// Ouverture du cours 2 v2 — incluse par `cours2_v2.typ`.
// Un fichier inclus n'hérite pas des imports de son appelant.
// Nouveau (v2) : les deux diapositives.
#import "../../../commun/prelude.typ": *

#page-titre(
  titre: "Cours 2",
  sous-titre: "Éditeur de code et git local",
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
├── 2a_vscode/
├── 2b_erreurs/
└── 2c_depot_altitudes/")
    ]
  ]

  #legende[
    Dans chaque dossier, la feuille du TD et son guide détaillé, en PDF et en
    page web.
  ]

  #notes[
    L'archive se copie et se décompresse à la première étape du TD 2a, dans
    Git Bash (`unzip`), en classe entière.

    Séance 2, à annoncer à l'oral (relecture du 04/11/2026 : la diapositive
    « Contenu de la séance » est retirée) : l'éditeur de code est présenté, puis
    configuré par toute la salle en même temps. Le reste de la séance s'y
    déroule. L'éditeur de code, cours, 10′ ; configurer l'éditeur de code, TD 2a
    en classe entière, 25′ ; corriger trois programmes, TD 2b, 10′ ; git local,
    cours et TD 2c, 62′. Durées indicatives.
    Tout se fait dans VS Code, avec son terminal Git Bash.

    Budget : 10 + 25 + 10 + 62 = 107′, 13′ de marge (syllabus v2, 28/09/2026,
    moins le TD Markdown, retiré le 04/11/2026). Premier
    poste à surveiller : la configuration. Si elle dépasse 25′, le guide du
    TD 2a, distribué avant la séance, doit la faire commencer avant.

    Si la séance déborde, retirer la diapositive « L'organisation des branches
    à plusieurs ».

    `tag` au projet 7 ; l'organisation
    des branches à plusieurs, en théorie en fin de partie git, puis au
    cours 6.
  ]
]
