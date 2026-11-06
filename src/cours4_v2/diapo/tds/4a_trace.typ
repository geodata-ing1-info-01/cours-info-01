// TD 4a du cours 4 v2 — « Un script Python, pas à pas », pour tous les élèves.
//
// Refait le 05/11/2026 sur la trace GPS des cours 1 à 3 : même plan que le TD 4a
// de 2026 (`src/cours4/diapo/tds/4a_recette.typ`), partie A pour le projet, partie B
// pour le programme. Le programme ajoute la distance parcourue et la vitesse
// moyenne à `altitudes.py` du TD 3c, renommé `stats_trace.py`.
//
// Deux changements de forme. Une option s'ajoute d'abord sans son calcul, puis avec
// des affichages provisoires, retirés quand le résultat est juste : chaque étape se
// teste en lançant le programme, sans tests unitaires. Les diapositives donnent
// l'objectif, les consignes et le test ; la solution d'une étape de programmation
// est dans la troisième partie du guide.
//
// La sortie attendue d'un test reste visible hors du corrigé : sans elle, l'élève ne
// peut pas tester (STYLE.md, « un attendu décrit un résultat visible »).
//
// Programme, corrigés et guide : `data/cours4_v2/generer_4a.py`, qui exécute chaque
// version. Sorties relevées sur ces versions, Python 3.12.
//
// Inclus par `cours4_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 4_v2`.
#import "../../../commun/prelude.typ": *
#import "../../../cours3/diapo/schemas.typ": arborescence, code-commente, sortie
#import "../../../cours1_v2/diapo/schemas.typ": consignes, terminal, terminal-etapes, etape-terminal
#import "../schemas_trace.typ": schema-segments

#let td = (
  numero: "4a",
  titre: "Un script Python, pas à pas",
  annonce: "TD d'application des cours 1 à 3 : créer et versionner le dossier d'un projet, puis ajouter à un programme le calcul de la distance et de la vitesse sur une trace GPS, avec un test et un commit par étape",
  dossier: "cours4/4a_trace/",
  duree: "30′ + 75′",
)
#separateur-td(..td)

// La sortie attendue d'une étape. `taille` est celle de `terminal` (cours 1 v2) : le
// texte affiché est plus petit, et 18 pt tient dans la colonne de droite.
#let test(titre: [Test], taille: 18pt, ..lignes) = panneau(titre, terminal(taille: taille, ..lignes))

// Le commit qui termine une étape, sous le test : deux commandes, comme au TD 2c
#let commit(message) = panneau[Commit][
  #block(above: 0pt, text(size: 17pt, stack(
    spacing: 5pt, raw("git add stats_trace.py"), raw("git commit -m \"" + message + "\""),
  )))
]

// Les commandes parmi lesquelles chercher
#let commandes-possibles(..cellules) = panneau[Commandes possibles][
  #show table.cell: set text(size: 14pt)
  #show raw: set text(size: 1.15em)
  #tableau(entete: false, columns: (auto, 1fr), align: left + horizon, ..cellules)
]

// Une diapositive d'étape : les consignes à gauche, le test ou les commandes à droite
#let deux-colonnes(gauche, droite) = grid(
  columns: (1fr, 1.05fr), column-gutter: 16pt, align: top, gauche, droite,
)

// --------------------------------------------
#d("Objectif du TD")[
  #annonce[
    Ajouter à un script d'analyse de trace GPS le calcul de la distance parcourue et de
    la vitesse moyenne. Le script calcule pour l'instant les altitudes extrêmes et le
    dénivelé cumulé.
  ]

  #grid(
    columns: (0.8fr, 1fr), column-gutter: 14pt, align: top,
    panneau[La trace GPS : `trace.csv`][
      #set block(spacing: 0pt)
      #sortie("X,Y,ele,time\n670307.7,6812407.3,79.6,2026/10/04 08:00:00+00\n670295.1,6812393.4,78.8,2026/10/04 08:00:30+00\n670319.7,6812356.2,79.9,2026/10/04 08:01:00+00\n…\n671847.8,6812231.5,127.7,2026/10/04 08:29:30+00", taille: 9.5pt)
    ],
    stack(
      spacing: 10pt,
      test(
        titre: [Au départ : `altitudes.py` du TD 3c, renommé `stats_trace.py`],
        "$ python stats_trace.py trace.csv",
        "altitude minimale : 78.8 m",
        "…",
        "cumul en baisse : 50.3 m",
      ),
      test(
        titre: [À la fin du TD],
        "$ python stats_trace.py trace.csv --distance --vitesse",
        "…",
        "cumul en baisse : 50.3 m",
        "distance parcourue : 1906.7 m",
        "vitesse moyenne : 1.08 m/s, soit 3.9 km/h",
      ),
    ),
  )

  #legende[
    `X`, `Y` : Lambert-93, en mètres. `ele` : altitude, en mètres. `time` : date et heure UTC.
  ]

  #notes[
    Marche simulée sur un chemin des gorges de Franchard, en forêt de Fontainebleau. Chemin
    et altitudes de l'IGN, vitesse et bruit simulés :
    `data/cours3_v2/traces/fabriquer_traces.py`. `trace_2.csv` : de la gare de
    Noisy-Champs à Geodata Paris.
  ]
]

