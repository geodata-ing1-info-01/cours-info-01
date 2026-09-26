// Gabarit des illustrations des notebooks du cours 3 : un schéma de
// diapositive, seul sur une page à sa taille, sur fond blanc. Le texte a les
// réglages de `diapos` (commun/theme.typ) : le schéma se dessine comme en
// séance. Même principe que `src/cours1/notebook/figures/_gabarit.typ`.
//
//     #import "../../_illustration.typ": *
//     #show: illustration                    // largeur de la zone de texte d'une diapositive
//     #show: illustration.with(largeur: auto) // la page se réduit au schéma
//
// `outils/construire_notebooks.py` compile chaque
// `<td>/illustrations/<nom>.typ` en `data/cours3/<td>/produit/illustrations/<nom>.png`.
#import "../../../commun/prelude.typ": *

#let illustration(corps, largeur: largeur-diapo - 2 * marge-x + 16pt) = {
  set page(width: largeur, height: auto, margin: 10pt, fill: white)
  set text(font: police-texte, size: pt-normalsize, fill: encre, lang: "fr")
  set par(justify: false, leading: 0.65em)
  show strong: set text(weight: demi-gras)
  show raw: set text(font: police-code, size: 0.78em)
  corps
}
