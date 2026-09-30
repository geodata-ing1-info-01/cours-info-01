# Une recette en Markdown — TD 3a, cours 3, parcours standard

Le TD ajoute une recette, les gaufres, à un dépôt git de recettes, créé à
partir des quatre recettes du TD 1a. Le texte des gaufres est mis en forme
en Markdown, reprise du TD 3a du cours 1. Le notebook `pages.ipynb`, livré
dans le dossier des recettes, reprend le programme de `recette.ipynb`
(TD 1a) : il insère le tableau des ingrédients dans chaque recette et en
fait une page HTML.

| Fichier | Rôle |
|---|---|
| `depart/gaufres/recette_a_formater.txt` | le texte de départ, sans structure |
| `depart/gaufres/ingredients.csv` | les quantités pour une personne, lues par le programme |
| `depart/recette_attendue.md` | le résultat attendu |
| `travail/` | vide : le dossier `recettes/` copié, qui devient le dépôt git |

Ces fichiers sont versionnés et livrés tels quels. `make_data.py build`
ajoute dans `produit/depart/` le dossier `recettes/` (les quatre recettes de
`data/cours3/recettes/` et la feuille de style), la photo des gaufres et
`CREDITS.md` ; `outils/construire_notebooks.py` ajoute `pages.ipynb` dans
`recettes/`, depuis `src/cours3/notebook/td/3a_markdown/depart/recettes/pages.md`.
La photo vient de Wikimedia Commons (`make_data.py fetch`, dans `fourni/`) :
« Gaufre molle.jpg », Jre, domaine public.
