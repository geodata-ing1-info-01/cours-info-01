"""Les guides des TD 7a (la recette en pages) et 7b (la fenêtre du train).

Appelé par `generer_projet7.py` après la vérification des corrigés : le code
montré vient de `recette(etat)` et `train(etat)`, les blocs de modifications
de `blocs` (`outils/modifications.py`), et les sorties montrées sont celles des
programmes et de git, exécutés au moment de l'écriture.

Écrit `src/cours7/notebook/td/7a_recette/guide.md` et
`src/cours7/notebook/td/7b_train/guide.md`.
"""

from __future__ import annotations

import ast
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

from generer_projet7 import (DEPOT, LIGNE_FENETRE, LIGNES_POTEAUX, TD_RECETTE, TITRE_PROGRAMME, depot_recette,
                             depot_train, ecrire, blocs, recette, train, verifier_train)

sys.path.insert(0, str(DEPOT / "src"))
from _identifiants import identifiant_titre  # noqa: E402

GUIDES = DEPOT / "src" / "cours7" / "notebook" / "td"
PROJET_RECETTE = r"C:\Users\eleve\Desktop\cours7\7a_recette\travail\recette"
PROJET_TRAIN = r"C:\Users\eleve\Desktop\cours7\7b_train\travail\train"

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


def executer(fabriquer, projet_windows, fichiers, *arguments, preparer=None):
    """Lance `python *arguments` dans un clone du dépôt de référence, avec les `fichiers` ; renvoie la sortie réelle."""
    with tempfile.TemporaryDirectory() as tmp:
        projet = Path(tmp) / "projet"
        fabriquer(projet)
        if preparer:
            preparer(projet)
        for chemin, texte in fichiers.items():
            ecrire(projet / chemin, texte)
        resultat = subprocess.run([sys.executable, *arguments], cwd=projet, capture_output=True, text=True)
        texte = resultat.stdout + resultat.stderr
        texte = re.sub(re.escape(str(projet)) + r"[\w/.]*",
                       lambda m: projet_windows + m.group(0)[len(str(projet)):].replace("/", "\\"), texte)
        return texte.rstrip("\n")


RAPPEL_MODIFICATIONS = """Le guide donne les modifications du programme par blocs. Les lignes en
vert, entre deux lignes `+++`, sont à ajouter : les copier telles quelles,
sans les lignes `+++`. Les lignes en rouge, entre deux lignes `---`, sont à
supprimer. Les autres lignes ne changent pas et indiquent l'endroit : le
nombre qui les précède est le numéro de la ligne dans VS Code, quand les
modifications sont faites de haut en bas."""

DEBUT_SEANCE = """## Au début de la séance

- Le compte GitHub du cours 6.
- L'archive `info01-cours7.zip`, copiée depuis `formationTemp` sur le
  Bureau, puis extraite : clic droit, Extraire tout, en effaçant la fin du
  dossier proposé, `\\info01-cours7`. Le dossier extrait est
  `Desktop\\cours7`.

Ouvrir le dossier `cours7/{td}/` dans VS Code, puis un terminal Git Bash
(menu Terminal, New Terminal ; flèche à côté du `+`, Git Bash)."""

DOC_PYTHON = "https://docs.python.org/fr/3/"
AIDE_MEMOIRE_PYTHON = f"""### Aide-mémoire Python

Les tableaux suivants rappellent les instructions Python dont le TD a
besoin, avec le TD où elles ont été vues et un lien vers la documentation
officielle de Python. Chaque module s'importe en tête du programme :
`import argparse`, `import shutil`, `import subprocess`,
`from pathlib import Path`.

**Chaînes de caractères** (TD 3c, TD 3f, TD 4a). Documentation :
[le texte, dans le tutoriel]({DOC_PYTHON}tutorial/introduction.html#text),
[les méthodes des chaînes]({DOC_PYTHON}library/stdtypes.html#string-methods),
[`round`]({DOC_PYTHON}library/functions.html#round).

| Instruction | Effet |
|-------------|----------|
| `"Pour " + str(6) + " personnes"` | met les chaînes bout à bout : `"Pour 6 personnes"` ; `str` convertit d'abord le nombre en chaîne |
| `texte = texte + ligne` | ajoute `ligne` à la fin de `texte` |
| `"\\n"` | le caractère de fin de ligne |
| `round(374.96, 1)` | le nombre arrondi à un chiffre après la virgule : `375.0` |
| `texte.replace("## Ingrédients", nouveau)` | une copie de `texte`, où `nouveau` remplace chaque `## Ingrédients` |
| `ligne.strip()` | une copie de `ligne` sans les espaces ni la fin de ligne, au début et à la fin |
| `ligne.lstrip("# ")` | une copie de `ligne` sans les `#` ni les espaces du début : `"Crêpes"` pour `"# Crêpes"` |

**Chemins, module `pathlib`** (TD 3b). Documentation :
[`pathlib`]({DOC_PYTHON}library/pathlib.html).

| Instruction | Effet |
|-------------|----------|
| `RACINE = Path(__file__).parent` | le dossier du programme : `__file__` est le chemin du programme |
| `RACINE / "recettes" / "crepes.csv"` | un chemin, construit dossier par dossier |
| `chemin.name`, `chemin.stem`, `chemin.suffix` | pour `recettes/crepes.csv` : `"crepes.csv"`, `"crepes"`, `".csv"` |
| `chemin.with_suffix(".html")` | le même chemin, avec une autre extension : `recettes/crepes.html` |
| `sorted(dossier.iterdir())` | les chemins du contenu de `dossier`, fichiers et dossiers, dans l'ordre alphabétique |
| `dossier.mkdir(exist_ok=True)` | crée le dossier, s'il n'existe pas déjà |

**Fichiers texte** (TD 3c, TD 3f). Documentation :
[lecture et écriture de fichiers]({DOC_PYTHON}tutorial/inputoutput.html#reading-and-writing-files),
[`read_text`]({DOC_PYTHON}library/pathlib.html#pathlib.Path.read_text),
[`write_text`]({DOC_PYTHON}library/pathlib.html#pathlib.Path.write_text).

| Instruction | Effet |
|-------------|----------|
| `with open(chemin, encoding="utf-8") as fichier:` | ouvre le fichier en lecture ; Python le referme à la fin du bloc `with` |
| `fichier.readline()` | la ligne suivante du fichier, fin de ligne comprise |
| `fichier.read()` | le texte du fichier, de la position de lecture jusqu'à la fin |
| `chemin.read_text(encoding="utf-8")` | tout le texte du fichier, sans `open` ni `with` |
| `chemin.write_text(texte, encoding="utf-8")` | écrit `texte` dans le fichier, qui perd son ancien contenu |

**Options de la ligne de commande, module `argparse`** (TD 3f, étape B6 du
TD 4a). Documentation : [tutoriel `argparse`]({DOC_PYTHON}howto/argparse.html).

| Instruction | Effet |
|-------------|----------|
| `analyseur = argparse.ArgumentParser()` | crée l'analyseur de la ligne de commande |
| `analyseur.add_argument("nom")` | un argument positionnel, obligatoire : `python recette.py crepes` |
| `analyseur.add_argument("-p", "--personnes", type=int, default=4)` | une option avec une valeur, convertie en entier, 4 par défaut : `-p 6` |
| `analyseur.add_argument("--page", action="store_true")` | une option sans valeur, nouvelle dans ce TD : `True` quand la commande la porte, `False` sinon |
| `options = analyseur.parse_args()` | lit la ligne de commande ; `options.nom`, `options.personnes` et `options.page` donnent les valeurs |

**Programmes externes et copie de fichiers, modules `subprocess` et
`shutil`** (TD 3b, TD 3f). Documentation :
[`subprocess.run`]({DOC_PYTHON}library/subprocess.html#subprocess.run),
[`shutil.copy`]({DOC_PYTHON}library/shutil.html#shutil.copy).

| Instruction | Effet |
|-------------|----------|
| `subprocess.run(["pandoc", "a.md", "-o", "a.html"], check=True)` | lance pandoc, comme la commande `pandoc a.md -o a.html` ; `check=True` arrête le programme si pandoc échoue |
| `shutil.copy(source, destination)` | copie le fichier `source` vers `destination`, un fichier ou un dossier |"""


