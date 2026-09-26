// VS Code : le panneau du contrôle de code source et la comparaison de
// `recette.md` après l'ajout du diagramme (étape 4 du TD 3b). Compilé en PNG
// par `outils/compiler_guides.py` et `outils/construire_notebooks.py`.
#import "../../../../../commun/illustrations_td.typ": vscode-diff
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#vscode-diff("gaufres", "recette.md", (
  ("6. Cuire dans un gaufrier chaud…", "6. Cuire dans un gaufrier chaud…", "neutre"),
  ("", "", "neutre"),
  ("", "```mermaid", "ajout"),
  ("", "flowchart LR", "ajout"),
  ("", "  A[Farine, sucre, levure, sel] --> C[Pâte]", "ajout"),
  ("", "  B[Œufs] --> C", "ajout"),
  ("", "  …", "ajout"),
  ("", "  F --> G[Cuisson]", "ajout"),
  ("", "```", "ajout"),
  ("", "", "ajout"),
  ("> Les gaufres se servent chaudes…", "> Les gaufres se servent chaudes…", "neutre"),
))
