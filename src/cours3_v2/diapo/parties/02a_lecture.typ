// Partie 2 du cours 3 v2, début : lire un fichier, du disque au processeur, puis
// les mémoires, le contenu d'un fichier texte, une suite de caractères où l'objet
// fichier garde une position de lecture, la fin de ligne et `with`.
//
// Incluse par `cours3_v2.typ`, avant `02b_encodage.typ`. Exemple passé de la
// recette à la trace GPS le 04/11/2026 ; `fichiers.ipynb` reste au cours 3 de 2026.
// Réordonnée le 05/11/2026 : le matériel après la première lecture, `with` depuis
// `02c_fichiers.typ`, la fin de ligne depuis `02b_encodage.typ`, le tableau des
// méthodes passé au récapitulatif de `02c_fichiers.typ`.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *
#import "../../../cours5/diapo/schemas.typ": repere
#import "../schemas_fichiers.typ": schema-lecture-memoire, schema-position-lecture, schema-fin-de-ligne

// --------------------------------------------
// Fusion de « Lire un fichier : ouvrir, lire, fermer » et de « Lecture d'un
// fichier : du disque au processeur » (05/11/2026). Les numéros des lignes de code
// sont ceux des flèches du schéma.
#d("Lecture d'un fichier : du disque au processeur")[
  #annonce[
    Lire un fichier demande trois étapes : l'ouvrir avec la fonction `open`,
    le lire avec une méthode de l'objet fichier, puis le fermer avec la
    méthode `close`. Le programme traite ensuite le texte lu.
  ]

  #{
    let ligne(code, numeros, commentaire) = (
      raw(lang: "python", code),
      numeros.map(n => repere(n, taille: 17pt)).join(h(2pt)),
      text(size: 13pt, fill: estompe, commentaire),
    )
    show raw: set text(size: 12.5pt)
    grid(
      columns: (auto, 40pt, 1fr), column-gutter: 8pt, row-gutter: 2pt,
      align: left + horizon,
      ..ligne("f = open(chemin, encoding=\"utf-8\")", (), [ouvrir : `f` est l'objet fichier]),
      ..ligne("texte = f.read()", (1,), [lire : copie du fichier du disque vers la mémoire vive]),
      ..ligne("f.close()", (), [fermer]),
      ..ligne("majuscules = texte.upper()", (2, 3), [traiter : le processeur copie `texte` dans son cache]),
    )
  }

  #v(0.3em)
  #align(center, schema-lecture-memoire())

  #legende[
    Une modification de `texte` reste en mémoire vive. Le fichier sur le disque
    ne change qu'avec `f.write`.
  ]

  #notes[
    `encoding` : expliqué à « Encodage d'un fichier texte ».

    Après `close()`, `f.read()` lève `ValueError`. Tant qu'il est ouvert, le
    fichier est réservé : sous Windows, un autre programme ne peut ni
    l'effacer ni le remplacer.

    `f.read()` passe par le système d'exploitation (cours 1), qui lit le disque
    par blocs et garde ces blocs en mémoire vive. Python décode ensuite les
    octets en caractères : voir « Encodage d'un fichier texte ».

    `upper` écrit une nouvelle chaîne en mémoire vive ; `texte` ne change pas.

    Les registres sont une mémoire de quelques octets dans le cœur, où une
    instruction lit ses nombres et écrit ses résultats. Cœur et instructions :
    « Exécution des instructions machine : un cœur », cours 1.

    Le texte d'un programme suit le même chemin : `python` lit le fichier
    enregistré (cours 1).
  ]
]

// Les mémoires et leurs ordres de grandeur.
#include "02a_memoire.typ"

// --------------------------------------------
#d("Fichier texte : une suite de caractères")[
  #annonce[
    Un éditeur affiche le texte sur plusieurs lignes. Dans le fichier, le
    texte est une seule suite de caractères, et chaque fin de ligne est un
    caractère, noté ⏎ ci-dessous. L'objet fichier contient une position de lecture.
    Chaque lecture part de cette position et la fait avancer.
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
// --------------------------------------------
// Placée ici le 05/11/2026, à la suite de ⏎ et avant « fin de ligne comprise ».
// L'octet n'étant pas encore défini, le schéma montre des caractères.
#d("Fin de ligne")[
  #annonce[
    La fin de ligne est un caractère de contrôle, écrit `\n` en Python.
    Sous Linux et macOS, elle est codée par ce seul caractère ; sous
    Windows, par les deux caractères `\r\n`.
  ]

  #align(center, schema-fin-de-ligne())

  #legende[
    En mode texte, Python remplace `\r\n` par `\n` à la lecture. À
    l'écriture sous Windows, il remplace chaque `\n` par `\r\n`. Dans le
    programme, les lignes sont toujours séparées par `\n`.
  ]

  #notes[
    `\r` seul (anciens Mac) est aussi lu comme `\n`. `newline=""` supprime la
    conversion : le module `csv` le demande.

    Octets : `0a` sous Linux et macOS, `0d 0a` sous Windows, visibles à « Lecture
    en mode binaire ».
  ]
]

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
    [une erreur survient pendant la lecture], [le fichier reste ouvert, car `close()` n'est pas exécuté], [fermé],
    [`close()` oublié], [reste ouvert jusqu'à la fin du programme], [aucun `close()` à écrire],
  )

  #notes[
    `as f` donne le nom de l'objet fichier ; le bloc indenté est la durée
    d'ouverture. Forme à employer.
  ]
]
