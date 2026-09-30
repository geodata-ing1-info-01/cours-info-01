"""Écrit le programme de départ et les corrigés des TD 4a et 4b (la recette à l'échelle), et les vérifie.

TD 4a, tous les élèves : partie A, le dossier du projet (terminal, VS Code,
git) ; partie B, le programme `recette.py`, un commit par étape :

    b1  corriger les deux erreurs de syntaxe du programme de départ
    b2  adapter les quantités à un nombre de personnes
    b3  convertir les unités, SI vers US et US vers SI
    b4  lire les ingrédients dans un fichier CSV
    b5  écrire le résultat dans un fichier CSV
    b6  lire les valeurs sur la ligne de commande (argparse)

TD 4b, parcours avancé, à la suite du TD 4a dans le même projet :

    c1  une fonction main
    c2  deux modules : quantites.py (les fonctions) et recette.py (le programme)
    c3  un environnement conda décrit par environment.yml (pas de code)
    c4  src/, pyproject.toml, pip install -e . : la commande recette
    c5  (bonus) --page : la page HTML, par pandoc

`version(etat)` assemble `recette.py` après chaque commit, `quantites(etat)`
le module de l'étape c2. Écrit :

    4a_recette/depart/recette.py           le programme de départ, avec ses deux erreurs
    corriges/4a_recette/b<n>/recette.py    l'état après chaque étape
    corriges/4b_paquet/c<n>/...            idem pour le TD 4b

    python generer_recette.py            # écrit et vérifie
    python generer_recette.py --diffs    # affiche aussi les blocs de modifications du guide
"""

from __future__ import annotations

import argparse
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ICI = Path(__file__).resolve().parent
DEPOT = ICI.parent.parent
TD_RECETTE = ICI / "4a_recette"
TD_PAQUET = ICI / "4b_paquet"
CORRIGES = ICI / "corriges"

sys.path.insert(0, str(DEPOT / "outils"))
from modifications import modifications  # noqa: E402

ETATS = ["depart", "b1", "b2", "b3", "b4", "b5", "b6", "c1", "c2", "c4", "c5"]

# ---- Les morceaux de recette.py ---------------------------------------------

DOC = '"""Une recette à l\'échelle : les ingrédients pour un nombre de personnes, en unités SI ou US."""\n'

IMPORTS_B4 = "\nimport csv\nfrom pathlib import Path\n"
IMPORTS_B6 = "\nimport argparse\nimport csv\nfrom pathlib import Path\n"

TITRE_DONNEES = "\n# ---- Les données -------------------------------------------------------------\n"

INGREDIENTS = '''
# La recette des crêpes : (ingrédient, quantité, unité)
INGREDIENTS = [
    ("Farine", 250, "g"),
    ("Lait", 500, "ml"),
    ("Œufs", 4, ""),
    ("Sel", 2, "g"),
    ("Beurre fondu", 50, "g"),
]
'''
PERSONNES_RECETTE = "PERSONNES_RECETTE = 4     # les recettes sont écrites pour 4 personnes\n"

TABLES = '''
# Pour chaque unité : l'unité de l'autre système, et le nombre par lequel
# multiplier la quantité
VERS_US = {"g": ("oz", 1 / 28.3495), "ml": ("cup", 1 / 236.588)}
VERS_SI = {"oz": ("g", 28.3495), "cup": ("ml", 236.588)}
'''
DONNEES = '''
# Les chemins partent du dossier du script : __file__ est le chemin de ce fichier
RACINE = Path(__file__).parent
DONNEES = RACINE / "recettes"
'''
SORTIE = 'SORTIE = RACINE / "sortie"\n'
# Au TD 4b, étape c4 : le script passe dans src/, la racine du projet est le dossier parent
RACINE_SRC = 'RACINE = Path(__file__).parent.parent     # src/, puis le dossier du projet\n'

TITRE_FONCTIONS = "\n\n# ---- Les fonctions -----------------------------------------------------------\n"

