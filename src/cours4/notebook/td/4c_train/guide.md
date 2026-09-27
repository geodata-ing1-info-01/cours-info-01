---
title: "TD 4c — La fenêtre du train"
subtitle: Guide détaillé, étape par étape
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# TD 4c — La fenêtre du train

Le TD fabrique une courte vidéo : la mer vue de la fenêtre d'un train, les voiles et la plage qui défilent derrière la vitre, d'après la scène de la mer du clip « Moon » de Kid Francescoli. Le rendu est un projet
Python, versionné avec git, qui contient un script `train.py` appelable en
ligne de commande.

Le script enchaîne toutes les étapes de la fabrication de la vidéo :

- la fonction `decalages` calcule de combien de pixels le paysage est décalé sur chaque image ; pour chaque décalage, la fonction `image` construit la commande qui compose l'image ;
- ImageMagick (`magick`) compose chaque image : le fond fixe, le plan décalé, puis la fenêtre par-dessus ;
- ffmpeg assemble les images en une vidéo.

ImageMagick et ffmpeg sont des programmes en ligne de commande, comme git
(cours 2) et pandoc (cours 3). Le script les lance avec `subprocess.run`,
une fois par image pour `magick` et une fois à la fin pour `ffmpeg` : Python
automatise ainsi l'ensemble des étapes. Pendant le développement, chaque
étape du TD se termine par un commit git.

Le schéma suivant montre les étapes du script final, avec des images de la
vidéo produite. Il est aussi en tête du notebook.

![Les étapes du script train.py](depart/illustrations/programme_train.png)

Le TD a deux parties.

- **Partie A** (environ 35 minutes) : créer un environnement conda qui
  contient ces outils, puis exécuter le notebook `train.ipynb` qui fabrique la
  vidéo.
- **Partie B** (environ 70 minutes) : construire le programme `train.py`,
  lancé depuis un terminal, fonctionnalité par fonctionnalité : une image,
  une série d'images, la vidéo. Chaque fonctionnalité est développée sur une
  branche git, puis fusionnée.

Pour chaque étape, le guide indique le dossier où se placer, les fichiers
au début et à la fin, le code à écrire et l'endroit où l'écrire, les
commandes à taper et la façon de vérifier le résultat.

Le tableau résume les étapes ; chaque nom d'étape renvoie à la page qui la
détaille. Chaque page commence par un encadré qui résume l'étape.

