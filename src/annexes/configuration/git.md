---
title: Git et Git Bash
subtitle: Ce qu'il faut pour le cours 2, trois façons de l'avoir sur les postes, et le terminal à ouvrir
---

Le cours 2 se fait dans un terminal bash. Il y faut deux choses : les
commandes git (`git init`, `add`, `commit`, `status`, `log`, `diff`,
`branch`, `merge`, `restore`…) et les commandes unix des diapositives
(`ls`, `cd`, `pwd`, `cp`, `mv`, `rm`, `touch`, `mkdir`). Sous Windows, les
deux viennent d'un seul logiciel, Git for Windows, qui contient git, bash et
ces commandes ([Git Bash : une fenêtre, bash et des
programmes](../notions/git_bash.md)). Il s'obtient sur les postes de la
salle de trois façons, sans droits d'administrateur.

## Trois façons d'avoir git sur un poste

| | Cmder, édition complète | git par conda | Git for Windows portable |
|---|---|---|---|
| Ce que c'est | une console portable (ConEmu + `cmd` + clink) qui embarque Git for Windows | le paquet `git` de conda-forge : Git for Windows décompressé dans `Library\` de l'environnement | l'archive `PortableGit-….7z.exe` de Git for Windows, sans installateur |
| Comment on l'a | déjà sur les postes [à vérifier : édition complète ou mini] | `conda create -n outils -c conda-forge git` dans l'invite de commandes d'Anaconda, session réseau ouverte (124 Mo) | copiée depuis `formationTemp` dans `Desktop\info01\outils\`, comme les fichiers d'une séance |
| Version de git | 2.45.1 (mai 2024) | 2.55 | 2.55 |
| Où sont les fichiers | `<Cmder>\vendor\git-for-windows\` | `C:\Users\<nom>\.conda\envs\outils\Library\` | `<dossier>\PortableGit\` |
| Il faut le réseau | non | oui, à la création | non |

Les trois contiennent le même git, le même bash et les mêmes commandes
unix. Cmder s'emploie s'il est là ; sinon, git par conda reprend ce que fait le
TD 4a, et l'archive portable évite le réseau.

Pour savoir si le Cmder d'un poste est l'édition complète : le dossier
`vendor\git-for-windows` existe dans son dossier, et `git --version` tapé
dans Cmder répond `git version 2.45.1.windows.1`. L'édition mini n'a ni
l'un ni l'autre.

## Ouvrir un terminal avec git

### Avec Cmder

Lancer `Cmder.exe`. L'onglet qui s'ouvre est un `cmd` ; `git` et les
commandes unix y répondent déjà, parce que Cmder les ajoute au PATH au
démarrage. Pour bash, avec l'invite des diapositives : bouton `+` en bas de
la fenêtre (ou `Ctrl` + `T`), puis la tâche `{bash::bash}`.

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

## Vérifier

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Taper `git --version` | `git version 2.xx.x.windows.x` | {ref}`G1 <dep-g1>` |
| Taper `ls -a` dans le dossier d'une séance | la liste des fichiers, `.` et `..` compris | le terminal n'est pas celui de cette page |
| Dans bash, l'invite | `eleve@POSTE MINGW64 ~/Desktop/info01 $` ; `$` en fin de ligne | l'onglet ouvert est un `cmd` |

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
`Échap`, `:wq`, `Entrée` pour enregistrer et quitter (TD 4a). Pour
utiliser VS Code à la place, quand `code` répond dans le terminal :

```
git config --global core.editor "code --wait"
```

## Git dans VS Code

VS Code fait deux choses distinctes avec git, réglées séparément.

Le panneau Source Control (`Ctrl` + `Maj` + `G`) lance `git.exe` lui-même,
sans terminal. Il le cherche dans cet ordre : le réglage `git.path` ;
`C:\Program Files\Git\cmd\git.exe` ;
`C:\Users\<nom>\AppData\Local\Programs\Git\cmd\git.exe` ; enfin le PATH
tel qu'il était quand VS Code a été lancé. Aucun des trois git de cette
page n'est aux deux premiers endroits : donner son chemin dans les réglages
User ({ref}`Les réglages <vscode-reglages>`), puis « Developer:
Reload Window » :

```json
"git.path": "C:\\Users\\eleve\\.conda\\envs\\outils\\Library\\cmd\\git.exe"
```

Pour Cmder, le chemin est `<Cmder>\vendor\git-for-windows\cmd\git.exe` ;
pour l'archive portable, `<dossier>\PortableGit\cmd\git.exe`. Autre
solution, sans réglage : lancer VS Code depuis l'invite de commandes d'Anaconda où
`outils` est activé (`code <dossier>`), git est alors dans son PATH.

Le terminal de VS Code, lui, lance un interpréteur de commandes dans son
panneau. Le profil « Anaconda Prompt » du module ([Python et environnement
conda](vscode_python.md)) suffit avec git par conda : `conda activate
outils`, puis `bash --login -i`. Pour ouvrir bash directement, ajouter un
profil qui pointe sur le `bash.exe` du même dossier que `git.exe`. VS Code
ne propose « Git Bash » de lui-même que pour une installation classique
dans un dossier nommé `Git` ; pour les trois options de cette page, le
profil s'écrit à la main :

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
est affiché ({ref}`VS Code, section Choisir le terminal à ouvrir
<vscode-terminal-choisir>`). VS Code ne connaît aucune commande de bash : il lance
`bash.exe`, et bash trouve `git`, `ls` et les autres tout seul
([Git Bash : une fenêtre, bash et des programmes](../notions/git_bash.md)).

### conda dans le terminal Git Bash

Git Bash ne connaît pas la commande `conda` à son ouverture : rien ne
charge `conda.sh`, le script d'Anaconda qui la définit pour bash
([Environnements](../notions/environnements.md)). Deux façons de le
charger à chaque terminal.

**Par `conda init bash`**, comme à l'étape 0.3 du TD 3a. `conda init`
écrit le chargement dans `~/.bash_profile`, que Git Bash lit à chaque
ouverture, dans VS Code comme hors de VS Code :

```text
echo 'cygpath() { /usr/bin/cygpath "$@"; }' >> ~/.bash_profile
source /c/ProgramData/anaconda3/etc/profile.d/conda.sh
conda init bash
```

**Par les réglages de VS Code seuls**, sans rien écrire dans le compte :
un profil de terminal lance bash avec un fichier de démarrage donné en
argument, comme le profil « Anaconda Prompt » lance `cmd` avec
`activate.bat`. À ajouter dans `terminal.integrated.profiles.windows`,
à côté du profil « Anaconda Prompt » :

```json
"Git Bash (Anaconda)": {
  "path": "C:\\Program Files\\Git\\bin\\bash.exe",
  "args": ["-c", "exec bash --rcfile <(echo 'source /etc/profile; cygpath() { /usr/bin/cygpath \"$@\"; }; source /c/ProgramData/anaconda3/etc/profile.d/conda.sh; conda activate base') -i"]
}
```

Le fichier de démarrage lit `/etc/profile`, comme un Git Bash ordinaire
(invite, `PATH`), puis charge `conda.sh` et active `base`. Le terminal se
choisit par la flèche à côté du `+` ; l'invite commence par `(base)`, et
`which python` affiche `/c/ProgramData/anaconda3/python`. Ce profil ne lit
ni `~/.bashrc` ni `~/.bash_profile`, et ne vaut que dans VS Code. Avec ces
arguments, VS Code n'y ajoute pas son intégration du terminal (les
marques à gauche des commandes).

Dans les deux cas, la ligne `cygpath() { … }` corrige un défaut de
l'installation de la salle. Anaconda y fournit son propre `cygpath`, dans
`C:\ProgramData\anaconda3\Library\usr\bin`, qui échoue sous Git Bash ;
une fois `base` activé, ce dossier passe avant ceux de Git dans le `PATH`.
Sans la ligne, chaque `conda activate` affiche l'aide de `cygpath`
(`Usage: cygpath …`) puis `bash: : No such file or directory`, et le
script d'OpenSSL d'Anaconda n'est pas chargé : l'environnement est activé,
mais `SSL_CERT_FILE` n'est pas posée. La fonction `cygpath` passe avant
le `PATH`, et appelle toujours celui de Git.

## Sur un ordinateur personnel

L'installateur de Git for Windows, avec ses options par défaut, met git,
Git Bash et le profil « Git Bash » de VS Code en place sans rien régler :
[Installation sur un ordinateur personnel](../poste_personnel.md).

## Documentation officielle

- [Git for Windows](https://gitforwindows.org) (en anglais) : l'installateur,
  l'archive portable et MinGit sont sur la
  [page des versions](https://github.com/git-for-windows/git/releases/latest).
- [Cmder](https://github.com/cmderdev/cmder#readme) (en anglais) : les deux
  éditions, et l'intégration à VS Code dans le wiki.
- [Pro Git, chapitre « Démarrage rapide »](https://git-scm.com/book/fr/v2/D%C3%A9marrage-rapide-Installation-de-Git)
  (en français) : l'installation de git sur les trois systèmes.
