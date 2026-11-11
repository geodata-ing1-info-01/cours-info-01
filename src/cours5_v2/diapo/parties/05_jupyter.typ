// Partie 5 du cours 5 v2, facultative : JupyterLab et le noyau. Incluse par `cours5_v2.typ`.
//
// Réorganisée le 06/11/2026 : le problème (une bibliothèque introuvable dans un notebook), le client
// et le serveur dans JupyterLab, repris du cours 5 de 2026, « Les clients d'un notebook », reprise de
// la partie 4 du cours 1 de 2026, puis le noyau d'un environnement, adapté du TD 1i de 2026. Le
// tableau général « Client et serveur » est dans `a_reprendre/reseau.typ`.
//
// Essayé le 06/11/2026 sous Linux avec JupyterLab 4.6, à partir d'un environnement d'essai qui joue
// le rôle de `base`, et un `PATH` sans le GDAL du système : cellules exécutées par `nbclient`, serveur
// interrogé par son API, captures dans Chromium (`src/cours5_v2/images/CREDITS.md`). Il reste à le
// refaire sur un poste de la salle, puis dans VS Code.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../../../cours3/diapo/schemas.typ": sortie
#import "../../../cours1_v2/diapo/schemas.typ": terminal
// Le schéma du notebook, dessiné pour la partie 4 du cours 1 : le client et le serveur sur le
// même poste.
#import "../../../cours1/diapo/schemas_notebooks.typ": schema-client-serveur as schema-notebook-local, schema-deux-clients

// --------------------------------------------
// Nouveau, 06/11/2026.
#d("Notebook : bibliothèque introuvable")[
  #annonce[
    Dans le terminal, `carte_trace.py` fonctionne après `conda activate carte`. Dans un notebook
    ouvert par JupyterLab, `import folium` lève `ModuleNotFoundError`.
  ]

  #align(center, box(stroke: 0.6pt + gris.darken(15%),
    image("/src/cours5_v2/images/jupyter_base.png", width: 92%)))

  #legende[
    `sys.executable` affiche le chemin de l'interpréteur : cette cellule s'exécute avec le Python
    de `base`. Capture de JupyterLab 4.6 sous Linux, chemin raccourci.
  ]

  #notes[
    Partir de la question : `folium` est installé, et la cellule ne le trouve pas. Le message a la
    même cause qu'en partie 3 : aucun dossier de `sys.path` ne contient `folium`.

    JupyterLab lancé depuis `base` emploie le noyau `Python 3 (ipykernel)`, affiché en haut à droite.
    Dans la salle, `sys.executable` est attendu sous la forme `C:\ProgramData\anaconda3\python.exe` :
    à relever.

    Capture du 06/11/2026, avec un environnement d'essai à la place de `base` : fabrication dans
    `src/cours5_v2/images/CREDITS.md`.
  ]
]

// --------------------------------------------
// Réunit « Client et serveur » et « Client et serveur sur le même poste », 06/11/2026.
#d("Client et serveur : JupyterLab")[
  #annonce[
    Un client envoie une requête, et un serveur répond. Dans JupyterLab, les deux programmes tournent
    sur le même poste, et le serveur lance un *noyau*, un interpréteur Python chargé d'exécuter les
    cellules.
  ]

  #align(center, scale(72%, reflow: true, schema-notebook-local()))

  #legende[
    `jupyter lab`, lancé dans un terminal, démarre le serveur. Le navigateur
    est le client : il se connecte à l'adresse `localhost:8888`, qui désigne
    le poste lui-même.
  ]

  #notes[
    Démonstration, deux minutes, dans Git Bash ou l'invite de commandes d'Anaconda :
    - `jupyter lab` : le terminal affiche l'adresse `http://localhost:8888/lab?token=…`
      et reste occupé, c'est le serveur ;
    - le navigateur s'ouvre sur cette adresse ; exécuter une cellule : le
      terminal affiche une ligne à chaque requête ;
    - fermer le terminal, puis exécuter une cellule : le navigateur signale
      que le serveur ne répond plus. Le client est toujours ouvert, le
      serveur est arrêté.

    `localhost` est le nom du poste pour lui-même (adresse `127.0.0.1`) ;
    8888 est le port du serveur. Rien ne sort du poste.

    Le jeton de l'adresse est un mot de passe à usage unique : un autre poste
    du réseau ne peut pas exécuter de code sur ce serveur sans lui. Lien avec
    le cours 6.

    Essayé le 06/11/2026 sous Linux : le processus du noyau a pour parent le serveur.

    Schéma de la partie 4 du cours 1 de 2026.
  ]
]

