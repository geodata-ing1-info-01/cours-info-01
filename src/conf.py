"""Configuration Sphinx du book « Introduction à l'informatique ».

Construction (depuis la racine du dépôt) :

    sphinx-build -E -b html src _build/html   # site statique
    sphinx-autobuild src _build/html          # aperçu live pendant la rédaction

Le HTML produit utilise des **chemins relatifs** et n'appelle aucune ressource
externe : `_build/html/index.html` s'ouvre par double-clic, sans serveur et sans
connexion — c'est la contrainte de distribution aux étudiants.
"""

from pathlib import Path

project = "Introduction à l'informatique"
author = "1re année géomatique"
copyright = "2026, module info01 — CC-BY-4.0"

extensions = [
    "myst_nb",        # Markdown MyST + exécution des cellules
    "sphinx_design",  # grilles et cartes (optionnel, utilisé par le thème)
]

# --- MyST -------------------------------------------------------------------
myst_enable_extensions = [
    "colon_fence",    # blocs :::{note} … :::
    "deflist",
]
# Le titre vient du frontmatter : MyST l'insère comme H1, le corps peut donc
# commencer en H2 sans déclencher d'avertissement.
myst_title_to_header = True
myst_heading_anchors = 3

# --- Exécution des notebooks ------------------------------------------------
# "cache" : n'exécute que ce qui a changé (première construction ~30 s,
# les suivantes quasi instantanées).
nb_execution_mode = "cache"
nb_execution_timeout = 120
nb_execution_raise_on_error = True   # une cellule qui échoue casse la build

# --- Rendu HTML -------------------------------------------------------------
html_theme = "sphinx_book_theme"
html_title = "Introduction à l'informatique"
html_static_path = ["_static"]
html_favicon = "_static/favicon.png"
html_theme_options = {
    "home_page_in_toc": True,
    "show_navbar_depth": 1,
    "use_download_button": False,
    # Pas de bouton « lancer sur Binder/Colab » : le book doit rester lisible
    # hors ligne.
    "launch_buttons": {},
}

# `outils/construire_notebooks.py` dépose les `.ipynb` dérivés des sources
# MyST dans `data/cours<n>/*_notebooks/produit/`, hors de `src/`. L'exclusion
# reste, au cas où l'un d'eux serait ouvert et enregistré à côté de sa source :
# Sphinx trouverait alors deux fichiers pour le même document et choisirait
# lui-même lequel construire, et le book pourrait afficher les résultats figés
# du `.ipynb` plutôt que ceux que la construction recalcule.
# `**/propositions/**` : notebooks d'essai (cours 4), à exécuter depuis
# `data/cours<n>/propositions/` d'après leur README — leurs chemins relatifs
# vers `data/` ne tiennent pas depuis `src/`, et ils ne sont dans aucun
# sommaire.
exclude_patterns = [
    "_build",
    "**/diapo/**",
    "**/notebook/*.ipynb",
    "**/notebook/td/**/*.ipynb",
    "**/propositions/**",
    "**/rejeu/**",           # script de rejeu d'un TD et ses sorties, lus dans le dépôt
    "**/images/**/*.md",     # crédits des images, lus dans le dépôt
    "commun/typst-101.md",     # mode d'emploi des sources typst, lu dans le dépôt
    "Thumbs.db",
    ".DS_Store",
]

# `notebook/td/` contient les notebooks livrés avec les TD, écrits pour être
# exécutés depuis le dossier du TD : ils restent hors du book. Le guide détaillé
# d'un TD, `guide.md`, n'a pas de cellule de code ; pour les cours de
# `GUIDES_DANS_LE_BOOK`, il est aussi une page du book, sous le titre « TD … ».
# Les guides des autres cours ne sont pas encore relus pour le book (leurs
# images sont cherchées dans `data/`, depuis `produit/`).
# Les versions 2 des cours 1 et 2 (propositions 2027-2028) aussi.
GUIDES_DANS_LE_BOOK = {"cours1", "cours2", "cours1_v2", "cours2_v2"}
_SRC = Path(__file__).resolve().parent
exclude_patterns += sorted(
    source.relative_to(_SRC).as_posix()
    for source in _SRC.glob("cours*/notebook/td/**/*.md")
    if not (source.name == "guide.md"
            and source.relative_to(_SRC).parts[0] in GUIDES_DANS_LE_BOOK)
)
language = "fr"
