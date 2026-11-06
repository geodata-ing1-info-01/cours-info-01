#!/usr/bin/env python3
"""Les traces GPS des TD des cours 3 à 5, version 2 (proposition 2027-2028).

Chaque trace suit un chemin réel, et simule une marche sur ce chemin :

    - le chemin vient du service d'itinéraire de la Géoplateforme de l'IGN, profil
      piéton (BD TOPO) ;
    - les altitudes viennent de son service d'altimétrie (RGE ALTI) ;
    - la vitesse, l'heure et le bruit de mesure sont simulés, avec une graine fixe.

Le script écrit `<nom>.gpx`, puis en tire `<nom>.csv` par la commande `ogr2ogr` du
cours 5. Les colonnes du CSV sont donc celles qu'écrit `ogr2ogr` : `X` et `Y`
(Lambert-93, en mètres), `ele` (altitude, en mètres) et `time` (heure UTC).

Les GPX et les CSV sont versionnés : le script ne sert qu'à les refaire. Il demande
le réseau, et GDAL 3.9 ou plus récent pour l'option `-xyRes` :

    python data/cours3_v2/traces/fabriquer_traces.py

`make_data.py` copie ensuite les CSV dans les dossiers des TD, et vérifie que les
listes d'altitudes des cours 1 et 2 viennent de `trace.csv`.
"""

from __future__ import annotations

import json
import math
import random
import subprocess
import urllib.parse
import urllib.request
from datetime import datetime, timedelta, timezone
from pathlib import Path

ICI = Path(__file__).resolve().parent
SERVICE = "https://data.geopf.fr"
ENTETES = {"User-Agent": "info01-cours/1.0"}

# Pour chaque trace : les points de passage (longitude, latitude), un point enregistré
# toutes les `pas` secondes, l'heure de départ et la graine du hasard.
TRACES = {
    "trace": {
        "nom": "Gorges de Franchard",
        "passages": [(2.5987, 48.4114), (2.6087, 48.4074), (2.6200, 48.4100)],
        "pas": 30,
        "depart": datetime(2026, 10, 4, 8, 0, 0, tzinfo=timezone.utc),
        "graine": 158,
    },
    "trace_2": {
        "nom": "Gare de Noisy-Champs, Geodata Paris",
        "passages": [(2.581781, 48.843240), (2.586968, 48.840579)],
        "pas": 10,
        "depart": datetime(2026, 9, 7, 7, 40, 0, tzinfo=timezone.utc),
        "graine": 2026,
    },
}


def lire_json(url: str) -> dict:
    requete = urllib.request.Request(url, headers=ENTETES)
    with urllib.request.urlopen(requete, timeout=60) as reponse:
        return json.load(reponse)


def chemin(passages: list[tuple[float, float]]) -> list[list[float]]:
    """Les sommets (longitude, latitude) du chemin piéton qui passe par ces points."""
    parametres = {
        "resource": "bdtopo-valhalla",
        "profile": "pedestrian",
        "optimization": "shortest",
        "start": "{},{}".format(*passages[0]),
        "end": "{},{}".format(*passages[-1]),
        "geometryFormat": "geojson",
        "getSteps": "false",
        "getBbox": "false",
    }
    if len(passages) > 2:
        parametres["intermediates"] = "|".join("{},{}".format(*p) for p in passages[1:-1])
    requete = urllib.parse.urlencode(parametres, safe=",|")
    return lire_json(f"{SERVICE}/navigation/itineraire?{requete}")["geometry"]["coordinates"]


def metres(a: list[float], b: list[float]) -> float:
    """La distance approchée entre deux points (longitude, latitude)."""
    dx = (b[0] - a[0]) * 111320 * math.cos(math.radians((a[1] + b[1]) / 2))
    dy = (b[1] - a[1]) * 110540
    return math.hypot(dx, dy)


