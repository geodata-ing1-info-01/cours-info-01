// « Les composants d'un ordinateur » (diapo/parties/01_logiciels_stockage.typ) : la photo
// du boîtier ouvert et ses six repères, aux positions de la diapositive.
#import "_gabarit.typ": *
#import "../../../cours5/diapo/schemas.typ": photo-reperee
#show: schema-de-cours.with(largeur: auto)

#photo-reperee("/illustrations/cours5/boitier_ouvert.jpg", 1400 / 1275, (
  (0.34, 0.50), (0.47, 0.42), (0.62, 0.53),
  (0.30, 0.66), (0.185, 0.58), (0.23, 0.21),
), hauteur: 360pt)
