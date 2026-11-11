// Après le push : le bandeau de la page du dépôt, puis la page de la pull request. Schéma, pas une capture.
#import "../../../../../commun/prelude.typ": *
#import "../../../../../commun/schemas_github.typ": *
#set page(width: auto, height: auto, margin: 10pt, fill: white)
#set text(font: police-texte, size: 10pt, fill: accent, lang: "fr")
#block(width: 15cm, stack(spacing: 8pt, bandeau-pr("alice-martin", "td7a-trace", "profil", repere: 1), page-pr("alice-martin", "td7a-trace", "Profil", "profil", reperes: (fusion: 2, confirmer: 3))))
