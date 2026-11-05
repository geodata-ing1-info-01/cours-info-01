// Partie 2 du cours 1 v2, seconde moitié : exécuter un programme. Incluse par
// `cours1_v2.typ`. Un fichier inclus n'hérite pas des imports de son appelant.
//
// 05/11/2026 : la partie s'appelle « Exécuter un programme », et suit cet ordre :
// compilation, processeur, interpréteur, moment de la traduction, Python au
// terminal, puis les deux comparaisons, qui emploient la session interactive et
// viennent donc après. « Notions des parties 1 et 2 utiles pour Python » est réunie
// à « Du code au programme : interpréteur ». « Compilateur et interpréteur :
// compromis » et « Exécution d'un programme Python » sont remplacées par « essais,
// calculs » et « changer de poste », qui reprennent leur contenu.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": terminal, programme-trois-lignes, schema-moment-traduction, schema-modifier-relancer
#import "../../../cours5/diapo/schemas.typ": schema-processeur, schema-coeurs

#separateur(
  "Exécuter un programme",
  annonce: "Exécuter et ouvrir des fichiers de code Python.",
)

// --------------------------------------------
// Relecture du 19/10/2026 : la moitié « Compilé » de « Compiler ou
// interpréter » (refaite le 27/09 à partir de « Deux chemins du texte à
// l'exécution »).
#d("Du code au programme : compilation puis exécution")[
  #annonce[
    Le processeur n'exécute que des instructions machine. Un compilateur
    traduit une fois le texte du programme en instructions machine, et les
    enregistre dans un fichier exécutable.
  ]

  #block(width: 100%, fill: gris, inset: (x: 12pt, y: 10pt))[
    #text(size: 16pt, fill: estompe, weight: demi-gras)[Compilé : C, C++]
    #v(0.4em)
    #chaine(
      ("altitudes.cpp", "le texte écrit"),
      ("le compilateur", "une fois, après chaque modification"),
      ("altitudes.exe", "des instructions machine"),
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
// Repris du cours 5 le 04/11/2026 (`cours5/diapo/parties/01_materiel.typ`), qui
// garde la sienne. Seuls les renvois changent : au cours 5, cette diapositive
// ouvre une suite de cinq, jusqu'aux six cœurs du Ryzen 5 7530U. 05/11/2026 :
// passe après la compilation, dont elle reprend les « instructions machine ».
#d("Exécution des instructions machine : un cœur")[
  #annonce[
    Un cœur exécute les instructions du programme une par une, une par cycle.
  ]

  #schema-processeur(1)

  #legende[
    Une cadence de 2~GHz fait 2 milliards de cycles par seconde. 2~GHz est la
    cadence de base de l'AMD Ryzen 5 7530U (2023), un processeur de portable.
  ]

  #notes[
    Une instruction : lire une valeur en mémoire, multiplier, additionner,
    comparer, sauter à une autre instruction. Une ligne de Python correspond à
    des dizaines ou des centaines d'instructions.

    Le compte suppose une instruction de calcul à chaque cycle ; il donne un
    maximum.

    Cadence de base : celle que le processeur tient sur tous ses cœurs à la
    fois. Un cœur seul monte jusqu'à 4,5 GHz.
  ]
]

// --------------------------------------------
// D'après « Le processeur : six cœurs » du cours 5 (annonce et notes), le
// 04/11/2026. Le schéma de cette diapositive-là multiplie des facteurs que le
// cours 1 ne présente pas (instructions vectorielles, a × b + c) : celui-ci est
// `schema-coeurs`, celui de la diapositive « Le processeur » du cours 5 avant
// le 19/10/2026, toujours employé par la page de cours.
#d("Exécution des instructions machine : plusieurs cœurs")[
  #annonce[
    Chaque cœur suit sa file d'instructions ; un programme Python ordinaire
    n'en occupe qu'un.
  ]

  #align(center, schema-coeurs())

  #legende[
    Deux cœurs sur les processeurs grand public depuis 2005 (AMD Athlon 64
    X2, Intel Pentium D).
  ]

  #notes[
    Les autres cœurs servent aux autres programmes ouverts.

    Cœurs : 4 sur les postes de la salle (relevé au TD 5a), 4 à 8 sur un
    portable, 32 à 128 sur un serveur de calcul.

    Les cœurs se sont multipliés quand la fréquence a cessé de monter, vers
    2005.

    Un programme occupe plusieurs cœurs s'il découpe son travail en parties
    indépendantes. numpy le fait pour le produit de matrices.

    Le gestionnaire des tâches affiche pour le Ryzen 5 7530U 6 cœurs et 12
    processeurs logiques : chaque cœur suit deux files d'instructions, qui se
    partagent ses unités.
  ]
]

