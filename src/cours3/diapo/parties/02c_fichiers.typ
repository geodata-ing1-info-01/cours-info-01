// Partie 2 du cours 3, fin : `with`, les modes d'écriture `"w"` et `"a"`,
// puis les lignes de `generer` qui lisent et écrivent un fichier.
//
// Incluse par `cours3.typ`, après `02b_encodage.typ`. Les sections 7 à 9
// de `fichiers.ipynb` reprennent ces notions en autonomie.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *
#import "../schemas_fichiers.typ": schema-modes-ecriture

// --------------------------------------------
#d("with : fermeture automatique", cellule: 7, fichier: "fichiers.ipynb")[
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
#d("Modes d'écriture : \"w\" et \"a\"", cellule: 9, fichier: "fichiers.ipynb")[
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
    § 9 : `essai.txt` écrit en `"w"`, complété en `"a"`,
    puis remplacé en `"w"`. Le mode `"x"` lève `FileExistsError` si le
    fichier existe.
  ]
]

// --------------------------------------------
#d("Fichiers texte : les lignes du programme")[
  #annonce[
    La fonction `generer` lit la recette, puis écrit la page complétée. Le
    notebook `fichiers.ipynb` reprend ces lignes section par section.
  ]

  #code-commente(
    taille-code: 12.5pt, taille-texte: 12pt,
    ("with open(fichier_recette, encoding=\"utf-8\") as fichier:", "§ 1 et 7 : ouvrir, et fermer à la fin du bloc"),
    ("    source = fichier.read()", "§ 1 : tout le texte, en une chaîne"),
    ("complete = source.replace(…)", ""),
    ("with open(fichier_sortie, \"w\", encoding=\"utf-8\") as fichier:", "§ 9 : mode `\"w\"`, le fichier est créé ou vidé"),
    ("    fichier.write(complete)", "écrire la chaîne"),
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
    Sections 1 à 9 en autonomie, 10 et 11 (CSV, `read_text`) après la
    séance. Deux lignes à compléter, aux § 4 et 8.

    Rappel : sans `encoding="utf-8"`, « é » devient « Ã© » (§ 3).
  ]
]