// --------------------------------------------
#d("Les clients d'un notebook")[
  #annonce[
    Le même fichier `.ipynb` s'ouvre dans JupyterLab ou dans VS Code. Les deux clients ont besoin
    d'un noyau.
  ]

  #align(center, schema-deux-clients())

  #legende[
    L'éditeur de code n'a pas besoin de `jupyterlab` : il démarre `ipykernel`
    lui-même. `ipykernel` est le noyau Python ; il en existe pour d'autres
    langages, et le nom _Jupyter_ vient de Julia, Python et R.
  ]

  #notes[
    Le point pratique : un environnement ouvert dans l'éditeur n'a besoin que d'`ipykernel`.

    L'éditeur parle directement au noyau, sans passer par un serveur. La
    documentation de l'extension le dit : « vous n'avez pas besoin
    d'installer jupyter dans l'environnement, seul `ipykernel` est
    nécessaire ». Il sait aussi se connecter à un serveur existant, en
    collant son adresse.

    Les langages, pour information et sans y insister : le noyau décide du
    langage. Il existe des noyaux pour R
    (`IRkernel`), Julia (`IJulia`), C++, et le `kernel.json` porte une
    ligne `language` qui dit lequel. Le projet s'appelait IPython jusqu'en
    2014.

    Ne pas en faire une invitation à changer de langage : le module reste
    en Python.
  ]
]

// --------------------------------------------
// Reprend la moitié gauche de « Noyau : interpréteur d'un environnement », 06/11/2026.
#d("Noyau d'un environnement : déclaration")[
  #annonce[
    `python -m ipykernel install` écrit un fichier `kernel.json`, qui donne le chemin de
    l'interpréteur de `carte`. JupyterLab propose alors ce noyau, et `import folium` réussit.
  ]

  #grid(
    columns: (1.5fr, 1fr), column-gutter: 14pt, align: top,
    terminal(
      taille: 13pt,
      "$ conda activate carte",
      "(carte) $ conda install -c conda-forge ipykernel",
      "(carte) $ python -m ipykernel install --user --name carte",
      "Installed kernelspec carte in …/jupyter/kernels/carte",
    ),
    panneau("kernel.json")[
      #sortie("\"argv\": [\n  \"…/envs/carte/bin/python\", …", taille: 12pt)
    ],
  )

  #v(0.3em)
  #align(center, box(stroke: 0.6pt + gris.darken(15%),
    image("/src/cours5_v2/images/jupyter_noyau_carte.png", width: 81%)))

  #legende[
    Le nom du noyau, `carte`, apparaît en haut à droite du notebook. Capture de JupyterLab 4.6 sous
    Linux, chemin raccourci.
  ]

  #notes[
    `--user` écrit le fichier dans le compte, et `--name` donne le nom du noyau. Sous Windows, dossier
    attendu : `AppData\Roaming\jupyter\kernels\carte\ `, d'après l'annexe sur les environnements de
    VS Code. Les noyaux disponibles : `jupyter kernelspec list`.

    Choisir le noyau : cliquer sur son nom en haut à droite, ou menu Kernel, Change Kernel.

    Une bibliothèque manque dans un notebook : l'installer dans l'environnement du noyau, celui que
    JupyterLab affiche en haut à droite.

    `ipykernel` peut s'ajouter à la liste de `environment.yml`.

    Essayé le 06/11/2026 sous Linux, avec JupyterLab lancé depuis un environnement d'essai à la place
    de `base`.
  ]
]

// --------------------------------------------
// Reprend la moitié droite de « Noyau : interpréteur d'un environnement », 06/11/2026.
#d("Noyau : recherche des dépendances")[
  #annonce[
    Le noyau trouve ses bibliothèques à partir de son interpréteur. Il reçoit `PATH` du serveur, donc
    du terminal où `jupyter lab` a été lancé.
  ]

  #grid(
    columns: (1fr, 1.1fr), column-gutter: 18pt, align: top,
    panneau("Cellule")[
      #sortie("import shutil\nimport sys\nprint(sys.executable)\nprint(shutil.which(\"ogr2ogr\"))\nimport folium\nprint(\"folium\", folium.__version__)", taille: 12.5pt)
    ],
    stack(
      spacing: 10pt,
      panneau[JupyterLab de `base`, noyau `carte`][
        #sortie("…/envs/carte/bin/python\nNone\nfolium 0.20.0", taille: 12.5pt)
      ],
      panneau[JupyterLab de `carte`, après activation][
        #sortie("…/envs/carte/bin/python\n…/envs/carte/bin/ogr2ogr\nfolium 0.20.0", taille: 12.5pt)
      ],
    ),
  )

  #legende[
    Avec `None`, `subprocess.run(["ogr2ogr", …])` lève `FileNotFoundError`. Pour lancer `jupyter lab`
    après `conda activate carte`, il faut installer `jupyterlab` dans `carte`, car l'activation retire
    `base` de `PATH`. Sorties réelles sous Linux, chemins raccourcis.
  ]

  #notes[
    `shutil.which` cherche dans `PATH`, comme la commande `which`.

    Essayé le 06/11/2026 sous Linux : le noyau reçoit le `PATH` du serveur. `jupyterlab` ajoute
    64 paquets et 120 Mo à `carte`. `conda activate carte`, depuis `base`, retire `miniforge3/bin` de
    `PATH`.

    Une bibliothèque manque dans un notebook : vérifier l'environnement du noyau. Un programme
    manque : vérifier le `PATH` du terminal qui a lancé JupyterLab.

    VS Code démarre le noyau lui-même, et applique les variables d'activation d'après l'annexe sur
    ses environnements : à relever en salle.
  ]
]
