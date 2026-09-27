---
title: VS Code
subtitle: L'éditeur de code du module ; ouvrir un dossier, la palette, les extensions, les réglages
---

VS Code est l'éditeur de code du module. Seul, il ne sait pas exécuter du
Python : il lui faut l'extension Python, et pour les notebooks l'extension
Jupyter. Une extension est un module qu'on ajoute à VS Code. Cette page
décrit ce qui sert dans tous les cas ; les deux pages suivantes décrivent
la configuration pour Python et pour les notebooks.

## Lancer VS Code et ouvrir un dossier

Menu Démarrer, taper `visual studio code`, Entrée. Puis menu File, Open
Folder, et choisir le dossier du TD. VS Code ouvre toujours un dossier, pas
un fichier isolé : le dossier est le projet, et l'explorateur de gauche en
montre le contenu.

À la première ouverture d'un dossier, VS Code demande si on fait confiance
à ses auteurs. Répondre « Yes, I trust the authors ». Sans cette réponse,
VS Code reste en « Restricted Mode » et l'extension Python ne se charge pas
({ref}`V4 <dep-v4>`).

## Lancer VS Code depuis l'invite de commandes d'Anaconda

Quand Navigator est lent ou ne s'ouvre pas, VS Code se lance aussi depuis
l'invite de commandes d'Anaconda. Taper `code` suivi d'une espace, puis glisser le dossier
du TD depuis l'explorateur dans la fenêtre, ce qui écrit son chemin, puis
Entrée :

```
(base) C:\Users\eleve>code "C:\Users\eleve\Desktop\cours1\2a_vscode_python"
```

VS Code s'ouvre sur ce dossier. Lancé ainsi, il connaît l'environnement
actif dans la fenêtre, ce qui aide au choix de l'interpréteur
({ref}`V6 <dep-v6>`) ; le réglage du terminal reste nécessaire
([Python et environnement conda](vscode_python.md)). Si la réponse est
`'code' n'est pas reconnu`, taper le chemin complet de la commande à la
place de `code` : `"C:\Program Files\Microsoft VS Code\bin\code.cmd"`, ou
`"%LOCALAPPDATA%\Programs\Microsoft VS Code\bin\code.cmd"` selon
l'installation ({ref}`V1 <dep-v1>`).

## La palette de commandes

`Ctrl` + `Maj` + `P` (ou `F1`) ouvre une zone de saisie en haut de la
fenêtre. On y tape le début du nom d'une commande et on la choisit dans la
liste. Toutes les consignes du module passent par elle, par exemple
« Python: Select Interpreter » ou « Developer: Reload Window ».

## Le panneau Extensions

`Ctrl` + `Maj` + `X` ouvre le panneau Extensions sur la gauche. On y tape
le nom d'une extension (`python`), on la choisit dans la liste, et on
clique Install.

:::{warning}
Installer une extension demande une connexion réseau qui fonctionne : les
extensions sont téléchargées depuis un serveur. Sur les postes de la
salle, ouvrir la session réseau avant ([Premiers tests du poste](../../avant/poste.md)).
Sans réseau, le panneau reste vide ou l'installation ne finit pas
({ref}`V3 <dep-v3>`).
:::

(vscode-reglages)=
## Les réglages

Tout ce qui se règle dans VS Code est enregistré dans des fichiers
`settings.json`. Il y en a deux niveaux :

- User : les réglages du compte, valables pour tous les dossiers ouverts
  sur ce poste. Le fichier est
  `C:\Users\<nom>\AppData\Roaming\Code\User\settings.json` ;
- Workspace : les réglages du dossier ouvert. Le fichier est
  `.vscode\settings.json` dans ce dossier ; il voyage avec le dossier, par
  exemple dans l'archive d'un TD.

Quand un réglage est présent aux deux niveaux, celui du dossier l'emporte.

```{figure} captures/vscode_settings_dossier.png
:alt: L'explorateur de VS Code montrant le fichier settings.json dans le dossier .vscode d'un projet, et son contenu ouvert dans l'éditeur
:width: 100%

Le fichier `.vscode\settings.json` d'un dossier, dans l'explorateur et
dans l'éditeur (documentation VS Code, CC BY 3.0 US).
```

Deux façons de les modifier, au choix :

- l'interface : palette (`Ctrl` + `Maj` + `P`), « Preferences: Open
  Settings (UI) », ou `Ctrl` + `,`. Une zone de recherche en haut, deux
  onglets User et Workspace, et un champ par réglage. Ce qu'on y écrit est
  enregistré aussitôt ;
