// Partie 3 du cours 1 v2 — un notebook et la syntaxe minimale de Markdown.
// Incluse par `cours1_v2.typ`. Un fichier inclus n'hérite pas des imports de
// son appelant.
//
// Reprend les diapositives 79 à 82 du cours 1 de 2026. La syntaxe de Markdown
// est réduite à ce qu'une cellule de texte demande ; l'intention de Markdown,
// la conversion par pandoc et le README sont au cours 2.
#import "../../../commun/prelude.typ": *
#import "../../../cours1/diapo/schemas_notebooks.typ": schema-notebook

#separateur(
  "Un notebook et la syntaxe de Markdown",
  annonce: "Un document qui réunit du texte, du code et ses résultats ; le texte s'y écrit en Markdown.",
)

#d("Programmation littérale")[
  #annonce[
    Le texte, le code et son résultat tiennent dans un seul document.
  ]

  #align(center, schema-notebook())

  #legende[
    Trois sortes de blocs, dans l'ordre où on les écrit. Le terme est de Donald
    Knuth, 1984.
  ]

  #notes[
    L'idée à faire passer, et la seule : ailleurs, le code est dans un
    fichier, l'explication dans un autre, et le résultat nulle part. Ici
    les trois sont au même endroit, et dans l'ordre du raisonnement.

    v2 : le bloc de texte s'écrit en Markdown, dont la syntaxe minimale est
    deux diapositives plus loin.

    Le résultat est enregistré dans le document : rouvert demain, il
    affiche encore ce que le code a produit aujourd'hui. C'est ce qui rend
    un notebook lisible sans l'exécuter.

    Knuth : « Considérons les programmes comme des œuvres de littérature ».
    Une phrase, sans développer ; c'est le nom de l'idée qui sert, pas son
    histoire.

    Ce qu'un notebook n'est pas : un moyen de livrer un outil. On y
    explore et on y explique ; ce qui doit tourner tout seul devient un
    script, au cours 3.
  ]
]
#d("Un notebook dans JupyterLab")[
  #annonce[
    Les trois sortes de blocs dans une vraie fenêtre.
  ]

  #align(center)[
    #if captures-disponibles {
      box(stroke: 1pt + accent.lighten(55%),
          image("/illustrations/cours1/notebook_jupyterlab.png", width: 88%))
    } else {
      scale(78%, reflow: true, schema-notebook())
    }
  ]

  #legende[
    Capture réelle. Le code y calcule la longueur d'un trajet de quatre points.
  ]

  #notes[
    Montrer où sont les trois blocs de la diapositive précédente, dans
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

// --------------------------------------------
// Nouveau (v2) : la syntaxe réduite à ce qu'une cellule de texte demande.
#d("La syntaxe minimale de Markdown")[
  #annonce[
    Une cellule de texte s'écrit en Markdown : du texte brut, où quelques
    signes indiquent la mise en forme.
  ]

  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
    [Ce qu'on tape], [Ce qui s'affiche],
    [`# Altitudes`, `## Les données`], [#text(size: 20pt, weight: "bold")[Altitudes] #h(0.6em) #text(size: 16pt, weight: "bold")[Les données]],
    [deux lignes séparées par une ligne vide], [deux paragraphes],
    [`du *texte* en **gras**`], [du #emph[texte] en #strong[gras]],
    [`- une puce`], [• une puce],
    [`1. une étape`], [1. une étape],
    [`[le site](https://jupyter.org)`], [#text(fill: attention)[#underline[le site]]],
    [``la variable `total` ``], [la variable #raw("total")],
  )

  #legende[
    Le texte tapé reste lisible sans être affiché mis en forme. Le cours 2
    complète cette syntaxe : tableaux, blocs de code, images.
  ]

  #notes[
    Deux pièges, une minute chacun. Une ligne vide sépare les paragraphes,
    sans quoi deux lignes consécutives n'en font qu'un. Le dièse veut un
    espace : `#Titre` ne produit pas un titre.

    Syntaxe complète, publiée par Gruber :
    daringfireball.net/projects/markdown/syntax ; l'intention de Markdown est
    au cours 2.
  ]
]
#d("Le bloc de texte : du Markdown")[
  #annonce[
    Le bloc de texte s'écrit en Markdown, et s'affiche mis en forme.
  ]

  #face-a-face(
    panneau("Ce qu'on tape dans le bloc")[
      ```markdown
      # Longueur d'un trajet

      Les points du trajet sont donnés en
      **coordonnées projetées**, en mètres.
      ```
    ],
    panneau("Ce que le notebook affiche")[
      #v(0.4em)
      #text(size: 24pt, weight: demi-gras)[Longueur d'un trajet]
      #v(0.5em)
      #text(size: 16pt)[
        Les points du trajet sont donnés en #strong[coordonnées projetées],
        en mètres.
      ]
    ],
  )

  #legende[
    Le `#` fait un titre, les deux astérisques mettent en gras, comme sur la
    diapositive précédente.
  ]

  #notes[
    Le bloc bascule entre les deux états : `Maj` + `Entrée` affiche la mise
    en forme, un double clic revient au texte source. C'est la même
    alternance que l'aperçu de l'éditeur.

    Un bloc de texte ne s'exécute pas au sens du code : il n'y a pas de
    noyau derrière, seulement une mise en forme. Le numéro `[1]` n'apparaît
    donc que sur les blocs de code.
  ]
]

// --------------------------------------------
// Nouveau (v2) : remplace « Lancer JupyterLab depuis Anaconda » ; Navigator
// était lent à démarrer sur les postes en 2026.
#d("Lancer JupyterLab")[
  #annonce[
    JupyterLab est installé avec Anaconda. Lancé depuis Git Bash, il montre
    les fichiers du dossier courant.
  ]

  #face-a-face(
    panneau("Depuis Git Bash")[
      ```console
      $ cd ~/Desktop/info01/cours1/3a_notebook
      $ jupyter lab
      ```
      #v(0.3em)
      #text(size: 15pt, fill: estompe)[
        Le navigateur s'ouvre sur `localhost:8888`. Git Bash reste occupé
        tant que JupyterLab tourne : `Ctrl` + `C` l'arrête.
      ]
    ],
    panneau("Depuis Anaconda Navigator")[
      #text(size: 16pt)[
        Page d'accueil, fiche JupyterLab, bouton *Launch*. Il montre le
        dossier personnel : descendre jusqu'à `Desktop/info01/cours1/3a_notebook`.
      ]
    ],
  )

  #legende[
    `localhost` désigne le poste lui-même : la page est affichée par le
    navigateur, et le serveur de JupyterLab tourne sur le même poste. Le
    cours 5 y revient.
  ]

  #notes[
    En 2026, Navigator a mis plusieurs minutes à s'ouvrir sur les postes, et
    répondait parfois « already running » sans fenêtre. Git Bash d'abord,
    Navigator en secours.

    `jupyter lab` suppose conda disponible dans Git Bash (début du TD 2b).

    Le client et le serveur d'un notebook sont au cours 5 (syllabus v2).
  ]
]