// --------------------------------------------
#d("Le guide et le matériel de départ")[
  #annonce[
    Le guide du TD a trois parties : la présentation, l'énoncé de chaque étape, puis
    les solutions.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Fichier], [Emplacement], [Usage],
    [`guide_4a_trace.pdf`, `.html`, `guide.ipynb`], [`cours4/4a_trace/`], [l'énoncé et les solutions, le code à copier],
    [`stats_trace.py`], [`depart/`], [le programme de départ, avec deux erreurs de syntaxe à corriger],
    [`trace.csv`, `trace_2.csv`], [`depart/`], [deux traces GPS, de 60 et 50 positions],
    [`README.md`], [`depart/modeles/`], [un modèle de README à adapter et compléter (étape B7)],
  )

  #notes[
    Copié depuis le PDF, le code perd ses indentations : copier depuis la page HTML.

    Écrire le code à partir de l'énoncé, lancer le test, puis lire la solution. La
    solution sert à vérifier, ou à avancer si l'essai n'aboutit pas.
  ]
]

// --------------------------------------------
#d("Les étapes du TD")[
  #tableau(
    columns: (auto, 1fr, 1.2fr),
    align: (center + horizon, left + horizon, left + horizon),
    [Étape], [Objectif], [Résultat],
    [A1-A3], [préparer le projet : dossier, éditeur, dépôt], [un dépôt git avec un commit initial],
    [B1], [lire un message d'erreur et corriger], [le script affiche les altitudes et le dénivelé],
    [B2], [ajouter l'option `--distance`, sans le calcul], [le script affiche `distance : calcul manquant`],
    [B3], [lire les positions de la trace], [le script affiche `positions lues : 61`],
    [B4], [écrire la fonction `distance_entre`], [le script affiche `premier segment : 36.2 m`],
    [B5], [écrire la fonction `distance_parcourue`], [le script affiche `distance parcourue : 1906.7 m`],
    [B6], [ajouter l'option `--vitesse`], [le script affiche `vitesse moyenne : 1.08 m/s`],
  )

  #legende[
    Commande de test : `python stats_trace.py trace.csv --distance` aux étapes B2 à B5,
    `--vitesse` à l'étape B6.
  ]

  #notes[
    Un commit à la fin de chaque étape. L'étape B7, en bonus : un README et une
    étiquette git.

    Déroulé, à annoncer à l'oral : présentation, 5 min ; partie A (créer le dossier du
    projet dans le terminal, l'ouvrir dans VS Code, créer le dépôt git), 30 min ;
    partie B (construire un script Python, avec un commit git à la fin de chaque étape),
    75 min. Il reste 10 minutes de marge.

    Le guide, dans le dossier du TD, détaille chaque étape : le faire ouvrir dès le
    début.
  ]
]

// --------------------------------------------
#d("Méthode de travail : un test à chaque étape")[
  #annonce[
    À la fin de chaque étape, le programme s'exécute sans erreur. Un affichage
    provisoire montre une valeur intermédiaire, et il est retiré quand le résultat
    final est juste.
  ]

  #chaine(
    ([Écrire], "le code de l'étape, dans VS Code"),
    ([Enregistrer], "Ctrl + S"),
    ([Lancer le script], "avec la commande de test"),
    ([Comparer], "la sortie à celle de l'énoncé"),
    ([Faire le commit], "git add, puis git commit"),
  )

  #v(0.5em)
  #test(
    titre: [Exemple : la fin de l'étape B2],
    "$ python stats_trace.py trace.csv --distance",
    "…",
    "distance : calcul manquant",
    "$ git add stats_trace.py",
    "$ git commit -m \"L'option --distance, sans le calcul\"",
    "…",
  )

  #notes[
    Pourquoi cet ordre : une erreur se trouve dans les quelques lignes écrites depuis
    le dernier test. Pas de tests unitaires à ce niveau.

    Méthode et vocabulaire : développement incrémental et « scaffolding », Downey,
    _Think Python_, section 5.2, sur le même calcul de distance et le même essai
    (triangle 3, 4, 5) :
    #link("https://greenteapress.com/thinkpython/html/chap05.html")[greenteapress.com/thinkpython/html/chap05.html].
  ]
]

