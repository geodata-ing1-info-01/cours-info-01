---
title: Amélioration d'un code de génération de recette
execution: ../../travail
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# Amélioration d'un code de génération de recette

Ce notebook améliore un programme qui génère une page de recette, avec deux
bibliothèques livrées avec Python : `pathlib` pour les chemins, `subprocess`
pour lancer un autre programme.

Le notebook suit l'évolution du programme :

1. les fonctions utiles, reprises du cours 1 ;
2. le programme de départ, avec ses chemins écrits en dur ;
3. les chemins construits avec `pathlib`, à partir d'une seule racine, puis
   pour toutes les recettes ;
4. la conversion de la recette en page HTML par pandoc, dans le terminal puis
   depuis Python.

Ce notebook est livré dans `depart/notebook/`. Avant de commencer, le copier
dans `travail/` et ouvrir la copie : `depart/` ne se modifie pas, et les
fichiers produits sont écrits dans `travail/`.

Une ligne de code qui se termine par `# à compléter` contient `...` à la place
de sa valeur, à remplacer par le code attendu. La cellule « Réponse » qui suit
est repliée ; un clic sur « Réponse » l'ouvre.

## 1 · Les fonctions utiles

Les fonctions ci-dessous sont reprises du cours 1. Il faut exécuter la
cellule pour qu'elles soient disponibles dans la suite du notebook. Leurs
lignes `open` et `with` sont expliquées dans le notebook suivant,
`fichiers.ipynb`.

| Fonction | Ce qu'elle reçoit | Ce qu'elle renvoie |
|---|---|---|
| `lire_ingredients(chemin)` | le chemin de `ingredients.csv`, qui donne les quantités pour une personne | une liste de tuples `(nom, quantité, unité)`, par exemple `('Farine', 60.0, 'g')` |
| `adapter(ingredients, personnes, unites)` | cette liste, un nombre de personnes, `"SI"` ou `"US"` | la liste, quantités multipliées, et converties en onces et en tasses si `"US"` |
| `tableau(ingredients)` | une liste d'ingrédients | le tableau Markdown des ingrédients, en une chaîne |

La première ligne du fichier CSV, qui nomme les colonnes, n'est pas dans la
liste. `float` convertit chaque quantité, lue comme du texte, en nombre.

```{code-cell} ipython3
import csv

FACTEURS = {"g": (28.3495, "oz"), "ml": (236.588, "cup")}


def lire_ingredients(chemin):
    """Les ingrédients du fichier CSV, quantités converties en nombres.

    La fonction renvoie une liste de tuples, un par ingrédient :
    le nom (position 0), la quantité en nombre décimal (position 1),
    l'unité de la quantité (position 2).
    """
    ingredients = []
    with open(chemin, encoding="utf-8", newline="") as fichier:
        lecteur = csv.reader(fichier)
        # La première ligne du fichier nomme les colonnes : next() la lit et la
        # laisse de côté, la boucle commence à la ligne suivante.
        next(lecteur)
        for nom, quantite, unite in lecteur:
            ingredients.append((nom, float(quantite), unite))
    return ingredients


def convertir(quantite, unite):
    """Une quantité et son unité, exprimées en unités américaines."""
    if unite in FACTEURS:
        diviseur, nouvelle_unite = FACTEURS[unite]
        return quantite / diviseur, nouvelle_unite
    return quantite, unite


def adapter(ingredients, personnes, unites):
    """La recette pour ce nombre de personnes, dans ce système d'unités."""
    resultat = []
    for nom, quantite, unite in ingredients:
        quantite = quantite * personnes
        if unites == "US":
            quantite, unite = convertir(quantite, unite)
        resultat.append((nom, quantite, unite))
    return resultat


def tableau(ingredients):
    """Le tableau Markdown des ingrédients, quantités écrites à trois chiffres."""
    lignes = ["| Ingrédient | Quantité |", "|---|---|"]
    for nom, quantite, unite in ingredients:
        lignes.append(f"| {nom} | {quantite:.3g} {unite}".rstrip() + " |")
    return "\n".join(lignes)
```

## 2 · Le programme de départ, chemins en dur

