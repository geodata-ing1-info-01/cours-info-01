---
title: "TD 1c — Lancer un programme"
subtitle: Guide détaillé, étape par étape
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

Un programme Python est un fichier texte, et `python` est un programme en
ligne de commande. Le TD cherche d'abord quel fichier la commande `python`
lance, puis rend disponible dans Git Bash celui d'Anaconda, par un réglage
fait une fois par poste. Il copie ensuite les fichiers du TD de `depart/`
dans `travail/`, ouvre le programme dans un éditeur de texte, Notepad++, le
fait exécuter depuis Git Bash, le modifie et le relance. Il refait ensuite
le calcul ligne à ligne dans une session interactive, puis, si le temps le
permet, lance un script de commandes. Il dure une vingtaine de minutes.

| Étape | Objectif | Action |
|---|---|---|
| [1 · Programme lancé par la commande python](#étape-1-programme-lancé-par-la-commande-python) | identifier le programme qu'une commande lance | trouver quel python la commande lance |
| [2 · Configuration de conda dans Git Bash](#étape-2-configuration-de-conda-dans-git-bash) | rendre un programme accessible depuis le terminal | rendre le Python d'Anaconda disponible dans Git Bash, une fois par poste |
| [3 · Le programme du TD](#étape-3-le-programme-du-td) | lire un programme Python dans un éditeur, et l'exécuter depuis le terminal | copier les fichiers de `depart` dans `travail`, ouvrir `travail\altitudes.py` dans Notepad++, puis le lancer dans Git Bash |
| [4 · Cycle d'édition d'un programme](#étape-4-cycle-dédition-dun-programme) | relier le fichier enregistré à ce qui s'exécute | le modifier, et le relancer avant et après l'enregistrement |
| [5 · Python en interactif](#étape-5-python-en-interactif) | exécuter du Python ligne à ligne, en interactif | refaire le calcul dans une session interactive de Python |
| [6 (facultative) · Script de commandes](#étape-6-facultative-script-de-commandes) | enchaîner des commandes dans un script | lancer un script de commandes, si le temps le permet |

Sur un poste où l'étape 2 est déjà faite, l'invite de Git Bash commence
par `(base)`, et `which python` affiche le Python d'Anaconda :
faire l'étape 1, puis passer à l'étape 3.

![Notepad++ et Git Bash, côte à côte](illustrations/deux_fenetres.png)

## Étape 1 · Programme lancé par la commande python

> **Objectif :** déterminer quel fichier la commande `python` lance dans Git Bash, puis lancer le
> Python d'Anaconda par son chemin.

### La commande `python`

Dans Git Bash, ouvert au TD 1b dans `1b_terminal/` :

```text
cd ../1c_programme
which python
python --version
```

`which python` affiche le chemin du fichier que lance la commande `python`.
`python --version` affiche la version de ce Python. bash cherche le fichier dans une liste
de dossiers, la variable `PATH`, et lance le premier qu'il trouve.

**À noter** : la version affichée, et le chemin du fichier lancé.

### Le Python d'Anaconda, dans l'explorateur

Anaconda est installé sur le poste, dans `C:\ProgramData\anaconda3`.
`C:\ProgramData` est un dossier masqué, que l'explorateur n'affiche pas :
taper ce chemin dans sa barre d'adresse, puis `Entrée`. Le dossier contient
`python.exe`, le programme de l'interpréteur.

### Lancement d'un fichier par son chemin

Un nom de commande qui contient un `/` désigne un fichier précis : bash le
lance sans chercher dans `PATH`. Dans Git Bash, le chemin de `python.exe`
s'écrit avec des `/`, et `C:` devient `/c` :

```text
/c/ProgramData/anaconda3/python.exe --version
```

**Test** : la commande affiche `Python 3.` suivi de la version
installée par Anaconda.

Si le temps le permet, la même chose depuis le dossier du fichier, où `./`
désigne le dossier courant, puis retour au dossier du TD :

```text
cd /c/ProgramData/anaconda3
./python.exe --version
cd ~/Desktop/info01/cours1/1c_programme
```

Tout programme se lance ainsi, par le chemin de son fichier. Une commande
sans `/`, comme `python`, `ls` ou `cp`, désigne le premier fichier de ce nom
trouvé dans `PATH`.

Ce que l'étape fait constater : [fin du guide](#étape-1-commande-et-fichier-exécutable).

## Étape 2 · Configuration de conda dans Git Bash

> **Objectif :** régler Git Bash, une fois par poste, pour que `python` lance le Python
> d'Anaconda.

```text
source /c/ProgramData/anaconda3/etc/profile.d/conda.sh
conda init bash
```

`source` rend la commande `conda` disponible dans ce terminal. `conda init
bash` écrit l'instruction équivalente dans le fichier `~/.bash_profile`, que
Git Bash lit à chaque ouverture : elle active conda, qui met les dossiers
d'Anaconda en tête de `PATH`. `conda init bash` affiche une ligne par
fichier examiné, `no change` ou `modified`, puis :

```text
==> For changes to take effect, close and re-open your current shell. <==
```

Fermer Git Bash (`exit`, ou la croix de la fenêtre), et le rouvrir dans
`1c_programme`, par le clic droit du TD 1b.

**Test** : la première ligne de l'invite est `(base)`. Puis :

```text
which python
python --version
ls -a ~
```

`which python` affiche `/c/ProgramData/anaconda3/python`, le fichier
d'Anaconda. `python --version` affiche `Python 3.` suivi de la version
installée par Anaconda. `ls -a ~` liste le dossier personnel, et
parmi les noms, `.bash_profile` : un fichier caché, écrit par
`conda init bash`.

Le réglage reste d'une séance à l'autre : les postes de la salle gardent le
dossier personnel. Il se refait sur un autre poste.

Ce que l'étape fait constater : [fin du guide](#étape-2-réglage-écrit-dans-un-fichier-caché).

### Dépannage

- **`source` affiche `No such file or directory`.** Anaconda est installé
  dans un autre dossier sur ce poste. Essayer
  `source /c/Users/$USERNAME/anaconda3/etc/profile.d/conda.sh`, ou prévenir
  l'enseignant.
- **`conda init bash` écrit `needs sudo`, ou une fenêtre de Windows
  demande des droits d'administrateur.** Fermer la fenêtre par « Non ».
  Ajouter l'activation de conda au seul fichier `~/.bash_profile`, par la
  commande suivante, puis fermer et rouvrir Git Bash :

  ```text
  echo 'eval "$(/c/ProgramData/anaconda3/Scripts/conda.exe shell.bash hook)"' >> ~/.bash_profile
  ```

- **Chaque nouveau Git Bash affiche l'aide de `cygpath`** (`Usage: cygpath
  …`), puis `bash: : No such file or directory`. L'environnement `base` est
  activé quand même : le message vient d'un `cygpath` fourni par Anaconda,
  qui échoue sous Git Bash. Pour le faire disparaître, taper une fois, puis
  rouvrir Git Bash :

  ```text
  sed -i '1i cygpath() { /usr/bin/cygpath "$@"; }' ~/.bash_profile
  ```

Si le réglage échoue malgré ces corrections, taper les commandes `python` de
la séance dans l'invite de commandes d'Anaconda : menu Démarrer, « Anaconda
Prompt ». conda y est actif sans réglage, et `python altitudes.py` s'y tape
de la même façon. Aller d'abord dans le dossier du TD, puis faire la copie de
l'étape 3 avec la commande `copy` de l'invite :

```text
cd Desktop\info01\cours1\1c_programme
copy depart\* travail\
cd travail
```

Les chemins s'y écrivent avec des `\`. Prévenir l'enseignant ; le réglage de
Git Bash se refera au cours 2.

## Étape 3 · Le programme du TD

> **Objectif :** copier les fichiers de `depart` dans `travail`, puis ouvrir
> `travail/altitudes.py` dans Notepad++ et le lancer dans Git Bash depuis `travail`.

### Copie et ouverture du programme

Le TD modifie le programme. Comme aux TD 1a et 1b, `depart/` garde les
fichiers livrés, et le travail se fait sur une copie, dans `travail/`. Dans
Git Bash, rouvert dans `1c_programme/` à l'étape 2 :

```text
cp depart/* travail/
cd travail
ls
```

`cp depart/* travail/` copie les deux fichiers de `depart/` dans `travail/`,
et `cd travail` fait de ce dossier le dossier courant. `ls` affiche
`altitudes.py` et `commandes.sh`.

1. Lancer Notepad++ (menu Démarrer, « Notepad++ »).
2. Menu Fichier, Ouvrir…, aller dans
   `Bureau\info01\cours1\1c_programme\travail`, et choisir `altitudes.py`.

Le fichier compte huit lignes : une chaîne de documentation, une ligne
vide, puis six lignes de code.

```python
"""Moyenne d'une série d'altitudes, à la main plutôt qu'avec sum()."""

altitudes = [79.6, 103.2, 98.3]
total = 0
for altitude in altitudes:
    total = total + altitude
moyenne = total / len(altitudes)
print(f"moyenne : {moyenne:.1f} m")
```

**À noter** : les couleurs, et le nom du langage affiché en bas à gauche
de la fenêtre de Notepad++.

### Exécution du programme

Dans Git Bash, toujours dans `travail/` :

```text
python altitudes.py
```

La commande `python altitudes.py` lance l'interpréteur Python, qui lit le
fichier et l'exécute :

```text
moyenne : 93.7 m
```

Le programme n'écrit qu'une ligne, celle du `print` final. La moyenne de
79,6, 103,2 et 98,3 vaut bien 93,7.

**Test** : `ls` après l'exécution affiche les deux mêmes
fichiers. Lancer un programme Python ne crée aucun fichier.

Si Git Bash affiche `bash: python: command not found`, l'étape 2 n'est pas
faite sur ce poste. Si le programme affiche une autre erreur, taper
`python --version` : une réponse qui commence par `Python 2.7` montre que
`python` lance encore le Python 2.7 du poste, qui ne peut pas exécuter ce
programme ; faire l'étape 2. Si Python affiche `can't open file … No such
file or directory`, le dossier courant n'est pas `travail` : lire
l'invite, et refaire le `cd travail` du début de l'étape.

Ce que l'étape fait constater : [fin du guide](#étape-3-programme-et-fichier-texte).

## Étape 4 · Cycle d'édition d'un programme

> **Objectif :** modifier `altitudes.py` dans Notepad++, et déterminer à quel moment `python`
> prend en compte la modification.

1. Dans Notepad++, ajouter `92.5` à la liste :

   ```python
   altitudes = [79.6, 103.2, 98.3, 92.5]
   ```

   Ne pas enregistrer. L'onglet du fichier porte une disquette rouge : le
   fichier affiché diffère du fichier enregistré.

2. Dans Git Bash, relancer : flèche vers le haut, qui rappelle la commande
   précédente, puis `Entrée`.

   **À noter** : la moyenne affichée.

3. Dans Notepad++, enregistrer : `Ctrl` + `S`. La disquette redevient
   bleue.

4. Relancer dans Git Bash.

**Test** :

```text
moyenne : 93.4 m
```

La somme des quatre altitudes vaut 373,6, et leur moyenne 93,4.

Ce que l'étape fait constater : [fin du guide](#étape-4-lecture-du-fichier-enregistré-par-linterpréteur).

## Étape 5 · Python en interactif

> **Objectif :** exécuter les premières lignes de `altitudes.py` une à une, dans une session
> interactive, puis afficher `total` et la moyenne.

Dans Git Bash, taper `python` sans nom de fichier : l'interpréteur ouvre une
session interactive. Chaque ligne tapée est lue, exécutée, et son résultat
affiché aussitôt.

```text
$ python
Python 3.12.14 (main, Sep  2 2026, 23:27:36) [GCC 15.3.0] on linux
>>> altitudes = [79.6, 103.2, 98.3]
>>> total = 0
>>> for altitude in altitudes:
...     total = total + altitude
...
>>> total
281.1
>>> total / len(altitudes)
93.7
>>> exit()
```

Session relevée sous Linux ; la première ligne, qui donne la version de
Python, diffère sur les postes de la salle.

Les trois chevrons `>>>` sont l'invite de Python : la session attend une
ligne de Python. Les commandes de Git Bash ne s'y tapent pas. Les trois points `...`
marquent la suite d'un bloc commencé, ici la boucle : taper quatre espaces
avant `total = total + altitude`, puis `Entrée` sur une ligne vide pour
finir le bloc. `total` s'affiche sans `print` : la session affiche la
valeur de chaque expression tapée.

`exit()` quitte la session ; l'invite de Git Bash revient.

**Test** : la dernière ligne de la fenêtre se termine par `$`.

Si `python` seul n'affiche pas l'invite `>>>` et semble bloqué, taper
`Ctrl` + `C`, puis `winpty python`. À défaut, faire la session dans l'invite
de commandes d'Anaconda.

Si une commande de Git Bash, comme `ls`, est tapée dans la session Python,
Python affiche `NameError: name 'ls' is not defined`. Lire l'invite avant
de taper : `$` pour Git Bash, `>>>` pour Python.

Ce que l'étape fait constater : [fin du guide](#étape-5-programme-et-session-interactive).

## Étape 6 (facultative) · Script de commandes

> **Objectif :** lire `commandes.sh`, le lancer, puis déterminer s'il peut se relancer sans
> erreur.

Un script est un fichier texte qui contient des commandes. `bash` les lit
et les exécute dans l'ordre, comme si on les tapait. Dans Notepad++, ouvrir
`1c_programme\travail\commandes.sh`, la copie de l'étape 3 :

```bash
# Commandes du TD 1b, puis le programme du TD 1c.
# Lancer depuis 1c_programme/travail : bash commandes.sh
mkdir -p copies
cp ../../1b_terminal/depart/*.txt copies/
ls copies
python altitudes.py
```

Une ligne qui commence par `#` est un commentaire, que bash ne lit pas.
`mkdir -p` crée le dossier `copies`, sans erreur s'il existe déjà. Depuis
`travail/`, `../../1b_terminal` remonte de deux dossiers, jusqu'à `cours1`,
puis descend dans le dossier du TD 1b. La dernière ligne lance le programme
du TD : `python` est une commande comme `ls` ou `cp`.

Dans Git Bash, dans `travail/` :

```text
bash commandes.sh
```

**Test** : Git Bash affiche la liste des deux fichiers `.txt`
copiés, puis la moyenne de l'étape 4.

```text
auld_lang_syne_une_ligne.txt  raven_une_ligne.txt
moyenne : 93.4 m
```

Relancer la commande, par la flèche vers le haut puis `Entrée`.

**À noter** : si la seconde exécution affiche un message d'erreur.

L'équivalent pour l'invite de commandes est un fichier `.bat`, en
[annexe](#annexe-le-script-pour-linvite-de-commandes).

Ce que l'étape fait constater : [fin du guide](#étape-6-script-de-commandes).

## Ce que le TD fait constater

À lire après avoir fait les étapes.

### Étape 1 : commande et fichier exécutable

Sur les postes de la salle, avant l'étape 2, la commande `python` lance un
Python 2.7, installé à part dans `C:\Python27`, ou ne trouve aucun fichier.
Dans ce dernier cas, Git Bash affiche `bash: python: command not found`, ou
un message qui renvoie au Microsoft Store.

`python`, comme `ls` ou `cp`, est le
nom d'un fichier exécutable. bash le cherche dans les dossiers de `PATH`, dans
l'ordre, et lance le premier qu'il trouve. Un chemin complet, qui contient un
`/`, lance un fichier précis sans cette recherche. Deux Python peuvent donc
être installés sur le même poste, et la commande `python` n'en lance qu'un :
le premier trouvé.

### Étape 2 : réglage écrit dans un fichier caché

`conda init bash` a écrit dans
`~/.bash_profile`, que Git Bash lit à chaque ouverture : d'où le `(base)`,
et le `python` d'Anaconda. L'activation de conda met les dossiers
d'Anaconda en tête de `PATH` : son `python.exe` est alors trouvé le premier.
Le cours 2 ouvre le même Git Bash dans l'éditeur de code, qui lit le même
fichier.

### Étape 3 : programme et fichier texte

Notepad++ ouvre `altitudes.py`
comme les fichiers texte du TD 1a, et reconnaît en plus l'extension `.py` :
il colore le code Python. Les couleurs ne sont pas dans le
fichier. N'importe quel éditeur de texte sert à écrire un programme ; le
cours 2 installe un éditeur de code, qui souligne les erreurs du programme
et ouvre un terminal dans sa fenêtre.

### Étape 4 : lecture du fichier enregistré par l'interpréteur

À l'étape 4, la moyenne ne
change pas tant que le fichier n'est pas enregistré : `python` lit le
fichier sur le disque. Le texte affiché par Notepad++ n'y est qu'une fois
enregistré.

### Étape 5 : programme et session interactive

Le programme lancé en entier n'affiche que
ce que ses `print` écrivent, et se relance à l'identique. La session
interactive affiche la valeur de chaque ligne, et ne garde rien sur le
disque. Un notebook, à la partie 3, réunit les deux : du code enregistré
dans un fichier, exécuté morceau par morceau, avec les résultats affichés.

### Étape 6 : script de commandes

Relancé, le script affiche la même sortie, sans message d'erreur :
`mkdir -p` accepte un dossier qui existe déjà, et `cp` remplace les copies
précédentes.

`commandes.sh` refait en une commande
ce que le TD 1b a fait ligne à ligne, et se relance à l'identique. bash lit
le script comme `python` lit `altitudes.py` : les deux sont des
interpréteurs, l'un de commandes, l'autre de Python. `python` étant une
commande, un script peut lancer un programme Python.

## Annexe · Le script pour l'invite de commandes

Dans l'invite de commandes, `cmd`, un script est un fichier `.bat`. Le même
travail que `commandes.sh` s'y écrit avec les commandes de `cmd`, et des `\`
dans les chemins.

```bat
rem Commandes du TD 1b, puis le programme du TD 1c.
rem Lancer depuis 1c_programme\travail : commandes.bat
if not exist copies mkdir copies
copy ..\..\1b_terminal\depart\*.txt copies\
dir /b copies
python altitudes.py
```

`rem` commence un commentaire. `if not exist copies mkdir copies` crée le
dossier seulement s'il n'existe pas. Dans l'invite de commandes, le fichier
se lance en tapant son nom, `commandes.bat`, depuis le dossier
`1c_programme\travail`. La dernière ligne demande que `python` soit disponible dans
l'invite, comme dans l'invite de commandes d'Anaconda.
