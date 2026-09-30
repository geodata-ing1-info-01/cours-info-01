// TD 2a — créer un dépôt et y enregistrer un premier état (questions 1 à 5
// du TP). Les cinq TD de la séance continuent le même projet, créé ici dans
// `travail/projet_2`.
#import "../../../commun/prelude.typ": *
#import "../style.typ": *

#let td = (
  numero: "2a",
  titre: "Un premier dépôt",
  annonce: "Objectif : créer un dépôt git, y enregistrer un premier état du projet, et lire son historique en graphe.",
  dossier: "cours2/2a_premier_depot/",
  duree: "15′",
)

#separateur-td(..td)

#d("TD 2a — un premier dépôt")[
  #question(1)[
    Configurez l'alias qui affichera le graphe du projet :
    #code("git config --global alias.llog 'log --graph --pretty=oneline --abbrev-commit --decorate'",
          taille: 12pt)
    Le graphe s'affiche ensuite avec `git llog`.
  ]

  #v(0.5em)
  #question(2)[
    En ligne de commande, placez-vous dans le dossier `travail/` de ce TD.
    Créez un dossier `projet_2`, puis entrez dedans.
  ]

  #v(0.5em)
  #question(3)[
    Initialisez un dépôt git dans ce dossier.
  ]
]

#d("TD 2a — enregistrer le premier état")[
  #question(4)[
    Créez un fichier *markdown* `README.md` à la racine du projet,
    c'est-à-dire dans `projet_2`.
  ]

  #v(0.6em)
  #question(5)[
    Créez un nouveau commit contenant le fichier nouvellement créé.
  ]

  #v(0.8em)
  #tableau(
    columns: (1.1fr, 1fr),
    align: left + horizon,
    [Commande], [Ce que `git status` affiche ensuite],
    [`git init`], reponse[dépôt vide, aucun commit, `README.md` non suivi],
    [`git add README.md`], reponse[modification à valider : nouveau fichier],
    [`git commit -m "…"`], reponse[arbre de travail propre],
  )

  #notes[
    Erreur fréquente à la question 3 : `git init` lancé dans `travail/` au
    lieu de `projet_2`. Faire vérifier le dossier courant avec `pwd` avant
    `git init`.
  ]
]
