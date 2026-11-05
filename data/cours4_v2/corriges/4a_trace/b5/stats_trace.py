"""Statistiques d'une trace GPS."""

import argparse
import math
from pathlib import Path


def distance_entre(x1, y1, x2, y2):
    """La distance entre le point (x1, y1) et le point (x2, y2)."""
    return math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)


def distance_parcourue(liste_x, liste_y):
    """La somme des longueurs des segments de la trace, en mètres."""
    total = 0
    for i in range(1, len(liste_x)):
        segment = distance_entre(liste_x[i - 1], liste_y[i - 1], liste_x[i], liste_y[i])
        total = total + segment
    return total


analyseur = argparse.ArgumentParser(description="Statistiques d'une trace GPS.")
analyseur.add_argument("fichier", help="le fichier CSV de la trace")
analyseur.add_argument("-s", "--seuil", type=float, default=0,
                       help="variation ignorée sous ce seuil, en mètres")
analyseur.add_argument("--distance", action="store_true",
                       help="affiche la distance parcourue")
options = analyseur.parse_args()

FICHIER = Path(options.fichier)
SEUIL = options.seuil

altitudes = []
liste_x = []
liste_y = []
with open(FICHIER, encoding="utf-8") as fichier:
    fichier.readline()
    for ligne in fichier:
        duree, x, y, z = ligne.strip().split(",")
        altitudes.append(float(z))
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
    distance = distance_parcourue(liste_x, liste_y)
    print(f"distance parcourue : {distance:.1f} m")
