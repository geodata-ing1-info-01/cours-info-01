// TD 5a du cours 5 v2 — « Le dossier de votre Python ».
//
// Nouveau (v2), 06/11/2026 : constater les deux erreurs de `carte_trace.py`, puis relever
// sur le poste les chemins de la partie « Le dossier d'une distribution ». Les sorties
// attendues viennent de la disposition d'Anaconda sous Windows, et restent à relever sur un
// poste de la salle.
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

#d("Préparer la séance")[
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

#d("Lancer le programme")[
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

#d("Trouver les fichiers de Python")[
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
