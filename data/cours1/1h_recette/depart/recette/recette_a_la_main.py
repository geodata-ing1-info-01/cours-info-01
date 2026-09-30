"""La recette pour quatre personnes, sans autre bibliothèque que `markdown`.

    python recette_a_la_main.py

Le programme se lit de haut en bas : lire les ingrédients, les adapter au
nombre de convives et au système d'unités, en faire un tableau Markdown,
l'insérer dans la recette, convertir le tout en HTML, écrire la page.

Pour un autre nombre de convives ou un autre système d'unités, changez les
deux valeurs ci-dessous et relancez.

Le `tabulate` importé ici est celui du projet, écrit à la main dans
`src/recette/tableau.py`. `recette_avec_tabulate.py` est le même programme,
avec celui de la bibliothèque : les deux fichiers ne diffèrent que par cette
ligne d'import.
"""

from pathlib import Path

import markdown

from recette.calculs import adapter, en_table, lire_ingredients
from recette.tableau import GABARIT, tabulate

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
