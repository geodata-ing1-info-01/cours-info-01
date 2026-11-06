// Partie 1 du cours 3 v2 : la portabilité du code. Incluse par `cours3_v2.typ`.
//
// Repris le 05/11/2026 : quatre versions du même script, avec ce qu'une autre
// personne fait pour traiter ses données, puis les pratiques non traitées et la
// bibliothèque standard. Le détail de pathlib et d'argparse est dans
// `02d_chemins_arguments.typ`.
//
// Sorties relevées avec les scripts affichés, Python 3.12, dans un dossier nommé
// comme celui d'Alice, puis dans un autre. Le chemin `C:/Users/alice/cours3/`
// est plus court que celui du TD 3b, pour tenir dans le panneau. Le fichier de
// données a une valeur par ligne : les mêmes valeurs que la liste de la première
// version, et une lecture sans en-tête ni découpage. Le TD 3b reprend `trace.csv`.
//
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *

// Les lignes communes aux trois versions qui lisent un fichier. `CHEMIN` est
// remplacé par ce que la version passe à `open`.
#let lecture = "altitudes = []\nwith open(CHEMIN, encoding=\"utf-8\") as f:\n    for ligne in f:\n        altitudes.append(float(ligne))\n\nprint(\"minimum :\", min(altitudes))\nprint(\"maximum :\", max(altitudes))"

// --------------------------------------------
#d("Données écrites dans le script")[
  #version-script(
    "altitudes = [79.6, 103.2, 98.3, 92.5, 123.7]\n\nprint(\"minimum :\", min(altitudes))\nprint(\"maximum :\", max(altitudes))",
    vives: (1,),
    poste("Poste d'Alice", "C:/Users/alice/cours3/", "altitudes.py",
      "$ python altitudes.py\nminimum : 79.6\nmaximum : 123.7"),
    [copie du script],
    poste("Autre poste", "C:/Users/eleve/projet/", "altitudes.py",
      "$ python altitudes.py\nminimum : 79.6\nmaximum : 123.7"),
    [Ouvrir `altitudes.py`, puis remplacer les valeurs de la liste `altitudes`.],
  )

  #legende[
    Le code et les données sont dans le même fichier. Le script affiche les
    altitudes d'Alice sur tous les postes.
  ]

  #notes[
    À dire en ouvrant la partie : au cours 1, lancer un script ; au cours 2,
    éditer le code ; ici, ce qu'il faut pour qu'une autre personne utilise ce
    code.

    Quatre versions du même script. Les lignes en bleu changent d'une version à
    l'autre. Ne pas expliquer le code ici : il est détaillé après.

    Le programme de la fin du TD 2c, réduit à deux lignes d'affichage. Même liste
    qu'au départ du TD 3a.
  ]
]

// --------------------------------------------
#d("Chemin absolu écrit dans le script")[
  #version-script(
    "FICHIER = \"C:/Users/alice/cours3/altitudes.txt\"\n\n" + lecture.replace("CHEMIN", "FICHIER"),
    vives: (1,),
    donnees: "79.6\n103.2\n…\n123.7",
    poste("Poste d'Alice", "C:/Users/alice/cours3/", "altitudes.py, altitudes.txt",
      "$ python altitudes.py\nminimum : 79.6\nmaximum : 123.7"),
    [copie du dossier],
    poste("Autre poste", "C:/Users/eleve/projet/", "altitudes.py, altitudes.txt",
      "$ python altitudes.py\nFileNotFoundError: [Errno 2] No such file or\ndirectory: 'C:/Users/alice/cours3/altitudes.txt'",
      erreur: true),
    [Ouvrir `altitudes.py`, puis remplacer le chemin de `FICHIER`.],
  )

  #legende[
    Les données sont dans un fichier, séparé du code. `C:/Users/alice/…` n'existe
    pas ailleurs, ni après un déplacement du dossier.
  ]

  #notes[
    Sorties réelles, Python 3.12 ; seule la dernière ligne de l'erreur est
    affichée, sur deux lignes pour tenir dans le panneau.

    Les valeurs de la version précédente, une par ligne. `float` ignore la fin de
    ligne. La lecture du fichier est détaillée dans la partie suivante.

    Le TD 3b part de ce problème, sur `trace.csv`.
  ]
]

