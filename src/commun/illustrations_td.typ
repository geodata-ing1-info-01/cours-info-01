// Illustrations des guides de TD, dessinées en typst : la fenêtre de VS Code
// avec son terminal Git Bash. Ce sont des schémas, pas des captures d'écran :
// les libellés sont ceux de VS Code en français, la disposition est
// simplifiée.
//
// Chaque guide qui en a besoin a un fichier `illustrations/<nom>.typ` qui
// appelle une de ces fonctions ; `outils/compiler_guides.py` le compile en PNG.
#import "theme.typ": accent, brun, estompe, gris, police-texte, police-code, demi-gras

#let _repere(n) = box(
  fill: brun, radius: 50%, inset: 3pt,
  text(size: 9pt, weight: "bold", fill: white)[#n],
)

// La fenêtre de VS Code : l'explorateur à gauche, le fichier au centre, le
// terminal en bas, et le menu ouvert par la flèche à côté du `+`.
// `dossier` : le dossier ouvert ; `invite` : ce qu'affiche le terminal.
#let vscode-git-bash(dossier, invite, fichiers: ()) = {
  set text(font: police-texte, size: 10pt, fill: accent, lang: "fr")
  let bord = 0.8pt + accent.lighten(55%)
  block(width: 17cm, stroke: bord, clip: true)[
    // La barre de menus
    #block(width: 100%, fill: gris, inset: (x: 8pt, y: 5pt))[
      Fichier #h(8pt) Édition #h(8pt) Sélection #h(8pt) Affichage #h(8pt) Exécuter #h(8pt) *Terminal* #h(8pt) Aide
      #h(1fr) #text(fill: estompe)[#dossier — Visual Studio Code]
    ]
    #grid(
      columns: (4.2cm, 1fr),
      // L'explorateur
      block(width: 100%, height: 7.6cm, fill: gris.lighten(40%), inset: 8pt, stroke: (right: bord))[
        #text(size: 8.5pt, weight: demi-gras, fill: estompe)[EXPLORATEUR]
        #v(4pt)
        #text(size: 9.5pt, weight: demi-gras)[#dossier]
        #for f in fichiers [
          #v(1pt)
          #h(8pt) #text(size: 9.5pt)[#f]
        ]
      ],
      grid(
        rows: (2.9cm, 4.7cm),
        // Le fichier ouvert
        block(width: 100%, height: 100%, inset: 8pt)[
          #text(size: 9pt, fill: estompe)[le fichier ouvert dans l'éditeur]
        ],
        // Le panneau du terminal
        block(width: 100%, height: 100%, stroke: (top: bord), inset: 0pt)[
          #block(width: 100%, inset: (x: 8pt, y: 4pt), stroke: (bottom: bord))[
            #text(size: 8.5pt, fill: estompe)[PROBLÈMES #h(8pt) SORTIE #h(8pt)] #text(size: 8.5pt, weight: demi-gras)[TERMINAL]
            #h(1fr)
            #text(size: 11pt)[+] #h(2pt) #box(stroke: 1.2pt + brun, inset: (x: 3pt, y: 1pt), radius: 2pt)[#text(size: 8pt)[▼]] #h(3pt) #_repere(1)
          ]
          #place(top + right, dx: -6pt, dy: 22pt, block(
            width: 4.6cm, fill: white, stroke: bord, inset: 6pt, radius: 3pt,
          )[
            #set text(size: 9.5pt)
            #set align(left)
            #block(width: 100%, fill: brun.lighten(80%), inset: 3pt)[*Git Bash* #h(1fr) #_repere(2)]
            #block(inset: 3pt)[Command Prompt]
            #block(inset: 3pt)[PowerShell]
          ])
          #block(inset: 8pt, width: 7.2cm)[
            #set align(left)
            #text(font: police-code, size: 8.5pt, raw(invite))
          ]
        ],
      ),
    )
  ]
  v(4pt)
  block(width: 17cm, text(size: 9.5pt, fill: estompe)[
    #_repere(1) la flèche à côté du `+`, en haut à droite du panneau du
    terminal ; #_repere(2) « Git Bash » dans le menu. Le terminal ouvert
    affiche une invite qui se termine par `$`.
  ])
}

