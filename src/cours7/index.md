---
title: "Séance 7 — Une fonctionnalité de plus, par une pull request"
---

:::{note} Page à rédiger
Le plan ci-dessous est celui du document de conception
(`syllabus/cours/7_projet_effets/contenu_detaille.md`, 27/09/2026), qui
remplace le benchmark d'image du plan initial. Les guides et les
diapositives de la séance sont à écrire.
:::

## Objectif

Ajouter des fonctionnalités à son programme du projet 4, dans son dépôt
GitHub du cours 6, et les livrer par des pull requests. Une des
fonctionnalités se calcule avec numpy, sur un tableau de nombres. Chaque
élève garde le parcours choisi aux cours 3 et 4.

## Parcours standard : TD 7a, le livre de recettes

Le programme `recette.py` traite une recette par appel. Le TD le complète
pour en faire un livre de recettes.

```{list-table}
:header-rows: 1

* - Étape
  - Ce qu'on fait
  - Durée
* - C0
  - le dépôt, une branche, l'environnement du programme
  - 10 min
* - C1
  - `--toutes` : vingt recettes de plus, et toutes les pages en une
    commande (`glob`)
  - 20 min
* - C2
  - le sommaire, une page de liens vers toutes les recettes
  - 15 min
* - C3
  - la photo de chaque recette, réduite avec Pillow
  - 15 min
* - C4
  - `--frigo` : les recettes faisables avec les ingrédients qu'on a,
    calculées avec numpy
  - 30 min
* - PR
  - une pull request pour le livre, une pour le frigo, fusionnées sur le site
  - 10 min
```

## Parcours avancé : TD 7b, la scène complète du train

Le programme `train.py` n'a qu'un plan mobile. Le TD complète la scène du
clip.

```{list-table}
:header-rows: 1

* - Étape
  - Ce qu'on fait
  - Durée
* - C0
  - le dépôt, une branche, numpy et Pillow dans l'environnement `animation`
  - 10 min
* - C1
  - plusieurs plans, chacun à sa vitesse
  - 20 min
* - C2
  - les plans et leurs vitesses décrits dans `decor/plans.csv`
  - 15 min
* - C3
  - l'effet des poteaux, avec une boucle sur les pixels puis avec numpy ;
    le test d'égalité et le chronométrage
  - 35 min
* - C4
  - `--boucle` : une vidéo qui boucle sans saut
  - 15 min
* - PR
  - une pull request pour les plans, une pour les poteaux
  - 10 min
```

## Avant la séance

Garder son dépôt GitHub du cours 6. Qui n'en a pas, ou dont le programme ne
fonctionne pas, part d'un dépôt de référence (`recette` ou `train`) : le
cloner, puis le pousser vers un dépôt vide de son compte.
