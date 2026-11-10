// Partie 1 du cours 3 v2 : la portabilité du code. Incluse par `cours3_v2.typ`.
//
// Repris le 05/11/2026 : quatre versions du même script, avec ce qu'une autre
// personne fait pour traiter ses données, puis les pratiques non traitées et la
// bibliothèque standard. Le détail de pathlib et d'argparse est dans
// `02d_chemins_arguments.typ`.
//
// Sorties relevées avec les scripts affichés, Python 3.12, dans un dossier nommé
// comme celui d'Alice, puis dans un autre. Le chemin `C:/Users/alice/cours3/`
// est aussi celui du programme d'Alice au TD 3b. Le fichier de
// données a une valeur par ligne : les mêmes valeurs que la liste de la première
// version, et une lecture sans en-tête ni découpage. Le TD 3b reprend `trace.csv`.
//
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *

// Les lignes communes aux deux versions qui passent une variable à `open`.
// `CHEMIN` est remplacé par cette variable.
#let lecture = "altitudes = []\nwith open(CHEMIN, encoding=\"utf-8\") as f:\n    for ligne in f:\n        altitudes.append(float(ligne))\n\nprint(\"minimum :\", min(altitudes))\nprint(\"maximum :\", max(altitudes))"

// --------------------------------------------
#d("Pb 1 : code et données dans le même fichier")[
  #annonce[
    Avantage : le script s'exécute sans erreur sur tous les postes.\
    Inconvénient : il faut modifier le script pour traiter d'autres données.
  ]

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

  #notes[
    À dire en ouvrant la partie : au cours 1, lancer un script ; au cours 2,
    éditer le code ; ici, ce qu'il faut pour qu'une autre personne utilise ce
    code.

    Quatre versions du même script. Les lignes en bleu changent d'une version à
    l'autre. Ne pas expliquer le code ici : il est détaillé après.

    Fil des quatre diapositives. Titre : le problème de la version affichée.
    Annonce, à partir de Pb 2 : d'abord ce que la version corrige. Pb 1 et Pb 3 :
    il faut modifier le script pour traiter d'autres données. Pb 2 : le script
    échoue sur un autre poste, et le chemin est à chercher dans le code. Le
    récapitulatif suit la solution.

    Le programme de la fin du TD 2c, réduit à deux lignes d'affichage. Même liste
    qu'au départ du TD 3a.
  ]
]

// --------------------------------------------
#d("Pb 2 : chemin absolu au milieu du code")[
  #annonce[
    Les données sont dans un fichier, séparé du code.\
    `C:/Users/alice/…` n'existe pas ailleurs, ni après un déplacement du dossier.
  ]

  #version-script(
    "altitudes = []\nwith open(\"C:/Users/alice/cours3/altitudes.txt\",\n          encoding=\"utf-8\") as f:\n    for ligne in f:\n        altitudes.append(float(ligne))\n\nprint(\"minimum :\", min(altitudes))\nprint(\"maximum :\", max(altitudes))",
    vives: (2,),
    donnees: "79.6\n…\n123.7",
    poste("Poste d'Alice", "C:/Users/alice/cours3/", "altitudes.py, altitudes.txt",
      "$ python altitudes.py\nminimum : 79.6\nmaximum : 123.7"),
    [copie du dossier],
    poste("Autre poste", "C:/Users/eleve/projet/", "altitudes.py, altitudes.txt",
      "$ python altitudes.py\nFileNotFoundError: [Errno 2] No such file or\ndirectory: 'C:/Users/alice/cours3/altitudes.txt'",
      erreur: true),
    [Ouvrir `altitudes.py`, chercher le chemin dans le code, puis le remplacer.],
  )

  #notes[
    Sorties réelles, Python 3.12 ; seule la dernière ligne de l'erreur est
    affichée, sur deux lignes pour tenir dans le panneau.

    Le chemin est écrit dans l'appel à `open`. Dans un script de plusieurs
    centaines de lignes, il faut d'abord trouver cet appel.

    Les valeurs de la version précédente, une par ligne. `float` ignore la fin de
    ligne. La lecture du fichier est détaillée dans la partie suivante.

    Le TD 3b part de ce problème, sur `trace.csv`.
  ]
]

// --------------------------------------------
#d("Pb 3 : chemin relatif écrit dans le script")[
  #annonce[
    Le chemin est relatif au dossier du script et ne dépend plus du poste.\
    Une autre personne trouve le nom du fichier au début du script, sans lire le
    reste du code.
  ]

  #version-script(
    "from pathlib import Path\n\nDOSSIER = Path(__file__).parent\nFICHIER = DOSSIER / \"altitudes.txt\"\n\n" + lecture.replace("CHEMIN", "FICHIER"),
    vives: (1, 3, 4, 7),
    poste("Poste d'Alice", "C:/Users/alice/cours3/", "altitudes.py, altitudes.txt",
      "$ python altitudes.py\nminimum : 79.6\nmaximum : 123.7"),
    [copie du dossier],
    poste("Autre poste", "C:/Users/eleve/projet/", "altitudes.py, altitudes.txt",
      "$ python altitudes.py\nminimum : 79.6\nmaximum : 123.7"),
    [Copier son fichier dans le dossier du script. Ouvrir `altitudes.py`, puis remplacer `altitudes.txt` par le nom de son fichier.],
  )

  #notes[
    `Path(__file__).parent` : le dossier du script. L'étape 4 du TD 3b corrige
    ainsi le chemin du programme.

    `Path` et `__file__` sont détaillés dans la partie suivante.

    Vocabulaire à donner : une valeur écrite dans le code est écrite « en dur ».
  ]
]

