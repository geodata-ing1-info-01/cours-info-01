---
title: JupyterLab hors Anaconda
subtitle: Lancer JupyterLab seul, dans un terminal, sans Anaconda Navigator
---

JupyterLab est un client de notebooks, livré avec Anaconda, qui s'affiche
dans le navigateur. Il se lance aussi seul, dans un terminal, sans passer
par Anaconda Navigator : le [TD 1d](../../cours1_v2/notebook/td/1d_notebook/guide.md)
le lance ainsi. Ce qu'est un notebook, son noyau et ses clients sont
expliqués dans [Les notebooks](../notions/notebooks.md). Le test de JupyterLab
est dans [Anaconda et JupyterLab](../../avant/python.md).

## Lancer JupyterLab depuis un terminal

Le bouton Launch de Navigator active l'environnement affiché en haut de sa
page, puis lance `jupyter lab`. Les mêmes commandes se tapent dans un terminal
où conda est disponible, l'invite de commandes d'Anaconda ou Git Bash configuré
([conda dans un terminal](anaconda.md)).

`jupyter lab` lance un programme de l'environnement actif, dont l'invite affiche
le nom entre parenthèses. Dans `base`, il est déjà installé. Dans un environnement
créé au TD 1h, il faut l'installer, ce qui ajoute aussi `ipykernel` :

```
conda install -n recette -c conda-forge jupyterlab
conda activate recette
jupyter lab
```

Pour ouvrir directement le dossier du TD, écrire son chemin après la
commande ; le plus simple est de taper `jupyter lab` suivi d'une espace,
puis de glisser le dossier depuis l'explorateur dans la fenêtre, ce qui
écrit son chemin :

```
(base) C:\Users\eleve>jupyter lab "C:\Users\eleve\Desktop\cours1\4_notebooks"
[I 2026-09-20 08:54:26.493 ServerApp] Serving notebooks from local directory: C:\Users\eleve\Desktop\cours1\4_notebooks
[I 2026-09-20 08:54:26.493 ServerApp] Jupyter Server 2.21.0 is running at:
[I 2026-09-20 08:54:26.493 ServerApp] http://localhost:8888/lab?token=ce65d1c3…
[I 2026-09-20 08:54:26.493 ServerApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
```

Ce qui s'affiche est le journal du serveur. `localhost:8888` veut dire
« sur ce poste, port 8888 » : le navigateur se connecte à un serveur qui tourne
sur la même machine. Le `token` dans l'adresse est un mot de passe à usage
unique, qui empêche un autre poste du réseau d'exécuter du code ici.
Firefox s'ouvre sur cette adresse ; sinon, la copier dans Firefox
({ref}`J5 <dep-j5>`).

La fenêtre reste occupée tant que JupyterLab tourne. Pour arrêter le serveur,
taper deux fois `Ctrl` + `C` dans la fenêtre, ou choisir le menu File, Shut Down
dans JupyterLab. Fermer l'onglet du navigateur ne l'arrête pas. Un serveur
oublié occupe le port 8888, et le suivant s'ouvre sur 8889.

## Les fichiers accessibles

JupyterLab montre le dossier d'où on le lance, et ce qu'il contient. Le panneau
de gauche ne remonte pas au-dessus de ce dossier, et n'a aucun bouton pour changer
de disque. La fenêtre noire affiche ce dossier, à la ligne `Serving notebooks from
local directory`.

Pour travailler dans un autre dossier ou sur le disque `D:`, arrêter JupyterLab,
se placer dans ce dossier, puis relancer ({ref}`J6 <dep-j6>`).

Cette limite ne vaut que pour le panneau de fichiers. Le code d'un notebook peut
lire un fichier ailleurs sur le poste : `open("D:/mon_dossier/fichier.csv")`.

## Documentation officielle

- [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/) (en anglais),
  section « Getting Started ».
