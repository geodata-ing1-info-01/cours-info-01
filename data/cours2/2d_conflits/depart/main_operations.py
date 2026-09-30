"""Seconde version de la boucle de saisie — question 23 du TD 2d.

Celle-ci découpe la chaîne sans expression régulière et vérifie que les deux
morceaux sont bien des nombres. Elle est destinée à la branche
`main_code_bis` : c'est elle qui entrera en conflit avec `main_regex.py`.
"""

import operations as op

if __name__ == "__main__":
    print("Geo Calculatrice")
    print("*" * 10)
    print("Tapez une opération :")
    operation = input()
    if "+" in operation:
        [x, y] = operation.split("+")
        if x.isnumeric() and y.isnumeric():
            x, y = float(x), float(y)
            print(op.add(x, y))
    elif "-" in operation:
        [x, y] = operation.split("-")
        if x.isnumeric() and y.isnumeric():
            x, y = float(x), float(y)
            print(op.add(x, op.neg(y)))
    elif "*" in operation:
        [x, y] = operation.split("*")
        if x.isnumeric() and y.isnumeric():
            x, y = float(x), float(y)
            print(op.mult(x, y))
    elif "/" in operation:
        [x, y] = operation.split("/")
        if x.isnumeric() and y.isnumeric():
            x, y = float(x), float(y)
            print(op.mult(x, op.inv(y)))