// --------------------------------------------
#d("Aide-mémoire : commandes git")[
  #annonce[
    Les commandes se tapent dans le terminal Git Bash de VS Code, dans
    `travail/stats_trace/`.
  ]

  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [`git status`], [les fichiers modifiés depuis le dernier commit],
    [`git diff`], [les lignes modifiées ; `q` pour quitter],
    [`git add stats_trace.py`], [ajoute le fichier au prochain commit],
    [`git commit -m "…"`], [enregistre le commit, avec ce message],
    [`git log --oneline`], [l'historique, une ligne par commit],
    [`git restore stats_trace.py`], [remet le fichier dans l'état du dernier commit],
  )
]

// --------------------------------------------
#d("Les supports en ligne")[
  #annonce[
    Le site du module donne les pages de cours, les guides des TD et les
    archives des séances. Il est en cours d'écriture : des pages manquent ou
    changent d'une semaine à l'autre.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Page], [Contenu],
    [#link("https://geodata-ing1-info-01.github.io/cours-info-01/")[geodata-ing1-info-01.github.io/cours-info-01]], [l'accueil : une page par séance, avec ses TD],
    [#link("https://geodata-ing1-info-01.github.io/cours-info-01/cours4/index.html")[…/cours4/index.html]], [la séance 4 : le guide du TD 4a],
    [#link("https://geodata-ing1-info-01.github.io/cours-info-01/telechargements/index.html")[…/telechargements/]], [une archive par séance, les fichiers des TD],
  )

  #notes[
    Le guide en ligne est le même que celui de l'archive. Copier le code
    depuis la page HTML.
  ]
]

// --------------------------------------------
#d("Étape A1 · Dossier du projet")[
  #objectif[
    créer le dossier du projet par des commandes, en copiant les fichiers livrés.
  ]

  #deux-colonnes(
    consignes(
      taille: 16pt,
      [Copier l'archive `info01-cours4.zip` de `formationTemp` dans le dossier `info01` du Bureau.],
      [Ouvrir Git Bash depuis le menu Démarrer.],
      [Aller dans le dossier `~/Desktop/info01`, puis décompresser l'archive.],
      [Aller dans le dossier du TD, `cours4/4a_trace`.],
      [Créer le dossier du projet, `travail/stats_trace`.],
      [Copier `depart/stats_trace.py` dans ce dossier.],
      [Copier les deux traces de `depart/` dans ce dossier, en une seule commande, avec le motif `*.csv`.],
    ),
    commandes-possibles(
      [`cd dossier`], [entre dans le dossier],
      [`mkdir nom`], [crée un dossier],
      [`ls dossier`], [liste le contenu du dossier],
      [`cp source destination`], [copie un fichier],
      [`unzip archive.zip`], [décompresse l'archive],
      [`*.csv`], [tous les fichiers en `.csv`],
    ),
  )

  #notes[
    Laisser chercher avant de passer à la solution.

    Erreur fréquente : `cp` lancé depuis `travail/`. `pwd` montre le dossier
    courant, qui doit être `4a_trace/`.
  ]
]

// --------------------------------------------
#d("Étape A1 : solution")[
  #grid(
    columns: (1.9fr, 1fr), column-gutter: 16pt, align: top,
    terminal-etapes(
      taille: 18pt,
      etape-terminal("cd ~/Desktop/info01", "unzip info01-cours4.zip", numero: 3),
      etape-terminal("cd cours4/4a_trace", numero: 4),
      etape-terminal("mkdir travail/stats_trace", numero: 5),
      etape-terminal("cp depart/stats_trace.py travail/stats_trace/", numero: 6),
      etape-terminal("cp depart/*.csv travail/stats_trace/", numero: 7),
      etape-terminal("ls travail/stats_trace", numero: "test",
        constat: [`mkdir` et `cp` n'affichent rien quand ils réussissent.]),
    ),
    arborescence(
      (0, "4a_trace/"),
      (1, "depart/"),
      (2, "stats_trace.py"),
      (2, "trace.csv"),
      (2, "trace_2.csv"),
      (1, "travail/"),
      (2, text(fill: attention)[stats_trace/], "le projet"),
      (3, text(fill: attention)[stats_trace.py]),
      (3, text(fill: attention)[trace.csv]),
      (3, text(fill: attention)[trace_2.csv]),
    ),
  )

  #legende[
    Si `cp` affiche `No such file or directory`, relire le chemin : la touche `Tab`
    complète les noms de dossiers et de fichiers.
  ]
]

