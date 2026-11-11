#!/usr/bin/env python3
"""Données du TD 7a, cours 7 version 2 (proposition 2027-2028).

Le TD part d'un dépôt modèle du compte GitHub du module,
`geodata-ing1-info-01/td7a-trace`, marqué « Template repository ». Chaque élève en
crée une copie sur son compte (« Use this template »), la clone en HTTPS, ajoute
l'option `--profil` sur une branche, pousse cette branche, puis la fusionne par une
pull request.

Ce script écrit dans `depot_modele/` le contenu du dépôt modèle, à pousser à la main
sur GitHub : le programme de la fin du TD 4a v2 (`stats_trace.py`, étape B6), les deux
traces, un `README.md` et un `.gitignore`. Il construit ensuite les deux versions de
l'étape 3 du TD par remplacements, les exécute, et écrit les corrigés dans
`corriges/7a_trace/`. Une ligne `! …` signale un écart, et `outils/livrer_tds.py`
s'arrête.

Le guide du TD reçoit ses blocs de code et ses sorties de ce module, par Cog
(`outils/guides_cog.py`) : `versions()`, `executer()`, `profil()` et `PROGRAMME`.

    python data/cours7_v2/make_data.py build      # dépôt modèle, corrigés, dossier du TD
    python data/cours7_v2/make_data.py sorties    # les sorties, pour les diapositives
"""

from __future__ import annotations

import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ICI = Path(__file__).resolve().parent
DONNEES = ICI.parent
SOURCE = DONNEES / "cours4_v2" / "corriges" / "4a_trace" / "b6" / "stats_trace.py"
TRACES = DONNEES / "cours3_v2" / "traces"
MODELE = ICI / "depot_modele"
TD = ICI / "7a_trace"
PROGRAMME = "stats_trace.py"

README = """# Statistiques d'une trace GPS

`stats_trace.py` lit une trace GPS dans un fichier CSV, puis affiche ses altitudes
extrêmes, son dénivelé cumulé et, sur option, la distance parcourue et la vitesse
moyenne. Programme écrit au TD 4a du module d'introduction à l'informatique.

## Lancement

```text
python stats_trace.py trace.csv --distance --vitesse
```

| Option | Effet |
|---|---|
| `-s`, `--seuil` | variation d'altitude ignorée sous ce seuil, en mètres |
| `--distance` | affiche la distance parcourue |
| `--vitesse` | affiche la vitesse moyenne |

## Données

`trace.csv` et `trace_2.csv` : une position toutes les 30 secondes, colonnes `X` et
`Y` en Lambert-93, `ele` (altitude, en mètres) et `time` (heure UTC).
"""

GITIGNORE = "resume.txt\n__pycache__/\n"

# L'étape 3 du TD, en deux commits : l'option et un message, puis le calcul et
# l'écriture du fichier. Chaque entrée : (ancien texte, nouveau texte).
ETAPE_3_1 = [
    ('                       help="affiche la vitesse moyenne")\n',
     '                       help="affiche la vitesse moyenne")\n'
     'analyseur.add_argument("--profil", action="store_true",\n'
     '                       help="écrit le profil altimétrique dans profil.csv")\n'),
    ("        if options.distance or options.vitesse:\n",
     "        if options.distance or options.vitesse or options.profil:\n"),
    ('    print(f"vitesse moyenne : {vitesse:.2f} m/s, soit {vitesse * 3.6:.1f} km/h")\n',
     '    print(f"vitesse moyenne : {vitesse:.2f} m/s, soit {vitesse * 3.6:.1f} km/h")\n'
     "\n"
     "if options.profil:\n"
     '    print("profil : calcul manquant")\n'),
]
ETAPE_3_2 = [
    ("    return total\n",
     "    return total\n"
     "\n"
     "\n"
     "def profil(points):\n"
     '    """La distance cumulée et l\'altitude de chaque position, en mètres."""\n'
     "    total = 0\n"
     "    lignes = [(total, points[0][2])]\n"
     "    for i in range(1, len(points)):\n"
     "        total = total + distance_entre(points[i - 1], points[i])\n"
     "        lignes.append((total, points[i][2]))\n"
     "    return lignes\n"),
    ('    print("profil : calcul manquant")\n',
     "    lignes = profil(points)\n"
     '    with open("profil.csv", "w", encoding="utf-8") as fichier_profil:\n'
     '        fichier_profil.write("distance,altitude\\n")\n'
     "        for distance_cumulee, altitude in lignes:\n"
     '            fichier_profil.write(f"{distance_cumulee:.1f},{altitude}\\n")\n'
     '    print(f"profil : profil.csv, {len(lignes)} positions")\n'),
]


