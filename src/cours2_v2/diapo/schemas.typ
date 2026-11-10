// Schémas du cours 2 v2.
//
// `fenetre-vscode` : la fenêtre de VS Code telle que les élèves la
// configurent au TD 2a, dessinée (28/09/2026). Elle remplace la capture du
// cours 1 de 2026 (projet trajet), absente du dépôt, dont le repli ne
// dessinait qu'une fenêtre vide. Intitulés en anglais, comme sur les postes ;
// disposition simplifiée. Le programme est `2a_vscode/altitudes.py`, et la
// sortie du terminal est la sienne. 09/11/2026 : le dossier ouvert est
// `2a_vscode` seul, un dossier par projet, et la commande part de lui.
//
// `zoom-barre-etat` (09/11/2026) : la droite de la barre d'état, agrandie, avec
// l'indentation du fichier encadrée.
//
// `schema-rappel-outils` (04/11/2026) : trois fenêtres séparées, à la disposition
// de `fenetre-vscode`, l'explorateur à gauche, l'éditeur au-dessus du terminal.
//
// `vignette-jupyterlab`, `vignette-spyder`, `vignette-vscode` (04/11/2026) : la
// disposition par défaut de chaque fenêtre, simplifiée. `schema-fonctions-ide`
// reprend ce dessin, en grand.
#import "../../commun/theme.typ": accent, alerte, attention, brun, estompe, gris, police-code, demi-gras, reponse
#import "../../cours1_v2/diapo/schemas.typ": _entree, _icone-fichier
#import "../../cours5/diapo/schemas.typ": repere
#import "../../commun/schemas_git.typ": graphe-git
#import "@preview/cetz:0.4.2"

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
#let fenetre-vscode(hauteur: 300pt, reperes: false, commande: "python altitudes.py", lignes: (1, 8)) = {
  set text(size: 11pt, fill: accent)
  let code = "\"\"\"Moyenne d'une série d'altitudes, à la main plutôt qu'avec sum().\"\"\"\n\naltitudes = [79.6, 103.2, 98.3]\ntotal = 0\nfor altitude in altitudes:\n    total = total + altitude\nmoyenne = total / len(altitudes)\nprint(f\"moyenne : {moyenne:.1f} m\")"
  block(width: 100%, stroke: _bord, clip: true)[
    // Barre de titre et menus
    #block(width: 100%, fill: gris, inset: (x: 8pt, y: 5pt))[
      #text(size: 10.5pt)[File #h(6pt) Edit #h(6pt) Selection #h(6pt) View #h(6pt) Go #h(6pt) Run #h(6pt) Terminal #h(6pt) Help]
      #h(1fr)
      #text(size: 10.5pt, fill: estompe)[altitudes.py — 2a_vscode — Visual Studio Code]
      #h(1fr)
    ]
    #grid(
      columns: (5.4cm, 1fr),
      // L'explorateur
      block(width: 100%, height: hauteur - 42pt, fill: gris.lighten(40%), stroke: (right: _bord), inset: (y: 6pt))[
        #set block(spacing: 0pt)
        #_nom-zone[l'arborescence]
        #block(inset: (x: 8pt, bottom: 4pt), text(size: 9.5pt, weight: demi-gras, fill: estompe)[EXPLORER])
        #_ligne-arbre(text(weight: demi-gras)[⌄ 2A_VSCODE])
        #_ligne-arbre([altitudes.py #if reperes { h(6pt); box(baseline: 5pt, repere(1, taille: 18pt)) }], retrait: 1, courant: true)
        #_ligne-arbre([td_2a_vscode.pdf], retrait: 1)
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
            #raw("(base)\neleve@POSTE MINGW64 ~/Desktop/info01/cours2/2a_vscode\n$ " + commande + "\nmoyenne : 93.7 m", block: true)
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

#let zoom-barre-etat() = block(fill: accent, inset: (x: 12pt, y: 7pt), radius: 2pt)[
  #set text(size: 15pt, fill: white)
  Ln 8, Col 1 #h(16pt)
  #box(stroke: 1.6pt + white, inset: (x: 5pt, y: 3pt), outset: (y: 2pt), radius: 3pt)[Spaces: 4]
  #h(16pt) UTF-8 #h(16pt) LF #h(16pt) Python
]

