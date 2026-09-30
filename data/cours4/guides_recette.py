"""Les guides des TD 4a (une recette à l'échelle) et 4b (un programme installable).

Appelé par `generer_recette.py` après l'écriture et la vérification des
corrigés : le code montré vient de `version(etat)`, les blocs de
modifications de `outils/modifications.py`, et les sorties montrées sont
celles des corrigés, exécutés au moment de l'écriture (`executer`).

Écrit `src/cours4/notebook/td/4a_recette/guide.md` et
`src/cours4/notebook/td/4b_paquet/guide.md`.
"""

from __future__ import annotations

import sys

from generer_recette import DEPOT, TD_PAQUET, executer, modifications, quantites, version

sys.path.insert(0, str(DEPOT / "src"))
from _identifiants import identifiant_titre  # noqa: E402

GUIDES = DEPOT / "src" / "cours4" / "notebook" / "td"

ENTETE = """---
title: "{titre}"
subtitle: Guide détaillé, étape par étape
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---
"""


def fence(code, langue="python"):
    return "```" + langue + "\n" + code.strip("\n") + "\n```"


def sortie(etat, *arguments, fichiers=None):
    """La sortie réelle de `python recette.py *arguments` dans l'état `etat`, en bloc de texte."""
    contenu = {"recette.py": version(etat)}
    contenu.update(fichiers or {})
    return fence(executer(contenu, "recette.py", *arguments), "text")


def fichier_b5():
    """Le contenu réel de `sortie/crepes_6_US.csv`, écrit par le programme de l'étape B5."""
    code = ("import pathlib, runpy; runpy.run_path('recette.py'); "
            "print(pathlib.Path('sortie/crepes_6_US.csv').read_text(encoding='utf-8'), end='')")
    texte = executer({"recette.py": version("b5")}, "-c", code)
    return texte.split("crepes_6_US.csv\n", 1)[1]


def encadre(faire, obtenir):
    return "> **À faire :** " + faire + "\n>\n> **À obtenir :** " + obtenir


def lier(texte):
    """Remplace `(#@X)` par l'identifiant du titre de niveau 2 qui commence par `X ·`."""
    for ligne in texte.splitlines():
        if ligne.startswith("## "):
            titre = ligne[3:]
            cle = titre.split(" ·")[0].split(" (")[0]
            texte = texte.replace("(#@" + cle + ")", "(#" + identifiant_titre(titre.replace("`", "")) + ")")
    assert "(#@" not in texte, [l for l in texte.splitlines() if "(#@" in l]
    return texte


RAPPEL_MODIFICATIONS = """**Les lignes à modifier.** Le guide donne le programme en entier une
seule fois, à l'étape B1. Pour les étapes suivantes, il ne donne que les
lignes qui changent, comme dans cet extrait de l'étape B2 :

{exemple}

Une ligne marquée `-` est à supprimer, une ligne marquée `+` est à ajouter.
Les lignes sans signe ne changent pas et indiquent l'endroit de la
modification. Le signe `…` remplace des lignes qui ne changent pas.

Le nombre qui suit le signe est le numéro de la ligne dans VS Code, quand
les modifications sont faites de haut en bas. Une ligne ajoutée n'a pas de
numéro. Si le fichier n'a pas les mêmes lignes vides que le guide, les
numéros diffèrent de quelques lignes, et les lignes sans signe permettent
de retrouver l'endroit.

Une ligne ajoutée se copie sans le `+` ni les cinq espaces qui le suivent.
Pour plusieurs lignes, les coller dans VS Code, sélectionner leurs six
premiers caractères en rectangle (`Maj+Alt` en faisant glisser la souris),
puis appuyer sur `Suppr`."""


# ---- TD 4a ---------------------------------------------------------------------

