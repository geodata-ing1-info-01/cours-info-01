#!/usr/bin/env python3
"""Données des TD du cours 3, version 2 (proposition 2027-2028).

TD 3a. Copie `trace.csv` de `traces/` dans `3a_denivele/depart/`. La trace vient d'un
chemin et d'altitudes réels, et simule une marche (`traces/fabriquer_traces.py`). Ses
colonnes sont celles qu'écrit `ogr2ogr` : `X`, `Y` (Lambert-93, en mètres), `ele`
(altitude, en mètres) et `time` (heure UTC). `altitudes.txt` et les listes des cours 1 et
2 sont une altitude sur 12 de `trace.csv`, soit une toutes les 6 minutes. Le programme de
départ du TD 3a est une copie du corrigé du TD 2c.

TD 3b. Fabrique dans `3b_portabilite/produit/travail/` le dépôt git que l'élève reçoit :
sur `master`, le corrigé du TD 2c, puis celui du TD 3a ; sur la branche `seuil`, partie
du second commit, le programme d'Alice (`corriges/3b_portabilite/seuil/altitudes.py`),
avec son chemin absolu dans `open` et un seuil écrit en dur. Les auteurs et les dates
sont fixes : les identifiants des trois commits ne changent pas d'une fabrication à
l'autre. `trace.csv`, `trace_2.csv` et `parcours.txt` sont à côté, non suivis. Le script
rejoue ensuite les étapes du TD dans un dossier temporaire : la fusion doit s'arrêter sur
un seul conflit, la ligne de `open`, et le programme final être le corrigé.

Le script signale par une ligne `! …` un écart à l'une de ces règles, et
`outils/livrer_tds.py` s'arrête.

    python data/cours3_v2/make_data.py build
"""

from __future__ import annotations

import csv
import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ICI = Path(__file__).resolve().parent
TRACES = ICI / "traces"
CORRIGES = ICI / "corriges"
DEPARTS = {
    "3a_denivele": ("trace.csv",),
}
DEPOT_3B = ICI / "3b_portabilite" / "produit" / "travail"

# Les trois commits fournis : (auteur, adresse, date, message, programme).
COMMITS = (
    ("Équipe info01", "info01@exemple.fr", "2027-10-01T10:00:00+02:00",
     "Calcule les altitudes extrêmes et le dénivelé cumulé",
     ICI / "3a_denivele" / "depart" / "altitudes.py"),
    ("Équipe info01", "info01@exemple.fr", "2027-10-08T10:00:00+02:00",
     "Lit les altitudes dans trace.csv",
     CORRIGES / "3a_denivele" / "altitudes.py"),
)
COMMIT_ALICE = (
    "Alice", "alice@exemple.fr", "2027-10-09T10:00:00+02:00",
    "Ajoute un seuil au dénivelé cumulé",
    CORRIGES / "3b_portabilite" / "seuil" / "altitudes.py",
)