// --------------------------------------------
// Relecture du 19/10/2026 : la moitié « Interprété » de « Compiler ou
// interpréter ». 05/11/2026 : réunie à « Notions des parties 1 et 2 utiles pour
// Python », dont elle reprend les boîtes et les icônes des éditeurs, celles du
// TD 1a (`images/editeurs/CREDITS.md`). Les notes sur la vitesse et le choix de
// Python passent à « Compilateur et interpréteur : essais, calculs ».
#d("Du code au programme : interpréteur")[
  #annonce[
    Un interpréteur lit le texte du programme et l'exécute, à chaque
    lancement, sans fichier exécutable. Python est un langage interprété.
  ]

  #block(width: 100%, fill: accent.lighten(92%), inset: (x: 12pt, y: 10pt))[
    #text(size: 16pt, fill: accent, weight: demi-gras)[Interprété : Python]
    #v(0.4em)
    #chaine(
      gabarit: bloc, pleins: (1,),
      ([#text(size: 24pt)[`altitudes.py`]], [un fichier texte, en entrée]),
      ([#text(size: 24pt)[`python`]], [l'interpréteur, un programme en ligne de commande]),
      ([#text(size: 24pt)[`moyenne : 129.0 m`]], [le résultat, écrit dans le terminal]),
    )
    #v(0.2em)
    #show raw: set text(size: 1.15em)
    #grid(
      columns: (1fr, 26pt, 1fr, 26pt, 1fr), align: center + horizon,
      grid(
        columns: (auto, 1fr), column-gutter: 8pt, align: left + horizon,
        stack(
          dir: ltr, spacing: 5pt,
          image("/src/cours1_v2/images/editeurs/bloc_notes.svg", height: 30pt),
          image("/src/cours1_v2/images/editeurs/notepadpp.svg", height: 30pt),
        ),
        text(size: 14pt, fill: estompe)[écrit dans Notepad++ ou le Bloc-notes],
      ),
      [],
      text(size: 14pt, fill: estompe)[lancé dans Git Bash : \ `python altitudes.py`],
      [],
      text(size: 14pt, fill: estompe)[rien d'autre sur le disque],
    )
  ]

  #legende[
    L'interpréteur est lui-même un programme compilé : `python.exe` est écrit
    en C. Pour lancer `altitudes.py` sur une autre machine, Python doit y être
    installé.
  ]

  #notes[
    Faire dire par la salle ce que chaque boîte reprend des parties 1 et 2.
    Partie 1 : un logiciel lit des fichiers en entrée, et l'extension indique
    leur type. Partie 2 : une commande se tape dans un terminal.

    Le fichier est du texte : il s'ouvre dans le Bloc-notes (TD 1a). Son
    extension `.py` ne change rien à son contenu ; elle fait seulement
    reconnaître le fichier par Notepad++ et par l'explorateur.

    Glossaire de Python : Python est interprété, « though the distinction
    can be blurry because of the presence of the bytecode compiler ».
    `python` traduit d'abord le texte en bytecode, qu'il exécute lui-même ;
    ce n'est pas du code machine.

    Tutoriel de Python, « Whetting Your Appetite » : « no compilation and
    linking is necessary », et l'interpréteur « can be used interactively ».
  ]
]

// --------------------------------------------
// Nouveau (05/11/2026). D'après Stanford CS106L, « Types and Structs » (compile
// time puis run time) et Think Python, chap. 1 (lire, exécuter). Refaite le même
// jour : trois lignes affichées, une opération par ligne, sans boucle ni code C++,
// que l'élève n'a pas vus à ce moment de la séance. Le typage n'y figure pas : c'est
// une autre question que la différence demandée ici.
//
// Sorties relevées le 05/11/2026 : `python trois_lignes.py` et le programme C++ des
// notes affichent tous deux 129.0.
#d("Compilateur et interpréteur : traduction")[
  #annonce[
    Le compilateur traduit toutes les lignes avant le lancement. L'interpréteur
    lit chaque ligne, la traduit et l'exécute, puis passe à la suivante.
  ]

  #programme-trois-lignes()
  #schema-moment-traduction()

  #legende[
    Au lancement suivant, l'exécutable se relance sans traduction, et
    l'interpréteur traduit de nouveau les trois lignes.
  ]

  #notes[
    Faire lire les trois lignes d'abord : chacune fait une opération, écrite à
    droite en bleu. Puis lire le schéma ligne par ligne. Le gris marque la
    traduction, le bleu ce que le processeur exécute (les cœurs de la diapositive
    « Exécution des instructions machine »). Schéma sans échelle : une traduction
    demande bien plus de temps qu'une opération, et la diapositive « essais, calculs »
    donne les durées mesurées.

    Stanford CS106L : « Interpreted languages all run in run time! Compiled
    Languages run in first compile time then run time ».

    Le même programme en C++, si la question vient : `double total = 128.4 + 131.0 +
    127.6;`, `double moyenne = total / 3;`, `printf("%.1f\n", moyenne);`, dans une
    fonction `main`. Il affiche aussi 129.0.

    Image possible, à l'oral : un livre traduit d'avance se lit vite, sans
    traducteur, et une correction demande une nouvelle édition. Un interprète en
    réunion commence tout de suite, doit être là à chaque réunion, et traduit de
    nouveau une phrase répétée.

    Si la question vient, pourquoi C++ ne s'exécute pas ligne à ligne. Le
    compilateur reçoit le programme entier (Severance, _Python for Everybody_,
    chap. 1) et produit un fichier, lancé ensuite. L'exécutable ne garde pas les
    lignes : avec `g++ -O2`, ce programme ne contient plus ni addition ni division,
    `g++` a fait le calcul à la compilation (relevé avec `objdump -d`). Le schéma
    simplifie sur ce point : avec des valeurs lues dans un fichier, le calcul a bien
    lieu à l'exécution.

    Si la question vient, pourquoi Python n'est pas compilé. Rien ne l'interdit,
    et des outils le font (Cython, Nuitka). `python` garde ce que la compilation
    retirerait : le lancement sans étape préalable, le même fichier sur tous les
    systèmes, la session interactive.

    Le typage est une question séparée, à ne pas mêler ici : OCaml, typé
    statiquement, a une session interactive, et SBCL compile en code machine un
    Common Lisp à typage dynamique.

    Simplification : `python` lit tout le fichier au lancement et le traduit en
    bytecode, puis décode chaque instruction de ce bytecode à chaque passage
    (`python -m dis`). Une parenthèse manquante en dernière ligne est donc signalée
    avant la première ligne (essayé avec Python 3.12).

    La distinction tient à l'outil. Il existe un interpréteur de C++
    (Cling, au CERN), et Python 3.13 a un compilateur à la volée
    expérimental. Java et JavaScript font les deux. Ne le dire que
    si la question vient.
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
// Nouveau (05/11/2026). Avec « changer de poste », remplace « Compilateur et
// interpréteur : compromis » et « Exécution d'un programme Python » (relecture du
// 19/10/2026), dont elle reprend la chaîne et l'annonce. Les compromis sont ceux de
// MIT 6.004 (11.2.1) et de Berkeley CS 61C (« Compile vs. Interpret »).
//
// Mesures du 05/11/2026 : g++ 11.4 -O2, Python 3.12.14, AMD Ryzen 7 PRO 6850H,
// Linux, médianes de 3 à 20 lancements. `g++ altitudes.cpp` 0,057 s ;
// `./altitudes` 0,001 s ; `python altitudes.py` 0,014 s. Sur 100 000 000 de tours
// de `total = total + 0.5` : `./calcul` 0,075 s ; `python calcul.py` 5,0 s.
#let _favorable(corps) = table.cell(fill: attention.lighten(72%), corps)

