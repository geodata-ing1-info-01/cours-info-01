"""Écrit les corrigés par étape des TD 7a (le livre de recettes) et 7b (la scène complète du train).

Chaque TD part du programme final d'un TD précédent : `recette.py` du TD 3a
(cours 3, `data/cours3/corriges/3a_cli/etape3/`), `train.py` du TD 4c
(projet 4, `version_train("b6")` de `data/cours4/generer_corriges.py`). Le
code ajouté est écrit ici en morceaux ; `recette(etape)` et `train(etape)`
assemblent le fichier tel qu'il est à la fin d'une étape. `generer_guides.py`
importe ce module : les guides et les corrigés ont le même code.

    python data/cours7/generer_corriges.py

écrit `corriges/7a_recette/c1/` … `c4/` et `corriges/7b_train/c1/` … `c4/`,
puis lance chaque programme sur un dossier de test.
"""
from pathlib import Path
import sys

ICI = Path(__file__).resolve().parent
DEPOT = ICI.parent.parent
CORRIGES = ICI / "corriges"

# Le module du cours 4 porte le même nom que celui-ci : il est chargé par son chemin.
import importlib.util  # noqa: E402
_spec = importlib.util.spec_from_file_location("generer_corriges_cours4", DEPOT / "data" / "cours4" / "generer_corriges.py")
cours4 = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(cours4)

APPEL = cours4.APPEL


def _remplacer(texte, avant, apres):
    assert texte.count(avant) == 1, avant[:60]
    return texte.replace(avant, apres)


# ============================================================ TD 7a : recette

ETAPES_RECETTE = ["c0", "c1-generer", "c1", "c2", "c3", "c4"]

TD3A = (DEPOT / "data" / "cours3" / "corriges" / "3a_cli" / "etape3" / "recette.py").read_text(encoding="utf-8")
R = {}
R["debut"] = TD3A[:TD3A.index("# ---- Le programme, dans une fonction")]
R["main-td3a"] = TD3A[TD3A.index("# ---- Le programme, dans une fonction"):TD3A.index("\n\n# Vrai quand")] + "\n"

R["photo"] = '''
def photo(nom):
    """La photo de la recette, réduite, copiée dans SORTIE ; renvoie son nom de fichier, ou None sans photo."""
    source = DONNEES / nom / "photo.jpg"
    if not source.exists():
        return None
    image = Image.open(source)
    image.thumbnail((600, 600))          # au plus 600 pixels de large et de haut, proportions gardées
    image.save(SORTIE / (nom + ".jpg"))
    return nom + ".jpg"

'''


def _generer(avec_photo):
    photo = '''
    # La photo, sous le titre
    fichier_photo = photo(nom)
    if fichier_photo is not None:
        complete = complete.replace("\\n", "\\n\\n![" + titre + "](" + fichier_photo + ")\\n", 1)
''' if avec_photo else ""
    return '''
def generer(nom, personnes, unites):
    """La page HTML d'une recette, pour ce nombre de personnes et ces unités ; renvoie son chemin."""
    # La recette : le tableau des ingrédients inséré sous « ## Ingrédients »
    ingredients = lire_ingredients(DONNEES / nom / "ingredients.csv")
    ingredients = adapter(ingredients, personnes, unites)
    source = (DONNEES / nom / "recette.md").read_text(encoding="utf-8")
    titre = source.splitlines()[0].lstrip("# ")
    intitule = f"## Ingrédients pour {personnes} personnes en {unites}"
    complete = source.replace("## Ingrédients", intitule + "\\n\\n" + tableau(ingredients))
    SORTIE.mkdir(exist_ok=True)
''' + photo + '''
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
'''


