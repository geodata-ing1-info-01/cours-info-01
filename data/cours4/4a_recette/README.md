# Un script Python, pas à pas — TD 4a, projet 4

Le TD crée le dossier du projet dans le terminal, l'ouvre dans VS Code et en
fait un dépôt git. Il écrit ensuite le programme `recette.py`, étape par
étape : les ingrédients d'une recette pour un nombre de personnes, en unités
SI ou américaines, lus dans un fichier CSV et écrits dans un autre. Un
commit par étape.

| Dossier | Ce qu'il contient |
|---|---|
| `depart/recette.py` | le programme de départ, avec deux erreurs de syntaxe à corriger à l'étape B1 |
| `depart/recettes/` | quatre recettes en CSV, pour 4 personnes ; `cookies.csv` est en unités américaines |
| `depart/modeles/README.md` | un modèle de README à adapter et compléter, étape B7 |
| `travail/` | vide : le dossier du projet y est créé à l'étape A1 |

Le guide détaillé, `guide_4a_recette.pdf` (aussi en `.html` et en notebook
`guide.ipynb`), donne pour chaque étape le dossier où se placer, le code, les
commandes et la façon de vérifier le résultat. Copier le code depuis la page
HTML : copié depuis le PDF, il perd ses indentations.

## Les étapes

| | Ce qu'on fait | Commits |
|---|---|---|
| A1 | `travail/recette/` créé par `mkdir`, les fichiers copiés par `cp` | |
| A2 | le projet ouvert dans VS Code, Git Bash comme terminal | |
| A3 | `git init`, `.gitignore` avec `sortie/`, premier commit | 1 |
| B1 | corriger les deux erreurs du programme de départ, un commit par erreur | 3 |
| B2 | la fonction `adapter` : la recette pour 6 personnes | 4 |
| B3 | la fonction `convertir` : unités SI ou américaines | 5 |
| B4 | la fonction `lire_ingredients` : la recette lue dans `recettes/` | 6 |
| B5 | la fonction `ecrire_ingredients` : le résultat écrit dans `sortie/` | 7 |
| B6 | `argparse` : `python recette.py cookies -p 8 -u SI` | 8 |
| B7 (bonus) | un README, l'étiquette `v1.0` | 9 |

Le parcours avancé continue avec le TD 4b, dans le même dossier
`travail/recette/`.
