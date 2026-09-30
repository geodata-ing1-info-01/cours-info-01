"""Écrit les corrigés, les dépôts de référence et les guides du projet 7, après les avoir vérifiés.

Refait le 30/09/2026 (`syllabus/cours/7_projet_effets/refonte_30-09.md`).
Chaque TD part d'un dépôt git récupéré sur GitHub, le complète sur des
branches, et livre chaque branche par une pull request.

TD 7a, parcours standard, la recette en pages. Départ : le programme du
TD 4a à l'étape B6 (`data/cours4/corriges/4a_recette/b6/`), dans le dépôt de
l'élève ou dans le dépôt de référence `recette`.

    d1  l'option --page : la page HTML d'une recette, par pandoc
    d3  l'option --toutes : toutes les recettes, une boucle sur leurs noms
    d4  le sommaire, sortie/index.html

TD 7b, parcours avancé, la fenêtre du train. Départ : le dépôt de référence
`train`, dont le programme écrit la vidéo de deux plans qui défilent sur le
fond, sans la fenêtre. Deux branches parties du même commit :

    e2  branche fenetre : la fenêtre posée sur chaque image
    e3  branche poteaux : les ombres des poteaux, un calque calculé avec numpy
    e3-fusion  la fusion des deux : le conflit résolu, les poteaux avant la fenêtre

    python generer_projet7.py                  # écrit et vérifie corrigés et guides
    python generer_projet7.py --depots DOSSIER # écrit aussi les deux dépôts de référence, à pousser sur GitHub
"""

from __future__ import annotations

import argparse
import importlib.util
import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ICI = Path(__file__).resolve().parent
DEPOT = ICI.parent.parent
CORRIGES = ICI / "corriges"
TD_RECETTE = ICI / "7a_recette"
TD_TRAIN = ICI / "7b_train"
COURS4 = DEPOT / "data" / "cours4"

sys.path.insert(0, str(DEPOT / "outils"))
from modifications import modifications  # noqa: E402,F401  (employé par guides_projet7.py)

_spec = importlib.util.spec_from_file_location("generer_recette", COURS4 / "generer_recette.py")
recette4 = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(recette4)

sys.path.insert(0, str(COURS4))
from make_data import decor_train  # noqa: E402


def _remplacer(texte, avant, apres):
    assert texte.count(avant) == 1, avant[:80]
    return texte.replace(avant, apres)


def _indenter(texte):
    return "".join(("    " + ligne) if ligne.strip() else ligne for ligne in texte.splitlines(keepends=True))


# ============================================================ TD 7a : la recette en pages

B6 = recette4.version("b6")
TITRE_PROGRAMME = recette4.TITRE_PROGRAMME