// ---------------------------------------------------------------------------
// Rappel du cours 1 : trois fenêtres séparées
//
// Le programme et sa sortie sont ceux du TD 1c. Les icônes des éditeurs sont
// celles du cours 1 v2 (`images/editeurs/CREDITS.md`). 09/11/2026 : le dossier
// est `1c_programme/travail`, où le TD 1c copie ses fichiers depuis `depart/`.

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
  let code = "altitudes = [79.6, 103.2, 98.3]\ntotal = 0\nfor altitude in altitudes:\n    total = total + altitude\nmoyenne = total / len(altitudes)\nprint(f\"moyenne : {moyenne:.1f} m\")"
  let icones = box(baseline: 3pt, stack(
    dir: ltr, spacing: 5pt,
    image("/src/cours1_v2/images/editeurs/bloc_notes.svg", height: 17pt),
    image("/src/cours1_v2/images/editeurs/notepadpp.svg", height: 17pt),
  ))
  grid(
    columns: (_colonnes-ide.at(0), auto, _colonnes-ide.at(1)), column-gutter: 7pt, align: top,
    {
      _titre-outil[Explorateur de fichiers]
      _fenetre-serree("travail", {
        block(width: 100%, stroke: 0.6pt + estompe, inset: (x: 6pt, y: 4pt), radius: 2pt, below: 5pt,
              text(font: police-code, size: 12pt)[…\\1c_programme\\travail])
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
        text(fill: estompe, raw("eleve@POSTE-12 MINGW64 ~/Desktop/info01/cours1/1c_programme/travail"))
        linebreak()
        raw("$ python altitudes.py")
        linebreak()
        raw("moyenne : 93.7 m")
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
          repere(3, taille: 20pt),
          align(horizon, text(size: 14pt, weight: demi-gras, fill: attention)[bouton Extensions]),
        ))
        place(top + right, dx: 2pt, dy: 18pt, repere(4, taille: 20pt))
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

// ---------------------------------------------------------------------------
// Pictogrammes des schémas git. `d` est le module `cetz.draw`, `p` le point où poser le
// dessin. La personne et l'écran viennent de `src/cours2/diapo/schemas.typ`.

#let _logos-git = "/src/cours2_v2/images/git/"   // voir CREDITS.md

// Tête et buste.
#let _personne(d, p, taille: 0.42, couleur: accent) = {
  let t = taille
  d.circle((p.at(0), p.at(1) + t * 0.46), radius: t * 0.26, stroke: 0.9pt + couleur, fill: white)
  d.line(
    (p.at(0) - t * 0.42, p.at(1) - t * 0.5),
    (p.at(0) - t * 0.40, p.at(1) + t * 0.06),
    (p.at(0) - t * 0.24, p.at(1) + t * 0.22),
    (p.at(0) + t * 0.24, p.at(1) + t * 0.22),
    (p.at(0) + t * 0.40, p.at(1) + t * 0.06),
    (p.at(0) + t * 0.42, p.at(1) - t * 0.5),
    close: true, stroke: 0.9pt + couleur, fill: white,
  )
}

// Un écran sur son pied.
#let _ecran(d, p, taille: 0.42, couleur: accent) = {
  d.rect(
    (p.at(0) - taille / 2, p.at(1) - taille * 0.34),
    (p.at(0) + taille / 2, p.at(1) + taille * 0.34),
    stroke: 0.9pt + couleur, fill: white,
  )
  d.line(
    (p.at(0) - taille * 0.18, p.at(1) - taille * 0.34),
    (p.at(0) + taille * 0.18, p.at(1) - taille * 0.34),
    stroke: 1.6pt + couleur,
  )
}

// Trois tiroirs empilés, chacun avec son voyant.
#let _serveur(d, p, taille: 0.5, couleur: accent) = {
  let l = taille
  let h = taille * 0.24
  for i in range(3) {
    let y = p.at(1) + (1 - i) * h * 1.15
    d.rect((p.at(0) - l / 2, y - h / 2), (p.at(0) + l / 2, y + h / 2),
      radius: 0.03, stroke: 0.8pt + couleur, fill: white)
    d.circle((p.at(0) + l * 0.32, y), radius: h * 0.16, fill: couleur, stroke: none)
  }
}

