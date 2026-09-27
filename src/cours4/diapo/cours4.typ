// Projet 4 — du notebook au programme, en deux parcours.
//
// Depuis le 26/09/2026, la séance a deux parcours, choisis au cours 3 :
//
//   - parcours standard : TD 4a, le client et le noyau d'un notebook
//     (`tds/4a_noyaux.typ`), puis TD 4b, le TD 3a du cours 3 repris
//     (`tds/4b_cli.typ`, écrit par `data/cours4/reprendre_td3a.py`) ;
//   - parcours avancé : TD 4c, la fenêtre du train (`tds/4c_train.typ`).
//
// Les TD 4a montre et 4b tourbillon d'avant le 26/09/2026 sont gardés comme
// propositions (`propositions/`, `../notebook/propositions/`). Le guide A4
// de chaque TD, `src/cours4/notebook/td/<td>/guide.md`, est compilé par
// `outils/compiler_guides.py --cours 4`.
//
//   python outils/compiler_diapos.py --cours 4
//   python outils/compiler_diapos.py --cours 4 --notes
//   python outils/compiler_diapos.py --cours 4 --sans-tds

#import "../../commun/prelude.typ": *
#import "../../cours3/diapo/schemas.typ": code-commente, sortie
#import "../../cours1/diapo/schemas_notebooks.typ": schema-client-serveur, schema-trois-serveurs, schema-deux-clients
#import "schemas.typ": programme-train

#show: diapos.with(
  titre-court: "Introduction à l'informatique",
  auteur-court: "1re année géomatique",
)

#let tds = sys.inputs.at("tds", default: "") != "false"

#import "tds/4a_noyaux.typ": td as td-4a
#import "tds/4b_cli.typ": td as td-4b
#import "tds/4c_train.typ": td as td-4c

#page-titre(
  titre: "Projet 4",
  sous-titre: "Du notebook au programme en ligne de commande, en deux parcours",
  auteur: "1re année géomatique",
  date: "",
)

// --------------------------------------------
#d("Objectifs de la séance")[
  #annonce[
    Écrire un programme Python lancé en ligne de commande, versionné avec
    git. Le parcours standard reprend le programme de la recette ; le
    parcours avancé fabrique une courte vidéo animée.
  ]

  #tableau(
    columns: (auto, 1fr, auto),
    align: (left + horizon, left + horizon, center + horizon),
    [Parcours], [Ce qu'on fait], [Durée],
    [Tous], [présentation des deux parcours], [10 min],
    [Standard], [TD 4a : le client et le noyau ; un environnement], [30 min],
    [], [TD 4b : `recette.py` en ligne de commande], [70 min],
    [Avancé], [TD 4c, A : l'environnement `animation`, le notebook], [35 min],
    [], [TD 4c, B : `train.py`, une branche par fonctionnalité], [70 min],
    [Tous], [une étiquette git, `git log`], [5 min],
  )

  #notes[
    Le guide A4 de chaque TD, dans son dossier, détaille chaque étape : le
    faire ouvrir dès le début.
  ]
]

// --------------------------------------------
#d("Deux parcours")[
  #annonce[
    Chaque élève garde le parcours choisi au cours 3.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Parcours standard], [Parcours avancé],
    [Au cours 3], [TD 3b : une recette en Markdown], [TD 3a : le programme `recette.py`],
    [Au projet 4], [TD 4a : le client et le noyau ; puis TD 4b, le TD 3a du cours 3], [TD 4c : la fenêtre du train],
    [Dossier], [`cours4/4a_noyaux/`, puis `cours4/4b_cli/`], [`cours4/4c_train/`],
  )

  #legende[
    Le TD 4b est le TD 3a du cours 3, avec le même guide : le parcours
    standard écrit ici le programme de la recette en ligne de commande.
  ]
]

// --------------------------------------------
#separateur(
  "Parcours standard · Le client et le noyau",
  annonce: "Un notebook est ouvert par un client et exécuté par un noyau ; un environnement peut avoir le noyau sans le client",
)