| Étape | Ce qu'on fait | Commits à la fin |
|---|---|---|
| [A1](#a1-récupérer-les-fichiers-du-td-les-ouvrir-dans-vs-code) | récupérer les fichiers du TD | |
| [A2](#a2-rendre-conda-disponible-créer-lenvironnement-animation) | créer l'environnement `animation` | |
| [A3](#a3-activer-lenvironnement-et-vérifier-les-outils) | activer l'environnement et vérifier les outils | |
| [A4](#a4-exécuter-le-notebook-dans-jupyterlab) | exécuter le notebook dans JupyterLab | |
| [B0](#b0-le-dossier-du-projet-et-le-dépôt-git) | créer le dossier du projet et le dépôt git | 1 |
| [B1](#b1-première-fonctionnalité-une-image) | une image, sur la branche `une-image` | 3 |
| [B2](#b2-deuxième-fonctionnalité-une-série-dimages) | une série d'images, sur la branche `serie` | 5 |
| [B3](#b3-troisième-fonctionnalité-la-vidéo) | la vidéo, sur la branche `video`, et un commit sur `master` | 9 |
| [B4](#b4-le-readme-complet) | le README complet | 10 |
| [B5](#b5-facultative-src-pyproject.toml-et-une-commande-installée) (facultatif) | `src/`, `pyproject.toml`, une commande installée | 11 |

## Rappels

**Un seul outil : VS Code.** Tout le TD se fait dans VS Code :
l'explorateur, à gauche, montre les fichiers ; l'éditeur, au centre,
affiche le fichier ouvert ; le terminal, en bas, sert à taper les
commandes. Le dossier du TD est ouvert à l'étape A1 et reste ouvert jusqu'à
la fin.

**Le terminal Git Bash.** Le terminal est Git Bash, celui du cours 2. Pour
l'ouvrir : menu Terminal → Nouveau terminal. Si le terminal ouvert n'est pas
Git Bash, cliquer sur la flèche à côté du `+`, en haut à droite du panneau
du terminal, puis choisir « Git Bash ».

![Ouvrir un terminal Git Bash dans VS Code](illustrations/vscode.png)

L'invite de Git Bash tient sur plusieurs lignes : le nom de l'environnement
conda actif entre parenthèses, puis `eleve@POSTE MINGW64` suivi du dossier
courant ; la dernière ligne commence par `$`, et la commande se tape après.
Dans Git Bash, les chemins s'écrivent avec des `/` : `C:\Users` devient
`/c/Users`.

**Changer de dossier.** `pwd` affiche le dossier courant, `ls` liste son
contenu, `cd nom_du_dossier` descend dans un sous-dossier, `cd ..` remonte
d'un niveau. L'[annexe](#annexe-les-commandes-des-deux-terminaux) rappelle ces commandes et leur équivalent
dans le terminal Windows.

**Environnement conda** (cours 1). Un environnement est un dossier qui
contient un Python et des programmes installés pour un projet. `conda env
create -f environment.yml` le crée à partir d'un fichier qui en donne la
liste ; `conda activate nom` l'active dans le terminal : les commandes
tapées ensuite (`python`, `magick`, `ffmpeg`, `jupyter`) sont celles de cet
environnement.

**Si une étape de la partie B échoue.** `git status` montre les fichiers
modifiés depuis le dernier commit ; `git restore train.py` remet le fichier
dans l'état du dernier commit.

# Partie A · Exécuter le notebook

## A1 · Récupérer les fichiers du TD, les ouvrir dans VS Code

> **À faire :** copier `info01-cours4.zip` sur le Bureau et le décompresser ; ouvrir le dossier `cours4/4c_train/` dans VS Code ; ouvrir un terminal Git Bash.
>
> **À obtenir :** l'explorateur de VS Code montre `depart/` et `travail/` ; `pwd` se termine par `cours4/4c_train`.

Copier l'archive `info01-cours4.zip` du dossier partagé `formationTemp` sur
le Bureau, dans le dossier `info01`, puis la décompresser (clic droit →
Extraire tout). Ne pas travailler dans le dossier partagé.

Ouvrir VS Code, puis Fichier → Ouvrir le dossier… → choisir
`info01/cours4/4c_train/`. Ouvrir ensuite un terminal Git Bash (voir les
rappels).

**Vérification** : l'explorateur de VS Code montre le contenu du dossier ;
dans le terminal, `pwd` affiche un chemin qui se termine par
`cours4/4c_train`, et `ls` liste `depart`, `travail`, le guide et
`README.md`. Le dossier contient :

```text
4c_train/
├── depart/
│   ├── environment.yml
│   ├── decor/
│   │   ├── fond.png
│   │   ├── plan.png
│   │   ├── fenetre.png
│   │   └── plage.png
│   ├── CREDITS.md
│   ├── illustrations/
│   │   └── programme_train.png
│   ├── notebook/
│   │   └── train.ipynb
│   └── modeles/
│       ├── README.md
│       └── pyproject.toml
├── travail/                 (vide)
├── guide_4c_train.pdf      (ce guide)
└── README.md
```

## A2 · Rendre conda disponible, créer l'environnement `animation`

> **À faire :** une fois par poste, rendre `conda` disponible dans Git Bash (`source …` puis `conda init bash`) ; dans `depart/` : `conda env create -f environment.yml`.
>
> **À obtenir :** l'invite commence par `(base)` ; `conda env list` affiche `animation`.

### A2.1 conda dans Git Bash

Git Bash ne connaît pas la commande `conda` au démarrage. Dans le terminal :

```text
source /c/ProgramData/anaconda3/etc/profile.d/conda.sh
conda init bash
```

`source` rend `conda` disponible dans ce terminal. `conda init bash` écrit la
même instruction dans un fichier que Git Bash lit à chaque ouverture : les
terminaux suivants ont `conda` sans rien taper. Cette partie A2.1 ne se fait
qu'une fois par poste.

Fermer le terminal (icône de corbeille, en haut à droite du panneau du
terminal) et en ouvrir un nouveau, Git Bash.

**Vérification** : la première ligne de l'invite est `(base)` ;
`conda --version` affiche `conda 2…`.

Si `source` répond `No such file or directory`, Anaconda est installé dans
un autre dossier du poste. Essayer
`source /c/Users/$USERNAME/anaconda3/etc/profile.d/conda.sh`, ou demander à
l'enseignant.

### A2.2 Le fichier `environment.yml`

Dans l'explorateur de VS Code, cliquer sur `depart/environment.yml` pour
l'afficher :

```yaml
name: animation
channels:
  - conda-forge
dependencies:
  - python=3.12
  - jupyterlab
  - imagemagick
  - ffmpeg
```

`name` est le nom de l'environnement ; `channels` dit où conda télécharge
les paquets ; `dependencies` liste ce qui est installé.

### A2.3 Créer l'environnement

Dans le terminal, depuis le dossier du TD :

```text
cd depart
ls
conda env create -f environment.yml
```

**Vérification** : `ls` liste `environment.yml`. conda calcule ensuite les
paquets à installer, les télécharge et les installe. Cela prend plusieurs
minutes : lire la partie B pendant ce temps. La commande se termine par des
lignes qui indiquent comment activer l'environnement :

```text
# To activate this environment, use
#
#     $ conda activate animation
```

Puis :

```text
conda env list
```

affiche une ligne `animation`, avec le chemin du dossier de
l'environnement.

**Erreurs fréquentes** :

- `EnvironmentFileNotFound` : le terminal n'est pas dans `depart/`.
  Vérifier avec `pwd` et `ls`.
- `CondaValueError: prefix already exists` : l'environnement existe déjà
  (créé par une autre personne sur ce poste, ou lors d'un essai). Passer à
  l'étape A3.
- une erreur de connexion (`CondaHTTPError`) : pas d'accès au réseau.
  Prévenir l'enseignant.

## A3 · Activer l'environnement et vérifier les outils

> **À faire :** `conda activate animation`, puis `magick -version` et `ffmpeg -version`.
>
> **À obtenir :** la première ligne de l'invite est `(animation)` ; les deux versions s'affichent.

Dans le terminal :

```text
conda activate animation
```

**Vérification** : la première ligne de l'invite est `(animation)` au lieu
de `(base)`.

Vérifier que les trois programmes sont ceux de l'environnement :

```text
which python
magick -version
ffmpeg -version
```

**Vérification** :

- `which python` affiche un chemin qui contient `envs/animation` ;
- `magick -version` affiche `Version: ImageMagick 7…` ;
- `ffmpeg -version` affiche `ffmpeg version …`.

Si `magick` répond `command not found`, l'environnement n'est pas actif :
refaire `conda activate animation`.

## A4 · Exécuter le notebook dans JupyterLab

> **À faire :** copier le notebook dans `travail/`, puis `cd travail` et `jupyter lab` ; exécuter le notebook section par section.
>
> **À obtenir :** section 1 : trois chemins dans `envs\animation` ; section 6 : la vidéo.

**Copier le notebook dans `travail/`, puis lancer JupyterLab.** Dans le
terminal, où l'environnement `animation` est actif :

```text
cd ..
cp depart/notebook/train.ipynb travail/
cd travail
jupyter lab
```

JupyterLab est lancé depuis ce terminal, l'environnement `animation` actif :
c'est ainsi que le notebook trouve `magick` et `ffmpeg`. Ne pas le lancer
depuis Anaconda Navigator, qui le lance dans l'environnement `base`.

**Vérification** : le navigateur s'ouvre sur JupyterLab ; s'il ne s'ouvre
pas, copier dans le navigateur l'adresse `http://localhost:8888/lab?token=…`
affichée dans le terminal. Le panneau de gauche de JupyterLab montre
`train.ipynb`. Ce terminal reste occupé par JupyterLab : le fermer arrête
JupyterLab.

**Exécuter.** Double-cliquer sur `train.ipynb`, puis exécuter les cellules
une par une avec `Maj` + `Entrée`, en lisant le texte entre les cellules.

**Vérifications** :

- la première cellule affiche trois chemins qui contiennent
  `envs\animation` (ou `envs/animation`). Si `magick` ou `ffmpeg` vaut
  `None`, JupyterLab n'a pas été lancé depuis l'environnement `animation` :
  fermer JupyterLab, refaire A3 et A4 ;
- chaque section affiche une image d'essai ;
- la dernière section affiche la vidéo (`train.mp4`, 120 images, 10 secondes) ;
- `travail/produit/` contient les images d'essai, le dossier `images/` et
  la vidéo.

Essayer ensuite de changer les valeurs de la dernière section, comme le
propose le cadre « À essayer » du notebook : ce sont les trois valeurs que
la partie B passera sur la ligne de commande.

Fin de la partie A. Fermer l'onglet du notebook ; JupyterLab peut rester
ouvert.

# Partie B · Du notebook au programme

La partie B construit le programme `train.py` fonctionnalité par
fonctionnalité, comme on développe un projet :

1. **une image** (B1) : `python train.py --decalage 200` ;
2. **une série d'images** (B2) : une image par décalage, dans `sortie/images/` ;
3. **la vidéo** (B3) : ffmpeg assemble la série ; `--nettoyer` supprime
   ensuite les images de la série.

Chaque fonctionnalité se développe sur sa propre branche git, en deux
commits, puis la branche est fusionnée dans `master`. Le programme a une
fonction `main` et lit ses options avec `argparse` dès la première
fonctionnalité (cours 3). À chaque étape, seules les cellules utiles du
notebook sont reprises.

## B0 · Le dossier du projet et le dépôt git

> **À faire :** dans un second terminal Git Bash, `conda activate animation` ; créer `travail/train/` avec `environment.yml` et le dossier `decor/`, un `.gitignore` et un README d'une ligne ; `git init`, puis un premier commit.
>
> **À obtenir :** `git log --oneline` affiche une ligne.

**Un nouveau terminal.** Le premier terminal fait tourner JupyterLab. Ouvrir
un second terminal Git Bash (flèche à côté du `+`, puis « Git Bash ») : il
s'ouvre dans le dossier du TD. Y activer l'environnement :

```text
conda activate animation
```

**Vérification** : la première ligne de l'invite est `(animation)`. À refaire
dans chaque nouveau terminal.

**Créer le dossier du projet** et y copier ce dont le programme a besoin :

```text
mkdir travail/train
cp depart/environment.yml travail/train/
cp -r depart/decor travail/train/
cd travail/train
ls
```

**Vérification** : l'invite se termine par `travail/train` ; `ls` liste
`environment.yml` et `decor`. Le dossier apparaît aussi dans l'explorateur
de VS Code.

**Créer le dépôt git** :

```text
git init
git status
```

**Vérification** : `git init` affiche `Initialized empty Git repository`
(ou `Dépôt Git vide initialisé`) ; `git status` liste les fichiers du
dossier sous « Untracked files » (« Fichiers non suivis »). Si `git status`
liste `depart/` ou `travail/`, le dépôt a été créé dans le mauvais dossier :
supprimer le dossier caché `.git` qui vient d'être créé (`rm -rf .git`),
revenir dans `travail/train/` et recommencer.

**Le fichier `.gitignore` et un premier README.** Le programme écrira ses
images et sa vidéo dans un dossier `sortie/` : ces fichiers ne sont pas
versionnés. Le README, d'une ligne pour l'instant, sera complété au fil
des étapes.

```text
echo "sortie/" > .gitignore
echo "# Train" > README.md
git add .
git commit -m "Le projet : environnement, .gitignore et README"
git log --oneline
```

**Vérification** : `git log --oneline` affiche une ligne ; `git status`
affiche « nothing to commit » (« rien à valider »).

**Dossier à la fin de B0** :

```text
travail/train/
├── .git/                (caché : le dépôt)
├── .gitignore
├── README.md
├── decor/               (les quatre images du décor)
└── environment.yml
```

## B1 · Première fonctionnalité : une image

> **À faire :** sur une branche `une-image` : les fonctions de dessin, puis `main` et les options, un commit chacun ; fusion dans `master`.
>
> **À obtenir :** `python train.py --decalage 200` écrit `sortie/train_0200.png` ; trois commits.

**Entrée** : les sections 2 à 4 du notebook. **Sortie** :
`python train.py --decalage 200` écrit `sortie/train_0200.png`.

### B1.1 Une branche pour la fonctionnalité

```text
git checkout -b une-image
git branch
```

**Vérification** : `git branch` affiche `master` et `* une-image` ; l'étoile
marque la branche courante.

### B1.2 Les fonctions de dessin

Créer le fichier `train.py` dans `travail/train/` (explorateur de VS Code : clic
droit sur le dossier `train` → Nouveau fichier). Y coller, dans l'ordre, la
description, les imports, les outils et les chemins :

```python
"""La fenêtre du train : une image, une série d'images ou une vidéo.

Le décalage du paysage est calculé par Python, chaque image composée par
ImageMagick, la vidéo assemblée par ffmpeg.

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
```

puis, dessous, les fonctions de dessin, reprises des sections 2 à 4 du
notebook :

```python
# ---- Une image (sections 2 à 4 du notebook) ---------------------------------


def lancer(commande):
    """Lance une commande (le programme, puis chaque argument) ; s'arrête si elle échoue."""
    subprocess.run(commande, check=True)


def image(fichier, decor, decalage):
    """Une image 640 × 480 : le fond, le plan décalé de `decalage` pixels vers la droite, puis la fenêtre."""
    commande = [MAGICK, str(decor / "fond.png"),
                "(", str(decor / "plan.png"), "-roll", "+" + str(decalage) + "+0",
                "-crop", "640x480+0+0", "+repage", ")", "-composite",
                str(decor / "fenetre.png"), "-composite"]
    commande.append(str(fichier))
    lancer(commande)
```

Enregistrer (`Ctrl+S`), puis dans le terminal : `python train.py`.

**Vérification** : rien ne s'affiche, pas d'erreur. Les `def` définissent
les fonctions sans les exécuter : le programme n'a pas encore de `main`.

```text
git add train.py
git commit -m "Une image : les fonctions de dessin"
```

### B1.3 La fonction `main` et les options

À la fin du fichier, coller :

```python
# ---- Le programme ------------------------------------------------------------

def main():
    analyseur = argparse.ArgumentParser(description="La fenêtre du train : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("-d", "--decalage", type=int, default=0, help="le décalage du paysage d'une image seule, en pixels (défaut : 0)")
    analyseur.add_argument("--decor", default="decor", help="le dossier des images du décor (défaut : decor)")
    options = analyseur.parse_args()
    decor = Path(options.decor)
    if not (decor / "plan.png").exists():
        analyseur.error("décor introuvable : " + options.decor)
    SORTIE.mkdir(exist_ok=True)

    # Une image
    fichier = SORTIE / ("train_" + str(options.decalage).zfill(4) + ".png")
    image(fichier, decor, options.decalage)
    print(fichier)


# Vrai quand le fichier est lancé par `python`, faux quand il est importé par
# un autre fichier : dans ce cas, main() n'est pas appelé.
if __name__ == "__main__":
    main()
```

L'option `--decor` donne le dossier des images du décor ; sa valeur par défaut, `decor`, est le dossier copié à l'étape B0. Si ce dossier ne contient pas `plan.png`, `analyseur.error` affiche un message et arrête le programme.

Enregistrer. **Vérifications** :

| Commande | Ce qui doit s'afficher |
|---|---|
| `python train.py --decalage 200` | le chemin de `sortie/train_0200.png` ; l'ouvrir par un double-clic |
| `python train.py` | `sortie/train_0000.png` : le décalage par défaut |
| `python train.py --decalage 2120` | `sortie/train_2120.png`, identique à `train_0200.png` : la bande fait 1 920 pixels |
| `python train.py --decor absent` | `error: décor introuvable : absent` |

```text
git commit -am "Une image : main et les options"
```

### B1.4 Fusionner la branche dans `master`

```text
git checkout master
git merge une-image
git log --oneline --graph --all
```

**Vérification** : git affiche `Fast-forward` ; `git log` affiche trois
commits sur une seule ligne verticale, `master` et `une-image` sur le
dernier.

![La branche une-image, avant et après la fusion](illustrations/branche_une_image.png)

## B2 · Deuxième fonctionnalité : une série d'images

> **À faire :** sur une branche `serie` : les fonctions decalages et serie, puis l'option `--images`, un commit chacun ; fusion dans `master`.
>
> **À obtenir :** une image par décalage dans `sortie/images/` ; cinq commits.

**Entrée** : la fonction `decalages` de la section 5 et la première cellule de la section 6 du notebook. **Sortie** : `python train.py --images 120`
écrit une image par décalage dans `sortie/images/`.

### B2.1 Une branche pour la fonctionnalité

```text
git checkout -b serie
```

### B2.2 Les fonctions `decalages` et `serie`

Dans `train.py`, entre les fonctions de dessin et la ligne
`# ---- Le programme`, coller :

```python
# ---- Une série d'images (sections 5 et 6 du notebook) -----------------------

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
```

Enregistrer. **Vérification** : `python train.py --help` fonctionne comme
avant : les nouvelles fonctions ne sont pas encore appelées.

```text
git commit -am "Série : les fonctions decalages et serie"
```

### B2.3 L'option `--images` dans `main`

Remplacer toute la fonction `main`, de `def main():` jusqu'à la ligne vide
qui précède `if __name__`, par :

```python
def main():
    analyseur = argparse.ArgumentParser(description="La fenêtre du train : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("-d", "--decalage", type=int, default=0, help="le décalage du paysage d'une image seule, en pixels (défaut : 0)")
    analyseur.add_argument("--decor", default="decor", help="le dossier des images du décor (défaut : decor)")
    analyseur.add_argument("-n", "--images", type=int, help="une série : ce nombre d'images, le paysage décalé de 8 pixels de plus à chaque image")
    options = analyseur.parse_args()
    decor = Path(options.decor)
    if not (decor / "plan.png").exists():
        analyseur.error("décor introuvable : " + options.decor)
    SORTIE.mkdir(exist_ok=True)

    if options.images is None:
        # Une image
        fichier = SORTIE / ("train_" + str(options.decalage).zfill(4) + ".png")
        image(fichier, decor, options.decalage)
        print(fichier)
    else:
        # Une série d'images
        nombre = serie(decor, options.images)
        print(nombre, "images dans", IMAGES)
```

La nouvelle option n'a pas de valeur par défaut : sans elle,
`options.images` vaut `None`, et le programme écrit une image seule,
comme en B1. Avec elle, il écrit la série.

Enregistrer. **Vérifications** :

| Commande | Ce qui doit s'afficher |
|---|---|
| `python train.py --images 24` | `24 images dans …/sortie/images` |
| `python train.py --decalage 100` | une image seule, comme en B1 |
| `python train.py --help` | l'option `--images` en plus |

```text
git commit -am "Série : l'option --images"
git checkout master
git merge serie
git log --oneline --graph --all
```

**Vérification** : `Fast-forward` ; cinq commits sur une ligne.

## B3 · Troisième fonctionnalité : la vidéo

> **À faire :** sur une branche `video` : `assembler` et les options `--video` et `--cadence` ; un commit sur `master` (le README) ; l'option `--nettoyer` ; fusion avec `git merge --no-edit video`.
>
> **À obtenir :** `sortie/train.mp4` ; `git log --graph` dessine les deux branches et le commit de fusion ; neuf commits.

**Entrée** : la dernière cellule du notebook (ffmpeg). **Sortie** :
`python train.py --images 120 --video` écrit `sortie/train.mp4` ; avec `--nettoyer`, le dossier
`sortie/images/` est ensuite supprimé.

Cette étape comprend aussi un commit sur `master` pendant le travail sur la
branche, comme lorsqu'une autre personne modifie le projet en même temps :
la fusion crée alors un commit de fusion.

### B3.1 Une branche, et la fonction `assembler`

```text
git checkout -b video
```

Dans `train.py`, après la fonction `serie`, coller :

```python
# ---- La vidéo (section 6 du notebook, seconde cellule) ----------------------

def assembler(video, cadence):
    """La vidéo à partir des images img_0001.png, img_0002.png… du dossier IMAGES."""
    lancer([FFMPEG, "-y", "-loglevel", "error",
            "-framerate", str(cadence),
            "-i", str(IMAGES / "img_%04d.png"),
            "-c:v", "mpeg4", "-q:v", "3", "-pix_fmt", "yuv420p",
            str(video)])
```

Puis remplacer la fonction `main` par :

```python
def main():
    analyseur = argparse.ArgumentParser(description="La fenêtre du train : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("-d", "--decalage", type=int, default=0, help="le décalage du paysage d'une image seule, en pixels (défaut : 0)")
    analyseur.add_argument("--decor", default="decor", help="le dossier des images du décor (défaut : decor)")
    analyseur.add_argument("-n", "--images", type=int, help="une série : ce nombre d'images, le paysage décalé de 8 pixels de plus à chaque image")
    analyseur.add_argument("--video", action="store_true", help="assemble la série en vidéo (avec --images)")
    analyseur.add_argument("-c", "--cadence", type=int, default=12, help="images par seconde de la vidéo (défaut : 12)")
    options = analyseur.parse_args()
    if options.video and options.images is None:
        analyseur.error("--video demande une série : ajouter --images")
    decor = Path(options.decor)
    if not (decor / "plan.png").exists():
        analyseur.error("décor introuvable : " + options.decor)
    SORTIE.mkdir(exist_ok=True)

    if options.images is None:
        # Une image
        fichier = SORTIE / ("train_" + str(options.decalage).zfill(4) + ".png")
        image(fichier, decor, options.decalage)
        print(fichier)
    else:
        # Une série d'images
        nombre = serie(decor, options.images)
        print(nombre, "images dans", IMAGES)
        # La vidéo
        if options.video:
            video = SORTIE / "train.mp4"
            assembler(video, options.cadence)
            print(video, ":", nombre, "images à", options.cadence, "images par seconde")
```

`action="store_true"` fait de `--video` une option sans valeur : présente,
elle vaut `True`. `analyseur.error` affiche un message et arrête le programme.

Enregistrer. **Vérifications** :

| Commande | Ce qui doit s'afficher |
|---|---|
| `python train.py --images 24 --video --cadence 6` | `24 images dans …`, puis `…/sortie/train.mp4 : 24 images à 6 images par seconde` |
| `python train.py --video` | `error: --video demande une série : ajouter --images` |

```text
git commit -am "Vidéo : la fonction assembler, les options --video et --cadence"
```

### B3.2 Pendant ce temps, sur `master` : le README

Revenir sur `master` et y décrire les deux premières fonctionnalités dans le
README :

```text
git checkout master
```

**Vérification** : dans VS Code, `train.py` n'a plus la fonction `assembler` :
le fichier est dans l'état de `master`.

Ouvrir `README.md` et le remplacer par :

```markdown
# Train

Une image : `python train.py --decalage 200`.

Une série d'images, le paysage décalé de 8 pixels de plus à chaque image : `python train.py --images 120`.
```

```text
git commit -am "README : une image et une série d'images"
git checkout video
```

**Vérification** : `train.py` a de nouveau la fonction `assembler` ; le
README est revenu à une ligne, celui de la branche `video`.

### B3.3 L'option `--nettoyer`

En tête du fichier, ajouter `import shutil` aux imports :

```python
import argparse
import shutil
import subprocess
```

Après la fonction `assembler`, coller :

```python
def nettoyer():
    """Supprime les fichiers intermédiaires : le dossier des images de la série."""
    shutil.rmtree(IMAGES)
```

`shutil.rmtree` supprime un dossier et tout son contenu. Puis remplacer la
fonction `main` par :

```python
def main():
    analyseur = argparse.ArgumentParser(description="La fenêtre du train : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("-d", "--decalage", type=int, default=0, help="le décalage du paysage d'une image seule, en pixels (défaut : 0)")
    analyseur.add_argument("--decor", default="decor", help="le dossier des images du décor (défaut : decor)")
    analyseur.add_argument("-n", "--images", type=int, help="une série : ce nombre d'images, le paysage décalé de 8 pixels de plus à chaque image")
    analyseur.add_argument("--video", action="store_true", help="assemble la série en vidéo (avec --images)")
    analyseur.add_argument("-c", "--cadence", type=int, default=12, help="images par seconde de la vidéo (défaut : 12)")
    analyseur.add_argument("--nettoyer", action="store_true", help="supprime les images de la série une fois la vidéo écrite")
    options = analyseur.parse_args()
    if options.video and options.images is None:
        analyseur.error("--video demande une série : ajouter --images")
    decor = Path(options.decor)
    if not (decor / "plan.png").exists():
        analyseur.error("décor introuvable : " + options.decor)
    SORTIE.mkdir(exist_ok=True)

    if options.images is None:
        # Une image
        fichier = SORTIE / ("train_" + str(options.decalage).zfill(4) + ".png")
        image(fichier, decor, options.decalage)
        print(fichier)
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

Enregistrer. **Vérification** : `python train.py --images 24 --video --nettoyer` affiche
`images intermédiaires supprimées` ; `sortie/` contient la vidéo, et
`sortie/images/` n'existe plus.

```text
git commit -am "Vidéo : l'option --nettoyer"
```

### B3.4 Fusionner : un commit de fusion

```text
git checkout master
git merge --no-edit video
git log --oneline --graph --all
```

`--no-edit` garde le message proposé par git, `Merge branch 'video'`. Sans
cette option, git ouvre un éditeur de texte pour le message (dans Git Bash,
l'éditeur vim : taper `:wq` puis `Entrée` pour en sortir).

**Vérification** : git affiche `Merge made by the 'ort' strategy.` ; le
README contient les deux fonctionnalités et `train.py` la vidéo : la fusion
réunit le travail des deux branches. `git log` dessine les deux branches :

```text
*   50b1221 (HEAD -> master) Merge branch 'video'
|| * 6ec207f (video) Vidéo : l'option --nettoyer
| * 29d3c28 Vidéo : la fonction assembler, les options --video et --cadence
* | f76d1a1 README : une image et une série d'images
|/
* 7c9a1f3 (serie) Série : l'option --images
* 798b51c Série : les fonctions decalages et serie
* 33299e8 (une-image) Une image : main et les options
* c62158a Une image : les fonctions de dessin
* ceebad6 Le projet : environnement, .gitignore et README
```

Les identifiants à sept caractères sont différents sur chaque poste. Le
graphe des commits, avant et après la fusion :

![La branche video et un commit sur master, avant et après la fusion](illustrations/fusion_video.png)

## B4 · Le README complet

> **À faire :** remplacer le README par le modèle et le compléter ; un commit.
>
> **À obtenir :** dix commits.

Remplacer `README.md` par le modèle `depart/modeles/README.md` :

```text
cp ../../depart/modeles/README.md README.md
```

L'ouvrir dans VS Code et remplacer chaque passage « (À compléter …) » :

- une phrase qui dit ce que fait le programme ;
- comment récupérer le dossier (archive ou `git clone`) ;
- pour chacune des trois fonctionnalités, la commande et ce qu'elle écrit
  dans `sortie/` ;
- votre nom.

**Vérification** : `Ctrl+Maj+V` affiche l'aperçu. Chaque commande du README
fonctionne quand on la colle dans le terminal, depuis `travail/train/`,
l'environnement `animation` actif.

```text
git commit -am "README complet"
git log --oneline
```

**Vérification** : dix lignes, le commit de fusion compris.

**Dossier à la fin de B4** (fin du TD obligatoire) :

```text
travail/train/
├── .git/
├── .gitignore
├── README.md
├── environment.yml
├── train.py
├── decor/               (les quatre images du décor)
└── sortie/               (non versionné)
```

## B5 (facultative) · `src/`, `pyproject.toml` et une commande installée

> **À faire :** `git mv train.py src/train.py` ; `pyproject.toml` ; `pip install -e .` ; un commit.
>
> **À obtenir :** la commande `train` fonctionne depuis n'importe quel dossier ; onze commits.

**Sortie** : une commande `train`, utilisable dans n'importe quel dossier,
l'environnement `animation` actif, sans écrire `python` ni le chemin du
fichier.

**Déplacer le code dans `src/`** :

```text
mkdir src
git mv train.py src/train.py
git status
```

**Vérification** : `git status` affiche un renommage (`renamed:`). Le
programme écrit dans `sortie/` du dossier du terminal : il n'y a rien à
changer dans le code.

**Le fichier `pyproject.toml`.** Le copier depuis les modèles, puis
compléter la ligne `description` dans VS Code :

```text
cp ../../depart/modeles/pyproject.toml .
```

La partie à lire est :

```toml
[project.scripts]
train = "train:main"
```

La commande `train` appelle la fonction `main` du fichier `train.py`, cherché
dans `src/`.

**Installer** (dans `travail/train/`, l'environnement `animation` actif) :

```text
pip install -e .
```

**Vérification** : la dernière ligne est `Successfully installed train-0.1`.
Si l'installation échoue faute de réseau :
`pip install -e . --no-build-isolation`.

**Utiliser la commande** :

```text
cd ..
train --decor train/decor --decalage 200
train --help
```

**Vérification** : l'image est écrite dans `travail/sortie/train_0200.png` ; l'aide s'affiche sans `python`.

**Le commit.** Revenir dans `travail/train/` (`cd train`). Dans le README,
remplacer `python train.py` par `train` et ajouter la ligne d'installation
`pip install -e .`.

```text
git add .
git commit -m "src/ et pyproject.toml : la commande train"
git log --oneline
```

**Vérification** : onze lignes. `pip uninstall train` retire la commande.

## Annexe · Les commandes des deux terminaux

Le TD se fait dans **Git Bash**, le terminal bash installé avec git et
utilisé au cours 2. La colonne de gauche donne les mêmes commandes dans le
terminal Windows (`cmd`, invite de commandes d'Anaconda), pour qui l'utilise ailleurs. Le
terminal de VS Code ouvre l'un ou l'autre (flèche à côté du `+` du panneau
du terminal).

| Pour… | Invite de commandes d'Anaconda (`cmd`) | Git Bash (`bash`) |
|---|---|---|
| afficher le dossier courant | `cd` | `pwd` |
| lister le dossier courant | `dir` | `ls` |
| descendre dans un dossier | `cd travail` | `cd travail` |
| remonter d'un niveau | `cd ..` | `cd ..` |
| créer un dossier | `mkdir montre` | `mkdir montre` |
| copier un fichier | `copy depart\environment.yml travail\` | `cp depart/environment.yml travail/` |
| copier un dossier | `xcopy /E /I depart\recettes travail\recettes` | `cp -r depart/recettes travail/` |
| afficher un fichier texte | `type README.md` | `cat README.md` |
| créer un fichier vide | `type nul > .gitignore` | `touch .gitignore` |
| supprimer un fichier | `del essai.txt` | `rm essai.txt` |
| effacer l'écran | `cls` | `clear` |
| écrire un chemin | `C:\Users\moi\Desktop` | `/c/Users/moi/Desktop` |
| activer un environnement | `conda activate animation` | `conda activate animation`, une fois l'étape A2.1 faite |
| lancer git | `git status`, si git est installé pour tout le poste | `git status` |

**conda dans Git Bash** (étape A2.1). Sur les postes de la salle, Anaconda
est installé dans `C:\ProgramData\anaconda3` :

```text
source /c/ProgramData/anaconda3/etc/profile.d/conda.sh
conda init bash
```

Sur un autre ordinateur, le chemin est celui du dossier d'installation
d'Anaconda : taper `echo %CONDA_PREFIX%` dans l'invite de commandes d'Anaconda pour le
trouver. Dans Git Bash, `C:\` s'écrit `/c/` et les `\` deviennent des
`/`.