TABLEAU = '''

def tableau(ingredients):
    \"\"\"Le tableau Markdown des ingrédients, une ligne par ingrédient.\"\"\"
    lignes = ["| Ingrédient | Quantité |", "|---|---|"]
    for nom, quantite, unite in ingredients:
        lignes.append("| " + nom + " | " + str(round(quantite, 1)) + " " + unite + " |")
    return "\\n".join(lignes)


def ecrire_markdown(nom, personnes, unites, ingredients):
    \"\"\"Le texte de recettes/<nom>.md, avec le tableau des ingrédients sous « ## Ingrédients », écrit dans sortie/ ; renvoie son chemin.\"\"\"
    source = (DONNEES / (nom + ".md")).read_text(encoding="utf-8")
    intitule = "## Ingrédients pour " + str(personnes) + " personnes, en unités " + unites
    complete = source.replace("## Ingrédients", intitule + "\\n\\n" + tableau(ingredients))
    markdown = SORTIE / (nom + ".md")
    markdown.write_text(complete, encoding="utf-8")
    return markdown
'''
PAGE = '''

def ecrire_page(markdown):
    \"\"\"La page HTML d'un fichier Markdown de sortie/, par pandoc, avec la feuille de style ; renvoie son chemin.\"\"\"
    titre = markdown.read_text(encoding="utf-8").splitlines()[0].lstrip("# ")
    shutil.copy(STYLE, markdown.parent / "style.css")
    page = markdown.with_suffix(".html")
    subprocess.run(["pandoc", str(markdown), "-o", str(page), "--standalone",
                    "--css", "style.css", "--metadata", "pagetitle=" + titre], check=True)
    return page
'''
NOMS = '''

def noms_des_recettes():
    \"\"\"Le nom de chaque recette de recettes/ : ses fichiers .csv, sans l'extension.\"\"\"
    noms = []
    for chemin in sorted(DONNEES.glob("*.csv")):
        noms.append(chemin.stem)
    return noms
'''
SOMMAIRE = '''

def ecrire_sommaire(noms):
    \"\"\"Le sommaire : sortie/index.md, un lien vers la page de chaque recette, puis sa page HTML ; renvoie son chemin.\"\"\"
    lignes = ["# Le livre de recettes", ""]
    for nom in noms:
        titre = (DONNEES / (nom + ".md")).read_text(encoding="utf-8").splitlines()[0].lstrip("# ")
        lignes.append("- [" + titre + "](" + nom + ".html)")
    markdown = SORTIE / "index.md"
    markdown.write_text("\\n".join(lignes) + "\\n", encoding="utf-8")
    return ecrire_page(markdown)
'''
OPTION_PAGE = 'analyseur.add_argument("--page", action="store_true", help="écrit aussi la page de la recette : son texte complété, puis sa page HTML")\n'
OPTION_TOUTES = 'analyseur.add_argument("--toutes", action="store_true", help="toutes les recettes de recettes/, au lieu d\'une seule")\n'
LIGNE_U = 'analyseur.add_argument("-u", "--unites", choices=("SI", "US"), default="SI", help="système d\'unités (défaut : SI)")\n'
PAGE_MARKDOWN = '''
if options.page:
    markdown = ecrire_markdown(NOM, PERSONNES, UNITES, ingredients)
    print("écrit :", markdown)
'''
PAGE_HTML = '''    page = ecrire_page(markdown)
    print("écrit :", page)
'''


def _recette_d1(avec_html):
    texte = B6
    if avec_html:
        texte = _remplacer(texte, "import csv\n", "import csv\nimport shutil\nimport subprocess\n")
        texte = _remplacer(texte, 'SORTIE = RACINE / "sortie"\n', 'SORTIE = RACINE / "sortie"\nSTYLE = RACINE / "style.css"\n')
    debut, programme = texte.split(TITRE_PROGRAMME)
    debut = debut.rstrip("\n") + "\n" + TABLEAU + (PAGE if avec_html else "")
    programme = _remplacer(programme, LIGNE_U, LIGNE_U + OPTION_PAGE) + PAGE_MARKDOWN + (PAGE_HTML if avec_html else "")
    return debut + TITRE_PROGRAMME + programme


def _recette_d3(avec_sommaire):
    debut = _recette_d1(True).split(TITRE_PROGRAMME)[0].rstrip("\n") + "\n" + NOMS
    if avec_sommaire:
        debut += SOMMAIRE
    programme = '''
# Les valeurs viennent de la ligne de commande
analyseur = argparse.ArgumentParser(description="Les ingrédients d'une recette pour un nombre de personnes, en unités SI ou US.")
analyseur.add_argument("nom", nargs="?", help="la recette : un fichier de recettes/, sans .csv")
analyseur.add_argument("-p", "--personnes", type=int, default=4, help="nombre de personnes (défaut : 4)")
''' + LIGNE_U + OPTION_PAGE + OPTION_TOUTES + '''options = analyseur.parse_args()
PERSONNES = options.personnes
UNITES = options.unites
if options.toutes:
    noms = noms_des_recettes()
elif options.nom is not None:
    noms = [options.nom]
else:
    analyseur.error("donner le nom d'une recette, ou --toutes")

for nom in noms:
''' + _indenter('''ingredients = lire_ingredients(DONNEES / (nom + ".csv"))
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
''')
    if avec_sommaire:
        programme += '''
# Le sommaire des pages écrites
if options.page and options.toutes:
    sommaire = ecrire_sommaire(noms)
    print("écrit :", sommaire)
'''
    return debut + TITRE_PROGRAMME + programme