#d("Compilateur et interpréteur : essais, calculs")[
  #show raw: set text(size: 1.15em)

  #annonce[
    La commande `python altitudes.py` lance l'interpréteur, qui lit le fichier
    enregistré et l'exécute. Un programme compilé demande une commande de plus.
  ]

  #schema-modifier-relancer()
  #v(0.2em)

  #show table.cell: set text(size: 15pt)
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    inset: (x: 8pt, y: 4.5pt),
    [Situation], [Compilé : C++], [Interprété : Python],
    [Modifier `altitudes`, relancer], [compiler, puis lancer : 0,06 s], _favorable[lancer : 0,01 s],
    [Essayer une ligne seule], [compiler tout un programme], _favorable[session interactive, `>>>`],
    [Calcul de 100 millions d'additions], _favorable[0,08 s, traduit une seule fois], [5 s, chaque addition traduite],
  )

  #legende[
    En bleu, le côté favorable. L'interprétation convient à un calcul fait une
    fois et à l'exploration, la compilation à un calcul répété souvent.
  ]

  #notes[
    Faire chercher le côté favorable ligne par ligne, avant de commenter.

    L'interpréteur lit le fichier sur le disque : une modification non
    enregistrée n'est pas exécutée. Le TD 1c le fait constater.

    Légende, MIT 6.004, 11.2.1 : l'interprétation pour un calcul fait une fois ou
    pour explorer, la compilation pour un calcul répété, « willing to invest more
    time up-front for more efficiency in the long-term ». Pendant le
    développement, on compile souvent pour un seul lancement.

    Première ligne : 0,06 s de compilation et 0,001 s de lancement, contre 0,01 s
    pour `python`. Personne ne ressent cet écart : sur un petit programme, Python
    ne perd rien, et il reste une commande de moins. Le délai de compilation
    augmente avec la taille du programme.

    Dernière ligne, un seul lancement : `python` traduit la ligne répétée à chaque
    passage, un programme compilé ne la traduit plus (MIT 6.004 : « may process and
    execute the same statement many times »). Environ 70 fois le temps de C++. L'écart
    compare deux langages, et ne vient pas de la seule interprétation. Mesures
    sous Linux, protocole en commentaire de cette diapositive, dans le source.

    Vitesse : 72 fois le temps du C sur des calculs intensifs (Pereira et
    al., SLE 2017) ; 47 fois pour un produit de matrices en Python 2.7
    (Leiserson et al., _Science_, 2020), avant Python 3.11, plus rapide de
    25 % en moyenne. numpy calcule en code compilé, « at near-C speeds »
    selon sa documentation.

    Pourquoi Python pour débuter : article de _Nature_ sur NumPy (Harris et
    al., 2020), « famously easy to learn and teach » ; cours d'introduction
    du MIT (6.100L) et de Software Carpentry.

    Notepad++ à la place de l'éditeur de code (VS Code au cours 2) : un seul
    outil nouveau par séance, et l'éditeur de code se configure en classe
    entière au cours 2 (syllabus v2). Notepad++ colore le code d'après
    l'extension `.py` ; la couleur n'est pas dans le fichier.

    Pour préparer : Stanford CS106L, « Types and Structs » ; MIT 6.004, vidéo
    11.2.1 ; Berkeley CS 61C, « Compile vs. Interpret » ; Severance, _Python for
    Everybody_, chap. 1 ; en français, Swinnen, _Apprendre à programmer avec
    Python 3_, chap. 1. _Structure and Interpretation of Computer Programs_, 5.5 :
    la compilation apporte la vitesse, l'interprétation un environnement « for
    interactive program development and debugging ».
  ]
]

