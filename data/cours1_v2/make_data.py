#!/usr/bin/env python3
"""Données des TD du cours 1, version 2 (proposition 2027-2028).

Les TD 1a et 1b de la version 2 travaillent sur les fichiers du TD 1a de la
version 1 : ce script les recopie depuis `data/cours1/1a_formats/produit/depart/`,
que `data/cours1/make_data.py build` fabrique. Les autres TD ont leurs
fichiers versionnés dans leur dossier.

Les TD 1a et 1b n'abordent plus la page web (décision du 19/10/2026) :
les pages `.html` et la feuille de style ne sont pas recopiées.

    python data/cours1/make_data.py build      # d'abord, si produit/ est vide
    python data/cours1_v2/make_data.py build
"""

from __future__ import annotations

import shutil
import sys
from pathlib import Path

ICI = Path(__file__).resolve().parent
DEPART_V1 = ICI.parent / "cours1" / "1a_formats" / "produit" / "depart"
TDS = ("1a_formats", "1b_terminal")
# Ce qu'un TD ne reçoit pas des fichiers de la version 1.
EXCLUS = {td: ("*.html", "*.css") for td in TDS}


def build() -> None:
    if not DEPART_V1.is_dir():
        sys.exit(f"{DEPART_V1} absent : lancer d'abord `python data/cours1/make_data.py build`.")
    for td in TDS:
        cible = ICI / td / "produit" / "depart"
        shutil.rmtree(cible, ignore_errors=True)
        shutil.copytree(DEPART_V1, cible, ignore=shutil.ignore_patterns(*EXCLUS.get(td, ())))
        (ICI / td / "produit" / "travail").mkdir(exist_ok=True)
        print(f"✓ {cible.relative_to(ICI.parent.parent)}")


if __name__ == "__main__":
    if sys.argv[1:] != ["build"]:
        sys.exit(__doc__)
    build()
