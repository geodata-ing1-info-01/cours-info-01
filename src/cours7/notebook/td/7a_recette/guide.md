---
title: "TD 7a — Le livre de recettes"
subtitle: Guide, étape par étape
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

Le TD complète le programme `recette.py` du TD 3a. Aujourd'hui, le
programme écrit la page d'une recette par appel. À la fin du TD, il écrit
toutes les pages et un sommaire, avec la photo de chaque recette, et il
cherche les recettes qu'on peut faire avec les ingrédients qu'on a, comme
les applications de recettes. Cette dernière fonctionnalité est calculée
avec numpy.

Chaque fonctionnalité se développe sur une branche de son dépôt GitHub (cours
6), puis arrive sur `master` par une pull request, fusionnée sur le site.

Pour chaque fonction à écrire, le guide donne sa première ligne, sa
description et, en commentaires, ce qu'il faut écrire ; le code complet est
dans l'[annexe](#annexe-le-code-complet), pour vérifier ou pour se
débloquer. Pour les autres modifications, le guide donne le code à coller.

| Étape | Ce qu'on fait | Durée |
|---|---|---|
| C0 | le dépôt, l'environnement, une branche `livre` | 10′ |
| C1 | toutes les recettes : vingt de plus, la fonction `generer`, l'option `--toutes` | 20′ |
| C2 | le sommaire, `sortie/index.html` | 15′ |
| C3 | la photo de chaque recette, avec Pillow | 15′ |
| PR 1 | la pull request de la branche `livre` | 5′ |
| C4 | les recettes faisables avec les ingrédients qu'on a, avec numpy | 30′ |
| PR 2 | le README, la pull request de la branche `frigo` | 5′ |

## Au début de la séance

- Le dépôt GitHub du projet 4, publié au cours 6, et la clé SSH du cours 5
  enregistrée sur le compte GitHub.
- L'archive `info01-cours7.zip`, copiée depuis `formationTemp` sur le Bureau,
  dans le dossier `info01`, puis décompressée.

Ouvrir le dossier `info01/cours7/7a_recette/` dans VS Code, puis un terminal Git
Bash (menu Terminal → Nouveau terminal ; flèche à côté du `+` → Git Bash).
Tout le TD se fait dans ce terminal.

## C0 · Le dépôt, l'environnement, une branche

> **À faire :** le dépôt `recette` dans `travail/` ; l'environnement `info01-recette` d'après `environment.yml` ; une branche `livre`.
>
> **À obtenir :** `python recette.py crepes` écrit `sortie/crepes.html` ; `git branch` affiche `* livre`.

### C0.1 Le dépôt sur le poste

**Cas A, le dépôt du cours 6 fonctionne.** Sur sa page GitHub, bouton
Code → SSH, copier l'adresse, puis :

```text
cd travail
git clone git@github.com:<compte>/recette.git
cd recette
```

**Cas B, pas de dépôt, ou un programme qui ne fonctionne pas.** Le module
publie un dépôt de référence, `recette`, sur le compte GitHub
`<organisation>` (le nom est donné en début de séance). Sur son compte
GitHub, créer d'abord un dépôt vide nommé `recette` (New repository, sans
README), puis :

```text
cd travail
git clone git@github.com:<organisation>/recette.git
cd recette
git remote set-url origin git@github.com:<compte>/recette.git
git push -u origin master
```

`git remote set-url` change l'adresse du dépôt distant `origin` : les
`push` suivants vont au dépôt de l'élève. Le dépôt garde l'historique du TD
d'origine.

**Vérification** : `ls` liste `recette.py`, `recettes`, `style.css` et `README.md` ; `git log --oneline` affiche les commits du TD 3a.


### C0.2 L'environnement

Le programme lance pandoc ; il demandera ensuite Pillow (étape C3) et numpy
(étape C4). Le fichier `environment.yml` décrit l'environnement du projet :

```text
cp ../../depart/modeles/environment.yml .
cat environment.yml
conda env create -f environment.yml
conda activate info01-recette
```

