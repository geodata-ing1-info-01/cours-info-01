---
title: Le terminal
subtitle: Se déplacer dans les dossiers et agir sur les fichiers en tapant des commandes
---

Les outils employés dans la suite du module, comme `python`, `conda` et
`git`, s'utilisent en ligne de commande, dans un terminal. Les programmes
écrits dans le module se lancent aussi de cette façon, car un programme sans
fenêtre ni bouton est plus simple à écrire. Dans le
[TD 1b](td/1b_terminal/guide.md), on refait au clavier, dans Git Bash, ce que
le TD 1a fait à la souris : se déplacer dans les dossiers, copier, renommer
et ouvrir des fichiers.

## Interface graphique et ligne de commande

Dans une **interface graphique**, on choisit l'opération parmi les menus et
les boutons affichés. En **ligne de commande**, on tape une commande, le nom
de l'opération, puis ses paramètres. Il faut donc connaître ce nom, ou le
chercher dans l'aide. Les sigles anglais sont GUI (*graphical user
interface*) et CLI (*command-line interface*).

```{figure} figures/2_gui_cli.svg
:alt: Deux panneaux. À gauche, l'explorateur de fichiers : raven.odt sélectionné dans depart, et le menu du clic droit ouvert sur Copier. À droite, Git Bash : la commande cp depart/raven.odt travail/.

La même copie, à la souris dans l'explorateur, et au clavier dans Git Bash.
```

Dans l'explorateur, la copie demande ensuite d'ouvrir le dossier `travail`,
puis de choisir Coller au clic droit. Dans Git Bash, on tape la ligne, puis
on appuie sur Entrée. Les deux copies donnent le même fichier,
`travail/raven.odt`.

`cp` abrège *copy*, et n'affiche rien quand la copie réussit. Ses deux
paramètres sont le fichier à copier et le dossier de destination.

## Intérêt de la ligne de commande

Face à une interface graphique, la ligne de commande facilite
l'automatisation des tâches, et simplifie l'écriture d'un programme. Savoir
s'en servir donne aussi accès aux outils qui n'ont pas d'autre interface.

### Automatisation des tâches

Le **traitement par lot** applique la même opération à une série de
fichiers. Il est plus courant en ligne de commande qu'en interface
graphique. La commande suivante copie d'un coup les fichiers `.txt` du
dossier `depart` dans le dossier `travail/textes`, comme au TD 1b :

```text
cp depart/*.txt travail/textes/
```

Pour réduire 120 images à 640 pixels de large dans Paint, il faut ouvrir,
redimensionner et enregistrer chaque image, 120 fois. En ligne de commande,
une seule commande traite toutes les images :

```text
magick mogrify -path travail -resize 640 depart/*.png
```

Le motif `depart/*.png` désigne tous les fichiers `.png` de `depart/`. Le
programme `magick`, d'ImageMagick, sert seulement d'exemple, et le module ne
l'emploie pas.