// --------------------------------------------
#d("Étape A2 · Projet dans VS Code")[
  #objectif[
    ouvrir le dossier du projet dans VS Code, avec un terminal Git Bash dans ce dossier.
  ]

  #consignes(
    taille: 16pt,
    [Lancer VS Code depuis le menu Démarrer.],
    [Ouvrir le dossier du projet : menu File, Open Folder…, `Desktop\info01\cours4\4a_trace\travail\stats_trace`, puis « Sélectionner un dossier ».],
    [Ouvrir un terminal : menu Terminal, New Terminal.],
    [Dans l'explorateur de VS Code, à gauche, ouvrir `stats_trace.py`. Chaque espace du code apparaît comme un point gris, et chaque tabulation comme une flèche.],
  )

  #v(0.4em)
  #test(
    titre: [Test : l'invite du terminal],
    taille: 17pt,
    "(base)",
    "eleve@POSTE MINGW64 ~/Desktop/info01/cours4/4a_trace/travail/stats_trace",
    "$",
  )

  #legende[
    Si l'invite ou l'affichage diffèrent, la solution de l'étape A2, dans le guide,
    donne le réglage à refaire.
  ]

  #notes[
    Les réglages datent du TD 2a. Sans `(base)` :
    `source /c/ProgramData/anaconda3/etc/profile.d/conda.sh`, puis `conda init bash`,
    puis un nouveau terminal.

    L'affichage des espaces sert à l'étape B1 (tabulation).
  ]
]

// --------------------------------------------
#d("Étape A3 · Dépôt git")[
  #objectif[
    enregistrer l'état de départ du projet dans un premier commit.
  ]

  #deux-colonnes(
    consignes(
      taille: 16pt,
      [Dans le terminal de VS Code, créer le dépôt dans le dossier du projet.],
      [Indiquer son nom et son adresse électronique, pour ce dépôt seulement.],
      [Dans l'explorateur de VS Code, créer un fichier nommé `.gitignore` (icône New File), y écrire la ligne `resume.txt`, puis enregistrer (`Ctrl` + `S`).],
      [Afficher l'état du dépôt.],
      [Faire le premier commit, avec tous les fichiers et le message `Le programme de départ et les traces`.],
      [Afficher l'historique.],
    ),
    commandes-possibles(
      [`git init`], [crée le dépôt],
      [`git add .`], [ajoute les fichiers au prochain commit],
      [`git config user.name "…"`], [le nom, pour ce dépôt ; de même `user.email`],
      [`git commit -m "…"`], [enregistre le commit],
      [`git status`], [l'état du dépôt],
      [`git log --oneline`], [l'historique],
    ),
  )

  #notes[
    `resume.txt` : modifié par le programme à chaque lancement (TD 3c), donc pas
    versionné.

    Vérifier que le dépôt est dans `travail/stats_trace/` : `git status` y liste
    `trace.csv`.
  ]
]

// --------------------------------------------
#d("Étape A3 : solution")[
  #terminal-etapes(
    taille: 18pt,
    etape-terminal("git init", numero: 1),
    etape-terminal("git config user.name \"Prénom Nom\"", "git config user.email \"prenom.nom@exemple.fr\"", numero: 2),
    etape-terminal("git status", numero: 4,
      constat: [Quatre entrées non suivies : `.gitignore`, `stats_trace.py`, `trace.csv`, `trace_2.csv`.]),
    etape-terminal("git add .", "git commit -m \"Le programme de départ et les traces\"", numero: 5),
    etape-terminal("git log --oneline", numero: 6),
  )

  #legende[
    Test : `git log --oneline` affiche une ligne. Le poste est partagé : le nom et
    l'adresse sont réglés pour ce dépôt seulement, sans #box[`--global`].
  ]
]

// --------------------------------------------
#d("Étape B1 · Correction du programme de départ")[
  #objectif[
    lire un message d'erreur de Python et corriger la ligne qu'il désigne. Le programme de départ
    contient deux erreurs.
  ]

  #deux-colonnes(
    consignes(
      taille: 16pt,
      [Dans le terminal, lancer le programme : `python stats_trace.py trace.csv`.],
      [Lire le message d'erreur. Il donne le fichier et le numéro de la ligne, recopie la ligne, puis nomme l'erreur.],
      [Dans VS Code, corriger cette ligne, puis enregistrer le fichier (`Ctrl` + `S`).],
      [Faire le commit de la correction, avec un message qui la décrit.],
      [Relancer le programme, puis refaire les consignes 2 à 4 sur la seconde erreur.],
    ),
    stack(
      spacing: 10pt,
      test(
        "$ python stats_trace.py trace.csv",
        "altitude minimale : 78.8 m",
        "altitude maximale : 129.5 m",
        "max - min : 44.7 m",
        "cumul en hausse : 98.4 m",
        "cumul en baisse : 50.3 m",
      ),
      commit("Correction : …"),
    ),
  )

  #legende[
    Solution : guide, étape B1.
  ]

  #reponse(legende[
    Constaté : deux erreurs, l'une après l'autre ; Python s'arrête sur la
    première qu'il rencontre.
  ])

  #notes[
    Faire lire le message à voix haute : fichier, ligne, ligne recopiée, nom de
    l'erreur.

    Ligne 18 : `:` manquant. Ligne 20 : deux tabulations au lieu de huit espaces. Les
    mêmes erreurs qu'au TD 2b.

    Avant chaque commit, `git diff` montre la ligne modifiée.
  ]
]