LIRE = '''
def lire_ingredients(chemin):
    """Les ingrédients du fichier CSV : une liste de (ingrédient, quantité, unité)."""
    ingredients = []
    with open(chemin, encoding="utf-8", newline="") as fichier:
        lecteur = csv.reader(fichier)
        next(lecteur)             # la première ligne nomme les colonnes
        for nom, quantite, unite in lecteur:
            ingredients.append((nom, float(quantite), unite))
    return ingredients

'''
ECRIRE = '''
def ecrire_ingredients(chemin, ingredients):
    """Écrit les ingrédients dans un fichier CSV, avec les mêmes colonnes que les fichiers lus."""
    with open(chemin, "w", encoding="utf-8", newline="") as fichier:
        ecrivain = csv.writer(fichier)
        ecrivain.writerow(["ingredient", "quantite", "unite"])
        for nom, quantite, unite in ingredients:
            ecrivain.writerow([nom, round(quantite, 1), unite])

'''
AFFICHER = '''
def afficher(ingredients):
    """Affiche une ligne par ingrédient : le nom, la quantité et l'unité."""
    for nom, quantite, unite in ingredients:
        print(nom, ":", round(quantite, 1), unite)
'''
# Le programme de départ : deux-points oublié, puis tabulation au lieu
# d'espaces dans la même fonction.
AFFICHER_FAUTIF = '''
def afficher(ingredients):
    """Affiche une ligne par ingrédient : le nom, la quantité et l'unité."""
    for nom, quantite, unite in ingredients
\tprint(nom, ":", round(quantite, 1), unite)
'''
ADAPTER = '''

def adapter(ingredients, personnes_recette, personnes):
    """Les ingrédients pour `personnes` personnes, d'une recette écrite pour `personnes_recette` personnes."""
    facteur = personnes / personnes_recette
    resultat = []
    for nom, quantite, unite in ingredients:
        resultat.append((nom, quantite * facteur, unite))
    return resultat
'''
CONVERTIR = '''

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
'''
TITRE_PROGRAMME = "\n\n# ---- Le programme -------------------------------------------------------------\n"

VALEURS = {
    "b2": '''
# Les valeurs à changer
PERSONNES = 6             # le nombre de personnes voulu
''',
    "b3": '''
# Les valeurs à changer
PERSONNES = 6             # le nombre de personnes voulu
UNITES = "US"             # le système d'unités voulu : "SI" ou "US"
''',
    "b4": '''
# Les valeurs à changer
NOM = "crepes"            # la recette : un fichier de recettes/, sans .csv
PERSONNES = 6             # le nombre de personnes voulu
UNITES = "US"             # le système d'unités voulu : "SI" ou "US"
''',
}
ARGUMENTS = '''
# Les valeurs viennent de la ligne de commande
analyseur = argparse.ArgumentParser(description="Les ingrédients d'une recette pour un nombre de personnes, en unités SI ou US.")
analyseur.add_argument("nom", help="la recette : un fichier de recettes/, sans .csv")
analyseur.add_argument("-p", "--personnes", type=int, default=4, help="nombre de personnes (défaut : 4)")
analyseur.add_argument("-u", "--unites", choices=("SI", "US"), default="SI", help="système d'unités (défaut : SI)")
options = analyseur.parse_args()
NOM = options.nom
PERSONNES = options.personnes
UNITES = options.unites
'''
PROGRAMME_B1 = '''
print("Crêpes pour", PERSONNES_RECETTE, "personnes")
afficher(INGREDIENTS)
'''
LECTURE_EN_DUR = "\ningredients = adapter(INGREDIENTS, PERSONNES_RECETTE, PERSONNES)\n"
LECTURE_CSV = '''
ingredients = lire_ingredients(DONNEES / (NOM + ".csv"))
ingredients = adapter(ingredients, PERSONNES_RECETTE, PERSONNES)
'''
CONVERSION = '''if UNITES == "US":
    ingredients = convertir(ingredients, VERS_US)
else:
    ingredients = convertir(ingredients, VERS_SI)
'''
AFFICHAGE_CREPES = 'print("Crêpes pour", PERSONNES, "personnes")\nafficher(ingredients)\n'
AFFICHAGE_CREPES_UNITES = 'print("Crêpes pour", PERSONNES, "personnes, en unités", UNITES)\nafficher(ingredients)\n'
AFFICHAGE_NOM = 'print(NOM, "pour", PERSONNES, "personnes, en unités", UNITES)\nafficher(ingredients)\n'
ECRITURE = '''
# Le résultat, dans sortie/
SORTIE.mkdir(exist_ok=True)
fichier = SORTIE / (NOM + "_" + str(PERSONNES) + "_" + UNITES + ".csv")
ecrire_ingredients(fichier, ingredients)
print("écrit :", fichier)
'''


