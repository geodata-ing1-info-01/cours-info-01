// Cours 1, version 2 — fichier d'assemblage. PROPOSITION DE TRAVAIL (WIP).
//
// Premier jet de la refonte décrite dans `syllabus/02_syllabus_v2.md`
// (cours 1), écrit le 26/09/2026 pour servir de base de discussion entre
// enseignants. Le cours 1 joué en 2026 reste dans `src/cours1/`, inchangé.
//
// Les diapositives reprises du cours 1 de 2026 sont copiées sans être
// reformulées ; les diapositives nouvelles portent un commentaire
// « nouveau (v2) » dans leur source.
//
//   python outils/compiler_diapos.py --cours 1_v2            # à projeter
//   python outils/compiler_diapos.py --cours 1_v2 --notes    # notes de conduite
//   python outils/compiler_diapos.py --cours 1_v2 --corrige  # corrigé des TD
//   python outils/compiler_diapos.py --cours 1_v2 --sans-tds # le fil du cours
//
// Conventions d'écriture : STYLE.md à la racine. Gabarits : voir
// `src/cours1/diapo/README.md`.

#import "../../commun/prelude.typ": *

#show: diapos.with(
  titre-court: "Introduction à l'informatique · cours 1, version 2 (proposition)",
  auteur-court: "1re année géomatique",
)

// Un TD par fichier de `tds/`, nommé comme le dossier que l'étudiant ouvre.
// Le TD 1a de 2026 est coupé en deux : la partie faite à la souris reste en
// 1a, la partie faite au terminal devient le TD 2a, joué après l'exposé sur
// le terminal.
#let tds = sys.inputs.at("tds", default: "") != "false"

#import "tds/1a_formats.typ": td as td-1a
#import "tds/2a_terminal.typ": td as td-2a
#import "tds/2b_programme.typ": td as td-2b
#import "tds/2c_erreurs.typ": td as td-2c
#import "tds/3a_notebook.typ": td as td-3a

#include "parties/00_ouverture.typ"

#include "parties/01_logiciels_stockage.typ"
#if tds {
  include "tds/1a_formats.typ"
} else {
  sommaire-td(td-1a)
}

#include "parties/02_terminal.typ"
#if tds {
  include "tds/2a_terminal.typ"
} else {
  sommaire-td(td-2a)
}

#include "parties/02b_programme.typ"
#if tds {
  include "tds/2b_programme.typ"
  include "tds/2c_erreurs.typ"
} else {
  sommaire-td(td-2b, td-2c)
}

#include "parties/03_notebook.typ"
#if tds {
  include "tds/3a_notebook.typ"
} else {
  sommaire-td(td-3a)
}

#include "parties/99_cloture.typ"