Le programme lit les ingrédients, les adapte à quatre personnes, puis insère
leur tableau dans le texte de `recette.md`. Dans ce fichier, le titre
`## Ingrédients` n'est suivi d'aucune ligne : `replace` le remplace par le
même titre suivi du tableau. Le texte obtenu est écrit dans
`travail/crepes.md`.

Les chemins sont écrits en dur : chacun est écrit en entier, depuis la racine
du disque, et n'existe que sur un poste. Ce n'est pas une bonne pratique,
mais on en trouve souvent des variantes dans les rendus. La suite du notebook
améliore ce code.

```{code-cell} ipython3
:tags: [raises-exception]

ingredients = lire_ingredients("C:/Users/alice/Desktop/cours3/1a_recette/depart/recettes/crepes/ingredients.csv")
ingredients = adapter(ingredients, 4, "SI")

with open("C:/Users/alice/Desktop/cours3/1a_recette/depart/recettes/crepes/recette.md", encoding="utf-8") as fichier:
    source = fichier.read()
complete = source.replace("## Ingrédients", "## Ingrédients\n\n" + tableau(ingredients))

with open("C:/Users/alice/Desktop/cours3/1a_recette/travail/crepes.md", "w", encoding="utf-8") as fichier:
    fichier.write(complete)
print(complete)
```

La cellule renvoie une erreur, `FileNotFoundError` : le dossier
`C:/Users/alice/…` n'existe pas sur votre poste.

:::{admonition} À faire
Dans la cellule ci-dessus, remplacez `C:/Users/alice/Desktop/cours3` par le
chemin de votre dossier `cours3`, aux trois endroits, puis exécutez-la de
nouveau. Ce chemin se lit dans la barre d'adresse de l'explorateur de
fichiers ; les `\` de Windows s'y remplacent par des `/`. Le programme doit
écrire le fichier `travail/crepes.md`.
:::

Ce code ne fonctionne que sur le poste où les chemins ont été écrits. Le
donner à quelqu'un d'autre, ou déplacer le dossier, oblige à réécrire trois
lignes.

## 3 · Des chemins construits avec `pathlib`

### 3.1 · Le programme dans une fonction

Le programme est placé dans une fonction, `generer`, dont les trois chemins
sont les paramètres. Le corps de la fonction ne contient plus aucun chemin ;
les chemins sont passés à l'appel. La suite du notebook ne change plus
que la façon de construire ces trois chemins.

```{code-cell} ipython3
def generer(fichier_ingredients, fichier_recette, fichier_sortie, personnes=4, unites="SI"):
    """Écrit la recette complétée par le tableau des ingrédients."""
    ingredients = adapter(lire_ingredients(fichier_ingredients), personnes, unites)

    with open(fichier_recette, encoding="utf-8") as fichier:
        source = fichier.read()
    complete = source.replace("## Ingrédients", "## Ingrédients\n\n" + tableau(ingredients))

    with open(fichier_sortie, "w", encoding="utf-8") as fichier:
        fichier.write(complete)
    print(fichier_sortie, "écrit")
```

### 3.2 · Une seule valeur en dur : la racine

`pathlib` fait partie de la bibliothèque standard, livrée avec Python, et
s'importe sans installation. `Path("…")` déclare un chemin, et l'opérateur `/`
ajoute un dossier ou un fichier à la fin d'un chemin, comme `+` ajoute deux
nombres. Dans le code, un `Path` s'écrit avec des `/` quel que soit le
système ; sous Windows, il s'affiche avec des `\`.

Construire un `Path` ne crée ni fichier ni dossier et ne vérifie pas leur
existence. Documentation :
[docs.python.org/fr/3/library/pathlib.html](https://docs.python.org/fr/3/library/pathlib.html).

```{code-cell} ipython3
from pathlib import Path

dossier = Path("C:/Users/alice/Desktop/cours3/1a_recette")
print(dossier)
print(dossier / "depart" / "recettes")
```

Avec `pathlib`, seul le chemin de la racine du TD, le dossier `1a_recette/`,
reste écrit en dur. Les autres chemins sont construits à partir de la racine
en suivant l'arborescence :

```text
1a_recette/                      ← RACINE
├── depart/
│   └── recettes/
│       └── crepes/              ← RECETTE
│           ├── ingredients.csv  ← FICHIER_INGREDIENTS
│           └── recette.md       ← FICHIER_RECETTE
└── travail/                     ← dossier courant
    ├── recette.ipynb            ← le notebook
    └── crepes.md                ← FICHIER_SORTIE
