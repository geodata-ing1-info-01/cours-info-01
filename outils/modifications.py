#!/usr/bin/env python3
"""Les lignes qui changent d'une version d'un fichier à la suivante, pour un guide de TD.

Une fois la première version du programme écrite, les guides ne donnent plus
le code entier à chaque étape, mais un bloc ```diff : les lignes à supprimer
(`-`), les lignes à ajouter (`+`) et deux lignes de contexte autour.

    -  36 def arguments_plan(decor):
    +     def arguments_plan(decor, decalage):
       37     return ["(", str(decor / "plan.png"),

Le numéro est celui de la ligne dans l'éditeur quand les modifications sont
faites de haut en bas : une ligne de contexte porte son numéro dans le
fichier modifié, une ligne à supprimer son numéro au moment où on la
supprime. Une ligne ajoutée n'a pas de numéro. `…` remplace les lignes qui
ne changent pas entre deux blocs.

Utilisé par `data/cours4/generer_guides.py` ; en ligne de commande, pour un
guide écrit à la main :

    python outils/modifications.py avant.py apres.py
"""

from __future__ import annotations

import argparse
import difflib
from pathlib import Path

LARGEUR = 3          # les chiffres du numéro de ligne


def modifications(avant: str, apres: str, contexte: int = 2) -> str:
    """Le bloc ```diff qui fait passer de `avant` à `apres`, numéros compris."""
    a = avant.splitlines()
    b = apres.splitlines()
    lignes = []
    for groupe in difflib.SequenceMatcher(None, a, b, autojunk=False).get_grouped_opcodes(contexte):
        if lignes:
            lignes.append("  " + "…".rjust(LARGEUR))
        for operation, i1, i2, j1, j2 in groupe:
            if operation == "equal":
                for k in range(i2 - i1):
                    lignes.append(f"  {j1 + k + 1:{LARGEUR}} {a[i1 + k]}")
                continue
            for k in range(i2 - i1):
                lignes.append(f"- {j1 + k + 1:{LARGEUR}} {a[i1 + k]}")
            for k in range(j2 - j1):
                lignes.append("+ " + " " * LARGEUR + " " + b[j1 + k])
    if not lignes:
        raise ValueError("les deux versions sont identiques")
    return "```diff\n" + "\n".join(ligne.rstrip() for ligne in lignes) + "\n```"


def main():
    analyseur = argparse.ArgumentParser(description="Les lignes qui changent d'un fichier à l'autre, en bloc ```diff numéroté.")
    analyseur.add_argument("avant", type=Path, help="la version avant la modification")
    analyseur.add_argument("apres", type=Path, help="la version après la modification")
    analyseur.add_argument("-c", "--contexte", type=int, default=2, help="lignes de contexte autour de chaque bloc (défaut : 2)")
    options = analyseur.parse_args()
    print(modifications(options.avant.read_text(encoding="utf-8"),
                        options.apres.read_text(encoding="utf-8"), options.contexte))


if __name__ == "__main__":
    main()