def appliquer(texte: str, remplacements: list[tuple[str, str]], nom: str) -> str | None:
    for ancien, nouveau in remplacements:
        if texte.count(ancien) != 1:
            print(f"! {nom} : texte trouvé {texte.count(ancien)} fois : {ancien[:50]!r}")
            return None
        texte = texte.replace(ancien, nouveau)
    return texte


def versions() -> dict[str, str] | None:
    depart = SOURCE.read_text(encoding="utf-8")
    v1 = appliquer(depart, ETAPE_3_1, "étape 3.1")
    v2 = appliquer(v1, ETAPE_3_2, "étape 3.2") if v1 else None
    if v2 is None:
        return None
    return {"depart": depart, "3.1": v1, "3.2": v2}


def lancer(programme: str, *arguments: str) -> tuple[str, str]:
    """La sortie de `python stats_trace.py *arguments`, et le contenu de `profil.csv`."""
    with tempfile.TemporaryDirectory() as temporaire:
        dossier = Path(temporaire)
        (dossier / "stats_trace.py").write_text(programme, encoding="utf-8")
        for nom in ("trace.csv", "trace_2.csv"):
            shutil.copy(TRACES / nom, dossier)
        resultat = subprocess.run([sys.executable, "stats_trace.py", *arguments], cwd=dossier,
                                  capture_output=True, text=True, encoding="utf-8")
        profil = dossier / "profil.csv"
        contenu = profil.read_text(encoding="utf-8") if profil.exists() else ""
    return (resultat.stdout + resultat.stderr).rstrip("\n"), contenu


def executer(nom: str, *arguments: str) -> str:
    """La sortie de `python stats_trace.py *arguments`, le programme à la version `nom`."""
    return lancer(versions()[nom], *arguments)[0]


def profil(nom: str, *arguments: str, debut: int = 4, fin: int = 2) -> str:
    """Le début et la fin de `profil.csv`, écrit par le programme à la version `nom`."""
    lignes = lancer(versions()[nom], *arguments)[1].splitlines()
    return "\n".join(lignes[:debut] + ["…"] + lignes[-fin:])


def build() -> None:
    textes = versions()
    if textes is None:
        return
    for nom, programme in textes.items():
        if nom == "depart":
            continue
        sortie, _ = lancer(programme, "trace.csv", "--profil", "--distance", "--vitesse")
        if "Traceback" in sortie or "error" in sortie.lower():
            print(f"! étape {nom} : {sortie}")
            return
    shutil.rmtree(MODELE, ignore_errors=True)
    MODELE.mkdir(parents=True)
    (MODELE / "stats_trace.py").write_text(textes["depart"], encoding="utf-8", newline="\n")
    for nom in ("trace.csv", "trace_2.csv"):
        shutil.copy(TRACES / nom, MODELE)
    (MODELE / "README.md").write_text(README, encoding="utf-8", newline="\n")
    (MODELE / ".gitignore").write_text(GITIGNORE, encoding="utf-8", newline="\n")
    print(f"✓ {MODELE.relative_to(DONNEES.parent)} : le contenu du dépôt modèle")
    for nom in ("3.1", "3.2"):
        corrige = ICI / "corriges" / "7a_trace" / f"etape_{nom.replace('.', '_')}" / "stats_trace.py"
        corrige.parent.mkdir(parents=True, exist_ok=True)
        corrige.write_text(textes[nom], encoding="utf-8", newline="\n")
    print(f"✓ {(ICI / 'corriges' / '7a_trace').relative_to(DONNEES.parent)} : les deux versions de l'étape 3")
    (TD / "travail").mkdir(parents=True, exist_ok=True)
    (TD / "travail" / ".gitkeep").touch()


def sorties() -> None:
    textes = versions()
    if textes is None:
        return
    for nom, arguments in (("3.1", ("trace.csv", "--profil")),
                           ("3.2", ("trace.csv", "--profil")),
                           ("3.2", ("trace_2.csv", "--profil"))):
        sortie, contenu = lancer(textes[nom], *arguments)
        print(f"--- étape {nom} : python stats_trace.py {' '.join(arguments)}")
        print(sortie)
        if contenu:
            lignes = contenu.splitlines()
            print(f"--- profil.csv : {len(lignes)} lignes")
            print("\n".join(lignes[:4] + ["…"] + lignes[-2:]))


if __name__ == "__main__":
    if sys.argv[1:] == ["build"]:
        build()
    elif sys.argv[1:] == ["sorties"]:
        sorties()
    else:
        sys.exit(__doc__)
