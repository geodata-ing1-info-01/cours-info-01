"""Écrit les guides détaillés des TD 4a, 4b et 4c, sur un même plan, avec le code des corrigés.

Les trois guides, `src/cours4/notebook/td/<td>/guide.md`, sont produits par ce
script à partir d'un même texte : leurs étapes restent identiques, seuls le
nom du programme, les données, les fonctions et les options changent. Le
code à coller vient de `generer_corriges.py`, importé ici : les guides et les
corrigés ont toujours le même code.

    python data/cours4/generer_corriges.py
    python data/cours4/generer_guides.py
    python outils/compiler_guides.py --cours 4

Modifier les guides ici, pas dans les fichiers `guide.md`, que ce script
réécrit. Demande pandoc (pour les identifiants des titres, cibles des liens).
"""
from pathlib import Path
import sys

DEPOT = Path(__file__).resolve().parent.parent.parent

sys.path.insert(0, str(Path(__file__).resolve().parent))
import generer_corriges as corriges  # noqa: E402


def fence(code, langue="python"):
    return "```" + langue + "\n" + code.strip("\n") + "\n```"


def tableau_verifs(verifs):
    lignes = ["| Commande | Ce qui doit s'afficher |", "|---|---|"]
    for commande, attendu in verifs:
        lignes.append("| `" + commande + "` | " + attendu + " |")
    return "\n".join(lignes)


def sans_titre(main):
    """La fonction `main` sans la ligne de titre qui la précède dans le fichier."""
    return main[main.index("def main():"):]


