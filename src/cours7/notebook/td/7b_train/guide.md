---
title: "TD 7b — La scène complète du train"
subtitle: Guide, étape par étape
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

Le TD complète le programme `train.py` du TD 4c. Aujourd'hui, un seul plan
défile derrière la vitre. Dans le clip « Moon », les voiles, la plage jaune
et la plage orange défilent à des vitesses différentes : plus un plan est
proche, plus il défile vite. Des ombres de poteaux passent aussi devant la
fenêtre. L'annexe « Plusieurs plans, plusieurs vitesses » du guide du TD 4c
présente la première partie.

À la fin du TD, le programme compose chaque image avec trois plans, décrits
dans un fichier du décor ; il applique l'effet des poteaux, écrit avec une
boucle sur les pixels puis avec numpy ; il calcule le nombre d'images d'une
vidéo qui boucle sans saut.

Chaque fonctionnalité se développe sur une branche de son dépôt GitHub (cours
6), puis arrive sur `master` par une pull request, fusionnée sur le site.
Pour chaque fonction à écrire, le guide donne sa première ligne, sa
description et, en commentaires, ce qu'il faut écrire ; le code complet est
dans l'[annexe](#annexe-le-code-complet).

| Étape | Ce qu'on fait | Durée |
|---|---|---|
| C0 | le dépôt, numpy et Pillow dans `animation`, une branche `plans` | 10′ |
| C1 | plusieurs plans, chacun à sa vitesse | 20′ |
| C2 | les plans décrits dans `decor/plans.csv` | 15′ |
| PR 1 | la pull request de la branche `plans` | 5′ |
| C3 | l'effet des poteaux, avec une boucle puis avec numpy ; le test ; le chronométrage | 35′ |
| C4 | une vidéo qui boucle sans saut | 15′ |
| PR 2 | le README, la pull request de la branche `poteaux` | 5′ |

C4 se fait si le temps le permet : 480 images demandent quelques minutes.

## Au début de la séance

- Le dépôt GitHub du projet 4, publié au cours 6, et la clé SSH du cours 5
  enregistrée sur le compte GitHub.
- L'archive `info01-cours7.zip`, copiée depuis `formationTemp` sur le Bureau,
  dans le dossier `info01`, puis décompressée.

Ouvrir le dossier `info01/cours7/7b_train/` dans VS Code, puis un terminal Git
Bash (menu Terminal → Nouveau terminal ; flèche à côté du `+` → Git Bash).
Tout le TD se fait dans ce terminal.

## C0 · Le dépôt, numpy et Pillow, une branche

> **À faire :** le dépôt `train` dans `travail/` ; numpy et Pillow dans l'environnement `animation`, ajoutés à `environment.yml` ; une branche `plans`.
>
> **À obtenir :** `python -c "import numpy, PIL"` ne répond rien ; `git branch` affiche `* plans`.

### C0.1 Le dépôt sur le poste

**Cas A, le dépôt du cours 6 fonctionne.** Sur sa page GitHub, bouton
Code → SSH, copier l'adresse, puis :

```text
cd travail
git clone git@github.com:<compte>/train.git
cd train
```

**Cas B, pas de dépôt, ou un programme qui ne fonctionne pas.** Le module
publie un dépôt de référence, `train`, sur le compte GitHub
`<organisation>` (le nom est donné en début de séance). Sur son compte
GitHub, créer d'abord un dépôt vide nommé `train` (New repository, sans
README), puis :

```text
cd travail
git clone git@github.com:<organisation>/train.git
cd train
git remote set-url origin git@github.com:<compte>/train.git
git push -u origin master
```

`git remote set-url` change l'adresse du dépôt distant `origin` : les
`push` suivants vont au dépôt de l'élève. Le dépôt garde l'historique du TD
d'origine.

**Vérification** : `ls` liste `train.py`, `decor` et `README.md` ; `ls decor` liste `voiles.png`, `plage_jaune.png` et `plage.png`.


Si `decor/` ne contient pas `voiles.png` et `plage_jaune.png`, les copier
depuis le dossier du TD 4c, ou demander à l'enseignant.

### C0.2 numpy et Pillow

numpy calcule sur des tableaux ; Pillow lit et écrit les fichiers d'images.

