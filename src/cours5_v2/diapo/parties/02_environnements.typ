// Cours 5 v2, partie 2 : bibliothèques et environnements Python. Incluse par
// `cours5_v2.typ`.
//
// Repris le 05/11/2026 de la partie 4 du cours 1 de 2026
// (`cours1/diapo/parties/04_projet_python.typ`), qui reste inchangée, avec ses
// schémas. « Ce que l'activation d'un environnement change » passe à la partie PATH,
// et « Projet : déclaration… » à la partie sur le paquet. Le terminal de l'éditeur
// et les trois diapositives sur le serveur de notebook ne sont pas repris.
// 06/11/2026 : les origines des bibliothèques et l'import passent à `01_probleme.typ`, et
// les deux diapositives d'exemple sur la recette sont retirées : la trace GPX les remplace.
#import "../../../commun/prelude.typ": *
#import "../../../cours1/diapo/schemas.typ": schema-isolation, schema-depots, schema-diamant

#separateur(
  "Bibliothèques et environnements Python",
  annonce: "Ce dont le code d'un projet dépend, où cela s'installe, et comment le décrire pour le refaire ailleurs.",
)

// --------------------------------------------
#d("Installation de bibliothèques : les dépendances")[
  #annonce[
    Une bibliothèque en réclame d'autres. Les installer demande d'abord la
    liste complète, puis une version par paquet qui convienne à tous.
  ]

  #grid(
    columns: (0.72fr, 1.28fr), column-gutter: 26pt, align: horizon,
    chaine-verticale(
      ("les bibliothèques utilisées", "numpy, pillow, pandoc, ffmpeg… 7 en tout"),
      ("ce qu'elles déclarent", "pillow en déclare 14, ffmpeg 53"),
      ("l'environnement obtenu", "293 paquets installés"),
    ),
    align(center, scale(72%, reflow: true, schema-diamant())),
  )

  #legende[
    À gauche : les paquets écrits dans le fichier sont les dépendances
    _directes_, celles qu'ils entraînent sont _transitives_. À droite :
    `pillow` et ses deux dépendances réclament le même `libzlib`, dont une
    seule version sera installée. Sept bibliothèques demandées, 293 paquets
    installés, relevés les 8 et 10 septembre 2026.
  ]

  #notes[
    Deux temps, et deux moitiés de diapositive. À gauche, la liste : la relation est
    récursive, la même règle s'appliquant à chaque paquet atteint jusqu'à n'en plus
    trouver de nouveau. Le dernier nombre n'est la somme d'aucun des précédents, les
    dépendances se recouvrant. Personne ne garde cette liste à la main, d'où l'outil.

    À droite, le choix : calculer l'ensemble à partir du fichier s'appelle *résoudre*
    les dépendances. Il faut choisir une version par paquet, le même paquet
    n'apparaissant qu'une fois dans l'environnement.

    Ici les deux exigences se recouvrent, et `libzlib 1.3.2` convient aux deux. Si
    l'une disait `libzlib <1.3`, aucune version ne conviendrait, et `conda` refuserait
    de créer l'environnement. Une installation est lente pour cette raison.

    Le mot « conflit » ne désigne pas une panne : le cas est ordinaire, et il se règle
    presque toujours seul.

    Écarter « librairie », faux ami de *library*.

    Les noms en `lib…` peuvent surprendre dans un environnement Python : `libtiff`,
    `openjpeg` et `libzlib` ne sont pas écrits en Python. Une bibliothèque d'images
    enveloppe du code C déjà compilé, et ces morceaux rendent l'installation difficile.
  ]
]

