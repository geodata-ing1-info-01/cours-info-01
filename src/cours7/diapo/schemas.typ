// Schémas du projet 7 : les effets du TD 7b, montrés par des images
// calculées par les programmes du TD (`data/cours7/make_data.py
// illustrations`, dans `illustrations/cours7/`), et, pour le TD 7a, la page
// d'une recette et le sommaire, dessinés d'après la sortie réelle du
// programme (`python recette.py crepes -p 6 --page`, `--toutes --page`).
//
// Employés par les diapositives (`cours7.typ`, `tds/7a_recette.typ`,
// `tds/7b_train.typ`) et par les illustrations des guides
// (`notebook/td/<td>/illustrations/*.typ`).
#import "../../commun/theme.typ": accent, attention, encre, estompe, gris, police-code, demi-gras

#let _dossier = "/illustrations/cours7/"

// Une image, et sa légende dessous, en petit.
#let _vignette(fichier, legende, largeur) = stack(
  spacing: 5pt,
  box(stroke: 0.6pt + estompe, image(_dossier + fichier, width: largeur)),
  box(width: largeur, align(center, text(size: 10pt, fill: estompe, legende))),
)
#let _signe(s) = align(center + horizon, text(size: 18pt, fill: accent, s))

// ---- TD 7b ----------------------------------------------------------------

// L'objectif du TD : le départ, chaque effet seul, puis les deux.
#let effets-train(largeur: 4.9cm) = grid(
  columns: 4, column-gutter: 10pt, align: top,
  _vignette("train_depart.png", [au départ : deux plans qui défilent sur le fond], largeur),
  _vignette("train_avec_fenetre.png", [effet 1 : la fenêtre du train, posée par-dessus], largeur),
  _vignette("train_avec_poteaux.png", [effet 2 : les ombres des poteaux, qui passent vite], largeur),
  _vignette("train_final.png", [l'objectif : les deux effets], largeur),
)

// Les couches de l'image de départ : le fond, puis chaque plan.
#let couches-depart(largeur: 3.6cm) = grid(
  columns: 7, column-gutter: 6pt, align: horizon,
  _vignette("train_fond.png", [le fond, fixe], largeur), _signe("+"),
  _vignette("train_voiles.png", [les voiles, 4 pixels par image], largeur), _signe("+"),
  _vignette("train_plage_jaune.png", [la plage, 8 pixels par image], largeur), _signe("="),
  _vignette("train_depart.png", [l'image], largeur),
)

// L'effet 1 : la fenêtre, dont la vitre est transparente, posée en dernier.
#let effet-fenetre(largeur: 4.4cm) = grid(
  columns: 5, column-gutter: 6pt, align: horizon,
  _vignette("train_depart.png", [l'image de départ], largeur), _signe("+"),
  _vignette("train_fenetre.png", [`decor/fenetre.png` : la vitre transparente], largeur), _signe("="),
  _vignette("train_avec_fenetre.png", [la vue depuis le train], largeur),
)

// L'effet 2 : le calque des poteaux, calculé avec numpy, posé sur le paysage.
#let effet-poteaux(largeur: 4.4cm) = grid(
  columns: 5, column-gutter: 6pt, align: horizon,
  _vignette("train_depart.png", [l'image de départ], largeur), _signe("+"),
  _vignette("train_calque_poteaux.png", [le calque : des bandes sombres, transparent ailleurs], largeur), _signe("="),
  _vignette("train_avec_poteaux.png", [les ombres des poteaux], largeur),
)

// ---- TD 7a ----------------------------------------------------------------

// Une fenêtre de navigateur dessinée : la barre d'adresse, puis la page.
#let _navigateur(adresse, largeur, corps) = block(
  width: largeur, stroke: 1pt + estompe, radius: 3pt, clip: true,
)[
  #block(width: 100%, fill: gris, inset: (x: 8pt, y: 5pt), below: 0pt)[
    #set align(left)
    #text(font: police-code, size: 9pt, fill: estompe, adresse)
  ]
  #block(width: 100%, inset: (x: 12pt, y: 8pt), fill: rgb("#faf8f4"))[
    #set align(left)
    #set text(size: 10pt, fill: rgb("#2b2b2b"))
    #set par(leading: 0.5em)
    #corps
  ]
]

// La page de la recette des crêpes pour 6 personnes, telle que pandoc
// l'écrit avec `style.css` : les valeurs sont celles du programme.
#let page-recette(largeur: 8.2cm) = _navigateur("sortie/crepes.html", largeur)[
  #text(size: 16pt, weight: demi-gras)[Crêpes] \
  #emph[10 minutes de préparation, 1 heure de repos.]
  #v(3pt)
  #text(size: 11pt, weight: demi-gras)[Ingrédients pour 6 personnes, en unités SI]
  #v(-2pt)
  #table(
    columns: (auto, auto), inset: (x: 6pt, y: 2.5pt), stroke: (x, y) => (bottom: 0.4pt + estompe),
    [*Ingrédient*], [*Quantité*],
    [Farine], [375.0 g], [Lait], [750.0 ml], [Œufs], [6.0], [Sel], [3.0 g], [Beurre fondu], [75.0 g],
  )
  #v(2pt)
  #text(size: 11pt, weight: demi-gras)[Préparation] \
  1. Mélanger la farine et le sel dans un saladier. \
  2. Casser les œufs au centre et mélanger. \
  …
]

// Le sommaire : un lien par recette, le titre de chaque fichier .md.
#let sommaire-recettes(largeur: 6cm) = _navigateur("sortie/index.html", largeur)[
  #text(size: 16pt, weight: demi-gras)[Le livre de recettes]
  #v(2pt)
  #set text(fill: rgb("#1a5276"))
  #for titre in ("Cookies au chocolat", "Crêpes", "Gâteau au yaourt", "Mousse au chocolat",
                 "Omelette au fromage", "Pancakes", "Pâte à pizza", "Quiche lorraine",
                 "Ratatouille", "Tarte aux pommes") [
    • #underline(titre) \
  ]
]
