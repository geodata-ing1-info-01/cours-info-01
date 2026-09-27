// Partie 2 du cours 1 v2, seconde moitié : le premier programme. Incluse par
// `cours1_v2.typ`. Un fichier inclus n'hérite pas des imports de son appelant.
//
// Refaite le 27/09/2026. Python y est présenté comme un programme en ligne de
// commande, lancé par le nom d'un fichier exécutable que bash cherche dans
// PATH ; puis compilé et interprété, avec ce que chacun apporte et le choix de
// Python ; enfin un script de commandes. « D'un programme à une application »
// et « La place de l'interpréteur » sont passées en annexe du book
// (`src/annexes/plus_loin/programme_interpreteur.md`), l'indentation et le TD
// des programmes fautifs au cours 2 v2.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": terminal, schema-path, chaine-terminal

#separateur-reprise(
  "Premier programme",
  annonce: "Un programme Python est un fichier texte, que l'interpréteur python exécute.",
)

// --------------------------------------------
#d("Python, un programme en ligne de commande")[
  #annonce[
    `python` se lance dans un terminal, suivi du nom du fichier à exécuter. Il
    n'ouvre pas de fenêtre et écrit ses résultats dans le terminal. Tout
    terminal où Python est disponible convient.
  ]

  #face-a-face(
    panneau[Dans Git Bash][
      #terminal(
        "$ cd ~/Desktop/info01/cours1/2b_programme",
        "$ python altitudes.py",
        "moyenne : 129.0 m",
      )
    ],
    panneau[Dans l'invite de commandes d'Anaconda][
      #terminal(
        titre: "Anaconda Prompt",
        taille: 17pt,
        "(base) …>cd Desktop\\info01\\cours1\\2b_programme",
        "(base) …\\2b_programme>python altitudes.py",
        "moyenne : 129.0 m",
      )
    ],
  )

  #legende[
    L'invite de commandes d'Anaconda est `cmd`, avec conda déjà activé :
    `python` y lance le Python d'Anaconda sans réglage. Comme `ls` ou `cp`,
    `python` est une commande, qu'un script peut lancer.
  ]

  #notes[
    Sortie relevée avec Python 3.12 sous Linux. `…` remplace le dossier
    personnel, `C:\Users\eleve`, où l'invite d'Anaconda s'ouvre.

    Git Bash demande le réglage du début du TD 2b ; l'invite de commandes
    d'Anaconda reste le recours si ce réglage manque sur un poste, comme
    pour JupyterLab à la partie 3.

    Un programme Python n'ouvre de fenêtre que s'il le demande, par une
    bibliothèque graphique. Ceux du module écrivent dans le terminal ou
    dans des fichiers.

    Au cours 4, un programme Python lance `magick` et `ffmpeg`, deux autres
    programmes en ligne de commande.
  ]
]

// --------------------------------------------
#d("Une commande désigne un fichier exécutable")[
  #annonce[
    `python` est le nom d'un fichier, `python.exe`. bash le cherche dans une
    liste de dossiers, la variable `PATH`, et lance le premier qu'il trouve.
  ]

  #schema-path()

  #legende[
    Un nom qui contient un `/` désigne un fichier précis, sans recherche :
    `/c/ProgramData/anaconda3/python.exe` lance le Python d'Anaconda.
    `type -a python` affiche les fichiers trouvés, dans l'ordre.
  ]

  #notes[
    À vérifier sur un poste, le 28/09 : `python --version` et
    `type -a python` dans Git Bash, sans conda. Python 2.7 attendu (fin de
    maintenance le 1er janvier 2020, python.org), dans `C:\Python27`, son
    dossier par défaut (FAQ Windows de Python 2.7). Sinon, la commande est
    introuvable, ou renvoie au Microsoft Store.

    Manuel de bash, « Command Search and Execution » : une commande sans `/`
    est cherchée dans chaque dossier de `$PATH` ; un nom qui contient un `/`
    est exécuté directement.

    Documentation de conda : « Activation prepends to PATH ». Le réglage du
    début du TD 2b le fait à chaque ouverture de Git Bash.

    `ls` est aussi un fichier, `/usr/bin/ls`, fourni par Git for Windows.
    Dans l'invite de commandes, `where python` joue le rôle de
    `type -a python`.
  ]
]

