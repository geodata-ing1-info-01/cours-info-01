// Cours 3, version 2 — fichier d'assemblage. PROPOSITION DE TRAVAIL (WIP).
//
// Créé le 04/11/2026 par copie des diapositives du cours 3 de 2026, qui reste
// dans `src/cours3/`, inchangé, avec ses TD et ses notebooks. Données :
// `data/cours3_v2/`. Les pages de cours et les guides des TD restent à créer.
//
// Écarts avec le cours 3 de 2026, au 04/11/2026 : la page de titre et le pied de
// page ; « Objectifs de la séance » revue, « Contenu de la séance » passée en
// notes, « Deux parcours » retirée ; la partie 1 réduite à la portabilité du code,
// sans `subprocess` ; le disque et la mémoire vive, repris du cours 5, dans la
// partie 2 (`parties/02b_memoire.typ`) ; l'exemple, `altitudes.py` et une trace GPS
// à la place de la recette ; trois TD simplifiés, en consignes numérotées.
//
// Refonte à venir : `syllabus/02_syllabus_v2.md` (cours 3).
//
// Même organisation que le cours 1 : `parties/` porte l'exposé, `tds/` les
// TD, et ce fichier ne pose que les réglages globaux et l'ordre. Depuis le
// 29/09/2026, l'exposé (parties 1 et 2) vient d'abord, et tous les TD
// suivent : en séance, ils se font après l'exposé, même quand ils
// reprennent une partie. Une diapositive reprise par une section de notebook
// porte le cartouche `cellule` de cette section.
//
//   python outils/compiler_diapos.py --cours 3_v2
//   python outils/compiler_diapos.py --cours 3_v2 --notes
//   python outils/compiler_diapos.py --cours 3_v2 --corrige
//   python outils/compiler_diapos.py --cours 3_v2 --sans-tds

#import "../../commun/prelude.typ": *

#show: diapos.with(
  titre-court: "Introduction à l'informatique · cours 3, version 2 (proposition)",
  auteur-court: "1re année géomatique",
)

#let tds = sys.inputs.at("tds", default: "") != "false"

#import "tds/3a_denivele.typ": td as td-3a
#import "tds/3b_portabilite.typ": td as td-3b
#import "tds/3c_encodage.typ": td as td-3c

#let partie-1 = (
  titre: "Portabilité du code",
  annonce: "Les chemins de fichiers et les paramètres d'un programme, pour qu'une autre personne puisse l'utiliser",
)
#let partie-2 = (
  titre: "Fichiers et encodage",
  annonce: "Lire un fichier ; son contenu, une suite de caractères ; le disque et la mémoire vive ; une suite d'octets décodés selon l'encodage ; le mode binaire ; écrire un fichier",
)

#include "parties/00_ouverture.typ"

// L'exposé.
#separateur(partie-1.titre, annonce: partie-1.annonce)
#include "parties/01_programme.typ"

#separateur(partie-2.titre, annonce: partie-2.annonce)
#include "parties/02a_lecture.typ"
#include "parties/02b_encodage.typ"
#include "parties/02c_fichiers.typ"

// Les trois TD, sur la même trace GPS.
#if tds {
  include "tds/3a_denivele.typ"
  include "tds/3b_portabilite.typ"
  include "tds/3c_encodage.typ"
} else {
  sommaire-td(td-3a, td-3b, td-3c)
}

#include "parties/99_cloture.typ"
