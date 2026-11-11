// « Du code au programme : interpréteur » (diapo/parties/02b_programme.typ).
// Icônes des éditeurs : images/editeurs/CREDITS.md.
#import "_gabarit.typ": *
#show: schema-de-cours

#block(width: 100%, fill: accent.lighten(92%), inset: (x: 12pt, y: 10pt))[
  #text(size: 16pt, fill: accent, weight: demi-gras)[Interprété : Python]
  #v(0.4em)
  #chaine(
    gabarit: bloc, pleins: (1,),
    ([#text(size: 24pt)[`altitudes.py`]], [un fichier texte, en entrée]),
    ([#text(size: 24pt)[`python`]], [l'interpréteur, un programme en ligne de commande]),
    ([#text(size: 24pt)[`moyenne : 93.7 m`]], [le résultat, écrit dans le terminal]),
  )
  #v(0.2em)
  #show raw: set text(size: 1.15em)
  #grid(
    columns: (1fr, 26pt, 1fr, 26pt, 1fr), align: center + horizon,
    grid(
      columns: (auto, 1fr), column-gutter: 8pt, align: left + horizon,
      stack(
        dir: ltr, spacing: 5pt,
        image("/src/cours1_v2/images/editeurs/bloc_notes.svg", height: 30pt),
        image("/src/cours1_v2/images/editeurs/notepadpp.svg", height: 30pt),
      ),
      text(size: 14pt, fill: estompe)[écrit dans Notepad++ ou le Bloc-notes],
    ),
    [],
    text(size: 14pt, fill: estompe)[lancé dans Git Bash : \ `python altitudes.py`],
    [],
    text(size: 14pt, fill: estompe)[rien d'autre sur le disque],
  )
]
