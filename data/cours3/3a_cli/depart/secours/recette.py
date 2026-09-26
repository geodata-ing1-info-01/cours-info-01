"""La recette des crêpes pour quatre personnes, en page HTML, par pandoc.

Le code du notebook du TD 1a, dans un seul fichier : les fonctions utiles,
puis le programme, de haut en bas. Les trois valeurs sont écrites en tête.

    python recette.py

À lancer depuis le dossier qui contient `recettes/` et `style.css` ; la page
est écrite dans `sortie/`.
"""

import csv
import shutil
import subprocess
from pathlib import Path

# ---- Les trois valeurs à changer -------------------------------------------
NOM = "crepes"
PERSONNES = 4
UNITES = "SI"      # "SI" ou "US"
# ---------------------------------------------------------------------------

# Les chemins partent du dossier du terminal (section 3.3 du notebook)
RACINE = Path.cwd()
DONNEES = RACINE / "recettes"
STYLE = RACINE / "style.css"
SORTIE = RACINE / "sortie"

# ---- Les fonctions utiles (section 1 du notebook) ---------------------------

FACTEURS = {"g": (28.3495, "oz"), "ml": (236.588, "cup")}


def lire_ingredients(chemin):
    """Les ingrédients du fichier CSV, quantités converties en nombres."""
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
    """La recette pour ce nombre de convives, dans ce système d'unités."""
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


# ---- Le programme, de haut en bas (sections 3.3 et 4.4 du notebook) --------

# La recette : le tableau des ingrédients inséré sous « ## Ingrédients »
ingredients = lire_ingredients(DONNEES / NOM / "ingredients.csv")
ingredients = adapter(ingredients, PERSONNES, UNITES)
source = (DONNEES / NOM / "recette.md").read_text(encoding="utf-8")
titre = source.splitlines()[0].lstrip("# ")
intitule = f"## Ingrédients pour {PERSONNES} personnes en {UNITES}"   # les valeurs entre accolades sont insérées dans le texte
complete = source.replace("## Ingrédients", intitule + "\n\n" + tableau(ingredients))

# Le Markdown complet et la feuille de style, dans sortie/
SORTIE.mkdir(exist_ok=True)
markdown = SORTIE / (NOM + ".md")
markdown.write_text(complete, encoding="utf-8")
shutil.copy(STYLE, SORTIE / "style.css")

# La page HTML, par pandoc
page = SORTIE / (NOM + ".html")
subprocess.run(
    ["pandoc", str(markdown), "-o", str(page),
     "--standalone", "--css", "style.css", "--metadata", "title=" + titre],
    check=True,
)
print(page, ":", PERSONNES, "personne(s), unités", UNITES)