def recette(etat):
    """`recette.py` du TD 7a à la fin de l'étape `etat` : a0 (le départ), d1a (le texte complété), d1, d3, d4."""
    return {"a0": lambda: B6, "d1a": lambda: _recette_d1(False), "d1": lambda: _recette_d1(True),
            "d3": lambda: _recette_d3(False), "d4": lambda: _recette_d3(True)}[etat]()


README_RECETTE = """# Recette à l'échelle

Le programme calcule les ingrédients d'une recette pour un nombre de
personnes, en unités SI (grammes, millilitres) ou américaines (onces,
tasses), et écrit le résultat dans un fichier CSV.

## Exécution

Dans le terminal, dans le dossier du projet :

```
python recette.py crepes -p 6 -u US
python recette.py --help
```

Le fichier produit est dans `sortie/`, par exemple `sortie/crepes_6_US.csv`.

## Recettes disponibles

Les fichiers de `recettes/`, chacun écrit pour 4 personnes : `cookies`
(en unités américaines), `crepes`, `mousse_chocolat`, `pate_pizza`.
"""


# ============================================================ TD 7b : la fenêtre du train

DOC_TRAIN = '''"""La vue depuis la fenêtre d'un train : une image, une série d'images ou une vidéo.

Chaque image pose sur le fond les plans du paysage, du plus lointain au plus
proche, chacun décalé selon sa vitesse. Les plans sont décrits dans
decor/plans.csv. Python construit la commande d'ImageMagick ; ffmpeg assemble
la vidéo.

    python train.py --numero 40
    python train.py --images 120 --video
    python train.py --help

À lancer dans l'environnement `train`, depuis le dossier du projet.
"""
'''
IMPORTS_TRAIN = "\nimport argparse\nimport csv\nimport subprocess\nfrom pathlib import Path\n"
IMPORTS_NUMPY = "\nimport numpy as np\nfrom PIL import Image\n"
OUTILS_TRAIN = '''
# Les programmes
MAGICK = "magick"
FFMPEG = "ffmpeg"

# Les chemins partent du dossier du terminal
DECOR = Path.cwd() / "decor"
SORTIE = Path.cwd() / "sortie"
IMAGES = SORTIE / "images"
'''
POTEAUX_CONSTANTES = '''
# Les ombres des poteaux : des bandes sombres qui passent très vite vers la gauche
POTEAUX = SORTIE / "poteaux.png"     # le calque des poteaux, refait pour chaque image
ECART_POTEAUX = 400                  # pixels entre deux bandes
LARGEUR_POTEAU = 24                  # largeur d'une bande, en pixels
VITESSE_POTEAUX = 90                 # pixels par image
'''
IMAGE_DEBUT = '''

# ---- Une image ---------------------------------------------------------------

def lire_plans():
    """Les plans de decor/plans.csv, du plus lointain au plus proche : une liste de (fichier, vitesse)."""
    plans = []
    with open(DECOR / "plans.csv", encoding="utf-8", newline="") as fichier:
        lecteur = csv.reader(fichier)
        next(lecteur)                # la première ligne nomme les colonnes
        for nom, vitesse in lecteur:
            plans.append((nom, int(vitesse)))
    return plans


def arguments_plan(fichier, decalage):
    """Les arguments de magick qui lisent la bande `fichier`, la font tourner de `decalage` colonnes
    vers la gauche, puis en découpent 640 × 480 pixels."""
    return ["(", str(DECOR / fichier), "-roll", "-" + str(decalage) + "+0",
            "-crop", "640x480+0+0", "+repage", ")"]
'''
ECRIRE_POTEAUX = '''

def ecrire_poteaux(fichier, numero):
    """Le calque des poteaux de l'image `numero`, 640 × 480 pixels : des bandes sombres, transparent ailleurs."""
    # Un tableau hauteur × largeur × 4 (rouge, vert, bleu, opacité), à zéro : noir et transparent
    calque = np.zeros((480, 640, 4), dtype=np.uint8)
    # Pour chaque colonne, vrai si elle tombe dans une bande
    colonnes = (np.arange(640) + VITESSE_POTEAUX * numero) % ECART_POTEAUX < LARGEUR_POTEAU
    calque[:, colonnes, 3] = 110     # l'opacité de ces colonnes, sur toute la hauteur
    Image.fromarray(calque).save(fichier)
'''
LIGNE_FENETRE = '    commande = commande + [str(DECOR / "fenetre.png"), "-composite"]\n'
LIGNES_POTEAUX = '    ecrire_poteaux(POTEAUX, numero)\n    commande = commande + [str(POTEAUX), "-composite"]\n'


