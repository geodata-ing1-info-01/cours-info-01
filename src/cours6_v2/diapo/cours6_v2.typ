// Cours 6, version 2 — fichier d'assemblage. PROPOSITION DE TRAVAIL (WIP).
//
// 05/11/2026 : un cours sur le partage du code et le travail à plusieurs, avec les
// problèmes d'authentification et de sécurité que cela pose. La forge d'abord, adaptée
// du cours de Florent Geniet du 14/10/2026 (`livraison/cours6/`) ; puis une diapositive
// qui pose le problème ; puis les mots de passe, les clés et les secrets, déplacés du
// cours 5. Le TD 6a adapte le TP de Florent Geniet, et le TD 6b est l'ancien TD 5b.
//
// `src/cours6/` reste le gabarit de 2026, inchangé. Les schémas des mots de passe
// viennent de `src/cours5/diapo/schemas.typ`, et ne sont pas recopiés.
//
//   python outils/compiler_diapos.py --cours 6_v2
//   python outils/compiler_diapos.py --cours 6_v2 --notes
//   python outils/compiler_diapos.py --cours 6_v2 --corrige
//   python outils/compiler_diapos.py --cours 6_v2 --sans-tds

#import "../../commun/prelude.typ": *

#show: diapos.with(
  titre-court: "Introduction à l'informatique · cours 6, version 2 (proposition)",
  auteur-court: "1re année géomatique",
)

#let tds = sys.inputs.at("tds", default: "") != "false"

#import "tds/6a_github.typ": td as td-6a
#import "tds/6b_secret_historique.typ": td as td-6b

#include "parties/00_ouverture.typ"

#include "parties/01_forge.typ"
#include "parties/02_mots_de_passe.typ"
#if tds {
  include "tds/6a_github.typ"
} else {
  sommaire-td(td-6a)
}

#include "parties/03_secrets.typ"
#if tds {
  include "tds/6b_secret_historique.typ"
} else {
  sommaire-td(td-6b)
}

#include "parties/99_cloture.typ"
