---
title: "TD 4a — La montre du Lapin blanc"
subtitle: Guide détaillé, étape par étape
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

Le TD fabrique une courte vidéo : une montre de gousset dont les aiguilles avancent d'une minute par image, de 10 h à 12 h, à côté du Lapin blanc d'*Alice au pays des merveilles*. Le rendu est un projet
Python, versionné avec git, qui contient un script `montre.py` appelable en
ligne de commande.

Le script enchaîne toutes les étapes de la fabrication de la vidéo :

- pour chaque minute, les fonctions Python calculent l'angle des deux aiguilles et la position de leurs extrémités (avec `sin` et `cos`), puis construisent la commande qui dessine l'image ;
- ImageMagick (`magick`) dessine chaque image : le cadran, les aiguilles, le Lapin et l'heure ;
- ffmpeg assemble les images en une vidéo.

ImageMagick et ffmpeg sont des programmes en ligne de commande, comme git
(cours 2) et pandoc (cours 3). Le script les lance avec `subprocess.run`,
une fois par image pour `magick` et une fois à la fin pour `ffmpeg` : Python
automatise ainsi l'ensemble des étapes. Pendant le développement, chaque
étape du TD se termine par un commit git.

Le schéma suivant montre les étapes du script final, avec des images de la
vidéo produite. Il est aussi en tête du notebook.

![Les étapes du script montre.py](depart/illustrations/programme_montre.png)

Le TD a deux parties.

- **Partie A** (environ 35 minutes) : créer un environnement conda qui
  contient ces outils, puis exécuter le notebook `montre.ipynb` qui fabrique la
  vidéo.
- **Partie B** (environ 70 minutes) : construire le programme `montre.py`,
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

**Environnement conda**. Un environnement est un dossier qui
contient un Python et des programmes installés pour un projet. `conda env
create -f environment.yml` le crée à partir d'un fichier qui en donne la
liste ; `conda activate nom` l'active dans le terminal : les commandes
tapées ensuite (`python`, `magick`, `ffmpeg`, `jupyter`) sont celles de cet
environnement.

**Si une étape de la partie B échoue.** `git status` montre les fichiers
modifiés depuis le dernier commit ; `git restore montre.py` remet le fichier
dans l'état du dernier commit.

# Partie A · Exécuter le notebook

## A1 · Récupérer les fichiers du TD, les ouvrir dans VS Code

> **À faire :** copier `info01-cours4.zip` sur le Bureau et le décompresser ; ouvrir le dossier `cours4/4a_montre/` dans VS Code ; ouvrir un terminal Git Bash.
>
> **À obtenir :** l'explorateur de VS Code montre `depart/` et `travail/` ; `pwd` se termine par `cours4/4a_montre`.

Copier l'archive `info01-cours4.zip` du dossier partagé `formationTemp` sur
le Bureau, dans le dossier `info01`, puis la décompresser (clic droit →
Extraire tout). Ne pas travailler dans le dossier partagé.

Ouvrir VS Code, puis Fichier → Ouvrir le dossier… → choisir
`info01/cours4/4a_montre/`. Ouvrir ensuite un terminal Git Bash (voir les
rappels).

**Vérification** : l'explorateur de VS Code montre le contenu du dossier ;
dans le terminal, `pwd` affiche un chemin qui se termine par
`cours4/4a_montre`, et `ls` liste `depart`, `travail`, le guide et
`README.md`. Le dossier contient :

```text
4a_montre/
├── depart/
│   ├── environment.yml
│   ├── illustrations/
│   │   └── programme_montre.png
│   ├── notebook/
│   │   └── montre.ipynb
│   └── modeles/
│       ├── README.md
│       └── pyproject.toml
├── travail/                 (vide)
├── guide_4a_montre.pdf      (ce guide)
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
cp depart/notebook/montre.ipynb travail/
cd travail
jupyter lab
```

JupyterLab est lancé depuis ce terminal, l'environnement `animation` actif :
c'est ainsi que le notebook trouve `magick` et `ffmpeg`. Ne pas le lancer
depuis Anaconda Navigator, qui le lance dans l'environnement `base`.

**Vérification** : le navigateur s'ouvre sur JupyterLab ; s'il ne s'ouvre
pas, copier dans le navigateur l'adresse `http://localhost:8888/lab?token=…`
affichée dans le terminal. Le panneau de gauche de JupyterLab montre
`montre.ipynb`. Ce terminal reste occupé par JupyterLab : le fermer arrête
JupyterLab.

