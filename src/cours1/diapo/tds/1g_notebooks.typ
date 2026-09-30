// TD 1g — « Le notebook, ouvert de trois façons ».
//
// Inclus par `cours1.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`, qui
// en tire la feuille de TD déposée dans le dossier annoncé. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "1g",
  titre: "Le notebook, ouvert de trois façons",
  annonce: "Objectif : ouvrir le même notebook de trois façons sans rien configurer, et voir ce que le noyau retient d'une cellule à l'autre",
  dossier: "cours1/1g_notebooks/",
  duree: "12′",
)
#separateur-td(..td)
#d("Ouvrir le même notebook, trois fois")[
  #annonce[
    `altitudes.ipynb` est le programme du TD 1c, découpé en cellules. Trois
    façons de l'ouvrir, et aucune ne demande de créer quoi que ce soit.
  ]

  #tableau(
    columns: (auto, 1.2fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [Dans le navigateur],
      [ouvrir #link("https://jupyter.org/try-jupyter/lab/")[jupyter.org/try-jupyter], y déposer le fichier],
      reponse[aucun compte, aucune installation, le calcul se fait chez vous],
    [Dans l'éditeur],
      [ouvrir le `.ipynb`, installer l'extension proposée, prendre l'interpréteur d'Anaconda],
      reponse[les cellules s'exécutent par `Maj` + `Entrée`],
    [Depuis Anaconda],
      [page d'accueil de Navigator, fiche JupyterLab #sym.arrow.r Launch],
      reponse[un onglet de navigateur, et le fichier dans l'arborescence],
  )

  #legende[
    L'extension proposée par l'éditeur est `ms-toolsai.jupyter`. Ce qu'il
    appelle « noyau » est l'interpréteur qui exécute les cellules : prendre
    celui d'Anaconda, le reste est au TD 1i.
  ]

  #notes[
    Aucune des trois ne demande de créer un environnement, et c'est ce qui
    permet de les faire ici : les postes de la salle ont la distribution
    Anaconda, qui pose JupyterLab et `ipykernel` dans `base`. Sur un portable
    personnel installé avec Miniforge, rien de tout cela n'est là — c'est le
    premier constat du TD 1i, et il vaut mieux l'annoncer que le découvrir
    au fond de la salle.

    Si le réseau de la salle est mauvais, sauter la première ligne et la
    montrer au tableau ; le premier chargement dans le navigateur prend une
    dizaine de secondes.

    Ne pas expliquer le mot « noyau » ici. VSCode demande de choisir, ils
    prennent celui d'Anaconda, et on passe. Qu'il y ait un choix à faire est
    justement ce que le TD 1i explique.

    L'extension Jupyter est la troisième et dernière du module, après
    `ms-python.python` au TD 1c et `ms-vscode.cpptools` au TD 1e. VSCode la
    propose de lui-même à l'ouverture du premier `.ipynb` ; si la
    proposition ne vient pas, panneau Extensions et l'identifiant en toutes
    lettres.

    VSCode demande aussi `ipykernel` dans l'environnement choisi, sa
    documentation est explicite là-dessus : « Only the IPyKernel package is
    required to launch a Python process as a kernel ». Il est dans le `base`
    d'Anaconda, donc rien à installer ici ; sur un environnement qui ne l'a
    pas, l'éditeur propose de l'ajouter, et c'est ce que le TD 1i fait
    constater.

    Le contenu du notebook n'est pas neuf : c'est `altitudes.py`, dont ils
    ont suivi la boucle au débogueur. Ce qui change est que le noyau retient
    `total` entre deux cellules, et la dernière section le fait constater en
    relançant la somme une seconde fois. Ne pas sauter cette section : c'est
    la seule chose que ce TD apprend et que les précédents n'ont pas dite.

    Le fichier source est en MyST, donc du texte, donc comparable ligne à
    ligne : « Deux formats de notebook » vérifié sur le support qu'ils ont
    sous les yeux.

    Dans le navigateur, les bibliothèques publiées s'installent par une
    cellule `%pip install`, la documentation de JupyterLite le prévoit. Ce
    qui ne marche pas est tout ce qui demande un processus au système :
    ni `subprocess`, ni ffmpeg, ni ImageMagick. Le dire si quelqu'un essaie.
  ]
]
