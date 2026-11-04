// Partie 2 du cours 3, fin : `with`, les modes d'écriture `"w"` et `"a"`,
// puis les lignes d'`altitudes.py` qui lisent et écrivent un fichier.
//
// Incluse par `cours3_v2.typ`, après `02b_encodage.typ`.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *
#import "../schemas_fichiers.typ": schema-modes-ecriture

// --------------------------------------------
#d("with : fermeture automatique")[
  #annonce[
    Un fichier ouvert doit être fermé. Le bloc `with` le ferme à la sortie
    du bloc indenté, y compris en cas d'erreur.
  ]

  #face-a-face(
    panneau("open, puis close")[
      #sortie("f = open(chemin, encoding=\"utf-8\")\ntexte = f.read()\nf.close()", taille: 12pt)
    ],
    panneau("with")[
      #sortie("with open(chemin, encoding=\"utf-8\") as f:\n    texte = f.read()\n# ici, f est fermé", taille: 12pt)
    ],
  )

  #v(0.3em)
  #tableau(
    columns: (1fr, 1fr, 1fr),
    align: left + horizon,
    [Situation], [`open`, puis `close()`], [`with`],
    [une erreur survient pendant la lecture], [reste ouvert : `close()` n'est pas atteint], [fermé],
    [`close()` oublié], [reste ouvert jusqu'à la fin du programme], [aucun `close()` à écrire],
  )

  #notes[
    `as f` donne le nom de l'objet fichier ; le bloc indenté est la durée
    d'ouverture. Forme à employer, et celle des fonctions utiles.
  ]
]

// --------------------------------------------
#d("Modes d'écriture : \"w\" et \"a\"")[
  #annonce[
    Le mode `"w"` vide le fichier à l'ouverture, puis écrit depuis le début.
    Le mode `"a"` conserve le contenu et écrit à la fin. Dans les deux modes,
    un fichier absent est créé.
  ]

  #align(center, schema-modes-ecriture())

  #legende[
    Le trait bleu marque la position d'écriture ; les cases en couleur sont
    les caractères écrits par `write`.
  ]

  #notes[
    Le TD 3c écrit `resume.txt` en `"w"`, puis le complète en `"a"`. Le mode
    `"x"` lève `FileExistsError` si le fichier existe.
  ]
]

// --------------------------------------------
// Revue le 04/11/2026 : les lignes d'`altitudes.py`, corrigé du TD 3c.
#d("Fichiers texte : les lignes du programme")[
  #annonce[
    Le programme `altitudes.py` lit la trace ligne par ligne, puis ajoute son
    résumé à un fichier.
  ]

  #code-commente(
    taille-code: 12.5pt, taille-texte: 12pt,
    ("with open(FICHIER, encoding=\"utf-8\") as fichier:", "ouvrir, et fermer à la fin du bloc"),
    ("    fichier.readline()", "la ligne d'en-tête, ignorée"),
    ("    for ligne in fichier:", "une ligne à la fois"),
    ("        duree, x, y, z = ligne.strip().split(\",\")", "les quatre valeurs de la ligne"),
    ("        altitudes.append(float(z))", "l'altitude, convertie en nombre"),
    ("with open(\"resume.txt\", \"a\", encoding=\"utf-8\") as sortie:", "mode `\"a\"` : le fichier est créé ou complété"),
    ("    sortie.write(texte)", "écrire la chaîne"),
  )

  #tableau(
    columns: (auto, 1fr, 1fr, 1fr),
    align: left + horizon,
    [Mode], [Ce qu'il fait], [Fichier absent], [Fichier présent],
    [`"r"`], [lire (défaut)], [erreur], [lu],
    [`"w"`], [écrire], [créé], [vidé, puis réécrit],
    [`"a"`], [ajouter à la fin], [créé], [conservé, complété],
  )

  #notes[
    `sortie.write(texte)` abrège la ligne du corrigé, qui écrit le nom du fichier,
    le seuil et les deux cumuls.

    Rappel : sans `encoding="utf-8"`, « é » devient « Ã© ».
  ]
]
