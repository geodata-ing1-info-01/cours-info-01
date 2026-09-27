---
title: La montre du Lapin blanc
subtitle: Un cadran dessiné par ImageMagick, des aiguilles placées par Python, une vidéo par ffmpeg
execution: ../../travail
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# La montre du Lapin blanc

Ce notebook fabrique une vidéo de dix secondes : une montre de gousset dont
les aiguilles avancent d'une minute par image, de 10 h à 12 h, à côté du
Lapin blanc d'*Alice au pays des merveilles* (Lewis Carroll, 1865 ;
traduction d'Henri Bué, 1869, domaine public).

Pour chaque minute, les fonctions Python calculent l'angle des deux
aiguilles et la position de leurs extrémités, puis construisent la commande
qui dessine l'image. Deux programmes en ligne de commande, comme git
(cours 2) et pandoc (cours 3), font le reste :

- ImageMagick (`magick`) dessine chaque image ;
- ffmpeg assemble les images en une vidéo.

Python lance ces deux programmes avec `subprocess.run` : il automatise
l'ensemble des étapes. Dans la partie B du TD, le code de ce notebook
devient un script `montre.py`, appelable en ligne de commande. Le schéma
suivant montre les étapes de ce script final, avec des images de la vidéo
produite :

![Les étapes du script montre.py](../depart/illustrations/programme_montre.png)

Le notebook a six parties :

1. Les outils : vérifier que `magick` et `ffmpeg` sont trouvés.
2. Une image : la fonction qui appelle ImageMagick.
3. Le cadran.
4. Les aiguilles.
5. Le Lapin et le texte.
6. La vidéo.

Dans la partie B du TD, le programme `montre.py` reprend ces sections
fonctionnalité par fonctionnalité : les sections 2 à 5 pour dessiner une
image (étape B1), la première cellule de la section 6 pour la série d'images
(B2), la seconde cellule de la section 6 pour la vidéo (B3).

Le notebook est livré dans `depart/notebook/`. Le copier dans `travail/`
avant de l'ouvrir. Les fichiers qu'il crée sont écrits dans
`travail/produit/`.

## 1 · Les outils

`magick` et `ffmpeg` sont des programmes, installés dans l'environnement
`animation`. `shutil.which` renvoie le chemin du programme trouvé, ou `None`
si le programme n'est pas trouvé (cours 3, notebook `recette`, section 4.3).

```{code-cell} ipython3
import math
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

- `-size 640x480 xc:#fbf7ee` crée une image unie, couleur crème ;
- chaque `-draw "…"` dessine des formes, dans l'ordre de la liste ;
- `-annotate` écrit le texte en bas de l'image ;
- le dernier argument est le fichier à écrire.

```{code-cell} ipython3
def lancer(commande):
    """Lance une commande (le programme, puis chaque argument) ; s'arrête si elle échoue."""
    subprocess.run(commande, check=True)


def image(fichier, dessins, texte):
    """Une image 640 × 480 : les dessins dans l'ordre, puis le texte en bas."""
    commande = [MAGICK, "-size", "640x480", "xc:#fbf7ee", "-font", POLICE, "-pointsize", "26"]
    for dessin in dessins:
        commande.append("-draw")
        commande.append(dessin)
    commande = commande + ["-pointsize", "22", "-fill", "#333333",
                           "-gravity", "South", "-annotate", "+0+18", texte]
    commande.append(str(fichier))
    lancer(commande)


image(PRODUIT / "essai.png", ["fill #7a5a1e circle 320,240 320,300"], "un essai")
Image(str(PRODUIT / "essai.png"))
```

## 3 · Le cadran

Le centre du cadran est en (`CX`, `CY`), son rayon vaut `R`. Le boîtier est
un cercle ; l'anneau, un petit cercle et un rectangle au-dessus ; les chiffres,
du texte placé par `text x,y '12'`.

```{code-cell} ipython3
CX = 380
CY = 240
R = 150

BOITIER = ("fill #f7f1df stroke #7a5a1e stroke-width 8 "
           "circle " + str(CX) + "," + str(CY) + " " + str(CX) + "," + str(CY + R))
ANNEAU = ("fill #c9a227 stroke #7a5a1e stroke-width 3 "
          "circle " + str(CX) + "," + str(CY - R - 22) + " " + str(CX) + "," + str(CY - R - 8) + " "
          "rectangle " + str(CX - 10) + "," + str(CY - R - 12) + " " + str(CX + 10) + "," + str(CY - R + 4))
CHIFFRES = ("fill #333333 stroke none "
            "text " + str(CX - 14) + "," + str(CY - R + 42) + " '12' "
            "text " + str(CX + R - 44) + "," + str(CY + 9) + " '3' "
            "text " + str(CX - 8) + "," + str(CY + R - 26) + " '6' "
            "text " + str(CX - R + 30) + "," + str(CY + 9) + " '9'")

image(PRODUIT / "essai_cadran.png", [BOITIER, ANNEAU, CHIFFRES], "")
Image(str(PRODUIT / "essai_cadran.png"))
```

Les soixante graduations sont des traits sur le bord du cadran, un tous les
six degrés. Le point à la distance `d` du centre, dans la direction `angle`
(0 en haut, 90 à droite), a pour coordonnées
`(CX + d × sin(angle), CY − d × cos(angle))`. La fonction `point` fait ce
calcul ; la boucle ajoute un trait à la chaîne `graduations` à chaque itération.

