// Les segments d'une trace GPS, pour le TD 4a du cours 4 v2.
//
// Les cinq premières positions de `data/cours4_v2/4a_trace/depart/trace.csv`,
// en mètres, à l'échelle. Le triangle du premier segment porte les deux écarts de la
// formule de `distance_entre`. Les longueurs sont calculées ici, et redonnent les
// cumuls de la sortie du programme : 18.8, 63.4, 105.6, 140.9.
#import "../../commun/prelude.typ": *

#let _positions = (
  (670307.7, 6812407.3),
  (670295.1, 6812393.4),
  (670319.7, 6812356.2),
  (670340.2, 6812319.3),
  (670355.6, 6812287.5),
)

#let schema-segments(echelle: 1.45pt, taille: 14pt) = {
  let xs = _positions.map(p => p.at(0))
  let ys = _positions.map(p => p.at(1))
  let marge = (gauche: 150pt, haut: 16pt, bas: 12pt, droite: 90pt)
  // Le point (x, y) de la trace, en coordonnées de la figure : y vers le bas.
  let ecran(p) = (
    marge.gauche + (p.at(0) - calc.min(..xs)) * echelle,
    marge.haut + (calc.max(..ys) - p.at(1)) * echelle,
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
  let decalages = ((42pt, -3pt), (-42pt, 4pt), (-42pt, 0pt), (-42pt, 0pt), (-42pt, 0pt))
  let longueurs = range(4).map(i => longueur(_positions.at(i), _positions.at(i + 1)))
  let chiffre(v) = str(calc.round(v, digits: 1)) + if calc.fract(calc.round(v, digits: 1)) == 0 { ".0" } else { "" }

  align(center, stack(
    spacing: 4pt,
    box(
      width: marge.gauche + (calc.max(..xs) - calc.min(..xs)) * echelle + marge.droite,
      height: marge.haut + (calc.max(..ys) - calc.min(..ys)) * echelle + marge.bas,
      {
        // Le triangle du premier segment
        place(top + left, line(start: p0, end: angle, stroke: pointille))
        place(top + left, line(start: angle, end: p1, stroke: pointille))
        etiquette(angle.at(0) - 66pt, p0.at(1) - 8pt, text(fill: estompe)[x2 − x1 = #chiffre(dx)])
        etiquette(angle.at(0) - 66pt, p0.at(1) + 9pt, text(fill: estompe)[y2 − y1 = #chiffre(dy)])

        // Les segments, et leur longueur au-dessus
        for i in range(4) {
          let a = ecran(_positions.at(i))
          let b = ecran(_positions.at(i + 1))
          place(top + left, line(start: a, end: b, stroke: 2pt + accent))
          let decalage = (34pt, 0pt)
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
