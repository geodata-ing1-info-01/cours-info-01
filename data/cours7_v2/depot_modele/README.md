# Statistiques d'une trace GPS

`stats_trace.py` lit une trace GPS dans un fichier CSV, puis affiche ses altitudes
extrêmes, son dénivelé cumulé et, sur option, la distance parcourue et la vitesse
moyenne. Programme écrit au TD 4a du module d'introduction à l'informatique.

## Lancement

```text
python stats_trace.py trace.csv --distance --vitesse
```

| Option | Effet |
|---|---|
| `-s`, `--seuil` | variation d'altitude ignorée sous ce seuil, en mètres |
| `--distance` | affiche la distance parcourue |
| `--vitesse` | affiche la vitesse moyenne |

## Données

`trace.csv` et `trace_2.csv` : une position toutes les 30 secondes, colonnes `X` et
`Y` en Lambert-93, `ele` (altitude, en mètres) et `time` (heure UTC).
