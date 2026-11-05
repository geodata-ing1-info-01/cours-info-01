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
#import "../schemas.typ": sortie
#import "../../../cours1_v2/diapo/schemas.typ": consignes, comment, commandes, constat

#let td = (
  numero: "3a",
  titre: "Dénivelé d'une trace GPS",
  annonce: "Objectif : faire lire à altitudes.py ses altitudes dans un fichier, puis dans une trace GPS",
  dossier: "cours3/3a_denivele/",
  duree: "20′",
)
#separateur-td(..td)

#d("Préparer la séance")[
  #consignes(
    taille: 17pt,
    [Copier l'archive `info01-cours3.zip` de `formationTemp` dans le dossier `info01` du Bureau.],
    [Décompresser l'archive dans Git Bash : #commandes("cd ~/Desktop/info01", "unzip info01-cours3.zip")],
    [Lancer VS Code depuis le menu Démarrer, puis ouvrir le dossier de la séance : #comment[File, Open Folder…, `Desktop\info01\cours3`.]],
    [Ouvrir un terminal : #comment[menu Terminal, New Terminal.]
      #constat[`(base)` et `MINGW64 ~/Desktop/info01/cours3`.]],
  )

  #legende[
    Chaque TD a son dossier. Dans chacun, `depart/` contient les fichiers
    livrés, et `travail/`, vide au départ, contiendra vos copies et vos programmes.
  ]

  #notes[
    Mêmes étapes qu'au TD 2a. VS Code est configuré depuis le cours 2.

    Séance sans notebook : tout se fait dans VS Code et son terminal.
  ]
]

#d("Copier le programme et les altitudes")[
  #consignes(
    taille: 17pt,
    [Aller dans le dossier du TD, et copier ses fichiers dans `travail/` : #commandes("cd 3a_denivele", "cp depart/* travail/", "cd travail")],
    [Lancer le programme du TD 2c : `python altitudes.py`.
      #constat[`127.6`, `136.7`, `9.1`, `11.7` et `3.4`.]],
    [Ouvrir `travail/altitudes.py` et `travail/altitudes.txt` dans VS Code.
      #constat[Les cinq altitudes de la liste sont aussi dans le fichier, une par ligne.]],
  )

  #notes[
    Le programme livré est celui de la fin du TD 2c, pour que chacun parte du
    même état, TD 2c terminé ou non.
  ]
]

#d("Lire les altitudes dans un fichier")[
  #consignes(
    taille: 16pt,
    [Dans `travail/altitudes.py`, remplacer la ligne `altitudes = [128.4, 131.0, 127.6, 134.9, 136.7]` par ces lignes, suivies d'une ligne vide :
      #v(2pt)
      #sortie("altitudes = []\nwith open(\"altitudes.txt\", encoding=\"utf-8\") as fichier:\n    for ligne in fichier:\n        altitudes.append(float(ligne))", taille: 13pt)],
    [Enregistrer le fichier, puis lancer le programme : `python altitudes.py`.
      #constat[Les mêmes résultats : `127.6`, `136.7`, `9.1`, `11.7` et `3.4`.]],
    [À la fin de `travail/altitudes.txt`, ajouter une ligne `137.4`, enregistrer le fichier, puis relancer le programme.
      #constat[`altitude maximale : 137.4 m` : seul le fichier de données a changé.]],
  )

  #notes[
    `open`, `encoding` et `with` : partie 2 de l'exposé. `float` convertit le texte
    en nombre, et ignore la fin de ligne.

    Une ligne vide dans `altitudes.txt` provoque `ValueError: could not convert
    string to float: '\n'` : la retirer.
  ]
]

#d("Lire les altitudes d'une trace GPS")[
  #grid(
    columns: (1.6fr, 1fr), column-gutter: 18pt, align: top,
    consignes(
      taille: 16pt,
      [Ouvrir `travail/trace.csv` dans VS Code.],
      [Dans `travail/altitudes.py`, remplacer les lignes de `altitudes = []` jusqu'à `altitudes.append(float(ligne))` par ces lignes :
        #v(2pt)
        #sortie("altitudes = []\nwith open(\"trace.csv\", encoding=\"utf-8\") as fichier:\n    fichier.readline()\n    for ligne in fichier:\n        duree, x, y, z = ligne.strip().split(\",\")\n        altitudes.append(float(z))", taille: 11.5pt)],
      [Enregistrer le fichier, puis lancer le programme : `python altitudes.py`.
        #constat[`120.6`, `165.3`, `44.7`, `58.4` et `59.9`.]],
    ),
    panneau("trace.csv, ses cinq premières lignes")[
      #sortie("durée,x,y,z\n0,673120.5,6860840.2,128.4\n30,673152.9,6860856.3,131.0\n60,673186.9,6860870.9,127.6\n90,673222.0,6860866.8,134.9\n…", taille: 12.5pt)
    ],
  )

  #legende[
    `durée` : secondes depuis le départ. `x`, `y` : Lambert-93, en mètres.
    `z` : altitude, en mètres.
  ]

  #notes[
    Trace inventée, 61 points, un toutes les 30 secondes :
    `data/cours3_v2/make_data.py`. Ses cinq premières altitudes sont celles de la
    liste du TD 2c.

    `fichier.readline()` lit la ligne d'en-tête, que la boucle ne reprend pas.
    `split(",")` découpe la ligne aux virgules.

    Vérification : hausse moins baisse donne la dernière altitude moins la
    première, ici 58,4 − 59,9 = −1,5, et 126,9 − 128,4 = −1,5.

    Le cumul dépasse largement l'écart `max - min` : la trace monte et descend
    plusieurs fois.
  ]
]
