// « Évolution de la puissance de calcul » (diapo/parties/02b_programme.typ) : le
// calcul pour l'AMD Ryzen 5 7530U, et la fréquence et le nombre de cœurs de 1990
// à 2024 (Karl Rupp, microprocessor-trend-data, CC BY 4.0).
#import "_gabarit.typ": *
#import "../../diapo/schemas.typ": graphe-frequence-coeurs
#import "../../../cours5/diapo/schemas.typ": _facteur
#show: schema-de-cours

#let _signe(s) = align(center, text(size: 22pt, fill: estompe)[#s])

#grid(
  columns: (4.4cm, 1fr), column-gutter: 18pt, align: horizon,
  stack(
    dir: ttb, spacing: 3pt,
    _facteur([2 · 10#super[9]], [cycles par seconde]),
    _signe[×],
    _facteur([6], [cœurs]),
    _signe[=],
    align(center)[
      #text(size: 22pt, weight: demi-gras, fill: accent)[12 · 10#super[9]]
      #linebreak()
      #text(size: 13pt, fill: estompe)[opérations par seconde]
    ],
  ),
  align(center, graphe-frequence-coeurs(largeur: 12.5, hauteur: 5.8)),
)
