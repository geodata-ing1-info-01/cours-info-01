---
title: "Git Bash : une fenêtre, bash et des programmes"
subtitle: Ce que contient Git for Windows, et pourquoi Cmder, conda et VS Code donnent le même bash
---

Sous Windows, git s'installe avec Git for Windows. Ce n'est pas seulement
git : c'est un dossier qui contient git, l'interpréteur bash, et les
commandes unix (`ls`, `cp`, `mv`, `rm`, `touch`, `pwd`, `vim`…) que bash
suppose présentes. Le même dossier se trouve, sans changement, dans Cmder
(`vendor\git-for-windows\`), dans un environnement conda où le paquet
`git` est installé (`Library\`), et dans l'archive portable
(`PortableGit\`). Cette page dit ce qu'il y a dedans, et comment les trois
pièces s'assemblent.

## Ce que contient le dossier

| Dossier ou fichier | Ce que c'est |
|---|---|
| `cmd\git.exe`, `bin\bash.exe` | deux lanceurs : ils règlent le PATH, puis appellent le vrai programme |
| `mingw64\bin\git.exe` | git lui-même |
| `usr\bin\bash.exe` | bash lui-même |
| `usr\bin\ls.exe`, `cp.exe`, `mv.exe`, `rm.exe`, `touch.exe`, `pwd.exe`, `mkdir.exe`, `vim.exe`… | les commandes unix, un programme par commande |
| `usr\bin\mintty.exe` | la fenêtre de Git Bash |
| `etc\profile` | le script que bash exécute au démarrage, quand il est lancé avec `--login` |
| `git-bash.exe` | mintty + bash : le raccourci « Git Bash » |
| `git-cmd.exe` | la fenêtre de `cmd`, avec le même PATH |

`ls` n'est pas une commande de bash : c'est le programme `usr\bin\ls.exe`,
comme `python.exe` est un programme. bash le trouve par le PATH
([Variables d'environnement](variables_environnement.md)). bash a ses
commandes internes, `cd`, `export` et quelques autres, qui ne
correspondent à aucun fichier ; sous `cmd`, `cd` et `mkdir` sont internes
de la même façon.

## Trois pièces : la fenêtre, l'interpréteur, les programmes

Un terminal est une fenêtre dans laquelle un interpréteur de commandes lit
ce qu'on tape ([Les terminaux](terminaux.md)). Pour Git Bash :

- la fenêtre : mintty, ou la fenêtre de `cmd`, ou un onglet de Cmder, ou
  le panneau de VS Code ; elle ne fait qu'afficher et transmettre ;
- l'interpréteur : `bash.exe`, qui lit la ligne et décide quoi lancer ;
- les programmes : `git.exe`, `ls.exe`, `cp.exe`…, lancés par bash quand
  la ligne commence par leur nom.

Changer de fenêtre ne change ni bash ni les commandes. C'est pourquoi le
cours 2 se fait indifféremment dans Git Bash, dans un onglet bash de Cmder
ou dans le terminal de VS Code : dans les trois cas, c'est le même
`bash.exe` qui lit les commandes.

## Comment bash trouve git et les commandes

Le lanceur `bin\bash.exe` ajoute `mingw64\bin` et `usr\bin` du dossier en
tête du PATH, puis lance `usr\bin\bash.exe` avec les arguments reçus,
`--login -i`. Avec `--login`, bash exécute `etc\profile`, qui refait le
PATH : `/mingw64/bin`, `/usr/bin`, `/bin`, puis le PATH de Windows tel
qu'il était avant. Ces chemins commençant par `/` sont ceux du dossier de
Git for Windows, vus depuis bash : `/usr/bin` est `usr\bin`.

Deux conséquences :

- `git`, `ls` et les autres sont trouvés quel que soit l'endroit où le
  dossier a été copié : le lanceur repart de son propre emplacement ;
- le PATH de Windows est conservé. Si un environnement conda était activé
  dans la fenêtre avant `bash --login -i`, `python` et `pandoc` de cet
  environnement répondent aussi dans bash.

## Les mêmes pièces, assemblées par chacun

| Ce qu'on ouvre | La fenêtre | Ce qui met git et `ls` dans le PATH | L'interpréteur |
|---|---|---|---|
| Raccourci « Git Bash », `git-bash.exe` | mintty | le lanceur, puis `etc\profile` | bash |
| Cmder, onglet par défaut | ConEmu | `vendor\init.bat`, au démarrage de l'onglet | `cmd` |
| Cmder, tâche `{bash::bash}` | ConEmu | le lanceur, puis `etc\profile` | bash |
| Invite de commandes d'Anaconda, `conda activate outils` | `cmd` | l'activation : `Library\bin` et `Library\usr\bin` de l'environnement | `cmd` |
| … puis `bash --login -i` | la même | le lanceur, puis `etc\profile` | bash |
| VS Code, profil « Git Bash » | le panneau de VS Code | le lanceur, puis `etc\profile` | bash |
| VS Code, panneau Source Control | aucune | le réglage `git.path` | aucun : VS Code lance `git.exe` directement |

VS Code ne sait rien de bash ni de ses commandes. Son profil « Git Bash »
est une ligne de réglage : le chemin de `bash.exe` et les arguments
`--login -i`. VS Code ne devine ce chemin que pour une installation
classique : il part de `git.exe` trouvé dans le PATH, remonte de deux
dossiers, et cherche `Git\bin\bash.exe`. Le dossier doit donc s'appeler
`Git`, ce qui n'est le cas ni pour Cmder, ni pour conda, ni pour l'archive
portable ; pour eux, on écrit le profil ([Git et Git
Bash](../configuration/git.md)).

## Un fichier de configuration commun

Tous ces assemblages lisent le même fichier de réglages de git, celui du
compte Windows : `C:\Users\<nom>\.gitconfig`, écrit par
`git config --global`. Sur un poste dont le compte est partagé, ce fichier
l'est aussi ; le nom et l'adresse des commits se règlent alors dans le
dépôt, sans `--global` ({ref}`G2 <dep-g2>`).
