// Le graphe git des étapes B1 à B4 du TD 4c : les branches `fenetre` et
// `plan`, parties du même commit, avant et après leur fusion dans `master`.
// Compilé en PNG par `outils/compiler_guides.py`.
#import "../../../../../commun/schemas_git.typ": graphe-git
#import "../../../../../commun/theme.typ": accent, estompe, police-texte, demi-gras
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#set text(font: police-texte, lang: "fr")

#let tronc = (
  (nom: "c1", col: 0, voie: 0),
  (nom: "c2", col: 1, voie: 0, parents: ("c1",)),
)
#let plan = (
  (nom: "c4", col: 2, voie: -1, parents: ("c2",), place: "dessous"),
  (nom: "c5", col: 3, voie: -1, parents: ("c4",), place: "dessous"),
  (nom: "c6", col: 4, voie: -1, parents: ("c5",), place: "dessous"),
)
#let titre(t) = text(size: 12pt, weight: demi-gras, fill: accent)[#t]

#grid(
  columns: 2, column-gutter: 1.2cm, row-gutter: 0.35cm,
  titre[Après B3 : deux branches parties de `c2`],
  titre[Après B4 : `git merge fenetre`, puis `git merge plan`],
  graphe-git(
    commits: tronc + ((nom: "c3", col: 2, voie: 1, parents: ("c2",)),) + plan,
    branches: (
      (nom: "master", voie: 0, commit: "c2"),
      (nom: "fenetre", voie: 1, commit: "c3"),
      (nom: "plan", voie: -1, commit: "c6"),
    ),
    taille-etiquette: 10pt, echelle: 0.8,
  ),
  graphe-git(
    commits: tronc + ((nom: "c3", col: 2, voie: 0, parents: ("c2",), place: "dessus"),) + plan
      + ((nom: "c7", col: 5, voie: 0, parents: ("c3", "c6"), place: "dessus"),),
    branches: (
      (nom: "master", voie: 0, commit: "c7"),
      (nom: "plan", voie: -1, commit: "c6"),
    ),
    taille-etiquette: 10pt, echelle: 0.8,
  ),
)
#v(0.2cm)
#block(width: 18cm, text(size: 10pt, fill: estompe)[
  `c3` porte la fenêtre, `c4` à `c6` le plan. `git merge fenetre` est une
  avance rapide : `master` passe sur `c3`. `git merge plan` réunit deux
  modifications de `train.py` faites à partir de `c2` : il crée le commit de
  fusion `c7`, qui a deux parents, `c3` et `c6`, après la résolution du
  conflit.
])
