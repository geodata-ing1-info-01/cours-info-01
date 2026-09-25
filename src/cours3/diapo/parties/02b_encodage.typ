// Partie 2 du cours 3, seconde moitié — ASCII et UTF-8.
//
// Incluse par `cours3.typ`, après `02a_fichiers.typ`. La section 1
// d'`images.ipynb` reprend ces diapositives. Les sections suivantes (PGM, formats
// d'image, compression) sont facultatives et n'ont plus de diapositive ;
// celles qui les présentaient sont dans l'historique git (avant le
// 25/09/2026).
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *

// --------------------------------------------
#d("ASCII et UTF-8", cellule: 1, fichier: "images.ipynb")[
  #annonce[
    Un caractère est un nombre. ASCII en définit 128, sur un octet chacun :
    lettres sans accent, chiffres, ponctuation. UTF-8 garde ces 128 octets
    et écrit tous les autres caractères sur deux, trois ou quatre octets.
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

  #v(0.3em)
  #code-commente(
    taille-code: 12.5pt, taille-texte: 12pt,
    ("\"œuf\".encode(\"utf-8\").hex(\" \")", "les octets : `len` compte les caractères, `encode` les octets"),
    ("\"œ\".encode(\"ascii\")", "`UnicodeEncodeError` : pas de code ASCII pour `œ`"),
  )

  #legende[
    `œ` manque aussi en ISO 8859-1, l'encodage des textes français avant
    UTF-8 : d'où « oeuf » dans les fichiers anciens.
  ]

  #notes[
    Section 1 : une ligne à compléter dans la première boucle ; `len`
    vaut 1 quatre fois, les octets vont de un à quatre. Explication du
    `Ã©` de `fichiers.ipynb` : `é` écrit en deux octets UTF-8, relus en
    cp1252, donne deux caractères.

    UTF-8 est ce qu'on écrit dans `encoding=`. Les autres encodages
    existent ; ne pas les détailler.
  ]
]

// --------------------------------------------
#d("Des noms de lieux", cellule: 1, fichier: "images.ipynb")[
  #annonce[
    Des noms de communes portent des caractères hors ASCII. Pour les écrire
    tels quels sur une carte, le fichier qui les porte est en UTF-8, et le
    programme qui le lit écrit `encoding="utf-8"`.
  ]

  #tableau(
    columns: (1.3fr, auto, 1fr, auto),
    align: (left + horizon, center + horizon, left + horizon, right + horizon),
    [Commune], [Lettre], [Ce qu'un fichier ASCII peut écrire], [Octets UTF-8],
    [Œuilly (Aisne ; Marne)], [`Œ`], [Oeuilly], [7 pour 6 caractères],
    [Plœuc-L'Hermitage (Côtes-d'Armor)], [`œ`], [Ploeuc-L'Hermitage], [18 pour 17],
    [L'Haÿ-les-Roses (Val-de-Marne)], [`ÿ`], [L'Hay-les-Roses], [16 pour 15],
    [Aÿ-Champagne (Marne)], [`ÿ`], [Ay-Champagne], [13 pour 12],
  )

  #legende[
    La dernière cellule de la section 1 compte, pour chaque nom, les
    caractères et les octets.
  ]

  #notes[
    Le lien avec le métier : les toponymes sont des données, et ils passent
    par des fichiers. Un CSV de communes lu sans `encoding="utf-8"` sur un
    poste Windows donne « PlÅ“uc » ; le même écrit en ASCII a perdu la
    lettre. Les deux erreurs se voient sur la carte.

    Les sections 2 à 6 du notebook (PGM texte et binaire, signatures,
    compression, temps de lecture) sont facultatives. Le poids et la
    compression reviennent au projet 7.
  ]
]