// Une fenêtre de terminal : fond sombre, invite `>_`.
#let _terminal(d, p, taille: 0.6, echelle: 1.0) = {
  d.rect((p.at(0) - taille / 2, p.at(1) - taille * 0.4), (p.at(0) + taille / 2, p.at(1) + taille * 0.4),
    radius: 0.06, fill: accent, stroke: none)
  d.content((p.at(0) - taille * 0.36, p.at(1) + taille * 0.12),
    text(font: police-code, size: 9pt * echelle, weight: "bold", fill: white)[>\_], anchor: "west")
}

// ---------------------------------------------------------------------------
// Git : vue d'ensemble, d'après « Git : c'est quoi ? » du cours 2 de 2026 (Florent
// Geniet). Quatre usages autour du logo ; ceux que la séance traite sont en `attention`.
#let schema-usages-git(echelle: 1.0) = cetz.canvas(length: echelle * 1cm, {
  import cetz.draw: *
  let rayon = 1.5
  let logo = (0, 2.0)
  let petite-fleche = (end: ">", fill: accent, scale: 0.35)
  let marque(fichier, p, largeur) = content(p, image(_logos-git + fichier, width: largeur * echelle * 1cm))
  let traite(corps) = text(weight: "bold", fill: attention, corps)

  // Le contenu de chaque cercle, dessiné autour de son centre (x, y).
  let versions(x, y) = {
    line((x - 0.15, y + 0.75), (x - 0.15, y - 0.85),
      stroke: (paint: estompe, thickness: 0.7pt, dash: "densely-dashed"),
      mark: (end: ">", fill: estompe, scale: 0.4))
    for (i, teinte) in (rgb("#A8D8A8"), rgb("#F2B8B8"), rgb("#CBB8E8")).enumerate() {
      let yi = y + 0.55 - i * 0.55
      circle((x - 0.15, yi), radius: 0.2, fill: teinte, stroke: 0.7pt + accent)
      content((x + 0.15, yi), text(size: 10pt * echelle, fill: accent)[V#(i + 1)], anchor: "west")
    }
  }
  let equipe(x, y) = {
    marque("git.svg", (x, y + 0.75), 0.6)
    for dx in (-0.7, 0.0, 0.7) {
      _personne(cetz.draw, (x + dx, y - 0.5), taille: 0.52)
      line((x + dx * 0.5, y + 0.38), (x + dx, y - 0.18), stroke: 0.7pt + accent, mark: petite-fleche)
    }
  }
  let forge(x, y) = {
    for (fichier, nom, dy) in (("github.svg", "GitHub", 1.0), ("gitlab.svg", "GitLab", 0.64)) {
      marque(fichier, (x - 0.55, y + dy), 0.3)
      content((x - 0.33, y + dy), text(size: 9pt * echelle, weight: "bold", fill: accent)[#nom], anchor: "west")
    }
    _serveur(cetz.draw, (x, y + 0.12), taille: 0.5)
    for dx in (-0.65, 0.0, 0.65) {
      _ecran(cetz.draw, (x + dx, y - 0.68), taille: 0.48)
      line((x + dx * 0.45, y - 0.16), (x + dx, y - 0.44), stroke: 0.7pt + accent, mark: petite-fleche)
    }
  }
  // En haut, les deux outils de la séance ; en bas, deux logiciels dédiés.
  let outils(x, y) = {
    _terminal(cetz.draw, (x - 0.5, y + 0.42), taille: 0.68, echelle: echelle)
    marque("vscode.svg", (x + 0.5, y + 0.42), 0.64)
    marque("gitkraken.svg", (x - 0.5, y - 0.55), 0.75)
    marque("tortoisegit.svg", (x + 0.5, y - 0.55), 0.8)
  }

  let usages = (
    (centre: (-6.3, 0.6), traite: true, dessin: versions,
      titre: traite[Versionnement \ du code]),
    (centre: (-2.3, -3.0), traite: false, dessin: equipe,
      titre: [Travail à plusieurs]),
    (centre: (2.3, -3.0), traite: false, dessin: forge,
      titre: [Hébergement du code en ligne]),
    (centre: (6.3, 0.6), traite: true, dessin: outils,
      titre: [#traite[ligne de commande], logiciels dédiés, #traite[IDE]]),
  )

  for u in usages {
    let (cx, cy) = u.centre
    let couleur = if u.traite { attention } else { accent }
    // Une flèche du bord du logo au bord du cercle.
    let (dx, dy) = (cx - logo.at(0), cy - logo.at(1))
    let n = calc.sqrt(dx * dx + dy * dy)
    line(
      (logo.at(0) + dx / n * 1.05, logo.at(1) + dy / n * 1.05),
      (cx - dx / n * rayon, cy - dy / n * rayon),
      stroke: (if u.traite { 1.8pt } else { 1.1pt }) + couleur,
      mark: (end: ">", fill: couleur, scale: 0.5),
    )
    circle(u.centre, radius: rayon,
      stroke: (if u.traite { 2pt } else { 0.8pt }) + couleur,
      fill: if u.traite { attention.lighten(90%) } else { white })
    (u.dessin)(cx, cy)
    content(
      (cx, cy - rayon - 0.15),
      block(width: 4.2cm * echelle)[
        #set par(leading: 0.45em)
        #align(center, text(size: 12pt * echelle, fill: accent)[#u.titre])
      ],
      anchor: "north",
    )
  }

  marque("git.svg", logo, 2.0)
})

// ---------------------------------------------------------------------------
// Créer un dépôt : le dossier `travail` avant et après `git init`, le nouveau `.git` surligné.
#let _icone-dossier = box(width: 15pt, height: 12pt, baseline: 2pt, {
  place(top + left, rect(width: 7pt, height: 4pt, radius: (top: 1.5pt), fill: accent.lighten(55%)))
  place(bottom + left, rect(width: 15pt, height: 10pt, radius: 1.5pt, fill: accent.lighten(55%)))
})

// Une ligne d'arborescence. `nouveau` surligne ce que l'étape crée ; `cache` estompe
// un nom qui commence par un point ; `note` s'écrit à droite du nom.
#let _entree-arbre(nom, retrait: 0, dossier: false, nouveau: false, cache: false, note: none, taille: 14pt) = block(
  above: 2pt, below: 2pt, inset: (left: 4pt + retrait * 20pt, right: 8pt, y: taille * 3 / 14), radius: 2pt,
  fill: if nouveau { attention.lighten(85%) },
  [#if dossier { _icone-dossier } else { _icone-fichier } #h(5pt)
   #text(font: police-code, size: taille, fill: if cache { estompe } else { accent }, nom)
   #if note != none { h(6pt) + text(size: 12pt, fill: estompe, note) }],
)

// Un cadre titré autour de lignes d'arborescence.
#let _cadre-arbre(titre, ..lignes) = block(width: 100%, stroke: _bord, radius: 3pt, inset: 8pt)[
  #text(size: 14pt, weight: demi-gras, fill: estompe, titre)
  #v(2pt)
  #lignes.pos().join()
]

#let schema-git-init() = {
  let entree = _entree-arbre
  let etat = _cadre-arbre
  let dossier = (entree("travail", dossier: true), entree("altitudes.py", retrait: 1))
  stack(
    spacing: 6pt,
    etat([Avant `git init`], ..dossier),
    align(center, text(size: 22pt, fill: accent, sym.arrow.b)),
    etat([Après `git init`], ..dossier,
      entree(".git", retrait: 1, dossier: true, nouveau: true),
      pad(left: 4pt + 2 * 20pt, text(font: police-code, size: 12pt, fill: estompe)[HEAD config objects refs …]),
    ),
  )
}

