// Partie 1 du cours 5 v2 : réutiliser des programmes et des bibliothèques. Incluse par
// `cours5_v2.typ`.
//
// Nouveau (06/11/2026) : la problématique, à haut niveau. Ne pas tout recoder ; ce que le
// programme fait avec deux fonctionnalités de plus, en pseudo-code ; ce que cela demande sur
// le poste de développement ; le problème posé par la distribution du code ; les étapes sur
// chaque poste. L'outil d'installation n'est pas nommé ici : partie 4.
//
// Sorties relevées le 06/11/2026 sous Linux, Python 3.12, GDAL 3.13.3, folium 0.20, avec
// `data/cours5_v2/programme/carte_trace.py`. L'autre poste est un environnement réduit à
// Python, puis à Python et `folium`. Rien n'a tourné sur un poste de la salle.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../../../cours3_v2/diapo/schemas.typ": poste, script

// --------------------------------------------
#d("Réutilisation d'outils existants")[
  #annonce[
    Un programme peut appeler des outils écrits et testés par d'autres, sans tout recoder.
  ]

  #grid(
    columns: (1fr, 1fr), gutter: 12pt, rows: 84pt,
    bloc("Un programme existant", "se lance par une commande : ogr2ogr, ffmpeg, git…", hauteur: 100%),
    bloc("Une bibliothèque existante", "s'importe dans le code : folium, numpy, pillow…", hauteur: 100%),
  )

  #v(0.4em)
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Tout recoder], [Réutiliser un outil existant],
    [Écriture du code], [tout le calcul et ses cas particuliers], [l'appel à l'outil],
    [Correction des erreurs], [par l'auteur du programme], [par les auteurs de l'outil],
    [Installation], [Python], surligne[Python et l'outil, sur chaque poste qui lance le programme],
  )

  #notes[
    Message de la séance. Cours 3 : une autre personne utilise le code. Cours 5 : le code
    appelle des outils écrits par d'autres.

    Les deux blocs : parties 2 et 3. La ligne en bleu : partie 4. Un outil réutilisé est une
    dépendance. Il faut l'installer sur chaque poste.

    Ne pas entrer dans Python ici : le détail vient après.
  ]
]

// --------------------------------------------
#d("Exemple : deux nouvelles fonctionnalités")[
  #annonce[
    `stats_trace.py`, le programme du cours 4, lit un fichier CSV. Une montre enregistre un
    fichier GPX. L'objectif est de lire ce fichier et d'afficher la trace sur une carte.
  ]

  #grid(
    columns: (1fr, auto), column-gutter: 14pt, align: horizon,
    {
      show table.cell: set text(size: 13.5pt)
      tableau(
        columns: (0.9fr, 1fr, 1fr),
        align: left + horizon,
        [Fonctionnalité], [Tout recoder], [Outil existant],
        [lire un fichier GPX et convertir ses positions en mètres], [lire le format XML, calculer la projection], [`ogr2ogr`, un programme de GDAL, qui gère 69 formats de fichiers],
        [afficher la trace sur une carte], [récupérer les tuiles de fond, gérer le zoom, dessiner la trace], [`folium`, une bibliothèque de 9 495 lignes de Python],
      )
    },
    image("/src/cours5_v2/images/carte_trace_2.png", height: 155pt),
  )

  #legende[
    La carte obtenue affiche, sur le Plan IGN, une marche simulée sur un chemin réel, de la
    gare de Noisy-Champs à Geodata Paris.
  ]

  #notes[
    La carte sert d'exemple. Le message porte sur la réutilisation.

    Un GPX donne des degrés, et le calcul de distance du TD 4a demande des mètres.

    Relevé le 06/11/2026 : `ogrinfo --formats` liste 69 formats ; la bibliothèque compilée de
    GDAL pèse 39 Mo, et `proj.db`, la base des systèmes de coordonnées, 11 Mo. `folium` compte
    9 495 lignes de Python, sans Leaflet, écrit en JavaScript.

    À l'affichage, le navigateur charge Leaflet et les tuiles par le réseau. À
    vérifier depuis une VM de la salle : l'accès à `data.geopf.fr` et au CDN de Leaflet.
  ]
]

