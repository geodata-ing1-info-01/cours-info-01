---
title: Installation sur un ordinateur personnel
subtitle: Installer les mêmes outils chez soi
---

Les pages précédentes décrivent les postes de la salle. Sur un ordinateur
personnel, on a les droits d'administrateur, il n'y a pas de session réseau
à ouvrir, et le système peut être Windows, macOS ou Linux. Cette page
donne, dans l'ordre, ce qu'il faut installer et ce qui change.

## Anaconda

Télécharger l'installateur sur <https://www.anaconda.com/download> et le
lancer avec les options proposées par défaut. Sous Windows, choisir
« Just Me » : Anaconda s'installe alors dans `C:\Users\<nom>\anaconda3`,
sans droits d'administrateur.

Vérifier ensuite comme sur les postes de la salle
([Anaconda, JupyterLab et VS Code](../avant/python.md)) : sous Windows, dans l'Anaconda
Prompt ; sous macOS et Linux, dans le Terminal, où l'invite commence par
`(base)` dès l'installation.

Même règle que dans la salle : on n'installe rien dans `base`. Chaque
projet a son environnement (`conda create -n <nom> -c conda-forge …`).
Ce n'est pas obligatoire chez soi, mais c'est ce qui évite de casser
l'installation.

## JupyterLab

Rien à installer : il est livré avec Anaconda. Le test est le même
([JupyterLab](configuration/jupyterlab.md)).

## VS Code

Télécharger sur <https://code.visualstudio.com>. Sous Windows, prendre le
« User Installer » : il s'installe dans le profil, sans droits
d'administrateur. Puis suivre [VS Code](configuration/vscode.md) et [Python et environnement
conda](configuration/vscode_python.md).

Le réglage du terminal change :

- sous macOS et Linux, rien à faire : le terminal de VS Code active
  l'environnement sans problème ;
- sous Windows, VS Code ouvre un PowerShell. Si le message
  `activate.ps1 cannot be loaded because running scripts is disabled`
  apparaît ({ref}`A7 <dep-a7>`), ouvrir un PowerShell (menu Démarrer,
  taper `powershell`) et taper une fois :

  ```
  Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
  ```

  puis rouvrir le terminal de VS Code. Cette commande ne demande pas de
  droits d'administrateur. Les réglages de terminal de la salle
  ([Fichiers de réglages](configuration/vscode_reglages.md)) fonctionnent
  aussi : `Command Prompt` tel quel, la variante « Anaconda Prompt » en
  remplaçant `C:\ProgramData\anaconda3` par `C:\Users\<nom>\anaconda3`.

Pour que `conda` réponde dans tous les terminaux de Windows, et pas
seulement dans l'Anaconda Prompt, taper une fois dans l'Anaconda Prompt
`conda init cmd.exe` (pour `cmd`) ou `conda init powershell` (pour
PowerShell, après la commande ci-dessus), puis rouvrir le terminal.

Sous Windows, si `python` répond « Python n'a pas été trouvé ; exécutez
sans arguments pour l'installer à partir du Microsoft Store »
({ref}`V7 <dep-v7>`) : Paramètres, Applications, Paramètres avancés des
applications, Alias d'exécution d'application, et désactiver `python.exe`
et `python3.exe`.

## git (séance 2)

Windows : <https://git-scm.com>, options par défaut. macOS : taper `git`
dans le Terminal ; s'il manque, macOS propose de l'installer. Linux : le
paquet `git` de la distribution. Dans tous les cas, `conda install -c
conda-forge git` dans un environnement fonctionne aussi. Ce que VS Code
fait de git, et le terminal à ouvrir pour le cours 2, sont dans [Git et
Git Bash](configuration/git.md).

## Éditeurs et bureautique

Notepad++ (Windows seulement) : <https://notepad-plus-plus.org>.
LibreOffice : <https://fr.libreoffice.org>. Sous macOS, TextEdit remplace
le Bloc-notes, à condition de le passer en texte brut (menu Format,
Convertir au format Texte).
