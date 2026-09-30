# Le notebook, ouvert de trois façons — TD 1g, cours 1

Un notebook, `altitudes.ipynb`, à ouvrir de trois façons : dans le navigateur,
depuis Anaconda Navigator, et dans l'éditeur. Aucune ne demande de créer un
environnement, parce que les postes de la salle ont la distribution Anaconda,
qui pose JupyterLab et `ipykernel` dans `base`. Une installation Miniforge part
d'un `base` minimal et n'a ni l'un ni l'autre : c'est le premier constat du
TD 1i.

C'est le programme du TD 1c découpé en cellules. Ce qu'il ajoute est ce que le
noyau retient d'une cellule à l'autre : relancer la boucle sans relancer les
données ajoute une seconde fois les trois altitudes.

Le notebook est dérivé d'une source MyST Markdown,
[`src/cours1/notebook/td/1g_notebooks/`](../../../src/cours1/notebook/td/1g_notebooks/),
et déposé ici par :

```bash
python outils/construire_notebooks.py            # convertit en .ipynb, dans produit/
python outils/construire_notebooks.py --executer # et remplit les sorties
```

Le `.ipynb` est un fichier dérivé, comme un PDF l'est d'un `.typ` : il va dans
`produit/`, et `outils/livrer_tds.py` le met à plat dans le dossier livré.

## L'extension de l'éditeur

Ouvrir un `.ipynb` dans VSCode demande l'extension `ms-toolsai.jupyter`, la
troisième et dernière du module. L'éditeur la propose de lui-même à la première
ouverture ; sans elle, le notebook s'affiche comme un fichier texte illisible.

VSCode demande aussi `ipykernel` dans l'environnement choisi. Le `base`
d'Anaconda le porte, donc il n'y a rien de plus à installer ici. Sur un
environnement qui ne l'a pas, l'éditeur propose de l'ajouter : c'est le premier
constat du TD 1i.

Ce que l'éditeur appelle « noyau » est l'interpréteur qui exécute les cellules.
Prendre celui d'Anaconda et passer : qu'il y ait un choix à faire est le sujet
du TD 1i.

## Le second notebook

`recette.ipynb`, qui reprend le programme du TD 1h une fonction par cellule,
est livré avec le TD 1i : il lit les données du projet recette, que ce TD-là
fait installer.

## Dans le navigateur

JupyterLite exécute Python par Pyodide, et n'est pas limité à la bibliothèque
standard : une cellule `%pip install` y pose une bibliothèque pure Python. Ce
qui n'y fonctionne pas est tout ce qui demande un processus au système —
`subprocess`, donc ni ffmpeg ni ImageMagick. Le notebook de ce TD n'en a pas
besoin.
