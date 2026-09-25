// Schéma du cours 3 : changer une valeur dans un notebook.
//
// Même grammaire que `schema-notebook` du cours 1 (`src/cours1/diapo/
// schemas_notebooks.typ`) : le document dessiné, un contour de couleur par
// cellule, une étiquette de la même couleur qui dit ce qu'on en fait. Séparé
// de `schemas.typ` pour la même raison que là-bas : ce fichier ouvre
// `cetz.draw`, dont les noms masqueraient ceux de typst chez qui l'importerait
// en bloc.
//
//     #import "../schemas_notebook.typ": schema-notebook-valeurs

#import "../../commun/prelude.typ": *
#import "@preview/cetz:0.4.2"
#import cetz.draw: *

#let _trait = accent.lighten(45%)

#let _etiquette(x, y, texte, couleur) = {
  content((x, y), anchor: "east", box(
    fill: couleur, inset: (x: 6pt, y: 3pt), radius: 3pt,
    text(size: 11.5pt, fill: white, weight: demi-gras)[#texte],
  ))
}

#let _code(x, y, texte, couleur: encre) = {
  content((x, y), anchor: "west", {
    set smartquote(enabled: false)
    text(size: 10pt, font: police-code, fill: couleur)[#texte]
  })
}

// Une cellule de code : son numéro d'exécution, son fond gris, ses lignes.
#let _cellule(y0, y1, numero, lignes, contour, x0: 0.3, x1: 12.7) = {
  rect((x0, y0), (x1, y1), radius: 0.08, stroke: contour)
  content((x0 + 0.2, y1 - 0.62), anchor: "west",
          text(size: 11pt, font: police-code, fill: estompe)[#numero])
  rect((x0 + 1.05, y0 + 0.15), (x1 - 0.15, y1 - 0.15), stroke: none,
       fill: gris.lighten(45%))
  for (i, ligne) in lignes.enumerate() {
    _code(x0 + 1.2, y1 - 0.62 - i * 0.48, ligne)
  }
}

// Le notebook de la recette : une valeur changée dans une cellule, et les
// cellules qui en dépendent, à relancer dans l'ordre pour obtenir la page.
#let schema-notebook-valeurs(longueur: 0.95cm) = cetz.canvas(length: longueur, {
  set-style(stroke: 0.9pt + _trait)

  // Le document, et la barre qui le nomme.
  rect((0, 0), (13, 9.3), radius: 0.12, stroke: 1.4pt + accent, fill: white)
  rect((0, 8.65), (13, 9.3), radius: (north: 0.12, rest: 0), stroke: none, fill: gris)
  line((0, 8.65), (13, 8.65), stroke: 1pt + accent.lighten(45%))
  content((0.4, 8.97), anchor: "west", text(size: 12pt, font: police-code)[recette.ipynb])

  // La cellule des valeurs, modifiée.
  _cellule(6.4, 8.2, "[5]:", ("NOM = \"pate_pizza\"", "PERSONNES = 6", "UNITES = \"US\""),
           2.2pt + attention)
  _etiquette(12.55, 8.2, "1. modifiée", attention)

  // Les cellules qui utilisent ces valeurs : leur numéro est celui de
  // l'exécution précédente, elles sont à relancer.
  _cellule(4.1, 6.0, "[6]:", ("RECETTE = RECETTES / NOM", "generer(RECETTE / \"ingredients.csv\", …,",
                              "        PERSONNES, UNITES)"), 2.2pt + brun)
  _etiquette(12.55, 6.0, "2. à réexécuter", brun)

  _cellule(2.35, 3.7, "[7]:", ("!pandoc pate_pizza.md -o pate_pizza.html",),
           2.2pt + brun)
  _etiquette(12.55, 3.7, "3. à réexécuter", brun)

  // Le résultat, obtenu seulement après les trois étapes.
  rect((0.3, 0.3), (12.7, 1.95), radius: 0.08,
       stroke: (paint: estompe.lighten(40%), thickness: 1pt, dash: "dashed"))
  content((6.5, 1.12), text(size: 12pt, fill: estompe)[la page : six personnes, unités US])
})
