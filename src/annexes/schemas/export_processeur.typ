// Exporte en SVG, pour la page « Le processeur et la carte graphique », cinq schémas
// du cours 5 de 2026. Compilation, depuis la racine du dépôt :
//
//     typst compile --root . src/annexes/schemas/export_processeur.typ "src/annexes/schemas/processeur_{n}.svg" --format svg
//
// Une page par schéma, dans l'ordre de `schemas` ci-dessous : `processeur_1.svg` à
// `processeur_5.svg`. Les SVG produits sont versionnés ; ce fichier sert à les refaire
// quand le dessin change dans le cours 5.
#import "../../commun/prelude.typ": *
#import "../../cours5/diapo/schemas.typ": schema-processeur, schema-puces-image, schema-operations

#set page(width: largeur-diapo - 2 * marge-x + 16pt, height: auto, margin: 8pt, fill: white)
#set text(font: police-texte, size: pt-normalsize, fill: encre, lang: "fr")
#set par(justify: false, leading: 0.65em)
#show strong: set text(weight: demi-gras)
#show raw: set text(font: police-code)

#let schemas = (
  () => schema-processeur(2),
  () => schema-processeur(3),
  () => schema-processeur(4),
  () => align(center, schema-puces-image()),
  () => schema-operations(),
)
#for s in schemas {
  s()
  pagebreak(weak: true)
}
