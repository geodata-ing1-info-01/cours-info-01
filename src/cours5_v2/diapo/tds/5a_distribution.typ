// TD 5a du cours 5 v2 — « Le dossier de votre Python ».
//
// Nouveau (v2), 06/11/2026 : lancer la création de l'environnement du TD 5b, constater les deux
// erreurs de `carte_trace.py`, puis relever sur le poste les chemins de la diapositive « Dossier
// d'une distribution Python ». Les sorties attendues viennent de la disposition d'Anaconda sous
// Windows, et restent à relever sur un poste de la salle.
//
// Inclus par `cours5_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 5_v2`.
#import "../../../commun/prelude.typ": *
#import "../../../cours1_v2/diapo/schemas.typ": consignes, comment, commandes, constat

#let td = (
  numero: "5a",
  titre: "Le dossier de votre Python",
  annonce: "Objectif : constater ce qui manque à carte_trace.py, puis trouver où se trouvent l'interpréteur, les bibliothèques et les programmes du poste",
  dossier: "cours5/5a_distribution/",
  duree: "10′",
)
#separateur-td(..td)

#d("Préparation de la séance")[
  #objectif[
    copier et décompresser `info01-cours5.zip`, puis ouvrir le dossier `cours5` et un terminal dans
    VS Code.
  ]

  #consignes(
    taille: 17pt,
    [Copier l'archive `info01-cours5.zip` de `formationTemp` dans le dossier `info01` du Bureau.],
    [Décompresser l'archive dans Git Bash : #commandes("cd ~/Desktop/info01", "unzip info01-cours5.zip")],
    [Lancer VS Code depuis le menu Démarrer, puis ouvrir le dossier de la séance : #comment[File, Open Folder…, `Desktop\info01\cours5`.]],
    [Ouvrir un terminal : #comment[menu Terminal, New Terminal.]
      #constat[`(base)` et `MINGW64 ~/Desktop/info01/cours5`.]],
  )

  #notes[
    Mêmes étapes qu'au TD 3a.
  ]
]

// Nouveau, 06/11/2026 : l'installation dure plusieurs minutes, et se termine avant le TD 5b.
#d("Création de l'environnement : lancement")[
  #objectif[
    lancer dès maintenant, dans un second terminal, l'installation des outils du TD~5b.
  ]

  #consignes(
    taille: 16pt,
    [Ouvrir un second terminal : #comment[menu Terminal, New Terminal.]
      #constat[`(base)` et `MINGW64 ~/Desktop/info01/cours5`.]],
    [Lancer la création de l'environnement `carte` : #commandes("conda create -y -n carte -c conda-forge python=3.12 gdal folium")
      #constat[`Collecting package metadata`, puis le téléchargement des paquets.]],
    [Laisser cette commande tourner, et revenir au premier terminal : #comment[cliquer sur son nom, dans la liste des terminaux.]],
  )

  #legende[
    Cette commande dure plusieurs minutes. Son explication vient à la partie 4, et ce terminal sert de
    nouveau au TD 5b.
  ]

  #notes[
    `-y` répond oui à la question de confirmation : le téléchargement démarre sans attendre.

    Environnement résolu pour Windows le 06/11/2026 : 91 paquets, 221 Mo à télécharger. Durée à relever
    sur un poste de la salle.

    Si `conda create` s'arrête sur `CondaHTTPError` : annexe « Session réseau, proxy, droits du
    compte ».
  ]
]

#d("Programme sur le poste")[
  #objectif[
    lancer `carte_trace.py` sur `trace_2.gpx`, et chercher le programme `ogr2ogr`.
  ]

  #consignes(
    taille: 17pt,
    [Aller dans le dossier du TD, et copier ses fichiers dans `travail/` : #commandes("cd 5a_distribution", "cp depart/* travail/", "cd travail")],
    [Lancer le programme : `python carte_trace.py trace_2.gpx`.
      #constat[`ModuleNotFoundError: No module named 'folium'`.]],
    [Chercher le programme de conversion : `which ogr2ogr`.
      #constat[`no ogr2ogr in (…)`, suivi des dossiers de `PATH`.]],
  )

  #notes[
    Le TD 5b corrige ces deux manques.

    Si un GDAL ou un QGIS est dans le `PATH` du poste, `which` le trouve : à vérifier sur un
    poste de la salle.
  ]
]

#d("Fichiers de Python sur le poste")[
  #objectif[
    relever les chemins de l'interpréteur, des modules `argparse` et `numpy`, et de `pandoc`.
  ]

  #consignes(
    taille: 15pt,
    [Afficher le chemin de l'interpréteur : #commandes("python -c \"import sys; print(sys.executable)\"")
      #constat[`C:\ProgramData\anaconda3\python.exe`.]],
    [Afficher la liste des dossiers où Python cherche un module : #commandes("python -c \"import sys; print(*sys.path, sep='\\n')\"")
      #constat[`…\Lib` et `…\Lib\site-packages`, dans le dossier d'Anaconda.]],
    [Afficher le fichier de deux modules : #commandes("python -c \"import argparse; print(argparse.__file__)\"", "python -c \"import numpy; print(numpy.__file__)\"")
      #constat[`argparse` dans `Lib\ `, livré avec Python ; `numpy` dans `Lib\site-packages\ `, installé.]],
    [Chercher un programme installé avec Anaconda : `which pandoc`.
      #constat[`/c/ProgramData/anaconda3/Library/bin/pandoc`.]],
  )

  #notes[
    Sorties attendues, à relever sur un poste de la salle.

    `numpy` et `pandoc` sont dans le paquet `anaconda` : un environnement réduit ne les a
    pas.
  ]
]
