// Cours 5 v2, partie 1 : l'objectif de la séance, et les deux dépendances qu'il révèle.
// Incluse par `cours5_v2.typ`.
//
// Nouveau (06/11/2026) : la séance part d'un objectif, le résumé et la carte d'une trace
// GPX, à la place de l'exemple de la recette et de pandoc. `subprocess` et les origines
// des bibliothèques sont repris des anciennes parties, et tiennent ici sur quatre
// diapositives.
//
// Programme : `data/cours5_v2/programme/carte_trace.py`, avec `stats_trace.py` de la fin
// du TD 4a. Sorties relevées le 06/11/2026 sous Linux, Python 3.12, GDAL 3.13.3, folium
// 0.20. Rien n'a tourné sur un poste de la salle.
#import "../../../commun/prelude.typ": *
#import "../../../cours3/diapo/schemas.typ": code-commente, sortie
#import "../../../cours1_v2/diapo/schemas.typ": terminal

#separateur(
  "Du fichier GPX à la carte",
  annonce: "L'objectif de la séance, et ce dont le programme a besoin pour l'atteindre.",
)

// --------------------------------------------
#d("Trace GPX : résumé et carte")[
  #annonce[
    Une montre ou un téléphone enregistre une trace dans un fichier GPX. Objectif de la
    séance : obtenir à partir de ce fichier le résumé du TD 4a et une carte.
  ]

  #grid(
    columns: (1fr, auto), column-gutter: 16pt, align: top,
    terminal(
      taille: 16pt,
      "$ python carte_trace.py trace_2.gpx",
      "altitude minimale : 91.3 m",
      "altitude maximale : 99.7 m",
      "max - min : 8.4 m",
      "cumul en hausse : 29.2 m",
      "cumul en baisse : 26.9 m",
      "distance parcourue : 632.3 m",
      "vitesse moyenne : 1.29 m/s, soit 4.6 km/h",
      "carte écrite : trace_2.html",
    ),
    image("/src/cours5_v2/images/carte_trace_2.png", height: 205pt),
  )

  #legende[
    `trace_2.html`, ouvert dans un navigateur, sur le Plan IGN. De la gare de
    Noisy-Champs à Geodata Paris : marche simulée sur un chemin réel.
  ]

  #notes[
    À dire en ouvrant la séance : le programme du cours 4 lit un CSV ; une montre donne
    un GPX. Toute la séance sert à faire fonctionner cette commande, ici puis sur un
    autre poste.

    Le résumé est celui du TD 4a. La page charge Leaflet et les tuiles à l'affichage :
    le navigateur a besoin du réseau.

    À vérifier depuis une VM de la salle : l'accès à `data.geopf.fr` et au CDN de
    Leaflet.
  ]
]

// --------------------------------------------
#d("Du fichier GPX au résumé et à la carte")[
  #annonce[
    `carte_trace.py` enchaîne deux conversions et deux traitements. Il s'appuie sur
    `ogr2ogr`, un programme en ligne de commande, et sur `folium`, une bibliothèque
    Python.
  ]

  #chaine(
    ([`trace_2.gpx`], "positions en degrés"),
    ([`ogr2ogr`], "convertit en Lambert-93"),
    ([`trace_2.csv`], "positions en mètres"),
    ([`stats_trace.py`], "le résumé du TD 4a"),
  )

  #v(0.8em)
  #chaine(
    ([`trace_2.gpx`], "positions en degrés"),
    ([`ogr2ogr`], "convertit en GeoJSON"),
    ([`trace_2.geojson`], "la ligne de la trace"),
    ([`folium`], "écrit la page trace_2.html"),
  )

  #legende[
    `ogr2ogr` fait partie de GDAL, le logiciel libre de conversion de données
    géographiques. `folium` écrit une page web avec une carte Leaflet.
  ]

  #notes[
    La diapositive sert de plan à la partie : `ogr2ogr`, puis `folium`.
  ]
]

