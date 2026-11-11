---
title: "TD 5a — L'emplacement de votre distribution Python"
subtitle: Présentation, énoncé et solutions
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

Ce guide a trois parties. La présentation décrit le but du TD et ses étapes. L'énoncé donne, pour
chaque étape, l'objectif, les consignes et le test à faire. Les solutions expliquent chaque
commande, donnent ce que l'étape fait constater, et la marche à suivre si le résultat diffère.

# Présentation du TD

## Objectif du TD

`carte_trace.py` convertit une trace GPX avec le programme `ogr2ogr`, calcule ses statistiques avec
`stats_trace.py`, puis écrit une carte avec la bibliothèque `folium`.

Le TD consiste à déterminer si le poste a ces deux outils, puis à relever où se trouvent
l'interpréteur, les bibliothèques et les programmes du poste. Il se termine par la commande qui
crée l'environnement du TD 5b. Cette commande dure plusieurs minutes, et continue pendant la
partie 4 de l'exposé.

## Les étapes

Le TD dure dix minutes.

1. Préparation de la séance.
2. Ouverture du dossier travail dans VS Code.
3. Programme sur le poste.
4. Fichiers de Python sur le poste.
5. Création de l'environnement : lancement.

### Les notions employées

| Notion | Diapositive |
|---|---|
| `which`, `PATH` | « Recherche d'un programme : variable PATH » |
| dossier d'une distribution, `site-packages` | « Dossier d'une distribution Python » |
| `sys.path` | « sys.path : recherche d'une bibliothèque » |

# Énoncé

## Étape 1 · Préparation de la séance

> **Objectif :** copier et décompresser `info01-cours5.zip`, puis copier les fichiers de `depart/`
> du TD 5a dans `travail/`.

**Consignes**

1. Copier l'archive `info01-cours5.zip` de `formationTemp` dans le dossier `info01` du Bureau.
2. Décompresser l'archive dans Git Bash :

   ```text
   cd ~/Desktop/info01
   unzip info01-cours5.zip
   ```

3. Copier les fichiers de `depart/` dans `travail/`, puis afficher le contenu de `travail/` :

   ```text
   cd cours5/5a_distribution
   cp depart/* travail/
   ls travail
   ```

**Test**

`ls travail` affiche les quatre fichiers de `depart/` : `carte_trace.py`, `stats_trace.py`,
`trace.gpx` et `trace_2.gpx`. Le dossier `cours5/` contient alors :

```text
cours5/
├── 5a_distribution/
│   ├── depart/                      fichiers livrés
│   │   ├── carte_trace.py
│   │   ├── stats_trace.py
│   │   ├── trace.gpx
│   │   └── trace_2.gpx
│   ├── guide.ipynb
│   ├── guide_5a_distribution.html
│   ├── guide_5a_distribution.pdf
│   ├── td_5a_distribution.pdf
│   └── travail/                     copies
│       ├── carte_trace.py
│       ├── stats_trace.py
│       ├── trace.gpx
│       └── trace_2.gpx
├── 5b_environnement/
├── 5c_description/
├── 5d_noyau/
└── README.md
```

