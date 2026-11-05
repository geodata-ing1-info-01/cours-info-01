// Exposé du parcours avancé, retiré du cours 4 v2 le 05/11/2026 : pas de parcours avancé
// pour l'instant. Des options avancées s'ajouteront aux TD quand une première version de
// tous les cours v2 existera. Ce fichier n'est inclus nulle part. Il précédait le TD 4b
// (`4b_paquet.typ`, à côté) et porte sur `recette.py`, le programme du TD 4a de 2026.
#import "../../../commun/prelude.typ": *
#import "../../../cours3/diapo/schemas.typ": code-commente, sortie

#separateur(
  "Parcours avancé · Un projet Python",
  annonce: "Un programme réparti en modules, un environnement décrit par un fichier, une commande installée par pip",
)

// --------------------------------------------
#d("Un module, un import")[
  #annonce[
    Un fichier Python est un module. `import` exécute le module une fois, et
    ses noms sont ensuite utilisables dans le fichier qui l'importe.
  ]

  #face-a-face(
    panneau("quantites.py")[
      #sortie("import csv\n\nVERS_US = {\"g\": (\"oz\", 1 / 28.3495), …}\n\ndef adapter(ingredients, personnes_recette, personnes):\n    …\n\ndef convertir(ingredients, table):\n    …", taille: 11pt)
    ],
    panneau("recette.py")[
      #sortie("from quantites import VERS_US, adapter, convertir\n\ndef main():\n    …\n    ingredients = adapter(ingredients, 4, 6)\n    ingredients = convertir(ingredients, VERS_US)", taille: 11pt)
    ],
  )

  #legende[
    Python cherche un module dans le dossier du fichier lancé, puis dans la
    bibliothèque standard (`csv`, `pathlib`) et dans les paquets de
    l'environnement actif.
  ]

  #notes[
    `import quantites` exécute tout le fichier : d'où `main` et
    `if __name__ == "__main__":` (étape C1), pour qu'un import de
    `recette.py` ne lance pas le programme.

    La liste des dossiers parcourus : `python -c "import sys; print(sys.path)"`.
  ]
]

// --------------------------------------------
#d("Un environnement conda")[
  #annonce[
    Un environnement est un dossier qui contient un Python et des paquets.
    `conda activate` place ses dossiers en tête de `PATH`, et `python`
    désigne alors le Python de l'environnement.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Commande], [Invite `(base)`], [Invite `(recette)`],
    [`which python`], [le Python d'Anaconda, dans `anaconda3/`], [le Python de l'environnement, dans `envs/recette/`],
    [`which pandoc`], [le pandoc d'Anaconda], [le pandoc de l'environnement],
    [`pip install …`], [installe dans `base`], [installe dans `recette` seulement],
  )

  #legende[
    Une commande désigne un exécutable cherché dans les dossiers de `PATH`,
    dans l'ordre (cours 1). Deux projets, deux environnements : les
    versions installées pour l'un ne changent pas l'autre.
  ]

  #notes[
    Le cours 5 v2 reprend les environnements pour tous les élèves.

    Emplacement réel de `envs/` sur les postes de la salle : à vérifier
    (`conda env list`).
  ]
]

// --------------------------------------------
#d("environment.yml, conda et pip")[
  #annonce[
    `environment.yml` décrit l'environnement du projet. Versionné avec le
    code, il permet de recréer l'environnement sur un autre poste.
  ]

  #face-a-face(
    panneau("environment.yml")[
      #sortie("name: recette\nchannels:\n  - conda-forge\ndependencies:\n  - python=3.12\n  - pandoc\n  - pip\n  - setuptools", taille: 12pt)
    ],
    panneau("Dans le terminal, dans le projet")[
      #tableau(
        entete: false,
        columns: (1fr,),
        align: left + horizon,
        [`conda env create -f environment.yml` #h(0.5em) → crée `recette`],
        [`conda activate recette` #h(0.5em) → `(recette)`],
        [`pip install -e . --no-build-isolation` #h(0.5em) → installe le projet],
      )
    ],
  )

  #legende[
    conda installe Python et des programmes qui ne sont pas écrits en
    Python, comme pandoc. pip installe des paquets Python : ici, le projet
    lui-même.
  ]

  #notes[
    `conda-forge` : le dépôt des paquets. `setuptools` construit le paquet
    au moment de `pip install` ; présent dans l'environnement, il évite un
    téléchargement depuis PyPI (`--no-build-isolation`).
  ]
]

// --------------------------------------------
#d("pyproject.toml : du fichier à la commande")[
  #annonce[
    `pyproject.toml` est la fiche du projet, lue par pip. `[project.scripts]`
    y déclare les commandes à installer.
  ]

  #code-commente(
    taille-code: 12pt, taille-texte: 12pt,
    ("[project]", "la fiche du projet"),
    ("name = \"recette\"", "le nom du paquet, pour pip"),
    ("[project.scripts]", "les commandes à installer"),
    ("recette = \"recette:main\"", "la commande `recette` appelle `main` du module `recette`"),
    ("[tool.setuptools]", "où sont les modules"),
    ("package-dir = {\"\" = \"src\"}", "dans le dossier `src/`"),
    ("py-modules = [\"recette\", \"quantites\"]", "deux modules, un fichier chacun"),
  )

  #legende[
    `pip install -e .` installe le projet du dossier courant en mode
    modifiable : la commande appelle le code de `src/`, et une modification
    de ce code vaut sans réinstaller.
  ]

  #notes[
    `src/` sépare le code des données et des fichiers du projet. La commande
    est un petit exécutable écrit par pip dans l'environnement :
    `which recette`.
  ]
]
