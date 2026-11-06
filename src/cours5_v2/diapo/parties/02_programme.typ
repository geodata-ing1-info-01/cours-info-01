// Partie 2 du cours 5 v2 : appeler un programme existant. Incluse par `cours5_v2.typ`.
//
// Plan du 06/11/2026 : la ligne du pseudo-code traitée, `subprocess` en général sur `git`, son
// application à `ogr2ogr`, les échecs, les chemins, puis l'installation d'un programme, sa
// recherche dans `PATH` et la portée d'une modification de cette variable. `PROJ_DATA` passe à
// `a_reprendre/environnement.typ`, et « Variables d'environnement : portée » au cours 6.
//
// L'ordre de la diapositive sur la recherche vient de deux cours : un programme lancé par son
// nom et par son chemin, puis la liste des dossiers. MIT, *The Missing Semester*, « Course
// overview + the shell » ; Eaton Lab, université Columbia, « 2.1 shell ». Niveaux système et
// compte : iTechtics, « User vs System Environment Variables », et
// `src/annexes/notions/variables_environnement.md`.
//
// Sorties relevées le 06/11/2026 sous Linux, bash 5, Python 3.12, GDAL 3.13.3. Pour l'essai,
// `outils/gdal` est un lien vers un environnement conda. La liste des dossiers de « Recherche
// d'un programme » est attendue sur un poste de la salle, et reste à relever.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../../../cours3/diapo/schemas.typ": code-commente, sortie
#import "../../../cours3_v2/diapo/schemas.typ": arborescence, script
#import "../../../cours1_v2/diapo/schemas.typ": terminal

// --------------------------------------------
#d("Appel d'un programme : étapes")[
  #grid(
    columns: (1.3fr, 1fr), column-gutter: 18pt, align: top,
    panneau("Le programme, en pseudo-code")[
      #script("importer la bibliothèque de carte\n\nlire le chemin du fichier GPX\nappeler le programme de conversion : GPX → CSV\nlire le CSV et calculer le résumé (cours 4)\nafficher le résumé\nappeler la fonction d'affichage de la carte", vives: (4,), taille: 13pt, lang: none)
    ],
    panneau("Étapes pour cette ligne")[
      #chaine-verticale(
        ecart: 2pt,
        ("Tester la commande", "dans le terminal"),
        ("Écrire l'appel", "dans le programme Python"),
        ("Vérifier que le programme est trouvé", "le système le cherche dans les dossiers de PATH"),
      )
    ],
  )

  #legende[
    En bleu, la ligne traitée dans cette partie.
  ]

  #notes[
    Reprend « Ajout des fonctionnalités : code et installations ». L'installation de l'outil :
    partie 4.
  ]
]

// --------------------------------------------
#d("subprocess : lancement d'un programme")[
  #annonce[
    La fonction `subprocess.run` lance un programme en ligne de commande depuis un
    programme Python. Elle reçoit la commande sous forme de liste : le nom du programme,
    puis ses arguments, un élément par mot.
  ]

  #tableau(
    columns: (auto, auto, auto, auto),
    align: left + horizon,
    [Dans le terminal], [`git`], [`log`], [`--oneline`],
    [Dans la liste Python], [`"git"`], [`"log"`], [`"--oneline"`],
  )

  #face-a-face(
    panneau("Dans le terminal")[
      #terminal(
        taille: 14pt,
        "$ git log --oneline",
        "8d08215 Remplace la moyenne par les altitudes extrêmes",
        "8195be4 Ajoute le calcul de la moyenne",
      )
    ],
    panneau("Dans un programme Python")[
      #sortie("import subprocess\ncommande = [\"git\", \"log\", \"--oneline\"]\nsubprocess.run(commande, check=True)", taille: 13pt)
    ],
  )

  #legende[
    `subprocess` est livré avec Python. Lancé dans le même dossier, ce programme affiche les
    mêmes lignes. `check=True` lève une erreur Python si la commande échoue.
  ]

  #notes[
    Exemple pris au cours 2. Sortie réelle, le 06/11/2026.

    Liste : chaque élément est transmis au programme sans découpage, espaces et accents
    compris.
  ]
]

