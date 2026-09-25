# Diapositives — Cours 3

Même organisation que le cours 1, dont le [README](../../cours1/diapo/README.md)
décrit les gabarits, les compilations et les vérifications :

```bash
python outils/compiler_diapos.py --cours 3            # cours3.pdf, à projeter
python outils/compiler_diapos.py --cours 3 --notes    # avec les notes de conduite
python outils/compiler_diapos.py --cours 3 --corrige  # les réponses des TD
python outils/compiler_diapos.py --cours 3 --sans-tds # un sommaire par bloc de TD
python outils/compiler_tds.py --cours 3               # une feuille par TD
python outils/verifier_diapos.py src/cours3/diapo/cours3.pdf
```

Ce que cette séance a de particulier : les parties 1 et 2 sont de l'exposé
seul, et leurs notebooks (`recette.ipynb`, `fichiers.ipynb`, `images.ipynb`)
se font en autonomie ; les TD 1a, 2a et 2b n'ont plus de diapositive dans le
déroulé, et leurs fichiers `tds/` ne servent plus qu'aux feuilles de TD. La
partie 1 (`01_programme.typ`) présente l'objectif et les étapes du programme
de la recette, ses données, le code de départ et ses trois problèmes, les
améliorations jusqu'à la ligne de commande, puis `pathlib`, `subprocess`,
`main` et `argparse`, avec un script minimal et son appel. La partie 2
présente les lignes du programme qui manipulent des fichiers, l'objet fichier
et sa position de lecture, `with`, la lecture en bloc ou ligne par ligne
(`02a_fichiers.typ`), puis ASCII et UTF-8 (`02b_encodage.typ`). La partie 3
ne contient que son ouverture et le TD 3a, qui commence par la différence
entre notebook et script. Une diapositive reprise par une section de notebook
passe `cellule:` au gabarit `d`, qui ajoute à la ligne de titre le cartouche
« § n » de cette section.

`schemas_notebook.typ` et `schemas_fichiers.typ` portent les schémas dessinés
avec cetz : le notebook dont une valeur change, et la position de lecture
d'un fichier.

Le détail est dans le texte des notebooks. Une ligne de code terminée par
`# à compléter` y est livrée avec `...` à la place de sa valeur, suivie d'une
réponse repliée : voir `outils/construire_notebooks.py`.

`schemas.typ` porte deux gabarits propres à la séance : `sortie` (une sortie
de terminal ou de cellule, en `raw`, sur fond gris) et `code-commente`.
