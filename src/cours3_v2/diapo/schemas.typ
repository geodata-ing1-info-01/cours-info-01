// Gabarits propres au cours 3, pour montrer du code et ses sorties. Les
// gabarits communs sont dans `src/commun/schemas.typ`.
#import "../../commun/prelude.typ": *

// Une sortie de terminal ou de cellule, passée en chaîne (les `\n` y sont
// des retours à la ligne) : rendue en `raw` pour que les colonnes restent
// alignées, sur fond gris, en taille réduite pour tenir sur une diapositive.
#let sortie(texte, taille: 13pt) = block(
  width: 100%, inset: (x: 10pt, y: 8pt), fill: gris,
)[
  // Le thème règle la taille des blocs `raw` par une règle `show` ; celle-ci,
  // posée plus près, la remplace.
  #show raw: set text(size: taille)
  #raw(block: true, texte)
]

// Un code commenté ligne à ligne : à gauche chaque ligne de code, à droite
// ce qu'elle fait, en une ligne courte. Une paire par ligne ; une paire dont
// le code est vide fait une ligne blanche. Le code se met en `raw` avec
// coloration Python. Le commentaire est lu comme du balisage typst : les
// accents graves y donnent du code en ligne.
//
//   #code-commente(
//     ("from pathlib import Path", "importer la bibliothèque"),
//     ("dossier = Path(\"depart\")", "déclarer un chemin"),
//   )
#let code-commente(..lignes, taille-code: 14pt, taille-texte: 13.5pt) = {
  let paires = lignes.pos()
  // Le thème réduit les `raw` par une règle `show` ; celle-ci, posée plus
  // près, fixe la taille du code.
  show raw: set text(size: taille-code)
  grid(
    columns: (auto, 1fr), column-gutter: 20pt, row-gutter: 6pt,
    align: (left + horizon, left + horizon),
    ..paires.map(paire => (
      if paire.at(0) == "" { [] } else { raw(lang: "python", paire.at(0)) },
      text(size: taille-texte, fill: estompe, eval(paire.at(1), mode: "markup")),
    )).flatten(),
  )
}

// Une arborescence de dossiers, dessinée avec les traits de la commande
// `tree`. Chaque entrée est un tableau `(niveau, nom)` ou `(niveau, nom,
// note)`, dans l'ordre de lecture ; le niveau 0 est la racine. La note est
// écrite à droite, en gris. Un nom passé en contenu plutôt qu'en chaîne
// garde sa mise en forme : `text(fill: attention)[recette.ipynb]` pour un
// fichier à copier.
//
//   #arborescence(
//     (0, "cours3/"),
//     (1, "3b_recette/"),
//     (2, "travail/", "vide"),
//   )
#let arborescence(..entrees, taille: 12pt) = {
  let e = entrees.pos()
  // Une entrée est la dernière de son dossier quand aucune entrée du même
  // niveau ne la suit avant une entrée de niveau inférieur.
  let derniere(i) = {
    let n = e.at(i).at(0)
    let resultat = true
    let fini = false
    for j in range(i + 1, e.len()) {
      if not fini {
        let m = e.at(j).at(0)
        if m < n { fini = true }
        else if m == n { resultat = false; fini = true }
      }
    }
    resultat
  }
  // Le dernier ancêtre de l'entrée i au niveau k.
  let ancetre(i, k) = {
    let trouve = none
    for j in range(0, i) {
      if e.at(j).at(0) == k { trouve = j }
    }
    trouve
  }
  let blanc = "\u{00A0}"
  let lignes = ()
  for (i, entree) in e.enumerate() {
    let n = entree.at(0)
    let prefixe = ""
    for k in range(1, n) {
      let a = ancetre(i, k)
      prefixe += if a != none and not derniere(a) { "│" + blanc * 2 } else { blanc * 3 }
    }
    if n > 0 { prefixe += if derniere(i) { "└─" + blanc } else { "├─" + blanc } }
    let note = if entree.len() > 2 { entree.at(2) } else { "" }
    lignes.push(text(font: police-code, size: taille)[#prefixe#entree.at(1)])
    lignes.push(text(size: taille, fill: estompe, if type(note) == str { eval(note, mode: "markup") } else { note }))
  }
  grid(
    columns: (auto, auto), column-gutter: 22pt, row-gutter: 0.42em,
    align: (left + horizon, left + horizon),
    ..lignes,
  )
}

// Le panneau des fichiers de JupyterLab, dessiné : la ligne du chemin, en
// haut, puis le contenu du dossier ouvert. `chemin` est la liste des
// dossiers depuis le dossier de lancement ; `entrees` les noms affichés.
#let panneau-jupyterlab(chemin, entrees, largeur: 100%) = block(
  width: largeur, stroke: 1pt + estompe, radius: 3pt, clip: true,
)[
  #block(width: 100%, fill: gris, inset: (x: 10pt, y: 7pt), below: 0pt)[
    #box(width: 13pt, height: 9pt, stroke: 1.2pt + encre, radius: 1pt, baseline: 0pt)
    #text(font: police-code, size: 12pt, chemin.map(dossier => " / " + dossier).join() + " /")
  ]
  #block(width: 100%, inset: (x: 10pt, y: 8pt))[
    #set text(font: police-code, size: 12pt)
    #set par(leading: 0.7em)
    #entrees.join(linebreak())
  ]
]