// --------------------------------------------
#d("Fichier GPX et fichier CSV")[
  #annonce[
    Un GPX donne les positions en degrés. La distance du TD 4a se calcule en mètres :
    `ogr2ogr` convertit les positions en Lambert-93, et écrit le CSV des TD 3 et 4.
  ]

  #face-a-face(
    panneau("Une position de trace_2.gpx")[
      #sortie("<trkpt lat=\"48.8434345\" lon=\"2.5817636\">\n  <ele>94.7</ele>\n  <time>2026-09-07T07:40:00Z</time>\n</trkpt>", taille: 12pt)
    ],
    panneau("Les mêmes valeurs dans trace_2.csv")[
      #sortie("X,Y,ele,time\n669304.8,6860457.7,94.7,2026/09/07 07:40:00+00", taille: 12pt)
    ],
  )

  #v(0.4em)
  #terminal(
    taille: 15pt,
    "$ ogr2ogr -f CSV trace_2.csv trace_2.gpx track_points -t_srs EPSG:2154 \\",
    "      -lco GEOMETRY=AS_XY -select ele,time -xyRes 0.1",
  )

  #legende[
    Le GPX est un fichier texte au format XML. Son `<trkpt>` tient sur une ligne, mis en
    page ici sur quatre.
  ]

  #notes[
    Le CSV obtenu est identique au `trace_2.csv` des TD 3 et 4 : essayé le 06/11/2026.

    Options : `-f CSV` le format de sortie ; `track_points` la couche des positions du
    GPX ; `-t_srs EPSG:2154` le système de coordonnées, Lambert-93 ; `-lco
    GEOMETRY=AS_XY` les colonnes `X` et `Y` ; `-select` les colonnes gardées ; `-xyRes
    0.1` les coordonnées au décimètre, depuis GDAL 3.9.

    Documentation : gdal.org/programs/ogr2ogr.html.
  ]
]

// --------------------------------------------
#d("subprocess : appeler ogr2ogr depuis Python")[
  #annonce[
    La fonction `subprocess.run` lance un programme en ligne de commande depuis un
    programme Python. Elle reçoit la commande sous forme de liste : le nom du programme,
    puis ses arguments, un élément par mot.
  ]

  #tableau(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    align: left + horizon,
    [Dans le terminal], [`ogr2ogr`], [`-f`], [`CSV`], [`trace_2.csv`], [`trace_2.gpx`], [`…`],
    [Dans la liste Python], [`"ogr2ogr"`], [`"-f"`], [`"CSV"`], [`CSV`], [`GPX`], [`…`],
  )

  #v(0.4em)
  #sortie("commande = [\"ogr2ogr\", \"-f\", \"CSV\", CSV, GPX, \"track_points\", \"-t_srs\", \"EPSG:2154\",\n            \"-lco\", \"GEOMETRY=AS_XY\", \"-select\", \"ele,time\", \"-xyRes\", \"0.1\"]\nsubprocess.run(commande, check=True)", taille: 13pt)

  #legende[
    `subprocess` est livré avec Python. `check=True` lève une erreur Python en cas
    d'échec. `CSV` et `GPX` sont des chemins `Path`, que `subprocess.run` accepte
    directement.
  ]

  #notes[
    Liste : chaque élément est transmis au programme sans découpage,
    espaces et accents compris.

    Essayé le 06/11/2026 : un fichier absent lève `CalledProcessError` ; un
    programme introuvable, comme `ogr2ogrr`, lève `FileNotFoundError`.

    Python trouve `ogr2ogr` dans les dossiers de `PATH`, comme le terminal : partie
    « PATH et variables d'environnement ».

    Si la question vient : le module `osgeo`, livré avec GDAL, fait la même conversion
    en Python. La commande s'essaie d'abord au terminal, et le module n'enseigne pas
    l'interface de `osgeo`.
  ]
]

// --------------------------------------------
#d("subprocess : dossier courant et chemins")[
  #annonce[
    Un chemin relatif part du dossier courant, celui du terminal (cours 3). Le programme
    construit donc ses chemins à partir de l'argument `gpx` et de `__file__`.
  ]

  #code-commente(
    taille-code: 12pt, taille-texte: 12.5pt,
    ("GPX = Path(options.gpx)", "le chemin donné sur la ligne de commande"),
    ("CSV = GPX.with_suffix(\".csv\")", "`travail/trace_2.gpx` donne `travail/trace_2.csv`"),
    ("STATS = Path(__file__).parent / \"stats_trace.py\"", "le programme du TD 4a, à côté de ce script"),
    ("commande = [\"python\", STATS, CSV, \"--distance\", \"--vitesse\"]", "la commande, avec les deux chemins"),
    ("subprocess.run(commande, check=True)", "lance le programme du TD 4a"),
  )

  #v(0.5em)
  #terminal(
    taille: 16pt,
    "$ python travail/carte_trace.py travail/trace_2.gpx",
    "…",
    "vitesse moyenne : 1.29 m/s, soit 4.6 km/h",
    "carte écrite : travail/trace_2.html",
  )

  #legende[
    Sans `STATS`, la ligne `"stats_trace.py"` ne fonctionne que depuis le dossier du
    script.
  ]

  #notes[
    Dans une chaîne Python, `\t` est une tabulation : écrire les chemins
    avec `/` ou avec `Path`, jamais `"cours5\travail"`.

    `stats_trace.py` écrit `resume.txt` dans le dossier courant (TD 3c).
  ]
]