Si conda répond `prefix already exists`, l'environnement existe déjà (projet
4) : passer à `conda activate`.

**Vérification** : la première ligne de l'invite est `(info01-recette)` ;
`python recette.py crepes` affiche le chemin de `sortie/crepes.html`.

### C0.3 Une branche

```text
git checkout -b livre
git add environment.yml
git commit -m "L'environnement du projet"
```

**Vérification** : `git branch` affiche `* livre`.

## C1 · Toutes les recettes

> **À faire :** copier les vingt recettes ; déplacer le corps de `main` dans une fonction `generer` ; la fonction `noms_des_recettes` et l'option `--toutes` ; un commit à chaque fois.
>
> **À obtenir :** `python recette.py --toutes` écrit une page par recette dans `sortie/`, 24 en tout.

### C1.1 Vingt recettes de plus

```text
cp -r ../../depart/recettes/* recettes/
ls recettes
python recette.py --help
```

**Vérification** : `ls` liste 24 dossiers et `CREDITS.md` ; l'aide liste
les 24 recettes : le programme les trouve sans changement de code (TD 3a,
section 3.4 du notebook).

```text
git add recettes
git commit -m "Vingt recettes de plus"
```

### C1.2 La fonction `generer`

Pour écrire toutes les pages, le programme doit répéter ce que fait `main`
pour une recette. Ces lignes deviennent une fonction, appelée une fois par
recette.

Dans `recette.py`, sous les fonctions utiles, coller :

```python
# ---- Une page ---------------------------------------------------------------

def generer(nom, personnes, unites):
    """La page HTML d'une recette, pour ce nombre de personnes et ces unités ; renvoie son chemin."""
    # La recette : le tableau des ingrédients inséré sous « ## Ingrédients »
    ingredients = lire_ingredients(DONNEES / nom / "ingredients.csv")
    ingredients = adapter(ingredients, personnes, unites)
    source = (DONNEES / nom / "recette.md").read_text(encoding="utf-8")
    titre = source.splitlines()[0].lstrip("# ")
    intitule = f"## Ingrédients pour {personnes} personnes en {unites}"
    complete = source.replace("## Ingrédients", intitule + "\n\n" + tableau(ingredients))
    SORTIE.mkdir(exist_ok=True)

    # Le Markdown complet et la feuille de style, dans sortie/
    markdown = SORTIE / (nom + ".md")
    markdown.write_text(complete, encoding="utf-8")
    shutil.copy(STYLE, SORTIE / "style.css")

    # La page HTML, par pandoc
    page = SORTIE / (nom + ".html")
    subprocess.run(
        ["pandoc", str(markdown), "-o", str(page),
         "--standalone", "--css", "style.css", "--metadata", "title=" + titre],
        check=True,
    )
    return page
```

La fonction reprend les lignes de `main`, de `# La recette` jusqu'à
`subprocess.run(…)`, avec les paramètres `nom`, `personnes` et `unites` à
la place de `NOM`, `PERSONNES` et `UNITES`, et renvoie le chemin de la page.
Puis remplacer toute la fonction `main`, de `def main():` jusqu'à la ligne
vide qui précède `# Vrai quand`, par :

```python
def main():
    # Les trois valeurs viennent de la ligne de commande
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

    page = generer(NOM, PERSONNES, UNITES)
    print(page, ":", PERSONNES, "personne(s), unités", UNITES)
```

Enregistrer. **Vérification** : `python recette.py crepes -p 2` affiche,
comme avant, le chemin de `sortie/crepes.html`.

```text
git commit -am "La fonction generer"
```

### C1.3 La fonction `noms_des_recettes` et l'option `--toutes`

`DONNEES.glob("*/recette.md")` renvoie les chemins des fichiers
`recette.md` de tous les sous-dossiers de `recettes/` ; `chemin.parent`
est le dossier du fichier, et `chemin.parent.name` son nom, celui de la
recette. Sous la fonction `generer`, écrire :