// --------------------------------------------
#d("Solution : chemin donné en ligne de commande")[
  #annonce[
    Le code ne contient plus de nom de fichier.
  ]

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

  #notes[
    Le chemin donné sur la ligne de commande part du dossier du terminal : celui
    de la personne qui lance le programme.

    `argparse` est détaillé dans la partie suivante. Le TD 3b passe aussi le
    seuil par la ligne de commande.
  ]
]

// --------------------------------------------
// Les quatre versions, sur les deux usages des diapositives précédentes : la
// colonne de droite et l'encadré du bas.
#d("Récapitulatif des quatre versions")[
  #tableau(
    columns: (1.1fr, 1fr, 1.3fr),
    align: left + horizon,
    [Version], [Sur un autre poste], [Pour traiter d'autres données],
    [code et données dans le même fichier], [le script s'exécute sans erreur], [remplacer les valeurs de la liste dans le script],
    [chemin absolu au milieu du code], [le script s'arrête sur `FileNotFoundError`], [chercher le chemin dans le code, puis le remplacer],
    [chemin relatif écrit dans le script], [le script s'exécute sans erreur], [copier le fichier dans le dossier du script, puis remplacer `altitudes.txt` au début du script],
    [chemin donné en ligne de commande], [le script s'exécute sans erreur], [écrire le chemin après le nom du script, sans modifier le code],
  )

  #notes[
    Seule la dernière version s'exécute sur un autre poste et traite d'autres
    données sans modification du code.
  ]
]

// --------------------------------------------
#d("Autres bonnes pratiques de développement")[
  #annonce[
    D'autres problèmes de portabilité et d'autres bonnes pratiques de
    développement ne sont pas traités dans cet enseignement. Python est dit
    « batteries included » (piles fournies), car sa bibliothèque standard,
    installée avec lui, fournit des modules pour beaucoup d'entre eux.
  ]

  #tableau(
    columns: (auto, 1fr, auto),
    align: left + horizon,
    [Sujet], [Intérêt], [Module],
    [fichier de configuration], [regrouper les réglages dans un fichier, séparé du code], [`configparser`],
    [dossier personnel], [trouver le dossier de l'utilisateur sous Windows, Linux ou macOS], [`pathlib`],
    [journal (log)], [enregistrer ce que le programme a fait, par exemple le fichier lu], [`logging`],
    [tests], [vérifier qu'une fonction renvoie le résultat attendu], [`unittest`],
  )

  #notes[
    Citer sans s'y attarder.

    Dossier personnel : `Path.home()` renvoie `C:/Users/alice` sur le poste
    d'Alice. `unittest` regroupe les tests d'un projet et les lance tous.
    `tomllib` (Python 3.11) lit aussi les fichiers de configuration TOML. Les
    bibliothèques à installer sur l'autre poste : cours 5.

    Source : tutoriel Python, section 10.12, « Batteries included » :
    « Python adopte le principe des "piles fournies" ».
    `docs.python.org/fr/3/tutorial/stdlib.html#batteries-included`
  ]
]

// --------------------------------------------
// Nouveau, 05/11/2026. Exemples exécutés, Python 3.12.
#d("Bibliothèque standard de Python")[
  #annonce[
    Les quatre versions du script emploient `open`, `pathlib` et `argparse`,
    détaillés dans la partie suivante. Comme `pathlib` et `argparse`, d'autres
    modules de la bibliothèque standard s'importent sans installation.
  ]

  #face-a-face(
    panneau("Partie suivante")[
      #tableau(
        entete: false,
        columns: (auto, 1fr),
        align: left + horizon,
        [`open`], [ouvrir un fichier pour le lire ou l'écrire],
        [`pathlib`], [construire un chemin à partir du dossier du script],
        [`argparse`], [lire les arguments donnés en ligne de commande],
      )
    ],
    panneau("Autres modules utiles")[
      #tableau(
        entete: false,
        columns: (auto, 1fr),
        align: left + horizon,
        [`csv`], [lire et écrire un fichier CSV],
        [`statistics`], [calculer une moyenne, une médiane],
        [`math`], [calculer une racine carrée, un logarithme],
        [`datetime`], [lire une date, calculer une durée],
      )
    ],
  )

  #legende[
    Avant d'écrire une fonction, chercher si un module la fournit déjà. Liste
    complète : docs.python.org/fr/3/library/.
  ]

  #notes[
    Passage vers la partie suivante, qui détaille les trois outils de gauche,
    employés dans les quatre versions. `open` est une fonction intégrée,
    employée sans import.

    Les modules de droite ne sont pas détaillés. `datetime` : étape B6 du TD 4a.
    Le programme du cours 1 calcule une moyenne avec une boucle, pour écrire une
    boucle. `statistics.mean` renvoie le même résultat, 93.7 sur sa liste.
  ]
]
