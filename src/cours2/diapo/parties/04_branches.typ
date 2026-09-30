// Cours 2, partie 4 — branches, HEAD, fusion et conflits (diapositives 17
// à 20). Le graphe à huit commits sert aux quatre.
#import "../../../commun/prelude.typ": *
#import "../beamer.typ": d-beamer as d
#import "../../../commun/schemas_git.typ": *
#import "../schemas.typ": *
#import "../style.typ": *

// Le graphe de référence : deux branches depuis commit 1, et commit 5 seul
// sur une voie intermédiaire.
#let _reference = (
  (nom: "c1", col: 0, voie: 0, etiquette: "commit 1"),
  (nom: "c4", col: 1, voie: 0, etiquette: "commit 4", parents: ("c1",)),
  (nom: "c7", col: 2, voie: 0, etiquette: "commit 7", parents: ("c4",)),
  (nom: "c8", col: 3, voie: 0, etiquette: "commit 8", parents: ("c7",)),
  (nom: "c2", col: 1, voie: 2, etiquette: "commit 2", parents: ("c1",)),
  (nom: "c3", col: 2, voie: 2, etiquette: "commit 3", parents: ("c2",)),
  (nom: "c6", col: 3, voie: 2, etiquette: "commit 6", parents: ("c3",)),
  (nom: "c5", col: 2, voie: 1, etiquette: "commit 5", parents: ("c4",)),
)

#let _branches-reference = (
  (nom: "branche 1", voie: 0, col: 3, ancre: "west"),
  (nom: "branche 2", voie: 2, col: 0, ancre: "east"),
)

// Après `git merge` : un commit de fusion, à deux parents.
#let _reference-fusion = _reference + (
  (nom: "c9", col: 4, voie: 0, etiquette: "merge", parents: ("c8", "c6")),
)

// Avec des noms de branche, pas de flèche de prolongement : ils se
// superposeraient.
#let _graphe-reference(echelle: 1.15, branches: (), extra: none) = graphe-git(
  commits: _reference,
  taille-etiquette: 11pt,
  branches: branches,
  fleches: if branches.len() == 0 { ((depuis: "c8"),) } else { () },
  echelle: echelle,
  extra: extra,
)

// --------------------------------------------- 17/26, en deux étapes
#let _deux-branches(haut, bas, echelle: 1.0) = graphe-git(
  taille-etiquette: 11pt,
  commits: (
    (nom: "a", col: 0, voie: 0, id: "c1"),
    (nom: "b", col: 1, voie: 0, id: "c2", parents: ("a",)),
    (nom: "c", col: 1, voie: 1.6, id: "c3", parents: ("a",)),
  ),
  branches: (
    (nom: haut, voie: 1.6, col: 1, ancre: "west", dy: 0.42),
    (nom: bas, voie: 0, col: 1, ancre: "west", dy: -0.42),
  ),
  fleches: ((depuis: "b", longueur: 0.9), (depuis: "c", longueur: 0.9)),
  echelle: echelle,
)

#d("Branches")[
  #grid(
    columns: (1.15fr, 1fr), column-gutter: 18pt, align: horizon,
    [
      Création de *branches* de commits évoluant en parallèle.
      #code("#Créer une nouvelle branche
#à partir du commit courant
git branch <nom_de_branche>

#Créer une nouvelle branche
#et s'y placer
git checkout -b <nom_branche>

#Changer de branche
git checkout <nom_de_branche>

#voir les différentes branches
git branch")
    ],
    align(center, _deux-branches("branche 2", "branche 1", echelle: 1.5)),
  )
]

#d("Branches")[
  #grid(
    columns: (1fr, 1fr), column-gutter: 18pt, align: horizon,
    [La branche initiale s'appelle *master*, ou parfois *main*.],
    align(center, _deux-branches("branche", "main", echelle: 1.7)),
  )

  #notes[
    `git init` nomme la première branche `master`, sauf si le réglage
    `init.defaultBranch` dit autre chose. GitHub et GitLab nomment la leur
    `main`. Les TD écrivent *master* : sur un poste réglé autrement, lire
    *main*.
  ]
]

