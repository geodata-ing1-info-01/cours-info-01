---
title: Caractères et images
subtitle: Ce qu'un fichier texte et un fichier binaire contiennent
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# Caractères et images : texte et binaire

Ce notebook montre ce qu'un fichier contient, octet par octet. La section 1,
jouée en séance, porte sur les caractères : comment ASCII et UTF-8 les
écrivent en octets. Les sections 2 à 6, facultatives, comparent un fichier
texte et un fichier binaire qui contiennent la même image.

Une ligne qui se termine par `# à compléter` est à écrire ; la cellule
« Réponse » repliée qui la suit donne la solution. Les fichiers créés par le
notebook sont écrits dans `travail/`.

## 1 · ASCII et UTF-8

Un caractère est un nombre. Le code ASCII en définit 128, écrits sur un octet
chacun : les lettres sans accent, les chiffres, la ponctuation, l'espace et le
retour à la ligne. UTF-8 reprend ces 128 codes sur les mêmes octets, et écrit
tous les autres caractères sur deux, trois ou quatre octets : `é` et `œ` en
prennent deux, `😀` quatre.

`len` compte les caractères d'une chaîne ; `encode("utf-8")` renvoie ses
octets, et `hex(" ")` les écrit en hexadécimal, séparés par des espaces.

```{code-cell} ipython3
for texte in ("a", "é", "œ", "😀"):
    octets = texte.encode("utf-8")  # à compléter
    print(texte, len(texte), "caractère,", len(octets), "octet(s) :", octets.hex(" "))
```

```{code-cell} ipython3
:tags: [raises-exception]

"œ".encode("ascii")   # œ n'a pas de code ASCII : UnicodeEncodeError
```

En UTF-8, le premier octet d'un caractère indique sur combien d'octets le
caractère est écrit. Le nombre d'octets se lit sur les premiers bits de cet
octet, écrit en binaire :

| Premier octet, en binaire | En hexadécimal | Nombre d'octets du caractère |
|---|---|---|
| `0xxxxxxx` | `00` à `7f` | 1 : les 128 caractères ASCII |
| `110xxxxx` | `c2` à `df` | 2 |
| `1110xxxx` | `e0` à `ef` | 3 |
| `11110xxx` | `f0` à `f4` | 4 |

Les octets suivants du caractère commencent tous par `10` en binaire (`80` à
`bf` en hexadécimal). Un premier octet ne commence jamais par `10` : un
programme ne peut donc pas les confondre. Les bits notés `x`, mis bout à
bout, forment le numéro du caractère.

```{code-cell} ipython3
# Chaque octet en hexadécimal, puis en binaire sur 8 bits
for texte in ("a", "é", "œ", "😀"):
    print(texte, " ".join(f"{octet:02x}={octet:08b}" for octet in texte.encode("utf-8")))
```

Pour `é`, le premier octet `c3` s'écrit `11000011` : il commence par `110`,
le caractère occupe donc deux octets, `c3 a9`. Pour `😀`, le premier octet
`f0` commence par `11110` : le caractère occupe quatre octets.

Un programme qui lit un fichier en UTF-8 applique cette règle octet après
octet. En pseudo-code :

```text
position ← 0
texte ← chaîne vide
tant que position < nombre d'octets du fichier :
    premier ← octets[position]
    si premier commence par 0 en binaire      : n ← 1
    sinon si premier commence par 110         : n ← 2
    sinon si premier commence par 1110        : n ← 3
    sinon si premier commence par 11110       : n ← 4
    sinon : erreur, le fichier n'est pas en UTF-8
    vérifier que les n - 1 octets suivants commencent par 10,
        sinon : erreur, le fichier n'est pas en UTF-8
    caractère ← le caractère dont le numéro est formé par les bits x
                des octets[position] à octets[position + n - 1]
    ajouter caractère à la fin de texte
    position ← position + n
```

Python applique cette règle quand un fichier est ouvert avec
`encoding="utf-8"`, ou quand on appelle `octets.decode("utf-8")`. Si la
règle n'est pas respectée, Python lève une erreur `UnicodeDecodeError`.

Lus avec un autre encodage, les mêmes octets donnent d'autres caractères. En
`cp1252`, l'encodage par défaut de Windows, chaque octet est un caractère :
`c3 a9` se lit `Ã©` au lieu de `é`, l'erreur montrée dans le notebook
`fichiers`, section 3.

```{code-cell} ipython3
octets = "é".encode("utf-8")
print(octets.decode("utf-8"), octets.decode("cp1252"))
```

