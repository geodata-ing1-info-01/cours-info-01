// Schémas du cours 2 v2.
//
// `fenetre-vscode` : la fenêtre de VS Code telle que les élèves la
// configurent au TD 2a, dessinée (28/09/2026). Elle remplace la capture du
// cours 1 de 2026 (projet trajet), absente du dépôt, dont le repli ne
// dessinait qu'une fenêtre vide. Intitulés en anglais, comme sur les postes ;
// disposition simplifiée. Le programme est `2a_vscode/altitudes.py`, et la
// sortie du terminal est la sienne.
//
// `schema-rappel-outils` (04/11/2026) : trois fenêtres séparées, à la disposition
// de `fenetre-vscode`, l'explorateur à gauche, l'éditeur au-dessus du terminal.
//
// `vignette-jupyterlab`, `vignette-spyder`, `vignette-vscode` (04/11/2026) : la
// disposition par défaut de chaque fenêtre, simplifiée. `schema-fonctions-ide`
// reprend ce dessin, en grand.
#import "../../commun/theme.typ": accent, alerte, attention, brun, estompe, gris, police-code, demi-gras
#import "../../cours1_v2/diapo/schemas.typ": _entree
#import "../../cours5/diapo/schemas.typ": repere

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

// `reperes` place les numéros 1 et 2 sur le fichier et sur le bouton d'exécution (TD 2a) ;
// `commande` remplace la ligne tapée dans le terminal ; `lignes` choisit les lignes du
// programme affichées, pour une fenêtre moins haute.
#let fenetre-vscode(hauteur: 300pt, reperes: false, commande: "python 2a_vscode/altitudes.py", lignes: (1, 8)) = {
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
        #_ligne-arbre([altitudes.py #if reperes { h(6pt); box(baseline: 5pt, repere(1, taille: 18pt)) }], retrait: 2, courant: true)
        #_ligne-arbre([› 2b_erreurs], retrait: 1)
        #_ligne-arbre([› 2c_depot_altitudes], retrait: 1)
      ],
      grid(
        rows: (auto, auto),
        // Le fichier ouvert
        block(width: 100%, height: (hauteur - 42pt) * 0.62)[
          #_nom-zone[le code]
          #block(width: 100%, stroke: (bottom: _bord), inset: 0pt)[
            #box(fill: white, stroke: (right: _bord), inset: (x: 10pt, y: 5pt))[altitudes.py]
            #h(1fr)
            #if reperes { box(baseline: 5pt, repere(2, taille: 18pt)) }
            #box(inset: (x: 10pt, y: 5pt))[#text(size: 12pt)[▷]]
          ]
          #block(inset: (x: 8pt, y: 6pt))[
            // Le thème réduit le code à 0,78 du texte courant : 13 pt donnent
            // environ 10 pt, numéros de ligne compris.
            #set text(size: 13pt)
            #set par(leading: 0.45em)
            #grid(
              columns: (auto, 1fr), column-gutter: 12pt,
              text(fill: estompe, raw(range(lignes.at(0), lignes.at(1) + 1).map(str).join("\n"), block: true)),
              raw(code.split("\n").slice(lignes.at(0) - 1, lignes.at(1)).join("\n"), lang: "python", block: true),
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
            #raw("(base)\neleve@POSTE MINGW64 ~/Desktop/info01/cours2\n$ " + commande + "\nmoyenne : 129.0 m", block: true)
          ]
        ],
      ),
    )
    // La barre d'état
    #block(width: 100%, fill: accent, inset: (x: 8pt, y: 4pt))[
      #set text(size: 10pt, fill: white)
      #h(1fr) Ln 8, Col 1 #h(12pt) Spaces: 4 #h(12pt) UTF-8 #h(12pt) LF #h(12pt) Python #h(12pt) #"3.x ('base')"
    ]
  ]
}

// ---------------------------------------------------------------------------
// Rappel du cours 1 : trois fenêtres séparées
//
// Le programme et sa sortie sont ceux du TD 1c. Les icônes des éditeurs sont
// celles du cours 1 v2 (`images/editeurs/CREDITS.md`).

#let _colonnes-ide = (0.46fr, 1fr)

#let _titre-outil(corps) = block(below: 4pt, text(size: 15pt, weight: demi-gras)[#corps])

