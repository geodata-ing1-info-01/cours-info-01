---
title: Le client et le noyau d'un notebook
subtitle: "Parcours standard : un notebook ouvert dans deux clients, et un environnement qui a le noyau sans le client"
---

Cette page est celle du parcours standard. Elle reprend la partie du cours 1
sur les notebooks et les environnements, sur le code de la recette du
cours 3 : ce qu'un notebook demande pour s'exécuter, où ces programmes
peuvent se trouver, et ce qu'un environnement doit contenir pour qu'un
notebook s'y exécute. Deux TD l'accompagnent : le TD 4a, sur le noyau, puis
le TD 4b, qui reprend le TD 3a du cours 3. Ils sont présentés en fin de page.

## Le client et le serveur d'un notebook

Un notebook est une application web : un client qui affiche le document, un
serveur qui exécute le code. Sur le poste, `jupyter lab` démarre le serveur,
puis le navigateur affiche le client, JupyterLab, à une adresse `localhost`.
Le serveur, `jupyter-server`, reçoit les cellules, et le noyau, `ipykernel`,
les exécute et retient leurs variables.

```{figure} ../../cours1/notebook/figures/4_client_serveur.svg
:alt: Votre machine, en deux moitiés : le client, jupyterlab dans le navigateur ou VS Code, qui affiche le document ; le serveur, jupyter-server et ipykernel, qui exécute le code.

Le client et le serveur d'un notebook, sur le même poste.
```

Changer de client ne change pas le noyau : JupyterLab et l'éditeur de code
ouvrent le même fichier et exécutent ses cellules dans le même noyau.
L'adresse `localhost:8888/lab?token=…` contient un jeton, un mot de passe à
usage unique : le cours 5 y revient.

## Les trois emplacements du serveur

Le serveur d'un notebook peut être sur un autre ordinateur, sur le poste, ou
dans le navigateur lui-même.

```{figure} ../../cours1/notebook/figures/4_trois_serveurs.svg
:alt: Trois cas : le serveur sur un ordinateur distant, le serveur sur le poste, le noyau dans le navigateur.

Les trois emplacements du serveur d'un notebook.
```

Dans le premier cas, Colab ou un serveur de calcul, le code et les données
sortent du poste ; Colab demande un compte. Le deuxième cas est celui des
séances : `jupyter lab` sur le poste. Dans le troisième, JupyterLite
(jupyter.org/try-jupyter), le noyau Python est exécuté par le navigateur ;
tous les paquets n'y sont pas.

## Les clients d'un notebook

Le même fichier s'ouvre dans plusieurs clients. Tous ont besoin d'un noyau.

```{figure} ../../cours1/notebook/figures/4_deux_clients.svg
:alt: Dans le navigateur, jupyterlab passe par jupyter-server pour joindre ipykernel ; dans l'éditeur de code, VS Code démarre ipykernel lui-même, sans serveur.

JupyterLab dans le navigateur, et VS Code, qui démarre le noyau lui-même.
```

L'éditeur de code n'a pas besoin de `jupyterlab` : il démarre `ipykernel`
lui-même. Un environnement ouvert dans l'éditeur n'a donc besoin que
d'`ipykernel`.

## Ce que le noyau retient

Le noyau garde en mémoire les variables des cellules exécutées. Il les
retient dans l'ordre des exécutions, qui peut différer de l'ordre du
document : une cellule modifiée mais pas exécutée n'a pas d'effet, et le
numéro entre crochets, à gauche de chaque cellule, donne l'ordre des
exécutions. Un noyau redémarré ne connaît plus aucune variable. Avant de
rendre ou de partager un notebook, on le réexécute en entier, de haut en
bas.

`sys.executable` donne le chemin de l'interpréteur du noyau, et
`shutil.which("pandoc")` le programme pandoc que ce noyau trouve dans son
`PATH`.

## Un environnement pour le programme

`environment.yml` décrit l'environnement d'un programme : ses paquets, et le
canal d'où ils viennent. L'environnement du programme de la recette contient
Python, pandoc, que le programme lance, et `ipykernel`, le noyau. Il n'a pas
de client : `jupyterlab` n'y est pas.

```yaml
name: info01-recette

channels:
  - conda-forge

dependencies:
  - python=3.12
  - pandoc
  - ipykernel
```

```text
conda env create -f environment.yml
conda env list
```

La création télécharge les paquets, quelques minutes. Dans VS Code,
l'environnement se choisit comme noyau d'un notebook : en haut à droite,
« Select Kernel », puis « Python Environments » et `info01-recette`. Les
chemins de `sys.executable` et de pandoc sont alors dans
`envs\info01-recette`.

Dans ce même environnement, activé, `jupyter lab` répond `Jupyter command
jupyter-lab not found` : la commande `jupyter` existe, installée avec
`ipykernel`, mais le client JupyterLab n'est pas là. Pour ouvrir le notebook
dans le navigateur, on installe `jupyterlab` dans l'environnement, ou on le
lance depuis `base`.

## TD de la partie

- TD 4a, le client et le noyau d'un notebook, dans le dossier
  `cours4/4a_noyaux/` de l'archive, 30 minutes : `noyau.ipynb` ouvert dans
  JupyterLab puis dans VS Code, ce que le noyau retient, puis l'environnement
  `info01-recette` créé depuis `environment.yml` et choisi comme noyau.
- [TD 4b — Une ligne de commande pour la recette](td/4b_cli/guide.md), dans
  `cours4/4b_cli/`, 70 minutes : le TD 3a du cours 3, que le parcours
  standard fait ici ; le programme `recette.py`, `main`, `argparse`, un
  README, un commit par étape.

Les TD du parcours avancé sont dans [Travaux dirigés du projet
4](travaux_diriges.md).