Une suite de commandes s'enregistre dans un script, et se relance avec
d'autres paramètres. La page [Premier
programme](03_premier_programme.md#un-script-de-commandes) en donne un
exemple. Des logiciels à interface graphique proposent aussi un traitement
par lot, limité aux opérations qu'ils prévoient. QGIS le propose par
« Exécuter comme processus de lot », dans la boîte à outils de traitements.

### Programmes plus simples à écrire

Un programme en ligne de commande reçoit ses paramètres sur la ligne qui le
lance. Le cours 3 construit le programme suivant, qui reçoit un nom de
fichier, `trace.csv`, et une option, `-s 2` :

```text
python altitudes.py trace.csv -s 2
```

Avec une interface graphique, il faudrait aussi programmer les fenêtres, les
boutons et leur comportement. Un programme en ligne de commande peut en
outre être lancé par un autre programme, comme au cours 5.

### Logiciels scientifiques et serveurs de calcul

Beaucoup de logiciels scientifiques ne s'utilisent qu'en ligne de commande,
comme GDAL pour les données géographiques, PDAL pour les nuages de points,
ou MicMac, de l'IGN et de l'ENSG, qui se lance par la commande `mm3d`. La
commande suivante convertit l'image `carte.png` en `carte.tif` avec
`gdal_translate`, un programme de GDAL :

```text
gdal_translate carte.png carte.tif
```

QGIS propose des fenêtres pour une partie des programmes de GDAL. Les
serveurs de calcul s'utilisent à distance, sans interface graphique. On s'y
connecte par `ssh`, présenté au cours 6.

### Comparaison des deux interfaces

L'interface graphique reste adaptée pour découvrir un logiciel, et pour une
opération faite une seule fois.

```{list-table}
:header-rows: 1

* -
  - Interface graphique
  - Ligne de commande
* - Trouver une opération
  - dans les menus affichés
  - connaître son nom, ou lire l'aide
* - Voir le résultat
  - après chaque action
  - en le demandant
* - Premières utilisations
  - peu d'erreurs
  - des fautes de frappe, des options oubliées
* - Traiter 120 fichiers
  - 120 fois la même opération
  - une commande, avec un motif
* - Refaire le travail plus tard
  - refaire chaque action
  - relancer la commande, gardée dans un fichier
* - Travailler sur un serveur
  - s'il a un bureau à distance
  - par `ssh`, au cours 6
```

## Le terminal et l'interpréteur de commandes

Deux programmes se partagent le travail :

- le **terminal** est la fenêtre : il affiche du texte et transmet ce qu'on
  tape ;
- l’**interpréteur de commandes**, ou *shell*, lit chaque ligne et lance le
  programme qu'elle nomme.

```{figure} figures/2_terminal.svg
:alt: À gauche, une chaîne de cinq étapes : ce qu'on tape, ls depart puis Entrée ; le terminal, la fenêtre, qui transmet la ligne ; l'interpréteur de commandes, bash, qui découpe la ligne et lance ls ; le programme ls, qui écrit la liste des fichiers ; l'interpréteur de commandes, qui réaffiche l'invite et attend la ligne suivante. À droite, la fenêtre de Git Bash, avec la commande ls depart, la liste des fichiers du dossier depart du TD 1b, puis l'invite suivante.

La commande `ls depart`, de la frappe à la liste des fichiers.
```

Quand le programme a fini, l'interpréteur réaffiche l'invite, et attend la
ligne suivante. Le mot « terminal » désigne souvent les deux programmes à la
fois. Le langage des commandes est celui de l'interpréteur : cmd, PowerShell
ou bash. L'interpréteur Python, présenté dans la page [Premier
programme](03_premier_programme.md), lit lui aussi du texte et le fait
exécuter.

## Les trois terminaux du poste de l'école

Plusieurs terminaux sont installés sur les postes de la salle, chacun avec
son interpréteur. L’**invite**, au début de chaque ligne, indique quel
interpréteur lit la commande, et donc le langage à employer.

```{list-table}
:header-rows: 1

* - Terminal
  - Interpréteur
  - Ouverture
  - Invite
  - Systèmes
* - Invite de commandes
  - cmd
  - Démarrer, puis `cmd`
  - `C:\Users\…>`
  - Windows
* - Terminal Windows
  - PowerShell
  - Démarrer, puis Terminal
  - `PS C:\Users\…>`
  - Windows
* - Git Bash
  - bash
  - clic droit dans un dossier, puis Open Git Bash here
  - `utilisateur@machine`, puis `$`
  - Windows avec Git Bash ; Linux et macOS
```

::::{grid} 1 1 3 3

:::{grid-item}
```{image} ../images/terminaux/git_bash_2011.png
:alt: Une fenêtre de Git Bash, avec une invite qui se termine par $.
```
Git Bash : `utilisateur@machine`, puis `$`.
:::

:::{grid-item}
```{image} ../images/terminaux/cmd_windows11.png
:alt: Une fenêtre de l'invite de commandes de Windows 11, avec une invite C:\Users\…>.
```
Invite de commandes : `C:\Users\…>`.
:::

:::{grid-item}
```{image} ../images/terminaux/powershell_terminal_windows.png
:alt: Une fenêtre du Terminal Windows avec PowerShell, et une invite PS C:\Users\…>.
```
PowerShell : `PS C:\Users\…>`.
:::

