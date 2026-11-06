// Partie 3 du cours 5 v2 : bibliothèques et autres dépendances. Incluse par `cours5_v2.typ`.
//
// Réorganisée le 06/11/2026 : le besoin (origines, exemple, échec de l'import) ; l'installation et
// la recherche (`pip`, dossier d'une distribution, `sys.path`, lien avec `PATH`) ; les outils
// (`pip` et `conda`, dépôts, repères) ; les dépendances et leurs versions, qui amènent les conflits
// de la partie 4. Textes repris en partie de la partie 4 du cours 1 de 2026.
//
// Sorties et déclarations de paquets relevées le 06/11/2026 sous Linux, Python 3.12, dans un
// environnement virtuel réduit à Python. L'arborescence Windows de « Dossier d'une distribution
// Python » est attendue, d'après les paquets win-64 de conda-forge (`Library/bin/ogr2ogr.exe`,
// `Lib/site-packages/osgeo/`), et reste à relever.
//
// `left-pad` : Wikipédia, « npm left-pad incident » ; blog de npm, « kik, left-pad, and npm »,
// 23 mars 2016.
//
// Wheels et dépendances compilées, lus le 06/11/2026 : Python Packaging User Guide, « Package
// Formats » ; pypackaging-native, « Native dependencies » et « The Geospatial stack » (2022) ;
// PEP 725, à l'état de brouillon ; documentations de GDAL, de `pyogrio` et de conda. Fichiers
// publiés : API JSON de PyPI, le même jour.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../../../cours3/diapo/schemas.typ": code-commente
#import "../../../cours3_v2/diapo/schemas.typ": arborescence
#import "../../../cours1_v2/diapo/schemas.typ": terminal
#import "../schemas.typ": schema-depots-carte, schema-version-jinja2

// --------------------------------------------
#d("Bibliothèques : origines")[
  #annonce[
    Un programme appelle des fonctions déjà écrites, regroupées en *bibliothèques*.
  ]

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 12pt,
    rows: 108pt,
    bloc("Livrées avec Python", "la bibliothèque standard : argparse, subprocess, pathlib…", hauteur: 100%),
    bloc("Écrites pour le projet", "vos propres fichiers, importés les uns par les autres", hauteur: 100%),
    bloc("Publiées par d'autres", "folium, numpy, pillow… à installer avant l'import", plein: true, hauteur: 100%),
  )

  #notes[
    Rappel de « Bibliothèque standard de Python », cours 3 : `argparse` et `pathlib`, puis
    `math` et `datetime` au TD 4a.

    Un programme est court parce que presque tout ce qu'il fait est déjà écrit
    ailleurs : lire une trace, dessiner une carte. Ce qu'il écrit vraiment est
    l'assemblage.

    La troisième colonne coûte le plus : le programme marche ici et pas ailleurs tant
    qu'on n'a pas dit ce qu'il faut installer. D'où l'environnement et le fichier qui
    le décrit.

    Écarter « librairie », faux ami de *library*.
  ]
]

// --------------------------------------------
#d("Exemple d'import de bibliothèque : folium")[
  #annonce[
    `folium` écrit une page web qui affiche une trace sur un fond de carte. Le programme importe
    la bibliothèque, puis appelle ses fonctions.
  ]

  #code-commente(
    taille-code: 12pt, taille-texte: 12.5pt,
    ("import folium", "la bibliothèque, à installer"),
    ("carte = folium.Map(tiles=PLAN_IGN, attr=\"Plan IGN\", max_zoom=18)", "la carte, sur le Plan IGN"),
    ("trace = folium.GeoJson(str(FICHIER_GEOJSON))", "la trace ; `folium` demande le chemin en chaîne"),
    ("trace.add_to(carte)", "ajoute la trace à la carte"),
    ("carte.fit_bounds(trace.get_bounds())", "cadre la carte sur la trace"),
    ("carte.save(FICHIER_CARTE)", "écrit la page `trace_2.html`"),
  )

  #legende[
    `FICHIER_GEOJSON` contient la trace, convertie par
    `ogr2ogr -f GeoJSON trace_2.geojson trace_2.gpx tracks`. `PLAN_IGN` contient l'adresse des
    tuiles du service WMTS de l'IGN. Documentation : python-visualization.github.io/folium.
  ]

  #notes[
    Passer vite : le code ne fait pas l'objet de la séance, et l'élève ne l'écrit pas.

    `folium.GeoJson` essayé avec un `Path` le 06/11/2026 : `ValueError: Cannot render
    objects with any missing geometries`.
  ]
]

