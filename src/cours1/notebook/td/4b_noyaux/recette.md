---
title: Recette
subtitle: Le programme du TD 4a, une fonction par cellule
execution: ..
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# Recette

Le programme du TD 4a, réécrit ici en entier : aucune des fonctions n'est
importée d'ailleurs, chacune occupe sa cellule, et on peut en changer une sans
relancer les autres.

Il lit les deux fichiers du projet `recette`, met les quantités à l'échelle et
affiche la recette avec son tableau d'ingrédients.

## Le chemin des données, à régler avant tout

La cellule ci-dessous est la seule à dépendre de l'endroit d'où le notebook est
ouvert. Le chemin est **relatif** : il part du dossier du notebook, remonte
d'un cran, et redescend dans les données du TD 4a.

:::{admonition} À faire
Commentez chaque ligne de la cellule suivante, puis changez le chemin pour
qu'il désigne les données là où elles sont chez vous. Dans le navigateur, où il
n'y a pas d'arborescence, déposez `ingredients.csv` et `recette.md` à côté du
notebook et remplacez le chemin par `Path(".")`.
:::

```{code-cell} ipython3
from pathlib import Path

DONNEES = Path("../4a_recette/depart/recette/data")

PERSONNES = 4
UNITES = "SI"      # "SI" ou "US"

assert DONNEES.is_dir(), f"dossier introuvable : {DONNEES.resolve()}"
sorted(f.name for f in DONNEES.iterdir())
```

## Lire les ingrédients

Le fichier donne les quantités **pour une personne, en unités SI**. La première
ligne nomme les colonnes, les suivantes donnent un ingrédient chacune.

```{code-cell} ipython3
import csv


def lire_ingredients(chemin):
    """Les ingrédients du fichier CSV, quantités converties en nombres."""
    ingredients = []
    with open(chemin, encoding="utf-8") as fichier:
        lecteur = csv.reader(fichier)
        next(lecteur)
        for nom, quantite, unite in lecteur:
            ingredients.append((nom, float(quantite), unite))
    return ingredients


lire_ingredients(DONNEES / "ingredients.csv")
```

## Convertir une unité

Deux facteurs suffisent. Ce qui se compte, les œufs, n'a pas d'équivalent
américain : la quantité et l'unité ressortent inchangées.

```{code-cell} ipython3
def convertir(quantite, unite):
    """Une quantité et son unité, exprimées en unités américaines."""
    if unite == "g":
        return quantite / 28.3495, "oz"      # une once vaut 28,3495 g
    if unite == "ml":
        return quantite / 236.588, "cup"     # une cup vaut 236,588 ml
    return quantite, unite


convertir(240, "g")
```

## Mettre à l'échelle

La quantité lue vaut pour une personne : on la multiplie, puis on la convertit
si le système demandé n'est pas celui du fichier.

```{code-cell} ipython3
def adapter(ingredients, personnes, unites):
    """La recette pour ce nombre de convives, dans ce système d'unités."""
    resultat = []
    for nom, quantite, unite in ingredients:
        quantite = quantite * personnes
        if unites == "US":
            quantite, unite = convertir(quantite, unite)
        resultat.append((nom, quantite, unite))
    return resultat


adapter(lire_ingredients(DONNEES / "ingredients.csv"), PERSONNES, UNITES)
```

## Écrire les quantités

C'est ici, et seulement ici, que les nombres deviennent du texte : trois
chiffres significatifs, suivis de l'unité quand il y en a une.

```{code-cell} ipython3
def en_table(ingredients):
    """Les ingrédients en lignes de tableau : un nom, une quantité écrite."""
    lignes = []
    for nom, quantite, unite in ingredients:
        lignes.append((nom, f"{quantite:.3g} {unite}".strip()))
    return lignes
```

## Poser les barres verticales

Un tableau Markdown n'est que des barres verticales et une ligne de tirets.
La fonction porte le nom et l'appel de celle de la bibliothèque `tabulate`,
réduite au seul format employé ici.

```{code-cell} ipython3
def tabulate(donnees, headers=(), tablefmt="github"):
    """Un tableau Markdown, à partir de lignes et d'un en-tête."""
    lignes = []
    lignes.append("| " + " | ".join(headers) + " |")
    lignes.append("|" + "---|" * len(headers))
    for donnee in donnees:
        lignes.append("| " + " | ".join(donnee) + " |")
    return "\n".join(lignes)


print(tabulate([("Farine", "240 g")], headers=["Ingrédient", "Quantité"]))
```

## Assembler

La recette annonce ses ingrédients par un titre et ne contient aucun tableau :
c'est ce qui lui permet de servir pour deux personnes comme pour douze.

```{code-cell} ipython3
ingredients = lire_ingredients(DONNEES / "ingredients.csv")
ingredients = adapter(ingredients, PERSONNES, UNITES)
tableau = tabulate(en_table(ingredients), headers=["Ingrédient", "Quantité"])

source = (DONNEES / "recette.md").read_text(encoding="utf-8")
source = source.replace("## Ingrédients", "## Ingrédients\n\n" + tableau)
print(source)
```

## Afficher le résultat mis en forme

Le notebook sait rendre du Markdown : `Markdown` en fait une sortie mise en
page, là où le programme du TD 4a écrivait un fichier HTML.

```{code-cell} ipython3
from IPython.display import Markdown

Markdown(source)
```

:::{admonition} À faire
Changez `PERSONNES` et `UNITES` dans la première cellule, puis
**Noyau → Redémarrer et tout exécuter**. Relancer la seule dernière cellule ne
suffirait pas : elle emploie des valeurs calculées plus haut.
:::
