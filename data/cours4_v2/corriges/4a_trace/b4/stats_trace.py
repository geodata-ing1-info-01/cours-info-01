"""Statistiques d'une trace GPS."""

import argparse
import math
from pathlib import Path


def distance_entre(x1, y1, x2, y2):
    """La distance entre le point (x1, y1) et le point (x2, y2)."""
    return math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)


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
    print(f"essai, 5.0 attendu : {distance_entre(0, 0, 3, 4)}")
    premier_segment = distance_entre(liste_x[0], liste_y[0], liste_x[1], liste_y[1])
    print(f"premier segment : {premier_segment:.1f} m")
    print("distance : calcul manquant")
