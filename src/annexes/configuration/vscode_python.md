---
title: Python et environnement conda
subtitle: Extension Python, interpréteur, terminal Git Bash
---

La configuration se fait une fois par poste et par compte, dans cet ordre, avec
VS Code ouvert sur le dossier du TD ([VS Code](vscode.md)) :

1. Installer l'extension Python, avec une connexion internet.
2. Choisir l'interpréteur : le `python.exe` d'Anaconda.
3. Faire de Git Bash le terminal de VS Code, avec conda activé.
4. Lancer un programme pour vérifier.

Les autres réglages et les versions vérifiées sont en fin de page.

## Installer l'extension Python

1. Ouvrir le panneau Extensions : `Ctrl` + `Maj` + `X`, ou le bouton à quatre
   carrés dans la barre de gauche.
2. Taper `python` dans la zone de recherche.
3. Choisir « Python », de Microsoft : le nom de l'éditeur est écrit sous celui
   de l'extension, avec une coche bleue.
4. Cliquer sur Install. Python, Pylance et Python Debugger apparaissent ensuite
   comme installées. Sinon : {ref}`V3 <dep-v3>`.

```{figure} captures/vscode_extensions_python.png
:alt: Le panneau Extensions avec python dans la zone de recherche ; l'extension Python de Microsoft est en tête de liste, et son volet de détail est ouvert
:width: 100%

Le panneau Extensions après avoir tapé `python` ; ici l'extension est déjà
installée, d'où les boutons Disable et Uninstall à la place d'Install
(documentation VS Code, CC BY 3.0 US).
```

Plusieurs extensions s'appellent « Python », et certaines ne viennent pas de
Microsoft : lire le nom de l'éditeur avant d'installer. Sur la page de
l'extension, la ligne « Identifier » donne `ms-python.python`.

## Choisir l'interpréteur

L'interpréteur est le Python que VS Code emploie pour exécuter les fichiers
`.py`.

1. Ouvrir un fichier `.py` du TD.
2. Palette, « Python: Select Interpreter ». Une liste apparaît, avec pour chaque
   Python trouvé son nom, son chemin, et son type : Conda pour un environnement
   conda, Global pour un Python installé seul.
3. Choisir la ligne `base` dont le chemin contient `anaconda3`. Si la liste ne
   montre pas `base` : {ref}`Quand la liste ne montre ni base ni les
   environnements <vscode-liste-interpreteurs>`.

```{figure} captures/vscode_select_interpreter.png
:alt: La liste Select Interpreter : l'interpréteur choisi en haut, puis Enter interpreter path, une entrée base de type Conda, et des Python de type Global et Workspace
:width: 100%

La liste « Python: Select Interpreter », sur un autre poste : `base` y est dans
`miniconda3`, et le cadre rouge marque le Python déjà choisi. Sur les postes de
la salle, la ligne `base` porte le chemin `C:\ProgramData\anaconda3\python.exe`
(documentation VS Code, CC BY 3.0 US).
```

Le nom choisi s'affiche en bas à droite de la fenêtre, et il est mémorisé
pour ce dossier, à part des fichiers `settings.json`, dans `User\workspaceStorage`.

```{figure} captures/vscode_status_bar.png
:alt: La barre d'état de VS Code avec le nom de l'environnement Python choisi
:width: 50%

L'interpréteur choisi, en bas à droite de la fenêtre (documentation VS
Code, CC BY 3.0 US).
```

Quand un TD a créé son propre environnement ([Anaconda](anaconda.md)), le
choisir ici, par son nom. VS Code crée aussi un environnement conda par la
commande « Python: Create Environment ». [Comment VS Code gère les
environnements](../notions/vscode_environnements.md) décrit ce qu'elle lance, et
pourquoi le module passe par l'invite de commandes d'Anaconda.

## Régler le terminal

Par défaut, le terminal de VS Code est un PowerShell, qui refuse le script
d'activation d'Anaconda tant que le compte n'a pas changé sa stratégie
({ref}`A7 <dep-a7>`). Le module emploie Git Bash, le terminal du cours 1
([Git et Git Bash](git.md)). VS Code l'ajoute à ses profils quand Git for
Windows est installé dans `C:\Program Files\Git`, comme sur les postes de la
salle.

Palette, « Terminal: Select Default Profile », puis « Git Bash » (s'il est
absent : {ref}`V12 <dep-v12>`). Ce choix est écrit dans les réglages du compte
({ref}`VS Code, section Les réglages <vscode-reglages>`) :

```json
"terminal.integrated.defaultProfile.windows": "Git Bash"
```

