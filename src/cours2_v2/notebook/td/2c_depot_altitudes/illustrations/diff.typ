// VS Code, panneau du contrôle de code source, et comparaison d'`altitudes.py`
// à l'étape 2 du TD 2c (la moyenne remplacée par les altitudes extrêmes). Les
// lignes longues sont coupées par `…`, pour tenir dans les colonnes.
#import "../../../../../commun/illustrations_td.typ": vscode-diff
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#vscode-diff("travail", "altitudes.py", (
  ("\"\"\"Moyenne d'une série d'altitu…", "\"\"\"Altitudes extrêmes d'une sér…", "modifie"),
  ("", "", "neutre"),
  ("altitudes = [128.4, 131.0, 127.6]", "altitudes = [128.4, 131.0, 127.6]", "neutre"),
  ("total = 0", "print(f\"altitude minimale : {mi…", "modifie"),
  ("for altitude in altitudes:", "print(f\"altitude maximale : {ma…", "modifie"),
  ("    total = total + altitude", "print(f\"max - min : {max(altitu…", "modifie"),
  ("moyenne = total / len(altitudes)", "", "suppression"),
  ("print(f\"moyenne : {moyenne:.1f} m\")", "", "suppression"),
))