R["titre-page"] = "# ---- Une page ---------------------------------------------------------------\n"
R["titre-livre"] = "\n\n# ---- Toutes les recettes et le sommaire -------------------------------------\n"
R["noms"] = '''
def noms_des_recettes():
    """Le nom de chaque recette : le dossier de chaque fichier recettes/*/recette.md."""
    noms = []
    for chemin in sorted(DONNEES.glob("*/recette.md")):
        noms.append(chemin.parent.name)
    return noms
'''
R["sommaire"] = '''

def sommaire(noms):
    """La page sortie/index.html : un lien vers la page de chaque recette ; renvoie son chemin."""
    lignes = ["# Le livre de recettes", ""]
    for nom in noms:
        titre = (DONNEES / nom / "recette.md").read_text(encoding="utf-8").splitlines()[0].lstrip("# ")
        lignes.append(f"- [{titre}]({nom}.html)")
    markdown = SORTIE / "index.md"
    markdown.write_text("\\n".join(lignes) + "\\n", encoding="utf-8")
    page = SORTIE / "index.html"
    subprocess.run(
        ["pandoc", str(markdown), "-o", str(page),
         "--standalone", "--css", "style.css", "--metadata", "title=Le livre de recettes"],
        check=True,
    )
    return page
'''
R["frigo"] = '''

# ---- Les recettes faisables avec ce qu'on a ----------------------------------

def simplifier(nom):
    """Le nom d'un ingrédient en minuscules, sans accents, « œ » écrit « oe » : « Œufs » donne « oeufs »."""
    nom = nom.lower().replace("œ", "oe")
    lettres = []
    # NFD sépare chaque lettre accentuée en une lettre et un accent ; les
    # accents sont de la catégorie « Mn », laissée de côté.
    for caractere in unicodedata.normalize("NFD", nom):
        if unicodedata.category(caractere) != "Mn":
            lettres.append(caractere)
    return "".join(lettres)


def matrice(noms):
    """La table recettes × ingrédients, 1 si la recette contient l'ingrédient ; et la liste des ingrédients."""
    contenus = []
    ingredients = []
    for nom in noms:
        contenu = []
        for ingredient, quantite, unite in lire_ingredients(DONNEES / nom / "ingredients.csv"):
            contenu.append(simplifier(ingredient))
        contenus.append(contenu)
        for ingredient in contenu:
            if ingredient not in ingredients:
                ingredients.append(ingredient)
    ingredients.sort()
    recettes = np.zeros((len(noms), len(ingredients)), dtype=int)
    for ligne, contenu in enumerate(contenus):
        for ingredient in contenu:
            recettes[ligne, ingredients.index(ingredient)] = 1
    return recettes, ingredients


def frigo(noms, disponibles, nombre=5):
    """Affiche les `nombre` recettes auxquelles il manque le moins d'ingrédients, et ceux qui manquent."""
    recettes, ingredients = matrice(noms)
    vecteur = np.zeros(len(ingredients), dtype=int)
    for nom in disponibles:
        if simplifier(nom) in ingredients:
            vecteur[ingredients.index(simplifier(nom))] = 1
        else:
            print("ingrédient inconnu :", nom)
    presents = recettes @ vecteur                  # pour chaque recette, ses ingrédients disponibles
    manquants = recettes.sum(axis=1) - presents    # pour chaque recette, ses ingrédients qui manquent
    ordre = np.argsort(manquants, kind="stable")   # les recettes, de celle à qui il manque le moins
    for ligne in ordre[:nombre]:
        absents = (recettes[ligne] == 1) & (vecteur == 0)
        liste = []
        for colonne in np.nonzero(absents)[0]:
            liste.append(ingredients[colonne])
        print(noms[ligne], ":", manquants[ligne], "ingrédient(s) manquant(s)", ", ".join(liste))
'''
R["titre-main"] = "\n\n# ---- Le programme ------------------------------------------------------------\n"
R["main-generer"] = '''
def main():
    # Les trois valeurs viennent de la ligne de commande
    analyseur = argparse.ArgumentParser(description="Met une recette à l'échelle et en fait une page HTML.")
    # Les recettes disponibles : les dossiers de recettes/ (section 3.4 du notebook)
    recettes_disponibles = []
    for dossier in sorted(DONNEES.iterdir()):
        if dossier.is_dir():
            recettes_disponibles.append(dossier.name)
    analyseur.add_argument("nom", choices=recettes_disponibles, help="la recette")
    analyseur.add_argument("-p", "--personnes", type=int, default=4, help="nombre de personnes (défaut : 4)")
    analyseur.add_argument("-u", "--unites", choices=("SI", "US"), default="SI", help="unités du tableau (défaut : SI)")
    options = analyseur.parse_args()
    NOM = options.nom
    PERSONNES = options.personnes
    UNITES = options.unites

    page = generer(NOM, PERSONNES, UNITES)
    print(page, ":", PERSONNES, "personne(s), unités", UNITES)
'''


