# Données — Projet 7 : une fonctionnalité de plus, par une pull request

Refait le 30/09/2026 (`syllabus/cours/7_projet_effets/refonte_30-09.md`).
Deux TD, un par parcours ; chacun part d'un dépôt git récupéré sur GitHub.

| Dossier | Ce que c'est |
|---|---|
| `7a_recette/` | parcours standard : la recette en pages ; `depart/` versionné (texte des recettes, six recettes de plus, `style.css`) |
| `7b_train/` | parcours avancé : la fenêtre du train ; le projet vient du dépôt de référence `train` |
| `corriges/7a_recette/d1`, `d3`, `d4` | `recette.py` à la fin de chaque étape du TD 7a |
| `corriges/7b_train/r2`, `e2`, `e3`, `e3-fusion` | `train.py` du dépôt de référence, puis des branches `fenetre` et `poteaux`, puis de la fusion |
| `corriges/4c_train/` | les corrigés de l'ancien TD 4c, en proposition |
| `_propositions/4c_train/` | l'ancien TD 4c du projet 4 (la fenêtre du train construite pas à pas), non livré |
| `generer_projet7.py` | écrit les corrigés ; rejoue le TD 7b avec un dépôt nu à la place de GitHub (le conflit) ; `--depots` écrit les dépôts de référence `recette` et `train` |
| `guides_projet7.py` | le texte des guides, avec les sorties réelles des programmes et de git |
| `make_data.py` | `build` : `produit/travail/` de chaque TD ; `illustrations` : les images des effets du TD 7b, dans `illustrations/cours7/`, calculées par les programmes du TD |

```bash
conda activate info01
python generer_projet7.py                         # corrigés et guides
python generer_projet7.py --depots ~/depots_info01   # et les dépôts de référence
python make_data.py illustrations               # si le programme du train a changé
python make_data.py build
python ../../outils/compiler_guides.py --cours 7
```

Les dépôts de référence sont à pousser sur le compte GitHub du module
(`recette` : l'historique du TD 4a jusqu'au README et à l'étiquette `v1.0` ;
`train` : trois commits). Le dépôt `recette` sert aussi au cours 6.