```

:::{admonition} À faire
Remplacez la valeur de `RACINE` par le chemin de votre dossier `1a_recette/`,
puis complétez les deux chemins marqués sur le modèle de `FICHIER_INGREDIENTS`.
:::

```{code-cell} ipython3
:tags: [raises-exception]

RACINE = Path("C:/Users/alice/Desktop/cours3/1a_recette")

RECETTE = RACINE / "depart" / "recettes" / "crepes"
FICHIER_INGREDIENTS = RECETTE / "ingredients.csv"
FICHIER_RECETTE = RECETTE / "recette.md"  # à compléter
FICHIER_SORTIE = RACINE / "travail" / "crepes.md"  # à compléter

generer(FICHIER_INGREDIENTS, FICHIER_RECETTE, FICHIER_SORTIE)
```

Le code fonctionne sur un autre poste en ne changeant qu'une ligne, tant que
le dossier du TD est copié sans modifier son arborescence.

### 3.3 · La racine déduite du dossier courant

Python connaît le dossier courant, celui d'où partent les chemins relatifs :
`Path.cwd()` le renvoie. Dans un notebook, le dossier courant est celui du
fichier `.ipynb`, ici `travail/`, car le serveur Jupyter y démarre le noyau.
`sys.executable`, le chemin de l'interpréteur Python, est ailleurs : le
dossier courant ne dépend pas de l'endroit où Python est installé.

La racine du TD est le dossier au-dessus de `travail/` : `parent` en Python,
`..` dans un chemin relatif. Un chemin relatif s'affiche tel qu'il a été
écrit, `..` compris ; `resolve()` le transforme en chemin absolu. `exists()`
dit si un chemin existe sur le disque.

```{code-cell} ipython3
import sys

print(Path.cwd())                                     # le dossier courant : …/1a_recette/travail
print(sys.executable)                                 # l'interpréteur Python
print((Path.cwd() / "recette.ipynb").exists())        # True : le notebook est dans le dossier courant
print(Path.cwd().parent)                              # le dossier au-dessus, en absolu
print(Path("..") / "depart" / "recettes")             # en relatif, tel qu'écrit
print((Path("..") / "depart" / "recettes").resolve()) # le même dossier, en absolu
```

La racine est maintenant calculée à partir du dossier courant, et plus aucun
chemin n'est écrit en dur.

```{code-cell} ipython3
RACINE = Path.cwd().parent  # à compléter

RECETTE = RACINE / "depart" / "recettes" / "crepes"
FICHIER_INGREDIENTS = RECETTE / "ingredients.csv"
FICHIER_RECETTE = RECETTE / "recette.md"
FICHIER_SORTIE = RACINE / "travail" / "crepes.md"

generer(FICHIER_INGREDIENTS, FICHIER_RECETTE, FICHIER_SORTIE)
```

Le même code fonctionne maintenant sur n'importe quel poste, à condition que
`depart/` et `travail/` soient côte à côte.

### 3.4 · Toutes les recettes

Le dossier `depart/recettes/` contient quatre dossiers, un par recette, tous
organisés de la même façon. Pour produire une page par recette, le programme
parcourt ces dossiers et nomme chaque fichier produit d'après le nom du
dossier.

```text
1a_recette/                      ← RACINE
├── depart/
│   └── recettes/                ← RECETTES
│       ├── crepes/              ← dossier, à la première itération
│       │   ├── ingredients.csv
│       │   └── recette.md
│       ├── …
│       └── salade_lentilles/    ← dossier, à la dernière itération
└── travail/
    ├── crepes.md                ← produit à la première itération
    ├── …
    └── salade_lentilles.md      ← produit à la dernière itération
```

`iterdir()` renvoie chaque entrée d'un dossier, fichiers et dossiers, sans
ordre garanti : `sorted` les trie. `is_dir()` ne garde que les dossiers, et
`name` donne le nom seul, sans le chemin.

```{code-cell} ipython3
RECETTES = RACINE / "depart" / "recettes"

for dossier in sorted(RECETTES.iterdir()):
    print(dossier.name, dossier.is_dir())
