// « L'organisation des branches à plusieurs » (diapo/parties/04_git.typ).
#import "_gabarit.typ": *
#import "_git.typ": *
#show: schema-de-cours.with(largeur: auto)

#graphe-git(
  commits: (
    (nom: "c1", col: 0, voie: 0),
    (nom: "c2", col: 1, voie: 1, parents: ("c1",)),
    (nom: "c3", col: 2, voie: 2, parents: ("c2",)),
    (nom: "c4", col: 3, voie: 2, parents: ("c3",)),
    (nom: "c5", col: 2, voie: -1, parents: ("c2",), place: "dessous"),
    (nom: "c6", col: 4, voie: 1, parents: ("c2", "c4")),
    (nom: "c7", col: 4, voie: -1, parents: ("c5",), place: "dessous"),
    (nom: "c8", col: 5, voie: 1, parents: ("c6", "c7")),
    (nom: "c9", col: 6, voie: 0, parents: ("c1", "c8")),
  ),
  branches: (
    (nom: "master", voie: 0, commit: "c9"),
    (nom: "develop", voie: 1, commit: "c8"),
    (nom: "conseil", voie: 2, commit: "c4"),
    (nom: "sans-gluten", voie: -1, commit: "c7"),
  ),
  echelle: 1.1,
  taille-etiquette: 10pt,
)
