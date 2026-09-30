# Données — Projet 4 : une recette à l'échelle, en deux parcours

Depuis le 30/09/2026, les deux parcours écrivent le même programme :
`recette.py` calcule les ingrédients d'une recette pour un nombre de
personnes, en unités SI ou US. Tous les élèves font le TD 4a ; le parcours
avancé le fait plus vite, puis fait le TD 4b dans le même dossier.

| Dossier | Ce que c'est |
|---|---|
| `4a_recette/` | TD 4a : `depart/recette.py` (le programme de départ, avec deux erreurs), `depart/recettes/` (quatre recettes en CSV, pour 4 personnes, dont `cookies.csv` en unités US), `depart/modeles/README.md` ; conception dans son `README.md` |
| `4b_paquet/` | TD 4b : `depart/modeles/environment.yml` et `pyproject.toml` ; conception dans son `README.md` |
| `corriges/4a_recette/`, `corriges/4b_paquet/` | le programme à la fin de chaque étape (`b1/` … `b6/`, `c1/` … `c5/`) |
| `generer_recette.py` | écrit `depart/recette.py`, les corrigés, puis les guides (par `guides_recette.py`), après avoir exécuté chaque étape |
| `guides_recette.py` | le texte des guides des TD 4a et 4b, avec les blocs de modifications et les sorties réelles des corrigés |
| `_propositions/`, `propositions/`, `corriges/4a_montre/`, `corriges/4b_tourbillon/` | les TD montre et tourbillon d'avant le 26/09/2026, gardés comme propositions ; non livrés |
| `generer_corriges.py`, `generer_guides.py` | les corrigés et les guides de la montre, du tourbillon et du train |
| `make_data.py` | `build` : `produit/` des TD 4a et 4b ; `train` : le décor de la proposition du train ; `illustrations` : les images des schémas |

Le train, TD 4c jusqu'au 30/09/2026, est passé au projet 7 comme
proposition : `../cours7/_propositions/4c_train/`, ses corrigés dans
`../cours7/corriges/4c_train/`, son guide et ses illustrations dans
`src/cours7/notebook/propositions/4c_train/`. Son code est encore écrit par
`generer_corriges.py` et `generer_guides.py`, et son décor par
`make_data.py`, que le cours 7 importe.

```bash
conda activate info01
python generer_recette.py             # départ, corrigés et guides des TD 4a et 4b
python generer_recette.py --diffs     # et les blocs de modifications, pour relecture
python make_data.py build
python ../../outils/compiler_guides.py --cours 4
python ../../outils/livrer_tds.py --cours 4
```
