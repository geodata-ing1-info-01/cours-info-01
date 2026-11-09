// « Le terminal et l'interpréteur de commandes » (diapo/parties/02_terminal.typ).
#import "_gabarit.typ": *
#import "../../diapo/schemas.typ": chaine-terminal, git-bash-ls, couleur-commande, couleur-sortie
#show: schema-de-cours

#grid(
  columns: (0.9fr, 1.45fr), column-gutter: 18pt, align: horizon,
  chaine-terminal(
    ("Ce qu'on tape", [#text(fill: couleur-commande, weight: 500)[ls depart], puis Entrée]),
    ("Le terminal", "la fenêtre, qui transmet la ligne"),
    ("L'interpréteur de commandes", "bash : découpe la ligne, lance ls"),
    ("Le programme ls", text(fill: couleur-sortie, weight: 500)[écrit la liste des fichiers]),
    ("L'interpréteur de commandes", "réaffiche l'invite, puis attend la ligne suivante"),
    plein: (2, 4),
  ),
  git-bash-ls(),
)
