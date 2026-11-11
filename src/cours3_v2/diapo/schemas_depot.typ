// Le graphe du dépôt du TD 3b, propre au cours 3.
//
// `master` en bas, la branche `seuil` au-dessus, partie du dernier commit du TD 3a. Dans
// le dépôt reçu, `git log --graph` affiche les quatre commits sur une ligne, car `master`
// n'a pas avancé depuis la création de `seuil` ; le graphe dessine quand même `seuil` sur
// sa voie, pour montrer d'où part la branche (demande du 10/11/2026). Les commits fournis
// portent les trois premiers caractères de leur identifiant, fixe
// (`data/cours3_v2/make_data.py`) ; ceux de l'élève, dont l'identifiant change d'un poste
// à l'autre, ont une pastille vide. Le commit d'Alice est en bleu.
#import "../../commun/prelude.typ": *
#import "@preview/cetz:0.4.2"

// `etat` : "fourni" (le dépôt reçu), "fusion" (après l'étape 6) ou "final".
#let graphe-depot(etat) = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  // Les deux premiers états tiennent dans une colonne de la diapositive ; après la
  // fusion, les étiquettes « pathlib » et « argument » demandent au moins 1,75 cm.
  let dx = (fourni: 1.6, fusion: 1.75, final: 1.9).at(etat)
  let (bas, haut) = (0, 1.35)
  let r = 0.34
  // (nom, colonne, voie, étiquette, identifiant, parents)
  let commits = (
    ("c1", 0, bas, [TD 2c], "53a", ()),
    ("c2", 1, bas, [TD 3a\ `.txt`], "189", ("c1",)),
    ("c3", 2, bas, [TD 3a\ `.csv`], "efe", ("c2",)),
    ("a1", 3, haut, [Alice], "5d4", ("c3",)),
  )
  if etat != "fourni" {
    commits += (
      ("g", 3, bas, [ignorer], none, ("c3",)),
      ("p", 4, bas, [pathlib], none, ("g",)),
      ("f", 5, bas, [argument], none, ("p",)),
      ("m", 6, bas, [fusion], none, ("f", "a1")),
    )
  }
  if etat == "final" {
    commits += (
      ("s", 7, bas, [option], none, ("m",)),
      ("e", 8, bas, [résumé], none, ("s",)),
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
    // Ancrée par son bord, l'étiquette peut avoir deux lignes sans toucher la pastille.
    let (dy, ancre) = if voie == bas { (-(r + 0.1), "north") } else { (r + 0.1, "south") }
    content((x, y + dy), anchor: ancre, align(center, {
      show raw: set text(size: 10.5pt)
      text(size: 11.5pt, fill: if alice { attention } else { encre })[#etiquette]
    }))
  }

  // Les branches : un cartouche sous le dernier commit de `master`, au-dessus de celui
  // d'Alice.
  let cartouche(position, texte, couleur) = content(position, box(
    inset: (x: 5pt, y: 3pt), radius: 3pt, stroke: 1pt + couleur,
    text(size: 10.5pt, font: police-code, fill: couleur)[#texte],
  ))
  let tete = commits.filter(c => c.at(2) == bas and c.at(0) != "a1").last().at(0)
  let (xt, _) = position.at(tete)
  // Dans le dépôt reçu, la tête est le commit du TD 3a, dont l'étiquette a deux lignes.
  cartouche((xt, bas - if etat == "fourni" { 1.75 } else { 1.25 }), [HEAD -> master], accent)
  let (xa, ya) = position.at("a1")
  cartouche((xa, ya + 1.25), [seuil], attention)
})
