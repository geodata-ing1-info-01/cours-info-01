"""Les étapes du trajet : les lire, et dire ce qu'elles contiennent.

Le fichier `data/etapes.csv` donne une ligne par point du trajet. La première
est le point de départ, dont la durée vaut zéro : on n'y anime rien, elle sert
d'origine au premier segment.

    numero,duree,x,y,texte
    0,0,398,248,Sortie de la gare
    1,4,410,360,1. Descendre vers le Mail Descartes

`x` et `y` sont des pixels de `data/carte.png`, pas des coordonnées
géographiques : c'est `carte.py`, lancé une fois par l'enseignant, qui a fait
la conversion.
"""

import csv
from dataclasses import dataclass

__all__ = ["Etape", "lire_etapes"]


@dataclass
class Etape:
    """Un point du trajet, et ce qu'on affiche en l'atteignant."""

    numero: int
    duree: int      # secondes pendant lesquelles l'image reste à l'écran
    x: int          # pixels, depuis le bord gauche de la carte
    y: int          # pixels, depuis le bord haut
    texte: str


def lire_etapes(chemin):
    """Les étapes du fichier CSV, dans l'ordre du trajet."""
    etapes = []
    with open(chemin, encoding="utf-8") as fichier:
        for ligne in csv.DictReader(fichier):
            etapes.append(Etape(
                numero=int(ligne["numero"]),
                duree=int(ligne["duree"]),
                x=int(ligne["x"]),
                y=int(ligne["y"]),
                texte=ligne["texte"],
            ))
    return etapes