```python
# ---- Toutes les recettes et le sommaire -------------------------------------

def noms_des_recettes():
    """Le nom de chaque recette : le dossier de chaque fichier recettes/*/recette.md."""
    noms = []
    for chemin in sorted(DONNEES.glob("*/recette.md")):
        # à écrire : ajouter à la liste noms le nom du dossier de chemin
    return noms
```

Puis remplacer la fonction `main` par :

```python
def main():
    noms = noms_des_recettes()
    analyseur = argparse.ArgumentParser(description="Met une recette à l'échelle et en fait une page HTML.")
    analyseur.add_argument("nom", nargs="?", choices=noms, help="la recette")
    analyseur.add_argument("-p", "--personnes", type=int, default=4, help="nombre de personnes (défaut : 4)")
    analyseur.add_argument("-u", "--unites", choices=("SI", "US"), default="SI", help="unités du tableau (défaut : SI)")
    analyseur.add_argument("--toutes", action="store_true", help="toutes les recettes, et le sommaire sortie/index.html")
    options = analyseur.parse_args()
    if options.nom is None and not options.toutes:
        analyseur.error("donner une recette, ou --toutes")

    if options.toutes:
        for nom in noms:
            generer(nom, options.personnes, options.unites)
        print(len(noms), "recettes dans", SORTIE)
    elif options.nom is not None:
        page = generer(options.nom, options.personnes, options.unites)
        print(page, ":", options.personnes, "personne(s), unités", options.unites)
```

`nargs="?"` rend le nom de la recette facultatif : il vaut `None` quand il
n'est pas donné. `analyseur.error` arrête le programme si l'on ne donne ni
recette ni `--toutes`.

Enregistrer. **Vérifications** :

| Commande | Ce qui doit s'afficher |
|---|---|
| `python recette.py --toutes` | `24 recettes dans …/sortie` |
| `python recette.py omelette` | le chemin de `sortie/omelette.html` |
| `python recette.py` | `error: donner une recette, ou --toutes` |

```text
git commit -am "L'option --toutes"
```

## C2 · Le sommaire

> **À faire :** la fonction `sommaire`, appelée après `--toutes` ; un commit.
>
> **À obtenir :** `sortie/index.html` s'ouvre dans le navigateur, et chaque lien mène à la page de sa recette.

Le sommaire est une page Markdown convertie par pandoc, comme les recettes :
une ligne `- [Titre](nom.html)` par recette. Sous `noms_des_recettes`,
écrire :

```python
def sommaire(noms):
    """La page sortie/index.html : un lien vers la page de chaque recette ; renvoie son chemin."""
    lignes = ["# Le livre de recettes", ""]
    for nom in noms:
        # à écrire : le titre de la recette, première ligne de recette.md sans « # »
        # à écrire : ajouter à lignes la ligne « - [titre](nom.html) »
    markdown = SORTIE / "index.md"
    # à écrire : écrire dans markdown les lignes, séparées par "\n"
    page = SORTIE / "index.html"
    subprocess.run(
        ["pandoc", str(markdown), "-o", str(page),
         "--standalone", "--css", "style.css", "--metadata", "title=Le livre de recettes"],
        check=True,
    )
    return page
```

Le titre d'une recette se lit comme dans `generer`. Dans `main`, remplacer
la ligne `print(len(noms), "recettes dans", SORTIE)` par :

```python
        print(sommaire(noms), ":", len(noms), "recettes")
```

Enregistrer. **Vérification** : `python recette.py --toutes` affiche le
chemin de `sortie/index.html` ; l'ouvrir par un double-clic dans
l'explorateur, puis suivre deux liens.

```text
git commit -am "Le sommaire"
```

## C3 · La photo de chaque recette

> **À faire :** installer Pillow et l'ajouter à `environment.yml` ; la fonction `photo` ; la photo sous le titre de chaque page ; un commit.
>
> **À obtenir :** la page des crêpes montre la photo ; celle de l'omelette, qui n'a pas de photo, s'écrit sans.

**Installer Pillow**, la bibliothèque qui lit et écrit les images :

