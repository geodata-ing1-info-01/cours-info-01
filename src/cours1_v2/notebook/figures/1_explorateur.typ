// « Stockage : fichier, extension et type » (diapo/parties/01_logiciels_stockage.typ) :
// l'explorateur ouvert sur le dossier Documents, à gauche de la diapositive.
#import "_gabarit.typ": *
#import "../../diapo/schemas.typ": explorateur
#show: schema-de-cours.with(largeur: 12cm)

// Sans cet espacement, le corps de `fenetre` commence par une ligne vide.
#set block(spacing: 0pt)
#explorateur(
  [C:\\Users\\alice\\Documents],
  ("altitudes.py", "carte.png", "raven.odt", "releve_2026.csv"),
  choisi: 3,
)
