# Un script Python, pas à pas — TD 4a, projet 4

Le TD crée le dossier du projet dans le terminal, l'ouvre dans VS Code et en
fait un dépôt git. Il ajoute ensuite au programme `stats_trace.py`, étape par
étape, le calcul de la distance parcourue et de la vitesse moyenne d'une trace
GPS. Un test et un commit par étape.

| Dossier | Contenu |
|---|---|
| `depart/stats_trace.py` | le programme de départ, avec deux erreurs de syntaxe à corriger à l'étape B1 |
| `depart/trace.csv`, `depart/trace_2.csv` | deux traces GPS, de 60 et 50 positions |
| `depart/modeles/README.md` | un modèle de README à adapter et compléter, étape B7 |
| `travail/` | vide : le dossier du projet y est créé à l'étape A1 |

Le guide, `guide_4a_trace.pdf` (aussi en `.html` et en notebook `guide.ipynb`), a
trois parties : la présentation du TD, l'énoncé de chaque étape, puis les
solutions. Copier le code depuis la page HTML : copié depuis le PDF, il perd ses
indentations.

## Les étapes

| | Objectif | Commits |
|---|---|---|
| A1 | `travail/stats_trace/` créé par `mkdir`, les fichiers copiés par `cp` | |
| A2 | le projet ouvert dans VS Code, avec un terminal Git Bash | |
| A3 | `git init`, `.gitignore` avec `resume.txt`, premier commit | 1 |
| B1 | corriger les deux erreurs du programme de départ, un commit par erreur | 3 |
| B2 | l'option `--distance`, qui affiche un message à la place du calcul | 4 |
| B3 | les positions de la trace, lues dans deux listes | 5 |
| B4 | la fonction `distance_entre` | 6 |
| B5 | la fonction `distance_parcourue` : le résultat final | 7 |
| B6 | l'option `--vitesse` et la fonction `secondes_ecoulees` | 8 |
| B7 (facultative) | un README, l'étiquette `v1.0` | 9 |
| B8 (facultative) | la distance calculée avec numpy | 10 |