::::

Captures de Wikimedia Commons : Git Bash de 2011, par Walid.bezza (CC BY-SA
3.0) ; invite de commandes de Windows 11 (domaine public) ; PowerShell 7.5,
par Refresh100 (MIT).

Sous Windows 11, « Open Git Bash here » se trouve sous « Afficher d'autres
options », dans le menu du clic droit. Git Bash s'ouvre aussi depuis le menu
Démarrer.

Le module emploie Git Bash, installé avec git sur les postes. Son
interpréteur, bash, n'est pas fourni avec Windows. bash est l'interpréteur
de Linux et de la plupart des serveurs. Ce choix s'appuie sur les faits
suivants :

- 92 % des serveurs web sont sous Unix, dont Linux (W3Techs, septembre
  2026), et les 500 ordinateurs du classement TOP500 sont sous Linux depuis
  novembre 2017 ;
- bash est employé par 49 % des développeurs, contre 23 % pour PowerShell
  (enquête Stack Overflow 2025) ;
- Git Bash fournit aussi `ssh`, employé au cours 6 ;
- sous macOS, l'interpréteur par défaut, zsh, est très proche de bash, et
  les commandes du module s'y tapent à l'identique.

PowerShell n'est pas employé dans le module. Sur les postes de la salle,
sans droits d'administrateur, il n'exécute pas le script d'activation de
conda, et affiche `activate.ps1 cannot be loaded because running scripts is
disabled on this system`.

```{list-table}
:header-rows: 1

* -
  - cmd
  - PowerShell
  - bash, dans Git Bash
* - Sur les postes
  - avec Windows
  - avec Windows
  - avec git
* - Sous Linux et macOS
  - absent
  - à installer
  - bash ; zsh sous macOS
* - Statut
  - conservé pour la compatibilité
  - recommandé par Microsoft
  - logiciel libre, GNU
* - Lister, copier
  - `dir`, `copy`
  - `Get-ChildItem`, `Copy-Item`
  - `ls`, `cp`
```

Dans PowerShell, `ls` et `cp` sont d'autres noms de `Get-ChildItem` et de
`Copy-Item`, qui n'acceptent pas les options de bash, et `ls -a` y échoue donc. Le guide du
[TD 1b](td/1b_terminal/guide.md) donne en annexe les commandes du TD dans
les trois interpréteurs.

## L'invite de Git Bash

Avant chaque commande, Git Bash affiche une invite : l'utilisateur, la
machine et le **dossier courant**. La commande se tape après le `$`.

```{figure} figures/2_invite_couleurs.svg
:alt: Une fenêtre de Git Bash. L'invite eleve@POSTE-12 en vert, MINGW64 en violet, ~/Desktop/info01/cours1 en jaune, puis $ ls, puis la liste 1a_formats/ 1b_terminal/ 1c_programme/ 1d_notebook/, puis de nouveau l'invite et $.

L'invite de Git Bash, dessinée avec ses couleurs ; le nom du poste est inventé.
```

```{list-table}
:header-rows: 1

* - Dans l'invite
  - Ce qu'il désigne
* - `eleve`
  - l'utilisateur
* - `POSTE-12`
  - la machine
* - `MINGW64`
  - Git Bash sous Windows
* - `~`
  - le dossier personnel, `C:\Users\eleve`
* - `~/Desktop/…`
  - le dossier courant, où s'exécutent les commandes
* - `$`
  - l'attente d'une commande
```

Dans la fenêtre de Git Bash, l'utilisateur et la machine s'affichent en
vert, `MINGW64` en violet et le dossier courant en jaune. Le `/` à la fin
d'un nom signale un dossier. Après le TD 1c, une ligne `(base)` s'ajoute
au-dessus de l'invite : l'environnement conda actif.

## Structure d'une commande

Une commande commence par le **nom du programme** à lancer. Suivent des
**options**, qui commencent par un tiret, et des **arguments**, souvent des
noms de fichiers :

```text
commande [options] <arguments>
```

