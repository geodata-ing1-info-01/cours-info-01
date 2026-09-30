// « Enregistrer une version : add, puis commit » (diapo/parties/04_git.typ) :
// les deux premiers commits du TD 2d.
#import "_gabarit.typ": *
#import "_git.typ": *
#show: schema-de-cours.with(largeur: auto)

#graphe-git(
  commits: (
    (nom: "c1", col: 0, voie: 0, id: "a16"),
    (nom: "c2", col: 1, voie: 0, id: "fe4", parents: ("c1",)),
  ),
  branches: ((nom: "master", voie: 0, commit: "c2"),),
  echelle: 1.4,
  taille-etiquette: 10pt,
  extra: (pos, d) => marque-tete(d, pos("c2"), dx: 0.8, dy: 0.8),
)
