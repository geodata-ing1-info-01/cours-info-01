---
title: Fichiers de réglages
subtitle: Les deux settings.json des postes de la salle, prêts à recopier
---

Cette page réunit les réglages de [Python et environnement
conda](vscode_python.md) et de [Notebooks](vscode_notebooks.md) en deux
fichiers complets, et détaille ceux de conda. Le premier se recopie une fois par compte, et a
priori sur chaque poste employé [à vérifier sur un poste] ; le second règle un seul dossier.
Les deux niveaux de réglages et
l'ouverture des fichiers sont décrits dans {ref}`VS Code, section Les réglages
<vscode-reglages>`.

Les réglages Python et le profil « Anaconda Prompt » ont été vérifiés le 21
septembre 2026 sur un poste de la salle, avec VS Code 1.124, l'extension Python
2026.4, Python Environments 1.36 et Jupyter 2025.9. Git Bash comme terminal par
défaut reste [à vérifier sur un poste].

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
    },
    "Git Bash": {
      "path": "C:\\Program Files\\Git\\bin\\bash.exe",
      "args": ["--login", "-i"]
    }
  },
  "terminal.integrated.defaultProfile.windows": "Git Bash",
  "editor.renderWhitespace": "all",
  "files.autoSave": "afterDelay"
}
```

Enregistrer (`Ctrl` + `S`), puis palette, « Developer: Reload Window ».

| Réglage | Effet |
|---|---|
| `python.condaPath` | VS Code interroge conda pour lister les environnements, même s'il ne l'a pas trouvé seul |
| `python.defaultInterpreterPath` | `base` sert d'interpréteur à un dossier tant qu'aucun autre n'y est choisi, et de premier noyau proposé |
| `python-envs.defaultEnvManager` | « Create Environment » crée un environnement conda |
| `python-envs.defaultPackageManager` | « Install Package » installe avec conda |
| `terminal.integrated.profiles.windows`, « Anaconda Prompt » | ajoute le terminal de secours, un `cmd` qui lance `activate.bat` à l'ouverture |
| `terminal.integrated.profiles.windows`, « Git Bash » | garde Git Bash dans la liste des terminaux, même si VS Code ne le trouve pas seul |
| `terminal.integrated.defaultProfile.windows` | New Terminal ouvre Git Bash |
| `editor.renderWhitespace` | un point gris marque chaque espace, comme dans Notepad++ |
| `files.autoSave` | le fichier s'enregistre une seconde après la dernière frappe |

conda est disponible dans Git Bash après `conda init bash` ({ref}`Anaconda,
section conda dans un terminal <conda-terminal>`).

## Réglages d'un dossier

Fichier `.vscode\settings.json` à la racine du dossier ; dans VS Code,
palette, « Preferences: Open Workspace Settings (JSON) », qui le crée s'il
n'existe pas. Les archives des TD n'en contiennent pas, car le réglage
`python.defaultInterpreterPath` du compte donne `base` à chaque dossier ouvert.
Le fichier ci-dessous donne les mêmes réglages Python à un seul dossier, et le
dossier le garde quand on le copie ou le versionne.

```json
{
  "python.defaultInterpreterPath": "C:\\ProgramData\\anaconda3\\python.exe",
  "python-envs.defaultEnvManager": "ms-python.python:conda",
  "python-envs.defaultPackageManager": "ms-python.python:conda"
}
```

Ce fichier diffère de celui du compte :

- `python.condaPath` n'y est pas : VS Code ne le lit qu'au niveau du
  compte, et l'ignore ici sans message ;
- le terminal n'y est pas réglé, car le réglage du compte s'applique. Un réglage
  de terminal posé par un dossier l'emporterait sur celui du compte, et
  ferait apparaître à l'ouverture une notification qui demande
  d'autoriser le dossier à changer le terminal.

## Vérifier

1. Palette, « Python: Select Interpreter ». La ligne `base`, de type Conda, avec
   le chemin `C:\ProgramData\anaconda3\python.exe`, est cochée. Sinon :
   {ref}`V6 <dep-v6>`.
2. Menu Terminal, New Terminal. L'invite commence par `(base)` et se termine par
   `$`. Sans `(base)` : {ref}`A3 <dep-a3>`. Si une erreur s'affiche :
   {ref}`V5 <dep-v5>`.
3. Flèche à côté du `+`, « Anaconda Prompt ». Un onglet « Anaconda Prompt »
   s'ouvre, avec une invite `(base) C:\…>`. Sinon : {ref}`V5 <dep-v5>`.
