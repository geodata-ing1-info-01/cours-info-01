---
title: Anaconda
subtitle: La distribution Python, conda dans un terminal, les environnements et les dépôts, Anaconda Navigator
---

Anaconda est une distribution Python : un ensemble qui réunit Python, des
centaines de bibliothèques déjà installées, l'outil `conda` qui gère les
environnements, et des applications (Anaconda Navigator, Spyder,
JupyterLab). Sur les postes de la salle, il est installé pour tous les
utilisateurs, dans `C:\ProgramData\anaconda3`.

On se sert d'Anaconda de deux façons : en ligne de commande, avec la
commande `conda` et le Python de la distribution tapés dans un terminal, ou
par Anaconda Navigator, une interface graphique qui lance les
applications. Le module emploie surtout la ligne de commande, et se sert de
Navigator en secours. Le test des deux est dans [Anaconda et
JupyterLab](../../avant/python.md).

(conda-terminal)=
## conda dans un terminal

Un terminal ordinaire ne connaît ni la commande `conda` ni le Python
d'Anaconda. Dans un `cmd` ouvert depuis le menu Démarrer, ou dans un Git
Bash qui n'a pas été configuré, `conda` n'est pas reconnu
({ref}`A2 <dep-a2>`), et `python` désigne un autre Python, ou aucun.

Il faut d'abord activer un environnement dans le terminal. Un script
d'Anaconda ajoute les dossiers de l'environnement en tête de la variable
`PATH`, et le terminal y trouve ensuite `conda`, `python` et les autres
programmes de l'environnement. La variable `PATH` est expliquée dans
[Variables d'environnement et recherche des
programmes](../notions/variables_environnement.md), et le contenu des
scripts d'activation dans [Les environnements
conda](../notions/environnements.md).

Chaque interpréteur de commandes a son script d'activation, dans le dossier
d'Anaconda :

| Terminal | Script d'activation | Mise en place |
|---|---|---|
| Invite de commandes d'Anaconda (`cmd`) | `Scripts\activate.bat` | faite par le raccourci du menu Démarrer |
| Git Bash (`bash`) | `etc/profile.d/conda.sh` | par `conda init bash`, une fois sur le poste |
| PowerShell | `shell\condabin\conda-hook.ps1` | bloquée sur les postes de la salle ({ref}`A7 <dep-a7>`) |

### L'invite de commandes d'Anaconda

Menu Démarrer, taper `anaconda`, choisir « Anaconda Prompt », le nom
anglais de l'invite de commandes d'Anaconda. Une fenêtre noire s'ouvre tout
de suite. La ligne qui attend une commande s'appelle
l'invite ; elle commence par `(base)`, le nom de l'environnement actif, puis
le dossier courant.

```{figure} menu_demarrer_anaconda.svg
:alt: Le menu Démarrer après avoir tapé anaconda, avec Navigator, Prompt et Spyder dans la liste
:width: 100%

Le menu Démarrer, après avoir tapé `anaconda`.
```

```{figure} ../../avant/anaconda_prompt.svg
:alt: La fenêtre de l'invite de commandes d'Anaconda, avec une commande tapée et sa réponse
:width: 100%

Une commande tapée dans l'invite de commandes d'Anaconda, et sa réponse.
```

Le raccourci ouvre un `cmd` et y exécute `activate.bat`
([Les terminaux en ligne de commande](../notions/terminaux.md)). L'invite
de commandes d'Anaconda fonctionne donc sans réglage.

| Ce qu'on tape | Ce qu'on doit voir |
|---|---|
| `conda --version` | `conda 25.x` ou `conda 24.x` |
| `where python` | en première ligne, `C:\ProgramData\anaconda3\python.exe` |

(conda-git-bash)=
### Git Bash

Git Bash est le terminal du module à partir du [TD 2a du cours
1](../../cours1_v2/notebook/td/2a_terminal/guide.md), qui fait cette
configuration. À son ouverture, Git Bash ne connaît pas conda. Deux
commandes, tapées une fois dans Git Bash, le configurent :

```text
source /c/ProgramData/anaconda3/etc/profile.d/conda.sh
conda init bash
```

