# Un programme installable — TD 4b, projet 4, parcours avancé

Le TD suit le TD 4a, dans le même dossier, `4a_recette/travail/recette/`, à
partir du programme de l'étape B6. Il lui donne la forme d'un projet
Python : une fonction `main`, deux modules, un environnement décrit par un
fichier, une commande `recette` installée par `pip`. Un commit par étape.

| Dossier | Ce qu'il contient |
|---|---|
| `depart/modeles/environment.yml` | l'environnement `recette` : Python, pandoc, pip, setuptools ; étape C3 |
| `depart/modeles/pyproject.toml` | la fiche du projet, à compléter ; étape C4 |

Depuis `4a_recette/travail/recette/`, les modèles se copient par
`cp ../../../4b_paquet/depart/modeles/environment.yml .` (de même pour
`pyproject.toml`). Le guide détaillé, `guide_4b_paquet.pdf` (aussi en `.html`
et en notebook `guide.ipynb`), détaille chaque étape.

## Les étapes

| | Ce qu'on fait |
|---|---|
| C1 | le programme dans une fonction `main`, appelée sous `if __name__ == "__main__":` |
| C2 | `quantites.py` (les tables et les fonctions), importé par `recette.py` |
| C3 | `conda env create -f environment.yml`, `conda activate recette` |
| C4 | `src/`, `pyproject.toml`, `pip install -e .` : la commande `recette` |
| C5 (bonus) | l'option `--page` : la page HTML, par pandoc |
