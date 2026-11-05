// Partie 3 du cours 1 v2 — un notebook et la syntaxe minimale de Markdown.
// Incluse par `cours1_v2.typ`. Un fichier inclus n'hérite pas des imports de
// son appelant.
//
// Reprend les diapositives 79 à 82 du cours 1 de 2026. La syntaxe de Markdown
// est réduite à ce qu'une cellule de texte demande ; le README est au cours 2.
//
// Seconde relecture du 19/10/2026 : plus de séparateur ; « Programmation
// littérale » suit « Compilateur et interpréteur : changer de poste », dans la partie
// « Exécuter un programme » ouverte dans `02b_programme.typ`, avant
// les TD 1c et 1d (ordre des inclusions dans `cours1_v2.typ`).
//
// Relecture du 19/10/2026 : « Lancer JupyterLab » ouvre le TD 1d, et « La
// syntaxe minimale de Markdown » passe avant l'étape du TD qui écrit une
// cellule de texte (`tds/1d_notebook.typ`). « Programmation littérale » :
// une phrase d'annonce, la capture en grand, et ce qui était dans
// l'annonce et la légende posé en étiquettes sur la capture.
#import "../../../commun/prelude.typ": *
#import "../../../cours1/diapo/schemas_notebooks.typ": schema-notebook

// Étiquette posée sur la capture : `x` et `y` en pixels de l'image
// (1400 × 535), convertis à la largeur affichée.
#let _largeur-capture = 670pt
#let _etiquette-capture(x, y, corps) = place(
  top + left, dx: x * _largeur-capture / 1400, dy: y * _largeur-capture / 1400,
  box(fill: attention, inset: (x: 5pt, y: 3pt), radius: 3pt,
      text(size: 13pt, fill: white, weight: demi-gras)[#corps]),
)

#d("Programmation littérale")[
  #annonce[
    Un notebook réunit le texte, le code et son résultat dans un seul
    document.
  ]

  // 28/09 : la capture de « Un notebook dans JupyterLab », réunie ici.
  #align(center)[
    #if captures-disponibles {
      box(stroke: 1pt + accent.lighten(55%), {
        image("/illustrations/cours1/notebook_jupyterlab.png", width: _largeur-capture)
        _etiquette-capture(700, 120)[← du texte, écrit en Markdown]
        _etiquette-capture(720, 60)[le noyau, qui exécute le code →]
        _etiquette-capture(40, 238)[ordre d'exécution →]
        _etiquette-capture(930, 320)[← une cellule de code]
        _etiquette-capture(640, 398)[← sa sortie, gardée dans le fichier]
        _etiquette-capture(925, 444)[← du texte qui commente le résultat]
      })
    } else {
      scale(70%, reflow: true, schema-notebook())
    }
  ]

  #legende[
    Le terme « programmation littérale » est de Donald Knuth, 1984.
  ]

  #notes[
    Pourquoi en parler dès le cours 1 : le notebook montre l'explication, le
    code et le résultat ensemble, ce qui sert à apprendre et à expliquer ;
    les cours 3 et 4 font leurs TD de Python dans des notebooks.

    L'idée à faire passer, et la seule : ailleurs, le code est dans un
    fichier, l'explication dans un autre, et le résultat nulle part. Ici
    les trois sont au même endroit, et dans l'ordre du raisonnement.

    Les cours et les TD de Python du module emploient des notebooks, qu'il
    faut donc savoir lancer et exécuter. Le noyau est un programme Python
    lancé par JupyterLab : il exécute les cellules et garde leurs
    variables.

    v2 : le bloc de texte s'écrit en Markdown, dont la syntaxe minimale est
    au TD 1d, avant l'étape qui écrit une cellule de texte.

    Le résultat est enregistré dans le document : rouvert demain, il
    affiche encore ce que le code a produit aujourd'hui. C'est ce qui rend
    un notebook lisible sans l'exécuter.

    Knuth : « Considérons les programmes comme des œuvres de littérature ».
    Une phrase, sans développer ; c'est le nom de l'idée qui sert, pas son
    histoire.

    Ce qu'un notebook n'est pas : un moyen de livrer un outil. On y
    explore et on y explique ; ce qui doit tourner tout seul devient un
    script, au cours 3.

    Sur la capture, montrer les trois blocs, dans
    l'ordre : le titre et la phrase en haut, la cellule de code au milieu
    avec son `[1]`, la sortie juste en dessous, puis le texte qui commente
    le résultat.

    Le `[1]` est le rang d'exécution, pas le rang dans le document. Une
    cellule relancée passe à `[2]` : c'est ce qui trahit un notebook
    exécuté dans le désordre.

    À droite en haut, le nom du noyau, `Python 3 (ipykernel)`. C'est ce
    qu'on choisit à l'ouverture ; les noyaux sont au cours 3.

    À gauche, l'arborescence : un notebook est un fichier dans un dossier,
    comme le reste.
  ]
]