// --------------------------------------------
// Refaite le 27/09 à partir de « Deux chemins du texte à l'exécution ».
#d("Compiler ou interpréter")[
  #annonce[
    Le processeur n'exécute que des instructions machine. Un compilateur
    traduit le programme une fois, un interpréteur lit son texte à chaque
    lancement.
  ]

  #block(width: 100%, fill: gris, inset: (x: 12pt, y: 7pt), below: 0.5em)[
    #text(size: 16pt, fill: estompe, weight: demi-gras)[Compilé : C, C++]
    #v(0.3em)
    #chaine(
      ("bonjour.cpp", "le texte écrit"),
      ("le compilateur", "une fois, après chaque modification"),
      ("bonjour.exe", "des instructions machine"),
      ("le résultat", "à chaque lancement"),
    )
  ]

  #block(width: 100%, fill: accent.lighten(92%), inset: (x: 12pt, y: 7pt))[
    #text(size: 16pt, fill: accent, weight: demi-gras)[Interprété : Python]
    #v(0.3em)
    #chaine(
      ("bonjour.py", "le texte écrit"),
      ("python.exe", "lit le texte, à chaque lancement"),
      ("le résultat", "rien d'autre sur le disque"),
    )
  ]

  #legende[
    L'interpréteur est lui-même un programme compilé : `python.exe` est écrit
    en C.
  ]

  #notes[
    Glossaire de Python : Python est interprété, « though the distinction
    can be blurry because of the presence of the bytecode compiler ».
    `python` traduit d'abord le texte en bytecode, qu'il exécute lui-même ;
    ce n'est pas du code machine.

    La distinction tient à l'outil. Il existe un interpréteur de C++
    (Cling, au CERN), et Python 3.13 a un compilateur à la volée
    expérimental. Java et JavaScript font les deux. Ne le dire que
    si la question vient.

    Le programme C++ du TD de 2026 est en annexe du book (« C++ »), avec
    « La place de l'interpréteur ».
  ]
]

// --------------------------------------------
#d("Compilé ou interprété : ce que chacun apporte")[
  #annonce[
    Le module emploie Python. Il se relance sans étape de compilation,
    s'essaie ligne à ligne, et ses bibliothèques de calcul font leurs
    calculs en code compilé.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Compilé : C, C++], [Interprété : Python],
    [Après une modification], [recompiler, puis lancer], [relancer],
    [Essayer une ligne], [l'écrire dans un programme complet], [la taper dans une session interactive],
    [Ce qu'on donne à un autre], [l'exécutable, qui se lance seul], [le fichier `.py`, et Python installé],
    [Sur un autre système], [recompiler pour ce système], [le même fichier],
    [Un calcul en boucle], [la référence], [environ 50 fois plus lent],
    [Une faute de frappe], [signalée à la compilation], [signalée au lancement],
  )

  #legende[
    Vitesse : deux mesures publiées, dans les notes. numpy calcule en code
    compilé, « at near-C speeds » selon sa documentation.
  ]

  #notes[
    Tutoriel de Python, « Whetting Your Appetite » : « no compilation and
    linking is necessary », et l'interpréteur « can be used interactively ».

    Vitesse : 72 fois le temps du C sur des calculs intensifs (Pereira et
    al., SLE 2017) ; 47 fois pour un produit de matrices en Python 2.7
    (Leiserson et al., _Science_, 2020). Deux mesures antérieures à
    Python 3.11, plus rapide de 25 % en moyenne.

    Pourquoi Python pour débuter : article de _Nature_ sur NumPy (Harris et
    al., 2020), « famously easy to learn and teach » ; cours d'introduction
    du MIT (6.100L) et de Software Carpentry.

    Un exécutable Python autonome existe (« freezing », guide de
    l'empaquetage de Python), au prix de plusieurs outils.
  ]
]