// --------------------------------------------
#d("Étape B2 · Option de distance")[
  #objectif[
    ajouter l'option `--distance`, qui affiche pour l'instant un message. Le calcul est écrit aux
    étapes B3 à B5, qui se testent avec la même commande.
  ]

  #deux-colonnes(
    consignes(
      taille: 16pt,
      [Dans `stats_trace.py`, avant la ligne `options = analyseur.parse_args()`, déclarer l'option #box[`--distance`], avec `action="store_true"` et le texte d'aide `affiche la distance parcourue`.],
      [À la fin du fichier, ajouter le bloc `if options.distance:`, qui affiche `distance : calcul manquant`.],
      [Enregistrer le fichier, puis lancer le test, avec puis sans #box[`--distance`].],
    ),
    stack(
      spacing: 10pt,
      test(
        "$ python stats_trace.py trace.csv --distance",
        "altitude minimale : 78.8 m",
        "…",
        "cumul en baisse : 50.3 m",
        "distance : calcul manquant",
      ),
      commit("L'option --distance, sans le calcul"),
    ),
  )

  #legende[
    Sans `--distance`, le message n'apparaît pas. `python stats_trace.py --help` décrit
    l'option. Solution : guide, étape B2.
  ]

  #notes[
    `store_true` est nouveau : `--seuil` (TD 3b) prenait une valeur.

    Message sans accent, comme tous les affichages du programme : selon le terminal,
    Python n'écrit pas les accents de la même façon.
  ]
]

// --------------------------------------------
#d("Étape B3 · Positions de la trace")[
  #objectif[
    garder les colonnes `x` et `y` de la trace dans deux listes, et contrôler les valeurs lues.
  ]

  #deux-colonnes(
    consignes(
      taille: 16pt,
      [Sous la ligne `altitudes = []`, créer deux listes vides, `liste_x` et `liste_y`.],
      [Dans la boucle de lecture, sous la ligne `altitudes.append(float(ele))`, convertir `x` et `y` en nombres avec `float`, puis les ajouter à `liste_x` et à `liste_y`.],
      [Dans le bloc `if options.distance:`, au-dessus du message, afficher provisoirement les deux lignes du test, avec `len(liste_x)`, `liste_x[0]` et `liste_y[0]`.],
      [Enregistrer le fichier, puis lancer le test.],
    ),
    stack(
      spacing: 10pt,
      test(
        "$ python stats_trace.py trace.csv --distance",
        "…",
        "positions lues : 60",
        "position 0 : 670307.7 6812407.3",
        "distance : calcul manquant",
      ),
      commit("Les positions de la trace"),
    ),
  )

  #legende[
    Ouvrir `trace.csv` dans VS Code, puis vérifier que la ligne 2 commence par
    `670307.7,6812407.3`. Solution : guide, étape B3.
  ]

  #notes[
    Erreur fréquente : les deux `append` hors de la boucle, `positions lues : 1`.

    Le test ne détecte pas un `float` oublié, car un texte s'affiche comme le nombre.
    L'erreur apparaît à l'étape B4.
  ]
]

// --------------------------------------------
#d("Distance parcourue : la somme des segments")[
  #annonce[
    Deux positions successives forment un *segment*. La distance parcourue est la
    somme des longueurs des segments.
  ]

  #schema-segments()

  #legende[
    Les cinq premières positions de `trace.csv`, à l'échelle. La longueur d'un segment
    est l'hypoténuse d'un triangle rectangle : √((x2 − x1)² + (y2 − y1)²).
  ]

  #notes[
    Les coordonnées Lambert-93 sont en mètres : la formule s'applique directement.
    La distance ne tient pas compte de l'altitude.

    Valeurs de la figure : les cumuls affichés à l'étape B5, 18.8, 63.4, 105.6, 140.9.
  ]
]

