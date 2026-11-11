#!/usr/bin/env python3
"""Le programme de départ et les corrigés du TD 4a, cours 4 v2, et les blocs de son guide.

Le programme de départ est le corrigé du TD 3b, renommé `stats_trace.py`, avec
deux fautes pour l'étape B1. Une modification du guide est une suite de
remplacements, appliqués à la version précédente du programme : `MODIFICATIONS`
donne ces versions, dans l'ordre, et le corrigé d'une étape est sa dernière
version. Chaque version à partir de b1.2 est exécutée.

Le guide, `src/cours4_v2/notebook/td/4a_trace/guide.md`, s'écrit à la main. Ses blocs
de code et ses sorties y sont écrits par Cog (`outils/guides_cog.py`), à partir de ce
module : `versions()`, `ORDRE`, `executer()` et `PROGRAMME`. Dans le guide :

    td.modif("b3.1")                               le bloc ```modif qui mène à la version b3.1
    td.sortie("b3", "trace.csv", "--distance")     la commande et sa sortie réelle, version b3
    td.sortie("b5.1", "trace.csv", debut=8, fin=2) la même chose, sans le milieu de la sortie
    td.programme("b6")                             le programme entier, version b6

Jusqu'au 11/11/2026, le texte du guide était dans un gabarit, `gabarit_guide_4a.md`, que ce
script remplissait.

    python data/cours4_v2/make_data.py build      # vérifie les versions, écrit depart/ et corriges/
    python data/cours4_v2/make_data.py sorties    # affiche les sorties, pour les diapositives
"""

from __future__ import annotations

import argparse
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ICI = Path(__file__).resolve().parent
DEPOT = ICI.parent.parent
sys.path[:0] = [str(DEPOT / "outils"), str(DEPOT / "src")]

TD = ICI / "4a_trace"
TRACES = ICI.parent / "cours3_v2" / "traces"
PROGRAMME = "stats_trace.py"
PROJET_WINDOWS = r"C:\Users\eleve\Desktop\info01\cours4\4a_trace\travail\stats_trace"

# Le corrigé du TD 3b : seuls changent le texte de la description et, pour
# l'étape B1, le deux-points du `for` et l'indentation de la ligne qui suit.
DEPART = '''"""Statistiques d'une trace GPS."""

import argparse
from pathlib import Path

analyseur = argparse.ArgumentParser(description="Statistiques d'une trace GPS.")
analyseur.add_argument("fichier", help="le fichier CSV de la trace")
analyseur.add_argument("-s", "--seuil", type=float, default=0,
                       help="variation ignorée sous ce seuil, en mètres")
options = analyseur.parse_args()

FICHIER = Path(options.fichier)
SEUIL = options.seuil

altitudes = []
with open(FICHIER, encoding="utf-8") as fichier:
    fichier.readline()
    for ligne in fichier
        x, y, ele, time = ligne.strip().split(",")
\t\taltitudes.append(float(ele))

print(f"altitude minimale : {min(altitudes):.1f} m")
print(f"altitude maximale : {max(altitudes):.1f} m")
print(f"max - min : {max(altitudes) - min(altitudes):.1f} m")

hausse = 0
baisse = 0
reference = altitudes[0]
for altitude in altitudes[1:]:
    ecart = altitude - reference
    if abs(ecart) >= SEUIL:
        if ecart > 0:
            hausse = hausse + ecart
        else:
            baisse = baisse - ecart
        reference = altitude

print(f"cumul en hausse : {hausse:.1f} m")
print(f"cumul en baisse : {baisse:.1f} m")

with open("resume.txt", "a", encoding="utf-8") as sortie:
    sortie.write(f"{FICHIER.name} : seuil {SEUIL}, hausse {hausse:.1f} m, baisse {baisse:.1f} m\\n")
'''

FIN_DEPART = 'baisse {baisse:.1f} m\\n")\n'
APPEL_PREMIER_SEGMENT = "distance_entre(points[0], points[1])"
APPEL_ESSAI = "distance_entre((0, 0, 0), (3, 4, 0))"

