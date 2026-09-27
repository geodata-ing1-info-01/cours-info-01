---
title: La Vague en tourbillon
subtitle: Une image tordue par ImageMagick, un angle calculé par Python, une vidéo par ffmpeg
execution: ../../travail
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# La Vague en tourbillon

Ce notebook fabrique une vidéo de quatre secondes : *La Grande Vague* de
Hokusai (The Met, CC0), l'image du cours 3, se tord en tourbillon puis se
détord. Chaque image de la vidéo est tordue d'un angle différent, de 0 à 360
degrés, puis de 360 à 0.

La fonction Python `angles` calcule la liste des angles de torsion ; pour
chaque angle, la fonction `image` construit la commande qui tord l'image.
Deux programmes en ligne de commande, comme git (cours 2) et pandoc
(cours 3), font le reste :

- ImageMagick (`magick`) réduit l'image, puis tord chaque copie et écrit
  l'angle en bas ;
- ffmpeg assemble les images en une vidéo.

Python lance ces deux programmes avec `subprocess.run` : il automatise
l'ensemble des étapes. Dans la partie B du TD, le code de ce notebook
devient un script `tourbillon.py`, appelable en ligne de commande. Le schéma
suivant montre les étapes de ce script final, avec des images de la vidéo
produite :

![Les étapes du script tourbillon.py](../depart/illustrations/programme_tourbillon.png)

Le notebook a six parties :

1. Les outils : vérifier que `magick` et `ffmpeg` sont trouvés.
2. Une image : la fonction qui appelle ImageMagick.
3. L'image de départ.
4. Le tourbillon.
5. Les angles et le texte.
6. La vidéo.

Dans la partie B du TD, le programme `tourbillon.py` reprend ces sections
fonctionnalité par fonctionnalité : les sections 2 à 4 et la fonction
`texte_angle` pour tordre une image (étape B1), la fonction `angles` et la
première cellule de la section 6 pour la série d'images (B2), la seconde
cellule de la section 6 pour la vidéo (B3).

Le notebook est livré dans `depart/notebook/`. Le copier dans `travail/`
avant de l'ouvrir. Les fichiers qu'il crée sont écrits dans
`travail/produit/`.

## 1 · Les outils

`magick` et `ffmpeg` sont des programmes, installés dans l'environnement
`animation`. `shutil.which` renvoie le chemin du programme trouvé, ou `None`
si le programme n'est pas trouvé (cours 3, notebook `recette`, section 4.3).

```{code-cell} ipython3
import shutil
import subprocess
import sys
from pathlib import Path

from IPython.display import Image, Video

print("Python :", sys.executable)
print("magick :", shutil.which("magick"))
print("ffmpeg :", shutil.which("ffmpeg"))
```

Les trois chemins doivent être dans le dossier de l'environnement
`animation`. Si `magick` ou `ffmpeg` vaut `None`, JupyterLab n'a pas été
lancé depuis l'environnement `animation` : voir l'étape A4 du guide.

La police des textes est Arial sous Windows, DejaVu sous Linux.

```{code-cell} ipython3
MAGICK = "magick"
FFMPEG = "ffmpeg"

POLICE = None
for candidate in ["C:/Windows/Fonts/arial.ttf", "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"]:
    if Path(candidate).exists():
        POLICE = candidate
print("police :", POLICE)

PRODUIT = Path.cwd() / "produit"
IMAGES = PRODUIT / "images"
IMAGES.mkdir(parents=True, exist_ok=True)
print(PRODUIT)
```

## 2 · Une image

`lancer` exécute une commande donnée sous forme de liste : le programme, puis
chaque argument. `check=True` arrête le notebook si la commande échoue.

`image` construit la commande `magick` d'une image de 640 × 480 pixels :

- le premier argument est l'image à lire ;
- `-swirl angle` la tord autour de son centre ;
- `-extent 640x480` complète l'image par une bande couleur crème en bas ;
- `-annotate` écrit le texte dans cette bande ;
- le dernier argument est le fichier à écrire.

```{code-cell} ipython3
def lancer(commande):
    """Lance une commande (le programme, puis chaque argument) ; s'arrête si elle échoue."""
    subprocess.run(commande, check=True)


def image(fichier, source, angle, texte):
    """Une image 640 × 480 : la source tordue de `angle` degrés, puis le texte en bas."""
    commande = [MAGICK, str(source), "-swirl", str(angle),
                "-background", "#fbf7ee", "-gravity", "North", "-extent", "640x480",
                "-font", POLICE, "-pointsize", "22", "-fill", "#333333",
                "-gravity", "South", "-annotate", "+0+14", texte]
    commande.append(str(fichier))
    lancer(commande)
```

