// Ouvrir Git Bash dans un dossier, depuis l'explorateur de Windows 11 : le
// menu du clic droit, puis « Afficher d'autres options », puis « Open Git
// Bash here ». Schéma, pas une capture : les entrées des menus sont
// abrégées. À remplacer par une capture d'un poste de la salle.
#import "../../../../../commun/prelude.typ": *
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#set text(font: police-texte, size: 10pt, fill: accent, lang: "fr")
#let repere(n) = box(fill: brun, radius: 50%, inset: 3pt, text(size: 9pt, weight: "bold", fill: white)[#n])
#let entree(t, choisie: false, n: none) = block(
  width: 100%, inset: (x: 6pt, y: 3pt), above: 0pt, below: 0pt,
  fill: if choisie { brun.lighten(80%) } else { white },
)[#t #if n != none [#h(1fr) #repere(n)]]
#let menu(largeur, ..entrees) = block(width: largeur, stroke: 0.8pt + accent.lighten(55%), inset: 3pt, fill: white, radius: 3pt)[
  #for e in entrees.pos() { e }
]
#block(width: 17cm)[
  #fenetre("2a_terminal — Explorateur de fichiers")[
    #block(width: 100%, stroke: 0.6pt + estompe.lighten(40%), inset: 4pt)[
      #text(font: police-code, size: 9pt)[C:\\Users\\eleve\\Desktop\\info01\\cours1\\2a_terminal]
    ]
    #v(4pt)
    #grid(
      columns: (4.5cm, 5.2cm, 5.2cm), column-gutter: 8pt,
      [
        #text(size: 9.5pt)[depart] \
        #text(size: 9.5pt)[travail] \
        #text(size: 9.5pt)[td_2a_terminal.pdf] \
        #v(6pt)
        #text(size: 9pt, fill: estompe)[clic droit sur un endroit vide de la fenêtre] #repere(1)
      ],
      menu(5.2cm,
        entree[Affichage],
        entree[Trier par],
        entree[Nouveau],
        entree[Propriétés],
        entree([Afficher d'autres options], choisie: true, n: 2),
      ),
      menu(5.2cm,
        entree[Open with Code],
        entree([Open Git Bash here], choisie: true, n: 3),
        entree[Open Git GUI here],
        entree[Coller],
        entree[Nouveau],
      ),
    )
  ]
]
#v(4pt)
#block(width: 17cm, text(size: 9.5pt, fill: estompe)[
  #repere(1) clic droit sur un endroit vide du dossier ; #repere(2) sous
  Windows 11, « Afficher d'autres options » ouvre l'ancien menu ;
  #repere(3) « Open Git Bash here » ouvre Git Bash dans ce dossier. Schéma :
  les menus réels ont plus d'entrées.
])
