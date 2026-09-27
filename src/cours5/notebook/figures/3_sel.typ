// « Le sel » (parties/03_prouver_qui_lon_est.typ) : `schema-connexion`, la
// table avec un sel par compte.
#import "_gabarit.typ": *
#import "../../diapo/schemas.typ": schema-connexion
#show: schema-de-cours.with(largeur: auto)

#schema-connexion(
  entetes: ("identifiant", "sel", "empreinte de sel + mot de passe"),
  lignes: (
    ("alice", "7f3a9c", "8a7fb679f0999b58…"),
    ("bob", "b21e04", "fe80f1e0ed9d164d…"),
    ("chloé", "e5d1f8", "f63e6f06896874c6…"),
  ),
  calcul: "SHA-256", zoom: 100%,
)
