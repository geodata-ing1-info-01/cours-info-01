"""La fenêtre du train : une image, une série d'images ou une vidéo.

Chaque image superpose trois images du décor : le fond, le plan découpé dans
une bande, puis la fenêtre. Python calcule le décalage du plan sur chaque
image et construit la commande d'ImageMagick ; ffmpeg assemble la vidéo.

    python train.py --numero 40
    python train.py --images 120
    python train.py --images 120 --video --cadence 12 --nettoyer
    python train.py --images 120 --effet poteaux --video
    python train.py --help

À lancer dans l'environnement `animation` ; le décor est lu dans `decor/`,
les fichiers sont écrits dans `sortie/`, dans le dossier du terminal.
"""

import argparse
import csv
import shutil
import subprocess
from pathlib import Path

import numpy as np
from PIL import Image

# Les programmes
MAGICK = "magick"
FFMPEG = "ffmpeg"

# Les fichiers produits vont dans sortie/, dans le dossier du terminal
SORTIE = Path.cwd() / "sortie"
IMAGES = SORTIE / "images"


# ---- Une image (sections 3 à 7 du notebook) ---------------------------------

def arguments_fond(decor):
    """Les arguments de magick qui lisent le fond, une image de 640 × 480 pixels."""
    return [str(decor / "fond.png")]


def arguments_plan(decor, fichier, decalage):
    """Les arguments de magick qui lisent la bande `fichier`, la font tourner de `decalage` colonnes
    vers la gauche, puis en découpent 640 × 480 pixels à partir de la colonne 0."""
    return ["(", str(decor / fichier),
            "-roll", "-" + str(decalage) + "+0",
            "-crop", "640x480+0+0", "+repage", ")"]


def arguments_fenetre(decor):
    """Les arguments de magick qui lisent la fenêtre, une image de 640 × 480 pixels."""
    return [str(decor / "fenetre.png")]


def lire_plans(decor):
    """Les plans de `decor/plans.csv`, du plus lointain au plus proche : une liste de (fichier, vitesse)."""
    plans = []
    with open(decor / "plans.csv", encoding="utf-8", newline="") as fichier:
        lecteur = csv.reader(fichier)
        next(lecteur)                     # la ligne des noms de colonnes
        for nom, vitesse in lecteur:
            plans.append((nom, int(vitesse)))
    return plans


def image(fichier, decor, plans, numero):
    """L'image numéro `numero` : le fond, chaque plan décalé de numero × sa vitesse, puis la fenêtre."""
    commande = [MAGICK] + arguments_fond(decor)
    for nom, vitesse in plans:
        commande = commande + arguments_plan(decor, nom, numero * vitesse) + ["-composite"]
    commande = commande + arguments_fenetre(decor) + ["-composite"]
    commande = commande + [str(fichier)]
    subprocess.run(commande, check=True)


def taille(fichier):
    """La largeur et la hauteur de l'image, en pixels, écrites par magick identify : « 640x480 »."""
    resultat = subprocess.run([MAGICK, "identify", "-format", "%wx%h", str(fichier)],
                              capture_output=True, text=True, check=True)
    return resultat.stdout


# ---- Une série d'images ------------------------------------------------------

def serie(decor, nombre):
    """`nombre` images, les images numéro 0 à nombre - 1, dans IMAGES ; renvoie le nombre d'images."""
    plans = lire_plans(decor)
    IMAGES.mkdir(parents=True, exist_ok=True)
    for ancienne in IMAGES.glob("img_*.png"):
        ancienne.unlink()
    for numero in range(nombre):
        fichier = IMAGES / ("img_" + str(numero + 1).zfill(4) + ".png")
        image(fichier, decor, plans, numero)
    return nombre

# ---- La vidéo (section 9 du notebook, seconde cellule) ----------------------

def assembler(video, cadence):
    """La vidéo à partir des images img_0001.png, img_0002.png… du dossier IMAGES."""
    subprocess.run([FFMPEG, "-y", "-loglevel", "error",
                    "-framerate", str(cadence),
                    "-i", str(IMAGES / "img_%04d.png"),
                    "-c:v", "mpeg4", "-q:v", "3", "-pix_fmt", "yuv420p",
                    str(video)], check=True)


def nettoyer():
    """Supprime les fichiers intermédiaires : le dossier des images de la série."""
    shutil.rmtree(IMAGES)


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


# Les ombres des poteaux : des bandes sombres qui passent très vite vers la gauche.
ECART_POTEAUX = 400       # pixels entre deux bandes
LARGEUR_POTEAU = 24       # largeur d'une bande, en pixels
VITESSE_POTEAUX = 90      # pixels par image


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


def poteaux_numpy(image, numero):
    """Les bandes des poteaux, sur les colonnes entières."""
    largeur = image.shape[1]
    colonnes = (np.arange(largeur) + VITESSE_POTEAUX * numero) % ECART_POTEAUX < LARGEUR_POTEAU
    resultat = image.copy()
    # uint16 : sans lui, image * 6 dépasse 255 et le résultat est faux, sans erreur
    resultat[:, colonnes] = image[:, colonnes].astype(np.uint16) * 6 // 10
    return resultat


EFFETS = {"poteaux": poteaux_numpy}


# ---- Le programme ------------------------------------------------------------

def main():
    analyseur = argparse.ArgumentParser(description="La fenêtre du train : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("--numero", type=int, default=0, help="le numéro d'une image seule (défaut : 0)")
    analyseur.add_argument("--decor", default="decor", help="le dossier des images du décor (défaut : decor)")
    analyseur.add_argument("-n", "--images", type=int, help="une série : ce nombre d'images")
    analyseur.add_argument("--effet", choices=sorted(EFFETS), help="un effet appliqué à chaque image de la série")
    analyseur.add_argument("--video", action="store_true", help="assemble la série en vidéo (avec --images)")
    analyseur.add_argument("-c", "--cadence", type=int, default=12, help="images par seconde de la vidéo (défaut : 12)")
    analyseur.add_argument("--nettoyer", action="store_true", help="supprime les images de la série une fois la vidéo écrite")
    options = analyseur.parse_args()
    decor = Path(options.decor)
    if not (decor / "plans.csv").exists():
        analyseur.error("plans.csv introuvable dans " + options.decor)
    if options.video and options.images is None:
        analyseur.error("--video demande une série : ajouter --images")
    SORTIE.mkdir(exist_ok=True)

    if options.images is None:
        # Une image
        fichier = SORTIE / ("train_" + str(options.numero).zfill(4) + ".png")
        image(fichier, decor, lire_plans(decor), options.numero)
        print(fichier, taille(fichier))
    else:
        # Une série d'images
        nombre = serie(decor, options.images)
        print(nombre, "images dans", IMAGES)
        # L'effet, sur chaque image de la série
        if options.effet:
            appliquer(EFFETS[options.effet])
            print("effet", options.effet, "appliqué")
        # La vidéo, puis les fichiers intermédiaires supprimés si demandé
        if options.video:
            video = SORTIE / "train.mp4"
            assembler(video, options.cadence)
            print(video, ":", nombre, "images à", options.cadence, "images par seconde")
            if options.nettoyer:
                nettoyer()
                print("images intermédiaires supprimées")


# Vrai quand le fichier est lancé par `python`, faux quand il est importé par
# un autre fichier : dans ce cas, main() n'est pas appelé.
if __name__ == "__main__":
    main()
