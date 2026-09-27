// « Un conflit de fusion » (diapo/parties/04_git.typ).
#import "_gabarit.typ": *
#import "_git.typ": *
#show: schema-de-cours.with(largeur: auto)

#graphe-git(
  commits: (
    (nom: "c6", col: 0, voie: 0, id: "eda"),
    (nom: "c8", col: 1, voie: 0, id: "b6b", parents: ("c6",)),
    (nom: "c7", col: 1, voie: 1, id: "c50", parents: ("c6",)),
  ),
  branches: (
    (nom: "master", voie: 0, commit: "c8"),
    (nom: "pour-18", voie: 1, commit: "c7"),
  ),
  echelle: 1.3,
  taille-etiquette: 10pt,
  extra: (pos, d) => {
    let cible = (2 * 1.75, 0.0)
    let tiret = (paint: rouge-attention, thickness: 1pt, dash: "dashed")
    d.line((pos("c8").at(0) + 0.5, 0.0), (cible.at(0) - 0.3, 0.0), stroke: tiret)
    d.line((pos("c7").at(0) + 0.45, pos("c7").at(1) - 0.2), (cible.at(0) - 0.25, 0.2), stroke: tiret)
    marque-conflit(d, cible)
  },
)
