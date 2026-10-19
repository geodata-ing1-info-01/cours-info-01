#!/usr/bin/env python3
"""Récupère les illustrations du cours 5 : les photos sur Wikimedia Commons, à
la taille utile, le dessin xkcd n° 936 et le logo Python.

    python illustrations/cours5/telecharger.py

Les fichiers sont décrits dans `README.md` à côté : nom, sujet, auteur,
licence. Le script demande à l'API de Commons une vignette de chaque fichier,
la ramène à 1 400 px et l'enregistre en JPEG : cela suffit à la projection et
tient en quelques centaines de Ko. Les originaux font 4 000 à 6 000 px.
"""

from __future__ import annotations

import io
import json
import sys
import time
import urllib.parse
import urllib.request
from pathlib import Path

from PIL import Image

ICI = Path(__file__).resolve().parent
API = "https://commons.wikimedia.org/w/api.php"
# Commons refuse les requêtes sans User-Agent identifiable.
UA = "info01-cours5/1.0 (https://gitlab.ign.fr/geodata-paris/ecue-info-01)"
LARGEUR = 1400

# nom local → fichier Commons, et rotation en degrés (sens trigonométrique).
# La carte mère est photographiée debout ; couchée, connecteurs arrière en
# haut, elle occupe la largeur de la diapositive.
PHOTOS = {
    "boitier_ouvert.jpg": ("File:Bluechip-PC; Mitte der 2010er 20240827 HOF8538-HDR RAW-Export.png", 0),
    "carte_mere.jpg": ("File:Gigabyte B550 UD AC-Y1 - Front.png", -90),
}

# Le dessin de Randall Munroe sur la force des mots de passe (CC BY-NC 2.5),
# en double résolution, tel quel.
XKCD = {
    "xkcd_936.png": "https://imgs.xkcd.com/comics/password_strength_2x.png",
}

# Le logo Python sans texte, en SVG, tel quel : la PSF admet le logo non
# modifié, accompagné du symbole ™, dans un support qui parle de Python.
LOGOS = {
    "python_logo.svg": "https://upload.wikimedia.org/wikipedia/commons/c/c3/Python-logo-notext.svg",
}


def vignette(titre: str) -> tuple[str, dict]:
    """L'adresse de la vignette, et les métadonnées (auteur, licence)."""
    params = urllib.parse.urlencode({
        "action": "query", "titles": titre, "prop": "imageinfo",
        "iiprop": "url|extmetadata", "iiurlwidth": LARGEUR, "format": "json",
    })
    requete = urllib.request.Request(f"{API}?{params}", headers={"User-Agent": UA})
    with urllib.request.urlopen(requete, timeout=30) as reponse:
        page = next(iter(json.load(reponse)["query"]["pages"].values()))
    info = page["imageinfo"][0]
    meta = {k: v.get("value", "") for k, v in info["extmetadata"].items()}
    return info["thumburl"], meta


def main() -> int:
    for nom, (titre, rotation) in PHOTOS.items():
        url, meta = vignette(titre)
        requete = urllib.request.Request(url, headers={"User-Agent": UA})
        with urllib.request.urlopen(requete, timeout=60) as reponse:
            image = Image.open(io.BytesIO(reponse.read())).convert("RGBA")
        # Le PNG de Commons peut être transparent autour de l'objet : en JPEG,
        # cette transparence deviendrait noire.
        fond = Image.new("RGB", image.size, "white")
        fond.paste(image, mask=image.getchannel("A"))
        image = fond
        if rotation:
            image = image.rotate(rotation, expand=True)
        # Commons ne rend que certaines largeurs : on ramène à la taille utile.
        image.thumbnail((LARGEUR, LARGEUR))
        image.save(ICI / nom, "JPEG", quality=82, optimize=True)
        taille = (ICI / nom).stat().st_size // 1000
        print(f"{nom:20} {image.width}x{image.height}  {taille} Ko  "
              f"{meta.get('LicenseShortName', '?')}")
        time.sleep(1.5)
    for nom, url in XKCD.items():
        requete = urllib.request.Request(url, headers={"User-Agent": UA})
        with urllib.request.urlopen(requete, timeout=60) as reponse:
            (ICI / nom).write_bytes(reponse.read())
        taille = (ICI / nom).stat().st_size // 1000
        print(f"{nom:20} {taille} Ko  CC BY-NC 2.5")
    for nom, url in LOGOS.items():
        requete = urllib.request.Request(url, headers={"User-Agent": UA})
        with urllib.request.urlopen(requete, timeout=60) as reponse:
            (ICI / nom).write_bytes(reponse.read())
        taille = (ICI / nom).stat().st_size // 1000
        print(f"{nom:20} {taille} Ko  marque de la PSF")
    return 0


if __name__ == "__main__":
    sys.exit(main())
