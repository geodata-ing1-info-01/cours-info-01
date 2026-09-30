#!/usr/bin/env python3
"""Compare deux versions d'un fichier texte, et applique le résultat ailleurs.

Deux commandes, dans cet ordre.

    python comparer.py creer recette.md recette_v2.md modifs.diff
    python comparer.py appliquer recette.md modifs.diff recette_v3.md

`creer` écrit dans `modifs.diff` ce qui distingue les deux versions, au format
« diff unifié » : quelques lignes de contexte, les lignes retirées préfixées
par `-`, les lignes ajoutées par `+`. C'est le format que produisent aussi
`diff -u`, `git diff` et la comparaison de VSCode ; il est lisible par un
humain autant que par un programme.

`appliquer` refait le chemin inverse : à partir de la première version et du
fichier de différences, il reconstruit la seconde, sous un nouveau nom. Rien
n'est modifié sur place, ce qui permet de vérifier le résultat avant de s'en
servir.

Le module `difflib` fait tout le travail de comparaison ; il est dans la
bibliothèque standard, donc rien n'est à installer.
"""

from __future__ import annotations

import difflib
import sys
from pathlib import Path


def lignes(chemin: Path) -> list[str]:
    """Le contenu d'un fichier texte, découpé en lignes, sauts de ligne gardés."""
    octets = chemin.read_bytes()
    try:
        return octets.decode("utf-8").splitlines(keepends=True)
    except UnicodeDecodeError:
        raise SystemExit(
            f"{chemin} n'est pas un fichier texte : ses octets ne se lisent pas "
            f"comme des caractères. D'un fichier binaire, une comparaison ne "
            f"peut dire que s'il diffère d'un autre, pas ce qui y a changé."
        )


def creer(avant: Path, apres: Path, sortie: Path) -> None:
    """Écrit dans `sortie` ce qui distingue `avant` de `apres`."""
    differences = difflib.unified_diff(
        lignes(avant),
        lignes(apres),
        fromfile=avant.name,
        tofile=apres.name,
    )
    texte = "".join(differences)
    sortie.write_text(texte, encoding="utf-8")
    nombre = sum(1 for l in texte.splitlines() if l[:1] in "+-" and l[:3] not in ("---", "+++"))
    print(f"{sortie} : {len(texte.splitlines())} lignes, dont {nombre} de différence")


def appliquer(avant: Path, differences: Path, sortie: Path) -> None:
    """Reconstruit la seconde version à partir de la première et des différences."""
    source = lignes(avant)
    resultat: list[str] = []
    position = 0  # index de la prochaine ligne de `source` à recopier

    for ligne in lignes(differences):
        if ligne.startswith("---") or ligne.startswith("+++"):
            continue
        if ligne.startswith("@@"):
            # « @@ -12,7 +12,8 @@ » : la section commence ligne 12 de la source.
            debut = int(ligne.split()[1].lstrip("-").split(",")[0]) - 1
            resultat.extend(source[position:debut])
            position = debut
        elif ligne.startswith("+"):
            resultat.append(ligne[1:])
        elif ligne.startswith("-"):
            attendu = ligne[1:]
            if source[position] != attendu:
                raise SystemExit(
                    f"{avant} ne correspond pas à {differences} : "
                    f"ligne {position + 1} attendue {attendu!r}, "
                    f"trouvée {source[position]!r}"
                )
            position += 1
        elif ligne.startswith(" "):
            resultat.append(source[position])
            position += 1

    resultat.extend(source[position:])
    sortie.write_text("".join(resultat), encoding="utf-8")
    print(f"{sortie} : {len(resultat)} lignes, reconstruites à partir de {avant}")


def main(arguments: list[str]) -> None:
    if len(arguments) != 4 or arguments[0] not in ("creer", "appliquer"):
        raise SystemExit(__doc__)
    commande, *chemins = arguments
    a, b, c = (Path(chemin) for chemin in chemins)
    if commande == "creer":
        creer(a, b, c)
    else:
        appliquer(a, b, c)


if __name__ == "__main__":
    main(sys.argv[1:])