// --------------------------------------------
#d("Ajout des fonctionnalités : code et installations")[
  #grid(
    columns: (1.3fr, 1fr), column-gutter: 18pt, align: top,
    panneau("Le programme, en pseudo-code")[
      #script("importer la bibliothèque de carte\n\nlire le chemin du fichier GPX\nappeler le programme de conversion : GPX → CSV\nlire le CSV et calculer le résumé (cours 4)\nafficher le résumé\nappeler la fonction d'affichage de la carte", vives: (1, 4, 7), taille: 13pt, lang: none)
    ],
    panneau("Sur le poste de développement")[
      #chaine-verticale(
        ecart: 2pt,
        ("Installer l'outil de conversion", "ogr2ogr, un programme"),
        ("Installer la bibliothèque Python", "folium"),
        ("Modifier le code", "les lignes en bleu"),
      )
    ],
  )

  #legende[
    En bleu, les lignes ajoutées au programme du cours 4.
  ]

  #notes[
    Le calcul du cours 4 ne change pas. Les lignes en bleu appellent un programme et une
    bibliothèque, absents du code.

    L'appel du programme : partie 2. L'import et la fonction de carte : partie 3. La façon
    d'installer : partie 4.
  ]
]

// --------------------------------------------
#d("Distribution du code : nouveau poste")[
  #annonce[
    Copié tel quel, le code ne fonctionne pas sur un nouveau poste, sauf si on y refait les
    mêmes installations. Il faut donc décrire ces installations.
  ]

  #grid(
    columns: (1fr, 1fr), column-gutter: 14pt, align: top,
    poste("Poste de développement", "C:/Users/alice/cours5/", "carte_trace.py, stats_trace.py, trace_2.gpx",
      "$ python carte_trace.py trace_2.gpx\n…\nvitesse moyenne : 1.29 m/s, soit 4.6 km/h\ncarte écrite : trace_2.html"),
    poste("Nouveau poste", "C:/Users/eleve/projet/", "carte_trace.py, stats_trace.py, trace_2.gpx",
      "$ python carte_trace.py trace_2.gpx\nModuleNotFoundError: No module named 'folium'\n# une fois folium installé :\nFileNotFoundError: [Errno 2] No such file or\ndirectory: 'ogr2ogr'",
      erreur: true),
  )

  #v(0.5em)
  #grid(
    columns: (1fr, 1fr), gutter: 14pt, rows: 86pt,
    bloc("Décrire dans la documentation", "le README liste ce qu'il faut installer", hauteur: 100%),
    bloc("Décrire dans un fichier de projet", "un outil standard lit ce fichier, et installe les dépendances", hauteur: 100%),
  )

  #notes[
    Le dossier copié contient le code, sans l'outil de conversion ni la bibliothèque.

    Le README : cours 2. Le fichier de projet et l'outil : partie 4. Ne pas les nommer ici.

    Sorties réelles, sous Linux ; seule la dernière ligne de chaque erreur est affichée. Sous
    Windows, le second message est attendu sous la forme `[WinError 2]`, à relever sur un
    poste de la salle.

    Le paquet `anaconda` 2025.06 (win-64) ne contient ni `gdal` ni `folium` : ces erreurs sont
    attendues en salle. La version installée sur les postes reste à confirmer.
  ]
]

// --------------------------------------------
#d("Distribution du code : étapes sur chaque poste")[
  #panneau("Poste de développement")[
    #chaine(
      ecart: 18pt,
      ("Installer", "les dépendances"),
      ("Tester", "chaque outil, sur un exemple"),
      ("Modifier le code", "ajouter les appels"),
      ("Mettre à jour", "la documentation ou le fichier de projet"),
    )
  ]

  #align(center, text(size: 14pt, fill: estompe)[#sym.arrow.b copie du dossier, ou dépôt git])

  #panneau("Nouveau poste, autre utilisateur")[
    #grid(
      columns: (auto, 1fr), column-gutter: 12pt, row-gutter: 8pt, align: horizon,
      text(size: 14pt, weight: demi-gras)[Avec la \ documentation],
      chaine(
        ecart: 18pt,
        ("Lire la documentation", "le README"),
        ("Suivre les instructions", "installer chaque dépendance"),
        ("Lancer le programme", ""),
      ),
      text(size: 14pt, weight: demi-gras)[Avec le fichier \ de projet],
      chaine(
        ecart: 18pt,
        ("Installer les dépendances", "un outil spécifique lit le fichier"),
        ("Lancer le programme", ""),
      ),
    )
  ]

  #notes[
    Schéma à reprendre en ouvrant les parties suivantes. Partie 2 : l'appel d'un programme.
    Partie 3 : les bibliothèques. Partie 4 : l'outil et le fichier de projet.

    Avec le fichier de projet, le nouveau poste compte moins d'étapes. Sur le poste de
    développement, il faut écrire ce fichier et le tenir à jour.
  ]
]
