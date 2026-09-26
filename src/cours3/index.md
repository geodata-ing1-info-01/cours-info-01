---
title: "Séance 3 — Chemins, fichiers, images et ligne de commande"
---

:::{note} Premier jet
Diapositives et notebooks rédigés le 20 septembre 2026 ; les pages de cours
de cette séance restent à écrire sur le modèle de `src/cours1/notebook/`.
:::

## Objectifs

Manipuler des chemins et lire des fichiers en Python, puis construire un
programme en ligne de commande en Python. Les notions des cours 1 et 2
(chemin relatif, encodage, texte et binaire, lancer un programme, les options
d'une commande, un commit par étape) reviennent, vues cette fois depuis le
code.

## Contenu de la séance

Deux notebooks autonomes, chacun présenté par quelques
diapositives, la première section d'un troisième sur ASCII et UTF-8, puis un
programme écrit dans l'éditeur et lancé au terminal.

```{list-table}
:header-rows: 1

* - Partie
  - Ce qu'on y fait
  - Durée
* - Préparation du poste de travail
  - récupérer l'archive du dossier partagé sur le Bureau ; vérifier que JupyterLab et l'éditeur se lancent
  - 10 min
* - Chemins et programmes externes
  - améliorer le code de génération de recette : chemins en dur, `pathlib`, pandoc appelé par `subprocess`
  - 20 min
* - Fichiers texte et encodage
  - `open`, `with`, les modes d'ouverture ; ASCII et UTF-8, ce qu'un caractère pèse
  - 45 min
* - Ligne de commande
  - le notebook devient un programme : un fichier, `main`, `argparse`, un README, un commit par étape
  - 45 min
```

## Avant la séance

Les fichiers des TD sont dans l'archive `cours3/` : un dossier par TD, avec
ses propres données et la feuille du TD en PDF. Rien à installer : Python,
JupyterLab, Pillow et pandoc sont dans l'environnement `base` d'Anaconda, et
ImageMagick est livré dans `3a_cli/depart/outils/` sous la forme d'un seul
exécutable.

L'archive vient du dossier partagé `formationTemp` ; elle se copie et se
décompresse dans le dossier `info01` du Bureau ([Récupérer les fichiers
d'une séance](../avant/donnees.md)), et rien ne se fait dans le dossier
partagé ni depuis l'archive. Les notebooks, livrés dans `depart/notebook/`, se copient
dans `travail/` avant d'être ouverts dans JupyterLab, depuis Anaconda
Navigator ou par `jupyter lab` dans Anaconda Prompt. Une ligne de code terminée par `# à compléter` est à
écrire en séance ; sa réponse est repliée dans la cellule « Réponse » qui la
suit, et la version complète est distribuée après.

| TD | Fichier | Ce qu'on y fait |
|---|---|---|
| 1a | `recette.ipynb` | le code de génération de recette, ses chemins refaits avec `pathlib`, converti par pandoc |
| 2a | `fichiers.ipynb` | comment le code de la recette ouvre, lit et écrit ses fichiers ; octets, ASCII et UTF-8, fin de ligne, mode binaire |
| 2b | `images.ipynb` | facultatif : un motif PGM de seize pixels en texte et en binaire, *La Grande Vague* en cinq formats, la compression |
| 3a | `recette.py` | le code du notebook dans un fichier, puis `main`, `argparse`, un README ; un commit par étape |

Les images sont libres : *Under the Wave off Kanagawa*
(The Met, CC0), photos de Wikimedia Commons créditées dans
`recettes/CREDITS.md`.
