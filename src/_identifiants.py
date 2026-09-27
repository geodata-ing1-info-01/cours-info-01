"""L'identifiant d'un titre dans le book, calculé comme pandoc le calcule.

Désigné par son nom dans `conf.py` (`myst_heading_slug_func`) : Sphinx ne
met pas en cache une fonction définie dans `conf.py` elle-même.
"""

import re


def identifiant_titre(titre: str) -> str:
    """Minuscules, ponctuation retirée, espaces remplacés par des tirets, tirets consécutifs réduits à un seul.

    « Étape 0 · Préparer » donne `étape-0-préparer`, comme dans les guides de
    TD convertis en PDF et en HTML par pandoc : les liens de leurs tableaux
    d'étapes fonctionnent dans les deux sorties.
    """
    identifiant = re.sub(r"[^\w\-. ]", "", titre.strip().lower()).replace(" ", "-")
    return re.sub(r"-{2,}", "-", identifiant)
