// Schémas du TD 4c : la composition d'une image de la vidéo, étape par étape,
// avec les images du décor. Ils servent en tête du notebook `train.ipynb` et
// du guide : chacun a son fichier `src/cours4/notebook/td/4c_train/
// illustrations/<nom>.typ`, compilé en PNG par `outils/compiler_guides.py` et
// `outils/construire_notebooks.py`.
//
// Les images viennent de `illustrations/cours4/train_*.png`, tirées du décor
// par `data/cours4/make_data.py illustrations`. Un damier gris et blanc y
// marque les pixels transparents. Les décalages montrés (400 et 1 500) sont
// ceux de `DECALAGE_SCHEMA` et `DEBORDEMENT_SCHEMA` dans `make_data.py`.
#import "../../commun/theme.typ": accent, alerte, estompe, police-texte, police-code, demi-gras

#let _dossier = "/illustrations/cours4/"
#let _bande = 1920
#let _image = 640
#let _hauteur = 480

// Un nombre de pixels écrit à la française : 1 919, avec une espace insécable.
#let _n(n) = {
  let s = str(n)
  if s.len() > 3 { s.slice(0, s.len() - 3) + "\u{00A0}" + s.slice(s.len() - 3) } else { s }
}

#let _style(corps) = {
  set text(font: police-texte, size: 10pt, fill: accent, lang: "fr")
  show raw: set text(font: police-code)
  corps
}

// Les colonnes `debut` à `debut + largeur` de l'image `nom`, large de
// `native` pixels, à l'échelle `ech` (longueur par pixel).
#let _morceau(nom, debut, largeur, ech, native: _bande) = box(
  width: largeur * ech, height: _hauteur * ech, clip: true,
  place(dx: -debut * ech, image(_dossier + nom, width: native * ech)),
)

// Une image de 640 × 480 pixels et sa légende, sous elle.
#let _vignette(corps, legende, largeur) = stack(
  spacing: 4pt,
  box(width: largeur, height: largeur * 3 / 4, corps),
  box(width: largeur, align(center, text(fill: estompe)[#legende])),
)

#let _cadre(ech, x, largeur, trait: 2pt + accent) = place(
  top + left, dx: x * ech,
  rect(width: largeur * ech, height: _hauteur * ech, stroke: trait),
)

// Une cote horizontale au-dessus d'une image : une flèche de x1 à x2 et son texte.
#let _cote(ech, x1, x2, texte, dy: -16pt) = place(
  top + left, dx: x1 * ech, dy: dy,
  box(width: (x2 - x1) * ech)[
    #place(bottom + left, dy: 0pt, line(length: (x2 - x1) * ech, stroke: 0.8pt + accent))
    #place(bottom + left, dy: 3pt, line(angle: 90deg, length: 6pt, stroke: 0.8pt + accent))
    #place(bottom + right, dy: 3pt, line(angle: 90deg, length: 6pt, stroke: 0.8pt + accent))
    #place(center + bottom, dy: -2pt, box(width: 8cm, align(center, box(fill: white, inset: (x: 3pt), texte))))
  ],
)