// --------------------------------------------
// Reprise de « Un programme s'appuie sur des bibliothèques » le 06/11/2026.
#d("Un programme s'appuie sur des bibliothèques")[
  #annonce[
    Un programme ne réécrit pas tout à partir de zéro. Il appelle des fonctions
    déjà écrites, regroupées en *bibliothèques*, qui ont trois origines.
  ]

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 12pt,
    rows: 108pt,
    bloc("Livrées avec Python", "la bibliothèque standard : argparse, subprocess, pathlib…", hauteur: 100%),
    bloc("Écrites pour le projet", "vos propres fichiers, importés les uns par les autres", hauteur: 100%),
    bloc("Publiées par d'autres", "folium, numpy, pillow… à installer depuis un dépôt de paquets", plein: true, hauteur: 100%),
  )

  #v(0.4em)
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Ce qu'on écrit], [Ce que cela demande],
    [`import subprocess`], [rien : installé avec l'interpréteur],
    [`import folium`], [que la bibliothèque ait été installée avant],
  )

  #notes[
    Un programme est court parce que presque tout ce qu'il fait est déjà écrit
    ailleurs : lire une trace, dessiner une carte. Ce qu'il écrit vraiment est
    l'assemblage.

    « Dépôt de paquets » traduit *repository* : conda-forge, PyPI, plus loin dans la
    séance.

    La troisième colonne coûte le plus : le programme marche ici et pas ailleurs tant
    qu'on n'a pas dit ce qu'il faut installer. D'où l'environnement et le fichier qui
    le décrit.

    Écarter « librairie », faux ami de *library*.
  ]
]

// --------------------------------------------
#d("folium : écrire la carte")[
  #annonce[
    `ogr2ogr` convertit le GPX en GeoJSON, dans `GEOJSON`. `folium` écrit ensuite une page
    web qui affiche cette ligne sur un fond de carte.
  ]

  #code-commente(
    taille-code: 12pt, taille-texte: 12.5pt,
    ("import folium", "la bibliothèque, à installer"),
    ("carte = folium.Map(tiles=PLAN_IGN, attr=\"Plan IGN\", max_zoom=18)", "la carte, sur le Plan IGN"),
    ("trace = folium.GeoJson(str(GEOJSON))", "la trace ; `folium` demande le chemin en chaîne"),
    ("trace.add_to(carte)", "ajoute la trace à la carte"),
    ("carte.fit_bounds(trace.get_bounds())", "cadre la carte sur la trace"),
    ("carte.save(CARTE)", "écrit la page `trace_2.html`"),
  )

  #legende[
    La conversion : `ogr2ogr -f GeoJSON trace_2.geojson trace_2.gpx tracks`. `PLAN_IGN`
    contient l'adresse des tuiles du service WMTS de l'IGN. Documentation :
    python-visualization.github.io/folium.
  ]

  #notes[
    Passer vite : le code ne fait pas l'objet de la séance, et l'élève ne l'écrit pas.

    `folium.GeoJson` essayé avec un `Path` le 06/11/2026 : `ValueError: Cannot render
    objects with any missing geometries`.
  ]
]

// --------------------------------------------
// Reprend le message de « L'import d'une bibliothèque et ses conditions ».
#d("Deux erreurs au premier lancement")[
  #annonce[
    Sur un poste qui n'a que Python, le programme s'arrête sur un
    `ModuleNotFoundError`. Une fois `folium` installé, il s'arrête sur un
    `FileNotFoundError`.
  ]

  #face-a-face(
    panneau("Une bibliothèque absente")[
      #terminal(
        taille: 13.5pt,
        "$ python carte_trace.py trace_2.gpx",
        "Traceback (most recent call last):",
        "  File \"carte_trace.py\", line 7, in <module>",
        "    import folium",
        "ModuleNotFoundError: No module named 'folium'",
      )
    ],
    panneau("Un programme absent")[
      #terminal(
        taille: 13.5pt,
        "$ python carte_trace.py trace_2.gpx",
        "Traceback (most recent call last):",
        "  …",
        "FileNotFoundError: [Errno 2] No such file or",
        "directory: 'ogr2ogr'",
      )
    ],
  )

  #v(0.4em)
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [`folium`], [`ogr2ogr`],
    [Nature], [une bibliothèque Python], [un programme en ligne de commande],
    [Appel], [`import folium`], [`subprocess.run(["ogr2ogr", …])`],
  )

  #legende[
    Sorties réelles, chemins raccourcis. La partie suivante montre où ces deux fichiers
    se trouvent, et où Python et le système les cherchent.
  ]

  #notes[
    Sous Linux, dans un environnement réduit à Python, puis à Python et `folium`. Sous
    Windows, le second message est attendu sous la forme `[WinError 2]`, à relever sur un
    poste de la salle.

    Le paquet `anaconda` 2025.06 (win-64) ne contient ni `gdal` ni `folium` : les deux
    erreurs sont attendues en salle. La version installée sur les postes reste à
    confirmer.

    Python s'arrête d'abord sur l'import, car il est en tête du programme.
  ]
]
