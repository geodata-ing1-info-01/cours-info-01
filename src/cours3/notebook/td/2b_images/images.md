---
title: "Images : texte et binaire"
subtitle: Ce qu'un fichier texte et un fichier binaire contiennent
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# Images : texte et binaire

Ce notebook est facultatif. Il compare un fichier texte et un fichier binaire
qui contiennent la même image, puis montre ce que contiennent les formats
d'image courants. Il suppose connues les sections 3 à 6 de `fichiers.ipynb` :
un fichier est une suite d'octets, UTF-8 écrit les caractères en octets, le
mode binaire lit les octets sans les décoder.

Les fichiers créés par le notebook sont écrits dans `travail/`.

## 1 · Une image au format texte : PGM `P2`

Le format d'image PGM représente une image en niveaux de gris. Il existe en
deux variantes, texte et binaire, qui ne diffèrent que par l'écriture des
pixels :

| | `P2`, texte | `P5`, binaire |
|---|---|---|
| ligne 1 : le nom du format | `P2` | `P5` |
| ligne 2 : largeur et hauteur | `4 4` | `4 4` |
| ligne 3 : la valeur du blanc, 1 à 65535 | `255` | `255` ; au-dessus, deux octets par pixel |
| les pixels, ligne par ligne | chaque valeur en chiffres, suivie d'un espace ou d'un retour à la ligne : `0 255 0 255` | chaque valeur sur un octet, sans séparateur : `00 ff 00 ff` |

