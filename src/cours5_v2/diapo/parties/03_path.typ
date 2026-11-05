// Cours 5 v2, partie 3 : PATH et variables d'environnement. Incluse par `cours5_v2.typ`.
//
// Nouveau (05/11/2026), sauf « Ce que l'activation d'un environnement change », reprise
// de la partie 4 du cours 1 de 2026, avec `schema-path` du cours 1 v2, écrit en chemins
// de Git Bash, à la place de `schema-chemin`. Répond à la question laissée au cours 1 v2 :
// comment `python` désigne un fichier. Fichiers de démarrage et `export PATH` : MIT,
// *The Missing Semester*, « Command-line Environment ».
//
// Commandes essayées le 05/11/2026 sous Linux (bash 5, Python 3.12). Les chemins de
// Windows des deux premières diapositives sont attendus sur un poste de la salle, et
// restent à relever.
#import "../../../commun/prelude.typ": *
#import "../../../cours1_v2/diapo/schemas.typ": terminal, schema-path

#separateur(
  "PATH et variables d'environnement",
  annonce: "Comment le terminal trouve une commande, et ce qu'il transmet aux programmes qu'il lance.",
)

// --------------------------------------------
#d("Variables d'environnement : définition")[
  #annonce[
    Une variable d'environnement associe un nom à une valeur. Le terminal la
    transmet à chaque programme qu'il lance.
  ]

  #grid(
    columns: (1fr, 1.15fr), column-gutter: 18pt, align: top,
    terminal(
      taille: 17pt,
      "$ echo \"$HOME\"",
      "/c/Users/eleve",
      "$ echo \"$USERNAME\"",
      "eleve",
    ),
    tableau(
      columns: (auto, 1fr),
      align: left + horizon,
      [Variable], [Sa valeur],
      [`HOME`], [le dossier personnel, que `~` désigne],
      [`USERNAME`], [le nom de l'utilisateur],
      [`PATH`], [les dossiers où chercher une commande],
    ),
  )

  #legende[
    `$NOM` est remplacé par la valeur de la variable avant que la commande ne
    démarre, comme le motif `*`. `env` affiche toutes les variables.
  ]

  #notes[
    Sorties attendues sur un poste de la salle, à relever. Sous Linux, `USERNAME`
    s'appelle `USER`, et `HOME` vaut `/home/eleve`.

    Les guillemets gardent la valeur en un seul mot, même si elle contient un
    espace (TD 1b).
  ]
]

// --------------------------------------------
#d("PATH : recherche d'une commande")[
  #annonce[
    Pour une commande sans `/`, Git Bash cherche dans chaque dossier de `PATH`, dans
    l'ordre, et lance le premier fichier de ce nom.
  ]

  #terminal(
    taille: 17pt,
    "$ echo \"$PATH\" | tr ':' '\\n'",
    "/c/ProgramData/anaconda3",
    "/c/ProgramData/anaconda3/Scripts",
    "/usr/bin",
    "/c/Python27",
    "$ which -a python",
    "/c/ProgramData/anaconda3/python",
    "/c/Python27/python",
  )

  #legende[
    Extrait d'un poste où un Python 2.7 est aussi installé. `tr` affiche un dossier
    par ligne ; `which -a` liste tous les fichiers trouvés. Si aucun dossier ne
    contient la commande, Git Bash répond `command not found`.
  ]

  #notes[
    Reprend `which python` du cours 1 et du TD 1c : `python` désigne le premier
    fichier de ce nom. Depuis le TD 1c, Git Bash active conda à l'ouverture, d'où
    `anaconda3` en tête.

    `echo` affiche un texte ; `|` envoie ce texte à la commande suivante.

    Un nom qui contient un `/` est lancé directement (manuel de bash, « Command
    Search and Execution ») : d'où `./altitudes.exe` au cours 1, et le chemin
    complet de `python.exe`.

    Essayé le 05/11/2026 sous Linux, `env -i` vidant `PATH` :
    `python: command not found`.
  ]
]

