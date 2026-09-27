// Diapositive retirée du cours 2 v2 le 28/09/2026, à reprendre au cours 3 v2,
// où le README s'écrit (étape 4 du TD 3a). Ce fichier n'est inclus nulle
// part. Le bloc de code Markdown (trois accents graves), vu jusque-là sur la
// diapositive « Tableau, bloc de code et image » du cours 2 v2, y va aussi :
// il sert dans un README.
#import "../../../commun/prelude.typ": *

#d("Le README d'un projet")[
  #annonce[
    `README.md`, à la racine d'un projet, décrit ce qu'il fait et comment
    s'en servir. La forge l'affiche en page d'accueil du dépôt.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Section], [Son contenu],
    [le titre et une phrase], [ce que fait le projet],
    [Installation], [ce qu'il faut installer, et la commande],
    [Utilisation], [la commande qui le lance, et ce qu'elle produit],
    [Données], [où sont les données, et d'où elles viennent],
  )

  #legende[
    Le README de chaque projet du module suit ce plan : cours 3 (la recette),
    projet 4 (l'animation), projet 7 (`RAPPORT.md`).
  ]

  #notes[
    Le README s'écrit pour quelqu'un qui découvre le dossier : un camarade,
    un correcteur, soi-même dans six mois.

    La forge (cours 6) le convertit en page web, comme pandoc.
  ]
]