def _main_recette(sommaire, frigo):
    erreur = "donner une recette, --toutes ou --frigo" if frigo else "donner une recette, ou --toutes"
    condition = "options.nom is None and not options.toutes and options.frigo is None" if frigo \
        else "options.nom is None and not options.toutes"
    option_frigo = '''    analyseur.add_argument("--frigo", nargs="+", metavar="INGREDIENT", help="les recettes faisables avec ces ingrédients")
''' if frigo else ""
    appel_frigo = '''    if options.frigo is not None:
        frigo(noms, options.frigo)
''' if frigo else ""
    fin_toutes = '''        print(sommaire(noms), ":", len(noms), "recettes")''' if sommaire \
        else '''        print(len(noms), "recettes dans", SORTIE)'''
    return '''
def main():
    noms = noms_des_recettes()
    analyseur = argparse.ArgumentParser(description="Met une recette à l'échelle et en fait une page HTML.")
    analyseur.add_argument("nom", nargs="?", choices=noms, help="la recette")
    analyseur.add_argument("-p", "--personnes", type=int, default=4, help="nombre de personnes (défaut : 4)")
    analyseur.add_argument("-u", "--unites", choices=("SI", "US"), default="SI", help="unités du tableau (défaut : SI)")
    analyseur.add_argument("--toutes", action="store_true", help="toutes les recettes, et le sommaire sortie/index.html")
''' + option_frigo + '''    options = analyseur.parse_args()
    if ''' + condition + ''':
        analyseur.error("''' + erreur + '''")

''' + appel_frigo + '''    if options.toutes:
        for nom in noms:
            generer(nom, options.personnes, options.unites)
''' + fin_toutes + '''
    elif options.nom is not None:
        page = generer(options.nom, options.personnes, options.unites)
        print(page, ":", options.personnes, "personne(s), unités", options.unites)
'''


R["main-c1"] = _main_recette(sommaire=False, frigo=False)
R["main-c2"] = _main_recette(sommaire=True, frigo=False)
R["main-c4"] = _main_recette(sommaire=True, frigo=True)


def recette(etape):
    """Le fichier `recette.py` tel qu'il est à la fin de l'étape (voir ETAPES_RECETTE)."""
    if etape == "c0":
        return TD3A
    rang = ETAPES_RECETTE.index(etape)
    debut = R["debut"]
    if rang >= ETAPES_RECETTE.index("c1"):
        debut = _remplacer(debut, "    python recette.py pate_pizza -p 6 -u US\n",
                           "    python recette.py pate_pizza -p 6 -u US\n    python recette.py --toutes\n")
    if rang >= ETAPES_RECETTE.index("c3"):
        debut = _remplacer(debut, "from pathlib import Path\n", "from pathlib import Path\n\nfrom PIL import Image\n")
    if rang >= ETAPES_RECETTE.index("c4"):
        debut = _remplacer(debut, "    python recette.py --toutes\n",
                           "    python recette.py --toutes\n    python recette.py --frigo farine lait oeufs\n")
        debut = _remplacer(debut, "import subprocess\n", "import subprocess\nimport unicodedata\n")
        debut = _remplacer(debut, "from PIL import Image\n", "import numpy as np\nfrom PIL import Image\n")
    texte = debut + R["titre-page"]
    if rang >= ETAPES_RECETTE.index("c3"):
        texte += R["photo"]
    texte += _generer(rang >= ETAPES_RECETTE.index("c3"))
    if etape == "c1-generer":
        return texte + R["titre-main"] + R["main-generer"] + APPEL
    texte += R["titre-livre"] + R["noms"]
    if rang >= ETAPES_RECETTE.index("c2"):
        texte += R["sommaire"]
    if rang >= ETAPES_RECETTE.index("c4"):
        texte += R["frigo"]
    main = {"c1": R["main-c1"], "c2": R["main-c2"], "c3": R["main-c2"], "c4": R["main-c4"]}[etape]
    return texte + R["titre-main"] + main + APPEL


