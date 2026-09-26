// VS Code après `git checkout -b arguments`, à l'étape 3.1 du TD 3a : la
// branche dans la barre d'état et dans l'invite. Compilé en PNG par
// `outils/compiler_guides.py` et `outils/construire_notebooks.py`.
#import "../../../../../commun/illustrations_td.typ": vscode-branche
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#vscode-branche("travail", "arguments", (
  "$ git checkout -b arguments",
  "Switched to a new branch 'arguments'",
  "(base)",
  "eleve@POSTE MINGW64",
  "~/Desktop/info01/cours3/3a_cli/travail (arguments)",
), fichiers: (".gitignore", "recette.py", "recettes", "style.css"))
