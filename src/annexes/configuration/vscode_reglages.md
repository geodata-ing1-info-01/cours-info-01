---
title: Fichiers de réglages
subtitle: Les deux settings.json des postes de la salle, prêts à recopier
---

Cette page réunit les réglages décrits dans [Python et environnement
conda](vscode_python.md) et [Notebooks](vscode_notebooks.md) en deux
fichiers complets. Le premier se recopie une fois par compte ; le second
est livré dans l'archive de chaque TD. Les deux niveaux de réglages et
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

conda est disponible dans Git Bash après `conda init bash` ({ref}`Git et Git
Bash, section conda <conda-git-bash>`).

## Réglages du dossier d'un TD

Fichier `.vscode\settings.json` à la racine du dossier du TD ; dans
VS Code, palette, « Preferences: Open Workspace Settings (JSON) », qui le
crée s'il n'existe pas. Ce fichier est livré dans l'archive de chaque TD, et il
n'y a rien à y faire. Il est reproduit ici pour préparer une archive ou vérifier
un poste.

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
   `$`. Sans `(base)` : {ref}`G4 <dep-g4>`. Si une erreur s'affiche :
   {ref}`V5 <dep-v5>`.
3. Flèche à côté du `+`, « Anaconda Prompt ». Un onglet « Anaconda Prompt »
   s'ouvre, avec une invite `(base) C:\…>`. Sinon : {ref}`V5 <dep-v5>`.
4. Dans ce terminal, taper `python -c "import sys; print(sys.executable)"`. La
   commande affiche `C:\ProgramData\anaconda3\python.exe`. Sinon :
   {ref}`V7 <dep-v7>`.
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

(vscode-caches)=
## Vider les caches de VS Code

VS Code et ses extensions gardent des informations d'une session à
l'autre : la liste des environnements trouvés, l'interpréteur choisi pour
chaque dossier, le noyau de chaque notebook. Après la suppression ou la
recréation d'un environnement, ces informations peuvent ne plus
correspondre au poste. Un interpréteur qui n'existe plus reste proposé, ou
un environnement nouveau n'apparaît pas dans la liste.

La première solution se trouve dans VS Code : palette, « Python: Clear Cache
and Reload Window ». La commande vide le cache de l'extension Python et
recharge la fenêtre.

Si le problème reste, fermer VS Code, puis lancer l'un des deux scripts
suivants depuis le dossier où il a été enregistré :

- {download}`vider_cache_vscode.bat <fichiers/vider_cache_vscode.bat>`,
  dans l'invite de commandes d'Anaconda : `vider_cache_vscode.bat` ;
- {download}`vider_cache_vscode.sh <fichiers/vider_cache_vscode.sh>`, dans
  Git Bash, et aussi sous macOS et Linux : `bash vider_cache_vscode.sh`.

Chaque script vérifie d'abord que VS Code est fermé. Il supprime ensuite
des dossiers de `%APPDATA%\Code`, le dossier de VS Code dans le compte :

| Dossiers | Contenu | Supprimés |
|---|---|---|
| `Cache`, `CachedData`, `CachedExtensionVSIXs`, `Code Cache`, `GPUCache` | les caches de l'application | toujours |
| `User\workspaceStorage` | l'état de chaque dossier ouvert : interpréteur choisi, noyau des notebooks, onglets ouverts | avec l'option `--tout` |
| `User\globalStorage\ms-python.python`, `ms-python.vscode-python-envs`, `ms-toolsai.jupyter` | les données des extensions Python, Python Environments et Jupyter | avec l'option `--tout` |

Les scripts ne touchent ni aux réglages (`settings.json`), ni aux
extensions installées. Après l'option `--tout`, l'interpréteur et le noyau
sont à choisir de nouveau dans chaque dossier. Les noms des dossiers
viennent de l'organisation habituelle de VS Code [à vérifier sur un poste
de la salle].