# ============================================================ TD 7b : train

ETAPES_TRAIN = ["c0", "c1", "c2", "c3", "c4"]

B6 = cours4.version_train("b6")
T = {}
T["plan"] = '''
def arguments_plan(decor, fichier, decalage):
    """Les arguments de magick qui lisent la bande `fichier`, la font tourner de `decalage` colonnes
    vers la gauche, puis en découpent 640 × 480 pixels à partir de la colonne 0."""
    return ["(", str(decor / fichier),
            "-roll", "-" + str(decalage) + "+0",
            "-crop", "640x480+0+0", "+repage", ")"]
'''
T["plans-liste"] = '''

# Les plans, du plus lointain au plus proche : le fichier de la bande, et sa vitesse en pixels par image
PLANS = [("voiles.png", 4), ("plage_jaune.png", 8), ("plage.png", 16)]
'''
T["plans-csv"] = '''

def lire_plans(decor):
    """Les plans de `decor/plans.csv`, du plus lointain au plus proche : une liste de (fichier, vitesse)."""
    plans = []
    with open(decor / "plans.csv", encoding="utf-8", newline="") as fichier:
        lecteur = csv.reader(fichier)
        next(lecteur)                     # la ligne des noms de colonnes
        for nom, vitesse in lecteur:
            plans.append((nom, int(vitesse)))
    return plans
'''
T["image"] = '''

def image(fichier, decor, plans, numero):
    """L'image numéro `numero` : le fond, chaque plan décalé de numero × sa vitesse, puis la fenêtre."""
    commande = [MAGICK] + arguments_fond(decor)
    for nom, vitesse in plans:
        commande = commande + arguments_plan(decor, nom, numero * vitesse) + ["-composite"]
    commande = commande + arguments_fenetre(decor) + ["-composite"]
    commande = commande + [str(fichier)]
    subprocess.run(commande, check=True)
'''


def _serie(source_des_plans):
    return '''

# ---- Une série d'images ------------------------------------------------------

def serie(decor, nombre):
    """`nombre` images, les images numéro 0 à nombre - 1, dans IMAGES ; renvoie le nombre d'images."""
    plans = ''' + source_des_plans + '''
    IMAGES.mkdir(parents=True, exist_ok=True)
    for ancienne in IMAGES.glob("img_*.png"):
        ancienne.unlink()
    for numero in range(nombre):
        fichier = IMAGES / ("img_" + str(numero + 1).zfill(4) + ".png")
        image(fichier, decor, plans, numero)
    return nombre
'''


