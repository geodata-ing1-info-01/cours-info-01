"""La fenêtre du train : une image, une série d'images ou une vidéo.

Chaque image superpose trois images du décor : le fond, le plan découpé dans
une bande, puis la fenêtre. Python calcule le décalage du plan sur chaque
image et construit la commande d'ImageMagick ; ffmpeg assemble la vidéo.

    python train.py --decalage 200
    python train.py --images 120
    python train.py --images 120 --video --cadence 12 --nettoyer
    python train.py --help

À lancer dans l'environnement `animation` ; le décor est lu dans `decor/`,
les fichiers sont écrits dans `sortie/`, dans le dossier du terminal.
"""

import argparse
import shutil
import subprocess
from pathlib import Path

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


def arguments_plan(decor, decalage):
    """Les arguments de magick qui lisent la bande du plan, la font tourner de `decalage` colonnes
    vers la gauche, puis en découpent 640 × 480 pixels à partir de la colonne 0."""
    return ["(", str(decor / "plan.png"),
            "-roll", "-" + str(decalage) + "+0",
            "-crop", "640x480+0+0", "+repage", ")"]


def arguments_fenetre(decor):
    """Les arguments de magick qui lisent la fenêtre, une image de 640 × 480 pixels."""
    return [str(decor / "fenetre.png")]


def image(fichier, decor, decalage):
    """Une image de la vidéo, 640 × 480 pixels, écrite dans `fichier`."""
    commande = [MAGICK] + arguments_fond(decor)
    commande = commande + arguments_plan(decor, decalage) + ["-composite"]
    commande = commande + arguments_fenetre(decor) + ["-composite"]
    commande = commande + [str(fichier)]
    subprocess.run(commande, check=True)


def taille(fichier):
    """La largeur et la hauteur de l'image, en pixels, écrites par magick identify : « 640x480 »."""
    resultat = subprocess.run([MAGICK, "identify", "-format", "%wx%h", str(fichier)],
                              capture_output=True, text=True, check=True)
    return resultat.stdout


# ---- Une série d'images (sections 8 et 9 du notebook) -----------------------

VITESSE = 8           # le décalage de plus à chaque image, en pixels


def decalages(nombre, vitesse):
    """Le décalage de chaque image : 0, puis `vitesse` pixels de plus à chaque image."""
    liste = []
    for numero in range(nombre):
        liste.append(numero * vitesse)
    return liste


def serie(decor, nombre):
    """`nombre` images, le plan un peu plus décalé à chaque image, dans IMAGES ; renvoie le nombre d'images."""
    IMAGES.mkdir(parents=True, exist_ok=True)
    for ancienne in IMAGES.glob("img_*.png"):
        ancienne.unlink()
    liste = decalages(nombre, VITESSE)
    numero = 0
    for decalage in liste:
        numero = numero + 1
        fichier = IMAGES / ("img_" + str(numero).zfill(4) + ".png")
        image(fichier, decor, decalage)
    return len(liste)


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


# ---- Le programme ------------------------------------------------------------

def main():
    analyseur = argparse.ArgumentParser(description="La fenêtre du train : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("-d", "--decalage", type=int, default=0, help="le décalage du plan d'une image seule, en pixels (défaut : 0)")
    analyseur.add_argument("--decor", default="decor", help="le dossier des images du décor (défaut : decor)")
    analyseur.add_argument("-n", "--images", type=int, help="une série : ce nombre d'images, le plan décalé de 8 pixels de plus à chaque image")
    analyseur.add_argument("--video", action="store_true", help="assemble la série en vidéo (avec --images)")
    analyseur.add_argument("-c", "--cadence", type=int, default=12, help="images par seconde de la vidéo (défaut : 12)")
    analyseur.add_argument("--nettoyer", action="store_true", help="supprime les images de la série une fois la vidéo écrite")
    options = analyseur.parse_args()
    if options.video and options.images is None:
        analyseur.error("--video demande une série : ajouter --images")
    decor = Path(options.decor)
    if not (decor / "fond.png").exists():
        analyseur.error("décor introuvable : " + options.decor)
    SORTIE.mkdir(exist_ok=True)

    if options.images is None:
        # Une image
        fichier = SORTIE / ("train_" + str(options.decalage).zfill(4) + ".png")
        image(fichier, decor, options.decalage)
        print(fichier, taille(fichier))
    else:
        # Une série d'images
        nombre = serie(decor, options.images)
        print(nombre, "images dans", IMAGES)
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
