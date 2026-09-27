// « Changer de branche change les fichiers » (diapo/parties/04_git.typ).
#import "_gabarit.typ": *
#import "_git.typ": *
#show: schema-de-cours

#face-a-face(
  panneau("Sur master")[
    #align(center, variante(tete: "c5"))
    #v(0.3em)
    #raw("| Farine | 250 g |", block: true)
  ],
  panneau[Après `git checkout sans-gluten`][
    #align(center, variante(tete: "c4"))
    #v(0.3em)
    #raw("| Farine de sarrasin | 250 g |", block: true)
  ],
)
