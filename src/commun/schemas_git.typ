// Graphe de commits, et ses annotations.
//
// Sert au cours 2 ; le cours 6 (forge et git en équipe) le reprendra. Les
// dessins sont en unités de `cetz.canvas`, mis à l'échelle par `echelle`.
//
// Le dessin suit les conventions de Pro Git et de gitdags : chaque commit
// porte son identifiant, l'arête va de l'enfant vers le parent (c'est le sens
// du pointeur dans git), une branche est un cartouche accroché au commit
// qu'elle désigne, et un commit de fusion, qui a deux parents, se distingue
// par un double trait. Chaque voie a sa couleur.
//
// `cetz.draw` n'est ouvert que dans les `canvas` : ses noms (`grid`, `line`,
// `content`, `rect`) masqueraient ceux de typst chez qui importerait ce
// fichier avec `: *`.

#import "@preview/cetz:0.4.2"
#import "theme.typ": accent, estompe, brun, attention, demi-gras, police-code

// Le rouge du support d'origine : l'arête de fusion, le conflit.
#let rouge-attention = rgb("#E8112D")

#let _pastille = 0.44         // rayon d'un commit
#let _ecart-x = 1.75          // d'un commit au suivant
#let _ecart-y = 1.3           // d'une voie à la suivante
#let _arete = 1.3pt           // épaisseur d'une arête

// Une couleur par voie : le tronc, puis les branches.
#let _couleurs-voies = (accent, brun, attention)
#let _teinte-voie(voie) = _couleurs-voies.at(calc.rem(int(voie), _couleurs-voies.len()))

// L'identifiant écrit dans la pastille. Explicite (`id`), sinon déduit du
// nom (`c7`), sinon de l'étiquette (« commit 7 » → `c7`, « Initial commit »
// → `c0`, « commit 2 bis » → `c2′`, « merge » → `m`), sinon vide.
#let _identifiant(c) = {
  if "id" in c { return c.id }
  if c.nom.match(regex("^c\d+$")) != none { return c.nom }
  let e = c.at("etiquette", default: "")
  if e == "Initial commit" { return "c0" }
  if e == "merge" { return "m" }
  let m = e.match(regex("^commit (\d+)( bis)?$"))
  if m != none { return "c" + m.captures.at(0) + if m.captures.at(1) != none { "′" } else { "" } }
  ""
}

// L'étiquette affichée sous la pastille : celle qui n'est pas déjà dans
// l'identifiant (« Initial commit », « v1 »).
#let _legende(c) = {
  let e = c.at("etiquette", default: "")
  if e == "" or e == "merge" { return "" }
  if e.match(regex("^commit \d+( bis)?$")) != none { return "" }
  e
}