// --------------------------------------------
#d("Import : bibliothèque standard ou à installer")[
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
      import folium
      ```
      ```
      ModuleNotFoundError:
      No module named 'folium'
      ```
      #text(size: 14pt, fill: estompe)[
        `folium`, `numpy`, `pillow` : il faut les installer, et savoir
        lesquelles.
      ]
    ],
  )

  #legende[
    Sorties réelles dans un environnement réduit à Python.
  ]

  #notes[
    Tout le reste de la partie répond à la colonne de droite. Y revenir si la salle
    décroche sur les fichiers de description.

    La bibliothèque livrée avec Python s'appelle la *bibliothèque standard* : `import
    subprocess`, en partie 2, ne demande que l'interpréteur.

    Cause du message : aucun dossier où Python cherche ne contient `folium`. La recherche vient
    plus loin dans la partie.

    Ni `numpy`, ni `pillow`, ni `pandas` ne font partie de la bibliothèque standard,
    et ce sont les outils du métier.
  ]
]

// --------------------------------------------
// Nouveau, 06/11/2026. Sorties relevées ce jour-là dans un environnement virtuel réduit à Python.
#d("Installation d'une bibliothèque : pip")[
  #annonce[
    Un *paquet* (_package_) contient une bibliothèque, prête à installer. `pip` télécharge le
    paquet depuis le dépôt PyPI, et copie ses fichiers dans le dossier de la distribution Python.
  ]

  #terminal(
    taille: 20pt,
    "$ pip install folium      # avec conda : conda install -c conda-forge folium",
    "Successfully installed branca-0.8.2 … folium-0.20.0 … xyzservices-2026.9.1",
    "$ python -c \"import folium; print(folium.__version__)\"",
    "0.20.0",
    "$ pip show folium",
    "Name: folium",
    "Version: 0.20.0",
    "Location: …/lib/python3.12/site-packages",
    "Requires: branca, jinja2, numpy, requests, xyzservices",
  )

  #legende[
    Sorties réelles, raccourcies. Le commentaire, après `#`, donne la même installation avec
    `conda`, présentée plus loin dans la partie.
  ]

  #notes[
    `Location` : le dossier où `pip` a écrit, diapositive suivante. `Requires` : les dépendances,
    plus loin dans la partie.

    Essayé le 06/11/2026 sous Linux.

    Dans la salle, `C:\ProgramData\anaconda3` n'est probablement pas modifiable par les élèves.
    `pip` installe alors dans un `site-packages` du compte, et `sys.path` compte un dossier de
    plus : attendu, à relever en salle.
  ]
]

