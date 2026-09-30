# Amélioration d'un code de génération de recette — TD 3b, cours 3

Un notebook, exécuté pendant l'exposé, une section à la fois. Les
cellules qui ne contiennent qu'un commentaire sont à compléter avec ce que la
diapositive montre.

| Fichier | Ce qu'il contient |
|---|---|
| `depart/notebook/recette.ipynb` | le code de génération de recette : chemins en dur, puis `pathlib`, puis pandoc |
| `depart/recettes/` | quatre recettes, une par dossier : `recette.md` et `ingredients.csv` |
| `depart/style.css` | la feuille de style des pages produites |
| `travail/` | vide : la copie du notebook, et ce qu'il écrit |

Copier `depart/notebook/recette.ipynb` dans `travail/`. Ouvrir JupyterLab
depuis Anaconda Navigator, ou, dans l'invite de commandes d'Anaconda, taper `jupyter lab` ;
puis naviguer jusqu'à `travail/` dans le panneau de gauche et double-cliquer
sur la copie. `depart/` ne se modifie pas ; le notebook y lit les
recettes par le chemin `../depart/`, qui suppose qu'il est dans `travail/`.
