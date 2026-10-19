// Schémas dessinés du cours 5.
//
// S'importe depuis une partie, en plus du prélude, et nommément :
//
//     #import "../schemas.typ": schema-composants, pyramide-memoire
//
// Pas de `: *` : ce fichier ouvre `cetz.draw`, dont les noms (`grid`, `line`,
// `circle`, `content`, `rect`…) masqueraient ceux de typst chez qui
// l'importerait en bloc. Dans ce fichier même, les primitives de typst qui
// portent un nom de cetz s'écrivent `std.rect`, `std.line`, `std.rotate`.
//
// Les couleurs sont celles du thème : `accent` la structure, `estompe` le
// secondaire, `gris` les remplissages, `brun` ce qui est secret ou privé,
// `attention` ce qui est public ou distribué, `alerte` ce qui est à éviter.

#import "../../commun/prelude.typ": *
#import "@preview/cetz:0.4.2"
#import cetz.draw: *

#let _trait = accent.lighten(45%)

// Étiquette sous un élément dessiné : le nom, puis son rôle en petit.
#let _etiquette(pos, nom, role, largeur: 4.2cm, anchor: "north") = content(
  pos, anchor: anchor, box(width: largeur)[
    #align(center)[
      #text(size: 16pt, weight: demi-gras, fill: accent)[#nom]
      #if role != none [
        #v(0.1em)
        #text(size: 13pt, fill: estompe)[#role]
      ]
    ]
  ],
)

// Flèche du thème : trait `accent`, pointe pleine.
#let _fleche(a, b, couleur: accent, epaisseur: 1.4pt, ..args) = line(
  a, b, stroke: epaisseur + couleur,
  mark: (end: ">", fill: couleur, scale: 1.2), ..args,
)

// Un numéro dans un cercle, posé sur un schéma ou sur une photo.
#let repere(n, taille: 21pt) = box(
  width: taille, height: taille,
  fill: white, stroke: 1.6pt + accent, radius: taille / 2,
  std.align(center + horizon, text(size: 12.5pt, weight: demi-gras, fill: accent)[#n]),
)

// ---------------------------------------------------------------------------
// Les composants d'un ordinateur
//
// Le boîtier, avec les six composants dont la séance parle, et à l'extérieur
// ce que l'utilisateur touche. Chaque composant porte son nom et son rôle.

#let _processeur(x, y) = {
  let c = 1.5
  rect((x - c / 2, y - c / 2), (x + c / 2, y + c / 2), radius: 0.06,
       fill: gris, stroke: 1.4pt + accent, name: "cpu")
  rect((x - c * 0.28, y - c * 0.28), (x + c * 0.28, y + c * 0.28),
       fill: accent, stroke: none)
  for i in range(4) {
    let d = (i - 1.5) * c * 0.22
    line((x + d, y + c / 2), (x + d, y + c / 2 + 0.2), stroke: 1.2pt + accent)
    line((x + d, y - c / 2), (x + d, y - c / 2 - 0.2), stroke: 1.2pt + accent)
    line((x + c / 2, y + d), (x + c / 2 + 0.2, y + d), stroke: 1.2pt + accent)
    line((x - c / 2, y + d), (x - c / 2 - 0.2, y + d), stroke: 1.2pt + accent)
  }
}

#let _memoire(x, y) = {
  for i in range(2) {
    let x0 = x - 0.55 + i * 0.7
    rect((x0, y - 1.1), (x0 + 0.4, y + 1.1), fill: gris, stroke: 1.2pt + accent)
    for k in range(6) {
      rect((x0 + 0.08, y - 0.95 + k * 0.34), (x0 + 0.32, y - 0.75 + k * 0.34),
           fill: accent.lighten(30%), stroke: none)
    }
  }
}

#let _disque(x, y) = {
  rect((x - 1.1, y - 0.7), (x + 1.1, y + 0.7), radius: 0.08, fill: gris,
       stroke: 1.2pt + accent)
  rect((x - 0.9, y - 0.5), (x + 0.9, y + 0.5), stroke: 0.8pt + _trait)
  for k in range(3) {
    rect((x - 0.7 + k * 0.55, y - 0.3), (x - 0.3 + k * 0.55, y + 0.3),
         fill: accent.lighten(30%), stroke: none)
  }
}

#let _carte-graphique(x, y) = {
  rect((x - 1.6, y - 0.75), (x + 1.6, y + 0.75), radius: 0.08, fill: gris,
       stroke: 1.2pt + accent)
  for i in range(2) {
    let cx = x - 0.75 + i * 1.5
    circle((cx, y), radius: 0.55, fill: white, stroke: 1pt + accent)
    for k in range(6) {
      line((cx, y), (rel: (0.5 * calc.cos(k * 60deg), 0.5 * calc.sin(k * 60deg))),
           stroke: 0.9pt + _trait)
    }
    circle((cx, y), radius: 0.12, fill: accent, stroke: none)
  }
}

#let _carte-reseau(x, y) = {
  rect((x - 0.9, y - 0.45), (x + 0.9, y + 0.45), radius: 0.06, fill: gris,
       stroke: 1.2pt + accent)
  rect((x + 0.3, y - 0.3), (x + 0.75, y + 0.3), fill: white, stroke: 1pt + accent)
  for k in range(4) {
    line((x + 0.38 + k * 0.09, y - 0.3), (x + 0.38 + k * 0.09, y - 0.12),
         stroke: 0.8pt + accent)
  }
}

#let _alimentation(x, y) = {
  rect((x - 1.0, y - 0.7), (x + 1.0, y + 0.7), radius: 0.08, fill: gris,
       stroke: 1.2pt + accent)
  circle((x - 0.3, y), radius: 0.5, fill: white, stroke: 1pt + accent)
  for k in range(6) {
    line((x - 0.3, y), (rel: (0.45 * calc.cos(k * 60deg), 0.45 * calc.sin(k * 60deg))),
         stroke: 0.9pt + _trait)
  }
  circle((x - 0.3, y), radius: 0.1, fill: accent, stroke: none)
  // la prise secteur
  rect((x + 0.4, y - 0.3), (x + 0.8, y + 0.3), fill: white, stroke: 1pt + accent)
  for d in (-0.12, 0.12) {
    circle((x + 0.6, y + d), radius: 0.05, fill: accent, stroke: none)
  }
}

#let _ecran(x, y) = {
  rect((x - 1.4, y - 0.1), (x + 1.4, y + 1.7), radius: 0.08, fill: white,
       stroke: 1.4pt + accent, name: "ecran")
  rect((x - 1.25, y + 0.05), (x + 1.25, y + 1.55), fill: gris.lighten(45%),
       stroke: none)
  line((x - 0.5, y - 0.55), (x + 0.5, y - 0.55), stroke: 1.4pt + accent)
  line((x, y - 0.55), (x, y - 0.1), stroke: 1.4pt + accent)
}

#let _clavier(x, y) = {
  rect((x - 1.5, y - 0.45), (x + 1.5, y + 0.45), radius: 0.08, fill: white,
       stroke: 1.4pt + accent, name: "clavier")
  for r in range(2) {
    for k in range(9) {
      rect((x - 1.32 + k * 0.31, y - 0.3 + r * 0.38),
           (x - 1.1 + k * 0.31, y - 0.08 + r * 0.38),
           fill: gris, stroke: none)
    }
  }
}

// Avec `dessous: true`, le boîtier est resserré et l'écran et le clavier
// passent dessous : le schéma laisse la droite de la diapositive à la photo
// du boîtier ouvert. Avec `numeros: true`, chaque composant porte le numéro
// du repère qui le désigne sur cette photo.

