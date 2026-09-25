// Schéma du cours 3 : l'objet fichier et sa position de lecture.
//
// Séparé de `schemas.typ` pour la même raison que `schemas_notebook.typ` :
// ce fichier ouvre `cetz.draw`, dont les noms masqueraient ceux de typst
// chez qui l'importerait en bloc.
//
//     #import "../schemas_fichiers.typ": schema-position-lecture

#import "../../commun/prelude.typ": *
#import "@preview/cetz:0.4.2"
#import cetz.draw: *

// Le début de `recette.md`, un caractère par case ; `⏎` note le retour à la
// ligne, `…` la suite du fichier.
#let _caracteres = ("#", " ", "C", "r", "ê", "p", "e", "s", "⏎", "⏎", "*", "1", "0", "…")
#let _case = 0.62

#let _code(x, y, texte) = content((x, y), anchor: "west", {
  set smartquote(enabled: false)
  text(size: 12pt, font: police-code)[#texte]
})

#let _note(x, y, corps) = content((x, y), anchor: "west",
  text(size: 12pt, fill: estompe)[#corps])

// Une rangée : le contenu du fichier, et la position de lecture sous la case
// `position` (0 : avant le premier caractère ; `none` : fichier fermé).
#let _rangee(x0, y, position, ferme: false) = {
  for (i, c) in _caracteres.enumerate() {
    let x = x0 + i * _case
    rect((x, y), (x + _case, y + 0.62),
         stroke: 0.7pt + if ferme { gris.darken(10%) } else { accent.lighten(40%) },
         fill: if ferme { gris.lighten(30%) } else { white })
    content((x + _case / 2, y + 0.31),
            text(size: 12pt, font: police-code,
                 fill: if ferme { estompe.lighten(30%) } else { encre })[#c])
  }
  if position != none {
    let x = x0 + position * _case
    line((x, y - 0.05), (x, y + 0.67), stroke: 2.4pt + attention)
    content((x, y - 0.3), text(size: 10.5pt, fill: attention, weight: demi-gras)[position])
  }
}

#let schema-position-lecture() = cetz.canvas(length: 1cm, {
  let xr = 9.6                                   // début des cases
  let fin = _caracteres.len()
  let xn = xr + fin * _case + 0.4                // début des notes

  _code(0, 5.0, "f = open(chemin, encoding=\"utf-8\")")
  _rangee(xr, 4.7, 0)
  _note(xn, 5.0)[un objet fichier ; rien n'est lu]

  _code(0, 3.4, "texte = f.read()")
  _rangee(xr, 3.1, fin)
  _note(xn, 3.4)[tout le texte, en une chaîne]

  _code(0, 1.8, "f.read()")
  _rangee(xr, 1.5, fin)
  _note(xn, 1.8)[`''` : plus rien à lire]

  _code(0, 0.2, "f.close()")
  _rangee(xr, -0.1, none, ferme: true)
  _note(xn, 0.2)[fermé : `f.read()` lève `ValueError`]
})
