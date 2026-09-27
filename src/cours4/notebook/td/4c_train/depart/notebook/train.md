---
title: La fenêtre du train
subtitle: Une image composée de trois images du décor par ImageMagick, un décalage calculé par Python, une vidéo par ffmpeg
execution: ../../travail
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# La fenêtre du train

Ce notebook fabrique une vidéo de dix secondes : la mer vue de la fenêtre
d'un train, les voiles et la plage qui défilent derrière la vitre. Le décor
est dessiné d'après la scène de la mer du clip « Moon » de Kid Francescoli
(collectif Cauboyz, 2017), tourné avec des décors en carton posés sur une
table tournante.

La section 1 décrit, sans code, comment une image de la vidéo est composée
à partir de trois images du décor. Les sections suivantes fabriquent cette
image étape par étape, puis la série d'images et la vidéo :

1. La composition d'une image.
2. Les outils : vérifier que `magick` et `ffmpeg` sont trouvés.
3. Le fond.
4. Le plan : découper l'emprise dans la bande.
5. Le plan : faire tourner la bande.
6. Le plan posé sur le fond.
7. La fenêtre posée par-dessus : une image de la vidéo.
8. Les décalages.
9. La vidéo.

Le notebook est livré dans `depart/notebook/`. Le copier dans `travail/`
avant de l'ouvrir. Les fichiers qu'il crée sont écrits dans
`travail/produit/`.

## 1 · La composition d'une image

Chaque image de la vidéo mesure 640 × 480 pixels. Elle est composée de trois
images du décor, posées l'une sur l'autre : le fond, puis le plan, puis la
fenêtre. Le schéma montre ces étapes pour une image de la vidéo.

![Le plan posé sur le fond, puis la fenêtre posée par-dessus](../illustrations/composition.png)

### 1.1 Le fond

Le fond contient le ciel, les nuages et la mer. Il mesure 640 × 480 pixels,
la taille d'une image de la vidéo, et reste le même sur toutes les images.
La première étape écrit une image qui ne contient que le fond, et vérifie
qu'elle mesure 640 × 480 pixels.

### 1.2 Le plan : une emprise dans une bande

Le plan contient les voiles et la plage. Il est dessiné sur une bande de
1 920 × 480 pixels, trois fois plus large qu'une image de la vidéo. Les
pixels hors des voiles et de la plage sont transparents : sur les schémas,
un damier gris et blanc les marque.

Le plan d'une image est un rectangle de 640 × 480 pixels découpé dans la
bande. On appelle ce rectangle l'emprise. Le décalage est le numéro de la
colonne de la bande où commence l'emprise.

