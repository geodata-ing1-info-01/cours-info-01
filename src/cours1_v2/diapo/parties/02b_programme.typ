// Partie 2 du cours 1 v2, seconde moitié : le premier programme. Incluse par
// `cours1_v2.typ`. Un fichier inclus n'hérite pas des imports de son appelant.
//
// Reprend les diapositives 39, 40 et 42 du cours 1 de 2026 (programme et
// application, compilé et interprété, place de l'interpréteur), et celle de
// l'indentation, dont le TD 2c a besoin. Les fonctions d'un IDE et l'édition
// passent au cours 2 ; « Du code source aux instructions machine » en annexe.
#import "../../../commun/prelude.typ": *
#import "../../../cours1/diapo/schemas.typ": blancs

#separateur-reprise(
  "Premier programme",
  annonce: "Un programme Python est un fichier texte, que l'interpréteur python exécute.",
)

#d("D'un programme à une application")[
  #annonce[
    Une distinction entre un programme et un logiciel, au sens classique, est
    la façon dont ils sont distribués et ce que doit faire un utilisateur pour
    arriver à s'en servir.
  ]

  #block(width: 100%, fill: gris, inset: (x: 12pt, y: 5pt), below: 0.4em)[
    #text(size: 15pt, fill: estompe, weight: demi-gras)[Distribution]
    #v(0.25em)
    #chaine(
      ("le code source", "ce qu'on écrit"),
      ("empaquetage", "packaging"),
      ("une application", "qui s'installe"),
    )
  ]

  #block(width: 100%, fill: accent.lighten(92%), inset: (x: 12pt, y: 5pt))[
    #text(size: 15pt, fill: accent, weight: demi-gras)[Déploiement]
    #v(0.25em)
    #chaine(
      ("le code source", "ce qu'on écrit"),
      ("mise en ligne", "déploiement"),
      ("une application web", "rien à installer"),
    )
  ]

  #legende[
    C'est l'empaquetage qui change, pas le programme : le même code se distribue
    en application à installer, ou se déploie en application web.
  ]

  #notes[
    Motiver avant de définir : renommer 300 photos par leur date prend une
    soirée à la main, quelques secondes par programme ; la deuxième
    exécution ne coûte rien, et une erreur de recopie devient
    systématique, donc repérable.

    Trois mots à séparer : « programmation » nomme l'activité, « programme »
    son résultat, « application » ce que reçoit celui qui s'en sert. Aucun ne
    désigne une nature différente : c'est l'usage qui les spécialise.

    Ne pas développer l'empaquetage ni le déploiement, les mots suffisent
    aujourd'hui. Ils servent à dire qu'une application n'est pas d'une autre
    nature qu'un programme, et ils reviendront au cours 6.

    Les deux chaînes annoncent celle de « Deux chemins du texte à
    l'exécution », qui suit : même gabarit, autre question.
  ]
]

// --------------------------------------------
#d("Deux chemins du texte à l'exécution")[
  #block(width: 100%, fill: gris, inset: (x: 12pt, y: 7pt), below: 0.5em)[
    #text(size: 17pt, fill: estompe)[
      #text(weight: demi-gras)[Compilé] : le texte est traduit une fois pour
      toutes. À chaque lancement il n'y a plus rien à comprendre, donc c'est
      plus rapide.
    ]
    #v(0.3em)
    #chaine(
      ("bonjour.cpp", "le texte écrit"),
      ("compilateur", "une fois"),
      ("bonjour.exe", "des instructions"),
      ("résultat", "à chaque lancement"),
    )
  ]

  #block(width: 100%, fill: accent.lighten(92%), inset: (x: 12pt, y: 7pt))[
    #text(size: 17pt, fill: accent)[
      #text(weight: demi-gras)[Interprété] : le texte est lu et exécuté à chaque
      lancement. Comprendre le code est donc refait à chaque fois.
    ]
    #v(0.3em)
    #chaine(
      ("bonjour.py", "le texte écrit"),
      ("interpréteur", "à chaque lancement"),
      ("résultat", "rien sur le disque"),
    )
  ]

  #legende[
    Lancer un programme Python ne crée rien sur le disque : il n'y a pas
    d'exécutable à produire.
  ]

  #notes[
    La chaîne compilée a une étape de plus, faite une fois ; l'interprétée
    en a une de moins, refaite à chaque exécution.

    Semer le facteur ×100 à ×1000 du projet 7 : `numpy` délègue
    à du C compilé. Ne pas développer.

    v2 : `bonjour.cpp` est le fichier du TD C++, en annexe.

    Si question « Et Java ? » répondre en une phrase, les deux à la
    fois comme js et JIT
  ]
]
// --------------------------------------------
#d("La place de l'interpréteur")[
  #annonce[
    L'interpréteur lit le texte du programme, et c'est lui qui s'adresse au
    système. Un programme compilé s'en passe : il est déjà en instructions
    machine.
  ]

  #couche(
    icone-fenetre(taille: 30pt), "Programme interprété",
    "bonjour.py, une page web", plein: true,
  )
  #liaison("son texte", "le résultat")
  #couche(
    icone-fenetre(taille: 30pt), "Interpréteur : traduit en bytecode, puis l'exécute",
    "python, le navigateur",
  )
  // `raw` tomberait à 0,78 em, soit 10,5 pt : trop petit à la projection.
  #liaison(
    [un appel système : #text(font: police-code)[open], #text(font: police-code)[read]],
    [des octets],
  )
  #couche(
    icone-engrenage(taille: 30pt), "Système d'exploitation",
    "Windows, macOS, Linux",
  )

  #legende[
    Le bytecode n'est pas des instructions machine : l'interpréteur l'exécute
    lui-même.
  ]

  #notes[
    Insister sur la différence entre les deux flèches descendantes, c'est le
    point de la diapositive. En haut circule du texte. En bas circulent des
    appels système, les mêmes que ceux de la partie 1 : l'interpréteur les fait
    à la place du programme, et un exécutable compilé les fait lui-même,
    `bonjour.exe` compris. Le bytecode, lui, ne circule sur aucune des deux
    flèches : il reste à l'intérieur de l'interpréteur.

    Ce que « traduit en bytecode » recouvre, si la question vient : `python`
    traduit le texte entier avant d'exécuter quoi que ce soit, en instructions
    d'une machine virtuelle qui n'existe que dans `python`. Le processeur, lui,
    ne connaît que les instructions machine de la diapositive précédente.
    `python -m dis bonjour.py` affiche ce bytecode ; les fichiers `.pyc` du
    dossier `__pycache__` en sont la version gardée sur le disque, pour ne pas
    refaire la traduction au lancement suivant.

    `open` et `read` sont les noms POSIX, ceux de macOS et de Linux ; Windows
    appelle les siens `CreateFile` et `ReadFile`. Les noms diffèrent, la nature
    de l'échange non. Ne le dire que si la question vient.

    Un interpréteur est un programme comme les autres. Celui de Python
    s'appelle `python`, et c'est son exécutable dont l'assembleur vient d'être
    montré. Ce qui exécute du texte est soi-même en instructions machine.

    Conséquence pratique : lancer un programme Python suppose Python
    installé, alors qu'un exécutable compilé se lance seul. v2 : le TD
    C++, en annexe, le fait constater ; les environnements sont au cours 3.

    Le navigateur interprète trois langages sans qu'on l'appelle «
    interpréteur » : le mot désigne un rôle, pas une catégorie de
    logiciel.
  ]
]