# Une position est un tuple (x, y, altitude), gardé seulement quand une option le demande
# (10/11/2026, à la place des deux listes `liste_x` et `liste_y`). Les deux listes reviennent
# à l'étape facultative B8, pour le calcul de numpy, qui travaille sur une colonne entière.
MODIFICATIONS = {
    # B1 : les deux erreurs
    "b1.1": [("    for ligne in fichier\n", "    for ligne in fichier:\n")],
    "b1.2": [("\t\taltitudes.append", "        altitudes.append")],
    # B2 : l'option, et un message à la place du calcul
    "b2.1": [('help="variation ignorée sous ce seuil, en mètres")\n',
              'help="variation ignorée sous ce seuil, en mètres")\n'
              'analyseur.add_argument("--distance", action="store_true",\n'
              '                       help="affiche la distance parcourue")\n')],
    "b2.2": [(FIN_DEPART, FIN_DEPART + '\n'
              'if options.distance:\n'
              '    print("distance : calcul manquant")\n')],
    # B3 : les positions, en tuples, avec l'option ; puis deux affichages provisoires
    "b3.1": [("altitudes = []\n", "altitudes = []\npoints = []\n")],
    "b3.2": [("        altitudes.append(float(ele))\n",
              "        altitudes.append(float(ele))\n"
              "        if options.distance:\n"
              "            points.append((float(x), float(y), float(ele)))\n")],
    "b3.3": [("\nif options.distance:\n",
              "\nif options.distance:\n"
              '    print(f"positions lues : {len(points)}")\n'
              '    print(f"position 0 : {points[0]}")\n')],
    # B4 : la fonction, essayée sur un triangle connu, puis sur le premier segment
    "b4.1": [("import argparse\n", "import argparse\nimport math\n")],
    "b4.2": [("from pathlib import Path\n\nanalyseur",
              "from pathlib import Path\n"
              "\n"
              "\n"
              "def distance_entre(point1, point2):\n"
              '    """La distance horizontale entre deux points (x, y, altitude), en mètres."""\n'
              "    x1, y1, altitude1 = point1\n"
              "    x2, y2, altitude2 = point2\n"
              "    return math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)\n"
              "\n"
              "\n"
              "analyseur")],
    "b4.3": [('    print(f"positions lues : {len(points)}")\n'
              '    print(f"position 0 : {points[0]}")\n',
              '    print(f"essai, 5.0 attendu : {' + APPEL_ESSAI + '}")\n'
              "    premier_segment = " + APPEL_PREMIER_SEGMENT + "\n"
              '    print(f"premier segment : {premier_segment:.1f} m")\n')],
    # B5 : la boucle, avec le cumul affiché, puis le résultat final seul
    "b5.1": [("    return math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)\n",
              "    return math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)\n"
              "\n"
              "\n"
              "def distance_parcourue(points):\n"
              '    """La somme des longueurs des segments de la trace, en mètres."""\n'
              "    total = 0\n"
              "    for i in range(1, len(points)):\n"
              "        segment = distance_entre(points[i - 1], points[i])\n"
              "        total = total + segment\n"
              '        print(f"position {i}, cumul : {total:.1f}")\n'
              "    return total\n")],
    "b5.2": [('    print(f"essai, 5.0 attendu : {' + APPEL_ESSAI + '}")\n'
              "    premier_segment = " + APPEL_PREMIER_SEGMENT + "\n"
              '    print(f"premier segment : {premier_segment:.1f} m")\n'
              '    print("distance : calcul manquant")\n',
              "    distance = distance_parcourue(points)\n"
              '    print(f"distance parcourue : {distance:.1f} m")\n')],
    "b5.3": [('        print(f"position {i}, cumul : {total:.1f}")\n', "")],
    # B6 : la même progression pour la vitesse
    "b6.1": [('help="affiche la distance parcourue")\n',
              'help="affiche la distance parcourue")\n'
              'analyseur.add_argument("--vitesse", action="store_true",\n'
              '                       help="affiche la vitesse moyenne")\n')],
    "b6.2": [('    print(f"distance parcourue : {distance:.1f} m")\n',
              '    print(f"distance parcourue : {distance:.1f} m")\n'
              "\n"
              "if options.vitesse:\n"
              '    print("vitesse : calcul manquant")\n')],
    "b6.3": [("import math\n", "import math\nfrom datetime import datetime\n"),
             ("from pathlib import Path\n\n\ndef distance_entre",
              "from pathlib import Path\n"
              "\n"
              'FORMAT_TEMPS = "%Y/%m/%d %H:%M:%S+00"\n'
              "\n"
              "\n"
              "def distance_entre")],
    "b6.4": [("    return total\n",
              "    return total\n"
              "\n"
              "\n"
              "def secondes_ecoulees(debut, fin):\n"
              '    """Le temps en secondes entre deux valeurs de la colonne time."""\n'
              "    date_debut = datetime.strptime(debut, FORMAT_TEMPS)\n"
              "    date_fin = datetime.strptime(fin, FORMAT_TEMPS)\n"
              "    return (date_fin - date_debut).total_seconds()\n")],
    "b6.5": [("if options.vitesse:\n",
              "if options.vitesse:\n"
              '    essai = secondes_ecoulees("2026/10/04 08:00:00+00", "2026/10/04 08:00:30+00")\n'
              '    print(f"essai, 30.0 attendu : {essai}")\n')],
    "b6.6": [("points = []\n", "points = []\ntemps = []\n")],
    "b6.7": [("        if options.distance:\n"
              "            points.append((float(x), float(y), float(ele)))\n",
              "        if options.distance or options.vitesse:\n"
              "            points.append((float(x), float(y), float(ele)))\n"
              "            temps.append(time)\n")],
    "b6.8": [('    essai = secondes_ecoulees("2026/10/04 08:00:00+00", "2026/10/04 08:00:30+00")\n'
              '    print(f"essai, 30.0 attendu : {essai}")\n',
              "    temps_total = secondes_ecoulees(temps[0], temps[-1])\n"
              '    print(f"temps total : {temps_total:.0f} s")\n')],
    "b6.9": [('    print(f"temps total : {temps_total:.0f} s")\n'
              '    print("vitesse : calcul manquant")\n',
              "    distance = distance_parcourue(points)\n"
              "    vitesse = distance / temps_total\n"
              '    print(f"vitesse moyenne : {vitesse:.2f} m/s, soit {vitesse * 3.6:.1f} km/h")\n')],
    # B8 (facultative) : la même distance, calculée par numpy sur deux listes, une par colonne
    "b8.1": [("from pathlib import Path\n\nFORMAT_TEMPS",
              "from pathlib import Path\n\nimport numpy as np\n\nFORMAT_TEMPS")],
    "b8.2": [("temps = []\n", "temps = []\nliste_x = []\nliste_y = []\n")],
    "b8.3": [("            temps.append(time)\n",
              "            temps.append(time)\n"
              "            liste_x.append(float(x))\n"
              "            liste_y.append(float(y))\n")],
    "b8.4": [("    return total\n",
              "    return total\n"
              "\n"
              "\n"
              "def distance_parcourue_numpy(liste_x, liste_y):\n"
              '    """La même somme, calculée par numpy sur les colonnes x et y."""\n'
              "    x = np.array(liste_x)\n"
              "    y = np.array(liste_y)\n"
              "    return np.sum(np.sqrt(np.diff(x) ** 2 + np.diff(y) ** 2))\n")],
    "b8.5": [('    print(f"distance parcourue : {distance:.1f} m")\n',
              '    print(f"distance parcourue : {distance:.1f} m")\n'
              "    distance_numpy = distance_parcourue_numpy(liste_x, liste_y)\n"
              '    print(f"distance parcourue, numpy : {distance_numpy:.1f} m")\n')],
}


