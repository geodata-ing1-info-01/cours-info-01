---
title: Anaconda, JupyterLab et VS Code
subtitle: Tester Anaconda et JupyterLab, régler VS Code
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

## VS Code

Quatre étapes, dans cet ordre. Les réglages sont enregistrés dans le
compte : ils sont à refaire sur un poste où l'on ne s'est jamais connecté.

### Autoriser les scripts dans PowerShell

Le terminal de VS Code est un PowerShell. À son ouverture, il affiche
`… cannot be loaded because running scripts is disabled on this system`
({ref}`A7 <dep-a7>`) : PowerShell refuse le script qui active
l'environnement d'Anaconda. Le compte peut l'autoriser pour lui-même, sans
droits d'administration.

Menu Démarrer, taper `powershell`, Entrée. Taper la commande suivante,
puis Entrée :

```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Répondre `O`, puis fermer la fenêtre. Si la réponse est un message
d'erreur, le poste impose sa stratégie : passer à la suite, les dernières
lignes des réglages du compte, plus bas, remplacent PowerShell par un
`cmd` déjà activé.

### Ouvrir VS Code sur le dossier de la séance

Dans Navigator, fiche VS Code, bouton Launch (ou menu Démarrer, taper
`visual studio code`, Entrée). Puis menu File, Open Folder, et choisir
`Bureau\info01\cours1`, ou le dossier de la séance.

À la première ouverture d'un dossier, VS Code demande si on fait confiance
à ses auteurs. Répondre « Yes, I trust the authors » ; sinon, l'extension
Python ne se charge pas ({ref}`V4 <dep-v4>`).

### Installer les extensions Python et Jupyter

Panneau Extensions (`Ctrl` + `Maj` + `X`). Taper `python` dans la zone de
recherche, choisir « Python », de Microsoft, et cliquer Install. Puis de
même avec `jupyter` et l'extension « Jupyter », de Microsoft.

Plusieurs extensions portent ces noms. Les bonnes se reconnaissent à leur
identifiant, écrit dans le volet de droite, ligne « Identifier » :
`ms-python.python` et `ms-toolsai.jupyter`. Si l'installation ne se fait
pas : {ref}`V3 <dep-v3>`.

### Recopier les réglages du compte

Palette (`Ctrl` + `Maj` + `P`), « Preferences: Open User Settings
(JSON) ». Si le fichier est vide, y recopier le bloc suivant en entier.
S'il contient déjà des réglages, ajouter les lignes du bloc entre les
accolades, après une virgule.

```json
{
  "python.condaPath": "C:\\ProgramData\\anaconda3\\Scripts\\conda.exe",
  "python.defaultInterpreterPath": "C:\\ProgramData\\anaconda3\\python.exe",
  "python-envs.defaultEnvManager": "ms-python.python:conda",
  "python-envs.defaultPackageManager": "ms-python.python:conda",
  "terminal.integrated.profiles.windows": {
    "Anaconda Prompt": {
      "path": "C:\\Windows\\System32\\cmd.exe",
      "args": ["/K", "C:\\ProgramData\\anaconda3\\Scripts\\activate.bat", "C:\\ProgramData\\anaconda3"]
    }
  },
  "terminal.integrated.defaultProfile.windows": "Anaconda Prompt"
}
```

Enregistrer (`Ctrl` + `S`), puis palette, « Developer: Reload Window ».
Les dernières lignes décrivent à VS Code le terminal de l'invite de commandes d'Anaconda,
qui s'ouvre déjà activé, sans dépendre de l'extension Python.
Ce que fait chaque ligne est expliqué dans [Fichiers de
réglages](../annexes/configuration/vscode_reglages.md).

### Vérifier

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Palette, « Python: Select Interpreter » | une ligne `base`, type Conda, chemin `C:\ProgramData\anaconda3\python.exe`, cochée | {ref}`V6 <dep-v6>` |
| Menu Terminal, New Terminal | un onglet « Anaconda Prompt », une invite `(base) C:\…>` | {ref}`V5 <dep-v5>` |
| Dans ce terminal, `python -c "import sys; print(sys.executable)"` | `C:\ProgramData\anaconda3\python.exe` | {ref}`V7 <dep-v7>` |
| Ouvrir un `.ipynb`, bouton « Select Kernel », « Python Environments… » | `base` en tête de liste | {ref}`J1 <dep-j1>` |

Le détail de chaque outil est dans les annexes : [Anaconda](../annexes/configuration/anaconda.md),
[JupyterLab](../annexes/configuration/jupyterlab.md),
[VS Code](../annexes/configuration/vscode.md). Spyder, que d'autres cours
emploient, se teste depuis sa page, [Spyder](../annexes/configuration/spyder.md).