def _image(lignes):
    return '''

def image(fichier, plans, numero):
    """L'image numéro `numero` : le fond, puis chaque plan décalé de numero × sa vitesse."""
    commande = [MAGICK, str(DECOR / "fond.png")]
    for nom, vitesse in plans:
        commande = commande + arguments_plan(nom, numero * vitesse) + ["-composite"]
''' + lignes + '''    commande = commande + [str(fichier)]
    subprocess.run(commande, check=True)
'''


SERIE_VIDEO = '''

# ---- Une série d'images, une vidéo -------------------------------------------

def serie(nombre):
    """`nombre` images dans IMAGES, numérotées de 0 à nombre - 1."""
    plans = lire_plans()
    IMAGES.mkdir(parents=True, exist_ok=True)
    for ancienne in IMAGES.glob("img_*.png"):
        ancienne.unlink()
    for numero in range(nombre):
        image(IMAGES / ("img_" + str(numero).zfill(4) + ".png"), plans, numero)


def assembler(video, cadence):
    """La vidéo à partir des images img_0000.png, img_0001.png… du dossier IMAGES."""
    subprocess.run([FFMPEG, "-y", "-loglevel", "error", "-framerate", str(cadence),
                    "-i", str(IMAGES / "img_%04d.png"),
                    "-c:v", "mpeg4", "-q:v", "3", "-pix_fmt", "yuv420p", str(video)], check=True)
'''
MAIN_R1 = '''

# ---- Le programme ------------------------------------------------------------

def main():
    analyseur = argparse.ArgumentParser(description="La vue depuis la fenêtre d'un train : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("--numero", type=int, default=0, help="le numéro de l'image (défaut : 0)")
    options = analyseur.parse_args()
    SORTIE.mkdir(exist_ok=True)

    fichier = SORTIE / ("train_" + str(options.numero).zfill(4) + ".png")
    image(fichier, lire_plans(), options.numero)
    print("écrit :", fichier)
'''
MAIN = '''

# ---- Le programme ------------------------------------------------------------

def main():
    analyseur = argparse.ArgumentParser(description="La vue depuis la fenêtre d'un train : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("--numero", type=int, default=0, help="le numéro d'une image seule (défaut : 0)")
    analyseur.add_argument("-n", "--images", type=int, help="une série : ce nombre d'images")
    analyseur.add_argument("--video", action="store_true", help="assemble la série en vidéo (avec --images)")
    analyseur.add_argument("-c", "--cadence", type=int, default=12, help="images par seconde de la vidéo (défaut : 12)")
    options = analyseur.parse_args()
    if options.video and options.images is None:
        analyseur.error("--video demande une série : ajouter --images")
    SORTIE.mkdir(exist_ok=True)

    if options.images is None:
        # Une image
        fichier = SORTIE / ("train_" + str(options.numero).zfill(4) + ".png")
        image(fichier, lire_plans(), options.numero)
        print("écrit :", fichier)
    else:
        # Une série d'images, puis la vidéo si demandé
        serie(options.images)
        print(options.images, "images dans", IMAGES)
        if options.video:
            video = SORTIE / "train.mp4"
            assembler(video, options.cadence)
            print("écrit :", video)
'''
APPEL = '''

# Vrai quand le fichier est lancé par `python`, faux quand il est importé.
if __name__ == "__main__":
    main()
'''


