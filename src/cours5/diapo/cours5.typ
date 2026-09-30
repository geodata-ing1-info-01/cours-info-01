// Cours 5 — fichier d'assemblage.
//
// Le contenu est dans `parties/` et `tds/`, un fichier par partie de l'exposé
// et par TD. Ce fichier ne porte que les réglages globaux et l'ordre des
// parties. Les schémas dessinés sont dans `schemas.typ`.
//
//   python outils/compiler_diapos.py --cours 5              # à projeter
//   python outils/compiler_diapos.py --cours 5 --notes      # notes de conduite
//   python outils/compiler_diapos.py --cours 5 --corrige    # corrigé des TD
//   python outils/compiler_diapos.py --cours 5 --sans-tds   # le fil du cours
//
// Conventions d'écriture : STYLE.md à la racine. Gabarits : voir
// `src/cours1/diapo/README.md`. Déroulé : `syllabus/cours/5_materiel_reseau_ssh/`.

#import "../../commun/prelude.typ": *

#show: diapos.with(
  titre-court: "Introduction à l'informatique",
  auteur-court: "1re année géomatique",
)

#let tds = sys.inputs.at("tds", default: "") != "false"

#import "tds/5a_mesures.typ": td as td-5a
#import "tds/5b_secret_historique.typ": td as td-5b

#include "parties/00_ouverture.typ"

#include "parties/01_materiel.typ"

#include "parties/02_reseau.typ"
#if tds {
  include "tds/5a_mesures.typ"
} else {
  sommaire-td(td-5a)
}

// La clé SSH sur GitHub (ancien TD 5b) est retirée le 30/09/2026 : l'accès à
// GitHub est vu au cours 6.
#include "parties/03_prouver_qui_lon_est.typ"

#include "parties/04_secrets.typ"
#if tds {
  include "tds/5b_secret_historique.typ"
} else {
  sommaire-td(td-5b)
}

#include "parties/99_cloture.typ"