// TD 2c, étape 4 : le dossier `travail` après le commit de `.gitignore`, puis le contenu
// de ce fichier. Ce que l'étape fait constater, `notes.txt` ignoré, est une réponse.
#let schema-dossier-gitignore() = {
  let entree = _entree-arbre.with(taille: 13pt)
  stack(
    spacing: 8pt,
    _cadre-arbre([Dossier `travail`],
      entree("travail", dossier: true),
      entree(".git", retrait: 1, dossier: true, cache: true, note: [caché]),
      entree(".gitignore", retrait: 1, nouveau: true, cache: true, note: [caché]),
      entree("altitudes.py", retrait: 1),
      entree("notes.txt", retrait: 1, note: reponse[ignoré]),
      entree("README.md", retrait: 1),
    ),
    _cadre-arbre([Contenu de `.gitignore`],
      block(width: 100%, above: 4pt, fill: gris, inset: (x: 8pt, y: 4pt),
        text(font: police-code, size: 13pt, "notes.txt"))),
  )
}

// ---------------------------------------------------------------------------
// Aide-mémoire : les trois zones de « Trois zones : dossier, index, dépôt », et les
// commandes qui font passer un fichier de l'une à l'autre.
#let schema-zones-commandes(echelle: 1.0) = cetz.canvas(length: echelle * 1cm, {
  import cetz.draw: *
  let (largeur, hauteur, ecart) = (4.6, 1.1, 7.8)
  let zones = ([Dossier de travail], [Index], [Dépôt, dans `.git`])
  for (i, nom) in zones.enumerate() {
    rect((i * ecart, 0), (i * ecart + largeur, hauteur), radius: 0.12, stroke: _bord,
      fill: if i == 2 { accent.lighten(88%) } else { white }, name: "z" + str(i))
    content("z" + str(i), text(size: 14pt * echelle, weight: demi-gras, nom))
  }
  let commande(p, t, ancre) = content(p, anchor: ancre,
    text(size: 13pt * echelle, font: police-code, fill: attention, t))
  let fleche = (paint: attention, thickness: 1.4pt)
  let pointe = (end: "straight", fill: attention, scale: 0.8)
  for (i, t) in ((0, "git add"), (1, "git commit")) {
    let (a, b) = (i * ecart + largeur, (i + 1) * ecart)
    line((a + 0.1, hauteur / 2), (b - 0.1, hauteur / 2), stroke: fleche, mark: pointe)
    commande(((a + b) / 2, hauteur / 2 + 0.15), t, "south")
  }
  // `git restore` : du dépôt vers le dossier, par-dessous.
  let (x0, x2) = (largeur / 2, 2 * ecart + largeur / 2)
  line((x2, -0.1), (x2, -0.7), (x0, -0.7), (x0, -0.1), stroke: fleche, mark: pointe)
  commande(((x0 + x2) / 2, -0.82), "git restore", "north")
})

