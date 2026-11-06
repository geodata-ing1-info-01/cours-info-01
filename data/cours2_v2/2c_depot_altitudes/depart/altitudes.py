"""Moyenne d'une série d'altitudes, à la main plutôt qu'avec sum()."""

altitudes = [79.6, 103.2, 98.3]
total = 0
for altitude in altitudes:
    total = total + altitude
moyenne = total / len(altitudes)
print(f"moyenne : {moyenne:.1f} m")
