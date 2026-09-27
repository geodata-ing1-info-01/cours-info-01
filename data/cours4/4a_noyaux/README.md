# Le client et le noyau d'un notebook — TD 4a, projet 4, parcours standard

Le TD reprend les TD 3b et 4b du cours 1 sur le code de la recette du
cours 3 : le même notebook, `noyau.ipynb`, ouvert dans deux clients,
JupyterLab et VS Code, puis exécuté dans le noyau d'un environnement créé
pour le programme.

| Fichier | Rôle |
|---|---|
| `depart/environment.yml` | l'environnement `info01-recette` : Python, pandoc, `ipykernel` |
| `depart/notebook/noyau.ipynb` | le notebook, à copier dans `travail/` |
| `depart/recettes/`, `depart/style.css` | les recettes du cours 3, que la section 3 du notebook met en page |
| `travail/` | vide : la copie du notebook, et la page produite |

`make_data.py build` recopie les recettes du cours 3 dans `produit/depart/` ;
`outils/construire_notebooks.py` y pose le notebook.