// La barre de titre de `fenetre` (theme.typ), sans la ligne vide qui ouvre le
// corps de ce gabarit : la colonne de droite porte deux fenêtres l'une sur
// l'autre.
#let _fenetre-serree(titre, corps) = block(width: 100%, stroke: 1pt + accent.lighten(55%), clip: true, {
  block(width: 100%, fill: gris, inset: (x: 9pt, y: 5pt), below: 0pt, grid(
    columns: (auto, 1fr), column-gutter: 9pt, align: horizon,
    box(height: 8pt, {
      for i in range(3) {
        place(horizon + left, dx: i * 11pt, circle(radius: 3.5pt, stroke: 0.8pt + estompe))
      }
      h(29pt)
    }),
    text(size: 13pt, fill: estompe, titre),
  ))
  block(width: 100%, inset: (x: 10pt, y: 7pt), above: 0pt, corps)
})

#let schema-rappel-outils() = {
  let code = "altitudes = [128.4, 131.0, 127.6]\ntotal = 0\nfor altitude in altitudes:\n    total = total + altitude\nmoyenne = total / len(altitudes)\nprint(f\"moyenne : {moyenne:.1f} m\")"
  let icones = box(baseline: 3pt, stack(
    dir: ltr, spacing: 5pt,
    image("/src/cours1_v2/images/editeurs/bloc_notes.svg", height: 17pt),
    image("/src/cours1_v2/images/editeurs/notepadpp.svg", height: 17pt),
  ))
  grid(
    columns: (_colonnes-ide.at(0), auto, _colonnes-ide.at(1)), column-gutter: 7pt, align: top,
    {
      _titre-outil[Explorateur de fichiers]
      _fenetre-serree("1c_programme", {
        block(width: 100%, stroke: 0.6pt + estompe, inset: (x: 6pt, y: 4pt), radius: 2pt, below: 5pt,
              text(font: police-code, size: 12pt)[…\\cours1\\1c_programme])
        _entree("altitudes.py", choisie: true)
        _entree("commandes.sh")
      })
      v(3pt)
      text(size: 13pt, fill: estompe)[pour un programme de plusieurs fichiers]
      v(6pt)
      block(
        width: 100%, inset: (x: 9pt, y: 7pt),
        fill: alerte.lighten(92%), stroke: (left: 3pt + alerte),
        text(size: 14pt)[
          Un programme écrit dans LibreOffice Writer est enregistré en `.odt`,
          et `python` ne peut pas exécuter ce fichier.
        ],
      )
    },
    pad(top: 62pt, align(center, stack(
      dir: ttb, spacing: 1pt,
      text(size: 12pt, fill: estompe)[ouvrir],
      text(size: 24pt, fill: accent)[→],
    ))),
    {
      _titre-outil[Éditeur de texte #h(2pt) #icones #h(2pt) Bloc-notes, Notepad++]
      _fenetre-serree("altitudes.py - Notepad++", {
        set text(size: 16.5pt)
        set par(leading: 0.42em)
        grid(
          columns: (auto, 1fr), column-gutter: 10pt,
          text(fill: estompe, raw(range(1, 7).map(str).join("\n"), block: true)),
          raw(code, lang: "python", block: true),
        )
      })
      v(-1pt)
      align(center, stack(
        dir: ltr, spacing: 6pt,
        text(size: 21pt, fill: accent)[↓],
        align(horizon, text(size: 12pt, fill: estompe)[enregistrer, puis lancer]),
      ))
      v(-1pt)
      _titre-outil[Terminal Git Bash]
      _fenetre-serree("Git Bash", {
        set text(size: 16.5pt)
        set par(leading: 0.42em)
        text(fill: estompe, raw("eleve@POSTE-12 MINGW64 ~/Desktop/info01/cours1/1c_programme"))
        linebreak()
        raw("$ python altitudes.py")
        linebreak()
        raw("moyenne : 129.0 m")
      })
    },
  )
}

// ---------------------------------------------------------------------------
// Trois vignettes pour comparer les fenêtres
//
// Un fond par rôle : le bleu clair, l'endroit où s'écrit le code ; le gris,
// l'endroit où s'affichent les résultats.

