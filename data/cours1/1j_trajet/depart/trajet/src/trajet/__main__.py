"""Fabrique la vidéo du trajet, de bout en bout.

    python -m trajet                     # data/carte.png + data/etapes.csv → trajet.mp4
    python -m trajet --sortie ailleurs   # écrit dans un autre dossier
    python -m trajet --help              # ce que la commande accepte

Après `pip install -e .`, la commande s'appelle `trajet`.

Quatre étapes, chacune produisant le fichier que la suivante consomme : les
images d'étape, les sous-titres, la liste de montage, la vidéo. Tous les
fichiers intermédiaires restent dans le dossier de sortie, et se lisent.
"""

import argparse
import shutil
import sys
from pathlib import Path

from trajet.etapes import lire_etapes
from trajet.images import dessiner_etapes
from trajet.montage import ecrire_liste_de_montage, ecrire_sous_titres, monter

# Le dossier du projet : deux crans au-dessus de `src/trajet/`.
PROJET = Path(__file__).resolve().parents[2]
DONNEES = PROJET / "data"

OUTILS = ("magick", "ffmpeg")


def verifier_outils():
    """Les deux programmes appelés doivent être dans le PATH."""
    manquants = [outil for outil in OUTILS if shutil.which(outil) is None]
    if manquants:
        raise SystemExit(
            f"{', '.join(manquants)} introuvable(s). L'environnement du projet "
            f"n'est pas actif : voir la section « Installation » du README."
        )


def main(arguments=None) -> int:
    analyseur = argparse.ArgumentParser(
        prog="trajet",
        description="Fabrique une vidéo commentée d'un trajet.",
    )
    analyseur.add_argument(
        "-c", "--carte", type=Path, default=DONNEES / "carte.png",
        help="le fond de carte (défaut : data/carte.png)",
    )
    analyseur.add_argument(
        "-e", "--etapes", type=Path, default=DONNEES / "etapes.csv",
        help="les étapes du trajet (défaut : data/etapes.csv)",
    )
    analyseur.add_argument(
        "-s", "--sortie", type=Path, default=PROJET,
        help="où écrire la vidéo et les fichiers intermédiaires (défaut : le projet)",
    )
    options = analyseur.parse_args(arguments)

    verifier_outils()
    for fichier in (options.carte, options.etapes):
        if not fichier.is_file():
            raise SystemExit(f"fichier introuvable : {fichier}")

    options.sortie.mkdir(parents=True, exist_ok=True)
    etapes = lire_etapes(options.etapes)
    if len(etapes) < 2:
        raise SystemExit(f"{options.etapes} : il faut au moins un départ et une étape")

    images = dessiner_etapes(options.carte, etapes, options.sortie)
    sous_titres = ecrire_sous_titres(etapes, options.sortie / "trajet.srt")
    liste = ecrire_liste_de_montage(images, etapes, options.sortie / "montage.txt")
    video = monter(liste, sous_titres, options.sortie / "trajet.mp4")

    duree = sum(etape.duree for etape in etapes)
    print(f"{video} : {len(images)} étapes, {duree} s, {video.stat().st_size} octets")
    return 0


if __name__ == "__main__":
    sys.exit(main())
