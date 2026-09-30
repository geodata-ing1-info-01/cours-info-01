// TD 4b du projet 4 — « Un programme installable », parcours avancé.
//
// Inclus par `cours4.typ`, après les quatre diapositives d'exposé du
// parcours avancé ; compilable seul par `outils/compiler_tds.py`. Un fichier
// inclus n'hérite pas des imports de son appelant.
//
// Le TD suit le TD 4a, dans le même dossier `4a_recette/travail/recette/`,
// à partir de l'état de l'étape B6. Ses modèles (`environment.yml`,
// `pyproject.toml`) sont dans `4b_paquet/depart/modeles/`. Corrigés et guide
// écrits par `data/cours4/generer_recette.py`.
#import "../../../commun/prelude.typ": *
#import "../../../cours3/diapo/schemas.typ": attendu-pistes, arborescence

#let td = (
  numero: "4b",
  titre: "Un programme installable",
  annonce: "Parcours avancé. TD d'application : transformer le script du TD 4a en projet Python installable, avec une fonction main, deux modules, un environnement et une commande",
  dossier: "cours4/4b_paquet/",
  duree: "55′",
)
#separateur-td(..td)

// --------------------------------------------
#d("Le guide et le matériel de départ")[
  #annonce[
    Le TD part du programme de l'étape B6 du TD 4a, dans le même dossier.
    Le guide détaille chaque étape.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Fichier], [Emplacement], [Usage],
    [`guide_4b_paquet.pdf`, `.html`, `guide.ipynb`], [`cours4/4b_paquet/`], [le détail des étapes, le code à copier],
    [`recette.py`, `recettes/`], [`cours4/4a_recette/travail/recette/`], [le projet du TD 4a, à l'étape B6],
    [`environment.yml`, `pyproject.toml`], [`cours4/4b_paquet/depart/modeles/`], [l'environnement (C3) et la fiche du projet (C4), à copier et compléter],
  )

  #notes[
    Depuis le projet, ces fichiers se copient par
    `cp ../../../4b_paquet/depart/modeles/environment.yml .`
  ]
]

// --------------------------------------------
#d("Les étapes du TD")[
  #annonce[
    Le script du TD 4a devient un programme installé, lancé par la commande
    `recette`, dans un environnement créé depuis un fichier.
  ]

  #chaine(
    ([`python recette.py crepes`], "un script"),
    ([`src/recette.py`, `src/quantites.py`], "deux modules"),
    ([`recette crepes`], "une commande installée"),
  )

  #tableau(
    columns: (auto, 1.3fr, 1fr),
    align: (center + horizon, left + horizon, left + horizon),
    [Étape], [Objectif], [Résultat],
    [C1], [isoler le programme principal], [`import recette` n'exécute rien],
    [C2], [répartir le code en deux modules], [`quantites.py`, importé],
    [C3], [décrire l'environnement dans un fichier], [l'environnement `recette`],
    [C4], [installer une commande], [`recette crepes -p 6`],
    [C5 (bonus)], [lancer pandoc depuis Python], [`sortie/crepes_6_SI.html`],
  )

  #notes[
    Un commit à la fin de chaque étape.
  ]
]