// L'icône du contrôle de code source dans la barre d'activité : trois nœuds
// reliés, comme une branche de git.
#let _icone-git(couleur) = box(width: 14pt, height: 16pt, {
  let r = 2.2pt
  place(dx: 3pt, dy: 1pt, circle(radius: r, stroke: 1pt + couleur))
  place(dx: 3pt, dy: 11pt, circle(radius: r, stroke: 1pt + couleur))
  place(dx: 9pt, dy: 4pt, circle(radius: r, stroke: 1pt + couleur))
  place(dx: 5.2pt, dy: 5.4pt, line(end: (0pt, 5.6pt), stroke: 1pt + couleur))
  place(dx: 10.2pt, dy: 8.4pt, line(end: (-4.5pt, 3pt), stroke: 1pt + couleur))
})

// Une ligne de l'éditeur de comparaison : `genre` vaut "ajout" (vert),
// "vide" (hachuré : la ligne n'existe que de l'autre côté) ou "neutre".
#let _ligne-diff(texte, genre: "neutre") = block(
  width: 100%, height: 12pt, inset: (x: 4pt), above: 0pt, below: 0pt,
  fill: if genre == "ajout" { rgb("#d7efd7") } else if genre == "vide" { gris.lighten(20%) } else { white },
  align(left + horizon, text(font: police-code, size: 7.5pt, raw(texte))),
)

// La fenêtre de VS Code, panneau du contrôle de code source ouvert, et
// l'éditeur de comparaison de `fichier` : à gauche la version du dernier
// commit, à droite le fichier modifié. `lignes` : des triplets
// (texte à gauche, texte à droite, genre), le genre s'appliquant au côté
// droit ; "ajout" met un fond hachuré à gauche.
#let vscode-diff(dossier, fichier, lignes) = {
  set text(font: police-texte, size: 10pt, fill: accent, lang: "fr")
  let bord = 0.8pt + accent.lighten(55%)
  block(width: 17cm, stroke: bord, clip: true)[
    #block(width: 100%, fill: gris, inset: (x: 8pt, y: 5pt))[
      Fichier #h(8pt) Édition #h(8pt) Sélection #h(8pt) Affichage #h(8pt) Exécuter #h(8pt) Terminal #h(8pt) Aide
      #h(1fr) #text(fill: estompe)[#dossier — Visual Studio Code]
    ]
    #grid(
      columns: (0.9cm, 3.9cm, 1fr),
      // La barre d'activité : explorateur, recherche, contrôle de code source
      block(width: 100%, height: 6.2cm, fill: gris.darken(8%), inset: (y: 8pt))[
        #set align(center)
        #box(width: 12pt, height: 14pt, stroke: 1pt + estompe, radius: 1pt)
        #v(8pt)
        #text(size: 13pt, fill: estompe)[⌕]
        #v(6pt)
        #box(stroke: 1.2pt + brun, inset: 2pt, radius: 2pt, _icone-git(accent))
        #v(2pt)
        #_repere(1)
      ],
      // Le panneau du contrôle de code source
      block(width: 100%, height: 6.2cm, fill: gris.lighten(40%), inset: 8pt, stroke: (right: bord))[
        #text(size: 8pt, weight: demi-gras, fill: estompe)[CONTRÔLE DE CODE SOURCE]
        #v(4pt)
        #block(width: 100%, stroke: bord, inset: 4pt, fill: white)[#text(size: 8pt, fill: estompe)[Message]]
        #v(4pt)
        #text(size: 8.5pt, weight: demi-gras)[Modifications]
        #v(2pt)
        #block(width: 100%, fill: brun.lighten(80%), inset: 3pt)[
          #text(size: 9pt)[#fichier] #h(1fr) #text(size: 8.5pt, fill: brun, weight: demi-gras)[M] #h(3pt) #_repere(2)
        ]
      ],
      // L'éditeur de comparaison, en deux colonnes
      block(width: 100%, height: 6.2cm, inset: 0pt)[
        #block(width: 100%, inset: (x: 8pt, y: 4pt), stroke: (bottom: bord))[
          #text(size: 8.5pt, weight: demi-gras)[#fichier] #text(size: 8.5pt, fill: estompe)[(comparaison)]
        ]
        #grid(
          columns: (1fr, 1fr),
          column-gutter: 0pt,
          block(width: 100%, inset: (x: 4pt, y: 3pt), stroke: (right: bord, bottom: bord))[#text(size: 8pt, fill: estompe)[dernier commit]],
          block(width: 100%, inset: (x: 4pt, y: 3pt), stroke: (bottom: bord))[#text(size: 8pt, fill: estompe)[fichier modifié]],
          ..lignes.map(((gauche, droite, genre)) => (
            block(width: 100%, stroke: (right: bord), _ligne-diff(gauche, genre: if genre == "ajout" { "vide" } else { "neutre" })),
            _ligne-diff(droite, genre: genre),
          )).flatten(),
        )
      ],
    )
  ]
  v(4pt)
  block(width: 17cm, text(size: 9.5pt, fill: estompe)[
    #_repere(1) l'icône du contrôle de code source, dans la barre de gauche ;
    #_repere(2) le fichier modifié, marqué `M` : un clic ouvre la comparaison.
    Les lignes ajoutées sont sur fond vert, à droite.
  ])
}

