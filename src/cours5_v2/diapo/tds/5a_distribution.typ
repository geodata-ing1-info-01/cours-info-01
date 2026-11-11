// TD 5a du cours 5 v2 — « L'emplacement de votre distribution Python ».
//
// Nouveau (v2), 06/11/2026 : constater les deux manques de `carte_trace.py`, relever sur le poste
// les chemins de la diapositive « Dossier d'une distribution Python », puis lancer la création de
// l'environnement du TD 5b. Les sorties attendues viennent de la disposition d'Anaconda sous
// Windows, et restent à relever sur un poste de la salle.
//
// 10/11/2026 : la copie de `depart/` dans `travail/` passe à la préparation, avec
// l'arborescence obtenue, et VS Code ouvre ensuite le dossier `travail/`. La création de
// l'environnement passe en fin de TD, juste avant la partie 4 qui l'explique. Les deux diapositives
// de constat disent ce qu'il faut regarder.
//
// 11/11/2026 : numéro d'étape dans le titre des diapositives d'action, repris par les sections du
// guide ; légende de l'arborescence complétée d'après l'archive livrée.
//
// Inclus par `cours5_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 5_v2`.
#import "../../../commun/prelude.typ": *
#import "../../../cours1_v2/diapo/schemas.typ": consignes, comment, commandes, constat
#import "../../../cours3_v2/diapo/schemas.typ": arborescence, explorateur-vscode, script

// Les fichiers de `depart/`, copiés dans `travail/` à la préparation.
#let fichiers-depart = ("carte_trace.py", "stats_trace.py", "trace.gpx", "trace_2.gpx")

#let td = (
  numero: "5a",
  titre: "L'emplacement de votre distribution Python",
  annonce: "Objectif : constater ce qui manque à carte_trace.py, puis trouver où se trouvent l'interpréteur, les bibliothèques et les programmes du poste",
  dossier: "cours5/5a_distribution/",
  duree: "10′",
)
#separateur-td(..td)

#d("Étape 1 · Préparation de la séance")[
  #objectif[
    copier et décompresser `info01-cours5.zip`, puis copier les fichiers de `depart/` du TD 5a dans
    `travail/`.
  ]

  #grid(
    columns: (1fr, 6.4cm), column-gutter: 18pt,
    consignes(
      taille: 16pt,
      [Copier l'archive `info01-cours5.zip` de `formationTemp` dans le dossier `info01` du Bureau.],
      [Décompresser l'archive dans Git Bash : #commandes("cd ~/Desktop/info01", "unzip info01-cours5.zip")],
      [Copier les fichiers de `depart/` dans `travail/`, puis afficher le contenu de `travail/` : #commandes("cd cours5/5a_distribution", "cp depart/* travail/", "ls travail")
        #constat[Les quatre fichiers de `depart/` : `carte_trace.py`, `stats_trace.py`, `trace.gpx` et `trace_2.gpx`.]],
    ),
    panneau("Après la copie", arborescence(
      (0, "5a_distribution/"),
      (1, "depart/", "fichiers livrés"),
      ..fichiers-depart.map(nom => (2, nom)),
      (1, "travail/", "copies"),
      ..fichiers-depart.map(nom => (2, nom)),
      taille: 11pt,
    )),
  )

  #legende[
    Le dossier du TD contient aussi `td_5a_distribution.pdf`, `guide_5a_distribution.pdf`,
    `guide_5a_distribution.html` et `guide.ipynb`.
  ]

  #notes[
    Mêmes étapes qu'au TD 3a, avec la copie dans `travail/` dès la préparation.
  ]
]

#d("Étape 2 · Ouverture du dossier travail dans VS Code")[
  #objectif[
    ouvrir dans VS Code le dossier `travail/` du TD 5a, puis un terminal.
  ]

  #grid(
    columns: (1fr, 6.2cm), column-gutter: 20pt,
    consignes(
      taille: 17pt,
      [Lancer VS Code depuis le menu Démarrer, puis ouvrir le dossier `travail/` du TD 5a : #comment[File, Open Folder…, `Desktop\info01\cours5\5a_distribution\travail`, puis « Yes, I trust the authors ».]],
      [Ouvrir un terminal : #comment[menu Terminal, New Terminal.]
        #constat[`(base)` et `MINGW64 ~/Desktop/info01/cours5/5a_distribution/travail`.]],
    ),
    panneau("Explorateur de VS Code", explorateur-vscode("travail", fichiers-depart)),
  )

  #notes[
    Comme au TD 3a, VS Code ouvre le dossier `travail/` du TD, et son terminal démarre dans ce
    dossier.
  ]
]

