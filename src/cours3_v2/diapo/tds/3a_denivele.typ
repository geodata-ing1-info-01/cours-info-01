// TD 3a du cours 3 v2 — « Dénivelé d'une trace GPS ».
//
// Nouveau (v2), 04/11/2026 : fait lire à `altitudes.py` un fichier, puis une trace
// GPS. Remplace les notebooks et le parcours du cours 3 de 2026, qui restent dans
// `src/cours3/`.
//
// 05/11/2026 : le programme de départ est le corrigé du TD 2c, qui calcule déjà les
// altitudes extrêmes et le dénivelé cumulé sur une liste. Le TD ne change que
// l'origine des données. `data/cours3_v2/make_data.py` vérifie que ces deux fichiers
// restent identiques. Corrigé : `data/cours3_v2/corriges/3a_denivele/`.
// Sorties relevées sur ce corrigé, Python 3.12.
//
// Inclus par `cours3_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 3_v2`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": sortie, explorateur-vscode, csv-colonne
#import "../../../cours1_v2/diapo/schemas.typ": consignes, comment, commandes, constat

#let td = (
  numero: "3a",
  titre: "Dénivelé d'une trace GPS",
  annonce: "Objectif : faire lire à altitudes.py ses altitudes dans un fichier, puis dans une trace GPS",
  dossier: "cours3/3a_denivele/",
  duree: "20′",
)
#separateur-td(..td)

#d("Préparation de la séance")[
  #objectif[
    copier et décompresser `info01-cours3.zip`, puis ouvrir dans VS Code le dossier `travail/` du
    TD 3a et un terminal.
  ]

  #consignes(
    taille: 17pt,
    [Copier l'archive `info01-cours3.zip` de `formationTemp` dans le dossier `info01` du Bureau.],
    [Décompresser l'archive dans Git Bash : #commandes("cd ~/Desktop/info01", "unzip info01-cours3.zip")],
    [Lancer VS Code depuis le menu Démarrer, puis ouvrir le dossier `travail/` du TD 3a : #comment[File, Open Folder…, `Desktop\info01\cours3\3a_denivele\travail`, puis « Yes, I trust the authors ».]],
    [Ouvrir un terminal : #comment[menu Terminal, New Terminal.]
      #constat[`(base)` et `MINGW64 ~/Desktop/info01/cours3/3a_denivele/travail`.]],
  )

  #legende[
    Chaque TD a son dossier. Au TD 3a, `depart/` contient les fichiers
    livrés, et `travail/`, vide au départ, contiendra vos copies et vos programmes.
    VS Code ouvre le dossier `travail/` du TD en cours, et son terminal démarre
    dans ce dossier.
  ]

  #notes[
    VS Code est configuré depuis le cours 2. Comme au TD 2c, VS Code ouvre le
    dossier `travail/`. L'élève y copie, y modifie et y lance ses programmes.

    Séance sans notebook : tout se fait dans VS Code et son terminal.
  ]
]

#d("Programme et altitudes du TD")[
  #objectif[
    copier les fichiers du TD dans `travail/`, lancer `altitudes.py`, et comparer ses altitudes à
    celles de `altitudes.txt`.
  ]

  #grid(
    columns: (1fr, 5.6cm), column-gutter: 20pt,
    consignes(
      taille: 17pt,
      [Copier les fichiers livrés dans `travail/`, le dossier du terminal : #commandes("cp ../depart/* .")
        #constat[L'explorateur de VS Code affiche `altitudes.py`, `altitudes.txt` et `trace.csv`.]],
      [Lancer le programme du TD 2c : `python altitudes.py`.
        #constat[`79.6`, `123.7`, `44.1`, `54.8` et `10.7`.]],
      [Ouvrir `altitudes.py` et `altitudes.txt` dans VS Code.
        #constat[Les cinq altitudes de la liste sont aussi dans le fichier, une par ligne.]],
    ),
    panneau("Après l'étape 1", explorateur-vscode("travail", ("altitudes.py", "altitudes.txt", "trace.csv"))),
  )

  #legende[
    Sans terminal, copier les fichiers dans l'explorateur de Windows, de
    `3a_denivele\depart` vers `3a_denivele\travail`.
  ]

  #notes[
    Le programme livré est celui de la fin du TD 2c, pour que chacun parte du
    même état, TD 2c terminé ou non.

    `..` : le dossier parent ; `.` : le dossier courant, vus au cours 1.
  ]
]

