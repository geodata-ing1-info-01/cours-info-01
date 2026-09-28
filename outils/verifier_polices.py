#!/usr/bin/env python3
"""Vérifie que les polices du thème des diapositives sont installées, et les
installe pour l'utilisateur courant si on le demande.

Le thème reprend l'identité du thème Beamer « Bruno », qui impose Fira Sans avec
un « gras » qui n'est en réalité qu'un demi-gras (graisse 500). Les gabarits de
`src/commun/theme.typ` sont calibrés sur la chasse de cette police. Sans elle,
typst retombe sur la suivante de la pile ; le document compile toujours, mais les
proportions ne sont plus celles pour lesquelles il a été réglé.

    python outils/verifier_polices.py             # état des lieux
    python outils/verifier_polices.py --installer # télécharge et installe Fira Sans et Lato

L'installation se fait dans le dossier de polices de l'utilisateur, sans droits
d'administration et sans toucher au système :

    Linux    ~/.local/share/fonts/
    macOS    ~/Library/Fonts/
    Windows  %LOCALAPPDATA%\\Microsoft\\Windows\\Fonts

Sous Linux, fontconfig lit en réalité `$XDG_DATA_HOME/fonts`. Certains
environnements redéfinissent cette variable pour s'isoler : le terminal intégré
de VSCode installé en paquet snap la fait pointer dans le bac à sable du snap.
Le script installe alors aux deux endroits, pour que la compilation aboutisse
au même rendu depuis un terminal ordinaire et depuis celui de l'éditeur.

Lato est la police de repli de la pile (`police-texte`) : elle ne sert pas
quand Fira Sans est là, mais typst avertit à chaque compilation d'une famille
de la pile qu'il ne trouve pas (`unknown font family: lato`). L'installer fait
taire l'avertissement.

Fira Sans (Mozilla) et Lato (Google Fonts) sont publiées sous licence SIL Open
Font License 1.1, qui autorise la redistribution ; le dépôt ne les embarque pas
pour autant, afin de rester sans fichier binaire.
"""

from __future__ import annotations

import argparse
import os
import platform
import shutil
import subprocess
import sys
import urllib.error
import urllib.request
from pathlib import Path

# Pour chaque famille : l'adresse des fichiers, les coupes employées par le
# thème (le texte courant, son italique, le demi-gras des titres et son
# italique ; Lato n'a pas de demi-gras dans sa version Google Fonts, typst
# prend alors le gras) et la licence. Les autres graisses ne servent pas.
FAMILLES = {
    "Fira Sans": (
        "https://raw.githubusercontent.com/mozilla/Fira/master/ttf/",
        ("FiraSans-Regular.ttf", "FiraSans-Italic.ttf",
         "FiraSans-Medium.ttf", "FiraSans-MediumItalic.ttf"),
        "https://raw.githubusercontent.com/mozilla/Fira/master/LICENSE",
    ),
    "Lato": (
        "https://raw.githubusercontent.com/google/fonts/main/ofl/lato/",
        ("Lato-Regular.ttf", "Lato-Italic.ttf", "Lato-Bold.ttf", "Lato-BoldItalic.ttf"),
        "https://raw.githubusercontent.com/google/fonts/main/ofl/lato/OFL.txt",
    ),
}

FAMILLE = "Fira Sans"


def dossiers_polices() -> list[Path]:
    """Dossiers où déposer les polices, selon le système.

    Renvoie une liste parce que sous Linux il peut y en avoir deux, quand
    `XDG_DATA_HOME` a été détourné (voir l'en-tête du module).
    """
    systeme = platform.system()
    if systeme == "Darwin":
        return [Path.home() / "Library" / "Fonts"]
    if systeme == "Windows":
        local = os.environ.get("LOCALAPPDATA") or str(Path.home() / "AppData" / "Local")
        return [Path(local) / "Microsoft" / "Windows" / "Fonts"]

    dossiers = [Path.home() / ".local" / "share" / "fonts"]
    xdg = os.environ.get("XDG_DATA_HOME")
    if xdg:
        autre = Path(xdg) / "fonts"
        if autre not in dossiers:
            dossiers.append(autre)
    return dossiers


def familles_vues_par_typst() -> set[str] | None:
    """Familles que typst sait charger, ou None s'il n'est pas installé."""
    if shutil.which("typst") is None:
        return None
    sortie = subprocess.run(
        ["typst", "fonts"], capture_output=True, text=True, check=False
    )
    return {ligne.strip() for ligne in sortie.stdout.splitlines() if ligne.strip()}


def installer(destination: Path, famille: str) -> int:
    base_url, coupes, licence_url = FAMILLES[famille]
    destination.mkdir(parents=True, exist_ok=True)
    for nom in coupes:
        cible = destination / nom
        if cible.exists():
            print(f"  déjà présent  {cible}")
            continue
        try:
            with urllib.request.urlopen(base_url + nom, timeout=60) as reponse:
                cible.write_bytes(reponse.read())
        except (urllib.error.URLError, TimeoutError) as erreur:
            print(f"  échec         {nom} : {erreur}", file=sys.stderr)
            return 1
        print(f"  installé      {cible}  ({cible.stat().st_size // 1024} Ko)")

    licence = destination / f"{famille.replace(' ', '')}-LICENSE.txt"
    if not licence.exists():
        try:
            with urllib.request.urlopen(licence_url, timeout=60) as reponse:
                licence.write_bytes(reponse.read())
        except (urllib.error.URLError, TimeoutError):
            pass

    # Sous Linux, fontconfig ne relit son cache que sur demande ; typst
    # l'interroge, donc il faut le rafraîchir avant de compiler.
    if platform.system() == "Linux" and shutil.which("fc-cache"):
        subprocess.run(["fc-cache", "-f", str(destination)], check=False)
    return 0


def main() -> int:
    analyseur = argparse.ArgumentParser(
        description="Vérifie, et installe au besoin, les polices des diapositives."
    )
    analyseur.add_argument(
        "--installer",
        action="store_true",
        help="télécharge Fira Sans et Lato et les installe pour l'utilisateur courant",
    )
    options = analyseur.parse_args()

    if options.installer:
        for famille in FAMILLES:
            for destination in dossiers_polices():
                print(f"Installation de {famille} dans {destination}")
                if installer(destination, famille) != 0:
                    return 1
        print()

    familles = familles_vues_par_typst()
    if familles is None:
        print("typst est introuvable : `conda activate info01` d'abord.", file=sys.stderr)
        return 2

    if "Lato" not in familles:
        print("Lato : absente. Police de repli seulement : typst avertira\n"
              "`unknown font family: lato` à chaque compilation, sans effet sur le rendu.\n")

    if FAMILLE in familles:
        print(f"{FAMILLE} : installée. Les diapositives rendront comme prévu.")
        return 0

    print(f"{FAMILLE} : absente.")
    print(
        "Les diapositives compilent quand même, mais typst emploiera la police de\n"
        "repli, dont la chasse est plus large : les schémas et les tableaux ne\n"
        "tiennent plus dans les proportions réglées pour le thème.\n"
    )
    print("Pour l'installer :\n")
    print("    python outils/verifier_polices.py --installer\n")
    return 1


if __name__ == "__main__":
    sys.exit(main())
