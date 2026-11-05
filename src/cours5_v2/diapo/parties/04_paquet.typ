// Cours 5 v2, partie 4 : le paquet. Incluse par `cours5_v2.typ`.
//
// « Projet : déclaration… » vient de la partie 4 du cours 1 de 2026, « pyproject.toml :
// du fichier à la commande » du cours 4 (le TD 4b l'applique). Reprises le 05/11/2026 :
// la ligne `[project.scripts]` de la première suit celle de la seconde.
#import "../../../commun/prelude.typ": *
#import "../../../cours3/diapo/schemas.typ": code-commente

#separateur(
  "Empaqueter un programme",
  annonce: "Le fichier qui décrit un projet, et la commande que pip installe à partir de ce fichier.",
)

// --------------------------------------------
#d("Projet : déclaration des informations & métadonnées")[
  #annonce[
    Un projet se décrit dans un fichier texte : son nom, sa version, et ce
    dont son code a besoin.
  ]

  #face-a-face(
    panneau[`pyproject.toml`, à la racine du projet][
      ```toml
      [project]
      name = "recette"
      version = "0.1.0"
      requires-python = ">=3.10"
      dependencies = ["markdown>=3.5"]

      [project.scripts]
      recette = "recette:main"
      ```
    ],
    panneau("Ce que chaque ligne déclare")[
      #tableau(
        columns: (auto, 1fr),
        align: left + horizon,
        [Ce qui est écrit], [Ce qu'il déclare],
        [`name`, `version`], [les métadonnées],
        surligne[`dependencies`], surligne[les bibliothèques à installer pour le code],
        [`requires-python`], [les versions de Python],
        [`[project.scripts]`], [la commande installée],
      )
    ],
  )

  #legende[
    `pyproject.toml` dit de quoi le code a besoin. `environment.yml` dit de quoi la
    machine a besoin, y compris ce qui n'est pas du Python.
  ]

  #notes[
    Les deux fichiers coexistent dans la plupart des projets. `pyproject.toml` s'écrit
    en TOML : des sections entre crochets, une valeur par nom. `environment.yml` est en
    YAML, où l'indentation porte la structure.

    La bibliothèque standard ne se déclare pas : `pathlib` et `subprocess` viennent
    avec Python.

    Troisième usage du texte, après le code et la documentation : décrire. YAML et
    TOML décrivent des données, comme `.json`, et acceptent des commentaires, ce
    qui explique qu'un humain les écrive.

    Piège du YAML, à mentionner si quelqu'un tape le fichier : deux espaces
    d'indentation, jamais de tabulation, et l'éditeur le signale.

    Boucler la partie : le code réutilisé au début de la séance est disponible
    parce que quelqu'un a écrit un fichier de cette forme, puis déposé le résultat
    sur un dépôt.

    Ne pas détailler `[build-system]`, absent de l'extrait : aucun projet
    ordinaire n'a à en changer.
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
    ("version = \"0.1\"", "sa version"),
    ("[project.scripts]", "les commandes à installer"),
    ("recette = \"recette:main\"", "la commande `recette` appelle `main` du module `recette`"),
    ("[tool.setuptools]", "où sont les modules"),
    ("package-dir = {\"\" = \"src\"}", "dans le dossier `src/`"),
    ("py-modules = [\"recette\"]", "le module, dans `src/recette.py`"),
  )

  #legende[
    `pip install -e .` installe le projet du dossier courant en mode
    modifiable : la commande appelle le code de `src/`, et une modification
    de ce code vaut sans réinstaller.
  ]

  #notes[
    `src/` sépare le code des données et des fichiers du projet. La commande
    est un petit exécutable écrit par pip dans le dossier de l'environnement que
    `PATH` parcourt : `which recette` l'affiche.
  ]
]
