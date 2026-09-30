# Le client, le noyau, et où ils sont installés — TD 1i, cours 1, facultatif

Un notebook demande deux choses : un **client**, qui affiche la page, et un
**noyau**, qui exécute les cellules. Le TD 1g n'a rien eu à installer parce que
les postes de la salle ont Anaconda, dont l'environnement `base` porte les deux.
Ce TD montre ce qui se passe quand ce n'est pas le cas, et les deux façons d'y
remédier.

| Fichier | Ce qu'il contient |
|---|---|
| `recette.ipynb` | le programme du TD 1h, rien d'importé, et un chemin relatif à commenter en tête |

Le notebook `altitudes.ipynb` du TD 1g sert aux trois premières parties.

## Vérifier plutôt que supposer

```bash
conda list -n base jupyterlab ipykernel
```

La réponse dépend de l'installation, et c'est le propos du TD. **Anaconda
Distribution** pose plus de six cents paquets dans `base`, JupyterLab et
`ipykernel` compris. **Miniconda** et **Miniforge** n'y mettent que conda,
Python et leurs dépendances : un notebook n'y ouvre rien tant qu'on n'a pas
installé de quoi le faire.

L'environnement `recette`, fabriqué au TD 1h, n'a que Python, `markdown` et
`tabulate`. C'est le cas d'essai : `jupyter lab` y répond « commande
introuvable », et VSCode y propose d'installer `ipykernel`.

## Les deux façons d'installer

**Tout au même endroit** — le client dans l'environnement du projet :

```bash
conda install -n recette -c conda-forge jupyterlab   # ipykernel vient avec
conda activate recette
jupyter lab
```

Simple, et c'est la configuration du TD 1g refaite à la main. Le défaut est
qu'on installe un client par projet.

**Le client d'un côté, le noyau de l'autre** — un JupyterLab installé une
fois, et un environnement par projet qui se déclare auprès de lui :

```bash
conda create -n altitudes -c conda-forge python=3.12 ipykernel numpy
conda run -n altitudes python -m ipykernel install --user --name altitudes

conda activate recette
jupyter kernelspec list          # le noyau `altitudes` y apparaît
```

Le client ne devine pas les environnements : il lit un dossier de
déclarations, où `ipykernel install` a écrit un `kernel.json` qui n'est qu'un
chemin vers un interpréteur. VSCode lit la même liste, ce qui explique qu'il
demande de choisir un noyau.

**La règle qui sert toute l'année** : une bibliothèque manquante s'installe
dans l'environnement du *noyau*, jamais dans celui du client.

## Rendre la main

```bash
jupyter kernelspec remove altitudes
conda env remove -n altitudes
```
