# Données — Cours 3 : chemins, images et ligne de commande

Quatre TD, et deux dossiers de la séance qui ne sont pas livrés :

| Dossier | Ce que c'est |
|---|---|
| `recettes/` | les quatre recettes (`recette.md`, `ingredients.csv`, pour une personne en SI) et `style.css` : la source, versionnée, que `make_data.py` recopie dans les TD qui s'en servent |
| `corriges/` | le TD 3a étape par étape (`3a_cli/etape<n>/`), versionné ici pour ne pas partir dans l'archive |
| `1a_recette/` | notebook `recette.ipynb` : chemins, `pathlib`, pandoc par `subprocess` |
| `2a_fichiers/` | notebook `fichiers.ipynb` : comment le code de la recette ouvre, lit et écrit ses fichiers (`open`, la position de lecture, octets et encodage, ASCII et UTF-8, fin de ligne, mode binaire, `with`, les modes, `csv`) |
| `2b_images/` | notebook `images.ipynb`, facultatif : texte et binaire sur des images PGM, formats d'image, compression |
| `3a_cli/` | `recette.py` construit depuis le notebook et transformé en ligne de commande, un commit par étape ; modèles de README et de `pyproject.toml` |

Les données sont dupliquées d'un TD à l'autre plutôt que citées par un chemin
relatif : chaque dossier se suffit.

```bash
conda activate info01
python make_data.py fetch    # La Grande Vague (The Met), photos (Commons), ImageMagick portable → fourni/
python make_data.py build    # recopie et dérive tout dans produit/ des quatre TD
python ../../outils/construire_notebooks.py   # les .ipynb, version à trous et corrigé
```

`build` extrait `magick.exe` de l'archive 7z avec `7z` s'il est installé, ou
`py7zr` s'il est importable ; sinon il dit quoi extraire à la main.

Sources et licences : *Under the Wave off Kanagawa*
(The Met, CC0), photos Wikimedia Commons (CC0, CC BY 2.0, domaine public ;
crédits écrits dans `depart/recettes/CREDITS.md`), ImageMagick (licence
Apache 2.0 modifiée).
