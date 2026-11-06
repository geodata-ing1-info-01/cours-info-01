#!/usr/bin/env python3
"""Le programme de départ, les corrigés et le guide du TD 4a, cours 4 v2.

Le programme de départ est le corrigé du TD 3c, renommé `stats_trace.py`, avec
deux fautes pour l'étape B1. Une modification du guide est une suite de
remplacements, appliqués à la version précédente du programme : `MODIFICATIONS`
donne ces versions, dans l'ordre, et le corrigé d'une étape est sa dernière
version. Chaque version à partir de b1.2 est exécutée.

Le texte du guide s'écrit dans `gabarit_guide_4a.md`, où ces marques sont
remplacées :

    {{modif b3.1}}                      le bloc ```modif qui mène à la version b3.1
    {{sortie b3 trace.csv --distance}}  la commande et sa sortie réelle, version b3
    {{extrait b5.1 trace.csv ...}}      la même chose, sans le milieu de la sortie
    {{programme b6}}                    le programme entier, version b6
    (#@Étape B3)                        le lien vers le titre de niveau 2 qui commence ainsi

    python data/cours4_v2/generer_4a.py            # écrit depart/, corriges/ et le guide
    python data/cours4_v2/generer_4a.py --sorties  # affiche les sorties, pour les diapositives
"""

from __future__ import annotations

import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ICI = Path(__file__).resolve().parent
DEPOT = ICI.parent.parent
sys.path[:0] = [str(DEPOT / "outils"), str(DEPOT / "src")]
from _identifiants import identifiant_titre  # noqa: E402
from modifications import blocs  # noqa: E402

TD = ICI / "4a_trace"
TRACES = ICI.parent / "cours3_v2" / "3c_encodage" / "depart"
GUIDE = DEPOT / "src" / "cours4_v2" / "notebook" / "td" / "4a_trace" / "guide.md"
PROJET_WINDOWS = r"C:\Users\eleve\Desktop\info01\cours4\4a_trace\travail\stats_trace"

# Le corrigé du TD 3c : seuls changent le texte de la description et, pour
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
APPEL_PREMIER_SEGMENT = "distance_entre(liste_x[0], liste_y[0], liste_x[1], liste_y[1])"

