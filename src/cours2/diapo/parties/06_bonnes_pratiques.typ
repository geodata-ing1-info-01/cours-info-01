// Cours 2, partie 6 — les règles de tenue d'un dépôt (diapositives 25 et 26).
#import "../../../commun/prelude.typ": *
#import "../beamer.typ": d-beamer as d
#import "../schemas.typ": *
#import "../style.typ": *

// --------------------------------------------- 25/26, en trois étapes
#let _regles = (
  [toujours décrire ce qu'on a fait dans le message de commit :],
  [ne pas commit un code qui n'est pas fonctionnel],
  [enfin il existe une architecture typique pour les projets informatiques],
)

#for etape in range(1, 4) {
  d("Bonnes pratiques")[
    On va essayer de suivre certaines règles lorsqu'on utilise git, pour
    toujours avoir un git lisible et compréhensible.

    #liste-progressive(etape, _regles)

    #if etape == 1 {
      code("git commit -m \"ajout de fonctionnalités dans le fichier...\"")
    }

    #if etape == 3 {
      notes[
        Le message décrit la modification : « ajout de la fonction inv dans
        operations.py ». « corrections » ne décrit rien.
      ]
    }
  ]
}

// --------------------------------------------- 26/26, en quatre étapes
//
// Une branche de plus par étape, et la phrase qui la concerne.
#let _commentaires = (
  [
    Le *main* ne reçoit que les versions complètes du projet, qui peuvent être
    distribuées.
  ],
  [
    On utilise une branche *develop* pour travailler sur la création d'une
    nouvelle version. Cette branche doit *toujours* avoir une version
    fonctionnelle du projet, et *on ne travaille pas directement dessus*.
  ],
  [
    On crée une branche pour chaque fonctionnalité à rajouter au projet. C'est
    sur ces branches qu'on travaille.
  ],
  [
    Si la branche *develop* change, on fusionne la nouvelle version avec les
    branches de fonctionnalité pour *rester à jour*.
  ],
)

#for etape in range(1, 5) {
  d("Bonnes pratiques")[
    #align(center, gitflow(etape: etape, echelle: 1.45))

    #v(0.6em)
    #_commentaires.at(etape - 1)

    #if etape == 4 {
      notes[
        Ce modèle s'appelle git flow. Le TD 2e en joue la première règle :
        master ne reçoit que la version terminée, taguée.
      ]
    }
  ]
}