#let schema-composants(dessous: false, numeros: false) = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + _trait)

  // le boîtier
  let (y-bas, y-haut) = if dessous { (-0.2, 9.6) } else { (-0.7, 10.2) }
  rect((0, y-bas), (16.6, y-haut), radius: 0.15, stroke: 1.6pt + accent, name: "boitier")
  content((0.35, y-haut - 0.3), anchor: "north-west",
          text(size: 13pt, fill: estompe)[#petites-capitales("le boîtier")])

  if numeros {
    for (n, pos) in ((1.7, 8.4), (7.2, 8.4), (11.7, 8.45),
                     (1.15, 3.85), (7.4, 3.65), (11.85, 3.85)).enumerate() {
      content(pos, repere(n + 1))
    }
  }

  // les six composants, sur deux rangées
  _processeur(3.2, 7.6)
  _etiquette((3.2, 6.3), "Processeur", "exécution des instructions", largeur: 4.8cm)

  _memoire(8.3, 7.6)
  _etiquette((8.3, 6.3), "Mémoire vive", "stockage temporaire des données", largeur: 4.8cm)

  _disque(13.4, 7.6)
  _etiquette((13.4, 6.3), "Disque", "stockage pérenne des données", largeur: 4.8cm)

  // la flèche dit l'évolution de la carte graphique, de l'affichage vers
  // le calcul
  _carte-graphique(3.3, 3.0)
  _etiquette((3.3, 2.1), "Carte graphique",
             [calcul de l'image affichée \ #sym.arrow.r calcul parallèle],
             largeur: 6.2cm)

  _carte-reseau(8.9, 3.0)
  _etiquette((8.9, 2.1), "Carte réseau", "connexion au réseau : câble, Wi-Fi", largeur: 4.4cm)

  _alimentation(13.4, 3.0)
  _etiquette((13.4, 2.1), "Alimentation", "conversion du 230 V", largeur: 4.4cm)

  // ce que l'utilisateur touche
  if dessous {
    _ecran(4.0, -2.6)
    content((5.8, -1.9), anchor: "west",
            text(size: 16pt, weight: demi-gras, fill: accent)[Écran])
    _clavier(11.0, -2.0)
    content((12.8, -2.0), anchor: "west",
            text(size: 16pt, weight: demi-gras, fill: accent)[Clavier, souris])
    line((4.0, y-bas), (4.0, -0.9))
    line((11.0, y-bas), (11.0, -1.55))
  } else {
    _ecran(21.0, 6.4)
    _etiquette((21.0, 5.5), "Écran", none)
    _clavier(21.0, 2.6)
    _etiquette((21.0, 1.9), "Clavier, souris", none)

    line("boitier.east", (rel: (0.9, 0), to: "boitier.east"),
         (rel: (0.9, 0), to: ("boitier.east", "|-", (0, 6.4))), (19.6, 6.4))
    line((rel: (0.9, 0), to: "boitier.east"),
         (rel: (0.9, 0), to: ("boitier.east", "|-", (0, 2.6))), (19.5, 2.6))
  }
})

// ---------------------------------------------------------------------------
// Le processeur : des cœurs, une file d'instructions chacun
//
// Quatre cœurs côte à côte. Chaque cœur reçoit une suite d'instructions et
// les exécute une par une, au rythme de la cadence.

#let schema-coeurs(n: 4) = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + _trait)
  let l = 4.2
  let ecart = 1.2
  let instructions = ("lire a", "lire b", "a + b", "comparer", "sauter", "écrire")
  for i in range(n) {
    let x0 = i * (l + ecart)
    // la file d'instructions, au-dessus du cœur
    for (k, ins) in instructions.enumerate() {
      let y = 6.3 - k * 0.62
      rect((x0 + 0.9, y - 0.25), (x0 + l - 0.9, y + 0.25), radius: 0.05,
           fill: if k == instructions.len() - 1 { accent.lighten(80%) } else { white })
      content((x0 + l / 2, y), text(size: 11pt, font: police-code, fill: accent)[#ins])
    }
    _fleche((x0 + l / 2, 2.55), (x0 + l / 2, 1.95), couleur: accent)
    // le cœur
    rect((x0, 0), (x0 + l, 1.8), radius: 0.08, fill: gris, stroke: 1.4pt + accent)
    content((x0 + l / 2, 0.9), text(size: 16pt, weight: demi-gras, fill: accent)[
      cœur #(i + 1)
    ])
  }
  content((n * (l + ecart) - ecart, 6.75), anchor: "south-east",
          text(size: 13pt, fill: estompe)[instructions du programme, dans l'ordre])
})

// ---------------------------------------------------------------------------
// Processeur et carte graphique : la surface de la puce
//
// D'après la figure 1 du CUDA C++ Programming Guide de NVIDIA : deux puces de
// même taille, l'une surtout faite de contrôle et de cache, l'autre surtout
// d'unités de calcul. Trois couleurs, reprises par la légende : le calcul en
// `accent`, le contrôle en `accent` éclairci, le cache en `gris`.

#let _c-calcul = accent
#let _c-controle = accent.lighten(62%)
#let _c-cache = gris.darken(4%)

#let _pave(a, b, couleur) = rect(a, b, fill: couleur, stroke: none)

// Les deux puces se dessinent à partir de leur coin inférieur gauche (x, y),
// à l'échelle `u` : 10,4 u de large, 6 u de haut, titre compris au-dessus.
#let _puce-processeur(x, y, u, titre, taille-titre: 15pt, taille-cache: 13pt) = {
  rect((x, y), (x + 10.4 * u, y + 6 * u), radius: 0.1 * u, stroke: 1.4pt + accent)
  // huit cœurs sur deux rangées, puis le cache partagé
  for r in range(2) {
    for i in range(4) {
      let x0 = x + (0.2 + i * 2.567) * u
      let y0 = y + (4.5 - r * 1.6) * u
      rect((x0, y0), (x0 + 2.3 * u, y0 + 1.4 * u), stroke: 0.6pt + _trait)
      _pave((x0 + 0.1 * u, y0 + 0.36 * u), (x0 + 1.3 * u, y0 + 1.3 * u), _c-controle)
      for (dx, dy) in ((0, 0), (0.42, 0), (0, 0.49), (0.42, 0.49)) {
        _pave((x0 + (1.4 + dx) * u, y0 + (0.36 + dy) * u),
              (x0 + (1.76 + dx) * u, y0 + (0.81 + dy) * u), _c-calcul)
      }
      _pave((x0 + 0.1 * u, y0 + 0.08 * u), (x0 + 2.2 * u, y0 + 0.28 * u), _c-cache)
    }
  }
  _pave((x + 0.2 * u, y + 0.2 * u), (x + 10.2 * u, y + 2.7 * u), _c-cache)
  content((x + 5.2 * u, y + 1.45 * u), text(size: taille-cache, fill: accent)[cache partagé])
  content((x, y + 6.25 * u), anchor: "south-west",
          text(size: taille-titre, weight: demi-gras, fill: estompe, bottom-edge: "baseline", titre))
}

// des rangées d'unités de calcul, un contrôle et un petit cache par rangée
#let _puce-carte(x, y, u, titre, taille-titre: 15pt, taille-cache: 11pt) = {
  rect((x, y), (x + 10.4 * u, y + 6 * u), radius: 0.1 * u, stroke: 1.4pt + accent)
  for r in range(10) {
    let yh = y + (5.8 - r * 0.5) * u
    let yb = yh - 0.42 * u
    _pave((x + 0.2 * u, yb), (x + 0.6 * u, yh), _c-controle)
    _pave((x + 0.65 * u, yb), (x + 0.95 * u, yh), _c-cache)
    for k in range(22) {
      let xa = x + (1.05 + k * 0.4) * u
      _pave((xa, yb), (xa + 0.34 * u, yh), _c-calcul)
    }
  }
  _pave((x + 0.2 * u, y + 0.2 * u), (x + 10.2 * u, y + 0.8 * u), _c-cache)
  content((x + 5.2 * u, y + 0.5 * u), text(size: taille-cache, fill: accent)[cache])
  content((x, y + 6.25 * u), anchor: "south-west",
          text(size: taille-titre, weight: demi-gras, fill: estompe, bottom-edge: "baseline", titre))
}

#let _entrees-puces = (
  (_c-calcul, [calcul]),
  (_c-controle, [contrôle des instructions]),
  (_c-cache, [cache : mémoire rapide]),
)

#let schema-puces() = cetz.canvas(length: 0.82cm, {
  _puce-processeur(0, 1.2, 1, [Processeur : 8 cœurs])
  _puce-carte(12.6, 1.2, 1, [Carte graphique : des milliers d'unités])

  // la légende
  let xs = (3.5, 7.5, 16.0)
  for ((couleur, nom), x) in _entrees-puces.zip(xs) {
    _pave((x, 0.1), (x + 0.45, 0.55), couleur)
    content((x + 0.65, 0.325), anchor: "west",
            text(size: 13pt, fill: accent, top-edge: "cap-height", bottom-edge: "baseline")[#nom])
  }
})

// ---------------------------------------------------------------------------
// Processeur et carte graphique : le traitement d'une image
//
// Une image de 16 × 8 pixels à éclaircir, la même opération sur chaque pixel.
// À gauche, quatre cœurs se partagent l'image par bandes et avancent d'un
// pixel par étape : l'état après trois étapes. À droite, un cœur par pixel :
// tout est fait en une étape. Pixel à traiter sombre, pixel traité clair.

#let _image(x0, fait) = {
  let (nc, nl, p) = (16, 8, 0.6)
  for l in range(nl) {
    for c in range(nc) {
      let niveau = calc.rem(c * 7 + l * 3 + calc.quo(c * l, 5), 5)
      // l'image est sombre ; un pixel traité est éclairci
      let couleur = if fait(l, c) { gris.darken(3% * niveau) } else {
        accent.lighten(18% + 6% * niveau)
      }
      rect((x0 + c * p, (nl - 1 - l) * p), (x0 + (c + 1) * p, (nl - l) * p),
           fill: couleur, stroke: 0.4pt + white)
    }
  }
}

#let schema-pixels() = cetz.canvas(length: 1cm, {
  let p = 0.6
  // le processeur : quatre bandes de deux lignes, trois pixels faits par bande
  let x0 = 1.9
  _image(x0, (l, c) => calc.rem(l, 2) == 0 and c < 3)
  for b in range(4) {
    let yh = (8 - 2 * b) * p
    if b > 0 {
      line((x0, yh), (x0 + 16 * p, yh), stroke: 3pt + white)
    }
    content((x0 - 0.2, yh - p), anchor: "east",
            text(size: 13pt, fill: accent)[cœur #(b + 1)])
    _fleche((x0 + 3.2 * p, yh - p / 2), (x0 + 5.2 * p, yh - p / 2), couleur: white,
            epaisseur: 1.6pt)
  }
  content((x0, 8 * p + 0.3), anchor: "south-west",
          text(size: 15pt, weight: demi-gras, fill: estompe, bottom-edge: "baseline")[Processeur, 4 cœurs : après 3 étapes])
  content((x0 + 8 * p, -0.35), anchor: "north",
          text(size: 14pt, fill: accent)[4 pixels par étape : 32 étapes])

  // la carte graphique : un cœur par pixel, tout est fait
  let x1 = 13.6
  _image(x1, (l, c) => true)
  content((x1, 8 * p + 0.3), anchor: "south-west",
          text(size: 15pt, weight: demi-gras, fill: estompe, bottom-edge: "baseline")[Carte graphique, 128 cœurs : après 1 étape])
  content((x1 + 8 * p, -0.35), anchor: "north",
          text(size: 14pt, fill: accent)[128 pixels par étape : 1 étape])
})

// ---------------------------------------------------------------------------
// Processeur et carte graphique : la puce et une image, sur une diapositive
//
// En haut, les deux puces de `schema-puces`, réduites, la légende des couleurs
// entre elles. Sous chaque puce, la même image en pixel art, 16 × 8 pixels
// (un paysage : soleil, montagnes enneigées, rivière, sapin, maison), à
// éclaircir : la même multiplication sur chaque pixel, et un pixel traité est
// dessiné éclairci. Le processeur a 8 cœurs, un par ligne, qui avancent d'un
// pixel par étape : l'état après 3 étapes. La carte graphique a un cœur par
// pixel : tout est fait en une étape. Les couleurs de l'image sont celles
// d'une image, et ne codent rien d'autre.

#let _palette-paysage = (
  s: rgb("#9cc9e8"),   // ciel
  o: rgb("#f2c14e"),   // soleil
  w: rgb("#f4f4f4"),   // neige
  m: rgb("#8a8f99"),   // montagne
  d: rgb("#646a75"),   // montagne à l'ombre
  g: rgb("#7cb35a"),   // herbe
  h: rgb("#5a9443"),   // herbe sombre
  b: rgb("#3f7fbf"),   // rivière
  t: rgb("#2f6b35"),   // sapin
  r: rgb("#b5523b"),   // toit
  f: rgb("#e8d9b5"),   // mur
  p: rgb("#7a4b2a"),   // porte
)

