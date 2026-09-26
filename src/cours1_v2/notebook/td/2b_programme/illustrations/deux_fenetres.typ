// Le programme du TD 2b (cours 1 v2) : `altitudes.py` dans Notepad++ à
// gauche, Git Bash à droite, où il est lancé. Schéma, pas une capture.
#import "../../../../../commun/prelude.typ": *
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#set text(font: police-texte, size: 10pt, fill: accent, lang: "fr")
#let repere(n) = box(fill: brun, radius: 50%, inset: 3pt, text(size: 9pt, weight: "bold", fill: white)[#n])
#block(width: 17cm)[
  #grid(
    columns: (1fr, 1fr), column-gutter: 10pt,
    fenetre("altitudes.py — Notepad++")[
      #text(size: 8.5pt, fill: estompe)[Fichier  Édition  Recherche  Affichage …]
      #v(3pt)
      #box(fill: gris, inset: (x: 5pt, y: 2pt))[#text(size: 9pt)[altitudes.py] #repere(1)]
      #v(3pt)
      ```python
      """Moyenne d'une série d'altitudes."""

      altitudes = [128.4, 131.0, 127.6]
      total = 0
      for altitude in altitudes:
          total = total + altitude
      moyenne = total / len(altitudes)
      print(f"moyenne : {moyenne:.1f} m")
      ```
    ],
    block(width: 100%, stroke: 1pt + accent.lighten(55%))[
      #block(width: 100%, fill: gris, inset: (x: 9pt, y: 6pt))[#text(size: 10pt, fill: estompe)[MINGW64:/c/Users/eleve/Desktop/info01/cours1/2b_programme]]
      #block(width: 100%, fill: rgb("#101010"), inset: 8pt)[
        #set text(font: police-code, size: 8.5pt, fill: white)
        (base) \
        #text(fill: rgb("#2f9e44"))[eleve\@POSTE-12] #text(fill: rgb("#9c36b5"))[MINGW64] #text(fill: rgb("#b08800"))[\~/Desktop/info01/cours1/2b_programme] \
        \$ python altitudes.py #repere(2) \
        moyenne : 129.0 m #repere(3) \
        \
        (base) \
        #text(fill: rgb("#2f9e44"))[eleve\@POSTE-12] #text(fill: rgb("#9c36b5"))[MINGW64] #text(fill: rgb("#b08800"))[\~/Desktop/info01/cours1/2b_programme] \
        \$ #box(width: 5pt, height: 9pt, fill: white)
      ]
    ],
  )
]
#v(4pt)
#block(width: 17cm, text(size: 9.5pt, fill: estompe)[
  #repere(1) l'onglet du fichier ; une disquette rouge y signale un fichier
  modifié et non enregistré (`Ctrl` + `S`) ; #repere(2) la commande, tapée
  dans Git Bash, dans le dossier du fichier ; #repere(3) ce que le
  programme écrit. Les deux fenêtres restent ouvertes côte à côte.
])
