---
title: "Les pages des recettes"
subtitle: Une page HTML par recette du dossier, produite par pandoc
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# Les pages des recettes

Ce notebook produit la page HTML de chaque recette du dossier où il se
trouve. Il reprend le code final de `recette.ipynb` (TD 3b) : les fonctions
utiles, puis la fonction qui écrit la recette complétée et la convertit par
pandoc. Il n'y a rien à compléter : exécuter les cellules dans l'ordre, ou
toutes à la fois par le menu Run, puis Run All Cells.

Chaque recette est un dossier qui contient `recette.md` et
`ingredients.csv`. Les pages sont écrites dans ce dossier, sous les noms
`page.md` et `page.html`. Une image citée par `recette.md`, comme
`photo.jpg`, est ainsi à côté de la page, et s'affiche.

## 1 · Les fonctions utiles

Les fonctions de la section 1 de `recette.ipynb` : `lire_ingredients` lit
le fichier CSV, `adapter` calcule les quantités pour un nombre de personnes
et un système d'unités, `tableau` écrit le tableau Markdown des
ingrédients.

```{code-cell} ipython3
import csv
import subprocess
from pathlib import Path

FACTEURS = {"g": (28.3495, "oz"), "ml": (236.588, "cup")}


def lire_ingredients(chemin):
    """Les ingrédients du fichier CSV, quantités converties en nombres."""
    ingredients = []
    with open(chemin, encoding="utf-8", newline="") as fichier:
        lecteur = csv.reader(fichier)
        next(lecteur)      # la première ligne nomme les colonnes
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

## 2 · La page d'une recette

La fonction `generer_page` reçoit le dossier d'une recette. Elle écrit
`page.md`, la recette complétée par le tableau des ingrédients sous
« Ingrédients », puis `page.html`, par pandoc. La feuille de style,
`style.css`, est dans le dossier des recettes, au-dessus de la page :
`../style.css`.

```{code-cell} ipython3
def generer_page(dossier, personnes=4, unites="SI"):
    """Écrit page.md, puis page.html par pandoc, dans le dossier de la recette."""
    ingredients = adapter(lire_ingredients(dossier / "ingredients.csv"), personnes, unites)
    source = (dossier / "recette.md").read_text(encoding="utf-8")
    intitule = f"## Ingrédients pour {personnes} personnes en {unites}"
    complete = source.replace("## Ingrédients", intitule + "\n\n" + tableau(ingredients))
    markdown = dossier / "page.md"
    markdown.write_text(complete, encoding="utf-8")

    page = dossier / "page.html"
    commande = ["pandoc", str(markdown), "-o", str(page), "--standalone",
                "--metadata", "pagetitle=" + dossier.name, "--css", "../style.css"]
    subprocess.run(commande, check=True)
    print(page.relative_to(Path.cwd()), "écrit")
```

## 3 · Toutes les recettes du dossier

Le dossier courant est celui du notebook, le dossier des recettes. Chacun
de ses sous-dossiers qui contient un fichier `recette.md` est une recette :
les autres, comme `.git/`, sont laissés de côté.

```{code-cell} ipython3
RACINE = Path.cwd()

for dossier in sorted(RACINE.iterdir()):
    if (dossier / "recette.md").exists():
        generer_page(dossier)
```

Ouvrir une page par un double-clic sur son fichier `page.html`, dans
l'explorateur de fichiers. Pour une autre quantité, appeler la fonction sur
une seule recette, par exemple
`generer_page(RACINE / "crepes", personnes=8, unites="US")`, puis recharger
la page dans le navigateur.
