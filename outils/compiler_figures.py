#!/usr/bin/env python3
"""Compile les schémas des pages de cours en SVG.

Un schéma de page est un fichier `src/cours<n>/notebook/figures/<nom>.typ`,
qui reprend le dessin d'une diapositive sur une page à sa taille (gabarit
`_gabarit.typ` du même dossier). Ce script le compile en `<nom>.svg` à côté,
et la page l'affiche par une directive `figure`. Les SVG sont versionnés :
le book se construit sans typst.

    python outils/compiler_figures.py            # tous les cours
    python outils/compiler_figures.py --cours 1

Les fichiers dont le nom commence par `_` (le gabarit) ne sont pas compilés.
Sort en code 1 si une compilation échoue.
"""

from __future__ import annotations

import argparse
import subprocess
import sys
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent


def sources(cours: str | None) -> list[Path]:
    motif = f"cours{cours}" if cours else "cours*"
    return sorted(
        source for source in (RACINE / "src").glob(f"{motif}/notebook/figures/*.typ")
        if not source.name.startswith("_")
    )


def main() -> int:
    analyseur = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    analyseur.add_argument("--cours", help="numéro du cours, 1 à 7, ou 1_v2")
    options = analyseur.parse_args()
    erreurs = 0
    for source in sources(options.cours):
        cible = source.with_suffix(".svg")
        code = subprocess.run(
            ["typst", "compile", "--root", str(RACINE), "--format", "svg",
             str(source), str(cible)],
            check=False,
        ).returncode
        if code != 0:
            print(f"échec : {source.relative_to(RACINE)}", file=sys.stderr)
            erreurs += 1
        else:
            print(cible.relative_to(RACINE))
    return 1 if erreurs else 0


if __name__ == "__main__":
    sys.exit(main())