def versions() -> dict[str, str]:
    """Le texte du programme à chaque version ; `b3` désigne la dernière version de l'étape 3."""
    resultat = {"depart": DEPART}
    texte = DEPART
    for nom, remplacements in MODIFICATIONS.items():
        for ancien, nouveau in remplacements:
            if texte.count(ancien) != 1:
                raise ValueError(f"{nom} : {ancien!r} trouvé {texte.count(ancien)} fois")
            texte = texte.replace(ancien, nouveau)
        resultat[nom] = texte
        resultat[nom.split(".")[0]] = texte
    return resultat


VERSIONS = versions()
ORDRE = ["depart", *MODIFICATIONS]


def executer(version: str, *arguments: str) -> str:
    """La sortie réelle de `python stats_trace.py *arguments`, erreurs comprises, avec le chemin d'un poste de la salle."""
    with tempfile.TemporaryDirectory() as temporaire:
        projet = Path(temporaire).resolve()
        (projet / "stats_trace.py").write_text(VERSIONS[version], encoding="utf-8", newline="\n")
        for trace in TRACES.glob("*.csv"):
            shutil.copy(trace, projet)
        resultat = subprocess.run([sys.executable, "stats_trace.py", *arguments], cwd=projet,
                                  capture_output=True, text=True, encoding="utf-8")
        texte = resultat.stdout + resultat.stderr
    return texte.replace(str(projet) + "/stats_trace.py", PROJET_WINDOWS + r"\stats_trace.py").rstrip("\n")


