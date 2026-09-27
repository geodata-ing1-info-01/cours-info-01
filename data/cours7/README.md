# Données — Projet 7 : une fonctionnalité de plus, par une pull request

Deux TD, un par parcours des cours 3 et 4. Conception :
`syllabus/cours/7_projet_effets/contenu_detaille.md` (cadre commun et TD 7a)
et `variante_train.md` (TD 7b).

| Dossier | Ce que c'est |
|---|---|
| `7a_recette/` | parcours standard : le livre de recettes (toutes les recettes, sommaire, photos, recettes faisables avec numpy) ; vingt recettes de plus dans `depart/recettes/`, versionnées |
| `7b_train/` | parcours avancé : la scène complète du train (plusieurs plans dans `plans.csv`, l'effet `poteaux` en boucle puis numpy, vidéo qui boucle) |
| `corriges/7a_recette/c1…c4/` | `recette.py` à la fin de chaque étape, écrit par `generer_corriges.py` |
| `corriges/7b_train/c1…c4/` | `train.py` à la fin de chaque étape, écrit par `generer_corriges.py` ; `test_effet.py`, `mesurer.py` |
| `generer_corriges.py` | les morceaux de code de chaque étape ; écrit les corrigés et lance chaque programme sur un dossier de test |
| `generer_guides.py` | écrit les guides `src/cours7/notebook/td/<td>/guide.md` avec le code des corrigés |
| `make_data.py` | `build` remplit `7a_recette/produit/depart/` et `7b_train/produit/depart/` |

```bash
conda activate info01
python make_data.py build
python generer_corriges.py
python generer_guides.py
python ../../outils/construire_notebooks.py
python ../../outils/compiler_guides.py --cours 7
```

Les élèves partent de leur dépôt GitHub du cours 6, ou d'un dépôt de
référence (`recette`, `train`) cloné puis poussé vers un dépôt vide de leur
compte (`git remote set-url origin …`).
