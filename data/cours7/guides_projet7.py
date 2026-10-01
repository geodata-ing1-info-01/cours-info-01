"""Les guides des TD 7a (la recette en pages) et 7b (la fenêtre du train).

Appelé par `generer_projet7.py` après la vérification des corrigés : le code
montré vient de `recette(etat)` et `train(etat)`, les blocs de modifications
de `outils/modifications.py`, et les sorties montrées sont celles des
programmes et de git, exécutés au moment de l'écriture.

Écrit `src/cours7/notebook/td/7a_recette/guide.md` et
`src/cours7/notebook/td/7b_train/guide.md`.
"""

from __future__ import annotations

import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

from generer_projet7 import (DEPOT, LIGNE_FENETRE, LIGNES_POTEAUX, TD_RECETTE, TITRE_PROGRAMME, depot_recette,
                             depot_train, ecrire, modifications, recette, train, verifier_train)

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


RAPPEL_MODIFICATIONS = """Le guide donne les lignes à modifier comme ceux du projet 4. Une ligne
marquée `-` est à supprimer, une ligne marquée `+` est à ajouter, sans le
`+` ni les cinq espaces qui le suivent. Les lignes sans signe ne changent
pas et indiquent l'endroit. Le nombre qui suit le signe est le numéro de la
ligne dans VS Code, quand les modifications sont faites de haut en bas."""

