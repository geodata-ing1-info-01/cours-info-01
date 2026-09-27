---
title: VS Code
subtitle: Autoriser les scripts, installer les extensions Python et Jupyter, recopier les réglages du compte
---

:::{note}
Cette page ne concerne que la séance 2 et les suivantes. À la séance 1, le
premier programme s'écrit dans Notepad++ et se lance dans un terminal, sans
VS Code.
:::

Ces réglages sont faits et expliqués pendant la séance 2. Ils sont réunis
ici pour les séances suivantes : sur un poste qui n'a pas encore servi, on
les refait dans l'ordre de la page. La session réseau doit être ouverte
avant ([Premiers tests du poste](poste.md)), et Anaconda testé ([Anaconda
et JupyterLab](python.md)).

:::{warning}
Le premier lancement de l'année de VS Code peut être long : il crée ses
fichiers de configuration, et cherche des mises à jour. Cliquer une seule
fois, puis attendre, jusqu'à deux minutes. Les lancements suivants sont
plus rapides.
:::

Quatre étapes, dans cet ordre. Les réglages sont enregistrés dans le
compte : ils sont à refaire sur un poste où l'on ne s'est jamais connecté.

## Autoriser les scripts dans PowerShell

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

## Ouvrir VS Code sur le dossier de la séance

Dans Navigator, fiche VS Code, bouton Launch (ou menu Démarrer, taper
`visual studio code`, Entrée). Puis menu File, Open Folder, et choisir
`Bureau\info01\cours2`, ou le dossier de la séance.

À la première ouverture d'un dossier, VS Code demande si on fait confiance
à ses auteurs. Répondre « Yes, I trust the authors » ; sinon, l'extension
Python ne se charge pas ({ref}`V4 <dep-v4>`).

## Installer les extensions Python et Jupyter

Panneau Extensions (`Ctrl` + `Maj` + `X`). Taper `python` dans la zone de
recherche, choisir « Python », de Microsoft, et cliquer Install. Puis de
même avec `jupyter` et l'extension « Jupyter », de Microsoft.

Plusieurs extensions portent ces noms. Les bonnes se reconnaissent à leur
identifiant, écrit dans le volet de droite, ligne « Identifier » :
`ms-python.python` et `ms-toolsai.jupyter`. Si l'installation ne se fait
pas : {ref}`V3 <dep-v3>`.

## Recopier les réglages du compte

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

## Vérifier

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Palette, « Python: Select Interpreter » | une ligne `base`, type Conda, chemin `C:\ProgramData\anaconda3\python.exe`, cochée | {ref}`V6 <dep-v6>` |
| Menu Terminal, New Terminal | un onglet « Anaconda Prompt », une invite `(base) C:\…>` | {ref}`V5 <dep-v5>` |
| Dans ce terminal, `python -c "import sys; print(sys.executable)"` | `C:\ProgramData\anaconda3\python.exe` | {ref}`V7 <dep-v7>` |
| Ouvrir un `.ipynb`, bouton « Select Kernel », « Python Environments… » | `base` en tête de liste | {ref}`J1 <dep-j1>` |

Le détail de VS Code est dans l'annexe [VS Code](../annexes/configuration/vscode.md).