def guide_4a():
    b1_b2 = modifications(version("b1"), version("b2"))
    lignes = b1_b2.splitlines()
    debut = next(i for i, l in enumerate(lignes) if "# ---- Le programme" in l)
    fin = next(i for i, l in enumerate(lignes) if "PERSONNES = 6" in l)
    exemple = "\n".join(["```diff", *lignes[debut:fin + 1], "```"])
    depart_deux_points = version("depart").replace("in ingredients\n", "in ingredients:\n")
    cookies_si = version("b4").replace('NOM = "crepes"', 'NOM = "cookies"').replace('UNITES = "US"', 'UNITES = "SI"')
    texte = ENTETE.format(titre="TD 4a — Un script Python, pas à pas") + f"""
Ce guide détaille les étapes de la feuille du TD 4a. Pour chaque étape, il
indique le dossier dans lequel se placer, ce qu'il faut écrire ou taper, et
comment vérifier le résultat.

Le TD revoit les opérations des cours 1 à 3 sur un petit programme. La
partie A crée le dossier du projet dans le terminal, l'ouvre dans VS Code
et crée son dépôt git. La partie B écrit le programme `recette.py` étape
par étape : il calcule les quantités d'une recette pour un nombre de
personnes, en unités SI ou en unités américaines. Chaque étape se termine
par un commit.

Le code de ce guide se copie depuis `guide_4a_recette.html`, ouvert dans un
navigateur, ou depuis `guide.ipynb`, ouvert dans JupyterLab. Copié depuis le
PDF, il perd ses indentations.

| Étape | Objectif | Commits à la fin |
|---|---|---|
| [A1](#@A1) | créer le dossier du projet dans le terminal | 0 |
| [A2](#@A2) | ouvrir le projet dans VS Code, avec Git Bash pour terminal | 0 |
| [A3](#@A3) | versionner le programme de départ | 1 |
| [B1](#@B1) | lire un message d'erreur, corriger le programme | 3 |
| [B2](#@B2) | adapter les quantités à un nombre de personnes | 4 |
| [B3](#@B3) | convertir les unités, dans les deux sens | 5 |
| [B4](#@B4) | lire les ingrédients dans un fichier CSV | 6 |
| [B5](#@B5) | écrire le résultat dans un fichier CSV | 7 |
| [B6](#@B6) | lire les valeurs sur la ligne de commande | 8 |
| [B7](#@B7) (bonus) | un README, une étiquette git | 9 |

Le parcours avancé fait ce TD plus vite, puis le TD 4b dans le même dossier.

# Partie A · Le dossier du projet

## A1 · Le dossier du projet, dans le terminal

{encadre("récupérer l'archive de la séance ; ouvrir Git Bash dans `cours4/4a_recette/` ; créer le dossier `travail/recette/` et y copier le programme et les recettes, par des commandes.",
         "`ls travail/recette` affiche `recette.py` et `recettes` ; `ls travail/recette/recettes` affiche les quatre fichiers CSV.")}

### A1.1 Récupérer l'archive

Comme au cours 3 : ouvrir le dossier partagé `formationTemp`, copier
`info01-cours4.zip` sur le Bureau, puis clic droit sur l'archive, Extraire
tout. Dans le dossier proposé, effacer la fin, `\\info01-cours4`, puis
Extraire. Le dossier extrait est `Desktop\\cours4`.

```text
cours4/
├── 4a_recette/
│   ├── depart/
│   │   ├── recette.py           ← le programme de départ
│   │   ├── recettes/            ← quatre recettes, pour 4 personnes
│   │   │   ├── cookies.csv
│   │   │   ├── crepes.csv
│   │   │   ├── mousse_chocolat.csv
│   │   │   └── pate_pizza.csv
│   │   └── modeles/
│   │       └── README.md        ← le modèle de l'étape B7
│   ├── travail/                 (vide)
│   ├── guide_4a_recette.pdf     ← ce guide
│   └── td_4a_recette.pdf        ← la feuille du TD
└── 4b_paquet/                   ← le TD 4b, parcours avancé
```

### A1.2 Ouvrir Git Bash dans le dossier du TD

Dans l'explorateur de fichiers Windows, ouvrir `cours4`, puis clic droit
sur le dossier `4a_recette`, « Afficher d'autres options », « Open Git Bash
here ». Une fenêtre Git Bash s'ouvre dans ce dossier.

À défaut, ouvrir Git Bash depuis le menu Démarrer, puis :

```text
cd ~/Desktop/cours4/4a_recette
```

**Vérification** :

```text
pwd
```

affiche `/c/Users/eleve/Desktop/cours4/4a_recette`. Dans Git Bash, les
chemins s'écrivent avec des `/`, et `C:\\Users` devient `/c/Users`.

### A1.3 Regarder le contenu

```text
ls
ls depart
ls depart/recettes
```

**Vérification** : la première commande liste `depart`, `travail` et les
deux PDF ; la troisième liste les quatre fichiers CSV.

### A1.4 Créer le dossier du projet et y copier les fichiers

Le projet est un dossier à part, dans `travail/` : les fichiers de
`depart/` restent tels qu'ils ont été livrés.

```text
mkdir travail/recette
cp depart/recette.py travail/recette/
mkdir travail/recette/recettes
cp depart/recettes/*.csv travail/recette/recettes/
```

`mkdir` crée un dossier. `cp` copie le fichier nommé en premier dans le
dossier nommé en second. `*.csv` désigne tous les fichiers dont le nom se
termine par `.csv`. Une commande qui réussit n'affiche rien.

**Vérification** :

```text
ls travail/recette
ls travail/recette/recettes
```

La première commande affiche `recette.py` et `recettes`, la seconde les
quatre fichiers CSV. Si `cp` affiche `No such file or directory`, relire le
chemin : la touche `Tab` complète les noms de dossiers et de fichiers.

## A2 · Le projet dans VS Code

{encadre("ouvrir `travail/recette/` dans VS Code ; choisir Git Bash comme terminal ; afficher les espaces et les tabulations.",
         "le terminal de VS Code a une invite qui commence par `(base)` et se termine par `travail/recette` ; les espaces du code apparaissent sous forme de points.")}

### A2.1 Ouvrir le dossier

Lancer VS Code depuis le menu Démarrer. Menu File, Open Folder… : aller dans
le Bureau, puis `cours4`, `4a_recette`, `travail`, cliquer une fois sur
`recette`, et « Sélectionner un dossier ». Si VS Code demande si l'on fait
confiance aux auteurs des fichiers, répondre « Yes, I trust the authors ».

Le dossier ouvert est le projet : l'explorateur, à gauche, montre ses
fichiers, et le terminal s'ouvre dans ce dossier.

### A2.2 Git Bash comme terminal

1. Palette de commandes : `Ctrl` + `Maj` + `P`.
2. Taper `default profile`, puis choisir « Terminal: Select Default
   Profile ».
3. Choisir « Git Bash ».
4. Menu Terminal, New Terminal.

**Vérification** : l'invite du terminal est

```text
(base)
eleve@POSTE MINGW64 ~/Desktop/cours4/4a_recette/travail/recette
$
```

Si l'invite commence par `PS`, le terminal est PowerShell : le fermer
(icône de corbeille), puis en ouvrir un nouveau. S'il n'y a pas de
`(base)`, conda n'est pas encore réglé dans Git Bash sur ce poste. Le
régler une fois, puis fermer le terminal et en ouvrir un nouveau :

```text
source /c/ProgramData/anaconda3/etc/profile.d/conda.sh
conda init bash
```

### A2.3 Afficher les espaces et les tabulations

Réglages : `Ctrl` + `,`. Dans la zone de recherche, taper `render
whitespace`, et choisir `all` pour « Editor: Render Whitespace ».

**Vérification** : ouvrir `recette.py` dans l'explorateur. Chaque espace du
code apparaît comme un point gris, et chaque tabulation comme une flèche.
L'étape B1 s'en sert.

Sur un thème sombre, les points et les flèches se voient mal. Un thème clair
les rend plus visibles : `Ctrl` + `K`, puis `Ctrl` + `T`, et choisir « Light
Modern » (ou « Light+ »). Le même choix se trouve dans le menu File,
Preferences, Theme, Color Theme.

## A3 · Le dépôt git

{encadre("dans le terminal de VS Code : `git init`, votre nom et votre adresse pour ce dépôt, un fichier `.gitignore` qui contient `sortie/`, puis le premier commit.",
         "`git log --oneline` affiche une ligne.")}

```text
git init
git config user.name "Prénom Nom"
git config user.email "prenom.nom@exemple.fr"
```

Le poste est partagé : le nom et l'adresse sont réglés pour ce dépôt
seulement, sans `--global`.

Le programme écrira ses résultats dans un dossier `sortie/`. Ces fichiers
ne sont pas versionnés, puisque le programme les refait :

```text
echo "sortie/" > .gitignore
git status
```

`echo` affiche le texte qui le suit, et `>` écrit cet affichage dans le
fichier `.gitignore`.

**Vérification** : `git status` liste `.gitignore`, `recette.py` et
`recettes/` parmi les fichiers non suivis.

```text
git add .
git commit -m "Le programme de départ et les recettes"
git log --oneline
```

**Vérification** : `git log --oneline` affiche une ligne.

# Partie B · Le programme

Le programme se lance dans le terminal de VS Code, dans
`travail/recette/` : `python recette.py`. Chaque étape modifie
`recette.py`, le relance, puis enregistre l'état du fichier par un commit.

{RAPPEL_MODIFICATIONS.format(exemple=exemple)}

**Si une étape échoue.** `git status` montre les fichiers modifiés depuis
le dernier commit. `git diff` montre les lignes modifiées (`q` pour
quitter). `git restore recette.py` remet le fichier dans l'état du dernier
commit.

## B1 · Corriger le programme de départ

{encadre("lancer `python recette.py`, lire le message d'erreur, corriger la ligne qu'il désigne, puis un commit ; recommencer jusqu'à ce que le programme affiche la recette.",
         "la recette des crêpes pour 4 personnes s'affiche ; un commit par erreur corrigée.")}

Le programme de départ a trois parties : les données (la recette des crêpes
écrite dans une liste), les fonctions, puis le programme, qui appelle les
fonctions. Chaque ingrédient est un tuple de trois valeurs : le nom, la
quantité et l'unité.

{fence(version("depart"))}

Lancer le programme :

```text
python recette.py
```

Python s'arrête sur une erreur :

{sortie("depart")}

Le message donne le fichier et le numéro de la ligne, recopie la ligne,
puis nomme l'erreur. `SyntaxError: expected ':'` signale un deux-points
manquant : une ligne `for` se termine par `:`. Corriger la ligne 20 et
enregistrer (`Ctrl` + `S`). Chaque correction a son commit :

```text
git diff
git commit -am "Correction : le deux-points de la boucle"
```

`git diff` montre la ligne corrigée, en rouge avant et en vert après. `-a`
ajoute au commit les fichiers déjà suivis et modifiés.

Relancer le programme. Python s'arrête sur une seconde erreur :

{sortie("depart", fichiers={"recette.py": depart_deux_points})}

`TabError` signale un mélange d'espaces et de tabulations dans
l'indentation d'un même bloc. Avec le réglage de l'étape A2, la ligne 21
commence par une flèche (une tabulation), et les autres lignes par des
points (des espaces). Effacer la flèche et la remplacer par huit espaces.

**Vérification** : `python recette.py` affiche

{sortie("b1")}

La barre d'état de VS Code, en bas à droite, indique `Spaces: 4` : la
touche `Tab` insère quatre espaces dans ce fichier.

```text
git diff
git commit -am "Correction : l'indentation de la ligne 21"
git log --oneline
```

**Vérification** : `git log --oneline` affiche trois lignes, une par
commit.

## B2 · Multiplier les quantités

{encadre("écrire la fonction `adapter`, qui reçoit le nombre de personnes de la recette et le nombre voulu, et renvoie les ingrédients pour ce nombre ; l'appeler pour 6 personnes ; un commit.",
         "`python recette.py` affiche la recette pour 6 personnes, avec `Farine : 375.0 g` ; un commit.")}

La recette est écrite pour 4 personnes (`PERSONNES_RECETTE`). Pour
6 personnes, chaque quantité est multipliée par 6 / 4 = 1,5. La fonction
`adapter` reçoit les deux nombres de personnes, celui de la recette et celui
voulu, et calcule ce facteur.

Elle parcourt ensuite la liste des ingrédients avec une boucle `for`, comme
`afficher`. Elle construit une nouvelle liste, `resultat`, un ingrédient à
la fois, avec `append`, et la renvoie.

{b1_b2}

**Vérification** : `python recette.py` affiche

{sortie("b2")}

Avec `PERSONNES = 4`, les quantités sont celles de départ ; avec
`PERSONNES = 2`, elles sont divisées par deux. Remettre `PERSONNES = 6`
avant le commit.

```text
git commit -am "Les quantités pour un nombre de personnes"
```

## B3 · Convertir les unités

{encadre("écrire les deux tables de conversion et la fonction `convertir` ; convertir la recette en unités américaines ; un commit.",
         "`Farine : 13.2 oz` et `Lait : 3.2 cup` ; les œufs gardent leur quantité ; un commit.")}

Une recette américaine donne les masses en onces (`oz`) et les volumes en
tasses (`cup`) : 1 oz = 28,3495 g et 1 cup = 236,588 ml. Deux dictionnaires
donnent, pour chaque unité, l'unité de l'autre système et le nombre par
lequel multiplier la quantité. `VERS_US["g"]` vaut `("oz", 1 / 28.3495)`.

La fonction `convertir` reçoit l'une des deux tables. Une unité absente de
la table, comme l'unité vide des œufs, ne change pas.

{modifications(version("b2"), version("b3"))}

**Vérification** : `python recette.py` affiche

{sortie("b3")}

Avec `UNITES = "SI"`, les quantités sont celles de l'étape B2 : la recette
est déjà en grammes et en millilitres, et `VERS_SI` ne contient ni `g` ni
`ml`. La conversion des unités américaines vers le SI sert à l'étape B4,
avec la recette des cookies. Remettre `UNITES = "US"` avant le commit.

```text
git commit -am "La conversion des unités"
```

## B4 · Lire les ingrédients dans un fichier CSV

{encadre("écrire la fonction `lire_ingredients`, qui lit un fichier de `recettes/` ; supprimer la liste initiale des ingrédients, `INGREDIENTS` ; un commit.",
         "la même sortie qu'à l'étape B3, lue dans `recettes/crepes.csv` ; `NOM = \"cookies\"` et `UNITES = \"SI\"` donnent des grammes et des millilitres ; un commit.")}

Ouvrir `recettes/crepes.csv` dans VS Code :

{fence((TD_PAQUET.parent / "4a_recette" / "depart" / "recettes" / "crepes.csv").read_text(encoding="utf-8"), "text")}

La première ligne nomme les colonnes, les suivantes donnent un ingrédient
chacune. La bibliothèque `csv` découpe chaque ligne en une liste de chaînes
(notebook `fichiers.ipynb` du cours 3, section 10 ; documentation
officielle : <https://docs.python.org/fr/3/library/csv.html>). `next(lecteur)` lit la
première ligne et la laisse de côté. `float` convertit la quantité, lue
comme une chaîne, en nombre.

Les chemins se construisent avec `pathlib`, à partir du dossier du script.
`__file__` est le chemin du fichier `recette.py` en cours d'exécution, et
`.parent` le dossier qui le contient, `travail/recette/`. `/` ajoute un nom
au chemin. Construits ainsi, les chemins ne dépendent pas du dossier du
terminal, et le programme trouve `recettes/` d'où qu'on le lance.

{modifications(version("b3"), version("b4"))}

**Vérification** : `python recette.py` affiche la même recette qu'à l'étape
B3, lue cette fois dans le fichier :

{sortie("b4")}

Avec `NOM = "cookies"` et `UNITES = "SI"`, la recette américaine est
convertie en grammes et en millilitres :

{sortie("b4", fichiers={"recette.py": cookies_si})}

Remettre `NOM = "crepes"` et `UNITES = "US"` avant le commit.

```text
git commit -am "Les ingrédients lus dans un fichier CSV"
```

## B5 · Écrire le résultat dans un fichier CSV

{encadre("écrire la fonction `ecrire_ingredients` ; écrire la recette calculée dans `sortie/` ; un commit.",
         "`sortie/crepes_6_US.csv`, avec les mêmes colonnes que les fichiers de `recettes/` ; `git status` ne liste pas `sortie/` ; un commit.")}

`open(chemin, "w", …)` ouvre le fichier en écriture : il est créé, ou vidé
s'il existe (notebook `fichiers.ipynb`, section 9). `csv.writer` écrit
chaque liste passée à `writerow` sur une ligne (documentation officielle du
module `csv` : <https://docs.python.org/fr/3/library/csv.html>), les valeurs séparées par
des virgules. `SORTIE.mkdir(exist_ok=True)` crée le dossier `sortie/` s'il
n'existe pas encore.

{modifications(version("b4"), version("b5"))}

**Vérification** : `python recette.py` affiche la recette, puis

{fence(executer({"recette.py": version("b5")}, "recette.py").splitlines()[-1], "text")}

Ouvrir `sortie/crepes_6_US.csv` dans VS Code :

{fence(fichier_b5(), "text")}

`git status` ne liste pas `sortie/`, écarté par `.gitignore`.

```text
git commit -am "Le résultat écrit dans un fichier CSV"
```

## B6 · Les valeurs sur la ligne de commande

{encadre("remplacer les trois valeurs écrites dans le programme par trois arguments lus par `argparse` ; un commit.",
         "`python recette.py cookies -p 8 -u SI` écrit `sortie/cookies_8_SI.csv` ; `python recette.py --help` décrit les trois arguments ; un commit.")}

Pour changer de recette, de nombre de personnes ou d'unités, il faut
jusqu'ici modifier les trois valeurs dans le code. `argparse` (cours 3) les
lit sur la ligne de commande, au lancement. Les fonctions et le calcul ne
changent pas. `nom` est un argument obligatoire. `-p` et `-u` sont des
options, avec une valeur par défaut. `choices` limite les valeurs
possibles, et `type=int` convertit la valeur lue en nombre entier.

{modifications(version("b5"), version("b6"))}

**Vérifications** :

| Commande | Ce qui doit s'afficher |
|---|---|
| `python recette.py cookies -p 8 -u SI` | la recette des cookies pour 8 personnes, en grammes et en millilitres, puis `écrit : …\\sortie\\cookies_8_SI.csv` |
| `python recette.py crepes` | la recette pour 4 personnes en SI, les valeurs par défaut |
| `python recette.py` | `error: the following arguments are required: nom` |
| `python recette.py crepes -u FR` | `error: argument -u/--unites: invalid choice: 'FR' (choose from 'SI', 'US')` |
| `python recette.py --help` | l'aide : les trois arguments et leur texte |

Un nom de recette inconnu arrête le programme sur une erreur, dont la
dernière ligne donne la cause :

```text
python recette.py gaufres
```

{fence(executer({"recette.py": version("b6")}, "recette.py", "gaufres").splitlines()[-1], "text")}

```text
git commit -am "Les valeurs lues sur la ligne de commande"
```

## B7 (bonus) · Un README, une étiquette

{encadre("compléter un README à partir du modèle ; poser l'étiquette `v1.0` sur le dernier commit.",
         "`git log --oneline` affiche neuf lignes, la première marquée `tag: v1.0`.")}

Copier le modèle dans le projet, depuis `travail/recette/` :

```text
cp ../../depart/modeles/README.md .
```

`..` désigne le dossier parent : `../../` remonte de `travail/recette/` à
`4a_recette/`. Le `.` final désigne le dossier courant.

Ouvrir `README.md` dans VS Code et remplacer chaque passage « (À compléter
…) ». `Ctrl` + `Maj` + `V` affiche l'aperçu. Chaque commande écrite dans le
README doit fonctionner quand on la colle dans le terminal.

```text
git add README.md
git commit -m "Un README"
git tag -a v1.0 -m "Première version"
git log --oneline
```

Une étiquette git, un _tag_, nomme un commit : `v1.0` désigne la version
finale sans chercher son identifiant.
"""
    return lier(texte)