**Exécuter.** Double-cliquer sur `montre.ipynb`, puis exécuter les cellules
une par une avec `Maj` + `Entrée`, en lisant le texte entre les cellules.

**Vérifications** :

- la première cellule affiche trois chemins qui contiennent
  `envs\animation` (ou `envs/animation`). Si `magick` ou `ffmpeg` vaut
  `None`, JupyterLab n'a pas été lancé depuis l'environnement `animation` :
  fermer JupyterLab, refaire A3 et A4 ;
- chaque section affiche une image d'essai ;
- la dernière section affiche la vidéo (`montre.mp4`, 120 images, 10 secondes) ;
- `travail/produit/` contient les images d'essai, le dossier `images/` et
  la vidéo.

Essayer ensuite de changer les valeurs de la dernière section, comme le
propose le cadre « À essayer » du notebook : ce sont les trois valeurs que
la partie B passera sur la ligne de commande.

Fin de la partie A. Fermer l'onglet du notebook ; JupyterLab peut rester
ouvert.

# Partie B · Du notebook au programme

La partie B construit le programme `montre.py` fonctionnalité par
fonctionnalité, comme on développe un projet :

1. **une image** (B1) : `python montre.py --heure 10:05` ;
2. **une série d'images** (B2) : une image par minute, dans `sortie/images/` ;
3. **la vidéo** (B3) : ffmpeg assemble la série ; `--nettoyer` supprime
   ensuite les images de la série.

Chaque fonctionnalité se développe sur sa propre branche git, en deux
commits, puis la branche est fusionnée dans `master`. Le programme a une
fonction `main` et lit ses options avec `argparse` dès la première
fonctionnalité (cours 3). À chaque étape, seules les cellules utiles du
notebook sont reprises.

## B0 · Le dossier du projet et le dépôt git

> **À faire :** dans un second terminal Git Bash, `conda activate animation` ; créer `travail/montre/` avec `environment.yml`, un `.gitignore` et un README d'une ligne ; `git init`, puis un premier commit.
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
mkdir travail/montre
cp depart/environment.yml travail/montre/
cd travail/montre
ls
```

**Vérification** : l'invite se termine par `travail/montre` ; `ls` liste
`environment.yml`. Le dossier apparaît aussi dans l'explorateur
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
revenir dans `travail/montre/` et recommencer.

**Le fichier `.gitignore` et un premier README.** Le programme écrira ses
images et sa vidéo dans un dossier `sortie/` : ces fichiers ne sont pas
versionnés. Le README, d'une ligne pour l'instant, sera complété au fil
des étapes.

```text
echo "sortie/" > .gitignore
echo "# Montre" > README.md
git add .
git commit -m "Le projet : environnement, .gitignore et README"
git log --oneline
```

**Vérification** : `git log --oneline` affiche une ligne ; `git status`
affiche « nothing to commit » (« rien à valider »).

**Dossier à la fin de B0** :

```text
travail/montre/
├── .git/                (caché : le dépôt)
├── .gitignore
├── README.md
└── environment.yml
```

## B1 · Première fonctionnalité : une image

> **À faire :** sur une branche `une-image` : les fonctions de dessin, puis `main` et les options, un commit chacun ; fusion dans `master`.
>
> **À obtenir :** `python montre.py --heure 10:05` écrit `sortie/montre_1005.png` ; trois commits.

**Entrée** : les sections 2 à 5 du notebook. **Sortie** :
`python montre.py --heure 10:05` écrit `sortie/montre_1005.png`.

### B1.1 Une branche pour la fonctionnalité

```text
git checkout -b une-image
git branch
```

**Vérification** : `git branch` affiche `master` et `* une-image` ; l'étoile
marque la branche courante.

### B1.2 Les fonctions de dessin

Créer le fichier `montre.py` dans `travail/montre/` (explorateur de VS Code : clic
droit sur le dossier `montre` → Nouveau fichier). Y coller, dans l'ordre, la
description, les imports, les outils et les chemins :

```python
"""La montre du Lapin blanc : une image, une série d'images ou une vidéo.

Les aiguilles sont placées par Python, l'image est dessinée par ImageMagick,
la vidéo assemblée par ffmpeg.

    python montre.py --heure 10:05
    python montre.py --heure 10:00 --minutes 120
    python montre.py --heure 10:00 --minutes 120 --video --cadence 12 --nettoyer
    python montre.py --help

À lancer dans l'environnement `animation` ; les fichiers sont écrits dans
`sortie/`, dans le dossier du terminal.
"""

