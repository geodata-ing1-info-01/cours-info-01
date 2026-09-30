// TD 1d du cours 1 v2 — « Un notebook dans JupyterLab ».
//
// Le TD 1g de 2026, réduit à JupyterLab, avec une cellule de texte à écrire.
// Le notebook, `altitudes.ipynb`, est construit depuis
// `src/cours1_v2/notebook/td/1d_notebook/altitudes.md` par
// `outils/construire_notebooks.py`.
//
// Inclus par `cours1_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 1_v2`.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "1d",
  titre: "Un notebook dans JupyterLab",
  annonce: "Objectif : exécuter un notebook dans JupyterLab, voir ce que le noyau retient d'une cellule à l'autre, et documenter le notebook en Markdown",
  dossier: "cours1/1d_notebook/",
  duree: "12′",
)
#separateur-td(..td)

#d("Exécuter les cellules")[
  #annonce[
    `altitudes.ipynb` est le programme du TD 1c, découpé en cellules. Une
    cellule s'exécute par `Maj` + `Entrée`.
  ]

  #tableau(
    columns: (auto, 1.2fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [invite de commandes d'Anaconda, `cd Desktop\info01\cours1\1d_notebook`, `jupyter lab` ; ouvrir `altitudes.ipynb`],
      reponse[les cellules de code n'ont pas encore de numéro],
    [2], [exécuter les cellules une à une, de haut en bas],
      reponse[`[1]`, `[2]`… à gauche, dans l'ordre ; la moyenne vaut `129.0`],
    [3], [exécuter une seconde fois la cellule de la boucle, puis celle de la moyenne],
      reponse[`258.0` : le noyau a gardé `total`, la boucle l'a encore augmenté],
    [4], [Kernel #sym.arrow.r Restart Kernel and Run All Cells],
      reponse[les numéros repartent de `[1]`, la moyenne revient à `129.0`],
  )

  #legende[
    Le numéro entre crochets donne l'ordre dans lequel les cellules ont été
    exécutées.
  ]

  #notes[
    Étape 3 : `total` passe de 387,0 à 774,0, et la moyenne à 258,0. Le
    notebook sépare `total = 0` de la boucle pour que ce soit visible (le
    notebook du TD 1g de 2026 remettait `total` à zéro dans la même cellule,
    et la relance ne changeait rien).

    En français, si JupyterLab l'est sur les postes : Noyau, Redémarrer le
    noyau et exécuter toutes les cellules.
  ]
]

#d("Ajouter une cellule de texte")[
  #annonce[
    Une cellule de texte en tête du notebook, écrite en Markdown, décrit ce
    que fait le programme.
  ]

  #tableau(
    columns: (auto, 1.2fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [cliquer sur la première cellule, touche `Échap`, puis `A`],
      reponse[une cellule vide apparaît au-dessus],
    [2], [touche `M`, ou « Markdown » dans la liste en haut de la page],
      reponse[le `[ ]` disparaît : une cellule de texte n'a pas de numéro],
    [3], [y écrire un titre, une phrase, la liste des données, un lien],
      reponse[le texte reste brut tant qu'on l'édite],
    [4], [`Maj` + `Entrée` ; double-clic pour revenir au texte],
      reponse[titre, liste et lien mis en forme],
    [5], [`Ctrl` + `S`], reponse[le notebook est enregistré],
    [6], [si le temps le permet : `Ctrl` + `C` dans l'invite, puis `jupyter lab` depuis Git Bash],
      reponse[le notebook rouvert garde la cellule de texte],
  )

  #legende[
    La syntaxe : diapositive « La syntaxe minimale de Markdown ».
  ]

  #notes[
    Exemple à ne projeter qu'en fin de TD :
    `# Moyenne des altitudes`, une ligne vide, `Calcule la moyenne de trois
    altitudes, en mètres.`, puis `- 128.4`, `- 131.0`, `- 127.6`, puis
    `[Jupyter](https://jupyter.org)`.

    `A` insère au-dessus, `B` au-dessous, en mode commande (`Échap`).
  ]
]
