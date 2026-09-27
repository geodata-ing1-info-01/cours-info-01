# Configurer l'éditeur de code, et lancer un programme — TD 2a, cours 1

Le sujet du TD est l'éditeur : le lancer, l'équiper de l'extension du
langage, lui désigner l'interpréteur Python, savoir où sont ses commandes et
ses réglages, puis exécuter un programme de trois façons. Les deux programmes du
dossier sont volontairement minuscules : ce qui compte est ce qu'il faut faire
pour les lancer.

| Fichier | Rôle |
|---|---|
| `bonjour.py` | affiche une phrase, trois lignes |
| `altitudes.py` | une moyenne de trois altitudes, à exécuter en entier, puis ligne à ligne, puis pas à pas |

Ces fichiers sont versionnés, contrairement aux données dérivées du dépôt : ce
sont des sources de quelques lignes. Le TD 2c, facultatif, refait le hello
world en C++ dans [`../2c_hello_cpp/`](../2c_hello_cpp/).

## Sur les postes de la salle

Les postes sont des machines virtuelles Windows avec Anaconda. VS Code s'y
lance de deux façons, et ce n'est pas indifférent :

- **Depuis Anaconda Navigator** (fiche VS Code, après avoir vérifié
  l'environnement affiché en haut de la page d'accueil) : VS Code part dans cet environnement et
  le terminal intégré trouve le bon `python`. C'est la voie du TD.
- **Depuis le bureau** : VS Code ouvre un terminal PowerShell, dont la
  stratégie d'exécution refuse le script d'activation de l'environnement
  (`activate.ps1 cannot be loaded because running scripts is disabled on this
  system`). Sans droits d'administrateur, la solution est de donner à VS Code
  le terminal de l'invite de commandes d'Anaconda, un `cmd` qui lance `activate.bat` :

  ```json
  "terminal.integrated.profiles.windows": {
    "Anaconda Prompt": {
      "path": "C:\\Windows\\System32\\cmd.exe",
      "args": ["/K", "C:\\ProgramData\\anaconda3\\Scripts\\activate.bat", "C:\\ProgramData\\anaconda3"]
    }
  },
  "terminal.integrated.defaultProfile.windows": "Anaconda Prompt"
  ```

  dans les réglages User (palette, « Open User Settings (JSON) »). Les deux
  chemins d'Anaconda se lisent dans la cible du raccourci « Anaconda Prompt »
  du menu Démarrer (clic droit → Propriétés). Détail des autres solutions,
  et de ce qui les limite, dans les notes de la diapositive « VS Code hors
  Anaconda : changer de terminal » et dans l'issue
  [vscode-python #2559](https://github.com/microsoft/vscode-python/issues/2559).

## Déroulé, étape par étape

1. **Fichier → Ouvrir le dossier**, puis choisir `cours1/2a_vscode_python/`.
   On ouvre le dossier, pas un fichier : c'est lui qui devient le projet.
2. **`Ctrl` + `Maj` + `X`**, chercher `ms-python.python`, installer.
3. **`Ctrl` + `Maj` + `P`**, taper « Python: Select Interpreter », choisir
   l'interpréteur d'Anaconda. Le réglage sert au terminal ouvert à l'étape
   suivante.
4. **Terminal → Nouveau terminal.** Il s'ouvre en bas, déjà placé dans
   `2a_vscode_python/`, et son invite commence par `(base)`.
5. Taper `python altitudes.py`, puis Entrée. La moyenne s'affiche, et rien
   n'apparaît dans l'arborescence : lancer un programme Python ne laisse rien
   sur le disque. Le bouton d'exécution et le menu Run → Run Without Debugging
   font la même chose, en écrivant la commande dans le terminal.
6. Taper `python`, puis les lignes d'`altitudes.py` une à une : la session
   interactive affiche chaque résultat. `exit()` pour sortir.
7. Ouvrir `altitudes.py`, cliquer dans la marge de la ligne 4, `F5`, « Python
   Debugger » puis « Python File » : le programme s'arrête ligne 4. `F10`
   trois fois en lisant `total` dans le panneau Variables, puis `F5`.

En option, sans VS Code : invite de commandes d'Anaconda, `cd` sur le dossier (le glisser
dans la fenêtre colle son chemin), puis les mêmes commandes, ce que l'éditeur
faisait à votre place.

## Ce que le TD montre

La palette de commandes (`Ctrl` + `Maj` + `P`) et les réglages (`Ctrl` + `,`)
sont les deux outils qui rendent l'éditeur apprenable : on tape ce qu'on
cherche. Les réglages sont un fichier texte, `settings.json`, à deux niveaux :
User, pour soi sur ce poste, et Workspace, rangé avec le projet dans
`.vscode/settings.json`.
