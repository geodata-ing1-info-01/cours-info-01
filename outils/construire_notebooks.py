#!/usr/bin/env python3
"""Convertit les notebooks MyST du dépôt en `.ipynb`, et les exécute.

Les sources sont en MyST Markdown : c'est du texte, qui se relit, se compare
ligne à ligne et se versionne — la démonstration du cours 1 appliquée à ses
propres supports. Le `.ipynb` en est dérivé, comme un PDF l'est d'un `.typ`.

Ne sont convertis que les notebooks écrits pour un TD,
`src/cours<n>/notebook/td/<td>/`, où `<td>` nomme le dossier de `data/cours<n>/`
qui les reçoit. Les autres pages de `notebook/` sont des chapitres du book :
elles s'exécutent à la construction du book, et n'ont pas à être distribuées en
`.ipynb`.

Le `.ipynb` est déposé dans `produit/` du TD, et `outils/livrer_tds.py` le
prend au passage, comme le reste de `produit/`. Un sous-dossier sous `<td>/`
est reproduit sous `produit/` : `td/1a_recette/depart/notebook/recette.md`
donne `produit/depart/notebook/recette.ipynb`, que l'étudiant copie dans
`travail/` avant de l'ouvrir. La clé `execution` de l'en-tête MyST dit alors,
relativement au notebook livré, depuis quel dossier il s'exécute
(`execution: ../../travail`) ; sans elle, c'est son propre dossier.

    python outils/construire_notebooks.py            # convertit
    python outils/construire_notebooks.py --executer # convertit puis exécute

`--executer` remplit les sorties : c'est ce qu'on distribue aux étudiants quand
on veut qu'ils voient le résultat attendu sans avoir à tout relancer. Sans
l'option, les cellules sont vides, ce qui est la forme à ouvrir en séance.
Un notebook qui ne tourne que dans l'environnement que son TD fait créer
(`outils_video` du TD 4c du cours 1, dans `trajet_ensg`) porte
`executer: false` dans son en-tête : il est converti, jamais exécuté.

Un notebook à compléter en séance marque ses cellules de solution par
l'étiquette `corrige` (`:tags: [corrige]` sous la clôture ```{code-cell}). Le
`.ipynb` livré ne garde alors, de ces cellules, que les lignes de commentaire
placées en tête, la consigne ; la version complète va dans `produit/_corrige/`,
que `outils/livrer_tds.py` ne livre pas, et c'est elle que `--executer`
exécute. C'est le pendant du `reponse[…]` des diapositives : ce que l'étudiant
produit est masqué, la consigne ne l'est jamais.

Un trou plus court se marque ligne par ligne, par le commentaire final
`# à compléter`, dans n'importe quelle cellule de code. Le livré garde la
cellule entière et ne remplace que ces lignes : `x = expression  # à compléter`
devient `x = ...  # à compléter`, une ligne sans affectation devient
`...  # à compléter`. Une cellule Markdown « Réponse », repliée par
`<details>`, suit la cellule et donne les lignes complètes ; JupyterLab et
VS Code l'affichent fermée, un clic l'ouvre. Le corrigé garde les lignes,
sans le commentaire.

Une ligne à corriger plutôt qu'à écrire se marque `# à remplacer`, précédée
d'un commentaire `# livré : <code>` qui donne la version livrée :

    # livré : with open("C:/…/recette.md", encoding="utf-8") as fichier:
    with open(fichier_recette, encoding="utf-8") as fichier:  # à remplacer

Le livré porte la ligne du commentaire, suivie de `# à remplacer` ; le
corrigé et la réponse repliée, la ligne correcte. Le commentaire `# livré`
n'apparaît dans aucun des deux.

Les illustrations d'un TD sont des schémas de diapositive, écrits en typst
dans `src/cours<n>/notebook/td/<td>/illustrations/<nom>.typ`. Le script les
compile en `produit/illustrations/<nom>.png` du TD, que `livrer_tds.py` met à
plat dans `<td>/illustrations/`. Un notebook ouvert depuis `travail/` les
affiche par `![…](../illustrations/<nom>.png)`.

Sort en code 1 si une conversion, une exécution ou une illustration échoue.
"""

from __future__ import annotations

import argparse
import json
import re
import shutil
import subprocess
import sys
from pathlib import Path

ETIQUETTE = "corrige"
MARQUE = "# à compléter"
REMPLACER = "# à remplacer"
LIVRE = "# livré : "
AFFECTATION = re.compile(r"^(\s*)([\w.\[\]\"', ]+?)\s*=(?!=)")

RACINE = Path(__file__).resolve().parent.parent
SOURCES = sorted((RACINE / "src").glob("cours*/notebook/td/**/*.md"))


