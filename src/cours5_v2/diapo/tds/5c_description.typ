// TD 5c du cours 5 v2 — « Décrire l'installation pour un autre poste ».
//
// Nouveau (v2), 06/11/2026 : `environment.yml`, le `README.md`, puis l'environnement supprimé et
// recréé à partir de ces fichiers. `pyproject.toml` reste facultatif. Solutions dans
// `data/cours5_v2/corriges/5c_description/`. Parcours essayé sous Linux le 06/11/2026 ; la durée de
// la recréation sur un poste de la salle reste à relever.
//
// Inclus par `cours5_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 5_v2`.
#import "../../../commun/prelude.typ": *
#import "../../../cours1_v2/diapo/schemas.typ": consignes, comment, commandes, constat

#let td = (
  numero: "5c",
  titre: "Décrire l'installation pour un autre poste",
  annonce: "Objectif : décrire l'installation de carte_trace.py dans des fichiers, puis refaire l'environnement à partir de ces fichiers",
  dossier: "cours5/5c_description/",
  duree: "20′",
)
#separateur-td(..td)

// Le contenu d'un fichier à écrire dans VS Code.
#let _fichier(contenu, lang: none) = block(width: 100%, inset: (x: 9pt, y: 6pt), above: 5pt, below: 2pt, fill: gris)[
  #show raw: set text(size: 12pt)
  #raw(block: true, lang: lang, contenu)
]

#d("Objectif du TD")[
  #annonce[
    Les commandes du TD 5b ne sont enregistrées nulle part dans le projet. Les décrire dans deux
    fichiers permet de supprimer l'environnement, puis de le recréer à partir de ces fichiers.
  ]

  #chaine(
    ecart: 14pt,
    ("Écrire", [`environment.yml`]),
    ("Écrire", [`README.md`]),
    ("Supprimer", "l'environnement"),
    ("Recréer", "l'environnement, dans un autre dossier"),
    ("Lancer", "le programme"),
  )

  #notes[
    Reprend « Distribution du code : étapes sur chaque poste », partie 1, et « Distribution du code :
    commandes sur un nouveau poste », partie 4.
  ]
]

#d("Écrire le fichier environment.yml")[
  #consignes(
    taille: 16pt,
    [Aller dans le dossier du TD, et copier ses fichiers dans `travail/` : #commandes("cd ../../5c_description", "cp depart/* travail/", "cd travail")],
    [Dans VS Code, créer le fichier `environment.yml` dans `travail/`, avec ces lignes : #comment[File, New File…]
      #_fichier("name: carte\nchannels:\n  - conda-forge\ndependencies:\n  - python=3.12\n  - gdal\n  - folium", lang: "yaml")],
    [Enregistrer le fichier, puis lister le dossier : `Ctrl` + `S`, puis `ls`.
      #constat[`environment.yml`, avec les fichiers du programme.]],
  )

  #notes[
    Deux espaces d'indentation, jamais de tabulation : l'éditeur signale l'erreur.
  ]
]

#d("Écrire le fichier README.md")[
  #consignes(
    taille: 16pt,
    [Dans VS Code, créer le fichier `README.md` dans `travail/`, avec ces lignes : #comment[File, New File…]
      #_fichier("# carte-trace\n\nCe programme résume une trace GPX, et écrit une carte de cette trace dans une page web.\n\n## Installation\n\n    conda env create -f environment.yml\n    conda activate carte\n\n## Utilisation\n\n    python carte_trace.py trace_2.gpx", lang: "markdown")],
    [Afficher l'aperçu : `Ctrl` + `Maj` + `V`.
      #constat[Un titre, un paragraphe et deux sections, avec les commandes en bloc de code.]],
    [Enregistrer le fichier : `Ctrl` + `S`.],
  )

  #notes[
    Quatre espaces au début d'une ligne : un bloc de code en Markdown.

    Sans `environment.yml`, cette section contiendrait la commande `conda create` complète :
    « Environnement : README ou environment.yml ».
  ]
]

#d("Supprimer l'environnement")[
  #consignes(
    taille: 17pt,
    [Désactiver l'environnement : `conda deactivate`.
      #constat[`(base)` à la place de `(carte)`.]],
    [Supprimer l'environnement : `conda env remove -y -n carte`.],
    [Afficher les environnements : `conda env list`.
      #constat[`base`, sans `carte`.]],
  )

  #legende[
    L'option `-y` répond oui à la question de confirmation de `conda`.
  ]

  #notes[
    `conda` garde les paquets déjà téléchargés dans son cache : la recréation ne les télécharge pas
    de nouveau.
  ]
]

#d("Recréer l'environnement dans un autre dossier")[
  #consignes(
    taille: 15pt,
    [Créer le dossier `nouveau_poste/`, et y copier les fichiers du projet : #commandes("mkdir ../nouveau_poste", "cp carte_trace.py stats_trace.py trace_2.gpx environment.yml README.md ../nouveau_poste/", "cd ../nouveau_poste")],
    [Suivre la section Installation du `README.md` : #commandes("conda env create -f environment.yml", "conda activate carte")
      #constat[`(carte)` au début de la ligne.]],
    [Suivre la section Utilisation du `README.md` : `python carte_trace.py trace_2.gpx`.
      #constat[`carte écrite : trace_2.html`.]],
  )

  #legende[
    Le dossier `nouveau_poste/` remplace ici un autre poste.
  ]

  #notes[
    Essayé le 06/11/2026 sous Linux : 11 s, avec des paquets déjà téléchargés. Durée à relever sur un
    poste de la salle.

    Sur un vrai nouveau poste, le dossier arrive par une copie ou par `git clone`, et `conda` télécharge
    les paquets : cours 6.
  ]
]

#d("Écrire le fichier pyproject.toml, étape facultative")[
  #consignes(
    taille: 16pt,
    [Dans VS Code, créer le fichier `pyproject.toml` dans `nouveau_poste/`, avec ces lignes : #comment[File, New File…]
      #_fichier("[project]\nname = \"carte-trace\"\nversion = \"0.1\"\nrequires-python = \">=3.10\"\ndependencies = [\"folium>=0.20\"]\n\n[tool.setuptools]\npy-modules = [\"carte_trace\", \"stats_trace\"]", lang: "toml")],
    [Installer le projet : `pip install .`
      #constat[`Requirement already satisfied: folium>=0.20`, puis `Successfully installed carte-trace-0.1`.]],
    [Afficher sa description : `pip show carte-trace`.
      #constat[`Version: 0.1` et `Requires: folium`.]],
  )

  #notes[
    `pip` trouve `folium` déjà installé par `conda`, et n'installe que `carte-trace`.

    `pip install .` écrit aussi `build/` et `carte_trace.egg-info/` dans le dossier.

    Sorties relevées sous Linux le 06/11/2026.
  ]
]
