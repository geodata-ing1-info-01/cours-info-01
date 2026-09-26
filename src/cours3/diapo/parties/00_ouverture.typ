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
    La séance comprend deux notebooks autonomes, puis l'écriture d'un script dans l'éditeur.
    Chaque TD a son dossier dans l'archive `cours3/`.
  ]

  #tableau(
    columns: (auto, auto, 1fr, auto),
    align: (left + horizon, left + horizon, left + horizon, center + horizon),
    [Partie], [Fichier], [Contenu], [Durée],
    [Préparation du poste de travail], [TD 0a], [récupérer l'archive, lancer JupyterLab], [10 min],
    [Environnement (selon les groupes)], [TD 0a], [`info01-cours3` : pandoc, Pillow], [+15 min],
    [Chemins et programmes externes], [`recette.ipynb`], [`pathlib` ; pandoc lancé par `subprocess`], [20 min],
    [Fichiers texte et encodage], [`fichiers.ipynb`], [lire et écrire un fichier ; ASCII et UTF-8], [30 min],
    [Ligne de commande], [`recette.py`], [`main`, `argparse` ; un commit par étape], [45 min],
  )

  #notes[
    Chaque partie commence par quelques diapositives (le programme, ses améliorations, les bibliothèques), puis travail autonome sur le notebook : un texte explicatif par section, une réponse repliée sous chaque ligne à compléter.
    Le cartouche « § n » d'une diapositive renvoie à la section du notebook qui la reprend.
    `images.ipynb` (PGM, formats d'image, compression) est facultatif.
    La dernière partie est le TD 3a seul : le passage en script, `main` et `argparse` sont présentés dans la partie 1.
  ]
]