TDS = [
    {
        "td": "4a_montre", "numero": "4a", "p": "montre", "titre_court": "Montre",
        "titre": "La montre du Lapin blanc",
        "objet": "une montre de gousset dont les aiguilles avancent d'une minute par image, de 10 h à 12 h, à côté du Lapin blanc d'*Alice au pays des merveilles*",
        "calcul": "pour chaque minute, les fonctions Python calculent l'angle des deux aiguilles et la position de leurs extrémités (avec `sin` et `cos`), puis construisent la commande qui dessine l'image",
        "dessin": "dessine chaque image : le cadran, les aiguilles, le Lapin et l'heure",
        "schema": "depart/illustrations/programme_montre.png",
        "arbre_depart_extra": "",
        "arbre_projet_donnees": "",
        "cp_extra": "", "ls_extra": "", "copie": "",
        "sortie_notebook": "`montre.mp4`, 120 images, 10 secondes",
        "sections_b1": "2 à 5",
        "sections_b2": "la première cellule de la section 6",
        "b1_cmd": "python montre.py --heure 10:05",
        "b1_fichier": "sortie/montre_1005.png",
        "b1_explication": "`type=lire_heure` : argparse passe le texte de l'option à la fonction `lire_heure`, qui renvoie les deux nombres, ou une erreur si le texte n'est pas une heure. La valeur par défaut, `\"10:00\"`, passe par la même fonction.",
        "b1_verifs": [
            ("python montre.py --heure 10:05", "le chemin de `sortie/montre_1005.png` ; l'ouvrir par un double-clic"),
            ("python montre.py", "`sortie/montre_1000.png` : l'heure par défaut"),
            ("python montre.py --heure 13:00", "`error: argument --heure: heure attendue entre 1:00 et 12:59 : 13:00`"),
            ("python montre.py --heure dix", "`error: argument --heure: heure attendue sous la forme 10:05 : dix`"),
        ],
        "serie_unite": "minute", "serie_option": "--minutes", "serie_attribut": "minutes",
        "b2_titre_fonctions": "La fonction `serie`", "b2_commit1": "la fonction serie",
        "b2_cmd": "python montre.py --heure 10:00 --minutes 120",
        "b2_verifs": [
            ("python montre.py --heure 12:50 --minutes 20", "`20 images dans …/sortie/images` ; `img_0011.png` affiche 1 h 00"),
            ("python montre.py --heure 10:05", "une image seule, comme en B1"),
            ("python montre.py --help", "l'option `--minutes` en plus"),
        ],
        "b3_cmd": "python montre.py --heure 10:00 --minutes 120 --video",
        "b3_verifs": [
            ("python montre.py --heure 10:00 --minutes 30 --video --cadence 6", "`30 images dans …`, puis `…/sortie/montre.mp4 : 30 images à 6 images par seconde`"),
            ("python montre.py --video", "`error: --video demande une série : ajouter --minutes`"),
        ],
        "b3_cmd_nettoyer": "python montre.py --heure 10:00 --minutes 30 --video --nettoyer",
        "readme_b3": "# Montre\n\nUne image : `python montre.py --heure 10:05`.\n\nUne série d'images, une par minute : `python montre.py --heure 10:00 --minutes 120`.",
        "b5_cmd": "montre --heure 10:05",
        "b5_attendu": "l'image est écrite dans `travail/sortie/montre_1005.png`",
    },
    {
        "td": "4b_tourbillon", "numero": "4b", "p": "tourbillon", "titre_court": "Tourbillon",
        "titre": "La Vague en tourbillon",
        "objet": "*La Grande Vague* de Hokusai, l'image du cours 3, qui se tord en tourbillon puis se détord",
        "calcul": "la fonction `angles` calcule la liste des angles de torsion, de 0 à 360 degrés puis retour à 0 ; pour chaque angle, la fonction `image` construit la commande qui tord l'image",
        "dessin": "réduit l'image, puis tord chaque copie de l'angle voulu et écrit cet angle en bas",
        "schema": "depart/illustrations/programme_tourbillon.png",
        "arbre_depart_extra": "│   ├── vague.jpg\n│   ├── CREDITS.md\n",
        "arbre_projet_donnees": "├── vague.jpg\n",
        "cp_extra": "cp depart/vague.jpg travail/tourbillon/\n", "ls_extra": " et `vague.jpg`", "copie": " et `vague.jpg`",
        "sortie_notebook": "`tourbillon.mp4`, 49 images, 4 secondes",
        "sections_b1": "2 à 4 (avec la fonction `texte_angle` de la section 5)",
        "sections_b2": "la fonction `angles` de la section 5 et la première cellule de la section 6",
        "b1_cmd": "python tourbillon.py vague.jpg --angle 90",
        "b1_fichier": "sortie/tourbillon_090.png",
        "b1_explication": "`image` est un argument positionnel, donc obligatoire : le chemin de l'image à tordre. Si le fichier n'existe pas, `analyseur.error` affiche un message et arrête le programme. L'image est d'abord réduite dans `sortie/petite.png`.",
        "b1_verifs": [
            ("python tourbillon.py vague.jpg --angle 90", "le chemin de `sortie/tourbillon_090.png` ; l'ouvrir par un double-clic"),
            ("python tourbillon.py vague.jpg", "`sortie/tourbillon_090.png` : l'angle par défaut"),
            ("python tourbillon.py absente.jpg", "`error: image introuvable : absente.jpg`"),
            ("python tourbillon.py", "`error: the following arguments are required: image`"),
        ],
        "serie_unite": "angle", "serie_option": "--maximum", "serie_attribut": "maximum",
        "b2_titre_fonctions": "Les fonctions `angles` et `serie`", "b2_commit1": "les fonctions angles et serie",
        "b2_cmd": "python tourbillon.py vague.jpg --maximum 360",
        "b2_verifs": [
            ("python tourbillon.py vague.jpg --maximum 90", "`13 images dans …/sortie/images`"),
            ("python tourbillon.py vague.jpg --angle 45", "une image seule, comme en B1"),
            ("python tourbillon.py --help", "l'option `--maximum` en plus"),
        ],
        "b3_cmd": "python tourbillon.py vague.jpg --maximum 360 --video",
        "b3_verifs": [
            ("python tourbillon.py vague.jpg --maximum 90 --video --cadence 6", "`13 images dans …`, puis `…/sortie/tourbillon.mp4 : 13 images à 6 images par seconde`"),
            ("python tourbillon.py vague.jpg --video", "`error: --video demande une série : ajouter --maximum`"),
        ],
        "b3_cmd_nettoyer": "python tourbillon.py vague.jpg --maximum 90 --video --nettoyer",
        "readme_b3": "# Tourbillon\n\nUne image : `python tourbillon.py vague.jpg --angle 90`.\n\nUne série d'images, de 0 à 360 degrés puis retour : `python tourbillon.py vague.jpg --maximum 360`.",
        "b5_cmd": "tourbillon tourbillon/vague.jpg --angle 90",
        "b5_attendu": "l'image est écrite dans `travail/sortie/tourbillon_090.png`",
    },
    {
        "td": "4c_train", "numero": "4c", "p": "train", "titre_court": "Train",
        "titre": "La fenêtre du train",
        "objet": "la mer vue de la fenêtre d'un train, les voiles et la plage qui défilent derrière la vitre, d'après la scène de la mer du clip « Moon » de Kid Francescoli",
        "calcul": "la fonction `decalages` calcule de combien de pixels le paysage est décalé sur chaque image ; pour chaque décalage, la fonction `image` construit la commande qui compose l'image",
        "dessin": "compose chaque image : le fond fixe, le plan décalé, puis la fenêtre par-dessus",
        "schema": "depart/illustrations/programme_train.png",
        "arbre_depart_extra": "│   ├── decor/\n│   │   ├── fond.png\n│   │   ├── plan.png\n│   │   ├── fenetre.png\n│   │   └── plage.png\n│   ├── CREDITS.md\n",
        "arbre_projet_donnees": "├── decor/               (les quatre images du décor)\n",
        "cp_extra": "cp -r depart/decor travail/train/\n", "ls_extra": " et `decor`", "copie": " et le dossier `decor/`",
        "sortie_notebook": "`train.mp4`, 120 images, 10 secondes",
        "sections_b1": "2 à 4",
        "sections_b2": "la fonction `decalages` de la section 5 et la première cellule de la section 6",
        "b1_cmd": "python train.py --decalage 200",
        "b1_fichier": "sortie/train_0200.png",
        "b1_explication": "L'option `--decor` donne le dossier des images du décor ; sa valeur par défaut, `decor`, est le dossier copié à l'étape B0. Si ce dossier ne contient pas `plan.png`, `analyseur.error` affiche un message et arrête le programme.",
        "b1_verifs": [
            ("python train.py --decalage 200", "le chemin de `sortie/train_0200.png` ; l'ouvrir par un double-clic"),
            ("python train.py", "`sortie/train_0000.png` : le décalage par défaut"),
            ("python train.py --decalage 2120", "`sortie/train_2120.png`, identique à `train_0200.png` : la bande fait 1 920 pixels"),
            ("python train.py --decor absent", "`error: décor introuvable : absent`"),
        ],
        "serie_unite": "décalage", "serie_option": "--images", "serie_attribut": "images",
        "b2_titre_fonctions": "Les fonctions `decalages` et `serie`", "b2_commit1": "les fonctions decalages et serie",
        "b2_cmd": "python train.py --images 120",
        "b2_verifs": [
            ("python train.py --images 24", "`24 images dans …/sortie/images`"),
            ("python train.py --decalage 100", "une image seule, comme en B1"),
            ("python train.py --help", "l'option `--images` en plus"),
        ],
        "b3_cmd": "python train.py --images 120 --video",
        "b3_verifs": [
            ("python train.py --images 24 --video --cadence 6", "`24 images dans …`, puis `…/sortie/train.mp4 : 24 images à 6 images par seconde`"),
            ("python train.py --video", "`error: --video demande une série : ajouter --images`"),
        ],
        "b3_cmd_nettoyer": "python train.py --images 24 --video --nettoyer",
        "readme_b3": "# Train\n\nUne image : `python train.py --decalage 200`.\n\nUne série d'images, le paysage décalé de 8 pixels de plus à chaque image : `python train.py --images 120`.",
        "b5_cmd": "train --decor train/decor --decalage 200",
        "b5_attendu": "l'image est écrite dans `travail/sortie/train_0200.png`",
    },
]