```text
conda install -c conda-forge pillow
python -c "import PIL; print(PIL.__version__)"
```

Dans `environment.yml`, ajouter la ligne `  - pillow` à la fin de la liste
`dependencies`. **Vérification** : la commande `python` affiche un numéro de
version.

**Le code.** En tête du fichier, sous `from pathlib import Path`, ajouter :

```python

from PIL import Image
```

Au-dessus de `generer`, écrire :

```python
def photo(nom):
    """La photo de la recette, réduite, copiée dans SORTIE ; renvoie son nom de fichier, ou None sans photo."""
    source = DONNEES / nom / "photo.jpg"
    # à écrire : si source n'existe pas, renvoyer None
    # à écrire : ouvrir l'image, la réduire à 600 pixels au plus, l'enregistrer dans SORTIE / (nom + ".jpg")
    return nom + ".jpg"
```

`Image.open(source)` renvoie l'image ; sa méthode `thumbnail((600, 600))` la
réduit à 600 pixels au plus, en gardant ses proportions ; sa méthode
`save(chemin)` l'enregistre. Les photos des recettes du TD 3a mesurent 960
pixels de large.

Dans `generer`, sous la ligne `SORTIE.mkdir(exist_ok=True)`, ajouter :

```python
    # La photo, sous le titre
    fichier_photo = photo(nom)
    if fichier_photo is not None:
        complete = complete.replace("\n", "\n\n![" + titre + "](" + fichier_photo + ")\n", 1)
```

`complete.replace("\n", …, 1)` remplace le premier saut de ligne, celui qui
suit le titre : l'image s'insère sous le titre.

Enregistrer. **Vérification** : `python recette.py --toutes`, puis ouvrir
`sortie/crepes.html` (la photo) et `sortie/omelette.html` (pas de photo) ;
`sortie/` contient `crepes.jpg`.

```text
git commit -am "La photo de chaque recette"
```

## PR 1 · La pull request de la branche `livre`

> **À faire :** pousser la branche `livre`, ouvrir la pull request, la fusionner sur le site, puis `git pull` sur `master`.
>
> **À obtenir :** sur le poste, `master` contient les commits de C0 à C3.

**Pousser la branche** :

```text
git push -u origin livre
```

**Vérification** : la dernière ligne affiche `branch 'livre' set up to
track 'origin/livre'`.

**Ouvrir la pull request.** Sur la page du dépôt sur GitHub, un bandeau
propose « Compare & pull request » : cliquer dessus. Vérifier en haut de la
page : `base: master` ← `compare: livre`. Titre : `Le livre de recettes` ; dans la
description, les commandes qui montrent la fonctionnalité (`--toutes`, le sommaire, les photos).
Cliquer « Create pull request ».

**Fusionner.** En bas de la pull request, « Merge pull request », puis
« Confirm merge ». Sur le poste :

```text
git checkout master
git pull
git log --oneline --graph
```

**Vérification** : `git log` montre le commit de fusion, `Merge pull request
#… from <compte>/livre`, et les commits de la branche.


## C4 · Les recettes faisables avec ce qu'on a

> **À faire :** une branche `frigo` ; installer numpy ; les fonctions `simplifier` et `matrice` (fournies), puis `frigo` ; l'option `--frigo` ; un commit.
>
> **À obtenir :** `python recette.py --frigo farine lait oeufs beurre sucre sel` affiche les cinq recettes auxquelles il manque le moins d'ingrédients.

```text
git checkout -b frigo
conda install -c conda-forge numpy
```

Dans `environment.yml`, ajouter la ligne `  - numpy`.

### C4.1 La table recettes × ingrédients

Le programme range l'information « la recette contient l'ingrédient » dans
un tableau numpy de 0 et de 1 : une ligne par recette, une colonne par
ingrédient. Par exemple, pour trois recettes et quatre ingrédients :

```text
                 farine  lait  oeufs  sucre
crepes             1      1      1      0
mousse_chocolat    0      0      1      1
pancakes           1      1      1      1
```

