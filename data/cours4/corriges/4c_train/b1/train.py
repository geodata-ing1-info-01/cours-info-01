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


def image(fichier, decor):
    """Une image de la vidéo, 640 × 480 pixels, écrite dans `fichier`."""
    commande = [MAGICK] + arguments_fond(decor)
    commande = commande + [str(fichier)]
    subprocess.run(commande, check=True)


def taille(fichier):
    """La largeur et la hauteur de l'image, en pixels, écrites par magick identify : « 640x480 »."""
    resultat = subprocess.run([MAGICK, "identify", "-format", "%wx%h", str(fichier)],
                              capture_output=True, text=True, check=True)
    return resultat.stdout


# ---- Le programme ------------------------------------------------------------

def main():
    analyseur = argparse.ArgumentParser(description="La fenêtre du train : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("--decor", default="decor", help="le dossier des images du décor (défaut : decor)")
    options = analyseur.parse_args()
    decor = Path(options.decor)
    if not (decor / "fond.png").exists():
        analyseur.error("décor introuvable : " + options.decor)
    SORTIE.mkdir(exist_ok=True)

    # Une image
    fichier = SORTIE / "train.png"
    image(fichier, decor)
    print(fichier, taille(fichier))


# Vrai quand le fichier est lancé par `python`, faux quand il est importé par
# un autre fichier : dans ce cas, main() n'est pas appelé.
if __name__ == "__main__":
    main()
