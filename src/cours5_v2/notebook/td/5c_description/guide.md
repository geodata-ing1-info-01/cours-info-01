---
title: "TD 5c — Décrire l'installation pour un autre poste"
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

Copier le contenu des fichiers depuis `guide_5c_description.html`, ouvert dans un navigateur. Copié
depuis le PDF, ce contenu perd ses indentations.

# Présentation du TD

## Objectif du TD

Les commandes du TD 5b ne sont enregistrées nulle part dans le projet. Une autre personne qui reçoit
le dossier ne sait pas quoi installer. Il faut donc décrire l'installation dans deux fichiers,
`environment.yml` et `README.md`. Pour vérifier cette description, il faut ensuite supprimer
l'environnement, puis le recréer à partir de ces fichiers.

Un dossier neuf, `nouveau_poste/`, remplace ici un autre poste. Il ne reçoit que les fichiers du projet.

## Les étapes

Le TD dure vingt minutes, sans l'étape facultative.

1. Fichier environment.yml.
2. Fichier README.md.
3. Suppression de l'environnement.
4. Recréation de l'environnement.
5. Fichier pyproject.toml, étape facultative.

### Les notions employées

| Notion | Diapositive |
|---|---|
| `README` et `environment.yml` | « Environnement : README ou environment.yml » |
| `pyproject.toml` | « Projet : déclaration des informations & métadonnées » |
| choix entre les deux fichiers | « Fichiers de projet : environment.yml et pyproject.toml » |
| commandes `conda` | « Commandes conda : résumé » |

# Énoncé

## Étape 1 · Fichier environment.yml

> **Objectif :** décrire l'environnement `carte` dans `travail/environment.yml`.

**Consignes**

1. Ouvrir le dossier du TD dans VS Code : menu File, Open Folder…,
   `Desktop\info01\cours5\5c_description`, puis « Yes, I trust the authors ».
2. Ouvrir un terminal, y activer l'environnement, et copier les fichiers du TD dans `travail/` : menu
   Terminal, New Terminal.

   ```text
   conda activate carte
   cp depart/* travail/
   cd travail
   ```

3. Dans VS Code, créer le fichier `environment.yml` dans `travail`, y écrire ces lignes, puis
   enregistrer : explorateur, clic droit sur `travail`, New File…, nom `environment.yml`, puis
   `Ctrl` + `S`.

   ```yaml
   name: carte
   channels:
     - conda-forge
   dependencies:
     - python=3.12
     - gdal
     - folium
   ```

4. Lister le dossier :

   ```text
   ls
   ```

**Test**

`ls` affiche `carte_trace.py`, `environment.yml`, `stats_trace.py` et `trace_2.gpx`.

Si `ls` n'affiche pas `environment.yml`, voir la [solution de l'étape 1](#solution-de-létape-1).

## Étape 2 · Fichier README.md

> **Objectif :** écrire dans `travail/README.md` les commandes d'installation et d'utilisation.

**Consignes**

1. Dans VS Code, créer le fichier `README.md` dans `travail`, y écrire ces lignes, puis enregistrer :
   explorateur, clic droit sur `travail`, New File…, nom `README.md`, puis `Ctrl` + `S`.

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

**Test**

L'aperçu affiche un titre, un paragraphe et deux sections, avec les commandes dans des blocs de code.

## Étape 3 · Suppression de l'environnement

> **Objectif :** supprimer l'environnement `carte`, pour le recréer ensuite à partir de
> `environment.yml`.

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

## Étape 4 · Recréation de l'environnement

> **Objectif :** copier le projet dans `nouveau_poste/`, y recréer `carte` à partir de
> `environment.yml`, et y lancer `carte_trace.py`.

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

## Étape 5 (facultative) · Fichier pyproject.toml

> **Objectif :** décrire le projet dans `nouveau_poste/pyproject.toml`, puis l'installer avec `pip`.

**Consignes**

1. Dans VS Code, créer le fichier `pyproject.toml` dans `nouveau_poste`, y écrire ces lignes, puis
   enregistrer : explorateur, clic droit sur `nouveau_poste`, New File…, nom `pyproject.toml`, puis
   `Ctrl` + `S`.

   ```toml
   [project]
   name = "carte-trace"
   version = "0.1"
   requires-python = ">=3.10"
   dependencies = ["folium>=0.20"]

   [tool.setuptools]
   py-modules = ["carte_trace", "stats_trace"]
   ```

2. Installer le projet :

   ```text
   pip install .
   ```

3. Afficher sa description :

   ```text
   pip show carte-trace
   ```

**Test**

`pip install .` affiche `Requirement already satisfied: folium>=0.20`, et se termine par
`Successfully installed carte-trace-0.1`. `pip show carte-trace` affiche `Version: 0.1` et
`Requires: folium`.

# Solutions

## Solution de l'étape 1

`conda` lit dans `environment.yml` :

| Clé | Rôle |
|---|---|
| `name` | le nom de l'environnement à créer |
| `channels` | le dépôt où chercher les paquets, comme l'option `-c` |
| `dependencies` | les paquets demandés, comme à la fin de `conda create` |

Le fichier ne contient que les paquets demandés. `conda` calcule les autres, et le même fichier sert
donc sous Windows et sous Linux, où les paquets compilés diffèrent.

La consigne 1 ouvre dans VS Code le dossier du TD 5c, et son explorateur montre `travail/`, où la
consigne 3 crée le fichier. Si `ls` n'affiche pas `environment.yml`, le fichier a été créé dans un
autre dossier : dans l'explorateur de VS Code, le faire glisser sur `travail`.

## Solution de l'étape 2

En Markdown, une ligne qui commence par `#` ou `##` est un titre, et une ligne qui commence par
quatre espaces appartient à un bloc de code. L'autre personne lit la section Installation, puis tape
ces commandes.

Sans `environment.yml`, cette section contiendrait la commande `conda create` complète, avec la liste
des paquets.

## Solution de l'étape 3

`conda env remove` supprime le dossier de l'environnement. L'option `-y` répond oui à la question de
confirmation. `conda` garde les paquets téléchargés dans son cache, et l'étape suivante n'a donc pas
à les télécharger de nouveau.

Si la commande affiche `CondaEnvironmentError: Cannot remove current environment`, l'environnement
est encore actif : lancer `conda deactivate`, puis relancer la suppression.

## Solution de l'étape 4

`cp` copie ici les cinq fichiers du projet. `conda env create -f environment.yml` lit le nom et la
liste des paquets dans le fichier, puis crée l'environnement. Sur ce poste, les paquets sont restés
dans le cache de `conda` après la suppression de l'étape 3. Sur un autre poste, la commande les
télécharge d'abord.

Si `conda env create` affiche une erreur :

- `EnvironmentFileNotFound`, suivi d'un chemin : le terminal n'est pas dans le dossier du fichier.
  `pwd` affiche le dossier courant, qui doit se terminer par `nouveau_poste`.
- `ArgumentError: The environment file(s) do not specify a name or prefix` : `conda` n'a pas pu lire
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
