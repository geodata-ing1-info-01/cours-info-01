// Partie 2 du cours 1 v2, seconde moitié : le premier programme. Incluse par
// `cours1_v2.typ`. Un fichier inclus n'hérite pas des imports de son appelant.
//
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": terminal, chaine-terminal

#separateur(
  "Programme Python et notebook",
  annonce: "comment executer et ouvrir des fichiers de codes python",
)

// --------------------------------------------
// Seconde relecture du 19/10/2026 : ce que les parties 1 et 2 ont dit, que
// la partie 3 emploie. Les icônes des éditeurs sont celles du TD 1a
// (`images/editeurs/CREDITS.md`).
#d("notions des parties 1 et 2 utiles pour Python")[
  #annonce[
    `python` est un programme en ligne de commande. Il prend en entrée un
    fichier texte, écrit dans un éditeur de texte comme le Bloc-notes, dont
    l'extension est souvent `.py`.
  ]

  #chaine(
    gabarit: bloc, pleins: (1,),
    ([#text(size: 24pt)[`altitudes.py`]], [un fichier texte, en entrée]),
    ([#text(size: 24pt)[`python`]], [un programme en ligne de commande]),
    ([#text(size: 24pt)[`moyenne : 129.0 m`]], [le résultat, écrit dans le terminal]),
  )

  #grid(
    columns: (1fr, 26pt, 1fr, 26pt, 1fr), align: center + top,
    stack(
      dir: ttb, spacing: 6pt,
      stack(
        dir: ltr, spacing: 14pt,
        image("/src/cours1_v2/images/editeurs/bloc_notes.svg", height: 40pt),
        image("/src/cours1_v2/images/editeurs/notepadpp.svg", height: 40pt),
      ),
      text(size: 14pt, fill: estompe)[écrit dans le Bloc-notes ou Notepad++],
    ),
    [],
    text(size: 14pt, fill: estompe)[lancé dans Git Bash : \ `python altitudes.py`],
    [],
    [],
  )

  #legende[
    Partie 1 : un logiciel lit des fichiers en entrée, et l'extension
    indique leur type. Partie 2 : une commande se tape dans un terminal.
  ]

  #notes[
    Diapositive de transition : faire dire par la salle ce que chaque boîte
    reprend des parties 1 et 2, avant de parler de compilation.

    Le fichier est du texte : il s'ouvre dans le Bloc-notes (TD 1a). Son
    extension `.py` ne change rien à son contenu ; elle fait seulement
    reconnaître le fichier par Notepad++ et par l'explorateur.
  ]
]

// --------------------------------------------
// Relecture du 19/10/2026 : la moitié « Compilé » de « Compiler ou
// interpréter » (refaite le 27/09 à partir de « Deux chemins du texte à
// l'exécution »).
#d("Du code au programme : compilation puis execution")[
  #annonce[
    Le processeur n'exécute que des instructions machine. Un compilateur
    traduit une fois le texte du programme en instructions machine, et les
    enregistre dans un fichier exécutable.
  ]

  #block(width: 100%, fill: gris, inset: (x: 12pt, y: 10pt))[
    #text(size: 16pt, fill: estompe, weight: demi-gras)[Compilé : C, C++]
    #v(0.4em)
    #chaine(
      ("bonjour.cpp", "le texte écrit"),
      ("le compilateur", "une fois, après chaque modification"),
      ("bonjour.exe", "des instructions machine"),
      ("le résultat", "à chaque lancement"),
    )
  ]

  #legende[
    Le fichier exécutable se lance seul, sans le compilateur, sur le système
    pour lequel il a été compilé.
  ]

  #notes[
    Après une modification du texte : recompiler, puis lancer. Une faute de
    frappe est signalée à la compilation, avant tout lancement.

    Sur un autre système, recompiler pour ce système.

    Le programme C++ du TD de 2026 est en annexe du book (« C++ »), avec
    « La place de l'interpréteur ».
  ]
]

// --------------------------------------------
// Relecture du 19/10/2026 : la moitié « Interprété » de « Compiler ou
// interpréter », avec les notes de « Compilé ou interprété : ce que chacun
// apporte », retirée.
#d("Du code au programme : Interpréteur")[
  #annonce[
    Un interpréteur lit le texte du programme et l'exécute, à chaque
    lancement, sans fichier exécutable. Python est un langage interprété.
  ]

  #block(width: 100%, fill: accent.lighten(92%), inset: (x: 12pt, y: 10pt))[
    #text(size: 16pt, fill: accent, weight: demi-gras)[Interprété : Python]
    #v(0.4em)
    #chaine(
      ("bonjour.py", "le texte écrit"),
      ("python.exe", "lit le texte, à chaque lancement"),
      ("le résultat", "rien d'autre sur le disque"),
    )
  ]

  #legende[
    L'interpréteur est lui-même un programme compilé : `python.exe` est écrit
    en C. Pour lancer `bonjour.py` sur une autre machine, Python doit y être
    installé.
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

    Tutoriel de Python, « Whetting Your Appetite » : « no compilation and
    linking is necessary », et l'interpréteur « can be used interactively ».
    Une faute de frappe est signalée au lancement.

    Vitesse : 72 fois le temps du C sur des calculs intensifs (Pereira et
    al., SLE 2017) ; 47 fois pour un produit de matrices en Python 2.7
    (Leiserson et al., _Science_, 2020), avant Python 3.11, plus rapide de
    25 % en moyenne. numpy calcule en code compilé, « at near-C speeds »
    selon sa documentation.

    Pourquoi Python pour débuter : article de _Nature_ sur NumPy (Harris et
    al., 2020), « famously easy to learn and teach » ; cours d'introduction
    du MIT (6.100L) et de Software Carpentry. Un exécutable Python autonome
    existe (« freezing », guide de l'empaquetage de Python), au prix de
    plusieurs outils.
  ]
]