// --------------------------------------------
#d("subprocess : conversion d'un fichier GPX")[
  #annonce[
    `ogr2ogr` convertit les positions du GPX en Lambert-93, et écrit le CSV des TD 3 et 4.
  ]

  #face-a-face(
    panneau("Une position de trace_2.gpx")[
      #sortie("<trkpt lat=\"48.8434345\" lon=\"2.5817636\">\n  <ele>94.7</ele><time>2026-09-07T07:40:00Z</time>\n</trkpt>", taille: 10pt)
    ],
    panneau("Les mêmes valeurs dans trace_2.csv")[
      #sortie("X,Y,ele,time\n669304.8,6860457.7,94.7,2026/09/07 07:40:00+00", taille: 10pt)
    ],
  )

  #terminal(
    taille: 13.5pt,
    "$ ogr2ogr trace_2.csv trace_2.gpx track_points -f CSV -t_srs EPSG:2154 -lco GEOMETRY=AS_XY -select ele,time -xyRes 0.1",
  )

  #script("FICHIER_GPX = \"trace_2.gpx\"\nFICHIER_CSV = \"trace_2.csv\"\noptions_ogr = [\"-f\", \"CSV\", \"-t_srs\", \"EPSG:2154\", \"-lco\", \"GEOMETRY=AS_XY\",\n               \"-select\", \"ele,time\", \"-xyRes\", \"0.1\"]\ncommande = [\"ogr2ogr\", FICHIER_CSV, FICHIER_GPX, \"track_points\"] + options_ogr\nsubprocess.run(commande, check=True)", vives: (1, 2, 5), taille: 11.5pt)

  #legende[
    En bleu, les deux variables Python et leur emploi dans la commande. Dans le fichier GPX,
    `<trkpt>` est écrit sur une seule ligne.
  ]

  #notes[
    Un fichier GPX contient les positions en degrés, et la distance du TD 4a se calcule en
    mètres.

    `+` met bout à bout deux listes. La première ligne de la commande porte ce qui change d'un
    fichier à l'autre, et `options_ogr` les réglages de la conversion.

    Le CSV obtenu est identique au `trace_2.csv` des TD 3 et 4 : essayé le 06/11/2026.

    Options : `-f CSV` le format de sortie ; `track_points` la couche des positions du
    GPX ; `-t_srs EPSG:2154` le système de coordonnées, Lambert-93 ; `-lco
    GEOMETRY=AS_XY` les colonnes `X` et `Y` ; `-select` les colonnes gardées ; `-xyRes
    0.1` les coordonnées au décimètre, depuis GDAL 3.9.

    Documentation : gdal.org/programs/ogr2ogr.html.

    Si la question vient : le module `osgeo`, livré avec GDAL, fait la même conversion
    en Python. La commande s'essaie d'abord au terminal, et le module n'enseigne pas
    l'interface de `osgeo`.
  ]
]

// --------------------------------------------
#d("subprocess : échec d'une commande")[
  #annonce[
    `subprocess.run` lève `FileNotFoundError` si le programme est introuvable. Il lève
    `CalledProcessError` si le programme échoue et que l'appel contient `check=True`.
  ]

  #show table.cell: set text(size: 15pt)
  #tableau(
    columns: (1.3fr, 1fr, 1fr),
    align: left + horizon,
    [Commande], [Avec `check=True`], [Sans `check=True`],
    [programme introuvable : `["ogr2ogrr", "--version"]`], [`FileNotFoundError`], [`FileNotFoundError`],
    [fichier absent : `["ogr2ogr", "-f", "CSV", "sortie.csv", "absent.gpx"]`], [`CalledProcessError`], [le programme Python continue, et `returncode` vaut 1],
  )

  #v(0.4em)
  #terminal(
    taille: 12.5pt,
    "$ python appel.py",
    "ERROR 1: Unable to open datasource `absent.gpx' with the following drivers.",
    "…",
    "subprocess.CalledProcessError: Command '['ogr2ogr', '-f', 'CSV', 'sortie.csv',",
    "'absent.gpx']' returned non-zero exit status 1.",
  )

  #legende[
    Sortie réelle, raccourcie. `ogr2ogr` écrit son message, puis Python écrit le sien.
  ]

  #notes[
    Sans `check=True`, `carte_trace.py` continuerait sans le CSV, et l'erreur viendrait de
    `stats_trace.py`.

    Essayé le 06/11/2026 sous Linux. Sous Windows, le message de `FileNotFoundError` est
    attendu sous la forme `[WinError 2]`, à relever.
  ]
]

