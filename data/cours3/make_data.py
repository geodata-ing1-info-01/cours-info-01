"""Fabrique les fichiers des TD du cours 3 : recettes, images, outil portable.

Le dépôt versionne les recettes (`recettes/`), les modèles et le programme de
secours du TD 3b ; tout ce qui vient d'ailleurs est téléchargé une fois dans `fourni/`,
et `build` recopie ou dérive ce que chaque TD reçoit dans son `produit/`.

    python make_data.py fetch    # télécharge dans 2b_images/fourni/, 3b_cli/fourni/ et 3a_markdown/fourni/
    python make_data.py build    # remplit produit/ des cinq TD, depuis recettes/, 3a_markdown/ et fourni/

Chaque TD reçoit sa propre copie des données : un dossier livré se suffit,
aucun TD ne renvoie à un chemin d'un TD précédent.

Sources : *Under the Wave off Kanagawa* de Hokusai (The Met, open access,
CC0), photos de Wikimedia Commons (licences dans
`PHOTOS`), ImageMagick portable (GitHub, licence Apache 2.0 modifiée).
"""

from __future__ import annotations

import argparse
import json
import shutil
import subprocess
import sys
import urllib.parse
import urllib.request
from pathlib import Path

ICI = Path(__file__).parent
RECETTES = ICI / "recettes"
CORRIGES = ICI / "corriges"

TD_RECETTE = ICI / "1a_recette"
TD_FICHIERS = ICI / "2a_fichiers"
TD_IMAGES = ICI / "2b_images"
TD_CLI = ICI / "3b_cli"
TD_MARKDOWN = ICI / "3a_markdown"

# Commons et le Met demandent un User-Agent identifiable.
ENTETES = {"User-Agent": "info01-cours (https://github.com/ ; cours d'introduction à l'informatique)"}

# --- Images du TD 2b --------------------------------------------------------

# L'objet 45434 du Met est *Under the Wave off Kanagawa* ; l'API renvoie
# l'URL de l'image originale, CC0, 3 859 × 2 594 pixels. `build` la réduit à
# 2 000 pixels de large : assez de pixels pour que la lecture se mesure, et
# un JPEG qui tient dans l'archive.
MET_OBJET = "https://collectionapi.metmuseum.org/public/collection/v1/objects/45434"
VAGUE_ORIGINAL = "vague_original.jpg"
VAGUE = "vague.jpg"
LARGEUR_VAGUE = 2000

# --- Photos des recettes (TD 3b) ---------------------------------------------

# Une photo par recette, prise sur Wikimedia Commons en 960 px de large. La
# page de chaque fichier donne la licence ; `CREDITS.md` la recopie dans le
# dossier livré, ce que CC BY exige et que CC0 n'interdit pas.
PHOTOS = {
    "crepes": {
        "fichier": "Crêpe à la confiture de fruit.jpg",
        "auteur": "Line 1921", "licence": "CC0",
    },
    "mousse_chocolat": {
        "fichier": "Mousse au chocolat (31043136424).jpg",
        "auteur": "Theo Crazzolara", "licence": "CC BY 2.0",
    },
    "salade_lentilles": {
        "fichier": "Salade de lentilles au Bouillon de Lyon en février 2023.jpg",
        "auteur": "Benoît Prieur", "licence": "CC0",
    },
    "pate_pizza": {
        "fichier": "Making pizza dough in kitchen.jpg",
        "auteur": "Jon Sullivan", "licence": "domaine public",
    },
}
LARGEUR_PHOTO = 960

# La photo de la recette écrite au TD 3a, qui n'est pas dans `recettes/`.
PHOTO_GAUFRES = {
    "fichier": "Gaufre molle.jpg",
    "auteur": "Jre", "licence": "domaine public",
}

# --- ImageMagick portable (TD 3b, option) -------------------------------------

# Un seul exécutable, sans installateur ni droits d'administration. Les
# autres `.exe` de l'archive sont des copies de celui-ci, les `.xml` sont
# facultatifs.
MAGICK_VERSION = "7.1.2-31"
MAGICK_ARCHIVE = f"ImageMagick-{MAGICK_VERSION}-portable-Q16-x64.7z"
MAGICK_URL = f"https://github.com/ImageMagick/ImageMagick/releases/download/{MAGICK_VERSION}/{MAGICK_ARCHIVE}"

# Le motif 4 × 4 du TD 2b, écrit en clair : c'est un fichier texte, et c'est
# le point.
MOTIF = "P2\n4 4\n255\n0 255 0 255\n255 0 255 0\n0 255 0 255\n255 0 255 0\n"


