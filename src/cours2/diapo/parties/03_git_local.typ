// Cours 2, partie 3 — le dépôt local : créer, enregistrer, annuler, étiqueter
// (diapositives 11 à 16).
#import "../../../commun/prelude.typ": *
#import "../beamer.typ": d-beamer as d
#import "../../../commun/schemas_git.typ": *
#import "../schemas.typ": *
#import "../style.typ": *

// Une suite de commits sur une voie, prolongée de tirets.
#let _chaine(noms, teintes: (:), echelle: 1.0, extra: none) = graphe-git(
  taille-etiquette: 11pt,
  commits: noms.enumerate().map(((i, nom)) => (
    nom: "k" + str(i), col: i, voie: 0, etiquette: nom,
    teinte: teintes.at(str(i), default: white),
    parents: if i == 0 { () } else { ("k" + str(i - 1),) },
  )),
  fleches: ((depuis: "k" + str(noms.len() - 1), longueur: 0.9),),
  echelle: echelle,
  extra: extra,
)

// --------------------------------------------- 11/26
#d("Initialiser un projet git")[
  #grid(
    columns: (1.5fr, 1fr), column-gutter: 20pt, align: horizon,
    [
      Un projet git s'appelle un *repository* (ou *dépôt git* en français).

      #v(0.9em)
      Créer un repository = créer un dossier _.git_

      #v(0.9em)
      On utilise la commande suivante :
      #code("git init", centre: true)
    ],
    align(center, dossier-projet(echelle: 1.3)),
  )

  #notes[
    Le dépôt est le dossier `.git`. Le supprimer efface l'historique ; les
    fichiers de travail restent.
  ]
]

// --------------------------------------------- 12/26
#d("Commit")[
  #grid(
    columns: (1.4fr, 1fr), column-gutter: 20pt, align: horizon,
    align(center)[
      Juste après `git init`, le dépôt ne contient aucun commit. Le
      premier commit s'appelle souvent *Initial commit*
    ],
    align(center, _chaine(("Initial commit",), echelle: 1.3)),
  )
]

// --------------------------------------------- 13/26
#d("Commit")[
  #grid(
    columns: (1.25fr, 1fr), column-gutter: 20pt, align: horizon,
    align(center)[
      Chaque nouvel état enregistré du projet s'appelle un *commit*
    ],
    align(center, _chaine(("Initial commit", "commit 1", "commit 2"), echelle: 1.15)),
  )

  #notes[
    Un commit est un état enregistré du projet entier, avec un identifiant,
    auquel on peut revenir.
  ]
]

// --------------------------------------------- 14/26, en cinq étapes
//
// À chaque étape, un texte et une transition de plus.
#let _etapes-enregistrer = (
  [Chaque fichier créé est *non suivi*.],
  [
    Pour commencer à suivre un fichier, on utilise la commande :
    #code("#ajouter un fichier spécifique
git add <nom_de_fichier>

#ajouter un dossier et
#tout ses fichiers
git add <nom_de_dossier>

#ajouter le dossier courant
git add .")
  ],
  [
    On peut ensuite créer un *nouvel état* du projet avec les nouveaux
    fichiers.
    #code("git commit -m <message_de_commit>")
  ],
  [Pour valider un changement, on réutilise la commande *add*.],
  [
    Il faut régulièrement faire des *commits*, car on ne peut naviguer
    qu'entre deux états enregistrés.
  ],
)

#for etape in range(1, 6) {
  d("Enregistrer des modifications")[
    #grid(
      columns: (1fr, 1.25fr), column-gutter: 16pt, align: horizon,
      block(width: 100%)[#_etapes-enregistrer.at(etape - 1)],
      align(center, cycle-de-vie(etape: etape, echelle: 1.0)),
    )

    #if etape == 5 {
      notes[
        Correspondance avec `git status` : « non suivi » = « Fichiers non
        suivis » ; « suivi & non modifié » = « Modifications qui seront
        validées » ; « modifié » = « Modifications qui ne seront pas
        validées » ; « nouvel état » = « rien à valider ».
      ]
    }
  ]
}

// --------------------------------------------- 15/26
#d("Annuler un commit")[
  #grid(
    columns: (1.15fr, 1fr), column-gutter: 20pt, align: horizon,
    [
      On peut annuler un commit avec la commande :
      #code("git revert <nom du commit>")
      Cette commande crée un nouveau commit !
    ],
    align(center, _chaine(
      ("commit 1", "commit 2", "commit 3"),
      teintes: ("1": rgb("#F5C6C6")),
      echelle: 1.25,
      extra: (pos, d) => {
        pont(d, pos("k0"), pos("k2"), "Même état")
        d.content((pos("k2").at(0), pos("k2").at(1) - 0.55),
                  text(size: 9pt, fill: accent)[git revert c2], anchor: "north")
      },
    )),
  )

  #notes[
    `revert` ajoute un commit qui défait le commit visé ; les commits
    existants restent. `reset`, qui retire des commits de la branche, n'est
    pas vu aujourd'hui.
  ]
]

// --------------------------------------------- 16/26
#d("Tagger un commit")[
  #grid(
    columns: (1.3fr, 1fr), column-gutter: 20pt, align: horizon,
    [
      On peut tagger un commit avec la commande :
      #code("git tag -a <nom du tag> -m <message de tag>")
    ],
    align(center, _chaine(
      ("commit 1", "commit 2", "commit 3"),
      teintes: ("1": rgb("#BFE3BF")),
      echelle: 1.25,
      extra: (pos, d) => {
        d.content((pos("k1").at(0), pos("k1").at(1) - 0.55),
                  text(size: 9pt, fill: accent)[Tag : V1.0], anchor: "north")
      },
    )),
  )

  #notes[
    Un tag donne un nom choisi (`v1.0`) à un commit, dont l'identifiant est
    une empreinte SHA-1 de 40 caractères. Le TD 6a en pose un.
  ]
]
