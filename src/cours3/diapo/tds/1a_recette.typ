// TD 1a du cours 3 — « Ouvrir le notebook de la recette ».
//
// Inclus par `cours3.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`. Un
// fichier inclus n'hérite pas des imports de son appelant.
//
// Ce TD ouvre le notebook que l'exposé de la partie 1 vient de présenter ;
// le notebook explique lui-même chaque section.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "1a",
  titre: "Ouvrir le notebook de la recette",
  annonce: "Ouvrir recette.ipynb dans JupyterLab ; chaque section du notebook explique ce qu'elle fait",
  dossier: "cours3/1a_recette/",
  duree: "5′",
)
// Dans le cours, l'ouverture est commune à la partie (`separateur-cours-td`,
// dans `cours3.typ`) ; seule la feuille de TD remet celle-ci.
#if feuille-seule { separateur-td(..td) }

#d("Ouvrir le notebook")[
  #annonce[
    Les notebooks sont livrés dans `depart/notebook/`. On travaille sur une
    copie, dans `travail/` : `depart/` ne se modifie pas.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire],
    [1], [dans l'explorateur, copier `depart/notebook/recette.ipynb` dans `travail/`],
    [2], [dans le panneau de gauche de JupyterLab, descendre jusqu'à `cours3/1a_recette/travail/`, double-cliquer sur `recette.ipynb`],
    [3], [ouvrir aussi `depart/recettes/crepes/recette.md` par un double-clic],
    [4], [exécuter les sections dans l'ordre ; une ligne terminée par `# à compléter` est à écrire, la réponse est repliée sous la cellule],
  )

  #legende[
    Les fichiers créés par le notebook sont écrits dans `travail/`, à côté
    de lui.
  ]

  #notes[
    La copie est la première étape, et elle compte : le notebook lit `depart/`
    par un chemin qui remonte d'un cran, `..`, ce qui suppose qu'il est dans
    `travail/`. Ouvert depuis `depart/notebook/`, il ne trouverait rien.

    Le nom du noyau en haut à droite est celui du TD 3b du cours 1. S'il
    manque, cliquer dessus et choisir `Python 3`.

    À constater : `travail/recette.ipynb` à côté de `depart/` ; le notebook
    ouvert avec `Python 3 (ipykernel)` en haut à droite ; la recette sans
    tableau sous « Ingrédients ».
  ]
]