def train(etat):
    """`train.py` du TD 7b : r1, r2 (le dépôt de référence), e2 (fenetre), e3 (poteaux), e3-fusion."""
    numpy = etat in ("e3", "e3-fusion")
    texte = DOC_TRAIN + IMPORTS_TRAIN + (IMPORTS_NUMPY if numpy else "") + OUTILS_TRAIN
    if numpy:
        texte += POTEAUX_CONSTANTES
    texte += IMAGE_DEBUT
    if numpy:
        texte += ECRIRE_POTEAUX
    lignes = {"r1": "", "r2": "", "e2": LIGNE_FENETRE, "e3": LIGNES_POTEAUX, "e3-fusion": LIGNES_POTEAUX + LIGNE_FENETRE}[etat]
    texte += _image(lignes)
    if etat == "r1":
        return texte + MAIN_R1 + APPEL
    return texte + SERIE_VIDEO + MAIN + APPEL


PLANS_CSV = "fichier,vitesse\nvoiles.png,4\nplage_jaune.png,8\n"
ENVIRONNEMENT_TRAIN = """# L'environnement du programme train : conda env create -f environment.yml
name: train
channels:
  - conda-forge
dependencies:
  - python=3.12
  - imagemagick
  - ffmpeg
  - numpy
  - pillow
"""
README_TRAIN = """# Train

La vue depuis la fenêtre d'un train, d'après la scène de la mer du clip
« Moon » de Kid Francescoli (Cauboyz, 2017) : des plans du paysage qui
défilent sur un fond fixe, chacun à sa vitesse.

## Installation

```
conda env create -f environment.yml
conda activate train
```

## Exécution

Dans le dossier du projet :

```
python train.py --numero 40             # une image : sortie/train_0040.png
python train.py --images 120 --video    # 120 images, puis sortie/train.mp4
python train.py --help
```

Les plans sont décrits dans `decor/plans.csv`, du plus lointain au plus
proche : le fichier de la bande et sa vitesse, en pixels par image.

## Le décor

Les images de `decor/` sont dessinées par un programme (ImageMagick, des
polygones de couleur unie).
"""


# ============================================================ les dépôts de référence

def _git(dossier, *arguments, attendu=0):
    # Les messages de git en anglais, comme sur les postes de la salle
    # et des dates fixes : les identifiants des commits ne changent pas d'une génération à l'autre
    env = dict(os.environ, LC_ALL="C.UTF-8", LANGUAGE="en",
               GIT_AUTHOR_DATE="2026-10-06T10:00:00+02:00", GIT_COMMITTER_DATE="2026-10-06T10:00:00+02:00")
    resultat = subprocess.run(["git", "-c", "init.defaultBranch=master", *arguments], cwd=dossier,
                              capture_output=True, text=True, env=env)
    assert resultat.returncode == attendu, (arguments, resultat.stdout, resultat.stderr)
    return resultat.stdout + resultat.stderr


def _identite(dossier, nom="Équipe info01"):
    _git(dossier, "config", "user.name", nom)
    _git(dossier, "config", "user.email", "info01@exemple.fr")


def _commit(dossier, message, fichiers):
    for chemin, texte in fichiers.items():
        cible = dossier / chemin
        cible.parent.mkdir(parents=True, exist_ok=True)
        cible.write_text(texte, encoding="utf-8")
    _git(dossier, "add", ".")
    _git(dossier, "commit", "-q", "-m", message)