def _indenter(texte):
    return "".join(("    " + ligne) if ligne.strip() else ligne for ligne in texte.splitlines(keepends=True))


def _standard(etat):
    """`recette.py` du TD 4a après l'étape `etat` (depart, b1 à b6)."""
    rang = ETATS.index(etat)

    def apres(e):
        return rang >= ETATS.index(e)

    texte = DOC
    if apres("b6"):
        texte += IMPORTS_B6
    elif apres("b4"):
        texte += IMPORTS_B4
    texte += TITRE_DONNEES
    if not apres("b4"):
        texte += INGREDIENTS
    texte += ("\n" if apres("b4") else "") + PERSONNES_RECETTE
    if apres("b3"):
        texte += TABLES
    if apres("b4"):
        texte += DONNEES
    if apres("b5"):
        texte += SORTIE
    texte += TITRE_FONCTIONS
    if apres("b4"):
        texte += LIRE
    if apres("b5"):
        texte += ECRIRE
    texte += AFFICHER_FAUTIF if etat == "depart" else AFFICHER
    if apres("b2"):
        texte += ADAPTER
    if apres("b3"):
        texte += CONVERTIR
    texte += TITRE_PROGRAMME
    if not apres("b2"):
        return texte + PROGRAMME_B1
    texte += ARGUMENTS if apres("b6") else VALEURS[etat if etat in VALEURS else "b4"]
    texte += LECTURE_CSV if apres("b4") else LECTURE_EN_DUR
    if apres("b3"):
        texte += "\n" + CONVERSION
    if apres("b4"):
        texte += "\n" + AFFICHAGE_NOM
    elif apres("b3"):
        texte += "\n" + AFFICHAGE_CREPES_UNITES
    else:
        texte += "\n" + AFFICHAGE_CREPES
    if apres("b5"):
        texte += ECRITURE
    return texte


# ---- Le TD 4b : main, puis deux modules --------------------------------------

APPEL = '''

# Vrai quand le fichier est lancé par `python`, faux quand il est importé.
if __name__ == "__main__":
    main()
'''

QUANTITES_DOC = '"""Les quantités d\'une recette : lire et écrire un fichier CSV, adapter au nombre de personnes, convertir, afficher."""\n'


def quantites():
    """Le module `quantites.py` de l'étape c2 : les tables et les fonctions de `recette.py`."""
    return (QUANTITES_DOC + "\nimport csv\n" + TABLES + TITRE_FONCTIONS + LIRE + ECRIRE + AFFICHER
            + ADAPTER + CONVERTIR)


PAGE = '''
def ecrire_page(chemin, titre, ingredients):
    """Écrit la page HTML des ingrédients : un tableau Markdown, converti par pandoc."""
    lignes = ["# " + titre, "", "| Ingrédient | Quantité |", "|---|---|"]
    for nom, quantite, unite in ingredients:
        lignes.append("| " + nom + " | " + str(round(quantite, 1)) + " " + unite + " |")
    markdown = chemin.with_suffix(".md")
    markdown.write_text("\\n".join(lignes) + "\\n", encoding="utf-8")
    subprocess.run(["pandoc", str(markdown), "-o", str(chemin), "--standalone",
                    "--metadata", "title=" + titre], check=True)
'''


IMPORT_QUANTITES = "from quantites import VERS_SI, VERS_US, adapter, afficher, convertir, ecrire_ingredients, lire_ingredients\n"


