"""Moyenne d'une série d'altitudes, à la main plutôt qu'avec sum()."""

altitudes = [128.4, 131.0, 127.6]
total = 0
for altitude in altitudes:
    total = total + altitude
moyenne = total / len(altitudes)
print(f"moyenne : {moyenne:.1f} m")
