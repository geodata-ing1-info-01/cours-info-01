"""Une recette à l'échelle : les ingrédients pour un nombre de personnes, en unités SI ou US."""

import csv
from pathlib import Path

# ---- Les données -------------------------------------------------------------

PERSONNES_RECETTE = 4     # les recettes sont écrites pour 4 personnes

# Pour chaque unité : l'unité de l'autre système, et le nombre par lequel
# multiplier la quantité
VERS_US = {"g": ("oz", 1 / 28.3495), "ml": ("cup", 1 / 236.588)}
VERS_SI = {"oz": ("g", 28.3495), "cup": ("ml", 236.588)}

# Les chemins partent du dossier du script : __file__ est le chemin de ce fichier
RACINE = Path(__file__).parent
DONNEES = RACINE / "recettes"


# ---- Les fonctions -----------------------------------------------------------

def lire_ingredients(chemin):
    """Les ingrédients du fichier CSV : une liste de (ingrédient, quantité, unité)."""
    ingredients = []
    with open(chemin, encoding="utf-8", newline="") as fichier:
        lecteur = csv.reader(fichier)
        next(lecteur)             # la première ligne nomme les colonnes
        for nom, quantite, unite in lecteur:
            ingredients.append((nom, float(quantite), unite))
    return ingredients


def afficher(ingredients):
    """Affiche une ligne par ingrédient : le nom, la quantité et l'unité."""
    for nom, quantite, unite in ingredients:
        print(nom, ":", round(quantite, 1), unite)


def adapter(ingredients, personnes_recette, personnes):
    """Les ingrédients pour `personnes` personnes, d'une recette écrite pour `personnes_recette` personnes."""
    facteur = personnes / personnes_recette
    resultat = []
    for nom, quantite, unite in ingredients:
        resultat.append((nom, quantite * facteur, unite))
    return resultat


def convertir(ingredients, table):
    """Les ingrédients, chaque unité présente dans `table` remplacée par celle de l'autre système."""
    resultat = []
    for nom, quantite, unite in ingredients:
        if unite in table:
            nouvelle_unite, facteur = table[unite]
            resultat.append((nom, quantite * facteur, nouvelle_unite))
        else:
            resultat.append((nom, quantite, unite))
    return resultat


# ---- Le programme -------------------------------------------------------------

# Les valeurs à changer
NOM = "crepes"            # la recette : un fichier de recettes/, sans .csv
PERSONNES = 6             # le nombre de personnes voulu
UNITES = "US"             # le système d'unités voulu : "SI" ou "US"

ingredients = lire_ingredients(DONNEES / (NOM + ".csv"))
ingredients = adapter(ingredients, PERSONNES_RECETTE, PERSONNES)

if UNITES == "US":
    ingredients = convertir(ingredients, VERS_US)
else:
    ingredients = convertir(ingredients, VERS_SI)

print(NOM, "pour", PERSONNES, "personnes, en unités", UNITES)
afficher(ingredients)