#let _fond-code = attention.lighten(72%)
#let _fond-sortie = gris

#let _zone(nom, fond: white) = block(
  width: 100%, height: 100%, fill: fond, stroke: 0.6pt + accent.lighten(55%),
  above: 0pt, below: 0pt,
  align(center + horizon, text(size: 11pt, fill: accent)[#nom]),
)

#let _vignette(nom, corps, hauteur: 72pt) = block(width: 100%)[
  #align(center, text(size: 16pt, weight: demi-gras, fill: accent)[#nom])
  #v(-5pt)
  #block(width: 100%, height: hauteur, corps)
]

#let vignette-jupyterlab() = _vignette("JupyterLab (notebooks)", grid(
  columns: (0.42fr, 1fr), column-gutter: 2pt,
  _zone[fichiers],
  grid(
    rows: (1fr,) * 5, row-gutter: 1pt,
    _zone[texte],
    _zone(fond: _fond-code)[code],
    _zone(fond: _fond-sortie)[résultat],
    _zone(fond: _fond-code)[code],
    _zone(fond: _fond-sortie)[résultat],
  ),
))

#let vignette-spyder() = _vignette("Spyder", grid(
  columns: (1fr, 1fr), column-gutter: 2pt,
  _zone(fond: _fond-code)[éditeur],
  grid(
    rows: (1fr, 1fr), row-gutter: 2pt,
    _zone(fond: _fond-sortie)[variables, figures],
    _zone(fond: _fond-sortie)[console],
  ),
))

#let vignette-vscode() = _vignette("VS Code", grid(
  columns: (0.42fr, 1fr), column-gutter: 2pt,
  _zone[fichiers],
  grid(
    rows: (1.4fr, 1fr), row-gutter: 2pt,
    _zone(fond: _fond-code)[éditeur],
    _zone(fond: _fond-sortie)[terminal],
  ),
))

// ---------------------------------------------------------------------------
// Les fonctions d'un IDE
//
// Le dessin des vignettes, en grand : les trois zones et leurs fonds. Chaque zone
// nomme l'outil du cours 1 qu'elle reprend, puis porte les fonctions de l'IDE. La
// zone en pointillés porte des fenêtres en option, celles de Spyder par exemple.

#let _fonction(corps, largeur: auto) = box(
  width: largeur, fill: white, stroke: 0.6pt + accent.lighten(55%),
  inset: (x: 7pt, y: 4pt),
  text(size: 14pt, fill: accent)[#corps],
)

#let _zone-fonctions(nom, outil, corps, fond: white, trait: 0.6pt + accent.lighten(55%)) = block(
  width: 100%, height: 100%, fill: fond, stroke: trait,
  inset: (x: 10pt, y: 9pt), above: 0pt, below: 0pt,
  {
    text(size: 17pt, weight: demi-gras, fill: accent)[#nom]
    linebreak()
    text(size: 13pt, fill: estompe)[#outil]
    v(7pt)
    block({
      set par(leading: 9pt)
      corps
    })
  },
)

#let schema-fonctions-ide(hauteur: 250pt) = block(width: 100%, height: hauteur, grid(
  columns: _colonnes-ide, column-gutter: 3pt,
  _zone-fonctions("Fichiers", [au cours 1 : l'explorateur], {
    _fonction(largeur: 100%)[arborescence du dossier]
    v(5pt)
    _fonction(largeur: 100%)[recherche dans les fichiers]
  }),
  grid(
    rows: (1.15fr, 1fr), row-gutter: 3pt,
    _zone-fonctions("Éditeur", [au cours 1 : Bloc-notes, Notepad++], fond: _fond-code, [
      #text(size: 14pt, fill: accent)[aide syntaxique :]
      #_fonction[coloration]
      #_fonction[soulignement des fautes]
      #_fonction[indentation]
      #linebreak()
      #_fonction[complétion]
    ]),
    grid(
      columns: (1fr, 1.15fr), column-gutter: 3pt,
      _zone-fonctions("Terminal", [au cours 1 : Git Bash], fond: _fond-sortie, [
        #_fonction[bouton d'exécution]
      ]),
      _zone-fonctions(
        "En option", [fenêtres de Spyder, par exemple], fond: _fond-sortie,
        trait: (paint: accent.lighten(30%), thickness: 0.9pt, dash: "dashed"), [
          #_fonction[débogueur]
          #_fonction[figures]
        ],
      ),
    ),
  ),
))

