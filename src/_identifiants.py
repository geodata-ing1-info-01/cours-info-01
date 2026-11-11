"""L'identifiant d'un titre dans le book, calculé comme pandoc le calcule.

Désigné par son nom dans `conf.py` (`myst_heading_slug_func`) : Sphinx ne
met pas en cache une fonction définie dans `conf.py` elle-même.
"""


def identifiant_titre(titre: str) -> str:
    """L'identifiant de pandoc (extension `auto_identifiers`).

    Pandoc met le titre en minuscules, n'en garde que les lettres, les
    chiffres, `_`, `-`, `.` et les espaces, relie les mots par un tiret, puis
    retire tout ce qui précède la première lettre. « Étape 0 · Préparer »
    donne `étape-0-préparer`, et « 1 · Ouvrir le dossier » donne
    `ouvrir-le-dossier`, comme dans les guides de TD convertis en PDF et en
    HTML par pandoc : les liens de leurs tableaux d'étapes fonctionnent dans
    les deux sorties. Un titre sans lettre donne `section`, comme chez pandoc.
    """
    gardes = "".join(c for c in titre.lower() if c.isalnum() or c in "_-. ")
    identifiant = "-".join(gardes.split())
    debut = next((i for i, c in enumerate(identifiant) if c.isalpha()), len(identifiant))
    return identifiant[debut:] or "section"
