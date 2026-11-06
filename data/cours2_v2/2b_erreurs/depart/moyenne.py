"""Moyenne d'une série de mesures d'altitude, en mètres."""

altitudes = [79.6, 103.2, 98.3, 92.5]

total = 0
for altitude in altitudes
    total = total + altitude

print(total / len(altitudes))
