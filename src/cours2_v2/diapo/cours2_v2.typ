// Cours 2, version 2 — fichier d'assemblage. PROPOSITION DE TRAVAIL (WIP).
//
// Premier jet de la refonte décrite dans `syllabus/02_syllabus_v2.md`
// (cours 2), écrit le 26/09/2026 pour servir de base de discussion entre
// enseignants. Le cours 2 joué en 2026 (portage du support de Florent
// Geniet) reste dans `src/cours2/`, inchangé.
//
// Les diapositives reprises du cours 1 de 2026 (éditeur de code) sont copiées
// sans être reformulées. La partie git est réécrite sur le
// modèle des autres cours (titre, annonce, preuve visuelle) ; elle reprend
// les schémas de `commun/schemas_git.typ`. Les sorties de git viennent du
// rejeu du TD 2c : `src/cours2_v2/notebook/td/2c_depot_altitudes/rejeu/`.
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

#import "tds/2a_vscode.typ": td as td-2a
#import "tds/2b_erreurs.typ": td as td-2b
#import "tds/2c_depot_altitudes.typ": td as td-2c

#include "parties/00_ouverture.typ"

// L'éditeur est présenté, puis configuré en classe entière (TD 2a) et employé
// (TD 2b). Ordre du 28/09/2026 ; `parties/01_vscode.typ` retiré.
// 04/11/2026 : `parties/03_markdown.typ` et le TD Markdown sont retirés, la
// syntaxe minimale est vue au cours 1 v2 ; l'ancien TD 2d devient le TD 2c ;
// `parties/03b_vscode.typ` est fondu dans `parties/02_editeur.typ`.
#include "parties/02_editeur.typ"
#if tds {
  include "tds/2a_vscode.typ"
  include "tds/2b_erreurs.typ"
} else {
  sommaire-td(td-2a)
  sommaire-td(td-2b)
}

#include "parties/04_git.typ"
#if tds {
  include "tds/2c_depot_altitudes.typ"
} else {
  sommaire-td(td-2c)
}

#include "parties/99_cloture.typ"
