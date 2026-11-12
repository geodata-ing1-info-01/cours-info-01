---
title: Problèmes avec git et Git Bash
subtitle: Git Bash à partir de la séance 1, git à partir de la séance 2
---

L'ouverture et la configuration de Git Bash sont dans [Git et Git
Bash](../configuration/git.md).

(dep-git)=
## Problèmes avec git

(dep-g1)=
### G1. « 'git' n'est pas reconnu en tant que commande interne ou externe »

Ce qu'on voit
: Ce message dans le terminal. Dans VS Code : « Git not found. Install it
  or configure it using the 'git.path' setting ».

Vérifier
: Dans un `cmd`, `dir "C:\Program Files\Git\cmd\git.exe"` puis
  `dir "%LOCALAPPDATA%\Programs\Git\cmd\git.exe"`.

Solution
: Si l'un des deux fichiers existe : dans VS Code, palette, « Preferences:
  Open Settings (UI) », chercher `git.path` et y écrire ce chemin. Si aucun
  n'existe, git s'obtient sans droits d'administrateur avec Cmder, un
  environnement conda (`conda create -n outils -c conda-forge git`) ou l'archive
  portable de Git for Windows : [Git et Git Bash](../configuration/git.md). Le
  `git.path` de chacune est dans {ref}`VS Code, section Git dans VS Code
  <vscode-git>`.

(dep-g2)=
### G2. « Author identity unknown » au premier commit

Ce qu'on voit
: `Author identity unknown *** Please tell me who you are.`, suivi des deux
  commandes à taper.

Cause
: Chaque commit porte un nom et une adresse, qui ne sont pas encore réglés.

Solution
: Dans le terminal, dans le dossier du dépôt :

  ```
  git config user.name "Prénom Nom"
  git config user.email "prenom.nom@exemple.fr"
  ```

  Sans `--global`, le réglage ne vaut que pour ce dépôt. Sur un poste de la
  salle, dont le compte Windows est commun à plusieurs élèves, il ne reste
  donc pas pour l'élève suivant ([Git et Git Bash](../configuration/git.md)).
  `git config user.name`, sans valeur, affiche ce qui est enregistré. Sur un
  ordinateur personnel, `git config --global user.name "Prénom Nom"`
  l'enregistre une fois pour tous les dépôts du compte.

(dep-g3)=
### G3. « warning: … LF will be replaced by CRLF »

Ce qu'on voit
: `warning: in the working copy of 'notes.md', LF will be replaced by CRLF
  the next time Git touches it`.

Cause
: Windows termine les lignes d'un fichier texte par deux caractères
  (CR LF), macOS et Linux par un seul (LF). git prévient qu'il convertira.
  Cet avertissement n'empêche pas le commit.

Solution
: Rien à faire pour le module. Pour ne plus voir le message :
  `git config --global core.autocrlf false`.

## Problèmes avec Git Bash

Les problèmes de conda dans Git Bash sont dans [Problèmes avec
Anaconda](anaconda.md) :

- `conda` n'est pas reconnu : {ref}`A2 <dep-a2>` ;
- l'invite ne commence pas par `(base)` : {ref}`A3 <dep-a3>` ;
- `source` affiche `No such file or directory` : {ref}`A14 <dep-a14>` ;
- `conda init bash` écrit `needs sudo`, ou Windows demande des droits
  d'administrateur : {ref}`A15 <dep-a15>`.

(dep-g7)=
### G7. Chaque nouveau Git Bash affiche l'aide de `cygpath`

Ce qu'on voit
: `Usage: cygpath …`, puis `bash: : No such file or directory`.

Cause
: Anaconda fournit son propre `cygpath`, dans
  `C:\ProgramData\anaconda3\Library\usr\bin`, qui échoue sous Git Bash ;
  une fois `base` activé, ce dossier passe avant ceux de Git dans le `PATH`.
  L'environnement est activé, mais le script d'OpenSSL d'Anaconda n'est pas
  chargé, et `SSL_CERT_FILE` n'est pas posée.

Solution
: Taper une fois la commande suivante, puis rouvrir Git Bash :

  ```text
  sed -i '1i cygpath() { /usr/bin/cygpath "$@"; }' ~/.bash_profile
  ```

  Elle ajoute en tête de `~/.bash_profile` une fonction `cygpath`, qui passe
  avant le `PATH` et appelle toujours celui de Git.
