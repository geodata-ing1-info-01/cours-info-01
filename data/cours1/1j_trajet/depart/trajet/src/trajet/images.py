"""Une image par étape, dessinée sur le fond de carte par ImageMagick.

ImageMagick n'est pas une bibliothèque Python : c'est un programme, `magick`,
qu'on lance comme on le ferait au terminal. `subprocess.run` reçoit la commande
sous forme de liste — un élément par argument — et non sous forme de chaîne :
aucun découpage à deviner, donc aucun problème d'espace dans un nom de fichier.

La commande construite ici a la forme :

    magick carte.png -stroke '#1f6f8b' -strokewidth 6 -draw "line 398,248 410,360" etape_01.png

`-draw` prend une instruction de dessin en un seul argument, `-stroke` la
couleur du trait et `-strokewidth` son épaisseur. Les options valent pour tous
les `-draw` qui suivent, jusqu'à ce qu'on les change.
"""

import subprocess

__all__ = ["PARCOURU", "COURANT", "dessiner_etapes"]

PARCOURU = "#1f6f8bAA"     # bleu translucide : le chemin déjà fait
COURANT = "#d95f02"        # orange : le segment de l'étape en cours
RAYON = 9                  # pixels, pour les pastilles de départ et d'arrivée


def _commande(carte, etapes, jusqu_a):
    """Les arguments de `magick` pour l'image de l'étape `jusqu_a`."""
    arguments = [str(carte), "-fill", "none"]

    # Les segments déjà parcourus, en bleu.
    for i in range(1, jusqu_a):
        arguments += [
            "-stroke", PARCOURU, "-strokewidth", "6",
            "-draw", f"line {etapes[i - 1].x},{etapes[i - 1].y} {etapes[i].x},{etapes[i].y}",
        ]

    # Le segment de l'étape en cours, en orange et plus épais.
    depart, arrivee = etapes[jusqu_a - 1], etapes[jusqu_a]
    arguments += [
        "-stroke", COURANT, "-strokewidth", "9",
        "-draw", f"line {depart.x},{depart.y} {arrivee.x},{arrivee.y}",
        "-stroke", "none",
        "-fill", COURANT,
        "-draw", f"circle {arrivee.x},{arrivee.y} {arrivee.x + RAYON},{arrivee.y}",
        "-fill", PARCOURU[:7],
        "-draw", f"circle {etapes[0].x},{etapes[0].y} {etapes[0].x + RAYON},{etapes[0].y}",
    ]
    return arguments


def dessiner_etapes(carte, etapes, dossier):
    """Une image par étape, `etape_01.png` et suivantes. Rend leurs chemins."""
    images = []
    for i in range(1, len(etapes)):
        image = dossier / f"etape_{i:02d}.png"
        subprocess.run(["magick", *_commande(carte, etapes, i), str(image)], check=True)
        images.append(image)
    return images