// --------------------------------------------
#d("Le numéro de version d'une dépendance")[
  #annonce[
    D'une version à l'autre, une bibliothèque gagne des fonctions et en retire
    d'autres. Le même code ne passe donc pas partout.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Le code], [avec `numpy` 1.26.4], [avec `numpy` 2.5.2],
    [`np.trapezoid([0, 1, 2])`],
      [`AttributeError: module 'numpy' has no attribute 'trapezoid'`],
      [`2.0`],
    [`np.NaN`],
      [`nan`],
      [`AttributeError: np.NaN was removed in the NumPy 2.0 release`],
  )

  #v(0.5em)
  #align(center)[
    #text(size: 17pt)[
      La valeur n'a pas disparu. En 1.26, `np.nan`, `np.NaN` et `np.NAN`
      désignent la même chose ; la version 2.0 n'en garde qu'une.
    ]
  ]

  #legende[
    Sorties réelles, relevées le 10 septembre 2026 dans deux environnements.
    D'où deux exigences opposées : `numpy>=2` pour la première ligne,
    `numpy<2` pour la seconde tant que le code n'est pas repris.
  ]

  #notes[
    Répond à une question fréquente : pourquoi ne pas prendre la dernière version de
    tout.

    Première ligne, le motif de monter : `trapezoid` n'existe pas avant numpy 2.0. Un
    projet qui l'emploie exige au moins cette version.

    Seconde ligne, le motif de ne pas monter : `np.NaN` a disparu dans la même
    version. Le code qui l'emploie s'arrête, et la reprise a un coût, parfois sur des
    milliers de lignes. D'où des projets qui restent sur une version ancienne.

    Ici, le retrait ne perd rien : `np.nan` reste, et seules ses orthographes en double
    partent. NumPy 1.26 acceptait trois façons d'écrire « pas un nombre » et cinq
    d'écrire « l'infini » : `np.inf`, `np.Inf`, `np.Infinity`, `np.infty`, `np.PINF`.
    La version 2.0 n'en garde qu'une de chaque. Le coût tombe sur le code déjà écrit.

    Le second message d'erreur dit ce qui a été retiré, dans quelle version, et par
    quoi le remplacer. Tous ne le font pas.

    Une dépendance se déclare par un nom et une exigence de version : la ligne
    `dependencies` de `pyproject.toml`, partie suivante.

    Ne pas entrer dans la numérotation sémantique.
  ]
]

// --------------------------------------------
#d("Environnement : un moyen de gérer les conflits de dépendances")[
  #annonce[
    Un projet suit `numpy 1.26`, l'autre `numpy 2.1` : installées ensemble, la
    seconde chasse la première. D'où un dossier par projet, un *environnement*.
  ]

  #align(center, scale(92%, reflow: true, schema-isolation()))

  #legende[
    Les deux versions coexistent sans se croiser, et le Python du système n'est
    pas touché.
  ]

  #notes[
    Le faire constater en direct, la sortie est courte :
    `python -c "import numpy; print(numpy.__version__)"` donne une version, puis
    `conda activate recette` et la même commande en donne une autre. Le même mot
    `python` désigne deux programmes différents.

    Sans environnement : une seule version par machine, et le projet qui exige l'autre
    ne tourne plus. Avec : un dossier par projet.

    Réponse au symptôme le plus fréquent du semestre : `ModuleNotFoundError` sur un
    paquet « qu'on vient d'installer ». Le paquet est installé, mais hors de
    l'environnement actif.

    Réflexe à redemander toute l'année : afficher quel Python tourne avant de chercher
    plus loin.
  ]
]

// --------------------------------------------
#d("Comment installer des librairies python")[
  #annonce[
    Plusieurs outils existent et l'écosystème évolue encore. Ici on utilise
    `conda` pour l'environnement et les dépendances, et `pip` pour installer
    le projet lui-même en local. Vocabulaire : en Python, une librairie est
    appelée package.
  ]

  #frise(
    largeur-etiquette: 152pt, tige: 26pt,
    (2008, "pip", "les bibliothèques Python, depuis PyPI"),
    (2012, "conda", "les paquets, et ce qui n'est pas Python"),
    (2015, "conda-forge", "le dépôt communautaire"),
    (2019, "mamba", "le solveur de conda, réécrit"),
    (2023, "pixi", "l'écosystème conda, repris de zéro"),
    (2024, "uv", "pip et les environnements, réécrits"),
  )

  #legende[
    `pyenv`, né la même année que `conda`, n'est pas sur l'axe : il choisit la
    version de Python et n'installe aucun paquet. Dates de création des dépôts,
    relevées le 8 septembre 2026 par l'API de GitHub.
  ]

  #notes[
    Deux minutes. Répond à « pourquoi conda alors que tout le monde dit `pip install` »,
    une question qui vient du web.

    `pip` n'installe que des bibliothèques Python : ni `ffmpeg`, ni un compilateur C++.
    `pyenv` choisit la version de Python active et n'installe aucun paquet ; il figure
    dans la légende parce que son nom prête à confusion. `conda` installe les deux.

    `uv` et `pixi`, récents et écrits en Rust, résolvent les dépendances en quelques
    secondes : `uv` du côté de `pip`, `pixi` de celui de conda. Hors programme, le
    module s'en tenant à un seul outil.

    Le dernier outil ne remplace pas les autres : `pip` a dix-huit ans, reste le plus
    employé, et est installé dans l'environnement du module.

    On ne mélange pas deux outils sur un même environnement, aucun ne voyant ce que
    l'autre a posé.
  ]
]

