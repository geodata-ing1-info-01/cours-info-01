---
title: "Séance 3 — Chemins, fichiers et ligne de commande"
---

## Objectifs

Manipuler des chemins et lire des fichiers en Python, puis construire un
programme en ligne de commande en Python. Les notions des cours 1 et 2
(chemin relatif, encodage, texte et binaire, lancer un programme, les options
d'une commande, un commit par étape) reviennent, vues cette fois depuis le
code.

## Contenu de la séance

Trois parties, chacune présentée par quelques diapositives, puis travaillée
dans un TD. Les deux premières s'accompagnent d'un notebook autonome, commun
à tous. Pour la troisième, chaque élève choisit un parcours : le parcours
avancé écrit un programme lancé au terminal (TD 3b), le parcours standard
écrit une recette en Markdown, mise en page par le programme du TD 1a
(TD 3a).

```{list-table}
:header-rows: 1

* - Partie
  - Ce qu'on y voit
  - Durée
* - Préparation du poste de travail
  - récupérer l'archive du dossier partagé sur le Bureau ; copier les deux
    notebooks dans `travail/` ; ouvrir JupyterLab sur le dossier `cours3/`
  - 10 min
* - [Chemins et programmes externes](notebook/01_chemins_programmes.md)
  - le programme de la recette, ses chemins construits avec `pathlib`,
    pandoc lancé par `subprocess`
  - 20 min
* - [Fichiers et encodage](notebook/02_fichiers_encodage.md)
  - lire et écrire un fichier, `with`, les modes ; le texte comme suite de
    caractères, les octets, ASCII et UTF-8, la fin de ligne, le mode binaire
  - 30 min
* - Une recette en Markdown, parcours standard
  - la recette des gaufres, écrite en Markdown et ajoutée à un dépôt git de recettes, et sa page
  - 45 min
* - [Du notebook au programme](notebook/03_du_notebook_au_programme.md),
    parcours avancé
  - selon les groupes, l'environnement de la séance ; le notebook devient un
    programme : un fichier, `argparse`, un README, puis `main` en bonus ; un commit par étape
  - 45 min, +15 min
```

Les TD sont réunis, par partie, dans [Travaux dirigés de la séance
3](notebook/travaux_diriges.md).

## Avant la séance

Les fichiers des TD sont dans l'archive `cours3/` : un dossier par TD, avec
ses propres données et la feuille du TD en PDF. Python, JupyterLab, Pillow et
pandoc sont dans l'environnement `base` d'Anaconda. Selon les groupes, le TD
3b commence par créer un environnement de la séance, `info01-cours3`, en une
commande dans l'invite de commandes d'Anaconda.

L'archive vient du dossier partagé `formationTemp` ; elle se copie et se
décompresse dans le dossier `info01` du Bureau ([Récupérer les fichiers
d'une séance](../avant/donnees.md)), et rien ne se fait dans le dossier
partagé ni depuis l'archive. Les notebooks, livrés dans `depart/notebook/`,
se copient dans `travail/` avant d'être ouverts dans JupyterLab, depuis
Anaconda Navigator ou par `jupyter lab` dans l'invite de commandes d'Anaconda. Une ligne de
code terminée par `# à compléter` est à écrire en séance ; sa réponse est
repliée dans la cellule « Réponse » qui la suit, et la version complète est
distribuée après.

| TD | Fichier | Ce qu'on y fait |
|---|---|---|
| 1a | `recette.ipynb` | le code de génération de recette, ses chemins refaits avec `pathlib`, converti par pandoc |
| 2a | `fichiers.ipynb` | comment le code de la recette ouvre, lit et écrit ses fichiers ; octets, ASCII et UTF-8, fin de ligne, mode binaire |
| 2b | `images.ipynb` | facultatif : un motif PGM de seize pixels en texte et en binaire, *La Grande Vague* en cinq formats, la compression |
| 3a | `recette.md` | parcours standard : la recette des gaufres, écrite en Markdown et ajoutée à un dépôt git de recettes, et sa page |
| 3b | `recette.py` | parcours avancé : le code du notebook dans un fichier, puis `argparse`, un README et, en bonus, `main` ; un commit par étape |

Les images sont libres : *Under the Wave off Kanagawa*
(The Met, CC0), photos de Wikimedia Commons créditées dans
`recettes/CREDITS.md` ; la photo des gaufres est dans le domaine public.

## À retenir

```{list-table}
:header-rows: 0

* - Un chemin relatif
  - part du dossier courant : celui du notebook, ou celui du terminal
* - `Path(__file__).parent`
  - le dossier du script, d'où qu'on le lance
* - `encoding="utf-8"`
  - dans chaque lecture et chaque écriture de texte
* - `subprocess.run([...])`
  - un programme externe, appelé depuis Python, en liste
* - Un caractère
  - un nombre ; ASCII en a 128, sur un octet ; UTF-8 écrit les autres sur
    deux à quatre
* - `argparse`
  - les valeurs sur la ligne de commande, vérifiées, et l'aide de `--help`
* - Un environnement conda
  - un Python et ses paquets ; `conda create -n nom … paquets` le crée avec
    eux (TD 3b, selon les groupes)
```

```{toctree}
:maxdepth: 1

notebook/01_chemins_programmes
notebook/02_fichiers_encodage
notebook/03_du_notebook_au_programme
notebook/travaux_diriges
```
