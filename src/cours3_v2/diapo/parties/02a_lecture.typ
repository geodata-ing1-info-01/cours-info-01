// Partie 2 du cours 3, début : lire un fichier (ouvrir, lire, fermer), puis
// le contenu d'un fichier texte, une suite de caractères où l'objet fichier
// garde une position de lecture.
//
// Incluse par `cours3_v2.typ`, avant `02b_encodage.typ`. Exemple passé de la
// recette à la trace GPS le 04/11/2026 ; `fichiers.ipynb` reste au cours 3 de 2026.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *
#import "../schemas_fichiers.typ": schema-position-lecture

// --------------------------------------------
#d("Lire un fichier : ouvrir, lire, fermer")[
  #annonce[
    Lire un fichier demande trois étapes : l'ouvrir avec la fonction `open`,
    le lire avec une méthode de l'objet fichier, puis le fermer avec la
    méthode `close`.
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
    `encoding` : expliqué à « Fichier texte : une suite d'octets ».

    Après `close()`, `f.read()` lève `ValueError`. Tant qu'il est ouvert, le
    fichier est réservé : sous Windows, un autre programme ne peut ni
    l'effacer ni le remplacer.

    Sur un fichier de plusieurs gigaoctets (un nuage de points LiDAR en
    texte), `read()` échoue faute de mémoire ; la boucle `for` le traite, et
    `break` arrête la lecture. `strip()` enlève la fin de ligne d'une ligne lue.
  ]
]

// --------------------------------------------
#d("Fichier texte : une suite de caractères")[
  #annonce[
    Un éditeur affiche le texte sur plusieurs lignes. Dans le fichier, le
    texte est une seule suite de caractères, et chaque fin de ligne est un
    caractère, noté ⏎ ci-dessous. L'objet fichier garde une position dans cette suite :
    chaque lecture part de cette position et la fait avancer.
  ]

  #align(center, schema-position-lecture())

  #legende[
    La méthode `readline` lit jusqu'au prochain ⏎, inclus.
  ]

  #notes[
    `print(f)` affiche l'objet, `<_io.TextIOWrapper name='trace.csv'
    mode='r' encoding='utf-8'>`, sans le contenu. `trace.csv` : 1 803
    caractères.
  ]
]