// Une étape de TD : l'attendu, ce qui doit exister ou fonctionner à la fin
// de l'étape, puis les pistes, les opérations à faire, numérotées dans
// l'ordre. Les deux listes sont l'une sous l'autre : côte à côte, en deux
// tableaux, leurs lignes semblaient se répondre (30/09/2026). Une coche
// marque ce qu'on vérifie, un numéro l'ordre des opérations : c'est
// l'exception de STYLE.md aux listes sur les diapositives, réservée aux
// diapositives d'étape de TD. Chaque argument est une liste de contenus, une
// ligne par élément. Le code complet reste dans le guide.
//
//   #attendu-pistes(
//     ([`python recette.py` affiche la recette pour 6 personnes],),
//     ([calculer le facteur], [reprendre la boucle de `afficher`]),
//   )
#let attendu-pistes(attendu, pistes, taille: 15pt) = {
  let titre(t) = text(size: taille, weight: demi-gras, fill: encre)[#t]
  let liste(elements, marque) = {
    set text(size: taille)
    grid(
      columns: (auto, 1fr), column-gutter: 8pt, row-gutter: 0.42em,
      ..elements.enumerate().map(((i, x)) => (marque(i), x)).flatten(),
    )
  }
  stack(
    spacing: 0.45em,
    titre[Attendu à la fin de l'étape],
    liste(attendu, i => text(fill: attention)[#sym.checkmark]),
    v(0.35em),
    titre[Pistes],
    liste(pistes, i => [#str(i + 1).]),
  )
}

// ---------------------------------------------------------------------------
// Les versions du script, partie 1 (05/11/2026)
//
// Le script à gauche ; à droite, ce qu'il fait sur deux postes ; dessous, ce
// qu'une autre personne fait pour traiter ses données.

// Un script entier, une bande par ligne. Les lignes de `vives`, comptées à
// partir de 1, ont un fond bleu clair : ce sont celles qui changent d'une
// version à l'autre. `interligne` est la hauteur d'une bande, en multiple de
// `taille`.
#let script(texte, vives: (), taille: 11pt, interligne: 1.38, lang: "python") = block(
  width: 100%, inset: 7pt, fill: gris, above: 0pt, below: 0pt,
)[
  // Le thème réduit les `raw` en ligne ; celle-ci, posée plus près, fixe la taille.
  #show raw: set text(size: taille)
  #stack(..texte.split("\n").enumerate().map(((i, ligne)) => block(
    width: 100%, height: taille * interligne, inset: (x: 3pt), above: 0pt, below: 0pt,
    fill: if (i + 1) in vives { attention.lighten(72%) },
    align(horizon, raw(lang: lang, ligne)),
  )))
]

// Un poste : son nom, le dossier du script, ses fichiers, puis une commande et
// sa sortie. `erreur: true` met le cadre et la sortie en orange.
#let poste(nom, dossier, fichiers, terminal, erreur: false) = {
  let couleur = if erreur { alerte } else { accent }
  block(
    width: 100%, stroke: 1pt + couleur, radius: 3pt, inset: (x: 9pt, y: 6pt),
    breakable: false,
  )[
    #set par(leading: 0.4em)
    #text(size: 14pt, weight: demi-gras, fill: couleur)[#nom]
    #h(0.6em)
    #text(size: 10.5pt, font: police-code, fill: estompe)[#dossier]
    #linebreak()
    #text(size: 10.5pt, font: police-code, fill: estompe)[#fichiers]
    #block(width: 100%, inset: (x: 7pt, y: 5pt), fill: gris, above: 0.35em, below: 0pt)[
      #show raw: set text(size: 11pt, fill: couleur)
      #raw(block: true, terminal)
    ]
  ]
}

