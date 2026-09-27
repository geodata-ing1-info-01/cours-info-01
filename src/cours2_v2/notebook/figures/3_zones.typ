// « Trois zones : dossier, index, dépôt » (diapo/parties/04_git.typ).
#import "_gabarit.typ": *
#show: schema-de-cours

#grid(
  columns: (1fr, auto, 1fr, auto, 1fr), column-gutter: 8pt, align: horizon,
  bloc("Dossier de travail", "les fichiers tels qu'on les modifie", hauteur: 90pt),
  align(center)[#text(size: 15pt, font: police-code)[git add] \ #text(size: 26pt, fill: accent)[→]],
  bloc("Index", "ce qui entrera dans le prochain commit", hauteur: 90pt),
  align(center)[#text(size: 15pt, font: police-code)[git commit] \ #text(size: 26pt, fill: accent)[→]],
  bloc("Dépôt", "l'historique des commits, dans .git", plein: true, hauteur: 90pt),
)
