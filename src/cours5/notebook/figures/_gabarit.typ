// Gabarit des schémas de la page de cours : un schéma de diapositive, seul
// sur une page à sa taille. La largeur est celle de la zone de texte d'une
// diapositive, et le texte a les réglages de `diapos` (commun/theme.typ) : le
// schéma se dessine comme en séance.
//
//     #import "_gabarit.typ": *
//     #show: schema-de-cours
//
// Un petit schéma, qui ne dépend pas de la largeur disponible, prend
// `#show: schema-de-cours.with(largeur: auto)` : la page se réduit à lui.
//
// `outils/compiler_figures.py` compile chaque `<nom>.typ` de ce dossier en
// `<nom>.svg`, que la page affiche.
#import "../../../commun/prelude.typ": *

#let schema-de-cours(corps, largeur: largeur-diapo - 2 * marge-x + 16pt) = {
  set page(width: largeur, height: auto, margin: 8pt, fill: white)
  set text(font: police-texte, size: pt-normalsize, fill: encre, lang: "fr")
  set par(justify: false, leading: 0.65em)
  show strong: set text(weight: demi-gras)
  show raw: set text(font: police-code, size: 0.78em)
  corps
}
