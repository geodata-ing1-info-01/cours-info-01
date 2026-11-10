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
#import "../schemas_fichiers.typ": schema-lecture-memoire, schema-position-lecture, schema-boucle-fichier, schema-fin-de-ligne, schema-page-cr-lf, schema-machine-a-ecrire

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
#d("En mémoire : fichier texte == suite de caractères")[
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
    mode='r' encoding='utf-8'>`, sans le contenu. `trace.csv` : 2 857
    caractères.
  ]
]
// --------------------------------------------
// Vérifié sur `trace.csv`, Python 3.12 : après `f.readline()`, le premier tour
// donne la première ligne de données.
#d("Boucle sur un fichier : une ligne par tour")[
  #annonce[
    Comme `for altitude in altitudes` parcourt une liste au cours 1,
    `for ligne in f` parcourt les lignes du fichier. À chaque tour, Python lit la
    ligne suivante comme `readline`, à partir de la position de lecture.
  ]

  #align(center, schema-boucle-fichier())

  #legende[
    La boucle s'arrête à la fin du fichier. Chaque ligne garde son ⏎, et
    `strip()` le retire.
  ]

  #notes[
    Au TD 3a, `fichier.readline()` lit l'en-tête de `trace.csv` avant la boucle.
    `float(ligne)` accepte le ⏎ ; après `split(",")`, il resterait dans la
    dernière valeur, d'où `strip()`.
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

  // La barre d'état de `parcours.txt` ouvert dans VS Code.
  #v(0.4em)
  #grid(
    columns: (auto, 1fr), column-gutter: 16pt, align: horizon,
    barre-etat-fin-de-ligne(),
    text(size: 15pt)[
      VS Code affiche la fin de ligne du fichier dans la barre d'état : `LF` pour
      `\n`, `CRLF` pour `\r\n`. Pour en changer, cliquer sur cette mention.
    ],
  )

  #notes[
    Première ligne de `parcours.txt`, le fichier du TD 3b.

    Les fins de ligne de `parcours.txt` sont des `\n` : VS Code affiche `LF`, y
    compris sous Windows. Un fichier créé dans VS Code sous Windows est en `CRLF`, car le
    réglage `files.eol` vaut `auto` par défaut.

    `\r` seul (anciens Mac) est aussi lu comme `\n`. `newline=""` supprime la
    conversion : le module `csv` le demande.

    Octets : `0a` sous Linux et macOS, `0d 0a` sous Windows, visibles à « Lecture
    en mode binaire ».
  ]
]

// --------------------------------------------
// Diapositive de culture : CR et LF sur une feuille et sur une machine à écrire.
#d("Origine de CR et LF : la machine à écrire")[
  #annonce[
    Les téléscripteurs, puis le code ASCII, ont codé les deux mouvements du passage
    à la ligne par deux caractères de contrôle : CR, _carriage return_ (retour
    chariot), et LF, _line feed_ (saut de ligne).
  ]

  #align(center, grid(
    columns: (auto, auto), column-gutter: 40pt,
    panneau("Sur la feuille", schema-page-cr-lf()),
    panneau("Sur la machine à écrire", schema-machine-a-ecrire()),
  ))

  #notes[
    Diapositive de culture, à passer vite. Sur une machine mécanique, le levier
    fait aussi tourner le rouleau d'une ligne, et produit ainsi CR et LF en un seul
    mouvement. MS-DOS, puis Windows, ont gardé les deux caractères ; Unix n'a
    gardé que LF.
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
