"""À documenter : c'est l'exercice du TD.

Écrivez ici, sur le modèle de `recette_a_la_main.py`, ce que ce programme
fait, comment on le lance, et ce qui le distingue de l'autre.
"""

from pathlib import Path

import markdown
from tabulate import tabulate

from recette.calculs import adapter, en_table, lire_ingredients
from recette.tableau import GABARIT

# ---- Les deux valeurs à changer -------------------------------------------
PERSONNES = 4
UNITES = "SI"      # "SI" ou "US"
# ---------------------------------------------------------------------------

PROJET = Path(__file__).resolve().parent
DONNEES = PROJET / "data"

ingredients = lire_ingredients(DONNEES / "ingredients.csv")
ingredients = adapter(ingredients, PERSONNES, UNITES)

lignes = en_table(ingredients)
tableau = tabulate(lignes, headers=["Ingrédient", "Quantité"], tablefmt="github")

source = (DONNEES / "recette.md").read_text(encoding="utf-8")
source = source.replace("## Ingrédients", "## Ingrédients\n\n" + tableau)

corps = markdown.markdown(source, extensions=["tables"])
page = GABARIT.format(titre="Crêpes", corps=corps)

sortie = PROJET / "recette.html"
sortie.write_text(page, encoding="utf-8")
print(f"{sortie.name} écrit pour {PERSONNES} personne(s), en unités {UNITES}")
