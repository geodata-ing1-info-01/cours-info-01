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
se font en autonomie ; les TD 3b, 3c et 3d n'ont plus de diapositive dans le
déroulé, et leurs fichiers `tds/` ne servent plus qu'aux feuilles de TD. La
partie 1 (`01_programme.typ`) présente l'objectif et les étapes du programme
de la recette, ses données, le code de départ et ses trois problèmes, les
améliorations jusqu'à la ligne de commande, puis `pathlib`, `subprocess`,
`main` et `argparse`, avec un script minimal et son appel. La partie 2
descend d'un niveau à chaque diapositive : lire un fichier (ouvrir, lire,
fermer), le texte vu comme une suite de caractères et la position de lecture
(`02a_lecture.typ`) ; le fichier vu comme une suite d'octets décodés selon
l'encodage, ASCII et UTF-8, la fin de ligne, puis le mode binaire, qui lit
les octets sans les décoder (`02b_encodage.typ`) ; enfin `with`, les modes
`"w"` et `"a"`, et les lignes du programme qui lisent et écrivent un fichier
(`02c_fichiers.typ`). Les TD suivent l'exposé, tous en fin de séance : le
TD 3a (l'archive, les deux arborescences, JupyterLab ouvert sur `cours3/`),
les notebooks des TD 3b et 3c, la diapositive des deux parcours
(`parties/03_parcours.typ`, aussi projetée à l'ouverture), puis les TD 3e et
3f. Le TD 3f commence par l'environnement conda, selon les groupes, le guide
détaillé et le matériel de départ, puis la différence entre notebook et
script. Une diapositive reprise par une section de notebook
passe `cellule:` au gabarit `d`, qui ajoute à la ligne de titre le cartouche
« § n » de cette section.

`schemas_notebook.typ` et `schemas_fichiers.typ` portent les schémas dessinés
avec cetz : le notebook dont une valeur change ; les octets d'un fichier,
leur décodage, la fin de ligne, la position de lecture en mode texte et en
mode binaire, les modes d'écriture.

Le détail est dans le texte des notebooks. Une ligne de code terminée par
`# à compléter` y est livrée avec `...` à la place de sa valeur, suivie d'une
réponse repliée : voir `outils/construire_notebooks.py`.

`schemas.typ` porte deux gabarits propres à la séance : `sortie` (une sortie
de terminal ou de cellule, en `raw`, sur fond gris) et `code-commente`.