# ---- TD 4b ---------------------------------------------------------------------

def debut_fin_main(texte):
    """La fonction `main` et son appel, avec les deux premières et les deux dernières lignes du corps."""
    lignes = texte[texte.index("def main():"):].splitlines()
    fin = lignes.index("# Vrai quand le fichier est lancé par `python`, faux quand il est importé.")
    corps = [l for l in lignes[1:fin] if l.strip()]
    return "\n".join([lignes[0], *corps[:2], "    ...", *corps[-2:], "", ""] + lignes[fin:])


def guide_4b():
    b6 = version("b6")
    c1 = version("c1")
    c2 = version("c2")
    c4 = version("c4")
    c5 = version("c5")
    fichiers_c2 = {"recette.py": c2, "quantites.py": quantites()}
    fichiers_c5 = {"src/recette.py": c5, "src/quantites.py": quantites()}
    env = (TD_PAQUET / "depart" / "modeles" / "environment.yml").read_text(encoding="utf-8")
    pyproject = (TD_PAQUET / "depart" / "modeles" / "pyproject.toml").read_text(encoding="utf-8")
    import_avant = executer({"recette.py": b6}, "-c", "import recette").splitlines()[-1]
    erreur_src = executer({"src/recette.py": c2, "src/quantites.py": quantites()}, "src/recette.py", "crepes").splitlines()[-1]
    texte = ENTETE.format(titre="TD 4b — Un programme installable") + f"""
Ce guide détaille les étapes du TD 4b, pour le parcours avancé. Le TD suit
le TD 4a, dans le même dossier `4a_recette/travail/recette/`. Il part du
programme de l'étape B6 : `python recette.py crepes -p 6 -u US` écrit
`sortie/crepes_6_US.csv`.

Le TD donne au programme la forme d'un projet Python : une fonction `main`,
deux modules, un environnement décrit par un fichier, puis une commande
`recette` installée par `pip`. Les diapositives de l'exposé qui précède le
TD expliquent ces quatre notions. Chaque étape se termine par un commit.

Le guide donne les lignes à modifier sous la forme expliquée dans la
partie B du guide du TD 4a : `-` pour une ligne à supprimer, `+` pour une
ligne à ajouter.

| Étape | Objectif | Commits de plus |
|---|---|---|
| [C1](#@C1) | séparer les définitions du programme principal : `main` | 1 |
| [C2](#@C2) | répartir le code en deux modules | 2 |
| [C3](#@C3) | décrire l'environnement du projet dans un fichier | 3 |
| [C4](#@C4) | installer le programme comme une commande | 4 |
| [C5](#@C5) (bonus) | écrire la page HTML par pandoc | 5 |

## C1 · Une fonction main

{encadre("placer les lignes du programme dans une fonction `main`, appelée en bas du fichier sous `if __name__ == \"__main__\":` ; un commit.",
         "`python recette.py crepes -p 6` affiche la même recette qu'avant ; `python -c \"import recette\"` n'affiche rien.")}

Python lit un fichier de haut en bas, qu'il soit lancé par `python` ou
importé par un autre fichier. Importer `recette.py` exécute donc aussi son
programme :

```text
python -c "import recette"
```

s'arrête sur une erreur, car le programme attend ses arguments :

{fence(import_avant, "text")}

`python -c` exécute le code écrit entre guillemets.

1. Au-dessus du commentaire `# Les valeurs viennent de la ligne de
   commande`, écrire `def main():`.
2. Sélectionner toutes les lignes du programme, de ce commentaire jusqu'au
   dernier `print`, et appuyer sur `Tab` : elles se décalent de quatre
   espaces.
3. À la fin du fichier, ajouter l'appel :

{fence(c1[c1.index(chr(10) + chr(10) + "# Vrai quand"):])}

Le bas du fichier devient :

{fence(debut_fin_main(c1))}

`__name__` vaut `"__main__"` quand le fichier est lancé par `python`, et
`"recette"` quand il est importé.

**Vérification** : `python recette.py crepes -p 6` affiche la même recette
qu'à l'étape B6 ; `python -c "import recette"` n'affiche rien.

```text
git diff
git commit -am "Une fonction main"
```

## C2 · Deux modules

{encadre("créer `quantites.py` avec les tables et les fonctions ; les retirer de `recette.py`, qui les importe ; un commit.",
         "la même recette ; `recette.py` ne contient plus que les chemins, `main` et son appel.")}

Un fichier Python est un module. `quantites.py` contiendra ce qui calcule
(lire, écrire, adapter, convertir, afficher) et `recette.py` ce qui
dépend du programme (les chemins, les arguments, l'ordre des appels).

### C2.1 Le module `quantites.py`

Dans l'explorateur de VS Code, créer le fichier `quantites.py` dans
`travail/recette/`. Y couper-coller depuis `recette.py` les deux tables et
les cinq fonctions. Le fichier contient alors :

{fence(quantites())}

### C2.2 `recette.py` importe le module

Dans `recette.py`, il reste les chemins, puis `main` et son appel.
`import csv` n'y sert plus. Une ligne importe les tables et les fonctions
de `quantites.py` :

{modifications(version("c2-coupe"), c2)}

`from quantites import adapter` exécute `quantites.py` une fois, et le nom
`adapter` est ensuite utilisable dans `recette.py`. Python cherche
`quantites.py` dans le dossier du fichier lancé, puis dans les dossiers de
l'environnement.

**Vérification** :

```text
python recette.py crepes -p 6
python -c "import quantites; print(quantites.VERS_US)"
```

La première commande affiche la même recette. La seconde affiche la table :

{fence(executer(fichiers_c2, "-c", "import quantites; print(quantites.VERS_US)"), "text")}

```text
git add quantites.py
git commit -am "Deux modules : quantites et recette"
```

## C3 · Un environnement pour le projet

{encadre("copier `environment.yml` dans le projet ; créer l'environnement `recette` et l'activer ; un commit.",
         "l'invite commence par `(recette)` ; `which python` donne le Python de l'environnement ; le programme fonctionne.")}

Le fichier `environment.yml` décrit ce dont le projet a besoin. Une autre
personne recrée le même environnement à partir de ce fichier.

```text
cp ../../../4b_paquet/depart/modeles/environment.yml .
```

{fence(env, "yaml")}

`pandoc` sert au bonus C5. `pip` et `setuptools` servent à l'étape C4.

```text
conda env create -f environment.yml
conda activate recette
which python
```

La création télécharge les paquets : plusieurs minutes.

**Vérification** : l'invite commence par `(recette)`, et `which python`
affiche un chemin qui contient `envs/recette`. `python recette.py crepes`
affiche la recette : le programme n'emploie que la bibliothèque standard
de Python.

```text
git add environment.yml
git commit -m "L'environnement du projet"
```

## C4 · Une commande installée

{encadre("déplacer les deux modules dans `src/` avec `git mv` ; copier et compléter `pyproject.toml` ; `pip install -e .` ; un commit.",
         "`recette crepes -p 6` affiche la recette, sans `python` ni nom de fichier ; `recette --help` affiche l'aide.")}

### C4.1 Les modules dans `src/`

```text
mkdir src
git mv recette.py quantites.py src/
git status
```

**Vérification** : `git status` affiche deux renommages (`renamed:`).

Le script est maintenant dans `src/`. `Path(__file__).parent` désigne donc
`src/`, qui ne contient pas `recettes/`, et `python src/recette.py crepes`
s'arrête sur une erreur dont la dernière ligne est :

{fence(erreur_src, "text")}

La racine du projet est le dossier parent de `src/` : un `.parent` de plus,
comme `..` dans un chemin.

{modifications(c2, c4)}

**Vérification** : `python src/recette.py crepes` affiche la recette.

### C4.2 Le fichier `pyproject.toml`

```text
cp ../../../4b_paquet/depart/modeles/pyproject.toml .
```

{fence(pyproject, "toml")}

`[project.scripts]` déclare la commande : `recette = "recette:main"` fait
de `recette` une commande qui appelle la fonction `main` du module
`recette`. `package-dir` et `py-modules` disent à pip où sont les modules.
Compléter la ligne `description`.

### C4.3 Installer

Dans `travail/recette/`, l'environnement `recette` actif :

```text
pip install -e . --no-build-isolation
```

`.` désigne le projet, dans le dossier courant. `-e` installe le projet en
mode modifiable : la commande appelle le code de `src/`, et une
modification de ce code vaut sans réinstaller. `--no-build-isolation`
utilise le `setuptools` de l'environnement, sans le télécharger.

**Vérification** : la dernière ligne affichée est `Successfully installed
recette-0.1`. Puis :

```text
recette crepes -p 6
recette --help
which recette
```

La recette s'affiche, sans `python` ni nom de fichier. `which recette`
donne un chemin dans l'environnement `recette`. Les chemins partent du
script : lancée depuis un autre dossier, par exemple après `cd ..`, la
commande trouve toujours `recettes/`, et écrit dans `sortie/` du projet.

Dans le README, s'il existe, remplacer `python recette.py` par `recette` et
ajouter l'installation.

```text
git add pyproject.toml
git commit -am "src/ et pyproject.toml : la commande recette"
```

`pip uninstall recette` retire la commande.

## C5 (bonus) · La page HTML, par pandoc

{encadre("ajouter l'option `--page`, qui écrit aussi la recette en page HTML par pandoc ; un commit.",
         "`recette crepes -p 6 --page` écrit `sortie/crepes_6_SI.html`, qui s'ouvre dans le navigateur.")}

La fonction `ecrire_page` écrit un tableau Markdown, puis lance pandoc avec
`subprocess.run`, comme au cours 3. Elle reste dans `recette.py`, car elle
dépend d'un programme extérieur.

{modifications(c4, c5)}

**Vérification** :

```text
recette crepes -p 6 --page
start sortie/crepes_6_SI.html
```

{fence(executer(fichiers_c5, "src/recette.py", "crepes", "-p", "6", "--page").splitlines()[-1], "text")}

La page affiche le titre et le tableau des ingrédients.

```text
git commit -am "L'option --page"
```
"""
    return lier(texte)


def ecrire_guides():
    for td, texte in (("4a_recette", guide_4a()), ("4b_paquet", guide_4b())):
        cible = GUIDES / td / "guide.md"
        cible.parent.mkdir(parents=True, exist_ok=True)
        cible.write_text(texte, encoding="utf-8")
        print("ok", cible.relative_to(DEPOT))