// --------------------------------------------
#d("Le client et le serveur d'un notebook")[
  #annonce[
    Un notebook est une application web : un client qui affiche, un serveur
    qui exécute.
  ]

  #align(center, schema-client-serveur())

  #legende[
    Changer de client ne change pas le noyau : JupyterLab et l'éditeur de code
    ouvrent le même fichier et exécutent ses cellules dans le même noyau.
  ]

  #notes[
    Le noyau est le processus Python qui exécute les cellules et retient les
    variables : section 2 de `noyau.ipynb`.

    Le jeton de l'adresse `localhost:8888/lab?token=…` est un mot de passe à
    usage unique. Repris au cours 5.
  ]
]

// --------------------------------------------
#d("Les trois emplacements du serveur")[
  #annonce[
    Le serveur d'un notebook peut être sur un autre ordinateur, sur votre
    poste, ou dans le navigateur lui-même.
  ]

  #align(center, scale(80%, reflow: true, schema-trois-serveurs()))

  #legende[
    Dans le premier cas seulement, le code et les données sortent du poste.
  ]

  #notes[
    Premier cas : Colab, ou un serveur de calcul ; Colab demande un compte.
    Deuxième cas : `jupyter lab` sur le poste, celui des séances. Troisième
    cas : JupyterLite (jupyter.org/try-jupyter) ; tous les paquets n'y sont
    pas.
  ]
]

// --------------------------------------------
#d("Les clients d'un notebook")[
  #annonce[
    Le même fichier s'ouvre dans plusieurs clients. Tous ont besoin d'un
    noyau.
  ]

  #align(center, schema-deux-clients())

  #legende[
    L'éditeur de code n'a pas besoin de `jupyterlab` : il démarre `ipykernel`
    lui-même. Un environnement ouvert dans l'éditeur n'a besoin que
    d'`ipykernel`.
  ]

  #notes[
    TD 4a, étapes 8 et 10 : `info01-recette` a `ipykernel` sans `jupyterlab`
    ; VS Code l'emploie, `jupyter lab` y échoue.
  ]
]

// --------------------------------------------
#if tds {
  include "tds/4a_noyaux.typ"
  include "tds/4b_cli.typ"
} else {
  sommaire-td(td-4a, td-4b)
}

// --------------------------------------------
#separateur(
  "Parcours avancé · La fenêtre du train",
  annonce: "Une vidéo fabriquée par ImageMagick et ffmpeg, lancés par Python ; un environnement décrit par environment.yml",
)

// --------------------------------------------
#d("Des outils en ligne de commande")[
  #annonce[
    ImageMagick (`magick`) et ffmpeg sont des programmes en ligne de
    commande, comme git (cours 2) et pandoc (cours 3). Le script Python les
    lance avec `subprocess.run` : une fois par image pour `magick`, une fois
    à la fin pour `ffmpeg`.
  ]

  #code-commente(
    taille-code: 11.5pt, taille-texte: 11.5pt,
    ("magick fond.png ( plan.png -roll -8+0 -crop 640x480+0+0 +repage )", "la bande du plan, tournée de 8 colonnes, puis découpée"),
    ("       -composite fenetre.png -composite img_0002.png", "posé sur le fond, puis la fenêtre par-dessus"),
    ("ffmpeg -framerate 12 -i img_%04d.png train.mp4", "12 images par seconde ; `%04d` : un numéro à quatre chiffres"),
  )

  #legende[
    Pendant le développement, chaque étape se termine par un commit git : le
    dépôt garde une version qui fonctionne à chaque étape.
  ]

  #notes[
    `magick` et `ffmpeg` ne sont pas dans l'environnement `base`
    d'Anaconda : c'est la raison de la partie A.
  ]
]

// --------------------------------------------
#d("Le programme train.py, étape par étape")[
  #annonce[
    Python calcule la liste des décalages, puis, pour chaque décalage, lance
    `magick`, qui compose l'image. ffmpeg assemble les 120 images.
  ]

  #programme-train(hauteur-vignette: 64pt)

  #notes[
    Les étapes du programme ; celles du TD sont sur sa feuille. `decalages` fait l'étape 2,
    `image` les étapes 3 et 4, `assembler` l'étape 5.
  ]
]

