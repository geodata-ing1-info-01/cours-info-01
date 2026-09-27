// « Les systèmes de version » (diapo/parties/04_git.typ). Les deux panneaux
// l'un sous l'autre, pour rester lisibles dans la colonne de la page.
#import "_gabarit.typ": *
#import "_git.typ": *
#show: schema-de-cours.with(largeur: 15cm)

#panneau("Centralisé : CVS (1986), Subversion (2000)")[
  #align(center)[
    #machine("Serveur", historique, plein: true)
    #v(0.2em)
    #grid(
      columns: 3, column-gutter: 12pt,
      ..range(1, 4).map(i => stack(
        dir: ttb, spacing: 3pt,
        double-fleche(vertical: true),
        machine("Poste " + str(i), une-version),
      )),
    )
  ]
]
#v(0.8em)
#panneau("Distribué : git, Mercurial (2005)")[
  #align(center, grid(
    columns: 5, column-gutter: 4pt, align: horizon,
    machine("Poste 1", historique), double-fleche(),
    machine("Poste 2", historique), double-fleche(),
    machine("Clé USB", historique),
  ))
]