// --------------------------------------------
#d("subprocess : dossier courant et chemins")[
  #annonce[
    Un chemin relatif part du dossier courant, celui du terminal (cours 3). Écrit dans le code,
    le chemin du fichier GPX ne fonctionne donc que depuis le dossier de ce fichier.
  ]

  #face-a-face(
    panneau("Chemin écrit dans le code")[
      #script("FICHIER_GPX = \"trace_2.gpx\"\nFICHIER_CSV = \"trace_2.csv\"", taille: 11pt)
      #v(0.4em)
      #terminal(
        taille: 13.5pt,
        "$ python travail/conversion.py",
        "ERROR 1: Unable to open datasource",
        "`trace_2.gpx' with the following drivers.",
      )
    ],
    panneau("Chemin donné en argument")[
      #script("FICHIER_GPX = Path(options.gpx)\nFICHIER_CSV = FICHIER_GPX.with_suffix(\".csv\")", taille: 11pt)
      #v(0.4em)
      #terminal(
        taille: 13.5pt,
        "$ python travail/carte_trace.py travail/trace_2.gpx",
        "…",
        "carte écrite : travail/trace_2.html",
      )
    ],
  )

  #legende[
    Les deux commandes sont lancées depuis le dossier parent de `travail`. `argparse` et `Path` :
    cours 3.
  ]

  #notes[
    `with_suffix` remplace l'extension : `travail/trace_2.gpx` donne `travail/trace_2.csv`.

    `carte_trace.py` lance aussi `stats_trace.py`, avec le chemin
    `Path(__file__).parent / "stats_trace.py"` (cours 3).

    Dans une chaîne Python, `\t` est une tabulation : écrire les chemins
    avec `/` ou avec `Path`, jamais `"cours5\travail"`.

    `stats_trace.py` écrit `resume.txt` dans le dossier courant (TD 3c).

    Sorties réelles sous Linux, le 06/11/2026.
  ]
]

// --------------------------------------------
// Nouveau, 06/11/2026.
#d("Installation d'un programme : globale ou locale")[
  #annonce[
    Installer un programme consiste à copier ses fichiers dans un dossier.
  ]

  #show table.cell: set text(size: 15pt)
  #tableau(
    columns: (auto, 1fr, 1fr, 1fr),
    align: left + horizon,
    [], [Installation locale], [Installation globale, dans un dossier par défaut], [Installation globale, avec une variable mise à jour],
    [Dossier], [un dossier du projet ou du compte], [un dossier du système, cherché par défaut], [un autre dossier, ajouté à une variable d'environnement],
    [Windows], [`outils\gdal\bin\ogr2ogr.exe`], [`C:\Windows\System32\cmd.exe`], [`C:\Program Files\Git\cmd\git.exe`],
    [Linux], [`outils/gdal/bin/ogr2ogr`], [`/usr/bin/ogr2ogr`], [`/snap/bin/code`],
    [Lancement], [par son chemin], [par son nom], [par son nom],
  )

  #legende[
    La variable d'environnement mise à jour s'appelle `PATH` : diapositive suivante.
  ]

  #notes[
    Exemple d'installation globale avec une variable mise à jour : la case « Add python.exe to
    PATH » de l'installateur de Python.

    Une installation locale ne modifie pas le système, et ne demande pas de droits
    d'administrateur.

    Un environnement conda est une installation locale, dans un dossier du compte : partie 4.

    Essai sous Linux : `outils/gdal` est un lien vers un environnement conda. Sous Windows, la
    disposition du dossier dépend de la distribution de GDAL : à relever en salle.

    `/snap/bin/code` : VS Code installé par snap, sous Ubuntu. `/etc/profile.d/apps-bin-path.sh`
    ajoute `/snap/bin` à `PATH` : relevé le 06/11/2026. Chemins de Windows attendus, à relever en
    salle.
  ]
]