def guide(t):
    p = t["p"]
    pieces = corriges.PIECES[p]
    entete = pieces["doc"] + "\n" + pieces["imports"] + pieces.get("outils", corriges.OUTILS)
    dessin = pieces["dessin"]
    main_b1 = pieces["options"] + pieces["main-b1"] + corriges.APPEL
    serie = pieces["serie"]
    main_b2 = sans_titre(pieces["main-b2"])
    assembler = corriges.ASSEMBLER
    main_b3v = sans_titre(pieces["main-b3-video"])
    nettoyer = pieces["nettoyer"]
    main_b3 = sans_titre(pieces["main-b3"])
    cp_extra = t["cp_extra"]
    ls_extra = t["ls_extra"]
    L = []
    w = L.append

    w(f"""---
title: "TD {t['numero']} — {t['titre']}"
subtitle: Guide détaillé, étape par étape
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# TD {t['numero']} — {t['titre']}

Le TD fabrique une courte vidéo : {t['objet']}. Le rendu est un projet
Python, versionné avec git, qui contient un script `{p}.py` appelable en
ligne de commande.

Le script enchaîne toutes les étapes de la fabrication de la vidéo :

- {t['calcul']} ;
- ImageMagick (`magick`) {t['dessin']} ;
- ffmpeg assemble les images en une vidéo.

ImageMagick et ffmpeg sont des programmes en ligne de commande, comme git
(cours 2) et pandoc (cours 3). Le script les lance avec `subprocess.run`,
une fois par image pour `magick` et une fois à la fin pour `ffmpeg` : Python
automatise ainsi l'ensemble des étapes. Pendant le développement, chaque
étape du TD se termine par un commit git.

Le schéma suivant montre les étapes du script final, avec des images de la
vidéo produite. Il est aussi en tête du notebook.

![Les étapes du script {p}.py]({t['schema']})

Le TD a deux parties.

- **Partie A** (environ 35 minutes) : créer un environnement conda qui
  contient ces outils, puis exécuter le notebook `{p}.ipynb` qui fabrique la
  vidéo.
- **Partie B** (environ 70 minutes) : construire le programme `{p}.py`,
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
| [A1](#@A1) | récupérer les fichiers du TD | |
| [A2](#@A2) | créer l'environnement `animation` | |
| [A3](#@A3) | activer l'environnement et vérifier les outils | |
| [A4](#@A4) | exécuter le notebook dans JupyterLab | |
| [B0](#@B0) | créer le dossier du projet et le dépôt git | 1 |
| [B1](#@B1) | une image, sur la branche `une-image` | 3 |
| [B2](#@B2) | une série d'images, sur la branche `serie` | 5 |
| [B3](#@B3) | la vidéo, sur la branche `video`, et un commit sur `master` | 9 |
| [B4](#@B4) | le README complet | 10 |
| [B5](#@B5) (facultatif) | `src/`, `pyproject.toml`, une commande installée | 11 |

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
Dans Git Bash, les chemins s'écrivent avec des `/` : `C:\\Users` devient
`/c/Users`.

**Changer de dossier.** `pwd` affiche le dossier courant, `ls` liste son
contenu, `cd nom_du_dossier` descend dans un sous-dossier, `cd ..` remonte
d'un niveau. L'[annexe](#@ANNEXE) rappelle ces commandes et leur équivalent
dans le terminal Windows.

**Environnement conda** (cours 1). Un environnement est un dossier qui
contient un Python et des programmes installés pour un projet. `conda env
create -f environment.yml` le crée à partir d'un fichier qui en donne la
liste ; `conda activate nom` l'active dans le terminal : les commandes
tapées ensuite (`python`, `magick`, `ffmpeg`, `jupyter`) sont celles de cet
environnement.

**Si une étape de la partie B échoue.** `git status` montre les fichiers
modifiés depuis le dernier commit ; `git restore {p}.py` remet le fichier
dans l'état du dernier commit.

# Partie A · Exécuter le notebook

## A1 · Récupérer les fichiers du TD, les ouvrir dans VS Code

Copier l'archive `info01-cours4.zip` du dossier partagé `formationTemp` sur
le Bureau, dans le dossier `info01`, puis la décompresser (clic droit →
Extraire tout). Ne pas travailler dans le dossier partagé.

Ouvrir VS Code, puis Fichier → Ouvrir le dossier… → choisir
`info01/cours4/{t['td']}/`. Ouvrir ensuite un terminal Git Bash (voir les
rappels).

**Vérification** : l'explorateur de VS Code montre le contenu du dossier ;
dans le terminal, `pwd` affiche un chemin qui se termine par
`cours4/{t['td']}`, et `ls` liste `depart`, `travail`, le guide et
`README.md`. Le dossier contient :

```text
{t['td']}/
├── depart/
│   ├── environment.yml
{t['arbre_depart_extra']}│   ├── illustrations/
│   │   └── programme_{p}.png
│   ├── notebook/
│   │   └── {p}.ipynb
│   └── modeles/
│       ├── README.md
│       └── pyproject.toml
├── travail/                 (vide)
├── guide_{t['td']}.pdf      (ce guide)
└── README.md
```

## A2 · Rendre conda disponible, créer l'environnement `animation`

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

**Copier le notebook dans `travail/`, puis lancer JupyterLab.** Dans le
terminal, où l'environnement `animation` est actif :

```text
cd ..
cp depart/notebook/{p}.ipynb travail/
cd travail
jupyter lab
```

JupyterLab est lancé depuis ce terminal, l'environnement `animation` actif :
c'est ainsi que le notebook trouve `magick` et `ffmpeg`. Ne pas le lancer
depuis Anaconda Navigator, qui le lance dans l'environnement `base`.

**Vérification** : le navigateur s'ouvre sur JupyterLab ; s'il ne s'ouvre
pas, copier dans le navigateur l'adresse `http://localhost:8888/lab?token=…`
affichée dans le terminal. Le panneau de gauche de JupyterLab montre
`{p}.ipynb`. Ce terminal reste occupé par JupyterLab : le fermer arrête
JupyterLab.

**Exécuter.** Double-cliquer sur `{p}.ipynb`, puis exécuter les cellules
une par une avec `Maj` + `Entrée`, en lisant le texte entre les cellules.

**Vérifications** :

- la première cellule affiche trois chemins qui contiennent
  `envs\\animation` (ou `envs/animation`). Si `magick` ou `ffmpeg` vaut
  `None`, JupyterLab n'a pas été lancé depuis l'environnement `animation` :
  fermer JupyterLab, refaire A3 et A4 ;
- chaque section affiche une image d'essai ;
- la dernière section affiche la vidéo ({t['sortie_notebook']}) ;
- `travail/produit/` contient les images d'essai, le dossier `images/` et
  la vidéo.

Essayer ensuite de changer les valeurs de la dernière section, comme le
propose le cadre « À essayer » du notebook : ce sont les trois valeurs que
la partie B passera sur la ligne de commande.

Fin de la partie A. Fermer l'onglet du notebook ; JupyterLab peut rester
ouvert.

# Partie B · Du notebook au programme

La partie B construit le programme `{p}.py` fonctionnalité par
fonctionnalité, comme on développe un projet :

1. **une image** (B1) : `{t['b1_cmd']}` ;
2. **une série d'images** (B2) : une image par {t['serie_unite']}, dans `sortie/images/` ;
3. **la vidéo** (B3) : ffmpeg assemble la série ; `--nettoyer` supprime
   ensuite les images de la série.

Chaque fonctionnalité se développe sur sa propre branche git, en deux
commits, puis la branche est fusionnée dans `master`. Le programme a une
fonction `main` et lit ses options avec `argparse` dès la première
fonctionnalité (cours 3). À chaque étape, seules les cellules utiles du
notebook sont reprises.

## B0 · Le dossier du projet et le dépôt git

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
mkdir travail/{p}
cp depart/environment.yml travail/{p}/
{cp_extra}cd travail/{p}
ls
```

**Vérification** : l'invite se termine par `travail/{p}` ; `ls` liste
`environment.yml`{ls_extra}. Le dossier apparaît aussi dans l'explorateur
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
revenir dans `travail/{p}/` et recommencer.

**Le fichier `.gitignore` et un premier README.** Le programme écrira ses
images et sa vidéo dans un dossier `sortie/` : ces fichiers ne sont pas
versionnés. Le README, d'une ligne pour l'instant, sera complété au fil
des étapes.

```text
echo "sortie/" > .gitignore
echo "# {t['titre_court']}" > README.md
git add .
git commit -m "Le projet : environnement, .gitignore et README"
git log --oneline
```

**Vérification** : `git log --oneline` affiche une ligne ; `git status`
affiche « nothing to commit » (« rien à valider »).

**Dossier à la fin de B0** :

```text
travail/{p}/
├── .git/                (caché : le dépôt)
├── .gitignore
├── README.md
{t['arbre_projet_donnees']}└── environment.yml
```

## B1 · Première fonctionnalité : une image

**Entrée** : les sections {t['sections_b1']} du notebook. **Sortie** :
`{t['b1_cmd']}` écrit `{t['b1_fichier']}`.

### B1.1 Une branche pour la fonctionnalité

```text
git checkout -b une-image
git branch
```

**Vérification** : `git branch` affiche `master` et `* une-image` ; l'étoile
marque la branche courante.

### B1.2 Les fonctions de dessin

Créer le fichier `{p}.py` dans `travail/{p}/` (explorateur de VS Code : clic
droit sur le dossier `{p}` → Nouveau fichier). Y coller, dans l'ordre, la
description, les imports, les outils et les chemins :

{fence(entete)}

puis, dessous, les fonctions de dessin, reprises des sections {t['sections_b1']} du
notebook :

{fence(dessin)}

Enregistrer (`Ctrl+S`), puis dans le terminal : `python {p}.py`.

**Vérification** : rien ne s'affiche, pas d'erreur. Les `def` définissent
les fonctions sans les exécuter : le programme n'a pas encore de `main`.

```text
git add {p}.py
git commit -m "Une image : les fonctions de dessin"
```

### B1.3 La fonction `main` et les options

À la fin du fichier, coller :

{fence(main_b1)}

{t['b1_explication']}

Enregistrer. **Vérifications** :

{tableau_verifs(t['b1_verifs'])}

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

**Entrée** : {t['sections_b2']} du notebook. **Sortie** : `{t['b2_cmd']}`
écrit une image par {t['serie_unite']} dans `sortie/images/`.

### B2.1 Une branche pour la fonctionnalité

```text
git checkout -b serie
```

### B2.2 {t['b2_titre_fonctions']}

Dans `{p}.py`, entre les fonctions de dessin et la ligne
`# ---- Le programme`, coller :

{fence(serie)}

Enregistrer. **Vérification** : `python {p}.py --help` fonctionne comme
avant : les nouvelles fonctions ne sont pas encore appelées.

```text
git commit -am "Série : {t['b2_commit1']}"
```

### B2.3 L'option `{t['serie_option']}` dans `main`

Remplacer toute la fonction `main`, de `def main():` jusqu'à la ligne vide
qui précède `if __name__`, par :

{fence(main_b2)}

La nouvelle option n'a pas de valeur par défaut : sans elle,
`options.{t['serie_attribut']}` vaut `None`, et le programme écrit une image seule,
comme en B1. Avec elle, il écrit la série.

Enregistrer. **Vérifications** :

{tableau_verifs(t['b2_verifs'])}

```text
git commit -am "Série : l'option {t['serie_option']}"
git checkout master
git merge serie
git log --oneline --graph --all
```

**Vérification** : `Fast-forward` ; cinq commits sur une ligne.

## B3 · Troisième fonctionnalité : la vidéo

**Entrée** : la dernière cellule du notebook (ffmpeg). **Sortie** :
`{t['b3_cmd']}` écrit `sortie/{p}.mp4` ; avec `--nettoyer`, le dossier
`sortie/images/` est ensuite supprimé.

Cette étape comprend aussi un commit sur `master` pendant le travail sur la
branche, comme lorsqu'une autre personne modifie le projet en même temps :
la fusion crée alors un commit de fusion.

### B3.1 Une branche, et la fonction `assembler`

```text
git checkout -b video
```

Dans `{p}.py`, après la fonction `serie`, coller :

{fence(assembler)}

Puis remplacer la fonction `main` par :

{fence(main_b3v)}

`action="store_true"` fait de `--video` une option sans valeur : présente,
elle vaut `True`. `analyseur.error` affiche un message et arrête le programme.

Enregistrer. **Vérifications** :

{tableau_verifs(t['b3_verifs'])}

```text
git commit -am "Vidéo : la fonction assembler, les options --video et --cadence"
```

### B3.2 Pendant ce temps, sur `master` : le README

Revenir sur `master` et y décrire les deux premières fonctionnalités dans le
README :

```text
git checkout master
```

**Vérification** : dans VS Code, `{p}.py` n'a plus la fonction `assembler` :
le fichier est dans l'état de `master`.

Ouvrir `README.md` et le remplacer par :

```markdown
{t['readme_b3']}
```

```text
git commit -am "README : une image et une série d'images"
git checkout video
```

**Vérification** : `{p}.py` a de nouveau la fonction `assembler` ; le
README est revenu à une ligne, celui de la branche `video`.

### B3.3 L'option `--nettoyer`

En tête du fichier, ajouter `import shutil` aux imports :

```python
import argparse
import shutil
import subprocess
```

Après la fonction `assembler`, coller :

{fence(nettoyer)}

`shutil.rmtree` supprime un dossier et tout son contenu. Puis remplacer la
fonction `main` par :

{fence(main_b3)}

Enregistrer. **Vérification** : `{t['b3_cmd_nettoyer']}` affiche
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
README contient les deux fonctionnalités et `{p}.py` la vidéo : la fusion
réunit le travail des deux branches. `git log` dessine les deux branches :

```text
*   50b1221 (HEAD -> master) Merge branch 'video'
|\
| * 6ec207f (video) Vidéo : l'option --nettoyer
| * 29d3c28 Vidéo : la fonction assembler, les options --video et --cadence
* | f76d1a1 README : une image et une série d'images
|/
* 7c9a1f3 (serie) Série : l'option {t['serie_option']}
* 798b51c Série : {t['b2_commit1']}
* 33299e8 (une-image) Une image : main et les options
* c62158a Une image : les fonctions de dessin
* ceebad6 Le projet : environnement, .gitignore et README
```

Les identifiants à sept caractères sont différents sur chaque poste. Le
graphe des commits, avant et après la fusion :

![La branche video et un commit sur master, avant et après la fusion](illustrations/fusion_video.png)

## B4 · Le README complet

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
fonctionne quand on la colle dans le terminal, depuis `travail/{p}/`,
l'environnement `animation` actif.

```text
git commit -am "README complet"
git log --oneline
```

**Vérification** : dix lignes, le commit de fusion compris.

**Dossier à la fin de B4** (fin du TD obligatoire) :

```text
travail/{p}/
├── .git/
├── .gitignore
├── README.md
├── environment.yml
├── {p}.py
{t['arbre_projet_donnees']}└── sortie/               (non versionné)
```

## B5 (facultative) · `src/`, `pyproject.toml` et une commande installée

**Sortie** : une commande `{p}`, utilisable dans n'importe quel dossier,
l'environnement `animation` actif, sans écrire `python` ni le chemin du
fichier.

**Déplacer le code dans `src/`** :

```text
mkdir src
git mv {p}.py src/{p}.py
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
{p} = "{p}:main"
```

La commande `{p}` appelle la fonction `main` du fichier `{p}.py`, cherché
dans `src/`.

**Installer** (dans `travail/{p}/`, l'environnement `animation` actif) :

```text
pip install -e .
```

**Vérification** : la dernière ligne est `Successfully installed {p}-0.1`.
Si l'installation échoue faute de réseau :
`pip install -e . --no-build-isolation`.

**Utiliser la commande** :

```text
cd ..
{t['b5_cmd']}
{p} --help
```

**Vérification** : {t['b5_attendu']} ; l'aide s'affiche sans `python`.

**Le commit.** Revenir dans `travail/{p}/` (`cd {p}`). Dans le README,
remplacer `python {p}.py` par `{p}` et ajouter la ligne d'installation
`pip install -e .`.

```text
git add .
git commit -m "src/ et pyproject.toml : la commande {p}"
git log --oneline
```

**Vérification** : onze lignes. `pip uninstall {p}` retire la commande.
""")
    w(ANNEXE)
    texte = "".join(L)
    texte = inserer_resumes(texte, t)
    return lier(texte)


