"""Fabrique le fond de carte du TD 5 du cours 1, « une vidéo, deux chemins ».

Assemble des tuiles OpenStreetMap en une image unique, y appose la mention
d'attribution exigée par la licence, et convertit des coordonnées
longitude/latitude en pixels de cette image.

    python carte.py                     # fabrique carte.png et carte.json
    python carte.py trajet.geojson      # + convertit un tracé uMap en etapes.csv

Le fichier `carte.json` retient la projection utilisée : c'est lui qui permet
de repasser plus tard des coordonnées géographiques aux pixels de l'image.

Politique d'usage des tuiles : le serveur d'OpenStreetMap est un service
bénévole, qui interdit les téléchargements en masse. Ce script est fait pour
être lancé **une fois par l'enseignant**, qui distribue ensuite `carte.png`
aux étudiants ; les tuiles sont mises en cache dans `fourni/`.
"""
import csv
import json
import math
import subprocess
import sys
import urllib.request
from pathlib import Path

# Cité Descartes : de la gare de Noisy-Champs à l'école.
BBOX = (2.5795, 48.8398, 2.5895, 48.8445)   # ouest, sud, est, nord
ZOOM = 17
AGENT = "info01-support-pedagogique/1.0"
ATTRIBUTION = "© les contributeurs d'OpenStreetMap"
ICI = Path(__file__).parent
# Le fond de carte est une donnée du projet des étudiants, et il se refabrique :
# il naît donc dans `produit/`, sous le chemin qu'il aura dans l'archive livrée.
PRODUIT = ICI / "produit" / "depart" / "trajet" / "data"


def deg_vers_tuile(lon, lat, zoom):
    """Coordonnées de tuile (fractionnaires) dans la projection Web Mercator."""
    n = 2 ** zoom
    x = (lon + 180.0) / 360.0 * n
    y = (1 - math.asinh(math.tan(math.radians(lat))) / math.pi) / 2 * n
    return x, y


def fabrique_carte(bbox=BBOX, zoom=ZOOM, sortie=PRODUIT / "carte.png"):
    lon_o, lat_s, lon_e, lat_n = bbox
    x0, y0 = deg_vers_tuile(lon_o, lat_n, zoom)     # coin haut-gauche
    x1, y1 = deg_vers_tuile(lon_e, lat_s, zoom)     # coin bas-droit
    tx0, ty0, tx1, ty1 = int(x0), int(y0), int(x1), int(y1)

    cache = ICI / "fourni"
    cache.mkdir(exist_ok=True)
    sortie.parent.mkdir(parents=True, exist_ok=True)
    tuiles = []
    for ty in range(ty0, ty1 + 1):
        for tx in range(tx0, tx1 + 1):
            fichier = cache / f"{zoom}_{tx}_{ty}.png"
            if not fichier.exists():
                url = f"https://tile.openstreetmap.org/{zoom}/{tx}/{ty}.png"
                requete = urllib.request.Request(url, headers={"User-Agent": AGENT})
                fichier.write_bytes(urllib.request.urlopen(requete, timeout=30).read())
            tuiles.append(str(fichier))

    colonnes, lignes = tx1 - tx0 + 1, ty1 - ty0 + 1
    mosaique = ICI / "mosaique.png"
    subprocess.run(["magick", "montage", *tuiles, "-tile", f"{colonnes}x{lignes}",
                    "-geometry", "+0+0", str(mosaique)], check=True)

    # Recadrage sur la bbox demandée, puis mention d'attribution.
    gauche, haut = (x0 - tx0) * 256, (y0 - ty0) * 256
    largeur = round((x1 - tx0) * 256 - gauche)
    hauteur = round((y1 - ty0) * 256 - haut)
    subprocess.run([
        "magick", str(mosaique),
        "-crop", f"{largeur}x{hauteur}+{round(gauche)}+{round(haut)}", "+repage",
        "-gravity", "SouthEast", "-background", "#ffffffcc", "-fill", "#333333",
        "-pointsize", "13", "-splice", "0x18", "-annotate", "+4+2", ATTRIBUTION,
        str(sortie),
    ], check=True)
    mosaique.unlink()

    reference = {"bbox": list(bbox), "zoom": zoom, "origine": [x0, y0],
                 "taille": [largeur, hauteur]}
    (PRODUIT / "carte.json").write_text(json.dumps(reference, indent=2))
    print(f"{sortie.name} : {largeur}×{hauteur} pixels")
    return reference


def vers_pixels(lon, lat, reference):
    x, y = deg_vers_tuile(lon, lat, reference["zoom"])
    ox, oy = reference["origine"]
    return round((x - ox) * 256), round((y - oy) * 256)


def geojson_vers_etapes(chemin_geojson, reference,
                        sortie=ICI / "depart" / "trajet" / "data" / "etapes.csv"):
    """Convertit le tracé exporté depuis uMap en fichier d'étapes.

    C'est le pont entre les deux chemins du TD : le trajet dessiné
    à la souris devient le fichier que la commande consomme.
    """
    donnees = json.loads(Path(chemin_geojson).read_text())
    points = []
    for element in donnees["features"]:
        geometrie = element["geometry"]
        if geometrie["type"] == "LineString":
            points.extend(geometrie["coordinates"])
    if not points:
        sys.exit("aucune ligne trouvée dans le GeoJSON")

    with open(sortie, "w", newline="", encoding="utf-8") as f:
        ecrivain = csv.writer(f)
        ecrivain.writerow(["numero", "duree", "x", "y", "texte"])
        for i, (lon, lat) in enumerate(points):
            x, y = vers_pixels(lon, lat, reference)
            ecrivain.writerow([i, 0 if i == 0 else 4, x, y,
                               "" if i == 0 else f"{i}. à compléter"])
    print(f"{sortie.name} : {len(points)} points, textes à écrire")


if __name__ == "__main__":
    reference = fabrique_carte()
    if len(sys.argv) > 1:
        geojson_vers_etapes(sys.argv[1], reference)