// --------------------------------------------- 18/26
//
// Deux états du graphe, et entre eux la commande.
#d("Head")[
  #grid(
    columns: (0.85fr, 1.45fr), column-gutter: 16pt, align: horizon,
    [
      HEAD : désigne le commit sur lequel on se trouve (commit courant)
      #code("#Changer de commit
git checkout <nom_de_commit>")
    ],
    align(center)[
      #_graphe-reference(echelle: 1.0, extra: (pos, d) => marque-tete(d, pos("c6")))
      #v(0.2em)
      #grid(
        columns: (auto, auto), column-gutter: 8pt, align: horizon,
        text(size: 26pt, fill: accent)[#sym.arrow.b],
        text(size: 14pt, weight: demi-gras, fill: accent)[git checkout commit_7],
      )
      #v(0.2em)
      #_graphe-reference(echelle: 1.0, extra: (pos, d) => marque-tete(d, pos("c7"), dy: 0.85))
    ],
  )
]

// --------------------------------------------- 19/26, en trois étapes
#d("Fusionner deux branches")[
  #grid(
    columns: (1fr, 1.2fr), column-gutter: 18pt, align: horizon,
    [
      Deux branches peuvent être fusionnées $=>$ les
      modifications des deux branches sont ajoutées.
    ],
    align(center, _graphe-reference(echelle: 1.2, extra: (pos, d) => {
      arete-epaisse(d, pos("c6"), pos("c8"))
      cerne(d, pos("c6"), pos("c8"))
    })),
  )
]

#d("Fusionner deux branches")[
  #grid(
    columns: (1fr, 1.2fr), column-gutter: 18pt, align: horizon,
    [
      Une première façon de fusionner est le *merge*.\
      Le merge crée un nouveau commit de fusion
      #code("#Merge la branche b_1
#dans la branche courante
git merge <b_1>")
    ],
    align(center, graphe-git(
      commits: _reference-fusion,
      branches: _branches-reference,
      taille-etiquette: 11pt,
      echelle: 1.1,
      extra: (pos, d) => {
        etiquette-arete(d, pos("c6"), pos("c9"), "merge", decalage: (0.55, 0.1))
      },
    )),
  )
]

// Après le rebase, les commits de la branche 2 sont refaits au bout de la
// branche 1.
#let _rebase-apres = (
  (nom: "c1", col: 0, voie: 0, etiquette: "commit 1"),
  (nom: "c4", col: 1, voie: 0, etiquette: "commit 4", parents: ("c1",)),
  (nom: "c7", col: 2, voie: 0, etiquette: "commit 7", parents: ("c4",)),
  (nom: "c8", col: 3, voie: 0, etiquette: "commit 8", parents: ("c7",)),
  (nom: "c5", col: 1.6, voie: 1, etiquette: "commit 5", parents: ("c4",)),
  (nom: "c2b", col: 3.7, voie: 2, etiquette: "commit 2 bis", parents: ("c8",)),
  (nom: "c3b", col: 5.2, voie: 2, etiquette: "commit 3 bis", parents: ("c2b",)),
  (nom: "c6b", col: 6.7, voie: 2, etiquette: "commit 6 bis", parents: ("c3b",)),
)

#d("Fusionner deux branches")[
  #grid(
    columns: (0.85fr, 1.45fr), column-gutter: 16pt, align: horizon,
    [
      Une seconde façon de fusionner est le *rebase*.\
      Le rebase rajoute les commits de la branche source au sommet de la
      branche cible.
      #code("#Refait les commits de b_2
#au bout de b_1
git rebase <b_1> <b_2>")
    ],
    align(center)[
      #_graphe-reference(echelle: 0.78, branches: _branches-reference)
      #v(-0.2em)
      #text(size: 22pt, fill: accent)[#sym.arrow.b]
      #v(-0.2em)
      #graphe-git(
        commits: _rebase-apres,
        branches: (
          (nom: "branche 1", voie: 0, col: 3, ancre: "west"),
          (nom: "branche 2", voie: 2, col: 3.7, ancre: "east"),
        ),
        echelle: 0.78,
        taille-etiquette: 11pt,
      )
    ],
  )

  #notes[
    Le rebase réécrit l'historique : les commits replacés sont de nouveaux
    commits, avec un autre identifiant, d'où les « bis ». Une branche que
    quelqu'un d'autre a déjà récupérée ne se rebase pas. Le TD 2c le fait
    constater sur la branche `main_code`.
  ]
]