// --------------------------------------------
#d("Écriture d'une fonction Python")[
  #annonce[
    `len` et `min` sont des fonctions fournies par Python. `def` permet d'en écrire de
    nouvelles, avant leur premier appel, car Python exécute le fichier de haut en bas.
  ]

  #code-commente(
    ("def ecart(a, b):", "déclare la fonction et ses deux paramètres"),
    ("    \"\"\"La différence entre deux valeurs.\"\"\"", "décrit la fonction"),
    ("    return b - a", "le corps est indenté ; `return` renvoie le résultat"),
    ("", ""),
    ("resultat = ecart(79.6, 103.2)", "appelle la fonction : `a` reçoit `79.6`, `b` reçoit `103.2`"),
    ("print(f\"ecart : {resultat:.1f} m\")", "affiche `ecart : 23.6 m`"),
  )

  #notes[
    Les cours 1 à 3 v2 ne montrent pas `def` : présenter cette diapositive à l'oral.

    Le TD 4a est aussi le premier où l'élève compose du code : aux TD 3a à 3c, le code
    était donné à coller.
  ]
]

// --------------------------------------------
#d("Étape B4 · Fonction distance_entre")[
  #objectif[
    écrire `distance_entre(x1, y1, x2, y2)`, qui renvoie la distance entre deux points.
  ]

  #consignes(
    taille: 17pt,
    [En tête de `stats_trace.py`, ajouter la ligne `import math`.],
    [Sous les lignes `import`, déclarer la fonction `distance_entre(x1, y1, x2, y2)`.],
    [Dans la fonction, renvoyer avec `return` la distance √((x2 − x1)² + (y2 − y1)²).],
  )

  #legende[
    `3 ** 2` vaut `9`. `math.sqrt(9)` vaut `3.0`.
  ]

  #notes[
    `import math` : bibliothèque standard, comme `argparse`.

    Erreurs fréquentes, messages réels, à la diapositive suivante.
  ]
]

// --------------------------------------------
#d("Étape B4 · Essai de la fonction")[
  #objectif[
    essayer la fonction sur un cas dont le résultat est connu, puis sur les deux premières
    positions de la trace.
  ]

  #deux-colonnes(
    consignes(
      taille: 16pt,
      [Dans le bloc `if options.distance:`, retirer les deux affichages de l'étape B3.],
      [À leur place, afficher provisoirement `distance_entre(0, 0, 3, 4)`, comme sur le test.],
      [Sous cette ligne, garder dans `premier_segment` la distance entre les positions 0 et 1, puis l'afficher avec un chiffre après la virgule.],
      [Enregistrer le fichier, puis lancer le test.],
    ),
    stack(
      spacing: 10pt,
      test(
        "$ python stats_trace.py trace.csv --distance",
        "…",
        "essai, 5.0 attendu : 5.0",
        "premier segment : 18.8 m",
        "distance : calcul manquant",
      ),
      commit("La fonction distance_entre"),
    ),
  )

  #legende[
    Le triangle de côtés 3 et 4 a une hypoténuse de longueur 5. Solution : guide,
    étape B4.
  ]

  #notes[
    Erreurs fréquentes, messages réels :

    `NameError: name 'distance_entre' is not defined` : fonction écrite après l'appel.

    `NameError: name 'math' is not defined. Did you mean: 'Path'? Or did you forget to
    import 'math'?` : `import math` absent.

    `essai, 5.0 attendu : None`, puis `TypeError: unsupported format string passed to
    NoneType.__format__` : `return` absent.

    `TypeError: unsupported operand type(s) for -: 'str' and 'str'` : `float` oublié à
    l'étape B3.
  ]
]

// --------------------------------------------
#d("Étape B5 · Fonction distance_parcourue")[
  #objectif[
    additionner les longueurs des segments. La position 0 n'a pas de position précédente : la
    boucle commence donc à `i = 1`.
  ]

  #consignes(
    taille: 16pt,
    [Sous `distance_entre`, déclarer la fonction `distance_parcourue(liste_x, liste_y)`.],
    [Dans la fonction, créer la variable `total`, qui vaut 0.],
    [Écrire la boucle : `for i in range(1, len(liste_x)):`.],
    [Dans la boucle, appeler `distance_entre` avec `liste_x[i - 1]`, `liste_y[i - 1]`, `liste_x[i]` et `liste_y[i]`, et garder le résultat dans la variable `segment`.],
    [Dans la boucle, ajouter `segment` à `total`.],
    [Dans la boucle, afficher provisoirement `i` et `total`, comme sur le test de la diapositive suivante.],
    [Après la boucle, au niveau de la ligne `for`, renvoyer `total` avec `return`.],
  )

  #notes[
    Passage le plus difficile du TD : une fonction qui appelle une autre fonction.
    Passer dans les rangs.

    Erreur fréquente : `return` indenté dans la boucle ; la fonction s'arrête après le
    premier segment, `distance parcourue : 18.8 m`.
  ]
]