ANNEXE = """
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
| copier un fichier | `copy depart\\environment.yml travail\\` | `cp depart/environment.yml travail/` |
| copier un dossier | `xcopy /E /I depart\\recettes travail\\recettes` | `cp -r depart/recettes travail/` |
| afficher un fichier texte | `type README.md` | `cat README.md` |
| créer un fichier vide | `type nul > .gitignore` | `touch .gitignore` |
| supprimer un fichier | `del essai.txt` | `rm essai.txt` |
| effacer l'écran | `cls` | `clear` |
| écrire un chemin | `C:\\Users\\moi\\Desktop` | `/c/Users/moi/Desktop` |
| activer un environnement | `conda activate animation` | `conda activate animation`, une fois l'étape A2.1 faite |
| lancer git | `git status`, si git est installé pour tout le poste | `git status` |

**conda dans Git Bash** (étape A2.1). Sur les postes de la salle, Anaconda
est installé dans `C:\\ProgramData\\anaconda3` :

```text
source /c/ProgramData/anaconda3/etc/profile.d/conda.sh
conda init bash
```

Sur un autre ordinateur, le chemin est celui du dossier d'installation
d'Anaconda : taper `echo %CONDA_PREFIX%` dans l'invite de commandes d'Anaconda pour le
trouver. Dans Git Bash, `C:\\` s'écrit `/c/` et les `\\` deviennent des
`/`.
"""

