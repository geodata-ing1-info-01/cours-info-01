// Schémas de la présentation du module (séance 0 v2) : la progression des sept
// séances et le programme repris par les TD. Employés par `cours0_v2.typ` et par
// les figures de la page d'introduction du site, `../notebook/figures/`, que
// `outils/compiler_figures.py` compile en SVG.
#import "../../commun/prelude.typ": *

// Une séance : numéro et titre, puis ce qu'elle présente. Les deux TD
// d'application sont en brun, la couleur des TD.
#let _seance(numero, sujet, contenu, td: false) = block(
  width: 100%, inset: (x: 8pt, y: 5pt), breakable: false,
  fill: if td { brun.lighten(90%) } else { white },
  stroke: 1pt + if td { brun.lighten(35%) } else { accent.lighten(55%) },
)[
  #text(size: 13pt, weight: demi-gras, fill: if td { brun } else { encre })[Séance #numero · #sujet]
  #v(0.2em, weak: true)
  #text(size: 11pt, fill: estompe)[#contenu]
]

// Une étape de la progression : son nom, puis ses séances.
#let _phase(nom, detail, ..seances) = stack(
  dir: ttb, spacing: 5pt,
  block(width: 100%, inset: (x: 8pt, y: 5pt), fill: accent.lighten(88%), stroke: 1pt + accent.lighten(40%))[
    #align(center)[
      #text(size: 17pt, weight: "semibold")[#nom] \
      #text(size: 11.5pt, fill: estompe)[#detail]
    ]
  ],
  ..seances.pos(),
)

#let schema-progression() = grid(
  columns: (1fr, 20pt, 1fr, 20pt, 1fr),
  align: top,
  _phase(
    "Utiliser", "des programmes et des fichiers",
    _seance(1, "Logiciels, fichiers, terminal et premier programme",
      [ordinateur et logiciels ; fichiers et chemins ; ligne de commande ; programme Python et notebook]),
  ),
  fleche,
  _phase(
    "Développer", "un programme, seul puis à plusieurs",
    _seance(2, "Éditeur de code et git local", [VS Code ; versions, branches et fusion avec git]),
    _seance(3, "Fichiers, chemins et programme en ligne de commande",
      [lecture et écriture de fichiers ; chemins et arguments : pathlib, argparse]),
    _seance(4, "Projet d'application 1", [un script écrit pas à pas, un commit par étape], td: true),
  ),
  fleche,
  _phase(
    "Livrer", "un programme à une autre personne",
    _seance(5, "Réutiliser des programmes et des bibliothèques",
      [subprocess et PATH ; bibliothèques, dépendances, environnements]),
    _seance(6, "Forge, mots de passe et secrets", [GitHub : clone, push, pull ; authentification ; secrets]),
    _seance(7, "Projet d'application 2", [une branche fusionnée par une pull request], td: true),
  ),
)

#let schema-programme-td() = {
  show raw: set text(size: 1.2em)
  chaine(
  gabarit: bloc, ecart: 24pt,
  ([`altitudes.py`], [séances 1 à 3 : lancé, versionné, puis rendu portable]),
  ([`stats_trace.py`], [séance 4 : distance parcourue et vitesse moyenne d'une trace GPS]),
  ([`carte_trace.py`], [séance 5 : carte web de la trace, avec ogr2ogr et folium]),
  ([dépôt `td7a-trace`], [séance 7 : une nouvelle option, ajoutée par une pull request]),
  )
}