def _avance(etat):
    """`recette.py` du TD 4b après l'étape `etat` (c1, c2-coupe, c2, c4, c5).

    `c2-coupe` : l'état intermédiaire de l'étape c2, les tables et les
    fonctions coupées pour être collées dans `quantites.py`, l'import pas
    encore écrit.
    """
    b6 = _standard("b6")
    programme = b6.split(TITRE_PROGRAMME)[1]
    if etat == "c1":
        debut = b6.split(TITRE_PROGRAMME)[0]
        return debut + TITRE_PROGRAMME + "\ndef main():" + _indenter(programme) + APPEL
    # c2 et après : les tables et les fonctions passent dans quantites.py
    if etat == "c2-coupe":
        imports = IMPORTS_B6
    else:
        imports = "\nimport argparse\nfrom pathlib import Path\n\n" + IMPORT_QUANTITES
    if etat == "c5":
        imports = imports.replace("from pathlib import Path\n", "import subprocess\nfrom pathlib import Path\n")
    texte = DOC + imports + TITRE_DONNEES + "\n" + PERSONNES_RECETTE + DONNEES + SORTIE
    if etat in ("c4", "c5"):
        texte = texte.replace("RACINE = Path(__file__).parent\n", RACINE_SRC)
    if etat == "c5":
        texte += TITRE_FONCTIONS + PAGE
        ligne_u = [l for l in programme.splitlines(keepends=True) if 'add_argument("-u"' in l][0]
        programme = programme.replace(
            ligne_u,
            ligne_u + 'analyseur.add_argument("--page", action="store_true", help="écrit aussi la page HTML, par pandoc")\n')
        programme += """
if options.page:
    page = SORTIE / (NOM + "_" + str(PERSONNES) + "_" + UNITES + ".html")
    ecrire_page(page, NOM + " pour " + str(PERSONNES) + " personnes", ingredients)
    print("écrit :", page)
"""
    return texte + TITRE_PROGRAMME + "\ndef main():" + _indenter(programme) + APPEL


def version(etat):
    """`recette.py` après l'étape `etat` (voir ETATS, et `c2-coupe`)."""
    return _avance(etat) if etat.startswith("c") else _standard(etat)


# ---- Écriture et vérification -------------------------------------------------

def ecrire(chemin, texte):
    chemin.parent.mkdir(parents=True, exist_ok=True)
    chemin.write_text(texte, encoding="utf-8")


def lancer(dossier, *arguments, attendu=0):
    """Lance une commande dans `dossier` ; renvoie la sortie, erreur comprise."""
    resultat = subprocess.run(list(arguments), cwd=dossier, capture_output=True, text=True)
    assert resultat.returncode == attendu, (arguments, resultat.stdout, resultat.stderr)
    return resultat.stdout + resultat.stderr


def verifier():
    """Exécute chaque état dans un dossier temporaire, avec les recettes du départ."""
    py = sys.executable
    with tempfile.TemporaryDirectory() as tmp:
        projet = Path(tmp)
        shutil.copytree(TD_RECETTE / "depart" / "recettes", projet / "recettes")

        def essai(etat, *arguments, attendu=0):
            ecrire(projet / "recette.py", version(etat))
            return lancer(projet, py, "recette.py", *arguments, attendu=attendu)

        assert "SyntaxError: expected ':'" in essai("depart", attendu=1)
        sans_deux_points = version("depart").replace("in ingredients\n", "in ingredients:\n")
        ecrire(projet / "recette.py", sans_deux_points)
        assert "TabError" in lancer(projet, py, "recette.py", attendu=1)
        assert "Farine : 250 g" in essai("b1")
        assert "Farine : 375.0 g" in essai("b2")
        sortie = essai("b3")
        assert "Farine : 13.2 oz" in sortie and "Lait : 3.2 cup" in sortie, sortie
        assert "crepes pour 6 personnes, en unités US" in essai("b4")
        assert "écrit :" in essai("b5")
        ecrit = (projet / "sortie" / "crepes_6_US.csv").read_text(encoding="utf-8")
        assert ecrit.splitlines()[1] == "Farine,13.2,oz", ecrit
        sortie = essai("b6", "cookies", "-u", "SI")
        assert "Farine : 354.9 ml" in sortie and "Pincée de sel : 1.0" in sortie, sortie
        assert "usage:" in essai("b6", "--help")
        # Aller-retour : le fichier US écrit, relu comme une recette, redonne les valeurs SI
        shutil.copy(projet / "sortie" / "crepes_6_US.csv", projet / "recettes" / "retour.csv")
        sortie = essai("b6", "retour", "-p", "4", "-u", "SI")
        assert "Farine : 374.2 g" in sortie, sortie      # 13.2 oz, arrondi à l'écriture : 374.2 g au lieu de 375
        essai("b6", "gaufres", attendu=1)
        (projet / "recettes" / "retour.csv").unlink()
        # TD 4b
        assert "Farine : 375.0 g" in essai("c1", "crepes", "-p", "6")
        ecrire(projet / "quantites.py", quantites())
        assert "Farine : 375.0 g" in essai("c2", "crepes", "-p", "6")
        (projet / "src").mkdir()
        shutil.move(projet / "recette.py", projet / "src" / "recette.py")
        shutil.move(projet / "quantites.py", projet / "src" / "quantites.py")
        ecrire(projet / "src" / "recette.py", version("c4"))
        assert "Farine : 375.0 g" in lancer(projet, py, "src/recette.py", "crepes", "-p", "6")
        # Les chemins partent du script : le programme marche depuis un autre dossier
        assert "Farine : 375.0 g" in lancer(projet / "recettes", py, "../src/recette.py", "crepes", "-p", "6")
        if shutil.which("pandoc"):
            ecrire(projet / "src" / "recette.py", version("c5"))
            lancer(projet, py, "src/recette.py", "crepes", "-p", "6", "--page")
            assert (projet / "sortie" / "crepes_6_SI.html").exists()
        else:
            print("pandoc absent : --page non vérifié")


