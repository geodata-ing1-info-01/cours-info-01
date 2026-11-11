// « Programmation littérale » (diapo/parties/03_notebook.typ) : la capture de JupyterLab
// et ses six étiquettes, aux positions de la diapositive. `x` et `y` sont en pixels de
// l'image (1400 × 535), convertis à la largeur affichée.
#import "_gabarit.typ": *
#show: schema-de-cours.with(largeur: auto)

#let _largeur-capture = 670pt
#let _etiquette-capture(x, y, corps) = place(
  top + left, dx: x * _largeur-capture / 1400, dy: y * _largeur-capture / 1400,
  box(fill: attention, inset: (x: 5pt, y: 3pt), radius: 3pt,
      text(size: 13pt, fill: white, weight: demi-gras)[#corps]),
)

#box(stroke: 1pt + accent.lighten(55%), {
  image("/illustrations/cours1/notebook_jupyterlab.png", width: _largeur-capture)
  _etiquette-capture(700, 120)[← du texte, écrit en Markdown]
  _etiquette-capture(720, 60)[le noyau, qui exécute le code →]
  _etiquette-capture(40, 238)[ordre d'exécution →]
  _etiquette-capture(930, 320)[← une cellule de code]
  _etiquette-capture(640, 398)[← sa sortie, gardée dans le fichier]
  _etiquette-capture(925, 444)[← du texte qui commente le résultat]
})
