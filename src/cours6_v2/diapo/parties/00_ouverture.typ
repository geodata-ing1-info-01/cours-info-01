// Ouverture du cours 6 v2 — incluse par `cours6_v2.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#page-titre(
  titre: "Cours 6",
  sous-titre: "Forge, mots de passe et secrets",
  auteur: "1re année géomatique",
  date: "2027-2028",
)

// --------------------------------------------
#d("Objectifs de la séance")[
  #chaine(
    gabarit: bloc, pleins: (2,),
    ([Cours 3], [permettre à une autre personne d'utiliser ce code]),
    ([Cours 5], [installer ce code et ce dont il dépend]),
    ([Cours 6], [partager ce code et travailler à plusieurs]),
  )

  #v(0.3em)
  #annonce[
    Synchroniser un dépôt avec une forge, et travailler à plusieurs sur ce dépôt.\
    Protéger l'accès au dépôt : authentification, droits, secrets.
  ]

  #notes[
    Le déroulé reste à établir, et le TD 6a à chronométrer. Le syllabus v2 prévoit
    95 min pour une forge sans la partie sur les mots de passe.
  ]
]