// --------------------------------------------
// Nouveau (v2) : le programme écrit dans un éditeur de texte, lancé au terminal.
// 28/09 : les deux façons d'employer l'interpréteur, côte à côte.
#d("Un fichier ou une session interactive")[
  #annonce[
    L'interpréteur python exécute un fichier enregistré, ou les lignes tapées
    une à une.
  ]

  #grid(
    columns: (0.9fr, 1.1fr), column-gutter: 18pt,
    panneau[Un programme, écrit dans un éditeur de texte][
      #chaine-terminal(
        ("Notepad++", "écrire altitudes.py, l'enregistrer"),
        ("Le terminal", "taper python altitudes.py"),
        ("L'interpréteur python", "lit le fichier enregistré, l'exécute"),
        ("Le terminal", "affiche moyenne : 129.0 m"),
        plein: 2,
      )
    ],
    panneau[Une session interactive, dans le terminal][
      #terminal(
        taille: 16pt,
        "$ python",
        "Python 3.12.14 (main, Sep  2 2026, 23:27:36) [GCC 15.3.0] on linux",
        ">>> 128.4 + 131.0",
        "259.4",
        ">>> exit()",
      )
    ],
  )

  #legende[
    Le programme se relance à l'identique, la session ne garde rien sur le
    disque.
  ]

  #notes[
    L'interpréteur lit le fichier sur le disque : une modification non
    enregistrée n'est pas exécutée. Le TD 2b le fait constater.

    Le notebook, à la partie 3, réunit les deux : du code enregistré,
    exécuté morceau par morceau.

    Session relevée avec Python 3.12 sous Linux ; la ligne de version diffère
    sur les postes.


    Notepad++ à la place de l'éditeur de code (VS Code au cours 2) : un seul
    outil nouveau par séance, et l'éditeur de code se configure en classe
    entière au cours 2 (syllabus v2).

    Notepad++ colore le code d'après l'extension `.py` ; la couleur n'est
    pas dans le fichier. Le TD 1a l'a montré sur `.css` et `.html`.
  ]
]

// --------------------------------------------
// Nouveau (v2), 27/09 : un script de commandes, et Python dedans.
#d("Un script de commandes")[
  #annonce[
    Un script est un fichier texte qui contient des commandes. `bash` les
    exécute dans l'ordre, comme si on les tapait. Le travail se refait en une
    commande, aussi souvent qu'il le faut.
  ]

  #face-a-face(
    panneau[`commandes.sh`, dans Notepad++][
      #text(size: 18pt)[```bash
      # Commandes du TD 2a, puis le programme du TD 2b.
      # Lancer depuis 2b_programme : bash commandes.sh
      mkdir -p copies
      cp ../2a_terminal/depart/*.html copies/
      ls copies
      python altitudes.py
      ```]
    ],
    panneau[Lancé dans Git Bash][
      #terminal(
        taille: 17pt,
        "$ bash commandes.sh",
        "auld_lang_syne_brut.html   raven_brut.html",
        "auld_lang_syne_style.html  raven_style.html",
        "moyenne : 129.0 m",
      )
    ],
  )

  #legende[
    Une ligne qui commence par `#` est un commentaire. `python` y est une
    commande comme les autres. L'équivalent pour l'invite de commandes est
    un fichier `.bat`, en annexe du guide du TD 2b.
  ]

  #notes[
    Sortie relevée sous Linux (bash 5.2), dans une copie de l'archive, avec
    une fenêtre de 80 colonnes.

    `mkdir -p` : pas d'erreur si le dossier existe déjà, au second
    lancement. `.sh` est l'extension d'usage, que Notepad++ reconnaît.

    Manuel de bash, « Shell Scripts » : « a text file containing shell
    commands ». bash est donc un interpréteur, comme `python` : l'un lit
    des commandes, l'autre du Python.

    Fil de la partie : un logiciel graphique automatise les tâches qu'il
    prévoit (l'export du TD 1a) ; un script enchaîne et répète des
    programmes existants ; un programme Python fait ce qu'aucun outil ne
    fait. On choisit selon la tâche, et le plus simple des outils qui la
    font.
  ]
]
