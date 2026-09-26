// TD 2a du cours 3 — « Lire et écrire des fichiers texte ».
//
// Inclus par `cours3.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`. Un
// fichier inclus n'hérite pas des imports de son appelant.
//
// Comme le TD 1a, ce fichier ouvre le notebook que la première moitié de la
// partie 2 vient de présenter : `fichiers.ipynb`, dont les sections suivent
// les diapositives de la partie. Le TD 2b, facultatif, ouvre `images.ipynb`.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "2a",
  titre: "Lire et écrire des fichiers texte",
  annonce: "Ouvrir fichiers.ipynb ; chaque section du notebook explique ce qu'elle fait",
  dossier: "cours3/2a_fichiers/",
  duree: "15′",
)
// Dans le cours, l'ouverture est commune à la partie (`separateur-cours-td`,
// dans `cours3.typ`) ; seule la feuille de TD remet celle-ci.
#if feuille-seule { separateur-td(..td) }

#d("Ouvrir le notebook des fichiers")[
  #annonce[
    Les fonctions utiles de `recette.ipynb` ouvrent, lisent et écrivent des
    fichiers sans que ces lignes aient été expliquées. `fichiers.ipynb`
    reprend le code dans son dernier état et explique ces lignes. Il est
    dans le dossier `cours3/2a_fichiers/`, avec une copie des recettes.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [dans l'explorateur, copier `2a_fichiers/depart/notebook/fichiers.ipynb` dans `2a_fichiers/travail/`],
      reponse[`2a_fichiers/travail/fichiers.ipynb`],
    [2], [dans le panneau de gauche de JupyterLab, double-cliquer dessus],
      reponse[un second onglet, à côté du premier],
    [3], [exécuter la section 0],
      reponse[`True True` : les chemins de la section 3.3, retrouvés],
    [4], [exécuter les sections 1 à 9 ; les sections 10 et 11 se font après la séance],
      reponse[« Ãª » lu en `cp1252` ; `b'\xc3\xaa'` en mode binaire ; `essai.txt` écrit, complété, remplacé],
  )

  #legende[
    `recette.ipynb` peut rester ouvert. Le notebook des images, dans
    `2b_images/`, est facultatif.
  ]

  #notes[
    La section 0 déclare les mêmes variables qu'à la section 3.3 de
    `recette.ipynb`, à partir de `Path.cwd()` ; rien à recopier. Le notebook
    doit être dans `travail/`, comme le premier : ouvert depuis
    `depart/notebook/`, `RACINE` désignerait `depart/`.
  ]
]
