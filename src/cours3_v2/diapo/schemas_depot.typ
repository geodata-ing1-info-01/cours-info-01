// Le graphe du dépôt du TD 3b, propre au cours 3.
//
// `master` en bas, la branche `seuil` au-dessus une fois que `master` a avancé. Dans le
// dépôt reçu, les trois commits sont sur une ligne, comme dans `git log --graph`. Les
// commits fournis portent les trois premiers caractères de leur identifiant, fixe
// (`data/cours3_v2/make_data.py`) ; ceux de l'élève, dont l'identifiant change d'un poste
// à l'autre, ont une pastille vide. Le commit d'Alice est en bleu.
#import "../../commun/prelude.typ": *
#import "@preview/cetz:0.4.2"

// `etat` : "fourni" (le dépôt reçu), "fusion" (après l'étape 6) ou "final".
#let graphe-depot(etat) = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  let dx = 1.9
  let (bas, haut) = (0, 1.35)
  let r = 0.34
  // (nom, colonne, voie, étiquette, identifiant, parents)
  let commits = (
    ("c1", 0, bas, [TD 2c], "53a", ()),
    ("c2", 1, bas, [TD 3a], "a55", ("c1",)),
    ("a1", 2, if etat == "fourni" { bas } else { haut }, [Alice], "fd6", ("c2",)),
  )
  if etat != "fourni" {
    commits += (
      ("g", 2, bas, [ignorer], none, ("c2",)),
      ("p", 3, bas, [pathlib], none, ("g",)),
      ("f", 4, bas, [argument], none, ("p",)),
      ("m", 5, bas, [fusion], none, ("f", "a1")),
    )
  }
  if etat == "final" {
    commits += (
      ("s", 6, bas, [option], none, ("m",)),
      ("e", 7, bas, [résumé], none, ("s",)),
    )
  }
  let position = (:)
  for c in commits { position.insert(c.at(0), (c.at(1) * dx, c.at(2))) }

  // Les arêtes, de chaque commit vers ses parents. L'arête de la fusion suit la voie de
  // `seuil`, puis descend sur le commit de fusion.
  for c in commits {
    for p in c.at(5) {
      let (xc, yc) = position.at(c.at(0))
      let (xp, yp) = position.at(p)
      let points = if yc == bas and yp == haut { ((xc, yc), (xc - 0.6 * dx, haut), (xp, yp)) } else { ((xc, yc), (xp, yp)) }
      line(..points, stroke: 1.4pt + accent.lighten(30%))
    }
  }
  // Les pastilles et leurs étiquettes : dessous sur `master`, dessus sur `seuil`.
  for (nom, col, voie, etiquette, id, parents) in commits {
    let (x, y) = position.at(nom)
    let alice = nom == "a1"
    let fond = if alice { attention } else if id != none { accent } else { white }
    circle((x, y), radius: r, fill: fond, stroke: 1.2pt + if alice { attention } else { accent })
    if id != none {
      content((x, y), text(size: 9pt, font: police-code, fill: white)[#id])
    }
    let dy = if voie == bas { -0.62 } else { 0.62 }
    content((x, y + dy), {
      show raw: set text(size: 10.5pt)
      text(size: 11.5pt, fill: if alice { attention } else { encre })[#etiquette]
    })
  }

  // Les branches : un cartouche sous le dernier commit de `master`, au-dessus de celui
  // d'Alice.
  let cartouche(position, texte, couleur) = content(position, box(
    inset: (x: 5pt, y: 3pt), radius: 3pt, stroke: 1pt + couleur,
    text(size: 10.5pt, font: police-code, fill: couleur)[#texte],
  ))
  let tete = commits.filter(c => c.at(2) == bas and c.at(0) != "a1").last().at(0)
  let (xt, _) = position.at(tete)
  cartouche((xt, bas - 1.25), [HEAD -> master], accent)
  let (xa, ya) = position.at("a1")
  cartouche((xa, ya + if ya == bas { 0.8 } else { 1.25 }), [seuil], attention)
})
