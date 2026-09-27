# Recette

Met une recette à l'échelle pour un nombre de personnes, dans les unités
choisies, et en fait une page HTML avec pandoc.

## Installation

Le programme demande Python et pandoc, tous deux fournis par Anaconda.

1. Installer Anaconda : <https://www.anaconda.com/download>.
2. Récupérer ce dossier par `git clone`, ou décompresser l'archive du projet.

## Installation de la commande

Dans l'invite de commandes d'Anaconda, dans le dossier du projet :

```
pip install -e .
```

La commande `recette` est alors disponible dans tous les dossiers.

## Exécution

```
recette crepes
recette pate_pizza -p 6 -u US
```

`recette --help` affiche les arguments : la recette, obligatoire ;
`-p`, `--personnes`, le nombre de personnes (4 par défaut) ; `-u`, `--unites`,
`SI` ou `US` (`SI` par défaut).

La page produite est dans `sortie/`, dans le dossier où la commande est lancée.

## Recettes disponibles

`crepes`, `mousse_chocolat`, `pate_pizza`, `salade_lentilles` : un dossier
par recette dans `data/recettes/`, avec `recette.md` et `ingredients.csv`.

## Auteur

(Votre nom.)
