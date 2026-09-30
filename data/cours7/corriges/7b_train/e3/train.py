"""La vue depuis la fenêtre d'un train : une image, une série d'images ou une vidéo.

Chaque image pose sur le fond les plans du paysage, du plus lointain au plus
proche, chacun décalé selon sa vitesse. Les plans sont décrits dans
decor/plans.csv. Python construit la commande d'ImageMagick ; ffmpeg assemble
la vidéo.

    python train.py --numero 40
    python train.py --images 120 --video
    python train.py --help

À lancer dans l'environnement `train`, depuis le dossier du projet.
"""

import argparse
import csv
import subprocess
from pathlib import Path

import numpy as np
from PIL import Image

# Les programmes
MAGICK = "magick"
FFMPEG = "ffmpeg"

# Les chemins partent du dossier du terminal
DECOR = Path.cwd() / "decor"
SORTIE = Path.cwd() / "sortie"
IMAGES = SORTIE / "images"

# Les ombres des poteaux : des bandes sombres qui passent très vite vers la gauche
POTEAUX = SORTIE / "poteaux.png"     # le calque des poteaux, refait pour chaque image
ECART_POTEAUX = 400                  # pixels entre deux bandes
LARGEUR_POTEAU = 24                  # largeur d'une bande, en pixels
VITESSE_POTEAUX = 90                 # pixels par image


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


def ecrire_poteaux(fichier, numero):
    """Le calque des poteaux de l'image `numero`, 640 × 480 pixels : des bandes sombres, transparent ailleurs."""
    # Un tableau hauteur × largeur × 4 (rouge, vert, bleu, opacité), à zéro : noir et transparent
    calque = np.zeros((480, 640, 4), dtype=np.uint8)
    # Pour chaque colonne, vrai si elle tombe dans une bande
    colonnes = (np.arange(640) + VITESSE_POTEAUX * numero) % ECART_POTEAUX < LARGEUR_POTEAU
    calque[:, colonnes, 3] = 110     # l'opacité de ces colonnes, sur toute la hauteur
    Image.fromarray(calque).save(fichier)


def image(fichier, plans, numero):
    """L'image numéro `numero` : le fond, puis chaque plan décalé de numero × sa vitesse."""
    commande = [MAGICK, str(DECOR / "fond.png")]
    for nom, vitesse in plans:
        commande = commande + arguments_plan(nom, numero * vitesse) + ["-composite"]
    ecrire_poteaux(POTEAUX, numero)
    commande = commande + [str(POTEAUX), "-composite"]
    commande = commande + [str(fichier)]
    subprocess.run(commande, check=True)


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


# Vrai quand le fichier est lancé par `python`, faux quand il est importé.
if __name__ == "__main__":
    main()