L'en-tête est du texte dans les deux variantes. Le PGM fait partie d'une
famille de formats : le PBM (`P1`, `P4`) pour les images en noir et blanc, et
le PPM (`P3`, `P6`) pour les images en couleur, avec trois valeurs par pixel.
Documentation :
[netpbm.sourceforge.net/doc/pgm.html](https://netpbm.sourceforge.net/doc/pgm.html).

Le fichier `depart/motif.pgm` est au format `P2` : `read_text()` renvoie son
contenu sous forme de texte. La bibliothèque Pillow, livrée avec Anaconda,
ouvre le même fichier comme une image : `size` donne la largeur et la
hauteur en pixels, `mode` le type d'image, `'L'` pour les niveaux de gris.
L'image ne fait que 4 × 4 pixels ; `resize` avec `Image.NEAREST` l'agrandit
sans lisser, et les seize pixels restent distincts.

```{code-cell} ipython3
from pathlib import Path
from PIL import Image

motif = Path("depart/motif.pgm")
print(motif.read_text())

image = Image.open(motif)
print(image.size, image.mode)
image.resize((160, 160), Image.NEAREST)
```

## 2 · La même image en binaire

Pillow enregistre un `.pgm` dans la variante binaire : le même en-tête, en
clair, puis un octet par pixel au lieu d'un nombre écrit en chiffres.

```{code-cell} ipython3
SORTIE = Path("travail")
SORTIE.mkdir(exist_ok=True)

image.save(SORTIE / "motif.pgm")
octets = (SORTIE / "motif.pgm").read_bytes()
print(len(motif.read_bytes()), "octets en texte,", len(octets), "en binaire")
print(octets.hex(" "))
```

Les onze premiers octets sont l'en-tête, `P5`, `4 4`, `255`, séparés par des
retours à la ligne (`0a`). Les seize suivants sont les pixels : `00` vaut 0,
`ff` vaut 255.

Le fichier texte est lui aussi une suite d'octets : un par caractère, selon
le code ASCII. `255` y occupe trois octets, `32 35 35`, plus un espace, `20`.

```{code-cell} ipython3
print(motif.read_bytes()[:23].hex(" "))   # l'en-tête et la première ligne de pixels du fichier texte
```

Un éditeur hexadécimal affiche la position de chaque octet, sa valeur en
hexadécimal et le caractère correspondant. La fonction `hexdump` fait la même
chose pour n'importe quel fichier ; elle affiche un point à la place d'un
octet qui n'est pas un caractère affichable.

```{code-cell} ipython3
def hexdump(chemin, n=32, largeur=16):
    """Les n premiers octets d'un fichier, en hexadécimal et en caractères."""
    donnees = Path(chemin).read_bytes()[:n]
    for debut in range(0, len(donnees), largeur):
        tranche = donnees[debut:debut + largeur]
        texte = "".join(chr(octet) if 32 <= octet < 127 else "." for octet in tranche)
        print(f"{debut:04x}  {tranche.hex(' '):<{largeur * 3}} {texte}")


hexdump(motif)
print()
hexdump(SORTIE / "motif.pgm")
```

Dans le fichier texte, les seuls points sont les retours à la ligne (`0a`).
Dans le fichier binaire, les seize pixels, `00` et `ff`, ne sont pas des
caractères affichables : ils apparaissent tous comme des points.

## 3 · La signature d'un format

Chaque fichier d'image commence par quelques octets fixes, appelés
signature, qui identifient son format : `P5` pour PGM binaire, `BM` pour BMP,
`‰PNG` pour PNG. `Image.open` reconnaît le format d'un fichier d'après sa
signature ; l'extension de son nom n'intervient pas. `save`, lui, choisit le
format d'après l'extension.

`glob("motif.*")` renvoie les chemins du dossier dont le nom correspond au
motif, `*` remplaçant n'importe quelle suite de caractères ;
`stat().st_size` renvoie la taille du fichier en octets.

```{code-cell} ipython3
image.save(SORTIE / "motif.bmp")
image.save(SORTIE / "motif.png")

for fichier in sorted(SORTIE.glob("motif.*")):
    print(f"{fichier.name:12} {fichier.stat().st_size:5} octets")
    hexdump(fichier, n=16)
```

## 4 · Une vraie image, en cinq fichiers

Le fichier `depart/vague.jpg` contient *La Grande Vague* de Hokusai, une
image en couleur de 2 000 pixels de large. `convert("L")` en renvoie une
copie en niveaux de gris, un octet par pixel, enregistrée ensuite en PGM
binaire, PNG, BMP et JPEG. Pour le JPEG, `quality` règle la compression, de
1 à 95 : plus la valeur est basse, plus le fichier est petit et plus l'image
perd de détails.

```{code-cell} ipython3
vague = Image.open("depart/vague.jpg")
gris = vague.convert("L")
for nom in ("vague.pgm", "vague.png", "vague.bmp"):
    gris.save(SORTIE / nom)
gris.save(SORTIE / "vague.jpg", quality=85)
gris.resize((600, 403))
```

Pillow n'écrit pas la variante texte `P2`. La cellule suivante l'écrit sans
Pillow : `tobytes()` renvoie les pixels, un octet par pixel, ligne après
ligne ; chaque ligne de pixels devient une ligne de texte, les valeurs écrites
en chiffres et séparées par des espaces.

```{code-cell} ipython3
largeur, hauteur = gris.size
donnees = gris.tobytes()

lignes = [f"P2\n{largeur} {hauteur}\n255"]
for i in range(hauteur):
    ligne = donnees[i * largeur:(i + 1) * largeur]
    lignes.append(" ".join(str(octet) for octet in ligne))
(SORTIE / "vague_texte.pgm").write_text("\n".join(lignes) + "\n")

pixels = largeur * hauteur
print(f"{pixels:,} pixels\n")
for fichier in sorted(SORTIE.glob("vague*")):
    taille = fichier.stat().st_size
    print(f"{fichier.name:18} {taille:>10,} octets   {taille / pixels:5.2f} octet(s) par pixel")
```

La taille d'un fichier d'image non compressé se calcule : largeur × hauteur
× octets par valeur, plus l'en-tête. Le PGM binaire fait un octet par pixel,
plus 17 octets d'en-tête ; le BMP un octet par pixel, plus 1 078 octets
d'en-tête et de palette. Le texte fait plus de trois octets par pixel : chaque
valeur a un à trois chiffres, suivis d'un espace.

PNG et JPEG sont plus petits parce qu'ils sont compressés. Compresser, c'est
écrire une répétition une fois, avec le nombre de fois, au lieu de répéter la
valeur : la ligne `0 0 0 0 0 255 255 0` s'écrit `5×0 2×255 1×0`. PNG le fait
sans perte, avec l'algorithme des fichiers ZIP (deflate), que `zlib.compress`
applique aux pixels bruts. JPEG compresse avec perte : l'image relue n'est pas
exactement celle de départ.

```{code-cell} ipython3
import zlib

comprime = zlib.compress(donnees)
print(len(donnees), "octets bruts,", len(comprime), "compressés,", (SORTIE / "vague.png").stat().st_size, "en PNG")
```

PNG obtient moins que `zlib` seul parce qu'il transforme d'abord chaque ligne,
en écrivant la différence avec le pixel voisin, plus souvent répétée que la
valeur elle-même.

## 5 · Le temps de lecture

`%timeit` lance une ligne plusieurs fois et donne le temps moyen. `load()`
force Pillow à lire les pixels, ce qu'`open` seul ne fait pas.

```{code-cell} ipython3
%timeit -r 3 -n 1 Image.open(SORTIE / "vague_texte.pgm").load()
%timeit -r 3 -n 1 Image.open(SORTIE / "vague.pgm").load()
%timeit -r 3 -n 1 Image.open(SORTIE / "vague.png").load()
%timeit -r 3 -n 1 Image.open(SORTIE / "vague.jpg").load()
```

Les quatre temps s'affichent dans l'ordre : PGM texte, PGM binaire, PNG,
JPEG. En binaire, l'octet lu est déjà la valeur du pixel : la lecture est une
copie. En texte, chaque nombre est une suite de chiffres à reconnaître et à
convertir, et il y en a un par pixel. PNG et JPEG sont plus petits sur le
disque, et demandent un calcul pour retrouver les pixels.
