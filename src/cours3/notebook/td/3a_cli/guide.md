---
title: "TD 3a — Une ligne de commande pour la recette"
subtitle: Guide détaillé, étape par étape
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# TD 3a — Une ligne de commande pour la recette

Ce guide détaille les étapes de la feuille du TD 3a. Pour chaque étape, il
indique :

- le dossier dans lequel se placer ;
- les fichiers au début et à la fin de l'étape ;
- le code à écrire, et l'endroit du fichier où l'écrire ;
- les commandes à taper dans le terminal ;
- comment vérifier que chaque commande a fonctionné.

Le TD transforme le code du notebook `recette.ipynb` (TD 1a) en un programme
`recette.py`, lancé depuis un terminal. Chaque étape se termine par un commit
git.

Le tableau résume les étapes ; chaque numéro d'étape renvoie à la page qui
la détaille. Chaque page commence par un encadré qui résume l'étape.

| Étape | Ce qu'on fait | Commits à la fin |
|---|---|---|
| [0](#étape-0-préparer-le-dossier-de-travail-et-le-dépôt-git) | préparer le dossier `travail/` et créer le dépôt git | 0 |
| [1](#étape-1-le-code-du-notebook-dans-un-fichier) | écrire `recette.py` à partir du notebook | 1 |
| [2](#étape-2-une-fonction-main) | mettre le programme dans une fonction `main` | 2 |
| [3](#étape-3-les-arguments-sur-une-branche) | lire la recette, le nombre de personnes et les unités sur la ligne de commande, sur une branche | 5 |
| [4](#étape-4-un-readme) | écrire un `README.md` | 6 |
| [5](#étape-5-facultative-le-code-dans-src-les-données-dans-data) (facultatif, après la séance) | ranger le code dans `src/` et les données dans `data/` | 7 |
| [6](#étape-6-facultative-une-commande-installée) (facultatif, après la séance) | installer le programme comme une commande | 8 |

## Rappels avant de commencer

**Un seul outil : VS Code.** Tout le TD se fait dans VS Code :
l'explorateur, à gauche, montre les fichiers ; l'éditeur, au centre,
affiche le fichier ouvert ; le terminal, en bas, sert à taper les
commandes.

**Le terminal Git Bash.** Le terminal est Git Bash, celui du cours 2. Pour
l'ouvrir : menu Terminal → Nouveau terminal. Si le terminal ouvert n'est pas
Git Bash, cliquer sur la flèche à côté du `+`, en haut à droite du panneau
du terminal, puis choisir « Git Bash ».

![Ouvrir un terminal Git Bash dans VS Code](illustrations/vscode.png)

L'invite de Git Bash tient sur plusieurs lignes : le nom de l'environnement
conda actif entre parenthèses, `(base)`, puis `eleve@POSTE MINGW64` suivi
du dossier courant ; la dernière ligne commence par `$`, et la commande se
tape après. Les chemins relatifs des commandes partent du dossier courant.
Dans Git Bash, les chemins s'écrivent avec des `/` : `C:\Users` devient
`/c/Users`.

**Changer de dossier.** `pwd` affiche le dossier courant, `ls` liste son
contenu, `cd nom_du_dossier` descend dans un sous-dossier, `cd ..` remonte
d'un niveau. L'[annexe](#annexe-les-commandes-des-deux-terminaux) rappelle les commandes du terminal
Windows (`cmd`) et de Git Bash.

**Enregistrer un fichier.** Dans VS Code, `Ctrl+S`. Un fichier modifié et
non enregistré a un point blanc sur son onglet ; `python` lit le fichier
enregistré sur le disque, pas ce qui est affiché dans l'éditeur.

**Si une étape échoue.** `git status` montre les fichiers modifiés depuis le
dernier commit. `git restore recette.py` remet `recette.py` dans l'état du
dernier commit. Le résultat attendu de l'étape 1 est dans
`depart/secours/recette.py`.

## Étape 0 · Préparer le dossier de travail et le dépôt git

> **À faire :** copier `depart/recettes/` et `depart/style.css` dans `travail/` ; ouvrir `travail/` dans VS Code, avec un terminal Git Bash ; une fois par poste, rendre `conda` disponible dans Git Bash ; `git init` ; un fichier `.gitignore` avec la ligne `sortie/`.
>
> **À obtenir :** `git status` liste `recettes/`, `style.css` et `.gitignore`, et pas `depart/`.

**Dossier de départ** : `cours3/3a_cli/`, tel que décompressé depuis
l'archive.

```text
3a_cli/
├── depart/
│   ├── recettes/
│   │   ├── crepes/
│   │   │   ├── ingredients.csv
│   │   │   ├── photo.jpg
│   │   │   └── recette.md
│   │   ├── mousse_chocolat/        (même contenu)
│   │   ├── pate_pizza/             (même contenu)
│   │   ├── salade_lentilles/       (même contenu)
│   │   └── CREDITS.md
│   ├── style.css
│   ├── modeles/
│   │   ├── README.md
│   │   └── pyproject.toml
│   ├── secours/
│   │   └── recette.py
│   └── outils/
└── travail/                        (vide)
```

### 0.1 Copier les données dans `travail/`

Dans l'explorateur de fichiers Windows, copier le dossier
`depart/recettes/` et le fichier `depart/style.css` dans `travail/`.

**Vérification** : `travail/` contient `recettes/` et `style.css`.

### 0.2 Ouvrir `travail/` dans VS Code

Dans VS Code : Fichier → Ouvrir le dossier… → choisir `3a_cli/travail/`.
Ouvrir ensuite un terminal Git Bash (voir les rappels).

**Vérification** : le panneau de gauche de VS Code affiche `recettes/` et
`style.css` ; dans le terminal, `pwd` affiche un chemin qui se termine par
`3a_cli/travail`.

Si ce n'est pas le cas, taper `cd` suivi du chemin du dossier `travail/`,
par exemple :

```text
cd /c/Users/eleve/Desktop/info01/cours3/3a_cli/travail
```

### 0.3 conda dans Git Bash

Le programme utilise le Python et le pandoc d'Anaconda. Git Bash ne connaît
pas la commande `conda` au démarrage. Dans le terminal :

```text
source /c/ProgramData/anaconda3/etc/profile.d/conda.sh
conda init bash
```

`source` rend `conda` disponible dans ce terminal. `conda init bash` écrit la
même instruction dans un fichier que Git Bash lit à chaque ouverture : les
terminaux suivants ont `conda`, et l'environnement `base` est activé sans
rien taper. Cette partie ne se fait qu'une fois par poste.

Fermer le terminal (icône de corbeille, en haut à droite du panneau du
terminal) et en ouvrir un nouveau, Git Bash.

**Vérification** : la première ligne de l'invite est `(base)`. Puis :

```text
which python
pandoc --version
```

`which python` affiche `/c/ProgramData/anaconda3/python` ; `pandoc
--version` affiche `pandoc 2…` ou `pandoc 3…`.

Si `source` répond `No such file or directory`, Anaconda est installé dans
un autre dossier du poste. Essayer
`source /c/Users/$USERNAME/anaconda3/etc/profile.d/conda.sh`, ou demander à
l'enseignant.

Si chaque nouveau terminal affiche l'aide de `cygpath` (`Usage: cygpath …`)
puis `bash: : No such file or directory`, l'environnement est tout de même
activé. Le message vient d'un `cygpath` fourni par Anaconda, qui échoue
sous Git Bash. Pour le faire disparaître, taper une fois, puis ouvrir un
nouveau terminal :

```text
sed -i '1i cygpath() { /usr/bin/cygpath "$@"; }' ~/.bash_profile
```

### 0.4 Créer le dépôt git

Dans le terminal, dans `travail/` :

```text
git init
```

**Vérification** : git affiche `Initialized empty Git repository in
…/travail/.git/` (ou `Dépôt Git vide initialisé`, selon la langue). Puis :

```text
git status
```

affiche `recettes/` et `style.css` sous « Untracked files » (« Fichiers non
suivis »). Si
`git status` affiche `depart/`, le dépôt a été créé dans `3a_cli/` au lieu de
`travail/` : supprimer le dossier caché `3a_cli/.git`, revenir dans
`travail/` et recommencer.

Vérifier aussi que git connaît votre nom (réglé au cours 2) :

```text
git config user.name
```

Si la commande n'affiche rien :

```text
git config --global user.name "Prénom Nom"
git config --global user.email "prenom.nom@example.com"
```

### 0.5 Le fichier `.gitignore`

Le programme écrira ses pages dans un dossier `sortie/`. Ces fichiers sont
produits par le programme : ils ne sont pas versionnés.

Dans le terminal, dans `travail/` :

```text
echo "sortie/" > .gitignore
cat .gitignore
```

**Vérification** : `cat` affiche `sortie/` ; `git status` affiche aussi
`.gitignore` parmi les fichiers non suivis.

**Dossier à la fin de l'étape 0** :

```text
travail/
├── .git/            (caché : le dépôt)
├── .gitignore
├── recettes/
└── style.css
```

Pas de commit à cette étape : le premier commit vient avec le code.

## Étape 1 · Le code du notebook dans un fichier

> **À faire :** écrire `recette.py` en quatre blocs, avec le code donné ; `git add .`, puis le premier commit.
>
> **À obtenir :** `python recette.py` écrit `sortie/crepes.html` ; `git log --oneline` affiche une ligne.

**Entrée** : les cellules du notebook `recette.ipynb` (TD 1a), dans leur
version finale : sections 1, 3.1, 3.3 et 4.4.

**Sortie** : un fichier `travail/recette.py` ; lancé par
`python recette.py`, il écrit `sortie/crepes.html`.

Créer le fichier `recette.py` dans `travail/` (clic droit → Nouveau fichier).
Le fichier se remplit en quatre blocs, dans cet ordre, de haut en bas.

### 1.1 En tête : les imports, les trois valeurs, les chemins

Coller en haut du fichier :

```python
"""La recette des crêpes pour quatre personnes, en page HTML, par pandoc."""

import csv
import shutil
import subprocess
from pathlib import Path

# Les trois valeurs à changer
NOM = "crepes"
PERSONNES = 4
UNITES = "SI"      # "SI" ou "US"

# Les chemins partent du dossier du terminal (section 3.3 du notebook)
RACINE = Path.cwd()
DONNEES = RACINE / "recettes"
STYLE = RACINE / "style.css"
SORTIE = RACINE / "sortie"
```

Enregistrer, puis dans le terminal, dans `travail/` :

```text
python recette.py
```

**Vérification** : la commande ne fait rien et n'affiche rien. Pas de
message d'erreur : les imports et les chemins sont corrects.

### 1.2 Les fonctions utiles

Sous le bloc précédent, coller les fonctions de la section 1 du notebook
(elles sont reproduites ici) :

```python
FACTEURS = {"g": (28.3495, "oz"), "ml": (236.588, "cup")}


def lire_ingredients(chemin):
    """Les ingrédients du fichier CSV, quantités converties en nombres."""
    ingredients = []
    with open(chemin, encoding="utf-8", newline="") as fichier:
        lecteur = csv.reader(fichier)
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

**Vérification** : `python recette.py` ne fait toujours rien. Les `def`
définissent les fonctions sans les exécuter.

### 1.3 Le programme : la recette complétée en Markdown

Sous les fonctions, écrire le programme, qui reprend le corps de la fonction
`generer` du notebook (section 3.1) avec les chemins de la section 3.3. Les
deux blocs `with` du notebook sont écrits ici avec `read_text` et
`write_text` (notebook `fichiers.ipynb`, section 11).

```python
# La recette : le tableau des ingrédients inséré sous « ## Ingrédients »
ingredients = lire_ingredients(DONNEES / NOM / "ingredients.csv")
ingredients = adapter(ingredients, PERSONNES, UNITES)
source = (DONNEES / NOM / "recette.md").read_text(encoding="utf-8")
titre = source.splitlines()[0].lstrip("# ")
intitule = f"## Ingrédients pour {PERSONNES} personnes en {UNITES}"   # les valeurs entre accolades sont insérées dans le texte
complete = source.replace("## Ingrédients", intitule + "\n\n" + tableau(ingredients))

# Le Markdown complet et la feuille de style, dans sortie/
SORTIE.mkdir(exist_ok=True)
markdown = SORTIE / (NOM + ".md")
markdown.write_text(complete, encoding="utf-8")
shutil.copy(STYLE, SORTIE / "style.css")
```

La ligne `titre = …` prend la première ligne de la recette (`# Crêpes`) et
retire le `#` et l'espace : pandoc s'en sert comme titre de la page.
`shutil.copy` copie la feuille de style à côté de la page.

Enregistrer, puis `python recette.py`.

**Vérification** : un dossier `sortie/` apparaît dans `travail/`, avec
`crepes.md` et `style.css`. Ouvrir `sortie/crepes.md` dans VS Code : le
tableau des ingrédients est sous « ## Ingrédients ».

### 1.4 Le programme : la page HTML par pandoc

À la fin du fichier, coller l'appel de pandoc de la section 4.3 du notebook :

```python
# La page HTML, par pandoc
page = SORTIE / (NOM + ".html")
subprocess.run(
    ["pandoc", str(markdown), "-o", str(page),
     "--standalone", "--css", "style.css", "--metadata", "title=" + titre],
    check=True,
)
print(page, ":", PERSONNES, "personne(s), unités", UNITES)
```

`subprocess.run` ne prend que des chaînes : les chemins `Path` sont passés
par `str(…)`. Dans un fichier `.py`, rien ne s'affiche sans `print`.

Enregistrer, puis `python recette.py`.

**Vérification** : le terminal affiche le chemin de la page, suivi de
`: 4 personne(s), unités SI`. `sortie/crepes.html` existe ; un double-clic
dans l'explorateur l'ouvre dans le navigateur, avec le tableau et le style.

**Erreurs fréquentes** :

- `FileNotFoundError: … recettes\crepes\ingredients.csv` : le terminal
  n'est pas dans `travail/`. `Path.cwd()` est le dossier du terminal.
- `FileNotFoundError` sur `pandoc`, ou `python: command not found` : la
  première ligne de l'invite n'est pas `(base)`, conda n'est pas activé
  dans ce terminal. Refaire l'étape 0.3.
- `IndentationError` : une ligne collée a gardé des espaces en trop au
  début. Les lignes du programme commencent en colonne 1.

### 1.5 Le premier commit

Dans le terminal, dans `travail/` :

```text
git status
```

**Vérification** : `.gitignore`, `recette.py`, `recettes/` et `style.css`
sont listés comme non suivis. `sortie/` n'est pas listé : `.gitignore`
l'exclut.

```text
git add .
git commit -m "Le programme du notebook, dans un fichier"
```

**Vérification** : git affiche le nombre de fichiers ajoutés. Puis :

```text
git status
git log --oneline
```

`git status` affiche « rien à valider, la copie de travail est propre » ;
`git log --oneline` affiche une ligne.

**Dossier à la fin de l'étape 1** :

```text
travail/
├── .git/
├── .gitignore
├── recette.py
├── recettes/
├── sortie/          (non versionné)
│   ├── crepes.html
│   ├── crepes.md
│   └── style.css
└── style.css
```

## Étape 2 · Une fonction `main`

> **À faire :** mettre le programme dans `def main():`, appelée sous `if __name__ == "__main__":` ; un commit.
>
> **À obtenir :** la même page ; deux lignes dans `git log --oneline`.

**Entrée** : `recette.py` de l'étape 1.

**Sortie** : le même fichier, dont le programme est dans une fonction
`main`, appelée en bas du fichier. La page produite est la même.

### 2.1 Le programme dans `main`

Dans `recette.py`, repérer la première ligne du programme :

```python
# La recette : le tableau des ingrédients inséré sous « ## Ingrédients »
```

Juste au-dessus, écrire :

```python
def main():
```

Sélectionner toutes les lignes du programme, de ce commentaire jusqu'au
`print` final, et appuyer sur `Tab` : elles se décalent de quatre espaces.
Enregistrer.

Le bas du fichier doit ressembler à ceci :

```python
def main():
    # La recette : le tableau des ingrédients inséré sous « ## Ingrédients »
    ingredients = lire_ingredients(DONNEES / NOM / "ingredients.csv")
    ...
    print(page, ":", PERSONNES, "personne(s), unités", UNITES)
```

Supprimer le dossier `sortie/` dans l'explorateur, puis `python recette.py`.

**Vérification** : rien ne s'affiche et `sortie/` n'est pas recréé. `def main():`
définit la fonction ; rien ne l'appelle encore.

### 2.2 L'appel de `main`

À la toute fin du fichier, sans indentation, ajouter :

```python


if __name__ == "__main__":
    main()
```

Enregistrer, puis `python recette.py`.

**Vérification** : la page est de nouveau produite, avec le même message
qu'à l'étape 1.

### 2.3 Le commit

```text
git diff
```

**Vérification** : les lignes du programme apparaissent deux fois, en rouge
(sans indentation) et en vert (avec quatre espaces) ; les lignes
`def main():` et `if __name__ …` sont en vert. Taper `q` pour quitter
l'affichage.

```text
git commit -am "Une fonction main"
git log --oneline
```

`-a` ajoute les fichiers déjà suivis qui ont été modifiés : pas besoin de
`git add recette.py`.

**Vérification** : `git log --oneline` affiche deux lignes.

## Étape 3 · Les arguments, sur une branche

> **À faire :** sur une branche `arguments`, ajouter trois arguments `argparse`, un commit par argument ; puis `git checkout master` et `git merge arguments`.
>
> **À obtenir :** `python recette.py pate_pizza -p 6 -u US` écrit la page ; cinq commits.

**Entrée** : `recette.py` de l'étape 2, où `NOM`, `PERSONNES` et `UNITES`
sont écrits en tête du fichier.

**Sortie** : les trois valeurs sont lues sur la ligne de commande :

```text
python recette.py pate_pizza -p 6 -u US
```

Le travail se fait sur une branche `arguments`, un commit par argument, puis
la branche est fusionnée dans `master`.

### 3.1 Créer la branche

```text
git checkout -b arguments
git branch
```

**Vérification** : `git branch` affiche `master` et `* arguments` ;
l'étoile marque la branche courante.

### 3.2 Premier argument : le nom de la recette

En tête du fichier, ajouter `import argparse` avec les autres imports :

```python
import argparse
import csv
...
```

Supprimer la ligne `NOM = "crepes"` en tête du fichier.

Au début de `main`, avant le commentaire « La recette … », coller (en
gardant les quatre espaces d'indentation) :

```python
    # Les valeurs viennent de la ligne de commande
    analyseur = argparse.ArgumentParser(description="Met une recette à l'échelle et en fait une page HTML.")
    # Les recettes disponibles : les dossiers de recettes/ (section 3.4 du notebook)
    recettes_disponibles = []
    for dossier in sorted(DONNEES.iterdir()):
        if dossier.is_dir():
            recettes_disponibles.append(dossier.name)
    analyseur.add_argument("nom", choices=recettes_disponibles, help="la recette")
    options = analyseur.parse_args()
    NOM = options.nom
```

Enregistrer. **Vérifications**, dans l'ordre :

| Commande | Ce qui doit s'afficher |
|---|---|
| `python recette.py` | `error: the following arguments are required: nom` |
| `python recette.py gaufres` | `error: argument nom: invalid choice: 'gaufres'` et la liste des recettes |
| `python recette.py mousse_chocolat` | la page `sortie/mousse_chocolat.html` est écrite |
| `python recette.py --help` | l'aide : `nom` et sa liste de valeurs |

Puis le commit :

```text
git commit -am "Argument : le nom de la recette"
```

### 3.3 Deuxième argument : le nombre de personnes

Supprimer la ligne `PERSONNES = 4` en tête du fichier. Dans `main`, sous la
ligne `analyseur.add_argument("nom", …)`, ajouter :

```python
    analyseur.add_argument("-p", "--personnes", type=int, default=4, help="nombre de personnes (défaut : 4)")
```

et sous la ligne `NOM = options.nom` :

```python
    PERSONNES = options.personnes
```

Enregistrer. **Vérifications** :

| Commande | Ce qui doit s'afficher |
|---|---|
| `python recette.py pate_pizza -p 6` | `… : 6 personne(s), unités SI` |
| `python recette.py pate_pizza` | `… : 4 personne(s)` : la valeur par défaut |
| `python recette.py pate_pizza -p six` | `error: argument -p/--personnes: invalid int value: 'six'` |

```text
git commit -am "Argument : le nombre de personnes"
```

### 3.4 Troisième argument : les unités

Supprimer la ligne `UNITES = "SI"` en tête du fichier. Dans `main`, sous la
ligne `--personnes`, ajouter :

```python
    analyseur.add_argument("-u", "--unites", choices=("SI", "US"), default="SI", help="unités du tableau (défaut : SI)")
```

et sous `PERSONNES = options.personnes` :

```python
    UNITES = options.unites
```

Enregistrer. **Vérifications** :

| Commande | Ce qui doit s'afficher |
|---|---|
| `python recette.py pate_pizza -p 6 -u US` | `… : 6 personne(s), unités US` ; la page donne des `oz` et des `cup` |
| `python recette.py --help` | les trois arguments, avec leurs textes d'aide |

```text
git commit -am "Argument : les unités"
git log --oneline
```

**Vérification** : cinq lignes.

Le début de `main` doit maintenant être :

```python
def main():
    # Les valeurs viennent de la ligne de commande
    analyseur = argparse.ArgumentParser(description="Met une recette à l'échelle et en fait une page HTML.")
    # Les recettes disponibles : les dossiers de recettes/ (section 3.4 du notebook)
    recettes_disponibles = []
    for dossier in sorted(DONNEES.iterdir()):
        if dossier.is_dir():
            recettes_disponibles.append(dossier.name)
    analyseur.add_argument("nom", choices=recettes_disponibles, help="la recette")
    analyseur.add_argument("-p", "--personnes", type=int, default=4, help="nombre de personnes (défaut : 4)")
    analyseur.add_argument("-u", "--unites", choices=("SI", "US"), default="SI", help="unités du tableau (défaut : SI)")
    options = analyseur.parse_args()
    NOM = options.nom
    PERSONNES = options.personnes
    UNITES = options.unites

    # La recette : le tableau des ingrédients inséré sous « ## Ingrédients »
    ...
```

### 3.5 Fusionner la branche dans `master`

```text
git checkout master
```

**Vérification** : ouvrir `recette.py` dans VS Code : les lignes
`argparse` ont disparu. Le fichier est dans l'état du dernier commit de
`master`, celui de l'étape 2.

```text
git merge arguments
git log --oneline --graph
```

**Vérification** : git affiche `Fast-forward` (avance rapide) ;
`recette.py` contient de nouveau les trois arguments ; `git log` affiche cinq
commits sur une seule ligne verticale. `python recette.py crepes -p 2`
fonctionne.

Le graphe des commits, avant et après la fusion :

![La branche arguments, avant et après la fusion](illustrations/branche.png)

`git log --oneline --graph` affiche les commits du plus récent au plus
ancien, `c5` en haut. Les identifiants à sept caractères sont différents
sur chaque poste :

```text
* 4d9b3f1 (HEAD -> master, arguments) Argument : les unités
* 91c07e5 Argument : le nombre de personnes
* 2a6f8d0 Argument : le nom de la recette
* e35b712 Une fonction main
* 0c4a9e8 Le programme du notebook, dans un fichier
```

## Étape 4 · Un README

> **À faire :** compléter le README à partir de `depart/modeles/README.md` ; `git add README.md` ; un commit.
>
> **À obtenir :** six commits.

**Entrée** : le modèle `depart/modeles/README.md`.

**Sortie** : `travail/README.md`, complété et versionné.

### 4.1 Copier le modèle

Dans l'explorateur, copier `depart/modeles/README.md` dans `travail/`.
L'ouvrir dans VS Code. Il contient cinq parties et des passages
« (À compléter …) ».

### 4.2 Compléter

Remplacer chaque passage « (À compléter …) » :

- la phrase d'objectif : ce que fait le programme, en une phrase ;
- l'installation : comment récupérer le dossier (archive ou `git clone`) ;
- l'exécution : un exemple avec `-p` et `-u`, par exemple
  `python recette.py pate_pizza -p 6 -u US` ;
- les recettes disponibles : les noms des dossiers de `recettes/` ;
- l'auteur : votre nom.

**Vérification** : `Ctrl+Maj+V` dans VS Code affiche l'aperçu de la page.
Chaque commande écrite dans le README fonctionne quand on la colle dans le
terminal, depuis `travail/`.

### 4.3 Le commit

`README.md` est un fichier nouveau : `git commit -a` ne l'ajoute pas.

```text
git add README.md
git commit -m "Un README"
git log --oneline
```

**Vérification** : six lignes.

**Dossier à la fin de l'étape 4** (fin du TD obligatoire) :

```text
travail/
├── .git/
├── .gitignore
├── README.md
├── recette.py
├── recettes/
├── sortie/          (non versionné)
└── style.css
```

## Étape 5 (facultative) · Le code dans `src/`, les données dans `data/`

> **À faire :** déplacer le code dans `src/` et les données dans `data/` avec `git mv` ; les chemins partent de `__file__` ; un commit.
>
> **À obtenir :** le programme fonctionne depuis un autre dossier ; sept commits.

**Sortie** : le programme se lance depuis n'importe quel dossier ; les
données sont trouvées à partir du dossier du script, et non plus du dossier
du terminal.

### 5.1 Déplacer les fichiers avec git

Dans le terminal, dans `travail/` :

```text
mkdir src
mkdir data
git mv recette.py src/recette.py
git mv recettes data/recettes
git mv style.css data/style.css
git status
```

**Vérification** : `git status` affiche trois renommages (`renamed:` ou
`renommé :`).

### 5.2 Les chemins partent du script

Dans `src/recette.py`, remplacer les quatre lignes de chemins :

```python
RACINE = Path.cwd()
DONNEES = RACINE / "recettes"
STYLE = RACINE / "style.css"
SORTIE = RACINE / "sortie"
```

par :

```python
# Les données partent du dossier du script, la sortie du dossier du terminal
ICI = Path(__file__).resolve().parent      # src/
RACINE = ICI.parent                        # le dossier du projet
DONNEES = RACINE / "data" / "recettes"
STYLE = RACINE / "data" / "style.css"
SORTIE = Path.cwd() / "sortie"
```

`__file__` est le chemin du fichier `.py` en cours d'exécution.

**Vérifications** :

| Dossier du terminal | Commande | Où la page est écrite |
|---|---|---|
| `travail/` | `python src/recette.py crepes` | `travail/sortie/crepes.html` |
| `3a_cli/` (après `cd ..`) | `python travail/src/recette.py crepes` | `3a_cli/sortie/crepes.html` |

Revenir dans `travail/` (`cd travail`), puis :

```text
git commit -am "src/ et data/"
```

**Vérification** : `git log --oneline` affiche sept lignes. Mettre aussi à
jour le README (`python src/recette.py …`) et le valider par un commit.

## Étape 6 (facultative) · Une commande installée

> **À faire :** copier `pyproject.toml` ; `pip install -e .` ; un commit.
>
> **À obtenir :** la commande `recette` fonctionne depuis n'importe quel dossier ; huit commits.

**Sortie** : une commande `recette`, utilisable dans n'importe quel dossier,
sans écrire `python` ni le chemin du script.

### 6.1 Le fichier `pyproject.toml`

Copier `depart/modeles/pyproject.toml` dans `travail/`. Compléter la ligne
`description`. La partie à lire est :

```toml
[project.scripts]
recette = "recette:main"
```

La commande `recette` appelle la fonction `main` du fichier `recette.py`,
cherché dans `src/`.

### 6.2 Installer

Dans le terminal, dans `travail/` :

```text
pip install -e .
```

**Vérification** : la dernière ligne est `Successfully installed recette-0.1`.
Si l'installation échoue faute de réseau :
`pip install -e . --no-build-isolation`.

### 6.3 Utiliser la commande

```text
cd ..
recette crepes -p 2
recette --help
```

**Vérification** : la page est écrite dans `sortie/` du dossier courant ;
l'aide s'affiche sans `python`.

### 6.4 Le commit

Revenir dans `travail/`. Dans le README, remplacer `python src/recette.py`
par `recette` et ajouter la ligne d'installation `pip install -e .`.

```text
git add pyproject.toml README.md
git commit -m "pyproject.toml : la commande recette"
git log --oneline
```

**Vérification** : huit lignes. `pip uninstall recette` retire la commande.

## Annexe · Les commandes des deux terminaux

Le TD se fait dans **Git Bash**, le terminal bash installé avec git et
utilisé au cours 2. La colonne de gauche donne les mêmes commandes dans le
terminal Windows (`cmd`, Anaconda Prompt), pour qui l'utilise ailleurs. Le
terminal de VS Code ouvre l'un ou l'autre (flèche à côté du `+` du panneau
du terminal).

| Pour… | Terminal Windows (`cmd`) | Git Bash (`bash`) |
|---|---|---|
| afficher le dossier courant | `cd` | `pwd` |
| lister le dossier courant | `dir` | `ls` |
| descendre dans un dossier | `cd travail` | `cd travail` |
| remonter d'un niveau | `cd ..` | `cd ..` |
| créer un dossier | `mkdir src` | `mkdir src` |
| copier un fichier | `copy depart\style.css travail\` | `cp depart/style.css travail/` |
| copier un dossier | `xcopy /E /I depart\recettes travail\recettes` | `cp -r depart/recettes travail/` |
| afficher un fichier texte | `type README.md` | `cat README.md` |
| créer un fichier vide | `type nul > .gitignore` | `touch .gitignore` |
| supprimer un fichier | `del essai.txt` | `rm essai.txt` |
| effacer l'écran | `cls` | `clear` |
| écrire un chemin | `C:\Users\moi\Desktop` | `/c/Users/moi/Desktop` |
| activer l'environnement d'Anaconda | déjà actif dans Anaconda Prompt : l'invite commence par `(base)` | `conda activate base`, une fois l'étape 0.3 faite |
| lancer git | `git status`, si git est installé pour tout le poste | `git status` |

**conda dans Git Bash** (étape 0.3). Sur les postes de la salle, Anaconda
est installé dans `C:\ProgramData\anaconda3` :

```text
source /c/ProgramData/anaconda3/etc/profile.d/conda.sh
conda init bash
```

Sur un autre ordinateur, le chemin est celui du dossier d'installation
d'Anaconda : taper `echo %CONDA_PREFIX%` dans Anaconda Prompt pour le
trouver. Dans Git Bash, `C:\` s'écrit `/c/` et les `\` deviennent des `/`.
