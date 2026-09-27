// Cours 2, version 2 — fichier d'assemblage. PROPOSITION DE TRAVAIL (WIP).
//
// Premier jet de la refonte décrite dans `syllabus/02_syllabus_v2.md`
// (cours 2), écrit le 26/09/2026 pour servir de base de discussion entre
// enseignants. Le cours 2 joué en 2026 (portage du support de Florent
// Geniet) reste dans `src/cours2/`, inchangé.
//
// Les diapositives reprises du cours 1 de 2026 (éditeur de code, Markdown)
// sont copiées sans être reformulées. La partie git est réécrite sur le
// modèle des autres cours (titre, annonce, preuve visuelle) ; elle reprend
// les schémas de `commun/schemas_git.typ`. Les sorties de git viennent du
// rejeu du TD 3a : `src/cours2_v2/notebook/td/3a_depot_recette/rejeu/`.
//
//   python outils/compiler_diapos.py --cours 2_v2            # à projeter
//   python outils/compiler_diapos.py --cours 2_v2 --notes    # notes de conduite
//   python outils/compiler_diapos.py --cours 2_v2 --corrige  # corrigé des TD
//   python outils/compiler_diapos.py --cours 2_v2 --sans-tds # le fil du cours

#import "../../commun/prelude.typ": *

#show: diapos.with(
  titre-court: "Introduction à l'informatique · cours 2, version 2 (proposition)",
  auteur-court: "1re année géomatique",
)

#let tds = sys.inputs.at("tds", default: "") != "false"

#import "tds/1a_vscode.typ": td as td-1a
#import "tds/1b_erreurs.typ": td as td-1b
#import "tds/2a_markdown.typ": td as td-2a
#import "tds/3a_depot_recette.typ": td as td-3a

#include "parties/00_ouverture.typ"

// L'éditeur est présenté, avec Markdown en fin de partie, puis configuré en
// classe entière (TD 1a) et employé (TD 1b, TD 2a). Ordre du 28/09/2026 ;
// `parties/01_vscode.typ` retiré.
#include "parties/02_editeur.typ"
#include "parties/03_markdown.typ"
#include "parties/03b_vscode.typ"
#if tds {
  include "tds/1a_vscode.typ"
  include "tds/1b_erreurs.typ"
  include "tds/2a_markdown.typ"
} else {
  sommaire-td(td-1a)
  sommaire-td(td-1b)
  sommaire-td(td-2a)
}

#include "parties/04_git.typ"
#if tds {
  include "tds/3a_depot_recette.typ"
} else {
  sommaire-td(td-3a)
}

#include "parties/99_cloture.typ"