## 3 · L'image de départ

L'image est dans `depart/`, un dossier au-dessus de `travail/`. Elle fait
2 000 × 1 344 pixels ; `-resize 640x` la réduit à 640 pixels de large, la
hauteur suivant la proportion (430 pixels). Chaque image de la vidéo part de
cette copie réduite : `magick` travaille plus vite sur une petite image.

```{code-cell} ipython3
VAGUE = Path.cwd().parent / "depart" / "vague.jpg"
print(VAGUE, VAGUE.exists())

PETITE = PRODUIT / "vague_640.png"
lancer([MAGICK, str(VAGUE), "-resize", "640x", str(PETITE)])

image(PRODUIT / "essai.png", PETITE, 0, "sans tourbillon")
Image(str(PRODUIT / "essai.png"))
```

## 4 · Le tourbillon

`-swirl 180` tord l'image de 180 degrés au centre ; la torsion diminue vers
les bords.

```{code-cell} ipython3
image(PRODUIT / "essai_tourbillon.png", PETITE, 180, "tourbillon : 180°")
Image(str(PRODUIT / "essai_tourbillon.png"))
```

## 5 · Les angles et le texte

La fonction `angles` renvoie la liste des angles de la vidéo : de 0 à
`maximum` par pas de `pas` degrés, puis retour à 0. Le texte sous l'image
indique l'angle.

```{code-cell} ipython3
def angles(maximum, pas):
    """Les angles de 0 à `maximum`, puis de retour à 0, de `pas` en `pas` degrés."""
    liste = []
    for angle in range(0, maximum + 1, pas):        # 0, 15, 30 … maximum
        liste.append(angle)
    for angle in range(maximum - pas, -1, -pas):    # puis retour à 0
        liste.append(angle)
    return liste


def texte_angle(angle):
    """Le texte sous l'image : le titre du tableau et l'angle."""
    return "Hokusai, La Grande Vague · tourbillon : " + str(angle) + "°"


print(angles(90, 15))
image(PRODUIT / "essai_texte.png", PETITE, 90, texte_angle(90))
Image(str(PRODUIT / "essai_texte.png"))
```

## 6 · La vidéo

Une image par angle : avec `MAXIMUM = 360` et `PAS = 15`, 49 images, nommées
`img_0001.png`, `img_0002.png`… Les images d'une exécution précédente sont
d'abord supprimées.

```{code-cell} ipython3
MAXIMUM = 360       # l'angle le plus grand
PAS = 15            # l'écart entre deux images, en degrés

for ancienne in IMAGES.glob("img_*.png"):
    ancienne.unlink()

liste = angles(MAXIMUM, PAS)
numero = 0
for angle in liste:
    numero = numero + 1
    nom = "img_" + str(numero).zfill(4) + ".png"
    image(IMAGES / nom, PETITE, angle, texte_angle(angle))
print(len(liste), "images dans", IMAGES)
```

ffmpeg lit les images `img_0001.png`, `img_0002.png`… (`img_%04d.png` : quatre
chiffres) et écrit la vidéo. `-framerate 12` : douze images par seconde, la
vidéo dure 49 / 12 ≈ 4 secondes.

```{code-cell} ipython3
CADENCE = 12

lancer([FFMPEG, "-y", "-loglevel", "error",
        "-framerate", str(CADENCE),
        "-i", str(IMAGES / "img_%04d.png"),
        "-c:v", "mpeg4", "-q:v", "3", "-pix_fmt", "yuv420p",
        str(PRODUIT / "tourbillon.mp4")])
Video(str(PRODUIT / "tourbillon.mp4"), embed=True, width=480)
```

La vidéo est le fichier `travail/produit/tourbillon.mp4` : elle s'ouvre aussi
par un double-clic dans l'explorateur.

:::{admonition} À essayer
Changer `MAXIMUM` (par exemple 720) ou `CADENCE`, puis relancer les deux
dernières cellules. Remplacer `VAGUE` par une autre image `.jpg` ou `.png`.
Ce sont les trois valeurs que la partie B passera sur la ligne de commande.
:::
