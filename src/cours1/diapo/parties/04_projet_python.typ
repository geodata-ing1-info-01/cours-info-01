// Partie 4 du cours 1 — incluse par `cours1.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": schema-isolation, schema-depots, schema-diamant, schema-chemin
#import "../schemas_notebooks.typ": schema-client-serveur, schema-trois-serveurs, schema-deux-clients

// ======================== Structure d'un projet Python ======================

#separateur(
  "Bibliothèques et environnements Python",
  annonce: "Ce dont le code d'un projet dépend, où cela s'installe, et comment un notebook désigne le Python qui l'exécute",
)
// ---------------------- La documentation du projet --------------------------

#d("Un programme s'appuie sur des bibliothèques")[
  #annonce[
    Un programme ne réécrit pas tout à partir de zéro. Il appelle des fonctions
    déjà écrites, regroupées en *bibliothèques*, qui ont trois origines.
  ]

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 12pt,
    rows: 96pt,
    bloc("Livrées avec Python", "la bibliothèque standard : math, csv, pathlib, json…", hauteur: 100%),
    bloc("Écrites pour le projet", "vos propres fichiers, importés les uns par les autres", hauteur: 100%),
    bloc("Publiées par d'autres", "numpy, pillow, markdown… à installer depuis un dépôt de paquets", plein: true, hauteur: 100%),
  )

  #v(0.4em)
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Ce qu'on écrit], [Ce que cela demande],
    [`import csv`], [rien : installé avec l'interpréteur],
    [`from recette.calculs import adapter`], [que le projet ait été installé],
    [`import markdown`], [que la bibliothèque ait été installée avant],
  )

  #legende[
    Les diapositives suivantes le montrent sur un programme réel.
  ]

  #notes[
    C'est la diapositive de contexte de tout le bloc : sans elle, le
    programme qui suit tombe du ciel. Un programme est court parce que
    presque tout ce qu'il fait est déjà écrit ailleurs — lire un CSV,
    convertir du Markdown en HTML — et ce qu'il écrit vraiment, c'est
    l'assemblage.

    « Dépôt de paquets » traduit *repository* : conda-forge, PyPI. On y
    revient trois diapositives plus loin, avec l'outil qui va y chercher.

    La troisième colonne est celle qui coûte : elle marche ici et pas
    ailleurs tant qu'on n'a pas dit ce qu'il faut installer. C'est la
    problématique de la fin de la partie, l'environnement et le fichier
    qui le décrit.
  ]
]
#d("L'import d'une bibliothèque et ses conditions")[
  #annonce[
    Une bibliothèque se déclare par `import`, en tête du programme, avant tout
    appel à ses fonctions. Si elle n'est pas disponible, l'import échoue et le
    programme s'arrête sur un `ModuleNotFoundError`.
  ]

  #face-a-face(
    panneau("Livrées avec Python")[
      ```python
      import math
      print(math.sqrt(2))
      ```
      ```
      1.4142135623730951
      ```
      #text(size: 14pt, fill: estompe)[
        `math`, `csv`, `pathlib`, `json` : environ deux cents modules,
        installés en même temps que l'interpréteur.
      ]
    ],
    panneau("Publiées par d'autres")[
      ```python
      import numpy
      ```
      ```
      ModuleNotFoundError:
      No module named 'numpy'
      ```
      #text(size: 14pt, fill: estompe)[
        `numpy`, `pillow`, `markdown` : il faut les installer, et savoir
        lesquelles.
      ]
    ],
  )

  #legende[
    Sorties réelles dans un environnement réduit à Python. C'est la colonne de
    droite qui rend nécessaire tout ce qui suit : installer, puis décrire ce
    qu'on a installé.
  ]

  #notes[
    Diapositive charnière : tout le reste de la partie répond à la colonne
    de droite. Y revenir si la salle décroche sur les fichiers de
    description.

    La bibliothèque livrée avec Python s'appelle la *bibliothèque
    standard*. Elle explique pourquoi `import csv`, sur la diapositive
    précédente, ne demandait rien de plus que l'interpréteur.

    Le message d'erreur est le même que celui de la partie 2 et que celui
    du TD 1h à venir. Troisième rencontre, et cette fois la
    cause est nommée : la bibliothèque n'est pas dans l'environnement
    actif.

    Ne pas dire que la bibliothèque standard suffit : ni `numpy`, ni
    `pillow`, ni `pandas` n'en font partie, et c'est là que sont les
    outils du métier.
  ]
]
#d("Exemple de programme : l'objectif")[
  #annonce[
    Deux fichiers en entrée, la description de la recette et les quantités
    pour une personne en unités SI ; en sortie, une page de recette HTML
    avec les quantités adaptées au nombre de personnes voulu et au type
    d'unités de mesure.
  ]

  #grid(
    columns: (auto, auto, auto, auto, 1fr),
    column-gutter: 11pt,
    align: horizon,
    // Les deux entrées, avec un extrait de leur contenu réel.
    grid(
      rows: 2, row-gutter: 9pt,
      block(width: 158pt, inset: (x: 9pt, y: 7pt), fill: gris,
            stroke: 0.8pt + gris.darken(15%))[
        #text(font: police-code, size: 12pt, weight: demi-gras)[ingredients.csv]
        #v(0.3em)
        #set text(font: police-code, size: 10.5pt, fill: estompe)
        #set par(leading: 0.55em)
        ingredient,quantite,unite \
        Farine,60,g \
        Lait,125,ml
      ],
      block(width: 158pt, inset: (x: 9pt, y: 7pt), fill: gris,
            stroke: 0.8pt + gris.darken(15%))[
        #text(font: police-code, size: 12pt, weight: demi-gras)[recette.md]
        #v(0.3em)
        #set text(font: police-code, size: 10.5pt, fill: estompe)
        #set par(leading: 0.55em)
        \# Crêpes \
        \*10 minutes de préparation.\* \
        … \
        \#\# Ingrédients
      ],
    ),
    fleche,
    block(width: 152pt, inset: (x: 10pt, y: 9pt), fill: accent.lighten(92%),
          stroke: 0.8pt + accent.lighten(55%))[
      #set text(size: 13pt)
      Multiplier les quantités, les convertir, et poser le tableau sous le
      titre « Ingrédients ».
    ],
    fleche,
    // La sortie, où l'on retrouve les mêmes lignes.
    block(width: 100%, inset: (x: 11pt, y: 7pt),
          stroke: 0.8pt + estompe.lighten(50%))[
      #text(size: 16pt, weight: "bold")[Crêpes]
      #v(0.2em)
      #text(size: 12pt, style: "italic", fill: estompe)[10 minutes de préparation.]
      #v(0.2em)
      #text(size: 12pt, fill: estompe)[…]
      #v(0.1em)
      #text(size: 14pt, weight: "bold")[Ingrédients]
      #v(0.1em)
      // Le tableau reprend la taille du reste de la page simulée, et non
      // celle des tableaux de diapositive : c'est une page HTML en réduction.
      #show table.cell: set text(size: 12.5pt)
      #tableau(
        columns: (1fr, auto),
        align: left + horizon,
        [Ingrédient], [Quantité],
        [Farine], [240 g],
        [Lait], [500 ml],
      )
    ],
  )

  #legende[
    Pour quatre personnes : les 60 g du fichier en font 240. Le tableau de
    droite n'existe dans aucun des deux fichiers d'entrée, il est calculé.
  ]

  #notes[
    Poser le besoin avant le code : une recette s'écrit pour un nombre de
    convives, et se relit dans le système d'unités du lecteur. Les
    quantités du fichier valent pour une personne ; tout le reste se
    calcule.

    Faire remarquer que `recette.md` ne contient pas de tableau, seulement
    le titre « Ingrédients ». C'est ce qui permet au même fichier de servir
    pour deux personnes comme pour douze.

    Les cinq noms de la boîte du milieu sont l'ordre du programme, et
    celui de la diapositive suivante.

    Ce que la bibliothèque apporte, en une phrase : reconnaître les titres,
    les listes, les tableaux, l'emphase et les liens d'un texte Markdown,
    et leurs combinaisons. Huit mille lignes que personne n'écrit dans la
    semaine — c'est l'argument de la partie, et il ne vaut pas pour les
    conversions d'unités, qui tiennent en deux divisions.
  ]
]
#d("Exemple de programme : le code")[
  #annonce[
    En s'appuyant sur des bibliothèques existantes, le programme tient en
    neuf lignes. Le commentaire de chaque ligne en donne l'origine.
  ]

  #set text(size: 16pt)
  ```python
  import markdown                                           # installée
  from tabulate import tabulate                             # installée
  from recette.calculs import adapter, en_table, lire_ingredients  # le projet

  ingredients = lire_ingredients(DONNEES / "ingredients.csv") # le projet
  ingredients = adapter(ingredients, PERSONNES, UNITES)     # le projet
  lignes = en_table(ingredients)                            # le projet

  tableau = tabulate(lignes, headers=EN_TETE)               # installée
  source = (DONNEES / "recette.md").read_text(encoding="utf-8") # avec Python
  source = source.replace("## Ingrédients", tableau)        # Python seul

  corps = markdown.markdown(source, extensions=["tables"])  # installée
  page = GABARIT.format(titre="Crêpes", corps=corps)        # Python seul
  sortie.write_text(page, encoding="utf-8")                 # avec Python
  ```

  #legende[
    Deux lignes seulement demandent une bibliothèque installée. `source.replace`
    est resserrée ici : elle garde le titre.
  ]

  #notes[
    Reprendre ligne à ligne, sans s'attarder :

    1. `lire_ingredients` ouvre le CSV et rend une liste de triplets, avec
    des nombres et non du texte.
    2. `adapter` multiplie par le nombre de convives, puis convertit si on
    demande les unités américaines.
    3. `en_table` fabrique les lignes à afficher : c'est là que les nombres
    redeviennent du texte.
    4. `tabulate` en fait un tableau Markdown. C'est la ligne qu'on sait
    écrire soi-même, et l'autre fichier du projet le fait.
    5. `read_text` lit la recette. `pathlib` est livrée avec Python : rien
    à installer, mais c'est bien une bibliothèque.
    6. `replace` pose le tableau sous le titre. Une méthode des chaînes,
    donc du langage lui-même.
    7. `markdown.markdown` convertit en HTML. C'est la ligne qu'on ne
    saurait pas écrire : huit mille lignes derrière elle.
    8. `format` remplit le gabarit de la page. Du langage, encore.
    9. `write_text` écrit le fichier, et la page est prête.

    La leçon tient dans le décompte : sur neuf lignes, deux dépendent d'une
    installation. C'est peu, et c'est pourtant ce qui décide qu'un
    programme marche ou non sur une autre machine. D'où le fichier qui les
    déclare.

    Distinguer les trois origines : le code du projet, qu'on écrit et qu'on
    versionne ; la bibliothèque standard, qui vient avec l'interpréteur ;
    les bibliothèques installées, qui manquent tant qu'on ne les a pas
    demandées. Seules les dernières produisent un `ModuleNotFoundError`.
  ]
]
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
    Deux temps, et deux moitiés de diapositive. À gauche, la liste : la
    relation est récursive, la même règle s'appliquant à chaque paquet
    atteint jusqu'à n'en plus trouver de nouveau. Le dernier nombre n'est
    la somme d'aucun des précédents, les dépendances se recouvrant.
    Personne ne tient cette liste à la main, et c'est ce qui justifie
    l'outil.

    À droite, le choix : calculer l'ensemble à partir du fichier s'appelle
    *résoudre* les dépendances, et ce n'est pas un simple parcours du
    graphe. Il faut choisir une version par paquet, le même paquet
    n'apparaissant qu'une fois dans l'environnement.

    Ici les deux exigences se recouvrent, et `libzlib 1.3.2` convient aux
    deux. Si l'une disait `libzlib <1.3`, aucune version ne conviendrait,
    et `conda` refuserait de créer l'environnement plutôt que d'en
    fabriquer un cassé. C'est aussi ce qui explique qu'une installation
    soit lente.

    Ne pas dire « conflit » comme si c'était une panne : c'est le cas
    ordinaire, et il se règle presque toujours seul.

    Écarter « librairie », faux ami de *library*.

    Les noms en `lib…` peuvent surprendre dans un environnement Python :
    `libtiff`, `openjpeg` et `libzlib` ne sont pas écrits en Python. Une
    bibliothèque d'images enveloppe du code C déjà compilé, et ce sont ces
    morceaux-là qui rendent l'installation difficile.
  ]
]
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
    La diapositive répond à la question qui vient toujours : pourquoi ne
    pas prendre la dernière version de tout ?

    Première ligne, le motif de monter : `trapezoid` n'existe pas avant
    numpy 2.0. Un projet qui l'emploie exige au moins cette version, et
    c'est le cas ordinaire — on veut ce qui a été ajouté et corrigé.

    Seconde ligne, le motif de ne pas monter : `np.NaN` a disparu dans la
    même version. Le code qui l'emploie s'arrête, et la reprise a un coût,
    parfois sur des milliers de lignes. D'où des projets qui restent
    volontairement sur une version ancienne.

    Pourquoi retirer quelque chose qui marchait ? Ici, rien n'est perdu :
    `np.nan` reste, et seules ses orthographes en double partent. NumPy 1.26
    acceptait trois façons d'écrire « pas un nombre » et cinq d'écrire
    « l'infini » — `np.inf`, `np.Inf`, `np.Infinity`, `np.infty`, `np.PINF`.
    La version 2.0 n'en garde qu'une de chaque, pour qu'il n'y ait qu'une
    façon d'écrire chaque chose.

    C'est le motif ordinaire d'un retrait : non pas supprimer une
    possibilité, mais cesser d'en offrir plusieurs pour la même. Le coût est
    quand même réel, puisqu'il tombe sur le code déjà écrit.

    Le second message d'erreur est exemplaire : il dit ce qui a été retiré,
    dans quelle version, et par quoi le remplacer. Tous ne le font pas.

    Le mot à poser : une dépendance ne se déclare pas par un nom seul, mais
    par un nom et une exigence de version. C'est ce que porte la ligne
    `dependencies` du fichier, diapositives suivantes.

    Ne pas entrer dans la numérotation sémantique : le cours 3 y revient
    quand ils publieront quelque chose.
  ]
]
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
    Le faire constater en direct plutôt que de le projeter, la sortie est
    courte et elle a plus de force tapée devant eux :
    `python -c "import numpy; print(numpy.__version__)"` donne une version,
    puis `conda activate recette` et la même commande en donne une autre. Le
    même mot `python` désigne deux programmes différents.

    Sans environnement : une seule version par machine, et le projet qui exige
    l'autre ne tourne plus. Avec : un dossier par projet.

    Réponse au symptôme le plus fréquent du semestre :
    `ModuleNotFoundError` sur un paquet « qu'on vient d'installer ». Le
    paquet est installé, mais hors de l'environnement actif.

    Réflexe à redemander toute l'année : afficher quel Python tourne avant
    de chercher plus loin.
  ]
]
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
    Deux minutes. Elle répond à « pourquoi conda alors que tout le monde
    dit `pip install` ? », question qui vient du web de toute façon.

    `pip` n'installe que des bibliothèques Python : ni `ffmpeg`, ni un
    compilateur C++. `pyenv` ne fait pas ce travail — il choisit la
    version de Python active et n'installe aucun paquet ; il figure ici
    parce que son nom prête à confusion. `conda` fait les deux.

    `uv` et `pixi`, récents et écrits en Rust, résolvent les dépendances
    en quelques secondes : `uv` du côté de `pip`, `pixi` de celui de
    conda. Hors programme, le module s'en tenant à un seul outil.

    Pas de succession où le dernier remplace les autres : `pip` a dix-huit
    ans, reste le plus employé, est installé dans l'environnement du
    module, et `uv` l'appelle encore par-dessous.

    À retenir : on ne mélange pas deux outils sur un même environnement,
    aucun ne voyant ce que l'autre a posé.
  ]
]
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
    Ne pas classer les deux dépôts en bon et mauvais. PyPI est l'index de
    référence du monde Python, où la plupart des bibliothèques paraissent
    d'abord ; un paquet conda-forge en est le plus souvent construit
    quelques jours plus tard.

    Ce qui change est la porte d'entrée. Publier sur PyPI est immédiat et
    sans relecture, ce qui fait sa richesse et ce qu'exploite la
    diapositive suivante ; conda-forge demande une recette et une
    relecture humaine, ce qui élève la barrière sans rien prouver sur le
    code en amont.

    Trente fois plus de projets d'un côté : conda-forge n'empaquette que
    ce que quelqu'un a proposé.

    Si la question du canal `defaults` vient : Miniforge n'installe que
    depuis conda-forge, les conditions d'Anaconda demandant une licence
    payante aux grandes organisations. Raison écrite dans
    `INSTALLATION.md`.
  ]
]
#d("Créer un environnement, et le décrire")[
  #annonce[
    Deux façons d'obtenir le même environnement. Pour qu'un projet se refasse
    ailleurs, c'est le fichier qui compte : lui seul voyage avec le code.
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
    La phrase à retenir de la partie : une installation se refait parce
    qu'un fichier la décrit, non parce qu'on se souvient de ce qu'on a
    tapé. C'est aussi ce qui est demandé au rendu.

    Deux façons de faire, un seul outil. À gauche, on tape ; à droite, on lit un
    fichier que quelqu'un a écrit, le plus souvent soi-même la semaine
    d'avant. Le résultat est le même environnement.

    `-n recette` nomme l'environnement visé sans y entrer. Entrer dedans,
    c'est `conda activate`, diapositive suivante : le distinguer ici évite
    la confusion la plus fréquente.

    `-c conda-forge` désigne le dépôt d'où viennent les paquets ; dans le
    fichier, c'est la ligne `channels`.

    Le fichier n'installe rien : il dit ce qu'il faut installer. Écrire la
    liste complète des paquets réellement posés serait la figer et
    l'attacher à un système, les paquets compilés n'étant pas les mêmes
    sous Windows et sous Linux.

    Le fichier se range avec le code et le suit partout : quelques lignes
    de texte, comme le reste du projet. Le versionner est le sujet du
    cours 2.

    Ce qui manque encore : ce fichier écrit à la main ne dit pas d'où vient
    chaque paquet ni en quelle version exacte. `conda env export` le fait ;
    ne pas y entrer aujourd'hui.

    Ne pas lancer la création maintenant : plusieurs minutes, et c'est le
    TD de fin de partie. Sa dernière étape est justement d'ajouter au
    fichier la ligne qui manquait, et de constater que rien ne
    s'installe puisque c'était déjà fait.
  ]
]
#d("Ce que l'activation d'un environnement change")[
  #annonce[
    Activer un environnement n'installe rien et ne déplace rien : cela pose un
    dossier de plus en tête de la liste où le terminal cherche les commandes.
  ]

  #align(center, schema-chemin())

  #legende[
    Chemins d'un poste Windows, avant et après `conda activate` ; sous macOS et
    Linux, `…/envs/recette/bin` passe devant `/usr/bin`. La liste parcourue est
    la variable `PATH`.
  ]

  #notes[
    La diapositive répond à la question qui revient tout le semestre :
    « pourquoi `python` n'est pas le même selon le terminal ? ». Le mot
    `python` ne désigne pas un programme, mais le premier fichier de ce nom
    trouvé dans la liste.

    Conséquence immédiate, à énoncer : `conda install` pose le paquet dans
    l'environnement actif, et un terminal ouvert avant l'activation ne le
    verra pas. C'est le `ModuleNotFoundError` de la diapositive précédente,
    vu par son mécanisme.

    Deuxième conséquence : désactiver ne désinstalle rien, cela retire le
    dossier de la tête de la liste.

    Sous Windows, `python.exe` est à la racine de l'environnement, et
    l'activation ajoute aussi `…\envs\recette\Scripts` et `Library\bin`,
    non montrés. Sans environnement, `python` renvoie souvent au Microsoft
    Store, ou à une autre installation : ne pas s'y attarder, dire
    « introuvable ou un autre ». Sous macOS et Linux, le même mécanisme avec
    `…/envs/recette/bin` devant `/usr/bin`.

    `PATH` est repris au cours 2, avec les chemins et le dossier courant ;
    ici, seul l'ordre de parcours compte.
  ]
]
#d("Projet : déclaration des informations & métadonnées")[
  #annonce[
    Un projet se décrit dans un fichier texte : son nom, sa version, et ce
    dont son code a besoin.
  ]

  #face-a-face(
    panneau[`pyproject.toml`, à la racine du projet][
      ```toml
      [project]
      name = "recette"
      version = "0.1.0"
      requires-python = ">=3.10"
      dependencies = ["markdown>=3.5"]

      [project.scripts]
      recette = "recette.__main__:main"
      ```
    ],
    panneau("Ce que chaque ligne déclare")[
      #tableau(
        columns: (auto, 1fr),
        align: left + horizon,
        [Ce qui est écrit], [Ce que c'est],
        [`name`, `version`], [les métadonnées],
        surligne[`dependencies`], surligne[ce que le code importe],
        [`requires-python`], [les versions de Python],
        [`[project.scripts]`], [la commande installée],
      )
    ],
  )

  #legende[
    Contenu réel de `pyproject.toml`, écrit en TOML : des sections entre
    crochets, une valeur par nom. `environment.yml` est en YAML, où
    l'indentation porte la structure.
  ]

  #notes[
    Deux fichiers, deux descriptions, et il faut les distinguer :
    `environment.yml` dit de quoi la *machine* a besoin, y compris ce qui
    n'est pas du Python ; `pyproject.toml` dit de quoi le *code* a besoin.
    Les deux coexistent dans la plupart des projets, et dans celui du
    TD 1h.

    C'est un troisième usage du texte, après le code et la documentation :
    décrire. Ils ont croisé `.json` et `.yaml` à « Les fichiers texte d'un
    projet » ; ce sont les mêmes formats, employés ici pour déclarer. Comme
    `.json`, YAML et TOML décrivent des données ; contrairement à lui, ils
    acceptent des commentaires, ce qui explique qu'un humain les écrive. On
    les retrouve hors de Python : réglages d'un outil, description d'une
    chaîne d'intégration, composition de conteneurs.

    Piège du YAML, à mentionner si quelqu'un tape le fichier : deux espaces
    d'indentation, jamais de tabulation, et l'éditeur le signale. C'est
    « Espaces, tabulations et fins de ligne » qui resurgit.

    La ligne surlignée est celle que le TD 1h fait lire avant de
    lancer quoi que ce soit : le projet annonce avoir besoin de `markdown`.

    Boucler la partie : le code réutilisé au début est disponible parce que
    quelqu'un a écrit un fichier de cette forme, puis déposé le résultat sur
    un dépôt. Fabriquer le paquet est au cours 3, avec `[project.scripts]`.

    Ne pas détailler `[build-system]`, absent de l'extrait : aucun projet
    ordinaire n'a à en changer.
  ]
]
#d("Le terminal de l'éditeur de code")[
  #annonce[
    L'éditeur ouvre un terminal dans sa fenêtre, déjà placé dans le dossier du
    projet.
  ]

  #tableau(
    columns: (1.1fr, 1fr),
    align: left + horizon,
    [L'action], [Ce qu'elle règle],
    [Terminal #sym.arrow.r Nouveau terminal], [un terminal dans le dossier ouvert],
    [le sélecteur, à droite du panneau], [l'interpréteur de commandes : PowerShell, bash, zsh],
    [`Ctrl` + `Maj` + `P`, `Python: Select Interpreter`], [l'environnement activé dans chaque nouveau terminal],
    [la barre d'état, en bas], [l'environnement en cours],
  )

  #legende[
    Le dossier du projet est le dossier courant : c'est de lui que partent les
    chemins relatifs des commandes.
  ]

  #notes[
    Ils s'en sont servis au TD 1c, « hello world », sans qu'on le
    nomme.

    La troisième ligne évite le `ModuleNotFoundError` de la diapositive
    précédente : l'interpréteur choisi est celui que l'éditeur active dans
    chaque nouveau terminal, et la barre d'état le vérifie sans rien
    taper.

    Le terminal intégré est le même programme, affiché dans la fenêtre de
    l'éditeur. Le dire, la question vient.

    Libellés dépendants de la version de VSCode et de la langue de
    l'interface, anglaise par défaut : à vérifier sur le poste de
    démonstration.

    Ouvrir un terminal hors de l'éditeur est en annexe, et au cours 2.
  ]
]
#d("Le client et le serveur d'un notebook")[
  #annonce[
    Un notebook est une application web : un client qui affiche, un serveur qui
    exécute.
  ]

  #align(center, schema-client-serveur())

  #legende[
    Changer de client ne change pas le noyau : JupyterLab et l'éditeur de code
    ouvrent le même fichier et parlent au même serveur.
  ]

  #notes[
    Reprendre le schéma de la première partie : là-bas le serveur était
    ailleurs, ici il est sur la même machine. Le navigateur ne sait pas
    faire la différence, et c'est pourquoi l'adresse ressemble à une
    adresse de site.

    Le noyau est le processus Python qui exécute et qui retient. La
    démonstration en trois temps : `x = 10`, puis `print(x * 2)` → 20 ;
    modifier la première cellule en `x = 3` sans l'exécuter, la seconde
    affiche toujours 20 ; puis Restart & Run All. Réflexe avant tout
    partage.

    VSCode est un client comme JupyterLab : il ouvre le même fichier et
    parle au même noyau. C'est le sens de la question « choisir le noyau »
    qu'il pose à l'ouverture, et le TD le vérifie.

    Le jeton dans l'adresse `localhost:8888/lab?token=…` est un mot de
    passe à usage unique, qui empêche qu'un autre poste du réseau exécute
    du code. Une phrase ; repris au cours 5.

    JupyterLite n'a pas de serveur : le noyau y est compilé en
    WebAssembly et tourne dans l'onglet. Utile pour ouvrir un notebook en
    dix secondes, sans compte ni installation ; pas pour travailler, tous
    les paquets n'y étant pas. Colab, à l'inverse, exige un compte et
    exécute sur ses serveurs.
  ]
]
#d("Les trois emplacements du serveur")[
  #annonce[
    Client et serveur sont deux rôles, pas deux machines.
  ]

  #align(center, schema-trois-serveurs())

  #legende[
    Seul le premier cas fait sortir quelque chose de votre machine. Dans le
    troisième, le noyau Python est exécuté par le navigateur lui-même.
  ]

  #notes[
    C'est « Où s'exécute une application web » repris sur un cas précis :
    la question utile n'est pas « est-ce que ça tourne chez moi ? » mais
    « qu'est-ce qui sort, et quand ? ».

    Premier cas : le code part sur une machine qu'on ne possède pas. Colab
    exige un compte, et ce qu'on y dépose part sur les serveurs de
    Google. Pratique pour dépanner, pas pour rendre un travail.

    Deuxième cas, celui du module : `jupyter lab` démarre un serveur sur
    leur poste, et l'adresse `localhost:8888` en est la preuve. Le jeton
    dans l'adresse est un mot de passe à usage unique, qui empêche qu'un
    autre poste du réseau exécute du code. Repris au cours 5.

    Troisième cas, à relier à « La place de l'interpréteur » : le
    navigateur y figurait déjà comme interpréteur, à côté de `python`.
    JupyterLite ne fait que pousser cela plus loin — le noyau Python y est
    compilé en WebAssembly et tourne dans l'onglet, si bien qu'il n'y a
    plus de serveur du tout. Un navigateur est devenu assez complet pour
    faire tourner un interpréteur Python.

    Sa limite, à dire pour qu'ils ne s'y installent pas : tous les paquets
    n'y sont pas, et ce qu'on y dépose vit dans le navigateur. Il sert à
    ouvrir un notebook en dix secondes, sans compte ni installation.
  ]
]
#d("Les clients d'un notebook")[
  #annonce[
    Le même fichier s'ouvre par plusieurs clients. Tous ont besoin du même
    noyau.
  ]

  #align(center, schema-deux-clients())

  #legende[
    L'éditeur de code n'a pas besoin de `jupyterlab` : il démarre `ipykernel`
    lui-même. `ipykernel` est le noyau Python ; il en existe pour d'autres
    langages, et le nom _Jupyter_ vient de Julia, Python et R.
  ]

  #notes[
    Le point pratique, et il sert dès le TD : un environnement
    ouvert dans l'éditeur n'a besoin que d'`ipykernel`. C'est pourquoi
    l'environnement `analyse` de tout à l'heure n'a pas `jupyterlab` et
    fonctionne quand même.

    L'éditeur parle directement au noyau, sans passer par un serveur — la
    documentation de l'extension le dit : « vous n'avez pas besoin
    d'installer jupyter dans l'environnement, seul `ipykernel` est
    nécessaire ». Il sait aussi se connecter à un serveur existant, en
    collant son adresse ; c'est le premier cas du schéma précédent.

    Les langages, pour information et sans y insister : le noyau décide du
    langage, pas le format de fichier. Il existe des noyaux pour R
    (`IRkernel`), Julia (`IJulia`), C++, et le `kernel.json` porte une
    ligne `language` qui dit lequel. Le projet s'appelait IPython jusqu'en
    2014.

    Ne pas en faire une invitation à changer de langage : le module reste
    en Python.
  ]
]