// ---------------------------------------------------------------------------
// La composition : le fond, puis le plan posé dessus, puis la fenêtre.
#let composition(largeur: 4.6cm) = _style({
  let ech = largeur / _image
  let signe(s) = align(center + horizon, text(size: 20pt, fill: accent)[#s])
  let ligne(numero, titre, a, b, c) = (
    grid.cell(colspan: 5, align(left, text(weight: demi-gras)[#numero · #titre])),
    a, signe("+"), b, signe("="), c,
  )
  grid(
    columns: (largeur, 1cm, largeur, 1cm, largeur),
    row-gutter: 8pt,
    ..ligne("1", "Le plan posé sur le fond",
      _vignette(image(_dossier + "train_fond.png", width: largeur), [le fond, fixe], largeur),
      _vignette(_morceau("train_plan.png", 400, _image, ech), [le plan, découpé dans la bande], largeur),
      _vignette(image(_dossier + "train_plan_sur_fond.png", width: largeur), [le fond et le plan], largeur)),
    grid.cell(colspan: 5, v(6pt)),
    ..ligne("2", "La fenêtre posée par-dessus",
      _vignette(image(_dossier + "train_plan_sur_fond.png", width: largeur), [le fond et le plan], largeur),
      _vignette(image(_dossier + "train_fenetre.png", width: largeur), [la fenêtre, fixe], largeur),
      _vignette(image(_dossier + "train_image.png", width: largeur), [l'image de la vidéo], largeur)),
  )
  v(2pt)
  text(size: 9pt, fill: estompe)[Le damier marque les pixels transparents.]
})

// ---------------------------------------------------------------------------
// L'emprise : un rectangle de 640 × 480 pixels, à la colonne `decalage` de la
// bande ; dessous, le plan de l'image, découpé dans l'emprise.
#let emprise(decalage: 400, largeur: 17cm) = _style({
  let ech = largeur / _bande
  text(weight: demi-gras)[La bande du plan, 1~920 × 480 pixels, et l'emprise à la colonne #_n(decalage)]
  block(width: largeur, height: _hauteur * ech, above: 38pt)[
    #image(_dossier + "train_plan.png", width: largeur)
    #_cadre(ech, decalage, _image)
    #_cote(ech, 0, decalage, [décalage : #_n(decalage) pixels])
    #_cote(ech, decalage, decalage + _image, [l'emprise : 640 pixels])
  ]
  box(width: largeur, grid(
    columns: (1fr, 1fr),
    align(left, text(fill: estompe)[colonne 0]),
    align(right, text(fill: estompe)[colonne 1~919]),
  ))
  v(4pt)
  pad(left: decalage * ech, stack(
    spacing: 4pt,
    box(width: _image * ech, align(center, text(size: 14pt)[↓])),
    stack(
      dir: ltr, spacing: 12pt,
      box(stroke: 2pt + accent, _morceau("train_plan.png", decalage, _image, ech)),
      align(horizon, text(fill: estompe)[
        le plan de l'image : 640 × 480 pixels, \ colonnes #_n(decalage) à #_n(decalage + _image - 1)
      ]),
    ),
  ))
})

// ---------------------------------------------------------------------------
// Le débordement : à la colonne `decalage`, l'emprise dépasse la bande ; la
// bande tournée de `decalage` colonnes vers la gauche, puis l'emprise à la
// colonne 0.
#let debordement(decalage: 1500, largeur: 15cm) = _style({
  let ech = largeur / _bande
  let reste = _bande - decalage            // les colonnes de l'emprise dans la bande
  let dehors = _image - reste               // les colonnes hors de la bande
  let raccord(x) = place(top + left, dx: x * ech,
    line(angle: 90deg, length: _hauteur * ech, stroke: (paint: alerte, thickness: 1.5pt, dash: "dashed")))

  text(weight: demi-gras)[1 · Découper l'emprise à la colonne #_n(decalage)]
  block(width: largeur + dehors * ech, height: _hauteur * ech, above: 38pt, below: 4pt)[
    #image(_dossier + "train_plan.png", width: largeur)
    #_cadre(ech, decalage, reste)
    #place(top + left, dx: _bande * ech, rect(width: dehors * ech, height: _hauteur * ech,
      stroke: (paint: alerte, thickness: 2pt, dash: "dashed")))
    #_cote(ech, decalage, _bande + dehors, [l'emprise : 640 pixels])
  ]
  box(width: largeur + dehors * ech, grid(
    columns: (1fr, auto),
    text(fill: estompe)[Le découpage garde #reste × 480 pixels.],
    text(fill: alerte)[#dehors colonnes hors de la bande],
  ))

  v(14pt)
  text(weight: demi-gras)[2 · Faire tourner la bande de #_n(decalage) colonnes vers la gauche, puis découper à la colonne 0]
  block(width: largeur, height: _hauteur * ech, above: 38pt)[
    #box(_morceau("train_plan.png", decalage, reste, ech))#box(_morceau("train_plan.png", 0, decalage, ech))
    #raccord(reste)
    #_cadre(ech, 0, _image)
    #_cote(ech, 0, reste, [#_n(decalage) à 1~919])
    #_cote(ech, reste, _bande, [colonnes 0 à #_n(decalage - 1)])
  ]
  v(4pt)
  stack(
    dir: ltr, spacing: 12pt,
    box(stroke: 2pt + accent)[
      #box(_morceau("train_plan.png", decalage, reste, ech))#box(_morceau("train_plan.png", 0, dehors, ech))
      #raccord(reste)
    ],
    align(horizon, text(fill: estompe)[
      le plan de l'image : 640 × 480 pixels, \
      colonnes #_n(decalage) à 1~919, puis 0 à #(dehors - 1) ; \
      #text(fill: alerte)[tirets] : le raccord de la bande
    ]),
  )
})

// ---------------------------------------------------------------------------
// La bande enroulée sur un cylindre (image de `make_data.py`), et sa légende.
#let cylindre(hauteur: 7cm) = _style(grid(
  columns: (auto, 7.5cm),
  column-gutter: 14pt,
  image(_dossier + "train_cylindre.png", height: hauteur),
  align(horizon, stack(
    spacing: 12pt,
    [La bande du plan, 1~920 pixels de long, enroulée sur un cylindre : la
     colonne 1~919 touche la colonne 0 (#text(fill: alerte)[tirets]).],
    [#box(width: 1.2em, line(length: 1.2em, stroke: 2pt + accent)) L'emprise,
     face à nous : colonnes 1~500 à 1~919, puis 0 à 219.],
    [Faire tourner le cylindre de 8 colonnes amène devant nous l'emprise de
     l'image suivante. Sur le cylindre, l'emprise ne dépasse jamais.],
  )),
))

// ---------------------------------------------------------------------------
// Deux images de la vidéo côte à côte, chacune avec sa légende : ce que le
// guide fait vérifier (étapes B3 et B4).
#let _deux-images(a, legende-a, b, legende-b, largeur: 7.5cm) = _style(grid(
  columns: (largeur, largeur),
  column-gutter: 16pt,
  _vignette(image(_dossier + a, width: largeur), legende-a, largeur),
  _vignette(image(_dossier + b, width: largeur), legende-b, largeur),
))

#let decoupe-1500() = _deux-images(
  "train_decoupe_1500.png", [découpé à la colonne 1~500 : le plan ne mesure que 420 pixels de large],
  "train_tourne_1500.png", [la bande tournée de 1~500 colonnes, puis découpée à la colonne 0],
)

#let ordre-composition() = _deux-images(
  "train_image.png", [le plan, puis la fenêtre : la fenêtre cache les bords du plan],
  "train_ordre_inverse.png", [la fenêtre, puis le plan : la plage passe sur le cadre],
)

// ---------------------------------------------------------------------------
// L'annexe : plusieurs plans, chacun avec sa vitesse, posés du plus lointain
// au plus proche. Les décalages sont ceux de l'image numéro 40
// (`NUMERO_PLANS` et `PLANS_ANNEXE` dans `make_data.py`).
#let plans(largeur: 2.75cm, numero: 40) = _style({
  let ech = largeur / _image
  let couche(corps, titre, vitesse) = stack(
    spacing: 4pt,
    box(width: largeur, height: largeur * 3 / 4, corps),
    box(width: largeur, align(center)[#text(weight: demi-gras)[#titre] \ #text(fill: estompe)[#vitesse]]),
  )
  let plan(nom, titre, vitesse) = couche(
    _morceau("train_bande_" + nom + ".png", calc.rem(numero * vitesse, _bande), _image, ech),
    titre, [#vitesse px par image \ décalage #_n(numero * vitesse)],
  )
  let signe(s) = align(center + horizon, text(size: 16pt)[#s])
  grid(
    columns: (largeur, 0.5cm) * 5 + (largeur * 1.5,),
    align: top,
    couche(image(_dossier + "train_fond.png", width: largeur), [le fond], [fixe]), signe("+"),
    plan("voiles", [les voiles], 2), signe("+"),
    plan("plage_jaune", [la plage jaune], 8), signe("+"),
    plan("plage", [la plage orange], 16), signe("+"),
    couche(image(_dossier + "train_fenetre.png", width: largeur), [la fenêtre], [fixe]), signe("="),
    stack(spacing: 4pt,
      image(_dossier + "train_plans.png", width: largeur * 1.5),
      box(width: largeur * 1.5, align(center, text(fill: estompe)[l'image numéro #numero]))),
  )
})
