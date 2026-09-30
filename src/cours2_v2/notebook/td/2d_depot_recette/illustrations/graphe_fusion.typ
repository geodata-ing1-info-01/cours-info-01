// Le graphe de l'étape 5 du TD 2d : la branche `sans-gluten`, avant et après
// sa fusion dans `master`. Identifiants du rejeu (rejeu/sortie.txt).
#import "../../../../../commun/schemas_git.typ": graphe-git
#import "../../../../../commun/theme.typ": accent, estompe, demi-gras, police-texte
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#set text(font: police-texte, lang: "fr")
#let base = (
  (nom: "c4", col: 0, voie: 0, id: "28c"),
  (nom: "c5", col: 1, voie: 1, id: "939", parents: ("c4",)),
  (nom: "c6", col: 1, voie: 0, id: "220", parents: ("c4",), place: "dessous"),
)
#let fusion = (nom: "c7", col: 2, voie: 0, id: "eda", parents: ("c6", "c5"))
#let titre(t) = text(size: 12pt, weight: demi-gras, fill: accent)[#t]
#grid(
  columns: 2, column-gutter: 1.4cm, row-gutter: 0.35cm,
  titre[Avant `git merge` : un commit sur chaque branche],
  titre[Après `git merge sans-gluten`],
  graphe-git(commits: base, branches: (
    (nom: "master", voie: 0, commit: "c6"),
    (nom: "sans-gluten", voie: 1, commit: "c5"),
  ), taille-etiquette: 10pt, echelle: 0.9),
  graphe-git(commits: base + (fusion,), branches: (
    (nom: "master", voie: 0, commit: "c7"),
    (nom: "sans-gluten", voie: 1, commit: "c5"),
  ), taille-etiquette: 10pt, echelle: 0.9),
)
#v(0.2cm)
#block(width: 16cm, text(size: 10pt, fill: estompe)[
  Dans chaque pastille, le début de l'identifiant du commit. `28c` : « Ignore
  les fichiers produits par pandoc » ; `939` : la farine de sarrasin, sur
  `sans-gluten` ; `220` : le conseil, sur `master` ; `eda` : le commit de
  fusion, qui a deux parents (double trait). Les identifiants diffèrent sur
  chaque poste.
])
