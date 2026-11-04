// Ouverture du cours 3 — incluse par `cours3_v2.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#page-titre(
  titre: "Cours 3",
  sous-titre: "Version 2, proposition de travail",
  auteur: "1re année géomatique",
  date: "2027-2028",
)

// --------------------------------------------
// Revue le 04/11/2026 : la chaîne des trois cours, un tableau sans `subprocess`,
// avec les renvois de la version 2. « Contenu de la séance » et « Deux parcours »
// sont retirées.
#d("Objectifs de la séance")[
  #chaine(
    gabarit: bloc, pleins: (2,),
    ([Cours 1], [lancer un script Python]),
    ([Cours 2], [éditer le code]),
    ([Cours 3], [permettre à une autre personne d'utiliser ce code]),
  )

  #v(0.3em)
  #annonce[
    Manipuler des chemins et lire des fichiers en Python.\
    Construire un programme en ligne de commande en Python.
  ]

  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
    [Vu aux cours 1 et 2], [Aujourd'hui, en Python],
    [chemin relatif, chemin absolu], [`Path`, `/`, `resolve()`, `Path.cwd()`],
    [fichier texte], [`open(file_path, encoding="utf-8")`, `fichier.write(..)`],
    [disque et mémoire vive], [`f.read()`, du disque à la mémoire vive],
    [lancer un programme au terminal], [`argparse`, dans un programme qu'on écrit],
  )

  #notes[
    Les notions sont connues des cours précédent. 
    Ici on les revoit et on étudie comment les manipuler avec les fonctionnalités de la librairie standard Python.

    Séance 3, à annoncer à l'oral (relecture du 04/11/2026). L'exposé d'abord,
    puis trois TD, sur une trace GPS, dans VS Code. Chaque TD a son dossier dans
    l'archive `cours3/`. TD 3a, dénivelé d'une trace, 30 min ; TD 3b, chemins et
    paramètres, 30 min ; TD 3c, encodage et écriture, 20 min.

    Les TD du cours 3 de 2026, leurs notebooks et les deux parcours restent dans
    `src/cours3/`.
  ]
]
