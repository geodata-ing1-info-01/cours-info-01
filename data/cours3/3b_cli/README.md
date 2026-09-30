# Une ligne de commande pour la recette — TD 3b, cours 3

Le TD construit `recette.py` à partir des cellules du notebook du TD 1a : un
fichier, les trois valeurs lues par `argparse`, un README, puis, en bonus,
une fonction `main` ; un commit par étape. Deux étapes facultatives rangent le code dans
`src/` et les données dans `data/`, puis installent le programme comme une
commande avec `pyproject.toml`.

| Dossier | Ce qu'il contient |
|---|---|
| `depart/recettes/` | quatre recettes : `recette.md`, `ingredients.csv` |
| `depart/style.css` | la feuille de style des pages produites |
| `depart/modeles/` | `README.md` et `pyproject.toml` à compléter, étapes 3 et 6 |
| `depart/secours/recette.py` | le résultat attendu de l'étape 1, pour qui reste bloqué |
| `travail/` | vide : les données copiées, le code écrit, et le dépôt git |

Copier `depart/recettes/` et `depart/style.css` dans `travail/`, ouvrir
`travail/` dans l'éditeur, et suivre la feuille du TD. Le guide détaillé,
`guide_3b_cli.pdf` (aussi en `.html` et en notebook `guide.ipynb`), donne pour
chaque étape le dossier où se placer, le code à coller, les commandes et la
façon de vérifier le résultat.

## Les étapes

| | Ce qu'on fait | Commits |
|---|---|---|
| 0 | `git init`, `.gitignore` avec `sortie/` | |
| 1 | `recette.py` : les cellules du notebook, dans l'ordre ; `python recette.py` écrit `sortie/crepes.html` | 1 |
| 2 | branche `arguments` : `nom`, puis `--personnes`, puis `--unites` ; fusion dans `master` | 4 |
| 3 | `README.md` depuis le modèle : objectif, installation, exécution | 5 |
| 4 (bonus) | le programme dans `main()`, appelé sous `if __name__ == "__main__":` | 6 |
| 5 (facultatif) | `src/recette.py`, `data/recettes/` ; les chemins partent de `__file__` | 7 |
| 6 (facultatif) | `pyproject.toml`, `pip install -e .` : la commande `recette`, qui appelle `main` | 8 |

Le corrigé de chaque étape est dans `corriges/3b_cli/etape<n>/` du dépôt ; il
n'est pas dans ce dossier, et il est distribué après la séance.
