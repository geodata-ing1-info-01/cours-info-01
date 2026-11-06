// Diapositives de la partie 4 du cours 5 v2 sorties le 06/11/2026, à replacer ou à couper. Ce
// fichier n'est inclus nulle part. Il se compile seul :
//
//   typst compile --root . src/cours5_v2/diapo/a_reprendre/environnement.typ
//
// Texte déplacé sans modification. Déjà repris en v2 : une phrase sur `PROJ_DATA` dans les notes
// de « Activation d'un environnement : effet sur PATH ».
#import "../../../commun/prelude.typ": *
#import "../../../cours3/diapo/schemas.typ": code-commente
#import "../../../cours1_v2/diapo/schemas.typ": terminal

#show: diapos.with(
  titre-court: "Environnement : diapositives à replacer",
  auteur-court: "cours 5 v2, 06/11/2026",
)

#d("Diapositives d'environnement à replacer")[
  #show table.cell: set text(size: 14pt)
  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
    [Diapositive], [Raison du retrait],
    [Variable lue par un programme : PROJ_DATA], [détail technique, sans lien direct avec la distribution du programme],
    [pyproject.toml : du fichier à la commande], [demande `def main` et un dossier `src/`, absents de `carte_trace.py` ; à rapprocher de `cours4_v2/diapo/a_reprendre/4b_paquet.typ`],
  )
]

// --------------------------------------------
// Nouveau, 06/11/2026. Sorties relevées ce jour-là sous Linux, GDAL 3.13.3.
#d("Variable lue par un programme : PROJ_DATA")[
  #annonce[
    L'activation pose aussi des variables lues par les programmes. `ogr2ogr` cherche
    `proj.db`, la base des systèmes de coordonnées, dans le dossier que donne `PROJ_DATA`.
  ]

  #terminal(
    taille: 17pt,
    "$ echo \"$PROJ_DATA\"",
    "…/envs/essai/share/proj",
    "$ PROJ_DATA=/faux ogr2ogr -f CSV sortie.csv trace_2.gpx track_points -t_srs EPSG:2154",
    "ERROR 1: PROJ: proj_create_from_database: Cannot find proj.db",
    "ERROR 1: Failed to process SRS definition: EPSG:2154",
  )

  #legende[
    Sorties réelles sous Linux, chemin raccourci. `PROJ_DATA=/faux` devant une commande vaut
    pour cette commande seulement.
  ]

  #notes[
    Le paquet de GDAL ajoute à l'environnement des scripts d'activation, dans
    `etc/conda/activate.d/`, qui règlent `GDAL_DATA` et `PROJ_DATA`.

    Sous Linux, `ogr2ogr` appelé par son chemin, sans ces variables, trouve quand même
    `proj.db`. Le résultat sous Windows reste à relever.
  ]
]

// --------------------------------------------
#d("pyproject.toml : du fichier à la commande")[
  #annonce[
    `pyproject.toml` est la fiche du projet, lue par pip. `[project.scripts]`
    y déclare les commandes à installer.
  ]

  #code-commente(
    taille-code: 12pt, taille-texte: 12pt,
    ("[project]", "la fiche du projet"),
    ("name = \"carte-trace\"", "le nom du paquet, pour pip"),
    ("version = \"0.1\"", "sa version"),
    ("[project.scripts]", "les commandes à installer"),
    ("carte-trace = \"carte_trace:main\"", "la commande `carte-trace` appelle `main` du module `carte_trace`"),
    ("[tool.setuptools]", "où sont les modules"),
    ("package-dir = {\"\" = \"src\"}", "dans le dossier `src/`"),
    ("py-modules = [\"carte_trace\"]", "le module, dans `src/carte_trace.py`"),
  )

  #legende[
    `pip install -e .` installe le projet du dossier courant en mode
    modifiable : la commande appelle le code de `src/`, et une modification
    de ce code vaut sans réinstaller.
  ]

  #notes[
    `src/` sépare le code des données et des fichiers du projet. La commande
    est un petit exécutable écrit par pip dans le dossier de l'environnement que
    `PATH` parcourt : `which carte-trace` l'affiche.

    Essayé le 06/11/2026, avec le code de `carte_trace.py` dans une fonction `main`.
  ]
]
