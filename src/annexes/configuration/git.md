---
title: Git et Git Bash
subtitle: Ouvrir Git Bash, y avoir conda, régler git, et les solutions de secours quand Git Bash n'est pas installé
---

Git Bash est le terminal du module, à partir du [TD
1b](../../cours1_v2/notebook/td/1b_terminal/guide.md). Le module y emploie les
commandes git (`git init`, `add`, `commit`, `status`, `log`, `diff`,
`branch`, `merge`, `restore`…) et les commandes unix des diapositives
(`ls`, `cd`, `pwd`, `cp`, `mv`, `rm`, `touch`, `mkdir`). Sous Windows, les
deux viennent d'un seul logiciel, Git for Windows, qui contient git, bash et
ces commandes ([Git Bash : une fenêtre, bash et des
programmes](../notions/git_bash.md)). Git for Windows est installé sur les
postes de la salle, dans `C:\Program Files\Git`.

Cette page décrit Git Bash hors de VS Code. Le terminal Git Bash et le
panneau de git dans VS Code sont décrits dans {ref}`VS Code, section Git
dans VS Code <vscode-git>`.

## Ouvrir Git Bash

Git Bash s'ouvre depuis l'explorateur ou depuis le menu Démarrer :

- dans l'explorateur, ouvrir le dossier de travail, clic droit sur un
  endroit vide de la fenêtre, « Afficher d'autres options » sous
  Windows 11, puis « Open Git Bash here ». Le dossier courant de Git Bash
  est alors ce dossier ;
- menu Démarrer, taper `git bash`, Entrée. Le dossier courant est le
  dossier personnel, `~`.

## Vérifier

1. Lire l'invite : `eleve@POSTE MINGW64 ~/Desktop/info01`, puis `$`. Si elle se
   termine par `>`, la fenêtre ouverte est un `cmd`.
2. Taper `git --version`. La commande affiche `git version 2.xx.x.windows.x`.
   Sinon : {ref}`G1 <dep-g1>`.
3. Dans le dossier d'une séance, taper `ls -a`. La commande liste les fichiers,
   avec `.` et `..`. Si `ls` n'est pas reconnu, la fenêtre n'est pas Git Bash.

(conda-git-bash)=
## conda dans Git Bash

Dans un Git Bash qui n'a pas été configuré, `conda` n'est pas reconnu,
et `python` lance un autre Python que celui d'Anaconda, ou aucun. Le [TD
1c](../../cours1_v2/notebook/td/1c_programme/guide.md) fait cette
configuration. Taper une fois ces commandes dans Git Bash :

```text
source /c/ProgramData/anaconda3/etc/profile.d/conda.sh
conda init bash
```

`source` exécute le script `conda.sh` dans le terminal ouvert, ce qui y
définit la commande `conda`. `conda init bash` écrit une instruction
équivalente dans le fichier `~/.bash_profile`, que Git Bash lit à chaque
ouverture. Il affiche une ligne par fichier examiné, `no change` ou
`modified`. Fermer ensuite Git Bash, puis le rouvrir.

1. Ouvrir Git Bash. L'invite commence par `(base)`.
2. Taper `which python`. La commande affiche `/c/ProgramData/anaconda3/python`.
3. Taper `conda --version`. La commande affiche `conda 25.x` ou `conda 24.x`.

Si l'une de ces vérifications échoue : {ref}`G4 <dep-g4>`. Si un message
d'erreur s'affiche :

- `source` affiche `No such file or directory` : {ref}`G5 <dep-g5>`.
- `conda init bash` écrit `needs sudo`, ou Windows demande des droits
  d'administrateur : {ref}`G6 <dep-g6>`.
- Chaque nouveau Git Bash affiche l'aide de `cygpath` : {ref}`G7 <dep-g7>`.

Le réglage est écrit dans le dossier personnel du compte. Il reste d'une
séance à l'autre sur le même poste, et se refait sur un autre poste. Il
vaut aussi pour le Git Bash ouvert dans VS Code, qui lit le même fichier
({ref}`VS Code, section Git dans VS Code <vscode-git>`).

## Le nom et l'adresse des commits