def destination(source: Path) -> tuple[Path, Path] | None:
    """`produit/` du TD que nomme la source, et le sous-dossier où va le `.ipynb`.

    Le chemin d'une source est `src/cours<n>/notebook/td/<td>/[<sous>/]<nom>.md` :
    `<td>` est le dossier de `data/cours<n>/` qui reçoit le notebook, et
    `<sous>`, s'il existe, est reproduit sous `produit/`. Écrire la
    destination dans l'arborescence plutôt que dans le script évite d'avoir à
    tenir une table de correspondance.
    """
    for parent in source.parents:
        if parent.name == "td" and parent.parent.name == "notebook":
            cours = parent.parents[1].name
            relatif = source.relative_to(parent)
            td = RACINE / "data" / cours / relatif.parts[0]
            if not td.is_dir():
                return None
            sous = Path(*relatif.parts[1:-1])
            return td / "produit", sous
    return None


def illustrer() -> int:
    """Compile les illustrations des TD en PNG ; renvoie le nombre d'échecs."""
    echecs = 0
    for figure in sorted((RACINE / "src").glob("cours*/notebook/td/*/illustrations/*.typ")):
        td = figure.parent.parent
        cours = td.parents[2].name
        produit = RACINE / "data" / cours / td.name / "produit"
        if not produit.parent.is_dir():
            continue
        cible = produit / "illustrations" / (figure.stem + ".png")
        cible.parent.mkdir(parents=True, exist_ok=True)
        code = subprocess.run(
            ["typst", "compile", "--root", str(RACINE), "--format", "png", "--ppi", "144",
             str(figure), str(cible)],
            check=False,
        ).returncode
        if code != 0:
            print(f"{figure.relative_to(RACINE)} : illustration échouée", file=sys.stderr)
            echecs += 1
        else:
            print(f"  {cible.relative_to(RACINE)}")
    return echecs


def a_executer_ici(notebook: Path) -> bool:
    """Faux si l'en-tête porte `executer: false` : le notebook tourne ailleurs."""
    metadonnees = json.loads(notebook.read_text(encoding="utf-8")).get("metadata", {})
    return metadonnees.get("executer", True) is not False


def dossier_execution(notebook: Path) -> Path:
    """D'où le notebook s'exécute : la clé `execution` de ses métadonnées, sinon son dossier."""
    metadonnees = json.loads(notebook.read_text(encoding="utf-8")).get("metadata", {})
    relatif = metadonnees.get("execution")
    return (notebook.parent / relatif).resolve() if relatif else notebook.parent


def consigne(source_cellule: str) -> str:
    """Les lignes de commentaire en tête d'une cellule, ou une consigne par défaut."""
    lignes = []
    for ligne in source_cellule.splitlines():
        if ligne.startswith("#"):
            lignes.append(ligne)
        elif ligne.strip():
            break
    return "\n".join(lignes) + "\n" if lignes else "# à compléter\n"


def ligne_a_trou(ligne: str) -> str:
    """La ligne livrée : la valeur remplacée par `...`, le nom affecté conservé."""
    affectation = AFFECTATION.match(ligne)
    if affectation:
        indentation, nom = affectation.groups()
        return f"{indentation}{nom} = ...  {MARQUE}"
    indentation = ligne[:len(ligne) - len(ligne.lstrip())]
    return f"{indentation}...  {MARQUE}"


def sans_marque(ligne: str) -> str:
    return ligne[:-len(MARQUE)].rstrip()


def reponse(lignes: list[str]) -> dict:
    """La cellule Markdown repliée qui donne les lignes complètes."""
    texte = "\n".join(lignes)
    return {
        "cell_type": "markdown",
        "metadata": {},
        "source": f"<details><summary>Réponse</summary>\n\n```python\n{texte}\n```\n\n</details>",
    }


