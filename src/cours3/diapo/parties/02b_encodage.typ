// Partie 2 du cours 3, suite : le fichier comme suite d'octets et
// l'encodage, ASCII et UTF-8, la fin de ligne, puis le mode binaire, qui lit
// les octets sans les décoder.
//
// Incluse par `cours3.typ`, entre `02a_lecture.typ` et `02c_fichiers.typ`.
// Les sections 3 à 6 de `fichiers.ipynb` reprennent ces diapositives, dans
// le même ordre. `images.ipynb` (PGM, formats d'image, compression) est
// facultatif et n'ont plus de diapositive ;
// celles qui les présentaient sont dans l'historique git (avant le
// 25/09/2026).
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *
#import "../schemas_fichiers.typ": schema-decodage, schema-fin-de-ligne, schema-position-octets

// --------------------------------------------
#d("Fichier texte : une suite d'octets", cellule: 3, fichier: "fichiers.ipynb")[
  #annonce[
    Sur le disque, un fichier est une suite d'octets. L'encodage, donné par
    l'argument `encoding` de `open`, définit le caractère qui correspond à
    chaque octet ou groupe d'octets. Décodés avec un autre encodage, les
    mêmes octets donnent d'autres caractères.
  ]

  #align(center, schema-decodage())

  #legende[
    `␣` représente l'espace, `⏎` le retour à la ligne. Sans l'argument
    `encoding`, Python sous Windows décode en cp1252, et `Crêpes` s'affiche
    `CrÃªpes`.
  ]

  #notes[
    Même cause pour `é` : `c3 a9` relu en cp1252 donne `Ã©` (§ 3 de
    `fichiers.ipynb`).

    Python 3.15 lira en UTF-8 par défaut (PEP 686) ; les postes de la salle
    sont en 3.13.
  ]
]

// --------------------------------------------
#d("Encodage texte : ASCII et UTF-8", cellule: 4, fichier: "fichiers.ipynb")[
  #annonce[
    Un encodage écrit chaque caractère en octets. ASCII code 128 caractères
    sur un octet : lettres sans accent, chiffres, ponctuation. UTF-8 code
    ces 128 de la même façon, et les autres sur deux à quatre octets.
  ]

  #face-a-face(
    panneau("Quatre caractères")[
      #tableau(
        columns: (auto, auto, 1fr),
        align: (center + horizon, left + horizon, left + horizon),
        [Caractère], [ASCII], [UTF-8],
        [`a`], [`61`], [`61`],
        [`é`], [—], [`c3 a9`],
        [`œ`], [—], [`c5 93`],
        [`😀`], [—], [`f0 9f 98 80`],
      )
    ],
    panneau("Un mot, avec et sans ligature")[
      #tableau(
        columns: (auto, auto, 1fr),
        align: (left + horizon, center + horizon, left + horizon),
        [Mot], [`len`], [UTF-8],
        [`œuf`], [3], [`c5 93 75 66`, 4 octets],
        [`oeuf`], [4], [`6f 65 75 66`, 4 octets],
      )
    ],
  )

  #code-commente(
    taille-code: 12.5pt, taille-texte: 12pt,
    ("\"œuf\".encode(\"utf-8\").hex(\" \")", "`encode` renvoie les octets, `hex` les affiche en hexadécimal"),
    ("\"œ\".encode(\"ascii\")", "lève `UnicodeEncodeError` : `œ` n'a pas de code ASCII"),
  )

  #notes[
    § 4 : une ligne à compléter dans la première boucle ; `len`
    vaut 1 quatre fois, les octets vont de un à quatre.

    `len` compte les caractères. ISO 8859-1, l'encodage des textes
    français avant UTF-8, n'a pas de code pour `œ` : les fichiers anciens
    écrivent « oeuf ».

    UTF-8 est ce qu'on écrit dans `encoding=`. Les autres encodages
    existent ; ne pas les détailler.
  ]
]

// --------------------------------------------
#d("Fin de ligne", cellule: 5, fichier: "fichiers.ipynb")[
  #annonce[
    La fin de ligne est un caractère de contrôle, écrit `\n` en Python.
    Sous Linux et macOS, un fichier texte la code par l'octet `0a` ; sous
    Windows, par les deux octets `0d 0a`, écrits `\r\n`.
  ]

  #align(center, schema-fin-de-ligne())

  #legende[
    En mode texte, Python remplace `\r\n` par `\n` à la lecture. À
    l'écriture sous Windows, il remplace chaque `\n` par `\r\n`. Dans le
    programme, les lignes sont toujours séparées par `\n`.
  ]

  #notes[
    § 5 : la cellule écrit le fichier avec `newline="\r\n"`. `\r` seul (anciens Mac)
    est aussi lu comme `\n`. `newline=""` supprime la conversion : le
    module `csv` le demande (§ 10).
  ]
]

// --------------------------------------------
#d("Mode binaire : des octets", cellule: 6, fichier: "fichiers.ipynb")[
  #annonce[
    Le deuxième argument de `open` est le mode d'ouverture. Avec le mode
    `"rb"`, Python lit les octets du fichier sans les décoder : `read`
    renvoie un objet `bytes`, et les fins de ligne restent `\r\n`. La
    position compte des octets.
  ]

  #align(center, schema-position-octets())

  #legende[
    Le mode `"wb"` écrit des octets : `f.write(b"...")`. Un programme lit
    et écrit une image en mode binaire (`images.ipynb`, facultatif).
  ]

  #notes[
    Même fichier que la diapositive de la fin de ligne, écrit sous Windows.
    `read(n)` lit au plus `n` octets. `chemin.read_bytes()` équivaut à
    `open(chemin, "rb")` puis `read()` (§ 11).
  ]
]