#d("Lecture des altitudes dans un fichier")[
  #objectif[
    modifier `altitudes.py` pour qu'il lise ses altitudes dans `altitudes.txt`, puis ajouter une
    altitude à ce fichier.
  ]

  #consignes(
    taille: 16pt,
    [Dans `altitudes.py`, remplacer la ligne `altitudes = [79.6, 103.2, 98.3, 92.5, 123.7]` par ces lignes, suivies d'une ligne vide :
      #v(2pt)
      #sortie("altitudes = []\nwith open(\"altitudes.txt\", encoding=\"utf-8\") as fichier:\n    for ligne in fichier:\n        altitudes.append(float(ligne))", taille: 13pt)],
    [Enregistrer le fichier, puis lancer le programme : `python altitudes.py`.
      #constat[Les mêmes résultats : `79.6`, `123.7`, `44.1`, `54.8` et `10.7`.]],
    [À la fin de `altitudes.txt`, ajouter une ligne `127.7`, enregistrer le fichier, puis relancer le programme.
      #constat[`altitude maximale : 127.7 m` : seul le fichier de données a changé.]],
  )

  #notes[
    `open`, `encoding` et `with` : partie 2 de l'exposé. `float` convertit le texte
    en nombre, et ignore la fin de ligne.

    Une ligne vide dans `altitudes.txt` provoque `ValueError: could not convert
    string to float: '\n'` : la retirer.
  ]
]

#d("Fichier d'altitudes et trace GPS")[
  #annonce[
    Un fichier CSV (_comma-separated values_) contient un tableau écrit en texte :
    la première ligne, l'en-tête, donne le nom des colonnes, et une virgule sépare
    deux valeurs d'une ligne.
  ]

  #face-a-face(
    panneau("altitudes.txt : les altitudes seules")[
      #sortie("79.6\n103.2\n98.3\n…", taille: 12pt)
    ],
    panneau("trace.csv : toute la trace GPS")[
      #csv-colonne("X,Y,ele,time\n670307.7,6812407.3,79.6,2026/10/04 08:00:00+00\n670295.1,6812393.4,78.8,2026/10/04 08:00:30+00\n…", 2, taille: 11pt)
    ],
  )

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [`altitudes.txt`], [`trace.csv`],
    [Première ligne], [une altitude, à lire], [l'en-tête, à sauter],
    [Lignes suivantes], [une valeur : convertir la ligne en nombre], [quatre valeurs : découper aux virgules, puis convertir `ele`],
  )

  #legende[
    `trace.csv` est livré dans `depart/`, et copié dans `travail/` à l'étape 1.
  ]

  #notes[
    Sur la diapositive suivante, `fichier.readline()` lit l'en-tête sans le
    garder, et `split(",")` découpe chaque ligne.
  ]
]

#d("Lecture des altitudes d'une trace GPS")[
  #objectif[
    modifier `altitudes.py` pour qu'il lise ses altitudes dans la colonne `ele` de `trace.csv`.
  ]

  #grid(
    columns: (1.2fr, 1fr), column-gutter: 14pt, align: top,
    consignes(
      taille: 16pt,
      [Ouvrir `trace.csv` dans VS Code.],
      [Dans `altitudes.py`, remplacer les lignes de `altitudes = []` jusqu'à `altitudes.append(float(ligne))` par ces lignes :
        #sortie("altitudes = []\nwith open(\"trace.csv\", encoding=\"utf-8\") as fichier:\n    fichier.readline()\n    for ligne in fichier:\n        x, y, ele, time = ligne.strip().split(\",\")\n        altitudes.append(float(ele))", taille: 11pt)],
      [Enregistrer le fichier, puis lancer le programme : `python altitudes.py`.
        #constat[`78.8`, `129.5`, `50.7`, `98.4` et `50.3`.]],
    ),
    panneau("trace.csv, ses cinq premières lignes")[
      #sortie("X,Y,ele,time\n670307.7,6812407.3,79.6,2026/10/04 08:00:00+00\n670295.1,6812393.4,78.8,2026/10/04 08:00:30+00\n670319.7,6812356.2,79.9,2026/10/04 08:01:00+00\n670340.2,6812319.3,78.9,2026/10/04 08:01:30+00\n…", taille: 10pt)
    ],
  )

  #legende[
    `X`, `Y` : Lambert-93, en mètres. `ele` : altitude, en mètres. `time` : date et
    heure UTC. Marche simulée sur un chemin des gorges de Franchard, en forêt de
    Fontainebleau.
  ]

  #notes[
    Chemin et altitudes de l'IGN, vitesse et bruit simulés, 60 points, un toutes les
    30 secondes : `data/cours3_v2/traces/fabriquer_traces.py`. La liste du TD 2c
    contient une altitude sur 12 de cette trace.

    `ele` : le nom de l'altitude dans un fichier GPX. Le cours 5 fabrique ce CSV à
    partir d'un GPX.

    `fichier.readline()` lit la ligne d'en-tête, que la boucle ne reprend pas.
    `split(",")` découpe la ligne aux virgules.

    Vérification : hausse moins baisse donne la dernière altitude moins la
    première, ici 98,4 − 50,3 = 48,1, et 127,7 − 79,6 = 48,1.

    Le cumul dépasse largement l'écart `max - min` : la trace monte et descend
    plusieurs fois.
  ]
]
