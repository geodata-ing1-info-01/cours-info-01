---
title: Du notebook au programme
subtitle: Le code du notebook dans un fichier .py, une fonction main, et ses valeurs lues sur la ligne de commande avec argparse
---

Cette partie fait passer le code du notebook `recette.ipynb` dans un
programme, `recette.py`, lancé depuis un terminal. Elle présente la fonction
`main` et la façon dont Python lit un script, puis `argparse`, qui lit les
valeurs du programme sur la ligne de commande. Le programme se construit par
étapes, un commit git par étape. Un TD l'accompagne, le TD 3a ; il est
présenté en fin de page.

## Du notebook à la ligne de commande

Dans un notebook, les valeurs du programme sont écrites dans une cellule.
Changer une valeur oblige à relancer les cellules qui en dépendent, dans
l'ordre. Le script du TD 3a reçoit les valeurs sur la ligne de commande, et
une seule commande produit la page.

```{figure} figures/3_notebook_valeurs.svg
:alt: Un notebook dont la cellule des valeurs est modifiée : les cellules qui en dépendent sont à relancer.

Dans un notebook, une valeur modifiée demande de relancer les cellules qui en
dépendent.
```

```text
> python recette.py pate_pizza -p 6 -u US
…\sortie\pate_pizza.html : 6 personne(s), unités US
```

```{list-table}
:header-rows: 1

* - Dans le notebook
  - Sur la ligne de commande
* - `NOM = "pate_pizza"`
  - `pate_pizza`
* - `PERSONNES = 6`
  - `-p 6`
* - `UNITES = "US"`
  - `-u US`
```

## La fonction `main`

Les lignes du programme sont placées dans une fonction, `main`. La fin du
fichier appelle `main` seulement si le fichier est lancé avec
`python recette.py` :

```python
# les fonctions utiles, sans changement
def lire_ingredients(chemin):
    ...


# le programme, dans une fonction : ses lignes sont indentées
def main():
    ingredients = lire_ingredients(...)
    ...


# vrai si le fichier est lancé avec python
if __name__ == "__main__":
    main()
```

Le résultat de `python recette.py` est le même qu'avant le passage dans
`main`.

## La lecture d'un script par Python

Lancé ou importé, un fichier est lu de haut en bas, et chaque ligne est
exécutée. Un `def` crée la fonction sans exécuter son corps : le corps ne
s'exécute qu'à l'appel. `__name__` est une variable que Python définit dans
chaque fichier : elle vaut `"__main__"` dans le fichier lancé, et le nom du
module, ici `"recette"`, dans un fichier importé.

```{list-table}
:header-rows: 1

* - Ligne de `recette.py`
  - `python recette.py`
  - `from recette import lire_ingredients`
* - `import csv`
  - exécutée : `csv` est chargé
  - exécutée : `csv` est chargé
* - `def lire_ingredients(chemin): …`
  - la fonction est créée
  - la fonction est créée
* - `def main(): …`
  - la fonction est créée
  - la fonction est créée
* - `if __name__ == "__main__":`
  - `__name__` vaut `"__main__"` : vrai
  - `__name__` vaut `"recette"` : faux
* - `    main()`
  - exécutée : la page est produite
  - ignorée
```

Sans le test, `main()` serait aussi exécutée à l'import : récupérer
`lire_ingredients` pour la réutiliser ou la tester produirait la page et
lancerait pandoc. Un fichier de tests, par exemple, appelle
`lire_ingredients` sur un CSV connu et vérifie le résultat ; le projet 7 en
écrit un.

## Les arguments d'un script avec `argparse`