def a_trous(complet: Path, livre: Path) -> bool:
    """Écrit la version livrée du notebook ; dit s'il y avait des cellules à masquer.

    Le notebook complet est réécrit au passage, sans les commentaires
    `# à compléter`.
    """
    notebook = json.loads(complet.read_text(encoding="utf-8"))
    cellules_livrees = []
    masquees = 0
    for cellule in notebook["cells"]:
        cellules_livrees.append(cellule)
        if cellule["cell_type"] != "code":
            continue
        lignes = "".join(cellule["source"]).splitlines()
        complete, livree_lignes, reponses = [], [], []
        i = 0
        while i < len(lignes):
            ligne = lignes[i]
            suivante = lignes[i + 1].rstrip() if i + 1 < len(lignes) else ""
            if ligne.lstrip().startswith(LIVRE) and suivante.endswith(REMPLACER):
                # la ligne livrée vient du commentaire, la correcte de la suivante
                indentation = ligne[:len(ligne) - len(ligne.lstrip())]
                correcte = suivante[:-len(REMPLACER)].rstrip()
                livree_lignes.append(f"{indentation}{ligne.strip()[len(LIVRE):]}  {REMPLACER}")
                complete.append(correcte)
                reponses.append(correcte.strip())
                i += 2
                continue
            if ligne.rstrip().endswith(MARQUE):
                livree_lignes.append(ligne_a_trou(sans_marque(ligne)))
                complete.append(sans_marque(ligne))
                reponses.append(sans_marque(ligne).strip())
            else:
                livree_lignes.append(ligne)
                complete.append(ligne)
            i += 1
        if reponses:
            livree = dict(cellule)
            livree["source"] = "\n".join(livree_lignes)
            cellule["source"] = "\n".join(complete)
            cellules_livrees[-1] = livree
            cellules_livrees.append(reponse(reponses))
            masquees += 1
        elif ETIQUETTE in cellule.get("metadata", {}).get("tags", []):
            livree = dict(cellule)
            livree["source"] = consigne("".join(cellule["source"]))
            cellules_livrees[-1] = livree
            masquees += 1
    if masquees:
        complet.write_text(json.dumps(notebook, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
        notebook["cells"] = cellules_livrees
        for cellule in notebook["cells"]:
            if cellule["cell_type"] == "code":
                cellule["outputs"] = []
                cellule["execution_count"] = None
        livre.write_text(json.dumps(notebook, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
    return bool(masquees)


def convertir(source: Path, executer: bool) -> bool:
    trouve = destination(source)
    if trouve is None:
        print(f"{source.relative_to(RACINE)} : pas de dossier de TD correspondant "
              f"sous data/, ignoré", file=sys.stderr)
        return False
    produit, sous = trouve
    dossier = produit / sous
    dossier.mkdir(parents=True, exist_ok=True)
    cible = dossier / source.with_suffix(".ipynb").name
    conversion = subprocess.run(
        ["jupytext", "--to", "ipynb", "--output", str(cible), str(source)],
        capture_output=True, text=True,
    )
    if conversion.returncode != 0:
        print(f"{source.relative_to(RACINE)} : conversion échouée", file=sys.stderr)
        print(conversion.stderr.strip(), file=sys.stderr)
        return False
    print(f"  {cible.relative_to(RACINE)}")

    # Le notebook complet est d'abord écrit à la place du livré ; s'il porte
    # des cellules `corrige`, il part dans `_corrige/` et le livré est refait
    # avec ses trous.
    complet = cible
    corrige = produit / "_corrige" / sous / cible.name
    provisoire = cible.with_suffix(".tmp")
    troue = a_trous(cible, provisoire)
    if troue:
        corrige.parent.mkdir(parents=True, exist_ok=True)
        cible.replace(corrige)
        provisoire.replace(cible)
        complet = corrige
        print(f"  {corrige.relative_to(RACINE)} (complet ; le livré est à trous)")
    elif corrige.exists():
        corrige.unlink()

    if not executer:
        return True
    if not a_executer_ici(cible):
        print("    non exécuté (executer: false)")
        return True

    # Le notebook s'exécute là où l'étudiant l'ouvre : son propre dossier, ou
    # celui que sa clé `execution` désigne (la copie dans `travail/`). nbconvert
    # exécute toujours un notebook depuis son propre dossier : la version
    # complète est donc copiée à cet endroit le temps de tourner, puis rangée
    # dans `_corrige/` avec ses sorties.
    ou = dossier_execution(cible)
    ou.mkdir(parents=True, exist_ok=True)
    # Dans un autre dossier, la copie porte le nom du notebook, comme celle
    # que l'étudiant fait ; dans le même, un préfixe la distingue du livré.
    a_executer = ou / (cible.name if ou != cible.parent else f"_execution_{cible.name}")
    shutil.copy2(complet, a_executer)
    execution = subprocess.run(
        ["jupyter", "nbconvert", "--to", "notebook", "--execute", "--inplace",
         str(a_executer)],
        capture_output=True, text=True, cwd=ou,
    )
    # Sans trous, le livré lui-même reçoit les sorties, comme avant ; avec,
    # elles vont au corrigé.
    if troue or ou != cible.parent:
        corrige.parent.mkdir(parents=True, exist_ok=True)
        a_executer.replace(corrige)
        complet = corrige
    else:
        a_executer.replace(cible)
        complet = cible
    if execution.returncode != 0:
        print(f"{complet.relative_to(RACINE)} : exécution échouée", file=sys.stderr)
        print(execution.stderr.strip()[-1500:], file=sys.stderr)
        return False
    print(f"    exécuté ({complet.relative_to(RACINE)})")
    return True


def main() -> int:
    analyseur = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    analyseur.add_argument(
        "--executer", action="store_true",
        help="exécuter les notebooks après conversion, pour remplir les sorties",
    )
    options = analyseur.parse_args()

    if not SOURCES:
        print("aucun notebook MyST trouvé sous src/cours*/notebook/", file=sys.stderr)
        return 1

    echecs = illustrer()
    for source in SOURCES:
        print(f"{source.relative_to(RACINE)}")
        if not convertir(source, options.executer):
            echecs += 1
    return 1 if echecs else 0


if __name__ == "__main__":
    sys.exit(main())