Les crochets désignent ce qui est facultatif, les chevrons ce qu'on
remplace.

```{list-table}
:header-rows: 1

* - Commande tapée
  - Programme
  - Options
  - Arguments
* - `ls`
  - `ls`
  -
  -
* - `ls -a depart`
  - `ls`
  - `-a`
  - `depart`
* - `cp depart/raven.odt travail/`
  - `cp`
  -
  - `depart/raven.odt`, `travail/`
* - `python --version`
  - `python`
  - `--version`
  -
* - `ls --help`
  - `ls`
  - `--help`
  -
```

- Une option d'une lettre prend un tiret, une option en toutes lettres en
  prend deux.
- `--help` affiche l'aide de la plupart des commandes.
- L'interpréteur découpe la ligne aux espaces. Le premier mot désigne le
  programme, et les mots suivants lui sont transmis. Un nom de fichier qui
  contient un espace s'écrit donc entre guillemets :
  `cp depart/raven_une_ligne.txt "travail/le corbeau.txt"`.

## Les commandes de base : se déplacer

Chaque commande de base a son équivalent à la souris dans l'explorateur de
fichiers.

```{list-table}
:header-rows: 1

* - Commande
  - Ce qu'elle fait
  - Dans l'explorateur
* - `pwd`
  - affiche le dossier courant
  - la barre d'adresse
* - `ls`
  - liste le dossier courant
  - la fenêtre ouverte
* - `ls dossier`
  - liste le dossier nommé
  - ouvrir ce dossier
* - `cd dossier`
  - descend dans le dossier nommé
  - double-clic sur le dossier
```

Dans Git Bash, la touche `Tab` complète un nom de fichier ou de dossier
commencé. La flèche vers le haut rappelle la commande précédente.

## Les commandes de base : agir sur les fichiers

```{list-table}
:header-rows: 1

* - Commande
  - Ce qu'elle fait
  - Dans l'explorateur
* - `cp source destination`
  - copie un fichier
  - `Ctrl` + `C`, puis `Ctrl` + `V`
* - `mv source destination`
  - déplace ou renomme
  - glisser ; `F2`
* - `mkdir nom`
  - crée un dossier
  - Nouveau dossier
* - `rm fichier`
  - supprime, sans passer par la corbeille
  - `Suppr`
* - `start fichier`
  - ouvre avec le logiciel associé
  - double-clic
```

:::{warning}
`rm` supprime définitivement : le fichier ne va pas dans la corbeille, et
aucune commande ne le rend. Relire la commande avant de la valider, surtout
avec le caractère générique `*`.
:::

`cp -r` et `rm -r` agissent sur un dossier et tout son contenu. `start` est
propre à Windows ; sous macOS, la commande est `open`, sous Linux
`xdg-open`.

## Le chemin d'un fichier en ligne de commande

En ligne de commande, un fichier se désigne par son chemin, écrit après le
nom de la commande. Un chemin **absolu** part de la racine. Un chemin
**relatif** part du dossier courant. Les exemples de cette page s'écrivent
dans Git Bash, qui note les chemins à la façon de Linux et de macOS : le
disque `C:` devient `/c`, et chaque barre inversée `\` devient une barre `/`.

```{list-table}
:header-rows: 1

* - Dans l'explorateur
  - Dans Git Bash
  -
* - `C:\Users\eleve`
  - `/c/Users/eleve`
  - chemin absolu
* - `C:\Users\eleve`
  - `~`
  - le dossier personnel
* - le dossier ouvert
  - `.`
  - le dossier courant
* - le dossier au-dessus
  - `..`
  - le dossier parent
```

La commande `cd ..` remonte donc au dossier parent, comme la flèche
« dossier parent » de l'explorateur.

Dans l'arborescence suivante, les trois chemins du tableau désignent le même
fichier, `raven.odt`, depuis trois endroits différents.

```text
~/Desktop/info01/cours1/
├─ 1a_formats/depart/raven.odt
└─ 1c_programme/depart/altitudes.py
```

```{list-table}
:header-rows: 1

* -
  - Le chemin de `raven.odt`
  - Depuis