// La fenêtre de VS Code après `git checkout -b` : la barre d'état, en bas à
// gauche, affiche la branche courante ; l'invite de Git Bash la répète entre
// parenthèses. `lignes` : les lignes du terminal, la dernière avant `$` étant
// celle qui porte le nom de la branche.
#let vscode-branche(dossier, branche, lignes, fichiers: ()) = {
  set text(font: police-texte, size: 10pt, fill: accent, lang: "fr")
  let bord = 0.8pt + accent.lighten(55%)
  let bleu = rgb("#007acc")
  block(width: 17cm, stroke: bord, clip: true)[
    #block(width: 100%, fill: gris, inset: (x: 8pt, y: 5pt))[
      Fichier #h(8pt) Édition #h(8pt) Sélection #h(8pt) Affichage #h(8pt) Exécuter #h(8pt) Terminal #h(8pt) Aide
      #h(1fr) #text(fill: estompe)[#dossier — Visual Studio Code]
    ]
    #grid(
      columns: (4.2cm, 1fr),
      block(width: 100%, height: 5.2cm, fill: gris.lighten(40%), inset: 8pt, stroke: (right: bord))[
        #text(size: 8.5pt, weight: demi-gras, fill: estompe)[EXPLORATEUR]
        #v(4pt)
        #text(size: 9.5pt, weight: demi-gras)[#dossier]
        #for f in fichiers [
          #v(1pt)
          #h(8pt) #text(size: 9.5pt)[#f]
        ]
      ],
      grid(
        rows: (1.6cm, 3.6cm),
        block(width: 100%, height: 100%, inset: 8pt)[
          #text(size: 9pt, fill: estompe)[le fichier ouvert dans l'éditeur]
        ],
        block(width: 100%, height: 100%, stroke: (top: bord), inset: 0pt)[
          #block(width: 100%, inset: (x: 8pt, y: 4pt), stroke: (bottom: bord))[
            #text(size: 8.5pt, fill: estompe)[PROBLÈMES #h(8pt) SORTIE #h(8pt)] #text(size: 8.5pt, weight: demi-gras)[TERMINAL]
          ]
          #block(inset: 8pt, width: 100%)[
            #set align(left)
            #set par(leading: 0.45em)
            #for (i, l) in lignes.enumerate() [
              #text(font: police-code, size: 8.5pt, raw(l))
              #if i == lignes.len() - 1 [ #h(4pt) #_repere(2) ]
              \
            ]
            #text(font: police-code, size: 8.5pt, raw("$"))
          ]
        ],
      ),
    )
    // La barre d'état, en bas de la fenêtre
    #block(width: 100%, fill: bleu, inset: (x: 8pt, y: 3pt))[
      #box(baseline: 30%, _icone-git(white)) #h(2pt) #text(size: 9pt, fill: white, weight: demi-gras)[#branche]
      #h(4pt) #_repere(1)
      #h(1fr) #text(size: 8.5pt, fill: white)[Ln 1, Col 1 #h(8pt) UTF-8 #h(8pt) Python]
    ]
  ]
  v(4pt)
  block(width: 17cm, text(size: 9.5pt, fill: estompe)[
    #_repere(1) la branche courante, dans la barre d'état, en bas à gauche de la
    fenêtre ; #_repere(2) la même branche, entre parenthèses, dans l'invite
    de Git Bash.
  ])
}

