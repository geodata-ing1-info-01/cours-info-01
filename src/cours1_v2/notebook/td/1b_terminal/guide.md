---
title: "TD 1b — Rejouer le TD 1a mais en ligne de commande"
subtitle: Guide détaillé, étape par étape
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

Le TD refait au clavier, dans un terminal, ce que le TD 1a a fait à la
souris : se déplacer dans les dossiers, copier, renommer et ouvrir des
fichiers. Il dure une quinzaine de minutes.

Le terminal du module est Git Bash, installé avec git sur les postes de
la salle. Les commandes de ce guide sont celles de bash : elles se tapent à
l'identique dans le terminal de macOS et de Linux.

Chaque étape donne les opérations à faire. Les commandes à employer sont dans
[l'annexe « Les commandes du TD »](#annexe-les-commandes-du-td), et la
solution de chaque étape, commande par commande, dans [l'annexe « Solution
des étapes »](#annexe-solution-des-étapes).

| Étape | Objectif | Action |
|---|---|---|
| [1 · Git Bash dans le dossier du TD](#étape-1-git-bash-dans-le-dossier-du-td) | situer le terminal dans l'arborescence | ouvrir Git Bash dans le dossier du TD, et lire l'invite |
| [2 · Déplacements et contenu d'un dossier](#étape-2-déplacements-et-contenu-dun-dossier) | se déplacer par des chemins relatifs | se déplacer et lister le contenu des dossiers |
| [3 · Copie et renommage d'un fichier](#étape-3-copie-et-renommage-dun-fichier) | manipuler des fichiers par des commandes | copier, renommer et ouvrir des fichiers |
| [4 · Espace dans un nom de fichier](#étape-4-espace-dans-un-nom-de-fichier) | écrire un chemin qui contient un espace | écrire un nom de fichier qui contient un espace |
| [5 · Copie de plusieurs fichiers avec un motif](#étape-5-copie-de-plusieurs-fichiers-avec-un-motif) | agir sur plusieurs fichiers en une commande | copier plusieurs fichiers d'un coup, supprimer un fichier |

## Rappels avant de commencer

**Plusieurs terminaux.** Le poste a plusieurs terminaux :
l'invite de commandes (`cmd`), PowerShell, Git Bash. Chacun a son langage.
Les commandes du guide sont celles de Git Bash, et [la dernière
annexe](#annexe-les-mêmes-commandes-dans-powershell-et-linvite-de-commandes)
donne leurs équivalents dans les deux autres. L'invite, au début de chaque
ligne, indique le terminal employé :

| Git Bash | Invite de commandes | PowerShell |
|---|---|---|
| ![Git Bash](../../../images/terminaux/git_bash_2011.png) | ![Invite de commandes](../../../images/terminaux/cmd_windows11.png) | ![PowerShell](../../../images/terminaux/powershell_terminal_windows.png) |
| `utilisateur@machine MINGW64 ~/…`, puis `$` | `C:\Users\…>` | `PS C:\Users\…>` |

La capture de Git Bash date de 2011 (`MINGW32`). Sources et licences :
`images/terminaux/CREDITS.md` dans le dépôt du cours.

**Saisie d'une commande.** Une commande se tape après le `$`, puis se valide
par `Entrée`. Les touches suivantes rappellent, complètent ou interrompent
une commande :

| Touche | Effet |
|---|---|
| flèche vers le haut | rappelle la commande précédente, à modifier ou relancer |
| `Tab` | complète le nom de fichier ou de dossier commencé |
| `Ctrl` + `C` | interrompt la commande en cours |

Sur un clavier français : `~` se tape `AltGr` + `2`, puis espace ; `|`,
`AltGr` + `6`. Coller dans Git Bash : clic droit, puis « Paste », ou `Maj` +
`Inser` ; `Ctrl` + `V` ne colle pas.

**Commande réussie sans message.** `cp`, `mv`, `mkdir`,
`rm` n'affichent rien quand tout se passe bien. Un message après une de ces
commandes est un message d'erreur : le lire.

## Étape 1 · Git Bash dans le dossier du TD

> **Objectif :** ouvrir Git Bash dans le dossier du TD, `cours1\1b_terminal`, à partir de
> l'explorateur.

**Dossier de départ** : `cours1/1b_terminal/`, tel que décompressé au TD 1a.

```text
1b_terminal/
├── depart/                  les fichiers du TD 1a : raven.odt, raven_une_ligne.txt…
├── illustrations/           les images du guide
├── travail/                 vide
├── guide.ipynb              le guide, en notebook
├── guide_1b_terminal.html   le guide, en page web
├── guide_1b_terminal.pdf    le guide, en PDF
└── td_1b_terminal.pdf       la feuille du TD
```

### Ouverture de Git Bash par le clic droit

1. Dans l'explorateur, ouvrir `Bureau\info01\cours1\1b_terminal`.
2. Clic droit sur un endroit vide de la fenêtre (pas sur un fichier).
3. Sous Windows 11, choisir « Afficher d'autres options », en bas du menu.
4. Choisir « Open Git Bash here ».

![Ouvrir Git Bash dans un dossier](illustrations/menu_git_bash.png)

Git Bash s'ouvre, et son dossier courant est le dossier où l'on a cliqué.

Autre façon : menu Démarrer, « Git Bash », puis taper

```text
cd ~/Desktop/info01/cours1/1b_terminal
```

### Lecture de l'invite

![L'invite de Git Bash, annotée](illustrations/invite.png)

Sur le poste, la ligne `(base)` de la capture n'apparaît qu'après le réglage
de conda, à l'étape 2 du TD 1c.

**Test** : la première ligne de l'invite se termine par
`~/Desktop/info01/cours1/1b_terminal`.

## Étape 2 · Déplacements et contenu d'un dossier

> **Objectif :** avec la ligne de commande : afficher le dossier courant, lister le contenu de
> `depart` et de `travail`, entrer dans le dossier `depart`, lister depuis ce dossier le contenu
> de `1a_formats/travail`, puis revenir dans `1b_terminal`.

**Consignes**

1. Afficher le dossier courant.
2. Lister le contenu du dossier courant.
3. Lister le contenu de `depart`.
4. Lister le contenu de `travail`, entrées cachées comprises.
5. Entrer dans `depart`. Afficher le dossier courant, et relire l'invite.
6. Sans quitter `depart`, lister le contenu de `1a_formats/travail`.
7. Revenir dans `1b_terminal` pour la suite du TD.

**Test** : l'invite se termine par `1b_terminal`.

Solution : [annexe](#solution-de-létape-2).

Ce que l'étape fait constater : [fin du guide](#étape-2-dossier-courant).

## Étape 3 · Copie et renommage d'un fichier

> **Objectif :** en ligne de commande, obtenir dans `travail` trois copies de `depart/raven.odt`,
> nommées `raven_odt.pdf`, `riri.fifi.loulou.odt` et `raven.loulou`, puis ouvrir chacune et noter
> quel logiciel Windows lance et ce que ce logiciel affiche.

**Consignes**

1. Copier `raven.odt` de `depart` dans `travail`.
2. Renommer la copie en `raven_odt.pdf`.
3. Ouvrir le fichier renommé. Noter le logiciel qui s'ouvre et ce qu'il affiche.
4. Copier `raven.odt` dans `travail` sous le nom `riri.fifi.loulou.odt`, puis ouvrir la copie.
5. Copier `raven.odt` dans `travail` sous le nom `raven.loulou`, puis ouvrir la copie. Si Windows
   demande un logiciel, choisir LibreOffice Writer.

**Test** : `travail` contient `raven.loulou`, `raven_odt.pdf` et `riri.fifi.loulou.odt`.

Solution : [annexe](#solution-de-létape-3).

Ce que l'étape fait constater : [fin du guide](#étape-3-extension-et-logiciel-associé).

## Étape 4 · Espace dans un nom de fichier

> **Objectif :** copier `raven_une_ligne.txt` dans `travail` sous le nom `le corbeau.txt`, puis
> ouvrir la copie ; déterminer comment écrire ce nom dans une commande.

Dans une commande, les espaces séparent le programme, ses options et ses
arguments. Le chemin `travail/le corbeau.txt` devient donc deux arguments.

**Consignes**

1. Copier `raven_une_ligne.txt` de `depart` dans `travail`, sous le nom `le corbeau.txt`. Lire le
   message.
2. Écrire le nom pour qu'il reste un seul argument, puis refaire la copie. Essayer les guillemets.
3. Lister le contenu de `travail`.
4. Ouvrir la copie. Avec `start`, écrire `""` avant un nom entre guillemets.

**Test** : `travail` contient `le corbeau.txt`, et la copie s'ouvre dans le Bloc-notes.

Solution : [annexe](#solution-de-létape-4).

Ce que l'étape fait constater : [fin du guide](#étapes-4-et-5-ligne-découpée-aux-espaces).

## Étape 5 · Copie de plusieurs fichiers avec un motif

> **Objectif :** employer le caractère générique `*` pour copier d'un coup les fichiers `.txt` de
> `depart` dans un nouveau dossier, `travail/textes`, et pour lister les fichiers `.odt`.

**Consignes**

1. Créer un dossier `textes` dans `travail`.
2. Copier dans ce dossier tous les fichiers `.txt` de `depart`.
3. Lister le contenu de `textes`.
4. Lister les fichiers `.odt` de `depart`.
5. Supprimer l'une des copies, puis lister de nouveau `textes`.

**Test** : `travail/textes` ne contient plus qu'une des deux copies.

Solution : [annexe](#solution-de-létape-5).

Ce que l'étape fait constater : [fin du guide](#étapes-4-et-5-ligne-découpée-aux-espaces).

## Ce que le TD fait constater

À lire après avoir fait les étapes.

### Mêmes opérations, au clavier

`cp`, `mv`, `mkdir`, `rm` et `start`
font ce que font `Ctrl` + `C`, `F2`, « Nouveau dossier », `Suppr` et le
double-clic dans l'explorateur. Le terminal les fait sans confirmation, et
`rm` sans corbeille.

### Étape 2 : dossier courant

Chaque commande part du dossier courant, affiché
dans l'invite et par `pwd`. Un chemin relatif (`depart`, ou
`../../1a_formats/travail` tapé dans `depart`) part de lui. Un chemin qui
part de la racine du disque (`/c/Users/…`) ou du dossier personnel (`~`)
vaut depuis n'importe quel dossier.

### Étape 3 : extension et logiciel associé

`mv` a changé le nom du fichier, et
aucun octet de son contenu. Windows choisit le logiciel d'après la fin du
nom : un lecteur PDF pour `raven_odt.pdf`, qui ne peut pas l'ouvrir ;
LibreOffice pour `riri.fifi.loulou.odt`, qui l'ouvre ; aucun pour
`raven.loulou`, dont l'extension est inconnue : une fenêtre demande
lequel employer.

### Étapes 4 et 5 : ligne découpée aux espaces

Git Bash découpe la ligne en mots
avant de lancer la commande : le premier est le programme, les suivants ses
options et ses arguments. Un nom qui contient un espace s'écrit donc entre
guillemets. Un motif comme `*.txt` est remplacé par Git Bash, lui aussi, avant
que la commande ne démarre.

## Annexe · Les commandes du TD

| Commande | Effet | Dans l'explorateur |
|---|---|---|
| `pwd` | affiche le dossier courant | la barre d'adresse |
| `ls`, `ls dossier` | liste le contenu d'un dossier | la fenêtre ouverte |
| `ls -a` | liste aussi les entrées cachées | Affichage, Éléments masqués |
| `cd dossier`, `cd ..` | change de dossier courant | double-clic ; dossier parent |
| `cp source destination` | copie | `Ctrl` + `C`, `Ctrl` + `V` |
| `mv source destination` | déplace ou renomme | glisser ; `F2` |
| `mkdir nom` | crée un dossier | Nouveau dossier |
| `rm fichier` | supprime, sans corbeille | `Suppr` |
| `start fichier` | ouvre avec le logiciel associé | double-clic |
| `commande --help` | affiche l'aide de la commande | |

## Annexe · Solution des étapes

### Solution de l'étape 2

#### Dossier courant

```text
pwd
```

`pwd` affiche le chemin absolu du dossier courant :

```text
/c/Users/eleve/Desktop/info01/cours1/1b_terminal
```

Git Bash écrit les chemins à la façon de Linux : des barres obliques `/`,
et le disque `C:` devient `/c`. Le même dossier s'écrit
`C:\Users\eleve\Desktop\info01\cours1\1b_terminal` dans l'explorateur.

#### Liste du contenu

```text
ls
```

`ls` liste le contenu du dossier courant : les dossiers `depart/`,
`illustrations/` et `travail/`, la feuille du TD et le guide. Le `/` à la
fin d'un nom marque un dossier.

```text
ls depart
```

```text
auld_lang_syne.odt                raven.odt
auld_lang_syne_une_ligne.donnees  raven_une_ligne.donnees
auld_lang_syne_une_ligne.txt      raven_une_ligne.txt
```

`depart` est un **argument** : le dossier à lister. Sans argument, `ls`
liste le dossier courant.

#### Entrées cachées

```text
ls travail
ls -a travail
```

`ls travail` n'affiche rien : le dossier est vide. `ls -a travail` affiche
deux entrées :

```text
./  ../
```

`-a` est une **option** : elle modifie ce que fait la commande (« all »,
tout afficher). `.` désigne le dossier lui-même, `..` son dossier parent.
Tout dossier les contient ; `ls` ne les affiche pas, parce que leur nom
commence par un point, la marque d'un fichier caché.

#### Déplacement

```text
cd depart
pwd
```

L'invite et `pwd` se terminent maintenant par `1b_terminal/depart`. `cd`
(« change directory ») change le dossier courant.

Les chemins relatifs partent du dossier courant. Le schéma les donne depuis
`1b_terminal` :

![Les chemins relatifs depuis 1b_terminal](illustrations/arborescence.png)

Depuis `depart`, il faut un `..` de plus : `..` désigne `1b_terminal`, et
`../..` désigne `cours1`. Sans quitter `depart` :

```text
ls ../../1a_formats/travail
```

```text
raven.pdf  raven.png  raven.txt
```

La commande liste les copies faites au TD 1a. Si l'étape facultative du TD 1a
est faite, la liste contient aussi `raven.zip` et le dossier `raven/`.

Revenir dans `1b_terminal`, d'où partent les commandes de la suite du TD :

```text
cd ..
pwd
```

Si `cd` affiche `No such file or directory`, le chemin tapé n'existe pas
depuis le dossier courant : lire l'invite, puis `ls` pour voir les noms
disponibles. `Tab` complète un nom commencé et évite les fautes de frappe.

### Solution de l'étape 3

#### Copie

```text
cp depart/raven.odt travail/
ls travail
```

```text
raven.odt
```

`cp source destination` copie ; la destination est ici un dossier, et la
copie garde son nom.

#### Renommage

```text
mv travail/raven.odt travail/raven_odt.pdf
ls travail
```

```text
raven_odt.pdf
```

`mv` déplace ou renomme : ici, le fichier reste dans `travail/` et change de
nom. Windows demandait une confirmation quand on changeait l'extension à la
souris ; `mv` n'en affiche pas.

#### Ouverture

```text
start travail/raven_odt.pdf
```

`start` ouvre un fichier avec le logiciel que Windows associe à son
extension, comme un double-clic dans l'explorateur.

Deux autres copies, et leur ouverture :

```text
cp depart/raven.odt travail/riri.fifi.loulou.odt
start travail/riri.fifi.loulou.odt
cp depart/raven.odt travail/raven.loulou
start travail/raven.loulou
```

`ls travail` liste alors les trois copies :

```text
raven.loulou  raven_odt.pdf  riri.fifi.loulou.odt
```

Si `start` ne fait rien, essayer `explorer.exe`, qui ouvre aussi un fichier
avec son logiciel associé ; les barres du chemin s'écrivent alors à la façon
de Windows : `explorer.exe travail\\raven_odt.pdf`.

### Solution de l'étape 4

Faire d'abord la copie sans précaution :

```text
cp depart/raven_une_ligne.txt travail/le corbeau.txt
```

Git Bash affiche un message d'erreur, par exemple :

```text
cp: target 'corbeau.txt' is not a directory
```

`cp` a reçu trois noms, `depart/raven_une_ligne.txt`, `travail/le` et
`corbeau.txt`, et il copie les deux premiers dans le troisième, qu'il prend
pour un dossier.

Entre guillemets, un nom qui contient un espace reste un seul argument.
Refaire la copie, la vérifier, puis l'ouvrir :

```text
cp depart/raven_une_ligne.txt "travail/le corbeau.txt"
ls travail
start "" "travail/le corbeau.txt"
```

`ls` écrit le nom entre apostrophes, `'le corbeau.txt'`, comme il faudrait
le taper. Le poème s'ouvre dans le Bloc-notes. `start` prend le premier
argument entre guillemets pour le titre d'une fenêtre : d'où les guillemets
vides `""` avant le nom du fichier.

Les noms de fichiers du module n'ont pas d'espace : `_` le remplace.

### Solution de l'étape 5

```text
mkdir travail/textes
cp depart/*.txt travail/textes/
ls travail/textes
```

```text
auld_lang_syne_une_ligne.txt  raven_une_ligne.txt
```

`mkdir` crée un dossier. Dans `depart/*.txt`, le caractère générique `*`
remplace n'importe quelle suite de caractères : Git Bash remplace le motif
par la liste des noms qui correspondent, puis lance `cp` avec ces deux noms.

```text
ls depart/*.odt
```

```text
depart/auld_lang_syne.odt  depart/raven.odt
```

```text
rm travail/textes/auld_lang_syne_une_ligne.txt
ls travail/textes
```

`rm` supprime le fichier, sans passer par la corbeille : il ne se récupère
pas. Relire la commande avant de valider.

## Annexe · Les mêmes commandes dans PowerShell et l'invite de commandes

Le TD se fait dans Git Bash. Les mêmes opérations se font dans PowerShell et
dans l'invite de commandes (`cmd`), avec d'autres commandes ou d'autres
options. Le tableau les donne pour les commandes du TD, tapées depuis le
dossier `1b_terminal`.

| Opération | Git Bash | PowerShell | Invite de commandes |
|------|--------|--------|--------|
| afficher le dossier courant | `pwd` | `pwd` | `cd` |
| lister un dossier | `ls depart` | `ls depart` | `dir depart` |
| lister aussi les entrées cachées | `ls -a travail` | `ls -Force travail` | `dir /a travail` |
| descendre dans un dossier | `cd depart` | `cd depart` | `cd depart` |
| remonter au dossier parent | `cd ..` | `cd ..` | `cd ..` |
| copier un fichier | `cp depart/raven.odt travail/` | `cp depart/raven.odt travail/` | `copy depart\raven.odt travail\` |
| renommer un fichier | `mv travail/raven.odt travail/raven_odt.pdf` | `mv travail/raven.odt travail/raven_odt.pdf` | `ren travail\raven.odt raven_odt.pdf` |
| ouvrir avec le logiciel associé | `start travail/raven_odt.pdf` | `start travail/raven_odt.pdf` | `start travail\raven_odt.pdf` |
| ouvrir un fichier dont le nom a un espace | `start "" "travail/le corbeau.txt"` | `start "travail/le corbeau.txt"` | `start "" "travail\le corbeau.txt"` |
| créer un dossier | `mkdir travail/textes` | `mkdir travail/textes` | `mkdir travail\textes` |
| copier plusieurs fichiers | `cp depart/*.txt travail/textes/` | `cp depart/*.txt travail/textes/` | `copy depart\*.txt travail\textes\` |
| supprimer un fichier, sans corbeille | `rm travail/textes/auld_lang_syne_une_ligne.txt` | `rm travail/textes/auld_lang_syne_une_ligne.txt` | `del travail\textes\auld_lang_syne_une_ligne.txt` |
| afficher l'aide d'une commande | `ls --help` | `help ls` | `dir /?` |

**Dans PowerShell**, `ls`, `cp`, `mv`, `rm` et `mkdir` sont d'autres noms
des commandes de PowerShell : `Get-ChildItem`, `Copy-Item`, `Move-Item`,
`Remove-Item` et `New-Item`. Ils prennent les options des commandes de
PowerShell. Ainsi `ls -a` échoue, et `ls -Force` affiche les entrées cachées.
PowerShell accepte `/` et `\` dans les chemins. Son `start` n'attend pas de
titre de fenêtre, et s'écrit donc sans `""`.

**Dans l'invite de commandes**, les chemins s'écrivent avec `\`, car `/`
introduit une option (`dir /a`). `ren` prend le nouveau nom seul, sans
dossier. `start` lit le premier argument entre guillemets comme le titre de
la fenêtre, d'où le `""` devant un nom entre guillemets.

**Présentation des listes.** PowerShell affiche pour chaque
entrée sa date et sa taille, et l'invite de commandes ajoute le nom du
disque et le total des tailles. Les noms sont les mêmes.

**Python.** Pour l'invite de commandes, `python` s'emploie depuis l'invite
de commandes d'Anaconda, au menu Démarrer. Pour PowerShell, il faut ouvrir
l'invite PowerShell d'Anaconda, si elle est installée sur le poste. Le
réglage fait à l'étape 2 du TD 1c ne vaut que pour Git Bash.
