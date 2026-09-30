#!/usr/bin/env python3
"""Convertit les guides détaillés des TD en PDF A4 et en page HTML.

Un guide est un fichier `guide.md` écrit à côté des notebooks d'un TD,
`src/cours<n>/notebook/td/<td>/guide.md`. C'est du Markdown sans cellule de
code : `outils/construire_notebooks.py` en fait aussi un `guide.ipynb`, et ce
script en tire, par pandoc, deux versions à lire hors de JupyterLab :

    - `guide_<td>.pdf`, en A4, par typst (`--pdf-engine=typst`) ;
    - `guide_<td>.html`, une page seule, sans fichier annexe.

Chaque étape, titre de niveau 2, commence une page du PDF. Les images
dessinées pour le guide, `illustrations/<nom>.typ` à côté de `guide.md`, sont
compilées en PNG dans `produit/illustrations/`. Les images du guide sont
cherchées à partir de `produit/` du TD, où
`make_data.py` les dépose : un chemin comme
`depart/illustrations/programme_montre.png` vaut pour le guide livré à la
racine du dossier du TD comme pour la conversion. Elles sont cherchées
ensuite à côté de `guide.md` : les guides du book (versions 2 des cours 1
et 2) y gardent leurs images versionnées, que la page du book affiche. Les deux fichiers sont
déposés dans `produit/` du TD, que `outils/livrer_tds.py` met à
plat dans le dossier livré : l'étudiant trouve le guide à côté de `depart/`.

    python outils/compiler_guides.py --cours 3
    python outils/compiler_guides.py --cours 4

Demande pandoc 3.1.2 ou plus récent et typst, tous deux dans l'environnement
`info01`. Sort en code 1 si une conversion échoue.
"""

from __future__ import annotations

import argparse
import os
import subprocess
import sys
import tempfile
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent

# Le format de la page passe par les variables du modèle typst de pandoc
# (`VARIABLES_TYPST`) ; l'en-tête ajoute des blocs de code plus petits que le
# texte, sur fond gris, et une page nouvelle à chaque titre de niveau 1.
VARIABLES_TYPST = """\
papersize: a4
fontsize: 10.5pt
lang: fr
region: FR
margin:
  x: 2cm
  y: 2cm
"""

ENTETE_TYPST = """\
#show raw.where(block: true): set text(size: 8.5pt)
#show raw.where(block: true): block.with(fill: luma(242), inset: 6pt, radius: 3pt, width: 100%)
#let apres-partie = state("apres-partie", false)
#show heading.where(level: 1): it => { pagebreak(weak: true); apres-partie.update(true); it }
// Chaque étape commence une page, sauf la première d'une partie : le titre de
// la partie vient d'ouvrir la page.
#show heading.where(level: 2): it => {
  context if not apres-partie.get() { pagebreak(weak: true) }
  apres-partie.update(false)
  it
}
#show quote.where(block: true): it => block(
  width: 100%, fill: rgb("#eef3f7"), stroke: (left: 3pt + rgb("#182936")),
  inset: (x: 10pt, y: 8pt), it.body,
)
#set table(stroke: 0.5pt + luma(180))
#show table: set align(left)
"""

STYLE_HTML = """\
<style>
body { max-width: 50rem; margin: 2rem auto; padding: 0 1rem; font-family: sans-serif; line-height: 1.5; }
blockquote { margin: 1rem 0; padding: .6rem 1rem; background: #eef3f7; border-left: 4px solid #182936; }
h2 { margin-top: 3rem; border-top: 1px solid #ccc; padding-top: 1rem; }
pre { background: #f2f2f2; padding: .6rem; overflow-x: auto; font-size: .9em; }
code { font-size: .95em; }
table { border-collapse: collapse; }
th, td { border: 1px solid #ccc; padding: .3rem .5rem; vertical-align: top; }
/* Blocs ```diff : lignes supprimées en rouge, lignes ajoutées en vert, comme dans le PDF */
pre.diff span.st { color: #b31d28; }
pre.diff span.va { color: #22863a; }
</style>
"""


def guides(cours: str) -> list[tuple[Path, Path]]:
    """Les guides du cours, et le `produit/` du TD qui reçoit chacun."""
    couples = []
    for source in sorted((RACINE / "src" / f"cours{cours}" / "notebook" / "td").glob("*/guide.md")):
        td = source.parent.name
        couples.append((source, RACINE / "data" / f"cours{cours}" / td / "produit"))
    return couples


