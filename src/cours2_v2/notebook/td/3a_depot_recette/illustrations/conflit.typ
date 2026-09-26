// `recette.md` ouvert dans VS Code pendant le conflit de l'étape 6 du TD 3a :
// les deux versions de la ligne, les marqueurs, et les actions proposées
// au-dessus. Schéma, pas une capture : libellés de VS Code en anglais.
#import "../../../../../commun/theme.typ": accent, estompe, gris, brun, demi-gras, police-texte, police-code
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#set text(font: police-texte, size: 10pt, fill: accent, lang: "fr")
#let ligne(t, fond: white, couleur: accent) = block(
  width: 100%, fill: fond, inset: (x: 6pt, y: 2.5pt), above: 0pt, below: 0pt,
  text(font: police-code, size: 8.5pt, fill: couleur, raw(t)),
)
#block(width: 16cm, stroke: 0.8pt + accent.lighten(55%), clip: true)[
  #block(width: 100%, fill: gris, inset: (x: 8pt, y: 5pt))[
    #text(weight: demi-gras)[recette.md] #h(4pt) #text(fill: brun, weight: demi-gras)[!] #h(1fr) #text(fill: estompe)[travail — Visual Studio Code]
  ]
  #ligne("# Crêpes")
  #ligne("")
  #block(width: 100%, inset: (x: 6pt, y: 2pt))[
    #text(size: 8.5pt, fill: estompe)[Accept Current Change | Accept Incoming Change | Accept Both Changes | Compare Changes]
  ]
  #ligne("<<<<<<< HEAD (Current Change)", fond: rgb("#d7efd7"))
  #ligne("*Pour 12 crêpes — 10 minutes de préparation, 2 heures de repos.*", fond: rgb("#e8f6e8"))
  #ligne("=======", fond: gris.lighten(20%))
  #ligne("*Pour 18 crêpes — 10 minutes de préparation, 1 heure de repos.*", fond: rgb("#e3eef8"))
  #ligne(">>>>>>> pour-18 (Incoming Change)", fond: rgb("#cfe1f3"))
  #ligne("")
  #ligne("![Une crêpe qui cuit, une minute par face.](crepes.jpg)")
]
#v(4pt)
#block(width: 16cm, text(size: 9.5pt, fill: estompe)[
  En vert, la version de la branche courante (`master`, « Current ») ; en
  bleu, celle de la branche fusionnée (`pour-18`, « Incoming »). Les quatre
  liens au-dessus remplacent le bloc par l'une, l'autre ou les deux. Ici,
  la bonne ligne prend un morceau de chacune : l'écrire à la main.
])
