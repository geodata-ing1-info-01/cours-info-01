// Cours 5, version 2 — fichier d'assemblage. PROPOSITION DE TRAVAIL (WIP).
//
// 05/11/2026 : le cours porte d'abord sur l'installation et la distribution d'un
// programme Python, après le cours 3 sur la portabilité. En tête, `subprocess` (cours 3
// de 2026) et les environnements (cours 1 de 2026) ; puis `PATH` et les variables
// d'environnement, nouveaux ; puis le paquet. Le matériel et le réseau restants suivent.
//
// Le cours 5 de 2026 reste inchangé dans `src/cours5/`. Les schémas et le TD 5a viennent
// de là, et ne sont pas recopiés. Passés ailleurs : les mots de passe, les clés SSH et
// les secrets au cours 6 v2 ; la température et la consommation au cours 1 v2.
//
//   python outils/compiler_diapos.py --cours 5_v2
//   python outils/compiler_diapos.py --cours 5_v2 --notes
//   python outils/compiler_diapos.py --cours 5_v2 --corrige
//   python outils/compiler_diapos.py --cours 5_v2 --sans-tds

#import "../../commun/prelude.typ": *

#show: diapos.with(
  titre-court: "Introduction à l'informatique · cours 5, version 2 (proposition)",
  auteur-court: "1re année géomatique",
)

#let tds = sys.inputs.at("tds", default: "") != "false"

#import "tds/5a_mesures.typ": td as td-5a

#include "parties/00_ouverture.typ"

#include "parties/01_subprocess.typ"
#include "parties/02_environnements.typ"
#include "parties/03_path.typ"
#include "parties/04_paquet.typ"

#include "parties/05_materiel.typ"
#include "parties/06_reseau.typ"
#if tds {
  include "tds/5a_mesures.typ"
} else {
  sommaire-td(td-5a)
}

#include "parties/99_cloture.typ"
