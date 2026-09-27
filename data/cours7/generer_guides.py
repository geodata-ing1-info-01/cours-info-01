"""Écrit les guides des TD 7a (le livre de recettes) et 7b (la scène complète du train).

Le code montré vient de `generer_corriges.py`, importé ici : les guides et
les corrigés ont le même code. Les fonctions à écrire par l'élève sont
montrées en squelette (la ligne `def`, la description, des commentaires qui
disent quoi écrire) ; leur code complet est dans l'annexe du guide.

    python data/cours7/generer_corriges.py
    python data/cours7/generer_guides.py
    python outils/compiler_guides.py --cours 7

Modifier les guides ici, pas dans les fichiers `guide.md`, que ce script
réécrit.
"""
import ast
import importlib.util
from pathlib import Path

ICI = Path(__file__).resolve().parent
DEPOT = ICI.parent.parent

_spec = importlib.util.spec_from_file_location("generer_corriges_cours7", ICI / "generer_corriges.py")
corriges = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(corriges)

ORGANISATION = "<organisation>"   # le compte GitHub du module, donné en séance


def fence(code, langue="python"):
    return "```" + langue + "\n" + code.strip("\n") + "\n```"


def fonction(texte, nom):
    """Le code de la fonction `nom` dans le fichier `texte`, docstring comprise."""
    for noeud in ast.parse(texte).body:
        if isinstance(noeud, ast.FunctionDef) and noeud.name == nom:
            return ast.get_source_segment(texte, noeud)
    raise KeyError(nom)


def verifs(lignes):
    tableau = ["| Commande | Ce qui doit s'afficher |", "|---|---|"]
    for commande, attendu in lignes:
        tableau.append("| `" + commande + "` | " + attendu + " |")
    return "\n".join(tableau)


def encadre(faire, obtenir):
    return "> **À faire :** " + faire + "\n>\n> **À obtenir :** " + obtenir


ENTETE = """---
title: "{titre}"
subtitle: Guide, étape par étape
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---
"""


def pull_request(branche, titre, fichiers_readme):
    """Le texte commun d'une pull request : pousser, ouvrir, fusionner, récupérer."""
    return f"""**Pousser la branche** :

```text
git push -u origin {branche}
```

**Vérification** : la dernière ligne affiche `branch '{branche}' set up to
track 'origin/{branche}'`.

**Ouvrir la pull request.** Sur la page du dépôt sur GitHub, un bandeau
propose « Compare & pull request » : cliquer dessus. Vérifier en haut de la
page : `base: master` ← `compare: {branche}`. Titre : `{titre}` ; dans la
description, les commandes qui montrent la fonctionnalité{fichiers_readme}.
Cliquer « Create pull request ».

**Fusionner.** En bas de la pull request, « Merge pull request », puis
« Confirm merge ». Sur le poste :

```text
git checkout master
git pull
git log --oneline --graph
```

**Vérification** : `git log` montre le commit de fusion, `Merge pull request
#… from <compte>/{branche}`, et les commits de la branche.
"""


DEBUT_SEANCE = """## Au début de la séance

- Le dépôt GitHub du projet 4, publié au cours 6, et la clé SSH du cours 5
  enregistrée sur le compte GitHub.
- L'archive `info01-cours7.zip`, copiée depuis `formationTemp` sur le Bureau,
  dans le dossier `info01`, puis décompressée.

Ouvrir le dossier `info01/cours7/{td}/` dans VS Code, puis un terminal Git
Bash (menu Terminal → Nouveau terminal ; flèche à côté du `+` → Git Bash).
Tout le TD se fait dans ce terminal.
"""


def depot(nom, apres):
    """L'étape C0.1 : le dépôt sur le poste, le sien ou celui de référence."""
    return f"""### C0.1 Le dépôt sur le poste

**Cas A, le dépôt du cours 6 fonctionne.** Sur sa page GitHub, bouton
Code → SSH, copier l'adresse, puis :

```text
cd travail
git clone git@github.com:<compte>/{nom}.git
cd {nom}
```

**Cas B, pas de dépôt, ou un programme qui ne fonctionne pas.** Le module
publie un dépôt de référence, `{nom}`, sur le compte GitHub
`{ORGANISATION}` (le nom est donné en début de séance). Sur son compte
GitHub, créer d'abord un dépôt vide nommé `{nom}` (New repository, sans
README), puis :

```text
cd travail
git clone git@github.com:{ORGANISATION}/{nom}.git
cd {nom}
git remote set-url origin git@github.com:<compte>/{nom}.git
git push -u origin master
```

`git remote set-url` change l'adresse du dépôt distant `origin` : les
`push` suivants vont au dépôt de l'élève. Le dépôt garde l'historique du TD
d'origine.

**Vérification** : {apres}
"""


