// TD 1a du cours 3 — « Le notebook de la recette ».
//
// Inclus par `cours3.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`. Un
// fichier inclus n'hérite pas des imports de son appelant.
//
// Ce TD fait faire le notebook que l'exposé de la partie 1 a présenté ; le
// notebook explique lui-même chaque section. Depuis le 29/09/2026, les TD
// sont tous en fin de séance, après le TD 0a qui copie le notebook dans
// `travail/`.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "1a",
  titre: "Le notebook de la recette",
  annonce: "Objectif : construire les chemins du programme de la recette avec pathlib, et lancer pandoc depuis Python, dans recette.ipynb, section par section",
  dossier: "cours3/1a_recette/",
  duree: "20′",
)
#separateur-td(..td)

#d("Faire le notebook recette.ipynb")[
  #annonce[
    Le notebook reprend la partie 1 de l'exposé. Il s'exécute dans sa copie,
    `1a_recette/travail/recette.ipynb`, faite au TD 0a.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire],
    [1], [dans le panneau de gauche de JupyterLab, ouvrir `1a_recette/`, puis `travail/`, et double-cliquer sur `recette.ipynb`],
    [2], [ouvrir aussi `depart/recettes/crepes/recette.md` par un double-clic],
    [3], [exécuter les sections dans l'ordre ; une ligne terminée par `# à compléter` est à écrire, la réponse est repliée sous la cellule],
    [4], [sections 1 à 4.3 en séance ; la section 4.4 se fait après la séance],
  )

  #legende[
    Les fichiers créés par le notebook sont écrits dans `travail/`, à côté
    de lui.
  ]

  #notes[
    `travail/` vide : la copie du TD 0a n'est pas faite. La faire avant
    d'ouvrir le notebook.

    Le nom du noyau en haut à droite est celui du TD 3b du cours 1. S'il
    manque, cliquer dessus et choisir `Python 3`.

    À constater : `travail/recette.ipynb` à côté de `depart/` ; le notebook
    ouvert avec `Python 3 (ipykernel)` en haut à droite ; la recette sans
    tableau sous « Ingrédients ».
  ]
]
