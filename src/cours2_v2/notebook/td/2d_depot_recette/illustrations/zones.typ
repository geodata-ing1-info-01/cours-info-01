// Les trois zones de git et les commandes qui font passer de l'une à
// l'autre, pour le guide du TD 2d.
#import "../../../../../commun/theme.typ": accent, estompe, gris, brun, demi-gras, police-texte, police-code
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#set text(font: police-texte, size: 11pt, fill: accent, lang: "fr")
#let zone(titre, detail, fond) = block(
  width: 4.8cm, height: 3.1cm, fill: fond, stroke: 0.9pt + accent, inset: 8pt,
)[
  #align(center)[#text(weight: demi-gras)[#titre] \ #v(2pt) #text(size: 9.5pt, fill: estompe)[#detail]]
]
#let fleche(commande, sens: "→") = align(center + horizon)[
  #text(font: police-code, size: 9.5pt)[#commande] \ #text(size: 20pt)[#sens]
]
#grid(
  columns: 5, column-gutter: 6pt, align: horizon,
  zone("Dossier de travail", [les fichiers tels qu'ils sont sur le disque ; `git status` : « non suivis », « ne seront pas validées »], white),
  fleche("git add"),
  zone("Index", [ce qui entrera dans le prochain commit ; `git status` : « seront validées »], gris.lighten(30%)),
  fleche("git commit"),
  zone("Dépôt", [l'historique, dans le dossier caché `.git` ; `git log`], gris),
)
#v(6pt)
#block(width: 16cm, text(size: 9.5pt, fill: estompe)[
  `git restore fichier` remet dans le dossier de travail la version du dernier
  commit ; `git restore --staged fichier` retire un fichier de l'index sans
  toucher au disque.
])
