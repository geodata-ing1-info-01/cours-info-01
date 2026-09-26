// Ouverture du cours 3 — incluse par `cours3.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#page-titre(
  titre: "Cours 3",
  sous-titre: "Chemins, fichiers et ligne de commande, en Python",
  auteur: "1re année géomatique",
  date: "29 septembre 2026",
)

// --------------------------------------------
#d("Objectifs de la séance")[
  #annonce[
    Manipuler des chemins et lire des fichiers en Python.\
    Construire un programme en ligne de commande en Python.\ 
    Revoir les notions des cours 1 et 2 côté code Python.
  ]

  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
    [Vu aux cours 1 et 2], [Aujourd'hui, en Python],
    [chemin relatif, chemin absolu ], [`Path`, `/`, `resolve()`, `Path(__file__)`],
    [fichier texte, encodage (cours 1)], [`open(file_path, encoding="utf-8")`, `fichier.write(..)`],
    [caractères et octets (cours 1)], [`encode("utf-8")`, ASCII et UTF-8],
    [lancer un programme au terminal (cours 2)], [`subprocess.run([...])`,  avec pandoc  md -> html],
    [Ecrire une ligne de commande], [`argparse`, dans un programme qu'on écrit],
  )

  #notes[
    Les notions sont connues des cours précédent. 
    Ici on les revoit et on étudie comment les manipuler avec les fonctionnalités de la librairie standard Python.
  ]
]

// --------------------------------------------
#d("Contenu de la séance")[
  #annonce[
    La séance comprend deux notebooks autonomes, puis, au choix, un script
    écrit dans l'éditeur ou une recette écrite en Markdown. Chaque TD a son
    dossier dans l'archive `cours3/`.
  ]

  #tableau(
    columns: (auto, auto, 1fr, auto),
    align: (left + horizon, left + horizon, left + horizon, center + horizon),
    [Partie], [Fichier], [Contenu], [Durée],
    [Préparation du poste de travail], [TD 0a], [récupérer l'archive, lancer JupyterLab], [10 min],
    [Environnement (selon les groupes)], [TD 0a], [`info01-cours3` : pandoc, Pillow], [+15 min],
    [Chemins et programmes externes], [`recette.ipynb`], [`pathlib` ; pandoc lancé par `subprocess`], [20 min],
    [Fichiers texte et encodage], [`fichiers.ipynb`], [lire et écrire un fichier ; ASCII et UTF-8], [30 min],
    [Au choix : ligne de commande], [TD 3a], [`recette.py`, `main`, `argparse`], [45 min],
    [ou Markdown], [TD 3b], [une recette, sa page, un dépôt], [45 min],
  )

  #notes[
    Chaque partie commence par quelques diapositives (le programme, ses améliorations, les bibliothèques), puis travail autonome sur le notebook : un texte explicatif par section, une réponse repliée sous chaque ligne à compléter.
    Le cartouche « § n » d'une diapositive renvoie à la section du notebook qui la reprend.
    `images.ipynb` (PGM, formats d'image, compression) est facultatif.
    La dernière partie est un TD au choix, 3a ou 3b : le passage en script, `main` et `argparse` sont présentés dans la partie 1.
  ]
]

// --------------------------------------------
#d("Deux parcours")[
  #annonce[
    Les deux notebooks sont communs. Pour la dernière partie, chaque élève
    choisit l'un des deux parcours.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Parcours standard], [Parcours avancé],
    [Tronc commun], table.cell(colspan: 2)[TD 0a ; `recette.ipynb` (TD 1a) ; `fichiers.ipynb`, sections 1 à 9 (TD 2a)],
    [Dernière partie], [TD 3b : la recette des gaufres en Markdown, sa page produite par le programme du TD 1a, un dépôt git], [TD 3a : le programme `recette.py`, lancé depuis le terminal, un commit par étape],
    [En plus, si le temps le permet], [finir les notebooks], [`images.ipynb` ; `fichiers.ipynb`, section 12],
  )

  #legende[
    Conseil : le parcours avancé si `fichiers.ipynb` est terminé jusqu'à la
    section 9 à la fin de la partie 2. Le TD 3a est repris au projet 4 par
    le parcours standard.
  ]

  #notes[
    Le TD 3b reprend le TD Markdown du cours 1, que beaucoup n'ont pas fini,
    sur une nouvelle recette.
  ]
]
