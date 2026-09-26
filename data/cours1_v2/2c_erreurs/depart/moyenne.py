"""Moyenne d'une série de mesures d'altitude, en mètres."""

altitudes = [128.4, 131.0, 127.6, 133.2]

total = 0
for altitude in altitudes
    total = total + altitude

print(total / len(altitudes))
