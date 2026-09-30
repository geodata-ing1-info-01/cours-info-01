"""Les sous-titres, la liste de montage, et l'appel à ffmpeg.

Deux fichiers texte sont écrits avant le montage, et c'est le propos du TD :
chaque étape produit un fichier que la suivante consomme, et tous sont
lisibles dans l'éditeur.

`trajet.srt` est le format de sous-titres le plus répandu — un numéro, un
intervalle, une ligne de texte, une ligne vide. `montage.txt` est la liste que
le démultiplexeur `concat` de ffmpeg attend : un fichier, sa durée, et le
dernier répété, faute de quoi ffmpeg coupe la dernière image.

La commande construite ici a la forme :

    ffmpeg -y -f concat -safe 0 -i montage.txt -vf "subtitles=trajet.srt:…" -r 25 trajet.mp4

`-f concat` dit de lire une liste plutôt qu'une vidéo, `-vf` applique un
filtre — ici l'incrustation des sous-titres — et `-r 25` fixe le nombre
d'images par seconde.
"""

import subprocess

__all__ = ["ecrire_sous_titres", "ecrire_liste_de_montage", "monter"]

STYLE = "FontSize=11,Outline=1.5,MarginV=16"


def _horodatage(secondes):
    """`00:01:07,000`, la forme des instants dans un fichier `.srt`."""
    return f"00:{secondes // 60:02d}:{secondes % 60:02d},000"


def ecrire_sous_titres(etapes, chemin):
    """Un bloc de sous-titre par étape, aux durées du fichier des étapes."""
    blocs = []
    instant = 0
    for i in range(1, len(etapes)):
        etape = etapes[i]
        fin = instant + etape.duree
        blocs.append(
            f"{i}\n{_horodatage(instant)} --> {_horodatage(fin)}\n{etape.texte}\n"
        )
        instant = fin
    chemin.write_text("\n".join(blocs), encoding="utf-8")
    return chemin


def ecrire_liste_de_montage(images, etapes, chemin):
    """La liste que `ffmpeg -f concat` attend : un fichier, une durée."""
    lignes = []
    for image, etape in zip(images, etapes[1:]):
        lignes.append(f"file '{image.name}'")
        lignes.append(f"duration {etape.duree}")
    lignes.append(f"file '{images[-1].name}'")   # sans quoi la dernière saute
    chemin.write_text("\n".join(lignes) + "\n", encoding="utf-8")
    return chemin


def monter(liste, sous_titres, sortie, images_par_seconde=25):
    """Assemble les images en vidéo, sous-titres incrustés."""
    filtre = f"subtitles={sous_titres.name}:force_style='{STYLE}',format=yuv420p"
    subprocess.run(
        [
            "ffmpeg", "-y", "-loglevel", "error",
            "-f", "concat", "-safe", "0", "-i", liste.name,
            "-vf", filtre,
            "-r", str(images_par_seconde),
            sortie.name,
        ],
        cwd=liste.parent,    # les noms restent nus, donc rien à échapper
        check=True,
    )
    return sortie