import argparse
import math
import subprocess
from pathlib import Path

# Les programmes, et la police des textes
MAGICK = "magick"
FFMPEG = "ffmpeg"
POLICE = None
for candidate in ["C:/Windows/Fonts/arial.ttf", "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"]:
    if Path(candidate).exists():
        POLICE = candidate

# Les fichiers produits vont dans sortie/, dans le dossier du terminal
SORTIE = Path.cwd() / "sortie"
IMAGES = SORTIE / "images"
```

puis, dessous, les fonctions de dessin, reprises des sections 2 à 5 du
notebook :

```python
# ---- Une image (sections 2 à 5 du notebook) ---------------------------------

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
LAPIN = ("fill #ffffff stroke #666666 stroke-width 3 "
         "ellipse 95,110 16,60 0,360  ellipse 145,110 16,60 0,360 "
         "fill #f4b6c2 stroke none ellipse 95,110 7,42 0,360  ellipse 145,110 7,42 0,360 "
         "fill #ffffff stroke #666666 stroke-width 3 circle 120,205 120,255 "
         "fill #e8607a stroke none circle 103,198 103,206  circle 137,198 137,206 "
         "fill #f4b6c2 stroke none ellipse 120,222 6,4 0,360 "
         "fill none stroke #666666 stroke-width 2 "
         "line 65,226 113,222  line 65,240 113,226  line 127,222 175,226  line 127,226 175,240")
CITATION = "« Ah ! j’arriverai trop tard ! »"


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


def point(distance, angle_degres):
    """Le point à `distance` du centre du cadran, dans la direction `angle_degres` (0 en haut, 90 à droite)."""
    angle = math.radians(angle_degres)
    x = CX + distance * math.sin(angle)
    y = CY - distance * math.cos(angle)
    return str(round(x)) + "," + str(round(y))


def graduations():
    """Les soixante traits du bord du cadran, un tous les six degrés."""
    dessin = "fill none stroke #333333 stroke-width 2 "
    for k in range(60):
        angle = k * 6
        if k % 5 == 0:
            longueur = 14        # un trait long toutes les cinq minutes
        else:
            longueur = 6
        dessin = dessin + "line " + point(R - 6, angle) + " " + point(R - 6 - longueur, angle) + " "
    return dessin


def aiguilles(heures, minutes):
    """Les deux aiguilles pour cette heure, et l'axe au centre."""
    angle_heures = 30 * heures + 0.5 * minutes
    angle_minutes = 6 * minutes
    centre = str(CX) + "," + str(CY)
    return ("fill none stroke #222222 stroke-linecap round "
            "stroke-width 8 line " + centre + " " + point(80, angle_heures) + " "
            "stroke-width 5 line " + centre + " " + point(120, angle_minutes) + " "
            "fill #222222 stroke none circle " + centre + " " + str(CX) + "," + str(CY + 7))


def texte_heure(heures, minutes):
    """La citation, puis l'heure écrite « 10 h 05 »."""
    return CITATION + "\n" + str(heures) + " h " + str(minutes).zfill(2)


def dessiner(fichier, heures, minutes):
    """L'image de la montre à cette heure : le cadran, les aiguilles, le Lapin et le texte."""
    dessins = [BOITIER, ANNEAU, graduations(), CHIFFRES, aiguilles(heures, minutes), LAPIN]
    image(fichier, dessins, texte_heure(heures, minutes))
```

Enregistrer (`Ctrl+S`), puis dans le terminal : `python montre.py`.

**Vérification** : rien ne s'affiche, pas d'erreur. Les `def` définissent
les fonctions sans les exécuter : le programme n'a pas encore de `main`.

```text
git add montre.py
git commit -m "Une image : les fonctions de dessin"
```

### B1.3 La fonction `main` et les options

À la fin du fichier, coller :

```python
def lire_heure(texte):
    """L'heure écrite « 10:05 », en deux nombres : (10, 5). Sert de `type` à argparse."""
    morceaux = texte.split(":")
    if len(morceaux) != 2 or not morceaux[0].isdigit() or not morceaux[1].isdigit():
        raise argparse.ArgumentTypeError("heure attendue sous la forme 10:05 : " + texte)
    heures = int(morceaux[0])
    minutes = int(morceaux[1])
    if heures < 1 or heures > 12 or minutes > 59:
        raise argparse.ArgumentTypeError("heure attendue entre 1:00 et 12:59 : " + texte)
    return heures, minutes


