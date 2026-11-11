// « Du code au programme : compilation puis exécution »
// (diapo/parties/02b_programme.typ).
#import "_gabarit.typ": *
#show: schema-de-cours

#block(width: 100%, fill: gris, inset: (x: 12pt, y: 10pt))[
  #text(size: 16pt, fill: estompe, weight: demi-gras)[Compilé : C, C++]
  #v(0.4em)
  #chaine(
    ("altitudes.cpp", "le texte écrit"),
    ("le compilateur", "une fois, après chaque modification"),
    ("altitudes.exe", "des instructions machine"),
    ("le résultat", "à chaque lancement"),
  )
]
