"""La couleur des blocs ```modif des guides de TD : vert pour les lignes à ajouter, rouge pour les lignes à supprimer.

Un bloc ```modif, écrit par `blocs` de `outils/modifications.py`, encadre
les lignes à ajouter par deux lignes `+++`, et les lignes à supprimer par
deux lignes `---`. Aucun surligneur ne connaît ce format :

    - `LexerModif` le colore dans le book, déclaré par `conf.py` ;
    - `html` l'écrit en HTML coloré, pour le guide converti par pandoc
      (`outils/compiler_guides.py`) et pour le notebook
      (`outils/construire_notebooks.py`) ;
    - le PDF le colore par une règle typst, dans `outils/compiler_guides.py`.

Les couleurs sont celles des blocs ```diff des guides du cours 4.
"""

import html as _html
import re

from pygments.lexer import RegexLexer
from pygments.token import Generic, Text

AJOUT = "+++"
SUPPRESSION = "---"
COULEURS = {AJOUT: "#22863a", SUPPRESSION: "#b31d28"}

# Un bloc ```modif d'un texte Markdown, clôtures comprises
BLOC = re.compile(r"^```modif\n(.*?)^```$", re.MULTILINE | re.DOTALL)


class LexerModif(RegexLexer):
    """Les lignes entre deux `+++` en `Generic.Inserted`, entre deux `---` en `Generic.Deleted`."""

    name = "Modifications"
    aliases = ["modif"]
    tokens = {
        "root": [
            (r"\+\+\+\n", Generic.Inserted, "ajout"),
            (r"---\n", Generic.Deleted, "suppression"),
            (r".*\n", Text),
        ],
        "ajout": [
            (r"\+\+\+\n", Generic.Inserted, "#pop"),
            (r".*\n", Generic.Inserted),
        ],
        "suppression": [
            (r"---\n", Generic.Deleted, "#pop"),
            (r".*\n", Generic.Deleted),
        ],
    }


def html(code: str) -> str:
    """Le contenu d'un bloc ```modif en `<pre>`, les lignes ajoutées et supprimées colorées par un attribut `style`."""
    lignes = []
    marque = None
    for ligne in code.rstrip("\n").split("\n"):
        ouvre = marque is None and ligne in COULEURS
        if ouvre:
            marque = ligne
        texte = _html.escape(ligne, quote=False)
        if marque is not None:
            texte = f'<span style="color: {COULEURS[marque]}">{texte}</span>'
        lignes.append(texte)
        if not ouvre and ligne == marque:
            marque = None
    return '<pre class="modif"><code>' + "\n".join(lignes) + "</code></pre>"


def blocs_en_html(texte: str) -> str:
    """Le texte Markdown, chaque bloc ```modif remplacé par son HTML coloré."""
    return BLOC.sub(lambda m: html(m.group(1)), texte)