```

`name` est l'une des parties d'un chemin que `pathlib` renvoie. Les exemples
suivants portent sur le fichier de la recette des crêpes.

```{code-cell} ipython3
chemin = RECETTES / "crepes" / "recette.md"

print(chemin.name)                     # le nom du fichier : recette.md
print(chemin.stem)                     # le nom sans l'extension : recette
print(chemin.suffix)                   # l'extension, point compris : .md
print(chemin.parent)                   # le dossier qui le contient
print(chemin.parent.name)              # le nom de ce dossier : crepes
print(chemin.relative_to(RACINE))      # le chemin à partir de RACINE
print(chemin.with_suffix(".html"))     # le même chemin, autre extension
print(chemin.with_name("ingredients.csv"))  # le même dossier, autre nom de fichier
```

Le programme appelle `generer` une fois par dossier de recette. Le fichier
produit porte le nom du dossier, avec l'extension `.md` : `with_suffix(".md")`
l'ajoute au chemin `travail/crepes`.

```{code-cell} ipython3
for dossier in sorted(RECETTES.iterdir()):
    if dossier.is_dir():
        fichier_sortie = (RACINE / "travail" / dossier.name).with_suffix(".md")  # à compléter
        generer(dossier / "ingredients.csv", dossier / "recette.md", fichier_sortie)
```

## 4 · Convertir avec pandoc

`travail/crepes.md` est un fichier Markdown. pandoc, livré avec Anaconda, le
convertit en page HTML. pandoc est un programme, qui se lance dans le
terminal ; il ne s'importe pas comme une bibliothèque Python. Documentation :
[pandoc.org/MANUAL.html](https://pandoc.org/MANUAL.html) (toutes les options)
et [pandoc.org/demos.html](https://pandoc.org/demos.html) (des exemples de
commandes).

### 4.1 · Dans le terminal

Dans Anaconda Prompt, se placer dans `travail/` (le chemin affiché par
`Path.cwd()` à la section 3.3), puis lancer pandoc :

```
(base) C:\Users\moi> cd Desktop\cours3\1a_recette\travail
(base) C:\Users\moi\Desktop\cours3\1a_recette\travail> pandoc crepes.md -o crepes.html
```

La commande se lit ainsi :

- `pandoc` : le programme lancé ;
- `crepes.md` : le fichier à lire, l'entrée ; pandoc la prend sans option
  (beaucoup d'autres programmes utilisent `-i`, pour `--input`) ;
- `-o crepes.html` : le fichier à écrire ; `-o` est le raccourci
  d'`--output`, la sortie ;
- le format de sortie est déduit de l'extension, ici `.html`.

Les chemins donnés à pandoc partent du dossier courant du terminal. Depuis
`cours3/`, la même conversion s'écrit avec les chemins jusqu'à `travail/`,
pour l'entrée comme pour la sortie ; avec `-o crepes.html` seul, la page
serait écrite dans `cours3/`, alors que `crepes.md` est dans `travail/`.

```
(base) C:\Users\moi\Desktop\cours3> pandoc 1a_recette\travail\crepes.md -o 1a_recette\travail\crepes.html
```

Ouvrir `crepes.html` par un double-clic.

### 4.2 · Depuis le notebook, avec `!`

Une cellule qui commence par `!` n'est pas du Python : la ligne est passée au
terminal, et sa sortie s'affiche sous la cellule. Cette syntaxe, propre aux
notebooks, permet d'essayer une commande sans changer de fenêtre.

Chaque option de pandoc change la page produite :

| Option | Ce qui change |
|---|---|
| (aucune) | un fragment : le contenu, sans `<html>` ni en-tête |
| `--standalone`, ou `-s` | une page complète ; sans titre déclaré, pandoc prend le nom du fichier et affiche un avertissement |
| `--metadata title=Crêpes` | le titre de la page, affiché dans l'onglet |
| `--css style.css` | le lien vers une feuille de style ; le chemin est celui que le navigateur suit depuis la page |
| `--toc` | une table des matières, construite sur les titres |

Les cellules suivantes ajoutent ces options une à une. Ouvrir `crepes.html`
après chacune pour voir la différence.

```{code-cell} ipython3
!pandoc crepes.md -o crepes.html
print(Path("crepes.html").read_text(encoding="utf-8")[:120])
```

```{code-cell} ipython3
!pandoc crepes.md -o crepes.html --standalone --metadata title=Crêpes
print(Path("crepes.html").read_text(encoding="utf-8")[:120])
```

La feuille de style est d'abord copiée de `depart/` à côté de la page.

```{code-cell} ipython3
import shutil

