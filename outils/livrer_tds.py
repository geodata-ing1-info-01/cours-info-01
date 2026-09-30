#!/usr/bin/env python3
"""Assemble l'archive d'une séance telle que les étudiants la reçoivent.

    python outils/livrer_tds.py                # cours 1 → livraison/cours1/ et livraison/info01-cours1.zip
    python outils/livrer_tds.py --cours 3      # une autre séance
    python outils/livrer_tds.py --lister       # ce qui serait copié, sans rien écrire
    python outils/livrer_tds.py --sans-fabriquer   # sans refaire feuilles de TD ni notebooks

Le dépôt et l'archive n'ont pas la même arborescence, et c'est voulu. Le dépôt
range ce qu'il ne versionne pas dans deux dossiers réservés, `produit/` (ce
qu'une commande refabrique) et `fourni/` (ce qui vient d'ailleurs) : une
distinction qui compte pour qui entretient le cours, et qui n'est rien pour qui
le suit. L'archive ne la montre donc pas. Pour chaque TD, `cours<n>/<td>/`
reçoit :

    - les fichiers versionnés du dossier, tels quels ;
    - le contenu de `produit/`, mis à plat dans le dossier, sans `_corrige/`,
      dossiers vides compris (le `travail/` du TD 1a attend les copies de
      l'étudiant) ;
    - la feuille de TD, `td_<td>.pdf`, compilée par `outils/compiler_tds.py`
      depuis `src/cours<n>/diapo/tds/<td>.typ`, quand elle existe ;
    - le guide détaillé, `guide_<td>.pdf`, `.html` et `guide.ipynb`, tiré de
      `src/cours<n>/notebook/td/<td>/guide.md`, quand il existe (il passe par
      `produit/`, comme les notebooks).

Un TD a l'une ou l'autre de ces deux feuilles, ou les deux : la feuille typst
donne les étapes en résumé, le guide les détaille.

Avant d'assembler, le script refait ce qui se dérive des sources : les données
(`data/cours<n>/make_data.py build`, qui repart d'un `produit/` vide), les
feuilles de TD (`outils/compiler_tds.py`) et les notebooks
(`outils/construire_notebooks.py`), et les guides détaillés
(`outils/compiler_guides.py`). L'archive ne part donc ni avec une version
en retard sur le dépôt, ni avec ce qu'un essai — un TD joué depuis `data/`, la
construction du book — a laissé dans `produit/`. Si `make_data.py` signale
une source absente (une ligne `! …`, le plus souvent un `fourni/` pas encore
téléchargé), le script s'arrête sans assembler : l'archive partirait sans le
fichier.

`fourni/` reste au dépôt : c'est la matière première de `make_data.py`, les
étudiants n'en ont pas besoin. Les diapositives nomment les chemins tels que
l'archive les montre, `cours1/1a_formats/raven.odt` ; c'est donc depuis
`livraison/cours1/` qu'on rejoue un TD, jamais depuis `data/`.

Un TD qui se fait à la racine de l'archive (`dossier: "cours3/"`, la
préparation du poste) n'a pas de dossier : sa feuille, `td_<fichier du TD>.pdf`,
est déposée par `compiler_tds.py` dans `data/cours<n>/` et livrée à la racine
de l'archive, et le README le liste avec les autres.

Un dossier de TD est un sous-dossier de `data/cours<n>/` dont le nom commence
par son numéro, `1a_`, `2b_`, `4_` : ce qui n'en porte pas (`make_data.py`, le
README de la séance) est l'affaire du dépôt et n'est pas livré. L'archive porte
son propre README, qui liste les TD à partir de leurs descriptions.

« Versionné » se lit par `git ls-files` : un fichier nouveau part dans
l'archive dès qu'il est ajouté à l'index (`git add`), pas avant. C'est ce qui
garantit qu'un artefact laissé là par un essai (un exécutable, une page HTML)
ne part pas avec.
"""

from __future__ import annotations

import argparse
import re
import shutil
import subprocess
import sys
import zipfile
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
LIVRAISON = RACINE / "livraison"
MOTIF_TD = re.compile(r"^\d+[a-z]?_")


def dossiers_td(cours: str) -> list[Path]:
    donnees = RACINE / "data" / f"cours{cours}"
    return sorted(d for d in donnees.iterdir() if d.is_dir() and MOTIF_TD.match(d.name))


def feuilles_racine(cours: str) -> list[tuple[str, Path]]:
    """Les TD faits à la racine de l'archive : (nom du fichier du TD, sa feuille dans `data/`)."""
    tds = RACINE / f"src/cours{cours}/diapo/tds"
    racine = []
    for source in sorted(tds.glob("*.typ")) if tds.is_dir() else []:
        dossier = re.search(r'dossier:\s*"([^"]+)"', source.read_text(encoding="utf-8"))
        if dossier and len(Path(dossier.group(1)).parts) == 1:
            racine.append((source.stem, RACINE / "data" / f"cours{cours}" / f"td_{source.stem}.pdf"))
    return racine


