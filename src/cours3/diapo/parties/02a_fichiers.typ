// Partie 2 du cours 3, première moitié — lire et écrire des fichiers texte.
//
// Incluse par `cours3.typ`. Les lignes du programme qui manipulent des
// fichiers, puis trois diapositives génériques : l'objet fichier et sa
// position de lecture, `with` face à `open`/`close`, la lecture en bloc ou
// ligne par ligne. `fichiers.ipynb` reprend ces notions en autonomie.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *
#import "../schemas_fichiers.typ": schema-position-lecture

// --------------------------------------------
#d("Fichiers texte : les lignes du programme")[
  #annonce[
    `fichiers.ipynb` explique les lignes de `generer` qui ouvrent, lisent et
    écrivent un fichier.
  ]

  #code-commente(
    taille-code: 12.5pt, taille-texte: 12pt,
    ("with open(fichier_recette, encoding=\"utf-8\") as fichier:", "§ 1 et 2 : ouvrir, et fermer à la fin du bloc"),
    ("    source = fichier.read()", "§ 1 : tout le texte, en une chaîne"),
    ("complete = source.replace(…)", ""),
    ("with open(fichier_sortie, \"w\", encoding=\"utf-8\") as fichier:", "§ 3 : le mode `\"w\"`, créer ou vider"),
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
    Sections 1 à 4 en séance, 5 et 6 (CSV, `read_text`) après. Une seule
    ligne à compléter, au § 4.

    À reprendre en salle : `encoding="utf-8"`. Sans cet argument, Windows lit
    en `cp1252` et « é » devient « Ã© » (fin du § 3). Transition vers ASCII
    et UTF-8, au TD 2b.
  ]
]

// --------------------------------------------
#d("Objet fichier : position de lecture")[
  #annonce[
    `open` renvoie un objet fichier, qui garde une position de lecture.
    Chaque lecture part de cette position et la fait avancer.
  ]

  #align(center, schema-position-lecture())

  #legende[
    `⏎` note le retour à la ligne, le caractère `\n`.
  ]

  #notes[
    `print(f)` affiche l'objet, `<_io.TextIOWrapper name='recette.md'
    mode='r' encoding='utf-8'>`, sans le contenu. Sorties réelles, sur
    `recette.md` des crêpes (400 caractères).

    Tant qu'il est ouvert, le fichier est réservé par le programme : sous
    Windows, un autre programme ne peut ni l'effacer ni le remplacer.
  ]
]

// --------------------------------------------
#d("with : fermeture automatique du fichier")[
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
#d("Lecture en bloc ou ligne par ligne")[
  #annonce[
    Les trois formes lisent le même fichier. Elles diffèrent par ce qu'elles
    renvoient et par ce qu'elles gardent en mémoire.
  ]

  #tableau(
    columns: (auto, 1.5fr, auto),
    align: left + horizon,
    [Code], [Ce qui est obtenu], [En mémoire],
    [`texte = f.read()`], [une chaîne : `'# Crêpes\n\n*10 minutes…'`], [tout le fichier],
    [`lignes = f.readlines()`], [une liste, une chaîne par ligne : `['# Crêpes\n', '\n', …]`], [tout le fichier, découpé],
    [`for ligne in f:`], [une ligne à chaque itération : `'# Crêpes\n'`, puis `'\n'`, puis…], [une ligne à la fois],
  )

  #legende[
    La boucle `for` convient à un fichier plus gros que la mémoire, ou dont
    seul le début est utile : `break` arrête la lecture. Chaque ligne garde
    son `\n` final ; `strip()` l'enlève.
  ]

  #notes[
    Pour un fichier de quelques lignes, `read()` convient. Sur un fichier de
    plusieurs gigaoctets (un nuage de points LiDAR en texte, par exemple),
    `read()` échoue faute de mémoire ; la boucle `for` le traite.
  ]
]