// ---------------------------------------------------------------------------
// Ce qu'il faut relier à VS Code
//
// 05/11/2026, pour le TD 2a : à gauche, ce qui est dans VS Code ; à droite, ce qui est
// installé à part sur le poste. Le bleu marque ce que le TD configure : l'extension, et
// les deux liens vers le poste. Le fond et le dessin des cases sont ceux de
// `_zone-fonctions`.
#let _case-config(nom, detail, a-configurer: false) = block(
  width: 100%, inset: (x: 10pt, y: 8pt), above: 0pt, below: 0pt,
  fill: if a-configurer { _fond-code } else { white },
  stroke: 0.6pt + accent.lighten(55%),
  {
    text(size: 17pt, weight: demi-gras, fill: accent)[#nom]
    linebreak()
    show raw: set text(size: 1.15em)
    text(size: 14pt, fill: estompe)[#detail]
  },
)

#let _lien-config(corps) = align(center + horizon, stack(
  dir: ttb, spacing: 3pt,
  text(size: 13pt, fill: attention)[#corps],
  text(size: 22pt, fill: attention)[#sym.arrow.r],
))

#let schema-vscode-configuration() = {
  let colonne(corps) = text(size: 15pt, weight: demi-gras, fill: estompe)[#corps]
  grid(
    columns: (1fr, 132pt, 1fr), row-gutter: 9pt, align: left + horizon,
    colonne[Dans VS Code], [], colonne[Installé à part, sur le poste],
    _case-config("Éditeur", [ouverture des fichiers, coloration des langages courants]), [], [],
    _case-config("Extension du langage", [à installer, avec une connexion internet], a-configurer: true),
    _lien-config[chemin à indiquer],
    _case-config("Interpréteur ou compilateur", [`python.exe`, `g++`…]),
    _case-config("Panneau du terminal", [PowerShell par défaut]),
    _lien-config[terminal à choisir],
    _case-config("Terminal", [Git Bash, avec conda activé]),
  )
}

// ---------------------------------------------------------------------------
// Le bouton Extensions, dans la fenêtre de VS Code
//
// 05/11/2026, pour le TD 2a : la barre d'icônes à gauche, le panneau qu'ouvre le bouton
// Extensions, et la zone de recherche. Les repères reprennent les numéros des consignes.
// Dessin de la fenêtre : celui de `fenetre-vscode`. La liste réelle est sur la diapositive
// suivante, en capture.
#let _icone-extensions = box(width: 18pt, height: 18pt, {
  let carre(x, y) = place(top + left, dx: x, dy: y, rect(width: 7pt, height: 7pt, stroke: 1.2pt + attention))
  carre(0pt, 10pt)
  carre(8pt, 10pt)
  carre(0pt, 2pt)
  carre(10pt, 0pt)
})

#let _case-barre(corps, choisie: false) = block(
  width: 100%, height: 30pt, above: 0pt, below: 0pt,
  fill: if choisie { _fond-code },
  stroke: if choisie { (left: 2.5pt + attention) },
  align(center + horizon, corps),
)

#let schema-bouton-extensions(hauteur: 190pt) = {
  set text(size: 11pt, fill: accent)
  let trait = 1.1pt + estompe
  block(width: 100%, stroke: _bord, clip: true)[
    #block(width: 100%, fill: gris, inset: (x: 8pt, y: 5pt), below: 0pt)[
      #text(size: 10.5pt)[File #h(5pt) Edit #h(5pt) View #h(5pt) Terminal #h(5pt) Help]
    ]
    #grid(
      columns: (32pt, 1fr),
      block(width: 100%, height: hauteur, above: 0pt, fill: gris.lighten(25%), stroke: (right: _bord), {
        set block(spacing: 0pt)
        _case-barre(rect(width: 12pt, height: 15pt, stroke: trait))
        _case-barre(circle(radius: 6pt, stroke: trait))
        _case-barre(polygon((0pt, 0pt), (0pt, 14pt), (11pt, 7pt), stroke: trait))
        _case-barre(_icone-extensions, choisie: true)
      }),
      block(width: 100%, height: hauteur, above: 0pt, inset: (x: 10pt, y: 8pt), {
        set block(spacing: 0pt)
        text(size: 10pt, weight: demi-gras, fill: estompe)[EXTENSIONS: MARKETPLACE]
        v(7pt)
        block(width: 100%, stroke: _bord, inset: (x: 7pt, y: 5pt), text(size: 13pt, raw("python")))
        v(14pt)
        text(size: 13pt, fill: estompe)[la liste des extensions s'affiche ici]
        // Les repères sont placés à la main, à hauteur du bouton et de la zone.
        place(top + left, dx: -2pt, dy: 88pt, stack(
          dir: ltr, spacing: 5pt,
          repere(2, taille: 20pt),
          align(horizon, text(size: 14pt, weight: demi-gras, fill: attention)[bouton Extensions]),
        ))
        place(top + right, dx: 2pt, dy: 18pt, repere(3, taille: 20pt))
      }),
    )
  ]
}