// ---------------------------------------------------------------------------
// Le graphe de commits
//
// Un commit :
//
//   (nom: "c1", col: 0, voie: 0, etiquette: "commit 1", parents: ("c0",))
//
// `col` est l'abscisse, `voie` la ligne de développement. Facultatifs :
// `etape` (le commit apparaît à partir de cette étape), `teinte` (fond de la
// pastille, à la place du fond de la voie), `id` (le texte dans la pastille),
// `place` (« dessus » ou « dessous » pour l'étiquette et le cartouche de
// branche ; par défaut dessous sur la voie 0, dessus ailleurs).
//
// `branches` : (nom, voie, col, commit, etape, ecart). Le cartouche s'accroche au
// commit nommé, sinon au dernier commit visible de la voie, à `ecart` de la pastille :
// 1.0 le place au-delà d'une étiquette du même côté. Il s'appelle `branche-<nom>`
// dans le canevas.
// `fleches` : (depuis, longueur) — un prolongement en pointillé vers la
// droite, pour dire que l'historique continue.
// `extra` : fonction `(pos, d)` appelée en dernier, avec `pos(nom)` qui donne
// les coordonnées d'un commit et `d` le module `cetz.draw`. Sert aux
// annotations propres à une diapositive.
#let graphe-git(
  commits: (),
  branches: (),
  fleches: (),
  etape: 99,
  extra: none,
  echelle: 1.0,
  ecart-x: _ecart-x,
  ecart-y: _ecart-y,
  taille-etiquette: 9pt,
) = cetz.canvas(length: echelle * 1cm, {
  import cetz.draw: *

  let par-nom = (:)
  for c in commits { par-nom.insert(c.nom, c) }
  let pos(nom) = {
    let c = par-nom.at(nom)
    (c.col * ecart-x, c.voie * ecart-y)
  }
  let visible(c) = c.at("etape", default: 0) <= etape
  let dessous(c) = c.at("place", default: if c.voie == 0 { "dessous" } else { "dessus" }) == "dessous"
  let r = _pastille

  // Prolongements, arêtes, puis pastilles : ce qui passe dessous d'abord.
  for f in fleches {
    if f.at("etape", default: 0) > etape { continue }
    let depart = pos(f.depuis)
    line(
      (depart.at(0) + r + 0.12, depart.at(1)),
      (depart.at(0) + f.at("longueur", default: 0.9) * ecart-x, depart.at(1)),
      stroke: (paint: estompe, thickness: _arete, dash: "dotted"),
    )
  }

  // Une arête par parent, de l'enfant vers le parent, raccourcie au bord des
  // pastilles.
  for c in commits {
    if not visible(c) { continue }
    for p in c.at("parents", default: ()) {
      if not visible(par-nom.at(p)) { continue }
      let (a, b) = (pos(c.nom), pos(p))
      let (dx, dy) = (b.at(0) - a.at(0), b.at(1) - a.at(1))
      let n = calc.sqrt(dx * dx + dy * dy)
      let (ux, uy) = (dx / n, dy / n)
      line(
        (a.at(0) + ux * r, a.at(1) + uy * r),
        (b.at(0) - ux * (r + 0.08), b.at(1) - uy * (r + 0.08)),
        stroke: _arete + estompe, mark: (end: "straight", fill: estompe, scale: 0.85),
      )
    }
  }

  for c in commits {
    if not visible(c) { continue }
    let p = pos(c.nom)
    let couleur = _teinte-voie(c.voie)
    let fond = c.at("teinte", default: couleur.lighten(88%))
    if fond == white { fond = couleur.lighten(88%) }
    circle(p, radius: r, fill: fond, stroke: _arete + couleur)
    // Deux parents : un commit de fusion, en double trait.
    if c.at("parents", default: ()).len() >= 2 {
      circle(p, radius: r - 0.09, stroke: 1pt + couleur)
    }
    // L'identifiant suit l'échelle, pour tenir dans la pastille ; les autres
    // textes, non.
    let id = _identifiant(c)
    if id != "" {
      content(p, text(size: calc.max(8pt, (taille-etiquette + 1pt) * echelle), weight: demi-gras, fill: couleur, font: police-code)[#id])
    }
    let legende = _legende(c)
    if legende != "" {
      let s = if dessous(c) { -1 } else { 1 }
      content(
        (p.at(0), p.at(1) + s * (r + 0.14)),
        text(size: taille-etiquette, fill: accent)[#legende],
        anchor: if s < 0 { "north" } else { "south" },
      )
    }
  }

  // Le cartouche de branche, relié en pointillé au commit qu'il désigne.
  for b in branches {
    if b.at("etape", default: 0) > etape { continue }
    let nom-commit = b.at("commit", default: none)
    if nom-commit == none {
      let candidats = commits.filter(c => visible(c) and c.voie == b.voie)
      if candidats.len() == 0 { continue }
      nom-commit = candidats.sorted(key: c => c.col).last().nom
    }
    let c = par-nom.at(nom-commit)
    let p = pos(nom-commit)
    let couleur = _teinte-voie(c.voie)
    let s = if dessous(c) { -1 } else { 1 }
    let q = (p.at(0), p.at(1) + s * (r + b.at("ecart", default: 0.62)))
    // Le pointillé part du bord de la pastille, ou du bas de l'étiquette du commit.
    let depart = if _legende(c) == "" { r + 0.04 } else { r + 0.14 + 1.3 * taille-etiquette / (echelle * 1cm) }
    if r + b.at("ecart", default: 0.62) - 0.3 > depart + 0.2 {
      line(
        (p.at(0), p.at(1) + s * depart), (q.at(0), q.at(1) - s * 0.3),
        stroke: (paint: couleur, thickness: 1pt, dash: "dotted"),
      )
    }
    content(q, name: "branche-" + b.nom, box(fill: couleur, inset: (x: 6pt, y: 3.5pt), radius: 4pt,
      text(size: taille-etiquette + 1pt, weight: demi-gras, fill: white)[#b.nom]))
  }

  if extra != none { extra(pos, cetz.draw) }
})

// ---------------------------------------------------------------------------
// Annotations, à appeler depuis `extra`. `d` est le module `cetz.draw`, `p`,
// `a` et `b` des positions de commit.

// Le cartouche HEAD, relié au commit par une flèche. `dy` négatif : le
// cartouche est sous le commit ; positif : au-dessus. Choisir le côté que
// l'étiquette du commit n'occupe pas.
#let marque-tete(d, p, dx: 0.95, dy: -0.8, texte: "HEAD") = {
  let sens = if dy < 0 { -1 } else { 1 }
  let coin = (p.at(0) + dx, p.at(1) + dy)
  let (ux, uy) = (p.at(0) - coin.at(0), p.at(1) - coin.at(1))
  let n = calc.sqrt(ux * ux + uy * uy)
  d.line(
    coin, (p.at(0) - ux / n * (_pastille + 0.06), p.at(1) - uy / n * (_pastille + 0.06)),
    stroke: 1.2pt + accent, mark: (end: "straight", fill: accent, scale: 0.8),
  )
  d.content(
    coin,
    box(stroke: 1pt + accent, fill: white, inset: (x: 5pt, y: 3pt), radius: 4pt,
      text(size: 10pt, weight: demi-gras, fill: accent)[#texte]),
    anchor: if sens < 0 { "north-west" } else { "south-west" },
  )
}

// Le cartouche HEAD à droite de celui d'une branche : HEAD désigne la branche
// courante. La branche doit figurer dans `branches`.
#let marque-tete-branche(d, branche, texte: "HEAD") = {
  let bord = "branche-" + branche + ".east"
  d.line((rel: (0.7, 0), to: bord), (rel: (0.08, 0), to: bord),
    stroke: 1.2pt + accent, mark: (end: "straight", fill: accent, scale: 0.8))
  d.content((rel: (0.7, 0), to: bord), anchor: "west",
    box(stroke: 1pt + accent, fill: white, inset: (x: 5pt, y: 3pt), radius: 4pt,
      text(size: 10pt, weight: demi-gras, fill: accent)[#texte]))
}

// L'ellipse rouge autour d'une arête.
#let cerne(d, a, b, largeur: 0.55) = {
  let centre = ((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2)
  let h = calc.abs(b.at(1) - a.at(1)) / 2 + 0.35
  d.circle(centre, radius: (largeur, h), stroke: 1.1pt + rouge-attention)
}

// L'étoile de conflit et son mot.
#let marque-conflit(d, p, texte: "Conflit") = {
  let n = 10
  let sommets = range(n).map(i => {
    let a = 90deg + i * (360deg / n)
    let r = if calc.rem(i, 2) == 0 { 0.26 } else { 0.11 }
    (p.at(0) + r * calc.cos(a), p.at(1) + r * calc.sin(a))
  })
  d.line(..sommets, close: true, stroke: 0.9pt + rouge-attention, fill: white)
  d.content(
    (p.at(0) + 0.2, p.at(1) + 0.3),
    text(size: 9pt, fill: rouge-attention)[#texte],
    anchor: "south-west",
  )
}

// Deux traits qui joignent deux commits à un sommet portant un texte
// (« Même état »).
#let pont(d, a, b, texte, hauteur: 1.25) = {
  let sommet = ((a.at(0) + b.at(0)) / 2, a.at(1) + hauteur)
  d.line((a.at(0), a.at(1) + _pastille), sommet, stroke: 0.9pt + estompe)
  d.line((b.at(0), b.at(1) + _pastille), sommet, stroke: 0.9pt + estompe)
  d.content(sommet, text(size: 9pt, fill: accent)[#texte], anchor: "south")
}

// Une arête épaisse, d'un bord de pastille à l'autre, dans le sens de la
// fusion (de la branche fusionnée vers la branche qui reçoit).
#let arete-epaisse(d, a, b, epaisseur: 2.2pt) = {
  let dx = b.at(0) - a.at(0)
  let dy = b.at(1) - a.at(1)
  let norme = calc.sqrt(dx * dx + dy * dy)
  let (ux, uy) = (dx / norme, dy / norme)
  d.line(
    (a.at(0) + ux * _pastille, a.at(1) + uy * _pastille),
    (b.at(0) - ux * (_pastille + 0.1), b.at(1) - uy * (_pastille + 0.1)),
    stroke: epaisseur + accent, mark: (end: "straight", fill: accent, scale: 0.9),
  )
}

// Un texte au milieu d'une arête (« merge », « git revert »).
#let etiquette-arete(d, a, b, texte, decalage: (0, -0.3), taille: 9pt) = {
  d.content(
    ((a.at(0) + b.at(0)) / 2 + decalage.at(0), (a.at(1) + b.at(1)) / 2 + decalage.at(1)),
    text(size: taille, fill: accent)[#texte],
  )
}