Avec les ingrédients disponibles dans un vecteur de 0 et de 1, par exemple
`farine lait` → `[1, 1, 0, 0]`, le produit `recettes @ vecteur` donne, pour
chaque recette, le nombre de ses ingrédients disponibles : `[2, 0, 2]`.
`recettes.sum(axis=1)` donne le nombre d'ingrédients de chaque recette :
`[3, 2, 4]` ; la différence, le nombre d'ingrédients qui manquent :
`[1, 2, 2]`.

Les noms d'ingrédients tapés au clavier doivent retrouver ceux des fichiers
CSV : `oeufs` pour `Œufs`. La fonction `simplifier` met les noms en
minuscules, retire les accents et écrit `œ` en `oe` (le cours 3 montre
`œuf` et `oeuf` en UTF-8).

En tête du fichier, ajouter `import unicodedata` sous `import subprocess`,
et `import numpy as np` au-dessus de `from PIL import Image`. Sous
`sommaire`, coller :

```python
# ---- Les recettes faisables avec ce qu'on a ----------------------------------

def simplifier(nom):
    """Le nom d'un ingrédient en minuscules, sans accents, « œ » écrit « oe » : « Œufs » donne « oeufs »."""
    nom = nom.lower().replace("œ", "oe")
    lettres = []
    # NFD sépare chaque lettre accentuée en une lettre et un accent ; les
    # accents sont de la catégorie « Mn », laissée de côté.
    for caractere in unicodedata.normalize("NFD", nom):
        if unicodedata.category(caractere) != "Mn":
            lettres.append(caractere)
    return "".join(lettres)


def matrice(noms):
    """La table recettes × ingrédients, 1 si la recette contient l'ingrédient ; et la liste des ingrédients."""
    contenus = []
    ingredients = []
    for nom in noms:
        contenu = []
        for ingredient, quantite, unite in lire_ingredients(DONNEES / nom / "ingredients.csv"):
            contenu.append(simplifier(ingredient))
        contenus.append(contenu)
        for ingredient in contenu:
            if ingredient not in ingredients:
                ingredients.append(ingredient)
    ingredients.sort()
    recettes = np.zeros((len(noms), len(ingredients)), dtype=int)
    for ligne, contenu in enumerate(contenus):
        for ingredient in contenu:
            recettes[ligne, ingredients.index(ingredient)] = 1
    return recettes, ingredients
```

### C4.2 La fonction `frigo`

Sous `matrice`, écrire :

```python
def frigo(noms, disponibles, nombre=5):
    """Affiche les `nombre` recettes auxquelles il manque le moins d'ingrédients, et ceux qui manquent."""
    recettes, ingredients = matrice(noms)
    vecteur = np.zeros(len(ingredients), dtype=int)
    for nom in disponibles:
        if simplifier(nom) in ingredients:
            vecteur[ingredients.index(simplifier(nom))] = 1
        else:
            print("ingrédient inconnu :", nom)
    # à écrire : presents, le nombre d'ingrédients disponibles de chaque recette (produit @)
    # à écrire : manquants, le nombre d'ingrédients qui manquent à chaque recette (somme sur axis=1)
    # à écrire : ordre, les lignes des recettes rangées par nombre d'ingrédients manquants (np.argsort)
    for ligne in ordre[:nombre]:
        # à écrire : absents, vrai pour les ingrédients de la recette qui ne sont pas disponibles
        liste = []
        for colonne in np.nonzero(absents)[0]:
            liste.append(ingredients[colonne])
        print(noms[ligne], ":", manquants[ligne], "ingrédient(s) manquant(s)", ", ".join(liste))
```

Les outils numpy :

| Pour… | numpy |
|---|---|
| le produit d'un tableau et d'un vecteur | `recettes @ vecteur` |
| la somme de chaque ligne | `recettes.sum(axis=1)` |
| les positions qui rangent les valeurs dans l'ordre croissant | `np.argsort(manquants, kind="stable")` |
| vrai là où deux conditions sont vraies, case par case | `(recettes[ligne] == 1) & (vecteur == 0)` |
| les positions des cases vraies | `np.nonzero(absents)[0]` |

