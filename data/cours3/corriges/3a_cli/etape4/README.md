# Recette

Met une recette à l'échelle pour un nombre de personnes, dans les unités
choisies, et en fait une page HTML avec pandoc.

## Installation

Le programme demande Python et pandoc, tous deux fournis par Anaconda.

1. Installer Anaconda : <https://www.anaconda.com/download>.
2. Récupérer ce dossier par `git clone`, ou décompresser l'archive du projet.

## Exécution

Dans l'invite de commandes d'Anaconda, se placer dans le dossier du projet, puis :

```
python recette.py crepes
python recette.py pate_pizza -p 6 -u US
```

`python recette.py --help` affiche les arguments : la recette, obligatoire ;
`-p`, `--personnes`, le nombre de personnes (4 par défaut) ; `-u`, `--unites`,
`SI` ou `US` (`SI` par défaut).

La page produite est dans `sortie/`.

## Recettes disponibles

`crepes`, `mousse_chocolat`, `pate_pizza`, `salade_lentilles` : un dossier
par recette dans `recettes/`, avec `recette.md` et `ingredients.csv`.

## Auteur

(Votre nom.)
