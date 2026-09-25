#!/usr/bin/env python3
"""Repère les diapositives trop pleines dans un PDF produit par typst.

Le gabarit `d` de `src/commun/theme.typ` répartit l'espace libre entre le
titre et le bas de la page par deux ressorts (`v(0.85fr)` puis `v(1fr)`).
Quand le corps est
trop haut, ces ressorts se referment sans que typst ne signale rien : la phrase
d'annonce vient alors se coller sous le titre, parfois le chevaucher, et la
diapositive n'est fautive qu'à l'œil.

Le symptôme se mesure. Ce script relève, page par page, l'écart vertical entre
le bas du titre et la première ligne du corps, et signale ce qui passe sous un
seuil.

    python outils/verifier_diapos.py src/cours1/diapo/cours1.pdf

La version annotée est plus contrainte, puisqu'elle réserve le bas de la page
aux notes de conduite : elle mérite le même passage.

    typst compile --root . --input notes=true src/cours1/diapo/cours1.typ notes.pdf
    python outils/verifier_diapos.py notes.pdf

Une page qui porte du texte sans aucune ligne à la taille d'un titre est
aussi signalée : c'est la suite d'une diapositive qui a débordé sur une page
de plus, que l'écart seul ne voit pas.

Sort en code 1 si au moins une diapositive est signalée, pour un enchaînement
dans un script.
"""

from __future__ import annotations

import argparse
import subprocess
import sys
import xml.etree.ElementTree as ET

NS = "{http://www.w3.org/1999/xhtml}"

# Corps du titre de diapositive : 33 pt, soit une ligne d'environ 40 pt de haut.
# Le corps courant est à 21 pt. Le seuil départage les deux sans ambiguïté.
HAUTEUR_TITRE = 35.0

# Écart normal entre le titre et le corps sur une diapositive qui respire : la
# valeur observée descend rarement sous 30 pt.
ECART_MINIMAL = 20.0

# Le pied de page occupe les derniers points de la hauteur ; on l'écarte.
BANDE_PIED = 40.0

# Le texte d'une page de débordement commence dans cette bande, en haut.
BANDE_HAUTE = 80.0


# La version annotée pose les notes à droite, sur une page deux fois plus large.
# Ce qui s'y mesure est la diapositive, donc la moitié gauche : sans ce filtre,
# les lignes de notes sont lues comme le corps et l'écart mesuré est celui qui
# les sépare du titre, soit presque rien.
RAPPORT_16_9 = 841.89 / 473.556


def largeur_diapo(page):
    largeur, hauteur = float(page.get("width")), float(page.get("height"))
    double = largeur > 1.5 * hauteur * RAPPORT_16_9
    return largeur / 2 if double else largeur


def lignes(page, tolerance=3.0):
    """Regroupe les mots de la diapositive en lignes, par ordonnée."""
    limite = largeur_diapo(page)
    mots = sorted(
        (
            (float(m.get("yMin")), float(m.get("yMax")), float(m.get("xMin")), m.text or "")
            for m in page.iter(NS + "word")
            if float(m.get("xMin")) < limite
        ),
        key=lambda m: (m[0], m[2]),
    )
    groupes = []
    for ymin, ymax, _, texte in mots:
        if groupes and abs(groupes[-1][0] - ymin) <= tolerance:
            haut, bas, mots_vus = groupes[-1]
            groupes[-1] = (haut, max(bas, ymax), mots_vus + " " + texte)
        else:
            groupes.append((ymin, ymax, texte))
    return groupes


def bloc_titre(gs):
    """Étendue du titre : ses lignes, plus ce qui les chevauche.

    Un titre peut tenir sur deux lignes, et contenir un fragment en chasse fixe
    (`content.xml`, `.odt`) dont la boîte est plus courte et forme un groupe à
    part. Les deux cas se ramènent au même traitement : on absorbe toute ligne
    qui déborde encore sur la bande du titre.
    """
    fin = gs[0][1]
    i = 1
    while i < len(gs) and (gs[i][0] < fin or gs[i][1] - gs[i][0] >= HAUTEUR_TITRE):
        fin = max(fin, gs[i][1])
        i += 1
    return fin, i


def examiner(chemin, seuil):
    xml = subprocess.run(
        ["pdftotext", "-bbox", str(chemin), "-"], capture_output=True, text=True
    )
    if xml.returncode != 0:
        print(f"pdftotext a échoué sur {chemin}", file=sys.stderr)
        return None
    racine = ET.fromstring(xml.stdout)

    signalees = []
    for numero, page in enumerate(racine.iter(NS + "page"), 1):
        hauteur = float(page.get("height"))
        gs = [g for g in lignes(page) if g[0] < hauteur - BANDE_PIED]
        if (gs and all(bas - haut < HAUTEUR_TITRE for haut, bas, _ in gs)
                and gs[0][0] < BANDE_HAUTE
                and not gs[0][2].startswith("TRAVAUX DIRIGÉS")):
            # Du texte en haut de page, mais aucune ligne à la taille d'un
            # titre : la suite d'une diapositive qui a débordé sur une page
            # de plus. Le sommaire des TD (« TRAVAUX DIRIGÉS ») et une image
            # pleine page, créditée en bas, n'en sont pas.
            signalees.append((numero, 0.0, "page sans titre : " + gs[0][2]))
            continue
        if not gs or gs[0][1] - gs[0][0] < HAUTEUR_TITRE:
            continue  # page de titre ou de séparation : pas de corps à mesurer
        fin_titre, i = bloc_titre(gs)
        if i >= len(gs):
            continue  # un titre et rien d'autre
        ecart = gs[i][0] - fin_titre
        if ecart < seuil:
            signalees.append((numero, ecart, gs[0][2]))
    return signalees


def main() -> int:
    analyseur = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    analyseur.add_argument("pdf", nargs="+", help="les PDF à examiner")
    analyseur.add_argument(
        "--seuil", type=float, default=ECART_MINIMAL,
        help=f"écart minimal toléré, en points (défaut : {ECART_MINIMAL:g})",
    )
    options = analyseur.parse_args()

    total = 0
    for chemin in options.pdf:
        signalees = examiner(chemin, options.seuil)
        if signalees is None:
            return 2
        print(f"{chemin} : ", end="")
        if not signalees:
            print("aucune diapositive trop pleine.")
            continue
        print(f"{len(signalees)} diapositive(s) trop pleine(s).")
        for numero, ecart, titre in signalees:
            print(f"  page {numero:>3}   écart {ecart:6.1f} pt   {titre[:55]}")
        total += len(signalees)
    return 1 if total else 0


if __name__ == "__main__":
    sys.exit(main())
