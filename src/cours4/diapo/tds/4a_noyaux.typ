// TD 4a du projet 4 — « Le client et le noyau d'un notebook », parcours
// standard.
//
// Inclus par `cours4.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`. Un
// fichier inclus n'hérite pas des imports de son appelant.
//
// Reprend les TD 3b (un notebook ouvert de plusieurs façons) et 4b (le client
// et le noyau) du cours 1, non joués en 2026, sur le code de la recette du
// cours 3 : `noyau.ipynb`, puis l'environnement `info01-recette`, qui a le
// noyau sans le client.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "4a",
  titre: "Le client et le noyau d'un notebook",
  annonce: "Parcours standard : ouvrir le même notebook dans JupyterLab puis dans VS Code, voir ce que le noyau retient, puis l'exécuter dans le noyau d'un environnement créé pour le programme",
  dossier: "cours4/4a_noyaux/",
  duree: "30′",
)
#separateur-td(..td)

// --------------------------------------------
#d("Un notebook, deux clients")[
  #annonce[
    `noyau.ipynb` s'ouvre dans JupyterLab, puis dans VS Code. Les deux
    clients exécutent ses cellules dans un noyau, ici celui de `base`.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire],
    [1], [copier `depart/notebook/noyau.ipynb` dans `travail/`],
    [2], [dans l'invite de commandes d'Anaconda, `cd` vers `4a_noyaux/`, puis `jupyter lab` ; ouvrir `travail/noyau.ipynb`],
    [3], [exécuter la section 1 : les deux chemins sont dans `anaconda3`],
    [4], [section 2 : suivre le texte, jusqu'au redémarrage du noyau et à l'erreur `NameError`],
    [5], [fermer l'onglet, puis `Ctrl` + `C` dans l'invite de commandes d'Anaconda : le serveur s'arrête],
    [6], [dans VS Code, ouvrir `travail/noyau.ipynb` ; en haut à droite, « Select Kernel », puis « Python Environments » et `base` ; exécuter la section 1],
  )

  #legende[
    JupyterLab et VS Code affichent le même fichier et exécutent ses cellules
    dans le même interpréteur : celui du noyau, donné par `sys.executable`.
  ]

  #notes[
    Étape 5 : le serveur tourne tant que l'invite de commandes d'Anaconda est ouverte ;
    fermer l'onglet du navigateur ne l'arrête pas.

    Étape 6 : VS Code démarre le noyau lui-même, sans JupyterLab. Il faut les
    extensions Python et Jupyter de VS Code, installées au cours 1.
  ]
]

// --------------------------------------------
#d("Un environnement pour le programme")[
  #annonce[
    `environment.yml` décrit l'environnement du programme : Python, pandoc et
    `ipykernel`, le noyau. Il n'a pas de client : `jupyterlab` n'y est pas.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire],
    [7], [dans l'invite de commandes d'Anaconda, dans `4a_noyaux/depart/` : `conda env create -f environment.yml`, puis `conda env list`],
    [8], [dans VS Code, « Select Kernel » → `info01-recette` ; exécuter la section 1 : les chemins sont dans `envs\info01-recette`],
    [9], [exécuter la section 3 : `travail/crepes.html` est écrit ; l'ouvrir par un double-clic],
    [10], [`conda activate info01-recette`, puis `jupyter lab` : `Jupyter command jupyter-lab not found`],
  )

  #legende[
    VS Code n'a besoin que du noyau, `ipykernel`. JupyterLab est un client :
    il faut l'installer dans l'environnement, ou le lancer depuis `base`.
  ]

  #notes[
    Étape 7 : la création télécharge 66 paquets, quelques minutes. Si deux
    élèves partagent un poste, le second obtient `prefix already exists` :
    passer à l'étape 8.

    Étape 10 : `jupyter` existe (paquet `jupyter_core`, dépendance
    d'`ipykernel`), la sous-commande `lab` non.
  ]
]
