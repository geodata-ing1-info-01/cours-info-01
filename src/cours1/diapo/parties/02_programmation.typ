// Partie du cours 1 — incluse par `cours1.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": blancs, capture-ide, souligne-ondule

// ==================== Programmation et éditeur de code =====================

#separateur("Programmation et éditeur de code")
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

    Semer le facteur ×100 à ×1000 du cours 6 et du TD 7 : `numpy` délègue
    à du C compilé. Ne pas développer.

    Les noms de fichiers sont ceux des TD 1c et 1e à venir ; le dire
    une fois.

    Si question « Et Java ? » répondre en une phrase, les deux à la
    fois comme js et JIT
  ]
]

// --------------------------------------------
#d("Du code source aux instructions machine")[
  #annonce[
    Compiler enchaîne quatre étapes. Au bout, des instructions que le
    processeur exécute telles quelles.
  ]

  #chaine(
    ("préprocesseur", "un seul texte"),
    ("compilateur", "de l'assembleur"),
    ("assembleur", "des instructions machine"),
    ("éditeur de liens", "un exécutable"),
  )

  #v(0.5em)
  #face-a-face(
    panneau("Ce qu'a écrit un humain")[
      ```cpp
      int largeur = 1920;
      int hauteur = 1080;
      return largeur * hauteur;
      ```
    ],
    panneau("Ce que le processeur exécute")[
      ```
      mov   DWORD PTR -8[rbp], 1920
      mov   DWORD PTR -4[rbp], 1080
      mov   eax,  DWORD PTR -8[rbp]
      imul  eax,  DWORD PTR -4[rbp]
      ```
    ],
  )

  #legende[
    Une instruction machine fait une opération élémentaire : `mov` copie une
    valeur, `imul` en multiplie deux. Le processeur les exécute telles quelles,
    là où un interpréteur doit d'abord lire et analyser la ligne.
  ]

  #notes[
    Les quatre étapes sont celles que documente GCC : « Compilation can involve
    up to four stages: preprocessing, compilation proper, assembly and linking,
    always in that order. » Ne pas détailler l'éditeur de liens : il suffit de
    dire qu'il rassemble le programme et les bibliothèques en un seul fichier.

    L'assembleur affiché est celui que produit vraiment `g++` sur le code de
    gauche, il se refait :
    `g++ -S -O0 -masm=intel -fno-asynchronous-unwind-tables surface.cpp -o -`.
    Les quatre lignes correspondent aux trois du source.

    Lire une ligne à voix haute pour montrer qu'il n'y a rien de mystérieux :
    `mov DWORD PTR -8[rbp], 1920` veut dire « écris 1920 à cet emplacement de
    la mémoire ». `-8[rbp]` est une adresse, calculée à partir du repère `rbp`.

    D'où la différence de vitesse, si la question vient : les deux chemins
    finissent par les mêmes opérations élémentaires, mais l'interprété refait
    l'analyse du texte à chaque exécution, et à chaque tour de boucle.

    L'exécutable de `python3` est arrivé au bout de ce chemin : ce qui exécute
    du texte est soi-même un binaire. C'est la diapositive suivante. Le contenu
    d'un exécutable, octet par octet, est ouvert au cours 3.
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
    installé, alors qu'un exécutable compilé se lance seul. C'est ce que
    le TD 1e fera constater, et pourquoi la partie « Environnement
    de programmation » existe.

    Le navigateur interprète trois langages sans qu'on l'appelle «
    interpréteur » : le mot désigne un rôle, pas une catégorie de
    logiciel.
  ]
]