def telecharger(url: str, cible: Path) -> None:
    if cible.exists():
        print(f"= {cible.relative_to(ICI)} déjà présent")
        return
    print(f"↓ {url}")
    requete = urllib.request.Request(url, headers=ENTETES)
    with urllib.request.urlopen(requete, timeout=60) as reponse:
        cible.write_bytes(reponse.read())
    print(f"✓ {cible.relative_to(ICI)} ({cible.stat().st_size / 1e3:.0f} Ko)")


def url_commons(fichier: str, largeur: int) -> str:
    """L'image réduite d'un fichier de Commons, par son nom."""
    nom = urllib.parse.quote(fichier.replace(" ", "_"))
    return f"https://commons.wikimedia.org/wiki/Special:FilePath/{nom}?width={largeur}"


def fetch() -> None:
    images = TD_IMAGES / "fourni"
    images.mkdir(parents=True, exist_ok=True)
    cible = images / VAGUE_ORIGINAL
    if not cible.exists():
        requete = urllib.request.Request(MET_OBJET, headers=ENTETES)
        with urllib.request.urlopen(requete, timeout=60) as reponse:
            objet = json.load(reponse)
        if not objet.get("isPublicDomain"):
            sys.exit("l'objet du Met n'est plus signalé comme libre : vérifier avant de continuer")
        telecharger(objet["primaryImage"], cible)
    else:
        print(f"= {cible.relative_to(ICI)} déjà présent")

    photos = TD_CLI / "fourni" / "photos"
    photos.mkdir(parents=True, exist_ok=True)
    for nom, meta in PHOTOS.items():
        telecharger(url_commons(meta["fichier"], LARGEUR_PHOTO), photos / f"{nom}.jpg")

    telecharger(MAGICK_URL, TD_CLI / "fourni" / MAGICK_ARCHIVE)

    (TD_MARKDOWN / "fourni").mkdir(parents=True, exist_ok=True)
    telecharger(url_commons(PHOTO_GAUFRES["fichier"], LARGEUR_PHOTO),
                TD_MARKDOWN / "fourni" / "gaufres.jpg")


def vider(produit: Path) -> None:
    """Repart d'un `produit/` vide : rien de ce qu'un essai y a laissé ne part."""
    if produit.exists():
        for ancien in produit.iterdir():
            if ancien.name != ".gitkeep":
                shutil.rmtree(ancien) if ancien.is_dir() else ancien.unlink()
    produit.mkdir(parents=True, exist_ok=True)


def copier_recettes(depart: Path, avec_photos: bool) -> None:
    for dossier in sorted(RECETTES.iterdir()):
        if not dossier.is_dir():
            continue
        cible = depart / "recettes" / dossier.name
        shutil.copytree(dossier, cible)
        if avec_photos:
            photo = TD_CLI / "fourni" / "photos" / f"{dossier.name}.jpg"
            if photo.exists():
                shutil.copy2(photo, cible / "photo.jpg")
            else:
                print(f"! {photo.relative_to(ICI)} absent — lancer `fetch`")
    shutil.copy2(RECETTES / "style.css", depart / "style.css")
    if avec_photos:
        lignes = ["# Photos", "", "Wikimedia Commons, réduites à 960 px de large.", ""]
        for nom, meta in PHOTOS.items():
            page = "https://commons.wikimedia.org/wiki/File:" + meta["fichier"].replace(" ", "_")
            lignes.append(f"- `{nom}/photo.jpg` : {meta['auteur']}, {meta['licence']}, <{page}>")
        (depart / "recettes" / "CREDITS.md").write_text("\n".join(lignes) + "\n", encoding="utf-8")


def extraire_magick(archive: Path, cible: Path) -> bool:
    """`magick.exe` sorti de l'archive 7z, par `7z` ou `py7zr`, selon ce qui est là."""
    if cible.exists():
        return True
    cible.parent.mkdir(parents=True, exist_ok=True)
    if shutil.which("7z"):
        subprocess.run(["7z", "e", "-y", f"-o{cible.parent}", str(archive), "magick.exe", "LICENSE.txt"],
                       check=True, capture_output=True)
        return cible.exists()
    try:
        import py7zr  # type: ignore
    except ImportError:
        return False
    with py7zr.SevenZipFile(archive) as z:
        z.extract(path=cible.parent, targets=["magick.exe", "LICENSE.txt"])
    return cible.exists()


def reduire(source: Path, cible: Path, largeur: int) -> None:
    """Le JPEG réduit à `largeur` pixels de large, proportions gardées."""
    from PIL import Image  # dans l'environnement info01, comme chez les étudiants

    with Image.open(source) as image:
        hauteur = round(image.height * largeur / image.width)
        image.resize((largeur, hauteur), Image.LANCZOS).save(cible, quality=90)


