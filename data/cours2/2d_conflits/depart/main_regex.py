"""Première version de la boucle de saisie — question 21 du TD 2d.

Celle-ci lit l'opération avec une expression régulière. Elle est destinée à la
branche `main_code`, et entrera en conflit avec `main_operations.py`, écrite
sur `main_code_bis` : les deux modifient les mêmes lignes de `src/main.py`.

Le motif est écrit en chaîne brute (`r"..."`) : sans le `r`, Python lit `\d`
comme une séquence d'échappement inconnue et le signale.
"""

import re

from operations import *

if __name__ == "__main__":
    print("Geo Calculatrice")
    print("*" * 10)
    print("Tapez une opération :")
    s = input()
    search_result = re.search(r"\d+[\+\-\*\/]\d+", s)
    if search_result:
        operation = search_result[0]
        if "+" in operation:
            [x, y] = operation.split("+")
            x, y = float(x), float(y)
            result = add(x, y)
            print(result)
        elif "-" in operation:
            [x, y] = operation.split("-")
            x, y = float(x), float(y)
            result = add(x, neg(y))
            print(result)
        elif "*" in operation:
            [x, y] = operation.split("*")
            x, y = float(x), float(y)
            result = mult(x, y)
            print(result)
        elif "/" in operation:
            [x, y] = operation.split("/")
            x, y = float(x), float(y)
            result = mult(x, inv(y))
            print(result)