// ---------------------------------------------------------------------------
// Trois zones, d'après « Enregistrer des modifications » du cours 2 de 2026 (Florent
// Geniet) : `altitudes.py` va du dossier de travail au dépôt en deux commits, comme aux
// étapes 1 et 2 du TD 2c. Une ligne de vie par zone, le temps vers le bas, et à droite ce
// qu'affiche alors `git status`.
#let schema-zones-git(echelle: 1.0) = cetz.canvas(length: echelle * 1cm, {
  import cetz.draw: *
  let ecart = 4.7                       // d'une zone à la suivante
  let pas = 0.8                         // d'une ligne à la suivante
  let x-statut = 2 * ecart + 2.4
  let taille = 12pt * echelle
  let zones = (
    (nom: [Dossier de travail], detail: [les fichiers tels qu'on les modifie]),
    (nom: [Index], detail: [ce qui entrera dans le prochain commit]),
    (nom: [Dépôt], detail: [l'historique des commits, dans `.git`]),
  )
  // Un événement sur la ligne du dossier (`de` = `vers`) ou d'une zone à la suivante, puis
  // le message de `git status` qui le suit, et le commit créé.
  let propre = "rien à valider, la copie de travail est propre"
  let evenements = (
    (de: 0, vers: 0, texte: [`altitudes.py` créé], statut: "Fichiers non suivis"),
    (de: 0, vers: 1, texte: raw("git add"), statut: "Modifications qui seront validées"),
    (de: 1, vers: 2, texte: raw("git commit"), statut: propre, commit: "64e"),
    (de: 0, vers: 0, texte: [`altitudes.py` modifié], statut: "Modifications qui ne seront pas validées"),
    (de: 0, vers: 1, texte: raw("git add"), statut: "Modifications qui seront validées"),
    (de: 1, vers: 2, texte: raw("git commit"), statut: propre, commit: "726"),
  )
  let bas = -(evenements.len() + 0.2) * pas

  for (i, z) in zones.enumerate() {
    let x = i * ecart
    let depot = i == 2
    content((x, 0.15), anchor: "south", block(
      width: 4.4 * echelle * 1cm, height: 1.75 * echelle * 1cm, inset: 6pt,
      fill: if depot { accent.lighten(88%) },
      stroke: 1pt + accent.lighten(if depot { 40% } else { 65% }),
      align(center + horizon, stack(spacing: 5pt,
        text(size: 13pt * echelle, weight: demi-gras, fill: accent, z.nom),
        text(size: 10.5pt * echelle, fill: estompe, z.detail),
      )),
    ))
    line((x, 0.15), (x, bas), stroke: 0.8pt + estompe)
  }
  content((x-statut, 0.4), anchor: "south-west",
    text(size: taille, weight: demi-gras, fill: estompe)[Sortie de `git status`])

  for (k, e) in evenements.enumerate() {
    let y = -(k + 0.6) * pas
    let (x1, x2) = (e.de * ecart, e.vers * ecart)
    if e.de == e.vers {
      circle((x1, y), radius: 0.11, fill: accent, stroke: none)
      content((x1 - 0.25, y), text(size: taille, fill: accent, e.texte), anchor: "east")
    } else {
      let fin = if "commit" in e { x2 - 0.4 } else { x2 - 0.05 }
      line((x1 + 0.05, y), (fin, y), stroke: 1.3pt + accent,
        mark: (end: ">", fill: accent, scale: 0.6))
      content(((x1 + x2) / 2, y + 0.08), text(size: taille, fill: accent, e.texte), anchor: "south")
    }
    if "commit" in e {
      circle((x2, y), radius: 0.34, fill: accent.lighten(88%), stroke: 1.3pt + accent)
      content((x2, y), text(size: 9pt * echelle, weight: demi-gras, font: police-code,
        fill: accent, e.commit))
    }
    content((x-statut, y), text(size: taille, fill: estompe, "« " + e.statut + " »"), anchor: "west")
  }
})

// ---------------------------------------------------------------------------
// Git : fonctionnalités, d'après « Fonctionnalités » du cours 2 de 2026 (Florent Geniet).
//
// L'histoire d'`altitudes.py` dans les TD : Bruno écrit le programme, Alice ajoute sur sa
// branche le dénivelé cumulé et un seuil, Bruno fusionne puis renomme le script.
// `etape` ajoute, de 1 à 7 : la branche de Bruno, celle d'Alice, les développeurs, la
// fusion, les étiquettes, les utilisateurs, le dépôt sur GitHub. L'étape 1 oppose aussi
// cet historique à une copie de fichier par version. Le cadre du dessin est le même à
// toutes les étapes : rien ne bouge d'une page à l'autre.
#let schema-fonctionnalites-git(etape: 7, echelle: 1.0) = {
  let ex = 2.4                    // d'une colonne à la suivante
  let ey = 2.1                    // ordonnée de la branche d'Alice ; celle de Bruno est 0
  let r = 0.44                    // rayon d'un commit dans `graphe-git`
  let y-version = -1.62
  let y-utilisateur = -3.15
  let x-nom = -3.05               // colonne des développeurs
  let x-forge = -1.1              // bord gauche du cadre de la forge
  let gauche = x-nom - 1.32       // bords du dessin
  let droite = 5 * ex + 1.25
  let fin-bande = 5 * ex + 1.05
  let taille = 11.5pt * echelle
  let fleche = (end: ">", fill: accent, scale: 0.45)

  let commits = (
    (nom: "c1", col: 0, voie: 0, texte: "moyenne"),
    (nom: "c2", col: 1, voie: 0, texte: "min et max", parents: ("c1",)),
    (nom: "c3", col: 2, voie: 0, texte: "fichier texte", parents: ("c2",)),
    (nom: "c4", col: 2, voie: 1, texte: "dénivelé cumulé", parents: ("c2",), etape: 2),
    (nom: "c5", col: 3, voie: 0, texte: "trace GPS", parents: ("c3",)),
    (nom: "c6", col: 3, voie: 1, texte: "seuil", parents: ("c4",), etape: 2),
    (nom: "c7", col: 4, voie: 0, texte: "fusion", parents: ("c5", "c6"), etape: 4),
    (nom: "c8", col: 5, voie: 0, texte: "renommage", parents: ("c7",), etape: 4),
  )
  let versions = (("c2", "v1"), ("c5", "v2"), ("c7", "v3"))
  // Chaque bande couvre la branche et les textes de ses commits.
  let developpeurs = (
    (nom: "Bruno", y: 0, couleur: accent, fond: accent.lighten(93%), bande: (-1.12, 0.62)),
    (nom: "Alice", y: ey, couleur: brun, fond: brun.lighten(90%), bande: (ey - 0.62, ey + 1.12)),
  )

  graphe-git(
    commits: commits, etape: etape, echelle: echelle, ecart-x: ex, ecart-y: ey,
    extra: (pos, d) => {
      d.rect((gauche, y-utilisateur - 0.55), (droite, ey + 1.85), stroke: none)

      // Étape 1 : une copie par version face aux commits, et deux légendes, dans la place
      // que la branche d'Alice et les étiquettes occupent ensuite.
      if etape == 1 {
        let titre-ligne(y, titre, detail) = d.content((x-nom, y), align(center,
          text(size: taille, fill: accent)[#text(weight: demi-gras, titre) \ #detail]))
        titre-ligne(2.55, [Sans git], [une copie \ par version])
        titre-ligne(-0.35, [Avec git], [un commit \ par version])
        d.content((-0.75, 2.55), anchor: "west", block(fill: gris, inset: (x: 8pt, y: 6pt),
          text(size: 15pt * echelle, raw(block: true,
            "altitudes.py\naltitudes_v2.py\naltitudes_final.py\naltitudes_final_OK.py"))))
        let legende(y, ancre, corps) = d.content(((gauche + droite) / 2, y),
          block(width: (droite - gauche) * echelle * 1cm,
            align(center, text(size: 13pt, fill: estompe, corps))),
          anchor: ancre)
        legende(0.75, "south")[Chaque flèche part d'un commit enfant et pointe vers son parent.]
        legende(-1.3, "north")[
          Exemple tiré des TD 2c, 3a, 3b et 4a : script `altitudes.py`, puis `stats_trace.py`.
        ]
      }

      // Le texte de chaque commit : sous la branche de Bruno, au-dessus de celle d'Alice.
      for c in commits.filter(c => c.at("etape", default: 0) <= etape) {
        let (x, y) = pos(c.nom)
        let dessous = c.voie == 0
        d.content((x, if dessous { y - r - 0.1 } else { y + r + 0.1 }),
          text(size: taille, fill: accent, c.texte),
          anchor: if dessous { "north" } else { "south" })
      }

      if etape >= 3 {
        for dev in developpeurs {
          d.on-layer(-1, d.rect((x-nom - 1.05, dev.bande.at(0)), (fin-bande, dev.bande.at(1)),
            radius: 0.15, stroke: none, fill: dev.fond))
          _personne(d, (x-nom - 0.38, dev.y + 0.12), taille: 0.62, couleur: dev.couleur)
          _ecran(d, (x-nom + 0.37, dev.y + 0.1), taille: 0.55, couleur: dev.couleur)
          d.content((x-nom, dev.y - 0.36),
            text(size: taille, weight: demi-gras, fill: dev.couleur, dev.nom), anchor: "north")
        }
      }

      if etape >= 5 {
        for (nom, v) in versions {
          d.content((pos(nom).at(0), y-version), box(
            stroke: 1pt + accent, fill: white, inset: (x: 6pt, y: 3pt), radius: 3pt,
            text(size: taille, weight: demi-gras, fill: accent, v),
          ))
        }
      }

      if etape >= 6 {
        d.content((x-nom, y-utilisateur + 0.15), text(size: taille, fill: accent)[Utilisateurs])
        for (nom, v) in versions {
          let x = pos(nom).at(0)
          _personne(d, (x, y-utilisateur), taille: 0.62)
          d.line((x, y-utilisateur + 0.52), (x, y-version - 0.36), stroke: 0.9pt + accent, mark: fleche)
        }
      }

      // Le dépôt sur la forge entoure les commits ; chaque poste échange avec lui.
      if etape >= 7 {
        d.rect((x-forge, y-version - 0.5), (fin-bande + 0.15, ey + 1.8), radius: 0.2,
          stroke: 1.3pt + accent)
        d.content((x-forge + 0.25, ey + 1.47),
          image(_logos-git + "github.svg", width: 0.42 * echelle * 1cm), anchor: "west")
        d.content((x-forge + 0.8, ey + 1.47),
          text(size: taille, weight: demi-gras, fill: accent)[Dépôt sur GitHub], anchor: "west")
        let (debut, fin) = (x-nom + 0.75, x-forge - 0.1)
        for dev in developpeurs {
          let (milieu, y) = ((debut + fin) / 2, dev.y)
          d.line((debut, y + 0.14), (fin, y + 0.14), stroke: 1pt + accent, mark: fleche)
          d.line((fin, y - 0.14), (debut, y - 0.14), stroke: 1pt + accent, mark: fleche)
          d.content((milieu, y + 0.2), text(size: 10pt * echelle, fill: accent)[push], anchor: "south")
          d.content((milieu, y - 0.2), text(size: 10pt * echelle, fill: accent)[pull], anchor: "north")
        }
      }
    },
  )
}
