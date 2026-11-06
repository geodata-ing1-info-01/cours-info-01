// Partie 2 du cours 3 v2, fin : pathlib et argparse, employés par les versions du
// script de la partie 1. Incluse par `cours3_v2.typ`, après `02c_fichiers.typ`.
//
// Diapositives déplacées de `01_programme.typ` le 05/11/2026.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *

// --------------------------------------------
#d("pathlib : manipulation des chemins")[
  #annonce[
    La bibliothèque `pathlib` manipule les chemins en Python. Les fonctions
    ci-dessous sont parmi les plus courantes ; la documentation décrit les
    autres, comme `glob`, `with_suffix` ou `read_text` :
    docs.python.org/fr/3/library/pathlib.html.
  ]

  #code-commente(
    taille-code: 14.5pt, taille-texte: 13.5pt,
    ("from pathlib import Path", "la classe des chemins"),
    ("Path(\"C:/Users/alice/Desktop/cours3\")", "déclare un chemin ; ne crée et ne vérifie rien"),
    ("Path.cwd()", "le dossier courant"),
    ("Path(__file__)", "le chemin du script"),
    ("dossier / \"trace.csv\"", "ajoute un dossier ou un fichier au chemin"),
    ("", ""),
    ("chemin.name, chemin.stem, chemin.suffix", "`trace.csv`, `trace`, `.csv`"),
    ("chemin.parent", "le dossier qui contient le chemin"),
    ("", ""),
    ("chemin.exists(), chemin.is_dir(), chemin.is_file()", "existe ; est un dossier ; est un fichier"),
    ("dossier.iterdir()", "les fichiers et sous-dossiers, sans ordre"),
    ("chemin.resolve()", "le chemin absolu, sans `..`"),
    ("chemin.relative_to(racine)", "le chemin à partir de `racine`"),
  )

  #notes[
    Exemples de la colonne de droite avec `chemin = dossier / "trace.csv"`. La
    diapositive suivante emploie ces fonctions sur le programme.
  ]
]