// ---------------------------------------------------------------------------
// La liste des terminaux, dans le panneau du terminal
//
// 05/11/2026, pour le TD 2a : la flèche à droite du `+`, que des élèves n'ont pas trouvée
// en 2026, et le menu qu'elle ouvre, réduit aux entrées utiles. Le menu réel, plus long,
// est dans `annexes/configuration/captures/vscode_terminal_choisir.png`.
#let _ligne-menu(corps, choisie: false) = block(
  width: 100%, above: 0pt, below: 0pt, inset: (x: 8pt, y: 3.5pt),
  fill: if choisie { _fond-code },
  text(size: 12pt, corps),
)

#let schema-liste-terminaux(hauteur: 158pt) = {
  set text(size: 11pt, fill: accent)
  let filet = block(above: 2pt, below: 2pt, line(length: 100%, stroke: 0.6pt + accent.lighten(55%)))
  let boutons = stack(
    dir: ltr, spacing: 7pt,
    align(horizon, text(size: 10.5pt, fill: estompe)[bash]),
    repere(4, taille: 18pt),
    align(horizon, box(stroke: 2pt + attention, radius: 3pt, inset: (x: 5pt, y: 3pt))[
      #text(size: 19pt)[+] #h(4pt) #box(fill: _fond-code, inset: (x: 4pt, y: 1pt), baseline: 2pt, text(size: 19pt, weight: demi-gras)[⌄])
    ]),
    align(horizon, rect(width: 9pt, height: 11pt, stroke: 1pt + estompe)),
    align(horizon, text(size: 11pt, fill: estompe)[…]),
  )
  block(width: 100%, stroke: _bord, clip: true)[
    #block(width: 100%, fill: gris, inset: (x: 8pt, y: 5pt), below: 0pt)[
      #text(size: 10.5pt)[File #h(5pt) Edit #h(5pt) View #h(5pt) Terminal #h(5pt) Help]
    ]
    #block(width: 100%, height: 26pt, above: 0pt, below: 0pt, inset: (x: 10pt, y: 7pt),
           text(size: 11pt, fill: estompe)[le fichier ouvert])
    #block(width: 100%, height: hauteur, above: 0pt, stroke: (top: _bord), inset: (x: 8pt, y: 4pt))[
      #set block(spacing: 0pt)
      #grid(
        columns: (1fr, auto), align: left + horizon,
        text(size: 9.5pt, fill: estompe)[PROBLEMS #h(6pt) OUTPUT #h(6pt) #text(weight: demi-gras, fill: accent)[TERMINAL]],
        boutons,
      )
      #v(10pt)
      #text(size: 13pt, raw("eleve@POSTE MINGW64\n$", block: true))
      // Le menu, sous la flèche.
      #place(top + right, dx: 0pt, dy: 38pt, block(
        width: 150pt, fill: white, stroke: 0.8pt + accent.lighten(40%), radius: 3pt, inset: (y: 3pt),
        {
          set align(left)
          _ligne-menu[New Terminal]
          filet
          _ligne-menu[PowerShell]
          _ligne-menu(choisie: true)[Git Bash]
          _ligne-menu[Command Prompt]
          filet
          _ligne-menu[Select Default Profile]
        },
      ))
    ]
  ]
}
