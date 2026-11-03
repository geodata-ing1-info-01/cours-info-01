---
title: "Séance 4 — Projet d'application 1"
---

## Objectifs

Revoir, sur un petit programme, les opérations des cours 1 à 3 : le
terminal, VS Code, git, puis un programme Python qui lit et écrit des
fichiers et lit ses arguments sur la ligne de commande. Le parcours avancé
donne ensuite au programme la forme d'un projet Python installable. Chaque
élève garde le parcours choisi au cours 3.

## Contenu de la séance

```{list-table}
:header-rows: 1

* - Parcours
  - Ce qu'on fait
  - Durée
* - Tous
  - présentation de la séance
  - 5 min
* - Standard
  - TD 4a : le dossier du projet dans le terminal, VS Code, le dépôt git ;
    puis le programme `recette.py`, une étape par notion, un commit par
    étape
  - 30 + 75 min
* - Avancé
  - TD 4a plus vite ; un exposé sur les modules, les environnements et les
    commandes installées ; puis TD 4b : un programme installable
  - 50 + 10 + 55 min
```

Les TD sont réunis dans [Travaux dirigés du projet
4](notebook/travaux_diriges.md).

## Avant la séance

Les fichiers des TD sont dans l'archive `cours4/` : un dossier par TD, avec
la feuille du TD en PDF et le guide détaillé. L'archive se récupère depuis
le dossier partagé, comme décrit dans [Récupérer les fichiers d'une
séance](../avant/donnees.md). Le TD 4b crée un environnement conda depuis un
fichier `environment.yml` : la création télécharge les paquets et prend
quelques minutes.

## Parcours avancé : un projet Python

Un fichier Python est un module. `import` exécute le module une fois, et
ses noms sont ensuite utilisables dans le fichier qui l'importe. Python
cherche un module dans le dossier du fichier lancé, puis dans la
bibliothèque standard et dans les paquets de l'environnement actif.

Un environnement conda est un dossier qui contient un Python et des
paquets. `conda activate` place ses dossiers en tête de `PATH`, et `python`
désigne alors le Python de l'environnement. Le fichier `environment.yml`
décrit l'environnement d'un projet. Versionné avec le code, il permet de
recréer l'environnement sur un autre poste.

`pyproject.toml` est la fiche du projet, lue par pip. Sa section
`[project.scripts]` déclare les commandes à installer :
`recette = "recette:main"` fait de `recette` une commande qui appelle la
fonction `main` du module `recette`. `pip install -e .` installe le projet
du dossier courant en mode modifiable.

## Ce qu'on rend

Le dossier du projet, avec son historique git.

```{list-table}
:header-rows: 1

* - Commande
  - Parcours standard
  - Parcours avancé
* - `git log --oneline`
  - huit commits, neuf avec le bonus
  - douze commits au moins
* - `git status`
  - « rien à valider » ; `sortie/` n'est pas listé
  - « rien à valider » ; `sortie/` n'est pas listé
* - l'aide
  - `python recette.py --help`
  - `recette --help`
* - le résultat
  - `sortie/crepes_6_US.csv`
  - le même, et `environment.yml`, `pyproject.toml`
```

```{toctree}
:maxdepth: 1

notebook/travaux_diriges
```