// --------------------------------------------
#d("Dossier d'une distribution Python")[
  #annonce[
    Une distribution, comme Anaconda ou Miniforge, est installée dans un seul dossier.
    L'interpréteur, les programmes en ligne de commande et les bibliothèques y ont chacun
    leur sous-dossier.
  ]

  #face-a-face(
    panneau("Windows, avec Anaconda")[
      #arborescence(
        (0, "anaconda3/"),
        (1, "python.exe", "l'interpréteur"),
        (1, "Scripts/", "`pip.exe`, `conda.exe`"),
        (1, "Library/bin/", "`ogr2ogr.exe`"),
        (1, "Lib/", "la bibliothèque standard"),
        (2, "argparse.py, json/"),
        (2, "site-packages/", "*les bibliothèques installées*"),
        (3, "folium/"),
        (3, "numpy/"),
        taille: 12pt,
      )
    ],
    panneau("Linux et macOS, avec Miniforge")[
      #arborescence(
        (0, "miniforge3/"),
        (1, "bin/", "`python`, `pip`, `ogr2ogr`"),
        (1, "lib/python3.12/", "la bibliothèque standard"),
        (2, "argparse.py, json/"),
        (2, "site-packages/", "*les bibliothèques installées*"),
        (3, "folium/"),
        (3, "numpy/"),
        taille: 12pt,
      )
    ],
  )

  #legende[
    Un environnement conda a la même organisation : partie 4. `sys.prefix` donne le dossier de
    la distribution, et `sys.executable` le chemin de l'interpréteur. Dans la salle :
    `C:\ProgramData\anaconda3`.
  ]

  #notes[
    `conda install` et `pip install` écrivent dans ces dossiers : installer revient à y
    copier des fichiers.

    Le TD 5a fait relever ces chemins sur le poste. Le paquet GDAL pose `ogr2ogr.exe` dans
    `Library\bin\ ` et le module `osgeo` dans `Lib\site-packages\ `. `ogr2ogr` n'apparaît qu'une
    fois GDAL installé.

    Environnement d'essai sous Linux, avec Python, GDAL et folium : 250 programmes dans
    `bin/`, 109 entrées dans `site-packages/`.
  ]
]

// --------------------------------------------
#d("sys.path : recherche d'une bibliothèque")[
  #annonce[
    `import` cherche le module dans les dossiers de la liste `sys.path`, dans l'ordre, et
    charge le premier fichier de ce nom.
  ]

  #face-a-face(
    panneau("Ordre de recherche")[
      #show table.cell: set text(size: 15pt)
      #tableau(
        entete: false,
        columns: (auto, 1fr),
        align: left + horizon,
        [1], [le dossier du script],
        [2], [les dossiers de `PYTHONPATH`, une variable d'environnement souvent absente],
        [3], [la bibliothèque standard],
        [4], [les bibliothèques installées, dans `site-packages`],
      )
    ],
    panneau("Un dossier ajouté par PYTHONPATH")[
      #terminal(
        taille: 15pt,
        "$ export PYTHONPATH=\"$PWD/mes_modules\"",
        "$ python -c \"import sys; print(*sys.path, sep='\\n')\"",
        "",
        "…/projet/mes_modules",
        "…/lib/python312.zip",
        "…/lib/python3.12",
        "…/lib/python3.12/lib-dynload",
        "…/lib/python3.12/site-packages",
        "$ python -c \"import folium; print(folium.__file__)\"",
        "…/lib/python3.12/site-packages/folium/__init__.py",
      )
    ],
  )

  #legende[
    Sorties réelles sous Linux, chemins raccourcis. La ligne vide désigne le dossier
    courant. Quand Python lance un fichier, le dossier de ce fichier en prend la place.
    `PYTHONPATH` contient une liste de dossiers, séparés comme ceux de `PATH`.
  ]

  #notes[
    `python -c` exécute le texte qui suit. `*` passe les éléments de la liste à `print`,
    un par un : ne pas s'y attarder.

    `__file__` : le chemin du fichier, déjà vu au cours 3 pour le script.

    `python312.zip` et `lib-dynload` complètent la bibliothèque standard : ne pas s'y attarder.

    Essayé le 06/11/2026 : `import mon_module` échoue sans `PYTHONPATH`, et réussit avec le dossier
    `mes_modules` dans `PYTHONPATH`. Un projet installe ses modules avec `pip install .` :
    partie 4. `PYTHONPATH` sert surtout à un essai.

    Sous Windows, liste attendue, à relever : `python312.zip`, `DLLs`, `Lib`, le dossier de
    la distribution, `Lib\site-packages`.

    `sys.path` dépend de l'interpréteur lancé : partie suivante.
  ]
]