```{code-cell} ipython3
def point(distance, angle_degres):
    """Le point à `distance` du centre du cadran, dans la direction `angle_degres` (0 en haut, 90 à droite)."""
    angle = math.radians(angle_degres)
    x = CX + distance * math.sin(angle)
    y = CY - distance * math.cos(angle)
    return str(round(x)) + "," + str(round(y))


graduations = "fill none stroke #333333 stroke-width 2 "
for k in range(60):
    angle = k * 6
    if k % 5 == 0:
        longueur = 14        # un trait long toutes les cinq minutes
    else:
        longueur = 6
    graduations = graduations + "line " + point(R - 6, angle) + " " + point(R - 6 - longueur, angle) + " "
GRADUATIONS = graduations

image(PRODUIT / "essai_graduations.png", [BOITIER, ANNEAU, GRADUATIONS, CHIFFRES], "")
Image(str(PRODUIT / "essai_graduations.png"))
```

## 4 · Les aiguilles

L'aiguille des minutes fait un tour en soixante minutes : six degrés par
minute. L'aiguille des heures fait un tour en douze heures : trente degrés
par heure, plus un demi-degré par minute. Les deux partent du centre ;
`point` donne l'autre extrémité.

```{code-cell} ipython3
def aiguilles(heures, minutes):
    """Les deux aiguilles pour cette heure, et l'axe au centre."""
    angle_heures = 30 * heures + 0.5 * minutes
    angle_minutes = 6 * minutes
    centre = str(CX) + "," + str(CY)
    return ("fill none stroke #222222 stroke-linecap round "
            "stroke-width 8 line " + centre + " " + point(80, angle_heures) + " "
            "stroke-width 5 line " + centre + " " + point(120, angle_minutes) + " "
            "fill #222222 stroke none circle " + centre + " " + str(CX) + "," + str(CY + 7))


image(PRODUIT / "essai_aiguilles.png", [BOITIER, ANNEAU, GRADUATIONS, CHIFFRES, aiguilles(10, 5)], "10 h 05")
Image(str(PRODUIT / "essai_aiguilles.png"))
```

## 5 · Le Lapin et le texte

Le Lapin est dessiné avec des formes simples : deux ellipses pour les
oreilles, un cercle pour la tête, deux petits cercles pour les yeux, des
traits pour les moustaches. Le texte sous l'image est la citation, suivie de
l'heure.

```{code-cell} ipython3
LAPIN = ("fill #ffffff stroke #666666 stroke-width 3 "
         "ellipse 95,110 16,60 0,360  ellipse 145,110 16,60 0,360 "          # les oreilles
         "fill #f4b6c2 stroke none ellipse 95,110 7,42 0,360  ellipse 145,110 7,42 0,360 "
         "fill #ffffff stroke #666666 stroke-width 3 circle 120,205 120,255 "  # la tête
         "fill #e8607a stroke none circle 103,198 103,206  circle 137,198 137,206 "  # les yeux
         "fill #f4b6c2 stroke none ellipse 120,222 6,4 0,360 "                 # le nez
         "fill none stroke #666666 stroke-width 2 "
         "line 65,226 113,222  line 65,240 113,226  line 127,222 175,226  line 127,226 175,240")

CITATION = "« Ah ! j’arriverai trop tard ! »"


def texte_heure(heures, minutes):
    """La citation, puis l'heure écrite « 10 h 05 »."""
    return CITATION + "\n" + str(heures) + " h " + str(minutes).zfill(2)


image(PRODUIT / "essai_lapin.png",
      [BOITIER, ANNEAU, GRADUATIONS, CHIFFRES, aiguilles(10, 5), LAPIN],
      texte_heure(10, 5))
Image(str(PRODUIT / "essai_lapin.png"))
```

## 6 · La vidéo

Une image par minute, de 10 h 00 à 12 h 00 : cent vingt images, nommées
`img_0001.png`, `img_0002.png`… Les images d'une exécution précédente sont
d'abord supprimées.

```{code-cell} ipython3
DEBUT = 10          # l'heure de la première image
MINUTES = 120       # le nombre d'images, une par minute

for ancienne in IMAGES.glob("img_*.png"):
    ancienne.unlink()

for t in range(MINUTES):                 # t : les minutes écoulées depuis le début
    heures = DEBUT + t // 60
    minutes = t % 60
    nom = "img_" + str(t + 1).zfill(4) + ".png"
    image(IMAGES / nom,
          [BOITIER, ANNEAU, GRADUATIONS, CHIFFRES, aiguilles(heures, minutes), LAPIN],
          texte_heure(heures, minutes))
print(MINUTES, "images dans", IMAGES)
```

ffmpeg lit les images `img_0001.png`, `img_0002.png`… (`img_%04d.png` : quatre
chiffres) et écrit la vidéo. `-framerate 12` : douze images par seconde, la
vidéo dure 120 / 12 = 10 secondes.

```{code-cell} ipython3
CADENCE = 12

lancer([FFMPEG, "-y", "-loglevel", "error",
        "-framerate", str(CADENCE),
        "-i", str(IMAGES / "img_%04d.png"),
        "-c:v", "mpeg4", "-q:v", "3", "-pix_fmt", "yuv420p",
        str(PRODUIT / "montre.mp4")])
Video(str(PRODUIT / "montre.mp4"), embed=True, width=480)
```

La vidéo est le fichier `travail/produit/montre.mp4` : elle s'ouvre aussi par
un double-clic dans l'explorateur.

:::{admonition} À essayer
Changer `DEBUT` et `MINUTES` (par exemple `DEBUT = 3`, `MINUTES = 30`), ou
`CADENCE`, puis relancer les deux dernières cellules. Ce sont les trois
valeurs que la partie B passera sur la ligne de commande.
:::