def build() -> None:
    # TD 1a : les recettes et le notebook (posé là par construire_notebooks.py).
    produit = TD_RECETTE / "produit"
    vider(produit)
    (produit / "travail").mkdir()
    copier_recettes(produit / "depart", avec_photos=False)
    print(f"✓ {TD_RECETTE.name}/produit/depart/")

    # TD 2a : les recettes, que relit le notebook des fichiers (posé là par
    # construire_notebooks.py).
    produit = TD_FICHIERS / "produit"
    vider(produit)
    (produit / "travail").mkdir()
    copier_recettes(produit / "depart", avec_photos=False)
    print(f"✓ {TD_FICHIERS.name}/produit/depart/")

    # TD 2b : les images de départ.
    produit = TD_IMAGES / "produit"
    vider(produit)
    (produit / "travail").mkdir()
    depart = produit / "depart"
    depart.mkdir()
    (depart / "motif.pgm").write_text(MOTIF, encoding="ascii")
    original = TD_IMAGES / "fourni" / VAGUE_ORIGINAL
    if original.exists():
        reduire(original, depart / VAGUE, LARGEUR_VAGUE)
    else:
        print(f"! {original.relative_to(ICI)} absent — lancer `fetch`")
    (depart / "CREDITS.md").write_text(
        "# Images\n\n"
        "- `vague.jpg` : Katsushika Hokusai, *Under the Wave off Kanagawa*, "
        "The Metropolitan Museum of Art, open access (CC0), "
        "<https://www.metmuseum.org/art/collection/search/45434>\n",
        encoding="utf-8")
    print(f"✓ {TD_IMAGES.name}/produit/depart/")

    # TD 3b : les recettes avec leurs photos, l'outil portable, le corrigé.
    produit = TD_CLI / "produit"
    vider(produit)
    (produit / "travail").mkdir()
    copier_recettes(produit / "depart", avec_photos=True)
    archive = TD_CLI / "fourni" / MAGICK_ARCHIVE
    exe = produit / "depart" / "outils" / "magick.exe"
    if not archive.exists():
        print(f"! {archive.relative_to(ICI)} absent — lancer `fetch`")
    elif extraire_magick(archive, exe):
        print(f"✓ {exe.relative_to(ICI)} ({exe.stat().st_size / 1e6:.0f} Mo)")
    else:
        print(f"! ni `7z` ni `py7zr` : extraire magick.exe de {archive.name} "
              f"à la main dans {exe.parent.relative_to(ICI)}/")
    corrige = CORRIGES / "3b_cli"
    if corrige.is_dir():
        shutil.copytree(corrige, produit / "_corrige")
    print(f"✓ {TD_CLI.name}/produit/depart/")

    # TD 3a : le dépôt des recettes, `depart/recettes/`, reçoit les quatre
    # recettes et la feuille de style ; `outils/construire_notebooks.py` y
    # ajoute `pages.ipynb`. Le texte de la nouvelle recette et le résultat
    # attendu sont versionnés dans `3a_markdown/depart/` ; `produit/` y ajoute
    # la photo des gaufres et les crédits.
    produit = TD_MARKDOWN / "produit"
    vider(produit)
    (produit / "travail").mkdir()
    depart = produit / "depart"
    for dossier in sorted(RECETTES.iterdir()):
        if dossier.is_dir():
            shutil.copytree(dossier, depart / "recettes" / dossier.name)
    shutil.copy2(RECETTES / "style.css", depart / "recettes" / "style.css")
    (depart / "gaufres").mkdir(parents=True)
    photo = TD_MARKDOWN / "fourni" / "gaufres.jpg"
    if photo.exists():
        shutil.copy2(photo, depart / "gaufres" / "photo.jpg")
    else:
        print(f"! {photo.relative_to(ICI)} absent — lancer `fetch`")
    page = "https://commons.wikimedia.org/wiki/File:" + PHOTO_GAUFRES["fichier"].replace(" ", "_")
    (depart / "CREDITS.md").write_text(
        "# Photo\n\n"
        f"- `gaufres/photo.jpg` : {PHOTO_GAUFRES['auteur']}, {PHOTO_GAUFRES['licence']}, <{page}>\n",
        encoding="utf-8")
    print(f"✓ {TD_MARKDOWN.name}/produit/depart/")


def main() -> None:
    analyseur = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    analyseur.add_argument("commande", choices=("fetch", "build"))
    options = analyseur.parse_args()
    fetch() if options.commande == "fetch" else build()


if __name__ == "__main__":
    main()
