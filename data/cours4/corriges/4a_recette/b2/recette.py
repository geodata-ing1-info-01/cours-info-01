"""Une recette à l'échelle : les ingrédients pour un nombre de personnes, en unités SI ou US."""

# ---- Les données -------------------------------------------------------------

# La recette des crêpes : (ingrédient, quantité, unité)
INGREDIENTS = [
    ("Farine", 250, "g"),
    ("Lait", 500, "ml"),
    ("Œufs", 4, ""),
    ("Sel", 2, "g"),
    ("Beurre fondu", 50, "g"),
]
PERSONNES_RECETTE = 4     # les recettes sont écrites pour 4 personnes


# ---- Les fonctions -----------------------------------------------------------

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


# ---- Le programme -------------------------------------------------------------

# Les valeurs à changer
PERSONNES = 6             # le nombre de personnes voulu

ingredients = adapter(INGREDIENTS, PERSONNES_RECETTE, PERSONNES)

print("Crêpes pour", PERSONNES, "personnes")
afficher(ingredients)
