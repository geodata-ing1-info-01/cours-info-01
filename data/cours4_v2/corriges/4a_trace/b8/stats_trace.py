"""Statistiques d'une trace GPS."""

import argparse
import math
from datetime import datetime
from pathlib import Path

import numpy as np

FORMAT_TEMPS = "%Y/%m/%d %H:%M:%S+00"


def distance_entre(point1, point2):
    """La distance horizontale entre deux points (x, y, altitude), en mètres."""
    x1, y1, altitude1 = point1
    x2, y2, altitude2 = point2
    return math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)


def distance_parcourue(points):
    """La somme des longueurs des segments de la trace, en mètres."""
    total = 0
    for i in range(1, len(points)):
        segment = distance_entre(points[i - 1], points[i])
        total = total + segment
    return total


def distance_parcourue_numpy(liste_x, liste_y):
    """La même somme, calculée par numpy sur les colonnes x et y."""
    x = np.array(liste_x)
    y = np.array(liste_y)
    return np.sum(np.sqrt(np.diff(x) ** 2 + np.diff(y) ** 2))


def secondes_ecoulees(debut, fin):
    """Le temps en secondes entre deux valeurs de la colonne time."""
    date_debut = datetime.strptime(debut, FORMAT_TEMPS)
    date_fin = datetime.strptime(fin, FORMAT_TEMPS)
    return (date_fin - date_debut).total_seconds()


analyseur = argparse.ArgumentParser(description="Statistiques d'une trace GPS.")
analyseur.add_argument("fichier", help="le fichier CSV de la trace")
analyseur.add_argument("-s", "--seuil", type=float, default=0,
                       help="variation ignorée sous ce seuil, en mètres")
analyseur.add_argument("--distance", action="store_true",
                       help="affiche la distance parcourue")
analyseur.add_argument("--vitesse", action="store_true",
                       help="affiche la vitesse moyenne")
options = analyseur.parse_args()

FICHIER = Path(options.fichier)
SEUIL = options.seuil

altitudes = []
points = []
temps = []
liste_x = []
liste_y = []
with open(FICHIER, encoding="utf-8") as fichier:
    fichier.readline()
    for ligne in fichier:
        x, y, ele, time = ligne.strip().split(",")
        altitudes.append(float(ele))
        if options.distance or options.vitesse:
            points.append((float(x), float(y), float(ele)))
            temps.append(time)
            liste_x.append(float(x))
            liste_y.append(float(y))

print(f"altitude minimale : {min(altitudes):.1f} m")
print(f"altitude maximale : {max(altitudes):.1f} m")
print(f"max - min : {max(altitudes) - min(altitudes):.1f} m")

hausse = 0
baisse = 0
reference = altitudes[0]
for altitude in altitudes[1:]:
    ecart = altitude - reference
    if abs(ecart) >= SEUIL:
        if ecart > 0:
            hausse = hausse + ecart
        else:
            baisse = baisse - ecart
        reference = altitude

print(f"cumul en hausse : {hausse:.1f} m")
print(f"cumul en baisse : {baisse:.1f} m")

with open("resume.txt", "a", encoding="utf-8") as sortie:
    sortie.write(f"{FICHIER.name} : seuil {SEUIL}, hausse {hausse:.1f} m, baisse {baisse:.1f} m\n")

if options.distance:
    distance = distance_parcourue(points)
    print(f"distance parcourue : {distance:.1f} m")
    distance_numpy = distance_parcourue_numpy(liste_x, liste_y)
    print(f"distance parcourue, numpy : {distance_numpy:.1f} m")

if options.vitesse:
    temps_total = secondes_ecoulees(temps[0], temps[-1])
    distance = distance_parcourue(points)
    vitesse = distance / temps_total
    print(f"vitesse moyenne : {vitesse:.2f} m/s, soit {vitesse * 3.6:.1f} km/h")
