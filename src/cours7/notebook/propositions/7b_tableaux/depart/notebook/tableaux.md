---
title: Une image est un tableau
subtitle: Les outils numpy des deux effets de la fenêtre du train
execution: ../../travail
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# Une image est un tableau

Le TD 7b ajoute deux effets au programme `train.py` du TD 4c :

- `poteaux` : des bandes sombres qui passent très vite devant le paysage,
  l'ombre des poteaux le long de la voie ;
- `parallaxe` : un second plan, la plage orange, qui défile deux fois plus
  vite que le premier.

Chaque effet est une fonction Python qui reçoit une image de la série et
renvoie l'image modifiée. Elle est écrite deux fois : avec une boucle sur les
pixels, puis avec numpy, qui calcule sur le tableau entier. Ce notebook
montre les outils de numpy dont les deux versions ont besoin, sur d'autres
exemples que les deux effets.

Le notebook a six parties :

1. Lire une image : un tableau de nombres.
2. Lignes, colonnes, tranches.
3. Calculer sur des octets : le dépassement.
4. Choisir des colonnes avec un tableau de booléens.
5. Décaler avec `np.roll`, choisir des pixels avec un masque.
6. Une boucle ou numpy : le temps.

Le notebook est livré dans `depart/notebook/`. Le copier dans `travail/`
avant de l'ouvrir. Il demande numpy et Pillow, installés dans
l'environnement `animation` à l'étape C0 du guide.

## 1 · Lire une image

Pillow (`PIL`) lit le fichier ; `np.asarray` en fait un tableau numpy. Les
fonctions `lire` et `montrer` sont les mêmes que dans le programme.

```{code-cell} ipython3
from pathlib import Path
import time

import numpy as np
from PIL import Image
from IPython.display import display


def lire(fichier):
    """L'image du fichier, en tableau numpy (hauteur, largeur, 3) d'entiers de 0 à 255."""
    return np.asarray(Image.open(fichier).convert("RGB"))


def montrer(tableau):
    """Affiche le tableau comme une image."""
    display(Image.fromarray(tableau))


DEPART = Path.cwd().parent / "depart"
image = lire(DEPART / "exemple.png")
print(image.shape, image.dtype)
montrer(image)
```

`shape` vaut `(480, 640, 3)` : 480 lignes, 640 colonnes, 3 valeurs par
pixel, le rouge, le vert et le bleu. `dtype` vaut `uint8` : chaque valeur est
un octet, un entier de 0 à 255 (cours 3, `images.ipynb`).

`image[y, x]` est le pixel de la ligne `y` et de la colonne `x`, compté à
partir du coin en haut à gauche :

```{code-cell} ipython3
print("ciel :", image[100, 320])
print("mer :", image[285, 320])
print("cadre :", image[5, 5])
```

## 2 · Lignes, colonnes, tranches

`:` veut dire « tout » sur un axe. `image[:, 320]` est la colonne 320 :
480 pixels de 3 valeurs. `image[:, 300:340]` est une tranche de 40 colonnes,
de 300 à 339.

```{code-cell} ipython3
print(image[:, 320].shape)
print(image[:, 300:340].shape)
```

Le tableau lu est en lecture seule : `copy` en fait une copie modifiable.
Une affectation à une tranche modifie toutes ses valeurs d'un coup.

```{code-cell} ipython3
essai = image.copy()
essai[:, 300:340] = 255          # 40 colonnes blanches
montrer(essai)
```

## 3 · Calculer sur des octets : le dépassement

Un `uint8` ne peut pas dépasser 255. Si un calcul dépasse, numpy garde le
reste de la division par 256, sans prévenir : 200 × 6 = 1 200 devient
1 200 − 4 × 256 = 176.

```{code-cell} ipython3
octets = np.array([50, 100, 200], dtype=np.uint8)
print(octets * 6)
```

Pour faire le calcul juste, convertir d'abord en un type plus grand :
`astype(np.uint16)` (entiers de 0 à 65 535). Les entiers de Python n'ont
pas cette limite : `int(v)` convertit une valeur du tableau avant de
calculer.

```{code-cell} ipython3
print(octets.astype(np.uint16) * 6)
print(int(octets[2]) * 6)
```

Pour enregistrer le résultat dans une image, il faut revenir entre 0 et
255 : une valeur multipliée par 6 puis divisée par 10 (`// 10`) y revient
toujours.