Puis remplacer la fonction `main` par :

```python
def main():
    noms = noms_des_recettes()
    analyseur = argparse.ArgumentParser(description="Met une recette à l'échelle et en fait une page HTML.")
    analyseur.add_argument("nom", nargs="?", choices=noms, help="la recette")
    analyseur.add_argument("-p", "--personnes", type=int, default=4, help="nombre de personnes (défaut : 4)")
    analyseur.add_argument("-u", "--unites", choices=("SI", "US"), default="SI", help="unités du tableau (défaut : SI)")
    analyseur.add_argument("--toutes", action="store_true", help="toutes les recettes, et le sommaire sortie/index.html")
    analyseur.add_argument("--frigo", nargs="+", metavar="INGREDIENT", help="les recettes faisables avec ces ingrédients")
    options = analyseur.parse_args()
    if options.nom is None and not options.toutes and options.frigo is None:
        analyseur.error("donner une recette, --toutes ou --frigo")

    if options.frigo is not None:
        frigo(noms, options.frigo)
    if options.toutes:
        for nom in noms:
            generer(nom, options.personnes, options.unites)
        print(sommaire(noms), ":", len(noms), "recettes")
    elif options.nom is not None:
        page = generer(options.nom, options.personnes, options.unites)
        print(page, ":", options.personnes, "personne(s), unités", options.unites)
```

`nargs="+"` fait de `--frigo` une option qui reçoit un ou plusieurs mots.

Enregistrer. **Vérifications** :

| Commande | Ce qui doit s'afficher |
|---|---|
| `python recette.py --frigo farine lait oeufs beurre sucre sel` | cinq lignes, de `crepes : 1 ingrédient(s) manquant(s) beurre fondu` à `puree : 1 ingrédient(s) manquant(s) pomme de terre` |
| `python recette.py --frigo pâtes lardons œufs` | en deuxième ligne, `pates_carbonara : 3 ingrédient(s) manquant(s) fromage rape, poivre, sel` : les noms sont affichés simplifiés |
| `python recette.py --frigo chocolat` | `ingrédient inconnu : chocolat`, puis cinq recettes |

« Beurre fondu », dans la recette des crêpes, et « beurre » sont deux
ingrédients différents pour le programme : les noms des fichiers CSV
doivent être harmonisés pour que la recherche les rapproche.

```text
git commit -am "Les recettes faisables avec ce qu'on a"
```

## PR 2 · Le README et la pull request de la branche `frigo`

> **À faire :** décrire `--toutes` et `--frigo` dans le README ; un commit ; la pull request de la branche `frigo`, fusionnée.
>
> **À obtenir :** sur le poste, `master` contient toutes les fonctionnalités ; `git log --oneline --graph` montre les deux fusions.

Dans `README.md`, ajouter dans la partie qui décrit l'utilisation les deux
commandes, `python recette.py --toutes` et `python recette.py --frigo …`,
avec ce qu'elles écrivent ou affichent, et une phrase sur l'environnement
(`conda env create -f environment.yml`).

```text
git commit -am "README : --toutes, --frigo et l'environnement"
```

**Pousser la branche** :

```text
git push -u origin frigo
```

**Vérification** : la dernière ligne affiche `branch 'frigo' set up to
track 'origin/frigo'`.

**Ouvrir la pull request.** Sur la page du dépôt sur GitHub, un bandeau
propose « Compare & pull request » : cliquer dessus. Vérifier en haut de la
page : `base: master` ← `compare: frigo`. Titre : `Les recettes faisables` ; dans la
description, les commandes qui montrent la fonctionnalité (`--frigo`).
Cliquer « Create pull request ».

**Fusionner.** En bas de la pull request, « Merge pull request », puis
« Confirm merge ». Sur le poste :

```text
git checkout master
git pull
git log --oneline --graph
```

**Vérification** : `git log` montre le commit de fusion, `Merge pull request
#… from <compte>/frigo`, et les commits de la branche.


