// Partie 2 du cours 2 v2 — l'éditeur de code. Incluse par `cours2_v2.typ`.
// Un fichier inclus n'hérite pas des imports de son appelant.
//
// Reprend les diapositives 43 à 46 du cours 1 de 2026 (fonctions d'un IDE,
// édition, règles du langage, chasse fixe), sans les reformuler. Celle de
// l'indentation reste au cours 1 v2, pour le TD des programmes fautifs.
#import "../../../commun/prelude.typ": *
#import "../../../cours1/diapo/schemas.typ": souligne-ondule

#separateur-reprise(
  "L'éditeur de code",
  annonce: "Ce qu'un éditeur de code ajoute à un éditeur de texte.",
)

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
    tools for the development workflow. » Les environnements sont au
    cours 3.

    Sur la dernière ligne du tableau : un IDE donne « special support for one or
    more programming languages », et le support des autres langages passe le
    plus souvent par des greffons (Wikipédia, _Integrated development
    environment_). Exemples si la question vient : RStudio ou l'IDE Arduino ne
    servent qu'un langage, Eclipse et VSCode s'étendent.

    Débogage : en annexe. Panneau git : au TD 3a.

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

    À gauche, le `content.xml` d'un `.odt` (TD 1b du cours 1, en annexe), le
    texte noyé dans les balises. La règle, sans nuance : on n'écrit jamais de code dans Word ni
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

    Lien avec LibreOffice, manipulé au cours 1 : on y choisit une police
    pour la mise en page ; ici on la subit pour une raison technique.
  ]
]