// --------------------------------------------- 20/26, en trois étapes
//
// Graphe réduit à quatre commits, pour laisser place aux trois versions du
// fichier.
#let _graphe-conflit(echelle: 1.0, extra: none) = graphe-git(
  taille-etiquette: 11pt,
  commits: (
    (nom: "c1", col: 0, voie: 0, etiquette: "commit 1"),
    (nom: "c2", col: 1, voie: 1.5, etiquette: "commit 2", parents: ("c1",)),
    (nom: "c3", col: 1, voie: 0, etiquette: "commit 3", parents: ("c1",)),
    (nom: "m", col: 2, voie: 0.75, etiquette: "merge", parents: ("c2", "c3")),
  ),
  echelle: echelle,
  extra: extra,
)

#let _fichier-multiplication = note-fichier("file.py")[
  #py-mot("def") #py-appel("fonction_1")\(a,b\):\
  #h(1em) #py-mot("return") a\*b
]

#let _fichier-addition = note-fichier("file.py")[
  #py-mot("def") #py-appel("fonction_1")\(a,b\):\
  #h(1em) #py-mot("return") a+b
]

#d("Conflits")[
  #grid(
    columns: (1fr, 1.3fr), column-gutter: 16pt, align: horizon,
    [
      Deux modifications peuvent être contradictoires. Il y a alors *conflit* :
      le développeur doit choisir comment fusionner les deux modifications.
    ],
    align(center)[
      #_graphe-reference(echelle: 1.05, extra: (pos, d) => {
        marque-conflit(d, (pos("c8").at(0) + 0.05, pos("c8").at(1) + 0.75))
      })
      #v(0.6em)
      #sortie-terminal((
        ("Fusion automatique de file.py", none),
        ("CONFLIT (contenu) : Conflit de fusion dans file.py", none),
        ("La fusion automatique a échoué ; réglez les conflits et validez le résultat.", none),
      ), taille: 10pt)
    ],
  )
]

#d("Conflits")[
  #grid(
    columns: (1fr, 1.45fr), column-gutter: 14pt, align: horizon,
    [
      En cas de conflit lors d'un *merge*, git suspend le merge et marque les
      conflits *directement dans les fichiers*.
    ],
    grid(
      columns: (1fr, 1.15fr), column-gutter: 10pt, align: horizon,
      grid(
        columns: 1, row-gutter: 8pt,
        _fichier-multiplication,
        align(center, _graphe-conflit(echelle: 0.85, extra: (pos, d) => {
          marque-conflit(d, pos("m"), texte: "")
        })),
        _fichier-addition,
      ),
      note-fichier("file.py")[
        #py-mot("def") #py-appel("fonction_1")\(a,b\):\
        #py-marque("<<<<<<< HEAD")\
        #h(1em) #py-mot("return") a+b\
        #py-marque("=======")\
        #h(1em) #py-mot("return") a\*b\
        #py-marque(">>>>>>> branche_1")
      ],
    ),
  )
]

#d("Conflits")[
  #grid(
    columns: (1fr, 1.45fr), column-gutter: 14pt, align: horizon,
    [
      Les conflits se résolvent directement dans les fichiers. Une fois les
      conflits résolus, `git add` marque chaque fichier, puis on reprend le
      merge avec la commande
      #code("git add <fichier>
git merge --continue

#Idem pour le rebase
git rebase --continue")
    ],
    grid(
      columns: (1fr, 1.1fr), column-gutter: 10pt, align: horizon,
      grid(
        columns: 1, row-gutter: 8pt,
        _fichier-multiplication,
        align(center, _graphe-conflit(echelle: 0.85)),
        _fichier-addition,
      ),
      note-fichier("file.py")[
        #py-mot("def") #py-appel("fonction_1")\(a,b\):\
        #h(1em) #py-mot("return") [a+b,a\*b]
      ],
    ),
  )

  #notes[
    Git s'arrête quand les deux branches modifient les mêmes lignes. Les
    marqueurs `<<<<<<<`, `=======` et `>>>>>>>` sont du texte ordinaire : les
    supprimer après avoir choisi. Oubli fréquent au TD 2d.
  ]
]
