---
title: "TD 5c — Décrire l'installation pour un autre poste"
subtitle: Présentation, énoncé et solutions (version 2, proposition)
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

*Version 2 du cours 5 : proposition de travail pour 2027-2028. Les messages et les durées de ce guide
sont relevés sous Linux avec conda 26.7. Ils restent à relever sur un poste de la salle.*

Ce guide a trois parties. La présentation décrit le but du TD et ses étapes. L'énoncé donne, pour
chaque étape, l'objectif, les consignes et le test à faire. Les solutions expliquent chaque
commande, et donnent la marche à suivre si le résultat diffère.

Le contenu des fichiers de ce guide se copie depuis `guide_5c_description.html`, ouvert dans un
navigateur. Copié depuis le PDF, il perd ses indentations.

# Présentation du TD

## Objectif du TD

Les commandes du TD 5b ne sont enregistrées nulle part dans le projet. Une autre personne qui reçoit
le dossier ne sait pas quoi installer. Il faut donc décrire l'installation dans deux fichiers,
`environment.yml` et `README.md`. Pour vérifier cette description, il faut ensuite supprimer
l'environnement, puis le recréer à partir de ces fichiers.

Un dossier neuf, `nouveau_poste/`, remplace ici un autre poste. Il ne reçoit que les fichiers du projet.

## Les étapes

Le TD dure vingt minutes, sans l'étape facultative.

1. Écrire le fichier `environment.yml`.
2. Écrire le fichier `README.md`.
3. Supprimer l'environnement.
4. Recréer l'environnement dans un autre dossier.
5. Écrire le fichier `pyproject.toml`, étape facultative.

### Les notions employées

| Notion | Diapositive |
|---|---|
| `README` et `environment.yml` | « Environnement : README ou environment.yml » |
| `pyproject.toml` | « Projet : déclaration des informations & métadonnées » |
| choix entre les deux fichiers | « Fichiers de projet : environment.yml et pyproject.toml » |

# Énoncé

## Étape 1 · Écrire le fichier environment.yml

> **Objectif :** décrire l'environnement du programme dans un fichier lu par `conda`.

**Consignes**

1. Aller dans le dossier du TD, et copier ses fichiers dans `travail/` :

   ```text
   cd ../../5c_description
   cp depart/* travail/
   cd travail
   ```

2. Dans VS Code, créer le fichier `environment.yml` dans `travail/`, avec ces lignes : menu File,
   New File…

   ```yaml
   name: carte
   channels:
     - conda-forge
   dependencies:
     - python=3.12
     - gdal
     - folium
   ```

3. Enregistrer le fichier : `Ctrl` + `S`.
4. Lister le dossier :

   ```text
   ls
   ```

**Test**

`ls` affiche `carte_trace.py`, `environment.yml`, `stats_trace.py` et `trace_2.gpx`.

## Étape 2 · Écrire le fichier README.md

> **Objectif :** dire à une autre personne comment installer et lancer le programme.

**Consignes**

1. Dans VS Code, créer le fichier `README.md` dans `travail/`, avec ces lignes : menu File, New File…

   ```markdown
   # carte-trace

   Ce programme résume une trace GPX, et écrit une carte de cette trace dans une page web.

   ## Installation

       conda env create -f environment.yml
       conda activate carte

   ## Utilisation

       python carte_trace.py trace_2.gpx
   ```

2. Afficher l'aperçu : `Ctrl` + `Maj` + `V`.
3. Enregistrer le fichier : `Ctrl` + `S`.

**Test**

L'aperçu affiche un titre, un paragraphe et deux sections, avec les commandes dans des blocs de code.

## Étape 3 · Supprimer l'environnement

> **Objectif :** revenir à l'état d'un poste qui n'a pas l'environnement.

**Consignes**

1. Désactiver l'environnement :

   ```text
   conda deactivate
   ```

2. Supprimer l'environnement :

   ```text
   conda env remove -y -n carte
   ```

3. Afficher les environnements :

   ```text
   conda env list
   ```

**Test**

L'invite commence par `(base)`. `conda env list` affiche `base`, sans `carte`.

