#!/usr/bin/env python3
"""Données des TD du cours 2, version 2 (proposition 2027-2028).

Les fichiers texte des TD sont versionnés dans leur dossier. Seule la photo
de la recette vient d'ailleurs : `data/cours1/1f_markdown/fourni/crepes.jpg`
(CC0, Wikimedia Commons), importée par `outils/ressources.py`. Ce script la
recopie dans le `produit/depart/` des TD 2c et 2d.

    python data/cours2_v2/make_data.py build
"""

from __future__ import annotations

import shutil
import sys
from pathlib import Path

ICI = Path(__file__).resolve().parent
PHOTO = ICI.parent / "cours1" / "1f_markdown" / "fourni" / "crepes.jpg"
TDS = ("2c_markdown", "2d_depot_recette")


def build() -> None:
    for td in TDS:
        produit = ICI / td / "produit"
        shutil.rmtree(produit / "depart", ignore_errors=True)
        if not PHOTO.exists():
            print(f"! {PHOTO.name} absent — `python outils/ressources.py importer <dossier>`")
            continue
        (produit / "depart").mkdir(parents=True)
        shutil.copy2(PHOTO, produit / "depart" / PHOTO.name)
        print(f"✓ {PHOTO.name} → {(produit / 'depart').relative_to(ICI.parent.parent)}/")


if __name__ == "__main__":
    if sys.argv[1:] != ["build"]:
        sys.exit(__doc__)
    build()
