// TD 2b du cours 3 — « Images : texte et binaire », facultatif.
//
// Inclus par `cours3.typ`, entre les deux moitiés de la partie 2, qui porte
// les réglages globaux et importe `td` pour le sommaire des TD ; compilable
// seul par `outils/compiler_tds.py`. Un fichier inclus n'hérite pas des
// imports de son appelant.
//
// Ce fichier fait ouvrir `images.ipynb` : images PGM, formats, compression.
// ASCII et UTF-8, qui en formaient la section 1, sont passés dans
// `fichiers.ipynb` (section 4) le 25/09/2026.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "2b",
  titre: "Images : texte et binaire",
  annonce: "Facultatif, après la séance : ouvrir images.ipynb, une image en texte et en binaire",
  dossier: "cours3/2b_images/",
  duree: "10′",
)
#separateur-td(..td)

// --------------------------------------------
#d("Ouvrir le notebook des images")[
  #annonce[
    `images.ipynb` est facultatif. Il suppose connues les sections 3 à 6 de
    `fichiers.ipynb`.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [dans le panneau de gauche de JupyterLab, ouvrir `cours3/2b_images/images.ipynb`],
      reponse[un troisième onglet],
    [2], [exécuter les sections 1 à 5, une image en texte et en binaire],
      reponse[le PGM texte, plus de trois fois plus gros et plus lent à lire que le binaire],
  )

  #legende[
    Les fichiers créés par le notebook sont écrits dans `travail/`.
  ]

  #notes[
    Notebook livré à la racine du TD, `2b_images/images.ipynb` ; ses
    chemins partent de ce dossier (`depart/motif.pgm`).

    Les images sont libres : la Vague vient du Metropolitan Museum en CC0.
    `depart/CREDITS.md` le précise.
  ]
]