Si la suppression affiche une erreur, voir la [solution de l'étape 3](#solution-de-létape-3).

## Étape 4 · Recréer l'environnement dans un autre dossier

> **Objectif :** refaire l'installation à partir des seuls fichiers du projet, en suivant le `README.md`.

**Consignes**

1. Créer le dossier `nouveau_poste/`, et y copier les fichiers du projet :

   ```text
   mkdir ../nouveau_poste
   cp carte_trace.py stats_trace.py trace_2.gpx environment.yml README.md ../nouveau_poste/
   cd ../nouveau_poste
   ```

2. Suivre la section Installation du `README.md` :

   ```text
   conda env create -f environment.yml
   conda activate carte
   ```

3. Suivre la section Utilisation du `README.md` :

   ```text
   python carte_trace.py trace_2.gpx
   ```

**Test**

L'invite commence par `(carte)`, et le programme se termine par `carte écrite : trace_2.html`.

Si `conda env create` affiche une erreur, voir la [solution de l'étape 4](#solution-de-létape-4).

## Étape 5 (facultative) · Écrire le fichier pyproject.toml

> **Objectif :** décrire le projet lui-même, dans le fichier lu par `pip`.

**Consignes**

1. Dans VS Code, créer le fichier `pyproject.toml` dans `nouveau_poste/`, avec ces lignes : menu File,
   New File…

   ```toml
   [project]
   name = "carte-trace"
   version = "0.1"
   requires-python = ">=3.10"
   dependencies = ["folium>=0.20"]

   [tool.setuptools]
   py-modules = ["carte_trace", "stats_trace"]
   ```

2. Enregistrer le fichier : `Ctrl` + `S`.
3. Installer le projet :

   ```text
   pip install .
   ```

4. Afficher sa description :

   ```text
   pip show carte-trace
   ```

**Test**

`pip install .` affiche `Requirement already satisfied: folium>=0.20`, et se termine par
`Successfully installed carte-trace-0.1`. `pip show carte-trace` affiche `Version: 0.1` et
`Requires: folium`.

# Solutions

## Solution de l'étape 1

`conda` lit trois informations dans `environment.yml` :

| Clé | Rôle |
|---|---|
| `name` | le nom de l'environnement à créer |
| `channels` | le dépôt où chercher les paquets, comme l'option `-c` |
| `dependencies` | les paquets demandés, comme à la fin de `conda create` |

Le fichier ne contient que les paquets demandés. `conda` calcule les autres, et le même fichier sert
donc sous Windows et sous Linux, où les paquets compilés diffèrent.

## Solution de l'étape 2

`#` et `##` écrivent des titres en Markdown. Quatre espaces au début d'une ligne écrivent un bloc de
code. L'autre personne lit la section Installation, puis tape ces commandes.

Sans `environment.yml`, cette section contiendrait la commande `conda create` complète, avec la liste
des paquets.

## Solution de l'étape 3

`conda env remove` supprime le dossier de l'environnement. L'option `-y` répond oui à la question de
confirmation. `conda` garde les paquets téléchargés dans son cache, et l'étape suivante n'a donc pas
à les télécharger de nouveau.

Si la commande affiche `CondaEnvironmentError: Cannot remove current environment`, l'environnement
est encore actif : lancer `conda deactivate`, puis relancer la suppression.

## Solution de l'étape 4

`cp` copie ici les cinq fichiers du projet. `conda env create -f environment.yml` lit le nom et la liste des paquets dans le fichier, puis crée
l'environnement. Essayée sous Linux, cette commande dure 11 s avec des paquets déjà téléchargés. Sur
un autre poste, elle télécharge d'abord les paquets.

Cas d'erreur :

- **`EnvironmentFileNotFound`, suivi d'un chemin** : le terminal n'est pas dans le dossier du fichier.
  `pwd` affiche le dossier courant, qui doit se terminer par `nouveau_poste`.
- **`ArgumentError: The environment file(s) do not specify a name or prefix`** : `conda` n'a pas pu lire
  le fichier, qui contient par exemple une tabulation ou un deux-points manquant. Comparer le fichier
  aux lignes de l'énoncé.

## Solution de l'étape 5

`pyproject.toml` décrit le projet : son nom, sa version et les bibliothèques demandées par son code.
`pip install .` lit ce fichier dans le dossier courant, désigné par le point. `pip` trouve `folium` déjà
installé par `conda`, et n'installe que `carte-trace`.

GDAL n'apparaît pas dans ce fichier : le projet GDAL ne publie pas `ogr2ogr` sur PyPI. `carte_trace.py`
a donc besoin de `environment.yml`.

`pip install .` écrit aussi les dossiers `build/` et `carte_trace.egg-info/`, qui ne font pas partie du
projet.

Si `pip install .` affiche `Multiple top-level modules discovered in a flat-layout`, la section
`[tool.setuptools]` manque. Elle indique les fichiers du projet à installer.
