"""Écrit les guides détaillés des TD 4a, 4b et 4c, sur un même plan, avec le code des corrigés.

Les trois guides sont produits par ce script à partir d'un même texte : celui
du TD 4c, `src/cours4/notebook/td/4c_train/guide.md`, et ceux de la montre et
du tourbillon, gardés comme propositions depuis le 26/09/2026 dans
`src/cours4/notebook/propositions/<td>/guide.md`. Leurs étapes restent
identiques ; seuls le nom du programme, les données, les fonctions et les
options changent. Le
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


METHODE_TRAIN = """## La méthode

Cette section décrit comment le programme fabrique une image de la vidéo,
puis la vidéo, et dans quel ordre la partie B le construit. La section 1 du
notebook reprend les mêmes schémas.

### Composer une image

Chaque image de la vidéo mesure 640 × 480 pixels. Elle est composée de trois
images du décor, posées l'une sur l'autre : le fond, puis le plan, puis la
fenêtre. Le fond contient le ciel, les nuages et la mer ; la fenêtre, un
cadre noir et une vitre transparente. Les deux sont les mêmes sur toutes les
images : seul le plan change d'une image à la suivante. Le damier des
schémas marque les pixels transparents, qui laissent voir l'image placée
dessous.

![Le plan posé sur le fond, puis la fenêtre posée par-dessus](illustrations/composition.png)

### Découper le plan dans une bande

Le plan contient les voiles et la plage. Il est dessiné sur une bande de
1 920 × 480 pixels, trois fois plus large qu'une image de la vidéo. Le plan
d'une image est un rectangle de 640 × 480 pixels découpé dans la bande. On
appelle ce rectangle l'emprise. Le décalage est le numéro de la colonne de la
bande où commence l'emprise.