```text
conda activate animation
conda install -c conda-forge numpy pillow
python -c "import numpy, PIL; print(numpy.__version__, PIL.__version__)"
```

Dans `environment.yml`, ajouter deux lignes à la fin de la liste
`dependencies` : `  - numpy` et `  - pillow`.

### C0.3 Une branche

```text
git checkout -b plans
git commit -am "numpy et Pillow dans l'environnement"
```

## C1 · Plusieurs plans

> **À faire :** `arguments_plan` reçoit le fichier de la bande ; la liste `PLANS` ; `image` ajoute un morceau par plan ; `serie` et `main` passent le numéro de l'image ; un commit.
>
> **À obtenir :** `python train.py --numero 40` écrit `sortie/train_0040.png` avec les trois plans.

Sur l'image numéro `n`, un plan de vitesse `v` est décalé de `n × v`
pixels. Les plans sont posés du plus lointain au plus proche, puis la
fenêtre.

**Le plan reçoit sa bande.** Remplacer la fonction `arguments_plan` par :

```python
def arguments_plan(decor, fichier, decalage):
    """Les arguments de magick qui lisent la bande `fichier`, la font tourner de `decalage` colonnes
    vers la gauche, puis en découpent 640 × 480 pixels à partir de la colonne 0."""
    return ["(", str(decor / fichier),
            "-roll", "-" + str(decalage) + "+0",
            "-crop", "640x480+0+0", "+repage", ")"]
```

**La liste des plans et la fonction `image`.** Remplacer la fonction `image`
par la liste `PLANS`, puis la nouvelle fonction `image` :

```python
# Les plans, du plus lointain au plus proche : le fichier de la bande, et sa vitesse en pixels par image
PLANS = [("voiles.png", 4), ("plage_jaune.png", 8), ("plage.png", 16)]


def image(fichier, decor, plans, numero):
    """L'image numéro `numero` : le fond, chaque plan décalé de numero × sa vitesse, puis la fenêtre."""
    commande = [MAGICK] + arguments_fond(decor)
    for nom, vitesse in plans:
        # à écrire : ajouter à commande le morceau du plan, décalé de numero × vitesse, puis "-composite"
    commande = commande + arguments_fenetre(decor) + ["-composite"]
    commande = commande + [str(fichier)]
    subprocess.run(commande, check=True)
```

**La série.** Remplacer toute la partie `# ---- Une série d'images`, de ce
titre jusqu'à la ligne qui précède `# ---- La vidéo`, par :

```python
# ---- Une série d'images ------------------------------------------------------

def serie(decor, nombre):
    """`nombre` images, les images numéro 0 à nombre - 1, dans IMAGES ; renvoie le nombre d'images."""
    plans = PLANS
    IMAGES.mkdir(parents=True, exist_ok=True)
    for ancienne in IMAGES.glob("img_*.png"):
        ancienne.unlink()
    for numero in range(nombre):
        fichier = IMAGES / ("img_" + str(numero + 1).zfill(4) + ".png")
        image(fichier, decor, plans, numero)
    return nombre
```

La fonction `decalages` disparaît : chaque plan calcule son décalage à partir
du numéro de l'image.

**`main`.** Remplacer toute la fonction `main` par :

```python
def main():
    analyseur = argparse.ArgumentParser(description="La fenêtre du train : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("--numero", type=int, default=0, help="le numéro d'une image seule (défaut : 0)")
    analyseur.add_argument("--decor", default="decor", help="le dossier des images du décor (défaut : decor)")
    analyseur.add_argument("-n", "--images", type=int, help="une série : ce nombre d'images")
    analyseur.add_argument("--video", action="store_true", help="assemble la série en vidéo (avec --images)")
    analyseur.add_argument("-c", "--cadence", type=int, default=12, help="images par seconde de la vidéo (défaut : 12)")
    analyseur.add_argument("--nettoyer", action="store_true", help="supprime les images de la série une fois la vidéo écrite")
    options = analyseur.parse_args()
    decor = Path(options.decor)
    if not (decor / "fond.png").exists():
        analyseur.error("décor introuvable : " + options.decor)
    if options.video and options.images is None:
        analyseur.error("--video demande une série : ajouter --images")
    SORTIE.mkdir(exist_ok=True)

    if options.images is None:
        # Une image
        fichier = SORTIE / ("train_" + str(options.numero).zfill(4) + ".png")
        image(fichier, decor, PLANS, options.numero)
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
```

