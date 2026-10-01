#!/usr/bin/env python3
"""Construit le book et le publie sur GitHub Pages, avec des fichiers à télécharger.

    python outils/publier_book.py                                # construit, publie
    python outils/publier_book.py livraison/*.zip                # + ces fichiers dans telechargements/
    python outils/publier_book.py --sans-publier livraison/*.zip # construit seulement, pour vérifier

Trois étapes, depuis la racine du dépôt :

    1. `sphinx-build -E -b html src _build/html`, `-E` pour que toutes les
       pages soient réécrites avec le menu à jour ;
    2. les fichiers donnés sont copiés dans `_build/html/telechargements/`,
       vidé au préalable, avec un `index.html` qui les liste — GitHub Pages
       n'affiche pas le contenu d'un dossier ;
    3. `ghp-import -n -p -f -o _build/html` pousse le tout sur la branche
       `gh-pages` du remote GitHub, que GitHub Pages sert.

`-n` ajoute le `.nojekyll` sans lequel GitHub ignore `_static/` ; `-o` refait
la branche à partir d'un seul commit, sans quoi chaque publication ajoute à
l'historique une copie des archives.

Les fichiers peuvent venir d'ailleurs que de `livraison/` — d'un autre
worktree, par exemple — : ils sont pris tels quels, sous leur nom. Les limites
de GitHub Pages sont 100 Mo par fichier et 1 Go par site.
"""

from __future__ import annotations

import argparse
import html
import shutil
import subprocess
import sys
from datetime import datetime
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
SORTIE = RACINE / "_build" / "html"
TELECHARGEMENTS = SORTIE / "telechargements"


def taille_lisible(octets: int) -> str:
    for unite in ("o", "Ko", "Mo", "Go"):
        if octets < 1024:
            return f"{octets:.0f} {unite}" if unite == "o" else f"{octets:.1f} {unite}"
        octets /= 1024
    return f"{octets:.1f} To"


def construire() -> None:
    subprocess.run(
        ["sphinx-build", "-E", "-b", "html", "src", str(SORTIE.relative_to(RACINE))],
        cwd=RACINE, check=True,
    )


def deposer(fichiers: list[Path]) -> list[Path]:
    """Copie les fichiers dans telechargements/ et écrit la page qui les liste."""
    shutil.rmtree(TELECHARGEMENTS, ignore_errors=True)
    TELECHARGEMENTS.mkdir(parents=True)
    deposes = []
    for source in fichiers:
        if not source.is_file():
            sys.exit(f"introuvable : {source}")
        cible = TELECHARGEMENTS / source.name
        if cible.exists():
            sys.exit(f"deux fichiers portent le nom {source.name}")
        shutil.copy2(source, cible)
        deposes.append(cible)

    lignes = []
    for f in sorted(deposes):
        stat = f.stat()
        date = datetime.fromtimestamp(stat.st_mtime).strftime("%d/%m/%Y")
        nom = html.escape(f.name)
        lignes.append(
            f'<li><a href="{nom}">{nom}</a> — {taille_lisible(stat.st_size)}, {date}</li>'
        )
    liste = "\n".join(lignes) if lignes else "<li>Aucun fichier pour l'instant.</li>"
    (TELECHARGEMENTS / "index.html").write_text(
        f"""<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="utf-8">
<title>Téléchargements — Introduction à l'informatique</title>
<style>
  body {{ font-family: system-ui, sans-serif; max-width: 40em; margin: 3em auto; padding: 0 1em; line-height: 1.5; }}
  li {{ margin: .4em 0; }}
</style>
</head>
<body>
<h1>Téléchargements</h1>
<p>Une archive par séance, avec les fichiers des TD. Décompresser, puis
ouvrir le dossier obtenu dans JupyterLab ou VS Code.</p>
<ul>
{liste}
</ul>
<p><a href="../index.html">Retour au cours</a></p>
</body>
</html>
""",
        encoding="utf-8",
    )
    return deposes


def remote_github() -> str:
    """Le remote qui pointe vers GitHub : `origin` sur un clone, mais un poste
    qui a aussi la clé USB et GitLab le nomme souvent autrement."""
    sortie = subprocess.run(["git", "remote", "-v"], cwd=RACINE,
                            capture_output=True, text=True, check=True).stdout
    for ligne in sortie.splitlines():
        nom, url, *_ = ligne.split()
        if "github.com" in url:
            return nom
    return "origin"


def publier() -> None:
    subprocess.run(
        ["ghp-import", "-n", "-p", "-f", "-o", "-r", remote_github(),
         "-m", f"Publie le book ({datetime.now():%Y-%m-%d %H:%M})",
         str(SORTIE.relative_to(RACINE))],
        cwd=RACINE, check=True,
    )


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument("fichiers", nargs="*", type=Path,
                        help="fichiers à déposer dans telechargements/")
    parser.add_argument("--sans-publier", action="store_true",
                        help="construire sans pousser gh-pages")
    args = parser.parse_args()

    construire()
    deposes = deposer([f.resolve() for f in args.fichiers])
    for f in deposes:
        print(f"telechargements/{f.name} ({taille_lisible(f.stat().st_size)})")
    if args.sans_publier:
        print(f"\nBook dans {SORTIE.relative_to(RACINE)}/, non publié.")
        return
    publier()
    print("\nPublié : https://geodata-ing1-info-01.github.io/cours-info-01/")


if __name__ == "__main__":
    main()
