// « Les copies d'un dépôt » (diapo/parties/04_git.typ).
#import "_gabarit.typ": *
#import "_git.typ": *
#show: schema-de-cours.with(largeur: auto)

#grid(
  columns: 5, column-gutter: 6pt, row-gutter: 4pt, align: center + horizon,
  [], [], machine("Forge, au cours 6", historique), double-fleche(),
  machine("Ordinateur personnel", historique),
  [], [], double-fleche(vertical: true), [], double-fleche(vertical: true),
  machine("Dépôt d'un camarade", historique), double-fleche(),
  machine("Poste de la salle", historique, plein: true), double-fleche(),
  machine("Clé USB", historique),
)
