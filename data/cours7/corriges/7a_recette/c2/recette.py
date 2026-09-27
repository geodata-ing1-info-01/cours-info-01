"""Une recette mise à l'échelle, en page HTML, par pandoc.

Le code du notebook du TD 1a, dans un seul fichier : les fonctions utiles,
puis le programme dans `main`. La recette, le nombre de personnes et les
unités se donnent sur la ligne de commande.

    python recette.py crepes
    python recette.py pate_pizza -p 6 -u US
    python recette.py --toutes
    python recette.py --help

À lancer depuis le dossier qui contient `recettes/` et `style.css` ; la page
est écrite dans `sortie/`.
"""

import argparse
import csv
import shutil
import subprocess
from pathlib import Path

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


# ---- Une page ---------------------------------------------------------------

def generer(nom, personnes, unites):
    """La page HTML d'une recette, pour ce nombre de personnes et ces unités ; renvoie son chemin."""
    # La recette : le tableau des ingrédients inséré sous « ## Ingrédients »
    ingredients = lire_ingredients(DONNEES / nom / "ingredients.csv")
    ingredients = adapter(ingredients, personnes, unites)
    source = (DONNEES / nom / "recette.md").read_text(encoding="utf-8")
    titre = source.splitlines()[0].lstrip("# ")
    intitule = f"## Ingrédients pour {personnes} personnes en {unites}"
    complete = source.replace("## Ingrédients", intitule + "\n\n" + tableau(ingredients))
    SORTIE.mkdir(exist_ok=True)

    # Le Markdown complet et la feuille de style, dans sortie/
    markdown = SORTIE / (nom + ".md")
    markdown.write_text(complete, encoding="utf-8")
    shutil.copy(STYLE, SORTIE / "style.css")

    # La page HTML, par pandoc
    page = SORTIE / (nom + ".html")
    subprocess.run(
        ["pandoc", str(markdown), "-o", str(page),
         "--standalone", "--css", "style.css", "--metadata", "title=" + titre],
        check=True,
    )
    return page


# ---- Toutes les recettes et le sommaire -------------------------------------

def noms_des_recettes():
    """Le nom de chaque recette : le dossier de chaque fichier recettes/*/recette.md."""
    noms = []
    for chemin in sorted(DONNEES.glob("*/recette.md")):
        noms.append(chemin.parent.name)
    return noms


def sommaire(noms):
    """La page sortie/index.html : un lien vers la page de chaque recette ; renvoie son chemin."""
    lignes = ["# Le livre de recettes", ""]
    for nom in noms:
        titre = (DONNEES / nom / "recette.md").read_text(encoding="utf-8").splitlines()[0].lstrip("# ")
        lignes.append(f"- [{titre}]({nom}.html)")
    markdown = SORTIE / "index.md"
    markdown.write_text("\n".join(lignes) + "\n", encoding="utf-8")
    page = SORTIE / "index.html"
    subprocess.run(
        ["pandoc", str(markdown), "-o", str(page),
         "--standalone", "--css", "style.css", "--metadata", "title=Le livre de recettes"],
        check=True,
    )
    return page


# ---- Le programme ------------------------------------------------------------

def main():
    noms = noms_des_recettes()
    analyseur = argparse.ArgumentParser(description="Met une recette à l'échelle et en fait une page HTML.")
    analyseur.add_argument("nom", nargs="?", choices=noms, help="la recette")
    analyseur.add_argument("-p", "--personnes", type=int, default=4, help="nombre de personnes (défaut : 4)")
    analyseur.add_argument("-u", "--unites", choices=("SI", "US"), default="SI", help="unités du tableau (défaut : SI)")
    analyseur.add_argument("--toutes", action="store_true", help="toutes les recettes, et le sommaire sortie/index.html")
    options = analyseur.parse_args()
    if options.nom is None and not options.toutes:
        analyseur.error("donner une recette, ou --toutes")

    if options.toutes:
        for nom in noms:
            generer(nom, options.personnes, options.unites)
        print(sommaire(noms), ":", len(noms), "recettes")
    elif options.nom is not None:
        page = generer(options.nom, options.personnes, options.unites)
        print(page, ":", options.personnes, "personne(s), unités", options.unites)


# Vrai quand le fichier est lancé par `python`, faux quand il est importé par
# un autre fichier : dans ce cas, main() n'est pas appelé.
if __name__ == "__main__":
    main()
