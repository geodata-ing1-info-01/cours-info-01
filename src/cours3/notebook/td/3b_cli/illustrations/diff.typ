// VS Code, panneau du contrôle de code source et comparaison de `recette.py`
// à l'étape 4.3 du TD 3b. Compilé en PNG par `outils/compiler_guides.py` et
// `outils/construire_notebooks.py`.
#import "../../../../../commun/illustrations_td.typ": vscode-diff
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#vscode-diff("travail", "recette.py", (
  ("", "def main():", "ajout"),
  ("# Les valeurs viennent de la ligne…", "    # Les valeurs viennent de la ligne…", "neutre"),
  ("analyseur = argparse.ArgumentParser(…)", "    analyseur = argparse.ArgumentParser(…)", "neutre"),
  ("recettes_disponibles = []", "    recettes_disponibles = []", "neutre"),
  ("…", "    …", "neutre"),
  ("print(page, \":\", PERSONNES, …)", "    print(page, \":\", PERSONNES, …)", "neutre"),
  ("", "", "ajout"),
  ("", "", "ajout"),
  ("", "if __name__ == \"__main__\":", "ajout"),
  ("", "    main()", "ajout"),
))
