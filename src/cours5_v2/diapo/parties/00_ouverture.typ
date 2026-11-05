// Ouverture du cours 5 v2 — incluse par `cours5_v2.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#page-titre(
  titre: "Cours 5",
  sous-titre: "Version 2, proposition de travail",
  auteur: "1re année géomatique",
  date: "2027-2028",
)

// --------------------------------------------
#d("Objectifs de la séance")[
  #chaine(
    gabarit: bloc, pleins: (1,),
    ([Cours 3], [permettre à une autre personne d'utiliser ce code]),
    ([Cours 5], [installer ce code et ce dont il dépend]),
    ([Cours 6], [partager ce code et travailler à plusieurs]),
  )

  #v(0.3em)
  #annonce[
    Lancer un autre programme depuis Python.\
    Décrire l'environnement d'un projet, pour le recréer sur un autre poste.\
    Savoir comment le terminal trouve une commande.\
    Installer son programme comme une commande.
  ]

  #notes[
    Le déroulé reste à établir. Avec le matériel, le réseau et le TD 5a, le contenu
    dépasse une séance : choisir ce qui reste du cours 5 de 2026.

    Le TD 4b du parcours avancé applique déjà `pyproject.toml` et `subprocess`, avant
    cette séance.
  ]
]