`source` exécute le script `conda.sh` dans le terminal ouvert, ce qui y
définit la commande `conda`. `conda init bash` écrit une instruction
équivalente dans le fichier `~/.bash_profile`, que Git Bash lit à chaque
ouverture. Il affiche une ligne par fichier examiné, `no change` ou
`modified`. Fermer ensuite Git Bash, puis le rouvrir.

| Ce qu'on fait | Ce qu'on doit voir |
|---|---|
| Ouvrir Git Bash | l'invite commence par `(base)` |
| Taper `which python` | `/c/ProgramData/anaconda3/python` |
| Taper `conda --version` | `conda 25.x` ou `conda 24.x` |

Le réglage est écrit dans le dossier personnel du compte. Il reste d'une
séance à l'autre sur le même poste, et se refait sur un autre poste. Il
vaut aussi pour le Git Bash ouvert dans VS Code, qui lit le même fichier
([Git et Git Bash](git.md)).

Quand la configuration échoue :

`source` affiche `No such file or directory`
: Anaconda est installé dans un autre dossier. Sur un ordinateur
  personnel, essayer `source /c/Users/$USERNAME/anaconda3/etc/profile.d/conda.sh`,
  ou `source ~/miniforge3/etc/profile.d/conda.sh` avec Miniforge
  ([Python et conda](../poste_personnel/conda.md)).

`conda init bash` écrit `needs sudo`, ou Windows demande des droits d'administrateur
: Refuser, puis écrire la ligne à la main dans `~/.bash_profile`, et
  rouvrir Git Bash :

  ```text
  echo 'eval "$(/c/ProgramData/anaconda3/Scripts/conda.exe shell.bash hook)"' >> ~/.bash_profile
  ```

Chaque nouveau Git Bash affiche l'aide de `cygpath` (`Usage: cygpath …`), puis `bash: : No such file or directory`
: Anaconda fournit son propre `cygpath`, dans
  `C:\ProgramData\anaconda3\Library\usr\bin`, qui échoue sous Git Bash ;
  une fois `base` activé, ce dossier passe avant ceux de Git dans le `PATH`.
  L'environnement est activé, mais le script d'OpenSSL d'Anaconda n'est pas
  chargé, et `SSL_CERT_FILE` n'est pas posée. Taper une fois la commande
  suivante, puis rouvrir Git Bash :

  ```text
  sed -i '1i cygpath() { /usr/bin/cygpath "$@"; }' ~/.bash_profile
  ```

  Elle ajoute en tête de `~/.bash_profile` une fonction `cygpath`, qui passe
  avant le `PATH` et appelle toujours celui de Git.

## Les environnements

Un environnement est un dossier qui contient un Python et les paquets
installés avec lui. `base` est celui d'Anaconda. Sur les postes de la
salle, son dossier n'est pas modifiable par un compte élève : on n'y
installe rien. Chaque TD qui a besoin d'un paquet crée son propre
environnement, qui va dans `C:\Users\<nom>\.conda\envs`. Le TD 4a fait
créer le premier ; les commandes, dans l'invite de commandes d'Anaconda :

```
conda create -n recette -c conda-forge python pandoc
conda activate recette
conda env list
conda list -n recette
```

Dans l'ordre : créer l'environnement `recette` avec Python et pandoc, pris
sur le canal conda-forge ; l'activer (l'invite passe à `(recette)`) ; lister
les environnements connus ; lister les paquets de `recette`. Ce que
change l'activation est expliqué dans
[Les environnements conda](../notions/environnements.md).

Une application lancée depuis un terminal est cherchée dans
l'environnement actif, et démarre avec lui. Navigator fait de même avec
l'environnement choisi en haut de sa page. Le lancement de chaque
application est décrit dans sa page : [JupyterLab](jupyterlab.md),
[Spyder](spyder.md), [VS Code](vscode.md).

(config-depots)=
## Configuration des dépôts

Un paquet installé par conda vient d'un dépôt, un serveur qui en tient
des milliers à disposition. conda appelle ces dépôts des canaux
(*channels*). Il en existe plusieurs : `conda-forge`, tenu par une
communauté, où chaque paquet entre après relecture d'une recette ; les
canaux d'Anaconda (`defaults`, c'est-à-dire `pkgs/main` et `pkgs/r`),
tenus par l'entreprise, avec des conditions d'utilisation ; et PyPI, le
dépôt de `pip`, que conda n'emploie pas. Le réglage des canaux dit à conda
où chercher, et dans quel ordre.

