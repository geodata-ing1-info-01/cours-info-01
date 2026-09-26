# Une recette en Markdown — TD 3b, cours 3, parcours standard

Le TD reprend la mise en forme en Markdown du TD 3a du cours 1, sur une
nouvelle recette, les gaufres. Le fichier écrit par l'élève est lu par le
programme de `recette.ipynb` (TD 1a), qui y insère le tableau des
ingrédients et en fait une page HTML. Le dossier de la recette devient un
dépôt git.

| Fichier | Rôle |
|---|---|
| `depart/gaufres/recette_a_formater.txt` | le texte de départ, sans structure |
| `depart/gaufres/ingredients.csv` | les quantités pour une personne, lues par le programme |
| `depart/recette_attendue.md` | le résultat attendu |
| `travail/` | vide : le dossier `gaufres/` copié, puis le dépôt git |

Ces fichiers sont versionnés et livrés tels quels. `make_data.py build`
ajoute dans `produit/depart/` la photo et la feuille de style de la page,
dans `gaufres/`, et `CREDITS.md`. La photo vient de Wikimedia Commons
(`make_data.py fetch`, dans `fourni/`) : « Gaufre molle.jpg », Jre, domaine
public.