Le fichier complet est dans [Fichiers de réglages](vscode_reglages.md). Le
terminal de VS Code lit le même `~/.bash_profile` que la fenêtre Git Bash, où
`conda init bash` a écrit ({ref}`Git et Git Bash, section conda
<conda-git-bash>`) : l'invite commence donc par `(base)`.

## Vérifier

1. Menu Terminal, New Terminal. L'invite commence par `(base)` et se termine par
   `$`. Sans `(base)` : {ref}`G4 <dep-g4>`. Si une erreur s'affiche :
   {ref}`V5 <dep-v5>`.
2. Dans ce terminal, taper `python -c "import sys; print(sys.executable)"`. Le
   chemin d'Anaconda s'affiche. Sinon : {ref}`V7 <dep-v7>`.
3. Ouvrir un fichier `.py`, puis cliquer sur le triangle en haut à droite. Le
   terminal affiche ce que le programme écrit. Sinon : {ref}`V8 <dep-v8>`.

Le chemin affiché dans le terminal doit être celui de l'interpréteur choisi. Si
un `import` échoue alors que le paquet est installé, ces deux Python diffèrent
souvent ({ref}`V8 <dep-v8>`).

## Les autres terminaux

### Secours : l'invite de commandes d'Anaconda

Quand le réglage de conda échoue dans Git Bash, le terminal de secours est un
`cmd` ([Les terminaux](../notions/terminaux.md)), celui de l'invite de
commandes d'Anaconda. Ce profil active `base` à l'ouverture, sans dépendre de
l'extension Python.

1. Palette, « Preferences: Open User Settings (JSON) ».
2. Ajouter ces lignes entre les deux accolades du fichier, après une virgule s'il
   y a déjà quelque chose :

   ```json
   "terminal.integrated.profiles.windows": {
     "Anaconda Prompt": {
       "path": "C:\\Windows\\System32\\cmd.exe",
       "args": ["/K", "C:\\ProgramData\\anaconda3\\Scripts\\activate.bat", "C:\\ProgramData\\anaconda3"]
     }
   },
   "terminal.integrated.defaultProfile.windows": "Anaconda Prompt"
   ```

3. Enregistrer (`Ctrl` + `S`).
4. Menu Terminal, New Terminal. L'onglet s'appelle « Anaconda Prompt », et
   l'invite commence par `(base)`. Si rien ne change : palette, « Developer:
   Reload Window ». Si le terminal affiche une erreur : {ref}`V5 <dep-v5>`.

L'extension y tape tout de même sa commande d'activation, dans un
terminal déjà activé, pour l'environnement choisi comme interpréteur.

:::{note}
Les deux chemins `C:\ProgramData\anaconda3` sont ceux de l'installation
de la salle. Pour les lire sur un poste : menu Démarrer, clic droit sur
« Anaconda Prompt », Ouvrir l'emplacement du fichier, puis clic droit sur
le raccourci, Propriétés, champ Cible. Il contient
`%windir%\System32\cmd.exe "/K" C:\ProgramData\anaconda3\Scripts\activate.bat C:\ProgramData\anaconda3` :
les deux chemins du réglage sont les deux derniers, dans le même ordre.
:::

### Variante : conda chargé par VS Code

Quand `conda init bash` n'est pas possible, VS Code peut charger conda
par ses réglages seuls, sans rien écrire dans le compte. Un profil de terminal
lance bash avec un fichier de démarrage donné en argument, comme le profil
« Anaconda Prompt » lance `cmd` avec `activate.bat`. Ajouter ce profil dans
`terminal.integrated.profiles.windows`, à côté du profil « Anaconda Prompt » :

```json
"Git Bash (Anaconda)": {
  "path": "C:\\Program Files\\Git\\bin\\bash.exe",
  "args": ["-c", "exec bash --rcfile <(echo 'source /etc/profile; cygpath() { /usr/bin/cygpath \"$@\"; }; source /c/ProgramData/anaconda3/etc/profile.d/conda.sh; conda activate base') -i"]
}
```

Le fichier de démarrage lit `/etc/profile`, comme un Git Bash ordinaire
(invite, `PATH`), puis charge `conda.sh` et active `base`. Choisir ce terminal
par la flèche à côté du `+` : l'invite commence par `(base)`, et
`which python` affiche `/c/ProgramData/anaconda3/python`. Ce profil ne lit
ni `~/.bashrc` ni `~/.bash_profile`, et ne vaut que dans VS Code. Avec ces
arguments, VS Code n'y ajoute pas son intégration du terminal (les
marques à gauche des commandes).