// --------------------------------------------
#d("Recherche d'une bibliothèque et d'un programme")[
  #annonce[
    Python cherche une bibliothèque dans `sys.path`. Le système cherche un programme dans
    `PATH`. Les deux erreurs vues sur l'autre poste viennent de ces deux recherches.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [`folium`], [`ogr2ogr`],
    [Nature], [une bibliothèque Python], [un programme en ligne de commande],
    [Appel], [`import folium`], [`subprocess.run(["ogr2ogr", …])`],
    [Recherche dans], [`sys.path`], [`PATH`],
    [Ajout d'un dossier], [`PYTHONPATH`], [`PATH`],
    [Installation dans], [`Lib\site-packages\ `, `lib/python3.12/site-packages/`], [`Library\bin\ `, `bin/`],
    [Si le fichier est absent], [`ModuleNotFoundError`], [`FileNotFoundError`],
  )

  #notes[
    `PATH` n'explique pas `import` : une question revient souvent à ce sujet.

    Le lien entre les deux recherches : `PATH` désigne `python`, et `python` détermine
    `sys.path`.
  ]
]

// --------------------------------------------
// Nouveau, 06/11/2026, à la suite d'une remarque de Nicolas : la différence ne tient pas à la
// présence de code compilé. Fichiers relevés ce jour-là sur PyPI, essais sous Linux.
#d("Paquets sur PyPI : wheels et sources")[
  #annonce[
    Un projet peut publier sur PyPI ses sources et des archives prêtes à installer, les *wheels*.
    `pip` choisit le wheel adapté au poste, et compile les sources s'il n'en trouve aucun.
  ]

  #show table.cell: set text(size: 15pt)
  #tableau(
    columns: (auto, 1fr, 1fr, 1.1fr),
    align: left + horizon,
    [Paquet], [Contenu], [Fichiers sur PyPI], [Effet de `pip install`],
    [`folium`], [code Python], [1 wheel, pour tous les systèmes], [copie les fichiers du wheel],
    [`numpy`], [code Python et code compilé], [65 wheels, selon le système et la version de Python], [copie les fichiers du wheel adapté],
    [`ruff`], [un programme compilé], [17 wheels, selon le système], [copie le programme dans `bin/`],
    [`gdal`], [le module `osgeo`, à compiler], [les sources seules], [compile le module, si `libgdal` et un compilateur sont déjà sur le poste],
  )

  #legende[
    Fichiers relevés sur PyPI le 06/11/2026 : aucune des 98 versions de `gdal` n'a de wheel. Un wheel
    contient aussi les bibliothèques compilées qu'il appelle, par exemple 27 Mo dans `numpy.libs/`.
  ]

  #notes[
    Le nom d'un wheel indique où il s'installe. `folium-0.20.0-py2.py3-none-any.whl` : tout Python 3,
    tout système. `numpy-2.5.4-cp312-cp312-manylinux_2_27_x86_64….whl` : Python 3.12, Linux, x86-64.

    Un wheel compilé s'installe sans compilateur sur le poste. Un code compilé dépend du système, du
    processeur et souvent de la version de Python, d'où les 65 wheels de `numpy`.

    `ruff` vérifie le style du code Python : ici, un exemple de programme livré par un wheel. Essayé
    le 06/11/2026 : `pip install ruff`, puis `ruff --version`. Sous Windows, `Scripts\ ` à la place de
    `bin/`.

    Un paquet peut donc contenir du code compilé et un programme. La question suivante porte sur ce
    que publie le projet GDAL.
  ]
]