// --------------------------------------------
#d("Les fonctions d'un IDE")[
  #annonce[
    IDE, pour _integrated development environment_ : un logiciel qui réunit
    des fonctions pour aider à l'écriture, test et partage de code.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [La fonction], [Ce que l'éditeur en fournit],
    [Écrire le code],
      [coloration, indentation, complétion, soulignement des fautes],
    [Le lancer et le tester],
      [un terminal intégré et un bouton d'exécution, sans quitter la fenêtre],
    [Naviguer dans le projet],
      [l'arborescence à gauche, la recherche dans tous les fichiers],
    [Déboguer],
      [exécuter pas à pas, arrêter sur une ligne, lire les variables],
    [Connaître le langage],
      [certains IDE n'en servent qu'un ; d'autres s'étendent par extensions],
  )

  #avertissement[
    Un IDE ne contient pas forcément l'interpréteur ni le compilateur. Ils
    s'installent à part, et se configurent pour chaque langage et chaque
    système.
  ]

  #notes[
    Un éditeur de texte ordinaire ne fait que la première ligne du tableau.
    C'est l'intégration des autres qui fait l'environnement.

    L'avertissement est celui qui coûte le plus cher en séance : le bouton
    d'exécution est dans l'éditeur, pas l'outil qu'il appelle. La documentation
    de VSCode le dit pour le C++ : « The C/C++ extension doesn't include a C++
    compiler or debugger, since VS Code as an editor relies on command-line
    tools for the development workflow. » D'où la diapositive « De quoi
    compiler du C++ », et la partie « Environnement de programmation ».

    Sur la dernière ligne du tableau : un IDE donne « special support for one or
    more programming languages », et le support des autres langages passe le
    plus souvent par des greffons (Wikipédia, _Integrated development
    environment_). Exemples si la question vient : RStudio ou l'IDE Arduino ne
    servent qu'un langage, Eclipse et VSCode s'étendent.

    Débogage et panneau git sont nommés, pas montrés : cours 2.

    Microsoft présente VSCode comme un éditeur plutôt que comme un IDE,
    ses fonctions avancées venant d'extensions. Ne pas s'y attarder si la
    question ne vient pas.
  ]
]

// --------------------------------------------
#d("Les fonctions d'édition de texte d'un IDE")[
  #annonce[
    Programmer nécessite d'éditer des fichiers texte sans 'faute'.
    L'éditeur sert à rendre cela plus simple et rapide.
  ]

  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
    [Dans un éditeur de texte ordinaire], [Dans un éditeur de code],
    [une faute de frappe se découvre à l'exécution],
      [elle est soulignée pendant la frappe],
    [on cherche un fichier dans l'explorateur],
      [l'arborescence et la recherche sont dans la fenêtre],
    [une indentation fausse ne se voit pas],
      [les espaces s'affichent],
  )

  #legende[
    La colonne de droite est ce que cette partie détaille, ligne après ligne.
  ]

  #notes[
    Tout ce qui sera produit cette année passe par l'édition d'un fichier
    texte : le programme, ses réglages, sa documentation, et jusqu'à ce
    que git doit ignorer.

    La colonne de gauche n'est pas une caricature : c'est ce que fait
    quelqu'un qui écrit son code dans le Bloc-notes, et plusieurs l'auront
    fait au lycée. Montrer ce que cela coûte, sans se moquer.
  ]
]

// --------------------------------------------
#d("Texte brut et règles du langage")[
  #annonce[
    Un langage a une syntaxe définie. L'éditeur la connaît, par une extension,
    et colore chaque catégorie de mot sans rien ajouter au fichier.
  ]

  #grid(
    columns: (1.15fr, 0.9fr, 0.95fr), column-gutter: 18pt,
    // Volontairement sans coloration : seule la colonne de droite en porte,
    // sans quoi la comparaison ne montrerait plus rien.
    panneau("Enregistré par un traitement de texte")[
      #raw(
        "<text:p text:style-name=\"P1\">\naltitude = 128.4</text:p>\n<text:p>print(altitude)</text:p>",
        block: true,
      )
    ],
    panneau("Le fichier d'un programme")[
      #raw("altitude = 128.4\nprint(altitude)", block: true)
    ],
    panneau("Affiché par l'éditeur de code")[
      ```python
      altitude = 128.4
      print(altitude)
      ```
    ],
  )

  #v(0.5em)
  #annonce[
    Il souligne de même ce qui ne suit pas ces règles, sans rien lancer.
  ]

  #grid(
    columns: (auto, 1fr), column-gutter: 22pt, align: horizon,
    block(
      inset: (x: 18pt, y: 9pt), fill: gris,
      stroke: 1pt + accent.lighten(62%),
    )[
      #set text(size: 21pt)
      #set align(left)
      #raw("altitudes = [128.4, 131.0]") \
      #raw("for altitude in ")#souligne-ondule[#raw("altitudes")] \
      #raw("    print(altitude)")
    ],
    text(size: 16pt, fill: estompe)[
      Le deux-points manque. Sans l'éditeur, la faute n'apparaîtrait qu'au
      lancement : #raw("SyntaxError: expected ':'").
    ],
  )

  #notes[
    Deux services tirés de la même chose, les règles écrites du langage : la
    couleur, puis le soulignement.

    À gauche, le `content.xml` ouvert en début de séance, le texte noyé dans
    les balises. La règle, sans nuance : on n'écrit jamais de code dans Word ni
    dans LibreOffice. 

    Au milieu et à droite, le même fichier, octet pour octet. Ouvrir le même
    fichier dans le Bloc-notes le montre en une seconde.

    Faire nommer par la salle ce que la couleur distingue : les mots du langage
    et les fonctions connues, les nombres, le texte entre guillemets, les noms
    qu'on choisit.

    Sur le soulignement : un correcteur orthographique souligne le mot pendant
    qu'on tape, il n'attend pas l'impression. L'éditeur fait de même. Message
    relevé sous Python 3.12 ; il désigne ici la bonne ligne, ce qui n'est pas
    toujours le cas 

    Sur la chasse fixe : toutes les lettres y ont la même largeur, alors qu'une
    police proportionnelle fait le `i` plus étroit que le `m`. L'intérêt n'est
    pas esthétique — elle rend les espaces comptables, trois se distinguent de
    quatre et une tabulation se repère, ce dont Python a besoin. Ne pas
    confondre l'indentation, qui est dans le fichier et compte, avec la
    coloration et la police, qui n'y sont pas.

    Un langage a beaucoup moins d'exceptions que l'orthographe du français. 
    C'est ce qui rend la vérification automatique possible : 
    on ne peut pas écrire un logiciel qui corrige un
    texte français de façon sûre, on peut en écrire un qui vérifie un programme.
  ]
]