![La bande du plan et l'emprise à la colonne 400](../illustrations/emprise.png)

D'une image de la vidéo à la suivante, le décalage augmente de 8 pixels :
l'emprise avance de 8 colonnes vers la droite dans la bande, et les voiles et
la plage se déplacent de 8 pixels vers la gauche dans l'image.

### 1.3 Quand l'emprise dépasse la bande

L'emprise dépasse le bord droit de la bande dès que le décalage dépasse
1 920 − 640 = 1 280. Avec un décalage de 1 500, le découpage ne garde que les
420 colonnes qui restent dans la bande : le plan obtenu mesure
420 × 480 pixels.

La bande est dessinée pour que son bord droit se raccorde à son bord gauche :
placée après la colonne 1 919, la colonne 0 continue le dessin. Enroulée sur un cylindre,
comme les décors du clip posés sur une table tournante, la bande n'a plus de
bord.

![La bande enroulée sur un cylindre](../illustrations/cylindre.png)

Le programme fait tourner la bande comme le cylindre. Pour un décalage de
1 500, il déplace la bande de 1 500 colonnes vers la gauche ; les colonnes
qui sortent à gauche reviennent à droite. La bande commence alors par les
colonnes 1 500 à 1 919, suivies des colonnes 0 à 1 499. L'emprise est ensuite
découpée à partir de la colonne 0, et ne dépasse plus.

![Découper l'emprise à la colonne 1 500, puis faire tourner la bande avant de découper](../illustrations/debordement.png)

Pour un décalage inférieur à 1 280, faire tourner la bande puis découper à la
colonne 0 donne le même plan que découper à la colonne du décalage. Un
décalage plus grand que la bande fait plus d'un tour : 2 320 donne le même
plan que 400, car 2 320 = 1 920 + 400.

### 1.4 Le plan posé sur le fond

Le plan découpé est posé sur le fond. Là où le plan est transparent, le fond
reste visible ; les voiles et la plage cachent la mer.

### 1.5 La fenêtre posée par-dessus

La fenêtre est une image de 640 × 480 pixels : le cadre est noir, la vitre
est transparente. Posée en dernier, elle cache les bords du fond et du plan ;
ce qui est derrière la vitre reste visible.

### 1.6 De l'image à la vidéo

La vidéo compte 120 images. Le décalage vaut 0 sur la première image et
augmente de 8 pixels à chaque image : 0, 8, 16… jusqu'à 952 sur la dernière.
Affichées à 12 images par seconde, les 120 images durent 10 secondes.

## 2 · Les outils

Le programme fait chaque étape de la composition avec ImageMagick
(`magick`), et assemble la vidéo avec ffmpeg. Ces deux programmes
s'utilisent en ligne de commande, comme git (cours 2) et pandoc (cours 3).
Python calcule les décalages et lance les deux programmes avec
`subprocess.run`. Dans la partie B du TD, le code de ce notebook devient un
script `train.py`, appelable en ligne de commande. Le schéma suivant montre
les étapes de ce script, avec des images de la vidéo produite :

![Les étapes du script train.py](../depart/illustrations/programme_train.png)

`magick` et `ffmpeg` sont installés dans l'environnement `animation`.
`shutil.which` renvoie le chemin du programme trouvé, ou `None` si le
programme n'est pas trouvé (cours 3, notebook `recette`, section 4.3).

```{code-cell} ipython3
import shutil
import subprocess
import sys
from pathlib import Path

from IPython.display import Image, Video, display

print("Python :", sys.executable)
print("magick :", shutil.which("magick"))
print("ffmpeg :", shutil.which("ffmpeg"))
```

Les trois chemins doivent être dans le dossier de l'environnement
`animation`. Si `magick` ou `ffmpeg` vaut `None`, JupyterLab n'a pas été
lancé depuis l'environnement `animation` : voir l'étape A4 du guide.

Les images du décor sont dans `depart/decor/`, un dossier au-dessus de
`travail/` : `fond.png`, `plan.png` et `fenetre.png`. Les fichiers
`voiles.png`, `plage_jaune.png` et `plage.png` servent à l'annexe du guide,
« Plusieurs plans, plusieurs vitesses », et au TD 7. Ce sont des fichiers PNG, un format qui garde la
transparence. Les chemins sont écrits à partir du dossier du notebook,
`travail/`.

```{code-cell} ipython3
MAGICK = "magick"
FFMPEG = "ffmpeg"

DECOR = Path("..") / "depart" / "decor"
PRODUIT = Path("produit")
IMAGES = PRODUIT / "images"
IMAGES.mkdir(parents=True, exist_ok=True)

for nom in ["fond.png", "plan.png", "fenetre.png"]:
    print(DECOR / nom, (DECOR / nom).exists())
```

## 3 · Le fond

`subprocess.run` reçoit une commande sous forme de liste : le programme,
puis chaque argument. Le programme construit la commande `magick` morceau par
morceau, un morceau par étape de la composition. Chaque morceau est une liste
d'arguments, renvoyée par une fonction ; les listes s'ajoutent avec `+`.

Le premier morceau lit le fond : il ne contient que le chemin du fichier.
`magick` lit les images dans l'ordre de la commande, et écrit le résultat
dans le dernier fichier nommé. `" ".join(commande)` affiche la commande telle
qu'elle s'écrit dans un terminal. `check=True` arrête le notebook si la
commande échoue.

```{code-cell} ipython3
def arguments_fond(decor):
    """Les arguments de magick qui lisent le fond, une image de 640 × 480 pixels."""
    return [str(decor / "fond.png")]


commande = [MAGICK] + arguments_fond(DECOR) + [str(PRODUIT / "fond.png")]
print(" ".join(commande))
subprocess.run(commande, check=True)
Image(str(PRODUIT / "fond.png"))
```

`magick identify` écrit la description d'une image ; avec l'option
`-format "%wx%h"`, il n'écrit que sa largeur et sa hauteur. La fonction
`taille` récupère ce texte avec `capture_output=True` et `text=True` (cours 3,
notebook `recette`, section 4.3) et le renvoie.

```{code-cell} ipython3
def taille(fichier):
    """La largeur et la hauteur de l'image, en pixels, écrites par magick identify : « 640x480 »."""
    resultat = subprocess.run([MAGICK, "identify", "-format", "%wx%h", str(fichier)],
                              capture_output=True, text=True, check=True)
    return resultat.stdout


print(taille(PRODUIT / "fond.png"))
```

## 4 · Le plan : découper l'emprise dans la bande

`-crop 640x480+400+0` découpe un rectangle de 640 × 480 pixels dont le coin
en haut à gauche est à la colonne 400 et à la ligne 0 : l'emprise de la
section 1.2. Sans `+repage`, le fichier écrit garde la position du rectangle
dans la bande ; `+repage` l'efface. Les parenthèses `(` et `)` isolent ces
réglages : dans la commande complète (section 6), ils ne s'appliquent qu'au
plan.

```{code-cell} ipython3
def arguments_plan_decoupe(decor, decalage):
    """Les arguments de magick qui lisent la bande du plan et en découpent l'emprise, à la colonne `decalage`."""
    return ["(", str(decor / "plan.png"),
            "-crop", "640x480+" + str(decalage) + "+0", "+repage", ")"]


for decalage in [400, 1500]:
    fichier = PRODUIT / ("plan_decoupe_" + str(decalage) + ".png")
    commande = [MAGICK] + arguments_plan_decoupe(DECOR, decalage) + [str(fichier)]
    print(" ".join(commande))
    subprocess.run(commande, check=True)
    print("taille :", taille(fichier))
    display(Image(str(fichier)))
```

Les pixels transparents du plan prennent la couleur du fond de la page. Avec
un décalage de 1 500, l'emprise dépasse la bande (section 1.3) : le plan ne
mesure que 420 × 480 pixels.

:::{note}
Pour taper dans un terminal Git Bash une commande affichée ici, les
parenthèses s'écrivent `\(` et `\)` : sans la barre oblique inverse, bash les
interprète lui-même.
:::

## 5 · Le plan : faire tourner la bande

`-roll -1500+0` fait tourner la bande de 1 500 colonnes vers la gauche : les
colonnes qui sortent à gauche reviennent à droite. Le signe `-` indique la
gauche ; `+0` indique que les lignes ne bougent pas. `-crop 640x480+0+0`
découpe ensuite l'emprise à partir de la colonne 0.

```{code-cell} ipython3
def arguments_plan(decor, decalage):
    """Les arguments de magick qui lisent la bande du plan, la font tourner de `decalage` colonnes
    vers la gauche, puis en découpent 640 × 480 pixels à partir de la colonne 0."""
    return ["(", str(decor / "plan.png"),
            "-roll", "-" + str(decalage) + "+0",
            "-crop", "640x480+0+0", "+repage", ")"]


for decalage in [400, 1500, 2320]:
    fichier = PRODUIT / ("plan_" + str(decalage) + ".png")
    commande = [MAGICK] + arguments_plan(DECOR, decalage) + [str(fichier)]
    print(" ".join(commande))
    subprocess.run(commande, check=True)
    print("taille :", taille(fichier))
    display(Image(str(fichier)))
```

Les trois plans mesurent 640 × 480 pixels. Le plan de décalage 400 est le
même qu'à la section 4 ; celui de décalage 2 320 est le même que celui de
décalage 400. La suite du notebook utilise `arguments_plan`.

## 6 · Le plan posé sur le fond

La commande lit le fond, puis le plan. `-composite` pose la dernière image lue
sur l'image lue avant elle : les pixels transparents du plan laissent voir le
fond.

```{code-cell} ipython3
commande = [MAGICK] + arguments_fond(DECOR)
commande = commande + arguments_plan(DECOR, 400) + ["-composite"]
commande = commande + [str(PRODUIT / "fond_et_plan.png")]
print(" ".join(commande))
subprocess.run(commande, check=True)
print("taille :", taille(PRODUIT / "fond_et_plan.png"))
Image(str(PRODUIT / "fond_et_plan.png"))
```

## 7 · La fenêtre posée par-dessus : une image de la vidéo

Un troisième morceau lit la fenêtre, et un second `-composite` la pose sur le
fond et le plan. La commande complète a trois morceaux, un par image du
décor, et deux `-composite`.

```{code-cell} ipython3
def arguments_fenetre(decor):
    """Les arguments de magick qui lisent la fenêtre, une image de 640 × 480 pixels."""
    return [str(decor / "fenetre.png")]


commande = [MAGICK] + arguments_fond(DECOR)
commande = commande + arguments_plan(DECOR, 400) + ["-composite"]
commande = commande + arguments_fenetre(DECOR) + ["-composite"]
commande = commande + [str(PRODUIT / "image_400.png")]
print(" ".join(commande))
subprocess.run(commande, check=True)
print("taille :", taille(PRODUIT / "image_400.png"))
Image(str(PRODUIT / "image_400.png"))
```

La fonction `image` reprend ces lignes pour un fichier, un dossier de décor et
un décalage quelconques. Elle écrit une image de la vidéo.

```{code-cell} ipython3
def image(fichier, decor, decalage):
    """Une image 640 × 480 : le fond, le plan décalé de `decalage` pixels posé dessus, puis la fenêtre."""
    commande = [MAGICK] + arguments_fond(decor)
    commande = commande + arguments_plan(decor, decalage) + ["-composite"]
    commande = commande + arguments_fenetre(decor) + ["-composite"]
    commande = commande + [str(fichier)]
    subprocess.run(commande, check=True)


image(PRODUIT / "image_1500.png", DECOR, 1500)
Image(str(PRODUIT / "image_1500.png"))
```

## 8 · Les décalages

La fonction `decalages` renvoie le décalage de chaque image de la vidéo :
0 pour la première, puis `vitesse` pixels de plus à chaque image.

```{code-cell} ipython3
def decalages(nombre, vitesse):
    """Le décalage de chaque image : 0, puis `vitesse` pixels de plus à chaque image."""
    liste = []
    for numero in range(nombre):
        liste.append(numero * vitesse)
    return liste


print(decalages(6, 8))
```

## 9 · La vidéo

Une image par décalage : avec `NOMBRE = 120` et `VITESSE = 8`, 120 images,
nommées `img_0001.png`, `img_0002.png`… La dernière est décalée de
119 × 8 = 952 pixels. Les images d'une exécution précédente sont d'abord
supprimées.

```{code-cell} ipython3
NOMBRE = 120        # le nombre d'images
VITESSE = 8         # le décalage de plus à chaque image, en pixels

for ancienne in IMAGES.glob("img_*.png"):
    ancienne.unlink()

liste = decalages(NOMBRE, VITESSE)
numero = 0
for decalage in liste:
    numero = numero + 1
    nom = "img_" + str(numero).zfill(4) + ".png"
    image(IMAGES / nom, DECOR, decalage)
print(len(liste), "images dans", IMAGES)
```

ffmpeg lit les images `img_0001.png`, `img_0002.png`… (`img_%04d.png` : quatre
chiffres) et écrit la vidéo. `-framerate 12` : douze images par seconde, la
vidéo dure 120 / 12 = 10 secondes.

```{code-cell} ipython3
CADENCE = 12

subprocess.run([FFMPEG, "-y", "-loglevel", "error",
                "-framerate", str(CADENCE),
                "-i", str(IMAGES / "img_%04d.png"),
                "-c:v", "mpeg4", "-q:v", "3", "-pix_fmt", "yuv420p",
                str(PRODUIT / "train.mp4")], check=True)
Video(str(PRODUIT / "train.mp4"), embed=True, width=480)
```

La vidéo est le fichier `travail/produit/train.mp4` : elle s'ouvre aussi par
un double-clic dans l'explorateur.

:::{admonition} À essayer
Changer `VITESSE` (par exemple 2, puis 40) ou `CADENCE`, puis relancer les
deux dernières cellules. Avec `VITESSE = 40` et 120 images, le dernier
décalage vaut 4 760 : la bande fait plus de deux tours. Dans le clip, une
voile met une quarantaine de secondes à traverser la vitre. Ici, la vitre
fait 560 pixels de large : `VITESSE = 1`, à 12 images par seconde, donne à
peu près la même durée. `NOMBRE` et `CADENCE` sont les valeurs que la partie
B passera sur la ligne de commande.
:::
