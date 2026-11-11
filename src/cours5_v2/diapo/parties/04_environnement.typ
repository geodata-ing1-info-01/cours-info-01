// Partie 4 du cours 5 v2 : environnement et fichier de projet. Incluse par `cours5_v2.typ`.
//
// Réorganisée le 06/11/2026 : l'environnement (le conflit de versions, la création) ; l'activation
// (`PATH`, puis les deux recherches) ; les fichiers qui recréent le projet (`README` ou
// `environment.yml`, `pyproject.toml`, le choix entre les deux), et les commandes sur le nouveau
// poste de la partie 1. Repris en partie de la partie 4 du cours 1 de 2026 et du cours 4 de 2026.
//
// « Variable lue par un programme : PROJ_DATA » et « pyproject.toml : du fichier à la commande »
// sont dans `a_reprendre/environnement.typ`.
//
// Essayé le 06/11/2026 sous Linux, dans un dossier neuf : `conda env create -f environment.yml`,
// l'activation, `carte_trace.py` et `pip install .`. Les chemins de Windows restent à relever.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../../../cours1_v2/diapo/schemas.typ": terminal
#import "../../../cours3_v2/diapo/schemas.typ": arborescence, poste
#import "../schemas.typ": schema-isolation-carte, schema-path-carte

// --------------------------------------------
#d("Environnement : un moyen de gérer les conflits de dépendances")[
  #annonce[
    Un projet demande `numpy 1.26`, l'autre `numpy 2.5`, et `site-packages` ne contient qu'une
    version de chaque paquet. Chaque projet reçoit donc son propre dossier, un *environnement*.
  ]

  #align(center, scale(92%, reflow: true, schema-isolation-carte()))

  #legende[
    Chaque environnement contient son Python et ses paquets. Le Python du système ne change pas.
  ]

  #notes[
    Dans la salle, `conda install` dans `base` lève `EnvironmentNotWritableError` (annexe
    A8) : le compte élève ne peut pas modifier ce dossier. Sur un ordinateur personnel, le
    conflit de versions reste la raison principale.

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
// Reprend la moitié gauche de « Créer un environnement, et le décrire », 06/11/2026.
#d("Environnement : création et dossier")[
  #annonce[
    `conda create` crée un dossier, et y installe Python et les paquets demandés. `conda activate`
    sélectionne ensuite cet environnement dans le terminal.
  ]

  #face-a-face(
    panneau("Commandes")[
      #terminal(
        taille: 15pt,
        "$ conda create -n carte -c conda-forge \\",
        "      python=3.12 gdal folium",
        "…",
        "$ conda activate carte",
        "(carte) $ python carte_trace.py trace_2.gpx",
        "…",
        "carte écrite : trace_2.html",
      )
    ],
    panneau("Dossier de l'environnement, sous Windows")[
      #arborescence(
        (0, "…\\.conda\\envs\\carte\\"),
        (1, "python.exe", "l'interpréteur"),
        (1, "Scripts/", "`pip.exe`"),
        (1, "Library/bin/", "`ogr2ogr.exe`"),
        (1, "Lib/site-packages/", "`folium/`, `osgeo/`"),
        taille: 12pt,
      )
    ],
  )

  #legende[
    Ce dossier a la même organisation que le dossier d'une distribution. Dans la salle, le compte
    élève ne peut pas modifier `anaconda3`, et `conda` écrit donc dans `.conda\envs\ `. Sous Linux
    et macOS, le dossier est `~/miniforge3/envs/carte/`.
  ]

  #notes[
    `-n carte` nomme l'environnement visé sans y entrer. `conda activate` y entre : le distinguer
    ici évite la confusion la plus fréquente.

    `-c conda-forge` désigne le dépôt d'où viennent les paquets.

    `(carte)`, au début de la ligne : l'environnement actif.

    Un environnement conda est une installation locale, dans un dossier du compte (« Installation
    d'un programme : globale ou locale »). `pip install`, dans un environnement activé, écrit dans
    ce dossier.

    Ne pas relancer la création devant la salle : elle prend plusieurs minutes. La commande lancée au
    TD 5a se termine pendant cette partie.

    Dossier complet, dans la salle : `C:\Users\<nom>\.conda\envs\carte`.

    Commandes essayées le 06/11/2026 sous Linux. Arborescence attendue, à relever en salle.
  ]
]

