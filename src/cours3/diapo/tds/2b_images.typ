// TD 2b du cours 3 — « ASCII et UTF-8 ».
//
// Inclus par `cours3.typ`, entre les deux moitiés de la partie 2, qui porte
// les réglages globaux et importe `td` pour le sommaire des TD ; compilable
// seul par `outils/compiler_tds.py`. Un fichier inclus n'hérite pas des
// imports de son appelant.
//
// Ce fichier fait ouvrir `images.ipynb`, dont la section 1 accompagne les
// diapositives de `parties/02b_encodage.typ`. Les sections 2 à 6 (images
// PGM, formats, compression) sont facultatives : le dossier du TD garde son
// nom, `2b_images/`.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "2b",
  titre: "ASCII et UTF-8",
  annonce: "Ouvrir images.ipynb ; la section 1 se fait en séance, les sections sur les images sont facultatives",
  dossier: "cours3/2b_images/",
  duree: "10′",
)
#separateur-td(..td)

// --------------------------------------------
#d("Ouvrir le notebook des caractères et des images")[
  #annonce[
    La section 1 d'`images.ipynb`, sur les caractères, se fait en séance.
    Les sections 2 à 6, sur les images, sont facultatives.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [dans le panneau de gauche de JupyterLab, ouvrir `cours3/2b_images/images.ipynb`],
      reponse[un troisième onglet],
    [2], [exécuter la section 1, ASCII et UTF-8 ; compléter la ligne marquée],
      reponse[`é`, `œ` : deux octets ; `😀` : quatre ; « Plœuc » : un octet de plus que de caractères],
    [3], [après la séance, si vous le souhaitez : les sections 2 à 6, une image en texte et en binaire],
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