* - Absolu
  - `/c/Users/eleve/Desktop/info01/cours1/1a_formats/depart/raven.odt`
  - la racine
* - Relatif
  - `1a_formats/depart/raven.odt`
  - `cours1`
* - Relatif qui remonte
  - `../1a_formats/depart/raven.odt`
  - `1c_programme`
```

Sous Windows, Python accepte aussi les `/` dans un chemin.

:::{note}
Un chemin copié depuis la barre d'adresse de l'explorateur garde ses `\`.
Dans Git Bash, il s'écrit entre guillemets : `cd "C:\Users\eleve\Desktop"`.
Sur un clavier français, `~` se tape `AltGr` + `2`, puis espace.
:::

Un programme ne connaît pas à l'avance le chemin absolu du dossier d'un
utilisateur, mais il peut s'appuyer sur la position relative des fichiers.
Un projet qui n'emploie que des **chemins relatifs** se copie, se déplace et
s'envoie sans modification ; un chemin absolu écrit dans le code ne vaut que
sur le poste où il a été écrit. Le TD 2b fait corriger un chemin
de ce genre.

## Le fichier exécutable d'une commande

Une commande lance un fichier exécutable. `which` affiche le chemin de ce
fichier, et ce chemin peut remplacer le nom de la commande :

```text
$ which notepad
/c/Windows/system32/notepad
$ /c/Windows/system32/notepad.exe depart/raven_une_ligne.txt
```

% Sortie à relever sur un poste de la salle (notes de la diapositive) : la casse
% affichée par `which notepad`, l'ouverture du Bloc-notes sous Windows 11.

La seconde commande ouvre le poème dans le Bloc-notes, comme
`notepad depart/raven_une_ligne.txt`. Le chemin
`/c/Windows/system32/notepad.exe` désigne le fichier
`C:\Windows\System32\notepad.exe` de l'explorateur.

```{list-table}
:header-rows: 1

* - Commande tapée
  - Fichier lancé
* - `notepad fichier`
  - le premier fichier `notepad` trouvé dans les dossiers du `PATH`, ici
    `/c/Windows/system32/notepad`
* - `/c/Windows/system32/notepad.exe fichier`
  - le fichier de ce chemin, sans recherche
```

La variable **`PATH`** contient une liste de dossiers. Pour trouver le
fichier d'une commande, Git Bash parcourt ces dossiers dans l'ordre, et lance
le premier fichier qui porte ce nom. `echo $PATH` affiche cette liste. Quand plusieurs
versions d'un programme sont installées sur le poste, comme Python au
TD 1c, il faut donc écrire le chemin du fichier, ou régler le `PATH`.

Au TD 1c, conda ajoute son dossier en tête du `PATH`, et `python` lance
alors le Python d'Anaconda. La section [Compilateur et interpréteur :
changer de
poste](03_premier_programme.md#compilateur-et-interpréteur-changer-de-poste)
montre la liste des dossiers du `PATH`, avant et après le réglage de conda.

:::{note}
`which ls` affiche `/usr/bin/ls`. Git Bash appelle `/` son dossier
d'installation, `C:\Program Files\Git`, et ce fichier est donc
`C:\Program Files\Git\usr\bin\ls.exe` ; `cygpath -w /usr/bin/ls` affiche ce
chemin. Seuls les chemins qui commencent par `/c/` suivent la règle de la
section précédente. Dans l'invite de commandes, `where notepad` affiche le
même fichier que `which notepad`, et dans PowerShell, `Get-Command notepad`.
:::

## Fichiers cachés et caractère générique `*`

Les exemples suivants portent sur le dossier du TD 1b, tel qu'il est livré.

```text
1b_terminal/
├── depart/
│   ├── auld_lang_syne.odt
│   ├── auld_lang_syne_une_ligne.donnees
│   ├── auld_lang_syne_une_ligne.txt
│   ├── raven.odt
│   ├── raven_une_ligne.donnees
│   └── raven_une_ligne.txt
└── travail/           vide
```

Un nom qui commence par un point désigne un fichier **caché** : `ls` ne
l'affiche pas, `ls -a` l'affiche. Dans le dossier `travail`, encore vide :

```text
$ ls travail
$ ls -a travail
./  ../
```

`.` et `..`, le dossier courant et son parent, sont les deux entrées cachées
de tout dossier. Les logiciels enregistrent leurs réglages dans des fichiers
cachés : le TD 1c crée `.bash_profile` dans le dossier personnel, et le
cours 2 un dossier caché, `.git`.

:::{note}
Dans l'explorateur de Windows, les fichiers cachés s'affichent par le menu
Affichage, Afficher, Éléments masqués. Windows marque un fichier caché par
un attribut. Git Bash suit la convention du point, celle de Linux et de
macOS.
:::

Dans un nom de fichier, le **caractère générique** `*` remplace n'importe
quelle suite de caractères. Git Bash remplace le motif, par exemple
`*.txt`, par la liste des noms qui correspondent, puis lance la commande.

```{list-table}
:header-rows: 1

