---
title: Le noyau d'un notebook
execution: ../../travail
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# Le noyau d'un notebook

Un notebook demande deux programmes : un **client**, qui affiche le document,
et un **noyau**, qui exécute les cellules et retient leurs variables.
JupyterLab et VS Code sont deux clients ; le noyau est `ipykernel`, installé
dans un environnement conda. Ce notebook s'ouvre dans l'un puis dans l'autre,
et s'exécute dans le noyau de `base`, puis dans celui d'un environnement créé
pour le programme de la recette.

1. où s'exécute le notebook : l'interpréteur du noyau ;
2. ce que le noyau retient ;
3. le programme de la recette, exécuté dans ce noyau.

Ce notebook est livré dans `depart/notebook/`. Avant de commencer, le copier
dans `travail/` et ouvrir la copie.

## 1 · Où s'exécute ce notebook

`sys.executable` est le chemin de l'interpréteur Python qui exécute les
cellules, celui du noyau. `shutil.which("pandoc")` cherche le programme
pandoc dans les dossiers du `PATH` du noyau, comme le terminal le ferait.
Dans `base`, les deux chemins sont dans `anaconda3` ; dans l'environnement
`info01-recette`, ils sont dans `anaconda3\envs\info01-recette`.

```{code-cell} ipython3
import shutil
import sys

print(sys.executable)           # l'interpréteur du noyau
print(shutil.which("pandoc"))   # le programme pandoc que ce noyau trouve
```

## 2 · Ce que le noyau retient

Le noyau garde en mémoire les variables des cellules exécutées. Il les
retient dans l'ordre des exécutions, qui peut différer de l'ordre du
document.

```{code-cell} ipython3
x = 10
```

```{code-cell} ipython3
print(x * 2)
```

La seconde cellule affiche `20`. Remplacer `10` par `3` dans la première
cellule, sans l'exécuter, puis exécuter la seconde : elle affiche toujours
`20`, car le noyau a gardé `x = 10`. Le numéro entre crochets, à gauche de
chaque cellule, donne l'ordre des exécutions.

Redémarrer ensuite le noyau : dans JupyterLab, menu Kernel → Restart
Kernel… (Noyau → Redémarrer le noyau… en français) ; dans VS Code, bouton
« Restart » en haut du notebook. Le noyau
redémarré ne connaît plus aucune variable : exécuter la seconde cellule seule
lève `NameError: name 'x' is not defined`. Avant de rendre ou de partager un
notebook, on le réexécute en entier, de haut en bas.

## 3 · Le programme de la recette, dans ce noyau

Les fonctions utiles et la fonction `generer_page` du notebook
`recette.ipynb` du cours 3 produisent la page d'une recette : `generer`
écrit la recette complétée en Markdown, puis pandoc la convertit en page
HTML. pandoc doit donc être trouvé par le noyau : la section 1 le vérifie.

```{code-cell} ipython3
import csv

FACTEURS = {"g": (28.3495, "oz"), "ml": (236.588, "cup")}


def lire_ingredients(chemin):
    """Les ingrédients du fichier CSV, quantités converties en nombres.

    La fonction renvoie une liste de tuples, un par ingrédient :
    le nom (position 0), la quantité en nombre décimal (position 1),
    l'unité de la quantité (position 2).
    """
    ingredients = []
    with open(chemin, encoding="utf-8", newline="") as fichier:
        lecteur = csv.reader(fichier)
        # La première ligne du fichier nomme les colonnes : next() la lit et la
        # laisse de côté, la boucle commence à la ligne suivante.
        next(lecteur)
        for nom, quantite, unite in lecteur:
            ingredients.append((nom, float(quantite), unite))
    return ingredients


def convertir(quantite, unite):
    """Une quantité et son unité, exprimées en unités américaines."""
    if unite in FACTEURS:
        diviseur, nouvelle_unite = FACTEURS[unite]
        return quantite / diviseur, nouvelle_unite
    return quantite, unite


def adapter(ingredients, personnes, unites):
    """La recette pour ce nombre de personnes, dans ce système d'unités."""
    resultat = []
    for nom, quantite, unite in ingredients:
        quantite = quantite * personnes
        if unites == "US":
            quantite, unite = convertir(quantite, unite)
        resultat.append((nom, quantite, unite))
    return resultat


def tableau(ingredients):
    """Le tableau Markdown des ingrédients, quantités écrites à trois chiffres."""
    lignes = ["| Ingrédient | Quantité |", "|---|---|"]
    for nom, quantite, unite in ingredients:
        lignes.append(f"| {nom} | {quantite:.3g} {unite}".rstrip() + " |")
    return "\n".join(lignes)
```

```{code-cell} ipython3
import subprocess
from pathlib import Path


def generer(fichier_ingredients, fichier_recette, fichier_sortie, personnes=4, unites="SI"):
    """Écrit la recette complétée par le tableau des ingrédients."""
    ingredients = adapter(lire_ingredients(fichier_ingredients), personnes, unites)

    with open(fichier_recette, encoding="utf-8") as fichier:
        source = fichier.read()
    intitule = f"## Ingrédients pour {personnes} personnes en {unites}"
    complete = source.replace("## Ingrédients", intitule + "\n\n" + tableau(ingredients))

    with open(fichier_sortie, "w", encoding="utf-8") as fichier:
        fichier.write(complete)
    print(fichier_sortie, "écrit")


def generer_page(fichier_ingredients, fichier_recette, fichier_sortie, personnes=4, unites="SI"):
    """Écrit la recette en Markdown, puis la page HTML par pandoc."""
    generer(fichier_ingredients, fichier_recette, fichier_sortie, personnes, unites)

    page = fichier_sortie.with_suffix(".html")
    commande = ["pandoc", str(fichier_sortie), "-o", str(page), "--standalone",
                "--metadata", "pagetitle=" + fichier_sortie.stem, "--css", "style.css"]
    subprocess.run(commande, check=True)
    print(page, "écrit")
```

Les chemins partent de la racine du TD, le dossier au-dessus de `travail/`.
La feuille de style est copiée à côté de la page.

```{code-cell} ipython3
RACINE = Path.cwd().parent
DONNEES = RACINE / "depart" / "recettes"   # les données en entrée
SORTIE = RACINE / "travail"                # les fichiers produits

shutil.copy(RACINE / "depart" / "style.css", SORTIE / "style.css")

RECETTE = DONNEES / "crepes"
generer_page(RECETTE / "ingredients.csv", RECETTE / "recette.md", SORTIE / "crepes.md")
```

Si le noyau ne trouve pas pandoc, la cellule lève `FileNotFoundError` sur
`subprocess.run` : pandoc n'est pas dans l'environnement du noyau.
