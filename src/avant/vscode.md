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

## Ce qu'il faut configurer

VS Code n'est lié à aucun langage, et ne contient ni interpréteur ni
compilateur. Pour écrire et lancer du Python, il faut configurer quatre
choses :

| Quoi | Pourquoi |
|---|---|
| L'extension Python | Elle apporte l'exécution et la vérification du code. Elle se télécharge : il faut une connexion internet. |
| L'interpréteur | L'extension lance le Python qu'on lui désigne : celui d'Anaconda. |
| Le terminal | VS Code ouvre par défaut PowerShell, qui refuse le script d'activation de conda sur les postes de la salle. Le module emploie Git Bash. |
| conda dans Git Bash | Sans conda activé, `python` lance un autre Python que celui d'Anaconda, ou aucun. |

Ces réglages sont enregistrés dans le compte : ils sont à refaire sur un poste
où l'on ne s'est jamais connecté.

## Ouvrir VS Code sur le dossier de la séance

Menu Démarrer, taper `visual studio code`, Entrée. Puis menu File, Open Folder,
et choisir `Bureau\info01\cours2`, ou le dossier de la séance.

À la première ouverture d'un dossier, VS Code demande si on fait confiance
à ses auteurs. Répondre « Yes, I trust the authors » ; sinon, l'extension
Python ne se charge pas ({ref}`V4 <dep-v4>`).

## Installer l'extension Python

Panneau Extensions : bouton à quatre carrés dans la barre de gauche, ou
`Ctrl` + `Maj` + `X`. Taper `python` dans la zone de recherche, choisir
« Python », de Microsoft (le nom de l'éditeur est écrit sous celui de
l'extension, avec une coche bleue), et cliquer Install. Si l'installation ne se
fait pas : {ref}`V3 <dep-v3>`.

```{figure} ../annexes/configuration/captures/vscode_extensions_python.png
:alt: Le panneau Extensions avec python dans la zone de recherche ; l'extension Python de Microsoft est en tête de liste, et son volet de détail est ouvert
:width: 100%

Le panneau Extensions après avoir tapé `python` ; ici l'extension est déjà
installée, d'où les boutons Disable et Uninstall à la place d'Install
(documentation VS Code, CC BY 3.0 US).
```

## Choisir l'interpréteur

Palette (`Ctrl` + `Maj` + `P`), « Python: Select Interpreter », puis la ligne
`base`, de chemin `C:\ProgramData\anaconda3\python.exe`. Si elle n'est pas dans
la liste : {ref}`V6 <dep-v6>`.

## Faire de Git Bash le terminal

Palette, « Terminal: Select Default Profile », puis « Git Bash ». S'il n'est
pas proposé : {ref}`V12 <dep-v12>`. Puis menu Terminal, New Terminal.

La flèche à droite du `+`, en haut à droite du panneau du terminal, liste les
terminaux ({ref}`Choisir le terminal à ouvrir <vscode-terminal-choisir>`).

L'invite doit commencer par `(base)`. Sinon, taper dans ce terminal :

```text
source /c/ProgramData/anaconda3/etc/profile.d/conda.sh
conda init bash
```

Fermer ensuite le terminal (icône de corbeille, en haut à droite du panneau),
puis en ouvrir un nouveau. Si un message d'erreur s'affiche : {ref}`G4
<dep-g4>`, {ref}`G5 <dep-g5>`, {ref}`G6 <dep-g6>`, {ref}`G7 <dep-g7>`.

## Vérifier

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Regarder en bas à droite de la fenêtre | `3.x ('base')` | {ref}`V6 <dep-v6>` |
| Menu Terminal, New Terminal | une invite qui commence par `(base)` et se termine par `$` | {ref}`G4 <dep-g4>`, {ref}`V5 <dep-v5>` |
| Dans ce terminal, `which python` | `/c/ProgramData/anaconda3/python` | {ref}`G4 <dep-g4>`, {ref}`V7 <dep-v7>` |
| Ouvrir un fichier `.py`, puis cliquer sur le triangle en haut à droite | la commande dans le terminal, puis ce que le programme affiche | {ref}`V8 <dep-v8>` |

Le détail de VS Code est dans l'annexe [VS
Code](../annexes/configuration/vscode.md), et les réglages complets, prêts à
recopier, dans [Fichiers de réglages](../annexes/configuration/vscode_reglages.md).
Les notebooks dans VS Code demandent en plus l'extension Jupyter
([Notebooks](../annexes/configuration/vscode_notebooks.md)).