4. Dans ce terminal, taper `python -c "import sys; print(sys.executable)"`. La
   commande affiche `C:\ProgramData\anaconda3\python.exe`. Sinon :
   {ref}`A16 <dep-a16>`.
5. Ouvrir un `.ipynb`, cliquer sur « Select Kernel », puis « Python
   Environments… ». `base` est en tête de liste. Sinon : {ref}`J1 <dep-j1>`.
6. Exécuter une cellule `import sys; sys.executable`. La cellule affiche
   `C:\ProgramData\anaconda3\python.exe`, sans proposer d'installer `ipykernel`.
   Sinon : {ref}`J2 <dep-j2>`.

Le panneau Output (`Ctrl` + `Maj` + `U`), liste déroulante « Python
Environments », doit contenir une ligne `Discovered manager: (Conda)
C:\ProgramData\anaconda3\Scripts\conda.exe`. Si elle manque, le chemin de
`python.condaPath` est mal recopié, ou Anaconda n'est pas dans
`C:\ProgramData\anaconda3` sur ce poste ({ref}`A1 <dep-a1>`).

## Les réglages de conda

`python.condaPath` et `python.defaultInterpreterPath` corrigent une liste
d'interpréteurs sans `base` ({ref}`V6 <dep-v6>`).
Leurs valeurs sont celles des postes de la salle : si elles diffèrent, les lire
dans la cible du raccourci « Anaconda Prompt ».

`python.condaPath`
: Le chemin du programme `conda`. Avec ce réglage, VS Code interroge
  conda et obtient la liste complète des environnements, `base` et ceux
  du compte ; il s'en sert aussi pour activer l'environnement dans le
  terminal. Valeur : `C:\\ProgramData\\anaconda3\\Scripts\\conda.exe`.
  Niveau User seulement : au niveau Workspace, il est ignoré sans message.
  Il vaut pour les deux extensions, Python et Python Environments. VS Code
  ne relance pas toujours la recherche après ce changement : faire
  palette, « Python: Clear Cache and Reload Window » (ou « Developer:
  Reload Window »).

`python.defaultInterpreterPath`
: Le chemin du Python à employer pour un dossier tant qu'aucun
  interpréteur n'y a été choisi. Pour `base` :
  `C:\\ProgramData\\anaconda3\\python.exe` ; pour un environnement créé
  par le compte : `${env:USERPROFILE}\\.conda\\envs\\recette\\python.exe`.
  Niveau User ou Workspace ; au niveau Workspace, il peut être livré dans
  le `.vscode\settings.json` d'un dossier. Un choix fait ensuite par « Python:
  Select Interpreter » l'emporte sur ce réglage pour ce dossier, et la
  liste propose alors une entrée « Use Python from
  `python.defaultInterpreterPath` setting » pour y revenir. L'extension
  Jupyter propose ce même interpréteur en tête de sa liste de noyaux
  ([Notebooks](vscode_notebooks.md)).

`python-envs.defaultEnvManager`
: L'outil que VS Code emploie quand on lui demande de créer un
  environnement (bouton « Create Environment »), et celui dont la liste
  s'affiche en premier dans la vue Python : `ms-python.python:venv` par
  défaut (des environnements `venv`, sans conda), `ms-python.python:conda`
  pour employer conda. Sans ce réglage, un « Create Environment » lancé
  par mégarde produit un `venv` dans le dossier du TD, et la vue Python
  place venv avant conda. Poser ce réglage, même si le module crée ses
  environnements dans l'invite de commandes d'Anaconda.

`python-envs.defaultPackageManager`
: L'outil employé par « Install Package » dans la vue Python :
  `ms-python.python:pip` par défaut, `ms-python.python:conda` pour employer
  conda. Le poser pour la même raison.

:::{note}
`${env:USERPROFILE}` est remplacé par VS Code par le dossier du compte,
`C:\Users\<nom>`. Les réglages qui commencent par `python.` acceptent
cette écriture, `${env:NOM}` pour toute variable d'environnement
([Variables d'environnement](../notions/variables_environnement.md)). Elle
permet d'écrire un fichier de réglages qui vaut pour tous les comptes, et
de le distribuer tel quel. Les chemins d'Anaconda de la salle, dans
`C:\ProgramData`, n'en ont pas besoin : ils ne contiennent pas le nom du
compte.
:::
