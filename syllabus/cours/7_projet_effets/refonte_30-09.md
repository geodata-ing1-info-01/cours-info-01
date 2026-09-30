# Projet 7 — refonte du 30/09/2026

*Adoptée le 30/09/2026, avec les décisions de Nicolas sur les points
ouverts (fin du document). Supports : `src/cours7/diapo/cours7.typ`,
`tds/7a_recette.typ`, `tds/7b_train.typ` ; guides et corrigés écrits par
`data/cours7/generer_projet7.py`. Le projet 4 a changé le même jour : les
deux parcours y écrivent `recette.py` (TD 4a), le parcours avancé le
transforme en projet installable (TD 4b), et le train, TD 4c jusque-là, passe au projet 7.*

## Ce qui change

| | Avant | Adopté |
|---|---|---|
| TD 7a, standard | livre de recettes : `--toutes`, sommaire, photo (Pillow), `--frigo` (numpy) | la recette en pages HTML, reprise du TD 3b (pandoc par `subprocess`), puis toutes les recettes et un sommaire ; photo et `--frigo` retirés |
| TD 7b, avancé | suite du TD 4c : plusieurs plans, `poteaux` en boucle puis numpy, `--boucle` | le train récupéré d'un dépôt de référence (deux plans, sans fenêtre), utilisé, lu, puis complété sur deux branches : la fenêtre, puis les poteaux avec numpy ; un conflit à la seconde pull request |
| GitHub | pull requests dans son dépôt | au moins une pull request par TD, dans les deux TD : branche, `push`, pull request sur le site, fusion, `pull` |

## TD 7a · Compléter son projet, par des pull requests (standard, ≈ 85 min)

Départ : le dépôt du projet 4, publié au cours 6 (cas A), ou le dépôt de
référence `recette` (cas B : `git clone`, `git remote set-url origin`,
`git push -u origin master`). Le dépôt de référence a l'historique du TD 4a
jusqu'à l'étape B7 (README, étiquette `v1.0`).

| Étape | Objectif | Résultat |
|---|---|---|
| D0 (15′) | récupérer le projet et le relancer | `python recette.py crepes -p 6` ; `git log` montre l'historique du projet 4 |
| D1 (25′) | écrire une page Markdown, la convertir par pandoc (`subprocess`, cours 3) | branche `page` : `--page` écrit `sortie/crepes.html`, avec le texte de `recettes/crepes.md` (fourni) et le tableau des ingrédients |
| D2 (10′) | proposer une modification sur la forge | `git push -u origin page`, pull request sur le site, fusion, `git pull` |
| D3 (20′) | parcourir les fichiers d'un dossier (`glob`), répéter le programme dans une boucle | branche `livre` : six recettes de plus ; `--toutes --page` écrit dix pages |
| D4 (15′) | écrire une page qui relie les autres | `sortie/index.html`, un lien par recette ; seconde pull request |
| D5 (bonus) | publier les pages | une copie des pages dans `docs/`, publiée par GitHub Pages |

Fourni dans `depart/` : le texte des recettes en Markdown (`recettes/<nom>.md`,
les quatre du projet 4 et six autres, avec leurs CSV pour 4 personnes),
`style.css`. Ce qui est repris du TD 3b (4b ligne de commande) : la page et
son appel de pandoc ; de l'ancien TD 7a : `--toutes` et le sommaire.

## TD 7b · Reprendre et compléter le projet d'un autre (avancé, ≈ 100 min)

Départ : le dépôt de référence `train`, dans l'organisation GitHub. Son
programme écrit la vidéo de deux plans (voiles, plage jaune, décrits dans
`decor/plans.csv`) qui défilent sur le fond, sans la fenêtre ; trois
commits, `environment.yml` (python, imagemagick, ffmpeg, numpy, pillow),
`decor/`, un README. Les élèves ne l'initialisent pas : ils le clonent, le
font tourner, le lisent, puis le complètent.

| Étape | Objectif | Résultat |
|---|---|---|
| E0 (20′) | récupérer un projet et son environnement | `git clone`, `git remote set-url`, `git config pull.rebase false`, `conda env create` ; `--images 48 --video` |
| E1 (10′) | lire le code d'un autre | trois questions sur `plans.csv` et `image` ; réponses en fin de guide |
| E2 (20′) | une fonctionnalité sur une branche | `git branch fenetre`, `git branch poteaux` sur le même commit ; la fenêtre (une ligne dans `image`) ; pull request fusionnée |
| E3 (40′) | un calcul avec numpy ; un conflit | sur `poteaux` : `ecrire_poteaux` (`np.zeros`, `np.arange`, masque de colonnes), deux lignes dans `image` au même endroit que la fenêtre ; la pull request affiche un conflit ; `git pull origin master`, résolution (poteaux, puis fenêtre), `push`, fusion |
| E4 (bonus) | un plan de plus sans code | `plage.png,16` ajouté à `decor/plans.csv` |

Le conflit est vérifié par `generer_projet7.py`, qui rejoue le TD avec un
dépôt nu à la place de GitHub. Retirés par rapport à l'ancien TD 7b :
`--boucle`, la version en boucle de l'effet, le test d'égalité, le
chronométrage, `RAPPORT.md`.

## Décisions du 30/09/2026

1. TD 7a : GitHub Pages en bonus, sans la photo.
2. TD 7b : un dépôt de départ qui écrit la vidéo de deux plans sans la
   fenêtre ; la fenêtre et les poteaux ajoutés sur deux branches qui entrent
   en conflit.
3. Un seul dépôt de référence `recette` (l'état B7 du TD 4a), pour le
   cours 6 et le TD 7a.
4. Pas de numpy au parcours standard.