// --------------------------------------------
// Reprend « PATH : recherche d'une commande » (05/11/2026), avec `ogr2ogr` à gauche.
#d("Recherche d'un programme : variable PATH")[
  #annonce[
    Pour une commande sans `/`, Git Bash cherche dans chaque dossier de `PATH`, dans
    l'ordre, et lance le premier fichier de ce nom, avec ou sans `.exe`.
  ]

  #face-a-face(
    panneau("Programme dans un sous-dossier")[
      #arborescence(
        (0, "projet/"),
        (1, "carte_trace.py"),
        (1, "outils/gdal/bin/"),
        (2, "ogr2ogr.exe"),
        taille: 12pt,
      )
      #v(0.4em)
      #terminal(
        taille: 14pt,
        "$ outils/gdal/bin/ogr2ogr --version",
        "GDAL 3.13.3 \"Iowa City\", released 2026/08/13",
        "$ ogr2ogr --version",
        "bash: ogr2ogr: command not found",
      )
    ],
    panneau("La liste des dossiers")[
      #terminal(
        taille: 14pt,
        "$ echo \"$PATH\" | tr ':' '\\n'",
        "/c/ProgramData/anaconda3",
        "/c/ProgramData/anaconda3/Scripts",
        "/usr/bin",
        "/c/Python27",
        "$ which -a python",
        "/c/ProgramData/anaconda3/python",
        "/c/Python27/python",
      )
    ],
  )

  #legende[
    À gauche, les commandes sont lancées depuis `projet/`. À droite, un poste où un Python 2.7 est
    aussi installé. Si aucun dossier ne contient la commande, Git Bash répond `command not found`,
    et `subprocess.run` lève `FileNotFoundError`.
  ]

  #notes[
    `outils/gdal` : une copie de GDAL dans le projet, diapositive précédente. Dossier absent de
    `PATH`, donc commande introuvable par son nom.

    Sorties de gauche relevées sous Linux, où le fichier s'appelle `ogr2ogr`. Sous Windows, le
    fichier s'appelle `ogr2ogr.exe`, et Git Bash le trouve sans l'extension : attendu, à relever en
    salle. Un nom écrit avec `.exe` et sans `/` passe aussi par `PATH`.

    Reprend `which python` du cours 1 et du TD 1c : `python` désigne le premier
    fichier de ce nom. Depuis le TD 1c, Git Bash active conda à l'ouverture, d'où
    `anaconda3` en tête.

    `echo` affiche un texte ; `|` envoie ce texte à la commande suivante. `tr` affiche un dossier
    par ligne ; `which -a` liste tous les fichiers trouvés.

    Un nom qui contient un `/` est lancé directement (manuel de bash, « Command
    Search and Execution ») : d'où `outils/gdal/bin/ogr2ogr` à gauche. Git Bash ne cherche pas
    dans le dossier courant. Le `cmd` de Windows y cherche d'abord.
  ]
]

// --------------------------------------------
// Nouveau, 06/11/2026. Remplace « Variables d'environnement : définition ». Menus de Windows :
// annexe « Variables d'environnement et recherche des programmes ».
#d("Variable PATH : portée d'une modification")[
  #annonce[
    Une variable d'environnement associe un nom à une valeur, et cette valeur peut être une liste.
    Les dossiers de `PATH` sont séparés par `:` dans Git Bash et sous Linux, par `;` dans `cmd` et
    PowerShell.
  ]

  #show table.cell: set text(size: 14pt)
  #tableau(
    columns: (auto, 1.7fr, 1fr, 1fr),
    align: left + horizon,
    [Niveau], [Modification], [Portée], [Durée],
    [Système], [Paramètres, « Modifier les variables d'environnement système »], [tous les comptes du poste], [jusqu'à la modification suivante],
    [Compte], [Paramètres, « Modifier les variables d'environnement pour votre compte »], [ce compte], [jusqu'à la modification suivante],
    [Session], [`export`, dans un terminal], [ce terminal et les programmes qu'il lance], [jusqu'à la fermeture du terminal],
  )

  #v(0.15em)
  #terminal(
    taille: 14pt,
    "$ export PATH=\"$PWD/outils/gdal/bin:$PATH\"",
    "$ ogr2ogr --version",
    "GDAL 3.13.3 \"Iowa City\", released 2026/08/13",
  )

  #legende[
    `export` place le nouveau dossier devant la valeur actuelle de `PATH`, avec `:` entre les deux.
    Après une modification dans Paramètres, un terminal déjà ouvert garde l'ancienne valeur.
  ]

  #notes[
    Le terminal transmet les variables d'environnement à chaque programme qu'il lance.

    Valeur de `PATH` dans PowerShell, d'après l'annexe : `C:\Windows\System32;C:\Windows;…`.
    Git Bash affiche la même liste avec `:` et des chemins en `/c/…` : voir la diapositive
    précédente.

    `$PWD` : le dossier courant. `$NOM` est remplacé par la valeur de la variable avant que la
    commande ne démarre, comme le motif `*`. `env` affiche toutes les variables.

    Autres variables : `HOME`, le dossier personnel, que `~` désigne ; `CONDA_PREFIX`, le dossier
    de l'environnement actif.

    Le niveau système demande des droits d'administrateur. `PATH` du compte s'ajoute à `PATH` du
    système. Après une modification dans Paramètres, il faut ouvrir un nouveau terminal : attendu
    sous Windows, à relever en salle.

    `conda init bash` a écrit dans `~/.bash_profile` au TD 1c. Ce fichier s'exécute à l'ouverture
    de chaque terminal Git Bash du compte. `conda activate` modifie `PATH` au niveau de la
    session : partie 4.

    Essayé le 06/11/2026 sous Linux : dans un nouveau terminal, `which ogr2ogr` ne trouve plus le
    programme.
  ]
]