RESUMES = {
    "A1": ("copier `info01-cours4.zip` sur le Bureau et le décompresser ; ouvrir le dossier `cours4/{td}/` dans VS Code ; ouvrir un terminal Git Bash.",
           "l'explorateur de VS Code montre `depart/` et `travail/` ; `pwd` se termine par `cours4/{td}`."),
    "A2": ("une fois par poste, rendre `conda` disponible dans Git Bash (`source …` puis `conda init bash`) ; dans `depart/` : `conda env create -f environment.yml`.",
           "l'invite commence par `(base)` ; `conda env list` affiche `animation`."),
    "A3": ("`conda activate animation`, puis `magick -version` et `ffmpeg -version`.",
           "la première ligne de l'invite est `(animation)` ; les deux versions s'affichent."),
    "A4": ("copier le notebook dans `travail/`, puis `cd travail` et `jupyter lab` ; exécuter le notebook section par section.",
           "section 1 : trois chemins dans `envs\\animation` ; section 6 : la vidéo."),
    "B0": ("dans un second terminal Git Bash, `conda activate animation` ; créer `travail/{p}/` avec `environment.yml`{copie}, un `.gitignore` et un README d'une ligne ; `git init`, puis un premier commit.",
           "`git log --oneline` affiche une ligne."),
    "B1": ("sur une branche `une-image` : les fonctions de dessin, puis `main` et les options, un commit chacun ; fusion dans `master`.",
           "`{b1_cmd}` écrit `{b1_fichier}` ; trois commits."),
    "B2": ("sur une branche `serie` : {b2_commit1}, puis l'option `{serie_option}`, un commit chacun ; fusion dans `master`.",
           "une image par {serie_unite} dans `sortie/images/` ; cinq commits."),
    "B3": ("sur une branche `video` : `assembler` et les options `--video` et `--cadence` ; un commit sur `master` (le README) ; l'option `--nettoyer` ; fusion avec `git merge --no-edit video`.",
           "`sortie/{p}.mp4` ; `git log --graph` dessine les deux branches et le commit de fusion ; neuf commits."),
    "B4": ("remplacer le README par le modèle et le compléter ; un commit.",
           "dix commits."),
    "B5": ("`git mv {p}.py src/{p}.py` ; `pyproject.toml` ; `pip install -e .` ; un commit.",
           "la commande `{p}` fonctionne depuis n'importe quel dossier ; onze commits."),
}