// --------------------------------------------
#d("Python, un programme en ligne de commande")[
  #annonce[
    Dans un terminal, la commande `python` suivie du nom d'un fichier exécute
    ce fichier. Tapée seule, elle ouvre une session interactive, où Python
    exécute chaque ligne dès qu'on appuie sur Entrée.
  ]

  #face-a-face(
    panneau[Exécuter un fichier : `python altitudes.py`][
      #terminal(
        taille: 17pt,
        "$ cd ~/Desktop/info01/cours1/1c_programme",
        "$ python altitudes.py",
        "moyenne : 129.0 m",
      )
    ],
    panneau[Ouvrir une session interactive : `python`][
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
    Python écrit ses résultats dans le terminal, sans ouvrir de fenêtre.
    Comme `ls` ou `cp`, `python` est une commande, qu'un script peut lancer.
  ]

  #notes[
    Sorties relevées avec Python 3.12 sous Linux ; la ligne de version
    diffère sur les postes. `exit()` ferme la session.

    Git Bash demande le réglage du début du TD 1c ; l'invite de commandes
    d'Anaconda reste le recours si ce réglage manque sur un poste, comme
    pour JupyterLab à la partie 3. L'invite de commandes d'Anaconda est
    `cmd`, avec conda déjà activé : `python` y lance le Python d'Anaconda
    sans réglage. Elle s'ouvre dans `C:\Users\eleve` ; y taper
    `cd Desktop\info01\cours1\1c_programme`.

    Un programme Python n'ouvre de fenêtre que s'il le demande, par une
    bibliothèque graphique. Ceux du module écrivent dans le terminal ou
    dans des fichiers.

    Au cours 4, un programme Python lance `magick` et `ffmpeg`, deux autres
    programmes en ligne de commande.
  ]
]

// --------------------------------------------
// Relecture du 19/10/2026 : fusion de « Une commande désigne un fichier
// exécutable », simplifiée (le schéma de `PATH`, `schema-path`, est
// retiré), et de « Un fichier ou une session interactive », dont la session
// est déjà sur « Python, un programme en ligne de commande ». À gauche, ce
// que fait l'interpréteur du fichier enregistré ; à droite, comment voir
// quel interpréteur la commande `python` lance, et en lancer un autre.
#d("Exécution d'un programme Python")[
  #annonce[
    La commande `python altitudes.py` lance l'interpréteur, qui lit le
    fichier enregistré et l'exécute. `which python` affiche l'emplacement de
    cet interpréteur. Pour en lancer un autre, on tape le chemin complet de
    son fichier `python.exe`.
  ]

  #grid(
    columns: (0.85fr, 1.15fr), column-gutter: 18pt, align: top,
    chaine-terminal(
      ("Notepad++", "écrire altitudes.py, l'enregistrer"),
      ("Le terminal", "taper python altitudes.py"),
      ("L'interpréteur python", "lit le fichier enregistré, l'exécute"),
      ("Le terminal", "affiche moyenne : 129.0 m"),
      plein: 2,
    ),
    panneau[Dans Git Bash : le Python par défaut, puis celui d'Anaconda][
      #terminal(
        taille: 15pt,
        "$ which python",
        "/c/Python27/python",
        "$ /c/ProgramData/anaconda3/python.exe altitudes.py",
        "moyenne : 129.0 m",
      )
    ],
  )

  #legende[
    Exemple d'un poste où un Python 2.7 est installé dans `C:\Python27`.
    Dans Git Bash, `C:\` s'écrit `/c/`, et chaque `\` devient `/`.
  ]

  #notes[
    L'interpréteur lit le fichier sur le disque : une modification non
    enregistrée n'est pas exécutée. Le TD 1c le fait constater.

    À vérifier sur un poste de la salle : `which python` dans Git Bash,
    sans conda. Python 2.7 attendu (fin de maintenance le 1er janvier 2020,
    python.org), dans `C:\Python27`, son dossier par défaut. Sinon,
    `which: no python in (…)`, ou un renvoi au Microsoft Store.

    bash cherche une commande sans `/` dans chaque dossier de la variable
    `PATH`, et lance le premier fichier de ce nom ; un nom qui contient un
    `/` est lancé directement (manuel de bash, « Command Search and
    Execution »). `which -a python` liste tous les fichiers trouvés.
    `conda activate` met les dossiers d'Anaconda en tête de `PATH`
    (documentation de conda) ; le réglage du début du TD 1c le fait à
    chaque ouverture de Git Bash.

    `ls` est aussi un fichier, `/usr/bin/ls`, fourni par Git for Windows.
    Dans l'invite de commandes, `where python` joue le rôle de
    `which python`.

    Notepad++ à la place de l'éditeur de code (VS Code au cours 2) : un seul
    outil nouveau par séance, et l'éditeur de code se configure en classe
    entière au cours 2 (syllabus v2). Notepad++ colore le code d'après
    l'extension `.py` ; la couleur n'est pas dans le fichier.

    Le notebook, à la partie 3, réunit le fichier et la session : du code
    enregistré, exécuté morceau par morceau.
  ]
]