```{figure} ../schemas/depots.svg
:alt: Un environnement conda sur la machine, et deux dépôts à distance, PyPI et conda-forge ; une flèche va de conda-forge vers l'environnement
:width: 100%

Un environnement, et les dépôts d'où viennent ses paquets (schéma du
cours 1).
```

Le module prend ses paquets sur conda-forge, d'où le `-c conda-forge` des
commandes. Deux réglages, à faire une fois par compte dans l'Anaconda
Prompt, rendent ce choix permanent et évitent les questions que conda
pose sinon.

### Canal conda-forge par défaut

Écrire dans le fichier `C:\Users\<nom>\.condarc` (le créer avec le
Bloc-notes s'il n'existe pas ; le nom commence par un point et n'a pas
d'extension) :

```yaml
channels:
  - conda-forge
channel_priority: strict
```

Avec ce fichier, `conda create -n recette python pandoc` prend tout sur
conda-forge, sans `-c`, et les canaux d'Anaconda ne sont plus consultés,
y compris quand c'est VS Code qui lance `conda create`
([Comment VS Code gère les environnements](../notions/vscode_environnements.md)).
Vérifier : `conda config --show channels` affiche `conda-forge` seul.

### Conditions d'utilisation des canaux d'Anaconda

Depuis Anaconda 2025.06, conda demande une fois par compte d'accepter
les conditions d'utilisation des canaux d'Anaconda avant de s'en servir
({ref}`A10 <dep-a10>`). La question n'est posée que dans un terminal ;
lancé par VS Code, conda ne peut pas la poser et échoue. Faire le test une
fois, dans l'invite de commandes d'Anaconda :

```
conda tos
```

La réponse est un tableau des canaux avec, pour chacun, accepté ou non.
S'il reste des canaux non acceptés et qu'on compte s'en servir :

```
conda tos accept
```

Avec le fichier `.condarc` ci-dessus, les canaux d'Anaconda ne sont plus
consultés et la question ne se pose plus.

## Anaconda Navigator

Anaconda Navigator est une interface graphique qui lance les applications
d'Anaconda. Menu Démarrer, taper `anaconda`, choisir « Anaconda
Navigator ».

Après le chargement (jusqu'à deux minutes la première fois), la page
d'accueil affiche une fiche par application. En haut, une liste déroulante
indique l'environnement actif, `base (root)`.

```{figure} navigator_accueil.svg
:alt: La page d'accueil d'Anaconda Navigator, avec la liste des environnements et une fiche par application
:width: 100%

La page d'accueil d'Anaconda Navigator.
```

Le bouton Launch d'une fiche lance l'application dans l'environnement
affiché en haut. Quand Navigator est lent ou ne s'ouvre pas
({ref}`A4 <dep-a4>`, {ref}`A5 <dep-a5>`), chaque application se lance
aussi depuis un terminal, comme l'indique sa page.

## Documentation officielle

- Anaconda Navigator : [Getting started with Navigator](https://www.anaconda.com/docs/tools/anaconda-navigator/getting-started)
  (en anglais).
- Invite de commandes d'Anaconda et conda : [Getting started with conda](https://docs.conda.io/projects/conda/en/stable/user-guide/getting-started.html)
  (en anglais).

## Fichiers utiles

| Quoi | Où |
|---|---|
| Installation | `C:\ProgramData\anaconda3` |
| Python de `base` | `C:\ProgramData\anaconda3\python.exe` |
| Script qu'exécute l'invite de commandes d'Anaconda | `C:\ProgramData\anaconda3\Scripts\activate.bat` |
| Environnements créés par le compte | `C:\Users\<nom>\.conda\envs` |
| Liste des environnements connus | `C:\Users\<nom>\.conda\environments.txt` |
| Réglages de conda pour le compte (canaux) | `C:\Users\<nom>\.condarc` |
| Réglages et journaux de Navigator | `C:\Users\<nom>\.anaconda\navigator` et `C:\Users\<nom>\AppData\Roaming\.anaconda\navigator` |

`conda info`, dans l'invite de commandes d'Anaconda, affiche ces chemins tels que conda
les voit.
