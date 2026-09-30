# Installer un projet Python, et décrire son installation — TD 1h, cours 1

La partie 3 explique ce qu'un projet Python contient en plus de son code : sa
documentation, les bibliothèques dont il dépend, et les fichiers de
configuration. `depart/recette/` en est un, complet sauf sur un point : rien
n'y dit comment l'installer.

| Dossier | Ce qu'il contient |
|---|---|
| `depart/recette/` | le projet, tel qu'il est fourni |
| `travail/` | vide : votre copie du projet, et ce que vous en tirez |

Copiez `depart/recette/` dans `travail/` avant de commencer. Le détail des
étapes est sur la feuille du TD ; ce qui est à écrire est listé dans le
`README` du projet.

## Deux sortes de dépendances

Le programme importe trois noms que Python ne fournit pas, et ils ne
s'installent pas de la même façon.

| | D'où ça vient | Comment ça s'installe |
|---|---|---|
| `markdown`, `tabulate` | du dépôt conda-forge | `conda install -c conda-forge markdown tabulate` |
| `recette` | du dossier du projet | `python -m pip install -e .` |

La seconde ligne est celle qu'on oublie. Une bibliothèque qu'on écrit soi-même
n'est sur aucun dépôt tant que personne ne l'y a publiée : elle s'installe
depuis son dossier, et le point de la commande le désigne. Le code étant sous
`src/`, `import recette` ne trouve rien tant que cette commande n'a pas été
passée.

## Ce que le TD fait constater

Dans un environnement neuf, `python recette_a_la_main.py` donne un
`ModuleNotFoundError` sur `markdown`. Les bibliothèques installées, la même
commande donne le même message sur `recette`. Deux fois la même phrase, deux
causes différentes : c'est le propos du TD.

La dernière étape efface l'environnement d'essai et le refait à partir des
fichiers que vous venez d'écrire. Une documentation d'installation qu'on n'a
pas suivie n'est pas vérifiée.
