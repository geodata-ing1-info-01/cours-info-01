// Exporter le document de départ (TD 1a du cours 1 v2, étape 3) : le `.odt`
// de `depart\` ouvert dans Writer, le menu Fichier, les deux exports dans
// `travail\`. Schéma, pas une capture : le menu est abrégé.
// Compilé en PNG par `outils/compiler_guides.py`.
#import "../../../../../commun/prelude.typ": *
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#set text(font: police-texte, size: 10pt, fill: accent, lang: "fr")

#let repere(n) = box(fill: brun, radius: 50%, inset: 3pt, text(size: 9pt, weight: "bold", fill: white)[#n])
#let fichier = box(width: 9pt, height: 11pt, baseline: 2pt,
  rect(width: 9pt, height: 11pt, radius: 1pt, fill: white, stroke: 0.7pt + estompe))
#let entree(nom, choisie: false, n: none) = block(
  width: 100%, inset: (x: 4pt, y: 3pt), above: 2pt, below: 2pt,
  fill: if choisie { brun.lighten(80%) },
)[#fichier #h(4pt) #text(font: police-code, size: 9pt, nom) #if n != none [#h(1fr) #repere(n)]]
#let adresse(chemin) = block(
  width: 100%, stroke: 0.6pt + estompe, inset: (x: 5pt, y: 3pt), radius: 2pt,
  text(font: police-code, size: 9pt, chemin),
)
#let article(corps, choisi: false, n: none) = block(
  width: 100%, inset: (x: 5pt, y: 3pt), above: 1pt, below: 1pt,
  fill: if choisi { brun.lighten(80%) },
)[#corps #if n != none [#h(1fr) #repere(n)]]
#let legende-fenetre(corps) = block(width: 100%, above: 6pt, text(size: 9.5pt, fill: estompe, corps))
#let fleche = align(center + horizon, text(size: 22pt)[→])

#grid(
  columns: (4.6cm, 0.5cm, 7cm, 0.5cm, 4.6cm),
  align: (left + top, center + horizon, left + top, center + horizon, left + top),
  [
    #fenetre("depart")[
      #adresse[…\\depart]
      #entree("raven.odt", choisie: true, n: 1)
      #entree("raven_brut.html")
      #entree("style.css")
    ]
    #legende-fenetre[#repere(1) double-clic sur le document de départ, qui reste dans `depart\`]
  ],
  fleche,
  [
    #fenetre("raven.odt - LibreOffice Writer")[
      #box(fill: brun.lighten(80%), inset: (x: 4pt, y: 2pt))[Fichier] #h(6pt) Édition #h(6pt) Affichage
      #block(width: 100%, stroke: 0.8pt + accent.lighten(55%), radius: 3pt, inset: 3pt, above: 4pt)[
        #article[Enregistrer]
        #article[Enregistrer sous…]
        #article(choisi: true, n: 3)[Exporter…]
        #article(choisi: true, n: 2)[Exporter sous › Exporter au format PDF…]
        #article[Fermer]
      ]
    ]
    #legende-fenetre[#repere(2) l'export en PDF, puis #repere(3) l'export en PNG. Le titre de la fenêtre reste `raven.odt`.]
  ],
  fleche,
  [
    #fenetre("travail")[
      #adresse[…\\travail]
      #entree("raven.pdf")
      #entree("raven.png")
    ]
    #legende-fenetre[les deux exports, enregistrés dans `travail\`]
  ],
)
