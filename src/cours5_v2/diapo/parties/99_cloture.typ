// Clôture du cours 5 v2 — incluse en dernier par `cours5_v2.typ`. Un fichier inclus
// n'hérite pas des imports de son appelant.
//
// Remplace « Au cours 6 : compte GitHub et clé SSH » (05/11/2026) : les mots de passe et
// les clés passent au cours 6.
#import "../../../commun/prelude.typ": *

#d("À retenir")[
  #show table.cell: set text(size: 14.5pt)
  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [Une dépendance externe], [un programme ou une bibliothèque que le code ne contient pas, à réinstaller sur chaque poste],
    [`subprocess.run`], [lance un programme externe ; la commande est une liste, un élément par mot],
    [Un environnement], [un dossier par projet, avec son Python et ses paquets ; `environment.yml` le décrit],
    [`sys.path`], [les dossiers où Python cherche une bibliothèque ; l'interpréteur lancé les détermine],
    [`PATH`], [les dossiers où chercher une commande ; `conda activate` y place l'environnement en tête],
    [`export`], [transmet une variable aux programmes lancés ensuite],
    [`pyproject.toml`], [le nom, la version et les bibliothèques Python du projet ; `pip install .` lit ce fichier],
    [Le noyau], [l'interpréteur qui exécute un notebook ; `kernel.json` donne son chemin],
  )

  #notes[
    Le cours 6 reprend la distribution du code par une forge, et l'accès à ce code.
  ]
]
