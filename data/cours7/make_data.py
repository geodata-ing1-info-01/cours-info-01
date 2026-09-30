"""Fabrique les fichiers des TD du projet 7.

Refait le 30/09/2026. Les deux TD partent d'un dépôt git récupéré sur
GitHub : le dossier du TD ne livre que les fichiers à ajouter au dépôt.

TD 7a, la recette en pages : tout ce que le TD livre est versionné
(`7a_recette/depart/` : le texte des recettes en Markdown, six recettes de
plus, `style.css`) ; `build` ne fait que le dossier `produit/travail/`.

TD 7b, la fenêtre du train : le TD ne livre que le guide ; le décor est dans
le dépôt de référence `train`, écrit par `generer_projet7.py --depots`.
`build` ne fait que le dossier `produit/travail/`.

`illustrations` écrit dans `illustrations/cours7/` les images des schémas
du TD 7b (`src/cours7/diapo/schemas.typ`), calculées par les programmes du
TD eux-mêmes : les couches de l'image de départ, la fenêtre et le calque des
poteaux posés sur un damier (qui marque la transparence), l'image avant et
après chaque effet.

    python make_data.py build
    python make_data.py illustrations
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

ICI = Path(__file__).parent
TD_RECETTE = ICI / "7a_recette"
TD_TRAIN = ICI / "7b_train"

sys.path.insert(0, str(ICI.parent / "cours4"))
from make_data import sur_damier, vider  # noqa: E402

DEPOT = ICI.parent.parent
ILLUSTRATIONS = DEPOT / "illustrations" / "cours7"
NUMERO = 3                # l'image montrée : les bandes des poteaux y sont bien visibles


def build() -> None:
    for td in (TD_RECETTE, TD_TRAIN):
        produit = td / "produit"
        vider(produit)
        (produit / "travail").mkdir()
        print(f"✓ {td.name}/produit/")


def illustrations() -> None:
    import shutil
    import subprocess
    import tempfile

    import numpy as np
    from PIL import Image

    sys.path.insert(0, str(ICI))
    import generer_projet7 as g

    ILLUSTRATIONS.mkdir(parents=True, exist_ok=True)

    def damier(source, cible):
        Image.fromarray(sur_damier(np.asarray(Image.open(source).convert("RGBA")))).save(ILLUSTRATIONS / cible)

    with tempfile.TemporaryDirectory() as tmp:
        projet = Path(tmp) / "train"
        g.depot_train(projet)
        decor = projet / "decor"
        shutil.copy(decor / "fond.png", ILLUSTRATIONS / "train_fond.png")
        for nom, vitesse in (("voiles", 4), ("plage_jaune", 8)):
            morceau = Path(tmp) / (nom + ".png")
            subprocess.run(["magick", str(decor / (nom + ".png")), "-roll", "-" + str(NUMERO * vitesse) + "+0",
                            "-crop", "640x480+0+0", "+repage", str(morceau)], check=True)
            damier(morceau, "train_" + nom + ".png")
        damier(decor / "fenetre.png", "train_fenetre.png")
        images = {"r2": "train_depart.png", "e2": "train_avec_fenetre.png", "e3": "train_avec_poteaux.png",
                  "e3-fusion": "train_final.png"}
        for etat, cible in images.items():
            (projet / "train.py").write_text(g.train(etat), encoding="utf-8")
            subprocess.run([sys.executable, "train.py", "--numero", str(NUMERO)], cwd=projet, check=True,
                           stdout=subprocess.DEVNULL)
            shutil.copy(projet / "sortie" / ("train_" + str(NUMERO).zfill(4) + ".png"), ILLUSTRATIONS / cible)
            if etat == "e3":
                damier(projet / "sortie" / "poteaux.png", "train_calque_poteaux.png")
    print(f"✓ {ILLUSTRATIONS.relative_to(DEPOT)}/ : images du TD 7b")


def main() -> None:
    analyseur = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    analyseur.add_argument("commande", choices=("build", "illustrations"))
    options = analyseur.parse_args()
    illustrations() if options.commande == "illustrations" else build()


if __name__ == "__main__":
    main()
