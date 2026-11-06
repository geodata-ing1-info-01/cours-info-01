#!/usr/bin/env python3
"""Données des TD du cours 5, version 2 (proposition 2027-2028).

Le TD 5a reçoit le programme de la séance, `programme/carte_trace.py`, le programme de la
fin du TD 4a, `stats_trace.py`, et les deux traces GPX du cours 3
(`data/cours3_v2/traces/`). Ces copies sont versionnées, et le script les refait.

    python data/cours5_v2/make_data.py build
"""

from __future__ import annotations

import shutil
import sys
from pathlib import Path

ICI = Path(__file__).resolve().parent
DONNEES = ICI.parent
SOURCES = (
    ICI / "programme" / "carte_trace.py",
    DONNEES / "cours4_v2" / "corriges" / "4a_trace" / "b6" / "stats_trace.py",
    DONNEES / "cours3_v2" / "traces" / "trace.gpx",
    DONNEES / "cours3_v2" / "traces" / "trace_2.gpx",
)


def build() -> None:
    depart = ICI / "5a_distribution" / "depart"
    depart.mkdir(parents=True, exist_ok=True)
    travail = ICI / "5a_distribution" / "travail"
    travail.mkdir(exist_ok=True)
    (travail / ".gitkeep").touch()
    for source in SOURCES:
        cible = depart / source.name
        shutil.copyfile(source, cible)
        print(f"✓ {cible.relative_to(DONNEES.parent)}")


if __name__ == "__main__":
    if sys.argv[1:] != ["build"]:
        sys.exit(__doc__)
    build()