// --------------------------------------------
#d("Chemin construit à partir du script")[
  #version-script(
    "from pathlib import Path\n\nDOSSIER = Path(__file__).parent\nFICHIER = DOSSIER / \"altitudes.txt\"\n\n" + lecture.replace("CHEMIN", "FICHIER"),
    vives: (1, 3, 4),
    poste("Poste d'Alice", "C:/Users/alice/cours3/", "altitudes.py, altitudes.txt",
      "$ python altitudes.py\nminimum : 79.6\nmaximum : 123.7"),
    [copie du dossier],
    poste("Autre poste", "C:/Users/eleve/projet/", "altitudes.py, altitudes.txt",
      "$ python altitudes.py\nminimum : 79.6\nmaximum : 123.7"),
    [Copier son fichier dans le dossier du script. Ouvrir `altitudes.py`, puis remplacer `altitudes.txt` par le nom de son fichier.],
  )

  #legende[
    Le chemin ne dépend plus du poste. `Path` et `__file__` sont détaillés dans la
    partie suivante.
  ]

  #notes[
    `Path(__file__).parent` : le dossier du script. Le TD 3b essaie `Path.cwd()`,
    puis `__file__`.
  ]
]

// --------------------------------------------
#d("Chemin donné sur la ligne de commande")[
  #version-script(
    "import argparse\n\nanalyseur = argparse.ArgumentParser()\nanalyseur.add_argument(\"fichier\")\noptions = analyseur.parse_args()\n\n" + lecture.replace("CHEMIN", "options.fichier"),
    vives: (1, 3, 4, 5, 8),
    poste("Poste d'Alice", "C:/Users/alice/cours3/", "altitudes.py, altitudes.txt",
      "$ python altitudes.py altitudes.txt\nminimum : 79.6\nmaximum : 123.7"),
    [copie du script],
    poste("Autre poste", "C:/Users/eleve/projet/", "altitudes.py, mes_altitudes.txt",
      "$ python altitudes.py mes_altitudes.txt\nminimum : 111.8\nmaximum : 118.9"),
    [Écrire le chemin de son fichier après le nom du script. Le code ne change pas.],
  )

  #legende[
    Le code ne contient plus de nom de fichier. `argparse` est détaillé dans la
    partie suivante.
  ]

  #notes[
    Le chemin donné sur la ligne de commande part du dossier du terminal : celui
    de la personne qui lance le programme.

    Le TD 3b passe aussi le seuil par la ligne de commande.
  ]
]

// --------------------------------------------
// Nouveau, 05/11/2026. Exemples exécutés, Python 3.12.
#d("Autres bonnes pratiques : journal et tests")[
  #annonce[
    Un *journal* (log) enregistre ce que le programme a fait, par exemple le
    fichier lu. Un *test* vérifie qu'une fonction renvoie le résultat attendu.
    Ces deux pratiques ne sont pas traitées dans cette séance.
  ]

  #face-a-face(
    panneau("Journal, avec le module logging")[
      #sortie("import logging\n\nlogging.basicConfig(level=logging.INFO)\nlogging.info(\"Lecture de %s\", \"trace.csv\")", taille: 12pt)
      #sortie("INFO:root:Lecture de trace.csv", taille: 12pt)
    ],
    panneau("Test, avec assert")[
      #sortie("def moyenne(valeurs):\n    return sum(valeurs) / len(valeurs)\n\nassert moyenne([2, 4]) == 3", taille: 12pt)
    ],
  )

  #legende[
    `assert` ne fait rien si la condition est vraie, et lève `AssertionError` sinon.
    Documentation : docs.python.org/fr/3/library/logging.html et
    docs.python.org/fr/3/library/unittest.html.
  ]

  #notes[
    Les citer sans s'y attarder.

    Le module `unittest` regroupe les tests d'un projet et les lance tous.
  ]
]

// --------------------------------------------
// Nouveau, 05/11/2026. Exemples exécutés, Python 3.12.
#d("Bibliothèque standard de Python")[
  #annonce[
    Python est livré avec une bibliothèque standard, dont les modules s'importent
    sans installation. Avant d'écrire une fonction, chercher si un module la
    fournit déjà.
  ]

  #tableau(
    columns: (1fr, auto, 1fr),
    align: left + horizon,
    [Besoin], [Module], [Exemple],
    [chemins de fichiers], [`pathlib`], [`Path(__file__).parent`],
    [arguments de la ligne de commande], [`argparse`], [`analyseur.parse_args()`],
    [fichiers CSV], [`csv`], [`csv.reader(f)`],
    [moyenne, médiane], [`statistics`], [`statistics.mean(altitudes)`],
    [fonctions mathématiques], [`math`], [`math.sqrt(x)`],
    [dates et durées], [`datetime`], [`datetime.strptime(texte, format)`],
  )

  #legende[
    Liste complète : docs.python.org/fr/3/library/.
  ]

  #notes[
    `pathlib` et `argparse` : partie suivante. `datetime` : étape B6 du TD 4a.

    Le programme du cours 1 calcule une moyenne avec une boucle, pour écrire une
    boucle. `statistics.mean` renvoie le même résultat, 93.7 sur sa liste.
  ]
]
