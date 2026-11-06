---
title: "TD 5a — Le dossier de votre Python"
subtitle: Présentation, énoncé et solutions (version 2, proposition)
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

*Version 2 du cours 5 : proposition de travail pour 2027-2028. Les sorties de ce guide sont
attendues sous Windows, d'après la disposition d'Anaconda, et restent à relever sur un poste de la
salle.*

Ce guide a trois parties. La présentation décrit le but du TD et ses étapes. L'énoncé donne, pour
chaque étape, l'objectif, les consignes et le test à faire. Les solutions expliquent chaque
commande, et donnent la marche à suivre si le résultat diffère.

# Présentation du TD

## Objectif du TD

`carte_trace.py` convertit une trace GPX avec le programme `ogr2ogr`, calcule ses statistiques avec
`stats_trace.py`, puis écrit une carte avec la bibliothèque `folium`. Un poste de la salle n'a ni
`ogr2ogr` ni `folium`.

Le TD consiste à constater ces deux manques, puis à relever où se trouvent l'interpréteur, les
bibliothèques et les programmes du poste. Il faut aussi lancer la création de l'environnement du
TD 5b. Cette commande dure plusieurs minutes, et continue pendant ce TD et pendant la partie 4 de
l'exposé.

## Les étapes

Le TD dure dix minutes.

1. Préparer la séance.
2. Lancer la création de l'environnement.
3. Lancer le programme.
4. Trouver les fichiers de Python.

### Les notions employées

| Notion | Diapositive |
|---|---|
| `which`, `PATH` | « Recherche d'un programme : variable PATH » |
| dossier d'une distribution, `site-packages` | « Dossier d'une distribution Python » |
| `sys.path` | « sys.path : recherche d'une bibliothèque » |

# Énoncé

## Étape 1 · Préparer la séance

> **Objectif :** copier les fichiers de la séance, et ouvrir un terminal dans VS Code.

**Consignes**

1. Copier l'archive `info01-cours5.zip` de `formationTemp` dans le dossier `info01` du Bureau.
2. Décompresser l'archive dans Git Bash :

   ```text
   cd ~/Desktop/info01
   unzip info01-cours5.zip
   ```

3. Lancer VS Code depuis le menu Démarrer, puis ouvrir le dossier de la séance : menu File,
   Open Folder…, `Desktop\info01\cours5`.
4. Ouvrir un terminal : menu Terminal, New Terminal.

**Test**

L'invite du terminal est :

```text
(base)
eleve@POSTE MINGW64 ~/Desktop/info01/cours5
$
```

Si l'invite diffère, voir la [solution de l'étape 1](#solution-de-létape-1).

## Étape 2 · Lancer la création de l'environnement

> **Objectif :** lancer le téléchargement et l'installation des outils du TD 5b.

**Consignes**

1. Ouvrir un second terminal : menu Terminal, New Terminal.
2. Lancer la création de l'environnement `carte` :

   ```text
   conda create -y -n carte -c conda-forge python=3.12 gdal folium
   ```

3. Laisser cette commande tourner, et revenir au premier terminal : cliquer sur son nom, dans la
   liste des terminaux, à droite du panneau.

**Test**

Le second terminal affiche `Collecting package metadata`, puis `Solving environment`, puis la liste
des paquets et leur téléchargement.

Si la commande s'arrête sur une erreur, voir la [solution de l'étape 2](#solution-de-létape-2).

## Étape 3 · Lancer le programme

> **Objectif :** constater ce qui manque à `carte_trace.py`.

**Consignes**

1. Aller dans le dossier du TD, et copier ses fichiers dans `travail/` :

   ```text
   cd 5a_distribution
   cp depart/* travail/
   cd travail
   ```

2. Lancer le programme :

   ```text
   python carte_trace.py trace_2.gpx
   ```

3. Chercher le programme de conversion :

   ```text
   which ogr2ogr
   ```

**Test**

`python carte_trace.py trace_2.gpx` se termine par :

```text
ModuleNotFoundError: No module named 'folium'
```

`which ogr2ogr` affiche `no ogr2ogr in (…)`, suivi des dossiers de `PATH`.

## Étape 4 · Trouver les fichiers de Python

> **Objectif :** relever où le poste range l'interpréteur, les bibliothèques et les programmes.

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

**Test**

Tous les chemins affichés sont dans le dossier d'Anaconda, `C:\ProgramData\anaconda3`. La
[solution de l'étape 4](#solution-de-létape-4) donne le résultat de chaque commande.

# Solutions

## Solution de l'étape 1

`cd` entre dans le dossier `info01` du Bureau, et `unzip` y décompresse l'archive. VS Code ouvre
ensuite le dossier `cours5`, et son terminal part de ce dossier.

Si l'invite ne commence pas par `(base)`, voir le cas A3 de la page
[Problèmes avec Anaconda](../../../../annexes/problemes/anaconda.md). Si le terminal n'est pas Git
Bash, reprendre l'étape de configuration du TD 2a.

## Solution de l'étape 2

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

Si le second terminal affiche `CondaHTTPError`, voir le cas A9 de la page
[Problèmes avec Anaconda](../../../../annexes/problemes/anaconda.md), puis relancer la commande. Si
le terminal est fermé avant la fin, relancer aussi la commande.

## Solution de l'étape 3

`cp depart/* travail/` copie tous les fichiers de `depart/` dans `travail/`. Les commandes suivantes
portent sur cette copie, et `depart/` reste tel qu'il a été livré.

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
| `numpy` | `C:\ProgramData\anaconda3\Lib\site-packages\ ` | une bibliothèque installée |
| `pandoc` | `/c/ProgramData/anaconda3/Library/bin/` | un programme en ligne de commande |

`which` affiche un chemin de Git Bash, en `/c/…`, et Python un chemin de Windows, en `C:\…`. Les deux
formes désignent le même dossier.

Si ces chemins ne sont pas dans `anaconda3`, l'invite ne commence sans doute pas par `(base)` : voir
le cas A3 de la page [Problèmes avec Anaconda](../../../../annexes/problemes/anaconda.md).
