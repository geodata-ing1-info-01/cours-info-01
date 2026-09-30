// Partie Markdown du cours 2 v2. Incluse par `cours2_v2.typ`.
// Un fichier inclus n'hérite pas des imports de son appelant.
//
// Placée en fin de la partie « L'éditeur de code », avant « Visual Studio
// Code » et les TD 2a, 2b et 2c (28/09/2026).
//
// Ramenée le 28/09/2026 à une diapositive, sans séparateur de partie : la
// syntaxe minimale est vue au cours 1 v2 (notebook), et le cours 2 emploie
// Markdown pour fabriquer le projet que git versionne au TD 2d.
// Retirés : « L'intention de Markdown » (dans les notes de la diapositive
// Markdown du cours 1 v2) ; « Tableau, bloc de code et image » (le tableau
// et l'image dans les consignes du TD 2c, le bloc de code au cours 3) ;
// « Convertir un fichier Markdown : pandoc » (dernière étape du TD 2c) ;
// « Le README d'un projet » (au cours 3, `../a_reprendre/readme_cours3.typ`).
#import "../../../commun/prelude.typ": *

#d("Markdown, un format texte pour les documents")[
  #annonce[
    Un fichier Markdown est du texte brut, comme un programme : il s'écrit
    dans l'éditeur de code, et git en compare les lignes. Ses modifications
    se comprennent sans programmer.
  ]

  #face-a-face(
    panneau[Ce qu'on écrit, `recette.md`][
      #raw(
        "## Ingrédients\n\n| Ingrédient | Quantité |\n|---|---|\n| Farine | 250 g |\n| Œufs | 4 |\n\n## Préparation\n\n1. Mélanger la farine et le sel.\n2. Casser les œufs.",
        block: true, lang: "md",
      )
    ],
    panneau("Ce que l'aperçu montre")[
      #block(width: 100%, inset: (x: 10pt, y: 7pt), stroke: 0.8pt + estompe.lighten(50%))[
        #set text(size: 14pt)
        #text(size: 16pt, weight: "bold")[Ingrédients]
        #v(0.2em)
        #table(
          columns: 2, stroke: 0.6pt + estompe.lighten(40%), inset: 5pt,
          [*Ingrédient*], [*Quantité*], [Farine], [250 g], [Œufs], [4],
        )
        #v(0.2em)
        #text(size: 16pt, weight: "bold")[Préparation]
        #v(0.2em)
        1. Mélanger la farine et le sel.
        2. Casser les œufs.
      ]
    ],
  )

  #legende[
    La recette du TD 2c sert ensuite de projet pour git. Le `README.md` d'un
    projet s'écrit de la même façon.
  ]

  #notes[
    Syntaxe minimale vue au cours 1, dans les cellules du notebook. Le TD 2c
    ajoute le tableau et l'image ; la forme à taper est dans la consigne.

    Pourquoi une recette pour git : une quantité, une étape ou un conseil
    changés se lisent dans `git diff` sans connaître le programme, et rien
    ne s'arrête sur une erreur.

    Un `.odt` a une mise en forme, mais ne se compare pas ligne à ligne.

    Le `README.md` : la forge l'affiche en page d'accueil du dépôt (cours 6) ;
    son plan est au cours 3.

    pandoc, en fin de TD 2c : le même `.md` converti en page web et en
    `.odt`. Le TD 2d ignore ces fichiers produits ; le cours 3 appelle
    pandoc depuis Python.
  ]
]