# ---- Le programme ------------------------------------------------------------

def main():
    analyseur = argparse.ArgumentParser(description="La montre du Lapin blanc : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("--heure", type=lire_heure, default="10:00", help="l'heure de la montre, sous la forme 10:05 (défaut : 10:00)")
    options = analyseur.parse_args()
    heures, minutes = options.heure
    SORTIE.mkdir(exist_ok=True)

    # Une image
    fichier = SORTIE / ("montre_" + str(heures).zfill(2) + str(minutes).zfill(2) + ".png")
    dessiner(fichier, heures, minutes)
    print(fichier)


# Vrai quand le fichier est lancé par `python`, faux quand il est importé par
# un autre fichier : dans ce cas, main() n'est pas appelé.
if __name__ == "__main__":
    main()
```

`type=lire_heure` : argparse passe le texte de l'option à la fonction `lire_heure`, qui renvoie les deux nombres, ou une erreur si le texte n'est pas une heure. La valeur par défaut, `"10:00"`, passe par la même fonction.

Enregistrer. **Vérifications** :

| Commande | Ce qui doit s'afficher |
|---|---|
| `python montre.py --heure 10:05` | le chemin de `sortie/montre_1005.png` ; l'ouvrir par un double-clic |
| `python montre.py` | `sortie/montre_1000.png` : l'heure par défaut |
| `python montre.py --heure 13:00` | `error: argument --heure: heure attendue entre 1:00 et 12:59 : 13:00` |
| `python montre.py --heure dix` | `error: argument --heure: heure attendue sous la forme 10:05 : dix` |

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

> **À faire :** sur une branche `serie` : la fonction serie, puis l'option `--minutes`, un commit chacun ; fusion dans `master`.
>
> **À obtenir :** une image par minute dans `sortie/images/` ; cinq commits.

**Entrée** : la première cellule de la section 6 du notebook. **Sortie** : `python montre.py --heure 10:00 --minutes 120`
écrit une image par minute dans `sortie/images/`.

### B2.1 Une branche pour la fonctionnalité

```text
git checkout -b serie
```

### B2.2 La fonction `serie`

Dans `montre.py`, entre les fonctions de dessin et la ligne
`# ---- Le programme`, coller :

```python
# ---- Une série d'images (section 6 du notebook, première cellule) -----------

def serie(heures, minutes, nombre):
    """Une image par minute à partir de cette heure, dans IMAGES ; renvoie le nombre d'images."""
    IMAGES.mkdir(parents=True, exist_ok=True)
    for ancienne in IMAGES.glob("img_*.png"):
        ancienne.unlink()
    for t in range(nombre):                     # t : les minutes écoulées depuis la première image
        total = heures * 60 + minutes + t       # les minutes écoulées depuis 0 h 00
        h = (total // 60 - 1) % 12 + 1          # l'heure, de 1 à 12
        m = total % 60
        nom = "img_" + str(t + 1).zfill(4) + ".png"
        dessiner(IMAGES / nom, h, m)
    return nombre
```

Enregistrer. **Vérification** : `python montre.py --help` fonctionne comme
avant : les nouvelles fonctions ne sont pas encore appelées.

```text
git commit -am "Série : la fonction serie"
```

### B2.3 L'option `--minutes` dans `main`

Remplacer toute la fonction `main`, de `def main():` jusqu'à la ligne vide
qui précède `if __name__`, par :

```python
def main():
    analyseur = argparse.ArgumentParser(description="La montre du Lapin blanc : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("--heure", type=lire_heure, default="10:00", help="l'heure de la montre, sous la forme 10:05 (défaut : 10:00)")
    analyseur.add_argument("-m", "--minutes", type=int, help="une série : une image par minute, pendant ce nombre de minutes")
    options = analyseur.parse_args()
    heures, minutes = options.heure
    SORTIE.mkdir(exist_ok=True)

    if options.minutes is None:
        # Une image
        fichier = SORTIE / ("montre_" + str(heures).zfill(2) + str(minutes).zfill(2) + ".png")
        dessiner(fichier, heures, minutes)
        print(fichier)
    else:
        # Une série d'images
        nombre = serie(heures, minutes, options.minutes)
        print(nombre, "images dans", IMAGES)
```

La nouvelle option n'a pas de valeur par défaut : sans elle,
`options.minutes` vaut `None`, et le programme écrit une image seule,
comme en B1. Avec elle, il écrit la série.

Enregistrer. **Vérifications** :

| Commande | Ce qui doit s'afficher |
|---|---|
| `python montre.py --heure 12:50 --minutes 20` | `20 images dans …/sortie/images` ; `img_0011.png` affiche 1 h 00 |
| `python montre.py --heure 10:05` | une image seule, comme en B1 |
| `python montre.py --help` | l'option `--minutes` en plus |

```text
git commit -am "Série : l'option --minutes"
git checkout master
git merge serie
git log --oneline --graph --all
```

**Vérification** : `Fast-forward` ; cinq commits sur une ligne.

## B3 · Troisième fonctionnalité : la vidéo

> **À faire :** sur une branche `video` : `assembler` et les options `--video` et `--cadence` ; un commit sur `master` (le README) ; l'option `--nettoyer` ; fusion avec `git merge --no-edit video`.
>
> **À obtenir :** `sortie/montre.mp4` ; `git log --graph` dessine les deux branches et le commit de fusion ; neuf commits.

**Entrée** : la dernière cellule du notebook (ffmpeg). **Sortie** :
`python montre.py --heure 10:00 --minutes 120 --video` écrit `sortie/montre.mp4` ; avec `--nettoyer`, le dossier
`sortie/images/` est ensuite supprimé.

Cette étape comprend aussi un commit sur `master` pendant le travail sur la
branche, comme lorsqu'une autre personne modifie le projet en même temps :
la fusion crée alors un commit de fusion.

### B3.1 Une branche, et la fonction `assembler`

```text
git checkout -b video
```

Dans `montre.py`, après la fonction `serie`, coller :

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
    analyseur = argparse.ArgumentParser(description="La montre du Lapin blanc : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("--heure", type=lire_heure, default="10:00", help="l'heure de la montre, sous la forme 10:05 (défaut : 10:00)")
    analyseur.add_argument("-m", "--minutes", type=int, help="une série : une image par minute, pendant ce nombre de minutes")
    analyseur.add_argument("--video", action="store_true", help="assemble la série en vidéo (avec --minutes)")
    analyseur.add_argument("-c", "--cadence", type=int, default=12, help="images par seconde de la vidéo (défaut : 12)")
    options = analyseur.parse_args()
    heures, minutes = options.heure
    if options.video and options.minutes is None:
        analyseur.error("--video demande une série : ajouter --minutes")
    SORTIE.mkdir(exist_ok=True)

    if options.minutes is None:
        # Une image
        fichier = SORTIE / ("montre_" + str(heures).zfill(2) + str(minutes).zfill(2) + ".png")
        dessiner(fichier, heures, minutes)
        print(fichier)
    else:
        # Une série d'images
        nombre = serie(heures, minutes, options.minutes)
        print(nombre, "images dans", IMAGES)
        # La vidéo
        if options.video:
            video = SORTIE / "montre.mp4"
            assembler(video, options.cadence)
            print(video, ":", nombre, "images à", options.cadence, "images par seconde")
```

`action="store_true"` fait de `--video` une option sans valeur : présente,
elle vaut `True`. `analyseur.error` affiche un message et arrête le programme.

Enregistrer. **Vérifications** :

| Commande | Ce qui doit s'afficher |
|---|---|
| `python montre.py --heure 10:00 --minutes 30 --video --cadence 6` | `30 images dans …`, puis `…/sortie/montre.mp4 : 30 images à 6 images par seconde` |
| `python montre.py --video` | `error: --video demande une série : ajouter --minutes` |

```text
git commit -am "Vidéo : la fonction assembler, les options --video et --cadence"
```

### B3.2 Pendant ce temps, sur `master` : le README

Revenir sur `master` et y décrire les deux premières fonctionnalités dans le
README :

```text
git checkout master
```

**Vérification** : dans VS Code, `montre.py` n'a plus la fonction `assembler` :
le fichier est dans l'état de `master`.

Ouvrir `README.md` et le remplacer par :

```markdown
# Montre

Une image : `python montre.py --heure 10:05`.

Une série d'images, une par minute : `python montre.py --heure 10:00 --minutes 120`.
```

```text
git commit -am "README : une image et une série d'images"
git checkout video
```

**Vérification** : `montre.py` a de nouveau la fonction `assembler` ; le
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
    analyseur = argparse.ArgumentParser(description="La montre du Lapin blanc : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("--heure", type=lire_heure, default="10:00", help="l'heure de la montre, sous la forme 10:05 (défaut : 10:00)")
    analyseur.add_argument("-m", "--minutes", type=int, help="une série : une image par minute, pendant ce nombre de minutes")
    analyseur.add_argument("--video", action="store_true", help="assemble la série en vidéo (avec --minutes)")
    analyseur.add_argument("-c", "--cadence", type=int, default=12, help="images par seconde de la vidéo (défaut : 12)")
    analyseur.add_argument("--nettoyer", action="store_true", help="supprime les images de la série une fois la vidéo écrite")
    options = analyseur.parse_args()
    heures, minutes = options.heure
    if options.video and options.minutes is None:
        analyseur.error("--video demande une série : ajouter --minutes")
    SORTIE.mkdir(exist_ok=True)

    if options.minutes is None:
        # Une image
        fichier = SORTIE / ("montre_" + str(heures).zfill(2) + str(minutes).zfill(2) + ".png")
        dessiner(fichier, heures, minutes)
        print(fichier)
    else:
        # Une série d'images
        nombre = serie(heures, minutes, options.minutes)
        print(nombre, "images dans", IMAGES)
        # La vidéo, puis les fichiers intermédiaires supprimés si demandé
        if options.video:
            video = SORTIE / "montre.mp4"
            assembler(video, options.cadence)
            print(video, ":", nombre, "images à", options.cadence, "images par seconde")
            if options.nettoyer:
                nettoyer()
                print("images intermédiaires supprimées")
```

Enregistrer. **Vérification** : `python montre.py --heure 10:00 --minutes 30 --video --nettoyer` affiche
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
README contient les deux fonctionnalités et `montre.py` la vidéo : la fusion
réunit le travail des deux branches. `git log` dessine les deux branches :

```text
*   50b1221 (HEAD -> master) Merge branch 'video'
|| * 6ec207f (video) Vidéo : l'option --nettoyer
| * 29d3c28 Vidéo : la fonction assembler, les options --video et --cadence
* | f76d1a1 README : une image et une série d'images
|/
* 7c9a1f3 (serie) Série : l'option --minutes
* 798b51c Série : la fonction serie
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
fonctionne quand on la colle dans le terminal, depuis `travail/montre/`,
l'environnement `animation` actif.

```text
git commit -am "README complet"
git log --oneline
```

**Vérification** : dix lignes, le commit de fusion compris.

**Dossier à la fin de B4** (fin du TD obligatoire) :

```text
travail/montre/
├── .git/
├── .gitignore
├── README.md
├── environment.yml
├── montre.py
└── sortie/               (non versionné)
```

## B5 (facultative) · `src/`, `pyproject.toml` et une commande installée

> **À faire :** `git mv montre.py src/montre.py` ; `pyproject.toml` ; `pip install -e .` ; un commit.
>
> **À obtenir :** la commande `montre` fonctionne depuis n'importe quel dossier ; onze commits.

**Sortie** : une commande `montre`, utilisable dans n'importe quel dossier,
l'environnement `animation` actif, sans écrire `python` ni le chemin du
fichier.

**Déplacer le code dans `src/`** :

```text
mkdir src
git mv montre.py src/montre.py
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
montre = "montre:main"
```

La commande `montre` appelle la fonction `main` du fichier `montre.py`, cherché
dans `src/`.

**Installer** (dans `travail/montre/`, l'environnement `animation` actif) :

```text
pip install -e .
```

**Vérification** : la dernière ligne est `Successfully installed montre-0.1`.
Si l'installation échoue faute de réseau :
`pip install -e . --no-build-isolation`.

**Utiliser la commande** :

```text
cd ..
montre --heure 10:05
montre --help
```

**Vérification** : l'image est écrite dans `travail/sortie/montre_1005.png` ; l'aide s'affiche sans `python`.

**Le commit.** Revenir dans `travail/montre/` (`cd montre`). Dans le README,
remplacer `python montre.py` par `montre` et ajouter la ligne d'installation
`pip install -e .`.

```text
git add .
git commit -m "src/ et pyproject.toml : la commande montre"
git log --oneline
```

**Vérification** : onze lignes. `pip uninstall montre` retire la commande.

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