def suivis_par_git(dossier: Path) -> list[Path]:
    """Les fichiers versionnés du dossier, `.gitkeep` exclus."""
    sortie = subprocess.run(
        ["git", "ls-files", "-z", "--", str(dossier.relative_to(RACINE))],
        capture_output=True, text=True, cwd=RACINE, check=True,
    ).stdout
    return [RACINE / f for f in sortie.split("\0") if f and not f.endswith(".gitkeep")]


def dossiers_vides(td: Path) -> list[Path]:
    """Les dossiers à recréer vides dans le dossier livré.

    Deux cas, et le même effet attendu, un `travail/` qui attend les copies de
    l'étudiant : les dossiers que `make_data.py` laisse vides dans `produit/`,
    et ceux que le dépôt marque d'un `.gitkeep`, git ne sachant pas versionner
    un dossier vide.
    """
    vides = set()
    produit = td / "produit"
    if produit.is_dir():
        for d in produit.rglob("*"):
            if d.is_dir() and d.name != "_corrige" and not any(d.iterdir()):
                vides.add(d.relative_to(produit))
    for marque in td.rglob(".gitkeep"):
        relatif = marque.parent.relative_to(td)
        if relatif.parts and relatif.parts[0] not in ("produit", "fourni"):
            vides.add(relatif)
    return sorted(vides)


def a_livrer(td: Path) -> list[tuple[Path, Path]]:
    """Les couples (source, chemin relatif dans le dossier livré) d'un TD."""
    couples = []
    for f in suivis_par_git(td):
        relatif = f.relative_to(td)
        if relatif.parts[0] in ("produit", "fourni"):
            continue
        couples.append((f, relatif))
    produit = td / "produit"
    if produit.is_dir():
        for f in sorted(produit.rglob("*")):
            if not f.is_file() or f.name == ".gitkeep":
                continue
            relatif = f.relative_to(produit)
            if relatif.parts[0] == "_corrige":
                continue
            couples.append((f, relatif))
    feuille = td / f"td_{td.name}.pdf"
    if feuille.exists():
        couples.append((feuille, Path(feuille.name)))
    return couples


def description(cours: str, td: Path | str) -> dict[str, str]:
    """Le dictionnaire `td` du fichier typst de même nom, lu à la regex.

    Sans fichier typst, le titre vient de l'en-tête du guide, s'il existe.
    """
    td = Path(td)
    source = RACINE / f"src/cours{cours}/diapo/tds/{td.name}.typ"
    if not source.exists():
        titre = td.name
        guide = RACINE / f"src/cours{cours}/notebook/td/{td.name}/guide.md"
        if guide.exists():
            trouve = re.search(r'^title:\s*"?(.+?)"?\s*$', guide.read_text(encoding="utf-8"), re.M)
            if trouve:
                titre = re.sub(r"^TD \w+ — ", "", trouve.group(1))
        return {"numero": td.name.split("_")[0], "titre": titre}
    texte = source.read_text(encoding="utf-8")
    return dict(re.findall(r'^\s*(\w+):\s*"([^"]*)"', texte, re.M))


def readme(cours: str, tds: list[Path], racine: list[str]) -> str:
    lignes = [
        f"# Cours {cours} — travaux dirigés",
        "",
        "Un dossier par TD, dans l'ordre de la séance : le chiffre est la séance,",
        "la lettre l'ordre dans la séance. La feuille du TD (`td_<dossier>.pdf`) et,",
        "quand il existe, le guide détaillé (`guide_<dossier>.pdf`) sont dans son dossier.",
        "Un TD qui se fait à la racine de l'archive a sa feuille à la racine.",
        "",
        "| TD | Titre | Dossier | |",
        "|----|-------|---------|-|",
    ]
    rangees = []
    for td in tds:
        d = description(cours, td)
        rangees.append((d["numero"], f"| {d['numero']} | {d['titre']} | `{td.name}/` | {d.get('statut', '')} |"))
    for nom in racine:
        d = description(cours, nom)
        rangees.append((d["numero"], f"| {d['numero']} | {d['titre']} | racine, `td_{nom}.pdf` | {d.get('statut', '')} |"))
    lignes += [rangee for _, rangee in sorted(rangees)]
    lignes.append("")
    return "\n".join(lignes)