// --------------------------------------------
#d("L'environnement animation")[
  #annonce[
    `environment.yml` liste ce que le projet demande. `conda env create` crée
    l'environnement à partir de ce fichier ; `conda activate` le rend actif
    dans le terminal.
  ]

  #face-a-face(
    panneau("depart/environment.yml")[
      #sortie("name: animation\nchannels:\n  - conda-forge\ndependencies:\n  - python=3.12\n  - jupyterlab\n  - imagemagick\n  - ffmpeg", taille: 12pt)
    ],
    panneau("Dans le terminal Git Bash, dans depart/")[
      #tableau(
        entete: false,
        columns: (1fr,),
        align: left + horizon,
        [`conda env create -f environment.yml`],
        [`conda env list` #h(0.5em) → une ligne `animation`],
        [`conda activate animation` #h(0.5em) → `(animation)`],
        [`magick -version`, `ffmpeg -version`],
      )
    ],
  )

  #legende[
    Guide, étapes A2 et A3. Avant la première commande, une fois par poste :
    `conda` rendu disponible dans Git Bash. La création télécharge les
    paquets : plusieurs minutes.
  ]

  #notes[
    Un environnement est un dossier avec son Python et ses programmes ;
    `activate` met ses dossiers en tête de `PATH`. La partie 4 du cours 1
    de 2026, qui l'expliquait, n'a pas été jouée : le dire ici, sans
    parler de rappel.

    Si deux élèves partagent un poste, le second obtient `prefix already
    exists` : l'environnement est déjà là, passer à l'activation.
  ]
]

// --------------------------------------------
#d("JupyterLab lancé depuis l'environnement")[
  #annonce[
    Le notebook appelle `magick` et `ffmpeg` : il les cherche dans le `PATH`
    du terminal qui a lancé JupyterLab. JupyterLab se lance donc depuis le
    terminal Git Bash de VS Code, l'environnement `animation` actif.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous devez obtenir],
    [1], [copier `depart/notebook/<nom>.ipynb` dans `travail/`], [`travail/<nom>.ipynb`],
    [2], [`cd travail`, puis `jupyter lab`], [le navigateur s'ouvre sur `travail/`],
    [3], [ouvrir le notebook, exécuter les sections 1 et 2], [section 2 : trois chemins qui contiennent `envs\animation`],
    [4], [exécuter les sections suivantes, une à une], [une image d'essai par section, puis la vidéo],
  )

  #avertissement[
    Lancé depuis Anaconda Navigator, JupyterLab tourne dans `base` : la
    section 2 affiche `magick : None`.
  ]
]

// --------------------------------------------
#if tds {
  include "tds/4c_train.typ"
} else {
  sommaire-td(td-4c)
}

// --------------------------------------------
#d("Une version, une étiquette")[
  #annonce[
    Une étiquette git, un _tag_, nomme un commit. Posée sur la version
    finale du programme, elle la retrouve sans chercher son identifiant.
  ]

  #code-commente(
    taille-code: 13pt, taille-texte: 12.5pt,
    ("git tag -a v1.0 -m \"Première version\"", "pose l'étiquette `v1.0` sur le commit courant"),
    ("git tag", "liste les étiquettes du dépôt"),
    ("git log --oneline --graph --all", "l'étiquette apparaît à côté du commit"),
  )

  #notes[
    Vu au cours 2 (TD 6a). Le cours 6 publie le dépôt, étiquette comprise.
  ]
]

// --------------------------------------------
#d("Ce qu'on rend")[
  #annonce[
    Le dossier du projet, avec son historique git : le code, le README, et
    pour le train `environment.yml`, qui permettent de refaire le résultat
    sur un autre poste.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Commande], [Parcours standard, `recette.py`], [Parcours avancé, `train.py`],
    [`git log --oneline --graph --all`], [six commits, et l'étiquette `v1.0`], [douze commits, dont un de fusion, et l'étiquette `v1.0`],
    [`git status`], [« rien à valider » ; `sortie/` n'est pas listé], [« rien à valider » ; `sortie/` n'est pas listé],
    [`python <nom>.py --help`], [les trois arguments et leur aide], [les options des trois fonctionnalités],
    [le résultat], [`sortie/<recette>.html`], [`sortie/train.mp4`],
  )

  #notes[
    Le cours 6 publie le dépôt sur GitHub : le README en est la page
    d'accueil. Le parcours standard publie le dépôt de la recette.
  ]
]
