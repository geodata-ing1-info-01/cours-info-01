// Clôture du cours 2 v2 — incluse en dernier par `cours2_v2.typ`.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

// Nouveau (v2).
#d("À retenir")[
  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [Un éditeur de code], [colore, vérifie et lance le code ; son terminal est Git Bash],
    [Un réglage], [User pour le compte, Workspace pour le dossier, écrit dans `settings.json`],
    [Un commit], [une version enregistrée : ce que `git add` a mis dans l'index],
    [`git status`], [la commande à taper avant toute autre],
    [`.gitignore`], [ce qui se refait ne se versionne pas],
    [Une branche], [une variante, qui se fusionne ; un conflit se résout à la main],
    [Une copie d'un dépôt], [tout l'historique ; les copies échangent leurs commits (cours 6)],
  )

  #notes[
    Cours 3 : un environnement conda pour la séance ; les TD sont des dépôts
    git, un commit par étape (syllabus v2).
  ]
]