// --------------------------------------------
// Reprise de la partie 4 du cours 1 de 2026 le 05/11/2026, puis refaite le 06/11/2026 sur `envs/carte`.
#d("Activation d'un environnement : effet sur PATH")[
  #annonce[
    Activer un environnement n'installe rien et ne déplace aucun fichier. La modification de `PATH`
    vaut pour ce terminal, comme un `export`.
  ]

  #schema-path-carte()

  #legende[
    À gauche, aucun dossier ne contient `ogr2ogr.exe`. Sous macOS et Linux, `…/envs/carte/bin` passe
    devant `/usr/bin`.
  ]

  #notes[
    Répond à une question qui revient tout le semestre : `python` change selon le
    terminal. Le mot `python` désigne le premier fichier de ce nom trouvé dans la
    liste.

    Conséquence : `conda install` pose le paquet dans l'environnement actif, et un
    terminal ouvert avant l'activation ne le verra pas, d'où un
    `ModuleNotFoundError` sur un paquet « qu'on vient d'installer ».

    Deuxième conséquence : désactiver ne désinstalle rien, cela retire le
    dossier de la tête de la liste.

    L'activation lance aussi les scripts `etc/conda/activate.d/` des paquets : celui de GDAL
    règle `GDAL_DATA` et `PROJ_DATA`, relevés le 06/11/2026. `PROJ_DATA` donne à `ogr2ogr` le dossier
    de `proj.db`, la base des systèmes de coordonnées.

    La colonne de droite reprend « Recherche d'un programme : variable PATH ». Sous Windows,
    l'activation ajoute aussi `…\envs\carte\Scripts` et d'autres dossiers, non montrés. Chemins de
    Windows attendus, à relever en salle. Relevé sous Linux : `…/envs/carte/bin` en tête de `PATH`.
  ]
]

// --------------------------------------------
// Réunit « sys.path selon l'interpréteur lancé » et « GDAL : deux versions sur un même poste »,
// 06/11/2026. Sorties relevées ce jour-là sous Linux, avec un `PATH` sans le GDAL du système.
#d("Activation : recherche des dépendances")[
  #annonce[
    Après l'activation, `PATH` désigne le `python` et le `ogr2ogr` de l'environnement. Cet
    interpréteur calcule `sys.path` à partir de son propre dossier.
  ]

  #face-a-face(
    panneau[Avant `conda activate carte`][
      #terminal(
        taille: 14pt,
        "$ which python",
        "…/miniforge3/bin/python",
        "$ ogr2ogr --version",
        "bash: ogr2ogr: command not found",
        "$ python -c \"import sys; print(sys.path[-1])\"",
        "…/miniforge3/lib/python3.10/site-packages",
        "$ python -c \"import folium; print(folium.__version__)\"",
        "ModuleNotFoundError: No module named 'folium'",
      )
    ],
    panneau[Après `conda activate carte`][
      #terminal(
        taille: 14pt,
        "(carte) $ which python",
        "…/envs/carte/bin/python",
        "(carte) $ ogr2ogr --version",
        "GDAL 3.13.3 \"Iowa City\", released 2026/08/13",
        "(carte) $ python -c \"import sys; print(sys.path[-1])\"",
        "…/envs/carte/lib/python3.12/site-packages",
        "(carte) $ python -c \"import folium; print(folium.__version__)\"",
        "0.20.0",
      )
    ],
  )

  #legende[
    Sorties réelles sous Linux, chemins raccourcis. `sys.path[-1]` désigne le dernier dossier de la
    liste. À gauche, les deux recherches échouent, comme sur le nouveau poste de la partie 1.
  ]

  #notes[
    Le lien entre les deux recherches : `PATH` désigne l'interpréteur, et l'interpréteur
    détermine `sys.path`.

    Afficher quel Python tourne : `which python` ou `sys.executable`.

    Un nom qui contient un `/` lance ce fichier sans passer par `PATH`.
    `…/envs/carte/bin/python carte_trace.py trace_2.gpx`, sans activation, trouve `folium`, et
    `subprocess.run` lève `FileNotFoundError` sur `ogr2ogr` : essayé le 06/11/2026.

    Si un autre GDAL est dans `PATH`, le même appel lance cet autre `ogr2ogr` : sous Linux, GDAL
    3.4.1 du système, avec le module `osgeo` en 3.13.3. Deux versions d'un même logiciel dans un
    même programme : le résultat peut changer sans message d'erreur. Vérifier qu'aucun GDAL ou QGIS
    n'est dans le `PATH` des postes.

    Sous Windows, attendu : `…\envs\carte\python.exe` et `…\envs\carte\Library\bin\ogr2ogr.exe`, à
    relever en salle.
  ]
]

