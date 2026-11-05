---
title: "Séance 2, version 2 — Éditeur de code et git local"
---

:::{note}
Version 2 de la séance 2, en cours de construction pour l'année 2027-2028,
écrite en septembre 2026 à partir des retours sur la séance 2. La séance
jouée en 2026 est dans la partie « Archive 2026 ». Le TD git de cette
version peut servir à réviser git.
:::

## Contenu de la séance

L'éditeur de code est présenté, puis configuré par toute la salle en même
temps. Le reste de la séance se fait dans l'éditeur, avec son terminal Git
Bash.

```{list-table}
:header-rows: 1

* - Partie
  - Ce qu'on y voit
  - TD
* - [L'éditeur de code](notebook/01_editeur_de_code.md)
  - les fonctions d'un IDE, la coloration, la chasse fixe, l'indentation en
    espaces ou en tabulations ; la fenêtre de VS Code et sa configuration
    (l'extension Python, l'interpréteur, Git Bash comme terminal, les
    réglages User et Workspace) ; trois programmes fautifs à corriger
  - 2a, en classe entière ; 2b
* - [Git et le dépôt local](notebook/03_git_local.md)
  - les systèmes de version et les copies d'un dépôt ; la commande git et
    son aide ; le dépôt, l'index et le commit, `status`, `log`, `diff`,
    `restore`, le README, `.gitignore`
  - 2c, étapes 0 à 4
* - [Branches, fusion et conflits](notebook/04_branches.md)
  - les branches, la fusion et les conflits ; l'organisation des branches
    à plusieurs
  - 2c, étapes 5 à 7
```

Les guides détaillés des TD sont réunis dans [Travaux dirigés de la
séance 2, version 2](notebook/travaux_diriges.md).

## Ce qui change par rapport à 2026

La version 2 suit le syllabus v2 du module, `syllabus/02_syllabus_v2.md`
dans le dépôt :

- la ligne de commande passe au cours 1, avec un TD ;
- la configuration de VS Code arrive du cours 1, faite en classe entière,
  avec Git Bash comme terminal ;
- git se joue sur un seul dépôt, celui d'`altitudes.py`, le programme du cours 1,
  à la place des cinq TD sur le projet `projet_2` ; ce programme y gagne ses
  calculs, et un README ;
- `revert` et `rebase` restent dans la séance 2 de 2026, dans l'archive du
  book ; `tag` passe au projet 7 ;
  l'organisation main, develop, feature est gardée, en théorie ;
- l'aspect distribué de git est présenté en théorie ; il se pratique au
  cours 6, et à l'étape 7 du TD git pour ceux qui ont fini.

Les diapositives sont dans le dépôt, `src/cours2_v2/diapo/cours2_v2.pdf`.

```{toctree}
:maxdepth: 1

notebook/01_editeur_de_code
notebook/03_git_local
notebook/04_branches
notebook/travaux_diriges
```
