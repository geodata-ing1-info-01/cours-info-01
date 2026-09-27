// « Le terminal et l'interpréteur de commandes » (diapo/parties/02_terminal.typ).
#import "_gabarit.typ": *
#import "../../diapo/schemas.typ": chaine-terminal, git-bash-ls
#show: schema-de-cours

#grid(
  columns: (0.9fr, 1.45fr), column-gutter: 18pt, align: horizon,
  chaine-terminal(
    ("Ce qu'on tape", "ls depart, puis Entrée"),
    ("Le terminal", "la fenêtre, qui transmet la ligne"),
    ("L'interpréteur de commandes", "bash : découpe la ligne, lance ls"),
    ("Le programme ls", "écrit la liste des fichiers"),
    plein: 2,
  ),
  git-bash-ls(),
)