T["boucle"] = '''

# ---- Une vidéo qui boucle ----------------------------------------------------

LARGEUR_BANDE = 1920      # la largeur des bandes des plans, en pixels


def periode(vitesse):
    """Le nombre d'images après lequel un plan de cette vitesse revient à sa position de départ."""
    return LARGEUR_BANDE // math.gcd(LARGEUR_BANDE, vitesse)


def images_pour_boucler(plans):
    """Le plus petit nombre d'images après lequel tous les plans reviennent ensemble au départ."""
    nombre = 1
    for nom, vitesse in plans:
        nombre = math.lcm(nombre, periode(vitesse))
    return nombre
'''
T["outils-effet"] = '''

# ---- L'effet des poteaux -----------------------------------------------------

def lire(fichier):
    """L'image du fichier, en tableau numpy (hauteur, largeur, 3) d'entiers de 0 à 255."""
    return np.asarray(Image.open(fichier).convert("RGB"))


def ecrire(tableau, fichier):
    """Enregistre le tableau comme image ; le format suit l'extension du fichier."""
    Image.fromarray(tableau).save(fichier)


def appliquer(effet):
    """Applique l'effet à chaque image de la série, en remplaçant le fichier ; renvoie le nombre d'images."""
    fichiers = sorted(IMAGES.glob("img_*.png"))
    for numero, fichier in enumerate(fichiers):
        ecrire(effet(lire(fichier), numero), fichier)
    return len(fichiers)
'''
T["poteaux-constantes"] = '''

# Les ombres des poteaux : des bandes sombres qui passent très vite vers la gauche.
ECART_POTEAUX = 400       # pixels entre deux bandes
LARGEUR_POTEAU = 24       # largeur d'une bande, en pixels
VITESSE_POTEAUX = 90      # pixels par image
'''
T["poteaux-boucle"] = '''

def poteaux_boucle(image, numero):
    """Les bandes des poteaux, pixel par pixel : chaque valeur multipliée par 6/10."""
    hauteur, largeur, _ = image.shape
    resultat = image.copy()
    for y in range(hauteur):
        for x in range(largeur):
            if (x + VITESSE_POTEAUX * numero) % ECART_POTEAUX < LARGEUR_POTEAU:
                for c in range(3):
                    resultat[y, x, c] = int(image[y, x, c]) * 6 // 10
    return resultat
'''
T["poteaux-numpy"] = '''

def poteaux_numpy(image, numero):
    """Les bandes des poteaux, sur les colonnes entières."""
    largeur = image.shape[1]
    colonnes = (np.arange(largeur) + VITESSE_POTEAUX * numero) % ECART_POTEAUX < LARGEUR_POTEAU
    resultat = image.copy()
    # uint16 : sans lui, image * 6 dépasse 255 et le résultat est faux, sans erreur
    resultat[:, colonnes] = image[:, colonnes].astype(np.uint16) * 6 // 10
    return resultat


EFFETS = {"poteaux": poteaux_numpy}
'''


