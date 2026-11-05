// Les segments d'une trace GPS, pour le TD 4a du cours 4 v2.
//
// Les cinq premières positions de `data/cours4_v2/4a_trace/depart/trace.csv`,
// en mètres à partir de la première, à l'échelle. Le triangle du premier
// segment porte les deux écarts de la formule de `distance_entre`. Les longueurs
// sont calculées ici, et redonnent les cumuls de la sortie du programme :
// 36.2, 73.2, 108.5, 142.0.
#import "../../commun/prelude.typ": *

#let _positions = (
  (673120.5, 6860840.2),
  (673152.9, 6860856.3),
  (673186.9, 6860870.9),
  (673222.0, 6860866.8),
  (673255.5, 6860865.7),
)

#let schema-segments(echelle: 4.2pt, taille: 14pt) = {
  let origine = _positions.at(0)
  let hauteur-trace = 31 * echelle
  let marge = (gauche: 66pt, haut: 30pt, bas: 26pt, droite: 34pt)
  // Le point (x, y) de la trace, en coordonnées de la figure : y vers le bas.
  let ecran(p) = (
    marge.gauche + (p.at(0) - origine.at(0)) * echelle,
    marge.haut + hauteur-trace - (p.at(1) - origine.at(1)) * echelle,
  )
  // Une étiquette centrée sur (x, y), ou qui commence à x. Mesurée, elle ne se coupe pas.
  let etiquette(x, y, corps, depuis-gauche: false) = context {
    let contenu = text(size: taille, corps)
    let m = measure(contenu)
    place(top + left, dx: if depuis-gauche { x } else { x - m.width / 2 }, dy: y - m.height / 2, contenu)
  }
  let longueur(a, b) = calc.sqrt(calc.pow(b.at(0) - a.at(0), 2) + calc.pow(b.at(1) - a.at(1), 2))

  let p0 = ecran(_positions.at(0))
  let p1 = ecran(_positions.at(1))
  let angle = (p1.at(0), p0.at(1))
  let dx = _positions.at(1).at(0) - _positions.at(0).at(0)
  let dy = _positions.at(1).at(1) - _positions.at(0).at(1)
  let pointille = (paint: estompe, thickness: 0.9pt, dash: "dashed")
  // Décalage de chaque étiquette de position par rapport à son point
  let decalages = ((-40pt, 0pt), (-8pt, -16pt), (20pt, 17pt), (0pt, 17pt), (0pt, 17pt))
  let longueurs = range(4).map(i => longueur(_positions.at(i), _positions.at(i + 1)))
  let chiffre(v) = str(calc.round(v, digits: 1)) + if calc.fract(calc.round(v, digits: 1)) == 0 { ".0" } else { "" }

  align(center, stack(
    spacing: 4pt,
    box(
      width: marge.gauche + 135 * echelle + marge.droite,
      height: marge.haut + hauteur-trace + marge.bas,
      {
        // Le triangle du premier segment
        place(top + left, line(start: p0, end: angle, stroke: pointille))
        place(top + left, line(start: angle, end: p1, stroke: pointille))
        etiquette(p0.at(0) + dx * echelle / 2, p0.at(1) + 13pt, text(fill: estompe)[x2 − x1 = #chiffre(dx)])
        etiquette(angle.at(0) + 7pt, p0.at(1) - dy * echelle / 2, text(fill: estompe)[y2 − y1 = #chiffre(dy)], depuis-gauche: true)

        // Les segments, et leur longueur au-dessus
        for i in range(4) {
          let a = ecran(_positions.at(i))
          let b = ecran(_positions.at(i + 1))
          place(top + left, line(start: a, end: b, stroke: 2pt + accent))
          let decalage = if i == 0 { (-30pt, -8pt) } else if i == 1 { (-10pt, -14pt) } else { (0pt, -14pt) }
          etiquette(
            (a.at(0) + b.at(0)) / 2 + decalage.at(0), (a.at(1) + b.at(1)) / 2 + decalage.at(1),
            text(weight: demi-gras, fill: accent)[#chiffre(longueurs.at(i)) m],
          )
        }

        // Les positions, numérotées
        for (i, p) in _positions.enumerate() {
          let e = ecran(p)
          place(top + left, dx: e.at(0) - 4pt, dy: e.at(1) - 4pt, circle(radius: 4pt, fill: accent))
          etiquette(e.at(0) + decalages.at(i).at(0), e.at(1) + decalages.at(i).at(1), [position #i])
        }
      },
    ),
    text(size: taille)[Sur ces quatre segments : #longueurs.map(chiffre).join(" + ") = #chiffre(longueurs.sum()) m],
  ))
}
