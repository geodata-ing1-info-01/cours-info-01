"""La mise en forme du résultat : le tableau Markdown, et la page qui l'entoure.

`tabulate` porte le nom et l'appel de la fonction de la bibliothèque du même
nom, réduite au seul format employé ici. Les deux programmes du projet ne
diffèrent que par l'import de cette fonction : celle-ci, ou celle de la
bibliothèque.
"""

__all__ = ["tabulate", "GABARIT"]


def tabulate(donnees, headers=(), tablefmt="github"):
    """Un tableau Markdown, à partir de lignes et d'un en-tête."""
    lignes = []
    lignes.append("| " + " | ".join(headers) + " |")
    lignes.append("|" + "---|" * len(headers))
    for donnee in donnees:
        lignes.append("| " + " | ".join(donnee) + " |")
    return "\n".join(lignes)


# L'enveloppe de la page. `markdown.markdown` ne rend qu'un fragment : les
# titres et les paragraphes convertis, sans `<!doctype>`, sans `<head>`, et
# donc sans lien vers la feuille de style. C'est ici que la page devient un
# document : un type déclaré, un encodage, un titre d'onglet, et la feuille de
# style, qui est dans `data/` avec les autres fichiers fournis.
GABARIT = """<!doctype html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <title>{titre}</title>
  <link rel="stylesheet" href="data/style.css">
</head>
<body>
  <article>
{corps}
  </article>
</body>
</html>
"""