# ============================================================ TD 7a

def guide_recette():
    R = corriges.R
    final = corriges.recette("c4")
    c3 = corriges.recette("c3")
    generer_c1 = fonction(corriges.recette("c1"), "generer")
    lignes_photo = '''    # La photo, sous le titre
    fichier_photo = photo(nom)
    if fichier_photo is not None:
        complete = complete.replace("\\n", "\\n\\n![" + titre + "](" + fichier_photo + ")\\n", 1)'''
    main_c1 = fonction(corriges.recette("c1"), "main")
    main_c2 = fonction(corriges.recette("c2"), "main")
    main_c4 = fonction(final, "main")
    main_generer = fonction(corriges.recette("c1-generer"), "main")
    squelette_noms = '''def noms_des_recettes():
    """Le nom de chaque recette : le dossier de chaque fichier recettes/*/recette.md."""
    noms = []
    for chemin in sorted(DONNEES.glob("*/recette.md")):
        # à écrire : ajouter à la liste noms le nom du dossier de chemin
    return noms'''
    squelette_sommaire = '''def sommaire(noms):
    """La page sortie/index.html : un lien vers la page de chaque recette ; renvoie son chemin."""
    lignes = ["# Le livre de recettes", ""]
    for nom in noms:
        # à écrire : le titre de la recette, première ligne de recette.md sans « # »
        # à écrire : ajouter à lignes la ligne « - [titre](nom.html) »
    markdown = SORTIE / "index.md"
    # à écrire : écrire dans markdown les lignes, séparées par "\\n"
    page = SORTIE / "index.html"
    subprocess.run(
        ["pandoc", str(markdown), "-o", str(page),
         "--standalone", "--css", "style.css", "--metadata", "title=Le livre de recettes"],
        check=True,
    )
    return page'''
    squelette_photo = '''def photo(nom):
    """La photo de la recette, réduite, copiée dans SORTIE ; renvoie son nom de fichier, ou None sans photo."""
    source = DONNEES / nom / "photo.jpg"
    # à écrire : si source n'existe pas, renvoyer None
    # à écrire : ouvrir l'image, la réduire à 600 pixels au plus, l'enregistrer dans SORTIE / (nom + ".jpg")
    return nom + ".jpg"'''
    squelette_frigo = '''def frigo(noms, disponibles, nombre=5):
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
        print(noms[ligne], ":", manquants[ligne], "ingrédient(s) manquant(s)", ", ".join(liste))'''

    return ENTETE.format(titre="TD 7a — Le livre de recettes") + f"""
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

{DEBUT_SEANCE.format(td="7a_recette")}
## C0 · Le dépôt, l'environnement, une branche

{encadre("le dépôt `recette` dans `travail/` ; l'environnement `info01-recette` d'après `environment.yml` ; une branche `livre`.",
         "`python recette.py crepes` écrit `sortie/crepes.html` ; `git branch` affiche `* livre`.")}

{depot("recette", "`ls` liste `recette.py`, `recettes`, `style.css` et `README.md` ; `git log --oneline` affiche les commits du TD 3a.")}

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

{encadre("copier les vingt recettes ; déplacer le corps de `main` dans une fonction `generer` ; la fonction `noms_des_recettes` et l'option `--toutes` ; un commit à chaque fois.",
         "`python recette.py --toutes` écrit une page par recette dans `sortie/`, 24 en tout.")}

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

{fence(R["titre-page"] + chr(10) + generer_c1)}

La fonction reprend les lignes de `main`, de `# La recette` jusqu'à
`subprocess.run(…)`, avec les paramètres `nom`, `personnes` et `unites` à
la place de `NOM`, `PERSONNES` et `UNITES`, et renvoie le chemin de la page.
Puis remplacer toute la fonction `main`, de `def main():` jusqu'à la ligne
vide qui précède `# Vrai quand`, par :

{fence(main_generer)}

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

{fence("# ---- Toutes les recettes et le sommaire -------------------------------------" + chr(10) + chr(10) + squelette_noms)}

Puis remplacer la fonction `main` par :

{fence(main_c1)}

`nargs="?"` rend le nom de la recette facultatif : il vaut `None` quand il
n'est pas donné. `analyseur.error` arrête le programme si l'on ne donne ni
recette ni `--toutes`.

Enregistrer. **Vérifications** :

{verifs([
        ("python recette.py --toutes", "`24 recettes dans …/sortie`"),
        ("python recette.py omelette", "le chemin de `sortie/omelette.html`"),
        ("python recette.py", "`error: donner une recette, ou --toutes`"),
    ])}

```text
git commit -am "L'option --toutes"
```

## C2 · Le sommaire

{encadre("la fonction `sommaire`, appelée après `--toutes` ; un commit.",
         "`sortie/index.html` s'ouvre dans le navigateur, et chaque lien mène à la page de sa recette.")}

Le sommaire est une page Markdown convertie par pandoc, comme les recettes :
une ligne `- [Titre](nom.html)` par recette. Sous `noms_des_recettes`,
écrire :

{fence(squelette_sommaire)}

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

{encadre("installer Pillow et l'ajouter à `environment.yml` ; la fonction `photo` ; la photo sous le titre de chaque page ; un commit.",
         "la page des crêpes montre la photo ; celle de l'omelette, qui n'a pas de photo, s'écrit sans.")}

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

{fence(squelette_photo)}

`Image.open(source)` renvoie l'image ; sa méthode `thumbnail((600, 600))` la
réduit à 600 pixels au plus, en gardant ses proportions ; sa méthode
`save(chemin)` l'enregistre. Les photos des recettes du TD 3a mesurent 960
pixels de large.

Dans `generer`, sous la ligne `SORTIE.mkdir(exist_ok=True)`, ajouter :

{fence(lignes_photo)}

`complete.replace("\\n", …, 1)` remplace le premier saut de ligne, celui qui
suit le titre : l'image s'insère sous le titre.

Enregistrer. **Vérification** : `python recette.py --toutes`, puis ouvrir
`sortie/crepes.html` (la photo) et `sortie/omelette.html` (pas de photo) ;
`sortie/` contient `crepes.jpg`.

```text
git commit -am "La photo de chaque recette"
```

## PR 1 · La pull request de la branche `livre`

{encadre("pousser la branche `livre`, ouvrir la pull request, la fusionner sur le site, puis `git pull` sur `master`.",
         "sur le poste, `master` contient les commits de C0 à C3.")}

{pull_request("livre", "Le livre de recettes", " (`--toutes`, le sommaire, les photos)")}

## C4 · Les recettes faisables avec ce qu'on a

{encadre("une branche `frigo` ; installer numpy ; les fonctions `simplifier` et `matrice` (fournies), puis `frigo` ; l'option `--frigo` ; un commit.",
         "`python recette.py --frigo farine lait oeufs beurre sucre sel` affiche les cinq recettes auxquelles il manque le moins d'ingrédients.")}

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

{fence(R["frigo"].split("def frigo")[0])}

### C4.2 La fonction `frigo`

Sous `matrice`, écrire :

{fence(squelette_frigo)}

Les outils numpy :

| Pour… | numpy |
|---|---|
| le produit d'un tableau et d'un vecteur | `recettes @ vecteur` |
| la somme de chaque ligne | `recettes.sum(axis=1)` |
| les positions qui rangent les valeurs dans l'ordre croissant | `np.argsort(manquants, kind="stable")` |
| vrai là où deux conditions sont vraies, case par case | `(recettes[ligne] == 1) & (vecteur == 0)` |
| les positions des cases vraies | `np.nonzero(absents)[0]` |

Puis remplacer la fonction `main` par :

{fence(main_c4)}

`nargs="+"` fait de `--frigo` une option qui reçoit un ou plusieurs mots.

Enregistrer. **Vérifications** :

{verifs([
        ("python recette.py --frigo farine lait oeufs beurre sucre sel", "cinq lignes, de `crepes : 1 ingrédient(s) manquant(s) beurre fondu` à `puree : 1 ingrédient(s) manquant(s) pomme de terre`"),
        ("python recette.py --frigo pâtes lardons œufs", "en deuxième ligne, `pates_carbonara : 3 ingrédient(s) manquant(s) fromage rape, poivre, sel` : les noms sont affichés simplifiés"),
        ("python recette.py --frigo chocolat", "`ingrédient inconnu : chocolat`, puis cinq recettes"),
    ])}

« Beurre fondu », dans la recette des crêpes, et « beurre » sont deux
ingrédients différents pour le programme : les noms des fichiers CSV
doivent être harmonisés pour que la recherche les rapproche.

```text
git commit -am "Les recettes faisables avec ce qu'on a"
```

## PR 2 · Le README et la pull request de la branche `frigo`

{encadre("décrire `--toutes` et `--frigo` dans le README ; un commit ; la pull request de la branche `frigo`, fusionnée.",
         "sur le poste, `master` contient toutes les fonctionnalités ; `git log --oneline --graph` montre les deux fusions.")}

Dans `README.md`, ajouter dans la partie qui décrit l'utilisation les deux
commandes, `python recette.py --toutes` et `python recette.py --frigo …`,
avec ce qu'elles écrivent ou affichent, et une phrase sur l'environnement
(`conda env create -f environment.yml`).

```text
git commit -am "README : --toutes, --frigo et l'environnement"
```

{pull_request("frigo", "Les recettes faisables", " (`--frigo`)")}

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

{fence(fonction(final, "noms_des_recettes"))}

{fence(fonction(final, "sommaire"))}

{fence(fonction(c3, "photo"))}

{fence(fonction(final, "frigo"))}
"""