#d("Chasse fixe et chasse proportionnelle")[
  #annonce[
    Un éditeur de code emploie une police à chasse fixe, où toutes les lettres
    ont la même largeur. Le même programme dans la police d'un traitement de
    texte :
  ]

  #face-a-face(
    panneau("Chasse fixe (éditeur de code)")[
      #raw("def surface(longueur, largeur):\n    aire = longueur * largeur\n    if aire > 250:\n        categorie = \"grande\"\n    else:\n        categorie = \"petite\"\n    return aire, categorie", block: true)
    ],
    // Le même texte, à la même taille, dans la police du corps : seules les
    // largeurs de caractère changent.
    panneau("Chasse proportionnelle (traitement de texte)")[
      #{
        show raw: set text(font: police-texte)
        raw("def surface(longueur, largeur):\n    aire = longueur * largeur\n    if aire > 250:\n        categorie = \"grande\"\n    else:\n        categorie = \"petite\"\n    return aire, categorie", block: true)
      }
    ],
  )

  #legende[
    Même texte, même taille, deux polices. À droite, rien ne dit de combien
    chaque ligne est décalée.
  ]

  #notes[
    Faire chercher par la salle ce qui se perd à droite avant de le dire :
    l'entrée du `if`, celle du `else`, et le fait que `categorie` est au même
    niveau des deux côtés.

    L'intérêt de la chasse fixe n'est pas esthétique. Python compte les
    espaces qui commencent une ligne ; il faut donc les voir. Une police
    proportionnelle fait le `i` plus étroit que le `m`, et deux lignes
    décalées pareil ne le paraissent plus.

    Ne pas confondre l'indentation, qui est dans le fichier et compte, avec
    la police et la coloration, qui n'y sont pas.

    Lien avec LibreOffice, manipulé en début de séance : on y choisit une
    police pour la mise en page ; ici on la subit pour une raison technique.
  ]
]

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
    Les deux lignes sont celles de `cours1/1d_erreurs/surface.py` :
    la cinquième indentée par quatre espaces, la sixième par une tabulation.
    C'est le fichier que le TD 1d fera corriger ; le message d'erreur
    s'y lit à ce moment, ne pas le projeter ici.

    Python refuse ce mélange dans une même indentation, et le dit par
    `TabError`. Le message ne parle pas d'espace manquant : il dit que
    l'indentation mélange deux caractères. À l'œil nu, sur un éditeur réglé
    sur 4, rien ne se voit — c'est ce que montre la colonne de gauche.

    Le réglage se lit en bas à droite de l'éditeur, `Spaces: 4`. L'extension
    Python l'impose à 4, convention du langage ; un fichier venu d'ailleurs
    peut être écrit autrement.

    Ne pas montrer ici comment afficher les blancs : le TD 1d s'en
    charge, et cela s'apprend en le faisant, pas en le regardant.

    Fins de ligne, à dire en passant : Windows en met deux (`CRLF`), Linux et
    macOS un seul (`LF`). Un même fichier n'a donc pas la même taille selon la
    machine, et une comparaison peut signaler toutes les lignes comme
    modifiées. Repris au cours 2 avec git.

    Le saut de ligne est un caractère comme les autres : « Ce que contient un
    fichier texte », en annexe, le compte sur un poème tenant sur une ligne.
  ]
]
