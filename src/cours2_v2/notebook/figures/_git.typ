// Dessins communs aux schémas git de la page de cours, repris de
// `diapo/parties/04_git.typ` (mêmes commits, mêmes identifiants, ceux du
// rejeu du TD 2d).
#import "../../../commun/prelude.typ": *
#import "../../../commun/schemas_git.typ": *

// Un historique de trois commits, en petit, pour les schémas de dépôts.
#let historique = graphe-git(
  commits: (
    (nom: "c1", col: 0, voie: 0),
    (nom: "c2", col: 1, voie: 0, parents: ("c1",)),
    (nom: "c3", col: 2, voie: 0, parents: ("c2",)),
  ),
  echelle: 0.85, ecart-x: 1.2, taille-etiquette: 9pt,
)

// La dernière version seule, sans son historique.
#let une-version = graphe-git(
  commits: ((nom: "c3", col: 0, voie: 0),),
  echelle: 0.85, taille-etiquette: 9pt,
)

// Une machine ou un support, et ce qu'il contient.
#let machine(nom, corps, plein: false) = block(
  inset: (x: 9pt, y: 6pt), radius: 3pt,
  fill: if plein { accent.lighten(90%) } else { white },
  stroke: 1pt + accent.lighten(55%),
)[
  #align(center)[
    #text(size: 13pt, weight: demi-gras)[#nom]
    #v(0.15em, weak: true)
    #corps
  ]
]

#let double-fleche(vertical: false) = align(center + horizon, text(
  size: 22pt, fill: accent,
  if vertical { sym.arrow.t.b } else { sym.arrow.l.r },
))

// Un cartouche de branche dessiné à la main, pour une branche qui désigne
// le même commit qu'une autre.
#let cartouche(d, p, nom, couleur, dy: -1.06) = d.content(
  (p.at(0), p.at(1) + dy),
  box(fill: couleur, inset: (x: 6pt, y: 3.5pt), radius: 4pt,
    text(size: 11pt, weight: demi-gras, fill: white)[#nom]),
)

// Le graphe de l'étape 5 : `28c`, puis `220` sur master et `939` sur
// sans-gluten.
#let variante(tete: none, echelle: 1.15) = graphe-git(
  commits: (
    (nom: "c3", col: 0, voie: 0, id: "28c"),
    (nom: "c5", col: 1, voie: 0, id: "220", parents: ("c3",)),
    (nom: "c4", col: 1, voie: 1, id: "939", parents: ("c3",)),
  ),
  branches: (
    (nom: "master", voie: 0, commit: "c5"),
    (nom: "sans-gluten", voie: 1, commit: "c4"),
  ),
  echelle: echelle,
  taille-etiquette: 10pt,
  extra: if tete == none { none } else {
    (pos, d) => marque-tete(d, pos(tete), dx: 0.9, dy: if tete == "c5" { 0.75 } else { -0.75 })
  },
)