def sans_premier_titre(texte: str) -> str:
    """Le guide sans son titre de niveau 1, que l'en-tête YAML donne déjà.

    Les lignes des blocs de code sont ignorées : un `# Crêpes` d'exemple
    Markdown, ou un commentaire de bash, n'est pas un titre.
    """
    lignes = texte.splitlines(keepends=True)
    dans_code = False
    for i, ligne in enumerate(lignes):
        if ligne.lstrip().startswith(("```", "~~~")):
            dans_code = not dans_code
        elif not dans_code and ligne.startswith("# "):
            return "".join(lignes[:i] + lignes[i + 1:])
    return texte


# Cours dont les guides sont des pages du book avec leurs images : le PNG de
# chaque illustration est aussi écrit à côté de sa source, et versionné, pour
# que le book se construise sans typst (comme les SVG de `notebook/figures/`).
ILLUSTRATIONS_VERSIONNEES = {"cours1_v2", "cours2_v2"}


def illustrer(source: Path, produit: Path) -> int:
    """Les images du guide écrites en typst, `illustrations/<nom>.typ`, en PNG dans `produit/illustrations/`."""
    cours = source.relative_to(RACINE / "src").parts[0]
    for figure in sorted((source.parent / "illustrations").glob("*.typ")):
        cible = produit / "illustrations" / (figure.stem + ".png")
        cible.parent.mkdir(parents=True, exist_ok=True)
        code = subprocess.run(
            ["typst", "compile", "--root", str(RACINE), "--format", "png", "--ppi", "110",
             str(figure), str(cible)],
            check=False,
        ).returncode
        if code != 0:
            return code
        # La copie versionnée est compilée à 144 ppi, la résolution de
        # `construire_notebooks.py` : les deux outils écrivent alors le même
        # fichier, et git ne voit pas de changement d'un outil à l'autre.
        if cours in ILLUSTRATIONS_VERSIONNEES:
            code = subprocess.run(
                ["typst", "compile", "--root", str(RACINE), "--format", "png", "--ppi", "144",
                 str(figure), str(figure.with_suffix(".png"))],
                check=False,
            ).returncode
            if code != 0:
                return code
    return 0


def convertir(source: Path, produit: Path) -> int:
    td = source.parent.name
    produit.mkdir(parents=True, exist_ok=True)
    if illustrer(source, produit) != 0:
        return 1
    with tempfile.TemporaryDirectory() as temporaire:
        copie = Path(temporaire) / "guide.md"
        copie.write_text(sans_premier_titre(source.read_text(encoding="utf-8")), encoding="utf-8")
        entete = Path(temporaire) / "entete.typ"
        entete.write_text(ENTETE_TYPST, encoding="utf-8")
        variables = Path(temporaire) / "variables.yaml"
        variables.write_text(VARIABLES_TYPST, encoding="utf-8")
        style = Path(temporaire) / "style.html"
        style.write_text(STYLE_HTML, encoding="utf-8")
        commandes = [
            ["pandoc", str(copie), "--from", "markdown", "--pdf-engine=typst",
             "--resource-path", os.pathsep.join((str(produit), str(source.parent))),
             "--include-in-header", str(entete), "--metadata-file", str(variables), "-o", str(produit / f"guide_{td}.pdf")],
            ["pandoc", str(copie), "--from", "markdown", "--standalone", "--embed-resources",
             "--resource-path", os.pathsep.join((str(produit), str(source.parent))),
             "--include-in-header", str(style), "-o", str(produit / f"guide_{td}.html")],
        ]
        for commande in commandes:
            code = subprocess.run(commande, check=False).returncode
            if code != 0:
                return code
    print(f"{source.relative_to(RACINE)}\n  {produit.relative_to(RACINE)}/guide_{td}.pdf, .html")
    return 0


def main() -> int:
    analyseur = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    analyseur.add_argument("--cours", required=True, help="numéro du cours, 1 à 7, ou 1_v2")
    options = analyseur.parse_args()
    erreurs = 0
    for source, produit in guides(options.cours):
        if convertir(source, produit) != 0:
            print(f"échec : {source}", file=sys.stderr)
            erreurs += 1
    return 1 if erreurs else 0


if __name__ == "__main__":
    sys.exit(main())