shutil.copy(RACINE / "depart" / "style.css", "style.css")
!pandoc crepes.md -o crepes.html --standalone --metadata title=Crêpes --css style.css --toc
```

Le format de sortie suit l'extension : `.docx` pour Word, `.odt` pour
LibreOffice, `.txt` avec `-t plain` pour du texte sans balise. pandoc lit
aussi la plupart des formats qu'il écrit : le document Word se reconvertit en
Markdown. `--list-output-formats` donne la liste complète.

```{code-cell} ipython3
!pandoc crepes.md -o crepes.docx
!pandoc crepes.docx -o retour.md
print(Path("retour.md").read_text(encoding="utf-8")[:300])
```

### 4.3 · Où le terminal trouve pandoc

*Cette section se lit et s'exécute après la séance. En séance, passer à la
section 4.4.*

Le terminal a lancé `pandoc` sans qu'on lui dise où est le programme. Il l'a
cherché dans une liste de dossiers, la variable d'environnement `PATH`.
`shutil.which` fait la même recherche et renvoie le chemin absolu trouvé ;
`{chemin}`, dans une ligne `!`, insère la variable Python dans la commande.

```{code-cell} ipython3
chemin = shutil.which("pandoc")
print(chemin)
!"{chemin}" --version
```

Les variables d'environnement se lisent depuis Python dans `os.environ`, qui
est un dictionnaire. `PATH` est une seule chaîne de caractères, où les
dossiers sont séparés par `;` sous Windows et `:` ailleurs ; `os.pathsep`
donne le bon séparateur.

```{code-cell} ipython3
import os

dossiers = os.environ["PATH"].split(os.pathsep)   # une liste, un dossier par élément
print(len(dossiers), "dossiers")

dossier_pandoc = Path(chemin).parent
for dossier in dossiers:
    if Path(dossier) == dossier_pandoc:
        print(dossier, "  <- pandoc est ici")
    else:
        print(dossier)
```

Une commande « introuvable » est un programme dont le dossier n'est pas dans
cette liste. `conda activate` modifie le `PATH` ; une commande peut donc
exister dans un environnement et manquer dans un autre. Sous
Windows, conda range les programmes qui ne sont pas du Python, pandoc compris,
dans `Library\bin`.

### 4.4 · Appeler pandoc depuis Python

La syntaxe `!` ne fonctionne que dans un notebook. Dans un programme Python,
une commande se lance avec la bibliothèque standard, de deux façons :

- `os.system` reçoit la ligne de commande en une seule chaîne, et renvoie le
  code de retour du programme, 0 si tout s'est bien passé ;
- `subprocess.run` reçoit le programme et ses arguments dans une liste.

`subprocess.run` est la forme à utiliser : chaque élément de la liste arrive
au programme tel quel, espaces et accents compris, l'affichage du programme
peut être récupéré, et `check=True` déclenche une erreur Python si la
commande échoue.

```{code-cell} ipython3
import os

code = os.system("pandoc crepes.md -o crepes.html --standalone --metadata title=Crêpes")
print(code)
```

:::{admonition} À faire
Écrivez la même commande sous forme de liste : un élément par mot de la
ligne de commande, `"pandoc"` compris.
:::

```{code-cell} ipython3
import subprocess

commande = ["pandoc", "crepes.md", "-o", "crepes.html", "--standalone", "--metadata", "title=Crêpes"]  # à compléter
subprocess.run(commande, check=True)
```

`capture_output=True` récupère ce que le programme affiche, et `text=True`
le convertit en chaîne.

```{code-cell} ipython3
resultat = subprocess.run(["pandoc", "--version"], capture_output=True, text=True)
print(resultat.returncode)
print(resultat.stdout.splitlines()[0])
```

Un chemin `Path` se passe à `subprocess` par `str(chemin)` : la commande ne
reçoit que des chaînes de caractères. Le TD 3a emploie cette forme.
