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

Les versions vérifiées sont en fin de page.

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
   montre pas `base` : {ref}`V6 <dep-v6>`.

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
Dans un dossier ouvert ensuite, le réglage `python.defaultInterpreterPath` du
compte désigne `base` ([Fichiers de réglages](vscode_reglages.md)).

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
([Git et Git Bash](git.md)).

Palette, « Terminal: Select Default Profile », puis « Git Bash » (s'il est
absent : {ref}`V12 <dep-v12>`). Ce choix est écrit dans les réglages du compte
({ref}`VS Code, section Les réglages <vscode-reglages>`) :

```json
"terminal.integrated.defaultProfile.windows": "Git Bash"
```

Le fichier complet est dans [Fichiers de réglages](vscode_reglages.md). Le
terminal de VS Code lit le même `~/.bash_profile` que la fenêtre Git Bash, où
`conda init bash` a écrit ({ref}`Anaconda, section conda dans un terminal
<conda-terminal>`) : l'invite commence donc par `(base)`.

## Vérifier

1. Menu Terminal, New Terminal. L'invite commence par `(base)` et se termine par
   `$`. Sans `(base)` : {ref}`A3 <dep-a3>`. Si une erreur s'affiche :
   {ref}`V5 <dep-v5>`.
2. Dans ce terminal, taper `python -c "import sys; print(sys.executable)"`. Le
   chemin d'Anaconda s'affiche. Sinon : {ref}`A16 <dep-a16>`.
3. Ouvrir un fichier `.py`, puis cliquer sur le triangle en haut à droite. Le
   terminal affiche ce que le programme écrit. Sinon : {ref}`V8 <dep-v8>`.

Le chemin affiché dans le terminal doit être celui de l'interpréteur choisi. Si
un `import` échoue alors que le paquet est installé, ces deux Python diffèrent
souvent ({ref}`V8 <dep-v8>`).

## Secours : l'invite de commandes d'Anaconda

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
