"""La même recette, avec les valeurs données au lancement.

    python -m recette                       # 4 personnes, unités SI
    python -m recette --personnes 12        # pour douze
    python -m recette --unites US           # en onces et en cups
    python -m recette --help                # ce que la commande accepte

Après `pip install -e .`, la commande s'appelle `recette` : c'est ce que
déclare la section `[project.scripts]` de `pyproject.toml`.

Le corps du programme est celui de `recette_avec_tabulate.py`, à ceci près que
le nombre de convives et le système d'unités ne sont plus écrits dans le
fichier : `argparse` les lit sur la ligne de commande, refuse ce qui n'est pas
prévu, et répond tout seul à `--help`.
"""

import argparse
from pathlib import Path

import markdown
from tabulate import tabulate

from recette.calculs import adapter, en_table, lire_ingredients
from recette.tableau import GABARIT

# Le dossier du projet : deux crans au-dessus de `src/recette/`.
PROJET = Path(__file__).resolve().parents[2]
DONNEES = PROJET / "data"


def main(arguments=None) -> int:
    analyseur = argparse.ArgumentParser(
        prog="recette",
        description="Met une recette Markdown à l'échelle et en fait une page HTML.",
    )
    analyseur.add_argument(
        "-p", "--personnes", type=int, default=4,
        help="nombre de convives (défaut : 4)",
    )
    analyseur.add_argument(
        "-u", "--unites", choices=("SI", "US"), default="SI",
        help="système d'unités du tableau (défaut : SI)",
    )
    analyseur.add_argument(
        "-s", "--sortie", type=Path, default=PROJET / "recette.html",
        help="où écrire la page (défaut : recette.html, dans le projet)",
    )
    options = analyseur.parse_args(arguments)

    if options.personnes < 1:
        analyseur.error("le nombre de personnes doit valoir au moins 1")

    ingredients = lire_ingredients(DONNEES / "ingredients.csv")
    ingredients = adapter(ingredients, options.personnes, options.unites)

    lignes = en_table(ingredients)
    tableau = tabulate(lignes, headers=["Ingrédient", "Quantité"], tablefmt="github")

    source = (DONNEES / "recette.md").read_text(encoding="utf-8")
    source = source.replace("## Ingrédients", "## Ingrédients\n\n" + tableau)

    corps = markdown.markdown(source, extensions=["tables"])
    page = GABARIT.format(titre="Crêpes", corps=corps)
    options.sortie.write_text(page, encoding="utf-8")

    print(
        f"{options.sortie.name} : {options.personnes} personne(s), "
        f"unités {options.unites}, {options.sortie.stat().st_size} octets"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
