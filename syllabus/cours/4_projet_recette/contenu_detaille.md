# Projet 4 — Projet d'application 1, en deux parcours

*Conception du 30/09/2026, après la séance 3 : le TD de la fenêtre du train,
jugé trop ambitieux pour le projet 4, passe au projet 7 ; le projet 4 revoit
à un rythme lent les opérations des cours 1 à 3. Les supports sont
`src/cours4/diapo/cours4.typ`, `tds/4a_recette.typ`, `tds/4b_paquet.typ`, et
les guides `src/cours4/notebook/td/4a_recette/guide.md` et
`4b_paquet/guide.md`, écrits par `data/cours4/generer_recette.py`.*

## TD 4a — Un script Python, pas à pas (tous les élèves)

Proposition du 30/09/2026, à relire. Le TD revoit les opérations des cours 1
à 3 sur un petit programme : le terminal, VS Code, git, puis un programme
Python écrit étape par étape, sans Markdown ni pandoc.

### Ce qui est livré

```text
4a_recette/
├── depart/
│   ├── recette.py        le programme de départ, avec deux erreurs de syntaxe à corriger
│   ├── recettes/         quatre recettes en CSV, chacune pour 4 personnes
│   │   ├── crepes.csv, pate_pizza.csv, mousse_chocolat.csv   (unités SI)
│   │   └── cookies.csv                                       (unités US : cup, oz)
│   └── modeles/README.md
└── travail/              vide : le dossier du projet y est créé à la partie A
```

Les colonnes des CSV sont `ingredient,quantite,unite`, comme au cours 3. Les
quantités sont celles de la recette pour 4 personnes (au cours 3, elles
étaient pour une personne). Une unité vide (œufs, pincée de sel) ne se
convertit pas.

`depart/recette.py` et les corrigés sont écrits par
`data/cours4/generer_recette.py`, qui exécute aussi chaque état et vérifie ses
sorties.

### Partie A · Le dossier du projet (30 min)

| Étape | Objectif | Résultat |
|---|---|---|
| A1 (15′) | créer le dossier du projet dans le terminal : `cd`, `ls`, `mkdir`, `cp` avec `*` | `travail/recette/` contient `recette.py` et `recettes/` |
| A2 (10′) | ouvrir le projet dans VS Code, Git Bash comme terminal, l'interpréteur `base` | le terminal de VS Code affiche `(base)` dans `travail/recette` |
| A3 (5′) | versionner le départ : `git init`, `.gitignore` (`sortie/`), `add`, `commit` | un commit |

Commandes de A1, depuis `cours4/4a_recette/` :

```text
ls depart
ls depart/recettes
mkdir travail/recette
cp depart/recette.py travail/recette/
mkdir travail/recette/recettes
cp depart/recettes/*.csv travail/recette/recettes/
cd travail/recette
ls
pwd
```

### Partie B · Le programme (75 min, un commit par étape, un par erreur corrigée à B1)

| Étape | Objectif | Résultat | Corrigé |
|---|---|---|---|
| B1 (10′) | lire un message d'erreur et corriger : `SyntaxError` (deux-points), puis `TabError` | la recette des crêpes pour 4 s'affiche | `data/cours4/corriges/4a_recette/b1/` |
| B2 (10′) | une fonction qui parcourt une liste : `adapter`, le facteur calculé à partir des deux nombres de personnes | la recette pour 6 (`PERSONNES = 6`) | `b2/` |
| B3 (15′) | un dictionnaire, les deux sens de conversion : `convertir(ingredients, table)` avec `VERS_US` ou `VERS_SI` | `Farine : 13.2 oz` | `b3/` |
| B4 (15′) | lire un fichier CSV : `lire_ingredients`, `pathlib` | la liste initiale des ingrédients a disparu du programme ; `NOM = "cookies"` et `UNITES = "SI"` donnent des grammes et des millilitres | `b4/` |
| B5 (10′) | écrire un fichier CSV : `ecrire_ingredients` | `sortie/crepes_6_US.csv` | `b5/` |
| B6 (15′) | lire les valeurs sur la ligne de commande : `argparse`, sans `main` | `python recette.py cookies -p 8 -u SI`, `--help` | `b6/` |
| B7 (bonus) | un README à partir du modèle, `git tag v1.0` | | |

Vérification possible à B5-B6 : le fichier écrit en unités US, copié dans
`recettes/` et relu en SI pour 4 personnes, redonne les quantités de départ,
à l'arrondi près (374,2 g de farine au lieu de 375).

### Choix faits pour simplifier

- Toutes les recettes sont écrites pour 4 personnes : `PERSONNES_RECETTE`
  reste une constante du programme.
- Une seule fonction de conversion, qui reçoit la table de l'autre système.
- Pas de `main` (le cours 3 l'a mise en bonus du TD 3f) : elle ouvre le TD 4b.
- `argparse` sans `choices` pour le nom de la recette : un nom inconnu
  donne un `FileNotFoundError`, à lire au même titre que les erreurs de B1.
- Les quantités sont affichées et écrites avec `round(quantite, 1)`.

## TD 4b — Un programme installable (parcours avancé)

Proposition du 30/09/2026, à relire. Le TD suit le TD 4a, fait plus vite,
dans le même dossier `travail/recette/`. Il part de l'état de l'étape B6
(`data/cours4/corriges/4a_recette/b6/recette.py`).

Un exposé de quatre diapositives le précède (10 min) : un module et
`import`, un environnement, `environment.yml` et `pip`, `pyproject.toml` et
`[project.scripts]`.

### Ce qui est livré

```text
4b_paquet/
└── depart/modeles/
    ├── environment.yml   l'environnement recette : python 3.12, pandoc, pip
    └── pyproject.toml    la commande recette = recette:main, modules recette et quantites dans src/
```

Les modèles se copient depuis le projet par un chemin relatif :
`cp ../../../4b_paquet/depart/modeles/environment.yml .`

### Étapes

| Étape | Objectif | Résultat | Corrigé |
|---|---|---|---|
| C1 (10′) | le programme dans une fonction `main`, appelée sous `if __name__ == "__main__":` | la même sortie | `data/cours4/corriges/4b_paquet/c1/` |
| C2 (15′) | deux modules : `quantites.py` (tables et fonctions), `recette.py` (le programme), reliés par `from quantites import …` | la même sortie | `c2/` |
| C3 (15′) | un environnement décrit par un fichier : `conda env create -f environment.yml`, `conda activate recette` | `which python` dans l'environnement `recette` | (pas de code) |
| C4 (15′) | la structure d'un projet Python : `git mv` vers `src/`, `pyproject.toml`, `pip install -e .` | la commande `recette cookies -p 8` | `c4/` |
| C5 (bonus) | reprendre `subprocess` et pandoc du cours 3 : l'option `--page` | `sortie/crepes_6_SI.html` | `c5/` |

C3 demande un téléchargement (python, pandoc) : durée à mesurer sur un poste
de la salle. `pip install -e .` a été vérifié avec `--no-build-isolation`
dans un environnement qui contient déjà setuptools ; sans cette option, pip
télécharge setuptools.

### Budget du parcours avancé

TD 4a plus vite (partie A 15′, partie B 35′), exposé 10′, TD 4b 55′ : 115′
avec la présentation de la séance. C5 et le README se font après la séance
si le temps manque.
