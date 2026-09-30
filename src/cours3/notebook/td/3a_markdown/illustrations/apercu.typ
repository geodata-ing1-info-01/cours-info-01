// VS Code : `recette.md` des gaufres à gauche, son aperçu à droite (étape 2
// du TD 3a). Compilé en PNG par `outils/compiler_guides.py` et
// `outils/construire_notebooks.py`.
#import "../../../../../commun/illustrations_td.typ": vscode-apercu
#import "../../../../../commun/theme.typ": gris
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#vscode-apercu("recettes", "recette.md", (
  "# Gaufres",
  "",
  "*Pour 8 gaufres, 10 minutes de préparation…*",
  "",
  "![Une gaufre, sortie du gaufrier.](photo.jpg)",
  "",
  "## Ingrédients",
  "",
  "## Préparation",
  "",
  "1. Mélanger la farine, le sucre, la levure…",
  "2. Creuser un puits au centre…",
  "3. Verser le lait **peu à peu**, sans…",
  "…",
), [
  #text(size: 15pt, weight: "bold")[Gaufres] \
  #emph[Pour 8 gaufres…]
  #v(2pt)
  #box(width: 100%, height: 1.0cm, fill: rgb("#e4a64a").lighten(30%), radius: 2pt)[#align(center + horizon, text(size: 8pt)[photo.jpg])]
  #v(2pt)
  #text(size: 11pt, weight: "bold")[Ingrédients]
  #v(-4pt)
  #line(length: 100%, stroke: 0.5pt + gris.darken(20%))
  #text(size: 11pt, weight: "bold")[Préparation]
  #v(-4pt)
  #line(length: 100%, stroke: 0.5pt + gris.darken(20%))
  1. Mélanger la farine, le sucre… \
  2. Creuser un puits au centre…
], fichiers: ("crepes", "gaufres", "mousse_chocolat", "pate_pizza", "salade_lentilles", ".gitignore", "style.css"))