// --------------------------------------------
#d("D'où viennent les paquets")[
  #annonce[
    Une commande d'installation va chercher le paquet dans un dépôt. Les deux
    que vous croiserez n'y laissent pas entrer la même chose.
  ]

  #align(center, schema-depots())

  #legende[
    Les deux ne s'opposent pas : un paquet conda-forge est le plus souvent
    construit à partir de PyPI, quelques jours plus tard. Projets relevés le
    8 septembre 2026 dans l'index de PyPI, recettes conda-forge le même jour.
  ]

  #notes[
    Ne pas classer les deux dépôts en bon et mauvais. PyPI est l'index de référence du
    monde Python, où la plupart des bibliothèques paraissent d'abord ; un paquet
    conda-forge en est le plus souvent construit quelques jours plus tard.

    La porte d'entrée change. Publier sur PyPI est immédiat et sans relecture ;
    conda-forge demande une recette et une relecture humaine, ce qui élève la barrière
    sans rien prouver sur le code en amont. Le risque de paquets piratés revient au
    cours 6.

    Trente fois plus de projets d'un côté : conda-forge n'empaquette que ce que
    quelqu'un a proposé.

    Si la question du canal `defaults` vient : Miniforge n'installe que depuis
    conda-forge, les conditions d'Anaconda demandant une licence payante aux grandes
    organisations. Raison écrite dans `INSTALLATION.md`.
  ]
]

// --------------------------------------------
#d("Créer un environnement, et le décrire")[
  #annonce[
    Deux façons d'obtenir le même environnement. Seul le fichier voyage avec le
    code, et permet de refaire le projet ailleurs.
  ]

  #face-a-face(
    panneau("Composer l'environnement")[
      ```bash
      conda create -n recette \
          -c conda-forge python=3.12
      conda install -n recette \
          -c conda-forge markdown tabulate
      conda activate recette
      ```
      #text(size: 14pt, fill: estompe)[
        Rien n'en garde trace : ailleurs, il faut se souvenir de ces lignes.
      ]
    ],
    panneau("Le décrire dans un fichier")[
      ```bash
      conda env create -f environment.yml
      conda activate recette
      ```
      #v(0.3em)
      #block(width: 100%, inset: (x: 10pt, y: 6pt), fill: gris,
             stroke: 0.8pt + gris.darken(15%))[
        #text(size: 13pt, fill: estompe)[à la racine du projet :] #h(8pt)
        #text(font: police-code, size: 12pt, weight: demi-gras)[environment.yml]
        #set text(size: 14pt)
        ```yaml
        name: recette
        channels:
          - conda-forge
        dependencies:
          - python=3.12
          - markdown
          - tabulate
        ```
      ]
    ],
  )

  #legende[
    À défaut de fichier, écrire les commandes de gauche dans le `README`.
  ]

  #notes[
    Une installation se refait grâce au fichier qui la décrit. Ce qu'on a tapé ne
    voyage pas avec le code.

    Deux façons de faire, un seul outil. À gauche, on tape ; à droite, on lit un
    fichier que quelqu'un a écrit, le plus souvent soi-même la semaine d'avant. Le
    résultat est le même environnement.

    `-n recette` nomme l'environnement visé sans y entrer. `conda activate` y entre
    (partie suivante) : le distinguer ici évite la confusion la plus fréquente.

    `-c conda-forge` désigne le dépôt d'où viennent les paquets ; dans le fichier, la
    ligne `channels`.

    Le fichier n'installe rien : il dit ce qu'il faut installer. Écrire la liste
    complète des paquets réellement posés la figerait et l'attacherait à un système,
    les paquets compilés n'étant pas les mêmes sous Windows et sous Linux.

    Le fichier se range avec le code : quelques lignes de texte. Le versionner est le
    sujet du cours 2.

    `conda env export` donne la version exacte de chaque paquet : ne pas y entrer.

    Ne pas lancer la création en séance : elle prend plusieurs minutes.
  ]
]

