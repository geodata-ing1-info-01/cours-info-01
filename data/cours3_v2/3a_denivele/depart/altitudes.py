"""Altitudes extrêmes et dénivelé cumulé d'une série de mesures."""

altitudes = [79.6, 103.2, 98.3, 92.5, 123.7]
print(f"altitude minimale : {min(altitudes):.1f} m")
print(f"altitude maximale : {max(altitudes):.1f} m")
print(f"max - min : {max(altitudes) - min(altitudes):.1f} m")

hausse = 0
baisse = 0
for i in range(1, len(altitudes)):
    ecart = altitudes[i] - altitudes[i - 1]
    if ecart > 0:
        hausse = hausse + ecart
    else:
        baisse = baisse - ecart
print(f"cumul en hausse : {hausse:.1f} m")
print(f"cumul en baisse : {baisse:.1f} m")