// --------------------------------------------
// Nouveau, 06/11/2026, repris le même jour après lecture des références de l'en-tête. Sorties
// relevées sous Linux, dans un environnement virtuel réduit à Python, puis dans un environnement conda.
#d("pip et conda : folium et GDAL")[
  #annonce[
    Un paquet PyPI ne peut déclarer que des paquets PyPI, et `libgdal` n'y figure pas. Un paquet conda
    peut contenir des bibliothèques compilées et des programmes.
  ]

  #show table.cell: set text(size: 15pt)
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [PyPI, avec `pip`], [conda-forge, avec `conda`],
    [`osgeo`, le module Python], [`gdal`, sources à compiler], [`gdal`],
    [`libgdal`, la bibliothèque compilée], [absente], [`libgdal-core`],
    [`ogr2ogr`, le programme], [absent], [`libgdal-core`],
    [PROJ, GEOS et autres bibliothèques], [impossibles à déclarer], [30 paquets déclarés],
  )

  #v(0.2em)
  #terminal(
    taille: 14pt,
    "$ pip install gdal",
    "Could not find gdal-config. Make sure you have installed the GDAL native library and development headers.",
    "$ conda install -c conda-forge gdal folium",
    "$ ogr2ogr --version",
    "GDAL 3.13.3 \"Iowa City\", released 2026/08/13",
  )

  #legende[
    Sorties réelles, raccourcies, sous Linux. Avec `libgdal`, ses fichiers d'en-tête et un compilateur
    déjà sur le poste, `pip install gdal` réussit en 18 s, et n'installe pas `ogr2ogr`.
  ]

  #notes[
    Les dépendances d'un programme ne sont pas toutes écrites en Python : `ogr2ogr`, et les
    bibliothèques compilées de GDAL et de PROJ.

    `pip install gdal` compile les sources. Le script d'installation appelle `gdal-config`, un
    programme livré avec `libgdal`, et lève le même `FileNotFoundError` que `carte_trace.py` sans
    `ogr2ogr`. Sous Windows, le message reste à relever.

    Essayé le 06/11/2026 : `gdal` compilé avec le `libgdal` d'un environnement conda, puis
    `from osgeo import gdal` réussit, et aucun programme de GDAL n'apparaît dans `bin/`.

    Si la question vient, des wheels contiennent GDAL. `pip install pyogrio` copie `libgdal` dans
    `pyogrio.libs/` : 80 Mo, GDAL 3.12.4, 64 formats dont GPX, sans `ogr2ogr`. Sa documentation
    précise que ces wheels ne contiennent pas tous les formats. Chaque paquet garde sa propre copie
    de la bibliothèque, et des versions différentes peuvent se rencontrer dans un même environnement.

    Références : pypackaging-native, « dependencies on libraries that are not on PyPI cannot be
    expressed » ; PEP 725, à l'état de brouillon, propose une façon de les déclarer.

    Le module emploie `conda` pour cette raison.
  ]
]

// --------------------------------------------
#d("Dépôts de paquets : PyPI et conda-forge")[
  #annonce[
    Une commande d'installation va chercher le paquet dans un dépôt. Les deux
    que vous croiserez n'y laissent pas entrer la même chose.
  ]

  #align(center, schema-depots-carte())

  #legende[
    Les deux ne s'opposent pas : un paquet conda-forge est le plus souvent
    construit à partir de PyPI, quelques jours plus tard. Projets relevés le
    8 septembre 2026 dans l'index de PyPI, recettes conda-forge le même jour.
  ]

  #notes[
    « Dépôt de paquets » traduit *repository*.

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
#d("Outils d'installation : repères")[
  #annonce[
    Plusieurs outils existent et l'écosystème évolue encore. Ici on utilise
    `conda` pour l'environnement et les dépendances, et `pip` pour installer
    le projet lui-même en local.
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

    `pip` installe ce que PyPI publie. `conda` installe aussi Python lui-même et des bibliothèques
    système, avec leurs dépendances. `pyenv` choisit la version de Python active et n'installe aucun
    paquet ; il figure dans la légende parce que son nom prête à confusion.

    `uv` et `pixi`, récents et écrits en Rust, résolvent les dépendances en quelques
    secondes : `uv` du côté de `pip`, `pixi` de celui de conda. Hors programme, le
    module s'en tenant à un seul outil.

    Le dernier outil ne remplace pas les autres : `pip` a dix-huit ans, reste le plus
    employé, et est installé dans l'environnement du module.

    Dans un environnement conda, éviter d'installer un même paquet avec les deux outils.
  ]
]