def extrait(sortie: str, debut: int = 8, fin: int = 2) -> str:
    lignes = sortie.splitlines()
    return "\n".join([*lignes[:debut], "…", *lignes[-fin:]])


def verifier() -> None:
    """Chaque version à partir de b1.2 s'exécute sans erreur."""
    for nom in ORDRE[ORDRE.index("b1.2"):]:
        arguments = ["trace.csv"]
        if ORDRE.index(nom) >= ORDRE.index("b2.1"):
            arguments.append("--distance")
        if ORDRE.index(nom) >= ORDRE.index("b6.1"):  # l'option existe dès b6.1
            arguments.append("--vitesse")
        sortie = executer(nom, *arguments)
        if "Traceback" in sortie or "Error" in sortie or "error:" in sortie:
            raise RuntimeError(f"{nom} : {sortie}")


def ecrire() -> None:
    depart = TD / "depart"
    depart.mkdir(parents=True, exist_ok=True)
    (TD / "travail").mkdir(exist_ok=True)
    (TD / "travail" / ".gitkeep").touch()
    (depart / "stats_trace.py").write_text(DEPART, encoding="utf-8", newline="\n")
    for trace in TRACES.glob("*.csv"):
        shutil.copy(trace, depart)
    for etape in sorted({nom.split(".")[0] for nom in MODIFICATIONS}):
        corrige = ICI / "corriges" / "4a_trace" / etape / "stats_trace.py"
        corrige.parent.mkdir(parents=True, exist_ok=True)
        corrige.write_text(VERSIONS[etape], encoding="utf-8", newline="\n")


def afficher_sorties() -> None:
    essais = [
        ("depart", "trace.csv"), ("b1.1", "trace.csv"), ("b1", "trace.csv"),
        ("b2", "trace.csv", "--distance"), ("b2", "--help"),
        ("b3", "trace.csv", "--distance"), ("b3", "trace_2.csv", "--distance"),
        ("b4", "trace.csv", "--distance"), ("b5.2", "trace.csv", "--distance"),
        ("b5", "trace.csv", "--distance"), ("b5", "trace_2.csv", "--distance"),
        ("b6.2", "trace.csv", "--vitesse"), ("b6.5", "trace.csv", "--vitesse"),
        ("b6", "trace.csv", "--distance", "--vitesse"), ("b6", "trace_2.csv", "--vitesse"),
        ("b6", "trace.csv", "-s", "2", "--distance", "--vitesse"),
        ("b8", "trace.csv", "--distance"), ("b8", "trace_2.csv", "--distance"),
    ]
    for version, *arguments in essais:
        print(f"--- {version} : python stats_trace.py {' '.join(arguments)}")
        sortie = executer(version, *arguments)
        print(extrait(sortie, 10, 3) if version == "b5.2" else sortie)


if __name__ == "__main__":
    analyseur = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    analyseur.add_argument("commande", choices=("build", "sorties"))
    commande = analyseur.parse_args().commande
    verifier()
    if commande == "sorties":
        afficher_sorties()
    else:
        ecrire()
        print("✓ data/cours4_v2 : depart/ et corriges/ écrits")
