// Cours 3 — fichier d'assemblage.
//
// Même organisation que le cours 1 : `parties/` porte l'exposé, `tds/` les
// TD, et ce fichier ne pose que les réglages globaux et l'ordre. Particularité
// de cette séance : les parties 1 et 2 sont de l'exposé seul, et les
// notebooks qui les accompagnent (`recette.ipynb`, `fichiers.ipynb`,
// `images.ipynb`) se font en autonomie. Une diapositive reprise par une
// section de notebook porte le cartouche `cellule` de cette section.
//
//   python outils/compiler_diapos.py --cours 3
//   python outils/compiler_diapos.py --cours 3 --notes
//   python outils/compiler_diapos.py --cours 3 --corrige
//   python outils/compiler_diapos.py --cours 3 --sans-tds

#import "../../commun/prelude.typ": *

#show: diapos.with(
  titre-court: "Introduction à l'informatique",
  auteur-court: "1re année géomatique",
)

#let tds = sys.inputs.at("tds", default: "") != "false"

#import "tds/0a_preparation.typ": td as td-0a
#import "tds/3a_cli.typ": td as td-3a

// Les parties 1 et 2 se jouent notebook ouvert : leur ouverture est commune
// au TD, une page partagée entre le bleu de l'exposé et le brun du TD.
#let partie-1 = (
  titre: "Chemins et programmes externes",
  annonce: "Améliorer le code de génération de recette : ses chemins avec pathlib, sa conversion par pandoc avec subprocess, ses paramètres avec argparse",
)
#let partie-2 = (
  titre: "Fichiers et encodage",
  annonce: "Lire un fichier ; son contenu, une suite de caractères, puis une suite d'octets décodés selon l'encodage ; le mode binaire ; écrire un fichier",
)

#include "parties/00_ouverture.typ"

// TD d'environnement, selon les groupes (syllabus v1.5) : la partie 4 du
// cours 1 n'a pas été jouée en 2026.
#if tds {
  include "tds/0a_preparation.typ"
} else {
  sommaire-td(td-0a)
}

// Les parties 1 et 2 sont de l'exposé seul, depuis le 25/09/2026 : les
// notebooks se font en autonomie, et les TD 1a, 2a et 2b n'ont plus de
// diapositive dans le déroulé. Leurs fichiers `tds/` restent, pour les
// feuilles de TD livrées dans l'archive (`outils/compiler_tds.py`).
#separateur(partie-1.titre, annonce: partie-1.annonce)
#include "parties/01_programme.typ"

#separateur(partie-2.titre, annonce: partie-2.annonce)
#include "parties/02a_lecture.typ"
#include "parties/02b_encodage.typ"
#include "parties/02c_fichiers.typ"

#include "parties/03_cli.typ"
#if tds {
  include "tds/3a_cli.typ"
} else {
  sommaire-td(td-3a)
}

#include "parties/99_cloture.typ"
