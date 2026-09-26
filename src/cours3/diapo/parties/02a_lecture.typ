// Partie 2 du cours 3, début : lire un fichier (ouvrir, lire, fermer), puis
// le contenu d'un fichier texte, une suite de caractères où l'objet fichier
// garde une position de lecture.
//
// Incluse par `cours3.typ`, avant `02b_encodage.typ`. Les sections 1 et 2 de
// `fichiers.ipynb` reprennent ces notions en autonomie ; chaque
// diapositive porte le cartouche de sa section.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *
#import "../schemas_fichiers.typ": schema-position-lecture

// --------------------------------------------
#d("Lire un fichier : ouvrir, lire, fermer", cellule: 1, fichier: "fichiers.ipynb")[
  #annonce[
    Lire un fichier demande trois étapes : l'ouvrir avec la fonction `open`,
    le lire avec une méthode de l'objet fichier, puis le fermer avec la
    méthode `close`. Le tableau résume les façons de lire un fichier ouvert.
  ]

  #code-commente(
    taille-code: 12.5pt, taille-texte: 12pt,
    ("f = open(chemin, encoding=\"utf-8\")", "1. ouvrir : `f` est l'objet fichier"),
    ("texte = f.read()", "2. lire, ici avec la méthode `read`"),
    ("f.close()", "3. fermer"),
  )

  #tableau(
    columns: (auto, 1.5fr, auto),
    align: left + horizon,
    [Lecture], [Ce qui est obtenu], [En mémoire],
    [`texte = f.read()`], [une chaîne : tout le texte], [tout le fichier],
    [`ligne = f.readline()`], [une chaîne : la ligne suivante, fin de ligne comprise], [une ligne],
    [`lignes = f.readlines()`], [une liste de chaînes, une par ligne], [tout le fichier, découpé],
    [`for ligne in f:`], [une chaîne à chaque itération, une par ligne], [une ligne à la fois],
  )

  #notes[
    `encoding` : expliqué deux diapositives plus loin.

    Après `close()`, `f.read()` lève `ValueError`. Tant qu'il est ouvert, le
    fichier est réservé : sous Windows, un autre programme ne peut ni
    l'effacer ni le remplacer.

    Sur un fichier de plusieurs gigaoctets (un nuage de points LiDAR en
    texte), `read()` échoue faute de mémoire ; la boucle `for` le traite, et
    `break` arrête la lecture. `strip()` enlève la fin de ligne d'une ligne lue.
  ]
]

// --------------------------------------------
#d("Fichier texte : une suite de caractères", cellule: 2, fichier: "fichiers.ipynb")[
  #annonce[
    Un éditeur affiche le texte sur plusieurs lignes. Dans le fichier, le
    texte est une seule suite de caractères, et chaque fin de ligne est un
    caractère, noté ⏎ ci-dessous. L'objet fichier garde une position dans cette suite :
    chaque lecture part de cette position et la fait avancer.
  ]

  #align(center, schema-position-lecture())

  #legende[
    ␣ représente l'espace. La méthode `readline` lit jusqu'au prochain
    ⏎, inclus.
  ]

  #notes[
    `print(f)` affiche l'objet, `<_io.TextIOWrapper name='recette.md'
    mode='r' encoding='utf-8'>`, sans le contenu. `recette.md` des crêpes :
    400 caractères.
  ]
]

// --------------------------------------------
#d("Caractères de contrôle : \\n et \\t", cellule: 2, fichier: "fichiers.ipynb")[
  #annonce[
    La fin de ligne et la tabulation sont des caractères de contrôle, sans
    symbole visible. Dans une chaîne Python, ils s'écrivent avec une barre
    oblique inverse suivie d'une lettre.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Caractère], [Dans une chaîne], [Affiché par `print`],
    [fin de ligne (⏎)], [`"\n"`], [passage à la ligne suivante],
    [tabulation], [`"\t"`], [décalage jusqu'à la colonne suivante],
  )

  #face-a-face(
    panneau("Code")[
      #sortie("print(\"un\\tdeux\\ntrois\")\nprint(len(\"\\n\"))\nprint(repr(\"# Crêpes\\n\"))", taille: 12pt)
    ],
    panneau("Sortie")[
      #sortie("un      deux\ntrois\n1\n'# Crêpes\\n'", taille: 12pt)
    ],
  )

  #legende[
    `\n` compte pour un seul caractère. Une fin de ligne tapée avec la
    touche Entrée entre les guillemets termine la ligne de code : Python
    lève `SyntaxError: unterminated string literal`.
  ]

  #notes[
    Sortie réelle, Python 3.13. `repr` affiche une chaîne telle qu'elle
    s'écrit en Python. Le chemin Windows `"C:\temp\notes"`
    contient `\t` et `\n` : l'écrire avec `Path` et des `/`. `"\\"` écrit
    une barre oblique inverse.
  ]
]