# ============================================================ TD 7b

def guide_train():
    T = corriges.T
    c1 = corriges.train("c1")
    c2 = corriges.train("c2")
    c3 = corriges.train("c3")
    final = corriges.train("c4")
    serie_c1 = fonction(c1, "serie")
    squelette_image = '''def image(fichier, decor, plans, numero):
    """L'image numéro `numero` : le fond, chaque plan décalé de numero × sa vitesse, puis la fenêtre."""
    commande = [MAGICK] + arguments_fond(decor)
    for nom, vitesse in plans:
        # à écrire : ajouter à commande le morceau du plan, décalé de numero × vitesse, puis "-composite"
    commande = commande + arguments_fenetre(decor) + ["-composite"]
    commande = commande + [str(fichier)]
    subprocess.run(commande, check=True)'''
    squelette_lire_plans = '''def lire_plans(decor):
    """Les plans de `decor/plans.csv`, du plus lointain au plus proche : une liste de (fichier, vitesse)."""
    plans = []
    # à écrire : ouvrir decor / "plans.csv" avec with et open (encoding="utf-8", newline="")
    # à écrire : un lecteur csv.reader ; next(lecteur) passe la ligne des noms de colonnes
    # à écrire : pour chaque ligne (nom, vitesse), ajouter (nom, int(vitesse)) à plans
    return plans'''
    squelette_boucle = '''def poteaux_boucle(image, numero):
    """Les bandes des poteaux, pixel par pixel : chaque valeur multipliée par 6/10."""
    hauteur, largeur, _ = image.shape
    resultat = image.copy()
    # à écrire : pour chaque ligne y, chaque colonne x : si la colonne est dans une bande,
    #            chaque valeur des trois canaux devient int(valeur) * 6 // 10
    return resultat'''
    squelette_numpy = '''def poteaux_numpy(image, numero):
    """Les bandes des poteaux, sur les colonnes entières."""
    largeur = image.shape[1]
    # à écrire : colonnes, un tableau de booléens, vrai pour les colonnes dans une bande
    resultat = image.copy()
    # à écrire : ces colonnes de resultat reçoivent image[:, colonnes], convertie en uint16, * 6 // 10
    return resultat'''
    squelette_periode = '''def periode(vitesse):
    """Le nombre d'images après lequel un plan de cette vitesse revient à sa position de départ."""
    # à écrire : LARGEUR_BANDE divisé (division entière) par le pgcd de LARGEUR_BANDE et de vitesse


def images_pour_boucler(plans):
    """Le plus petit nombre d'images après lequel tous les plans reviennent ensemble au départ."""
    nombre = 1
    # à écrire : pour chaque plan, nombre devient le ppcm de nombre et de la période du plan
    return nombre'''

    return ENTETE.format(titre="TD 7b — La scène complète du train") + f"""
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

{DEBUT_SEANCE.format(td="7b_train")}
## C0 · Le dépôt, numpy et Pillow, une branche

{encadre("le dépôt `train` dans `travail/` ; numpy et Pillow dans l'environnement `animation`, ajoutés à `environment.yml` ; une branche `plans`.",
         "`python -c \"import numpy, PIL\"` ne répond rien ; `git branch` affiche `* plans`.")}

{depot("train", "`ls` liste `train.py`, `decor` et `README.md` ; `ls decor` liste `voiles.png`, `plage_jaune.png` et `plage.png`.")}

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

{encadre("`arguments_plan` reçoit le fichier de la bande ; la liste `PLANS` ; `image` ajoute un morceau par plan ; `serie` et `main` passent le numéro de l'image ; un commit.",
         "`python train.py --numero 40` écrit `sortie/train_0040.png` avec les trois plans.")}

Sur l'image numéro `n`, un plan de vitesse `v` est décalé de `n × v`
pixels. Les plans sont posés du plus lointain au plus proche, puis la
fenêtre.

**Le plan reçoit sa bande.** Remplacer la fonction `arguments_plan` par :

{fence(T["plan"])}

**La liste des plans et la fonction `image`.** Remplacer la fonction `image`
par la liste `PLANS`, puis la nouvelle fonction `image` :

{fence(T["plans-liste"] + chr(10) + chr(10) + squelette_image)}

**La série.** Remplacer toute la partie `# ---- Une série d'images`, de ce
titre jusqu'à la ligne qui précède `# ---- La vidéo`, par :

{fence(chr(10) + "# ---- Une série d'images ------------------------------------------------------" + chr(10) + chr(10) + serie_c1)}

La fonction `decalages` disparaît : chaque plan calcule son décalage à partir
du numéro de l'image.

**`main`.** Remplacer toute la fonction `main` par :

{fence(fonction(c1, "main"))}

L'option `--decalage` devient `--numero` : le numéro d'une image seule.

Enregistrer. **Vérifications** :

{verifs([
        ("python train.py --numero 40", "`…/sortie/train_0040.png 640x480` : les voiles décalées de 160 pixels, la plage jaune de 320, la plage orange de 640"),
        ("python train.py --images 48 --video", "`48 images dans …`, puis la vidéo ; la plage orange passe plus vite que les voiles"),
    ])}

```text
git commit -am "Plusieurs plans, chacun à sa vitesse"
```

## C2 · Les plans dans un fichier du décor

{encadre("le fichier `decor/plans.csv` ; la fonction `lire_plans` ; `PLANS` disparaît du code ; un commit.",
         "changer une vitesse dans `plans.csv` change les images, sans modifier `train.py`.")}

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

{fence(squelette_lire_plans)}

Puis, dans `serie`, remplacer `plans = PLANS` par `plans = lire_plans(decor)`,
et remplacer la fonction `main` par :

{fence(fonction(c2, "main"))}

Enregistrer. **Vérifications** :

{verifs([
        ("python train.py --numero 40", "la même image qu'à l'étape C1"),
        ("python train.py --numero 40", "après avoir mis la vitesse des voiles à 40 dans `plans.csv` : les voiles ont bougé ; remettre 4 ensuite"),
        ("python train.py --decor absent", "`error: plans.csv introuvable dans absent`"),
    ])}

```text
git add decor/plans.csv
git commit -am "Les plans dans decor/plans.csv"
```

## PR 1 · La pull request de la branche `plans`

{encadre("pousser la branche `plans`, ouvrir la pull request, la fusionner sur le site, puis `git pull` sur `master`.",
         "sur le poste, `master` contient les commits de C0 à C2.")}

{pull_request("plans", "Plusieurs plans", " (`--numero 40`, une vidéo)")}

## C3 · L'effet des poteaux

{encadre("une branche `poteaux` ; le notebook `tableaux.ipynb` ; `poteaux_boucle`, puis `poteaux_numpy` ; le test ; l'option `--effet` ; le chronométrage et `RAPPORT.md` ; un commit à chaque fois.",
         "`python test_effet.py` affiche `True` quatre fois ; le tableau des temps dans `RAPPORT.md`.")}

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

{fence(T["outils-effet"] + T["poteaux-constantes"])}

`appliquer(effet)` lit chaque image de la série, lui applique la fonction
`effet`, et réécrit le fichier. Sous les constantes, écrire :

{fence(squelette_boucle)}

`int(valeur)` convertit l'octet en entier Python, qui ne dépasse jamais
255 : le produit `valeur * 6` reste juste.

```text
git commit -am "Poteaux : la version boucle"
```

### C3.3 L'effet avec numpy, et le test

Sous `poteaux_boucle`, écrire la version numpy, qui calcule toutes les
colonnes d'un coup, puis le dictionnaire des effets :

{fence(squelette_numpy + chr(10) + chr(10) + chr(10) + 'EFFETS = {"poteaux": poteaux_numpy}')}

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

{fence(fonction(c3, "main"))}

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

{encadre("les fonctions `periode` et `images_pour_boucler` ; l'option `--boucle` ; un commit.",
         "`python train.py --boucle --video` écrit 480 images, et la vidéo relancée en boucle ne saute pas.")}

Un plan de vitesse `v` revient à sa position de départ quand le décalage
`n × v` est un multiple de 1 920, la largeur de la bande : après
`1920 // pgcd(1920, v)` images. Toute la scène revient au départ après le
plus petit multiple commun de ces périodes. `math.gcd` et `math.lcm`
calculent le pgcd et le ppcm.

En tête du fichier, ajouter `import math` sous `import csv`. Sous la fonction
`serie`, écrire :

{fence("# ---- Une vidéo qui boucle ----------------------------------------------------" + chr(10) + chr(10) + "LARGEUR_BANDE = 1920      # la largeur des bandes des plans, en pixels" + chr(10) + chr(10) + chr(10) + squelette_periode)}

Puis remplacer la fonction `main` par :

{fence(fonction(final, "main"))}

Enregistrer. **Vérifications** :

{verifs([
        ("python -c \"import train; from pathlib import Path; print(train.images_pour_boucler(train.lire_plans(Path('decor'))))\"", "`480` : les périodes 480, 240 et 120"),
        ("python train.py --boucle --effet poteaux --video --nettoyer", "`480 images dans …`, puis la vidéo de 40 secondes"),
    ])}

La période des poteaux, 400 // pgcd(400, 90) = 40 images, divise 480 : la
vidéo boucle aussi avec l'effet.

```text
git commit -am "L'option --boucle"
```

## PR 2 · Le README et la pull request de la branche `poteaux`

{encadre("décrire `--numero`, `plans.csv`, `--effet` et `--boucle` dans le README ; un commit ; la pull request de la branche `poteaux`, fusionnée.",
         "sur le poste, `master` contient toutes les fonctionnalités.")}

```text
git commit -am "README : plans.csv, --effet et --boucle"
```

{pull_request("poteaux", "L'effet des poteaux", " et le tableau des temps de `RAPPORT.md`")}

## Facultatif

- **Un décor de nuit** : un autre dossier de décor, avec ses bandes et son
  `plans.csv`, lu par `--decor` ; le programme ne change pas.
- **Les ombres dans la vitre seulement** : le masque de la vitre, vrai là où
  `fenetre.png` est transparente (`lire` en RGBA, canal 3 égal à 0).
- **Une pull request en binôme** : chacun propose une vitesse ou un plan
  dans le dépôt de l'autre, par un fork et une pull request.

## Annexe · Le code complet

Les fonctions écrites pendant le TD, telles que le corrigé les donne.

{fence(fonction(c1, "image"))}

{fence(fonction(c2, "lire_plans"))}

{fence(fonction(final, "poteaux_boucle"))}

{fence(fonction(final, "poteaux_numpy"))}

{fence(fonction(final, "periode") + chr(10) + chr(10) + chr(10) + fonction(final, "images_pour_boucler"))}
"""


def main():
    cibles = {
        "7a_recette": guide_recette(),
        "7b_train": guide_train(),
    }
    for td, texte in cibles.items():
        assert "#@" not in texte
        cible = DEPOT / "src" / "cours7" / "notebook" / "td" / td / "guide.md"
        cible.parent.mkdir(parents=True, exist_ok=True)
        cible.write_text(texte, encoding="utf-8")
        print("ok", cible.relative_to(DEPOT))


if __name__ == "__main__":
    main()
