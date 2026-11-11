// TD 5b du cours 5 v2 — « Un environnement pour le programme ».
//
// Nouveau (v2), 06/11/2026 : l'environnement `carte`, dont la création démarre au TD 5a, corrige
// les deux manques constatés à ce TD. Parcours essayé sous Linux le 06/11/2026. Les sorties
// attendues viennent de la disposition d'Anaconda sous Windows, et restent à relever sur un poste
// de la salle.
//
// 11/11/2026 : numéro d'étape dans le titre des diapositives d'action et dans la chaîne, repris par
// les sections du guide.
//
// Inclus par `cours5_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 5_v2`.
#import "../../../commun/prelude.typ": *
#import "../../../cours1_v2/diapo/schemas.typ": consignes, comment, commandes, constat

#let td = (
  numero: "5b",
  titre: "Un environnement pour le programme",
  annonce: "Objectif : faire fonctionner carte_trace.py sur le poste, dans l'environnement carte",
  dossier: "cours5/5b_environnement/",
  duree: "20′",
)
#separateur-td(..td)

#d("Objectif du TD")[
  #annonce[
    Au TD 5a, `carte_trace.py` échoue, car le poste n'a ni `folium` ni `ogr2ogr`. L'environnement
    `carte`, dont la création a démarré au TD 5a, contient ces deux outils.
  ]

  #chaine(
    ecart: 18pt,
    ("Étape 1", "Environnement créé"),
    ("Étape 2", "Activation de l'environnement"),
    ("Étape 3", "Programme dans l'environnement"),
    ("Étape 4", "Programme sans activation"),
  )

  #notes[
    Chaque étape reprend une diapositive de la partie 4 : création et dossier, activation, recherche
    des dépendances.
  ]
]

#d("Étape 1 · Environnement créé")[
  #objectif[
    attendre la fin de `conda create`, puis vérifier que l'environnement `carte` contient `ogr2ogr`
    et `folium`.
  ]

  #consignes(
    taille: 16pt,
    [Revenir au second terminal : #comment[cliquer sur son nom, dans la liste des terminaux.]],
    [Attendre la fin de `conda create`.
      #constat[`To activate this environment, use`, puis `conda activate carte`.]],
    [Revenir au premier terminal, et afficher les environnements : `conda env list`.
      #constat[`base` et `carte`, ce dernier dans `C:\Users\<nom>\.conda\envs\ `.]],
    [Lister le dossier de l'environnement : `ls ~/.conda/envs/carte`.
      #constat[`python.exe`, `Lib`, `Library` et `Scripts`, parmi d'autres.]],
    [Chercher le programme et la bibliothèque : #commandes("ls ~/.conda/envs/carte/Library/bin/ogr2ogr.exe", "ls ~/.conda/envs/carte/Lib/site-packages/folium")
      #constat[le fichier `ogr2ogr.exe`, puis les fichiers de `folium`, dont `__init__.py`.]],
  )

  #notes[
    Sorties attendues, à relever sur un poste de la salle. Relevé sous Linux : le dossier
    `…/envs/carte`, avec `bin/ogr2ogr` et `lib/python3.12/site-packages/folium/`.

    Dans Git Bash, `~` désigne `C:\Users\<nom>`.

    Si `conda create` s'arrête sur `CondaHTTPError` : annexe « Session réseau, proxy, droits du
    compte ».

    À relever sur un poste de la salle : le nom des deux terminaux dans la liste de VS Code, qui
    s'appellent peut-être tous deux « bash ».
  ]
]

#d("Étape 2 · Activation de l'environnement")[
  #objectif[
    activer `carte`, puis déterminer quels `python` et `ogr2ogr` le terminal lance.
  ]

  #consignes(
    taille: 16pt,
    [Activer l'environnement : `conda activate carte`.
      #constat[`(carte)` à la place de `(base)`.]],
    [Afficher le chemin des deux commandes : #commandes("which python", "which ogr2ogr")
      #constat[`/c/Users/<nom>/.conda/envs/carte/python`, puis `…/carte/Library/bin/ogr2ogr`.]],
    [Afficher le dernier dossier où Python cherche un module : #commandes("python -c \"import sys; print(sys.path[-1])\"")
      #constat[`C:\Users\<nom>\.conda\envs\carte\Lib\site-packages`.]],
  )

  #notes[
    Sorties attendues, à relever sur un poste de la salle. Relevé sous Linux : `…/envs/carte/bin/python`,
    `…/envs/carte/bin/ogr2ogr`, `…/envs/carte/lib/python3.12/site-packages`.

    Reprend « Activation : recherche des dépendances ».
  ]
]

#d("Étape 3 · Programme dans l'environnement")[
  #objectif[
    lancer `carte_trace.py` sur `trace_2.gpx` dans l'environnement `carte`, puis ouvrir la carte
    `trace_2.html`.
  ]

  #consignes(
    taille: 16pt,
    [Aller dans le dossier du TD, et copier ses fichiers dans `travail/` : #commandes("cd ../../5b_environnement", "cp depart/* travail/", "cd travail")],
    [Lancer le programme : `python carte_trace.py trace_2.gpx`.
      #constat[Les altitudes, `distance parcourue : 632.3 m`, `vitesse moyenne : 1.29 m/s, soit 4.6 km/h`, puis `carte écrite : trace_2.html`.]],
    [Lister les fichiers écrits : `ls`.
      #constat[`trace_2.csv`, `trace_2.geojson`, `trace_2.html` et `resume.txt`.]],
    [Ouvrir la carte : `start trace_2.html`.
      #constat[Le navigateur affiche la trace sur le Plan IGN.]],
  )

  #notes[
    Sorties relevées sous Linux le 06/11/2026.

    La page charge Leaflet et les tuiles de l'IGN par le réseau : accès à relever depuis les postes.
    En cas de blocage, montrer la capture de la partie 1.
  ]
]

#d("Étape 4 · Programme sans activation")[
  #objectif[
    déterminer si `carte_trace.py` fonctionne sans activer `carte`.
  ]

  #consignes(
    taille: 17pt,
    [Désactiver l'environnement : `conda deactivate`.
      #constat[`(base)` à la place de `(carte)`.]],
    [Relancer le programme : `python carte_trace.py trace_2.gpx`.
      #constat[`ModuleNotFoundError: No module named 'folium'`.]],
    [Réactiver l'environnement, puis relancer le programme : #commandes("conda activate carte", "python carte_trace.py trace_2.gpx")
      #constat[`carte écrite : trace_2.html`.]],
  )

  #notes[
    Aucun fichier ne change entre les trois lancements : `conda deactivate` et `conda activate`
    modifient `PATH`.

    Sorties relevées sous Linux le 06/11/2026.
  ]
]