def depot_recette(dossier):
    """Le dépôt de référence `recette` : l'historique du TD 4a jusqu'à l'étape B7, étiquette v1.0 comprise."""
    dossier.mkdir(parents=True)
    _git(dossier, "init", "-q")
    _identite(dossier)
    shutil.copytree(COURS4 / "4a_recette" / "depart" / "recettes", dossier / "recettes")
    _commit(dossier, "Le programme de départ et les recettes",
            {".gitignore": "sortie/\n", "recette.py": recette4.version("depart")})
    depart_deux_points = recette4.version("depart").replace("in ingredients\n", "in ingredients:\n")
    _commit(dossier, "Correction : le deux-points de la boucle", {"recette.py": depart_deux_points})
    messages = {"b1": "Correction : l'indentation de la ligne 21", "b2": "Les quantités pour un nombre de personnes",
                "b3": "La conversion des unités", "b4": "Les ingrédients lus dans un fichier CSV",
                "b5": "Le résultat écrit dans un fichier CSV", "b6": "Les valeurs lues sur la ligne de commande"}
    for etat, message in messages.items():
        _commit(dossier, message, {"recette.py": recette4.version(etat)})
    _commit(dossier, "Un README", {"README.md": README_RECETTE})
    _git(dossier, "tag", "-a", "v1.0", "-m", "Première version")


def depot_train(dossier):
    """Le dépôt de référence `train` : une image, puis la série et la vidéo, puis le README."""
    dossier.mkdir(parents=True)
    _git(dossier, "init", "-q")
    _identite(dossier)
    decor_train(dossier / "decor")
    (dossier / "decor" / "plan.png").unlink()     # la bande unique de l'ancien TD 4c, sans emploi ici
    _commit(dossier, "Une image : le fond et les plans lus dans decor/plans.csv",
            {".gitignore": "sortie/\n", "environment.yml": ENVIRONNEMENT_TRAIN,
             "decor/plans.csv": PLANS_CSV, "train.py": train("r1")})
    _commit(dossier, "Une série d'images, puis la vidéo", {"train.py": train("r2")})
    _commit(dossier, "Un README", {"README.md": README_TRAIN})


# ============================================================ écriture et vérifications

def ecrire(chemin, texte):
    chemin.parent.mkdir(parents=True, exist_ok=True)
    chemin.write_text(texte, encoding="utf-8")


def lancer(dossier, *arguments, attendu=0):
    resultat = subprocess.run([sys.executable, *arguments], cwd=dossier, capture_output=True, text=True)
    assert resultat.returncode == attendu, (arguments, resultat.stdout, resultat.stderr)
    return resultat.stdout + resultat.stderr


def verifier_recette():
    """Chaque état du TD 7a, lancé dans un clone du dépôt de référence, avec les fichiers du TD."""
    with tempfile.TemporaryDirectory() as tmp:
        projet = Path(tmp) / "recette"
        depot_recette(projet)
        assert "écrit" in lancer(projet, "recette.py", "crepes", "-p", "6")
        shutil.copy(TD_RECETTE / "depart" / "style.css", projet / "style.css")
        for md in ("crepes", "pate_pizza", "mousse_chocolat", "cookies"):
            shutil.copy(TD_RECETTE / "depart" / "recettes" / (md + ".md"), projet / "recettes")
        ecrire(projet / "recette.py", recette("d1a"))
        lancer(projet, "recette.py", "crepes", "-p", "6", "--page")
        complete = (projet / "sortie" / "crepes.md").read_text(encoding="utf-8")
        assert "## Ingrédients pour 6 personnes, en unités SI" in complete and "| Farine | 375.0 g |" in complete, complete
        ecrire(projet / "recette.py", recette("d1"))
        lancer(projet, "recette.py", "crepes", "-p", "6", "--page")
        page = (projet / "sortie" / "crepes.html").read_text(encoding="utf-8")
        assert "Ingrédients pour 6" in page and "<td>375.0 g</td>" in page, page[:500]
        shutil.copytree(TD_RECETTE / "depart" / "recettes", projet / "recettes", dirs_exist_ok=True)
        ecrire(projet / "recette.py", recette("d3"))
        sortie = lancer(projet, "recette.py", "--toutes", "--page")
        assert sortie.count(".html") == 10, sortie
        lancer(projet, "recette.py", attendu=2)
        ecrire(projet / "recette.py", recette("d4"))
        assert "index.html" in lancer(projet, "recette.py", "--toutes", "--page")
        assert (projet / "sortie" / "index.html").read_text(encoding="utf-8").count("<li>") == 10


