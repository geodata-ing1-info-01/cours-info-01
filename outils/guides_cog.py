#!/usr/bin/env python3
"""Écrit dans les guides de TD leurs blocs de code et leurs sorties, par Cog.

Un guide de TD, `src/cours<n>/notebook/td/<td>/guide.md`, s'écrit à la main. Ses
blocs de code et les sorties de ses programmes sont fabriqués à partir des données
du TD, dans `data/`, par Cog (https://cog.readthedocs.io). Cog exécute le code
Python placé entre `[[[cog` et `]]]`, dans un commentaire HTML, et écrit ce qu'il
produit juste en dessous, jusqu'à `[[[end]]]`, dans le fichier même :

    <!-- [[[cog td.modif("3.1")]]] -->
    ```modif
    …bloc écrit par Cog…
    ```
    <!-- [[[end]]] -->

Les commentaires ne s'affichent ni dans le PDF et la page HTML de pandoc, ni dans
le book, ni dans JupyterLab ; le bloc écrit entre les deux marques est du Markdown
ordinaire. Le texte reste ainsi dans le guide, et le code qui fabrique les versions
du programme reste dans `data/`. Le premier commentaire d'un guide charge ce code :

    <!-- [[[cog td = donnees("cours7_v2/make_data.py")]]] -->
    <!-- [[[end]]] -->

Le module chargé fournit :

    versions() -> dict[str, str]    le texte du programme à chaque version, « depart » en tête
    ORDRE: list[str]                facultatif : l'ordre des versions, quand versions()
                                    contient aussi des alias (« b3 » pour la dernière de B3)
    executer(nom, *arguments) -> str   la sortie réelle du programme à cette version
    PROGRAMME: str                  le nom du fichier lancé, pour la ligne de commande

    python outils/guides_cog.py --cours 7_v2      # réécrit les blocs des guides du cours
    python outils/guides_cog.py --verifier        # signale un bloc qui n'est plus à jour, sans rien écrire
    python outils/guides_cog.py src/cours7_v2/notebook/td/7a_trace/guide.md

Sans fichier ni `--cours`, le script traite tous les guides qui contiennent `[[[cog`.
`outils/livrer_tds.py` le lance après `make_data.py build` : l'archive part avec des
blocs à jour. Sort en code 1 si un guide n'est pas à jour (`--verifier`) ou si Cog
échoue.
"""

from __future__ import annotations

import argparse
import importlib.util
import sys
from pathlib import Path
from types import ModuleType

RACINE = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(RACINE / "outils"))
from modifications import blocs  # noqa: E402


def ecrire(texte: str) -> None:
    """Écrit `texte` à la place du bloc courant (dans un commentaire Cog)."""
    import cog  # module que Cog installe pendant le traitement d'un fichier
    cog.outl(texte.rstrip("\n"))


def bloc_code(texte: str, langage: str = "python") -> str:
    return f"```{langage}\n{texte.rstrip()}\n```"


def bloc_terminal(commande: str, sortie: str) -> str:
    return f"```text\n$ {commande}\n{sortie.rstrip()}\n```"


def extrait(sortie: str, debut: int = 8, fin: int = 2) -> str:
    """Les `debut` premières lignes de `sortie`, `…`, puis les `fin` dernières."""
    lignes = sortie.splitlines()
    if len(lignes) <= debut + fin:
        return sortie
    return "\n".join([*lignes[:debut], "…", *lignes[-fin:]])


class Donnees:
    """Les versions d'un programme de TD, et les blocs que le guide en montre."""

    def __init__(self, module: ModuleType) -> None:
        self.module = module
        self.versions = module.versions()
        if self.versions is None:
            raise RuntimeError(f"{module.__file__} : versions non fabriquées (lignes « ! » ci-dessus)")
        self.ordre = list(getattr(module, "ORDRE", self.versions))

    def modif(self, nom: str) -> None:
        """Le bloc ```modif qui mène de la version précédente à la version `nom`."""
        precedente = self.ordre[self.ordre.index(nom) - 1]
        ecrire(blocs(self.versions[precedente], self.versions[nom]))

    def texte(self, texte: str, langage: str = "text") -> None:
        """Un texte quelconque fabriqué par le module, dans un bloc de code."""
        ecrire(bloc_code(texte, langage))

    def programme(self, nom: str) -> None:
        """Le programme entier, à la version `nom`."""
        ecrire(bloc_code(self.versions[nom]))

    def sortie(self, nom: str, *arguments: str, debut: int | None = None, fin: int = 2) -> None:
        """La commande et sa sortie réelle ; avec `debut`, sans le milieu de la sortie."""
        texte = self.module.executer(nom, *arguments)
        if debut is not None:
            texte = extrait(texte, debut, fin)
        ecrire(bloc_terminal(" ".join(["python", self.module.PROGRAMME, *arguments]), texte))


def donnees(chemin: str) -> Donnees:
    """Le module de données `data/<chemin>`, chargé une seule fois par exécution."""
    fichier = RACINE / "data" / chemin
    nom = "donnees_" + "_".join(fichier.relative_to(RACINE / "data").with_suffix("").parts)
    if nom not in sys.modules:
        spec = importlib.util.spec_from_file_location(nom, fichier)
        module = importlib.util.module_from_spec(spec)
        sys.modules[nom] = module
        spec.loader.exec_module(module)
    return Donnees(sys.modules[nom])


def guides(cours: str | None) -> list[Path]:
    motif = f"src/cours{cours}/notebook/td/*/guide.md" if cours else "src/cours*/notebook/td/*/guide.md"
    return sorted(g for g in RACINE.glob(motif) if "[[[cog" in g.read_text(encoding="utf-8"))


def main() -> int:
    analyseur = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    analyseur.add_argument("fichiers", nargs="*", type=Path, help="les guides à traiter")
    analyseur.add_argument("--cours", help="les guides de ce cours seulement (1_v2, 7_v2…)")
    analyseur.add_argument("--verifier", action="store_true",
                           help="signaler les blocs qui ne sont plus à jour, sans rien écrire")
    options = analyseur.parse_args()
    fichiers = [f.resolve() for f in options.fichiers] or guides(options.cours)
    if not fichiers:
        return 0
    from cogapp import Cog
    arguments = ["cog", "--check", "--diff"] if options.verifier else ["cog", "-r"]
    arguments += ["-p", "from guides_cog import *", "-I", str(RACINE / "outils")]
    return Cog().main([*arguments, *map(str, fichiers)])


if __name__ == "__main__":
    sys.exit(main())
