---
title: Git et Git Bash
subtitle: Ouvrir Git Bash, y avoir conda, régler git, et les solutions de secours quand Git Bash n'est pas installé
---

Le cours 2 se fait dans un terminal bash. Il y faut deux choses : les
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

Git Bash s'ouvre de deux façons :

- dans l'explorateur, ouvrir le dossier de travail, clic droit sur un
  endroit vide de la fenêtre, « Afficher d'autres options » sous
  Windows 11, puis « Open Git Bash here ». Le dossier courant de Git Bash
  est alors ce dossier ;
- menu Démarrer, taper `git bash`, Entrée. Le dossier courant est le
  dossier personnel, `~`.

## Vérifier

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Taper `git --version` | `git version 2.xx.x.windows.x` | {ref}`G1 <dep-g1>` |
| Taper `ls -a` dans le dossier d'une séance | la liste des fichiers, `.` et `..` compris | le terminal n'est pas celui de cette page |
| Dans bash, l'invite | `eleve@POSTE MINGW64 ~/Desktop/info01 $` ; `$` en fin de ligne | l'onglet ouvert est un `cmd` |

## conda dans Git Bash

Git Bash ne connaît pas la commande `conda` à son ouverture. La
configuration, à faire une fois par `conda init bash`, est décrite dans
{ref}`Anaconda, section Git Bash <conda-git-bash>`.

## Le nom et l'adresse des commits

Chaque commit porte un nom et une adresse ({ref}`G2 <dep-g2>`). Sur un
poste de la salle, le compte Windows est commun : un réglage
`git config --global` s'écrit dans `C:\Users\eleve\.gitconfig` et reste
pour l'élève suivant. Régler plutôt dans le dépôt, après `git init`, sans
`--global` :

```
git config user.name "Prénom Nom"
git config user.email "prenom.nom@exemple.fr"
```

`git config user.name`, sans valeur, affiche ce qui est enregistré pour ce
dépôt.

## L'éditeur ouvert par git

`git merge` et `git commit` sans `-m` ouvrent un éditeur dans le terminal
pour le message. Avec Git for Windows, c'est vim : taper le message, puis
`Échap`, `:wq`, `Entrée` pour enregistrer et quitter. Pour
utiliser VS Code à la place, quand `code` répond dans le terminal :

```
git config --global core.editor "code --wait"
```

## Si Git Bash n'est pas installé

Sans Git for Windows, trois solutions donnent le même git, le même bash et
les mêmes commandes unix, sans droits d'administrateur :

| | Cmder, édition complète | git par conda | Git for Windows portable |
|---|---|---|---|
| Ce que c'est | une console portable (ConEmu + `cmd` + clink) qui embarque Git for Windows | le paquet `git` de conda-forge : Git for Windows décompressé dans `Library\` de l'environnement | l'archive `PortableGit-….7z.exe` de Git for Windows, sans installateur |
| Comment on l'a | déjà sur les postes [à vérifier : édition complète ou mini] | `conda create -n outils -c conda-forge git` dans l'invite de commandes d'Anaconda, session réseau ouverte (124 Mo) | copiée depuis `formationTemp` dans `Desktop\info01\outils\`, comme les fichiers d'une séance |
| Où sont les fichiers | `<Cmder>\vendor\git-for-windows\` | `C:\Users\<nom>\.conda\envs\outils\Library\` | `<dossier>\PortableGit\` |
| Il faut le réseau | non | oui, à la création | non |

Cmder s'emploie s'il est là. Sinon, git par conda demande le réseau à la
création, et l'archive portable n'en demande pas.

### Avec Cmder

Lancer `Cmder.exe`. L'onglet qui s'ouvre est un `cmd` ; `git` et les
commandes unix y répondent déjà, parce que Cmder les ajoute au PATH au
démarrage. Pour bash, avec l'invite des diapositives : bouton `+` en bas de
la fenêtre (ou `Ctrl` + `T`), puis la tâche `{bash::bash}`.

Pour savoir si le Cmder d'un poste est l'édition complète, vérifier que le dossier
`vendor\git-for-windows` existe dans son dossier, et `git --version` tapé
dans Cmder répond `git version 2.45.1.windows.1`. L'édition mini n'a ni
l'un ni l'autre.

### Avec git par conda

Une fois par compte, dans l'invite de commandes d'Anaconda, session réseau ouverte :

```
conda create -n outils -c conda-forge git
```

Puis, à chaque séance, dans l'invite de commandes d'Anaconda :

```
conda activate outils
```

L'invite passe à `(outils)`. `git`, `ls`, `cp`, `rm`, `touch`, `pwd` y
répondent : l'activation met `Library\bin` et `Library\usr\bin` de
l'environnement dans le PATH. Pour bash lui-même, dans cette fenêtre :

```
bash --login -i
```

Le paquet ajoute aussi un raccourci « Git Bash » au menu Démarrer [à
vérifier : nom exact sur les postes], qui ouvre bash directement.

### Avec Git for Windows portable

Dans `formationTemp`, copier `PortableGit-2.55.0.5-64-bit.7z.exe` (un seul
fichier, 59 Mo) dans `Desktop\info01\outils\`, puis double-cliquer : une
fenêtre demande le dossier de destination ; laisser
`…\outils\PortableGit`, OK. Si le poste refuse de lancer ce fichier [à
vérifier], copier à la place le dossier `PortableGit` déjà décompressé,
déposé dans `formationTemp`.

Ensuite, double-clic sur `PortableGit\git-bash.exe` : la fenêtre Git Bash.
`git-cmd.exe`, à côté, ouvre un `cmd` avec les mêmes commandes.

## Documentation officielle

- [Git for Windows](https://gitforwindows.org) (en anglais) : l'installateur,
  l'archive portable et MinGit sont sur la
  [page des versions](https://github.com/git-for-windows/git/releases/latest).
- [Cmder](https://github.com/cmderdev/cmder#readme) (en anglais) : les deux
  éditions, et l'intégration à VS Code dans le wiki.
- [Pro Git, chapitre « Démarrage rapide »](https://git-scm.com/book/fr/v2/D%C3%A9marrage-rapide-Installation-de-Git)
  (en français) : l'installation de git sur les trois systèmes.
