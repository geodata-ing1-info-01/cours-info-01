# Lire et écrire des fichiers texte — TD 3c, cours 3

Un notebook, exécuté pendant l'exposé, une section à la fois. Les cellules
qui ne contiennent qu'un commentaire sont à compléter avec ce que la
diapositive montre.

| Fichier | Ce qu'il contient |
|---|---|
| `depart/notebook/fichiers.ipynb` | comment le code de la recette ouvre, lit et écrit ses fichiers : `open`, `with`, les modes, `csv`, `read_text` |
| `depart/recettes/` | les quatre recettes du TD 3b, une par dossier : `recette.md` et `ingredients.csv` |
| `depart/style.css` | la feuille de style des pages produites au TD 3b |
| `travail/` | vide : la copie du notebook, et ce qu'il écrit |

Copier `depart/notebook/fichiers.ipynb` dans `travail/`, puis l'ouvrir dans
JupyterLab. `depart/` ne se modifie pas ; le notebook y lit les recettes par
le chemin `../depart/`, qui suppose qu'il est dans `travail/`.
