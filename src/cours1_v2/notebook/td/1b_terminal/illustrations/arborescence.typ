// Les dossiers du cours 1 et les chemins relatifs du TD 1b (cours 1 v2) :
// d'où partent `depart`, `..` et `../1a_formats/travail` quand le dossier
// courant est `1b_terminal`.
#import "../../../../../commun/prelude.typ": *
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#set text(font: police-texte, size: 10pt, fill: accent, lang: "fr")
#let d(t, courant: false) = box(
  inset: (x: 5pt, y: 3pt), radius: 2pt,
  stroke: if courant { 1.4pt + brun } else { 0.7pt + accent.lighten(50%) },
  fill: if courant { brun.lighten(85%) } else { white },
  text(font: police-code, size: 10pt)[#t],
)
#grid(
  columns: (8.5cm, 8.5cm), column-gutter: 0.6cm, align: top,
  [
    #set par(leading: 0.75em)
    #d("~/Desktop/info01/cours1/") \
    #h(1.0cm) #d("1a_formats/") \
    #h(2.0cm) #d("depart/") \
    #h(2.0cm) #d("travail/") #text(size: 9pt, fill: estompe)[les exports du TD 1a] \
    #h(1.0cm) #d("1b_terminal/", courant: true) #text(size: 9pt, fill: brun)[dossier courant] \
    #h(2.0cm) #d("depart/") \
    #h(2.0cm) #d("travail/") \
    #h(1.0cm) #d("1c_programme/") \
    #h(1.0cm) #text(fill: estompe)[…]
  ],
  table(
    columns: (auto, 1fr), stroke: 0.5pt + estompe.lighten(40%), inset: 5pt,
    [Chemin tapé], [Dossier désigné, depuis `1b_terminal/`],
    [`depart`], [`1b_terminal/depart/`],
    [`.`], [`1b_terminal/` lui-même],
    [`..`], [`cours1/`, le dossier parent],
    [`../1a_formats/travail`], [remonte à `cours1/`, puis descend dans `1a_formats/travail/`],
    [`~/Desktop/info01`], [le même dossier depuis n'importe où : `~` part du dossier personnel],
  ),
)
