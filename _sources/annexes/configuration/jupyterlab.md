---
title: JupyterLab
subtitle: Tester JupyterLab, le lancer depuis un terminal, les fiches Notebook et JupyterLab
---

JupyterLab est un client de notebooks, livré avec Anaconda, qui s'affiche
dans le navigateur. Ce qu'est un notebook, son noyau et ses clients sont
expliqués dans [Les notebooks](../notions/notebooks.md).

## Tester JupyterLab

Le test, qui vérifie que Python exécute du code sur le poste sans rien
configurer, est dans [Anaconda et
JupyterLab](../../avant/python.md), après celui d'Anaconda.

## Lancer JupyterLab depuis un terminal

Navigator fait deux choses quand on clique Launch : il active
l'environnement affiché en haut de sa page, puis il lance `jupyter lab`.
Les deux mêmes commandes se tapent dans un terminal où conda est
disponible, l'invite de commandes d'Anaconda ou Git Bash configuré
([conda dans un terminal](anaconda.md)), et elles montrent ce que la fiche
cache.

`jupyter lab` n'est pas une commande de Windows : c'est un programme de
l'environnement actif, celui que l'invite affiche entre parenthèses.
Dans `base`, il est là. Dans un environnement créé au TD 1h, il n'y est
que si on l'y installe, et il entraîne `ipykernel` avec lui :

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
« sur ce poste, port 8888 » : le navigateur parle à un serveur qui tourne
sur la même machine. Le `token` dans l'adresse est un mot de passe à usage
unique, qui empêche un autre poste du réseau d'exécuter du code ici.
Firefox s'ouvre sur cette adresse ; sinon, la copier dans Firefox
({ref}`J5 <dep-j5>`).

La fenêtre reste occupée tant que JupyterLab tourne. Fermer l'onglet du
navigateur n'arrête pas le serveur : c'est `Ctrl` + `C` dans la fenêtre,
deux fois, qui l'arrête, ou le menu File, Shut Down dans JupyterLab. Un
serveur oublié occupe le port 8888, et le suivant s'ouvre sur 8889.

## Les fiches Notebook et JupyterLab

Navigator propose deux fiches, « Notebook » et « JupyterLab ». Ce sont
deux clients web du même projet Jupyter : Notebook est le plus ancien, une
page par notebook ; JupyterLab est le plus complet, avec un explorateur
de fichiers, plusieurs onglets et un terminal. Depuis 2023, Notebook est
construit sur les mêmes composants que JupyterLab. Les deux ouvrent les
mêmes fichiers `.ipynb` et lancent le même serveur ; aucun ne remplace
l'autre, et le choix ne change rien au fichier.

VS Code est un troisième client, qui ouvre les notebooks sans serveur
([Les notebooks](../notions/notebooks.md)).

## Documentation officielle

- [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/) (en anglais),
  section « Getting Started ».