# Les modifications des étapes du TD 3b, telles que les diapositives les donnent :
# (ancien texte, nouveau texte), appliquées à `altitudes.py`.
ETAPE_PATHLIB = (
    '"""\n\naltitudes = []\nwith open("trace.csv",',
    '"""\n\nfrom pathlib import Path\n\nFICHIER = Path(__file__).parent / "trace.csv"\n\n'
    'altitudes = []\nwith open(FICHIER,',
)
ETAPE_FICHIER = (
    'from pathlib import Path\n\nFICHIER = Path(__file__).parent / "trace.csv"\n',
    'import argparse\nfrom pathlib import Path\n\n'
    'analyseur = argparse.ArgumentParser(description="Altitudes et cumul d\'une trace GPS.")\n'
    'analyseur.add_argument("fichier", help="le fichier CSV de la trace")\n'
    'options = analyseur.parse_args()\n\n'
    'FICHIER = Path(options.fichier)\n',
)
CONFLIT = (
    '<<<<<<< HEAD\n'
    'with open(FICHIER, encoding="utf-8") as fichier:\n'
    '=======\n'
    'with open("C:/Users/alice/cours3/trace.csv", encoding="utf-8") as fichier:\n'
    '>>>>>>> seuil\n'
)
RESOLUTION = 'with open(FICHIER, encoding="utf-8") as fichier:\n'
ETAPES_SEUIL = (
    ('analyseur.add_argument("fichier", help="le fichier CSV de la trace")\n',
     'analyseur.add_argument("fichier", help="le fichier CSV de la trace")\n'
     'analyseur.add_argument("-s", "--seuil", type=float, default=0,\n'
     '                       help="variation ignorée sous ce seuil, en mètres")\n'),
    ('FICHIER = Path(options.fichier)\n', 'FICHIER = Path(options.fichier)\nSEUIL = options.seuil\n'),
    ('SEUIL = 2.0\n', ''),
)
ETAPE_RESUME = (
    '\nwith open("resume.txt", "a", encoding="utf-8") as sortie:\n'
    '    sortie.write(f"{FICHIER.name} : seuil {SEUIL}, hausse {hausse:.1f} m, '
    'baisse {baisse:.1f} m\\n")\n'
)


def verifier_listes() -> None:
    """`altitudes.txt` et le corrigé du TD 2c contiennent une altitude sur 12 de `trace.csv`."""
    with open(TRACES / "trace.csv", encoding="utf-8") as fichier:
        altitudes = [ligne["ele"] for ligne in csv.DictReader(fichier)]
    attendues = altitudes[::12][:5]
    texte = ICI / "3a_denivele" / "depart" / "altitudes.txt"
    if texte.read_text(encoding="utf-8").split() != attendues:
        print(f"! {texte.relative_to(ICI.parent.parent)} diffère de {attendues}")
    corrige = ICI.parent / "cours2_v2" / "corriges" / "2c_depot_altitudes" / "altitudes.py"
    liste = f"altitudes = [{', '.join(attendues)}]"
    if liste not in corrige.read_text(encoding="utf-8"):
        print(f"! {corrige.relative_to(ICI.parent.parent)} ne contient pas {liste}")


def git(dossier: Path, *arguments: str, auteur: tuple[str, str, str] | None = None,
        verifier: bool = True) -> subprocess.CompletedProcess:
    """Une commande git, hors de la configuration du poste qui fabrique les données."""
    env = dict(os.environ, GIT_CONFIG_GLOBAL=os.devnull, GIT_CONFIG_NOSYSTEM="1", LC_ALL="C")
    if auteur:
        nom, adresse, date = auteur
        env.update(GIT_AUTHOR_NAME=nom, GIT_AUTHOR_EMAIL=adresse, GIT_AUTHOR_DATE=date,
                   GIT_COMMITTER_NAME=nom, GIT_COMMITTER_EMAIL=adresse, GIT_COMMITTER_DATE=date)
    return subprocess.run(["git", *arguments], cwd=dossier, env=env, check=verifier,
                          capture_output=True, text=True)


def committer(dossier: Path, commit: tuple) -> None:
    nom, adresse, date, message, programme = commit
    shutil.copyfile(programme, dossier / "altitudes.py")
    git(dossier, "add", "altitudes.py")
    git(dossier, "commit", "-q", "-m", message, auteur=(nom, adresse, date))


def fabriquer_depot() -> None:
    """Le dépôt du TD 3b : deux commits sur `master`, un sur `seuil`, puis `master`."""
    shutil.rmtree(DEPOT_3B.parent, ignore_errors=True)
    DEPOT_3B.mkdir(parents=True)
    git(DEPOT_3B, "init", "-q", "-b", "master")
    for commit in COMMITS:
        committer(DEPOT_3B, commit)
    git(DEPOT_3B, "checkout", "-q", "-b", "seuil")
    committer(DEPOT_3B, COMMIT_ALICE)
    git(DEPOT_3B, "checkout", "-q", "master")
    for nom in ("trace.csv", "trace_2.csv", "parcours.txt"):
        shutil.copyfile(TRACES / nom, DEPOT_3B / nom)
    print(f"✓ {DEPOT_3B.relative_to(ICI.parent.parent)} : dépôt git, branches master et seuil")


