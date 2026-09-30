// TD 2c — revenir en arrière, et remettre une branche à jour
// (questions 18 à 20 du TP).
#import "../../../commun/prelude.typ": *
#import "../style.typ": *

#let td = (
  numero: "2c",
  titre: "Annuler et remettre à jour",
  annonce: "Objectif : annuler un commit sans réécrire l'historique, puis mettre une branche à jour sur une autre.",
  dossier: "cours2/2c_annuler/",
  duree: "15′",
)

#separateur-td(..td)

#d("TD 2c — annuler une erreur")[

  #legende[
    On travaille dans le dépôt créé au TD 2a,
    `cours2/2a_premier_depot/travail/projet_2`.
  ]
  #question(18)[
    On simule une fausse manœuvre. Supprimez le code présent dans `main.py`
    et dans `operations.py`, puis faites un commit. Comment revenir en
    arrière ?
  ]

  #v(0.4em)
  #question(19)[
    `git revert` crée un nouveau commit qui annule le commit visé. Repérez le
    commit avec `git log`, annulez-le avec `git revert` (dans l'éditeur :
    `:wq` puis `Entrée`), puis affichez le graphe.
  ]

  #v(0.4em)
  #tableau(
    columns: (1.4fr, 1fr),
    align: left + horizon,
    [Question], [Réponse],
    [Le commit créé par `git revert` a-t-il l'identifiant du commit
     repéré ?],
    reponse[non : c'est un nouveau commit],
  )
]

#d("TD 2c — remettre une branche à jour")[
  #question(20)[
    Revenez sur la branche *main_code*. Ajoutez en première ligne de
    `src/main.py` le commentaire
    `# Point d'entrée de la calculatrice : affiche le titre.`, puis faites un
    commit. Affichez le graphe avec `git llog --all`, mettez la branche à jour
    avec `git rebase develop`, puis affichez de nouveau le graphe.
  ]

  #v(0.4em)
  #tableau(
    columns: (1.4fr, 1fr),
    align: left + horizon,
    [Question], [Réponse],
    [Le commit du commentaire a-t-il le même identifiant avant et après le
     rebase ?],
    reponse[non : le rebase l'a refait au bout de *develop* ; son parent a
     changé, et donc son identifiant],
  )

  #notes[
    Une branche que quelqu'un d'autre a déjà récupérée ne se rebase pas ;
    ici, personne ne l'a récupérée.

    Avant le rebase, le commit du commentaire part de `affichage du titre` ;
    après, il est au sommet de develop, avec un autre identifiant, comme les
    « bis » de la diapositive. Sans ce commit, main_code n'aurait rien à
    refaire : le rebase ne ferait qu'avancer la branche.
  ]
]