// --------------------------------------------
// Nouveau (v2) : le programme écrit dans un éditeur de texte, lancé au terminal.
#d("Écrire et lancer un programme Python")[
  #annonce[
    Un programme Python est un fichier texte : n'importe quel éditeur de texte
    sert à l'écrire. Le terminal le fait exécuter par l'interpréteur.
  ]

  #chaine(
    ("Notepad++", "écrire altitudes.py, l'enregistrer"),
    ("Git Bash", "taper python altitudes.py"),
    ("L'interpréteur python", "lit le fichier enregistré, l'exécute"),
    ("Le terminal", "affiche ce que le programme écrit"),
  )

  #v(0.4em)
  #legende[
    L'interpréteur lit le fichier sur le disque : une modification non
    enregistrée n'est pas exécutée.
  ]

  #notes[
    Notepad++ à la place de l'éditeur de code (VS Code au cours 2) : un seul
    outil nouveau par séance, et l'éditeur de code se configure en classe
    entière au cours 2 (syllabus v2).

    Notepad++ colore le code d'après l'extension `.py` ; la couleur n'est
    pas dans le fichier. Le TD 1a l'a montré sur `.css` et `.html`.
  ]
]

// Reprise de la diapositive 47 du cours 1 de 2026, pour le TD 2c.
#d("L'indentation, en espaces ou en tabulation")[
  #annonce[
    Un espace et une tabulation sont deux caractères différents. Une
    tabulation vaut le nombre de colonnes que l'éditeur lui donne, et ce
    réglage change d'un éditeur à l'autre.
  ]

  #face-a-face(
    panneau("Tabulation réglée sur 4 colonnes")[
      #blancs[#raw("def surface(longueur, largeur):\n····aire = longueur * largeur\n→   return aire", block: true)]
      #v(0.3em)
      #text(size: 14pt, fill: estompe)[les deux lignes semblent alignées]
    ],
    panneau("Le même fichier, tabulation sur 8")[
      #blancs[#raw("def surface(longueur, largeur):\n····aire = longueur * largeur\n→       return aire", block: true)]
      #v(0.3em)
      #text(size: 14pt, fill: brun)[le décalage apparaît]
    ],
  )

  #legende[
    `·` marque un espace, `→` une tabulation, comme l'éditeur les dessine.
    Les octets du fichier sont les mêmes des deux côtés : seul le réglage de
    l'éditeur change.
  ]

  #notes[
    Les deux lignes sont celles de `cours1/2c_erreurs/depart/surface.py` :
    la cinquième indentée par quatre espaces, la sixième par une tabulation.
    C'est le fichier que le TD 2c fera corriger ; le message d'erreur
    s'y lit à ce moment, ne pas le projeter ici.

    Python refuse ce mélange dans une même indentation, et le dit par
    `TabError`. Le message ne parle pas d'espace manquant : il dit que
    l'indentation mélange deux caractères. À l'œil nu, sur un éditeur réglé
    sur 4, rien ne se voit — c'est ce que montre la colonne de gauche.

    v2 : dans Notepad++, Paramètres, Préférences, Langage, « Remplacer par
    des espaces » ; VS Code, au cours 2, l'impose à 4 pour Python.

    Ne pas montrer ici comment afficher les blancs : le TD 2c s'en
    charge, et cela s'apprend en le faisant, pas en le regardant.

    Fins de ligne, à dire en passant : Windows en met deux (`CRLF`), Linux et
    macOS un seul (`LF`). Un même fichier n'a donc pas la même taille selon la
    machine, et une comparaison peut signaler toutes les lignes comme
    modifiées. Repris au cours 2 avec git.

    Le saut de ligne est un caractère comme les autres : « Ce que contient un
    fichier texte », en annexe, le compte sur un poème tenant sur une ligne.
  ]
]
