// « Quatre façons d'obtenir un mot de passe » (parties/03_prouver_qui_lon_est.typ) :
// `schema-connexion`, avec les quatre repères.
#import "_gabarit.typ": *
#import "../../diapo/schemas.typ": schema-connexion
#show: schema-de-cours.with(largeur: auto)

#schema-connexion(
  entetes: ("identifiant", "mot de passe"),
  lignes: (
    ("alice", "Marseille2024!"),
    ("bob", "123456"),
    ("chloé", "123456"),
  ),
  reperes: true,
  zoom: 100%,
)
