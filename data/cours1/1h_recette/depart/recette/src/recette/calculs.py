"""Les ingrédients : les lire, les mettre à l'échelle, les convertir.

Un ingrédient est un triplet : son nom, sa quantité, son unité. Une recette
est la liste de ses ingrédients. Les fonctions se suivent dans cet
ordre, et aucune ne modifie ce qu'on lui donne :

    ingredients = lire_ingredients("data/ingredients.csv")
    ingredients = adapter(ingredients, personnes=4, unites="SI")
    lignes = en_table(ingredients)

La mise en forme du résultat est dans `tableau.py`.
"""

import csv

__all__ = ["lire_ingredients", "convertir", "adapter", "en_table"]


def lire_ingredients(chemin):
    """Les ingrédients du fichier CSV, quantités converties en nombres.

    La première ligne du fichier nomme les colonnes : elle est sautée. Les
    suivantes donnent un ingrédient chacune, dans l'ordre nom, quantité,
    unité, et pour une personne.
    """
    ingredients = []
    with open(chemin, encoding="utf-8") as fichier:
        lecteur = csv.reader(fichier)
        next(lecteur)
        for nom, quantite, unite in lecteur:
            ingredients.append((nom, float(quantite), unite))
    return ingredients


def convertir(quantite, unite):
    """Une quantité et son unité, exprimées en unités américaines.

    Ce qui se compte, les œufs, n'a pas d'équivalent : la quantité et
    l'unité ressortent inchangées, « une once d'œuf » ne voulant rien dire.
    """
    if unite == "g":
        return quantite / 28.3495, "oz"      # une once vaut 28,3495 g
    if unite == "ml":
        return quantite / 236.588, "cup"     # une cup vaut 236,588 ml
    return quantite, unite


def adapter(ingredients, personnes, unites):
    """La recette pour ce nombre de convives, dans ce système d'unités.

    Les deux réglages tiennent dans la même boucle : la quantité lue vaut
    pour une personne, on la multiplie, puis on la convertit si le système
    demandé n'est pas celui du fichier.
    """
    resultat = []
    for nom, quantite, unite in ingredients:
        quantite = quantite * personnes
        if unites == "US":
            quantite, unite = convertir(quantite, unite)
        resultat.append((nom, quantite, unite))
    return resultat


def en_table(ingredients):
    """Les ingrédients en lignes de tableau : un nom, une quantité écrite.

    C'est ici, et seulement ici, que les nombres deviennent du texte : trois
    chiffres significatifs, suivis de l'unité quand il y en a une.
    """
    lignes = []
    for nom, quantite, unite in ingredients:
        lignes.append((nom, f"{quantite:.3g} {unite}".strip()))
    return lignes
