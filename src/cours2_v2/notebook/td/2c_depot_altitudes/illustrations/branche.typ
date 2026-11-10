// VS Code après `git checkout -b cumul`, à l'étape 5 du TD 2c : la branche dans
// la barre d'état et dans l'invite.
#import "../../../../../commun/illustrations_td.typ": vscode-branche
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#vscode-branche("travail", "cumul", (
  "$ git checkout -b cumul",
  "Basculement sur la nouvelle branche 'cumul'",
  "(base)",
  "eleve@POSTE MINGW64",
  "~/Desktop/info01/cours2/2c_depot_altitudes/travail (cumul)",
), fichiers: (".gitignore", "altitudes.py", "notes.txt", "README.md"))