// La diapositive d'une version : `donnees`, le contenu du fichier lu, s'il faut
// le montrer ; `lien` nomme ce qui passe du poste d'Alice à l'autre poste ;
// `adapter` donne les opérations d'une autre personne. L'interligne serré laisse
// la place d'une annonce de deux lignes.
#let version-script(code, vives: (), donnees: none, alice, lien, autre, adapter) = {
  grid(
    columns: (1fr, 1fr), column-gutter: 16pt,
    stack(
      spacing: 5pt,
      text(size: 15pt, fill: estompe, weight: demi-gras)[altitudes.py],
      script(code, vives: vives, interligne: 1.25),
      ..if donnees != none {(
        v(3pt),
        text(size: 15pt, fill: estompe, weight: demi-gras)[altitudes.txt],
        script(donnees, lang: none, interligne: 1.25),
      )},
    ),
    stack(
      spacing: 4pt,
      alice,
      align(center, text(size: 13pt, fill: estompe)[#sym.arrow.b #lien]),
      autre,
    ),
  )
  block(
    width: 100%, above: 0.6em, below: 0pt, inset: (x: 12pt, y: 7pt),
    fill: attention.lighten(90%), stroke: (left: 3pt + attention),
  )[
    #set text(size: 14pt)
    #show raw: set text(size: 12.5pt)
    #text(fill: attention, weight: demi-gras)[Pour traiter d'autres données.] #adapter
  ]
}

// ---------------------------------------------------------------------------
// La droite de la barre d'état de VS Code, agrandie, avec la fin de ligne
// encadrée. Même dessin que `zoom-barre-etat` du cours 2 v2. Par défaut, la
// barre de `parcours.txt` (TD 3b), en fins de ligne `\n`.
#let barre-etat-fin-de-ligne(fin: "LF", langage: "Plain Text") = block(
  fill: accent, inset: (x: 12pt, y: 7pt), radius: 2pt,
)[
  #set text(size: 15pt, fill: white)
  Ln 1, Col 1 #h(16pt) Spaces: 4 #h(16pt) UTF-8 #h(16pt)
  #box(stroke: 1.6pt + white, inset: (x: 5pt, y: 3pt), outset: (y: 2pt), radius: 3pt)[#fin]
  #h(16pt) #langage
]

// ---------------------------------------------------------------------------
// Une ligne de code qui crée un chemin, avec un crochet sur chaque partie de la
// chaîne : `.name` au-dessus, `.parent`, `.stem` et `.suffix` dessous. Les
// colonnes ont la largeur mesurée de chaque morceau, et les noms débordent de
// leur colonne sans l'élargir.
#let parties-chemin(avant, dossier, nom, extension, apres, taille: 24pt) = context {
  let morceaux = (avant, dossier, "/", nom, extension, apres)
  let morceau(t) = text(font: police-code, size: taille)[#t]
  let trait = 1.4pt + attention
  let crochet(vers-le-bas) = pad(x: 3pt, block(width: 100%, height: 7pt, stroke: (
    left: trait, right: trait,
    top: if vers-le-bas { trait } else { none },
    bottom: if vers-le-bas { none } else { trait },
  )))
  let nomme(t) = box(width: 0pt, height: 1.1em, place(top + center,
    text(font: police-code, size: 13pt, fill: attention, weight: demi-gras)[#t]))
  grid(
    columns: morceaux.map(t => measure(morceau(t)).width),
    align: center + bottom, row-gutter: 3pt,
    grid.cell(colspan: 3)[], grid.cell(colspan: 2, nomme(".name")), [],
    grid.cell(colspan: 3)[], grid.cell(colspan: 2, crochet(true)), [],
    ..morceaux.map(morceau),
    [], crochet(false), [], crochet(false), crochet(false), [],
    [], nomme(".parent"), [], nomme(".stem"), nomme(".suffix"), [],
  )
}

// ---------------------------------------------------------------------------
// L'explorateur de VS Code, dessiné comme dans le cours 2 v2 : le dossier ouvert,
// en capitales, puis ses fichiers.
#let explorateur-vscode(dossier, fichiers, largeur: 5.6cm) = block(
  width: largeur, fill: gris.lighten(40%), stroke: 0.8pt + accent.lighten(55%),
  inset: (x: 10pt, y: 9pt),
)[
  #stack(
    spacing: 7pt,
    text(size: 10.5pt, weight: demi-gras, fill: estompe)[EXPLORER],
    text(size: 14pt, weight: demi-gras)[⌄ #upper(dossier)],
    ..fichiers.map(f => pad(left: 18pt, text(size: 14pt)[#f])),
  )
]

// ---------------------------------------------------------------------------
// Un fichier CSV en texte, sur fond gris : l'en-tête en gris, et la colonne
// d'indice `colonne`, comptée à partir de 0, en couleur.
#let csv-colonne(texte, colonne, taille: 12pt) = block(
  width: 100%, inset: (x: 10pt, y: 8pt), fill: gris,
)[
  #set text(font: police-code, size: taille)
  #set par(leading: 0.65em)
  #texte.split("\n").enumerate().map(((n, ligne)) => ligne.split(",").enumerate().map(((i, champ)) => {
    if i == colonne { text(fill: attention, weight: "bold", champ) }
    else if n == 0 { text(fill: estompe, champ) }
    else { champ }
  }).join(",")).join(linebreak())
]
