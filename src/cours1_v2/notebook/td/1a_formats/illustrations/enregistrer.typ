// La fenêtre d'enregistrement d'un export (TD 1a du cours 1 v2, étape 3) :
// elle s'ouvre dans `depart\`, le dossier du document ; on remonte d'un
// dossier, on ouvre `travail\`, puis on enregistre. Schéma, pas une capture :
// la fenêtre de Windows est simplifiée.
// Compilé en PNG par `outils/compiler_guides.py`.
#import "../../../../../commun/prelude.typ": *
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#set text(font: police-texte, size: 10pt, fill: accent, lang: "fr")

#let repere(n) = box(fill: brun, radius: 50%, inset: 3pt, text(size: 9pt, weight: "bold", fill: white)[#n])
#let dossier = box(width: 12pt, height: 10pt, baseline: 1.5pt, {
  place(top + left, rect(width: 5pt, height: 3pt, radius: 1pt, fill: brun.lighten(35%)))
  place(top + left, dy: 2pt, rect(width: 12pt, height: 8pt, radius: 1pt, fill: brun.lighten(55%)))
})
// La barre du haut : le bouton « dossier parent », puis le dossier courant.
#let barre(chemin, haut: false) = grid(
  columns: (auto, 1fr), column-gutter: 4pt, align: horizon,
  box(stroke: 0.6pt + estompe, inset: (x: 4pt, y: 2pt), radius: 2pt,
      fill: if haut { brun.lighten(80%) })[↑],
  block(width: 100%, stroke: 0.6pt + estompe, inset: (x: 5pt, y: 3pt), radius: 2pt,
        text(font: police-code, size: 9pt, chemin)),
)
#let ligne(corps, choisie: false) = block(
  width: 100%, inset: (x: 4pt, y: 3pt), above: 2pt, below: 2pt,
  fill: if choisie { brun.lighten(80%) }, corps,
)
#let bas(bouton: false) = [
  #v(4pt)
  #text(size: 9pt)[Nom du fichier : #text(font: police-code)[raven.pdf]] \
  #text(size: 9pt)[Type : PDF] #h(1fr)
  #box(stroke: 0.6pt + estompe, inset: (x: 5pt, y: 2pt), radius: 2pt,
       fill: if bouton { brun.lighten(80%) })[#text(size: 9pt)[Enregistrer]]
]
#let dialogue(corps) = fenetre("Exporter", hauteur: 4.9cm)[#corps]
#let legende-fenetre(corps) = block(width: 100%, above: 6pt, text(size: 9.5pt, fill: estompe, corps))

#grid(
  columns: (5.4cm, 5.4cm, 5.4cm), column-gutter: 10pt,
  [
    #dialogue[
      #barre([…\\depart], haut: true)
      #ligne(text(size: 9pt, fill: estompe)[aucun fichier PDF dans ce dossier])
      #v(1fr)
      #bas()
    ]
    #legende-fenetre[#repere(1) la fenêtre s'ouvre dans `depart\` : cliquer sur la flèche vers le haut]
  ],
  [
    #dialogue[
      #barre([…\\1a_formats])
      #ligne[#dossier #h(4pt) depart]
      #ligne(choisie: true)[#dossier #h(4pt) travail]
      #v(1fr)
      #bas()
    ]
    #legende-fenetre[#repere(2) dans `1a_formats\`, double-clic sur `travail`]
  ],
  [
    #dialogue[
      #barre([…\\travail])
      #ligne(text(size: 9pt, fill: estompe)[le dossier est vide])
      #v(1fr)
      #bas(bouton: true)
    ]
    #legende-fenetre[#repere(3) la barre indique `travail\` : cliquer sur « Enregistrer »]
  ],
)