def remplacer(fichier: Path, ancien: str, nouveau: str) -> bool:
    texte = fichier.read_text(encoding="utf-8")
    if texte.count(ancien) != 1:
        print(f"! TD 3b rejoué : texte introuvable dans altitudes.py : {ancien[:40]!r}")
        return False
    fichier.write_text(texte.replace(ancien, nouveau), encoding="utf-8")
    return True


def rejouer_td_3b() -> None:
    """Les étapes du TD 3b, sur une copie du dépôt : conflit attendu, puis le corrigé."""
    eleve = ("Élève", "eleve@exemple.fr", "2027-10-15T10:00:00+02:00")
    with tempfile.TemporaryDirectory() as temporaire:
        depot = Path(temporaire) / "travail"
        shutil.copytree(DEPOT_3B, depot)
        programme = depot / "altitudes.py"
        (depot / ".gitignore").write_text("*.csv\n*.txt\n", encoding="utf-8")
        git(depot, "add", ".gitignore")
        git(depot, "commit", "-q", "-m", "Ignore les données et les résultats", auteur=eleve)
        if git(depot, "status", "--porcelain").stdout:
            print("! TD 3b rejoué : `git status` n'est pas vide après `.gitignore`")
        for ancien, nouveau in (ETAPE_PATHLIB, ETAPE_FICHIER):
            if not remplacer(programme, ancien, nouveau):
                return
            git(depot, "commit", "-q", "-am", "étape", auteur=eleve)
        fusion = git(depot, "merge", "seuil", "-m", "Fusionne le seuil d'Alice",
                     auteur=eleve, verifier=False)
        if fusion.returncode == 0 or programme.read_text(encoding="utf-8").count("<<<<<<<") != 1:
            print("! TD 3b rejoué : la fusion devait s'arrêter sur un seul conflit")
            return
        if not remplacer(programme, CONFLIT, RESOLUTION):
            return
        git(depot, "add", "altitudes.py")
        git(depot, "commit", "-q", "--no-edit", auteur=eleve)
        for ancien, nouveau in ETAPES_SEUIL:
            if not remplacer(programme, ancien, nouveau):
                return
        with open(programme, "a", encoding="utf-8") as fichier:
            fichier.write(ETAPE_RESUME)
        corrige = CORRIGES / "3b_portabilite" / "altitudes.py"
        if programme.read_text(encoding="utf-8") != corrige.read_text(encoding="utf-8"):
            print(f"! TD 3b rejoué : le programme final diffère de {corrige.relative_to(ICI.parent.parent)}")
        else:
            print("✓ TD 3b rejoué : un conflit sur open, puis le corrigé")


def build() -> None:
    for td, noms in DEPARTS.items():
        for nom in noms:
            cible = ICI / td / "depart" / nom
            shutil.copyfile(TRACES / nom, cible)
            print(f"✓ {cible.relative_to(ICI.parent.parent)}")
    verifier_listes()
    depart = ICI / "3a_denivele" / "depart" / "altitudes.py"
    corrige = ICI.parent / "cours2_v2" / "corriges" / "2c_depot_altitudes" / "altitudes.py"
    if depart.read_text(encoding="utf-8") != corrige.read_text(encoding="utf-8"):
        print(f"! {depart.relative_to(ICI.parent.parent)} diffère de {corrige.relative_to(ICI.parent.parent)}")
    fabriquer_depot()
    rejouer_td_3b()


if __name__ == "__main__":
    if sys.argv[1:] != ["build"]:
        sys.exit(__doc__)
    build()
