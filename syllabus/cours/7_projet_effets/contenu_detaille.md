# Projet 7 — Une fonctionnalité de plus, livrée par une pull request (document de conception)

> 27/09/2026. Séance du 03/11/2026. Remplace le premier jet du 24/09 (un effet d'image au choix, en boucle puis avec numpy, pour la montre et le tourbillon du projet 4). Depuis le 26/09, les cours 3 et 4 ont deux parcours : le parcours standard aboutit au programme `recette.py` (TD 3a du cours 3, repris au TD 4b), le parcours avancé au programme `train.py` (TD 4c). Le projet 7 suit ces deux parcours : TD 7a pour la recette, TD 7b pour le train ([variante_train.md](variante_train.md)). Le dossier garde son nom, `7_projet_effets/`, pour ne pas casser les liens.

## Objectif

Chaque élève ajoute des fonctionnalités à son programme du projet 4, dans son dépôt GitHub (cours 6), et les livre par des pull requests. Une des fonctionnalités se calcule avec numpy, sur un tableau de nombres.

| Compétence | Vue | Ici |
|---|---|---|
| Installer un paquet dans un environnement, et le noter dans `environment.yml` | cours 3 (TD 0a), projet 4 | Pillow et numpy |
| Branche, commit, `merge` | cours 2, projet 4 | une branche par fonctionnalité |
| `push`, pull request | cours 6 | une pull request par branche, dans son propre dépôt |
| Lire et écrire des fichiers | cours 3 | CSV, images, pages |
| `argparse` | cours 3, projet 4 | une option par fonctionnalité |
| README en Markdown | cours 2, projet 4 | le README complété à la fin |

Ce que les deux TD ont en commun :

- la même ouverture (C0) : le dépôt, une branche, l'environnement ;
- des fonctionnalités qui ont un sens pour l'utilisateur du programme, chacune vérifiée par une commande ;
- une fonctionnalité calculée avec numpy : une opération sur un tableau entier ;
- la même fin : README, pull request dans son propre dépôt, fusion sur le site, `git pull`.

La revue par un camarade n'est plus demandée : elle demande d'ajouter un collaborateur et de coordonner deux élèves, ce qui coûte du temps et des erreurs. La pull request se fait dans le dépôt de l'élève. Les binômes qui le veulent s'envoient une pull request l'un à l'autre, en facultatif.

La comparaison entre une boucle et numpy est gardée au TD 7b seulement, où elle se mesure (une image de 640 × 480 pixels). Au TD 7a, numpy sert pour sa forme d'écriture : une table de 0 et de 1, un produit, une somme, un tri.

## Le dépôt de départ

Chaque élève part de son dépôt GitHub du cours 6. Pour qui n'en a pas, ou dont le dépôt ne fonctionne pas, deux dépôts de référence, publics, hébergés dans une organisation GitHub du module :

- `recette` : l'état du TD 3a à la fin de l'étape 4 (`recette.py`, `recettes/` avec les photos et `CREDITS.md`, `style.css`, `README.md`, `.gitignore`) ;
- `train` : l'état du TD 4c à la fin de l'étape B7 (`train.py`, `decor/`, `environment.yml`, `README.md`, `.gitignore`).

L'élève crée un dépôt vide sur son compte, puis :

```text
git clone git@github.com:<organisation>/recette.git
cd recette
git remote set-url origin git@github.com:<élève>/recette.git
git push -u origin master
```

Le dépôt garde l'historique du TD, et les pull requests restent dans le dépôt de l'élève. Un fork ferait viser par défaut le dépôt de l'organisation par chaque pull request (le réglage n'existe pas sur le site), et `git init` sur une copie perdrait l'historique.

## TD 7a — Le livre de recettes (parcours standard)

Le programme du TD 3a traite une recette par appel. Le TD le complète pour en faire un livre : toutes les recettes, un sommaire, les photos, puis la recherche des recettes faisables avec ce qu'on a, comme dans les applications de recettes (Paprika, SuperCook).

### Déroulé (≈ 120′)

| Durée | Étape | Contenu | Vérification |
|---|---|---|---|
| 🎓 10′ | Présentation | le livre de recettes ; une pull request dans son dépôt ; numpy : un tableau de nombres, une opération sur le tableau entier | — |
| ⌨️ 10′ | C0 | le dépôt (le sien, ou `recette` par `clone` et `set-url`) ; `environment.yml` d'après le modèle ; l'environnement ; branche `livre` | `git status`, `conda env list` |
| ⌨️ 20′ | C1 · toutes les recettes | copier les vingt recettes du dossier du TD dans `recettes/`, un commit ; le corps de `main` devient la fonction `generer(nom, personnes, unites)` ; `noms_des_recettes()` avec `DONNEES.glob("*/recette.md")` ; l'option `--toutes` | `python recette.py --toutes` écrit 24 pages |
| ⌨️ 15′ | C2 · le sommaire | `sommaire(noms)` écrit `sortie/index.md`, une ligne `- [Titre](nom.html)` par recette, puis pandoc | `sortie/index.html` s'ouvre, chaque lien mène à sa page |
| ⌨️ 15′ | C3 · la photo | `conda install -c conda-forge pillow`, ajouté à `environment.yml` ; `photo(nom)` réduit `photo.jpg` à 600 pixels (`Image.thumbnail`) et l'écrit dans `sortie/` ; une ligne `![Titre](nom.jpg)` sous le titre ; une recette sans photo n'en a pas | la page des crêpes montre la photo, celle de l'omelette non |
| ⌨️ 5′ | PR 1 | `push`, pull request `livre` → `master`, fusion sur le site, `git pull` | le graphe de `git log` sur `master` |
| ⌨️ 30′ | C4 · les recettes faisables | branche `frigo` ; `conda install numpy`, `environment.yml` ; `matrice(noms)` : la table recettes × ingrédients, 1 si la recette contient l'ingrédient ; l'option `--frigo farine lait oeufs` ; le calcul (ci-dessous) | la liste des cinq recettes auxquelles il manque le moins d'ingrédients |
| ⌨️ 5′ | PR 2 | README complété (les options `--toutes` et `--frigo`) ; `push`, pull request `frigo`, fusion, `git pull` | la pull request fusionnée |
| 10′ | Mise en commun | le livre d'un élève ; les recettes proposées pour un même frigo | — |

