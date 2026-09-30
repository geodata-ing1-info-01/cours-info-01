---
title: Travaux dirigés de la séance 3
subtitle: Les notebooks et le programme de la séance, rangés par partie
---

Chaque TD a son dossier dans l'archive `cours3/` de la séance, avec ses
données et sa feuille en PDF, `td_<dossier>.pdf`. Les TD 1a et 2a sont des
notebooks autonomes : un texte explicatif par section, et une réponse repliée
sous chaque ligne à compléter. Ils sont livrés dans `depart/notebook/`, et se
copient dans `travail/` avant d'être ouverts dans JupyterLab. Pour la dernière
partie, chaque élève choisit un parcours : le TD 3a, parcours standard, ou le
TD 3b, parcours avancé. Les deux se font dans VS Code, avec un terminal Git
Bash ; leur guide détaillé est livré dans leur dossier, en PDF, en page HTML
et en notebook, et il est aussi une page de ce site.

## Préparation du poste de travail

- TD 0a, 10 minutes : récupérer l'archive de la séance, copier les deux
  notebooks dans `travail/`, et ouvrir JupyterLab dans le dossier `cours3/`.

## Chemins et programmes externes

- TD 1a, `1a_recette/`, `recette.ipynb`, 20 minutes : le programme de la
  recette, ses chemins construits avec `pathlib`, puis pandoc lancé depuis
  Python ([page de la partie](01_chemins_programmes.md)).

## Fichiers et encodage

- TD 2a, `2a_fichiers/`, `fichiers.ipynb`, 30 minutes : lire et écrire un
  fichier, les caractères et leurs octets, ASCII et UTF-8, la fin de ligne, le
  mode binaire ([page de la partie](02_fichiers_encodage.md)).
- TD 2b, `2b_images/`, `images.ipynb`, facultatif : une image en texte et en
  binaire, les formats d'image, la compression.

## Dernière partie, au choix

- [TD 3a — Une recette en Markdown](td/3a_markdown/guide.md), parcours
  standard, `3a_markdown/`, 45 minutes : un dépôt git de recettes, créé à
  partir des recettes du TD 1a, auquel on ajoute la recette des gaufres,
  écrite en Markdown ; sa page, produite par le notebook du dépôt, qui
  reprend le programme du TD 1a ; un diagramme Mermaid. Le TD
  reprend le TD 3a Markdown du cours 1. Le projet 4 revoit, pour les deux
  parcours, le passage à un programme lancé depuis le terminal.
- [TD 3b — Une ligne de commande pour la recette](td/3b_cli/guide.md),
  parcours avancé, `3b_cli/`, 45 minutes : le code du notebook dans un
  fichier, les arguments avec `argparse`, un README et, en bonus, une
  fonction `main` ; un commit par étape ([page de la partie](03_du_notebook_au_programme.md)).
  Selon les groupes, le TD commence par la création de l'environnement conda
  de la séance, `info01-cours3`, avec pandoc et Pillow, 15 minutes de plus.

```{toctree}
:hidden:

td/3a_markdown/guide
td/3b_cli/guide
```