// --------------------------------------------
#d("Étape B5 · Appel de la fonction")[
  #objectif[
    contrôler le total après chaque segment.
  ]

  #deux-colonnes(
    consignes(
      taille: 16pt,
      [Dans le bloc `if options.distance:`, retirer tout le contenu.],
      [À la place, écrire `distance = distance_parcourue(liste_x, liste_y)`.],
      [Afficher le résultat, comme sur la dernière ligne du test, avec un chiffre après la virgule.],
      [Enregistrer le fichier, puis lancer le test.],
    ),
    test(
      "$ python stats_trace.py trace.csv --distance",
      "…",
      "position 1, cumul : 18.8",
      "position 2, cumul : 63.4",
      "…",
      "position 59, cumul : 1906.7",
      "distance parcourue : 1906.7 m",
    ),
  )

  #legende[
    La première valeur est celle du premier segment, à l'étape B4. Si la sortie s'arrête
    à `position 1`, le `return` est dans la boucle.
  ]
]

// --------------------------------------------
#d("Étape B5 · Résultat final")[
  #objectif[
    retirer l'affichage provisoire, une fois les valeurs contrôlées.
  ]

  #deux-colonnes(
    consignes(
      taille: 16pt,
      [Retirer le `print` de la boucle, puis enregistrer le fichier.],
      [Lancer le test sur `trace.csv`, puis sur `trace_2.csv`.],
    ),
    stack(
      spacing: 10pt,
      test(
        "$ python stats_trace.py trace.csv --distance",
        "…",
        "distance parcourue : 1906.7 m",
        "$ python stats_trace.py trace_2.csv --distance",
        "…",
        "distance parcourue : 632.3 m",
      ),
      commit("Le calcul de la distance parcourue"),
    ),
  )

  #legende[
    La trace compte 59 segments d'environ 32 m, et 59 × 32 = 1888 : le résultat a le
    bon ordre de grandeur. Solution : guide, étape B5.
  ]
]

// --------------------------------------------
#d("Étape B6 · Option de vitesse")[
  #objectif[
    ajouter l'option `--vitesse`, dans le même ordre que pour la distance : l'option, le calcul
    intermédiaire, puis le résultat.
  ]

  #deux-colonnes(
    consignes(
      taille: 16pt,
      [Avant la ligne `options = analyseur.parse_args()`, déclarer l'option #box[`--vitesse`], avec le texte d'aide `affiche la vitesse moyenne`.],
      [À la fin du fichier, ajouter le bloc `if options.vitesse:`, qui affiche `vitesse : calcul manquant`.],
      [Enregistrer le fichier, puis lancer le test.],
    ),
    test(
      "$ python stats_trace.py trace.csv --vitesse",
      "…",
      "cumul en baisse : 50.3 m",
      "vitesse : calcul manquant",
    ),
  )
]

// --------------------------------------------
// Nouveau, 06/11/2026 : la colonne `time` remplace la durée en secondes. La fonction
// `secondes_ecoulees` prend la place de `vitesse_moyenne`, qui ne faisait qu'une
// division. Sortie exécutée, Python 3.12.
#d("Dates et durées : le module datetime")[
  #annonce[
    Le module `datetime` fait partie de la bibliothèque standard, livrée avec Python. Il
    convertit un texte en date, et la différence de deux dates donne une durée.
  ]

  #code-commente(
    ("from datetime import datetime", "s'importe sans installation"),
    ("FORMAT_TEMPS = \"%Y/%m/%d %H:%M:%S+00\"", "décrit le texte de la colonne `time`"),
    ("", ""),
    ("debut = datetime.strptime(\"2026/10/04 08:00:00+00\", FORMAT_TEMPS)", "convertit le texte en date"),
    ("fin = datetime.strptime(\"2026/10/04 08:00:30+00\", FORMAT_TEMPS)", ""),
    ("print((fin - debut).total_seconds())", "affiche `30.0`, la durée en secondes"),
  )

  #legende[
    `%Y` : année. `%m` : mois. `%d` : jour. `%H`, `%M`, `%S` : heure, minutes, secondes.
    `+00` : heure UTC, écrit tel quel dans le format. Documentation :
    docs.python.org/fr/3/library/datetime.html.
  ]

  #notes[
    Rappel : « Bibliothèque standard de Python », cours 3.

    Python 3.12 : `%z` refuse `+00`, et `fromisoformat` refuse les `/`.

    Ce format de date est celui qu'écrit `ogr2ogr`, au cours 5.
  ]
]