* - Commande
  - Noms désignés dans `depart/` du TD 1b
* - `ls depart/*.txt`
  - les deux fichiers `.txt`
* - `ls depart/raven*`
  - les trois fichiers de *The Raven*
* - `cp depart/*.odt travail/`
  - les deux documents LibreOffice
```

:::{note}
Le caractère `*` s'appelle aussi joker (*wildcard* en anglais), et ces
motifs s'appellent *glob*. Le cours 3 emploie ce mot avec `Path.glob`. Les
expressions régulières, employées par `grep` ou le module `re` de Python,
ont une autre syntaxe, où `*` répète le caractère précédent.
:::

## Aide-mémoire : terminal et commandes

### Se déplacer, lister

```{list-table}
:header-rows: 1

* - Commande
  - Effet
* - `pwd`
  - affiche le dossier courant
* - `ls dossier`
  - liste le dossier nommé
* - `ls -a dossier`
  - liste aussi les fichiers cachés
* - `cd dossier`
  - descend dans le dossier nommé
* - `cd ..`
  - remonte au dossier parent
* - `which commande`
  - affiche le chemin du fichier lancé
```

### Agir sur les fichiers

```{list-table}
:header-rows: 1

* - Commande
  - Effet
* - `cp source destination`
  - copie un fichier
* - `mv source destination`
  - déplace ou renomme
* - `mkdir nom`
  - crée un dossier
* - `rm fichier`
  - supprime, sans corbeille
* - `start fichier`
  - ouvre avec le logiciel associé
* - `commande --help`
  - affiche l'aide de la commande
```

### Chemins dans Git Bash

```{list-table}
:header-rows: 1

* - Chemin
  - Sens
* - `/c/Users/eleve`
  - `C:\Users\eleve` dans l'explorateur
* - `~`
  - le dossier personnel
* - `..`
  - le dossier parent
* - `.`
  - le dossier courant
```

### Noms et raccourcis

```{list-table}
:header-rows: 1

* - Écriture ou touche
  - Effet
* - `*`
  - remplace toute suite de caractères
* - `"le corbeau.txt"`
  - reste un seul argument, malgré l'espace
* - `Tab`
  - complète un nom commencé
* - flèche vers le haut
  - rappelle la commande précédente
```

## TD de la partie

- [TD 1b — Rejouer le TD 1a mais en ligne de
  commande](td/1b_terminal/guide.md), 15 minutes. On y ouvre Git Bash dans
  le dossier du TD, puis on se déplace dans les dossiers avec `pwd`, `ls`
  et `cd`. On copie, renomme et ouvre ensuite des fichiers avec `cp`, `mv`
  et `start`, puis on écrit un nom de fichier qui contient un espace. À la
  dernière étape, on crée un dossier avec `mkdir`, on y copie plusieurs
  fichiers d'un coup avec le caractère générique `*`, puis on en supprime un
  avec `rm`.

Pour s'entraîner à la ligne de commande après la séance, des jeux et des
exercices sont réunis dans [S'entraîner : jeux et
exercices](../../apres/s_entrainer.md).

Les TD des autres parties sont dans [Travaux dirigés de la
séance 1](travaux_diriges.md).
