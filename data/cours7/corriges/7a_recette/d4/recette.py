"""Une recette à l'échelle : les ingrédients pour un nombre de personnes, en unités SI ou US."""

import argparse
import csv
import shutil
import subprocess
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
SORTIE = RACINE / "sortie"
STYLE = RACINE / "style.css"


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


def ecrire_ingredients(chemin, ingredients):
    """Écrit les ingrédients dans un fichier CSV, avec les mêmes colonnes que les fichiers lus."""
    with open(chemin, "w", encoding="utf-8", newline="") as fichier:
        ecrivain = csv.writer(fichier)
        ecrivain.writerow(["ingredient", "quantite", "unite"])
        for nom, quantite, unite in ingredients:
            ecrivain.writerow([nom, round(quantite, 1), unite])


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


def tableau(ingredients):
    """Le tableau Markdown des ingrédients, une ligne par ingrédient."""
    lignes = ["| Ingrédient | Quantité |", "|---|---|"]
    for nom, quantite, unite in ingredients:
        lignes.append("| " + nom + " | " + str(round(quantite, 1)) + " " + unite + " |")
    return "\n".join(lignes)


def ecrire_markdown(nom, personnes, unites, ingredients):
    """Le texte de recettes/<nom>.md, avec le tableau des ingrédients sous « ## Ingrédients », écrit dans sortie/ ; renvoie son chemin."""
    source = (DONNEES / (nom + ".md")).read_text(encoding="utf-8")
    intitule = "## Ingrédients pour " + str(personnes) + " personnes, en unités " + unites
    complete = source.replace("## Ingrédients", intitule + "\n\n" + tableau(ingredients))
    markdown = SORTIE / (nom + ".md")
    markdown.write_text(complete, encoding="utf-8")
    return markdown


def ecrire_page(markdown):
    """La page HTML d'un fichier Markdown de sortie/, par pandoc, avec la feuille de style ; renvoie son chemin."""
    titre = markdown.read_text(encoding="utf-8").splitlines()[0].lstrip("# ")
    shutil.copy(STYLE, markdown.parent / "style.css")
    page = markdown.with_suffix(".html")
    subprocess.run(["pandoc", str(markdown), "-o", str(page), "--standalone",
                    "--css", "style.css", "--metadata", "pagetitle=" + titre], check=True)
    return page


def noms_des_recettes():
    """Le nom de chaque recette de recettes/ : ses fichiers .csv, sans l'extension."""
    noms = []
    for chemin in sorted(DONNEES.glob("*.csv")):
        noms.append(chemin.stem)
    return noms


def ecrire_sommaire(noms):
    """Le sommaire : sortie/index.md, un lien vers la page de chaque recette, puis sa page HTML ; renvoie son chemin."""
    lignes = ["# Le livre de recettes", ""]
    for nom in noms:
        titre = (DONNEES / (nom + ".md")).read_text(encoding="utf-8").splitlines()[0].lstrip("# ")
        lignes.append("- [" + titre + "](" + nom + ".html)")
    markdown = SORTIE / "index.md"
    markdown.write_text("\n".join(lignes) + "\n", encoding="utf-8")
    return ecrire_page(markdown)


# ---- Le programme -------------------------------------------------------------

# Les valeurs viennent de la ligne de commande
analyseur = argparse.ArgumentParser(description="Les ingrédients d'une recette pour un nombre de personnes, en unités SI ou US.")
analyseur.add_argument("nom", nargs="?", help="la recette : un fichier de recettes/, sans .csv")
analyseur.add_argument("-p", "--personnes", type=int, default=4, help="nombre de personnes (défaut : 4)")
analyseur.add_argument("-u", "--unites", choices=("SI", "US"), default="SI", help="système d'unités (défaut : SI)")
analyseur.add_argument("--page", action="store_true", help="écrit aussi la page de la recette : son texte complété, puis sa page HTML")
analyseur.add_argument("--toutes", action="store_true", help="toutes les recettes de recettes/, au lieu d'une seule")
options = analyseur.parse_args()
PERSONNES = options.personnes
UNITES = options.unites
if options.toutes:
    noms = noms_des_recettes()
elif options.nom is not None:
    noms = [options.nom]
else:
    analyseur.error("donner le nom d'une recette, ou --toutes")

for nom in noms:
    ingredients = lire_ingredients(DONNEES / (nom + ".csv"))
    ingredients = adapter(ingredients, PERSONNES_RECETTE, PERSONNES)

    if UNITES == "US":
        ingredients = convertir(ingredients, VERS_US)
    else:
        ingredients = convertir(ingredients, VERS_SI)

    print(nom, "pour", PERSONNES, "personnes, en unités", UNITES)
    afficher(ingredients)

    # Le résultat, dans sortie/
    SORTIE.mkdir(exist_ok=True)
    fichier = SORTIE / (nom + "_" + str(PERSONNES) + "_" + UNITES + ".csv")
    ecrire_ingredients(fichier, ingredients)
    print("écrit :", fichier)

    if options.page:
        markdown = ecrire_markdown(nom, PERSONNES, UNITES, ingredients)
        print("écrit :", markdown)
        page = ecrire_page(markdown)
        print("écrit :", page)

# Le sommaire des pages écrites
if options.page and options.toutes:
    sommaire = ecrire_sommaire(noms)
    print("écrit :", sommaire)