La fonction `cygpath() { … }` de ce profil corrige un défaut de
l'installation de la salle, décrit dans {ref}`G7 <dep-g7>`.

### Variante : le profil « Command Prompt »

VS Code a parmi ses profils un `cmd` ordinaire, « Command Prompt », où
l'extension Python tape la commande d'activation à l'ouverture :

```json
"terminal.integrated.defaultProfile.windows": "Command Prompt"
```

Ce profil ne convient que si `conda activate` fonctionne dans un `cmd` ordinaire
du poste. Quand l'extension n'a pas pu lire les informations d'activation de
conda (panneau Output, « Python Environments » : `Conda environment
manager is not available, using default conda activation paths`), elle
tape seulement `conda activate base`, qui affiche `CondaError: Run 'conda
init' before 'conda activate'` si `conda init cmd.exe` n'a jamais été fait
pour le compte ({ref}`V5 <dep-v5>`).

(vscode-liste-interpreteurs)=
## Quand la liste ne montre ni `base` ni les environnements

L'extension construit cette liste en cherchant dans le `PATH` reçu au
lancement de VS Code, le registre de Windows, les installations de python.org
et les dossiers du projet, et en lançant `conda info --envs` quand elle trouve
conda.

Lancé depuis le menu Démarrer, VS Code ne reçoit pas les variables de
l'invite de commandes d'Anaconda ([Variables d'environnement](../notions/variables_environnement.md)).
Il cherche alors `conda` dans une liste de dossiers d'installation
habituels, dont `C:\ProgramData\anaconda3` : sur les postes de la salle,
cette recherche aboutit. Quand Anaconda est installé ailleurs, la liste ne
contient que « Enter interpreter path… » et des Python qui ne sont pas
ceux d'Anaconda ({ref}`V6 <dep-v6>`). Les réglages suivants corrigent ce cas.
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
  le `.vscode\settings.json` d'un TD. Un choix fait ensuite par « Python:
  Select Interpreter » l'emporte sur ce réglage pour ce dossier, et la
  liste propose alors une entrée « Use Python from
  `python.defaultInterpreterPath` setting » pour y revenir. L'extension
  Jupyter propose ce même interpréteur en tête de sa liste de noyaux
  ([Notebooks](vscode_notebooks.md)).

Le plus direct, sans réglage : « Enter interpreter path… », puis taper ou
coller le chemin du fichier `python.exe` de l'environnement voulu, aux chemins
ci-dessus, et appuyer sur Entrée. « Find… » ouvre à la place une fenêtre de
choix, qui n'affiche pas `C:\ProgramData`, un dossier masqué.

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

## Les autres réglages de conda

`python-envs.terminal.autoActivationType`
: `command` par défaut : quand VS Code ouvre un nouveau terminal, l'extension y
  tape la commande d'activation de l'environnement choisi comme interpréteur.
  Dans un `cmd`, elle tape
  `C:\ProgramData\anaconda3\Scripts\activate && conda activate base`, qui
  fonctionne sans que `conda` soit dans le `PATH` et fait apparaître `(base)`
  dans l'invite. Quand l'extension n'a pas pu lire les informations
  d'activation de conda, elle tape seulement `conda activate base`, qui échoue
  dans un `cmd` sans `conda init`. Dans PowerShell, la commande passe par un
  script, `conda-hook.ps1`, refusé par défaut ({ref}`A7 <dep-a7>`). Changer de
  terminal évite ce refus. À `off`, `python` désigne dans le terminal un autre
  Python que celui d'Anaconda. La valeur `shellStartup` modifie les fichiers de
  démarrage du terminal pour qu'il s'active seul, et ne sert pas ici.

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

## Versions

Les noms de commandes et de réglages de cette page ont été vérifiés avec
VS Code 1.137 et l'extension Python 2026.4 (septembre 2026). Ils sont les
mêmes depuis VS Code 1.56 (mai 2021, arrivée des profils de terminal) et
l'extension Python de 2021 ; sur une version plus ancienne, les noms
peuvent différer.

L'extension Python Environments est installée d'office, comme dépendance, et
gère les environnements sans réglage ([Comment VS Code gère les
environnements](../notions/vscode_environnements.md)).

## Source des captures d'écran

Les captures de cette page viennent de la
[documentation de Visual Studio Code](https://code.visualstudio.com/docs)
(Microsoft), publiée sous licence
[Creative Commons Attribution 3.0 US](https://creativecommons.org/licenses/by/3.0/us/).