def verifier_train():
    """Le TD 7b rejoué : un dépôt nu tient le rôle de GitHub ; la fusion de poteaux s'arrête sur un conflit."""
    with tempfile.TemporaryDirectory() as tmp:
        tmp = Path(tmp)
        depot_train(tmp / "reference")
        _git(tmp, "clone", "-q", "--bare", "reference", "github.git")
        _git(tmp, "clone", "-q", "github.git", "eleve")
        eleve = tmp / "eleve"
        _identite(eleve, "Élève")
        _git(eleve, "config", "pull.rebase", "false")
        assert "écrit" in lancer(eleve, "train.py", "--numero", "40")
        assert "écrit" in lancer(eleve, "train.py", "--images", "3", "--video")
        _git(eleve, "branch", "fenetre")
        _git(eleve, "branch", "poteaux")
        # La fenêtre, sur sa branche, puis fusionnée sur « GitHub » par une pull request
        _git(eleve, "checkout", "-q", "fenetre")
        _commit(eleve, "La fenêtre posée sur chaque image", {"train.py": train("e2")})
        lancer(eleve, "train.py", "--numero", "40")
        _git(eleve, "push", "-q", "-u", "origin", "fenetre")
        with tempfile.TemporaryDirectory() as site:
            site = Path(site) / "site"
            _git(tmp, "clone", "-q", "github.git", str(site))
            _identite(site, "GitHub")
            _git(site, "merge", "-q", "--no-ff", "origin/fenetre", "-m", "Merge pull request #1 from eleve/fenetre")
            _git(site, "push", "-q", "origin", "master")
        # Les poteaux, sur la branche partie du même commit
        _git(eleve, "checkout", "-q", "poteaux")
        assert "fenetre.png" not in (eleve / "train.py").read_text(encoding="utf-8")
        _commit(eleve, "Les ombres des poteaux", {"train.py": train("e3")})
        lancer(eleve, "train.py", "--numero", "40")
        sortie = _git(eleve, "pull", "origin", "master", attendu=1)
        assert "CONFLICT (content): Merge conflict in train.py" in sortie, sortie
        en_conflit = (eleve / "train.py").read_text(encoding="utf-8")
        assert "<<<<<<< HEAD" in en_conflit
        ecrire(eleve / "train.py", train("e3-fusion"))
        _git(eleve, "add", "train.py")
        _git(eleve, "commit", "-q", "--no-edit")
        assert "écrit" in lancer(eleve, "train.py", "--images", "3", "--video")
        return en_conflit, sortie


def main():
    analyseur = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    analyseur.add_argument("--depots", type=Path, help="écrit les dépôts de référence recette et train dans ce dossier")
    options = analyseur.parse_args()

    for etat in ("d1a", "d1", "d3", "d4"):
        ecrire(CORRIGES / "7a_recette" / etat / "recette.py", recette(etat))
    for etat in ("r2", "e2", "e3", "e3-fusion"):
        ecrire(CORRIGES / "7b_train" / etat / "train.py", train(etat))
    verifier_recette()
    verifier_train()
    print("ok : corrigés des TD 7a et 7b écrits et vérifiés ; conflit rejoué au TD 7b")

    import guides_projet7
    guides_projet7.ecrire_guides()

    if options.depots:
        for nom, fabriquer in (("recette", depot_recette), ("train", depot_train)):
            cible = options.depots / nom
            if cible.exists():
                shutil.rmtree(cible)
            fabriquer(cible)
            print("dépôt de référence :", cible)


if __name__ == "__main__":
    main()
