// Les deux parcours du cours 3 — la diapositive est incluse deux fois : par
// l'ouverture (`00_ouverture.typ`), et par `cours3.typ` avant les TD 3a et
// 3b, en rappel du choix. Depuis le 29/09/2026, elle remplace l'ouverture
// bleue de la partie 3 : les TD sont tous en fin de séance, et
// `argparse` est présenté dans la partie 1.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

// --------------------------------------------
#d("Deux parcours")[
  #annonce[
    La priorité, pour tous, est de faire les deux notebooks, dans l'ordre.
    La dernière partie se choisit ensuite.
  ]

  #bloc(
    [Priorité : les deux notebooks],
    [TD 0a, puis `recette.ipynb` (TD 1a), puis `fichiers.ipynb`, sections 1 à 9 (TD 2a)],
    plein: true,
  )
  #fleche-bas
  #grid(
    columns: (1fr, 1fr), column-gutter: 22pt,
    bloc([Parcours standard · TD 3a], [la recette des gaufres en Markdown, ajoutée à un dépôt git de recettes, et sa page]),
    bloc([Parcours avancé · TD 3b], [`recette.py` lancé depuis le terminal, un commit par étape]),
  )

  #legende[
    Le parcours avancé si `fichiers.ipynb` est terminé jusqu'à la section 9.
  ]

  #notes[
    En plus, si le temps le permet : finir les notebooks (standard), ou
    `images.ipynb` (avancé).

    Le TD 3a reprend le TD Markdown du cours 1, que beaucoup n'ont pas fini,
    sur une nouvelle recette.
  ]
]