// --------------------------------------------
// Reprise de la partie 4 du cours 1 de 2026 le 05/11/2026 : la diapositive explique ce
// que fait l'activation, et s'appuie donc sur la précédente.
#d("Ce que l'activation d'un environnement change")[
  #annonce[
    Activer un environnement n'installe rien et ne déplace rien : cela pose ses
    dossiers en tête de la liste où le terminal cherche les commandes.
  ]

  #schema-path()

  #legende[
    `conda activate recette` place de même les dossiers de `envs/recette` en tête.
    Sous macOS et Linux, `…/envs/recette/bin` passe devant `/usr/bin`.
  ]

  #notes[
    Répond à une question qui revient tout le semestre : `python` change selon le
    terminal. Le mot `python` désigne le premier fichier de ce nom trouvé dans la
    liste.

    Conséquence : `conda install` pose le paquet dans l'environnement actif, et un
    terminal ouvert avant l'activation ne le verra pas, d'où un
    `ModuleNotFoundError` sur un paquet « qu'on vient d'installer ».

    Deuxième conséquence : désactiver ne désinstalle rien, cela retire le
    dossier de la tête de la liste.

    La colonne de droite reprend la diapositive précédente. Sous Windows, `python.exe`
    est à la racine de l'environnement, et l'activation ajoute aussi
    `…\envs\recette\Scripts` et `Library\bin`, non montrés.
  ]
]

// --------------------------------------------
#d("Variables d'environnement : portée")[
  #annonce[
    Une variable créée dans un terminal reste dans ce terminal. `export` en fait une
    variable d'environnement, et un fichier de démarrage la pose à chaque ouverture.
  ]

  #show table.cell: set text(size: 15pt)
  #show raw: set text(size: 1.15em)
  #grid(
    columns: (1.5fr, 1fr), column-gutter: 16pt, align: top,
    tableau(
      columns: (auto, 1fr),
      align: left + horizon,
      inset: (x: 8pt, y: 5pt),
      [Où l'écrire], [Elle vaut pour],
      [`CLE_API=abc python carte.py`], [cette commande],
      [`NOM=alice`], [ce terminal seulement],
      [`export NOM=alice`], [ce terminal et ses programmes],
      [une ligne `export` dans `~/.bash_profile`], [chaque nouveau terminal],
    ),
    terminal(
      taille: 16pt,
      "$ NOM=alice",
      "$ bash -c 'echo \"[$NOM]\"'",
      "[]",
      "$ export NOM",
      "$ bash -c 'echo \"[$NOM]\"'",
      "[alice]",
    ),
  )

  #legende[
    Dans le terminal de droite, `bash -c` lance un second programme bash. Au TD 1c,
    `conda init bash` a écrit dans `~/.bash_profile`.
  ]

  #notes[
    MIT, _The Missing Semester_, « Command-line Environment » : `~/.bashrc` et
    `~/.bash_profile` contiennent les commandes à lancer au démarrage, comme une
    modification de `PATH` : `export PATH="$PATH:/chemin/vers/programme/bin"`.

    Une variable modifiée par un programme ne revient pas au terminal qui l'a
    lancé : la transmission va du parent vers ses enfants.
  ]
]

// --------------------------------------------
#d("Variables d'environnement : lecture en Python")[
  #annonce[
    `os.environ` donne au programme les variables qu'il a reçues. `subprocess.run`
    les transmet au programme lancé.
  ]

  #grid(
    columns: (1.35fr, 1fr), column-gutter: 16pt, align: top,
    panneau[`carte.py`][
      #set text(size: 15pt)
      ```python
      import os
      import subprocess

      commande = ["bash", "-c", 'echo "bash : $CLE_API"']
      subprocess.run(commande, check=True)
      print("Python :", os.environ.get("CLE_API", "absente"))
      ```
    ],
    panneau[Deux lancements][
      #terminal(
        taille: 15pt,
        "$ python carte.py",
        "bash :",
        "Python : absente",
        "$ CLE_API=abc python carte.py",
        "bash : abc",
        "Python : abc",
      )
    ],
  )

  #legende[
    Sorties réelles. `os.environ["CLE_API"]` lève un `KeyError` si la variable est
    absente. Au cours 6, cette lecture garde un secret hors du code.
  ]

  #notes[
    Essayé le 05/11/2026 sous Linux, Python 3.12.

    `'echo "bash : $CLE_API"'` est un seul élément de la liste : `bash -c` reçoit tout
    le texte à exécuter comme un seul argument.

    `subprocess` passe avant `print` dans `carte.py` : quand la sortie n'est pas une
    console, Python garde son texte en mémoire jusqu'à la fin, et l'ordre des deux
    lignes changerait.
  ]
]
