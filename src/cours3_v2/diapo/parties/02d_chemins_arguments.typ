// Partie 2 du cours 3 v2, fin : pathlib et argparse, employés par les versions du
// script de la partie 1. Incluse par `cours3_v2.typ`, après `02c_fichiers.typ`.
//
// Diapositives déplacées de `01_programme.typ` le 05/11/2026.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *

// --------------------------------------------
// Sorties relevées avec le corrigé du TD 3a, sur la branche `master` du TD 3b,
// Python 3.12.
#d("Chemin relatif : le dossier du terminal")[
  #annonce[
    Un chemin relatif écrit dans un script part du dossier courant du terminal,
    comme les chemins donnés à `ls` et à `cp` au cours 1.
  ]

  #grid(
    columns: (1fr, 1fr), column-gutter: 16pt,
    stack(
      spacing: 5pt,
      text(size: 15pt, fill: estompe, weight: demi-gras)[altitudes.py],
      script("altitudes = []\nwith open(\"trace.csv\", encoding=\"utf-8\") as fichier:\n    fichier.readline()\n    for ligne in fichier:\n        …", vives: (2,)),
    ),
    stack(
      spacing: 4pt,
      poste("Dossier du terminal", "…/3b_portabilite/travail/", "altitudes.py, trace.csv",
        "$ python altitudes.py\naltitude minimale : 78.8 m\naltitude maximale : 129.5 m"),
      align(center, text(size: 13pt, fill: estompe)[#sym.arrow.b `cd ..`]),
      poste("Dossier du terminal", "…/3b_portabilite/", "depart/, travail/",
        "$ python travail/altitudes.py\nFileNotFoundError: [Errno 2] No such file or\ndirectory: 'trace.csv'",
        erreur: true),
    ),
  )

  #notes[
    Partir de `open("trace.csv")`, dans le récapitulatif sur les fichiers.
    L'étape 4 du TD 3b refait cette expérience.

    Sorties réelles ; seule la dernière ligne de l'erreur est affichée.
  ]
]

