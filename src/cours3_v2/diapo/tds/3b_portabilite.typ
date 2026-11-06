// TD 3b du cours 3 v2 — « Un programme pour une autre personne ».
//
// Nouveau (v2), 04/11/2026 : les deux problèmes de portabilité de la partie 1
// de l'exposé, sur le programme du TD 3a repris par Alice, à qui un seuil a été
// ajouté. Corrigé : `data/cours3_v2/corriges/3b_portabilite/`. Sorties relevées
// sur ce corrigé, Python 3.12.
//
// Inclus par `cours3_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 3_v2`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": sortie
#import "../../../cours1_v2/diapo/schemas.typ": consignes, comment, commandes, constat

#let td = (
  numero: "3b",
  titre: "Un programme pour une autre personne",
  annonce: "Objectif : faire fonctionner le programme d'une autre personne, avec un chemin construit par pathlib et des paramètres lus par argparse",
  dossier: "cours3/3b_portabilite/",
  duree: "30′",
)
#separateur-td(..td)

#d("Lancer le programme d'Alice")[
  #annonce[
    Alice a ajouté un seuil à `altitudes.py` : une variation d'altitude plus
    petite que le seuil n'est pas comptée, ce qui écarte le bruit du GPS.
  ]

  #consignes(
    taille: 17pt,
    [Aller dans le dossier du TD, et copier ses fichiers dans `travail/` : #commandes("cd ../../3b_portabilite", "cp depart/* travail/", "cd travail")],
    [Ouvrir `travail/altitudes.py`, et lire les valeurs de `FICHIER` et de `SEUIL`, en tête du programme.],
    [Lancer le programme : `python altitudes.py`.
      #constat[`FileNotFoundError` : le chemin de `FICHIER` n'existe que sur le poste d'Alice.]],
  )

  #notes[
    Le terminal est encore dans `3a_denivele/travail/` : d'où `../../`.

    Le seuil compare chaque altitude à la dernière altitude retenue. Sans
    seuil, le bruit du GPS s'ajoute au cumul.
  ]
]

#d("Construire le chemin avec pathlib")[
  #consignes(
    taille: 16pt,
    [Dans `travail/altitudes.py`, remplacer la ligne `FICHIER = …` par ces deux lignes : #commandes("from pathlib import Path", "FICHIER = Path.cwd() / \"trace.csv\"")],
    [Enregistrer le fichier, puis lancer le programme : `python altitudes.py`.
      #constat[`cumul en hausse : 88.7 m` et `cumul en baisse : 39.9 m`.]],
    [Lancer le programme depuis le dossier du TD : #commandes("cd ..", "python travail/altitudes.py")
      #constat[`FileNotFoundError` : `Path.cwd()` est maintenant `3b_portabilite/`, et `trace.csv` n'y est pas.]],
    [Remplacer la ligne `FICHIER = …` par : #commandes("FICHIER = Path(__file__).parent / \"trace.csv\"")],
    [Enregistrer le fichier, puis relancer : `python travail/altitudes.py`.
      #constat[Les mêmes résultats, quel que soit le dossier du terminal.]],
  )

  #notes[
    `Path.cwd()` dépend du dossier du terminal, `__file__` du dossier du script.
    Un `Path` s'écrit avec des `/` quel que soit le système.
  ]
]

#d("Passer le fichier et le seuil en paramètres")[
  #consignes(
    taille: 16pt,
    [Revenir dans `travail/` : `cd travail`.],
    [Dans `travail/altitudes.py`, remplacer les lignes `from pathlib…`, `FICHIER = …` et `SEUIL = …` par ces lignes :
      #v(2pt)
      #sortie("import argparse\nfrom pathlib import Path\n\nanalyseur = argparse.ArgumentParser(description=\"Altitudes et cumul d'une trace GPS.\")\nanalyseur.add_argument(\"fichier\", help=\"le fichier CSV de la trace\")\nanalyseur.add_argument(\"-s\", \"--seuil\", type=float, default=0,\n                       help=\"variation ignorée sous ce seuil, en mètres\")\noptions = analyseur.parse_args()\n\nFICHIER = Path(options.fichier)\nSEUIL = options.seuil", taille: 11.5pt)],
    [Enregistrer le fichier, puis lancer le programme, sans puis avec un seuil : #commandes("python altitudes.py trace.csv", "python altitudes.py trace.csv -s 2")
      #constat[`cumul en hausse` : `98.4`, puis `88.7`.]],
  )

  #notes[
    Le chemin donné sur la ligne de commande part du dossier du terminal : celui
    de la personne qui lance le programme.
  ]
]

#d("Essayer l'interface du programme")[
  #consignes(
    taille: 17pt,
    [Lancer le programme sur la seconde trace, sans modifier le code : #commandes("python altitudes.py trace_2.csv", "python altitudes.py trace_2.csv -s 2")
      #constat[`cumul en hausse` : `29.2`, puis `11.4`.]],
    [Lancer le programme sans argument : `python altitudes.py`.
      #constat[`the following arguments are required: fichier`.]],
    [Donner un seuil qui n'est pas un nombre : `python altitudes.py trace.csv -s deux`.
      #constat[`argument -s/--seuil: invalid float value: 'deux'`.]],
    [Lire l'aide : `python altitudes.py --help`.
      #constat[Les deux arguments, avec les textes de `help=`.]],
  )

  #notes[
    `trace_2.csv` : de la gare de Noisy-Champs à Geodata Paris. Le terrain varie de
    8,4 m : la plus grande partie du cumul sans seuil vient du bruit.

    L'aide est produite à partir des `add_argument`, sans rien écrire d'autre.
  ]
]
