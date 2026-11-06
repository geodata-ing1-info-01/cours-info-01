#!/usr/bin/env python3
"""Données des TD du cours 5, version 2 (proposition 2027-2028).

Les TD 5a, 5b et 5c reçoivent le programme de la séance, `programme/carte_trace.py`, le
programme de la fin du TD 4a, `stats_trace.py`, et les traces GPX du cours 3
(`data/cours3_v2/traces/`). Le TD 5d reçoit un notebook d'une cellule. Ces copies sont
versionnées, et le script les refait. Les solutions du TD 5c sont dans `corriges/`.

    python data/cours5_v2/make_data.py build
"""

from __future__ import annotations

import json
import shutil
import sys
from pathlib import Path

ICI = Path(__file__).resolve().parent
DONNEES = ICI.parent
PROGRAMME = ICI / "programme" / "carte_trace.py"
STATS = DONNEES / "cours4_v2" / "corriges" / "4a_trace" / "b6" / "stats_trace.py"
TRACE = DONNEES / "cours3_v2" / "traces" / "trace.gpx"
TRACE_2 = DONNEES / "cours3_v2" / "traces" / "trace_2.gpx"
SOURCES = {
    "5a_distribution": (PROGRAMME, STATS, TRACE, TRACE_2),
    "5b_environnement": (PROGRAMME, STATS, TRACE_2),
    "5c_description": (PROGRAMME, STATS, TRACE_2),
}

CELLULE_5D = """import shutil
import sys
print(sys.executable)
print(shutil.which("ogr2ogr"))
import folium
print("folium", folium.__version__)
"""


def preparer(td: str) -> Path:
    """Crée `depart/` et `travail/` dans le dossier d'un TD, et renvoie `depart/`."""
    depart = ICI / td / "depart"
    depart.mkdir(parents=True, exist_ok=True)
    travail = ICI / td / "travail"
    travail.mkdir(exist_ok=True)
    (travail / ".gitkeep").touch()
    return depart


def ecrire_notebook(cible: Path) -> None:
    notebook = {
        "cells": [{
            "cell_type": "code",
            "execution_count": None,
            "id": "carte",
            "metadata": {},
            "outputs": [],
            "source": CELLULE_5D.splitlines(keepends=True),
        }],
        "metadata": {
            "kernelspec": {"display_name": "Python 3 (ipykernel)", "language": "python", "name": "python3"},
            "language_info": {"name": "python"},
        },
        "nbformat": 4,
        "nbformat_minor": 5,
    }
    cible.write_text(json.dumps(notebook, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")


def build() -> None:
    for td, sources in SOURCES.items():
        depart = preparer(td)
        for source in sources:
            cible = depart / source.name
            shutil.copyfile(source, cible)
            print(f"✓ {cible.relative_to(DONNEES.parent)}")
    cible = preparer("5d_noyau") / "carte.ipynb"
    ecrire_notebook(cible)
    print(f"✓ {cible.relative_to(DONNEES.parent)}")


if __name__ == "__main__":
    if sys.argv[1:] != ["build"]:
        sys.exit(__doc__)
    build()
