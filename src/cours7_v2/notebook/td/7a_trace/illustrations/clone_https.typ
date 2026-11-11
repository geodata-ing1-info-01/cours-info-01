// Le dépôt de l'élève, le menu Code ouvert sur l'onglet HTTPS. Schéma, pas une capture.
#import "../../../../../commun/prelude.typ": *
#import "../../../../../commun/schemas_github.typ": *
#set page(width: auto, height: auto, margin: 10pt, fill: white)
#set text(font: police-texte, size: 10pt, fill: accent, lang: "fr")
#block(width: 15cm, page-depot("alice-martin", "td7a-trace", fichiers: (".gitignore", "README.md", "stats_trace.py", "trace.csv", "trace_2.csv"), menu: menu-code("https://github.com/alice-martin/td7a-trace.git", repere: 2), reperes: (code: 1)))