## Facultatif

- **Publier le livre sur GitHub Pages.** `python recette.py --toutes`, puis
  `cp -r sortie docs`, `git add docs`, un commit, `git push`. Sur GitHub,
  Settings → Pages → Branch : `master`, dossier `/docs` → Save. Le livre est
  en ligne après une minute, à l'adresse affichée. Les photos sous licence
  CC BY demandent de citer leurs auteurs : ajouter au sommaire un lien vers
  `CREDITS.md`.
- **Vous aimerez aussi.** `recettes @ recettes.T` est un tableau recettes ×
  recettes : chaque case compte les ingrédients communs à deux recettes.
  `np.fill_diagonal(communs, -1)` écarte chaque recette d'elle-même ;
  `communs[ligne].argmax()` donne la recette la plus proche. Ajouter sous
  chaque page un lien vers elle.
- **Le placard.** Le sel, le poivre et l'eau comptés comme toujours
  disponibles.
- **Harmoniser les noms** des ingrédients dans les recettes du TD 3a
  (`Beurre fondu`, `Eau tiède`).
- **Une pull request en binôme.** Chacun ajoute sa propre recette dans le
  dépôt de l'autre : fork du dépôt du camarade, un commit, une pull request
  vers son dépôt.

## Annexe · Le code complet

Les fonctions écrites pendant le TD, telles que le corrigé les donne.

```python
def noms_des_recettes():
    """Le nom de chaque recette : le dossier de chaque fichier recettes/*/recette.md."""
    noms = []
    for chemin in sorted(DONNEES.glob("*/recette.md")):
        noms.append(chemin.parent.name)
    return noms
```

```python
def sommaire(noms):
    """La page sortie/index.html : un lien vers la page de chaque recette ; renvoie son chemin."""
    lignes = ["# Le livre de recettes", ""]
    for nom in noms:
        titre = (DONNEES / nom / "recette.md").read_text(encoding="utf-8").splitlines()[0].lstrip("# ")
        lignes.append(f"- [{titre}]({nom}.html)")
    markdown = SORTIE / "index.md"
    markdown.write_text("\n".join(lignes) + "\n", encoding="utf-8")
    page = SORTIE / "index.html"
    subprocess.run(
        ["pandoc", str(markdown), "-o", str(page),
         "--standalone", "--css", "style.css", "--metadata", "title=Le livre de recettes"],
        check=True,
    )
    return page
```

```python
def photo(nom):
    """La photo de la recette, réduite, copiée dans SORTIE ; renvoie son nom de fichier, ou None sans photo."""
    source = DONNEES / nom / "photo.jpg"
    if not source.exists():
        return None
    image = Image.open(source)
    image.thumbnail((600, 600))          # au plus 600 pixels de large et de haut, proportions gardées
    image.save(SORTIE / (nom + ".jpg"))
    return nom + ".jpg"
```

```python
def frigo(noms, disponibles, nombre=5):
    """Affiche les `nombre` recettes auxquelles il manque le moins d'ingrédients, et ceux qui manquent."""
    recettes, ingredients = matrice(noms)
    vecteur = np.zeros(len(ingredients), dtype=int)
    for nom in disponibles:
        if simplifier(nom) in ingredients:
            vecteur[ingredients.index(simplifier(nom))] = 1
        else:
            print("ingrédient inconnu :", nom)
    presents = recettes @ vecteur                  # pour chaque recette, ses ingrédients disponibles
    manquants = recettes.sum(axis=1) - presents    # pour chaque recette, ses ingrédients qui manquent
    ordre = np.argsort(manquants, kind="stable")   # les recettes, de celle à qui il manque le moins
    for ligne in ordre[:nombre]:
        absents = (recettes[ligne] == 1) & (vecteur == 0)
        liste = []
        for colonne in np.nonzero(absents)[0]:
            liste.append(ingredients[colonne])
        print(noms[ligne], ":", manquants[ligne], "ingrédient(s) manquant(s)", ", ".join(liste))
```
