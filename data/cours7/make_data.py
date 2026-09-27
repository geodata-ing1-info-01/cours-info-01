"""Fabrique les fichiers du TD 7b du cours 7 : deux effets pour la fenêtre du train.

Le TD 7b part du projet du TD 4c (`train.py`, le dossier `decor/`), que
l'élève a déjà. `build` remplit `7b_train/produit/depart/` de ce que le
notebook `tableaux.ipynb` lit : une image de la série du TD 4c
(`exemple.png`) et les deux images du décor qu'emploie la parallaxe
(`decor/plage.png`, `decor/fenetre.png`). Les modèles (`depart/modeles/`) et
le corrigé (`corriges/7b_train/`) sont versionnés.

    python make_data.py build

Le notebook est posé dans `produit/depart/notebook/` par
`outils/construire_notebooks.py`.
"""

from __future__ import annotations

import argparse
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ICI = Path(__file__).parent
TD_TRAIN = ICI / "7b_train"
COURS4 = ICI.parent / "cours4"

sys.path.insert(0, str(COURS4))
from make_data import decor_train, vider  # noqa: E402


def build() -> None:
    produit = TD_TRAIN / "produit"
    vider(produit)
    (produit / "travail").mkdir()
    depart = produit / "depart"
    with tempfile.TemporaryDirectory() as dossier:
        decor = Path(dossier) / "decor"
        decor_train(decor)
        # Une image de la série du TD 4c : le programme final, décalage 200.
        programme = COURS4 / "corriges" / "4c_train" / "b6" / "train.py"
        subprocess.run([sys.executable, str(programme), "--decalage", "200"], cwd=dossier, check=True,
                       stdout=subprocess.DEVNULL)
        depart.mkdir()
        shutil.copy(Path(dossier) / "sortie" / "train_0200.png", depart / "exemple.png")
        (depart / "decor").mkdir()
        for nom in ("plage.png", "fenetre.png"):
            shutil.copy(decor / nom, depart / "decor" / nom)
    print(f"✓ {TD_TRAIN.name}/produit/depart/")


def main() -> None:
    analyseur = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    analyseur.add_argument("commande", choices=("build",))
    analyseur.parse_args()
    build()


if __name__ == "__main__":
    main()
