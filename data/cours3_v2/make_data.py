#!/usr/bin/env python3
"""Traces GPS des TD du cours 3, version 2 (proposition 2027-2028).

Copie dans les dossiers des TD les deux traces de `traces/` : `trace.csv` (forêt de
Fontainebleau, gorges de Franchard) et `trace_2.csv` (de la gare de Noisy-Champs à
Geodata Paris). Elles viennent d'un chemin et d'altitudes réels, et simulent une marche
(`traces/fabriquer_traces.py`). Leurs colonnes sont celles qu'écrit `ogr2ogr` : `X`, `Y`
(Lambert-93, en mètres), `ele` (altitude, en mètres) et `time` (heure UTC). Les programmes
des TD, leurs corrigés et `altitudes.txt` sont versionnés à côté.

`altitudes.txt` et les listes des cours 1 et 2 sont une altitude sur 12 de `trace.csv`, soit
une toutes les 6 minutes. Le programme de départ du TD 3a est une copie du corrigé du TD 2c.
Le script signale par une ligne `! …` un écart à l'une de ces deux règles, et
`outils/livrer_tds.py` s'arrête.

    python data/cours3_v2/make_data.py build
"""

from __future__ import annotations

import csv
import shutil
import sys
from pathlib import Path

ICI = Path(__file__).resolve().parent
DEPARTS = {
    "3a_denivele": ("trace.csv",),
    "3b_portabilite": ("trace.csv", "trace_2.csv"),
    "3c_encodage": ("trace.csv", "trace_2.csv"),
}


def verifier_listes() -> None:
    """`altitudes.txt` et le corrigé du TD 2c contiennent une altitude sur 12 de `trace.csv`."""
    with open(ICI / "traces" / "trace.csv", encoding="utf-8") as fichier:
        altitudes = [ligne["ele"] for ligne in csv.DictReader(fichier)]
    attendues = altitudes[::12][:5]
    texte = ICI / "3a_denivele" / "depart" / "altitudes.txt"
    if texte.read_text(encoding="utf-8").split() != attendues:
        print(f"! {texte.relative_to(ICI.parent.parent)} diffère de {attendues}")
    corrige = ICI.parent / "cours2_v2" / "corriges" / "2c_depot_altitudes" / "altitudes.py"
    liste = f"altitudes = [{', '.join(attendues)}]"
    if liste not in corrige.read_text(encoding="utf-8"):
        print(f"! {corrige.relative_to(ICI.parent.parent)} ne contient pas {liste}")


def build() -> None:
    for td, noms in DEPARTS.items():
        for nom in noms:
            cible = ICI / td / "depart" / nom
            shutil.copyfile(ICI / "traces" / nom, cible)
            print(f"✓ {cible.relative_to(ICI.parent.parent)}")
    verifier_listes()
    depart = ICI / "3a_denivele" / "depart" / "altitudes.py"
    corrige = ICI.parent / "cours2_v2" / "corriges" / "2c_depot_altitudes" / "altitudes.py"
    if depart.read_text(encoding="utf-8") != corrige.read_text(encoding="utf-8"):
        print(f"! {depart.relative_to(ICI.parent.parent)} diffère de {corrige.relative_to(ICI.parent.parent)}")


if __name__ == "__main__":
    if sys.argv[1:] != ["build"]:
        sys.exit(__doc__)
    build()
