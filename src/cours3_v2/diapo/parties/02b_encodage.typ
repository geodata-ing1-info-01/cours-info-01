// Partie 2 du cours 3 v2, suite : les fichiers binaires et les fichiers texte, le
// mode binaire, les modes d'écriture, puis le fichier comme suite d'octets et
// l'encodage, ASCII et UTF-8.
//
// Incluse par `cours3_v2.typ`, entre `02a_lecture.typ` et `02c_fichiers.typ`.
// Exemple passé de la recette à la trace GPS le 04/11/2026 ; passé le 06/11/2026 à la
// première ligne de `parcours.txt`, avec le `ê` de `Forêt` : la première ligne de
// `trace.csv`, écrite par `ogr2ogr`, n'a pas d'accent.
// Mode binaire et modes d'écriture placés avant l'encodage le 05/11/2026.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *
#import "../schemas_fichiers.typ": schema-decodage, schema-modes-ecriture, schema-position-octets

// --------------------------------------------
// Reprise du cours 1 de 2026 (28/09/2026) : bit, octet, hexadécimal. Réécrite le
// 05/11/2026 : « chaque octet est un caractère » est faux en UTF-8. Sortie de
// `git diff` relevée sur un fichier texte et un fichier PNG.
#d("Fichiers binaires et fichiers texte")[
  #annonce[
    Un fichier est une suite de *bits*, 0 ou 1, groupés par huit en *octets*. Un
    octet a 256 valeurs possibles, notées par deux chiffres hexadécimaux. Dans un
    fichier *texte*, les octets codent des caractères. Dans un fichier *binaire*,
    ils codent des données selon un format.
  ]

  #chaine(
    ecart: 22pt,
    ("Huit bits", "01010010"),
    ("Une valeur", "82 sur 256 possibles"),
    ("Deux chiffres hexadécimaux", [52 vaut 5 × 16 + 2 × 1 = 82\ de 00 à FF]),
    ("Un caractère dans un fichier texte", "R, dans la table ASCII"),
  )

  #v(0.3em)
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Fichier texte], [Fichier binaire],
    [Exemples], [`.txt`, `.csv`, `.py`], [`.png`, `.odt`, `.exe`],
    [Lecture], [dans un éditeur de texte], [dans un logiciel adapté au format],
    [`git diff`], [les lignes modifiées], [`Binary files … differ`],
  )

  #legende[
    2#super[8] = 256. L'hexadécimal emploie seize chiffres, de `0` à `F`.
  ]

  #notes[
    Le cours 1 v2 ne définit ni l'octet ni l'hexadécimal : ils sont définis ici.

    Ne pas faire calculer : donner 2 puissance 8, et passer. Un chiffre
    hexadécimal note quatre bits, donc un octet s'écrit avec deux chiffres. Ici,
    `0101` vaut 5 et `0010` vaut 2.

    Tous les fichiers sont écrits en bits. Un fichier binaire n'est pas fait pour
    être lu caractère par caractère.

    Un fichier texte se compare et se versionne ligne par ligne. Git ne compare
    pas ainsi un fichier binaire : cours 2.
  ]
]

// --------------------------------------------
#d("Lecture en mode binaire")[
  #annonce[
    Le deuxième argument de `open` est le mode d'ouverture. Avec le mode
    `"rb"`, Python lit les octets du fichier sans les convertir en caractères : `read`
    renvoie un objet `bytes`, et les fins de ligne restent `\r\n`. La
    position est comptée en octets.
  ]

  #align(center, schema-position-octets())

  #legende[
    Le mode `"wb"` écrit des octets : `f.write(b"...")`. Un programme lit
    et écrit une image en mode binaire.
  ]

  #notes[
    Même fichier que la diapositive de la fin de ligne, écrit sous Windows. Les
    deux octets de `ê` : expliqués à « Encodage d'un fichier texte ».
    `read(n)` lit au plus `n` octets. `chemin.read_bytes()` équivaut à
    `open(chemin, "rb")` puis `read()`.
  ]
]

// --------------------------------------------
#d("Modes d'écriture : \"w\" et \"a\"")[
  #annonce[
    En mode `"w"`, Python vide le fichier à l'ouverture, puis écrit depuis le début.
    En mode `"a"`, Python conserve le contenu et écrit à la fin. Dans les deux modes,
    un fichier absent est créé.
  ]

  #align(center, schema-modes-ecriture())

  #legende[
    Le trait bleu marque la position d'écriture ; les cases en couleur sont
    les caractères écrits par `write`.
  ]

  #notes[
    Le TD 3b écrit `resume.txt` en `"w"`, puis le complète en `"a"`. Le mode
    `"x"` lève `FileExistsError` si le fichier existe.
  ]
]

// --------------------------------------------
#d("Encodage d'un fichier texte")[
  #annonce[
    L'encodage, donné par
    l'argument `encoding` de `open`, définit le caractère qui correspond à
    chaque octet ou groupe d'octets. Décodés avec un autre encodage, les
    mêmes octets donnent d'autres caractères.
  ]

  #align(center, schema-decodage())

  #legende[
    `⏎` représente le retour à la ligne. Sans l'argument
    `encoding`, Python sous Windows décode en cp1252, et `Forêt` s'affiche
    `ForÃªt`.
  ]

  #notes[
    Python 3.15 lira en UTF-8 par défaut (PEP 686) ; les postes de la salle
    sont en 3.13.
  ]
]

// --------------------------------------------
#d("Encodage texte : ASCII et UTF-8")[
  #annonce[
    Un encodage associe à chaque caractère un ou plusieurs octets. ASCII code 128
    caractères sur un octet : lettres sans accent, chiffres, ponctuation. UTF-8 code
    ces 128 caractères de la même façon, et les autres sur deux à quatre octets.
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
    `len` compte les caractères. ISO 8859-1, l'encodage des textes
    français avant UTF-8, n'a pas de code pour `œ` : les fichiers anciens
    écrivent « oeuf ».

    UTF-8 est ce qu'on écrit dans `encoding=`. Les autres encodages
    existent ; ne pas les détailler.
  ]
]