def reechantillonner(sommets: list[list[float]], pas: float = 10) -> list[tuple[float, float, float]]:
    """Un point tous les `pas` mètres : longitude, latitude, distance depuis le départ."""
    points, parcouru, prochain = [], 0.0, 0.0
    for a, b in zip(sommets, sommets[1:]):
        longueur = metres(a, b)
        while longueur > 0 and prochain <= parcouru + longueur:
            t = (prochain - parcouru) / longueur
            points.append((a[0] + t * (b[0] - a[0]), a[1] + t * (b[1] - a[1]), prochain))
            prochain += pas
        parcouru += longueur
    return points


def altitudes(points: list[tuple[float, float, float]]) -> list[float]:
    """L'altitude du terrain en chaque point, par paquets de 150 points."""
    resultat = []
    for debut in range(0, len(points), 150):
        paquet = points[debut:debut + 150]
        lon = "|".join(f"{p[0]:.7f}" for p in paquet)
        lat = "|".join(f"{p[1]:.7f}" for p in paquet)
        resultat += lire_json(f"{SERVICE}/altimetrie/1.0/calcul/alti/rest/elevation.json?"
                              f"lon={lon}&lat={lat}&resource=ign_rge_alti_wld&zonly=true")["elevations"]
    return resultat


def marche(points, terrain, pas, depart, graine) -> list[tuple[float, float, float, datetime]]:
    """Les positions enregistrées : longitude, latitude, altitude, heure.

    La vitesse suit la fonction de marche de Tobler, ralentie en montée et en forte
    descente. Le bruit vaut 2 m à l'horizontale et 0,7 m en altitude (écarts types).
    """
    hasard = random.Random(graine)
    positions = []
    i, parcouru, ecoule = 0, 0.0, 0
    while True:
        while i + 1 < len(points) and points[i + 1][2] <= parcouru:
            i += 1
        if i + 1 >= len(points):
            return positions
        a, b = points[i], points[i + 1]
        t = (parcouru - a[2]) / (b[2] - a[2])
        lat = a[1] + t * (b[1] - a[1])
        pente = (terrain[i + 1] - terrain[i]) / (b[2] - a[2])
        positions.append((
            a[0] + t * (b[0] - a[0]) + hasard.gauss(0, 2.0) / (111320 * math.cos(math.radians(lat))),
            lat + hasard.gauss(0, 2.0) / 110540,
            round(terrain[i] + t * (terrain[i + 1] - terrain[i]) + hasard.gauss(0, 0.7), 1),
            depart + timedelta(seconds=ecoule),
        ))
        vitesse = 1.6 * math.exp(-3.5 * abs(pente + 0.05)) + hasard.gauss(0, 0.08)
        parcouru += max(0.6, vitesse) * pas
        ecoule += pas


def ecrire_gpx(nom: str, positions, cible: Path) -> None:
    lignes = ['<?xml version="1.0" encoding="UTF-8"?>',
              '<gpx version="1.1" creator="info01" xmlns="http://www.topografix.com/GPX/1/1">',
              f"<trk><name>{nom}</name><trkseg>"]
    for lon, lat, z, heure in positions:
        lignes.append(f'<trkpt lat="{lat:.7f}" lon="{lon:.7f}"><ele>{z}</ele>'
                      f'<time>{heure:%Y-%m-%dT%H:%M:%SZ}</time></trkpt>')
    lignes += ["</trkseg></trk>", "</gpx>"]
    cible.write_text("\n".join(lignes) + "\n", encoding="utf-8", newline="\n")


def convertir(gpx: Path, csv: Path) -> None:
    """Le CSV en Lambert-93, par la commande du cours 5."""
    subprocess.run(["ogr2ogr", "-f", "CSV", str(csv), str(gpx), "track_points",
                    "-t_srs", "EPSG:2154", "-lco", "GEOMETRY=AS_XY",
                    "-select", "ele,time", "-xyRes", "0.1"], check=True)


def main() -> None:
    for nom, trace in TRACES.items():
        points = reechantillonner(chemin(trace["passages"]))
        positions = marche(points, altitudes(points), trace["pas"], trace["depart"], trace["graine"])
        ecrire_gpx(trace["nom"], positions, ICI / f"{nom}.gpx")
        convertir(ICI / f"{nom}.gpx", ICI / f"{nom}.csv")
        print(f"{nom} : {trace['nom']}, {len(positions)} points")


if __name__ == "__main__":
    main()