def _main_train(etape):
    rang = ETAPES_TRAIN.index(etape)
    plans = "PLANS" if etape == "c1" else "lire_plans(decor)"
    lignes = ['''

# ---- Le programme ------------------------------------------------------------

def main():
    analyseur = argparse.ArgumentParser(description="La fenêtre du train : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("--numero", type=int, default=0, help="le numéro d'une image seule (défaut : 0)")
    analyseur.add_argument("--decor", default="decor", help="le dossier des images du décor (défaut : decor)")
    analyseur.add_argument("-n", "--images", type=int, help="une série : ce nombre d'images")
''']
    if rang >= ETAPES_TRAIN.index("c4"):
        lignes.append('''    analyseur.add_argument("--boucle", action="store_true", help="une série dont la vidéo boucle sans saut")
''')
    if rang >= ETAPES_TRAIN.index("c3"):
        lignes.append('''    analyseur.add_argument("--effet", choices=sorted(EFFETS), help="un effet appliqué à chaque image de la série")
''')
    lignes.append('''    analyseur.add_argument("--video", action="store_true", help="assemble la série en vidéo (avec --images)")
    analyseur.add_argument("-c", "--cadence", type=int, default=12, help="images par seconde de la vidéo (défaut : 12)")
    analyseur.add_argument("--nettoyer", action="store_true", help="supprime les images de la série une fois la vidéo écrite")
    options = analyseur.parse_args()
    decor = Path(options.decor)
''')
    if etape == "c1":
        lignes.append('''    if not (decor / "fond.png").exists():
        analyseur.error("décor introuvable : " + options.decor)
''')
    else:
        lignes.append('''    if not (decor / "plans.csv").exists():
        analyseur.error("plans.csv introuvable dans " + options.decor)
''')
    if rang >= ETAPES_TRAIN.index("c4"):
        lignes.append('''    if options.boucle:
        options.images = images_pour_boucler(lire_plans(decor))
''')
    lignes.append('''    if options.video and options.images is None:
        analyseur.error("--video demande une série : ajouter --images")
    SORTIE.mkdir(exist_ok=True)

    if options.images is None:
        # Une image
        fichier = SORTIE / ("train_" + str(options.numero).zfill(4) + ".png")
        image(fichier, decor, ''' + plans + ''', options.numero)
        print(fichier, taille(fichier))
    else:
        # Une série d'images
        nombre = serie(decor, options.images)
        print(nombre, "images dans", IMAGES)
''')
    if rang >= ETAPES_TRAIN.index("c3"):
        lignes.append('''        # L'effet, sur chaque image de la série
        if options.effet:
            appliquer(EFFETS[options.effet])
            print("effet", options.effet, "appliqué")
''')
    lignes.append('''        # La vidéo, puis les fichiers intermédiaires supprimés si demandé
        if options.video:
            video = SORTIE / "train.mp4"
            assembler(video, options.cadence)
            print(video, ":", nombre, "images à", options.cadence, "images par seconde")
            if options.nettoyer:
                nettoyer()
                print("images intermédiaires supprimées")
''')
    return "".join(lignes)


def train(etape):
    """Le fichier `train.py` tel qu'il est à la fin de l'étape (voir ETAPES_TRAIN)."""
    if etape == "c0":
        return B6
    rang = ETAPES_TRAIN.index(etape)
    texte = B6[:B6.index("# ---- Le programme")].rstrip("\n") + "\n"
    # Le plan : un fichier en paramètre ; la fonction image : une boucle sur les plans
    texte = _remplacer(texte, cours4.F["plan"].lstrip("\n"), T["plan"].lstrip("\n"))
    image_b6 = cours4.image_train(True, [cours4.LIGNE_PLAN, cours4.LIGNE_FENETRE])
    source_plans = "PLANS" if etape == "c1" else "lire_plans(decor)"
    ajout = (T["plans-liste"] if etape == "c1" else T["plans-csv"]) + T["image"]
    texte = _remplacer(texte, image_b6, ajout)
    # La série : le numéro de l'image, plus de liste de décalages
    ancienne_serie = texte[texte.index("\n\n# ---- Une série d'images"):texte.index("\n\n# ---- La vidéo")]
    nouvelle = _serie(source_plans)
    if rang >= ETAPES_TRAIN.index("c4"):
        nouvelle += T["boucle"]
    texte = texte.replace(ancienne_serie, nouvelle.rstrip("\n"))
    # Les imports
    if rang >= ETAPES_TRAIN.index("c2"):
        texte = _remplacer(texte, "import argparse\n", "import argparse\nimport csv\n")
    if rang >= ETAPES_TRAIN.index("c4"):
        texte = _remplacer(texte, "import csv\n", "import csv\nimport math\n")
    if rang >= ETAPES_TRAIN.index("c3"):
        texte = _remplacer(texte, "from pathlib import Path\n", "from pathlib import Path\n\nimport numpy as np\nfrom PIL import Image\n")
        texte += T["outils-effet"] + T["poteaux-constantes"] + T["poteaux-boucle"] + T["poteaux-numpy"]
    # La description et les exemples
    texte = _remplacer(texte, "    python train.py --decalage 200\n", "    python train.py --numero 40\n")
    if rang >= ETAPES_TRAIN.index("c3"):
        texte = _remplacer(texte, "    python train.py --images 120 --video --cadence 12 --nettoyer\n",
                           "    python train.py --images 120 --video --cadence 12 --nettoyer\n"
                           "    python train.py --images 120 --effet poteaux --video\n")
    if rang >= ETAPES_TRAIN.index("c4"):
        texte = _remplacer(texte, "    python train.py --help\n", "    python train.py --boucle --video\n    python train.py --help\n")
    return texte + _main_train(etape) + APPEL