![La bande du plan et l'emprise à la colonne 400](illustrations/emprise.png)

D'une image de la vidéo à la suivante, le décalage augmente de 8 pixels :
l'emprise avance de 8 colonnes vers la droite dans la bande, et les voiles et
la plage se déplacent de 8 pixels vers la gauche dans l'image.

### Faire tourner la bande

L'emprise dépasse le bord droit de la bande dès que le décalage dépasse
1 920 − 640 = 1 280. Avec un décalage de 1 500, le découpage ne garde que les
420 colonnes qui restent dans la bande.

La bande est dessinée pour que son bord droit se raccorde à son bord gauche :
placée après la colonne 1 919, la colonne 0 continue le dessin. Enroulée sur
un cylindre, comme les décors du clip posés sur une table tournante, la
bande n'a plus de bord.

![La bande enroulée sur un cylindre](illustrations/cylindre.png)

Le programme fait tourner la bande comme le cylindre. Pour un décalage de
1 500, il déplace la bande de 1 500 colonnes vers la gauche ; les colonnes
qui sortent à gauche reviennent à droite. L'emprise est ensuite découpée à
partir de la colonne 0, et ne dépasse plus.

![Découper l'emprise à la colonne 1 500, puis faire tourner la bande avant de découper](illustrations/debordement.png)

Pour un décalage inférieur à 1 280, faire tourner la bande puis découper à la
colonne 0 donne le même plan que découper à la colonne du décalage. Un
décalage plus grand que la bande fait plus d'un tour : 2 120 donne le même
plan que 200, car 2 120 = 1 920 + 200.

### L'algorithme

Le programme final, `train.py`, fait les opérations suivantes :

1. lire les options : le nombre d'images, la cadence de la vidéo, le dossier
   du décor ;
2. calculer le décalage de chaque image : 0, 8, 16… ;
3. pour chaque décalage, construire la commande `magick` morceau par
   morceau, puis la lancer :
   - le fond ;
   - le plan : faire tourner la bande, découper l'emprise, puis poser le
     plan sur le fond (`-composite`) ;
   - la fenêtre, posée en dernier (`-composite`) ;
   - le nom du fichier à écrire ;
4. assembler les images en une vidéo avec ffmpeg.

Chaque morceau de la commande est une liste d'arguments, renvoyée par une
fonction : `arguments_fond`, `arguments_plan`, `arguments_fenetre`. La
fonction `image` ajoute ces listes l'une après l'autre avec `+`. L'ordre des
morceaux est l'ordre dans lequel `magick` pose les images.

### Construire le programme étape par étape

La partie B construit `train.py` dans l'ordre de la composition : une étape
ajoute une seule fonctionnalité, et se vérifie avant le commit, en ouvrant
l'image écrite et en lisant sa taille.

- B1, le fond : le programme écrit une image qui ne contient que le fond, et
  affiche sa taille, `640x480`.
- B2, la fenêtre : la fenêtre posée sur le fond, sur une branche `fenetre`.
- B3, le plan : le plan posé sur le fond, puis l'option `--decalage`, puis la
  bande qu'on fait tourner, sur une branche `plan`.
- B4, la fusion des deux branches : l'image complète.
- B5 et B6 : la série d'images, puis la vidéo.

La fenêtre et le plan ne dépendent pas l'un de l'autre : ils se développent
sur deux branches parties du même commit, celui du fond, puis se réunissent
par une fusion. Les deux branches modifient la fonction `image` au même
endroit : la fusion s'arrête sur un conflit, que l'étape B4 fait résoudre.

"""


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
        "sections_b1": "2 à 5", "section_outils": "1", "section_video": "6",
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
        "sections_b1": "2 à 4 (avec la fonction `texte_angle` de la section 5)", "section_outils": "1", "section_video": "6",
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
        "sections_b1": "3 à 7", "section_outils": "2", "section_video": "9",
        "schema_notebook": "dans la section 2 du notebook",
        "sections_b2": "la fonction `decalages` de la section 8 et la première cellule de la section 9",
        "verif_images": "la section 1 décrit la composition d'une image, sans code ; les sections 3 à 7 affichent chacune une étape de la composition et la taille de l'image obtenue",
        "composition": """
Chaque image de la vidéo superpose trois images du décor : le fond, le plan,
découpé dans une bande plus large que l'image, et la fenêtre. La section « La
méthode », après le tableau des étapes, décrit comment le programme compose
une image, puis la vidéo, avec des schémas.
""",
        "methode": METHODE_TRAIN,
        "b1_dessin_explication": """
Chaque fonction `arguments_…` renvoie le morceau de la commande `magick`
qui correspond à une étape de la composition : lire le fond ; lire le plan,
faire tourner la bande et découper l'emprise ; lire la fenêtre. La fonction
`image` ajoute ces morceaux l'un après l'autre, avec un `-composite` après le
plan et après la fenêtre, puis lance la commande.
""",
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


TABLEAU_B = """| [B0](#@B0) | créer le dossier du projet et le dépôt git | 1 |
| [B1](#@B1) | une image, sur la branche `une-image` | 3 |
| [B2](#@B2) | une série d'images, sur la branche `serie` | 5 |
| [B3](#@B3) | la vidéo, sur la branche `video`, et un commit sur `master` | 9 |
| [B4](#@B4) | le README complet | 10 |
| [B5](#@B5) (facultatif) | `src/`, `pyproject.toml`, une commande installée | 11 |"""


def guide(t):
    p = t["p"]
    if "partie_b" in t:
        # Le TD 4c a sa propre partie B : le texte commun ne sert que jusqu'à
        # la partie A, et les morceaux des autres TD ne s'y appliquent pas.
        pieces = {c: "def main():\n" for c in ("main-b1", "main-b2", "main-b3-video", "main-b3")}
    else:
        pieces = corriges.PIECES[p]
    entete = pieces.get("doc", "") + "\n" + pieces.get("imports", "") + pieces.get("outils", corriges.OUTILS)
    dessin = pieces.get("dessin", "")
    main_b1 = pieces.get("options", "") + pieces["main-b1"] + corriges.APPEL
    serie = pieces.get("serie", "")
    main_b2 = sans_titre(pieces["main-b2"])
    assembler = pieces.get("assembler", corriges.ASSEMBLER)
    main_b3v = sans_titre(pieces["main-b3-video"])
    nettoyer = pieces.get("nettoyer", "")
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

Le TD fabrique une courte vidéo : {t['objet']}. Le rendu est un projet
Python, versionné avec git, qui contient un script `{p}.py` appelable en
ligne de commande.
{t.get('composition', '')}
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
vidéo produite. Il est aussi {t.get('schema_notebook', 'en tête du notebook')}.

![Les étapes du script {p}.py]({t['schema']})

Le TD a deux parties.

- **Partie A** (environ 35 minutes) : créer un environnement conda qui
  contient ces outils, puis exécuter le notebook `{p}.ipynb` qui fabrique la
  vidéo.
- **Partie B** (environ 70 minutes) : {t.get('resume_b', f"""construire le programme `{p}.py`,
  lancé depuis un terminal, fonctionnalité par fonctionnalité : une image,
  une série d'images, la vidéo. Chaque fonctionnalité est développée sur une
  branche git, puis fusionnée.""")}

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
{t.get('tableau_b', TABLEAU_B)}

{t.get('methode', '')}## Rappels

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
- {t.get('verif_images', "chaque section affiche une image d'essai")} ;
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
{t.get('b1_dessin_explication', '')}
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
    if "partie_b" in t:
        texte = texte[:texte.index("\n# Partie B")] + "\n" + t["partie_b"](t) + ANNEXE
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
           "section {section_outils} : trois chemins dans `envs\\animation` ; section {section_video} : la vidéo."),
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
        for cle, (faire, obtenir) in t.get("resumes", RESUMES).items():
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
                cle = mots[0]
                if cle == "Annexe":
                    cle = "PLANS" if "Plusieurs" in mots else "ANNEXE"
                ids[cle] = ident
    for cle, ident in ids.items():
        texte = texte.replace("(#@" + cle + ")", "(#" + ident + ")")
    assert "#@" not in texte, [l for l in texte.splitlines() if "#@" in l]
    return texte


# ---- TD 4c : la partie B, par étapes de la composition ------------------------
#
# Le TD 4c ne suit plus le plan commun des TD 4a et 4b : l'image se construit
# par étapes de la composition, le fond sur `master`, puis la fenêtre et le
# plan sur deux branches parties du même commit, réunies par une fusion qui
# s'arrête sur un conflit. Le code vient de `generer_corriges.py`
# (`version_train`, `F`) ; le conflit montré est celui que `rejouer_train`
# obtient en refaisant l'historique avec git.

TABLEAU_B_TRAIN = """| [B0](#@B0) | créer le dossier du projet et le dépôt git | 1 |
| [B1](#@B1) | le fond, sur `master` | 2 |
| [B2](#@B2) | la fenêtre, sur la branche `fenetre` | 3 |
| [B3](#@B3) | le plan, sur la branche `plan` | 6 |
| [B4](#@B4) | réunir les deux branches : un conflit à résoudre | 7 |
| [B5](#@B5) | une série d'images, sur la branche `serie` | 9 |
| [B6](#@B6) | la vidéo, sur la branche `video` | 11 |
| [B7](#@B7) | le README complet | 12 |
| [B8](#@B8) (facultatif) | `src/`, `pyproject.toml`, une commande installée | 13 |
| [Annexe](#@PLANS) | plusieurs plans, plusieurs vitesses | |"""

RESUME_B_TRAIN = """construire le programme `train.py`,
  lancé depuis un terminal, en suivant les étapes de la composition : le
  fond, puis la fenêtre et le plan sur deux branches git réunies par une
  fusion, puis la série d'images et la vidéo."""

RESUMES_TRAIN = dict(RESUMES)
RESUMES_TRAIN.update({
    "B1": ("créer `train.py` : les fonctions `arguments_fond`, `image` et `taille`, puis `main` ; un commit sur `master`.",
           "`python train.py` écrit `sortie/train.png`, le fond seul, et affiche `640x480` ; deux commits."),
    "B2": ("sur une branche `fenetre` : la fonction `arguments_fenetre` et une ligne dans `image` ; un commit.",
           "`sortie/train.png` montre la fenêtre posée sur le fond ; trois commits."),
    "B3": ("depuis `master`, une branche `plan` : le plan posé sur le fond, l'option `--decalage`, puis la bande qu'on fait tourner ; un commit chacun.",
           "`python train.py --decalage 1500` écrit une image où la plage traverse toute l'image ; six commits."),
    "B4": ("`git merge fenetre`, puis `git merge plan` ; résoudre le conflit dans `train.py` ; `git add`, puis `git commit --no-edit`.",
           "`python train.py --decalage 200` écrit l'image complète ; un commit de fusion ; sept commits."),
    "B5": ("sur une branche `serie` : les fonctions `decalages` et `serie`, puis l'option `--images`, un commit chacun ; fusion dans `master`.",
           "une image par décalage dans `sortie/images/` ; neuf commits."),
    "B6": ("sur une branche `video` : `assembler` et les options `--video` et `--cadence`, puis l'option `--nettoyer`, un commit chacun ; fusion dans `master`.",
           "`sortie/train.mp4` ; onze commits."),
    "B7": ("remplacer le README par le modèle et le compléter ; un commit.",
           "douze commits."),
    "B8": ("`git mv train.py src/train.py` ; `pyproject.toml` ; `pip install -e .` ; un commit.",
           "la commande `train` fonctionne depuis n'importe quel dossier ; treize commits."),
})


def _entre(texte, debut, fin):
    """Les lignes de `texte` de la ligne qui commence par `debut` à celle qui commence par `fin`, incluses."""
    lignes = texte.splitlines()
    i = next(n for n, ligne in enumerate(lignes) if ligne.startswith(debut))
    j = next(n for n, ligne in enumerate(lignes) if n > i and ligne.startswith(fin))
    return "\n".join(lignes[i:j + 1])


def partie_b_train(t):
    F = corriges.F
    entete = F["doc"] + "\n" + F["imports"] + F["outils"]
    fonctions_b1 = F["titre-image"] + F["fond"] + corriges.image_train(False, []) + F["taille"]
    main_b1 = F["main-fond"] + corriges.APPEL
    image_b2 = corriges.image_train(False, [corriges.LIGNE_FENETRE])
    image_b3 = corriges.image_train(False, [corriges.LIGNE_PLAN_0])
    image_b3_decalage = corriges.image_train(True, [corriges.LIGNE_PLAN])
    conflit = _entre(corriges.rejouer_train(), "<<<<<<<", ">>>>>>>")
    resolution = _entre(corriges.version_train("b4"), "def arguments_plan", corriges.LIGNE_FENETRE.rstrip())
    return f"""# Partie B · Du notebook au programme

La partie B construit le programme `train.py` en suivant les étapes de la
composition d'une image (section 1 du notebook), puis la série d'images et
la vidéo :

1. **le fond** (B1), sur `master` : `python train.py` écrit
   `sortie/train.png`, qui ne contient que le fond ;
2. **la fenêtre** (B2), sur la branche `fenetre` : la fenêtre posée sur le
   fond ;
3. **le plan** (B3), sur la branche `plan`, partie du même commit que
   `fenetre` : le plan posé sur le fond, l'option `--decalage`, puis la bande
   qu'on fait tourner ;
4. **la fusion** (B4) : les deux branches sont réunies dans `master`. Elles
   ont modifié toutes les deux la fonction `image` au même endroit : la
   fusion s'arrête sur un conflit, à résoudre comme au TD 4c du cours 2 ;
5. **une série d'images** (B5), sur la branche `serie` ;
6. **la vidéo** (B6), sur la branche `video`.

Les branches `fenetre` et `plan` développent deux fonctionnalités
indépendantes à partir du même commit, comme deux personnes qui travaillent
en même temps sur le même programme. Le programme a une fonction `main` et
lit ses options avec `argparse` dès la première étape (cours 3). Chaque étape
reprend une section du notebook.

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
versionnés. Le README, d'une ligne pour l'instant, sera complété à l'étape
B7.

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
├── decor/               (les images du décor)
└── environment.yml
```

## B1 · Le fond, sur `master`

**Entrée** : la section 3 du notebook. **Sortie** : `python train.py` écrit
`sortie/train.png`, qui ne contient que le fond, et affiche sa taille.

Le fond est la base commune des deux branches des étapes B2 et B3 : il est
écrit directement sur `master`, en un commit.

### B1.1 L'en-tête du fichier

Créer le fichier `train.py` dans `travail/train/` (explorateur de VS Code :
clic droit sur le dossier `train` → Nouveau fichier). Y coller la
description, les imports, les programmes et les chemins :

{fence(entete)}

### B1.2 Les fonctions de l'image

Dessous, coller les trois fonctions de la section 3 du notebook :

{fence(fonctions_b1)}

`arguments_fond` renvoie le premier morceau de la commande `magick` : le
chemin du fond. `image` construit la commande morceau par morceau et la
lance ; pour l'instant, elle ne contient que le fond et le fichier à écrire.
`taille` renvoie la largeur et la hauteur d'une image, écrites par `magick
identify`.

### B1.3 La fonction `main`

À la fin du fichier, coller :

{fence(main_b1)}

L'option `--decor` donne le dossier des images du décor ; sa valeur par
défaut, `decor`, est le dossier copié à l'étape B0. Si ce dossier ne contient
pas `fond.png`, `analyseur.error` affiche un message et arrête le programme.

Enregistrer (`Ctrl+S`). **Vérifications** :

{tableau_verifs([
        ("python train.py", "`…/sortie/train.png 640x480` ; ouvrir l'image par un double-clic : le ciel, les nuages et la mer"),
        ("python train.py --decor absent", "`error: décor introuvable : absent`"),
        ("python train.py --help", "l'aide du programme et l'option `--decor`"),
    ])}

```text
git add train.py
git commit -m "Le fond : une image de 640 × 480 pixels"
git log --oneline
```

**Vérification** : deux lignes.

## B2 · La fenêtre, sur la branche `fenetre`

**Entrée** : la section 7 du notebook, sans le plan. **Sortie** :
`python train.py` écrit la fenêtre posée sur le fond.

```text
git checkout -b fenetre
git branch
```

**Vérification** : `git branch` affiche `* fenetre` et `master` ; l'étoile
marque la branche courante.

Dans `train.py`, entre la fonction `arguments_fond` et la fonction `image`,
coller :

{fence(F["fenetre"])}

Puis, dans la fonction `image`, ajouter la ligne de la fenêtre sous la ligne
qui lit le fond. La fonction devient :

{fence(image_b2)}

`-composite` pose la dernière image lue, la fenêtre, sur l'image lue avant
elle, le fond : les pixels transparents de la vitre laissent voir le fond.

Enregistrer. **Vérification** : `python train.py` affiche
`…/sortie/train.png 640x480` ; l'image montre le fond derrière la vitre, et
le cadre noir autour.

```text
git commit -am "Fenêtre : la fenêtre posée sur le fond"
```

## B3 · Le plan, sur la branche `plan`

**Entrée** : les sections 4 à 6 du notebook. **Sortie** :
`python train.py --decalage 200` écrit le plan décalé de 200 pixels, posé
sur le fond, dans `sortie/train_0200.png`.

### B3.1 Une branche partie de `master`

La branche `plan` part du même commit que `fenetre` : revenir d'abord sur
`master`.

```text
git checkout master
git checkout -b plan
```

**Vérification** : dans VS Code, `train.py` n'a plus la fonction
`arguments_fenetre` : le fichier est revenu à l'état du commit de l'étape B1.
Le travail de l'étape B2 est enregistré sur la branche `fenetre`.

### B3.2 Le plan posé sur le fond

Entre la fonction `arguments_fond` et la fonction `image`, coller la
fonction qui découpe l'emprise à la colonne 0 (sections 4 et 6 du notebook) :

{fence(F["plan-b3-plan"])}

Puis ajouter la ligne du plan dans `image` :

{fence(image_b3)}

Enregistrer. **Vérification** : `python train.py` écrit une image où les
voiles et la plage sont posées sur le fond.

```text
git commit -am "Plan : le plan posé sur le fond"
```

### B3.3 L'option `--decalage`

Le décalage est la colonne de la bande où commence l'emprise (section « La
méthode », schéma de l'emprise). `-crop 640x480+400+0` découpe l'emprise à la
colonne 400. Remplacer la fonction `arguments_plan` par :

{fence(F["plan-b3-decalage"])}

puis la fonction `image`, qui reçoit maintenant le décalage, par :

{fence(image_b3_decalage)}

puis toute la fonction `main`, de `def main():` jusqu'à la ligne vide qui
précède `if __name__`, par :

{fence(sans_titre(F["main-decalage"]))}

Le nom du fichier écrit contient le décalage, sur quatre chiffres : deux
décalages donnent deux fichiers, que l'on peut comparer.

Enregistrer. **Vérifications** :

{tableau_verifs([
        ("python train.py --decalage 400", "`…/sortie/train_0400.png 640x480` : les voiles et la plage se sont déplacées vers la gauche"),
        ("python train.py --decalage 1500", "`…/sortie/train_1500.png 640x480` : la plage s'arrête à 420 pixels du bord gauche, le reste de l'image ne montre que le fond"),
    ])}

À 1 500, l'emprise dépasse la bande (notebook, section 1.3) : le découpage
ne garde que 420 × 480 pixels, que `-composite` pose en haut à gauche du
fond.

![Le plan à 1 500 : découpé seul, puis la bande tournée avant le découpage](illustrations/decoupe_1500.png)

```text
git commit -am "Plan : l'option --decalage"
```

### B3.4 Faire tourner la bande

La bande se raccorde d'un bord à l'autre : le programme la fait tourner
avant de découper l'emprise (section « La méthode », schémas du cylindre et
de la rotation). Remplacer la fonction `arguments_plan` par la version de la
section 5 du notebook :

{fence(F["plan"])}

`-roll -1500+0` fait tourner la bande de 1 500 colonnes vers la gauche ;
`-crop 640x480+0+0` découpe ensuite l'emprise à partir de la colonne 0, qui
ne dépasse plus.

Enregistrer. **Vérifications** :

{tableau_verifs([
        ("python train.py --decalage 1500", "la plage traverse toute l'image (image de droite du schéma ci-dessus)"),
        ("python train.py --decalage 200", "`sortie/train_0200.png`"),
        ("python train.py --decalage 2120", "`sortie/train_2120.png`, identique à `train_0200.png` : 2 120 = 1 920 + 200"),
    ])}

```text
git commit -am "Plan : faire tourner la bande"
git log --oneline --graph --all
```

**Vérification** : le graphe dessine deux branches parties du commit de
l'étape B1 : `fenetre`, un commit, et `plan`, trois commits.

## B4 · Réunir les deux branches : un conflit

**Sortie** : sur `master`, `python train.py --decalage 200` écrit l'image
complète : le fond, le plan, puis la fenêtre.

![Les branches fenetre et plan, avant et après leur fusion](illustrations/branches.png)

### B4.1 Fusionner `fenetre`

```text
git checkout master
git merge fenetre
```

**Vérification** : git affiche `Fast-forward` : `master` n'a pas avancé
depuis la création de `fenetre`, git déplace `master` sur le commit de la
fenêtre.

### B4.2 Fusionner `plan` : le conflit

```text
git merge plan
```

**Vérification** : git affiche
`CONFLICT (content): Merge conflict in train.py`, puis
`Automatic merge failed; fix conflicts and then commit the result.` La
fusion est en cours : `git status` liste `train.py` sous « Unmerged paths »
(« Chemins non fusionnés »).

Depuis le commit de l'étape B1, les deux branches ont modifié `train.py` au
même endroit : chacune a ajouté une fonction sous `arguments_fond`, et une
ligne sous la ligne qui lit le fond ; la branche `plan` a aussi ajouté le
paramètre `decalage` à `image`. Git réunit seul les modifications qui portent
sur des lignes différentes, comme celles de `main` ; ici, il ne peut pas
choisir, et il écrit les deux versions dans le fichier.

Ouvrir `train.py` dans VS Code. Sous la fonction `arguments_fond`, le fichier
contient :

{fence(conflit)}

Entre `<<<<<<< HEAD` et `=======` : la version de `master`, qui vient de
`fenetre` ; entre `=======` et `>>>>>>> plan` : la version de `plan`.

### B4.3 Résoudre : écrire une version qui réunit les deux

L'image complète demande les deux fonctions, le paramètre `decalage` et
les deux lignes : la version qui réunit les deux s'écrit à la main. Remplacer
toutes les lignes, de `<<<<<<< HEAD` jusqu'à `>>>>>>> plan` compris, par :

{fence(resolution)}

La ligne du plan vient avant celle de la fenêtre : `magick` pose les images
dans l'ordre de la commande, et la fenêtre doit être posée en dernier. Les
liens Accept Both Changes (« Accepter les deux modifications ») de VS Code
garderaient les deux versions l'une après l'autre : deux fonctions `image`,
et la fenêtre avant le plan.

Enregistrer, puis vérifier qu'il ne reste aucun marqueur et que le programme
écrit l'image complète :

```text
grep -n "<<<<<<<\\|=======\\|>>>>>>>" train.py
python train.py --decalage 200
```

**Vérification** : `grep` n'affiche rien ; `sortie/train_0200.png` montre le
fond, le plan, puis la fenêtre : le cadre noir cache les bords du plan. Si
la plage passe sur le cadre, les deux lignes sont dans le mauvais ordre.

![L'ordre des lignes dans image : le plan, puis la fenêtre](illustrations/ordre_composition.png)

### B4.4 Terminer la fusion

```text
git add train.py
git commit --no-edit
git log --oneline --graph --all
```

`git add` marque le conflit comme résolu. `git commit --no-edit` crée le
commit de fusion avec le message proposé par git, `Merge branch 'plan'`.
Tant que la fusion n'est pas terminée, `git merge --abort` remet `master`
dans l'état d'avant `git merge plan`.

**Vérification** : le graphe dessine le commit de fusion, qui a deux
parents ; `git log --oneline` affiche sept lignes.

## B5 · Une série d'images, sur la branche `serie`

**Entrée** : la fonction `decalages` de la section 8 et la première cellule
de la section 9 du notebook. **Sortie** : `python train.py --images 120`
écrit une image par décalage dans `sortie/images/`.

```text
git checkout -b serie
```

### B5.1 Les fonctions `decalages` et `serie`

Dans `train.py`, entre la fonction `taille` et la ligne
`# ---- Le programme`, coller :

{fence(F["serie"])}

Enregistrer. **Vérification** : `python train.py --help` fonctionne comme
avant : les nouvelles fonctions ne sont pas encore appelées.

```text
git commit -am "Série : les fonctions decalages et serie"
```

### B5.2 L'option `--images` dans `main`

Remplacer toute la fonction `main` par :

{fence(sans_titre(F["main-serie"]))}

La nouvelle option n'a pas de valeur par défaut : sans elle,
`options.images` vaut `None`, et le programme écrit une image seule, comme
en B4. Avec elle, il écrit la série.

Enregistrer. **Vérifications** :

{tableau_verifs([
        ("python train.py --images 24", "`24 images dans …/sortie/images`"),
        ("python train.py --decalage 100", "une image seule, comme en B4"),
        ("python train.py --help", "l'option `--images` en plus"),
    ])}

```text
git commit -am "Série : l'option --images"
git checkout master
git merge serie
```

**Vérification** : `Fast-forward` ; `git log --oneline` affiche neuf lignes.

## B6 · La vidéo, sur la branche `video`

**Entrée** : la seconde cellule de la section 9 du notebook (ffmpeg).
**Sortie** : `python train.py --images 120 --video` écrit `sortie/train.mp4` ;
avec `--nettoyer`, le dossier `sortie/images/` est ensuite supprimé.

### B6.1 La fonction `assembler`, les options `--video` et `--cadence`

```text
git checkout -b video
```

Dans `train.py`, après la fonction `serie`, coller :

{fence(F["assembler"])}

Puis remplacer la fonction `main` par :

{fence(sans_titre(F["main-video"]))}

`action="store_true"` fait de `--video` une option sans valeur : présente,
elle vaut `True`.

Enregistrer. **Vérifications** :

{tableau_verifs([
        ("python train.py --images 24 --video --cadence 6", "`24 images dans …`, puis `…/sortie/train.mp4 : 24 images à 6 images par seconde`"),
        ("python train.py --video", "`error: --video demande une série : ajouter --images`"),
    ])}

```text
git commit -am "Vidéo : la fonction assembler, les options --video et --cadence"
```

### B6.2 L'option `--nettoyer`

En tête du fichier, ajouter `import shutil` aux imports :

```python
import argparse
import shutil
import subprocess
```

Après la fonction `assembler`, coller :

{fence(F["nettoyer"])}

`shutil.rmtree` supprime un dossier et tout son contenu. Puis remplacer la
fonction `main` par :

{fence(sans_titre(F["main"]))}

Enregistrer. **Vérification** : `python train.py --images 24 --video --nettoyer`
affiche `images intermédiaires supprimées` ; `sortie/` contient la vidéo, et
`sortie/images/` n'existe plus.

```text
git commit -am "Vidéo : l'option --nettoyer"
git checkout master
git merge video
git log --oneline
```

**Vérification** : `Fast-forward` ; onze lignes.

## B7 · Le README complet

Remplacer `README.md` par le modèle `depart/modeles/README.md` :

```text
cp ../../depart/modeles/README.md README.md
```

L'ouvrir dans VS Code et remplacer chaque passage « (À compléter …) » :

- une phrase qui dit ce que fait le programme ;
- comment récupérer le dossier (archive ou `git clone`) ;
- pour chacune des trois fonctionnalités, une image, une série d'images et
  une vidéo, la commande et ce qu'elle écrit dans `sortie/` ;
- votre nom.

**Vérification** : `Ctrl+Maj+V` affiche l'aperçu. Chaque commande du README
fonctionne quand on la colle dans le terminal, depuis `travail/train/`,
l'environnement `animation` actif.

```text
git commit -am "README complet"
git log --oneline
```

**Vérification** : douze lignes, le commit de fusion compris.

**Dossier à la fin de B7** (fin du TD obligatoire) :

```text
travail/train/
├── .git/
├── .gitignore
├── README.md
├── environment.yml
├── train.py
├── decor/               (les images du décor)
└── sortie/              (non versionné)
```

## B8 (facultative) · `src/`, `pyproject.toml` et une commande installée

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

**Vérification** : l'image est écrite dans `travail/sortie/train_0200.png` ;
l'aide s'affiche sans `python`.

**Le commit.** Revenir dans `travail/train/` (`cd train`). Dans le README,
remplacer `python train.py` par `train` et ajouter la ligne d'installation
`pip install -e .`.

```text
git add .
git commit -m "src/ et pyproject.toml : la commande train"
git log --oneline
```

**Vérification** : treize lignes. `pip uninstall train` retire la commande.
{ANNEXE_PLANS}"""


# L'annexe du TD 4c : `verifier_annexe_plans` exécute le code montré.
CODE_PLANS = '''# Les plans, du plus lointain au plus proche : le fichier, et la vitesse en pixels par image
PLANS = [("voiles.png", 2), ("plage_jaune.png", 8), ("plage.png", 16)]


def arguments_plan(decor, nom, decalage):
    """Les arguments de magick qui lisent la bande `nom`, la font tourner de `decalage` colonnes
    vers la gauche, puis en découpent 640 × 480 pixels à partir de la colonne 0."""
    return ["(", str(decor / nom),
            "-roll", "-" + str(decalage) + "+0",
            "-crop", "640x480+0+0", "+repage", ")"]


def image(fichier, decor, numero):
    """L'image numéro `numero` : le fond, chaque plan décalé de numero × sa vitesse, puis la fenêtre."""
    commande = [MAGICK] + arguments_fond(decor)
    for nom, vitesse in PLANS:
        commande = commande + arguments_plan(decor, nom, numero * vitesse) + ["-composite"]
    commande = commande + arguments_fenetre(decor) + ["-composite"]
    commande = commande + [str(fichier)]
    subprocess.run(commande, check=True)
'''

ANNEXE_PLANS = f"""
## Annexe · Plusieurs plans, plusieurs vitesses

Cette annexe ne fait pas partie du TD : elle décrit une suite possible du
programme, sans guide pas à pas.

Dans le clip, les voiles, la plage jaune et la plage orange du premier plan
défilent à des vitesses différentes : plus un plan est proche de la fenêtre,
plus il défile vite. Le ciel, les nuages et la mer ne bougent pas. Le
programme du TD n'a qu'un plan, les voiles et la plage jaune sur la même
bande, qui avancent de 8 pixels par image.

Le dossier `decor/` contient les bandes qu'il faut pour séparer les plans :
`voiles.png`, `plage_jaune.png`, et `plage.png`, la plage orange. Chaque plan
a sa vitesse, en pixels par image. Sur l'image numéro `n`, un plan de vitesse
`v` est décalé de `n × v` pixels. Les plans sont posés du plus lointain au
plus proche, puis la fenêtre.

![Trois plans, trois vitesses : l'image numéro 40](illustrations/plans.png)

La commande `magick` se construit comme dans le TD, avec un morceau par
plan. `arguments_plan` reçoit en plus le nom du fichier de la bande ; `image`
reçoit le numéro de l'image, et ajoute les morceaux dans une boucle :

{fence(CODE_PLANS)}

Le reste du programme change peu. `serie` passe à `image` le numéro de
chaque image, de 0 à `nombre - 1`, à la place du décalage : la fonction
`decalages` n'est plus utile. Pour une image seule, l'option `--decalage`
devient un numéro d'image.

La vitesse de chaque plan se règle en changeant la liste `PLANS`. Un
quatrième plan demande une bande de 1 920 × 480 pixels de plus dans
`decor/`, et une ligne de plus dans la liste. Le TD 7 reprendra ce programme et
lui ajoutera un autre effet : les ombres des poteaux, qui passent devant la
fenêtre.
"""


def verifier_annexe_plans():
    """Exécute le code de l'annexe dans le programme final : une image de 640 × 480 pixels."""
    import subprocess
    import tempfile
    sys.path.insert(0, str(Path(__file__).resolve().parent))
    import make_data
    with tempfile.TemporaryDirectory() as dossier:
        decor = Path(dossier) / "decor"
        make_data.decor_train(decor)
        espace = {"__name__": "annexe"}
        exec(corriges.version_train("b6") + CODE_PLANS, espace)
        espace["image"](Path(dossier) / "plans.png", decor, 40)
        taille = subprocess.run(["magick", "identify", "-format", "%wx%h", str(Path(dossier) / "plans.png")],
                                capture_output=True, text=True, check=True).stdout
        assert taille == "640x480", taille


for _t in TDS:
    if _t["td"] == "4c_train":
        _t.update(partie_b=partie_b_train, resumes=RESUMES_TRAIN, tableau_b=TABLEAU_B_TRAIN, resume_b=RESUME_B_TRAIN,
                  arbre_projet_donnees="├── decor/               (les images du décor)\n",
                  arbre_depart_extra=("│   ├── decor/\n│   │   ├── fond.png\n│   │   ├── plan.png\n│   │   ├── fenetre.png\n"
                                      "│   │   ├── voiles.png\n│   │   ├── plage_jaune.png\n│   │   └── plage.png\n"
                                      "│   ├── CREDITS.md\n"))
verifier_annexe_plans()


for t in TDS:
    rangement = "td" if t["td"] == "4c_train" else "propositions"
    cible = DEPOT / "src" / "cours4" / "notebook" / rangement / t["td"] / "guide.md"
    cible.write_text(guide(t), encoding="utf-8")
    print("ok", cible)
