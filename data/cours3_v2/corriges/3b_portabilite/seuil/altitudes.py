"""Altitudes extrêmes et dénivelé cumulé d'une série de mesures."""

altitudes = []
with open("C:/Users/alice/cours3/trace.csv", encoding="utf-8") as fichier:
    fichier.readline()
    for ligne in fichier:
        x, y, ele, time = ligne.strip().split(",")
        altitudes.append(float(ele))

print(f"altitude minimale : {min(altitudes):.1f} m")
print(f"altitude maximale : {max(altitudes):.1f} m")
print(f"max - min : {max(altitudes) - min(altitudes):.1f} m")

SEUIL = 2.0
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