// --------------------------------------------
// D'après « Correction 2 : une racine » du cours 3 de 2026, sur le programme de la
// trace. `Path(__file__)` remplace `Path.cwd().parent`, propre au notebook.
#d("pathlib : un chemin à partir du script")[
  #annonce[
    Un seul chemin est déclaré : le dossier du script, déduit de `__file__`. Les
    autres chemins sont construits à partir de lui avec l'opérateur `/`.
  ]

  #face-a-face(
    panneau("L'arborescence du TD 3b")[
      #sortie("3b_portabilite/\n└── travail/            ← DOSSIER\n    ├── altitudes.py    ← Path(__file__)\n    └── trace.csv       ← FICHIER", taille: 12pt)
    ],
    panneau("Le code")[
      #sortie("from pathlib import Path\n\nDOSSIER = Path(__file__).parent\nFICHIER = DOSSIER / \"trace.csv\"", taille: 12pt)
    ],
  )

  #legende[
    `Path.cwd()` renvoie le dossier du terminal. Le code ci-dessus fonctionne sur
    tout poste, quel que soit ce dossier.
  ]

  #notes[
    `__file__` : le chemin du fichier lancé, fourni par Python. `.parent` : le
    dossier qui le contient. Le TD 3b essaie `Path.cwd()`, puis `__file__`.

    Un `Path` s'écrit avec des `/` quel que soit le système, et s'affiche
    avec des `\` sous Windows. Construire un chemin ne vérifie pas qu'il
    existe : `exists()` le fait.
  ]
]

// --------------------------------------------
// Trois diapositives à la place de « argparse : les arguments d'un script »
// (05/11/2026), d'après le tutoriel de la documentation de Python : positionnels
// et options d'abord. Sorties relevées avec le corrigé du TD 3b, Python 3.13.
#d("Arguments positionnels et options")[
  #annonce[
    Les arguments sont les mots écrits après le nom du script.
  ]

  #{
    let morceau(code, nom, vif: false) = align(center)[
      #show raw: set text(size: 17pt)
      #block(inset: (x: 12pt, y: 8pt), below: 5pt,
             fill: if vif { attention.lighten(78%) } else { gris })[#raw(code)]
      #text(size: 13.5pt, fill: if vif { attention } else { estompe }, nom)
    ]
    align(center, grid(
      columns: (auto, auto, auto, auto), column-gutter: 10pt,
      morceau("python", [le programme]),
      morceau("altitudes.py", [le script]),
      morceau("trace.csv", [argument positionnel], vif: true),
      morceau("-s 2", [option et sa valeur], vif: true),
    ))
  }

  #v(0.5em)
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Argument positionnel], [Option],
    [Écriture], [sans tiret : `trace.csv`], [avec un ou deux tirets : `-s 2`, `--seuil 2`],
    [Reconnu par], [sa place sur la ligne], [son nom],
    [Si absent], [une erreur, car il est obligatoire], [une valeur par défaut],
    [Au cours 1], [`cp source destination`], [`ls -a`, `cp -r`],
  )

  #notes[
    Reprendre `ls -a` et `cp source destination` du cours 1 : ces commandes ont la
    même forme.

    L'ordre est libre : `-s 2 trace.csv` donne le même résultat.
  ]
]

// --------------------------------------------
#d("argparse : déclaration et lecture des arguments")[
  #annonce[
    `argparse`, bibliothèque standard, lit les arguments écrits après le nom
    du script : il les vérifie, les convertit, et construit l'aide de `--help`.
  ]

  #code-commente(
    taille-code: 12pt, taille-texte: 12.5pt,
    ("import argparse", "la bibliothèque, à importer"),
    ("analyseur = argparse.ArgumentParser()", "l'analyseur des arguments"),
    ("analyseur.add_argument(\"fichier\")", "obligatoire"),
    ("analyseur.add_argument(\"-s\", \"--seuil\", type=float, default=0)", "option ; convertie en nombre ; 0 si absente"),
    ("options = analyseur.parse_args()", "lit la ligne de commande"),
  )

  #v(0.4em)
  #tableau(
    columns: (1fr, auto, auto),
    align: left + horizon,
    [Commande], [`options.fichier`], [`options.seuil`],
    [`python altitudes.py trace.csv`], [`'trace.csv'`], [`0`],
    [`python altitudes.py trace.csv -s 2`], [`'trace.csv'`], [`2.0`],
    [`python altitudes.py -s 2 trace.csv`], [`'trace.csv'`], [`2.0`],
  )

  #legende[
    `add_argument("fichier")` crée `options.fichier`, et `"--seuil"` crée
    `options.seuil`.
  ]

  #notes[
    `type=float` convertit la valeur : sans lui, `options.seuil` vaut la chaîne `'2'`.

    Le seuil : une variation d'altitude plus petite n'est pas comptée, ce qui
    écarte le bruit du GPS. Sur `trace.csv`, le cumul en hausse passe de 98,4 m
    à 88,7 m avec `-s 2`.

    `choices`, non employé ici, limite les valeurs à une liste. Option sans valeur :
    `action="store_true"`, au TD 4a du cours 4.
  ]
]

// --------------------------------------------
#d("argparse : aide et messages d'erreur")[
  #script("analyseur = argparse.ArgumentParser(description=\"Altitudes et cumul d'une trace GPS.\")\nanalyseur.add_argument(\"fichier\", help=\"le fichier CSV de la trace\")\nanalyseur.add_argument(\"-s\", \"--seuil\", type=float, default=0,\n                       help=\"variation ignorée sous ce seuil, en mètres\")", vives: (1, 2, 4), taille: 11pt)

  #v(0.5em)
  #grid(
    columns: (1.25fr, 1fr), column-gutter: 16pt,
    panneau("Aide")[
      #sortie("$ python altitudes.py --help\nusage: altitudes.py [-h] [-s SEUIL] fichier\n\nAltitudes et cumul d'une trace GPS.\n\npositional arguments:\n  fichier            le fichier CSV de la trace\n\noptions:\n  -h, --help         show this help message and exit\n  -s, --seuil SEUIL  variation ignorée sous ce seuil, en mètres", taille: 10pt)
    ],
    panneau("Messages d'erreur")[
      #sortie("$ python altitudes.py\naltitudes.py: error: the following\narguments are required: fichier\n\n$ python altitudes.py trace.csv -s deux\naltitudes.py: error: argument -s/--seuil:\ninvalid float value: 'deux'", taille: 10.5pt)
    ],
  )

  #legende[
    Les textes de `description` et de `help` apparaissent dans l'aide.
    Documentation : docs.python.org/fr/3/library/argparse.html.
  ]

  #notes[
    Sorties réelles, Python 3.13, la version des postes de la salle. Sous 3.12, la
    ligne de `-s` s'écrit `-s SEUIL, --seuil SEUIL`. Erreurs : seule la dernière ligne
    est affichée, sur deux lignes pour tenir dans le panneau ; une ligne `usage:` la
    précède.

    Sans argument, `parse_args` affiche l'usage et arrête le script.

    Faire lire `--help` : l'aide est produite à partir des `add_argument`,
    sans rien écrire d'autre.
  ]
]
