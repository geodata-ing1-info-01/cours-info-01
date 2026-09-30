"""Fabrique les fichiers de l'exercice « formats de fichier » (cours 1).

Le dépôt ne versionne pas les textes : ce script les récupère (domaine public)
puis en dérive les variantes utilisées en séance.

    python make_data.py fetch    # télécharge les sources dans 1a_formats/fourni/
    python make_data.py build    # génère les fichiers dans 1a_formats/produit/depart/,
                                 # et recopie la photo du TD 1f depuis son fourni/

Hors ligne : déposer un .txt dans 1a_formats/fourni/ (nom = clé, ex. raven.txt)
et lancer directement `build`.
"""

import argparse
import shutil
import subprocess
import sys
import urllib.request
from pathlib import Path

ICI = Path(__file__).parent
SOURCES = ICI / "1a_formats" / "fourni"
PRODUIT = ICI / "1a_formats" / "produit"
# L'étudiant reçoit deux dossiers : `depart/`, les fichiers donnés, et
# `travail/`, vide, où vont ses copies et ce qu'il fabrique. Distinguer les
# deux évite qu'une copie renommée passe pour un fichier du cours.
SORTIE = PRODUIT / "depart"
TRAVAIL = PRODUIT / "travail"
CORRIGE = PRODUIT / "_corrige"
# Le TD 1b, l'archive .odt, repart du même `raven.odt`, dans son propre dossier.
ARCHIVE = ICI / "1b_archive_odt" / "produit"
# La photo de la recette du TD 1f : elle vient d'ailleurs, donc de `fourni/`,
# et ne se refabrique pas — mais elle doit partir dans l'archive, donc elle est
# recopiée dans `produit/`, seul dossier que `livrer_tds.py` livre.
PHOTO_SOURCE = ICI / "1f_markdown" / "fourni" / "crepes.jpg"
PHOTO_SORTIE = ICI / "1f_markdown" / "produit" / "depart" / "crepes.jpg"

# Textes du domaine public. `debut`/`fin` délimitent l'extrait utile dans le
# fichier brut (Gutenberg entoure le texte d'un long préambule de licence).
TEXTES = {
    "raven": {
        "titre": "The Raven",
        "auteur": "Edgar Allan Poe (1845)",
        "url": "https://www.gutenberg.org/cache/epub/1065/pg1065.txt",
        "debut": "Once upon a midnight dreary",
        "fin": "shall be lifted",
        "strophes_max": 4,
    },
    "auld_lang_syne": {
        "titre": "Auld Lang Syne",
        "auteur": "Robert Burns (1788)",
        "url": "https://www.gutenberg.org/cache/epub/1279/pg1279.txt",
        "debut": "Should auld acquaintance be forgot",
        "fin": None,
        "strophes_max": 4,
    },
    # Emplacement libre : déposer soi-même fourni/scarborough.txt
    # (Scarborough Fair, ballade traditionnelle — pas d'export texte stable
    # sur Wikisource, la page ne contient que la partition).
    "scarborough": {
        "titre": "Scarborough Fair",
        "auteur": "ballade traditionnelle anglaise",
        "url": None,
        "debut": None,
        "fin": None,
        "strophes_max": 4,
    },
}


def fetch() -> None:
    SOURCES.mkdir(exist_ok=True)
    for cle, meta in TEXTES.items():
        cible = SOURCES / f"{cle}.txt"
        if cible.exists():
            print(f"= {cible.name} déjà présent")
            continue
        if not meta["url"]:
            print(f"! {cle} : pas d'URL — déposer {cible} à la main")
            continue
        print(f"↓ {meta['url']}")
        with urllib.request.urlopen(meta["url"], timeout=30) as reponse:
            brut = reponse.read().decode("utf-8", errors="replace")
        cible.write_text(extraire(brut, meta), encoding="utf-8")
        print(f"✓ {cible.name}")


def extraire(brut: str, meta: dict) -> str:
    """Isole l'extrait utile et le limite à quelques strophes."""
    texte = brut.replace("\r\n", "\n")
    if meta["debut"] and meta["debut"] in texte:
        texte = texte[texte.index(meta["debut"]):]
    if meta["fin"] and meta["fin"] in texte:
        texte = texte[: texte.index(meta["fin"]) + len(meta["fin"])]
    strophes = [s.strip("\n") for s in texte.split("\n\n") if s.strip()]
    return "\n\n".join(strophes[: meta["strophes_max"]]) + "\n"


def lignes_du_texte(chemin: Path) -> list[str]:
    return [ligne.strip() for ligne in chemin.read_text(encoding="utf-8").splitlines()]


