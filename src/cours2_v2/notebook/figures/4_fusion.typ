// « Fusionner : git merge » (diapo/parties/04_git.typ) : avance rapide et
// commit de fusion.
#import "_gabarit.typ": *
#import "_git.typ": *
#show: schema-de-cours

#face-a-face(
  panneau("Seule cumul a avancé")[
    #align(center, graphe-git(
      commits: (
        (nom: "c3", col: 0, voie: 0, id: "ccd"),
        (nom: "c4", col: 1, voie: 0, id: "e0e", parents: ("c3",), place: "dessus"),
      ),
      branches: ((nom: "master", voie: 0, commit: "c4"),),
      echelle: 1.1,
      taille-etiquette: 10pt,
      extra: (pos, d) => cartouche(d, pos("c4"), "cumul", brun),
    ))
  ],
  panneau("Les deux branches ont avancé")[
    #align(center, graphe-git(
      commits: (
        (nom: "c3", col: 0, voie: 0, id: "ccd"),
        (nom: "c5", col: 1, voie: 0, id: "f42", parents: ("c3",)),
        (nom: "c4", col: 1, voie: 1, id: "e0e", parents: ("c3",)),
        (nom: "c6", col: 2, voie: 0, id: "5e6", parents: ("c5", "c4")),
      ),
      branches: (
        (nom: "master", voie: 0, commit: "c6"),
        (nom: "cumul", voie: 1, commit: "c4"),
      ),
      echelle: 1.1,
      taille-etiquette: 10pt,
    ))
  ],
)