`argparse`, de la bibliothèque standard, lit les arguments écrits après le nom
du script : il les vérifie, les convertit, et construit l'aide de `--help`.
Documentation :
[docs.python.org/fr/3/library/argparse.html](https://docs.python.org/fr/3/library/argparse.html).

Le script minimal lit un argument, le nom de la recette :

```python
import argparse


def main():
    analyseur = argparse.ArgumentParser()
    analyseur.add_argument("nom")
    options = analyseur.parse_args()
    print("Recette demandée :", options.nom)


if __name__ == "__main__":
    main()
```

```text
> python recette.py crepes
Recette demandée : crepes

> python recette.py
usage: recette.py [-h] nom
recette.py: error: the following arguments are required: nom
```

`options.nom` porte le nom donné à `add_argument`. Sans argument,
`parse_args` affiche l'usage et arrête le script, avant le `print`.

Le programme de la recette lit trois arguments :

```python
analyseur = argparse.ArgumentParser()
# obligatoire ; une valeur de la liste
analyseur.add_argument("nom", choices=recettes_disponibles)
# option ; convertie en entier ; 4 si absente
analyseur.add_argument("-p", "--personnes", type=int, default=4)
# option ; deux valeurs possibles
analyseur.add_argument("-u", "--unites", choices=("SI", "US"), default="SI")
# lit la ligne de commande
options = analyseur.parse_args()
```

Un argument sans tiret est obligatoire et positionnel. Un argument avec des
tirets est une option, qui a une valeur par défaut. `type=int` convertit la valeur en
entier et rejette `six`. `choices` rejette ce qui n'est pas dans la liste ; la
liste des recettes vient de `iterdir()` sur le dossier des recettes, comme à
la section 3.4 de `recette.ipynb`.

```{list-table}
:header-rows: 1

* - Commande
  - Ce qu'elle produit
* - `python recette.py pate_pizza -p 6 -u US`
  - la page de la pâte à pizza, pour 6 personnes, en unités US
* - `python recette.py gaufres`
  - `invalid choice`, et la liste des recettes
* - `python recette.py --help`
  - l'aide, construite à partir des `add_argument`
```

## Un commit par étape

Le programme se construit par étapes, et chaque étape se termine par un
commit git. Le dépôt est créé dans `travail/`, avec un fichier `.gitignore`.
`.gitignore` est un fichier texte : chaque ligne y nomme un fichier ou un
dossier que git ne suit pas. La ligne `sortie/` exclut les pages produites par
le programme, qu'il reproduit à chaque lancement.

Les postes de la salle sont partagés : le nom et l'adresse qui signent les
commits se règlent dans le dépôt, sans `--global` (page [Git et Git
Bash](../../annexes/configuration/git.md)).

`git diff` affiche les lignes modifiées depuis le dernier commit. VS Code
affiche la même comparaison : l'icône du contrôle de code source, dans la
barre de gauche, ouvre un panneau qui liste les fichiers modifiés, et un clic
sur un fichier ouvre l'éditeur de comparaison, le dernier commit à gauche, le
fichier modifié à droite. Par défaut, cet éditeur ignore les espaces en début
et en fin de ligne, alors que `git diff` les affiche.

Les trois arguments s'ajoutent sur une branche, `arguments`, un commit par
argument, puis la branche est fusionnée dans `master`. VS Code affiche la
branche courante en bas à gauche de la fenêtre, dans la barre d'état.

## Le dossier du script

Un chemin relatif part du dossier courant : celui du notebook, ou celui du
terminal qui lance le script. `Path(__file__).parent` désigne le dossier du
script lui-même, d'où qu'on le lance. L'étape 5 du TD 3a, facultative, range
le code dans `src/` et les données dans `data/`, et fait partir les chemins
des données de ce dossier.

## TD de la partie

- TD 3a, dans le dossier `cours3/3a_cli/` de l'archive, 45 minutes : écrire
  `recette.py` à partir du notebook, puis une fonction `main`, les trois
  arguments sur une branche, et un README ; un commit par étape. Les étapes 5
  et 6, facultatives, rangent le projet en `src/` et `data/`, puis
  l'installent comme une commande. Le guide détaillé du TD est livré dans le
  même dossier, en PDF, en page HTML et en notebook ; le code se copie depuis
  la page HTML ou le notebook.

```{list-table}
:header-rows: 1

* - Étape
  - Ce qu'on fait
  - Commits à la fin
* - 0
  - préparer le dossier `travail/` et créer le dépôt git
  - 0
* - 1
  - écrire `recette.py` à partir du notebook
  - 1
* - 2
  - mettre le programme dans une fonction `main`
  - 2
* - 3
  - lire la recette, le nombre de personnes et les unités sur la ligne de
    commande, sur une branche
  - 5
* - 4
  - écrire un `README.md`
  - 6
* - 5 (facultatif)
  - ranger le code dans `src/` et les données dans `data/`
  - 7
* - 6 (facultatif)
  - installer le programme comme une commande
  - 8
```

Le TD 3a est celui du parcours avancé. Le parcours standard fait à la place
le TD 3b, une recette en Markdown, et le TD 3a au projet 4.

Les TD des autres parties sont dans [Travaux dirigés de la séance
3](travaux_diriges.md).