# Le dossier du projet tel qu'il est sur un poste de la salle : les sorties
# montrées dans les guides remplacent le dossier temporaire par celui-ci.
PROJET_WINDOWS = r"C:\Users\eleve\Desktop\cours4\4a_recette\travail\recette"


def executer(fichiers, *arguments):
    """Lance `python *arguments` dans un projet fait des `fichiers` ({chemin relatif: texte}) et des recettes.

    Renvoie la sortie réelle, erreurs comprises, avec le chemin du dossier
    du projet sur un poste de la salle.
    """
    import re
    with tempfile.TemporaryDirectory() as tmp:
        projet = Path(tmp)
        shutil.copytree(TD_RECETTE / "depart" / "recettes", projet / "recettes")
        for chemin, texte in fichiers.items():
            ecrire(projet / chemin, texte)
        resultat = subprocess.run([sys.executable, *arguments], cwd=projet, capture_output=True, text=True)
        texte = resultat.stdout + resultat.stderr
        texte = re.sub(re.escape(str(projet)) + r"[\w/.]*",
                       lambda m: PROJET_WINDOWS + m.group(0)[len(str(projet)):].replace("/", "\\"), texte)
        # Un chemin cité entre apostrophes est écrit par repr : ses \ sont doublés.
        texte = re.sub(r"'(C:\\[^']*)'", lambda m: "'" + m.group(1).replace("\\", "\\\\") + "'", texte)
        return texte.rstrip("\n")


def main():
    analyseur = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    analyseur.add_argument("--diffs", action="store_true", help="affiche les blocs de modifications d'une étape à la suivante")
    options = analyseur.parse_args()

    ecrire(TD_RECETTE / "depart" / "recette.py", version("depart"))
    for etat in ("b1", "b2", "b3", "b4", "b5", "b6"):
        ecrire(CORRIGES / "4a_recette" / etat / "recette.py", version(etat))
    ecrire(CORRIGES / "4b_paquet" / "c1" / "recette.py", version("c1"))
    for etat in ("c2", "c4", "c5"):
        dossier = CORRIGES / "4b_paquet" / etat
        racine = dossier / "src" if etat != "c2" else dossier
        ecrire(racine / "recette.py", version(etat))
        ecrire(racine / "quantites.py", quantites())
    verifier()
    print("ok : départ, b1 à b6, c1 à c5 écrits et vérifiés")
    import guides_recette
    guides_recette.ecrire_guides()

    if options.diffs:
        paires = [("depart", "b1"), ("b1", "b2"), ("b2", "b3"), ("b3", "b4"), ("b4", "b5"), ("b5", "b6"), ("b6", "c1")]
        for avant, apres in paires:
            print(f"\n===== {avant} → {apres}")
            print(modifications(version(avant), version(apres)))


if __name__ == "__main__":
    main()