Chaque commit porte un nom et une adresse ({ref}`G2 <dep-g2>`). Sur un
poste de la salle, le compte Windows est commun : un réglage
`git config --global` s'écrit dans `C:\Users\eleve\.gitconfig` et reste
pour l'élève suivant. Après `git init`, régler le nom et l'adresse dans le
dépôt, sans `--global` :

```
git config user.name "Prénom Nom"
git config user.email "prenom.nom@exemple.fr"
```

`git config user.name`, sans valeur, affiche ce qui est enregistré pour ce
dépôt.

## L'éditeur ouvert par git

`git merge` et `git commit` sans `-m` ouvrent un éditeur dans le terminal
pour le message. Git for Windows ouvre vim. Taper le message, puis `Échap`,
`:wq`, `Entrée` pour enregistrer et quitter. Pour utiliser VS Code à la place,
si la commande `code` fonctionne dans le terminal :

```
git config --global core.editor "code --wait"
```

## Si Git Bash n'est pas installé

Sans Git for Windows, Cmder, git par conda et Git for Windows portable donnent
le même git, le même bash et les mêmes commandes unix, sans droits
d'administrateur. Employer Cmder s'il est là. Sinon, git par conda demande le
réseau à la création, et l'archive portable n'en demande pas.

### Avec Cmder

Cmder est une console portable (ConEmu + `cmd` + clink) qui embarque Git for
Windows, dans `<Cmder>\vendor\git-for-windows\`. Il est déjà sur les postes
[à vérifier : édition complète ou mini].

Lancer `Cmder.exe`. L'onglet qui s'ouvre est un `cmd`, où `git` et les
commandes unix fonctionnent déjà, parce que Cmder les ajoute au PATH au
démarrage. Pour bash, avec l'invite des diapositives : bouton `+` en bas de
la fenêtre (ou `Ctrl` + `T`), puis la tâche `{bash::bash}`.

Pour savoir si le Cmder d'un poste est l'édition complète, vérifier que le dossier
`vendor\git-for-windows` existe dans son dossier, et que `git --version`, tapé
dans Cmder, affiche `git version 2.45.1.windows.1`. L'édition mini n'a ni
l'un ni l'autre.

### Avec git par conda

Le paquet `git` de conda-forge contient Git for Windows, décompressé dans
`C:\Users\<nom>\.conda\envs\outils\Library\` (124 Mo).

Une fois par compte, dans l'invite de commandes d'Anaconda, session réseau ouverte :

```
conda create -n outils -c conda-forge git
```

Puis, à chaque séance, dans l'invite de commandes d'Anaconda :

```
conda activate outils
```

L'invite passe à `(outils)`. `git`, `ls`, `cp`, `rm`, `touch`, `pwd` y
fonctionnent, car l'activation met `Library\bin` et `Library\usr\bin` de
l'environnement dans le PATH. Pour bash lui-même, dans cette fenêtre :

```
bash --login -i
```

Le paquet ajoute aussi un raccourci « Git Bash » au menu Démarrer [à
vérifier : nom exact sur les postes], qui ouvre bash directement.

### Avec Git for Windows portable

1. Dans `formationTemp`, copier `PortableGit-2.55.0.5-64-bit.7z.exe` (un seul
   fichier, 59 Mo) dans `Desktop\info01\outils\`.
2. Double-cliquer sur ce fichier. Une fenêtre demande le dossier de destination :
   laisser `…\outils\PortableGit`, puis OK. Si le poste refuse de lancer ce
   fichier [à vérifier], copier à la place le dossier `PortableGit` déjà
   décompressé, déposé dans `formationTemp`.
3. Double-cliquer sur `PortableGit\git-bash.exe` pour ouvrir Git Bash.

`git-cmd.exe`, à côté, ouvre un `cmd` avec les mêmes commandes.

## Documentation officielle

- [Git for Windows](https://gitforwindows.org) (en anglais) : l'installateur,
  l'archive portable et MinGit sont sur la
  [page des versions](https://github.com/git-for-windows/git/releases/latest).
- [Cmder](https://github.com/cmderdev/cmder#readme) (en anglais) : les deux
  éditions, et l'intégration à VS Code dans le wiki.
- [Pro Git, chapitre « Démarrage rapide »](https://git-scm.com/book/fr/v2/D%C3%A9marrage-rapide-Installation-de-Git)
  (en français) : l'installation de git sur les trois systèmes.