Si `travail/` est vide, voir la [solution de l'étape 1](#solution-de-létape-1).

## Étape 2 · Ouverture du dossier travail dans VS Code

> **Objectif :** ouvrir dans VS Code le dossier `travail/` du TD 5a, puis un terminal.

**Consignes**

1. Lancer VS Code depuis le menu Démarrer, puis ouvrir le dossier `travail/` du TD 5a : menu File,
   Open Folder…, `Desktop\info01\cours5\5a_distribution\travail`, puis « Yes, I trust the
   authors ».
2. Ouvrir un terminal : menu Terminal, New Terminal.

**Test**

L'explorateur de VS Code affiche les quatre fichiers de `travail/`, et l'invite du terminal est :

```text
(base)
eleve@POSTE MINGW64 ~/Desktop/info01/cours5/5a_distribution/travail
$
```

Si l'invite diffère, voir la [solution de l'étape 2](#solution-de-létape-2).

## Étape 3 · Programme sur le poste

> **Objectif :** déterminer si le poste a les deux outils qu'appelle `carte_trace.py` : la
> bibliothèque `folium` et le programme `ogr2ogr`.

**Consignes**

1. Lancer le programme, puis lire la dernière ligne du message :

   ```text
   python carte_trace.py trace_2.gpx
   ```

2. Chercher `ogr2ogr` dans les dossiers de `PATH`, puis noter si `which` affiche son chemin :

   ```text
   which ogr2ogr
   ```

Dans `carte_trace.py`, `import folium`, ligne 7, demande la bibliothèque, et la commande des
lignes 26 et 27 demande le programme :

```python
import folium
# …
commande = ["ogr2ogr", FICHIER_CSV, FICHIER_GPX, "track_points"] + options_ogr
subprocess.run(commande, check=True)
```

**Test**

Le terminal affiche un message de `python`, puis la réponse de `which`. La
[solution de l'étape 3](#solution-de-létape-3) donne le résultat attendu.

## Étape 4 · Fichiers de Python sur le poste

> **Objectif :** relever les chemins de l'interpréteur, des modules `argparse` et `numpy`, et de
> `pandoc`, puis les comparer à l'arborescence de « Dossier d'une distribution Python ».

**Consignes**

1. Afficher le chemin de l'interpréteur :

   ```text
   python -c "import sys; print(sys.executable)"
   ```

2. Afficher la liste des dossiers où Python cherche un module :

   ```text
   python -c "import sys; print(*sys.path, sep='\n')"
   ```

3. Afficher le fichier de deux modules :

   ```text
   python -c "import argparse; print(argparse.__file__)"
   python -c "import numpy; print(numpy.__file__)"
   ```

4. Chercher un programme installé avec Anaconda :

   ```text
   which pandoc
   ```

5. Pour chaque chemin, repérer le dossier de la distribution qui le contient : la racine, `Lib`,
   `Lib\site-packages` ou `Library\bin`.

**Test**

Chaque commande affiche un chemin, sauf la deuxième, qui affiche une liste de dossiers, un par
ligne. La [solution de l'étape 4](#solution-de-létape-4) donne le résultat de chaque commande.

## Étape 5 · Création de l'environnement : lancement

> **Objectif :** lancer dès maintenant, dans un second terminal, l'installation des outils du
> TD 5b.

**Consignes**

1. Ouvrir un second terminal : menu Terminal, New Terminal.
2. Lancer la création de l'environnement `carte` :

   ```text
   conda create -y -n carte -c conda-forge python=3.12 gdal folium
   ```

3. Laisser cette commande tourner pendant la partie 4 de l'exposé.

**Test**

Le second terminal affiche `Collecting package metadata`, puis `Solving environment`, puis la liste
des paquets et leur téléchargement.

Si la commande s'arrête sur une erreur, voir la [solution de l'étape 5](#solution-de-létape-5).

# Solutions

## Solution de l'étape 1

`cd` entre dans le dossier `info01` du Bureau, et `unzip` y décompresse l'archive.
`cp depart/* travail/` copie tous les fichiers de `depart/` dans `travail/`. Les commandes suivantes
portent sur cette copie, et `depart/` reste tel qu'il a été livré.

Si `travail/` est vide, `cp` a affiché `cannot stat 'depart/*'` : la commande a été lancée hors du
dossier `5a_distribution`. Taper `cd ~/Desktop/info01/cours5/5a_distribution`, puis relancer
`cp depart/* travail/`.

## Solution de l'étape 2

VS Code ouvre le dossier `travail/`, et son terminal s'ouvre dans ce dossier.

Si l'invite ne commence pas par `(base)`, voir l'annexe « Problèmes avec Anaconda », cas A3. Si le
terminal n'est pas Git Bash, reprendre l'étape 5 du TD 2a, « Git Bash, terminal de VS Code ».

## Solution de l'étape 3

`python carte_trace.py trace_2.gpx` se termine par :

```text
ModuleNotFoundError: No module named 'folium'
```

`which ogr2ogr` affiche `no ogr2ogr in (…)` : aucun des dossiers de `PATH`, entre les parenthèses,
ne contient `ogr2ogr`. Le poste n'a donc ni `folium` ni `ogr2ogr`.

Python exécute `import folium` au début de `carte_trace.py`, et s'arrête sur `ModuleNotFoundError`
avant la conversion. `which ogr2ogr` cherche le programme dans les dossiers de `PATH`, et n'en trouve
aucun qui le contienne.

Si `which ogr2ogr` affiche un chemin, un logiciel du poste, comme GDAL ou QGIS, a placé ce programme
dans un dossier de `PATH`. La suite du TD ne change pas.

## Solution de l'étape 4

`python -c` exécute le texte qui suit. `sys.executable` contient le chemin de l'interpréteur, et
`sys.path` la liste des dossiers où `import` cherche un module. `__file__` contient le chemin du
fichier d'un module.

Les commandes affichent ces chemins :

| Fichier | Dossier | Nature |
|---|---|---|
| `python.exe` | `C:\ProgramData\anaconda3\ ` | l'interpréteur |
| `argparse.py` | `C:\ProgramData\anaconda3\Lib\ ` | la bibliothèque standard |
| `numpy\__init__.py` | `C:\ProgramData\anaconda3\Lib\site-packages\ ` | une bibliothèque installée |
| `pandoc` | `/c/ProgramData/anaconda3/Library/bin/` | un programme en ligne de commande |

La liste de `sys.path` commence par une ligne vide, qui désigne le dossier courant. Elle contient
`C:\ProgramData\anaconda3\Lib` et `C:\ProgramData\anaconda3\Lib\site-packages`. Tous ces chemins
sont dans le dossier d'Anaconda, `C:\ProgramData\anaconda3`.

`which` affiche un chemin de Git Bash, en `/c/…`, et Python un chemin de Windows, en `C:\…`. Les deux
formes désignent le même dossier.

Si ces chemins ne sont pas dans `anaconda3`, l'invite ne commence sans doute pas par `(base)` : voir
l'annexe « Problèmes avec Anaconda », cas A3.

## Solution de l'étape 5

`conda create` crée un dossier, et y installe Python et les paquets demandés. Les options de cette
commande sont :

| Option | Effet |
|---|---|
| `-y` | répond oui à la question de confirmation, et lance aussitôt le téléchargement |
| `-n carte` | nomme l'environnement `carte` |
| `-c conda-forge` | cherche les paquets dans le dépôt conda-forge |
| `python=3.12 gdal folium` | demande Python 3.12, GDAL et `folium` |

`conda` calcule la liste complète des dépendances, soit environ 90 paquets. La partie 4 de l'exposé
explique cette commande, et le TD 5b reprend ce terminal.

Si le second terminal affiche `CondaHTTPError`, voir l'annexe « Problèmes avec Anaconda », cas A9,
puis relancer la commande. Si `conda` demande d'accepter les conditions d'utilisation
(`Do you accept the Terms of Service (ToS)…`), ou s'arrête sur `CondaToSNonInteractiveError`, voir
le cas A10 de la même annexe. Si le terminal est fermé avant la fin, relancer aussi la commande.
