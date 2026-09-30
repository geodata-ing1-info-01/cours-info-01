// Cours 3 — fichier d'assemblage.
//
// Même organisation que le cours 1 : `parties/` porte l'exposé, `tds/` les
// TD, et ce fichier ne pose que les réglages globaux et l'ordre. Depuis le
// 29/09/2026, l'exposé (parties 1 et 2) vient d'abord, et tous les TD
// suivent : en séance, ils se font après l'exposé, même quand ils
// reprennent une partie. Une diapositive reprise par une section de notebook
// porte le cartouche `cellule` de cette section.
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

#import "tds/3a_preparation.typ": td as td-3a
#import "tds/3b_recette.typ": td as td-3b
#import "tds/3c_fichiers.typ": td as td-3c
#import "tds/3e_markdown.typ": td as td-3e
#import "tds/3f_cli.typ": td as td-3f

#let partie-1 = (
  titre: "Chemins et programmes externes",
  annonce: "Améliorer le code de génération de recette : ses chemins avec pathlib, sa conversion par pandoc avec subprocess, ses paramètres avec argparse",
)
#let partie-2 = (
  titre: "Fichiers et encodage",
  annonce: "Lire un fichier ; son contenu, une suite de caractères, puis une suite d'octets décodés selon l'encodage ; le mode binaire ; écrire un fichier",
)

#include "parties/00_ouverture.typ"

// L'exposé.
#separateur(partie-1.titre, annonce: partie-1.annonce)
#include "parties/01_programme.typ"

#separateur(partie-2.titre, annonce: partie-2.annonce)
#include "parties/02a_lecture.typ"
#include "parties/02b_encodage.typ"
#include "parties/02c_fichiers.typ"

// Les TD : la préparation du poste, sans l'environnement, puis les deux
// notebooks. `images.ipynb` (TD 3d), facultatif, n'a que sa feuille.
#if tds {
  include "tds/3a_preparation.typ"
  include "tds/3b_recette.typ"
  include "tds/3c_fichiers.typ"
} else {
  sommaire-td(td-3a, td-3b, td-3c)
}

// Dernière partie, au choix : rappel des deux parcours, puis le TD 3e
// (standard) et le TD 3f (avancé), qui commence par l'environnement conda,
// selon les groupes.
#include "parties/03_parcours.typ"
#if tds {
  include "tds/3e_markdown.typ"
  include "tds/3f_cli.typ"
} else {
  sommaire-td(td-3e, td-3f)
}

#include "parties/99_cloture.typ"