// --------------------------------------------
// Reprend la moitié droite de « Créer un environnement, et le décrire », 06/11/2026.
#d("Environnement : README ou environment.yml")[
  #annonce[
    Les commandes tapées au terminal ne sont enregistrées nulle part dans le projet. Pour refaire
    l'environnement ailleurs, il faut les décrire dans le `README`, ou dans un fichier lu par `conda`.
  ]

  #face-a-face(
    panneau("Dans la documentation")[
      #block(width: 100%, inset: (x: 10pt, y: 6pt), fill: gris,
             stroke: 0.8pt + gris.darken(15%))[
        #text(size: 13pt, fill: estompe)[à la racine du projet :] #h(8pt)
        #text(font: police-code, size: 12pt, weight: demi-gras)[README.md]
        #set text(size: 14pt)
        ```markdown
        ## Installation

        conda create -n carte -c conda-forge \
            python=3.12 gdal folium
        conda activate carte
        ```
      ]
      #text(size: 14pt, fill: estompe)[
        L'utilisateur lit le fichier, puis tape ces commandes.
      ]
    ],
    panneau("Dans un fichier lu par conda")[
      #block(width: 100%, inset: (x: 10pt, y: 6pt), fill: gris,
             stroke: 0.8pt + gris.darken(15%))[
        #text(size: 13pt, fill: estompe)[à la racine du projet :] #h(8pt)
        #text(font: police-code, size: 12pt, weight: demi-gras)[environment.yml]
        #set text(size: 14pt)
        ```yaml
        name: carte
        channels:
          - conda-forge
        dependencies:
          - python=3.12
          - gdal
          - folium
        ```
      ]
      #text(size: 14pt, fill: estompe)[
        `conda env create -f environment.yml` lit le fichier, et installe les paquets.
      ]
    ],
  )

  #legende[
    Les deux fichiers accompagnent le code, dans la copie du dossier ou dans le dépôt git.
  ]

  #notes[
    À gauche, on tape ; à droite, `conda` lit un fichier que quelqu'un a écrit, le plus souvent
    soi-même la semaine d'avant. Le résultat est le même environnement.

    Le `README` : cours 2. Ce sont les deux cas de « Distribution du code : nouveau poste », partie 1.

    `-c conda-forge` correspond à la ligne `channels` du fichier.

    Le fichier n'installe rien : il dit ce qu'il faut installer. Écrire la liste
    complète des paquets réellement posés la figerait et l'attacherait à un système,
    les paquets compilés n'étant pas les mêmes sous Windows et sous Linux.

    Le fichier se range avec le code : quelques lignes de texte. Le versionner est le
    sujet du cours 2.

    `conda env export` donne la version exacte de chaque paquet : ne pas y entrer.

    Piège du YAML, à mentionner si quelqu'un tape le fichier : deux espaces
    d'indentation, jamais de tabulation, et l'éditeur le signale.
  ]
]