#d("Étape 3 · Programme sur le poste")[
  #objectif[
    déterminer si le poste a les deux outils qu'appelle `carte_trace.py` : la bibliothèque `folium`
    et le programme `ogr2ogr`.
  ]

  #consignes(
    taille: 16pt,
    [Lancer le programme, puis lire la dernière ligne du message : `python carte_trace.py trace_2.gpx`.
      #constat[`ModuleNotFoundError: No module named 'folium'`. Python s'arrête à `import folium`,
        avant l'appel de `ogr2ogr`.]],
    [Chercher `ogr2ogr` dans les dossiers de `PATH`, puis noter si `which` affiche son chemin : `which ogr2ogr`.
      #constat[`no ogr2ogr in (…)` : aucun des dossiers de `PATH`, entre les parenthèses, ne contient `ogr2ogr`.]],
  )

  #v(0.2em)
  #panneau("Les deux outils dans carte_trace.py", script(
    "import folium\n…\ncommande = [\"ogr2ogr\", FICHIER_CSV, FICHIER_GPX, \"track_points\"] + options_ogr\nsubprocess.run(commande, check=True)",
    vives: (1, 3), taille: 11pt,
  ))

  #legende[
    En bleu, les lignes qui demandent `folium` et `ogr2ogr`.
  ]

  #notes[
    `which` cherche `ogr2ogr` sans lancer `carte_trace.py`, qui s'arrête avant l'appel.

    Le TD 5b corrige ces deux manques.

    Si un GDAL ou un QGIS est dans le `PATH` du poste, `which` le trouve : à vérifier sur un
    poste de la salle.

    À relever sur un poste de la salle : le texte exact du message de `which ogr2ogr`.
  ]
]

#d("Étape 4 · Fichiers de Python sur le poste")[
  #objectif[
    relever les chemins de l'interpréteur, des modules `argparse` et `numpy`, et de `pandoc`, puis
    les comparer à l'arborescence de « Dossier d'une distribution Python ».
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
    [Pour chaque chemin, repérer le dossier de la distribution qui le contient : la racine, `Lib`,
      `Lib\site-packages` ou `Library\bin`.
      #constat[`python.exe` à la racine, `argparse` dans `Lib`, `numpy` dans `Lib\site-packages`,
        `pandoc` dans `Library\bin`.]],
  )

  #notes[
    Sorties attendues, à relever sur un poste de la salle.

    `numpy` et `pandoc` sont dans le paquet `anaconda` : un environnement réduit ne les a
    pas.
  ]
]

// Nouveau, 06/11/2026 : l'installation dure plusieurs minutes, et se termine avant le TD 5b.
// En fin de TD depuis le 10/11/2026 : la commande tourne pendant la partie 4, qui l'explique.
#d("Étape 5 · Création de l'environnement : lancement")[
  #objectif[
    lancer dès maintenant, dans un second terminal, l'installation des outils du TD~5b.
  ]

  #consignes(
    taille: 16pt,
    [Ouvrir un second terminal : #comment[menu Terminal, New Terminal.]
      #constat[`(base)` et `MINGW64 ~/Desktop/info01/cours5/5a_distribution/travail`.]],
    [Lancer la création de l'environnement `carte` : #commandes("conda create -y -n carte -c conda-forge python=3.12 gdal folium")
      #constat[`Collecting package metadata`, puis le téléchargement des paquets.]],
    [Laisser cette commande tourner pendant la partie 4 de l'exposé.],
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

    Si `conda` demande d'accepter les conditions d'utilisation des canaux d'Anaconda, ou s'arrête
    sur `CondaToSNonInteractiveError` : annexe « Problèmes avec Anaconda », A10. Ces canaux sont
    consultés même avec `-c conda-forge`.
  ]
]