// --------------------------------------------
// Nouveau (05/11/2026). Reprend de « Compilateur et interpréteur : compromis » les
// deux lignes sur un autre poste, et de « Exécution d'un programme Python » la
// commande `which python` et le lancement par le chemin complet. Exécuter un
// programme Python demande un interpréteur, d'où la question de celui qui est lancé.
#d("Compilateur et interpréteur : changer de poste")[
  #show raw: set text(size: 1.15em)

  #annonce[
    Un programme Python dépend de l'interpréteur du poste. `which python` affiche
    celui que lance la commande, et le chemin complet de `python.exe` en lance un autre.
  ]

  #show table.cell: set text(size: 15pt)
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    inset: (x: 8pt, y: 4.5pt),
    [Situation], [Compilé : C++], [Interprété : Python],
    [Lancer sur un poste sans Python], _favorable[`altitudes.exe` se lance seul], [installer Python],
    [Lancer sur un autre système], [recompiler pour ce système], _favorable[le même `.py`, si Python est installé],
  )

  #v(0.3em)
  #panneau[Dans Git Bash : le Python par défaut échoue, celui d'Anaconda réussit][
    #terminal(
      taille: 16pt,
      "$ python altitudes.py",
      "SyntaxError: Non-ASCII character '\\xc3' in file altitudes.py on line 1…",
      "$ which python",
      "/c/Python27/python",
      "$ /c/ProgramData/anaconda3/python.exe altitudes.py",
      "moyenne : 129.0 m",
    )
  ]

  #legende[
    Exemple d'un poste où un Python 2.7 est installé dans `C:\Python27`.
  ]

  #notes[
    Relevé le 05/11/2026 avec Python 2.7.15 sur le fichier du TD 1c. La première
    ligne d'`altitudes.py` contient un caractère accentué, que Python 2 refuse sans
    déclaration d'encodage (PEP 263) ; Python 3 lit l'UTF-8 par défaut. Ne pas
    s'y attarder : l'encodage est au cours 3. Le message, coupé ici, continue par
    « but no encoding declared ».

    Dans Git Bash, `C:\` s'écrit `/c/`, et chaque `\` devient `/`.

    Un exécutable Python autonome existe (« freezing », guide de l'empaquetage de
    Python), au prix de plusieurs outils.

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

    Le notebook, à la partie 3, réunit le fichier et la session : du code
    enregistré, exécuté morceau par morceau.
  ]
]
