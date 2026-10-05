---
title: "Séance 2, 2026 — Ligne de commande et git local"
---

:::{note}
Séance jouée le 22 septembre 2026, gardée en archive. La version en cours de
la séance 2 est dans la partie « Séances ».
:::

## Contenu de la séance

Quatre parties : la ligne de commande, puis git sur un seul poste, du premier
commit jusqu'à la publication d'une version. Chaque page de partie renvoie à
ses TD. Les cinq TD construisent un même projet, une petite calculatrice en
Python, et chacun le reprend là où le précédent l'a laissé.

```{list-table}
:header-rows: 1

* - Partie
  - Ce qu'on y voit
* - [La ligne de commande](notebook/01_ligne_de_commande.md)
  - le terminal, la forme d'une commande, les commandes de base, les chemins
    et les motifs de noms de fichiers
* - [Git et le dépôt local](notebook/02_depot_local.md)
  - à quoi sert git, le dépôt, le commit, le cycle de vie d'un fichier,
    annuler et étiqueter un commit
* - [Branches, fusion et conflits](notebook/03_branches.md)
  - les branches, HEAD, le merge et le rebase, les conflits et leur
    résolution
* - [Lire et tenir un dépôt](notebook/04_lire_et_tenir_un_depot.md)
  - le graphe des commits, `git diff`, `git status`, le fichier
    `.gitignore`, et les règles d'un dépôt lisible
```

Les guides détaillés des TD sont réunis, par partie, dans [Travaux dirigés
de la séance 2](notebook/travaux_diriges.md).

Le support de la séance est celui de Florent Geniet, *Introduction à
l'informatique : lignes de commandes et git* (22 septembre 2026).

## Avant la séance

Les fichiers des TD sont dans l'archive `cours2/` remise avec la séance : un
dossier par TD, et dans chacun la feuille du TD en PDF. L'archive se récupère
depuis le dossier partagé, comme décrit dans [Récupérer les fichiers d'une
séance](../avant/donnees.md).

La séance se fait dans un terminal bash, avec git. La page [Git et Git
Bash](../annexes/configuration/git.md) décrit comment l'ouvrir sur les
postes de la salle, et comment régler le nom et l'adresse qui signent les
commits.

```{toctree}
:maxdepth: 1

notebook/01_ligne_de_commande
notebook/02_depot_local
notebook/03_branches
notebook/04_lire_et_tenir_un_depot
notebook/travaux_diriges
```
