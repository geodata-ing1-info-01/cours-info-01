// Le dossier partagé et le dossier du Bureau (TD 1a du cours 1 v2).
// Compilé en PNG par `outils/compiler_guides.py`.
#import "../../../../../commun/prelude.typ": *
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#set text(font: police-texte, size: 10pt, fill: accent, lang: "fr")

// Une icône de dossier, ou d'archive (fermeture éclair sur le dossier).
#let icone(archive: false) = box(width: 14pt, height: 11pt, baseline: 1.5pt, {
  place(top + left, rect(width: 6pt, height: 3pt, radius: 1pt, fill: brun.lighten(35%)))
  place(top + left, dy: 2pt, rect(width: 14pt, height: 9pt, radius: 1pt, fill: brun.lighten(55%)))
  if archive {
    for i in range(4) {
      place(top + left, dx: 6pt, dy: 2.5pt + i * 2pt, rect(width: 2pt, height: 1pt, fill: accent))
    }
  }
})

#let adresse(chemin) = block(
  width: 100%, stroke: 0.6pt + estompe, inset: (x: 6pt, y: 4pt), radius: 2pt,
  text(font: police-code, size: 9.5pt, chemin),
)

// Une fenêtre de l'explorateur : la barre d'adresse, puis les entrées.
#let explorateur(chemin, entrees) = {
  set text(size: 10pt)
  fenetre("Explorateur de fichiers", hauteur: 3.5cm)[
    #adresse(chemin)
    #v(4pt)
    #for (archive, nom) in entrees [
      #block(above: 5pt, below: 5pt)[#icone(archive: archive) #h(4pt) #text(font: police-code, size: 9.5pt, nom)]
    ]
  ]
}

#let legende-fenetre(corps) = block(width: 100%, above: 6pt, text(size: 9.5pt, fill: estompe, corps))

#grid(
  columns: (7cm, 3cm, 7cm),
  align: (left + top, center + top, left + top),
  [
    #explorateur("\\\\serveur\\formationTemp", ((true, "info01-cours1.zip"),))
    #legende-fenetre[le dossier partagé, sur un serveur de l'école : ne pas y travailler]
  ],
  [
    #v(1.3cm)
    #text(size: 10pt, weight: demi-gras)[copier]
    #v(-4pt)
    #text(size: 26pt)[→]
  ],
  [
    #explorateur("C:\\Users\\eleve\\Desktop\\info01", ((false, "cours1"), (true, "info01-cours1.zip")))
    #legende-fenetre[le Bureau du poste : on y copie et on y travaille]
  ],
)