def inserer_resumes(texte, t):
    """Un encadré en tête de chaque étape : ce qu'il faut faire, ce qu'il faut obtenir."""
    copie = t["copie"]
    lignes = texte.splitlines(keepends=True)
    sortie = []
    for ligne in lignes:
        sortie.append(ligne)
        for cle, (faire, obtenir) in RESUMES.items():
            if ligne.startswith("## " + cle + " "):
                valeurs = dict(t, copie=copie)
                f = faire.format_map(valeurs)
                o = obtenir.format_map(valeurs)
                sortie.append("\n> **À faire :** " + f + "\n>\n> **À obtenir :** " + o + "\n")
    return "".join(sortie)


def lier(texte):
    """Remplace les liens `#@A1` par l'identifiant que pandoc donne au titre de l'étape."""
    import json
    import subprocess
    arbre = json.loads(subprocess.run(["pandoc", "-f", "markdown", "-t", "json"], input=texte,
                                      capture_output=True, text=True, check=True).stdout)
    ids = {}
    for bloc in arbre["blocks"]:
        if bloc["t"] == "Header" and bloc["c"][0] == 2:
            ident = bloc["c"][1][0]
            mots = [x["c"] for x in bloc["c"][2] if x["t"] == "Str"]
            if mots:
                cle = "ANNEXE" if mots[0] == "Annexe" else mots[0]
                ids[cle] = ident
    for cle, ident in ids.items():
        texte = texte.replace("(#@" + cle + ")", "(#" + ident + ")")
    assert "#@" not in texte, [l for l in texte.splitlines() if "#@" in l]
    return texte


for t in TDS:
    cible = DEPOT / "src" / "cours4" / "notebook" / "td" / t["td"] / "guide.md"
    cible.write_text(guide(t), encoding="utf-8")
    print("ok", cible)