def build() -> None:
    # produit/ ne contient que ce que ce script fabrique : on repart de zéro,
    # pour que rien de ce qu'un TD joué depuis le dépôt y a laissé (un
    # `raven.pdf` exporté, une copie renommée) ne parte dans l'archive remise
    # aux étudiants, qui reprend produit/ tel quel.
    for dossier in (PRODUIT, ARCHIVE, PHOTO_SORTIE.parent.parent):
        if dossier.exists():
            for ancien in dossier.iterdir():
                if ancien.name == ".gitkeep":
                    continue
                shutil.rmtree(ancien) if ancien.is_dir() else ancien.unlink()
    for dossier in (SORTIE, TRAVAIL, CORRIGE, ARCHIVE / "depart", ARCHIVE / "travail"):
        dossier.mkdir(parents=True, exist_ok=True)
    (SORTIE / "style.css").write_text(CSS, encoding="utf-8")

    if PHOTO_SOURCE.exists():
        PHOTO_SORTIE.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(PHOTO_SOURCE, PHOTO_SORTIE)
        print(f"✓ {PHOTO_SORTIE.name} → {PHOTO_SORTIE.parent}/")
    else:
        print(f"! {PHOTO_SOURCE.name} absent — `python outils/ressources.py importer <dossier>`")

    trouve = False
    for cle, meta in TEXTES.items():
        source = SOURCES / f"{cle}.txt"
        if not source.exists():
            # Un texte sans URL est facultatif : son absence n'est pas un
            # manque, et `outils/livrer_tds.py` ne s'arrête que sur les `!`.
            if meta["url"]:
                print(f"! {source.name} absent — lancer `fetch` ou le déposer à la main")
            else:
                print(f"- {source.name} absent, facultatif (pas d'URL : à déposer à la main)")
            continue
        trouve = True
        construire_un(cle, meta, source)
    if not trouve:
        sys.exit("Aucune source disponible : rien à générer.")


def construire_un(cle: str, meta: dict, source: Path) -> None:
    lignes = lignes_du_texte(source)
    titre, auteur = meta["titre"], meta["auteur"]

    # Corrigé : le texte tel qu'il doit être remis en forme par l'étudiant.
    shutil.copy(source, CORRIGE / f"{cle}.txt")

    # 1. tout le texte sur UNE seule ligne (l'énoncé de l'exercice)
    une_ligne = " ".join(mot for mot in lignes if mot)
    (SORTIE / f"{cle}_une_ligne.txt").write_text(une_ligne + "\n", encoding="utf-8")

    # 2. le MÊME contenu avec une extension trompeuse (à renommer)
    (SORTIE / f"{cle}_une_ligne.donnees").write_text(une_ligne + "\n", encoding="utf-8")

    # 3. HTML brut : aucune mise en forme, le navigateur écrase les sauts de ligne
    (SORTIE / f"{cle}_brut.html").write_text(
        gabarit_html(titre, auteur, une_ligne, feuille=None), encoding="utf-8"
    )

    # 4. HTML mis en forme : même contenu, une feuille de style en plus
    corps = "\n".join(
        f"    <p>{ligne}</p>" if ligne else "    <br>" for ligne in lignes
    )
    (SORTIE / f"{cle}_style.html").write_text(
        gabarit_html(titre, auteur, corps, feuille="style.css", brut=False),
        encoding="utf-8",
    )

    # 5. ODT, via pandoc (installé avec l'environnement conda du cours)
    odt = SORTIE / f"{cle}.odt"
    md = SORTIE / f"{cle}.md"
    md.write_text(f"# {titre}\n\n*{auteur}*\n\n" + "\n".join(lignes) + "\n", encoding="utf-8")
    try:
        subprocess.run(["pandoc", str(md), "-o", str(odt)], check=True)
        if cle == "raven":
            shutil.copy(odt, ARCHIVE / "depart" / odt.name)
    except (FileNotFoundError, subprocess.CalledProcessError):
        print(f"! pandoc indisponible — {odt.name} non généré")
    finally:
        md.unlink(missing_ok=True)

    print(f"✓ {cle} : {len(lignes)} lignes → {SORTIE}/")


def gabarit_html(titre: str, auteur: str, corps: str, feuille: str | None, brut: bool = True) -> str:
    lien = f'\n  <link rel="stylesheet" href="{feuille}">' if feuille else ""
    contenu = f"    <p>{corps}</p>" if brut else corps
    return f"""<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>{titre}</title>{lien}
</head>
<body>
  <article>
    <h1>{titre}</h1>
    <p class="auteur">{auteur}</p>
{contenu}
  </article>
</body>
</html>
"""


CSS = """/* Feuille de style d'exemple — cours 1.
   Même contenu HTML, rendu différent : le fond (données) et la forme (style)
   sont dans deux fichiers séparés. */

body {
  font-family: Georgia, "Times New Roman", serif;
  line-height: 1.6;
  color: #2b2b2b;
  background: #faf8f4;
  margin: 0;
  padding: 2rem 1rem;
}

article {
  max-width: 34rem;
  margin: 0 auto;
}

h1 {
  font-size: 1.9rem;
  margin-bottom: 0.2rem;
}

.auteur {
  font-style: italic;
  color: #6b6b6b;
  margin-top: 0;
  border-bottom: 1px solid #ddd8cd;
  padding-bottom: 1rem;
}

p {
  margin: 0.15rem 0;
}
"""


if __name__ == "__main__":
    parseur = argparse.ArgumentParser(description=__doc__)
    parseur.add_argument("action", choices=["fetch", "build"])
    action = parseur.parse_args().action
    fetch() if action == "fetch" else build()
