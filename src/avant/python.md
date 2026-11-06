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

:::{note}
Cette page emploie des notions vues plus loin dans le cours : le terminal,
les commandes, les environnements. Taper les commandes telles qu'elles sont
écrites, et relire la page après la séance 4.
:::

## L'invite de commandes d'Anaconda

L'invite de commandes d'Anaconda, « Anaconda Prompt » dans le menu
Démarrer, est une fenêtre noire. On y tape une commande, on appuie sur
Entrée, et la réponse s'affiche en dessous. La ligne qui attend
une commande s'appelle l'invite. Sur les postes de la salle, elle commence
par `(base)`, le nom de l'environnement Python actif, celui d'Anaconda.

```{figure} anaconda_prompt.svg
:alt: La fenêtre de l'invite de commandes d'Anaconda, avec une commande tapée et sa réponse
:width: 100%

Une commande tapée dans l'invite de commandes d'Anaconda, et sa réponse.
```

1. Menu Démarrer, taper `anaconda prompt`, Entrée. Une fenêtre noire s'ouvre,
   et l'invite commence par `(base)`. Si le menu ne propose pas « Anaconda
   Prompt » : {ref}`A1 <dep-a1>`. Sans `(base)` : {ref}`A3 <dep-a3>`.
2. Taper `conda --version`, Entrée. La fenêtre affiche `conda 25.x` ou
   `conda 24.x`. Sinon : {ref}`A2 <dep-a2>`.
3. Taper `python -c "import sys; print(sys.executable)"`, Entrée. Le chemin
   affiché contient `anaconda3`. Sinon : {ref}`A3 <dep-a3>`.

Ce dernier chemin est celui du Python qui exécute les commandes. Il sert
de référence pour la suite : chaque fois qu'un outil affiche un chemin de
Python, ce doit être celui-là.

Dans la même fenêtre, vérifier que les conditions d'utilisation des
canaux d'Anaconda sont acceptées. conda les demande une fois par compte,
en posant une question dans le terminal. VS Code lance conda en
arrière-plan, sans terminal pour répondre : tant qu'elles ne sont pas
acceptées, ses recherches d'environnements échouent sur
`CondaToSNonInteractiveError` ({ref}`A10 <dep-a10>`).

1. Taper `conda tos`, Entrée. La fenêtre affiche un tableau des canaux, avec
   pour chacun s'il est accepté. Si elle affiche `invalid choice: 'tos'`, cette
   installation de conda ne gère pas ces conditions, et il n'y a rien à faire.
2. Si `pkgs/main` ou `pkgs/r` n'est pas accepté, taper :

   ```
   conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main --channel https://repo.anaconda.com/pkgs/r
   ```

## Anaconda Navigator

1. Menu Démarrer, taper `anaconda navigator`, Entrée, puis attendre. Une
   fenêtre « Loading applications… » s'ouvre, puis la page d'accueil, avec une
   fiche par application (JupyterLab, Spyder, VS Code…). Si rien ne s'affiche
   après deux minutes : {ref}`A4 <dep-a4>`. Avec le message `… already running` :
   {ref}`A5 <dep-a5>`.
2. En haut de la page d'accueil, lire la liste déroulante des environnements.
   Elle affiche `base (root)`. Sinon : {ref}`A11 <dep-a11>`.

:::{note}
Si Navigator propose une mise à jour, répondre No ({ref}`A6 <dep-a6>`).
:::

## JupyterLab

1. Dans Navigator, fiche JupyterLab, cliquer sur Launch. Une fenêtre noire
   s'ouvre, puis un onglet de Firefox à une adresse qui commence par
   `localhost:8888/lab`. Sinon : {ref}`J5 <dep-j5>`.
2. Dans l'onglet, sous « Notebook », cliquer sur « Python 3 ». Un notebook vide
   s'ouvre, avec une cellule. Sinon : {ref}`J1 <dep-j1>`.
3. Dans la cellule, taper `import sys; print(sys.executable)`, puis `Maj` +
   `Entrée`. Le même chemin que dans l'invite de commandes d'Anaconda s'affiche.
   Sinon : {ref}`J4 <dep-j4>`.
4. Menu File, Shut Down, puis fermer l'onglet. La fenêtre noire se ferme.

Le détail de chaque outil est dans les annexes, pages
[Anaconda](../annexes/configuration/anaconda.md) et
[JupyterLab](../annexes/configuration/jupyterlab.md). Spyder, que d'autres cours
emploient, se teste depuis sa page, [Spyder](../annexes/configuration/spyder.md).
