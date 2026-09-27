---
title: "Séance 4 — Du notebook au programme, en deux parcours"
---

## Objectifs

Écrire un programme Python lancé en ligne de commande, versionné avec git.
Le parcours standard reprend le programme de la recette du cours 3 ; le
parcours avancé fabrique une courte vidéo animée. Chaque élève garde le
parcours choisi au cours 3.

## Contenu de la séance

```{list-table}
:header-rows: 1

* - Parcours
  - Ce qu'on fait
  - Durée
* - Tous
  - présentation des deux parcours
  - 10 min
* - [Standard](notebook/01_client_noyau.md)
  - TD 4a : le client et le noyau d'un notebook, un environnement pour le
    programme ; puis TD 4b : `recette.py` en ligne de commande, un commit
    par étape
  - 30 + 70 min
* - [Avancé](notebook/02_animation.md)
  - TD 4c : l'environnement `animation`, le notebook `train.ipynb`, puis le
    programme `train.py`, une branche par fonctionnalité
  - 35 + 70 min
* - Tous
  - une étiquette git sur la version finale, `git log`
  - 5 min
```

Les TD sont réunis dans [Travaux dirigés du projet
4](notebook/travaux_diriges.md).

## Avant la séance

Les fichiers des TD sont dans l'archive `cours4/` : un dossier par TD, avec
la feuille du TD en PDF et, pour les TD 4b et 4c, le guide détaillé.
L'archive se récupère depuis le dossier partagé, comme décrit dans
[Récupérer les fichiers d'une séance](../avant/donnees.md). Les deux
parcours créent un environnement conda depuis un fichier `environment.yml` :
la création télécharge les paquets et prend quelques minutes.

## Une version, une étiquette

Une étiquette git, un *tag*, nomme un commit. Posée sur la version finale du
programme, elle la retrouve sans chercher son identifiant :

```text
git tag -a v1.0 -m "Première version"
git tag
git log --oneline --graph --all
```

La première commande pose l'étiquette `v1.0` sur le commit courant, la
deuxième liste les étiquettes du dépôt, et la troisième montre l'étiquette à
côté du commit. Le cours 6 publie le dépôt, étiquette comprise.

## Ce qu'on rend

Le dossier du projet, avec son historique git : le code, le README, et pour
le train `environment.yml`, qui permettent de refaire le résultat sur un
autre poste.

```{list-table}
:header-rows: 1

* - Commande
  - Parcours standard, `recette.py`
  - Parcours avancé, `train.py`
* - `git log --oneline --graph --all`
  - six commits, et l'étiquette `v1.0`
  - dix commits, dont un de fusion, et l'étiquette `v1.0`
* - `git status`
  - « rien à valider » ; `sortie/` n'est pas listé
  - « rien à valider » ; `sortie/` n'est pas listé
* - `python <nom>.py --help`
  - les trois arguments et leur aide
  - les options des trois fonctionnalités
* - le résultat
  - `sortie/<recette>.html`
  - `sortie/train.mp4`
```

```{toctree}
:maxdepth: 1

notebook/01_client_noyau
notebook/02_animation
notebook/travaux_diriges
```