- le fichier : palette, « Preferences: Open User Settings (JSON) » ou
  « Preferences: Open Workspace Settings (JSON) ». C'est le même contenu,
  en texte ; c'est la forme qu'on recopie depuis une page comme
  celle-ci.

```{figure} captures/vscode_settings_user_tab.png
:alt: La page des réglages : zone de recherche en haut, onglets User et Workspace, puis les réglages par catégorie
:width: 100%

La page des réglages, onglet User (documentation VS Code, CC BY 3.0 US).
```

```{figure} captures/vscode_settings_json.png
:alt: Le fichier settings.json du compte ouvert dans l'éditeur, avec son chemin AppData, Roaming, Code, User
:width: 80%

Le même contenu, dans le fichier `settings.json` du compte (documentation
VS Code, CC BY 3.0 US).
```

Dans le fichier, chaque réglage s'écrit `"nom": valeur`, les réglages sont
séparés par des virgules, et l'ensemble est entre accolades. Les chemins
Windows s'y écrivent avec des barres obliques inverses doublées. Les deux
réglages de l'exemple sont ceux de [Python et environnement
conda](vscode_python.md) ; les fichiers complets des postes de la salle
sont dans [Fichiers de réglages](vscode_reglages.md) :

```json
{
  "python.defaultInterpreterPath": "C:\\ProgramData\\anaconda3\\python.exe",
  "python.condaPath": "C:\\ProgramData\\anaconda3\\Scripts\\conda.exe"
}
```

Une erreur dans ce fichier se voit à une ligne soulignée en rouge
({ref}`V10 <dep-v10>`).

## Le terminal

Le terminal est une fenêtre de commandes à l'intérieur de VS Code
([Les terminaux](../notions/terminaux.md)). Menu
Terminal, New Terminal l'ouvre en bas de la fenêtre (le raccourci clavier
dépend du clavier, {ref}`V9 <dep-v9>`). Par défaut, c'est un PowerShell.
Sur les postes de la salle, deux terminaux le remplacent : l'invite de
commandes d'Anaconda, ouverte par défaut, et Git Bash. Leur réglage est
décrit dans [Python et environnement conda](vscode_python.md).

(vscode-terminal-choisir)=
### Choisir le terminal à ouvrir

En haut à droite du panneau du terminal, le bouton `+` ouvre un nouveau
terminal, du type par défaut. La petite flèche juste à sa droite ouvre la
liste des types de terminal que VS Code connaît, ses profils :
PowerShell, Command Prompt (le `cmd`), Git Bash quand il est installé
([Git et Git Bash](git.md)). Cliquer sur un nom ouvre un nouveau terminal
de ce type.

```{figure} captures/vscode_terminal_choisir.png
:alt: Le panneau du terminal ; le bouton plus et sa flèche sont encadrés en haut à droite, et la liste ouverte propose PowerShell, Git Bash, Command Prompt et d'autres profils
:width: 100%

La flèche à côté du `+`, et la liste des profils (documentation VS Code,
CC BY 3.0 US).
```

En bas de la même liste, « Select Default Profile » change le type ouvert
par le `+` et par le menu Terminal, New Terminal.

### Voir les terminaux ouverts

Ouvrir un terminal ne ferme pas le précédent. Avec un seul terminal
ouvert, son nom est écrit en haut à droite du panneau, à gauche du `+`
(« powershell » dans la capture précédente). À partir de deux, une liste
apparaît sur la droite du panneau, une ligne par terminal, avec l'icône et
le nom de son type. La ligne surlignée est le terminal affiché, celui qui
reçoit ce qu'on tape ; cliquer sur une autre ligne affiche l'autre
terminal. L'icône de corbeille, au survol d'une ligne, ferme ce terminal.

```{figure} captures/vscode_terminal_liste.png
:alt: Le panneau du terminal avec, à droite, la liste des terminaux ouverts : debian, ubuntu, pwsh surligné, cmd, JavaScript Debug Terminal ; pwsh et cmd sont affichés côte à côte
:width: 100%

La liste des terminaux ouverts, à droite du panneau. Ici, `pwsh`
(PowerShell) et `cmd` sont affichés côte à côte, ce que le trait qui les
relie dans la liste indique (documentation VS Code, CC BY 3.0 US).
```

L'invite dit aussi dans quel terminal on se trouve : celle de PowerShell
commence par `PS`, celle du `cmd` se termine par `>`, et celle de Git Bash
par `$`.

