// VS Code, panneau du contrôle de code source, et comparaison de
// `recette.md` à l'étape 2 du TD 2d (les œufs passent de 4 à 3).
#import "../../../../../commun/illustrations_td.typ": vscode-diff
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#vscode-diff("travail", "recette.md", (
  ("## Ingrédients", "## Ingrédients", "neutre"),
  ("", "", "neutre"),
  ("| Ingrédient | Quantité |", "| Ingrédient | Quantité |", "neutre"),
  ("|---|---|", "|---|---|", "neutre"),
  ("| Farine | 250 g |", "| Farine | 250 g |", "neutre"),
  ("| Œufs | 4 |", "| Œufs | 3 |", "modifie"),
  ("| Lait | 500 ml |", "| Lait | 500 ml |", "neutre"),
  ("| Sel | 1 pincée |", "| Sel | 1 pincée |", "neutre"),
  ("| Beurre fondu | 50 g |", "| Beurre fondu | 50 g |", "neutre"),
))
