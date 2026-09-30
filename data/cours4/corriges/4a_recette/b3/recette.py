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

# Pour chaque unité : l'unité de l'autre système, et le nombre par lequel
# multiplier la quantité
VERS_US = {"g": ("oz", 1 / 28.3495), "ml": ("cup", 1 / 236.588)}
VERS_SI = {"oz": ("g", 28.3495), "cup": ("ml", 236.588)}


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
PERSONNES = 6             # le nombre de personnes voulu
UNITES = "US"             # le système d'unités voulu : "SI" ou "US"

ingredients = adapter(INGREDIENTS, PERSONNES_RECETTE, PERSONNES)

if UNITES == "US":
    ingredients = convertir(ingredients, VERS_US)
else:
    ingredients = convertir(ingredients, VERS_SI)

print("Crêpes pour", PERSONNES, "personnes, en unités", UNITES)
afficher(ingredients)
