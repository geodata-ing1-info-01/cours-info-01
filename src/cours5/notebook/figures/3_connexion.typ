// « La connexion à un site » (parties/03_prouver_qui_lon_est.typ) :
// `schema-connexion`, la table en clair.
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
  zoom: 100%,
)