# ---- TD 7a ---------------------------------------------------------------------

def guide_7a():
    def preparer_d1(projet):
        shutil.copy(TD_RECETTE / "depart" / "style.css", projet / "style.css")
        for nom in ("crepes", "pate_pizza", "mousse_chocolat", "cookies"):
            shutil.copy(TD_RECETTE / "depart" / "recettes" / (nom + ".md"), projet / "recettes")

    def preparer_d3(projet):
        preparer_d1(projet)
        shutil.copytree(TD_RECETTE / "depart" / "recettes", projet / "recettes", dirs_exist_ok=True)

    def sortie(etat, *arguments, preparer=None):
        return fence(executer(depot_recette, PROJET_RECETTE, {"recette.py": recette(etat)}, "recette.py",
                              *arguments, preparer=preparer), "text")

    def dernieres(etat, n, *arguments, preparer=None):
        texte = executer(depot_recette, PROJET_RECETTE, {"recette.py": recette(etat)}, "recette.py",
                         *arguments, preparer=preparer)
        return fence("\n".join(texte.splitlines()[-n:]), "text")

    # Le texte complété, tel que le programme de l'étape D1.1 l'écrit
    code = ("import sys, runpy, pathlib; sys.argv = ['recette.py', 'crepes', '-p', '6', '--page']; "
            "runpy.run_path('recette.py', run_name='__main__'); "
            "print('@@@'); print(pathlib.Path('sortie/crepes.md').read_text(encoding='utf-8'), end='')")
    complete = executer(depot_recette, PROJET_RECETTE, {"recette.py": recette("d1a")}, "-c", code,
                        preparer=preparer_d1).split("@@@\n", 1)[1]
    extrait_complete = "\n".join(complete.splitlines()[:14]) + "\n…"
    # La liste des ingrédients des crêpes pour 6 personnes, et le tableau que `tableau` en écrit
    code = ("import sys, runpy; sys.argv = ['recette.py', 'crepes', '-p', '6']; "
            "e = runpy.run_path('recette.py', run_name='__main__'); "
            "print('@@@'); print(repr(e['ingredients'])); print('@@@'); print(e['tableau'](e['ingredients']), end='')")
    _, liste, tableau_crepes = executer(depot_recette, PROJET_RECETTE, {"recette.py": recette("d1f")},
                                        "-c", code).split("@@@\n")
    # Les commandes pandoc équivalentes à `ecrire_page`, sans puis avec la feuille de style,
    # exécutées dans un clone, après `python recette.py crepes -p 6 --page`
    def verifier_pandoc(commandes, attendu):
        with tempfile.TemporaryDirectory() as tmp:
            projet = Path(tmp) / "projet"
            depot_recette(projet)
            preparer_d1(projet)
            ecrire(projet / "recette.py", recette("d1a"))
            subprocess.run([sys.executable, "recette.py", "crepes", "-p", "6", "--page"], cwd=projet,
                           check=True, capture_output=True)
            subprocess.run(["bash", "-c", commandes], cwd=projet, check=True, capture_output=True)
            page = (projet / "sortie" / "crepes.html").read_text(encoding="utf-8")
            assert attendu in page, (commandes, attendu)
        return commandes
    pandoc_seul = verifier_pandoc(
        'pandoc sortie/crepes.md -o sortie/crepes.html --standalone --metadata pagetitle="Crêpes"',
        "<title>Crêpes</title>")
    pandoc_css = verifier_pandoc(
        'cp style.css sortie/\n'
        'pandoc sortie/crepes.md -o sortie/crepes.html --standalone --css style.css --metadata pagetitle="Crêpes"',
        'href="style.css"')
    liste_code = "ingredients = [\n" + "".join(
        f'    ("{nom}", {quantite!r}, "{unite}"),\n' for nom, quantite, unite in ast.literal_eval(liste)) + "]"
    d1_debut, d1_programme = recette("d1").split(TITRE_PROGRAMME)
    d3_debut, d3_programme = recette("d3").split(TITRE_PROGRAMME)
    toutes = executer(depot_recette, PROJET_RECETTE, {"recette.py": recette("d3")}, "recette.py",
                      "--toutes", "--page", preparer=preparer_d3)
    pages = [l for l in toutes.splitlines() if l.endswith(".html")]
    sans_argument = executer(depot_recette, PROJET_RECETTE, {"recette.py": recette("d3")}, "recette.py",
                             preparer=preparer_d3).splitlines()[-1]
    sommaire = executer(depot_recette, PROJET_RECETTE, {"recette.py": recette("d4")}, "recette.py",
                        "--toutes", "--page", preparer=preparer_d3).splitlines()[-1]
    crepes_md = (TD_RECETTE / "depart" / "recettes" / "crepes.md").read_text(encoding="utf-8")
    noms = sorted(p.stem for p in (TD_RECETTE / "depart" / "recettes").glob("*.md"))
    texte = ENTETE.format(titre="TD 7a — Compléter un projet GitHub, par des pull requests") + f"""
Le TD part d'un dépôt GitHub publié par le module, `td7a-recette`, le même
pour tous : il contient le programme `recette.py` du corrigé du TD 4a, avec
son historique. Le TD ajoute de nouvelles fonctions à ce programme. Au
départ, le programme calcule les ingrédients d'une recette pour un nombre de
personnes et les écrit dans un fichier CSV. À la fin du TD, il
écrit aussi, pour chaque recette, une page HTML qui réunit le texte de la
recette et le tableau des quantités calculées, puis un sommaire qui relie
ces pages, comme un livre de recettes.

![À la fin du TD : la page HTML d'une recette](illustrations/page.png)

![Le sommaire, avec un lien vers chaque page](illustrations/sommaire.png)

Le TD ajoute ainsi deux fonctionnalités au programme : générer la page HTML
d'une recette (étapes D1 et D2), puis générer les pages HTML de toutes les
recettes et leur sommaire (étapes D3 et D4). Vous développez chacune sur sa
propre branche, puis vous l'ajoutez à `master` par une pull request,
fusionnée sur le site de GitHub.

{RAPPEL_MODIFICATIONS}

| Étape | Objectif |
|---|---|
| [D0](#@D0) | copier le dépôt de départ sur son poste puis son compte GitHub, lancer le programme (test) |
| [D1](#@D1) | écrire la page HTML d'une recette : ajout de la liste d'ingrédients, conversion HTML |
| [D2](#@D2) | proposer la branche par une pull request |
| [D3](#@D3) | générer les pages de toutes les recettes avec un seul appel de commande |
| [D4](#@D4) | écrire une page d'index des recettes ; deuxième pull request |
| [D5](#@D5) (bonus) | publier les pages avec GitHub Pages |

{DEBUT_SEANCE.format(td="7a_recette")}

{AIDE_MEMOIRE_PYTHON}

## D0 · Récupérer le projet GitHub initial

{encadre("créer sur votre compte GitHub un dépôt vide `td7a-recette` ; cloner dans `travail/recette/` le dépôt de départ du module, puis l'envoyer vers votre nouveau dépôt GitHub ; régler votre nom et votre adresse pour ce dépôt.",
         "la page GitHub de votre dépôt `td7a-recette` affiche `recette.py` et les commits du TD 4a ; lancée depuis le dossier `travail/recette/`, la commande `python recette.py crepes -p 6` écrit `sortie/crepes_6_SI.csv`.")}

Le dépôt de départ, `td7a-recette`, est sur le compte GitHub du module,
`geodata-ing1-info-01`. Vous faites le TD dans une copie de ce dépôt, sur
votre compte : vous y poussez vos branches et y fusionnez vos pull requests.

Sur votre compte GitHub, créer un dépôt vide nommé `td7a-recette` (New
repository, sans README). Puis, en remplaçant `<compte>` par le nom de votre
compte GitHub :

```text
cd travail
git clone git@github.com:geodata-ing1-info-01/td7a-recette.git recette
cd recette
git remote set-url origin git@github.com:<compte>/td7a-recette.git
git push -u origin master
```

Le dernier argument de `git clone` nomme le dossier local `recette`.
`git remote set-url` change l'adresse du dépôt distant `origin` : les
`git push` suivants envoient vos commits vers votre nouveau dépôt.

Régler ensuite votre nom et votre adresse pour ce dépôt :

```text
git config user.name "Prénom Nom"
git config user.email "prenom.nom@exemple.fr"
```

**Vérification** : lancée depuis le dossier `travail/recette/`, la commande
`python recette.py crepes -p 6` affiche

{sortie("a0", "crepes", "-p", "6")}

## D1 · Générer la page HTML d'une recette

{encadre("sur une branche `page` : modifier le programme pour qu'il complète le texte de la recette par le tableau des ingrédients (D1.1), puis convertisse ce texte en page HTML en appelant pandoc, avec une feuille de style (D1.2) ; faire un commit à la fin de D1.1 et à la fin de D1.2.",
         "`python recette.py crepes -p 6 --page` écrit `sortie/crepes.md`, puis `sortie/crepes.html`, la page de la figure du début du guide.")}

Au départ, `recette.py` écrit les quantités d'une recette dans un fichier
CSV. L'étape D1 modifie ce programme pour qu'il écrive aussi la page HTML
de la recette, celle de la figure du début du guide. Cette page réunit
deux choses : le texte de la recette (le titre, le temps de préparation,
les étapes), écrit à la main dans un fichier Markdown, et le tableau des
ingrédients, que le programme calcule déjà. Les fichiers Markdown des
recettes sont fournis dans le dossier `depart/recettes/` du TD,
`cours7/7a_recette/depart/recettes/`, hors du projet.

Les modifications à faire, dans l'ordre :

1. Copier le texte des recettes du dossier `depart/recettes/` du TD dans
   le dossier `recettes/` du projet, un fichier Markdown par recette. Ce
   texte sert de modèle : sa section `## Ingrédients` est vide, et le
   programme la remplit.
2. Écrire une fonction, `tableau(ingredients)`, qui reçoit la liste des
   ingrédients et renvoie leur tableau Markdown, sous forme de texte.
3. Écrire une fonction, `ecrire_markdown(nom, personnes, unites,
   ingredients)`. Elle reçoit le nom de la recette (`"crepes"`), le nombre
   de personnes et le système d'unités (`"SI"` ou `"US"`), qui servent au
   titre de la section, et la liste des ingrédients. Elle lit le texte de
   la recette, `recettes/<nom>.md`, place le tableau sous `## Ingrédients`,
   écrit le résultat dans `sortie/<nom>.md`, et renvoie le chemin de ce
   fichier.
4. Modifier le programme principal pour qu'il écrive ce texte complété,
   seulement quand la commande porte une nouvelle option, `--page` :
   `python recette.py crepes -p 6 --page`. Sans l'option, le programme fait
   ce qu'il faisait avant. Une option sans valeur, comme `--page`, est
   décrite dans la documentation d'argparse, partie
   [« Introduction aux arguments optionnels »](https://docs.python.org/fr/3/howto/argparse.html#introducing-optional-arguments).
5. Écrire une fonction, `ecrire_page(markdown)`, qui reçoit le chemin du
   texte complété, le convertit en page HTML avec pandoc, et renvoie le
   chemin de la page.
6. Ajouter une feuille de style, `style.css`, qui fixe la présentation de
   la page : polices, couleurs, largeur du texte, bordures du tableau.
   `ecrire_page` copie ce fichier dans `sortie/`, à côté de la page, avec la
   fonction `shutil.copy` (TD 3f), décrite dans la
   [documentation de `shutil.copy`](https://docs.python.org/fr/3/library/shutil.html#shutil.copy).

Les modifications 1 à 4 forment l'étape D1.1, les modifications 5 et 6
l'étape D1.2. Créer d'abord une branche, `page`, pour y faire les six
modifications :

```text
git checkout -b page
```

> **Essayer avant de regarder la solution.** Pour chaque modification,
> lire d'abord son explication, puis écrire le code soi-même avant de
> regarder le bloc qui indique la solution. Les cours précédents
> présentent tout ce dont ce code a besoin : la liste de tuples des ingrédients et les
> fonctions (TD 4a), la lecture et l'écriture d'un fichier texte (TD 3c),
> `argparse` (TD 3f, et étape B6 du TD 4a), pandoc lancé par
> `subprocess.run` et la copie d'un fichier par `shutil.copy` (TD 3f).
> L'aide-mémoire Python, au début du guide, résume ces instructions. La
> solution sert ensuite à vérifier votre code, ou à avancer si votre essai
> n'aboutit pas.

### D1.1 Ajouter le tableau des ingrédients au texte de la recette

Les deux nouvelles fonctions lisent le texte d'une recette, y ajoutent le
tableau de ses ingrédients, et écrivent le texte complété. Les paragraphes
suivants montrent ces données sur l'exemple des crêpes, pour 6 personnes en
unités SI.

**Le texte de la recette.** Le texte de chaque recette est fourni dans le
dossier `depart/recettes/` du TD, un fichier Markdown par recette. Le texte
des crêpes :

{fence(crepes_md, "markdown")}

Sa section `## Ingrédients` est vide : la fonction `ecrire_markdown` y
placera le tableau des ingrédients.

**La liste des ingrédients et son tableau Markdown.** Dans le programme,
les ingrédients d'une recette sont une liste de tuples, un tuple par
ingrédient : son nom, sa quantité et son unité. `lire_ingredients` lit
cette liste dans le fichier CSV, puis `adapter` et `convertir` en
recalculent les quantités. Pour les crêpes, la liste `ingredients` vaut :

{fence(liste_code)}

L'appel `tableau(ingredients)` renvoie le tableau Markdown de cette liste :
deux lignes d'en-tête, puis une ligne par ingrédient, la quantité et
l'unité dans la seconde colonne :

{fence(tableau_crepes, "markdown")}

Pour écrire ce texte, `tableau` part des deux lignes d'en-tête, puis ajoute
une ligne par ingrédient dans une boucle `for`. L'opérateur `+` met deux
chaînes bout à bout : si `nom` vaut `"Farine"`, `"| " + nom + " |"` vaut
`"| Farine |"`. Un nombre se convertit d'abord en chaîne avec `str` :
`str(375.0)` vaut `"375.0"`. L'instruction `texte = texte + ligne` ajoute
`ligne` à la fin de `texte`. Chaque ligne se termine par `"\\n"`, le
caractère de fin de ligne (TD 3c).

**Le texte complété.** Pour les crêpes, l'appel `ecrire_markdown("crepes",
6, "SI", ingredients)` lit le texte de la recette, `recettes/crepes.md`.
Elle assemble ensuite le texte de remplacement : un titre,
`## Ingrédients pour 6 personnes, en unités SI`, une ligne vide, puis le
tableau. La méthode `replace` remplace la ligne `## Ingrédients` du texte
de la recette par ce texte de remplacement. La fonction écrit le résultat
dans `sortie/crepes.md`, puis renvoie ce chemin.
Le début du texte complété :

{fence(extrait_complete, "markdown")}

**Modification 1, le texte des recettes.** Copier dans `recettes/` le texte
des quatre recettes qui ont déjà leur fichier CSV :

```text
cp ../../depart/recettes/crepes.md ../../depart/recettes/pate_pizza.md recettes/
cp ../../depart/recettes/mousse_chocolat.md ../../depart/recettes/cookies.md recettes/
```

Chaque recette a maintenant deux fichiers : les ingrédients, en CSV, et le
texte, en Markdown.

**Modifications 2 et 3, les fonctions `tableau` et `ecrire_markdown`.**
Ajouter les deux fonctions avant le programme principal :

{blocs(recette("a0"), recette("d1f"))}

**Modification 4, l'option `--page`.** `action="store_true"` fait de
`--page` une option sans valeur : `options.page` vaut `True` quand la
commande porte l'option, `False` sinon (documentation d'argparse, partie
[« Introduction aux arguments optionnels »](https://docs.python.org/fr/3/howto/argparse.html#introducing-optional-arguments)). Le programme
principal n'appelle `ecrire_markdown` que si `options.page` vaut `True`,
après l'écriture du fichier CSV :

{blocs(recette("d1f"), recette("d1a"))}

**Vérification** : `python recette.py crepes -p 6 --page` se termine par

{dernieres("d1a", 1, "crepes", "-p", "6", "--page", preparer=preparer_d1)}

Ouvrir `sortie/crepes.md` dans VS Code (`Ctrl` + `Maj` + `V` pour
l'aperçu) : il commence par le texte complété montré plus haut.

```text
git add recettes
git commit -am "Le texte de la recette, complété par le tableau des ingrédients"
```

### D1.2 Générer la page HTML en appelant pandoc

La modification 5 produit la page HTML avec pandoc. La modification 6 lui
donne ensuite sa présentation, par une feuille de style.

**La page HTML, par pandoc.** pandoc convertit un fichier Markdown en page
HTML, comme au cours 3. L'appel `ecrire_page(markdown)`, où `markdown` est
le chemin `sortie/crepes.md` que renvoie `ecrire_markdown`, lance pandoc
avec `subprocess.run`. pandoc écrit la page `sortie/crepes.html` : le même
chemin, avec l'extension `.html` (`with_suffix(".html")`). `ecrire_page`
renvoie ce chemin. Pour les crêpes, `ecrire_page` lance la même commande
que celle-ci, tapée dans le terminal depuis le dossier du projet :

{fence(pandoc_seul, "text")}

`ecrire_page` construit cette commande pour n'importe quelle recette : elle
calcule le chemin de la page et le titre à partir de `markdown`. Le titre
de la page, `Crêpes`, vient de la première ligne du fichier, `# Crêpes`.
`readline` lit cette ligne, fin de ligne comprise (TD 3c) ; `strip()`
retire la fin de ligne, puis `lstrip("# ")` retire le `#` et l'espace du
début.

**La feuille de style.** Une page HTML décrit son contenu : un titre, des
paragraphes, un tableau. Sa présentation est décrite à part, dans une
feuille de style CSS, comme au cours 1. La feuille `style.css`, fournie
dans le dossier `depart/` du TD, met le texte dans une colonne centrée
d'environ 70 caractères, sur un fond crème, souligne les titres de section
et aligne à droite les quantités du tableau. Les dix pages et le sommaire
partageront cette feuille : une modification de `style.css` changera la
présentation de toutes les pages, sans toucher à leur contenu. L'option
`--css style.css` de pandoc ajoute dans la page un lien vers `style.css`,
à la place de la mise en forme que pandoc y met par défaut. Le navigateur
cherche ce fichier à côté de la page : `ecrire_page` le copie donc dans
`sortie/`. Tapées dans le terminal, la copie et la conversion seraient :

{fence(pandoc_css, "text")}

**Modification 5, l'appel de pandoc.** Ajouter `import subprocess`, une
fonction `ecrire_page`, et son appel après celui de `ecrire_markdown` :

{blocs(recette("d1a"), recette("d1p"))}

**Vérification** : `python recette.py crepes -p 6 --page` se termine par

{dernieres("d1p", 2, "crepes", "-p", "6", "--page", preparer=preparer_d1)}

`start sortie/crepes.html` ouvre la page dans le navigateur : le texte et
le tableau de la recette, avec la mise en forme par défaut de pandoc.

**Modification 6, la feuille de style.** Copier la feuille de style dans
le projet :

```text
cp ../../depart/style.css .
```

Puis, dans `ecrire_page`, copier `style.css` dans `sortie/` avec
`shutil.copy` ([documentation](https://docs.python.org/fr/3/library/shutil.html#shutil.copy)), et ajouter l'option `--css` à
la commande de pandoc :

{blocs(recette("d1p"), recette("d1"))}

**Vérification** : relancer `python recette.py crepes -p 6 --page`, puis
`start sortie/crepes.html` : la page a maintenant la présentation de la
figure du début du guide.

```text
git add style.css
git commit -am "La page HTML de la recette, par pandoc"
```

## D2 · Soumettre les modifications avec une pull request

{encadre("pousser la branche `page` ; ouvrir la pull request sur GitHub et la fusionner ; ramener `master` sur le poste.",
         "sur GitHub, la pull request est fusionnée ; `git log --oneline --graph` montre le commit de fusion sur `master`.")}

La branche `page` contient maintenant la nouvelle fonctionnalité, sur le
poste seulement. Une pull request demande, sur GitHub, sa fusion dans
`master`. Dans un projet à plusieurs, une autre personne relit alors
les modifications avant la fusion ; ici, chacun fusionne la sienne, dans
son dépôt.

Les opérations, dans l'ordre :

1. Envoyer la branche `page` sur GitHub.
2. Sur le site, ouvrir la pull request, puis la fusionner.
3. Ramener sur le poste le `master` de GitHub, qui contient la fusion.

```text
git push -u origin page
```

Sur la page du dépôt, GitHub affiche un bandeau « page had recent pushes » :
bouton Compare & pull request, puis Create pull request. La page de la pull
request montre les commits et les modifications de la branche. Bouton Merge
pull request, puis Confirm merge : la branche est fusionnée dans `master`,
sur GitHub.

Le `master` du poste n'a pas encore cette fusion :

```text
git checkout master
git pull
git log --oneline --graph
```

**Vérification** : la dernière ligne du graphe est le commit `Merge pull
request #1`, et `recette.py` contient `ecrire_page`.

## D3 · Ajouter une option pour générer toutes les recettes

{encadre("sur une branche `livre`, copier six recettes de plus dans le projet ; écrire une fonction qui renvoie la liste des noms des recettes (D3.1) ; ajouter l'option `--toutes`, qui génère la page de chaque recette de cette liste (D3.2) ; faire un commit.",
         "`python recette.py --toutes --page` écrit les pages des dix recettes dans `sortie/`.")}

Jusqu'ici, une commande écrit la page d'une seule recette. Pour les quatre
recettes du projet, quatre commandes restent faisables. Avec les six
recettes que cette étape ajoute, il en faut dix, presque identiques, puis
une de plus pour chaque nouvelle recette. Vous ajoutez donc au programme une
option, `--toutes`, qui génère les pages de toutes les recettes de
`recettes/` en une seule commande : `python recette.py --toutes --page`.

Les modifications à faire, dans l'ordre :

1. Copier les six autres recettes du dossier `depart/recettes/` du TD dans
   le dossier `recettes/` du projet : leur fichier CSV et leur texte.
2. Écrire une fonction, `noms_des_recettes()`, qui renvoie la liste des
   noms des recettes de `recettes/` (D3.1).
3. Ajouter au programme principal l'option `--toutes`, et placer dans une
   boucle les lignes qui calculent les quantités d'une recette et écrivent
   ses fichiers : le CSV et, avec `--page`, la page HTML. Avec `--toutes`,
   la boucle parcourt les noms de toutes les recettes ; sans l'option, elle
   ne traite que la recette nommée sur la ligne de commande (D3.2).

Créer d'abord une branche, `livre`, pour y faire ces modifications, puis
copier les six recettes :

```text
git checkout -b livre
cp ../../depart/recettes/*.csv ../../depart/recettes/*.md recettes/
ls recettes
```

**Vérification** : `ls` liste dix fichiers `.csv` et dix fichiers `.md`.

### D3.1 Obtenir la liste des noms des recettes

Le nom d'une recette est celui de son fichier CSV, sans l'extension :
`crepes` pour `crepes.csv`. Comme au TD 3b, `sorted(DONNEES.iterdir())`
donne les chemins des fichiers de `recettes/`, dans l'ordre alphabétique.
La fonction `noms_des_recettes` garde ceux dont l'extension, `suffix`, vaut
`".csv"`, et ajoute à une liste leur nom sans l'extension, `stem`. Elle
renvoie la liste des dix noms, de `{noms[0]}` à `{noms[-1]}`. Le
commentaire du code indique une écriture plus courte, avec `glob`.

{blocs(d1_debut, d3_debut)}

### D3.2 Ajouter l'option `--toutes`, qui génère la page de chaque recette

Le programme traite une seule recette, celle de la variable `NOM`. Pour
traiter toutes les recettes, placer les lignes qui calculent et écrivent les
fichiers d'une recette dans une boucle `for`. Cette boucle parcourt une
liste de noms : tous les noms avec `--toutes`, sinon le seul nom donné sur
la ligne de commande.

1. Remplacer les lignes de `analyseur.add_argument("nom", …)` à
   `UNITES = options.unites` par celles du bloc ci-dessous, jusqu'à
   `for nom in noms:`. `nargs="?"` rend le nom facultatif : avec
   `--toutes`, il n'est pas donné.
2. Sélectionner les lignes suivantes, de `ingredients = lire_ingredients(…)`
   jusqu'à la fin du fichier, puis appuyer sur `Tab` : VS Code les indente
   d'un niveau, et elles forment le corps de la boucle.
3. Dans ces lignes, remplacer `NOM` par `nom`, la variable de la boucle.

Le programme devient :

{fence(d3_programme)}

**Vérification** :

```text
python recette.py --toutes --page
```

affiche chaque recette, puis les fichiers écrits : {len(pages)} pages HTML
en tout. Sans nom ni `--toutes`, le programme s'arrête avec ce message :

{fence(sans_argument, "text")}

```text
git add recettes
git commit -am "Toutes les recettes"
```

## D4 · Générer le sommaire des recettes

{encadre("écrire une fonction, `ecrire_sommaire`, et l'appeler après la boucle ; faire un commit ; soumettre la branche `livre` avec une pull request.",
         "`sortie/index.html` a un lien vers chaque page ; la branche `livre` est fusionnée dans `master` sur GitHub.")}

Les dix pages ne sont reliées par aucun lien : pour ouvrir l'une d'elles,
il faut connaître le nom de son fichier. Le sommaire, `sortie/index.html`,
donne un lien vers chacune.

Les modifications à faire, dans l'ordre :

1. Écrire une fonction, `ecrire_sommaire`, qui écrit le sommaire en
   Markdown, `sortie/index.md`, puis le convertit en page HTML par
   `ecrire_page`.
2. Modifier le programme principal pour qu'il appelle cette fonction après
   la boucle, quand la commande porte `--page` et `--toutes`.

Terminer ensuite la branche `livre` par un commit et une pull request,
comme la branche `page` à l'étape D2.

![Le sommaire : un lien par recette](illustrations/sommaire.png)

Le sommaire est une page de plus, écrite comme les autres : un fichier
Markdown, `sortie/index.md`, converti par `ecrire_page`. Il contient un
titre, puis une liste Markdown, un lien par recette :
`- [Crêpes](crepes.html)`. Le texte du lien est le titre de la recette, la
première ligne de son fichier `.md` sans le `# `, lue comme dans
`ecrire_page`. `ecrire_sommaire` construit ce texte comme `tableau` : une
chaîne de départ, le titre du sommaire, puis une ligne ajoutée par
recette.

{blocs(recette("d3"), recette("d4"))}

**Vérification** : `python recette.py --toutes --page` se termine par

{fence(sommaire, "text")}

`start sortie/index.html` ouvre le sommaire ; chaque lien ouvre une page.

```text
git commit -am "Le sommaire"
git push -u origin livre
```

Sur GitHub, ouvrir puis fusionner la pull request de la branche `livre`,
comme à l'étape D2. Sur le poste, ramener ensuite `master` :

```text
git checkout master
git pull
```

## D5 (bonus) · Publier les pages sur GitHub Pages

{encadre("copier les pages dans un dossier `docs/` du dépôt ; régler GitHub Pages sur ce dossier.",
         "le sommaire s'ouvre à l'adresse `https://<compte>.github.io/td7a-recette/`.")}

GitHub Pages publie sur le web des pages rangées dans un dépôt GitHub : le
livre de recettes devient lisible par tous, à une adresse en `github.io`.
GitHub Pages ne publie que des fichiers versionnés, et `sortie/` ne l'est
pas : copier les pages dans un dossier versionné, `docs/`.

```text
mkdir docs
cp sortie/*.html sortie/style.css docs/
git add docs
git commit -m "Les pages, publiées"
git push
```

Sur GitHub : Settings, Pages ; Source : Deploy from a branch ; Branch :
`master`, dossier `/docs` ; Save. Une minute plus tard, la page Settings,
Pages donne l'adresse du site.

**Vérification** : `https://<compte>.github.io/td7a-recette/` affiche le
sommaire. Les pages publiées sont une copie : après une modification du
programme, refaire la copie, le commit et le `push`.
"""
    return lier(texte)