// --------------------------------------------
// Refaite le 06/11/2026 sur `folium`, à la place des chiffres du cours 1 de 2026. Déclarations
// relevées ce jour-là avec `importlib.metadata`.
#d("Installation de bibliothèques : les dépendances")[
  #annonce[
    Une bibliothèque déclare d'autres bibliothèques, qui en déclarent à leur tour. `pip` et `conda`
    lisent ces déclarations, et installent la liste complète.
  ]

  #grid(
    columns: (1.05fr, 0.95fr), column-gutter: 22pt, align: top,
    panneau("Dépendances déclarées par folium")[
      #arborescence(
        (0, "folium"),
        (1, "branca"),
        (2, "jinja2"),
        (3, "markupsafe"),
        (1, "jinja2", "déjà dans la liste"),
        (1, "numpy"),
        (1, "requests"),
        (2, "certifi, charset-normalizer"),
        (2, "idna, urllib3"),
        (1, "xyzservices"),
        taille: 11.5pt,
      )
    ],
    panneau("Installation de ces 11 paquets")[
      #show table.cell: set text(size: 15pt)
      #tableau(
        entete: false,
        columns: (auto, 1fr),
        align: left + horizon,
        [À la main], [copier `folium` dans `site-packages`, puis ses dépendances, puis les dépendances de ces dépendances],
        [Avec un outil], [taper `pip install folium` : `pip` lit les déclarations et copie les 11 paquets],
      )
    ],
  )

  #text(size: 15pt, fill: attention)[
    Chaque dépendance ajoute des paquets à installer et des versions à suivre. Il faut donc trouver
    un compromis entre tout recoder et installer une dépendance pour chaque besoin.
  ]

  #notes[
    Les 5 paquets déclarés par `folium` sont ses dépendances _directes_, les 5 autres sont
    _transitives_. La relation est récursive : la même règle s'applique à chaque paquet atteint,
    jusqu'à n'en plus trouver de nouveau. Personne ne garde cette liste à la main, d'où l'outil.

    Sur l'exemple de la séance : conda calcule 91 paquets pour `python=3.12 gdal folium` sous
    Windows, sur conda-forge (relevé le 06/11/2026).

    Compromis. Une dépendance évite d'écrire et de tester du code. Elle ajoute aussi du code écrit
    par d'autres, à maintenir à jour et à surveiller : cours 6. Quelques lignes faciles à écrire et
    à tester peuvent rester dans le projet : la moyenne du cours 3 n'appelle aucune bibliothèque.
    Une carte web ou une conversion de coordonnées justifient une bibliothèque.

    Cas connu : `left-pad`, 11 lignes de JavaScript, retiré de npm par son auteur le 22 mars 2016.
    Des milliers de projets, dont Babel et React, ne s'installaient plus. La panne a duré 2 h 30.
  ]
]

// --------------------------------------------
// Sépare en deux l'ancienne « Installation de bibliothèques : les dépendances », le 06/11/2026.
#d("Dépendances : résolution des versions")[
  #annonce[
    `site-packages` contient une seule version de chaque paquet. `pip` et `conda` choisissent ces
    versions à partir de toutes les exigences déclarées : cette étape s'appelle la *résolution*.
  ]

  #grid(
    columns: (1fr, 1fr), column-gutter: 18pt, align: horizon,
    align(center, scale(70%, reflow: true, schema-version-jinja2())),
    terminal(
      taille: 15pt,
      "$ pip install \"branca==0.8.2\" \"jinja2<3\"",
      "…",
      "ERROR: Cannot install branca==0.8.2 and jinja2<3",
      "because these package versions have conflicting",
      "dependencies.",
      "The conflict is caused by:",
      "    The user requested jinja2<3",
      "    branca 0.8.2 depends on jinja2>=3",
      "…",
      "ERROR: ResolutionImpossible",
    ),
  )

  #legende[
    À droite, `jinja2<3` contredit l'exigence de `branca 0.8.2`, et `pip` s'arrête sans rien
    installer. Sorties réelles, raccourcies.
  ]

  #notes[
    Le même paquet n'apparaît qu'une fois dans `site-packages`. Ici les deux exigences se
    recouvrent, et `jinja2 3.1.6` convient aux deux.

    Sans `branca==0.8.2`, `pip` trouve une solution avec des versions plus anciennes :
    `pip install --dry-run folium "jinja2<3"` propose `branca-0.7.0` et `Jinja2-2.11.3`, relevé le
    06/11/2026. Le terminal impose `branca` pour montrer le cas sans solution.

    Le mot « conflit » ne désigne pas une panne : le cas est ordinaire, et `pip` ou `conda` trouve
    presque toujours une solution. La résolution explique en partie la durée d'une installation
    avec `conda`.
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