// --------------------------------------------
#d("Projet : déclaration des informations & métadonnées")[
  #annonce[
    Un projet Python se décrit dans un fichier, `pyproject.toml`. `pip install .` lit ce fichier
    dans le dossier courant, puis installe le projet et ses dépendances.
  ]

  #face-a-face(
    panneau[`pyproject.toml`, à la racine du projet][
      #set text(size: 14pt)
      ```toml
      [project]
      name = "carte-trace"
      version = "0.1"
      requires-python = ">=3.10"
      dependencies = ["folium>=0.20"]

      [tool.setuptools]
      py-modules = ["carte_trace", "stats_trace"]
      ```
    ],
    panneau("Rôle de chaque ligne")[
      #show table.cell: set text(size: 15pt)
      #tableau(
        columns: (auto, 1fr),
        align: left + horizon,
        [Clé], [Rôle],
        [`name`, `version`], [le nom et la version du projet],
        surligne[`dependencies`], surligne[les bibliothèques à installer],
        [`requires-python`], [les versions de Python acceptées],
        [`py-modules`], [les fichiers du projet à installer],
      )
    ],
  )

  #v(0.3em)
  #terminal(
    taille: 15pt,
    "$ pip install .",
    "Successfully installed … carte-trace-0.1 … folium-0.20.0 … xyzservices-2026.9.1",
  )

  #notes[
    Sortie réelle, raccourcie, dans un environnement réduit à Python. Dans `pip install .`, le point
    désigne le dossier courant.

    La bibliothèque standard ne se déclare pas : `pathlib` et `subprocess` viennent
    avec Python.

    `pyproject.toml` s'écrit en TOML : des sections entre crochets, une valeur par nom.

    Troisième usage du texte, après le code et la documentation : décrire. YAML et
    TOML décrivent des données, comme `.json`, et acceptent des commentaires, ce
    qui explique qu'un humain les écrive.

    Sans `[tool.setuptools]`, `pip install .` échoue sur ce dossier, qui contient deux modules :
    essayé le 06/11/2026.

    Boucler la partie : le code réutilisé au début de la séance est disponible
    parce que quelqu'un a écrit un fichier de cette forme, puis déposé le résultat
    sur un dépôt.

    Ne pas détailler `[build-system]`, absent de l'extrait : aucun projet
    ordinaire n'a à en changer.
  ]
]

// --------------------------------------------
// Nouveau, 06/11/2026. Reprend la légende et les notes de l'ancienne page sur `pyproject.toml`.
#d("Fichiers de projet : environment.yml et pyproject.toml")[
  #annonce[
    Le projet GDAL ne publie pas `ogr2ogr` sur PyPI, et `carte_trace.py` a donc besoin de
    `environment.yml`. Un projet dont toutes les dépendances sont sur PyPI peut se limiter à
    `pyproject.toml`.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [`environment.yml`], [`pyproject.toml`],
    [Lu par], [`conda`], [`pip`],
    [Contenu], [Python, bibliothèques et programmes], [paquets de PyPI, nom et version du projet],
    [`folium`], [déclaré], [déclaré],
    [GDAL et `ogr2ogr`], [déclarés], [absents],
    [Commande], [`conda env create -f environment.yml`], [`pip install .`],
  )

  #notes[
    Un même projet peut contenir les deux fichiers. Dans l'environnement `carte`, `pip install .`
    trouve `folium` déjà installé par `conda`, et n'installe que `carte-trace` : essayé le
    06/11/2026.

    `environment.yml` s'écrit en YAML, où l'indentation porte la structure.
  ]
]

