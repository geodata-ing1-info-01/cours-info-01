// « La table avec des empreintes » (parties/03_prouver_qui_lon_est.typ) :
// `schema-connexion`, la table des empreintes SHA-256.
#import "_gabarit.typ": *
#import "../../diapo/schemas.typ": schema-connexion
#show: schema-de-cours.with(largeur: auto)

#schema-connexion(
  entetes: ("identifiant", "empreinte du mot de passe"),
  lignes: (
    ("alice", "2aa0358d8394e784…"),
    ("bob", "8d969eef6ecad3c2…"),
    ("chloé", "8d969eef6ecad3c2…"),
  ),
  calcul: "SHA-256", zoom: 100%,
)
