// Partie 1 du cours 3 v2 : la portabilité du code. Incluse par `cours3_v2.typ`.
//
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *

// --------------------------------------------
// Nouveau (v2), 04/11/2026. Sorties relevées avec le programme affiché, dans un
// dossier nommé comme celui d'Alice, puis dans un autre.
#d("Portabilité : chemins de fichiers")[
  #panneau("altitudes.py")[
    #sortie("f = open(\"C:/Users/alice/Desktop/cours3/trace.csv\", encoding=\"utf-8\")\nprint(len(f.readlines()), \"lignes\")", taille: 14pt)
  ]

  #grid(
    columns: (0.55fr, 1fr), column-gutter: 22pt,
    panneau("Sur le poste d'Alice")[
      #sortie("$ python altitudes.py\n62 lignes", taille: 12.5pt)
    ],
    panneau("Sur un autre poste")[
      #sortie("$ python altitudes.py\nFileNotFoundError: [Errno 2] No such file or directory:\n'C:/Users/alice/Desktop/cours3/trace.csv'", taille: 12.5pt)
    ],
  )

  #legende[
    `C:/Users/alice/…` n'existe pas ailleurs, ni après un déplacement du dossier.
  ]

  #notes[
    À dire en ouvrant la partie : au cours 1, lancer un script ; au cours 2,
    éditer le code ; ici, ce qu'il faut pour qu'une autre personne utilise ce
    code. Deux problèmes de portabilité : les chemins, puis les paramètres.

    Sorties réelles, Python 3.12 ; seule la dernière ligne de l'erreur est
    affichée, sur deux lignes pour tenir dans le panneau. `open` et `readlines`
    sont détaillés en partie 2.

    Le TD 3b part de ce problème.
  ]
]

// --------------------------------------------
// Nouveau (v2), 04/11/2026, d'après « Du notebook à la ligne de commande ». Les
// commandes sont celles du corrigé `corriges/3b_portabilite/altitudes.py`.
#d("Portabilité : paramètres en dur")[
  #grid(
    columns: (0.7fr, 1fr), column-gutter: 22pt,
    panneau("Valeurs écrites dans le code")[
      #sortie("FICHIER = \"trace.csv\"\nSEUIL = 2.0", taille: 15pt)
      #text(size: 15pt, fill: estompe)[
        à modifier dans le notebook ou le script avant chaque lancement
      ]
    ],
    panneau("Valeurs sur la ligne de commande")[
      #sortie("$ python altitudes.py trace.csv -s 2\n$ python altitudes.py trace_2.csv\n$ python altitudes.py --help", taille: 15pt)
      #text(size: 15pt, fill: estompe)[
        le code reste inchangé ; `--help` décrit les valeurs possibles
      ]
    ],
  )

  #legende[
    Une autre personne choisit ces valeurs sans ouvrir le code.
  ]

  #notes[
    Dans le notebook, changer une valeur oblige à relancer les cellules qui
    en dépendent.

    Le seuil : une variation d'altitude plus petite n'est pas comptée, ce qui
    écarte le bruit du GPS. Sur `trace.csv`, le cumul en hausse passe de 58,4 m
    à 55,4 m avec `-s 2`.
  ]
]

// --------------------------------------------
#d("pathlib : manipulation des chemins")[
  #annonce[
    `pathlib` simplifie la manipulation des chemins en Python. Les fonctions
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
// Un script minimal, sans fonction `main`. Sorties relevées, Python 3.12.
#d("Un script qui lit la ligne de commande")[
  #annonce[
    Le script lit le nom du fichier, écrit après le nom du script. La
    bibliothèque `argparse` vérifie qu'il est donné, et produit l'aide.
  ]

  #face-a-face(
    panneau("altitudes.py")[
      #sortie("import argparse\n\nanalyseur = argparse.ArgumentParser()\nanalyseur.add_argument(\"fichier\")\noptions = analyseur.parse_args()\nprint(\"Trace demandée :\", options.fichier)", taille: 12pt)
    ],
    panneau("Terminal")[
      #sortie("$ python altitudes.py trace.csv\nTrace demandée : trace.csv\n\n$ python altitudes.py\nusage: altitudes.py [-h] fichier\naltitudes.py: error: the following\narguments are required: fichier\n\n$ python altitudes.py --help\nusage: altitudes.py [-h] fichier\n…", taille: 12pt)
    ],
  )

  #legende[
    `options.fichier` contient le texte écrit après `altitudes.py`.
  ]

  #notes[
    Sorties réelles. `options.fichier` porte le nom donné à `add_argument`.
    Sans argument, `parse_args` affiche l'usage et arrête le script, avant
    le `print`. La diapositive suivante ajoute l'option du seuil, `-s`.
  ]
]

// --------------------------------------------
#d("argparse : les arguments d'un script")[
  #annonce[
    `argparse`, bibliothèque standard, lit les arguments écrits après le nom
    du script : il les vérifie, les convertit, et construit l'aide de `--help`.
  ]

  #code-commente(
    taille-code: 12pt, taille-texte: 12.5pt,
    ("analyseur = argparse.ArgumentParser()", "l'analyseur des arguments"),
    ("analyseur.add_argument(\"fichier\")", "obligatoire"),
    ("analyseur.add_argument(\"-s\", \"--seuil\", type=float, default=0)", "option ; convertie en nombre ; 0 si absente"),
    ("options = analyseur.parse_args()", "lit la ligne de commande ; message et arrêt si elle est invalide"),
    ("options.fichier, options.seuil", "les valeurs lues"),
  )

  #legende[
    Documentation : docs.python.org/fr/3/library/argparse.html.
  ]

  #tableau(
    entete: false,
    columns: (1fr, 1fr),
    align: left + horizon,
    [`python altitudes.py trace.csv -s 2`], [`fichier`, puis une option],
    [`python altitudes.py trace.csv -s deux`], [`invalid float value`],
    [`python altitudes.py --help`], [l'aide, depuis les `add_argument`],
  )

  #notes[
    Un argument sans tiret est obligatoire et positionnel ; un argument avec des
    tirets est une option, qui a une valeur par défaut. `type=float` convertit et
    rejette `deux`. `choices`, non employé ici, limite les valeurs à une liste.

    Faire lire `--help` : l'aide est produite à partir des `add_argument`,
    sans rien écrire d'autre.
  ]
]