## 4 · Choisir des colonnes avec un tableau de booléens

`np.arange(12)` est le tableau des entiers de 0 à 11. Une comparaison sur un
tableau donne un tableau de booléens, `True` ou `False` pour chaque
valeur :

```{code-cell} ipython3
x = np.arange(12)
print(x)
print(x % 5)
print(x % 5 < 2)
```

Un tableau de booléens placé comme indice garde les positions où il vaut
`True`. Ici, sur un petit tableau de 3 lignes et 12 colonnes, les colonnes
où `x % 5 < 2` :

```{code-cell} ipython3
petit = np.zeros((3, 12), dtype=np.uint8)
choisies = x % 5 < 2
petit[:, choisies] = 9
print(petit)
```

Le modulo (`%`) répète le motif tous les 5 : colonnes 0 et 1, puis 5 et 6,
puis 10 et 11.

## 5 · Décaler avec `np.roll`, choisir des pixels avec un masque

`np.roll` décale un tableau ; ce qui sort d'un côté revient de l'autre,
comme `-roll` d'ImageMagick au TD 4c. `axis=1` décale les colonnes d'une
image.

```{code-cell} ipython3
print(np.roll(np.arange(8), 3))
montrer(np.roll(image, 200, axis=1))
```

Une image PNG peut avoir une quatrième valeur par pixel, l'opacité (canal
alpha) : 0 pour un pixel transparent, 255 pour un pixel opaque. La plage
et la fenêtre en ont une ; `convert("RGBA")` la garde.

```{code-cell} ipython3
def lire_rgba(fichier):
    """L'image du fichier avec sa transparence : un tableau (hauteur, largeur, 4)."""
    return np.asarray(Image.open(fichier).convert("RGBA"))


plage = lire_rgba(DEPART / "decor" / "plage.png")
fenetre = lire_rgba(DEPART / "decor" / "fenetre.png")
print(plage.shape, fenetre.shape)
print("valeurs d'opacité de la plage :", np.unique(plage[:, :, 3]))
```

`fenetre[:, :, 3] == 0` est un tableau de booléens de 480 × 640 : vrai dans
la vitre, là où la fenêtre est transparente. Placé comme indice d'une image,
il choisit ces pixels ; `&` combine deux masques (vrai si les deux sont
vrais).

```{code-cell} ipython3
vitre = fenetre[:, :, 3] == 0
print(vitre.shape, vitre.sum(), "pixels dans la vitre")

essai = image.copy()
haut = np.zeros((480, 640), dtype=bool)
haut[:240] = True                        # la moitié haute de l'image
essai[vitre & haut] = [255, 255, 255]    # en blanc : la vitre, moitié haute
montrer(essai)
```

## 6 · Une boucle ou numpy : le temps

Un exemple qui n'est aucun des deux effets : le négatif, chaque valeur `v`
remplacée par `255 - v`. La version boucle passe par chaque pixel et chaque
canal ; la version numpy fait le calcul sur le tableau entier.
`time.perf_counter()` donne l'heure en secondes : la différence entre deux
appels est la durée de ce qui s'est exécuté entre les deux.

```{code-cell} ipython3
def negatif_boucle(image):
    hauteur, largeur, _ = image.shape
    resultat = image.copy()
    for y in range(hauteur):
        for x in range(largeur):
            for c in range(3):
                resultat[y, x, c] = 255 - int(image[y, x, c])
    return resultat


def negatif_numpy(image):
    return 255 - image


debut = time.perf_counter()
a = negatif_boucle(image)
milieu = time.perf_counter()
b = negatif_numpy(image)
fin = time.perf_counter()

print("boucle :", round(milieu - debut, 3), "s")
print("numpy  :", round(fin - milieu, 5), "s")
print("même résultat :", np.array_equal(a, b))
montrer(b)
```

`np.array_equal` vérifie que les deux tableaux ont la même forme et les mêmes
valeurs : c'est le test que le TD fait sur chaque effet.

:::{admonition} À essayer
Dans la section 4, changer `x % 5 < 2` en `(x - 3) % 5 < 2` : le motif se
décale de 3 colonnes. Dans la section 6, multiplier la durée de la boucle
par 120 : c'est le temps de l'effet sur toute la série d'images du TD 4c.
:::