DEBUT_SEANCE = """## Au début de la séance

- Le compte GitHub du cours 6, avec la clé SSH du cours 6 enregistrée.
- L'archive `info01-cours7.zip`, copiée depuis `formationTemp` sur le
  Bureau, puis extraite : clic droit, Extraire tout, en effaçant la fin du
  dossier proposé, `\\info01-cours7`. Le dossier extrait est
  `Desktop\\cours7`.

Ouvrir le dossier `cours7/{td}/` dans VS Code, puis un terminal Git Bash
(menu Terminal, New Terminal ; flèche à côté du `+`, Git Bash)."""


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
    texte = ENTETE.format(titre="TD 7a — Compléter son projet, par des pull requests") + f"""
Le TD complète le programme `recette.py` du projet 4, récupéré depuis
GitHub. Aujourd'hui, le programme calcule les ingrédients d'une recette pour
un nombre de personnes et les écrit dans un fichier CSV. À la fin du TD, il
écrit aussi, pour chaque recette, une page HTML qui réunit le texte de la
recette et le tableau des quantités calculées, puis un sommaire qui relie
ces pages, comme un livre de recettes.

![À la fin du TD : la page HTML d'une recette](illustrations/page.png)

![Le sommaire, avec un lien vers chaque page](illustrations/sommaire.png)

Chaque fonctionnalité se développe sur une branche, puis arrive sur
`master` par une pull request, fusionnée sur le site de GitHub.

{RAPPEL_MODIFICATIONS}

| Étape | Objectif | Durée |
|---|---|---|
| [D0](#@D0) | récupérer le projet et le relancer | 15′ |
| [D1](#@D1) | écrire la page HTML d'une recette : le texte complété, puis pandoc | 25′ |
| [D2](#@D2) | proposer la branche par une pull request | 10′ |
| [D3](#@D3) | écrire les pages de toutes les recettes en une commande | 20′ |
| [D4](#@D4) | écrire une page qui relie les autres ; seconde pull request | 15′ |
| [D5](#@D5) (bonus) | publier les pages avec GitHub Pages | |

{DEBUT_SEANCE.format(td="7a_recette")}

## D0 · Récupérer le projet

{encadre("le dépôt `recette` dans `travail/`, depuis GitHub ; votre nom et votre adresse pour ce dépôt.",
         "`python recette.py crepes -p 6` écrit `sortie/crepes_6_SI.csv` ; `git log --oneline` affiche l'historique du projet 4.")}

**Cas A, votre dépôt `recette` est sur GitHub et le programme fonctionne.**
Sur sa page GitHub, bouton Code, onglet SSH, copier l'adresse, puis :

```text
cd travail
git clone git@github.com:<compte>/recette.git
cd recette
```

**Cas B, pas de dépôt, ou un programme qui ne fonctionne pas.** Le module
publie un dépôt de référence, `td7a-recette`, sur le compte GitHub
`geodata-ing1-info-01`. Sur son compte GitHub, créer d'abord un dépôt vide nommé `recette` (New repository, sans
README), puis :

```text
cd travail
git clone git@github.com:geodata-ing1-info-01/td7a-recette.git recette
cd recette
git remote set-url origin git@github.com:<compte>/recette.git
git push -u origin master
```

`git remote set-url` change l'adresse du dépôt distant `origin` : les
`push` suivants vont au dépôt de l'élève. Le dernier argument de
`git clone` nomme le dossier local `recette`, comme dans le cas A. Le dépôt
garde l'historique du projet 4.

Dans les deux cas, régler votre nom et votre adresse pour ce dépôt :

```text
git config user.name "Prénom Nom"
git config user.email "prenom.nom@exemple.fr"
```

**Vérification** : `python recette.py crepes -p 6` affiche

{sortie("a0", "crepes", "-p", "6")}

## D1 · La page d'une recette

{encadre("sur une branche `page` : compléter le texte de la recette par le tableau des ingrédients (D1.1), puis convertir ce texte en page HTML par pandoc (D1.2) ; un commit pour chacune.",
         "`python recette.py crepes -p 6 --page` écrit `sortie/crepes.md`, puis `sortie/crepes.html`, la page de la figure du début du guide.")}

La page d'une recette réunit deux choses : le texte de la recette (le titre,
le temps de préparation, les étapes), écrit à la main dans un fichier
Markdown, et le tableau des ingrédients, calculé par le programme. Le
programme les réunit dans un fichier Markdown complet (D1.1), puis pandoc
convertit ce fichier en page HTML (D1.2).

### D1.1 Le texte de la recette, complété par le tableau

```text
git checkout -b page
cp ../../depart/style.css .
cp ../../depart/recettes/crepes.md ../../depart/recettes/pate_pizza.md recettes/
cp ../../depart/recettes/mousse_chocolat.md ../../depart/recettes/cookies.md recettes/
```

Chaque recette a maintenant deux fichiers : les ingrédients, en CSV, et le
texte, en Markdown. Le texte des crêpes :

{fence(crepes_md, "markdown")}

La section `## Ingrédients` est vide. La fonction `ecrire_markdown` la
remplace par un titre, `## Ingrédients pour 6 personnes, en unités SI`,
suivi du tableau des ingrédients, que la fonction `tableau` écrit en
Markdown, une ligne par ingrédient. `replace` renvoie le texte avec ce
remplacement. Le résultat est écrit dans `sortie/crepes.md`.

{modifications(recette("a0"), recette("d1a"))}

**Vérification** : `python recette.py crepes -p 6 --page` se termine par

{dernieres("d1a", 1, "crepes", "-p", "6", "--page", preparer=preparer_d1)}

Ouvrir `sortie/crepes.md` dans VS Code (`Ctrl` + `Maj` + `V` pour
l'aperçu) :

{fence(extrait_complete, "markdown")}

```text
git add style.css recettes
git commit -am "Le texte de la recette, complété par le tableau des ingrédients"
```

### D1.2 La page HTML, par pandoc

pandoc convertit un fichier Markdown en page HTML, comme au cours 3. La
fonction `ecrire_page` le lance avec `subprocess.run`, et copie la feuille
de style `style.css` à côté de la page. `with_suffix(".html")` donne le
chemin du même fichier avec l'extension `.html`.

{modifications(recette("d1a"), recette("d1"))}

**Vérification** : `python recette.py crepes -p 6 --page` se termine par

{dernieres("d1", 2, "crepes", "-p", "6", "--page", preparer=preparer_d1)}

```text
start sortie/crepes.html
```

ouvre la page dans le navigateur : celle de la figure du début du guide.

```text
git commit -am "La page HTML de la recette, par pandoc"
```

## D2 · La pull request

{encadre("pousser la branche `page` ; ouvrir la pull request sur GitHub et la fusionner ; ramener `master` sur le poste.",
         "sur GitHub, la pull request est fusionnée ; `git log --oneline --graph` montre le commit de fusion sur `master`.")}

```text
git push -u origin page
```

Sur la page du dépôt, GitHub affiche un bandeau « page had recent pushes » :
bouton Compare & pull request, puis Create pull request. La page de la pull
request montre les commits et les modifications de la branche. Bouton Merge
pull request, puis Confirm merge : la branche est fusionnée dans `master`,
sur GitHub.

Le dépôt du poste ne le sait pas encore :

```text
git checkout master
git pull
git log --oneline --graph
```

**Vérification** : la dernière ligne du graphe est le commit `Merge pull
request #1`, et `recette.py` contient `ecrire_page`.

## D3 · Toutes les recettes

{encadre("sur une branche `livre` : six recettes de plus ; la fonction `noms_des_recettes` (D3.1) ; le programme répété pour chaque nom, avec l'option `--toutes` (D3.2) ; un commit.",
         "`python recette.py --toutes --page` écrit les pages des dix recettes dans `sortie/`.")}

Jusqu'ici, une commande écrit la page d'une seule recette : il faudrait dix
commandes pour dix recettes. L'option `--toutes` fait le travail pour chaque
recette de `recettes/`, en une commande. Le programme a besoin pour cela de
la liste des noms des recettes (D3.1), puis répète ses lignes pour chaque
nom de cette liste (D3.2).

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
la liste des dix noms, de `{noms[0]}` à `{noms[-1]}`.

{modifications(d1_debut, d3_debut)}

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

{fence(d3_programme)}

**Vérification** :

```text
python recette.py --toutes --page
```

affiche chaque recette, puis les fichiers écrits : {len(pages)} pages HTML
en tout. Sans nom ni `--toutes`, le programme s'arrête sur

{fence(sans_argument, "text")}

```text
git add recettes
git commit -am "Toutes les recettes"
```

## D4 · Le sommaire

{encadre("la fonction `ecrire_sommaire`, appelée après la boucle ; un commit ; la pull request de la branche `livre`.",
         "`sortie/index.html` a un lien vers chaque page ; la branche `livre` est fusionnée dans `master` sur GitHub.")}

![Le sommaire : un lien par recette](illustrations/sommaire.png)

Le sommaire est une page de plus, écrite comme les autres : un fichier
Markdown, `sortie/index.md`, converti par `ecrire_page`. Il contient un
titre, puis une liste Markdown, un lien par recette :
`- [Crêpes](crepes.html)`. Le texte du lien est le titre de la recette, la
première ligne de son fichier `.md`, sans le `# `.

{modifications(recette("d3"), recette("d4"))}

**Vérification** : `python recette.py --toutes --page` se termine par

{fence(sommaire, "text")}

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

{encadre("copier les pages dans un dossier `docs/` du dépôt ; régler GitHub Pages sur ce dossier.",
         "le sommaire s'ouvre à l'adresse `https://<compte>.github.io/recette/`.")}

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

**Vérification** : `https://<compte>.github.io/recette/` affiche le
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

| Étape | Objectif | Durée |
|---|---|---|
| [E0](#@E0) | récupérer un projet et son environnement, le faire tourner | 20′ |
| [E1](#@E1) | lire le code d'un autre : comment une image est composée | 10′ |
| [E2](#@E2) | effet 1, la fenêtre du train, sur une branche ; une pull request | 20′ |
| [E3](#@E3) | effet 2, les ombres des poteaux avec numpy, sur une autre branche ; un conflit | 40′ |
| [E4](#@E4) (bonus) | un troisième plan, sans modifier le code | |

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

{modifications(r2, train("e2"))}

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

{modifications(r2, train("e3"))}

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