#let _paysage = (
  "sssssssssssssoos",
  "ssswsssssssssoos",
  "sswmwsssswssssss",
  "smmdmmssmmmsssss",
  "mmddmmmmdmmmrrrs",
  "gghggbbggghgfffg",
  "ghggbbggtgggfpfg",
  "hggbbggtttghgggh",
)

// L'image, le coin supérieur gauche en (x0, y0), pixels de côté `p` ;
// `fait(l, c)` dit si le pixel de la ligne l, colonne c, est éclairci.
#let _pixel-art(x0, y0, p, fait) = {
  for (l, ligne) in _paysage.enumerate() {
    for (c, code) in ligne.clusters().enumerate() {
      let couleur = _palette-paysage.at(code)
      if fait(l, c) { couleur = couleur.lighten(50%) }
      rect((x0 + c * p, y0 - l * p), (x0 + (c + 1) * p, y0 - (l + 1) * p),
           fill: couleur, stroke: none)
    }
  }
  rect((x0, y0), (x0 + 16 * p, y0 - 8 * p), stroke: 0.8pt + _trait)
}

#let schema-puces-image() = cetz.canvas(length: 1cm, {
  let u = 0.65
  let p = 0.48
  // centres des deux colonnes
  let (c1, c2) = (4.2, 17.4)
  _puce-processeur(c1 - 5.2 * u, -4.15, u, [Processeur : 8 cœurs],
                   taille-titre: 14pt, taille-cache: 11pt)
  _puce-carte(c2 - 5.2 * u, -4.15, u, [Carte graphique : des milliers d'unités],
              taille-titre: 14pt, taille-cache: 9pt)
  // la légende des couleurs, entre les deux puces
  for (k, (couleur, nom)) in _entrees-puces.enumerate() {
    let y = -1.5 - k * 0.6
    _pave((7.95, y - 0.2), (8.35, y + 0.2), couleur)
    content((8.55, y), anchor: "west",
            text(size: 12pt, fill: accent, top-edge: "cap-height", bottom-edge: "baseline")[#nom])
  }

  // les deux images
  let haut = -4.75
  let x1 = c1 - 8 * p
  _pixel-art(x1, haut, p, (l, c) => c < 3)
  for l in range(8) {
    content((x1 - 0.12, haut - (l + 0.5) * p), anchor: "east",
            text(size: 10pt, fill: estompe)[#(l + 1)])
  }
  content((c1, haut - 8 * p - 0.15), anchor: "north", text(size: 13pt, fill: accent)[
    un cœur par ligne : 8 pixels par étape, 16 étapes ; ici, après 3
  ])
  let x2 = c2 - 8 * p
  _pixel-art(x2, haut, p, (l, c) => true)
  // entre les deux images, l'opération appliquée
  content(((c1 + 8 * p + x2) / 2, haut - 4 * p), align(center, text(size: 14pt, fill: accent)[
    éclaircir : \ la même multiplication \ sur chaque pixel
  ]))
  content((c2, haut - 8 * p - 0.15), anchor: "north", text(size: 13pt, fill: accent)[
    un cœur par pixel : 128 pixels par étape, 1 étape
  ])
})

// ---------------------------------------------------------------------------
// Opérations par seconde : la décomposition pour un portable
//
// Le nombre d'opérations par seconde est un produit : unités de calcul,
// cycles par seconde, opérations par cycle. Une ligne pour le processeur, avec
// sous les 32 opérations par cycle leur décomposition, une ligne pour la carte
// graphique intégrée, puis le total. Valeurs d'un AMD Ryzen 5 7530U (2023) à
// sa cadence de base. Dessiné avec les primitives de typst, sans cetz.

#let _facteur(valeur, unite, fond: white) = box(
  width: 100%, inset: (x: 4pt, y: 7pt), radius: 4pt,
  stroke: 1.2pt + accent, fill: fond,
  align(center)[
    #text(size: 22pt, weight: demi-gras, fill: accent)[#valeur]
    #linebreak()
    #text(size: 13pt, fill: estompe)[#unite]
  ],
)

#let schema-operations() = {
  let signe(s) = text(size: 22pt, fill: estompe)[#s]
  let nom(s) = align(left, text(size: 17pt, weight: demi-gras, fill: accent)[#s])
  let resultat(v) = align(left, text(size: 22pt, weight: demi-gras, fill: accent)[#v])
  let cadence = _facteur([2 · 10#super[9]], [cycles par seconde])
  std.grid(
    columns: (auto, 1fr, auto, 1.25fr, auto, 1.25fr, auto, auto),
    column-gutter: 8pt, row-gutter: 8pt, align: center + horizon,
    nom[Processeur], _facteur([6], [cœurs]), signe[×], cadence, signe[×],
    _facteur([32], [opérations par cycle]), signe[=], resultat[3,8 · 10#super[11]],
    [], [], [], [], [],
    text(size: 13pt, fill: estompe)[8 nombres par instruction \ × 2 opérations : a × b + c \ × 2 instructions par cycle],
    [], [],
    nom[Carte graphique], _facteur([448], [unités de calcul]), signe[×], cadence, signe[×],
    _facteur([2], [opérations par cycle]), signe[=], resultat[1,8 · 10#super[12]],
    std.grid.cell(colspan: 6, align(right, text(size: 17pt, fill: accent)[total])),
    signe[≈], resultat[2 · 10#super[12]],
  )
}

// ---------------------------------------------------------------------------
// Le processeur, en cinq étapes
//
// Une figure pour cinq diapositives. Chaque étape ajoute un facteur au nombre
// d'opérations par seconde, jusqu'à la ligne « Processeur » de
// `schema-operations` : AMD Ryzen 5 7530U à sa cadence de base, 2 GHz.
//
//   1  un cœur, une instruction par cycle, une opération par instruction
//   2  instruction vectorielle : 8 nombres par instruction
//   3  multiplication et addition dans la même instruction : 2 opérations
//   4  deux unités de calcul : 2 instructions par cycle
//   5  six cœurs
//
// En haut, le dessin : la file d'instructions à gauche, l'instruction en
// cours sur fond clair ; le cœur à droite, avec ses registres d'entrée (cases
// blanches), l'opération (cases pleines) et les résultats (cases claires). À
// l'étape 5, les six cœurs, réduits à leurs cases d'opération. En bas, le
// calcul, un facteur par case, dans l'ordre des étapes ; le facteur ajouté
// par l'étape est sur fond clair. Le dessin a la même taille aux cinq étapes
// et les cases du calcul la même largeur, pour que rien ne bouge d'une
// diapositive à l'autre.

#let _case = 0.9        // largeur d'une case de registre
#let _pas-case = 0.98   // d'une case à la suivante
#let _haut-case = 0.52
#let _pas-rang = 0.62   // d'une rangée à la suivante
#let _fond-nouveau = accent.lighten(88%)

// Une unité de calcul de `n` cases, le haut en `y0`. `lettres` nomme les
// registres d'entrée, `sortie` celui des résultats.
#let _unite-calcul(x0, y0, n, lettres, sortie, fma) = {
  let nom(lettre, i) = if n == 1 { lettre } else { [#lettre#sub[#(i + 1)]] }
  let rangee(r, remplissage, trait, texte) = {
    let y = y0 - r * _pas-rang
    for i in range(n) {
      let x = x0 + i * _pas-case
      rect((x, y - _haut-case), (x + _case, y), fill: remplissage, stroke: trait)
      content((x + _case / 2, y - _haut-case / 2), texte(i))
    }
  }
  for (r, lettre) in lettres.enumerate() {
    rangee(r, white, 0.8pt + _trait, i => text(size: 13pt, fill: accent, nom(lettre, i)))
  }
  rangee(lettres.len(), accent, none,
         i => text(size: 13pt, fill: white, weight: demi-gras, if fma [×+] else [×]))
  rangee(lettres.len() + 1, accent.lighten(80%), 0.8pt + _trait,
         i => text(size: 13pt, fill: accent, nom(sortie, i)))
}

#let _dessin-coeur(etape) = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + _trait)
  // le cadre invisible : même taille à toutes les étapes
  rect((0, 0.75), (23.3, -3.9), stroke: none)

  if etape == 5 {
    for k in range(6) {
      let x0 = k * 3.94
      // le cœur 1 exécute le programme Python, en `attention` et avec le
      // logo ; les autres cœurs, aux autres programmes, restent en `accent`
      let python = k == 0
      let teinte = if python { attention } else { accent }
      // la file d'instructions du cœur, esquissée
      for j in range(3) {
        let y = 0.7 - j * 0.38
        rect((x0 + 0.5, y - 0.3), (x0 + 3.0, y), radius: 0.04,
             fill: if python { attention.lighten(75%) } else { white },
             stroke: 0.9pt + if python { attention } else { _trait })
      }
      _fleche((x0 + 1.75, -0.45), (x0 + 1.75, -0.9), couleur: teinte)
      rect((x0, -1.0), (x0 + 3.5, -3.6), radius: 0.08,
           fill: if python { attention.lighten(85%) } else { gris },
           stroke: 1.4pt + teinte)
      let etiquette = text(size: 16pt, weight: demi-gras, fill: teinte)[cœur #(k + 1)]
      if python {
        content((x0 + 1.4, -1.4), etiquette)
        // le logo non modifié, suivi du symbole de marque que demande la PSF
        content((x0 + 2.75, -1.4), image("/illustrations/cours5/python_logo.svg",
                                         height: 0.62cm))
        content((x0 + 3.1, -1.12), anchor: "west",
                text(size: 7pt, fill: estompe)[™])
      } else {
        content((x0 + 1.75, -1.4), etiquette)
      }
      for u in range(2) {
        for i in range(8) {
          let x = x0 + 0.15 + i * 0.41
          let y = -2.0 - u * 0.65
          rect((x, y - 0.48), (x + 0.38, y), fill: teinte, stroke: none)
        }
      }
    }
  } else {
    let fma = etape >= 3
    let n = if etape == 1 { 1 } else { 8 }
    let file = if etape <= 2 {
      (("lire a", false), ("lire b", false), ("a × b", true), ("écrire r", false))
    } else if etape == 3 {
      (("lire a", false), ("lire b", false), ("lire c", false),
       ("a × b + c", true), ("écrire r", false))
    } else {
      (("lire a, b, c", false), ("lire d, e, f", false), ("a × b + c", true),
       ("d × e + f", true), ("écrire r, s", false))
    }

    // la file d'instructions
    content((1.9, 0.45), text(size: 13pt, fill: estompe)[instructions])
    for (k, (ins, encours)) in file.enumerate() {
      let y = 0.1 - k * 0.6
      rect((0, y - 0.5), (3.8, y), radius: 0.05,
           fill: if encours { accent.lighten(80%) } else { white })
      content((1.9, y - 0.25), text(size: 13pt, font: police-code, fill: accent)[#ins])
    }
    _fleche((3.95, -1.4), (4.55, -1.4))

    // le cœur et ses unités
    let largeur-unite = (n - 1) * _pas-case + _case
    let unites = if etape == 4 { 2 } else { 1 }
    let x-coeur = 4.7
    let largeur = calc.max(unites * largeur-unite + (unites - 1) * 1.0 + 1.0, 3.6)
    let x-unite = x-coeur + (largeur - unites * largeur-unite - (unites - 1) * 1.0) / 2
    rect((x-coeur, 0.6), (x-coeur + largeur, -3.85), radius: 0.08, fill: gris,
         stroke: 1.4pt + accent)
    content((x-coeur + 0.3, 0.33), anchor: "west",
            text(size: 16pt, weight: demi-gras, fill: accent)[cœur])
    let lettres = if fma { ("a", "b", "c") } else { ("a", "b") }
    for u in range(unites) {
      let x0 = x-unite + u * (largeur-unite + 1.0)
      let (entrees, sortie) = if u == 0 { (lettres, "r") } else { (("d", "e", "f"), "s") }
      _unite-calcul(x0, -0.2, n, entrees, sortie, fma)
      content((x0 + largeur-unite / 2, -3.3), anchor: "north",
              text(size: 13pt, fill: estompe)[unité de calcul])
    }
    // à l'étape 2, le rappel que les 8 cases font la même opération
    if etape == 2 {
      let y = -0.2 - 2 * _pas-rang - _haut-case / 2
      _fleche((x-coeur + largeur + 1.1, y), (x-coeur + largeur - 0.4, y))
      content((x-coeur + largeur + 1.3, y), anchor: "west",
              text(size: 15pt, fill: accent)[la même opération \ pour les 8 nombres])
    }
  }
})

#let schema-processeur(etape) = {
  let signe(s) = text(size: 22pt, fill: estompe)[#s]
  // les facteurs, dans l'ordre des étapes ; à l'étape 1, une opération par
  // cycle tient lieu des trois facteurs suivants
  let facteurs = (
    ([2 · 10#super[9]], [cycles par seconde]),
    if etape == 1 { ([1], [opération par cycle]) } else { ([8], [nombres par instruction]) },
    ([2], [opérations \ a × b + c]),
    ([2], [instructions par cycle]),
    ([6], [cœurs]),
  ).slice(0, calc.max(etape, 2))
  let total = (
    [2 · 10#super[9]], [1,6 · 10#super[10]], [3,2 · 10#super[10]],
    [6,4 · 10#super[10]], [3,8 · 10#super[11]],
  ).at(etape - 1)
  let cellules = ()
  for (k, (valeur, unite)) in facteurs.enumerate() {
    if k > 0 { cellules.push(signe[×]) }
    cellules.push(_facteur(valeur, block(height: 2.3em, align(horizon, unite)),
                           fond: if etape > 1 and k == etape - 1 { _fond-nouveau } else { white }))
  }
  cellules.push(signe[=])
  cellules.push(align(left)[
    #text(size: 22pt, weight: demi-gras, fill: accent)[#total]
    #linebreak()
    #text(size: 13pt, fill: estompe)[opérations par seconde]
  ])

  _dessin-coeur(etape)
  v(0.4em)
  std.grid(
    columns: (3.3cm, 0.75cm) * facteurs.len() + (auto,),
    column-gutter: 0pt, align: center + horizon,
    ..cellules,
  )
}

// ---------------------------------------------------------------------------
// Hiérarchie des mémoires : la pyramide
//
// Quatre étages, du plus rapide et plus petit au plus lent et plus grand.
// Chaque étage porte son nom au centre, sa taille à gauche, son temps d'accès à
// droite. Le remplissage dit si le contenu de l'étage reste à l'extinction du
// poste : gris pour le cache et la mémoire vive, qui s'effacent ; bleu clair
// pour le disque et le réseau, qui conservent. Une légende sous la base.

#let _efface = gris
#let _conserve = attention.lighten(58%)

#let pyramide-memoire() = cetz.canvas(length: 1cm, {
  let etages = (
    ("Cache", "dans le processeur", "quelques Mo", "1 ns", false),
    ("Mémoire vive", "RAM", "8 à 32 Go", "100 ns", false),
    ("Disque", "SSD ou disque dur", "0,5 à 4 To", "0,1 à 10 ms", true),
    ("Réseau", "un autre ordinateur", "sans limite", "1 à 300 ms", true),
  )
  let etage-h = 1.55
  let (xg, xd) = (0, 22)
  let cx = (xg + xd) / 2
  // largeur du sommet et de la base
  let (l-haut, l-bas) = (6.4, 16.0)
  let n = etages.len()
  for (i, etage) in etages.enumerate() {
    let (nom, detail, taille, temps, conserve) = etage
    let y-haut = (n - i) * etage-h
    let y-bas = (n - i - 1) * etage-h
    let l1 = l-haut + (l-bas - l-haut) * i / n
    let l2 = l-haut + (l-bas - l-haut) * (i + 1) / n
    line((cx - l1 / 2, y-haut), (cx + l1 / 2, y-haut), (cx + l2 / 2, y-bas),
         (cx - l2 / 2, y-bas), close: true,
         fill: if conserve { _conserve } else { _efface }, stroke: 1.2pt + accent)
    content((cx, (y-haut + y-bas) / 2), box[
      #align(center)[
        #text(size: 17pt, weight: demi-gras, fill: accent)[#nom]
        #h(0.5em)
        #text(size: 13pt, fill: estompe)[#detail]
      ]
    ])
    content((cx - l-bas / 2 - 0.5, (y-haut + y-bas) / 2), anchor: "east",
            text(size: 15pt, fill: accent)[#taille])
    content((cx + l-bas / 2 + 0.5, (y-haut + y-bas) / 2), anchor: "west",
            text(size: 15pt, fill: accent)[#temps])
  }
  content((cx - l-bas / 2 - 0.5, n * etage-h + 0.35), anchor: "south-east",
          text(size: 13pt, fill: estompe)[#petites-capitales("taille")])
  content((cx + l-bas / 2 + 0.5, n * etage-h + 0.35), anchor: "south-west",
          text(size: 13pt, fill: estompe)[#petites-capitales("temps d'accès")])
  let pastille(couleur) = box(width: 0.9em, height: 0.9em, baseline: 0.12em,
                              fill: couleur, stroke: 1pt + accent)
  content((cx, -0.6), anchor: "north", text(size: 15pt, fill: accent)[
    #pastille(_efface) #h(0.3em) contenu effacé à l'extinction
    #h(2em)
    #pastille(_conserve) #h(0.3em) contenu conservé à l'extinction
  ])
})

// ---------------------------------------------------------------------------
// Temps d'accès sur une échelle logarithmique
//
// Une barre par accès, de longueur proportionnelle au logarithme du temps :
// c'est ce qui rend comparables une nanoseconde et une demi-seconde sur la
// même diapositive. Chaque décade est marquée ; la valeur est écrite au bout
// de la barre. Dessiné avec les primitives de typst, sans cetz.
//
// Avec `echelle` (l'en-tête d'une colonne), chaque ligne peut porter un
// cinquième élément, écrit dans une colonne à droite : le même temps sur une
// échelle humaine. `interligne` resserre les barres quand la place manque.

#let barres-temps(lignes, t-min: 1e-9, t-max: 1, largeur-nom: 150pt, largeur-valeur: 80pt, echelle: none, largeur-echelle: 190pt, interligne: 6pt) = layout(dispo => {
  let decades = calc.round(calc.log(t-max / t-min, base: 10))
  let largeur-droite = if echelle == none { 0pt } else { largeur-echelle }
  let largeur-barre = dispo.width - largeur-nom - largeur-valeur - 20pt - largeur-droite
  let x(t) = largeur-barre * calc.log(t / t-min, base: 10) / decades
  let hauteur-ligne = 20pt
  let n = lignes.len()
  let haut = if echelle == none { 0pt } else { hauteur-ligne }
  let hauteur = n * (hauteur-ligne + interligne) + 26pt + haut

  block(width: 100%, height: hauteur, {
    if echelle != none {
      place(top + right, box(width: largeur-echelle, height: hauteur-ligne,
            align(right + horizon, text(size: 13pt, fill: estompe)[#echelle])))
    }
    // repères des décades, avec l'unité lisible
    let reperes = (
      (1e-9, "1 ns"), (1e-6, "1 µs"), (1e-3, "1 ms"), (1, "1 s"),
    )
    for (t, nom) in reperes {
      place(top + left, dx: largeur-nom + 10pt + x(t), dy: haut,
            std.line(angle: 90deg, length: hauteur - 22pt - haut, stroke: 0.5pt + gris.darken(15%)))
      place(bottom + left, dx: largeur-nom + 10pt + x(t) - 14pt,
            text(size: 12pt, fill: estompe)[#nom])
    }
    for k in range(int(decades) + 1) {
      let t = t-min * calc.pow(10, k)
      place(top + left, dx: largeur-nom + 10pt + x(t), dy: haut,
            std.line(angle: 90deg, length: 6pt, stroke: 0.7pt + estompe))
    }
    for (i, ligne) in lignes.enumerate() {
      let (nom, t, valeur, couleur, ..reste) = ligne
      let y = haut + i * (hauteur-ligne + interligne)
      if echelle != none and reste.len() > 0 {
        place(top + right, dy: y, box(width: largeur-echelle, height: hauteur-ligne,
              align(right + horizon, text(size: 15pt, fill: accent)[#reste.at(0)])))
      }
      place(top + left, dx: 0pt, dy: y,
            box(width: largeur-nom, height: hauteur-ligne,
                align(right + horizon, text(size: 15pt, fill: accent)[#nom])))
      place(top + left, dx: largeur-nom + 10pt, dy: y + 3pt,
            std.rect(width: x(t), height: hauteur-ligne - 6pt, fill: couleur, stroke: none))
      // fond blanc : la valeur passe devant le trait de la décade suivante
      place(top + left, dx: largeur-nom + 10pt + x(t) + 4pt, dy: y,
            box(height: hauteur-ligne, fill: white, inset: (x: 2pt),
                align(horizon, text(size: 14pt, fill: accent, weight: demi-gras)[#valeur])))
    }
  })
})

// ---------------------------------------------------------------------------
// Local et distant : du poste au serveur
//
// Cinq étapes reliées en ligne : le poste, le réseau de la salle, celui de
// l'école, Internet, le serveur. Sous chaque lien, la distance et le temps
// d'un aller-retour.

#let _portable(x, y) = {
  rect((x - 1.1, y), (x + 1.1, y + 1.4), radius: 0.08, fill: white,
       stroke: 1.4pt + accent)
  rect((x - 0.95, y + 0.12), (x + 0.95, y + 1.28), fill: gris.lighten(45%), stroke: none)
  line((x - 1.4, y - 0.25), (x + 1.4, y - 0.25), (x + 1.15, y), (x - 1.15, y),
       close: true, stroke: 1.4pt + accent, fill: gris)
}

#let _boitier-reseau(x, y, l: 2.2, h: 0.7, voyants: 4) = {
  rect((x - l / 2, y - h / 2), (x + l / 2, y + h / 2), radius: 0.06, fill: white,
       stroke: 1.4pt + accent)
  for k in range(voyants) {
    circle((x - l / 2 + 0.35 + k * 0.4, y), radius: 0.09, fill: accent, stroke: none)
  }
}

#let _nuage(x, y) = {
  let bulles = ((0, 0, 1.0), (-1.1, -0.2, 0.75), (1.1, -0.2, 0.75), (-0.5, 0.45, 0.7), (0.6, 0.5, 0.65))
  for (dx, dy, r) in bulles {
    circle((x + dx, y + dy), radius: r, fill: gris.lighten(40%), stroke: none)
  }
  for (dx, dy, r) in bulles {
    circle((x + dx, y + dy), radius: r, fill: none, stroke: 1.2pt + accent)
  }
  for (dx, dy, r) in bulles {
    circle((x + dx, y + dy), radius: r - 0.05, fill: gris.lighten(40%), stroke: none)
  }
}

#let _serveur(x, y) = {
  rect((x - 0.9, y - 1.3), (x + 0.9, y + 1.3), radius: 0.08, fill: white,
       stroke: 1.4pt + accent)
  for k in range(4) {
    let y0 = y - 1.1 + k * 0.6
    rect((x - 0.75, y0), (x + 0.75, y0 + 0.45), fill: gris.lighten(45%), stroke: 0.8pt + _trait)
    circle((x - 0.55, y0 + 0.22), radius: 0.07, fill: accent, stroke: none)
    for j in range(3) {
      line((x + 0.15 + j * 0.2, y0 + 0.1), (x + 0.15 + j * 0.2, y0 + 0.35), stroke: 0.8pt + _trait)
    }
  }
}

#let schema-local-distant() = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + _trait)
  let y = 3.2
  let xs = (1.5, 7.0, 12.5, 18.0, 23.5)

  _portable(xs.at(0), y - 0.6)
  _etiquette((xs.at(0), y - 1.2), "Votre poste", none, largeur: 3.5cm)

  _boitier-reseau(xs.at(1), y)
  _etiquette((xs.at(1), y - 0.7), "La salle", "un commutateur", largeur: 3.5cm)

  _boitier-reseau(xs.at(2), y, voyants: 3)
  _etiquette((xs.at(2), y - 0.7), "L'école", "un routeur, le pare-feu", largeur: 3.8cm)

  _nuage(xs.at(3), y)
  _etiquette((xs.at(3), y - 1.3), "Internet", "les réseaux des opérateurs", largeur: 4cm)

  _serveur(xs.at(4), y)
  _etiquette((xs.at(4), y - 1.6), "Le serveur", "la forge, un site", largeur: 3.5cm)

  // les liens, et ce qu'ils coûtent
  let liens = (
    ("quelques mètres", "0,2 ms"),
    ("quelques centaines de mètres", "1 ms"),
    ("vers l'opérateur", "5 ms"),
    ("Paris–Francfort, ou plus loin", "13 à 300 ms"),
  )
  for (i, lien) in liens.enumerate() {
    let (distance, temps) = lien
    let (xa, xb) = (xs.at(i) + 1.55, xs.at(i + 1) - 1.55)
    if i == 0 { xa = xs.at(0) + 1.5 }
    if i == 2 { xb = xs.at(3) - 2.0 }
    if i == 3 { xa = xs.at(3) + 2.0; xb = xs.at(4) - 1.05 }
    line((xa, y), (xb, y), stroke: 1.4pt + accent)
    content(((xa + xb) / 2, y + 0.35), anchor: "south", box(width: 4.4cm)[
      #align(center)[
        #text(size: 14pt, weight: demi-gras, fill: accent)[#temps]
        #linebreak()
        #text(size: 11.5pt, fill: estompe)[#distance]
      ]
    ])
  }
  // local / distant
  let y-accolade = -1.1
  line((0, y-accolade), (xs.at(2) + 1.3, y-accolade), stroke: 1.2pt + brun)
  content(((0 + xs.at(2) + 1.3) / 2, y-accolade - 0.15), anchor: "north",
          text(size: 14pt, fill: brun, weight: demi-gras)[#petites-capitales("réseau local")])
  line((xs.at(2) + 1.7, y-accolade), (xs.at(4) + 1.0, y-accolade), stroke: 1.2pt + attention)
  content(((xs.at(2) + 1.7 + xs.at(4) + 1.0) / 2, y-accolade - 0.15), anchor: "north",
          text(size: 14pt, fill: attention, weight: demi-gras)[#petites-capitales("distant")])
})

// ---------------------------------------------------------------------------
// Client et serveur : une requête, une réponse

#let schema-client-serveur() = cetz.canvas(length: 0.84cm, {
  set-style(stroke: 0.9pt + _trait)
  let y = 1.6
  _portable(2.0, y - 0.6)
  _etiquette((2.0, y - 1.2), "Client", "demande", largeur: 3.5cm)
  _serveur(22.0, y)
  _etiquette((22.0, y - 1.6), "Serveur", "répond à beaucoup de clients", largeur: 5cm)

  _fleche((4.0, y + 0.5), (20.8, y + 0.5), couleur: alerte, epaisseur: 2pt)
  content((12.4, y + 0.7), anchor: "south", text(size: 16pt, fill: alerte, weight: demi-gras)[
    requête : l'adresse de la page demandée
  ])
  _fleche((20.8, y - 0.5), (4.0, y - 0.5), couleur: accent, epaisseur: 1.6pt)
  content((12.4, y - 0.7), anchor: "north", text(size: 16pt, fill: accent)[
    réponse : la page
  ])
})

// ---------------------------------------------------------------------------
// Débit et latence : le tuyau
//
// La latence est le temps que met le premier octet à arriver, la longueur du
// tuyau. Le débit est ce qui passe par seconde, sa largeur.

#let schema-tuyau() = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + _trait)
  let (x0, x1) = (2.5, 19.5)
  let (yb, yh) = (1.0, 3.2)

  _portable(0.6, yb + 0.3)
  _serveur(21.3, (yb + yh) / 2)

  // le tuyau
  rect((x0, yb), (x1, yh), fill: gris.lighten(50%), stroke: 1.4pt + accent)
  // les paquets qui le traversent
  for k in range(7) {
    let x = x0 + 0.8 + k * 2.4
    rect((x, yb + 0.55), (x + 1.2, yh - 0.55), radius: 0.05,
         fill: accent.lighten(35%), stroke: none)
  }
  // latence : la longueur
  _fleche((x0, yh + 0.8), (x1, yh + 0.8), couleur: attention, epaisseur: 1.4pt)
  content(((x0 + x1) / 2, yh + 1.0), anchor: "south", box[
    #align(center)[
      #text(size: 17pt, weight: demi-gras, fill: attention)[latence]
      #h(0.6em)
      #text(size: 14pt, fill: estompe)[le temps que met le premier octet à arriver]
    ]
  ])
  // débit : la largeur
  _fleche((x1 + 0.45, yb), (x1 + 0.45, yh), couleur: brun, epaisseur: 1.4pt)
  line((x1 + 0.45, yb), (x1 + 0.45, yh), stroke: 1.4pt + brun,
       mark: (start: ">", fill: brun, scale: 1.2))
  content(((x0 + x1) / 2, yb - 0.3), anchor: "north", box[
    #align(center)[
      #text(size: 17pt, weight: demi-gras, fill: brun)[débit]
      #h(0.6em)
      #text(size: 14pt, fill: estompe)[ce qui passe chaque seconde, en bits par seconde]
    ]
  ])
})

// ---------------------------------------------------------------------------
// La connexion à un site : le poste, le réseau, le serveur, sa table
//
// Le même schéma sert à plusieurs diapositives de la partie 3 : seule la
// table change (en clair, avec une empreinte, avec un sel), avec le calcul
// fait par le serveur. `reperes: true` numérote les quatre endroits où l'on
// obtient le mot de passe d'un autre : la table, le formulaire, le réseau,
// le poste.
//
// Pour montrer les parades (version courte, 19/10/2026) : `mot-de-passe`
// remplace celui du formulaire, `chiffre: true` montre le trajet chiffré,
// `telephone: true` dessine à droite du poste le téléphone du deuxième
// facteur.
//
//   schema-connexion(
//     entetes: ("identifiant", "mot de passe"),
//     lignes: (("alice", "Marseille2024!"), ("bob", "123456")),
//     calcul: "SHA-256",
//   )

#let schema-connexion(entetes: (), lignes: (), calcul: none, reperes: false, zoom: 115%,
                      mot-de-passe: "Marseille2024!", chiffre: false, telephone: false) = std.scale(zoom, reflow: true, cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + _trait)
  let y = 0

  // le poste : le formulaire rempli
  content((2.0, y), box(
    width: 4.2cm, inset: 6pt, stroke: 1.4pt + accent, radius: 4pt, fill: white,
  )[
    #set text(size: 13pt)
    #set par(leading: 0.4em)
    #text(fill: estompe)[identifiant] \
    #text(font: police-code)[alice] \
    #text(fill: estompe)[mot de passe] \
    #text(font: police-code)[#mot-de-passe]
  ])
  _etiquette((2.0, y - 1.35), "Votre poste", none, largeur: 4cm)

  // le téléphone du deuxième facteur, à droite du poste, au-dessus du réseau
  if telephone {
    rect((4.7, y + 0.35), (6.1, y + 2.55), radius: 0.15, fill: white, stroke: 1.4pt + accent)
    rect((4.85, y + 0.6), (5.95, y + 2.25), fill: gris.lighten(40%), stroke: none)
    content((5.4, y + 2.05), text(size: 10pt, fill: estompe)[code])
    content((5.4, y + 1.2), text(size: 12pt, font: police-code, fill: accent)[482 \ 913])
  }

  // le réseau
  _fleche((4.6, y), (10.7, y), epaisseur: 1.6pt)
  content((7.65, y + 0.15), anchor: "south",
          text(size: 13pt, font: police-code, fill: accent)[#if chiffre [9c1f47ae…] else [alice, #mot-de-passe]])
  content((7.65, y - 0.15), anchor: "north", text(size: 14pt, fill: estompe)[#if chiffre [le réseau (HTTPS)] else [le réseau]])

  // le serveur, et le calcul qu'il fait avant de comparer
  _serveur(11.8, y)
  _etiquette((11.8, y - 1.4), "Le serveur", none, largeur: 3.5cm)
  _fleche((12.9, y), (15.9, y), epaisseur: 1.4pt)
  content((14.4, y + 0.15), anchor: "south", box(width: 3.2cm, align(center,
    text(size: 13pt, fill: accent)[#if calcul == none [compare] else [#calcul \ puis compare]])))

  // la table des comptes
  content((16.1, y), anchor: "west", box[
    #text(size: 14pt, fill: estompe)[la table des comptes]
    #v(-0.5em)
    #table(
      columns: entetes.len(),
      inset: (x: 6pt, y: 4pt),
      stroke: 0.6pt + accent.lighten(40%),
      fill: (x, y) => if y == 0 { gris.lighten(45%) },
      ..entetes.map(e => text(size: 13pt, weight: demi-gras)[#e]),
      ..lignes.flatten().map(v => text(size: 13pt, font: police-code)[#v]),
    )
  ])

  if reperes {
    let r(pos, n) = content(pos, repere(n))
    r((15.55, y + 1.6), 1)
    r((11.8, y + 1.6), 2)
    r((5.2, y - 0.5), 3)
    r((-0.75, y + 0.9), 4)
  }
}))

// ---------------------------------------------------------------------------
// Une paire de clés : le cadenas et la clé

#let _cadenas(x, y, couleur, echelle: 1) = {
  let s = echelle
  rect((x - 1.1 * s, y - 1.0 * s), (x + 1.1 * s, y + 0.5 * s), radius: 0.12 * s,
       fill: couleur.lighten(85%), stroke: 1.6pt + couleur)
  arc((x, y + 0.5 * s), start: 0deg, stop: 180deg, radius: 0.7 * s, anchor: "origin",
      stroke: 1.6pt + couleur)
  line((x - 0.7 * s, y + 0.5 * s), (x - 0.7 * s, y + 0.2 * s), stroke: 1.6pt + couleur)
  line((x + 0.7 * s, y + 0.5 * s), (x + 0.7 * s, y + 0.2 * s), stroke: 1.6pt + couleur)
  circle((x, y - 0.15 * s), radius: 0.2 * s, fill: couleur, stroke: none)
  rect((x - 0.07 * s, y - 0.6 * s), (x + 0.07 * s, y - 0.2 * s), fill: couleur, stroke: none)
}

#let _cle(x, y, couleur, echelle: 1) = {
  let s = echelle
  circle((x - 1.3 * s, y), radius: 0.55 * s, fill: couleur.lighten(85%), stroke: 1.6pt + couleur)
  circle((x - 1.3 * s, y), radius: 0.2 * s, fill: white, stroke: 1.2pt + couleur)
  rect((x - 0.75 * s, y - 0.15 * s), (x + 1.6 * s, y + 0.15 * s), fill: couleur, stroke: none)
  for (k, h) in ((0.2, 0.45), (0.65, 0.35), (1.15, 0.45)) {
    rect((x + k * s, y - 0.15 * s), (x + k * s + 0.25 * s, y - h * s), fill: couleur, stroke: none)
  }
}

#let schema-cles() = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + _trait)
  // la clé publique, à gauche, et où elle va
  _cadenas(4.0, 4.3, attention, echelle: 1.3)
  content((4.0, 2.2), anchor: "north", box(width: 8cm)[
    #align(center)[
      #text(size: 19pt, weight: demi-gras, fill: attention)[clé publique]
      #linebreak()
      #text(size: 15pt, fill: accent)[sert à fermer ; elle est distribuée]
      #linebreak()
      #text(size: 13.5pt, fill: estompe)[`id_ed25519.pub`, collée sur la forge et les serveurs]
    ]
  ])
  // la clé privée, à droite, et où elle reste
  _cle(17.5, 4.3, brun, echelle: 1.3)
  content((17.5, 2.2), anchor: "north", box(width: 8cm)[
    #align(center)[
      #text(size: 19pt, weight: demi-gras, fill: brun)[clé privée]
      #linebreak()
      #text(size: 15pt, fill: accent)[sert à ouvrir ; elle reste sur votre poste]
      #linebreak()
      #text(size: 13.5pt, fill: estompe)[le fichier `id_ed25519` n'est jamais copié ni envoyé]
    ]
  ])
  // ce qui les lie
  line((7.0, 4.3), (14.4, 4.3), stroke: (paint: estompe, thickness: 1pt, dash: "dashed"))
  content((10.7, 4.5), anchor: "south", box(width: 9.4cm)[
    #align(center)[
      #text(size: 14pt, fill: estompe)[Les deux clés sont créées ensemble par `ssh-keygen`. Un message fermé avec la clé publique ne peut être ouvert qu'avec la clé privée.]
    ]
  ])
})

// ---------------------------------------------------------------------------
// Empreinte, sel et calcul lent (version courte, diapositive facultative)
//
// Trois lignes, lues de gauche à droite : ce qui entre, le calcul écrit sur
// la flèche, ce qui sort. Empreinte : deux mots presque identiques, deux
// empreintes sans rapport, et la flèche du retour barrée. Sel : le même mot
// de passe pour bob et chloé, sans sel puis avec ; le sel en `attention`,
// car il n'est pas secret. Calcul lent : le temps pour essayer toutes les
// combinaisons de 8 caractères, avec SHA-256 et avec bcrypt.

#let schema-empreinte-sel() = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + _trait)
  let code(corps, couleur: accent) = text(size: 14pt, font: police-code, fill: couleur, corps)
  let petit(corps, couleur: estompe) = text(size: 12pt, fill: couleur, corps)
  // une ligne : l'entrée finit en x0, la flèche porte le calcul, la sortie
  // commence au bout de la flèche
  let calcul(x0, y, entree, nom, sortie, longueur: 2.4) = {
    content((x0, y), anchor: "east", entree)
    _fleche((x0 + 0.2, y), (x0 + 0.2 + longueur, y), epaisseur: 1.2pt)
    content((x0 + 0.2 + longueur / 2, y + 0.14), anchor: "south",
            text(size: 11pt, fill: estompe)[#nom])
    content((x0 + 0.4 + longueur, y), anchor: "west", sortie)
  }
  let titre(y, nom, detail) = {
    content((0, y + 0.3), anchor: "west", text(size: 15pt, weight: demi-gras, fill: accent)[#nom])
    content((0, y - 0.1), anchor: "north-west", box(width: 4.4cm, petit(detail)))
  }
  let separation(y) = line((0, y), (23.2, y), stroke: 0.6pt + gris.darken(10%))

  // l'empreinte
  titre(-0.45, [empreinte], [un calcul à sens unique])
  calcul(8.6, 0.1, code[bonjour], [SHA-256], code[2cb4b143…])
  calcul(8.6, -0.9, code[Bonjour], [SHA-256], code[9172e8ee…])
  // le retour impossible, sous les deux lignes
  line((13.2, -1.75), (8.8, -1.75), stroke: (paint: estompe, thickness: 1.1pt, dash: "dashed"),
       mark: (end: ">", fill: estompe, scale: 1.0))
  line((10.75, -1.5), (11.25, -2.0), stroke: 2pt + accent)
  line((10.75, -2.0), (11.25, -1.5), stroke: 2pt + accent)
  content((13.5, -1.75), anchor: "west", petit[aucun calcul ne remonte au mot de passe])
  content((14.6, -0.4), anchor: "west", box(width: 8.6cm, text(size: 13pt, fill: accent)[
    le même mot donne toujours la même empreinte ; une lettre de différence donne une empreinte sans rapport
  ]))

  separation(-2.45)

  // le sel
  titre(-3.75, [sel], [un par compte, gardé dans la table])
  content((8.6, -2.95), anchor: "east", petit[sans sel])
  calcul(8.6, -3.55, code[123456], [SHA-256], code[8d969eef…], longueur: 1.9)
  calcul(8.6, -4.45, code[123456], [SHA-256], code[8d969eef…], longueur: 1.9)
  content((6.3, -3.55), anchor: "east", petit[bob])
  content((6.3, -4.45), anchor: "east", petit[chloé])
  content((11.1, -5.05), anchor: "west", petit(couleur: accent)[identiques])
  content((18.4, -2.95), anchor: "east", petit[avec sel])
  calcul(18.4, -3.55, [#code(couleur: attention)[b21e04]#code[123456]], [SHA-256], code[fe80f1e0…], longueur: 1.9)
  calcul(18.4, -4.45, [#code(couleur: attention)[e5d1f8]#code[123456]], [SHA-256], code[f63e6f06…], longueur: 1.9)
  content((20.9, -5.05), anchor: "west", petit(couleur: accent)[différentes])

  separation(-5.5)

  // le calcul lent
  titre(-6.95, [calcul lent], [moins d'essais par seconde])
  content((8.6, -6.0), anchor: "east", petit[8 caractères tirés au hasard])
  calcul(8.6, -6.65, code[k7\#Qp2vL], [SHA-256 : 22 milliards d'essais par seconde],
         text(size: 15pt, weight: demi-gras, fill: accent)[trouvé en 3,5 jours], longueur: 8.0)
  calcul(8.6, -7.65, code[k7\#Qp2vL], [bcrypt : 184 000 essais par seconde],
         text(size: 15pt, weight: demi-gras, fill: accent)[trouvé en 1 100 ans], longueur: 8.0)
})

// ---------------------------------------------------------------------------
// Cryptographie symétrique et asymétrique : une clé ou deux
//
// Trois lignes de même forme : une clé, un geste, le message, le geste
// inverse, l'autre clé. La couleur d'une clé dit qui la détient : `accent`
// la clé partagée, `attention` la clé publique, que tout le monde a, `brun`
// la clé privée, que son détenteur garde. Les clés sont toutes dessinées en
// clés : la clé publique ne prend pas ici la forme d'un cadenas, qui ne vaut
// que pour fermer.

#let schema-cryptographie() = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + _trait)
  let lignes = (
    ([symétrique], [le mot de passe du Wi-Fi],
     (accent, [la clé], [les deux côtés]), [ferme], [message fermé], [ouvre],
     (accent, [la même clé], [les deux côtés])),
    ([asymétrique : chiffrer], [envoyer un secret],
     (attention, [clé publique], [n'importe qui]), [ferme], [message fermé], [ouvre],
     (brun, [clé privée], [son détenteur seul])),
    ([asymétrique : signer], [prouver qui l'on est : SSH],
     (brun, [clé privée], [son détenteur seul]), [signe], [message signé], [vérifie],
     (attention, [clé publique], [n'importe qui])),
  )
  let cle-et-nom(x, y, (couleur, nom, qui)) = {
    _cle(x, y + 0.15, couleur, echelle: 0.5)
    content((x - 0.1, y - 0.4), anchor: "north", std.stack(
      dir: ttb, spacing: 4pt,
      align(center, text(size: 14pt, weight: demi-gras, fill: couleur)[#nom]),
      align(center, text(size: 12pt, fill: estompe)[#qui]),
    ))
  }
  for (k, (type, usage, gauche, geste, message, inverse, droite)) in lignes.enumerate() {
    let y = -k * 2.2
    // séparation entre la ligne symétrique et les deux lignes asymétriques
    if k == 1 {
      line((0, y + 0.95), (23.0, y + 0.95), stroke: 0.6pt + gris.darken(10%))
    }
    content((0, y + 0.25), anchor: "west", text(size: 15pt, weight: demi-gras, fill: accent)[#type])
    content((0, y - 0.3), anchor: "west", text(size: 12pt, fill: estompe)[#usage])
    cle-et-nom(7.6, y, gauche)
    _fleche((9.2, y + 0.15), (11.3, y + 0.15))
    content((10.25, y + 0.35), anchor: "south", text(size: 13pt, fill: accent)[#geste])
    rect((11.5, y - 0.35), (15.3, y + 0.65), radius: 0.08, fill: gris, stroke: 0.9pt + _trait)
    content((13.4, y + 0.15), text(size: 13pt, fill: accent)[#message])
    _fleche((15.5, y + 0.15), (17.6, y + 0.15))
    content((16.55, y + 0.35), anchor: "south", text(size: 13pt, fill: accent)[#inverse])
    cle-et-nom(19.5, y, droite)
  }
})

// ---------------------------------------------------------------------------
// La connexion SSH : quatre messages
//
// Deux lignes de vie, le client et le serveur, et les messages dans l'ordre.
// La clé privée n'apparaît que du côté du client : elle n'est jamais envoyée.
// Le client signe le défi avec la clé privée, le serveur vérifie la signature
// avec la clé publique (signature Ed25519, depuis le 19/10/2026 ; le défi
// « fermé avec la clé publique » de la première version était le
// fonctionnement de SSH-1 avec RSA).
//
// Avec `cles: true`, la paire est dessinée en tête, entre les deux acteurs,
// comme dans `schema-cryptographie` : la clé privée près du poste, la clé
// publique près du serveur, et le nom de chaque fichier sous l'acteur qui le
// garde. `pas` règle l'écart
// entre deux messages.

#let schema-echange-ssh(cles: false, pas: 1.45) = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + _trait)
  let (xc, xs) = (3.0, 20.0)
  let y0 = 6.6

  // les deux acteurs
  _portable(xc, y0 + 0.4)
  content((xc, y0 + 2.1), anchor: "south", box[
    #text(size: 16pt, weight: demi-gras, fill: accent)[votre poste]
    #linebreak()
    #text(size: 13pt, fill: brun)[clé privée#if cles [, `id_ed25519`]]
  ])
  _serveur(xs, y0 + 1.0)
  content((xs, y0 + 2.4), anchor: "south", box[
    #text(size: 16pt, weight: demi-gras, fill: accent)[le serveur]
    #linebreak()
    #text(size: 13pt, fill: attention)[votre clé publique#if cles [, `id_ed25519.pub`]]
  ])

  if cles {
    let yc = y0 + 1.3
    _cle(xc + 4.2, yc, brun, echelle: 0.75)
    _cle(xs - 3.6, yc, attention, echelle: 0.75)
    line((xc + 5.9, yc), (xs - 5.2, yc), stroke: (paint: estompe, thickness: 1pt, dash: "dashed"))
    content(((xc + xs) / 2 - 0.3, yc + 0.15), anchor: "south",
            text(size: 13pt, fill: estompe)[une paire, créée par `ssh-keygen`])
  }
  line((xc, y0 - 0.2), (xc, y0 - 4 * pas - 0.4), stroke: 1pt + _trait)
  line((xs, y0 - 0.4), (xs, y0 - 4 * pas - 0.4), stroke: 1pt + _trait)

  let messages = (
    (true, "« je suis alice »", "le nom du compte, en clair"),
    (false, "un défi", "un nombre tiré au hasard"),
    (true, "le défi, signé avec la clé privée", "la clé reste sur le poste"),
    (false, "« entrez »", "signature vérifiée avec la clé publique d’alice"),
  )
  for (i, message) in messages.enumerate() {
    let (vers-serveur, texte, detail) = message
    let y = y0 - 0.6 - i * pas
    let (a, b) = if vers-serveur { (xc + 0.3, xs - 0.3) } else { (xs - 0.3, xc + 0.3) }
    let couleur = if i == 2 { brun } else if i == 3 { attention } else { accent }
    _fleche((a, y), (b, y), couleur: couleur, epaisseur: 1.5pt)
    content(((xc + xs) / 2, y + 0.12), anchor: "south", box[
      #text(size: 15pt, fill: couleur, weight: demi-gras)[#(i + 1). #texte]
      #h(0.6em)
      #text(size: 13pt, fill: estompe)[#detail]
    ])
  }
})

// ---------------------------------------------------------------------------
// Un commit et un push : où chacun écrit

#let schema-commit-push() = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + _trait)
  let y = 2.6
  // le poste : dossier de travail et dépôt local, dans le même cadre
  rect((0, 0), (13.2, 5.2), radius: 0.12, stroke: 1.4pt + accent, fill: none, name: "poste")
  content((0.35, 4.95), anchor: "north-west",
          text(size: 13pt, fill: estompe)[#petites-capitales("votre poste")])
  rect((0.5, 1.2), (5.3, 4.0), radius: 0.08, fill: gris, stroke: 1.2pt + accent)
  content((2.9, 2.6), box[
    #align(center)[
      #text(size: 16pt, weight: demi-gras, fill: accent)[dossier de travail]
      #linebreak()
      #text(size: 13pt, fill: estompe)[vos fichiers]
    ]
  ])
  rect((8.5, 1.2), (12.7, 4.0), radius: 0.08, fill: gris, stroke: 1.2pt + accent)
  content((10.6, 2.6), box[
    #align(center)[
      #text(size: 16pt, weight: demi-gras, fill: accent)[dépôt local]
      #linebreak()
      #text(size: 13pt, fill: estompe)[`.git/`, sur le disque]
    ]
  ])
  _fleche((5.4, y), (8.4, y), couleur: accent, epaisseur: 1.6pt)
  content((6.9, y + 0.25), anchor: "south", text(size: 15pt, weight: demi-gras, fill: accent)[`commit`])
  content((6.9, y - 0.3), anchor: "north", text(size: 13pt, fill: estompe)[quelques ms])

  // la forge, au bout du réseau
  _serveur(21.5, y)
  content((21.5, y - 1.6), anchor: "north", box[
    #align(center)[
      #text(size: 16pt, weight: demi-gras, fill: accent)[la forge]
      #linebreak()
      #text(size: 13pt, fill: estompe)[le même dépôt, ailleurs]
    ]
  ])
  _fleche((13.4, y), (20.4, y), couleur: attention, epaisseur: 1.6pt)
  content((16.9, y + 0.25), anchor: "south", text(size: 15pt, weight: demi-gras, fill: attention)[`push`])
  content((16.9, y - 0.3), anchor: "north", box(width: 6.6cm)[
    #align(center)[
      #text(size: 13pt, fill: estompe)[un aller-retour, puis les octets : de 0,1 s à plusieurs secondes]
    ]
  ])
  content((16.9, 0.4), anchor: "north", text(size: 13pt, fill: attention)[#petites-capitales("réseau")])
})

// ---------------------------------------------------------------------------
// Une photo avec des repères numérotés
//
// Les repères sont posés en fractions de la largeur et de la hauteur de
// l'image : ils la suivent quelle que soit la taille à laquelle elle est
// projetée. La légende, numéro par numéro, va dans un tableau à côté de la
// photo, et non sur elle : du texte posé sur une photo sombre ne se lit pas.
//
//   #photo-reperee("/illustrations/cours5/carte_mere.jpg", 1400 / 933,
//                  ((0.66, 0.52), (0.66, 0.80)), hauteur: 300pt)

// `repere` est défini plus haut, avec le schéma de la connexion.

// La légende des repères : un numéro, un libellé, en corps réduit pour
// tenir à côté de la photo sans repli.
#let legende-reperes(..libelles) = std.grid(
  columns: (auto, 1fr), column-gutter: 10pt, row-gutter: 9pt, align: (center + horizon, left + horizon),
  ..libelles.pos().enumerate().map(((i, l)) => (repere(i + 1), text(size: 15pt)[#l])).flatten(),
)

#let photo-reperee(chemin, rapport, reperes, hauteur: 300pt) = {
  let largeur = hauteur * rapport
  let taille = 21pt
  box(width: largeur, height: hauteur, stroke: 1pt + accent.lighten(55%))[
    #image(chemin, width: 100%, height: 100%)
    #for (i, (fx, fy)) in reperes.enumerate() {
      place(top + left, dx: fx * largeur - taille / 2, dy: fy * hauteur - taille / 2,
            repere(i + 1, taille: taille))
    }
  ]
}

// ---------------------------------------------------------------------------
// Trente ans de processeurs
//
// Quatre séries de Karl Rupp (microprocessor-trend-data, CC BY 4.0), un point
// par processeur, sur une échelle verticale logarithmique : transistors,
// fréquence, puissance, cœurs. Le nom de chaque série est écrit au bout de
// ses points, pas dans une légende à part.

#import "donnees/tendances.typ": transistors, frequence, puissance, coeurs

#let graphe-tendances(largeur: 21.5, hauteur: 8.6) = cetz.canvas(length: 1cm, {
  let (a0, a1) = (1990, 2024)
  let (l0, l1) = (-0.3, 8.3)
  let x(a) = largeur * (a - a0) / (a1 - a0)
  let y(v) = hauteur * (calc.log(v, base: 10) - l0) / (l1 - l0)

  // grille et axes
  for k in range(0, 9) {
    let yy = y(calc.pow(10, k))
    line((0, yy), (largeur, yy), stroke: 0.4pt + gris.darken(12%))
    content((-0.25, yy), anchor: "east", text(size: 12pt, fill: estompe)[
      #if k == 0 [1] else if k < 4 [#calc.pow(10, k)] else [10#super[#k]]
    ])
  }
  line((0, 0), (largeur, 0), stroke: 0.8pt + accent)
  line((0, 0), (0, hauteur), stroke: 0.8pt + accent)
  for a in range(1990, 2025, step: 5) {
    line((x(a), 0), (x(a), -0.15), stroke: 0.8pt + accent)
    content((x(a), -0.25), anchor: "north", text(size: 12pt, fill: accent)[#a])
  }

  let serie(points, couleur, nom, y-nom) = {
    for (a, v) in points {
      if v > 0 {
        circle((x(a), y(v)), radius: 0.075, fill: couleur, stroke: none)
      }
    }
    content((largeur + 0.25, y(y-nom)), anchor: "west",
            text(size: 13.5pt, fill: couleur, weight: demi-gras)[#nom])
  }
  serie(transistors, estompe, "transistors (milliers)", 3e7)
  serie(frequence, attention, "fréquence (MHz)", 3000)
  serie(puissance, brun, "puissance (W)", 90)
  serie(coeurs, accent, "cœurs", 12)
})