MODIFICATIONS = {
    # B1 : les deux erreurs
    "b1.1": [("    for ligne in fichier\n", "    for ligne in fichier:\n")],
    "b1.2": [("\t\taltitudes.append", "        altitudes.append")],
    # B2 : l'option, et un message à la place du calcul
    "b2.1": [('''help="variation ignorée sous ce seuil, en mètres")\n''',
              '''help="variation ignorée sous ce seuil, en mètres")
analyseur.add_argument("--distance", action="store_true",
                       help="affiche la distance parcourue")\n''')],
    "b2.2": [(FIN_DEPART, FIN_DEPART + '''
if options.distance:
    print("distance : calcul manquant")\n''')],
    # B3 : les positions, et deux affichages provisoires
    "b3.1": [("altitudes = []\n", "altitudes = []\nliste_x = []\nliste_y = []\n")],
    "b3.2": [("        altitudes.append(float(ele))\n", """        altitudes.append(float(ele))
        liste_x.append(float(x))
        liste_y.append(float(y))
""")],
    "b3.3": [('''if options.distance:\n''', '''if options.distance:
    print(f"positions lues : {len(liste_x)}")
    print(f"position 0 : {liste_x[0]} {liste_y[0]}")\n''')],
    # B4 : la fonction, essayée sur un triangle connu, puis sur le premier segment
    "b4.1": [("import argparse\n", "import argparse\nimport math\n")],
    "b4.2": [("from pathlib import Path\n\nanalyseur", '''from pathlib import Path


def distance_entre(x1, y1, x2, y2):
    """La distance entre le point (x1, y1) et le point (x2, y2)."""
    return math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)


analyseur''')],
    "b4.3": [('''    print(f"positions lues : {len(liste_x)}")
    print(f"position 0 : {liste_x[0]} {liste_y[0]}")\n''',
              f'''    print(f"essai, 5.0 attendu : {{distance_entre(0, 0, 3, 4)}}")
    premier_segment = {APPEL_PREMIER_SEGMENT}
    print(f"premier segment : {{premier_segment:.1f}} m")\n''')],
    # B5 : la boucle, avec le cumul affiché, puis le résultat final seul
    "b5.1": [('''    return math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)\n''',
              '''    return math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)


def distance_parcourue(liste_x, liste_y):
    """La somme des longueurs des segments de la trace, en mètres."""
    total = 0
    for i in range(1, len(liste_x)):
        segment = distance_entre(liste_x[i - 1], liste_y[i - 1], liste_x[i], liste_y[i])
        total = total + segment
        print(f"position {i}, cumul : {total:.1f}")
    return total\n''')],
    "b5.2": [(f'''    print(f"essai, 5.0 attendu : {{distance_entre(0, 0, 3, 4)}}")
    premier_segment = {APPEL_PREMIER_SEGMENT}
    print(f"premier segment : {{premier_segment:.1f}} m")
    print("distance : calcul manquant")\n''',
              '''    distance = distance_parcourue(liste_x, liste_y)
    print(f"distance parcourue : {distance:.1f} m")\n''')],
    "b5.3": [('''        print(f"position {i}, cumul : {total:.1f}")\n''', "")],
    # B6 : la même progression pour la vitesse
    "b6.1": [('''help="affiche la distance parcourue")\n''',
              '''help="affiche la distance parcourue")
analyseur.add_argument("--vitesse", action="store_true",
                       help="affiche la vitesse moyenne")\n''')],
    "b6.2": [('''    print(f"distance parcourue : {distance:.1f} m")\n''',
              '''    print(f"distance parcourue : {distance:.1f} m")

if options.vitesse:
    print("vitesse : calcul manquant")\n''')],
    "b6.3": [("import math\n", "import math\nfrom datetime import datetime\n"),
             ("from pathlib import Path\n\n\ndef distance_entre", '''from pathlib import Path

FORMAT_TEMPS = "%Y/%m/%d %H:%M:%S+00"


def distance_entre''')],
    "b6.4": [("    return total\n", '''    return total


def secondes_ecoulees(debut, fin):
    """Le temps en secondes entre deux valeurs de la colonne time."""
    date_debut = datetime.strptime(debut, FORMAT_TEMPS)
    date_fin = datetime.strptime(fin, FORMAT_TEMPS)
    return (date_fin - date_debut).total_seconds()\n''')],
    "b6.5": [('''if options.vitesse:\n''', '''if options.vitesse:
    essai = secondes_ecoulees("2026/10/04 08:00:00+00", "2026/10/04 08:00:30+00")
    print(f"essai, 30.0 attendu : {essai}")\n''')],
    "b6.6": [("liste_y = []\n", "liste_y = []\ntemps = []\n")],
    "b6.7": [("        liste_y.append(float(y))\n", "        liste_y.append(float(y))\n        temps.append(time)\n")],
    "b6.8": [('''    essai = secondes_ecoulees("2026/10/04 08:00:00+00", "2026/10/04 08:00:30+00")
    print(f"essai, 30.0 attendu : {essai}")\n''', '''    temps_total = secondes_ecoulees(temps[0], temps[-1])
    print(f"temps total : {temps_total:.0f} s")\n''')],
    "b6.9": [('''    print(f"temps total : {temps_total:.0f} s")
    print("vitesse : calcul manquant")\n''',
              '''    distance = distance_parcourue(liste_x, liste_y)
    vitesse = distance / temps_total
    print(f"vitesse moyenne : {vitesse:.2f} m/s, soit {vitesse * 3.6:.1f} km/h")\n''')],
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


def bloc_texte(commande: str, sortie: str) -> str:
    return f"```text\n$ {commande}\n{sortie}\n```"


def extrait(sortie: str, debut: int = 8, fin: int = 2) -> str:
    lignes = sortie.splitlines()
    return "\n".join([*lignes[:debut], "…", *lignes[-fin:]])


def remplir(gabarit: str) -> str:
    """Remplace les marques du gabarit, puis les liens vers les titres de niveau 2."""
    def modif(trouve: re.Match) -> str:
        nom = trouve.group(1)
        return blocs(VERSIONS[ORDRE[ORDRE.index(nom) - 1]], VERSIONS[nom])

    def sortie(trouve: re.Match) -> str:
        genre, version, *arguments = trouve.group(1).split()
        texte = executer(version, *arguments)
        return bloc_texte(" ".join(["python stats_trace.py", *arguments]),
                          extrait(texte) if genre == "extrait" else texte)

    texte = re.sub(r"\{\{modif (\S+)\}\}", modif, gabarit)
    texte = re.sub(r"\{\{((?:sortie|extrait) [^}]+)\}\}", sortie, texte)
    texte = re.sub(r"\{\{programme (\S+)\}\}", lambda t: f"```python\n{VERSIONS[t.group(1)].rstrip()}\n```", texte)
    for ligne in texte.splitlines():
        if ligne.startswith("## "):
            titre = ligne[3:]
            cle = titre.split(" ·")[0].split(" (")[0]
            texte = texte.replace(f"(#@{cle})", "(#" + identifiant_titre(titre.replace("`", "")) + ")")
    reste = re.findall(r"\(#@[^)]*\)|\{\{[^}]*\}\}", texte)
    if reste:
        raise ValueError(f"marques non remplacées : {reste}")
    return texte


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
    gabarit = ICI / "gabarit_guide_4a.md"
    if gabarit.exists():
        GUIDE.parent.mkdir(parents=True, exist_ok=True)
        GUIDE.write_text(remplir(gabarit.read_text(encoding="utf-8")), encoding="utf-8", newline="\n")


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
    ]
    for version, *arguments in essais:
        print(f"--- {version} : python stats_trace.py {' '.join(arguments)}")
        sortie = executer(version, *arguments)
        print(extrait(sortie, 10, 3) if version == "b5.2" else sortie)


if __name__ == "__main__":
    verifier()
    if "--sorties" in sys.argv:
        afficher_sorties()
    else:
        ecrire()
        print("depart/, corriges/ et guide écrits")
