// « L'invite de Git Bash » (diapo/parties/02_terminal.typ) : la fenêtre de la
// diapositive, avec les couleurs de l'invite réelle, assombries pour le fond
// blanc. Le tableau de la diapositive est dans la page. Le nom du poste est
// inventé.
#import "_gabarit.typ": *
#show: schema-de-cours.with(largeur: 17cm)

#let vert = rgb("#1a7f37")
#let violet = rgb("#a2248f")
#let jaune = rgb("#9a6700")
#let invite = (
  text(fill: vert, "eleve@POSTE-12"), " ",
  text(fill: violet, "MINGW64"), " ",
  text(fill: jaune, "~/Desktop/info01/cours1"),
).join()

#fenetre("MINGW64:/c/Users/eleve/Desktop/info01/cours1", code: true)[
  #set text(size: 15pt)
  #invite \
  \$ ls \
  1a#sym.underscore;formats/#h(0.6em)1b#sym.underscore;terminal/#h(0.6em)1c#sym.underscore;programme/#h(0.6em)1d#sym.underscore;notebook/ \
  #v(0.4em)
  #invite \
  \$
]
