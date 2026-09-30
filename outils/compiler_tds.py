#!/usr/bin/env python3
"""Compile chaque TD d'une séance en feuille de TD séparée.

Un TD est un fichier de `src/cours<n>/diapo/tds/`, nommé comme le dossier que
l'étudiant ouvre : `1e_hello_cpp.typ` pour `cours1/1e_hello_cpp/`. Le même
fichier sert deux fois : inclus par `cours<n>.typ`, il est projeté au milieu du
cours ; compilé seul par ce script, il donne un PDF court que l'étudiant garde
sous les yeux pendant qu'il travaille.

    python outils/compiler_tds.py              # les TD du cours 1
    python outils/compiler_tds.py --cours 3    # ceux d'un autre cours
    python outils/compiler_tds.py --corrige    # + la version avec les réponses
    python outils/compiler_tds.py --lister     # ce qui serait produit, sans compiler

Le PDF est déposé dans le dossier que le TD annonce lui-même, par le champ
`dossier:` de sa description `td` — celui que l'étudiant a justement ouvert.
Ce champ est le chemin vu par l'étudiant, `cours1/1e_hello_cpp/` ; dans le
dépôt, il est sous `data/`. Le PDF s'appelle `td_<dossier>.pdf`, soit
`td_1e_hello_cpp.pdf`, et n'est pas versionné. Un TD qui se fait à la racine
de l'archive, comme la préparation du poste (`dossier: "cours3/"`), n'a pas de
dossier à lui : sa feuille est déposée dans `data/cours<n>/` et porte le nom du
fichier du TD, `td_3a_preparation.pdf` ; `outils/livrer_tds.py` la met à la
racine de l'archive.

Un cours sans dossier `tds/` n'est pas une erreur : ses TD peuvent n'avoir
qu'un guide en Markdown, compilé par `outils/compiler_guides.py`. Un TD peut
aussi avoir les deux, la feuille typst en résumé et le guide en détail.

Ce script écrit un fichier d'assemblage temporaire à côté de `cours<n>.typ` :
`typst` n'accepte que des chemins littéraux dans `include`, on ne peut donc pas
lui passer le TD à inclure en argument.
"""

from __future__ import annotations

import argparse
import re
import shutil
import subprocess
import sys
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent


def dossier_annonce(source: Path) -> str | None:
    """Le dossier que le TD annonce, tel que l'étudiant le voit."""
    trouve = re.search(r'dossier:\s*"([^"]+)"', source.read_text(encoding="utf-8"))
    return trouve.group(1) if trouve else None


def destination(dossier: str, cours: str) -> Path:
    """Le même dossier, dans le dépôt : sous `data/cours<n>/`.

    Le premier segment du chemin annoncé est remplacé par le dossier du cours
    compilé : un TD de la version 2 du cours 1 annonce `cours1/1a_formats/`,
    le chemin que l'étudiant verra, et sa feuille va dans
    `data/cours1_v2/1a_formats/`, sans remplacer celle de la version 1.
    """
    return RACINE / "data" / f"cours{cours}" / Path(*Path(dossier).parts[1:])


def nom_pdf(td: Path, dossier: str, corrige: bool) -> str:
    """`td_<dossier>.pdf`, ou `td_<fichier du TD>.pdf` pour un TD fait à la racine de l'archive."""
    nom = td.stem if len(Path(dossier).parts) == 1 else Path(dossier.rstrip("/")).name
    return f"td_{nom}{'-corrige' if corrige else ''}.pdf"


def reglages(assemblage: Path) -> str:
    """Les arguments de `diapos` du cours, repris tels quels par l'assemblage."""
    texte = assemblage.read_text(encoding="utf-8")
    trouve = re.search(r"#show: diapos\.with\((.*?)\)\n", texte, re.S)
    return trouve.group(1).strip() if trouve else ""


def compiler(td: Path, assemblage: Path, cours: str, corrige: bool, captures: bool) -> int:
    dossier = dossier_annonce(td)
    if dossier is None:
        print(f"{td.name} : aucun `dossier:` annoncé, ignoré", file=sys.stderr)
        return 0
    cible = destination(dossier, cours)
    if not cible.is_dir():
        print(f"{td.name} : {cible} n'existe pas, ignoré", file=sys.stderr)
        return 0

    sortie = cible / nom_pdf(td, dossier, corrige)
    temporaire = assemblage.with_name("_td_en_cours.typ")
    temporaire.write_text(
        "// Assemblage temporaire, écrit par outils/compiler_tds.py.\n"
        f'#import "../../commun/prelude.typ": *\n\n'
        f"#show: diapos.with({reglages(assemblage)})\n\n"
        f'#include "tds/{td.name}"\n',
        encoding="utf-8",
    )
    # `feuille=true` dit au TD qu'il est compilé seul : un TD ouvert dans le
    # cours par `separateur-cours-td` remet alors son ouverture brune.
    commande = ["typst", "compile", "--root", str(RACINE), "--input", "feuille=true"]
    if captures:
        commande += ["--input", "captures=true"]
    if corrige:
        commande += ["--input", "corrige=true"]
    commande += [str(temporaire), str(sortie)]
    try:
        resultat = subprocess.run(commande, check=False)
    finally:
        temporaire.unlink(missing_ok=True)
    if resultat.returncode == 0:
        print(f"  {sortie.relative_to(RACINE)}")
    return resultat.returncode


def main() -> int:
    analyseur = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    analyseur.add_argument("--cours", default="1", help="numéro du cours, 1 à 7, ou 1_v2 (défaut : 1)")
    analyseur.add_argument("--corrige", action="store_true", help="+ la version avec les réponses")
    analyseur.add_argument(
        "--sans-captures", action="store_true",
        help="ignorer les captures d'écran, pour vérifier le repli dessiné",
    )
    analyseur.add_argument("--lister", action="store_true", help="dire ce qui serait produit")
    options = analyseur.parse_args()

    diapo = RACINE / f"src/cours{options.cours}/diapo"
    assemblage = diapo / f"cours{options.cours}.typ"
    tds = sorted((diapo / "tds").glob("*.typ"))
    if not tds:
        # Un cours peut n'avoir que des guides en Markdown
        # (`outils/compiler_guides.py`) : rien à compiler ici, et pas d'erreur.
        print(f"{diapo.relative_to(RACINE)}/tds : aucune feuille de TD en typst")
        return 0

    if options.lister:
        for td in tds:
            dossier = dossier_annonce(td)
            if dossier is None:
                print(f"{td.name} → aucun dossier annoncé")
            else:
                print(f"{td.name} → {destination(dossier, options.cours).relative_to(RACINE)}/{nom_pdf(td, dossier, False)}")
        return 0

    if shutil.which("typst") is None:
        print("typst est introuvable : `conda activate info01` d'abord.", file=sys.stderr)
        return 2

    code = 0
    for td in tds:
        print(f"{td.name} :")
        code |= compiler(td, assemblage, options.cours, False, not options.sans_captures)
        if options.corrige:
            code |= compiler(td, assemblage, options.cours, True, not options.sans_captures)
    return code


if __name__ == "__main__":
    raise SystemExit(main())