// --------------------------------------------
// Parties vérifiées avec `PureWindowsPath`, Python 3.12.
#d("Objet Path : parties d'un chemin")[
  #annonce[
    La classe `Path`, importée de `pathlib`, transforme une chaîne en objet
    chemin. L'objet donne chaque partie du chemin, et l'opérateur `/` lui
    ajoute un dossier ou un fichier.
  ]

  #v(0.3em)
  #align(center, parties-chemin("chemin = Path(\"", "C:/Users/alice/cours3", "trace", ".csv", "\")"))

  #v(0.6em)
  #code-commente(
    taille-code: 14pt, taille-texte: 13.5pt,
    ("Path(\"C:/Users/alice/cours3\") / \"trace.csv\"", "construit le même chemin avec l'opérateur `/`"),
    ("chemin.parent / \"resume.txt\"", "construit `C:/Users/alice/cours3/resume.txt`"),
    ("chemin.exists()", "vérifie que le fichier existe : `True` ou `False`"),
  )

  #notes[
    `Path(...)` crée l'objet sans vérifier que le fichier existe. `.parent`
    remonte d'un niveau, comme `..` au cours 1.

    Sous Windows, `print(chemin)` affiche les `\` du système :
    `C:\Users\alice\cours3\trace.csv`.
  ]
]

// --------------------------------------------
// Sorties relevées sous Linux, dans l'arborescence du TD 3b, avec ces trois
// lignes en tête de `altitudes.py`, Python 3.12.
#d([Dossier du script : `__file__`])[
  #annonce[
    Au lancement d'un script, Python enregistre le chemin absolu du script dans
    la variable `__file__`. `Path(__file__).parent` donne le dossier du script,
    quel que soit le dossier du terminal.
  ]

  #script("from pathlib import Path\nprint(\"dossier du terminal :\", Path.cwd())\nprint(\"dossier du script :\", Path(__file__).parent)", taille: 13pt)

  #v(0.5em)
  #{
    show raw: set text(size: 13pt)
    tableau(
      columns: (auto, 1fr, 1fr),
      align: left + horizon,
      [Commande], [Dossier du terminal], [Dossier du script],
      [`python altitudes.py`], [`…\3b_portabilite\travail`], [`…\3b_portabilite\travail`],
      [`python travail/altitudes.py`], surligne[`…\3b_portabilite`], [`…\3b_portabilite\travail`],
    )
  }

  #legende[
    `…` : le dossier du cours sur le poste, par exemple
    `C:\Users\eleve\Desktop\info01\cours3`.
  ]

  #notes[
    `cwd` : _current working directory_, le dossier courant. Depuis Python 3.9,
    `__file__` contient un chemin absolu.

    Sorties relevées sous Linux, réécrites avec les `\` de Windows : à vérifier
    sur un poste de la salle.
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

  #notes[
    `__file__` : le chemin du fichier lancé, fourni par Python. `.parent` : le
    dossier qui le contient. L'étape 4 du TD 3b écrit ces lignes.

    `Path.cwd()` renvoie le dossier du terminal. Le code ci-dessus fonctionne sur
    tout poste, quel que soit ce dossier.

    Un `Path` s'écrit avec des `/` quel que soit le système, et s'affiche
    avec des `\` sous Windows. Construire un chemin ne vérifie pas qu'il
    existe : `exists()` le fait.
  ]
]

// --------------------------------------------
#d("pathlib : récapitulatif")[
  #annonce[
    La bibliothèque `pathlib` manipule les chemins en Python. Les fonctions
    ci-dessous sont parmi les plus courantes ; la documentation décrit les
    autres, comme `glob`, `with_suffix` ou `read_text` :
    docs.python.org/fr/3/library/pathlib.html.
  ]

  #code-commente(
    taille-code: 14.5pt, taille-texte: 13.5pt,
    ("from pathlib import Path", "la classe des chemins"),
    ("Path(\"C:/Users/alice/cours3\")", "déclare un chemin ; ne crée et ne vérifie rien"),
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
    Exemples de la colonne de droite avec `chemin = dossier / "trace.csv"`.
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
// Sorties relevées avec ce script, nommé `altitudes.py`, Python 3.12.
#d([Arguments d'un script : la liste `sys.argv`])[
  #annonce[
    Python enregistre les mots écrits après le nom du script dans la liste
    `sys.argv`, sous forme de chaînes, dans l'ordre de la frappe. Le premier
    élément est le nom du script.
  ]

  #grid(
    columns: (0.8fr, 1.2fr), column-gutter: 16pt,
    stack(
      spacing: 5pt,
      text(size: 15pt, fill: estompe, weight: demi-gras)[altitudes.py],
      script("import sys\n\nprint(sys.argv)", taille: 13pt),
    ),
    sortie("$ python altitudes.py\n['altitudes.py']\n$ python altitudes.py trace.csv\n['altitudes.py', 'trace.csv']\n$ python altitudes.py trace.csv -s 2\n['altitudes.py', 'trace.csv', '-s', '2']\n$ python altitudes.py -s 2 trace.csv\n['altitudes.py', '-s', '2', 'trace.csv']", taille: 12pt),
  )

  #v(0.5em)
  #{
    show raw: set text(size: 13pt)
    tableau(
      columns: (auto, auto, auto, auto, auto),
      align: left + horizon,
      [Commande], [`sys.argv[0]`], [`sys.argv[1]`], [`sys.argv[2]`], [`sys.argv[3]`],
      [`python altitudes.py trace.csv -s 2`], [`'altitudes.py'`], [`'trace.csv'`], [`'-s'`], [`'2'`],
    )
  }

  #notes[
    Le module `sys` fait partie de la bibliothèque standard. Les guillemets de la
    sortie signalent des chaînes : `'2'` est un texte, et le script doit le
    convertir avec `float` avant de calculer.

    `sys.argv[0]` garde le nom tapé, `travail/altitudes.py` depuis le dossier du
    TD, alors que `__file__` contient le chemin absolu.
  ]
]

// --------------------------------------------
// Sorties relevées avec ces deux lignes, Python 3.12.
#d([Lecture de `sys.argv` par position : limites])[
  #annonce[
    Lire les arguments à des positions fixes impose leur ordre et leur nombre.
    Les messages de Python décrivent l'erreur dans le code, sans indiquer à
    l'utilisateur ce qu'il doit taper.
  ]

  #script("import sys\nfichier = sys.argv[1]\nseuil = float(sys.argv[3])", vives: (2, 3), taille: 12pt)

  #v(0.3em)
  #{
    show raw: set text(size: 12pt)
    tableau(
      columns: (auto, auto, 1fr),
      align: left + horizon,
      [Après `python altitudes.py`], [Résultat], [Cause],
      [`trace.csv -s 2`], [`fichier` vaut `'trace.csv'`, `seuil` vaut `2.0`], [chaque argument est à sa place],
      [`trace.csv`], [`IndexError: list index out of range`], [`sys.argv[3]` n'existe pas],
      [`-s 2 trace.csv`], [`ValueError: could not convert`\ `string to float: 'trace.csv'`], [`sys.argv[3]` vaut `'trace.csv'`],
      [`--help`], [`IndexError: list index out of range`], [`sys.argv[1]` vaut `'--help'`, et `sys.argv[3]` n'existe pas],
    )
  }

  #notes[
    Sorties réelles ; seule la dernière ligne de l'erreur est affichée. Les deux
    diapositives suivantes reprennent ces commandes avec argparse.
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
    `options.seuil`. `parse_args` renvoie un objet avec un attribut par argument ;
    `vars(options)` le transforme en dictionnaire.
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

// --------------------------------------------
// Les deux versions donnent les mêmes valeurs et refusent les mêmes erreurs sur
// neuf commandes, Python 3.12. La version de gauche refuse `--seuil=2` et `-s2`.
#d("Intérêt d'argparse : lecture à la main")[
  #annonce[
    Sans argparse, le script parcourt lui-même `sys.argv` pour reconnaître
    l'option, convertir le seuil et signaler chaque erreur.
  ]

  #grid(
    columns: (1.25fr, 1fr), column-gutter: 16pt,
    panneau("Sans argparse")[
      #script("import sys\nfichier, seuil = None, 0.0\nmots = sys.argv[1:]\ni = 0\nwhile i < len(mots):\n    if mots[i] in (\"-h\", \"--help\"):\n        print(\"usage: altitudes.py [-h] [-s SEUIL] fichier\")\n        sys.exit()\n    elif mots[i] in (\"-s\", \"--seuil\"):\n        if i + 1 == len(mots):\n            sys.exit(\"erreur : -s demande une valeur\")\n        try:\n            seuil = float(mots[i + 1])\n        except ValueError:\n            sys.exit(f\"erreur : seuil invalide : {mots[i + 1]}\")\n        i += 2\n    elif fichier is None:\n        fichier = mots[i]\n        i += 1\n    else:\n        sys.exit(f\"erreur : argument en trop : {mots[i]}\")\nif fichier is None:\n    sys.exit(\"erreur : le fichier est obligatoire\")", taille: 9pt, interligne: 1.1)
    ],
    panneau("Avec argparse")[
      #script("import argparse\n\nanalyseur = argparse.ArgumentParser()\nanalyseur.add_argument(\"fichier\")\nanalyseur.add_argument(\"-s\", \"--seuil\",\n                       type=float, default=0)\noptions = analyseur.parse_args()", taille: 11pt)
      #v(0.6em)
      #text(size: 13pt, fill: estompe)[
        argparse accepte en plus `--seuil=2` et `-s2`, que la version de gauche
        refuse, et produit l'aide complète de `--help`.
      ]
    ],
  )

  #notes[
    Ne pas détailler le code de gauche, car `while`, `try` et `sys.exit` n'ont pas
    été présentés. Montrer la longueur des deux versions : 23 lignes contre 5
    instructions.

    L'aide de la version de gauche tient en une ligne écrite à la main. argparse
    accepte aussi l'abréviation `--se 2`.
  ]
]
