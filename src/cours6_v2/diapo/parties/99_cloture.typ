// Clôture du cours 6 v2 — incluse en dernier par `cours6_v2.typ`. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#d("À retenir")[
  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [Une forge], [héberge une copie du dépôt, avec laquelle chacun se synchronise],
    [`git clone`, `pull`, `push`], [copier le dépôt, recevoir les commits, envoyer les commits],
    [Un `pull` avant un `push`], [le dépôt distant refuse un `push` s'il a des commits que le poste n'a pas],
    [Une pull request], [demande de fusionner une branche, avec les différences affichées],
    [Un token, une clé SSH], [remplacent le mot de passe du compte pour git],
    [Un secret], [jamais dans un commit ; s'il est publié, le révoquer d'abord],
  )

  #notes[
    Le projet 7 applique ces opérations : une pull request relue par un camarade.
  ]
]