# ---- TD 7b ---------------------------------------------------------------------

def guide_7b():
    def sortie_train(etat, *arguments):
        return executer(depot_train, PROJET_TRAIN, {"train.py": train(etat)}, "train.py", *arguments)

    en_conflit, pull = verifier_train()
    lignes = en_conflit.splitlines()
    debut = next(i for i, l in enumerate(lignes) if l.startswith("<<<<<<<"))
    fin = next(i for i, l in enumerate(lignes) if l.startswith(">>>>>>>"))
    conflit = "\n".join(lignes[debut:fin + 1])
    messages_pull = "\n".join(l for l in pull.splitlines() if l.startswith(("Auto-merging", "CONFLICT", "Automatic")))
    plans_csv = "fichier,vitesse\nvoiles.png,4\nplage_jaune.png,8\n"
    r2 = train("r2")
    image_r2 = r2[r2.index("def image("):r2.index("\n\n# ---- Une série")]
    resolution = LIGNES_POTEAUX + LIGNE_FENETRE
    une_image = sortie_train("r2", "--numero", "40")
    video = sortie_train("r2", "--images", "48", "--video")
    texte = ENTETE.format(titre="TD 7b — Reprendre et compléter le projet d'un autre") + f"""
Le TD part d'un projet déjà commencé par quelqu'un d'autre : le dépôt
`train`, publié sur GitHub par le module. Son programme fabrique une courte
vidéo d'après la scène de la mer du clip « Moon » de Kid Francescoli
(Cauboyz, 2017). Dans ce clip, la caméra filme la mer depuis un train : le
paysage défile derrière la vitre, les plans proches plus vite que les plans
lointains, et les ombres des poteaux le long de la voie passent très vite.

## Ce que le TD ajoute au programme

Le programme du dépôt ne fait défiler que le paysage : deux plans, les
voiles et la plage, sur un fond fixe. Le TD lui ajoute les deux autres
éléments du clip, deux effets :

- **effet 1, la fenêtre du train** : le cadre de la vitre, posé par-dessus
  le paysage ;
- **effet 2, les ombres des poteaux** : des bandes sombres qui traversent
  l'image très vite, calculées avec numpy.

![Au départ, chaque effet seul, puis les deux : l'image numéro 3 de la vidéo](illustrations/effets.png)

Les deux effets se développent sur deux branches parties du même commit,
`fenetre` et `poteaux`, comme le feraient deux personnes en même temps.
Chacune arrive sur `master` par une pull request. Les deux modifient le
même endroit de la fonction `image` : la seconde pull request s'arrête sur
un conflit, que l'on résout sur le poste.

{RAPPEL_MODIFICATIONS}

| Étape | Objectif |
|---|---|
| [E0](#@E0) | récupérer un projet et son environnement, le faire tourner |
| [E1](#@E1) | lire le code d'un autre : comment une image est composée |
| [E2](#@E2) | effet 1, la fenêtre du train, sur une branche ; une pull request |
| [E3](#@E3) | effet 2, les ombres des poteaux avec numpy, sur une autre branche ; un conflit |
| [E4](#@E4) (bonus) | un troisième plan, sans modifier le code |

{DEBUT_SEANCE.format(td="7b_train")}

## E0 · Récupérer le projet et son environnement

{encadre("le dépôt `train` cloné depuis le compte du module, puis poussé vers un dépôt vide de votre compte ; l'environnement `train` créé depuis `environment.yml`.",
         "`python train.py --images 48 --video` écrit `sortie/train.mp4`, où deux plans défilent sur le fond.")}

### E0.1 Le dépôt

Sur votre compte GitHub, créer un dépôt vide nommé `train` (New
repository, sans README). Le compte du module est `geodata-ing1-info-01`.
Puis :

```text
cd travail
git clone git@github.com:geodata-ing1-info-01/td7b-train.git train
cd train
git remote set-url origin git@github.com:<compte>/train.git
git push -u origin master
```

Le dernier argument de `git clone` nomme le dossier local `train`.
`git remote set-url` change l'adresse du dépôt distant `origin` : les
`push` suivants vont à votre dépôt. Régler ensuite votre nom, votre
adresse, et la façon dont `git pull` réunit deux historiques (par une
fusion, étape E3) :

```text
git config user.name "Prénom Nom"
git config user.email "prenom.nom@exemple.fr"
git config pull.rebase false
```

**Vérification** : `ls` liste `README.md`, `decor`, `environment.yml` et
`train.py` ; `git log --oneline` affiche trois commits.

### E0.2 L'environnement

Le programme lance ImageMagick (`magick`) et ffmpeg, deux programmes en
ligne de commande. Le fichier `environment.yml` du dépôt décrit
l'environnement du projet :

```text
cat environment.yml
conda env create -f environment.yml
conda activate train
```

La création télécharge les paquets : plusieurs minutes. Pendant ce temps,
lire le README du dépôt.

**Vérification** : l'invite commence par `(train)` ; `magick -version`
affiche la version d'ImageMagick.

### E0.3 Faire tourner le programme

```text
python train.py --help
python train.py --numero 40
```

{fence(une_image, "text")}

```text
python train.py --images 48 --video
```

{fence(video, "text")}

**Vérification** : `start sortie/train.mp4` montre les voiles et la plage
jaune qui défilent vers la gauche, la plage plus vite que les voiles.

## E1 · Lire le code

{encadre("lire `decor/plans.csv` et la fonction `image` ; répondre aux trois questions.",
         "les réponses, vérifiées en lançant le programme.")}

![L'image de départ, couche par couche](illustrations/couches.png)

Chaque image de la vidéo superpose des couches : le fond, puis chaque plan,
découpé dans une bande qui tourne. Le damier marque les pixels
transparents : là, la couche laisse voir celle du dessous. Les plans sont décrits dans
`decor/plans.csv`, du plus lointain au plus proche :

{fence(plans_csv, "text")}

La fonction `image` construit la commande de `magick`, couche par couche :

{fence(image_r2)}

1. Quelle ligne de `image` ajoute un plan à la commande, et combien de
   fois s'exécute-t-elle pour une image ?
2. De combien de colonnes la bande des voiles est-elle décalée à l'image
   numéro 10 ?
3. Que devient l'image si l'on échange les deux dernières lignes de
   `decor/plans.csv` ? L'essayer avec `python train.py --numero 40`, puis
   remettre le fichier dans son état : `git restore decor/plans.csv`.

Les réponses sont à la fin du guide.

## E2 · Effet 1, la fenêtre du train

{encadre("créer deux branches, `fenetre` et `poteaux`, depuis `master` ; sur `fenetre`, poser l'image de la fenêtre sur chaque image de la vidéo ; un commit ; la pull request, fusionnée sur GitHub.",
         "`sortie/train_0040.png` montre le paysage derrière la vitre, dans le cadre noir ; sur GitHub, `master` contient la fenêtre.")}

![Effet 1 : l'image de la fenêtre, dont la vitre est transparente, posée sur l'image de départ](illustrations/fenetre.png)

### E2.1 Deux branches

```text
git branch fenetre
git branch poteaux
git branch
```

`git branch <nom>` crée une branche sur le commit courant, sans s'y placer.
Les deux branches partent du même commit, comme deux personnes qui
commencent chacune une fonctionnalité à partir de la même version.

### E2.2 La fenêtre

```text
git checkout fenetre
```

La fenêtre, `decor/fenetre.png`, est déjà dans le dépôt : une image de
640 × 480 pixels, noire sur le cadre, transparente sur la vitre. Posée en
dernier sur l'image, elle cache les bords du paysage et le laisse voir par
la vitre. Dans la fonction `image`, une ligne de plus l'ajoute à la commande
de `magick`, après la boucle des plans, avec `-composite`, comme chaque
plan.

{blocs(r2, train("e2"))}

**Vérification** : `python train.py --numero 40`, puis ouvrir
`sortie/train_0040.png` : le paysage derrière la vitre, et le cadre noir
autour.

```text
git commit -am "La fenêtre posée sur chaque image"
git push -u origin fenetre
```

### E2.3 La pull request

Sur GitHub : Compare & pull request, Create pull request, Merge pull
request, Confirm merge.

**Vérification** : sur la page du dépôt, `train.py` contient la ligne de la
fenêtre.

## E3 · Effet 2, les ombres des poteaux

{encadre("sur la branche `poteaux` : calculer avec numpy un calque des ombres, et le poser sur chaque image (E3.1) ; la pull request, qui s'arrête sur un conflit (E3.2) ; résoudre le conflit sur le poste (E3.3).",
         "la vidéo montre des bandes sombres qui passent vite sur le paysage, derrière la vitre ; les deux branches sont fusionnées dans `master`.")}

![Effet 2 : le calque des poteaux, sombre sur des bandes et transparent ailleurs, posé sur l'image de départ](illustrations/poteaux.png)

### E3.1 Le calque des poteaux

```text
git checkout poteaux
```

**Vérification** : `train.py` n'a pas la ligne de la fenêtre. La branche
`poteaux` est restée au commit de départ.

Dans le clip, les ombres des poteaux passent très vite devant la vitre. Le
programme les dessine sur un calque : une image de 640 × 480 pixels,
transparente sauf sur des bandes verticales sombres. Pour chaque image de
la vidéo, la fonction `ecrire_poteaux` calcule ce calque et l'écrit dans
`sortie/poteaux.png`, et `image` le pose sur le paysage, comme un plan. Les
bandes se décalent de 90 pixels d'une image à la suivante : dix fois plus
vite que la plage.

numpy représente une image comme un tableau de nombres. Le calque est un
tableau de 480 lignes, 640 colonnes et 4 valeurs par pixel : rouge, vert,
bleu et opacité, chacune de 0 à 255. `np.zeros(…)` crée ce tableau rempli
de zéros : un pixel noir et transparent partout.

`np.arange(640)` est le tableau des numéros de colonnes, de 0 à 639. Les
opérations sur ce tableau se font sur chaque valeur à la fois :
`(np.arange(640) + 90 * numero) % 400 < 24` donne, pour chaque colonne,
`True` si elle tombe dans une bande et `False` sinon. Ce tableau de
booléens choisit des colonnes : `calque[:, colonnes, 3] = 110` règle
l'opacité de ces colonnes, sur toutes les lignes (`:`), à 110 sur 255.

{blocs(r2, train("e3"))}

**Vérification** : `python train.py --numero 3`, puis ouvrir
`sortie/train_0003.png` : deux bandes sombres sur le paysage. Puis
`python train.py --images 48 --video` : les bandes passent vite vers la
gauche.

```text
git commit -am "Les ombres des poteaux"
git push -u origin poteaux
```

### E3.2 La pull request, et le conflit

Sur GitHub, ouvrir la pull request de `poteaux`. La page affiche « This
branch has conflicts that must be resolved » : `master` a changé depuis le
départ de la branche, et les deux branches ont modifié le même endroit de
`train.py`. Le conflit se résout sur le poste, en ramenant `master` dans la
branche :

```text
git pull origin master
```

{fence(messages_pull, "text")}

Dans `train.py`, la fonction `image` contient les deux versions :

{fence(conflit)}

Entre `<<<<<<< HEAD` et `=======` : la version de la branche `poteaux`.
Entre `=======` et `>>>>>>>` : la version de `master`, avec la fenêtre. La
ligne `>>>>>>>` se termine par l'identifiant du dernier commit de `master`,
différent dans chaque dépôt.

### E3.3 Résoudre

L'image finale demande les deux effets : les lignes des deux versions
restent. Les couches se posent de la plus lointaine à la plus proche : le
paysage, les poteaux, qui sont dehors, puis la fenêtre. Remplacer toutes
les lignes, de `<<<<<<< HEAD` jusqu'à `>>>>>>>` compris, par :

{fence(resolution)}

**Vérification** : `python train.py --images 48 --video` : la vidéo de la
dernière image de la figure du début du guide. Ici, le cadre de la fenêtre
est noir, et l'autre ordre des deux lignes donne presque la même image : les
ombres, noires, ne se voient pas sur le cadre noir.

```text
git add train.py
git commit --no-edit
git push
```

Sur GitHub, la pull request n'a plus de conflit : Merge pull request,
Confirm merge. Puis, sur le poste :

```text
git checkout master
git pull
git log --oneline --graph
```

**Vérification** : le graphe dessine les deux branches, réunies dans
`master`.

## E4 (bonus) · Un troisième plan

{encadre("ajouter la plage orange à `decor/plans.csv`, sans modifier le code ; une branche, une pull request.",
         "la vidéo montre trois plans, la plage orange devant, deux fois plus rapide que la plage jaune.")}

`decor/plage.png` est une troisième bande, déjà dans le dépôt. Le programme
lit ses plans dans `decor/plans.csv` : un plan de plus est une ligne de
plus.

```text
git checkout -b plage
echo "plage.png,16" >> decor/plans.csv
python train.py --images 48 --video
```

`>>` ajoute la ligne à la fin du fichier, sans effacer les autres.

```text
git commit -am "Un troisième plan : la plage orange"
git push -u origin plage
```

Puis la pull request, fusionnée sur GitHub, et `git checkout master`,
`git pull` sur le poste.

## Réponses de l'étape E1

1. La ligne `commande = commande + arguments_plan(nom, numero * vitesse)
   + ["-composite"]`, dans la boucle `for` : une fois par ligne de
   `plans.csv`, soit deux fois.
2. De 40 colonnes : le numéro de l'image, 10, fois la vitesse des voiles, 4.
3. `magick` pose les couches dans l'ordre de la commande. Les voiles,
   posées en dernier, passent devant la plage.
"""
    return lier(texte)


def ecrire_guides():
    for td, texte in (("7a_recette", guide_7a()), ("7b_train", guide_7b())):
        cible = GUIDES / td / "guide.md"
        cible.parent.mkdir(parents=True, exist_ok=True)
        cible.write_text(texte, encoding="utf-8")
        print("ok", cible.relative_to(DEPOT))