// --------------------------------------------
#d("Étape B6 · Fonction secondes_ecoulees")[
  #objectif[
    écrire `secondes_ecoulees(debut, fin)`, qui renvoie le temps en secondes entre deux valeurs de
    la colonne `time`.
  ]

  #deux-colonnes(
    consignes(
      taille: 14pt,
      [Sous la ligne `import math`, ajouter la ligne `from datetime import datetime`.],
      [Sous les lignes `import`, ajouter la ligne `FORMAT_TEMPS = "%Y/%m/%d %H:%M:%S+00"`.],
      [Sous `distance_parcourue`, déclarer la fonction `secondes_ecoulees(debut, fin)`.],
      [Dans la fonction, convertir `debut` et `fin` en dates, puis renvoyer le temps qui les sépare, en secondes.],
      [Dans le bloc `if options.vitesse:`, au-dessus du message, afficher provisoirement le résultat sur les deux valeurs ci-dessous.],
      [Enregistrer le fichier, puis lancer le test.],
    ),
    test(
      "$ python stats_trace.py trace.csv --vitesse",
      "…",
      "essai, 30.0 attendu : 30.0",
      "vitesse : calcul manquant",
    ),
  )

  #legende[
    Les deux valeurs de l'essai : `"2026/10/04 08:00:00+00"` et `"2026/10/04 08:00:30+00"`.
  ]

  #notes[
    Exercice le moins guidé de l'étape : l'élève adapte l'exemple de la diapositive
    précédente. Si le temps manque, donner la fonction : aucune autre étape n'en dépend.
  ]
]

// --------------------------------------------
#d("Étape B6 · Temps total")[
  #objectif[
    calculer le temps total, entre la première et la dernière valeur de la colonne `time`.
  ]

  #deux-colonnes(
    consignes(
      taille: 16pt,
      [Sous la ligne `liste_y = []`, créer une liste vide, `temps`.],
      [Dans la boucle de lecture, ajouter `time` à `temps`, sans le convertir.],
      [Dans le bloc `if options.vitesse:`, remplacer l'essai par le calcul de `temps_total`, avec `secondes_ecoulees(temps[0], temps[-1])`, puis l'afficher provisoirement sans chiffre après la virgule (`:.0f`).],
      [Enregistrer le fichier, puis lancer le test.],
    ),
    test(
      "$ python stats_trace.py trace.csv --vitesse",
      "…",
      "temps total : 1770 s",
      "vitesse : calcul manquant",
    ),
  )

  #legende[
    `temps[-1]` désigne le dernier élément de la liste `temps`. La première position de
    `trace.csv` finit par `08:00:00+00`, et la dernière par `08:29:30+00`.
  ]
]

// --------------------------------------------
#d("Étape B6 · Vitesse moyenne")[
  #objectif[
    afficher la vitesse moyenne, la distance parcourue divisée par le temps total.
  ]

  #deux-colonnes(
    consignes(
      taille: 16pt,
      [Dans le bloc `if options.vitesse:`, retirer les deux `print`.],
      [Sous le calcul de `temps_total`, appeler `distance_parcourue`, puis diviser `distance` par `temps_total`, et garder le résultat dans la variable `vitesse`.],
      [Afficher le résultat, comme sur le test : deux chiffres après la virgule en m/s, un en km/h.],
      [Enregistrer le fichier, puis lancer le test.],
    ),
    stack(
      spacing: 10pt,
      test(
        taille: 15.5pt,
        "$ python stats_trace.py trace.csv --distance --vitesse",
        "…",
        "distance parcourue : 1906.7 m",
        "vitesse moyenne : 1.08 m/s, soit 3.9 km/h",
        "$ python stats_trace.py trace.csv --vitesse",
        "…",
        "vitesse moyenne : 1.08 m/s, soit 3.9 km/h",
      ),
      commit("L'option --vitesse"),
    ),
  )

  #legende[
    Une vitesse en m/s, multipliée par 3,6, donne des km/h. À la calculatrice,
    1906,7 / 1770 donne 1,08. Solution : guide, étape B6.
  ]

  #notes[
    `git log --oneline` : huit lignes. Fin du TD en séance ; l'étape B7 est un bonus.

    `trace_2.csv` donne `vitesse moyenne : 1.29 m/s, soit 4.6 km/h`.
  ]
]

// --------------------------------------------
#d("Étape B7 (bonus) · README et étiquette")[
  #objectif[
    permettre à une autre personne de lancer le programme, et nommer la version finale.
  ]

  #consignes(
    taille: 16pt,
    [Copier le modèle de README dans le projet : `cp ../../depart/modeles/README.md .`],
    [Ouvrir `README.md` dans VS Code et remplacer chaque passage « (À compléter …) ». `Ctrl` + `Maj` + `V` affiche l'aperçu.],
    [Coller chaque commande du README dans le terminal, et vérifier qu'elle fonctionne.],
    [Faire le commit du README : `git add README.md`, puis `git commit -m "Un README"`.],
    [Poser l'étiquette `v1.0` sur ce commit : `git tag -a v1.0 -m "Première version"`.],
    [Vérifier que `git log --oneline` affiche neuf lignes, la première marquée `tag: v1.0`.],
  )

  #legende[
    Solution : guide, étape B7.
  ]
]
