#!/usr/bin/env python3
"""Relève dans les supports les tournures que STYLE.md proscrit.

Les relectures des supports corrigent toujours les mêmes tournures : le
contraste (« X, pas Y », « plutôt que »), la formule « c'est », le tiret
cadratin en connecteur, la question rhétorique, les tics de la table de
STYLE.md. Ce script les cherche avant la relecture, pour qu'elle porte sur le
fond.

    python outils/verifier_style.py                  # lignes ajoutées depuis le dernier commit
    python outils/verifier_style.py --depuis main~3  # depuis un autre commit
    python outils/verifier_style.py --tout src/cours3/diapo/parties/01_programme.typ

Par défaut, seules les lignes ajoutées ou modifiées sont lues (`git diff`) :
le texte déjà relu n'est pas signalé de nouveau, y compris une ligne déplacée
à l'identique d'un fichier à l'autre. `--tout` lit les fichiers
entiers. Sont lus les `.typ` et `.md` de `src/` et de `syllabus/` ; les blocs
de code des pages Markdown, les lignes de code des cellules et les
commentaires `//` des sources typst sont ignorés.

Un signalement n'est pas une erreur certaine : « ne … pas » est souvent
correct. Chaque ligne signalée se relit, et se réécrit si la tournure est
celle que la règle vise. Sort en code 1 s'il y a des signalements.
"""

from __future__ import annotations

import argparse
import re
import subprocess
import sys
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
DOSSIERS = ("src", "syllabus")

# (règle, motif) : la règle renvoie à STYLE.md ou aux relectures qui l'ont fixée.
REGLES = [
    ("contraste « X, pas Y »", re.compile(r",\s+pas\s+(?!de\b|d'|à\b|encore\b|toujours\b)\w", re.I)),
    ("contraste « plutôt que »", re.compile(r"\bplutôt qu", re.I)),
    ("contraste « et non »", re.compile(r"\bet non\b", re.I)),
    ("contraste « non pas » / « pas … mais »", re.compile(r"\bnon pas\b|\bpas\b[^.;:]{1,40},\s*mais\b", re.I)),
    ("formule « c'est »", re.compile(r"\bc['’]est\b", re.I)),
    ("tiret cadratin en connecteur", re.compile(r"\s—\s")),
    ("question rhétorique", re.compile(r"[^\s`\"']\s?\?(\s|$)")),
    ("tic (STYLE.md)", re.compile(
        r"\b(voilà|rien de plus|c'est tout|tout simplement|il suffit|suffit|"
        r"en fait|justement|magique|la clé|au passage|d'un coup d'œil)\b", re.I)),
    ("méta-commentaire", re.compile(r"\b(à retenir de la|le moment|l'idée centrale|important de)\b", re.I)),
    ("image : « vit », « tient », « se suit seul »", re.compile(r"\b(vit dans|vivent dans|tient dans|se suit seul|se suivent seuls)\b", re.I)),
]


def lignes_ajoutees(depuis: str) -> dict[Path, set[int]]:
    """Les numéros des lignes ajoutées ou modifiées, par fichier, depuis un commit."""
    sortie = subprocess.run(
        ["git", "diff", "-U0", "--no-color", depuis, "--", *DOSSIERS],
        capture_output=True, text=True, cwd=RACINE, check=True,
    ).stdout
    # Les fichiers nouveaux, non suivis, comptent en entier.
    nouveaux = subprocess.run(
        ["git", "ls-files", "--others", "--exclude-standard", "--", *DOSSIERS],
        capture_output=True, text=True, cwd=RACINE, check=True,
    ).stdout.split()
    lignes: dict[Path, set[int]] = {}
    # Une ligne retirée quelque part et ajoutée ailleurs, à l'identique, est un
    # déplacement : son texte a déjà été relu.
    retirees = {l[1:].strip() for l in sortie.splitlines()
                if l.startswith("-") and not l.startswith("---") and l[1:].strip()}
    fichier = None
    numero = 0
    for ligne in sortie.splitlines():
        if ligne.startswith("+++ "):
            nom = ligne[4:]
            fichier = None if nom == "/dev/null" else RACINE / nom.removeprefix("b/")
        elif ligne.startswith("@@") and fichier is not None:
            numero = int(re.search(r"\+(\d+)", ligne).group(1))
        elif ligne.startswith("+") and fichier is not None:
            if ligne[1:].strip() not in retirees:
                lignes.setdefault(fichier, set()).add(numero)
            numero += 1
    for nom in nouveaux:
        chemin = RACINE / nom
        if chemin.is_file() and chemin.suffix in (".typ", ".md"):
            lignes[chemin] = {
                n for n, texte in enumerate(chemin.read_text(encoding="utf-8").splitlines(), 1)
                if texte.strip() not in retirees
            }
    return {f: n for f, n in lignes.items() if f.suffix in (".typ", ".md")}


def lignes_de_prose(chemin: Path) -> list[tuple[int, str]]:
    """Les lignes à relire, sans le code ni les commentaires de source."""
    resultat = []
    dans_code = False
    for numero, ligne in enumerate(chemin.read_text(encoding="utf-8").splitlines(), 1):
        propre = ligne.strip()
        if chemin.suffix == ".md":
            if propre.startswith("```"):
                dans_code = not dans_code
                continue
            if dans_code:
                continue
        elif propre.startswith("//"):
            continue
        # Le code en ligne (`…`) n'est pas de la prose.
        resultat.append((numero, re.sub(r"`[^`]*`", "``", ligne)))
    return resultat


def main() -> int:
    analyseur = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    analyseur.add_argument("fichiers", nargs="*", type=Path, help="avec --tout : les fichiers à lire")
    analyseur.add_argument("--depuis", default="HEAD", help="commit de référence pour les lignes ajoutées")
    analyseur.add_argument("--tout", action="store_true", help="lire les fichiers entiers")
    options = analyseur.parse_args()

    if options.tout:
        fichiers = options.fichiers or [p for d in DOSSIERS for p in (RACINE / d).rglob("*") if p.suffix in (".typ", ".md")]
        a_lire = {p.resolve(): None for p in fichiers}
    else:
        a_lire = lignes_ajoutees(options.depuis)

    signalements = 0
    for chemin, retenues in sorted(a_lire.items()):
        for numero, ligne in lignes_de_prose(chemin):
            if retenues is not None and numero not in retenues:
                continue
            for regle, motif in REGLES:
                if motif.search(ligne):
                    print(f"{chemin.relative_to(RACINE)}:{numero} : {regle}\n    {ligne.strip()}")
                    signalements += 1
    if signalements:
        print(f"\n{signalements} signalement(s) : relire chaque ligne avec STYLE.md.")
    return 1 if signalements else 0


if __name__ == "__main__":
    sys.exit(main())
