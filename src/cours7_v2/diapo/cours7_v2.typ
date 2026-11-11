// Cours 7, version 2 — fichier d'assemblage. PROPOSITION DE TRAVAIL (WIP), 10/11/2026.
//
// Reprise de la séance 7 de 2026, qui reste inchangée dans `src/cours7/`. Pour l'instant,
// un seul TD, le TD 7a, refait sur le programme de la trace GPS (`tds/7a_trace.typ`), avec
// moins d'étapes et un premier push détaillé. Le TD 7b (le train) reste à reprendre.
//
//   python outils/compiler_diapos.py --cours 7_v2
//   python outils/compiler_diapos.py --cours 7_v2 --notes
//   python outils/compiler_diapos.py --cours 7_v2 --sans-tds

#import "../../commun/prelude.typ": *

#show: diapos.with(
  titre-court: "Introduction à l'informatique · cours 7",
  auteur-court: "1re année géomatique",
)

#let tds = sys.inputs.at("tds", default: "") != "false"

#import "tds/7a_trace.typ": td as td-7a

#page-titre(
  titre: "Séance 7 : projet d'application 2",
  sous-titre: "TD d'application des cours 4 à 6 : un dépôt GitHub copié, complété sur une branche, fusionné par une pull request",
  auteur: "1re année géomatique",
  date: "",
)

// --------------------------------------------
#if tds {
  include "tds/7a_trace.typ"
} else {
  sommaire-td(td-7a)
}

// --------------------------------------------
#d("Travail à rendre")[
  #annonce[
    Le dépôt GitHub `td7a-trace`, avec sa pull request fusionnée.
  ]

  #show table.cell: set text(size: 15pt)
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Emplacement], [Contenu attendu],
    [`https://github.com/<compte>/td7a-trace`], [`stats_trace.py` avec l'option `--profil`, et `profil.csv` absent],
    [onglet Pull requests, Closed], [la pull request de la branche `profil`, fusionnée],
    [`git log --oneline --graph`, sur `master`], [le commit `Merge pull request #1`, et les deux commits de la branche],
  )

  #legende[
    Le token est supprimé du poste et de GitHub à la fin de la séance.
  ]
]
