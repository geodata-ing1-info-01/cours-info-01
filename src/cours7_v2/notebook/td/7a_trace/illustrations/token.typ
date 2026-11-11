// Le formulaire du token classique, puis le token généré. Schéma, pas une capture.
#import "../../../../../commun/prelude.typ": *
#import "../../../../../commun/schemas_github.typ": *
#set page(width: auto, height: auto, margin: 10pt, fill: white)
#set text(font: police-texte, size: 10pt, fill: accent, lang: "fr")
#block(width: 17cm, grid(columns: (1fr, 1fr), column-gutter: 10pt, formulaire-token(reperes: (note: 1, expiration: 2, repo: 3, generer: 4)), token-genere(repere: 5)))
