// VS Code, `travail/recette.md` à gauche et son aperçu à droite, au milieu
// de l'étape 2 du TD 2a (cours 2 v2).
#import "../../../../../commun/illustrations_td.typ": vscode-apercu
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#vscode-apercu("2a_markdown", "recette.md", (
  "# Crêpes",
  "",
  "Pour 12 crêpes, 10 minutes de",
  "préparation, 1 heure de repos.",
  "",
  "## Ingrédients",
  "farine 250 g",
  "oeufs 4",
  "lait 500 ml",
  "",
  "## Préparation",
  "",
  "1. Mélanger la farine et le sel.",
  "2. Casser les oeufs au centre.",
), [
  #text(size: 14pt, weight: "bold")[Crêpes]
  #v(2pt)
  Pour 12 crêpes, 10 minutes de préparation, 1 heure de repos.
  #v(2pt)
  #text(size: 11pt, weight: "bold")[Ingrédients]
  #v(2pt)
  farine 250 g oeufs 4 lait 500 ml
  #v(2pt)
  #text(size: 11pt, weight: "bold")[Préparation]
  #v(2pt)
  1. Mélanger la farine et le sel. \
  2. Casser les oeufs au centre.
], fichiers: ("depart", "travail", "  recette.md"))
