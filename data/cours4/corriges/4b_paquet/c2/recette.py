"""Une recette à l'échelle : les ingrédients pour un nombre de personnes, en unités SI ou US."""

import argparse
from pathlib import Path

from quantites import VERS_SI, VERS_US, adapter, afficher, convertir, ecrire_ingredients, lire_ingredients

# ---- Les données -------------------------------------------------------------

PERSONNES_RECETTE = 4     # les recettes sont écrites pour 4 personnes

# Les chemins partent du dossier du script : __file__ est le chemin de ce fichier
RACINE = Path(__file__).parent
DONNEES = RACINE / "recettes"
SORTIE = RACINE / "sortie"


# ---- Le programme -------------------------------------------------------------

def main():
    # Les valeurs viennent de la ligne de commande
    analyseur = argparse.ArgumentParser(description="Les ingrédients d'une recette pour un nombre de personnes, en unités SI ou US.")
    analyseur.add_argument("nom", help="la recette : un fichier de recettes/, sans .csv")
    analyseur.add_argument("-p", "--personnes", type=int, default=4, help="nombre de personnes (défaut : 4)")
    analyseur.add_argument("-u", "--unites", choices=("SI", "US"), default="SI", help="système d'unités (défaut : SI)")
    options = analyseur.parse_args()
    NOM = options.nom
    PERSONNES = options.personnes
    UNITES = options.unites

    ingredients = lire_ingredients(DONNEES / (NOM + ".csv"))
    ingredients = adapter(ingredients, PERSONNES_RECETTE, PERSONNES)

    if UNITES == "US":
        ingredients = convertir(ingredients, VERS_US)
    else:
        ingredients = convertir(ingredients, VERS_SI)

    print(NOM, "pour", PERSONNES, "personnes, en unités", UNITES)
    afficher(ingredients)

    # Le résultat, dans sortie/
    SORTIE.mkdir(exist_ok=True)
    fichier = SORTIE / (NOM + "_" + str(PERSONNES) + "_" + UNITES + ".csv")
    ecrire_ingredients(fichier, ingredients)
    print("écrit :", fichier)


# Vrai quand le fichier est lancé par `python`, faux quand il est importé.
if __name__ == "__main__":
    main()