// La fenêtre de VS Code, un fichier Markdown à gauche et son aperçu à droite.
// `source` : les lignes du fichier ; `apercu` : le rendu, en contenu typst.
#let vscode-apercu(dossier, fichier, source, apercu, fichiers: ()) = {
  set text(font: police-texte, size: 10pt, fill: accent, lang: "fr")
  let bord = 0.8pt + accent.lighten(55%)
  block(width: 17cm, stroke: bord, clip: true)[
    #block(width: 100%, fill: gris, inset: (x: 8pt, y: 5pt))[
      Fichier #h(8pt) Édition #h(8pt) Sélection #h(8pt) Affichage #h(8pt) Exécuter #h(8pt) Terminal #h(8pt) Aide
      #h(1fr) #text(fill: estompe)[#dossier — Visual Studio Code]
    ]
    #grid(
      columns: (4.3cm, 1fr, 1fr),
      block(width: 100%, height: 7.4cm, fill: gris.lighten(40%), inset: 8pt, stroke: (right: bord))[
        #text(size: 8.5pt, weight: demi-gras, fill: estompe)[EXPLORATEUR]
        #v(4pt)
        #text(size: 9.5pt, weight: demi-gras)[#dossier]
        #for f in fichiers [
          #v(1pt)
          #h(6pt) #text(size: 8.5pt)[#f]
        ]
      ],
      // L'éditeur, avec l'icône de l'aperçu en haut à droite de ses onglets
      block(width: 100%, height: 7.4cm, stroke: (right: bord))[
        #block(width: 100%, inset: (x: 8pt, y: 4pt), stroke: (bottom: bord), fill: gris.lighten(40%))[
          #text(size: 9pt, weight: demi-gras)[#fichier]
          #h(1fr)
          #box(stroke: 1.2pt + brun, inset: (x: 3pt, y: 1pt), radius: 2pt)[#text(size: 8.5pt)[◫]] #h(3pt) #_repere(1)
        ]
        #block(inset: 8pt, width: 100%)[
          #set align(left)
          #set par(leading: 0.5em)
          #for l in source [
            #text(font: police-code, size: 7.5pt, raw(l)) \
          ]
        ]
      ],
      // L'aperçu
      block(width: 100%, height: 7.4cm)[
        #block(width: 100%, inset: (x: 8pt, y: 4pt), stroke: (bottom: bord), fill: gris.lighten(40%))[
          #text(size: 9pt)[Aperçu #fichier] #h(1fr) #_repere(2)
        ]
        #block(inset: 8pt, width: 100%)[
          #set align(left)
          #set text(size: 8.5pt)
          #apercu
        ]
      ],
    )
  ]
  v(4pt)
  block(width: 17cm, text(size: 9.5pt, fill: estompe)[
    #_repere(1) l'icône de l'aperçu sur le côté, en haut à droite de l'éditeur
    (ou `Ctrl` + `K` puis `V`) ; #_repere(2) l'aperçu, mis à jour pendant la
    frappe.
  ])
}