L'option `--decalage` devient `--numero` : le numéro d'une image seule.

Enregistrer. **Vérifications** :

| Commande | Ce qui doit s'afficher |
|---|---|
| `python train.py --numero 40` | `…/sortie/train_0040.png 640x480` : les voiles décalées de 160 pixels, la plage jaune de 320, la plage orange de 640 |
| `python train.py --images 48 --video` | `48 images dans …`, puis la vidéo ; la plage orange passe plus vite que les voiles |

```text
git commit -am "Plusieurs plans, chacun à sa vitesse"
```

## C2 · Les plans dans un fichier du décor

> **À faire :** le fichier `decor/plans.csv` ; la fonction `lire_plans` ; `PLANS` disparaît du code ; un commit.
>
> **À obtenir :** changer une vitesse dans `plans.csv` change les images, sans modifier `train.py`.

Les plans et leurs vitesses sont des données de la scène, comme les images
du décor. Dans un fichier du décor, ils changent sans modifier le programme,
et un autre décor peut avoir d'autres plans.

```text
cp ../../depart/modeles/plans.csv decor/
cat decor/plans.csv
```

Le fichier a deux colonnes, `fichier` et `vitesse`, et une ligne par plan.
Il se lit comme les ingrédients de la recette au TD 3a (`csv.reader`). En
tête de `train.py`, ajouter `import csv` sous `import argparse`. Remplacer
la liste `PLANS` par :

```python
def lire_plans(decor):
    """Les plans de `decor/plans.csv`, du plus lointain au plus proche : une liste de (fichier, vitesse)."""
    plans = []
    # à écrire : ouvrir decor / "plans.csv" avec with et open (encoding="utf-8", newline="")
    # à écrire : un lecteur csv.reader ; next(lecteur) passe la ligne des noms de colonnes
    # à écrire : pour chaque ligne (nom, vitesse), ajouter (nom, int(vitesse)) à plans
    return plans
```

Puis, dans `serie`, remplacer `plans = PLANS` par `plans = lire_plans(decor)`,
et remplacer la fonction `main` par :

```python
def main():
    analyseur = argparse.ArgumentParser(description="La fenêtre du train : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("--numero", type=int, default=0, help="le numéro d'une image seule (défaut : 0)")
    analyseur.add_argument("--decor", default="decor", help="le dossier des images du décor (défaut : decor)")
    analyseur.add_argument("-n", "--images", type=int, help="une série : ce nombre d'images")
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
        # La vidéo, puis les fichiers intermédiaires supprimés si demandé
        if options.video:
            video = SORTIE / "train.mp4"
            assembler(video, options.cadence)
            print(video, ":", nombre, "images à", options.cadence, "images par seconde")
            if options.nettoyer:
                nettoyer()
                print("images intermédiaires supprimées")
```

Enregistrer. **Vérifications** :

| Commande | Ce qui doit s'afficher |
|---|---|
| `python train.py --numero 40` | la même image qu'à l'étape C1 |
| `python train.py --numero 40` | après avoir mis la vitesse des voiles à 40 dans `plans.csv` : les voiles ont bougé ; remettre 4 ensuite |
| `python train.py --decor absent` | `error: plans.csv introuvable dans absent` |

```text
git add decor/plans.csv
git commit -am "Les plans dans decor/plans.csv"
```

## PR 1 · La pull request de la branche `plans`

> **À faire :** pousser la branche `plans`, ouvrir la pull request, la fusionner sur le site, puis `git pull` sur `master`.
>
> **À obtenir :** sur le poste, `master` contient les commits de C0 à C2.

**Pousser la branche** :

```text
git push -u origin plans
```

**Vérification** : la dernière ligne affiche `branch 'plans' set up to
track 'origin/plans'`.

**Ouvrir la pull request.** Sur la page du dépôt sur GitHub, un bandeau
propose « Compare & pull request » : cliquer dessus. Vérifier en haut de la
page : `base: master` ← `compare: plans`. Titre : `Plusieurs plans` ; dans la
description, les commandes qui montrent la fonctionnalité (`--numero 40`, une vidéo).
Cliquer « Create pull request ».