// --------------------------------------------
#d("Étape C1 · Une fonction main")[
  #annonce[
    Objectif : le même script, dont les fonctions peuvent être importées par
    un autre fichier sans lancer le programme.
  ]

  #attendu-pistes(
    (
      [`python recette.py crepes -p 6` affiche la même recette qu'à l'étape B6],
      [`python -c "import recette"` n'affiche rien],
      [un commit],
    ),
    (
      [écrire `def main():` au-dessus de la première ligne du programme],
      [sélectionner les lignes du programme, puis `Tab` : elles passent dans `main`],
      [appeler `main()` en bas du fichier, sous `if __name__ == "__main__":`],
    ),
  )

  #legende[
    Guide, étape C1.
  ]

  #reponse(legende[
    Constaté : avant, `python -c "import recette"` s'arrête sur `the
    following arguments are required: nom`.
  ])
]

// --------------------------------------------
#d("Étape C2 · Deux modules")[
  #annonce[
    Objectif : séparer ce qui calcule de ce qui dépend du programme, dans
    deux fichiers.
  ]

  #attendu-pistes(
    (
      [`quantites.py` contient les deux tables et les cinq fonctions],
      [`recette.py` ne contient plus que les chemins, `main` et son appel],
      [`python recette.py crepes -p 6` affiche la même recette ; un commit],
    ),
    (
      [créer `quantites.py`, y couper-coller les tables et les fonctions, avec `import csv` en tête],
      [dans `recette.py`, importer ce qu'il emploie : `from quantites import …`],
      [ajouter le nouveau fichier : `git add quantites.py`, puis le commit],
    ),
  )

  #legende[
    Guide, étape C2.
  ]

  #reponse(legende[
    Constaté : `python -c "import quantites; print(quantites.VERS_US)"`
    affiche la table ; un nom oublié dans l'import donne `NameError`.
  ])
]

// --------------------------------------------
#d("Étape C3 · Un environnement pour le projet")[
  #annonce[
    Objectif : un environnement qu'une autre personne recrée à l'identique,
    à partir d'un fichier versionné avec le code.
  ]

  #attendu-pistes(
    (
      [`environment.yml` versionné dans le dépôt],
      [l'invite commence par `(recette)`],
      [`which python` affiche un chemin qui contient `envs/recette` ; le programme fonctionne],
    ),
    (
      [copier le modèle : `cp ../../../4b_paquet/depart/modeles/environment.yml .`],
      [créer l'environnement : `conda env create -f environment.yml` (plusieurs minutes)],
      [l'activer : `conda activate recette`],
      [faire le commit du fichier],
    ),
  )

  #legende[
    Guide, étape C3.
  ]

  #reponse(legende[
    Constaté : le programme fonctionne dans le nouvel environnement ; il
    n'emploie que la bibliothèque standard de Python.
  ])

  #notes[
    Durée du téléchargement à mesurer sur un poste de la salle. Si elle
    dépasse cinq minutes : lancer la création, puis faire les étapes C1 et
    C2 pendant le téléchargement, dans un second terminal.
  ]
]

// --------------------------------------------
#d("Étape C4 · Une commande installée")[
  #annonce[
    Objectif : lancer le programme par son nom, comme `git` ou `pandoc`.
  ]

  #grid(
    columns: (2fr, 1fr), column-gutter: 22pt, align: top,
    attendu-pistes(
      (
        [`recette crepes -p 6` affiche la recette, sans `python` ni nom de fichier],
        [`recette --help` affiche l'aide],
        [un commit],
      ),
      (
        [déplacer les modules : `mkdir src`, puis `git mv recette.py quantites.py src/`],
        [remonter la racine d'un dossier : `RACINE = Path(__file__).parent.parent`],
        [copier `pyproject.toml`, compléter sa ligne `description`],
        [installer : `pip install -e . --no-build-isolation`],
      ),
    ),
    arborescence(
      (0, "recette/"),
      (1, "src/"),
      (2, "recette.py"),
      (2, "quantites.py"),
      (1, "recettes/"),
      (1, "environment.yml"),
      (1, "pyproject.toml"),
      (1, ".gitignore"),
    ),
  )

  #legende[
    Guide, étape C4.
  ]

  #reponse(legende[
    Constaté : dans `src/`, sans la nouvelle racine, le script ne trouve
    plus `recettes/` ; installée, la commande marche depuis n'importe quel
    dossier.
  ])

  #notes[
    Les chemins partent de `Path(__file__)` : après `git mv`, un `.parent`
    de plus. `--no-build-isolation` emploie le `setuptools` de
    l'environnement, sans accès à PyPI.
  ]
]

// --------------------------------------------
#d("Étape C5 (bonus) · La page HTML, par pandoc")[
  #annonce[
    Objectif : lancer un programme extérieur depuis Python, comme au
    cours 3.
  ]

  #attendu-pistes(
    (
      [`recette crepes -p 6 --page` écrit `sortie/crepes_6_SI.html`],
      [la page s'ouvre dans le navigateur, avec le titre et le tableau des ingrédients],
    ),
    (
      [écrire un tableau Markdown dans `sortie/`],
      [le convertir en page HTML : `subprocess.run(["pandoc", …], check=True)`],
      [ajouter l'option `--page` : `action="store_true"`],
    ),
  )

  #legende[
    Guide, étape C5. pandoc est dans l'environnement `recette`.
  ]
]