// --------------------------------------------
// Nouveau, 06/11/2026. Reprend les deux postes de « Distribution du code : nouveau poste », partie 1.
#d("Distribution du code : commandes sur un nouveau poste")[
  #annonce[
    Sur le nouveau poste, `conda` recrée l'environnement à partir de `environment.yml`. Le programme
    s'exécute ensuite comme sur le poste de développement.
  ]

  #grid(
    columns: (1fr, 1fr), column-gutter: 14pt, align: top,
    poste("Sans environnement", "C:/Users/eleve/projet/", "carte_trace.py, stats_trace.py, trace_2.gpx",
      "$ python carte_trace.py trace_2.gpx\nModuleNotFoundError: No module named 'folium'\n# une fois folium installé :\nFileNotFoundError: [Errno 2] No such file or\ndirectory: 'ogr2ogr'",
      erreur: true),
    poste("Avec environment.yml", "C:/Users/eleve/projet/", "carte_trace.py, stats_trace.py, trace_2.gpx, environment.yml",
      "$ conda env create -f environment.yml\n…\n$ conda activate carte\n(carte) $ python carte_trace.py trace_2.gpx\ndistance parcourue : 632.3 m\nvitesse moyenne : 1.29 m/s, soit 4.6 km/h\ncarte écrite : trace_2.html"),
  )

  #legende[
    Le dossier du projet arrive par une copie, ou par `git clone`. Sorties réelles sous Linux,
    raccourcies.
  ]

  #notes[
    Répond à « Distribution du code : nouveau poste » et à « Distribution du code : étapes sur
    chaque poste », partie 1 : y revenir.

    Essayé le 06/11/2026 sous Linux, dans un dossier neuf, avec ce fichier : 103 paquets, 547 Mo,
    13 s avec des paquets déjà téléchargés. Le temps sur un poste de la salle reste à relever.

    La distribution du code par une forge : cours 6.
  ]
]

// --------------------------------------------
// Ajoutée le 10/11/2026 : les commandes conda de la partie et des TD 5b à 5d, réunies avant les
// TD. Syntaxe et sorties de `conda env list` et `conda list` vérifiées avec conda 24.7.
#d("Commandes conda : résumé")[
  // Les commandes du tableau, plus grandes que le code de la légende.
  #show table.cell: set text(size: 14.5pt)
  #{
    show raw: set text(size: 13pt)
    tableau(
      columns: (auto, 1fr),
      align: left + horizon,
      [Commande], [Effet],
      [`conda create -n carte python=3.12 gdal`], [crée le dossier de l'environnement `carte`, et y installe ces paquets],
      [`conda env create -f environment.yml`], [crée l'environnement que décrit le fichier],
      [`conda activate carte`], [sélectionne `carte` dans ce terminal, en plaçant son dossier en tête de `PATH`],
      [`conda install ipykernel`], [installe un paquet dans l'environnement actif],
      [`conda list`], [liste les paquets de l'environnement actif, avec leur version],
      [`conda deactivate`], [revient à l'environnement précédent],
      [`conda env list`], [liste les environnements ; `*` marque l'environnement actif],
      [`conda env remove -n carte`], [supprime le dossier de l'environnement],
    )
  }

  #legende[
    `-n carte` désigne un environnement sans l'activer, comme dans `conda install -n carte ipykernel`.
    `-c conda-forge` désigne le dépôt des paquets. Dans un environnement actif, `pip install` écrit
    aussi dans son dossier.
  ]

  #notes[
    Les TD 5b à 5d emploient ces commandes : `conda env list` et `conda deactivate` aux TD 5b et
    5c, `conda env remove` au TD 5c, `conda install -c conda-forge ipykernel` au TD 5d.

    `conda list` affiche le nom, la version, la construction et le dépôt de chaque paquet.

    Dans la salle, ajouter `-c conda-forge` à `conda create` et à `conda install` : Anaconda
    installe sinon depuis son propre dépôt.
  ]
]
