// Séance 4, projet d'application 1 : un script Python construit pas à pas, en deux parcours.
//
// Depuis le 30/09/2026, la séance revoit les opérations des cours 1 à 3 à un
// rythme lent, sur un petit programme : le TD 4a (tous les élèves) crée le
// projet dans le terminal, l'ouvre dans VS Code, le versionne, puis écrit
// `recette.py` étape par étape. Le parcours avancé fait le TD 4a plus vite,
// puis le TD 4b, précédé de quatre diapositives d'exposé : `main`, deux
// modules, un environnement décrit par un fichier, une commande installée.
//
// Les TD d'avant le 30/09/2026 (4a noyaux, 4b ligne de commande, 4c train)
// sont dans l'historique git ; le train est repris au projet 7. Les TD 4a
// montre et 4b tourbillon d'avant le 26/09/2026 restent des propositions
// (`propositions/`).
//
//   python outils/compiler_diapos.py --cours 4
//   python outils/compiler_diapos.py --cours 4 --notes
//   python outils/compiler_diapos.py --cours 4 --sans-tds

#import "../../commun/prelude.typ": *
#import "../../cours3/diapo/schemas.typ": code-commente, sortie

#show: diapos.with(
  titre-court: "Introduction à l'informatique",
  auteur-court: "1re année géomatique",
)

#let tds = sys.inputs.at("tds", default: "") != "false"

#import "tds/4a_recette.typ": td as td-4a
#import "tds/4b_paquet.typ": td as td-4b

#page-titre(
  titre: "Séance 4 : projet d'application 1",
  sous-titre: "TD d'application des cours 1 à 3 : un script Python construit pas à pas, versionné avec git",
  auteur: "1re année géomatique",
  date: "",
)

// --------------------------------------------
#d("Contenu de la séance")[
  #annonce[
    Un TD d'application des cours 1 à 3, sur un seul projet : un script
    Python qui calcule les quantités d'une recette.
  ]

  #tableau(
    columns: (auto, 1fr, auto),
    align: (left + horizon, left + horizon, center + horizon),
    [Parcours], [Ce qu'on fait], [Durée],
    [Tous], [présentation de la séance], [5 min],
    [Standard], [TD 4a, partie A : créer le dossier du projet dans le terminal, l'ouvrir dans VS Code, créer le dépôt git], [30 min],
    [], [TD 4a, partie B : construire un script Python, avec un commit git à la fin de chaque étape], [75 min],
    [Avancé], [TD 4a, parties A et B, en 50 minutes], [50 min],
    [], [exposé : découper un script en modules, décrire son environnement, l'installer comme une commande], [10 min],
    [], [TD 4b : transformer le script en programme installable avec pip], [55 min],
  )

  #notes[
    Le guide de chaque TD, dans son dossier, détaille chaque étape : le
    faire ouvrir dès le début. Il reste 10 minutes de marge au parcours
    standard.
  ]
]

// --------------------------------------------
#d("Deux parcours")[
  #annonce[
    Chaque élève garde le parcours choisi au cours 3. Les deux parcours
    écrivent le même programme.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Parcours standard], [Parcours avancé],
    [Au cours 3], [TD 3e : une recette en Markdown], [TD 3f : le programme `recette.py`],
    [Au projet 4], [TD 4a, en suivant le guide détaillé], [TD 4a en 50 minutes, puis TD 4b],
    [Dossier], [`cours4/4a_recette/`], [`cours4/4a_recette/`, puis les fichiers à compléter de `cours4/4b_paquet/`],
  )

  #legende[
    Garder le dossier `travail/recette/` après la séance : les séances
    suivantes le reprennent.
  ]
]

// --------------------------------------------
#if tds {
  include "tds/4a_recette.typ"
} else {
  sommaire-td(td-4a)
}

// --------------------------------------------
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
    La partie 4 du cours 1 de 2026, qui expliquait les environnements, n'a
    pas été jouée : le dire ici, sans parler de rappel.

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

// --------------------------------------------
#if tds {
  include "tds/4b_paquet.typ"
} else {
  sommaire-td(td-4b)
}

// --------------------------------------------
#d("Ce qu'on rend")[
  #annonce[
    Le dossier du projet, avec son historique git.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Commande], [Parcours standard], [Parcours avancé],
    [`git log --oneline`], [huit commits, neuf avec le bonus], [douze commits au moins],
    [`git status`], [« rien à valider » ; `sortie/` n'est pas listé], [« rien à valider » ; `sortie/` n'est pas listé],
    [l'aide], [`python recette.py --help`], [`recette --help`],
    [le résultat], [`sortie/crepes_6_US.csv`], [le même, et `environment.yml`, `pyproject.toml`],
  )

  #notes[
    Le README et l'étiquette `v1.0` (étape B7) se font après la séance si
    le temps manque.
  ]
]