Le mot « œuf » a trois caractères et, en UTF-8, quatre octets ; « oeuf »,
écrit sans la ligature, en a quatre et quatre. `œ` n'existe ni en ASCII, ni
en ISO 8859-1, l'encodage courant des textes français avant UTF-8 ; les
fichiers anciens écrivent donc « oeuf ».

Des noms de communes de France portent ces caractères : Œuilly (Aisne, et
Marne), Plœuc-L'Hermitage (Côtes-d'Armor), L'Haÿ-les-Roses (Val-de-Marne),
Aÿ-Champagne (Marne). Un fichier en ASCII ne peut pas les écrire. Pour qu'ils
apparaissent tels quels sur une carte, le fichier qui les porte est en
UTF-8, et le programme qui le lit écrit `encoding="utf-8"` ; lu sans cet
argument sous Windows, « Plœuc » devient « PlÅ“uc ».

```{code-cell} ipython3
for nom in ("œuf", "oeuf", "Œuilly", "Plœuc-L'Hermitage", "L'Haÿ-les-Roses", "Aÿ-Champagne"):
    octets = nom.encode("utf-8")
    print(f"{nom:18} {len(nom):3} caractères, {len(octets):3} octets")
```

## 2 · Une image au format texte : PGM `P2`

*Les sections 2 à 6 sont facultatives. Elles se lisent et s'exécutent après
la séance.*

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

## 3 · La même image en binaire

Pillow enregistre un `.pgm` dans la variante binaire : le même en-tête, en
clair, puis un octet par pixel au lieu d'un nombre écrit en chiffres.

```{code-cell} ipython3
TRAVAIL = Path("travail")
TRAVAIL.mkdir(exist_ok=True)

image.save(TRAVAIL / "motif.pgm")
octets = (TRAVAIL / "motif.pgm").read_bytes()
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
hexdump(TRAVAIL / "motif.pgm")
```

Dans le fichier texte, les seuls points sont les retours à la ligne (`0a`).
Dans le fichier binaire, les seize pixels, `00` et `ff`, ne sont pas des
caractères affichables : ils apparaissent tous comme des points.

## 4 · La signature d'un format

Chaque fichier d'image commence par quelques octets fixes, appelés
signature, qui identifient son format : `P5` pour PGM binaire, `BM` pour BMP,
`‰PNG` pour PNG. `Image.open` reconnaît le format d'un fichier d'après sa
signature ; l'extension de son nom n'intervient pas. `save`, lui, choisit le
format d'après l'extension.

`glob("motif.*")` renvoie les chemins du dossier dont le nom correspond au
motif, `*` remplaçant n'importe quelle suite de caractères ;
`stat().st_size` renvoie la taille du fichier en octets.

```{code-cell} ipython3
image.save(TRAVAIL / "motif.bmp")
image.save(TRAVAIL / "motif.png")

for fichier in sorted(TRAVAIL.glob("motif.*")):
    print(f"{fichier.name:12} {fichier.stat().st_size:5} octets")
    hexdump(fichier, n=16)
```

## 5 · Une vraie image, en cinq fichiers

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
    gris.save(TRAVAIL / nom)
gris.save(TRAVAIL / "vague.jpg", quality=85)
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
(TRAVAIL / "vague_texte.pgm").write_text("\n".join(lignes) + "\n")

pixels = largeur * hauteur
print(f"{pixels:,} pixels\n")
for fichier in sorted(TRAVAIL.glob("vague*")):
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
print(len(donnees), "octets bruts,", len(comprime), "compressés,", (TRAVAIL / "vague.png").stat().st_size, "en PNG")
```

PNG obtient moins que `zlib` seul parce qu'il transforme d'abord chaque ligne,
en écrivant la différence avec le pixel voisin, plus souvent répétée que la
valeur elle-même.

## 6 · Le temps de lecture

`%timeit` lance une ligne plusieurs fois et donne le temps moyen. `load()`
force Pillow à lire les pixels, ce qu'`open` seul ne fait pas.

```{code-cell} ipython3
%timeit -r 3 -n 1 Image.open(TRAVAIL / "vague_texte.pgm").load()
%timeit -r 3 -n 1 Image.open(TRAVAIL / "vague.pgm").load()
%timeit -r 3 -n 1 Image.open(TRAVAIL / "vague.png").load()
%timeit -r 3 -n 1 Image.open(TRAVAIL / "vague.jpg").load()
```

Les quatre temps s'affichent dans l'ordre : PGM texte, PGM binaire, PNG,
JPEG. En binaire, l'octet lu est déjà la valeur du pixel : la lecture est une
copie. En texte, chaque nombre est une suite de chiffres à reconnaître et à
convertir, et il y en a un par pixel. PNG et JPEG sont plus petits sur le
disque, et demandent un calcul pour retrouver les pixels.
