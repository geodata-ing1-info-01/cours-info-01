// Schémas du cours 2 v2.
//
// `fenetre-vscode` : la fenêtre de VS Code telle que les élèves la
// configurent au TD 2a, dessinée (28/09/2026). Elle remplace la capture du
// cours 1 de 2026 (projet trajet), absente du dépôt, dont le repli ne
// dessinait qu'une fenêtre vide. Intitulés en anglais, comme sur les postes ;
// disposition simplifiée. Le programme est `2a_vscode/altitudes.py`, et la
// sortie du terminal est la sienne.
#import "../../commun/theme.typ": accent, brun, estompe, gris, police-code, demi-gras

#let _bord = 0.8pt + accent.lighten(55%)

// Le nom d'une zone, posé dans son coin bas droit.
#let _nom-zone(nom) = place(bottom + right, dx: -6pt, dy: -5pt, box(
  fill: brun, inset: (x: 6pt, y: 3pt), radius: 3pt,
  text(size: 12pt, weight: demi-gras, fill: white)[#nom],
))

#let _ligne-arbre(texte, retrait: 0, courant: false) = block(
  width: 100%, inset: (left: 6pt + retrait * 12pt, y: 2.5pt),
  fill: if courant { accent.lighten(85%) } else { none },
  text(size: 11pt)[#texte],
)

#let fenetre-vscode(hauteur: 300pt) = {
  set text(size: 11pt, fill: accent)
  let code = "\"\"\"Moyenne d'une série d'altitudes, à la main plutôt qu'avec sum().\"\"\"\n\naltitudes = [128.4, 131.0, 127.6]\ntotal = 0\nfor altitude in altitudes:\n    total = total + altitude\nmoyenne = total / len(altitudes)\nprint(f\"moyenne : {moyenne:.1f} m\")"
  block(width: 100%, stroke: _bord, clip: true)[
    // Barre de titre et menus
    #block(width: 100%, fill: gris, inset: (x: 8pt, y: 5pt))[
      #text(size: 10.5pt)[File #h(6pt) Edit #h(6pt) Selection #h(6pt) View #h(6pt) Go #h(6pt) Run #h(6pt) Terminal #h(6pt) Help]
      #h(1fr)
      #text(size: 10.5pt, fill: estompe)[altitudes.py — cours2 — Visual Studio Code]
      #h(1fr)
    ]
    #grid(
      columns: (5.4cm, 1fr),
      // L'explorateur
      block(width: 100%, height: hauteur - 42pt, fill: gris.lighten(40%), stroke: (right: _bord), inset: (y: 6pt))[
        #set block(spacing: 0pt)
        #_nom-zone[l'arborescence]
        #block(inset: (x: 8pt, bottom: 4pt), text(size: 9.5pt, weight: demi-gras, fill: estompe)[EXPLORER])
        #_ligne-arbre(text(weight: demi-gras)[⌄ COURS2])
        #_ligne-arbre([⌄ 2a_vscode], retrait: 1)
        #_ligne-arbre([altitudes.py], retrait: 2, courant: true)
        #_ligne-arbre([› 2b_erreurs], retrait: 1)
        #_ligne-arbre([› 2c_markdown], retrait: 1)
        #_ligne-arbre([› 2d_depot_recette], retrait: 1)
      ],
      grid(
        rows: (auto, auto),
        // Le fichier ouvert
        block(width: 100%, height: (hauteur - 42pt) * 0.62)[
          #_nom-zone[le code]
          #block(width: 100%, stroke: (bottom: _bord), inset: 0pt)[
            #box(fill: white, stroke: (right: _bord), inset: (x: 10pt, y: 5pt))[altitudes.py]
            #h(1fr)
            #box(inset: (x: 10pt, y: 5pt))[#text(size: 12pt)[▷]]
          ]
          #block(inset: (x: 8pt, y: 6pt))[
            // Le thème réduit le code à 0,78 du texte courant : 13 pt donnent
            // environ 10 pt, numéros de ligne compris.
            #set text(size: 13pt)
            #set par(leading: 0.45em)
            #grid(
              columns: (auto, 1fr), column-gutter: 12pt,
              text(fill: estompe, raw(range(1, 9).map(str).join("\n"), block: true)),
              raw(code, lang: "python", block: true),
            )
          ]
        ],
        // Le terminal
        block(width: 100%, height: (hauteur - 42pt) * 0.38, stroke: (top: _bord))[
          #_nom-zone[le terminal]
          #block(width: 100%, inset: (x: 8pt, y: 4pt))[
            #text(size: 9.5pt, fill: estompe)[PROBLEMS #h(8pt) OUTPUT #h(8pt)] #text(size: 9.5pt, weight: demi-gras)[TERMINAL]
            #h(12pt) #text(size: 9.5pt, fill: estompe)[bash]
          ]
          #block(inset: (x: 8pt, y: 2pt))[
            #set text(size: 13pt)
            #set par(leading: 0.4em)
            #raw("(base)\neleve@POSTE MINGW64 ~/Desktop/info01/cours2\n$ python 2a_vscode/altitudes.py\nmoyenne : 129.0 m", block: true)
          ]
        ],
      ),
    )
    // La barre d'état
    #block(width: 100%, fill: accent, inset: (x: 8pt, y: 4pt))[
      #set text(size: 10pt, fill: white)
      #h(1fr) Ln 8, Col 1 #h(12pt) Spaces: 4 #h(12pt) UTF-8 #h(12pt) LF #h(12pt) Python #h(12pt) 3.x ('base')
    ]
  ]
}
