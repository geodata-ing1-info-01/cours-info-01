// Ouverture du cours 2 v2 — incluse par `cours2_v2.typ`.
// Un fichier inclus n'hérite pas des imports de son appelant.
// Nouveau (v2) : les trois diapositives.
#import "../../../commun/prelude.typ": *

#page-titre(
  titre: "Cours 2",
  sous-titre: "Version 2, proposition de travail",
  auteur: "1re année géomatique",
  date: "2027-2028",
)

// --------------------------------------------
#d("Les fichiers du cours")[
  #annonce[
    Une archive par séance, un dossier par TD. Aujourd'hui, tout est dans
    `cours2/`.
  ]

  #align(center)[
    #block(
      inset: (x: 20pt, y: 13pt), fill: gris,
      stroke: 1pt + accent.lighten(62%),
    )[
      #set text(size: 23pt)
      #set align(left)
      #raw(
"cours2/                  un dossier par TD, dans l'ordre de la séance
├── 1a_vscode/
├── 1b_erreurs/
├── 2a_markdown/
└── 3a_depot_recette/")
    ]
  ]

  #legende[
    Dans chaque dossier, la feuille du TD et son guide détaillé, en PDF et en
    page web.
  ]

  #notes[
    L'archive se copie et se décompresse à la première étape du TD 1a, dans
    Git Bash (`unzip`), en classe entière.
  ]
]

// --------------------------------------------
#d("Contenu de la séance")[
  #annonce[
    La séance commence par la configuration de l'éditeur de code, faite par
    toute la salle en même temps. Le reste s'y déroule.
  ]

  #tableau(
    columns: (1fr, auto, auto),
    align: (left + horizon, left + horizon, right + horizon),
    [Partie], [Nature], [Durée],
    [Configurer l'éditeur de code], [TD 1a, en classe entière], [25′],
    [L'éditeur de code], [cours et TD 1b], [20′],
    [Markdown], [cours et TD 2a], [20′],
    [Git local], [cours et TD 3a], [60′],
  )

  #legende[
    Durées indicatives. Tout se fait dans VS Code, avec son terminal Git Bash.
  ]

  #notes[
    Budget du syllabus v2 : 115′, avant l'arrivée du TD 1b (10′), venu du
    cours 1 v2 le 27/09/2026. Le premier poste à surveiller est la
    configuration : si elle dépasse 25′, le guide du TD 1a, distribué avant
    la séance, doit la faire commencer avant.

    `revert`, `tag`, `rebase` et l'organisation main, develop, feature sont
    en annexe (syllabus v2).
  ]
]
