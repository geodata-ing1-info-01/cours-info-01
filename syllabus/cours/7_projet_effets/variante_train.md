# Projet 7, TD 7b — La scène complète (document de conception)

> 27/09/2026, remplace la version du 25/09 (effets `poteaux` et `parallaxe` sur le `train.py` de l'époque). Pour les élèves du parcours avancé, qui ont fait le TD 4c ([conception](../4_projet_animation/td_4c_train.md)). Cadre commun du projet 7 : [contenu_detaille.md](contenu_detaille.md).

## Objectif

Le programme du TD 4c n'a qu'un plan mobile. Dans le clip, les voiles, la plage jaune et la plage orange défilent à des vitesses différentes, et des ombres de poteaux passent devant la fenêtre. Le TD complète la scène : plusieurs plans, décrits dans un fichier du décor ; l'effet des poteaux, en boucle puis avec numpy ; une vidéo qui boucle. L'annexe « Plusieurs plans, plusieurs vitesses » du guide 4c en est l'introduction.

## Déroulé (≈ 120′)

| Durée | Étape | Contenu | Vérification |
|---|---|---|---|
| 🎓 10′ | Présentation | les plans du clip et leurs vitesses ; une image est un tableau (`shape` (480, 640, 3), `dtype` uint8) ; boucle sur les pixels et opération sur le tableau entier | — |
| ⌨️ 10′ | C0 | le dépôt (le sien, ou `train` par `clone` et `set-url`) ; `conda install -c conda-forge numpy pillow` dans `animation`, ajoutés à `environment.yml` ; branche `plans` | `python -c "import numpy, PIL"` |
| ⌨️ 20′ | C1 · plusieurs plans | `arguments_plan(decor, fichier, decalage)` ; la liste `PLANS = [("voiles.png", 4), ("plage_jaune.png", 8), ("plage.png", 16)]` ; `image(fichier, decor, plans, numero)` ajoute un morceau par plan dans une boucle ; `serie` passe le numéro de l'image ; `--decalage` devient `--numero` | `python train.py --numero 40` : les trois plans, décalés de 160, 320 et 640 pixels |
| ⌨️ 15′ | C2 · la scène dans un fichier | `decor/plans.csv` (colonnes `fichier`, `vitesse`) ; `lire_plans(decor)` le lit avec `csv`, comme les ingrédients de la recette au cours 3 ; `PLANS` disparaît du code | changer une vitesse dans `plans.csv` change la vidéo, sans toucher à `train.py` |
| ⌨️ 5′ | PR 1 | `push`, pull request `plans` → `master`, fusion, `git pull` | — |
| ⌨️ 35′ | C3 · les poteaux | branche `poteaux` ; le notebook `tableaux.ipynb` (tableaux, masques, dépassement des `uint8`) ; `lire`, `ecrire`, `appliquer` fournies ; `poteaux_boucle`, puis `poteaux_numpy` ; `test_effet.py` ; l'option `--effet poteaux` ; `mesurer.py` et `RAPPORT.md` | `python test_effet.py` affiche `True` ; le tableau des temps |
| ⌨️ 15′ | C4 · une vidéo qui boucle | un plan de vitesse `v` revient à sa position de départ après `1920 // math.gcd(1920, v)` images ; pour tous les plans, `math.lcm` de ces périodes ; l'option `--boucle` | `--boucle` donne 480 images ; la vidéo relancée en boucle ne saute pas |
| ⌨️ 5′ | PR 2 | README (les options `--numero`, `--boucle`, `--effet`) ; `push`, pull request `poteaux`, fusion | — |
| 5′ | Mise en commun | quelques vidéos ; les rapports de temps | — |

C4 passe en facultatif si C3 déborde : 480 images demandent environ trois minutes sur la machine de préparation.

## L'effet des poteaux

Des bandes sombres de 24 pixels, espacées de 400 pixels, passent vers la gauche à 90 pixels par image, plus vite que tous les plans. Dans une bande, chaque valeur `v` devient `v × 6 // 10`.

| Version | Calcul | Temps (machine de préparation) |
|---|---|---|
| boucle | pour chaque pixel (y, x), si `(x + 90 × numero) % 400 < 24` | 0,04 s par image |
| numpy | `colonnes = (np.arange(640) + 90 * numero) % 400 < 24` ; `resultat[:, colonnes] = image[:, colonnes].astype(np.uint16) * 6 // 10` | 0,5 ms par image |

Le point d'enseignement : sans `astype(np.uint16)`, `image * 6` dépasse 255 et le résultat est faux, sans erreur ; le test `np.array_equal` le révèle.

La période des poteaux, 400 // gcd(400, 90) = 40 images, divise 480 : la vidéo de `--boucle` boucle aussi avec l'effet.

## Plans et vitesses

| Plan | Fichier | Vitesse | Période |
|---|---|---|---|
| les voiles | `voiles.png` | 4 pixels par image | 480 images |
| la plage jaune | `plage_jaune.png` | 8 | 240 |
| la plage orange | `plage.png` | 16 | 120 |

Les trois bandes sont dessinées par `data/cours4/make_data.py` (`decor_train`) et livrées dans le `decor/` du TD 4c. Les vitesses sont celles de l'annexe du guide 4c.

## Facultatif

- Un décor de nuit : un autre dossier `decor/`, avec son `plans.csv` ; le programme ne change pas.
- Les ombres des poteaux dans la vitre seulement, avec le masque de la vitre (`fenetre.png`, transparence nulle).
- Une pull request en binôme : chacun propose une vitesse ou un plan dans le dépôt de l'autre.

## Fichiers

| Fichier | Rôle |
|---|---|
| `data/cours7/corriges/7b_train/c1…c4/train.py` | le programme à la fin de chaque étape, écrit et lancé par `data/cours7/generer_corriges.py` |
| `data/cours7/corriges/7b_train/test_effet.py`, `mesurer.py` | le test d'égalité et le chronométrage de `poteaux` |
| `data/cours7/7b_train/depart/modeles/` | `plans.csv`, `test_effet.py`, `mesurer.py`, `RAPPORT.md` |
| `src/cours7/notebook/td/7b_train/depart/notebook/tableaux.md` | le notebook des outils numpy (écrit le 25/09 ; sa section sur `np.roll` n'est plus utile) |
| `src/cours7/notebook/td/7b_train/guide.md` | le guide, écrit par `data/cours7/generer_guides.py` (27/09) |

## Reste à faire

1. Reprendre le notebook `tableaux.ipynb` (sa section 5, `np.roll`, n'est plus utile ; le guide fait faire les sections 1 à 4 et 6).
2. Mesurer sur un poste de la salle le temps de `--boucle` et de la boucle Python de `poteaux`.