**Fusionner.** En bas de la pull request, « Merge pull request », puis
« Confirm merge ». Sur le poste :

```text
git checkout master
git pull
git log --oneline --graph
```

**Vérification** : `git log` montre le commit de fusion, `Merge pull request
#… from <compte>/plans`, et les commits de la branche.


## C3 · L'effet des poteaux

> **À faire :** une branche `poteaux` ; le notebook `tableaux.ipynb` ; `poteaux_boucle`, puis `poteaux_numpy` ; le test ; l'option `--effet` ; le chronométrage et `RAPPORT.md` ; un commit à chaque fois.
>
> **À obtenir :** `python test_effet.py` affiche `True` quatre fois ; le tableau des temps dans `RAPPORT.md`.

```text
git checkout -b poteaux
```

### C3.1 Le notebook des outils numpy

Copier le notebook dans `travail/` :

```text
cp ../../depart/notebook/tableaux.ipynb ..
```

Ouvrir un second terminal Git Bash (il s'ouvre dans le dossier du TD), puis
`conda activate animation`, `cd travail` et `jupyter lab`. Dans JupyterLab,
ouvrir `tableaux.ipynb` et exécuter les sections 1 à 4 et 6 : une
image est un tableau `(480, 640, 3)` d'entiers `uint8` ; tranches ;
dépassement des `uint8` ; colonnes choisies par un tableau de booléens ;
temps d'une boucle et de numpy.

### C3.2 Lire et écrire les images, et l'effet en boucle

Des bandes sombres de 24 pixels, espacées de 400 pixels, passent vers la
gauche à 90 pixels par image. Sur l'image `numero`, la colonne `x` est dans
une bande si `(x + 90 × numero) % 400 < 24` ; chaque valeur `v` d'un pixel
de la bande devient `v × 6 // 10`.

En tête de `train.py`, sous `from pathlib import Path`, ajouter :

```python

import numpy as np
from PIL import Image
```

À la fin des fonctions, au-dessus de `# ---- Le programme`, coller les
fonctions qui lisent et écrivent les images, et les constantes de l'effet :

```python
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
```

`appliquer(effet)` lit chaque image de la série, lui applique la fonction
`effet`, et réécrit le fichier. Sous les constantes, écrire :

```python
def poteaux_boucle(image, numero):
    """Les bandes des poteaux, pixel par pixel : chaque valeur multipliée par 6/10."""
    hauteur, largeur, _ = image.shape
    resultat = image.copy()
    # à écrire : pour chaque ligne y, chaque colonne x : si la colonne est dans une bande,
    #            chaque valeur des trois canaux devient int(valeur) * 6 // 10
    return resultat
```

`int(valeur)` convertit l'octet en entier Python, qui ne dépasse jamais
255 : le produit `valeur * 6` reste juste.

```text
git commit -am "Poteaux : la version boucle"
```

### C3.3 L'effet avec numpy, et le test

Sous `poteaux_boucle`, écrire la version numpy, qui calcule toutes les
colonnes d'un coup, puis le dictionnaire des effets :

```python
def poteaux_numpy(image, numero):
    """Les bandes des poteaux, sur les colonnes entières."""
    largeur = image.shape[1]
    # à écrire : colonnes, un tableau de booléens, vrai pour les colonnes dans une bande
    resultat = image.copy()
    # à écrire : ces colonnes de resultat reçoivent image[:, colonnes], convertie en uint16, * 6 // 10
    return resultat


EFFETS = {"poteaux": poteaux_numpy}
```

Les outils : `np.arange(largeur)`, le tableau `0, 1, … largeur - 1` ; le
calcul `(… + VITESSE_POTEAUX * numero) % ECART_POTEAUX < LARGEUR_POTEAU` sur
ce tableau donne un tableau de booléens ; `image[:, colonnes]` choisit les
colonnes où il vaut vrai ; `.astype(np.uint16)` convertit en entiers de
deux octets (notebook, section 3).

**Le test.** Les deux versions doivent donner la même image :

```text
cp ../../depart/modeles/test_effet.py .
python test_effet.py
```

**Vérification** : quatre lignes qui finissent par `True`. Sans
`astype(np.uint16)`, les valeurs dépassent 255 et le test affiche `False`.

```text
git add test_effet.py
git commit -am "Poteaux : la version numpy, et le test"
```

### C3.4 L'option `--effet`

Remplacer la fonction `main` par :

```python
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
```

Enregistrer. **Vérification** : `python train.py --images 48 --effet poteaux
--video` écrit la vidéo, où les ombres passent devant le paysage.

```text
git commit -am "L'option --effet"
```

### C3.5 Mesurer, et le rapport

```text
cp ../../depart/modeles/mesurer.py ../../depart/modeles/RAPPORT.md .
python train.py --images 120
python mesurer.py poteaux
python train.py --images 31
cp sortie/images/img_0031.png avant.png
python train.py --images 31 --effet poteaux
cp sortie/images/img_0031.png apres.png
```

**Vérification** : `mesurer.py` affiche deux lignes, `boucle` puis `numpy`.
Sur la machine de préparation, la boucle prend 0,04 s par image, numpy
0,5 ms.

Compléter `RAPPORT.md` : les quatre durées, le nombre d'images, et une
phrase qui dit combien de fois numpy est plus rapide.

```text
git add RAPPORT.md avant.png apres.png mesurer.py
git commit -m "Le rapport : poteaux, boucle et numpy"
```

## C4 · Une vidéo qui boucle

> **À faire :** les fonctions `periode` et `images_pour_boucler` ; l'option `--boucle` ; un commit.
>
> **À obtenir :** `python train.py --boucle --video` écrit 480 images, et la vidéo relancée en boucle ne saute pas.

Un plan de vitesse `v` revient à sa position de départ quand le décalage
`n × v` est un multiple de 1 920, la largeur de la bande : après
`1920 // pgcd(1920, v)` images. Toute la scène revient au départ après le
plus petit multiple commun de ces périodes. `math.gcd` et `math.lcm`
calculent le pgcd et le ppcm.

En tête du fichier, ajouter `import math` sous `import csv`. Sous la fonction
`serie`, écrire :

```python
# ---- Une vidéo qui boucle ----------------------------------------------------

LARGEUR_BANDE = 1920      # la largeur des bandes des plans, en pixels


def periode(vitesse):
    """Le nombre d'images après lequel un plan de cette vitesse revient à sa position de départ."""
    # à écrire : LARGEUR_BANDE divisé (division entière) par le pgcd de LARGEUR_BANDE et de vitesse


def images_pour_boucler(plans):
    """Le plus petit nombre d'images après lequel tous les plans reviennent ensemble au départ."""
    nombre = 1
    # à écrire : pour chaque plan, nombre devient le ppcm de nombre et de la période du plan
    return nombre
```

Puis remplacer la fonction `main` par :

```python
def main():
    analyseur = argparse.ArgumentParser(description="La fenêtre du train : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("--numero", type=int, default=0, help="le numéro d'une image seule (défaut : 0)")
    analyseur.add_argument("--decor", default="decor", help="le dossier des images du décor (défaut : decor)")
    analyseur.add_argument("-n", "--images", type=int, help="une série : ce nombre d'images")
    analyseur.add_argument("--boucle", action="store_true", help="une série dont la vidéo boucle sans saut")
    analyseur.add_argument("--effet", choices=sorted(EFFETS), help="un effet appliqué à chaque image de la série")
    analyseur.add_argument("--video", action="store_true", help="assemble la série en vidéo (avec --images)")
    analyseur.add_argument("-c", "--cadence", type=int, default=12, help="images par seconde de la vidéo (défaut : 12)")
    analyseur.add_argument("--nettoyer", action="store_true", help="supprime les images de la série une fois la vidéo écrite")
    options = analyseur.parse_args()
    decor = Path(options.decor)
    if not (decor / "plans.csv").exists():
        analyseur.error("plans.csv introuvable dans " + options.decor)
    if options.boucle:
        options.images = images_pour_boucler(lire_plans(decor))
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
```

Enregistrer. **Vérifications** :

| Commande | Ce qui doit s'afficher |
|---|---|
| `python -c "import train; from pathlib import Path; print(train.images_pour_boucler(train.lire_plans(Path('decor'))))"` | `480` : les périodes 480, 240 et 120 |
| `python train.py --boucle --effet poteaux --video --nettoyer` | `480 images dans …`, puis la vidéo de 40 secondes |

La période des poteaux, 400 // pgcd(400, 90) = 40 images, divise 480 : la
vidéo boucle aussi avec l'effet.

```text
git commit -am "L'option --boucle"
```

## PR 2 · Le README et la pull request de la branche `poteaux`

> **À faire :** décrire `--numero`, `plans.csv`, `--effet` et `--boucle` dans le README ; un commit ; la pull request de la branche `poteaux`, fusionnée.
>
> **À obtenir :** sur le poste, `master` contient toutes les fonctionnalités.

```text
git commit -am "README : plans.csv, --effet et --boucle"
```

**Pousser la branche** :

```text
git push -u origin poteaux
```

**Vérification** : la dernière ligne affiche `branch 'poteaux' set up to
track 'origin/poteaux'`.

**Ouvrir la pull request.** Sur la page du dépôt sur GitHub, un bandeau
propose « Compare & pull request » : cliquer dessus. Vérifier en haut de la
page : `base: master` ← `compare: poteaux`. Titre : `L'effet des poteaux` ; dans la
description, les commandes qui montrent la fonctionnalité et le tableau des temps de `RAPPORT.md`.
Cliquer « Create pull request ».

**Fusionner.** En bas de la pull request, « Merge pull request », puis
« Confirm merge ». Sur le poste :

```text
git checkout master
git pull
git log --oneline --graph
```

**Vérification** : `git log` montre le commit de fusion, `Merge pull request
#… from <compte>/poteaux`, et les commits de la branche.


## Facultatif

- **Un décor de nuit** : un autre dossier de décor, avec ses bandes et son
  `plans.csv`, lu par `--decor` ; le programme ne change pas.
- **Les ombres dans la vitre seulement** : le masque de la vitre, vrai là où
  `fenetre.png` est transparente (`lire` en RGBA, canal 3 égal à 0).
- **Une pull request en binôme** : chacun propose une vitesse ou un plan
  dans le dépôt de l'autre, par un fork et une pull request.

## Annexe · Le code complet

Les fonctions écrites pendant le TD, telles que le corrigé les donne.

```python
def image(fichier, decor, plans, numero):
    """L'image numéro `numero` : le fond, chaque plan décalé de numero × sa vitesse, puis la fenêtre."""
    commande = [MAGICK] + arguments_fond(decor)
    for nom, vitesse in plans:
        commande = commande + arguments_plan(decor, nom, numero * vitesse) + ["-composite"]
    commande = commande + arguments_fenetre(decor) + ["-composite"]
    commande = commande + [str(fichier)]
    subprocess.run(commande, check=True)
```

```python
def lire_plans(decor):
    """Les plans de `decor/plans.csv`, du plus lointain au plus proche : une liste de (fichier, vitesse)."""
    plans = []
    with open(decor / "plans.csv", encoding="utf-8", newline="") as fichier:
        lecteur = csv.reader(fichier)
        next(lecteur)                     # la ligne des noms de colonnes
        for nom, vitesse in lecteur:
            plans.append((nom, int(vitesse)))
    return plans
```

```python
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
```

```python
def poteaux_numpy(image, numero):
    """Les bandes des poteaux, sur les colonnes entières."""
    largeur = image.shape[1]
    colonnes = (np.arange(largeur) + VITESSE_POTEAUX * numero) % ECART_POTEAUX < LARGEUR_POTEAU
    resultat = image.copy()
    # uint16 : sans lui, image * 6 dépasse 255 et le résultat est faux, sans erreur
    resultat[:, colonnes] = image[:, colonnes].astype(np.uint16) * 6 // 10
    return resultat
```

```python
def periode(vitesse):
    """Le nombre d'images après lequel un plan de cette vitesse revient à sa position de départ."""
    return LARGEUR_BANDE // math.gcd(LARGEUR_BANDE, vitesse)


def images_pour_boucler(plans):
    """Le plus petit nombre d'images après lequel tous les plans reviennent ensemble au départ."""
    nombre = 1
    for nom, vitesse in plans:
        nombre = math.lcm(nombre, periode(vitesse))
    return nombre
```
