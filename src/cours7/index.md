---
title: "Séance 7 — Projet d'application 2"
---

## Objectif

Reprendre un projet depuis GitHub, lui ajouter des fonctionnalités sur des
branches, et livrer chaque branche par une pull request, fusionnée sur le
site. Chaque élève garde son parcours.

## Parcours standard : TD 7a, compléter son projet, par des pull requests

Le TD part du programme `recette.py` du projet 4, publié au cours 6. Il lui
ajoute la page HTML de chaque recette, écrite par pandoc, puis toutes les
recettes et un sommaire.

```{list-table}
:header-rows: 1

* - Étape
  - Ce qu'on fait
  - Durée
* - D0
  - cloner son dépôt `recette`, relancer le programme
  - 15 min
* - D1
  - branche `page` : l'option `--page`, la page HTML d'une recette par
    pandoc
  - 25 min
* - D2
  - la pull request de `page`, fusionnée sur GitHub, puis `git pull`
  - 10 min
* - D3
  - branche `livre` : six recettes de plus, l'option `--toutes`
  - 20 min
* - D4
  - le sommaire, `sortie/index.html` ; la pull request de `livre`
  - 15 min
* - D5
  - bonus : les pages publiées avec GitHub Pages
  -
```

## Parcours avancé : TD 7b, reprendre et compléter le projet d'un autre

Le TD part du dépôt `train`, commencé par le module : un programme qui
fabrique la vidéo de deux plans du paysage, défilant sur un fond. Deux
diapositives présentent d'abord numpy : une image comme tableau de nombres,
et un masque de colonnes.

```{list-table}
:header-rows: 1

* - Étape
  - Ce qu'on fait
  - Durée
* - E0
  - cloner le dépôt `train`, le pousser vers son compte ; l'environnement
    `train` ; la vidéo
  - 20 min
* - E1
  - lire `decor/plans.csv` et la fonction `image`
  - 10 min
* - E2
  - deux branches, `fenetre` et `poteaux` ; la fenêtre, et sa pull request
  - 20 min
* - E3
  - les ombres des poteaux, un calque calculé avec numpy ; la pull request
    de `poteaux`, qui s'arrête sur un conflit, résolu sur le poste
  - 40 min
* - E4
  - bonus : un troisième plan, une ligne de plus dans `decor/plans.csv`
  -
```

## Avant la séance

Garder son dépôt GitHub du cours 6, et la clé SSH du cours 6 enregistrée
sur son compte. Qui n'a pas de dépôt `recette` utilisable part du dépôt de
référence : le cloner, puis le pousser vers un dépôt vide de son compte.