### Le calcul de C4

```python
recettes, ingredients = matrice(noms)          # recettes : tableau (24, n) de 0 et de 1
vecteur = np.zeros(len(ingredients), dtype=int)
# … 1 dans `vecteur` pour chaque ingrédient donné sur la ligne de commande
presents = recettes @ vecteur                  # pour chaque recette, ses ingrédients disponibles
manquants = recettes.sum(axis=1) - presents    # pour chaque recette, ses ingrédients qui manquent
ordre = np.argsort(manquants, kind="stable")   # les recettes, de celle à qui il manque le moins
absents = (recettes[ligne] == 1) & (vecteur == 0)   # les ingrédients qui manquent à une recette
```

Chaque ligne est un usage courant de numpy : produit d'une matrice et d'un vecteur, somme sur un axe, tri, masque. `simplifier(nom)` est fournie : minuscules, accents retirés, « œ » écrit « oe », pour que `oeufs` tapé au clavier désigne `Œufs` (le cours 3 montre « œuf » et « oeuf » en UTF-8).

Exemple, avec `--frigo farine lait oeufs beurre sucre sel` :

```text
crepes : 1 ingrédient(s) manquant(s) beurre fondu
mousse_chocolat : 1 ingrédient(s) manquant(s) chocolat noir
pain_perdu : 1 ingrédient(s) manquant(s) pain
pancakes : 1 ingrédient(s) manquant(s) levure chimique
puree : 1 ingrédient(s) manquant(s) pomme de terre
```

Pour le programme, « Beurre fondu », dans la recette des crêpes du cours 3, et « beurre » sont deux ingrédients différents. La mise en commun peut le relever, comme exemple de données à harmoniser.

### Ce que le guide donne et ce que l'élève écrit

Le guide donne le code de `simplifier`, la forme de `matrice` (la boucle qui remplit le tableau) et les commandes de vérification. L'élève écrit `generer` en déplaçant le corps de `main`, `noms_des_recettes`, `sommaire`, `photo`, et les lignes numpy de `frigo`, guidé par le nom de la fonction numpy à employer.

### Facultatif

- **GitHub Pages** : publier le livre. `python recette.py --toutes`, puis copier `sortie/` dans `docs/`, commit, `push` ; sur le site, Settings → Pages → branche `master`, dossier `/docs`. Les photos sous licence CC BY demandent de publier aussi `CREDITS.md` (lien depuis le sommaire).
- **Vous aimerez aussi** : `communs = recettes @ recettes.T` compte, en un seul produit, les ingrédients communs à chaque paire de recettes ; `np.fill_diagonal(communs, -1)` écarte la recette elle-même ; chaque page reçoit un lien vers la recette qui a le plus d'ingrédients communs.
- **Le placard** : le sel, le poivre et l'eau comptés comme toujours disponibles.
- **Harmoniser les noms** des ingrédients (« Beurre fondu », « Eau tiède ») dans les recettes du cours 3.
- **Une pull request en binôme** : chacun ajoute sa recette dans le dépôt de l'autre, par un fork et une pull request.

### Fichiers

| Fichier | Rôle |
|---|---|
| `data/cours7/7a_recette/depart/recettes/` | vingt recettes nouvelles (`recette.md`, `ingredients.csv`), sans photo ; quantités par personne |
| `data/cours7/7a_recette/depart/modeles/environment.yml` | l'environnement du dépôt : Python, pandoc, puis Pillow et numpy ajoutés par l'élève |
| `data/cours7/corriges/7a_recette/c1…c4/recette.py` | le programme à la fin de chaque étape, écrit et lancé par `data/cours7/generer_corriges.py` |
| `src/cours7/notebook/td/7a_recette/guide.md` | le guide, écrit par `data/cours7/generer_guides.py` : squelettes des fonctions à écrire, code complet en annexe |

## TD 7b — La scène complète (parcours avancé)

Voir [variante_train.md](variante_train.md) : plusieurs plans décrits dans `decor/plans.csv`, l'effet `poteaux` en boucle puis avec numpy, et une vidéo qui boucle.

## Abandonné

- Les quatre effets d'image (thermique, glitch, pixel art, vieux film) : ils visaient les séries d'images de la montre et du tourbillon, passés en propositions le 26/09. L'implémentation de référence reste dans [`effets_reference.py`](effets_reference.py), avec `poteaux`.
- La comparaison boucle / numpy au TD 7a : aucune fonctionnalité de la recette n'a assez de données pour la rendre visible.
- La revue obligatoire par un camarade (voir plus haut).

## Reste à faire

1. Créer l'organisation GitHub et y publier les dépôts `recette` et `train`, construits depuis les corrigés (`data/cours3/corriges/3a_cli/`, `data/cours4/corriges/4c_train/`).
2. Écrire les diapositives (`src/cours7/diapo/cours7.typ`). Les guides sont écrits (27/09).
3. Vérifier en salle : `conda install pillow numpy` dans l'environnement de la recette et dans `animation` ; le temps de `--boucle` (480 images) sur un poste.
