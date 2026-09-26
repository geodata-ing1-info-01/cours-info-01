// VS Code après `git checkout -b sans-gluten`, à l'étape 5 du TD 3a : la
// branche dans la barre d'état et dans l'invite.
#import "../../../../../commun/illustrations_td.typ": vscode-branche
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#vscode-branche("travail", "sans-gluten", (
  "$ git checkout -b sans-gluten",
  "Basculement sur la nouvelle branche 'sans-gluten'",
  "(base)",
  "eleve@POSTE MINGW64",
  "~/Desktop/info01/cours2/3a_depot_recette/travail (sans-gluten)",
), fichiers: (".gitignore", "crepes.jpg", "recette.html", "recette.md", "recette.odt"))
