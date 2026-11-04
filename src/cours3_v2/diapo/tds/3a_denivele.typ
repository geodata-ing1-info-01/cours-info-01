// TD 3a du cours 3 v2 — « Dénivelé d'une trace GPS ».
//
// Nouveau (v2), 04/11/2026 : part d'`altitudes.py`, le programme du cours 1, et
// lui fait lire une trace GPS. Remplace les notebooks et le parcours du cours 3
// de 2026, qui restent dans `src/cours3/`. Données :
// `data/cours3_v2/make_data.py`. Corrigé : `data/cours3_v2/corriges/3a_denivele/`.
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
  annonce: "Objectif : faire calculer par altitudes.py les altitudes extrêmes et le dénivelé cumulé d'une trace GPS",
  dossier: "cours3/3a_denivele/",
  duree: "30′",
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
    livrés, et `travail/`, vide, reçoit les copies et ce que vous écrivez.
  ]

  #notes[
    Mêmes étapes qu'au TD 2a. VS Code est configuré depuis le cours 2.

    Séance sans notebook : tout se fait dans VS Code et son terminal.
  ]
]

#d("Copier le programme et la trace")[
  #grid(
    columns: (1.25fr, 1fr), column-gutter: 18pt, align: top,
    consignes(
      taille: 16pt,
      [Aller dans le dossier du TD, et copier ses fichiers dans `travail/` : #commandes("cd 3a_denivele", "cp depart/* travail/", "cd travail")],
      [Lancer le programme du cours 1 : `python altitudes.py`.
        #constat[`moyenne : 129.0 m` : le programme ne lit pas encore la trace.]],
      [Ouvrir `travail/trace.csv` dans VS Code.],
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
    `data/cours3_v2/make_data.py`. Ses trois premières altitudes sont celles
    d'`altitudes.py`.
  ]
]

#d("Lire les altitudes de la trace")[
  #consignes(
    taille: 16pt,
    [Dans `travail/altitudes.py`, remplacer la ligne `altitudes = [128.4, 131.0, 127.6]` par ces six lignes :
      #v(2pt)
      #sortie("altitudes = []\nwith open(\"trace.csv\", encoding=\"utf-8\") as fichier:\n    fichier.readline()\n    for ligne in fichier:\n        duree, x, y, z = ligne.strip().split(\",\")\n        altitudes.append(float(z))", taille: 13pt)],
    [Enregistrer le fichier, puis lancer le programme : `python altitudes.py`.
      #constat[`moyenne : 143.6 m` : la moyenne des 61 altitudes.]],
  )

  #notes[
    `fichier.readline()` lit la ligne d'en-tête, que la boucle ne reprend pas.
    `split(",")` découpe la ligne aux virgules. `float` convertit le texte en
    nombre.

    `open`, `encoding` et `with` : partie 2 de l'exposé.
  ]
]

#d("Calculer les altitudes extrêmes")[
  #consignes(
    taille: 16pt,
    [Dans `travail/altitudes.py`, remplacer les lignes de `total = 0` jusqu'au `print` par ces trois lignes :
      #v(2pt)
      #sortie("print(f\"altitude minimale : {min(altitudes):.1f} m\")\nprint(f\"altitude maximale : {max(altitudes):.1f} m\")\nprint(f\"max - min : {max(altitudes) - min(altitudes):.1f} m\")", taille: 13pt)],
    [Enregistrer le fichier, puis lancer le programme : `python altitudes.py`.
      #constat[`120.6`, `165.3` et `44.7`.]],
  )

  #notes[
    `min` et `max` sont des fonctions de Python, qui reçoivent la liste.

    Textes affichés sans accent : selon le terminal, Python n'écrit pas les
    accents de la même façon.
  ]
]

#d("Calculer le dénivelé cumulé")[
  #annonce[
    Le dénivelé cumulé additionne les écarts d'altitude d'un point au suivant :
    les hausses d'un côté, les baisses de l'autre.
  ]

  #consignes(
    taille: 16pt,
    [À la fin de `travail/altitudes.py`, ajouter ces lignes :
      #v(2pt)
      #sortie("hausse = 0\nbaisse = 0\nfor i in range(1, len(altitudes)):\n    ecart = altitudes[i] - altitudes[i - 1]\n    if ecart > 0:\n        hausse = hausse + ecart\n    else:\n        baisse = baisse - ecart\nprint(f\"cumul en hausse : {hausse:.1f} m\")\nprint(f\"cumul en baisse : {baisse:.1f} m\")", taille: 12pt)],
    [Enregistrer le fichier, puis lancer le programme : `python altitudes.py`.
      #constat[`58.4` et `59.9`.]],
  )

  #legende[
    Sur les trois premières altitudes, 128.4, 131.0 et 127.6 : une hausse de
    2.6 m, puis une baisse de 3.4 m.
  ]

  #notes[
    Vérification : hausse moins baisse donne la dernière altitude moins la
    première, ici 58,4 − 59,9 = −1,5, et 126,9 − 128,4 = −1,5.

    Le cumul dépasse largement l'écart `max - min` : la trace monte et descend
    plusieurs fois.
  ]
]