def fabriquer(cours: str) -> int:
    """Refait données, feuilles de TD et notebooks depuis leurs sources."""
    etapes = []
    donnees = RACINE / "data" / f"cours{cours}" / "make_data.py"
    if donnees.exists():
        etapes.append((donnees, ["build"], donnees.parent))
    etapes += [
        (RACINE / "outils" / "compiler_tds.py", ["--cours", str(cours)], RACINE),
        (RACINE / "outils" / "construire_notebooks.py", [], RACINE),
        (RACINE / "outils" / "compiler_guides.py", ["--cours", str(cours)], RACINE),
    ]
    for script, arguments, dossier in etapes:
        execution = subprocess.run(
            [sys.executable, str(script), *arguments], cwd=dossier, check=False,
            capture_output=True, text=True,
        )
        print(execution.stdout, end="")
        print(execution.stderr, end="", file=sys.stderr)
        if execution.returncode:
            print(f"{script.name} a échoué", file=sys.stderr)
            return execution.returncode
        # `make_data.py` signale une source absente par une ligne `! …` et
        # continue : l'archive partirait sans le fichier. On s'arrête là.
        manques = [ligne for ligne in execution.stdout.splitlines() if ligne.startswith("! ")]
        if manques:
            print(f"{script.relative_to(RACINE)} : {len(manques)} fichier(s) non produit(s), "
                  "archive non assemblée (voir les lignes `!` ci-dessus)", file=sys.stderr)
            return 1
    return 0


def livrer(cours: str, lister: bool) -> int:
    tds = dossiers_td(cours)
    if not tds:
        print(f"data/cours{cours} : aucun dossier de TD", file=sys.stderr)
        return 1

    cible = LIVRAISON / f"cours{cours}"
    archive = LIVRAISON / f"info01-cours{cours}.zip"
    if not lister:
        shutil.rmtree(cible, ignore_errors=True)
        cible.mkdir(parents=True)

    total = 0
    for td in tds:
        couples = a_livrer(td)
        feuilles = [rel.name for _, rel in couples
                    if rel.suffix == ".pdf" and rel.name in (f"td_{td.name}.pdf", f"guide_{td.name}.pdf")]
        if not feuilles:
            print(f"  {td.name} : ni feuille de TD (td_{td.name}.pdf) ni guide (guide_{td.name}.pdf)",
                  file=sys.stderr)
        print(f"{td.name}/ : {len(couples)} fichier(s)")
        for source, relatif in couples:
            total += 1
            if lister:
                print(f"    {relatif}")
                continue
            destination = cible / td.name / relatif
            destination.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(source, destination)
        for vide in dossiers_vides(td):
            if lister:
                print(f"    {vide}/  (vide)")
            else:
                (cible / td.name / vide).mkdir(parents=True, exist_ok=True)

    racine = []
    for nom, feuille in feuilles_racine(cours):
        if not feuille.exists():
            print(f"  {nom} : feuille de TD absente ({feuille.relative_to(RACINE)})", file=sys.stderr)
            continue
        racine.append(nom)
        total += 1
        print(f"{feuille.name} : à la racine")
        if not lister:
            shutil.copy2(feuille, cible / feuille.name)

    if lister:
        print(f"\n{total} fichier(s) iraient dans {cible.relative_to(RACINE)}/")
        return 0

    (cible / "README.md").write_text(readme(cours, tds, racine), encoding="utf-8")
    with zipfile.ZipFile(archive, "w", zipfile.ZIP_DEFLATED) as z:
        for f in sorted(cible.rglob("*")):
            # Un dossier vide n'a pas de fichier à écrire : il faut l'inscrire
            # lui-même, sans quoi il manque à la décompression.
            if f.is_dir() and not any(f.iterdir()):
                z.writestr(str(f.relative_to(LIVRAISON)) + "/", "")
            elif f.is_file():
                z.write(f, f.relative_to(LIVRAISON))
    taille = archive.stat().st_size / 1e6
    print(f"\n{total} fichier(s) dans {cible.relative_to(RACINE)}/, "
          f"archive {archive.relative_to(RACINE)} ({taille:.1f} Mo)")
    return 0


def main() -> int:
    analyseur = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    analyseur.add_argument("--cours", default="1", help="numéro du cours, 1 à 7, ou 1_v2 (défaut : 1)")
    analyseur.add_argument("--lister", action="store_true", help="dire ce qui serait copié")
    analyseur.add_argument(
        "--sans-fabriquer", action="store_true",
        help="ne refaire ni les données, ni les feuilles de TD, ni les notebooks",
    )
    options = analyseur.parse_args()

    if not options.lister and not options.sans_fabriquer:
        for outil in ("typst", "jupytext"):
            if shutil.which(outil) is None:
                print(f"{outil} est introuvable : `conda activate info01` d'abord "
                      "(ou --sans-fabriquer).", file=sys.stderr)
                return 2
        if fabriquer(options.cours):
            return 1
    return livrer(options.cours, options.lister)


if __name__ == "__main__":
    sys.exit(main())
