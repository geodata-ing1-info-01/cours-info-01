---
title: Travaux dirigés de la séance 3
subtitle: Les notebooks et le programme de la séance, rangés par partie
---

Chaque TD a son dossier dans l'archive `cours3/` de la séance, avec ses
données et sa feuille en PDF, `td_<dossier>.pdf`. Les TD 1a et 2a sont des
notebooks autonomes : un texte explicatif par section, et une réponse repliée
sous chaque ligne à compléter. Ils sont livrés dans `depart/notebook/`, et se
copient dans `travail/` avant d'être ouverts dans JupyterLab. Pour la dernière
partie, chaque élève choisit un parcours : le TD 3a, parcours avancé, ou le
TD 3b, parcours standard. Les deux se font dans VS Code, avec un terminal Git
Bash, et leur guide détaillé est livré dans leur dossier.

## Préparation du poste de travail

- TD 0a, 10 minutes, et 15 minutes de plus selon les groupes : récupérer
  l'archive de la séance et vérifier que JupyterLab et l'éditeur se lancent ;
  selon les groupes, créer l'environnement conda de la séance,
  `info01-cours3`, avec JupyterLab, pandoc et Pillow.

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

- TD 3a, parcours avancé, `3a_cli/`, `recette.py`, 45 minutes : le code du
  notebook dans un fichier, une fonction `main`, les arguments avec
  `argparse`, un README ; un commit par étape ([page de la
  partie](03_du_notebook_au_programme.md)).
- TD 3b, parcours standard, `3b_markdown/`, 45 minutes : la recette des
  gaufres écrite en Markdown, sa page produite par le programme du TD 1a, un
  dépôt git qui ne contient que la recette, et un diagramme Mermaid. Le TD
  reprend le TD 3a Markdown du cours 1. Le parcours standard fait le TD 3a
  au projet 4.
