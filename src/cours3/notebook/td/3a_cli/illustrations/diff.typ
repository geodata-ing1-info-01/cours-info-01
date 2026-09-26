// VS Code, panneau du contrôle de code source et comparaison de `recette.py`
// à l'étape 2.3 du TD 3a. Compilé en PNG par `outils/compiler_guides.py` et
// `outils/construire_notebooks.py`.
#import "../../../../../commun/illustrations_td.typ": vscode-diff
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#vscode-diff("travail", "recette.py", (
  ("", "def main():", "ajout"),
  ("# La recette : le tableau…", "    # La recette : le tableau…", "neutre"),
  ("ingredients = lire_ingredients(…)", "    ingredients = lire_ingredients(…)", "neutre"),
  ("ingredients = adapter(…)", "    ingredients = adapter(…)", "neutre"),
  ("…", "    …", "neutre"),
  ("print(page, \":\", PERSONNES, …)", "    print(page, \":\", PERSONNES, …)", "neutre"),
  ("", "", "ajout"),
  ("", "", "ajout"),
  ("", "if __name__ == \"__main__\":", "ajout"),
  ("", "    main()", "ajout"),
))
