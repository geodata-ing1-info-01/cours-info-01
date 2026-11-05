// Cours 4, version 2 — fichier d'assemblage. PROPOSITION DE TRAVAIL (WIP).
//
// 05/11/2026 : reprise du cours 4 de 2026, qui reste inchangé dans `src/cours4/`. La
// séance a un seul TD, le TD 4a, refait sur la trace GPS des cours 1 à 3
// (`tds/4a_trace.typ`). Pas de parcours avancé pour l'instant : le TD 4b et son exposé
// sont dans `a_reprendre/`, et des options avancées s'ajouteront aux TD quand une
// première version de tous les cours v2 existera.
//
//   python outils/compiler_diapos.py --cours 4_v2
//   python outils/compiler_diapos.py --cours 4_v2 --notes
//   python outils/compiler_diapos.py --cours 4_v2 --sans-tds

#import "../../commun/prelude.typ": *

#show: diapos.with(
  titre-court: "Introduction à l'informatique · cours 4, version 2 (proposition)",
  auteur-court: "1re année géomatique",
)

#let tds = sys.inputs.at("tds", default: "") != "false"

#import "tds/4a_trace.typ": td as td-4a

#page-titre(
  titre: "Séance 4 : projet d'application 1",
  sous-titre: "TD d'application des cours 1 à 3 : un script Python construit pas à pas, versionné avec git",
  auteur: "1re année géomatique",
  date: "",
)

// --------------------------------------------
#if tds {
  include "tds/4a_trace.typ"
} else {
  sommaire-td(td-4a)
}

// --------------------------------------------
#d("Ce qu'on rend")[
  #annonce[
    Le dossier du projet, avec son historique git.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Commande], [Résultat],
    [`git log --oneline`], [huit commits, neuf avec le bonus],
    [`git status`], [« rien à valider » ; `resume.txt` n'est pas listé],
    [`python stats_trace.py --help`], [décrit les options `--distance` et `--vitesse`],
    [`python stats_trace.py trace.csv --distance --vitesse`], [affiche la distance parcourue et la vitesse moyenne],
  )

  #legende[
    Garder le dossier `travail/stats_trace/` après la séance : les séances
    suivantes le reprennent.
  ]

  #notes[
    Le README et l'étiquette `v1.0` (étape B7) se font après la séance si
    le temps manque.
  ]
]