# ============================================================ écriture et essais

def ecrire(chemin, texte):
    chemin.parent.mkdir(parents=True, exist_ok=True)
    chemin.write_text(texte, encoding="utf-8")


def essayer():
    """Lance chaque programme dans un dossier de test ; s'arrête à la première erreur."""
    import subprocess
    import tempfile
    sys.path.insert(0, str(DEPOT / "data" / "cours4"))
    import make_data

    def lancer(dossier, programme, *arguments, attendu=0):
        resultat = subprocess.run([sys.executable, programme, *arguments], cwd=dossier, capture_output=True, text=True)
        assert resultat.returncode == attendu, (programme, arguments, resultat.stderr)
        return resultat.stdout

    with tempfile.TemporaryDirectory() as dossier:
        dossier = Path(dossier)
        # Les recettes du TD 3a (sans photo : celles de fourni/ si elles sont là), puis les vingt du TD 7a
        import shutil
        photos = DEPOT / "data" / "cours3" / "3a_cli" / "produit" / "depart" / "recettes"
        source = photos if photos.is_dir() else DEPOT / "data" / "cours3" / "recettes"
        shutil.copytree(source, dossier / "recettes")
        shutil.copy(DEPOT / "data" / "cours3" / "recettes" / "style.css", dossier / "style.css")
        for etape in ETAPES_RECETTE[1:]:
            ecrire(dossier / "recette.py", recette(etape))
            lancer(dossier, "recette.py", "crepes", "-p", "2")
            if etape == "c1":
                shutil.copytree(ICI / "7a_recette" / "depart" / "recettes", dossier / "recettes", dirs_exist_ok=True)
            if etape not in ("c1-generer",):
                assert "24 recettes" in lancer(dossier, "recette.py", "--toutes") or etape == "c1"
        assert "crepes : 1" in lancer(dossier, "recette.py", "--frigo", "farine", "lait", "oeufs", "beurre", "sucre", "sel")

    with tempfile.TemporaryDirectory() as dossier:
        dossier = Path(dossier)
        make_data.decor_train(dossier / "decor")
        shutil.copy(ICI / "7b_train" / "depart" / "modeles" / "plans.csv", dossier / "decor" / "plans.csv")
        for etape in ETAPES_TRAIN[1:]:
            ecrire(dossier / "train.py", train(etape))
            assert "640x480" in lancer(dossier, "train.py", "--numero", "40")
            lancer(dossier, "train.py", "--images", "3")
        lancer(dossier, "train.py", "--images", "3", "--effet", "poteaux")
        ecrire(dossier / "test_effet.py", (ICI / "7b_train" / "depart" / "modeles" / "test_effet.py").read_text(encoding="utf-8"))
        assert lancer(dossier, "test_effet.py").count("True") == 4
        sys.path.insert(0, str(dossier))
        # --boucle : le nombre d'images, sans les fabriquer
        espace = {"__name__": "essai"}
        exec(train("c4"), espace)
        assert espace["images_pour_boucler"](espace["lire_plans"](dossier / "decor")) == 480


def main():
    for etape in ["c1", "c2", "c3", "c4"]:
        ecrire(CORRIGES / "7a_recette" / etape / "recette.py", recette(etape))
        ecrire(CORRIGES / "7b_train" / etape / "train.py", train(etape))
    essayer()
    print("ok corriges/7a_recette/c1…c4, corriges/7b_train/c1…c4 : programmes lancés")


if __name__ == "__main__":
    main()
