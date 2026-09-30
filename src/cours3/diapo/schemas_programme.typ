// Schémas du cours 3 : l'objectif et les étapes du programme de la recette.
//
// Employés par les diapositives de la partie 1 (`parties/01_programme.typ`)
// et par les illustrations de `recette.ipynb`
// (`notebook/td/3b_recette/illustrations/`), pour ne les dessiner qu'une fois.
//
//     #import "../schemas_programme.typ": schema-objectif, schema-etapes

#import "../../commun/prelude.typ": *
#import "schemas.typ": sortie

// Les deux fichiers d'une recette, et la page produite pour quatre personnes.
#let schema-objectif() = grid(
  columns: (1fr, 1.15fr, auto, 1.35fr),
  column-gutter: 10pt,
  align: top,
  panneau("ingredients.csv")[
    #sortie("ingredient,quantite,unite\nFarine,60,g\nLait,125,ml\nŒufs,1,\nSel,1,g\nBeurre fondu,12,g", taille: 10pt)
  ],
  panneau("recette.md")[
    #sortie("# Crêpes\n\n*10 minutes de préparation,\n1 heure de repos.*\n\n## Ingrédients\n\n## Préparation\n\n1. Mélanger la farine…\n2. Casser les œufs…", taille: 10pt)
  ],
  pad(top: 70pt, text(size: 20pt, fill: accent)[→]),
  fenetre("crepes.html")[
    #set text(size: 11pt)
    #text(size: 15pt, weight: demi-gras)[Crêpes] \
    #emph[10 minutes de préparation, 1 heure de repos.]
    #v(0.2em)
    #text(weight: demi-gras)[Ingrédients pour 4 personnes en SI]
    #table(
      columns: (auto, auto), inset: (x: 5pt, y: 2.5pt), stroke: 0.5pt + gris.darken(20%),
      [Ingrédient], [Quantité],
      [Farine], [240 g], [Lait], [500 ml], [Œufs], [4], [Sel], [4 g], [Beurre fondu], [48 g],
    )
    #v(0.1em)
    #text(weight: demi-gras)[Préparation] \
    1. Mélanger la farine…
  ],
)

// Des fichiers de la recette à la page HTML : `generer`, puis pandoc.
#let schema-etapes() = grid(
  columns: (1fr, auto, 1.1fr, auto, 1fr, auto, 0.8fr),
  column-gutter: 8pt,
  align: top,
  panneau("crepes/")[
    #sortie("ingredients.csv\nFarine,60,g\nLait,125,ml\n…\n\nrecette.md\n# Crêpes\n## Ingrédients\n## Préparation", taille: 10.5pt)
  ],
  pad(top: 58pt, text(size: 20pt, fill: accent)[→]),
  panneau("generer(…)")[
    #sortie("lire_ingredients\nadapter : 4 personnes\ntableau\nreplace sous\n« ## Ingrédients »", taille: 10.5pt)
  ],
  pad(top: 58pt, text(size: 20pt, fill: accent)[→]),
  panneau("travail/crepes.md")[
    #sortie("# Crêpes\n## Ingrédients pour 4 personnes en SI\n| Farine | 240 g |\n| Lait | 500 ml |\n…\n## Préparation", taille: 10.5pt)
  ],
  pad(top: 58pt, text(size: 20pt, fill: accent)[→]),
  panneau("pandoc")[
    #sortie("crepes.html", taille: 10.5pt)
  ],
)
