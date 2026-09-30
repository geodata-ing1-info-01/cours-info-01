// TD 3a du cours 1 — « Mettre en forme une recette en Markdown ».
//
// Inclus par `cours1.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`, qui
// en tire la feuille de TD déposée dans le dossier annoncé. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "3a",
  titre: "Mettre en forme une recette en Markdown",
  annonce: "Objectif : structurer un texte brut en Markdown, avec l'aperçu ouvert à côté",
  dossier: "cours1/3a_markdown/",
  duree: "20′",
)
#separateur-td(..td)
#d("Voir le rendu sans quitter l'éditeur")[
  #annonce[
    VSCode connaît le Markdown d'origine : rien à installer, et l'aperçu
    s'ouvre à côté du fichier, dans la même fenêtre.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [L'action], [Ce qu'elle ouvre], [Quand s'en servir],
    [`Ctrl` + `K` puis `V`],
      [l'aperçu à droite, l'éditeur reste à gauche],
      [pendant qu'on écrit : le rendu suit la frappe],
    [`Ctrl` + `Maj` + `V`],
      [l'aperçu seul, dans un onglet],
      [pour relire, une fois le texte écrit],
  )

  #legende[
    Les deux aperçus défilent avec le fichier. Ils ne changent rien au `.md` :
    ce qui est enregistré reste le texte que vous avez tapé.
  ]

  #notes[
    Le raccourci le plus employé de l'année : en prendre l'habitude maintenant, et écrire
    le fichier de notes du jour avec l'aperçu ouvert.

    Le montrer en direct plutôt que le décrire. Faire remarquer que
    l'éditeur et l'aperçu se suivent quand on fait défiler l'un des deux.

    Rien n'est installé pour cela : `markdown-language-features` est livré
    avec l'éditeur, contrairement à Python et C++, qui ont demandé une
    extension. C'est le contraste à nommer.

    En français, l'entrée du menu est Affichage #sym.arrow.r Ouvrir
    l'aperçu sur le côté. Libellés dépendants de la version, à vérifier sur
    le poste de démonstration.
  ]
]
#d("Mettre en forme une recette")[
  #annonce[
    Un texte brut sans aucune structure, à reprendre en Markdown. Le rendu se
    vérifie à côté, sans quitter l'éditeur.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire],
    [1], [ouvrir `cours1/3a_markdown/`, puis `depart/recette_a_formater.txt`],
    [2], [l'enregistrer sous `travail/recette.md`, et ouvrir l'aperçu par `Ctrl` + `K` puis `V`],
    [3], [un titre en `#`, deux sous-titres en `##`],
    [4], [les étapes de préparation en liste numérotée],
    [5], [les ingrédients en tableau, depuis `depart/ingredients.csv`],
    [6], [la photo, par `![légende](crepes.jpg)`],
    [7], [l'ordre des opérations en bloc `mermaid`],
  )

  #legende[
    `depart/recette.md` donne le résultat attendu : ne
    l'ouvrir qu'après avoir essayé.
  ]

  #notes[
    Le texte de départ n'a aucune structure, et c'est voulu : ils doivent
    la décider, pas la recopier. La discussion utile est de savoir ce qui
    est un titre et ce qui est une étape — la mise en forme est une
    lecture du contenu.

    Habitude à prendre, l'aperçu côte à côte : `Ctrl` + `K` puis `V`. On
    écrit à gauche, on voit à droite, sans rien lancer.

    Étape 5 : le tableau se tape à la main, ou se produit depuis le CSV
    par une extension du catalogue. À la main la première fois,
    l'extension ensuite — un tableau Markdown n'est que des barres
    verticales, dont l'alignement n'est même pas obligatoire.

    Étape 6 : `crepes.jpg` est dans `depart/`, à côté du fichier qu'ils
    écrivent — le chemin est donc relatif et tient en un nom. Une image ne
    s'insère pas dans un `.md`, elle s'y désigne : le fichier reste à côté,
    et c'est la quatrième rencontre des chemins relatifs de la partie 1.

    Étape 7 : le diagramme de la diapositive précédente. Rien à installer.

    Pour ceux qui vont vite : une citation par `>`, et une seconde photo
    prise par eux.
  ]
]
#d("Un diagramme écrit en texte")[
  #annonce[
    Un schéma se décrit aussi en texte. Six lignes dans un bloc `mermaid`, et
    l'aperçu dessine les boîtes et les flèches.
  ]

  #face-a-face(
    panneau("Ce qu'on écrit")[
      #raw(
        "```mermaid\nflowchart LR\n  A[Pâte] --> B[Repos, 1 h]\n  B --> C[Cuisson]\n```",
        block: true,
      )
    ],
    panneau("Ce qui s'affiche")[
      #v(0.6em)
      #chaine(
        ("Pâte", ""),
        ("Repos, 1 h", ""),
        ("Cuisson", ""),
      )
    ],
  )

  #legende[
    Rien à installer : depuis la version 1.121, VSCode rend les diagrammes
    Mermaid dans l'aperçu Markdown d'origine. La syntaxe complète est dans la
    documentation officielle,
    #link("https://mermaid.js.org/syntax/flowchart.html")[mermaid.js.org/syntax/flowchart].
  ]

  #notes[
    L'intérêt n'est pas de dessiner joli mais que le schéma soit du texte
    : il se compare ligne à ligne, se versionne, et se corrige sans
    rouvrir un logiciel de dessin.

    Faire remarquer que le dessin n'est pas dans le fichier : le `.md` ne
    contient que six lignes, les boîtes sont calculées à l'affichage,
    comme la coloration l'était pour le code.

    Le vocabulaire minimal suffit : `flowchart LR`, un identifiant, le
    texte entre crochets, `-->` pour une flèche.

    Ne pas ouvrir le catalogue des types de diagrammes. Le cours 2 s'en
    sert pour représenter l'historique d'un dépôt git.
  ]
]
// Le rendu attendu, quand la capture est disponible : sans elle, la
// diapositive n'aurait rien à montrer que le texte de la précédente.
#if captures-disponibles {
d("Le résultat attendu")[
  #annonce[
    Un titre, un tableau, une liste numérotée, et le diagramme dessiné à
    partir de ses six lignes de texte.
  ]

  #align(center)[
    #illustration(
      "/illustrations/cours1/apercu_recette.png",
      none,
      hauteur: 200pt,
    )
  ]

  #legende[
    Aperçu du `recette.md` du dossier. Le diagramme n'est pas une image : il
    est décrit en six lignes dans le fichier, et dessiné à l'affichage.
  ]

  #notes[
    À projeter après le TD : c'est le corrigé. Rien ici n'a
    demandé de logiciel de mise en page, et le fichier source reste
    lisible tel quel.

    Le diagramme a la même nature que le reste : du texte dans le fichier,
    une image seulement à l'écran. Troisième fois de la séance, après la
    coloration et les polices.
  ]
]
}
