"""Écrit le TD 4b du projet 4, reprise du TD 3a du cours 3 pour le parcours standard.

Le parcours standard fait au projet 4 le TD 3a du cours 3, que le parcours
avancé a fait au cours 3. Le TD garde son texte ; seuls son numéro, son
dossier et son parcours changent. Ce script écrit, à partir des fichiers du
cours 3 :

    - `src/cours4/diapo/tds/4b_cli.typ`, la feuille de TD ;
    - `src/cours4/notebook/td/4b_cli/guide.md` et ses `illustrations/`.

Modifier le TD 3a dans le cours 3, puis relancer ce script, plutôt que de
modifier ces fichiers, qu'il réécrit.

    python data/cours4/reprendre_td3a.py
    python data/cours4/make_data.py build     # après celui du cours 3
    python outils/compiler_tds.py --cours 4
    python outils/compiler_guides.py --cours 4
"""

from __future__ import annotations

import shutil
from pathlib import Path

DEPOT = Path(__file__).resolve().parent.parent.parent
FEUILLE = DEPOT / "src" / "cours3" / "diapo" / "tds" / "3a_cli.typ"
GUIDE = DEPOT / "src" / "cours3" / "notebook" / "td" / "3a_cli"

EN_TETE = (
    "// Écrit par data/cours4/reprendre_td3a.py depuis le TD 3a du cours 3 :\n"
    "// modifier le TD 3a, puis relancer le script.\n"
)

# Remplacements appliqués dans l'ordre. Les chemins d'abord, pour que
# « 3a_cli » ne soit plus lu comme « TD 3a ».
REMPLACEMENTS = [
    ("cours3/3a_cli", "cours4/4b_cli"),
    ("guide_3a_cli", "guide_4b_cli"),
    ("td_3a_cli", "td_4b_cli"),
    # Les corrigés restent ceux du cours 3 : une marque les protège du
    # remplacement de « 3a_cli », puis devient leur chemin dans le dépôt.
    ("data/cours3/corriges/3a_cli", "@CORRIGES@"),
    ("corriges/3a_cli", "@CORRIGES@"),
    ("`cours3.typ`", "`cours4.typ`"),
    # Les gabarits de la feuille sont ceux du cours 3.
    ('#import "../schemas.typ": *', '#import "../../../cours3/diapo/schemas.typ": *'),
    ("3a_cli", "4b_cli"),
    ("TD 3a du cours 3", "TD 4b du projet 4"),
    ("TD 3a", "TD 4b"),
    ('numero: "3a"', 'numero: "4b"'),
    ("Parcours avancé : construire", "Parcours standard : construire"),
    # Le dossier livré au projet 4 n'a pas l'outil portable du cours 3.
    ("│   ├── secours/\n│   │   └── recette.py\n│   └── outils/",
     "│   └── secours/\n│       └── recette.py"),
    ("@CORRIGES@", "data/cours3/corriges/3a_cli"),
]


def reprendre(texte: str) -> str:
    for ancien, nouveau in REMPLACEMENTS:
        texte = texte.replace(ancien, nouveau)
    return texte


def main() -> None:
    cible = DEPOT / "src" / "cours4" / "diapo" / "tds" / "4b_cli.typ"
    cible.write_text(EN_TETE + reprendre(FEUILLE.read_text(encoding="utf-8")), encoding="utf-8")
    print("ok", cible.relative_to(DEPOT))

    dossier = DEPOT / "src" / "cours4" / "notebook" / "td" / "4b_cli"
    if dossier.exists():
        shutil.rmtree(dossier)
    (dossier / "illustrations").mkdir(parents=True)
    guide = reprendre((GUIDE / "guide.md").read_text(encoding="utf-8"))
    # Une ligne de commentaire MyST, après l'en-tête YAML, dit d'où vient le guide.
    fin_entete = guide.index("\n---\n", 4) + len("\n---\n")
    guide = (guide[:fin_entete] + "\n% Écrit par data/cours4/reprendre_td3a.py depuis le guide du TD 3a"
             " du cours 3 : modifier celui-ci, puis relancer le script.\n" + guide[fin_entete:])
    (dossier / "guide.md").write_text(guide, encoding="utf-8")
    for figure in sorted((GUIDE / "illustrations").glob("*.typ")):
        texte = EN_TETE + reprendre(figure.read_text(encoding="utf-8"))
        (dossier / "illustrations" / figure.name).write_text(texte, encoding="utf-8")
    print("ok", dossier.relative_to(DEPOT))


if __name__ == "__main__":
    main()
