---
title: "TD 7a — Compléter un projet GitHub, par des pull requests"
subtitle: Guide détaillé, étape par étape
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

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

Chaque fonctionnalité se développe sur une branche, puis arrive sur
`master` par une pull request, fusionnée sur le site de GitHub.

Le guide donne les modifications du programme par blocs. Les lignes en
vert, entre deux lignes `+++`, sont à ajouter : les copier telles quelles,
sans les lignes `+++`. Les lignes en rouge, entre deux lignes `---`, sont à
supprimer. Les autres lignes ne changent pas et indiquent l'endroit : le
nombre qui les précède est le numéro de la ligne dans VS Code, quand les
modifications sont faites de haut en bas.

| Étape | Objectif | Durée |
|---|---|---|
| [D0](#d0-récupérer-le-projet-github-initial) | copier le dépôt de départ sur son poste puis son compte GitHub, lancer le programme (test) | 15′ |
| [D1](#d1-générer-la-page-html-dune-recette) | écrire la page HTML d'une recette : ajout de la liste d'ingrédients, conversion HTML | 25′ |
| [D2](#d2-soumettre-les-modifications-avec-une-pull-request) | proposer la branche par une pull request | 10′ |
| [D3](#d3-toutes-les-recettes) | générer les pages de toutes les recettes avec un seul appel de commande | 20′ |
| [D4](#d4-le-sommaire) | écrire une page d'index des recettes ; deuxième pull request | 15′ |
| [D5](#d5-bonus-les-pages-sur-github-pages) (bonus) | publier les pages avec GitHub Pages | |

## Au début de la séance

- Le compte GitHub du cours 6.
- L'archive `info01-cours7.zip`, copiée depuis `formationTemp` sur le
  Bureau, puis extraite : clic droit, Extraire tout, en effaçant la fin du
  dossier proposé, `\info01-cours7`. Le dossier extrait est
  `Desktop\cours7`.

Ouvrir le dossier `cours7/7a_recette/` dans VS Code, puis un terminal Git Bash
(menu Terminal, New Terminal ; flèche à côté du `+`, Git Bash).

## D0 · Récupérer le projet GitHub initial

> **À faire :** créer sur votre compte GitHub un dépôt vide `td7a-recette` ; cloner dans `travail/recette/` le dépôt de départ du module, puis l'envoyer vers votre nouveau dépôt GitHub ; régler votre nom et votre adresse pour ce dépôt.
>
> **À obtenir :** la page GitHub de votre dépôt `td7a-recette` affiche `recette.py` et les commits du TD 4a ; exécuter depuis le dossier `travail/recette/`, `python recette.py crepes -p 6` écrit `sortie/crepes_6_SI.csv`.

Le dépôt de départ, `td7a-recette`, est sur le compte GitHub du module,
`geodata-ing1-info-01`. Le TD se fait dans une copie de ce dépôt, sur votre
compte : vous y poussez vos branches et y fusionnez vos pull requests.

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
`push` suivants utilisent votre nouveau dépôt.

Régler ensuite votre nom et votre adresse pour ce dépôt :

```text
git config user.name "Prénom Nom"
git config user.email "prenom.nom@exemple.fr"
```

**Vérification** : exécuter depuis le dossier `travail/recette/` la commande `python recette.py crepes -p 6` affiche

```text
crepes pour 6 personnes, en unités SI
Farine : 375.0 g
Lait : 750.0 ml
Œufs : 6.0 
Sel : 3.0 g
Beurre fondu : 75.0 g
écrit : C:\Users\eleve\Desktop\cours7\7a_recette\travail\recette\sortie\crepes_6_SI.csv
```

## D1 · Générer la page HTML d'une recette

> **À faire :** sur une branche `page` : modifier le programme pour qu'il complète le texte de la recette par le tableau des ingrédients (D1.1), puis convertisse ce texte en page HTML en appelant pandoc (D1.2) ; faire un commit à la fin de D1.1 et à la fin de D1.2.
>
> **À obtenir :** `python recette.py crepes -p 6 --page` écrit `sortie/crepes.md`, puis `sortie/crepes.html`, la page de la figure du début du guide.

Au départ, `recette.py` écrit les quantités d'une recette dans un fichier
CSV. L'étape D1 modifie ce programme pour qu'il écrive aussi la page HTML
de la recette, celle de la figure du début du guide. Cette page réunit
deux choses : le texte de la recette (le titre, le temps de préparation,
les étapes), écrit à la main dans un fichier Markdown, et le tableau des
ingrédients, que le programme calcule déjà.

Les modifications à faire, dans l'ordre :

1. Ajouter au projet le texte des recettes, un fichier Markdown par recette
   dans `recettes/`. Ce texte sert de modèle : sa section `## Ingrédients`
   est vide, et le programme la remplit.
2. Écrire une fonction, `tableau`, qui convertit la liste des ingrédients
   en tableau Markdown.
3. Écrire une fonction, `ecrire_markdown`, qui place ce tableau dans le
   texte de la recette, sous `## Ingrédients`, et écrit le résultat dans
   `sortie/`.
4. Modifier le programme principal pour qu'il écrive ce texte complété,
   seulement quand la commande porte une nouvelle option, `--page` :
   `python recette.py crepes -p 6 --page`. Sans l'option, le programme fait
   ce qu'il faisait avant.
5. Convertir le texte complété en page HTML avec pandoc : une fonction,
   `ecrire_page`, qui place aussi la feuille de style à côté de la page.

Les modifications 1 à 4 forment l'étape D1.1, la modification 5 l'étape
D1.2. Toutes se font sur une branche, `page`, à créer avant la première :

```text
git checkout -b page
```

### D1.1 Ajouter le tableau des ingrédients au texte de la recette

Les deux nouvelles fonctions transforment des données que l'exemple des
crêpes, pour 6 personnes en unités SI, permet de suivre : le texte de la
recette, la liste des ingrédients, puis le texte complété.

**Le texte de la recette.** Le texte de chaque recette est fourni dans
`depart/recettes/`, un fichier Markdown par recette. Le texte des crêpes :

```markdown
# Crêpes

*10 minutes de préparation, 1 heure de repos.*

## Ingrédients

## Préparation

1. Mélanger la farine et le sel dans un saladier.
2. Casser les œufs au centre et mélanger.
3. Verser le lait **peu à peu**, sans cesser de remuer.
4. Ajouter le beurre fondu.
5. Laisser reposer une heure.
6. Cuire dans une poêle chaude, une minute par face.

> La pâte se conserve 24 heures au réfrigérateur.
```

Sa section `## Ingrédients` est vide : la fonction `ecrire_markdown` y
placera le tableau des ingrédients.

**La liste des ingrédients et son tableau Markdown.** Dans le programme,
les ingrédients d'une recette sont une liste de tuples, un tuple par
ingrédient : son nom, sa quantité et son unité. `lire_ingredients` lit
cette liste dans le fichier CSV, puis `adapter` et `convertir` en
recalculent les quantités. Pour les crêpes, la liste `ingredients` vaut :

```python
ingredients = [
    ("Farine", 375.0, "g"),
    ("Lait", 750.0, "ml"),
    ("Œufs", 6.0, ""),
    ("Sel", 3.0, "g"),
    ("Beurre fondu", 75.0, "g"),
]
```

L'appel `tableau(ingredients)` renvoie le tableau Markdown de cette liste :
deux lignes d'en-tête, puis une ligne par ingrédient, la quantité et
l'unité dans la seconde colonne :

```markdown
| Ingrédient | Quantité |
|---|---|
| Farine | 375.0 g |
| Lait | 750.0 ml |
| Œufs | 6.0  |
| Sel | 3.0 g |
| Beurre fondu | 75.0 g |
```

**Le texte complété.** L'appel `ecrire_markdown("crepes", 6, "SI",
ingredients)` lit le texte de la recette, `recettes/crepes.md`. Il remplace
sa ligne `## Ingrédients` par un titre, `## Ingrédients pour 6 personnes,
en unités SI`, suivi du tableau : `replace` renvoie le texte avec ce
remplacement. Il écrit le résultat dans `sortie/crepes.md`, et renvoie ce
chemin. Le début du texte complété :

```markdown
# Crêpes

*10 minutes de préparation, 1 heure de repos.*

## Ingrédients pour 6 personnes, en unités SI

| Ingrédient | Quantité |
|---|---|
| Farine | 375.0 g |
| Lait | 750.0 ml |
| Œufs | 6.0  |
| Sel | 3.0 g |
| Beurre fondu | 75.0 g |

…
```

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

```modif
   69
   70
+++
def tableau(ingredients):
    """Le tableau Markdown des ingrédients, une ligne par ingrédient."""
    lignes = ["| Ingrédient | Quantité |", "|---|---|"]
    for nom, quantite, unite in ingredients:
        lignes.append("| " + nom + " | " + str(round(quantite, 1)) + " " + unite + " |")
    return "\n".join(lignes)


def ecrire_markdown(nom, personnes, unites, ingredients):
    """Le texte de recettes/<nom>.md, avec le tableau des ingrédients sous « ## Ingrédients », écrit dans sortie/ ; renvoie son chemin."""
    source = (DONNEES / (nom + ".md")).read_text(encoding="utf-8")
    intitule = "## Ingrédients pour " + str(personnes) + " personnes, en unités " + unites
    complete = source.replace("## Ingrédients", intitule + "\n\n" + tableau(ingredients))
    markdown = SORTIE / (nom + ".md")
    markdown.write_text(complete, encoding="utf-8")
    return markdown


+++
   89 # ---- Le programme -------------------------------------------------------------
   90
```

**Modification 4, l'option `--page`.** `action="store_true"` fait de
`--page` une option sans valeur : `options.page` vaut `True` quand la
commande porte l'option, `False` sinon. Le programme principal n'appelle
`ecrire_markdown` que dans le premier cas, après l'écriture du fichier CSV :

```modif
   94 analyseur.add_argument("-p", "--personnes", type=int, default=4, help="nombre de personnes (défaut : 4)")
   95 analyseur.add_argument("-u", "--unites", choices=("SI", "US"), default="SI", help="système d'unités (défaut : SI)")
+++
analyseur.add_argument("--page", action="store_true", help="écrit aussi la page de la recette : son texte complété, puis sa page HTML")
+++
   97 options = analyseur.parse_args()
   98 NOM = options.nom
    …
  116 ecrire_ingredients(fichier, ingredients)
  117 print("écrit :", fichier)
+++

if options.page:
    markdown = ecrire_markdown(NOM, PERSONNES, UNITES, ingredients)
    print("écrit :", markdown)
+++
```

**Vérification** : `python recette.py crepes -p 6 --page` se termine par

```text
écrit : C:\Users\eleve\Desktop\cours7\7a_recette\travail\recette\sortie\crepes.md
```

Ouvrir `sortie/crepes.md` dans VS Code (`Ctrl` + `Maj` + `V` pour
l'aperçu) : il commence par le texte complété montré plus haut.

```text
git add recettes
git commit -am "Le texte de la recette, complété par le tableau des ingrédients"
```

### D1.2 Générer la page HTML en appelant pandoc

pandoc convertit un fichier Markdown en page HTML, comme au cours 3.
L'appel `ecrire_page(markdown)`, où `markdown` est le chemin
`sortie/crepes.md` que renvoie `ecrire_markdown`, lance pandoc avec
`subprocess.run`. pandoc écrit la page `sortie/crepes.html` : le même
chemin, avec l'extension `.html` (`with_suffix(".html")`). La page a besoin
d'une feuille de style, `style.css`, fournie dans `depart/` : `ecrire_page`
la copie à côté de la page, dans `sortie/`.

**Modification 5, la page HTML.** Copier la feuille de style dans le
projet :

```text
cp ../../depart/style.css .
```

Puis ajouter une fonction, `ecrire_page`, et son appel après celui de
`ecrire_markdown` :

```modif
    3 import argparse
    4 import csv
+++
import shutil
import subprocess
+++
    7 from pathlib import Path
    8
    …
   20 DONNEES = RACINE / "recettes"
   21 SORTIE = RACINE / "sortie"
+++
STYLE = RACINE / "style.css"
+++
   23
   24
    …
   90
   91
+++
def ecrire_page(markdown):
    """La page HTML d'un fichier Markdown de sortie/, par pandoc, avec la feuille de style ; renvoie son chemin."""
    titre = markdown.read_text(encoding="utf-8").splitlines()[0].lstrip("# ")
    shutil.copy(STYLE, markdown.parent / "style.css")
    page = markdown.with_suffix(".html")
    subprocess.run(["pandoc", str(markdown), "-o", str(page), "--standalone",
                    "--css", "style.css", "--metadata", "pagetitle=" + titre], check=True)
    return page


+++
  102 # ---- Le programme -------------------------------------------------------------
  103
    …
  133     markdown = ecrire_markdown(NOM, PERSONNES, UNITES, ingredients)
  134     print("écrit :", markdown)
+++
    page = ecrire_page(markdown)
    print("écrit :", page)
+++
```

**Vérification** : `python recette.py crepes -p 6 --page` se termine par

```text
écrit : C:\Users\eleve\Desktop\cours7\7a_recette\travail\recette\sortie\crepes.md
écrit : C:\Users\eleve\Desktop\cours7\7a_recette\travail\recette\sortie\crepes.html
```

```text
start sortie/crepes.html
```

ouvre la page dans le navigateur : celle de la figure du début du guide.

```text
git add style.css
git commit -am "La page HTML de la recette, par pandoc"
```

## D2 · Soumettre les modifications avec une pull request

> **À faire :** pousser la branche `page` ; ouvrir la pull request sur GitHub et la fusionner ; ramener `master` sur le poste.
>
> **À obtenir :** sur GitHub, la pull request est fusionnée ; `git log --oneline --graph` montre le commit de fusion sur `master`.

La branche `page` contient maintenant la nouvelle fonctionnalité, sur le
poste seulement. Une pull request la propose sur GitHub, pour la fusionner
dans `master`. Dans un projet à plusieurs, une autre personne relit alors
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

## D3 · Toutes les recettes

> **À faire :** sur une branche `livre` : six recettes de plus ; une fonction, `noms_des_recettes` (D3.1) ; le programme répété pour chaque nom, avec l'option `--toutes` (D3.2) ; un commit.
>
> **À obtenir :** `python recette.py --toutes --page` écrit les pages des dix recettes dans `sortie/`.

Jusqu'ici, une commande écrit la page d'une seule recette : il faudrait dix
commandes pour dix recettes. L'option `--toutes` fait le travail pour chaque
recette de `recettes/`, en une commande.

Les modifications à faire, dans l'ordre :

1. Ajouter au projet les six autres recettes, leur fichier CSV et leur
   texte.
2. Écrire une fonction, `noms_des_recettes`, qui renvoie la liste des noms
   des recettes de `recettes/` (D3.1).
3. Modifier le programme principal pour qu'il répète ses lignes pour chaque
   nom de cette liste, quand la commande porte une nouvelle option,
   `--toutes` : `python recette.py --toutes --page` (D3.2).

Toutes se font sur une branche, `livre`. Créer la branche, puis copier les
six recettes :

```text
git checkout -b livre
cp ../../depart/recettes/*.csv ../../depart/recettes/*.md recettes/
ls recettes
```

**Vérification** : `ls` liste dix fichiers `.csv` et dix fichiers `.md`.

### D3.1 La liste des noms des recettes

Le nom d'une recette est celui de son fichier CSV, sans l'extension :
`crepes` pour `crepes.csv`. `DONNEES.glob("*.csv")` renvoie les chemins des
fichiers de `recettes/` dont le nom se termine par `.csv`, et `stem` est le
nom d'un chemin sans son extension. La fonction `noms_des_recettes` renvoie
la liste des dix noms, de `cookies` à `tarte_pommes`.

```modif
   98                     "--css", "style.css", "--metadata", "pagetitle=" + titre], check=True)
   99     return page
+++


def noms_des_recettes():
    """Le nom de chaque recette de recettes/ : ses fichiers .csv, sans l'extension."""
    noms = []
    for chemin in sorted(DONNEES.glob("*.csv")):
        noms.append(chemin.stem)
    return noms
+++
```

### D3.2 Le programme, pour chaque nom

Le programme ne traite qu'une recette, `NOM`. Pour les traiter toutes, ses
lignes se répètent dans une boucle sur une liste de noms : tous les noms
avec `--toutes`, sinon le seul nom donné.

1. Remplacer les lignes de `analyseur.add_argument("nom", …)` à
   `UNITES = options.unites` par celles du bloc ci-dessous, jusqu'à
   `for nom in noms:`. `nargs="?"` rend le nom facultatif : avec
   `--toutes`, il n'est pas donné.
2. Sélectionner les lignes suivantes, de `ingredients = lire_ingredients(…)`
   jusqu'à la fin du fichier, et appuyer sur `Tab` : elles passent dans la
   boucle.
3. Dans ces lignes, remplacer `NOM` par `nom`, la variable de la boucle.

Le programme devient :

```python
# Les valeurs viennent de la ligne de commande
analyseur = argparse.ArgumentParser(description="Les ingrédients d'une recette pour un nombre de personnes, en unités SI ou US.")
analyseur.add_argument("nom", nargs="?", help="la recette : un fichier de recettes/, sans .csv")
analyseur.add_argument("-p", "--personnes", type=int, default=4, help="nombre de personnes (défaut : 4)")
analyseur.add_argument("-u", "--unites", choices=("SI", "US"), default="SI", help="système d'unités (défaut : SI)")
analyseur.add_argument("--page", action="store_true", help="écrit aussi la page de la recette : son texte complété, puis sa page HTML")
analyseur.add_argument("--toutes", action="store_true", help="toutes les recettes de recettes/, au lieu d'une seule")
options = analyseur.parse_args()
PERSONNES = options.personnes
UNITES = options.unites
if options.toutes:
    noms = noms_des_recettes()
elif options.nom is not None:
    noms = [options.nom]
else:
    analyseur.error("donner le nom d'une recette, ou --toutes")

for nom in noms:
    ingredients = lire_ingredients(DONNEES / (nom + ".csv"))
    ingredients = adapter(ingredients, PERSONNES_RECETTE, PERSONNES)

    if UNITES == "US":
        ingredients = convertir(ingredients, VERS_US)
    else:
        ingredients = convertir(ingredients, VERS_SI)

    print(nom, "pour", PERSONNES, "personnes, en unités", UNITES)
    afficher(ingredients)

    # Le résultat, dans sortie/
    SORTIE.mkdir(exist_ok=True)
    fichier = SORTIE / (nom + "_" + str(PERSONNES) + "_" + UNITES + ".csv")
    ecrire_ingredients(fichier, ingredients)
    print("écrit :", fichier)

    if options.page:
        markdown = ecrire_markdown(nom, PERSONNES, UNITES, ingredients)
        print("écrit :", markdown)
        page = ecrire_page(markdown)
        print("écrit :", page)
```

**Vérification** :

```text
python recette.py --toutes --page
```

affiche chaque recette, puis les fichiers écrits : 10 pages HTML
en tout. Sans nom ni `--toutes`, le programme s'arrête sur

```text
recette.py: error: donner le nom d'une recette, ou --toutes
```

```text
git add recettes
git commit -am "Toutes les recettes"
```

## D4 · Le sommaire

> **À faire :** une fonction, `ecrire_sommaire`, appelée après la boucle ; un commit ; la pull request de la branche `livre`.
>
> **À obtenir :** `sortie/index.html` a un lien vers chaque page ; la branche `livre` est fusionnée dans `master` sur GitHub.

Les dix pages ne sont reliées par aucun lien : pour ouvrir l'une d'elles,
il faut connaître le nom de son fichier. Le sommaire, `sortie/index.html`,
donne un lien vers chacune.

Les modifications à faire, dans l'ordre :

1. Écrire une fonction, `ecrire_sommaire`, qui écrit le sommaire en
   Markdown, `sortie/index.md`, puis le convertit en page HTML par
   `ecrire_page`.
2. Modifier le programme principal pour qu'il appelle cette fonction après
   la boucle, quand la commande porte `--page` et `--toutes`.

La branche `livre` se termine ensuite par un commit et sa pull request,
comme la branche `page` à l'étape D2.

![Le sommaire : un lien par recette](illustrations/sommaire.png)

Le sommaire est une page de plus, écrite comme les autres : un fichier
Markdown, `sortie/index.md`, converti par `ecrire_page`. Il contient un
titre, puis une liste Markdown, un lien par recette :
`- [Crêpes](crepes.html)`. Le texte du lien est le titre de la recette, la
première ligne de son fichier `.md`, sans le `# `.

```modif
  108
  109
+++
def ecrire_sommaire(noms):
    """Le sommaire : sortie/index.md, un lien vers la page de chaque recette, puis sa page HTML ; renvoie son chemin."""
    lignes = ["# Le livre de recettes", ""]
    for nom in noms:
        titre = (DONNEES / (nom + ".md")).read_text(encoding="utf-8").splitlines()[0].lstrip("# ")
        lignes.append("- [" + titre + "](" + nom + ".html)")
    markdown = SORTIE / "index.md"
    markdown.write_text("\n".join(lignes) + "\n", encoding="utf-8")
    return ecrire_page(markdown)


+++
  121 # ---- Le programme -------------------------------------------------------------
  122
    …
  161         page = ecrire_page(markdown)
  162         print("écrit :", page)
+++

# Le sommaire des pages écrites
if options.page and options.toutes:
    sommaire = ecrire_sommaire(noms)
    print("écrit :", sommaire)
+++
```

**Vérification** : `python recette.py --toutes --page` se termine par

```text
écrit : C:\Users\eleve\Desktop\cours7\7a_recette\travail\recette\sortie\index.html
```

`start sortie/index.html` ouvre le sommaire ; chaque lien ouvre une page.

```text
git commit -am "Le sommaire"
git push -u origin livre
```

Puis, sur GitHub, la pull request de la branche `livre`, fusionnée comme à
l'étape D2, et sur le poste :

```text
git checkout master
git pull
```

## D5 (bonus) · Les pages sur GitHub Pages

> **À faire :** copier les pages dans un dossier `docs/` du dépôt ; régler GitHub Pages sur ce dossier.
>
> **À obtenir :** le sommaire s'ouvre à l'adresse `https://<compte>.github.io/td7a-recette/`.

GitHub Pages publie sur le web des pages rangées dans un dépôt GitHub : le
livre de recettes devient lisible par tous, à une adresse en `github.io`.
`sortie/` n'est pas versionné. GitHub Pages publie un dossier versionné :
une copie des pages, dans `docs/`.

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
