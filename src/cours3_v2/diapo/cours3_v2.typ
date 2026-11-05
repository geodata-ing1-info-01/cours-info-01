// Cours 3, version 2 — fichier d'assemblage. PROPOSITION DE TRAVAIL (WIP).
//
//
// Même organisation que le cours 1 : `parties/` porte l'exposé, `tds/` les
// TD, et ce fichier ne pose que les réglages globaux et l'ordre. 
// Une diapositive reprise par une section de notebook
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
  annonce: "faciliter l'utilisation de son code par une autre personne : chemin de fichier, et interface en ligne de commande",
)
#let partie-2 = (
  titre: "Fichiers et encodage",
  annonce: "Lire et écrire un fichier ; fichier texte ou binaire et eoncodage; stockage des fichier et mémoire",
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
