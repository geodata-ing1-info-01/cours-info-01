// « Changer de branche change les fichiers » (diapo/parties/04_git.typ).
#import "_gabarit.typ": *
#import "_git.typ": *
#show: schema-de-cours

#face-a-face(
  panneau("Sur master")[
    #align(center, variante(tete: "c5"))
    #v(0.3em)
    #raw("$ python altitudes.py\n…\nmax - min : 3.4 m", block: true)
  ],
  panneau[Après `git checkout cumul`][
    #align(center, variante(tete: "c4"))
    #v(0.3em)
    #raw("$ python altitudes.py\n…\nmax - min : 3.4 m\ncumul en hausse : 2.6 m\ncumul en baisse : 3.4 m", block: true)
  ],
)
