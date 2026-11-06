---
title: VS Code
subtitle: Installer l'extension Python, choisir l'interpréteur, faire de Git Bash le terminal
---

:::{note}
Cette page ne concerne que la séance 2 et les suivantes. À la séance 1, le
premier programme s'écrit dans Notepad++ et se lance dans un terminal, sans
VS Code.
:::

Ces réglages sont faits et expliqués pendant la séance 2, au [TD
2a](../cours2_v2/notebook/td/2a_vscode/guide.md). Ils sont réunis ici pour les
séances suivantes : sur un poste qui n'a pas encore servi, on les refait dans
l'ordre de la page. La session réseau doit être ouverte avant ([Premiers tests
du poste](poste.md)), et Anaconda testé ([Anaconda et JupyterLab](python.md)).

:::{warning}
Le premier lancement de l'année de VS Code peut être long : il crée ses
fichiers de configuration, et cherche des mises à jour. Cliquer une seule
fois, puis attendre, jusqu'à deux minutes. Les lancements suivants sont
plus rapides.
:::

## Réglages à faire

VS Code n'est lié à aucun langage, et ne contient ni interpréteur ni
compilateur. Il faut le configurer pour chaque langage employé, et lui
désigner son terminal :

1. Installer l'extension Python, avec une connexion internet.
2. Choisir l'interpréteur : le `python.exe` d'Anaconda.
3. Faire de Git Bash le terminal de VS Code, à la place de PowerShell.
4. Y activer conda, pour que `python` lance le Python d'Anaconda.
5. Lancer un programme pour vérifier.

## Ouvrir VS Code sur le dossier de la séance

1. Menu Démarrer, taper `visual studio code`, Entrée.
2. Menu File, Open Folder, et choisir `Bureau\info01\cours2`, ou le dossier de
   la séance.
3. À la première ouverture d'un dossier, VS Code demande si on fait confiance
   à ses auteurs. Répondre « Yes, I trust the authors » ; sinon, l'extension
   Python ne se charge pas ({ref}`V4 <dep-v4>`).

## Installer l'extension Python

1. Ouvrir le panneau Extensions : `Ctrl` + `Maj` + `X`, ou le bouton à quatre
   carrés dans la barre de gauche.
2. Taper `python` dans la zone de recherche.
3. Choisir « Python », de Microsoft : le nom de l'éditeur est écrit sous celui
   de l'extension, avec une coche bleue.
4. Cliquer sur Install. Si l'installation ne se fait pas : {ref}`V3 <dep-v3>`.

```{figure} ../annexes/configuration/captures/vscode_extensions_python.png
:alt: Le panneau Extensions avec python dans la zone de recherche ; l'extension Python de Microsoft est en tête de liste, et son volet de détail est ouvert
:width: 100%

Le panneau Extensions après avoir tapé `python` ; ici l'extension est déjà
installée, d'où les boutons Disable et Uninstall à la place d'Install
(documentation VS Code, CC BY 3.0 US).
```

## Choisir l'interpréteur

1. Palette (`Ctrl` + `Maj` + `P`), « Python: Select Interpreter ».
2. Choisir la ligne `base`, de chemin `C:\ProgramData\anaconda3\python.exe`. Si
   elle n'est pas dans la liste : {ref}`V6 <dep-v6>`.

## Faire de Git Bash le terminal

1. Palette, « Terminal: Select Default Profile », puis « Git Bash ». S'il n'est
   pas proposé : {ref}`V12 <dep-v12>`.
2. Menu Terminal, New Terminal. L'invite doit commencer par `(base)`.
3. Sans `(base)`, taper dans ce terminal :

   ```text
   source /c/ProgramData/anaconda3/etc/profile.d/conda.sh
   conda init bash
   ```

   Fermer ensuite le terminal (icône de corbeille, en haut à droite du panneau),
   puis en ouvrir un nouveau.

Si un message d'erreur s'affiche :

- `source` affiche `No such file or directory` : {ref}`G5 <dep-g5>`.
- `conda init bash` écrit `needs sudo`, ou Windows demande des droits
  d'administrateur : {ref}`G6 <dep-g6>`.
- Chaque nouveau terminal affiche l'aide de `cygpath` : {ref}`G7 <dep-g7>`.

La flèche à droite du `+`, en haut à droite du panneau du terminal, liste les
terminaux ({ref}`Choisir le terminal à ouvrir <vscode-terminal-choisir>`).

## Vérifier

1. En bas à droite de la fenêtre, lire `3.x ('base')`. Sinon :
   {ref}`V6 <dep-v6>`.
2. Menu Terminal, New Terminal. L'invite commence par `(base)` et se termine par
   `$`. Sans `(base)` : {ref}`G4 <dep-g4>`. Si une erreur s'affiche :
   {ref}`V5 <dep-v5>`.
3. Dans ce terminal, taper `which python`. La commande affiche
   `/c/ProgramData/anaconda3/python`. Sinon : {ref}`V7 <dep-v7>`.
4. Ouvrir un fichier `.py`, puis cliquer sur le triangle en haut à droite. Le
   terminal affiche la commande, puis ce que le programme écrit. Sinon :
   {ref}`V8 <dep-v8>`.

Le détail de VS Code est dans l'annexe [VS
Code](../annexes/configuration/vscode.md), et les réglages complets, prêts à
recopier, dans [Fichiers de réglages](../annexes/configuration/vscode_reglages.md).
Les notebooks dans VS Code demandent en plus l'extension Jupyter
([Notebooks](../annexes/configuration/vscode_notebooks.md)).
