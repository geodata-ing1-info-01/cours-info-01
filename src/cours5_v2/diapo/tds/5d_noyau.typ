// TD 5d du cours 5 v2 — « Le noyau de l'environnement », facultatif.
//
// Nouveau (v2), 06/11/2026, adapté du TD 1i de 2026 : le notebook échoue avec le noyau de `base`,
// puis `carte` est déclaré et choisi dans JupyterLab. Le notebook vient de
// `data/cours5_v2/make_data.py`. Cellule essayée sous Linux le 06/11/2026 par `nbclient`, dans les deux
// noyaux. Le choix du noyau dans le menu de JupyterLab et les chemins de Windows restent à relever sur
// un poste de la salle.
//
// 11/11/2026 : numéro d'étape dans le titre des diapositives d'action et dans la chaîne, repris par
// les sections du guide.
//
// Inclus par `cours5_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 5_v2`.
#import "../../../commun/prelude.typ": *
#import "../../../cours1_v2/diapo/schemas.typ": consignes, comment, commandes, constat

#let td = (
  numero: "5d",
  titre: "Le noyau de l'environnement",
  annonce: "Objectif : exécuter un notebook avec le Python de l'environnement carte",
  dossier: "cours5/5d_noyau/",
  duree: "15′",
  statut: "facultatif",
)
#separateur-td(..td)

#d("Objectif du TD")[
  #annonce[
    Un notebook ouvert par le JupyterLab de `base` s'exécute avec le Python de `base`. Pour employer
    le Python de `carte`, il faut déclarer le noyau de cet environnement, puis le choisir dans JupyterLab.
  ]

  #chaine(
    ecart: 18pt,
    ("Étape 1", "Notebook avec le noyau de base"),
    ("Étape 2", "Déclaration du noyau de l'environnement"),
    ("Étape 3", "Choix du noyau dans JupyterLab"),
  )

  #notes[
    Reprend la partie 5 : « Notebook : bibliothèque introuvable », puis « Noyau d'un environnement :
    déclaration » et « Noyau : recherche des dépendances ».
  ]
]

#d("Étape 1 · Notebook avec le noyau de base")[
  #objectif[
    exécuter `carte.ipynb` dans JupyterLab, avec le noyau de `base`, et déterminer si la cellule
    aboutit.
  ]

  #consignes(
    taille: 16pt,
    [Revenir à `base`, aller dans le dossier du TD, et copier ses fichiers dans `travail/` : #commandes("conda deactivate", "cd ../../5d_noyau", "cp depart/* travail/", "cd travail")
      #constat[`(base)` au début de la ligne.]],
    [Lancer JupyterLab : `jupyter lab`.
      #constat[Le terminal reste occupé, et le navigateur ouvre une adresse `localhost`.]],
    [Ouvrir le notebook : #comment[double-cliquer sur `carte.ipynb`, dans le panneau de gauche.]
      #constat[`Python 3 (ipykernel)`, en haut à droite.]],
    [Exécuter la cellule : `Maj` + `Entrée`.
      #constat[`C:\ProgramData\anaconda3\python.exe`, `None`, puis `ModuleNotFoundError`.]],
  )

  #notes[
    Sorties attendues, à relever sur un poste de la salle. Relevé sous Linux, avec un environnement
    d'essai à la place de `base` : le chemin de son interpréteur, `None`, puis `ModuleNotFoundError`.

    `None` : aucun dossier de `PATH` ne contient `ogr2ogr`.

    Les captures du guide viennent de JupyterLab sous Linux, avec une cellule plus courte : à refaire
    sur un poste de la salle.
  ]
]

#d("Étape 2 · Déclaration du noyau de l'environnement")[
  #objectif[
    déclarer à JupyterLab le noyau de l'environnement `carte`, dans le second terminal.
  ]

  #consignes(
    taille: 16pt,
    [Ouvrir un second terminal : #comment[menu Terminal, New Terminal.]
      #constat[`(base)` au début de la ligne.]],
    [Activer l'environnement, et y installer `ipykernel` : #commandes("conda activate carte", "conda install -y -c conda-forge ipykernel")],
    [Déclarer le noyau : #commandes("python -m ipykernel install --user --name carte")
      #constat[`Installed kernelspec carte in`, suivi d'un dossier `jupyter\kernels\carte`.]],
  )

  #notes[
    Le premier terminal reste occupé par le serveur de JupyterLab.

    Dossier attendu sous Windows, d'après l'annexe sur les environnements de VS Code :
    `AppData\Roaming\jupyter\kernels\carte`. À relever sur un poste de la salle.

    À relever sur un poste de la salle : le nom des deux terminaux dans la liste de VS Code, qui
    s'appellent peut-être tous deux « bash ».
  ]
]

#d("Étape 3 · Choix du noyau dans JupyterLab")[
  #objectif[
    exécuter `carte.ipynb` avec le noyau `carte`, puis arrêter le serveur de JupyterLab.
  ]

  #consignes(
    taille: 16pt,
    [Recharger la page de JupyterLab : `F5`.],
    [Choisir le noyau : #comment[cliquer sur `Python 3 (ipykernel)`, en haut à droite, choisir `carte`, puis Select.]
      #constat[`carte`, en haut à droite.]],
    [Relancer le noyau et exécuter la cellule : #comment[menu Kernel, Restart Kernel and Run All Cells…]
      #constat[`…\.conda\envs\carte\python.exe`, `None`, puis `folium 0.20.0`.]],
    [Arrêter le serveur : #comment[revenir au premier terminal, puis `Ctrl` + `C` deux fois.]
      #constat[Le terminal rend la main, et le navigateur signale que le serveur ne répond plus.]],
  )

  #notes[
    Le serveur déjà lancé liste `carte` aussitôt : essayé le 06/11/2026. La page du navigateur peut
    garder l'ancienne liste, d'où le rechargement.

    `ogr2ogr` reste à `None` : le noyau reçoit le `PATH` du serveur, lancé depuis `base`. Reprend
    « Noyau : recherche des dépendances ».

    Sorties de la cellule relevées sous Linux par `nbclient`. Libellés du menu à relever dans JupyterLab
    sur un poste de la salle.
  ]
]