(vscode-git)=
## Git dans VS Code

VS Code fait deux choses distinctes avec git, réglées séparément : le
panneau Source Control, et le terminal Git Bash. Git Bash hors de VS Code
est décrit dans [Git et Git Bash](git.md).

### Le panneau Source Control

Le panneau Source Control (`Ctrl` + `Maj` + `G`) lance `git.exe` lui-même,
sans terminal. Il le cherche dans cet ordre : le réglage `git.path` ;
`C:\Program Files\Git\cmd\git.exe` ;
`C:\Users\<nom>\AppData\Local\Programs\Git\cmd\git.exe` ; enfin le PATH
tel qu'il était quand VS Code a été lancé. Sur les postes de la salle, Git
for Windows est dans `C:\Program Files\Git`, et VS Code le trouve sans
réglage. Avec une des solutions de secours de [Git et Git
Bash](git.md), git n'est à aucun des deux premiers endroits : donner son
chemin dans les réglages User ({ref}`Les réglages <vscode-reglages>`),
puis « Developer: Reload Window » :

```json
"git.path": "C:\\Users\\eleve\\.conda\\envs\\outils\\Library\\cmd\\git.exe"
```

Pour Cmder, le chemin est `<Cmder>\vendor\git-for-windows\cmd\git.exe` ;
pour l'archive portable, `<dossier>\PortableGit\cmd\git.exe`. Autre
solution, sans réglage : lancer VS Code depuis l'invite de commandes d'Anaconda où
`outils` est activé (`code <dossier>`), git est alors dans son PATH.

### Le terminal Git Bash

Quand Git for Windows est installé dans un dossier nommé `Git`, VS Code
ajoute de lui-même « Git Bash » à la liste de ses profils de terminal
({ref}`Choisir le terminal à ouvrir <vscode-terminal-choisir>`). Le
terminal Git Bash de VS Code lit le même fichier `~/.bash_profile` que la
fenêtre Git Bash : conda y est disponible une fois `conda init bash` fait
({ref}`Anaconda, section Git Bash <conda-git-bash>`). Son réglage avec
l'invite de commandes d'Anaconda est décrit dans [Python et environnement
conda](vscode_python.md).

Avec les solutions de secours, VS Code ne propose pas « Git Bash ». Le
profil s'écrit à la main, et pointe sur le `bash.exe` du même dossier que
`git.exe` :

```json
"terminal.integrated.profiles.windows": {
  "Git Bash": {
    "path": "C:\\Users\\eleve\\.conda\\envs\\outils\\Library\\bin\\bash.exe",
    "args": ["--login", "-i"]
  }
}
```

Menu Terminal, New Terminal, puis la flèche à côté du `+` pour choisir
« Git Bash », et vérifier dans la liste des terminaux que c'est lui qui
est affiché ({ref}`Choisir le terminal à ouvrir
<vscode-terminal-choisir>`). VS Code ne connaît aucune commande de bash : il lance
`bash.exe`, et bash trouve `git`, `ls` et les autres tout seul
([Git Bash : une fenêtre, bash et des programmes](../notions/git_bash.md)).

## Fichiers utiles

| Quoi | Où |
|---|---|
| Réglages du compte (`settings.json`) | palette, « Preferences: Open User Settings (JSON) » ; sur le disque, `C:\Users\<nom>\AppData\Roaming\Code\User\settings.json` |
| Réglages du dossier ouvert | `<dossier>\.vscode\settings.json` |
| Extensions installées | `C:\Users\<nom>\.vscode\extensions` ; `code --list-extensions` dans un `cmd` |
| Journaux des extensions | panneau Output (`Ctrl` + `Maj` + `U`), liste déroulante « Python », « Python Environments », « Jupyter » |

## Source des captures d'écran

Les captures de cette page viennent de la
[documentation de Visual Studio Code](https://code.visualstudio.com/docs)
(Microsoft), publiée sous licence
[Creative Commons Attribution 3.0 US](https://creativecommons.org/licenses/by/3.0/us/).

## Documentation officielle

- [Getting started with Python in VS Code](https://code.visualstudio.com/docs/python/python-tutorial)
  (en anglais) : extension Python, interpréteur, exécution d'un fichier.
- [Jupyter Notebooks in VS Code](https://code.visualstudio.com/docs/datascience/jupyter-notebooks)
  (en anglais) : extension Jupyter, choix du noyau.

```{toctree}
:maxdepth: 1

vscode_python
vscode_notebooks
vscode_reglages
```
