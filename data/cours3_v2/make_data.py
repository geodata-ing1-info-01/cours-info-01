#!/usr/bin/env python3
"""Traces GPS des TD du cours 3, version 2 (proposition 2027-2028).

Deux traces inventées, sans lien avec un parcours réel : la graine est fixée,
et le script redonne les mêmes fichiers. Les colonnes sont `durée` (secondes
depuis le départ), `x` et `y` (Lambert-93, en mètres) et `z` (altitude, en
mètres). Les trois premières altitudes de `trace.csv` sont celles du programme
`altitudes.py` du cours 1, et les cinq premières celles du corrigé du TD 2c. Les
programmes des TD, leurs corrigés et `altitudes.txt` sont versionnés à côté.

Le programme de départ du TD 3a est une copie du corrigé du TD 2c : le script
signale par une ligne `! …` qu'ils diffèrent, et `outils/livrer_tds.py` s'arrête.

    python data/cours3_v2/make_data.py build
"""

from __future__ import annotations

import math
import random
import sys
from pathlib import Path

ICI = Path(__file__).resolve().parent
ENTETE = "durée,x,y,z\n"
DEPARTS = {
    "3a_denivele": ("trace.csv",),
    "3b_portabilite": ("trace.csv", "trace_2.csv"),
    "3c_encodage": ("trace.csv", "trace_2.csv"),
}


def trace(graine: int, points: int, base: float, relief: float, bruit: float,
          debut: tuple[float, ...] = ()) -> str:
    """Le texte d'une trace : un point toutes les 30 secondes, à environ 1,2 m/s."""
    hasard = random.Random(graine)
    x, y = 673120.5, 6860840.2
    cap = hasard.uniform(0, 2 * math.pi)
    lignes = [ENTETE]
    for i in range(points):
        forme = math.sin(math.pi * i / (points - 1)) ** 2 + 0.25 * math.sin(6 * math.pi * i / (points - 1))
        z = debut[i] if i < len(debut) else base + relief * forme + hasard.gauss(0, bruit)
        lignes.append(f"{30 * i},{x:.1f},{y:.1f},{z:.1f}\n")
        cap += hasard.gauss(0, 0.25)
        x += 36 * math.cos(cap) + hasard.gauss(0, 1.5)
        y += 36 * math.sin(cap) + hasard.gauss(0, 1.5)
    return "".join(lignes)


def build() -> None:
    traces = {
        "trace.csv": trace(2026, 61, 128.0, 32.0, 0.7, debut=(128.4, 131.0, 127.6)),
        "trace_2.csv": trace(2027, 121, 112.0, 90.0, 1.2),
    }
    for td, noms in DEPARTS.items():
        for nom in noms:
            cible = ICI / td / "depart" / nom
            cible.write_text(traces[nom], encoding="utf-8", newline="\n")
            print(f"✓ {cible.relative_to(ICI.parent.parent)}")
    depart = ICI / "3a_denivele" / "depart" / "altitudes.py"
    corrige = ICI.parent / "cours2_v2" / "corriges" / "2c_depot_altitudes" / "altitudes.py"
    if depart.read_text(encoding="utf-8") != corrige.read_text(encoding="utf-8"):
        print(f"! {depart.relative_to(ICI.parent.parent)} diffère de {corrige.relative_to(ICI.parent.parent)}")


if __name__ == "__main__":
    if sys.argv[1:] != ["build"]:
        sys.exit(__doc__)
    build()
