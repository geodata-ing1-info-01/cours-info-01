---
title: Anaconda et JupyterLab
subtitle: Tester l'invite de commandes d'Anaconda, Navigator et JupyterLab
---

Ces tests et ces réglages sont faits et expliqués pendant la séance 1. Ils
sont réunis ici pour les séances suivantes : sur un poste qui n'a pas
encore servi, on les refait dans l'ordre de la page, sans chercher dans
les annexes. La session réseau doit être ouverte avant ([Premiers tests du
poste](poste.md)).

:::{warning}
Le premier lancement de l'année de chacun de ces outils peut être long :
ils créent leurs fichiers de configuration, et certains cherchent des
mises à jour. Cliquer une seule fois, puis attendre, jusqu'à deux minutes.
Les lancements suivants sont plus rapides.
:::

:::{warning}
Cette configuration emploie des notions qui ne sont vues que plus loin
dans le cours : le terminal, les commandes qu'on y tape, les
environnements. Pour l'instant, taper les commandes telles qu'elles sont
écrites, sans chercher à tout comprendre. Relire la page après la
séance 4, une fois la ligne de commande et les interpréteurs pratiqués.
:::

## L'invite de commandes d'Anaconda

L'invite de commandes d'Anaconda, « Anaconda Prompt » dans le menu
Démarrer, est une fenêtre noire. On y tape une commande, on appuie sur
Entrée, et la réponse s'affiche en dessous. La ligne qui attend
une commande s'appelle l'invite. Sur les postes de la salle, elle commence
par `(base)` : c'est le nom de l'environnement Python actif, celui
d'Anaconda.

```{figure} anaconda_prompt.svg
:alt: La fenêtre de l'invite de commandes d'Anaconda, avec une commande tapée et sa réponse
:width: 100%

Une commande tapée dans l'invite de commandes d'Anaconda, et sa réponse.
```

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Menu Démarrer, taper `anaconda prompt`, Entrée | une fenêtre noire ; l'invite commence par `(base)` | {ref}`A1 <dep-a1>`, {ref}`A3 <dep-a3>` |
| Taper `conda --version` puis Entrée | `conda 25.x` ou `conda 24.x` | {ref}`A2 <dep-a2>` |
| Taper `python -c "import sys; print(sys.executable)"` puis Entrée | un chemin qui contient `anaconda3` | {ref}`A3 <dep-a3>` |

Ce dernier chemin est celui du Python qui exécute les commandes. Il sert
de référence pour la suite : chaque fois qu'un outil affiche un chemin de
Python, ce doit être celui-là.

Dans la même fenêtre, vérifier que les conditions d'utilisation des
canaux d'Anaconda sont acceptées. conda les demande une fois par compte,
en posant une question dans le terminal. VS Code lance conda en
arrière-plan, sans terminal pour répondre : tant qu'elles ne sont pas
acceptées, ses recherches d'environnements échouent sur
`CondaToSNonInteractiveError` ({ref}`A10 <dep-a10>`).

```
conda tos
```

La réponse est un tableau des canaux, avec pour chacun s'il est accepté.
Si `pkgs/main` ou `pkgs/r` ne l'est pas, taper :

```
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main --channel https://repo.anaconda.com/pkgs/r
```

Si `conda tos` répond `invalid choice: 'tos'`, cette installation de conda
ne connaît pas ces conditions, et il n'y a rien à faire.

## Anaconda Navigator

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Menu Démarrer, taper `anaconda navigator`, Entrée, puis attendre | une fenêtre « Loading applications… », puis la page d'accueil, avec une fiche par application (JupyterLab, Spyder, VS Code…) | {ref}`A4 <dep-a4>`, {ref}`A5 <dep-a5>` |
| En haut de la page d'accueil, la liste déroulante des environnements | `base (root)` | {ref}`A11 <dep-a11>` |

:::{note}
Si Navigator propose une mise à jour, répondre No ({ref}`A6 <dep-a6>`).
:::

## JupyterLab

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Dans Anaconda Navigator, fiche JupyterLab, bouton Launch | une fenêtre noire, puis un onglet de Firefox à une adresse qui commence par `localhost:8888/lab` | {ref}`J5 <dep-j5>` |
| Dans l'onglet, sous « Notebook », cliquer « Python 3 » | un notebook vide, avec une cellule | {ref}`J1 <dep-j1>` |
| Taper `import sys; print(sys.executable)` dans la cellule, puis `Maj` + `Entrée` | le chemin d'Anaconda, le même que dans l'invite de commandes d'Anaconda | {ref}`J4 <dep-j4>` |
| Menu File, Shut Down, puis fermer l'onglet | la fenêtre noire se ferme | |

Le détail de chaque outil est dans les annexes, pages
[Anaconda](../annexes/configuration/anaconda.md) et
[JupyterLab](../annexes/configuration/jupyterlab.md). Spyder, que d'autres cours
emploient, se teste depuis sa page, [Spyder](../annexes/configuration/spyder.md).
