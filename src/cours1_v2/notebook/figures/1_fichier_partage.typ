// « Modifications simultanées d'un fichier partagé » (diapo/parties/01b_fichier_partage.typ).
#import "_gabarit.typ": *
#show: schema-de-cours

#chaine(
  ("10 h 00", "Alice ouvre info01-salle.txt dans formationTemp"),
  ("10 h 02", "Bruno ouvre le même fichier"),
  ("10 h 10", "Alice ajoute son prénom et enregistre"),
  ("10 h 15", "Bruno ajoute le sien et enregistre : le prénom d'Alice a disparu"),
)
