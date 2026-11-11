#!/usr/bin/env python3
"""Données des TD du cours 1, version 2 (proposition 2027-2028).

Les TD 1a et 1b de la version 2 travaillent sur les fichiers du TD 1a de la
version 1 : ce script les recopie depuis `data/cours1/1a_formats/produit/depart/`,
que `data/cours1/make_data.py build` fabrique. Les autres TD ont leurs
fichiers versionnés dans leur dossier.

Les TD 1a et 1b n'abordent plus la page web (décision du 19/10/2026) :
les pages `.html` et la feuille de style ne sont pas recopiées.

Le TD 1c garde ses fichiers dans `1c_programme/depart/`, versionnés ; le
script lui crée un `travail/` vide, où l'élève les copie avant de modifier
le programme (09/11/2026).

Le script vide d'abord le `produit/` de chaque TD, comme `outils/livrer_tds.py`
l'attend : un fichier laissé là par un essai ne part pas dans l'archive. Les
guides et les notebooks y sont refaits ensuite par les outils de `outils/`.

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


def vider_produits() -> None:
    """Vide le `produit/` de chaque dossier de TD (`1a_formats`, `1b_terminal`…), sauf `.gitkeep`."""
    for dossier in sorted(ICI.iterdir()):
        produit = dossier / "produit"
        if not (dossier.is_dir() and dossier.name[:1].isdigit() and produit.is_dir()):
            continue
        for element in produit.iterdir():
            if element.is_dir():
                shutil.rmtree(element)
            elif element.name != ".gitkeep":
                element.unlink()


def build() -> None:
    if not DEPART_V1.is_dir():
        sys.exit(f"{DEPART_V1} absent : lancer d'abord `python data/cours1/make_data.py build`.")
    vider_produits()
    for td in TDS:
        cible = ICI / td / "produit" / "depart"
        shutil.copytree(DEPART_V1, cible, ignore=shutil.ignore_patterns(*EXCLUS.get(td, ())))
        (ICI / td / "produit" / "travail").mkdir(exist_ok=True)
        print(f"✓ {cible.relative_to(ICI.parent.parent)}")
    travail_1c = ICI / "1c_programme" / "produit" / "travail"
    travail_1c.mkdir(parents=True, exist_ok=True)
    print(f"✓ {travail_1c.relative_to(ICI.parent.parent)}")


if __name__ == "__main__":
    if sys.argv[1:] != ["build"]:
        sys.exit(__doc__)
    build()
