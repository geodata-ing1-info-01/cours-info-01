---
title: Fichiers de réglages
subtitle: Les deux settings.json des postes de la salle, prêts à recopier
---

Cette page réunit les réglages décrits dans [Python et environnement
conda](vscode_python.md) et [Notebooks](vscode_notebooks.md) en deux
fichiers complets. Le premier se recopie une fois par compte ; le second
est livré dans l'archive de chaque TD. Ce que sont ces deux niveaux et
comment ouvrir les fichiers : {ref}`VS Code, section Les réglages
<vscode-reglages>`.

Ces fichiers ont été vérifiés le 21 septembre 2026 sur un poste de la
salle, avec VS Code 1.124, l'extension Python 2026.4, Python Environments
1.36 et Jupyter 2025.9. Ils obtiennent trois choses : la liste des
environnements conda dans « Python: Select Interpreter » et dans le
sélecteur de noyau, un `cmd` déjà activé comme terminal par défaut, et `base` comme
noyau des notebooks sans rien installer.

## Réglages du compte

Fichier `C:\Users\<nom>\AppData\Roaming\Code\User\settings.json` ; dans
VS Code, palette (`Ctrl` + `Maj` + `P`), « Preferences: Open User Settings
(JSON) ».

Si le fichier est vide ou n'existe pas, le recopier en entier. S'il
contient déjà des réglages, ajouter les lignes du bloc entre les
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

| Réglage | Ce qu'il obtient |
|---|---|
| `python.condaPath` | conda est interrogé pour la liste des environnements, même si VS Code ne l'a pas trouvé seul |
| `python.defaultInterpreterPath` | `base` est l'interpréteur d'un dossier tant qu'on n'en a pas choisi un autre, et le noyau proposé en premier |
| `python-envs.defaultEnvManager` | « Create Environment » crée un environnement conda, pas un `venv` |
| `python-envs.defaultPackageManager` | « Install Package » passe par conda, pas par pip |
| `terminal.integrated.profiles.windows` | décrit le terminal de l'Anaconda Prompt : un `cmd` qui lance `activate.bat` à l'ouverture |
| `terminal.integrated.defaultProfile.windows` | ce terminal est celui qu'ouvre New Terminal, déjà activé, sans dépendre de l'extension Python |

## Réglages du dossier d'un TD

Fichier `.vscode\settings.json` à la racine du dossier du TD ; dans
VS Code, palette, « Preferences: Open Workspace Settings (JSON) », qui le
crée s'il n'existe pas. Il est livré dans l'archive de chaque TD, donc
l'étudiant n'a rien à y faire ; il est reproduit ici pour qui prépare une
archive ou vérifie un poste.

```json
{
  "python.defaultInterpreterPath": "C:\\ProgramData\\anaconda3\\python.exe",
  "python-envs.defaultEnvManager": "ms-python.python:conda",
  "python-envs.defaultPackageManager": "ms-python.python:conda"
}
```

Deux différences avec le fichier du compte :

- `python.condaPath` n'y est pas : VS Code ne le lit qu'au niveau du
  compte, et l'ignore ici sans message ;
- le terminal n'y est pas réglé : celui du compte suffit. Un réglage de
  terminal posé par un dossier l'emporterait sur celui du compte, et
  ferait apparaître à l'ouverture une notification qui demande
  d'autoriser le dossier à changer le terminal.

## Vérifier

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Palette, « Python: Select Interpreter » | une ligne `base`, type Conda, chemin `C:\ProgramData\anaconda3\python.exe`, cochée | {ref}`V6 <dep-v6>` |
| Menu Terminal, New Terminal | un onglet « Anaconda Prompt », une invite `(base) C:\…>` | {ref}`V5 <dep-v5>` |
| Dans ce terminal, `python -c "import sys; print(sys.executable)"` | `C:\ProgramData\anaconda3\python.exe` | {ref}`V7 <dep-v7>` |
| Ouvrir un `.ipynb`, bouton « Select Kernel », « Python Environments… » | `base` en tête de liste | {ref}`J1 <dep-j1>` |
| Exécuter une cellule `import sys; sys.executable` | `C:\ProgramData\anaconda3\python.exe`, sans proposition d'installer `ipykernel` | {ref}`J2 <dep-j2>` |

Le panneau Output (`Ctrl` + `Maj` + `U`), liste déroulante « Python
Environments », doit contenir une ligne `Discovered manager: (Conda)
C:\ProgramData\anaconda3\Scripts\conda.exe`. Si elle manque, le chemin de
`python.condaPath` est mal recopié, ou Anaconda n'est pas dans
`C:\ProgramData\anaconda3` sur ce poste ({ref}`A1 <dep-a1>`).

## Variante : le profil « Command Prompt »

Les réglages de ce fichier jusqu'au 25 septembre 2026 remplaçaient les
deux réglages de terminal par la seule ligne :

```json
"terminal.integrated.defaultProfile.windows": "Command Prompt"
```

Ce `cmd` ordinaire compte sur l'extension Python pour activer
l'environnement, et cela ne marche pas sur tous les postes. Quand
l'extension n'a pas pu lire les informations d'activation de conda, le
panneau Output, « Python Environments », contient `Conda environment
manager is not available, using default conda activation paths`, et
l'extension tape seulement `conda activate base`. Dans un `cmd` où
`conda init cmd.exe` n'a jamais été fait, cette commande répond
`CondaError: Run 'conda init' before 'conda activate'` et l'invite reste
sans `(base)` ({ref}`V5 <dep-v5>`). Le profil « Anaconda Prompt » lance
`activate.bat` lui-même, et ne dépend pas de ce cas.

## PowerShell, si on y tient

Le terminal PowerShell refuse `conda-hook.ps1` parce que sa stratégie
d'exécution est `Restricted` ({ref}`A7 <dep-a7>`). Quand aucune stratégie
de groupe ne l'impose, le compte peut la changer pour lui-même, sans
droits d'administration, dans un terminal PowerShell :

```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Répondre `O`, fermer et rouvrir le terminal. `Get-ExecutionPolicy -List`
dit avant si c'est possible : les lignes `MachinePolicy` et `UserPolicy`
doivent être à `Undefined`. Le réglage suit le compte, pas le poste ; sur
une machine virtuelle remise à zéro, il est à refaire.
