// Partie 1 du cours 2 v2 — l'éditeur de code. Incluse par `cours2_v2.typ`.
// Un fichier inclus n'hérite pas des imports de son appelant.
//
// Reprend les diapositives 44 et 45 du cours 1 de 2026 (édition, règles du
// langage), sans les reformuler. Celle de l'indentation vient du cours 1 v2
// (27/09/2026), avec le TD 2b qui s'en sert.
//
// Depuis le 28/09/2026, la partie ouvre la séance : l'éditeur est expliqué
// avant d'être configuré (TD 2a, en classe entière). La partie « Configurer
// l'éditeur de code » et son séparateur sont retirés.
//
// 04/11/2026 : « Chasse fixe et chasse proportionnelle » et la diapositive
// Markdown (`03_markdown.typ`) sont retirées. Ordre de la partie : le rappel du
// cours 1 (nouveau), « Visual Studio Code » (venue de `03b_vscode.typ`), « Les
// fonctions d'un IDE » (redessinée), la comparaison des trois outils (nouvelle),
// puis les deux diapositives d'aide syntaxique (retitrées). La page de cours
// (`notebook/01_editeur_de_code.md`) garde la chasse fixe et les anciens titres.
#import "../../../commun/prelude.typ": *
#import "../../../cours1/diapo/schemas.typ": souligne-ondule, blancs
#import "../schemas.typ": fenetre-vscode, schema-rappel-outils, schema-fonctions-ide, vignette-jupyterlab, vignette-spyder, vignette-vscode

#separateur(
  "L'éditeur de code",
  annonce: "Ce qu'un éditeur de code ajoute à un éditeur de texte.",
)

// --------------------------------------------
// Nouveau (v2), 04/11/2026.
#d("Rappel du cours 1 : édition et exécution")[
  #schema-rappel-outils()

  #notes[
    Faire raconter le TD 1c par la salle, sur le schéma, avant de passer à la
    diapositive suivante, qui garde la même disposition.

    À dire : après une modification dans Notepad++, il faut enregistrer le
    fichier, revenir dans Git Bash et relancer `python altitudes.py`.

    Le Bloc-notes n'a pas de coloration. Notepad++ colore le code d'après
    l'extension `.py`.

    `python raven.odt` répond `can't find '__main__' module` : un `.odt` est
    une archive ZIP (cours 1), et Python y cherche un programme. Sortie relevée
    avec Python 3.12.
  ]
]

// --------------------------------------------
// Venue de la partie « Configurer l'éditeur de code » (retirée le
// 28/09/2026) ; reprise de la diapositive 48 du cours 1 de 2026, avec une
// fenêtre dessinée (`../schemas.typ`).
// Déplacée après le rappel du cours 1 le 04/11/2026, sans changement.
#d("Visual Studio Code")[
  #annonce[
    L'éditeur du module a trois zones : l'arborescence du dossier ouvert, le
    fichier, et le terminal, qui part de ce dossier.
  ]

  #fenetre-vscode(hauteur: 240pt)

  #notes[
    Schéma de la fenêtre après la configuration du TD 2a. En bas, la barre
    d'état : position, indentation, encodage, fin de ligne, interpréteur
    (TD 2b).

    Générique : une extension par langage, et une configuration qui dépend
    du système. Le panneau git vient au TD 2c.

    Faire retrouver les trois zones sur les postes au début du TD 2a.

    La commande du terminal part du dossier ouvert, `cours2` : le chemin
    du programme est relatif à lui.

    Un éditeur de code enregistre du texte brut ; les couleurs et les
    numéros de ligne ne sont qu'un affichage.

    VS Code s'affiche en anglais par défaut ; le module ne demande pas d'en
    changer. Les intitulés cités dans les TD sont les intitulés anglais.
  ]
]

// --------------------------------------------
// Redessinée le 04/11/2026 : le tableau et son avertissement deviennent les
// zones d'une fenêtre, dans le dessin des vignettes de la diapositive suivante.
// « Connaître le langage » passe sur « Comparaison : JupyterLab, Spyder, VS
// Code ». Notes reprises, sauf leur première ligne.
#d("Les fonctions d'un IDE")[
  #schema-fonctions-ide()

  #legende[
    IDE : _integrated development environment_, environnement de développement
    intégré. Python doit être installé à part de VS Code, puis sélectionné dans
    l'éditeur (TD 2a).
  ]

  #notes[
    Lire le schéma zone par zone, avec l'outil du cours 1 que chaque zone
    reprend. L'aide syntaxique est détaillée en fin de partie.

    Zone en pointillés : des fenêtres qu'un IDE peut ajouter. Dans Spyder, les
    volets Debugger et Plots. Débogueur : arrêt sur une ligne, exécution pas à
    pas, valeur des variables.

    Notepad++ a déjà la coloration, la complétion et la recherche dans les
    fichiers. La limite entre un éditeur de texte et un IDE n'est pas stricte.

    Sur la légende : le bouton d'exécution est dans l'éditeur ; l'outil qu'il
    appelle est installé à part. La documentation
    de VSCode le dit pour le C++ : « The C/C++ extension doesn't include a C++
    compiler or debugger, since VS Code as an editor relies on command-line
    tools for the development workflow. » Les environnements sont au
    cours 5.

    Sur les langages : un IDE donne « special support for one or
    more programming languages », et le support des autres langages passe le
    plus souvent par des greffons (Wikipédia, _Integrated development
    environment_). Exemples si la question vient : RStudio ou l'IDE Arduino ne
    servent qu'un langage, Eclipse et VSCode s'étendent.

    Débogage : TD 1c de 2026, dans l'archive du book. Panneau
    git : au TD 2c.

    Microsoft présente VSCode comme un éditeur plutôt que comme un IDE,
    ses fonctions avancées venant d'extensions. Ne pas s'y attarder si la
    question ne vient pas.
  ]
]

// --------------------------------------------
// Nouveau (v2), 04/11/2026. Les lignes du tableau et la légende reprennent la
// page `annexes/notions/outils.md`.
#d("Comparaison : JupyterLab, Spyder, VS Code")[
  #{
    // `tableau` fixe sa taille de texte : la règle `show` passe après elle.
    show table.cell: set text(size: 14pt)
    tableau(
      columns: (auto, 1fr, 1fr, 1fr),
      align: left + horizon,
      inset: (x: 8pt, y: 6pt),
      [], vignette-jupyterlab(), vignette-spyder(), vignette-vscode(),
      [Tâche],
        [suivre un cours et exécuter ses exemples un à un],
        [écrire un programme de calcul, et regarder ses variables et ses figures],
        [écrire un programme de plusieurs fichiers, suivi avec git],
      [Fichiers `.py`],
        [éditeur simple, exécution dans un terminal de JupyterLab],
        [exécution par `F5`, ou par cellules `# %%`],
        [exécution avec l'extension Python],
      [Notebooks `.ipynb`],
        [ouverture et exécution],
        [conversion en fichier `.py`, ou plugin `spyder-notebook`],
        [ouverture et exécution avec l'extension Jupyter],
      [Autres langages],
        [par un autre noyau (R, Julia)],
        [aucun],
        [une extension par langage],
    )
  }

  #legende[
    Le module emploie JupyterLab et VS Code. D'autres cours emploient Spyder.
  ]

  #notes[
    Le module emploie VS Code parce qu'il sert aux projets suivis avec git et
    aux autres langages que les élèves rencontrent dans d'autres cours. Les
    élèves n'apprennent ainsi qu'un éditeur pour tous ces usages.

    Vignettes : dispositions par défaut, simplifiées. Sur Spyder, les onglets en
    haut à droite sont l'explorateur de variables, les graphiques, l'aide et
    les fichiers. Après `F5`, l'explorateur de variables et le volet de figures
    montrent l'état du programme.

    Spyder est livré avec Anaconda et installé sur les postes de la salle, dans
    l'environnement `base`. Il fonctionne sans réglage. Sur les postes, il faut
    installer les extensions Python et Jupyter dans VS Code et régler le
    terminal : TD 2a.

    Documentation de Spyder : « a powerful scientific environment written in
    Python, for Python ». Documentation de JupyterLab : « a next-generation
    web-based user interface for Project Jupyter ».

    Détail et tests de chaque outil : annexes, « Choisir entre JupyterLab, Spyder
    et VS Code » et « Spyder ».
  ]
]

// « Les fonctions d'édition de texte d'un IDE » retirée le 28/09/2026 : son
// tableau annonçait les trois diapositives suivantes.
// Retitrée le 04/11/2026 (« Texte brut et règles du langage ») ; première annonce
// réécrite, le reste sans changement. Le terme est posé sur « Les fonctions d'un
// IDE ».
#d("Aide syntaxique : coloration, soulignement")[
  #annonce[
    Une extension de l'éditeur contient les règles de syntaxe du langage.
    D'après ces règles, l'éditeur colore chaque catégorie de mot, sans modifier
    le fichier.
  ]

  #grid(
    columns: (1.15fr, 0.9fr, 0.95fr), column-gutter: 18pt,
    // Volontairement sans coloration : seule la colonne de droite en porte,
    // sans quoi la comparaison ne montrerait plus rien.
    panneau("Enregistré par un traitement de texte")[
      #raw(
        "<text:p text:style-name=\"P1\">\naltitude = 79.6</text:p>\n<text:p>print(altitude)</text:p>",
        block: true,
      )
    ],
    panneau("Le fichier d'un programme")[
      #raw("altitude = 79.6\nprint(altitude)", block: true)
    ],
    panneau("Affiché par l'éditeur de code")[
      ```python
      altitude = 79.6
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
      #raw("altitudes = [79.6, 103.2]") \
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

    À gauche, le `content.xml` d'un `.odt` (TD 1b de 2026, dans l'archive du book), le
    texte entre les balises. On n'écrit pas de code dans Word ni dans
    LibreOffice.

    Au milieu et à droite, le même fichier, octet pour octet. Ouvrir le même
    fichier dans le Bloc-notes le montre en une seconde.

    Faire nommer par la salle ce que la couleur distingue : les mots du langage
    et les fonctions connues, les nombres, le texte entre guillemets, les noms
    qu'on choisit.

    Sur le soulignement : un correcteur orthographique souligne le mot pendant
    qu'on tape, il n'attend pas l'impression. L'éditeur fait de même. Message
    relevé sous Python 3.12 ; il désigne ici la bonne ligne, ce qui n'est pas
    toujours le cas.

    Un langage a beaucoup moins d'exceptions que l'orthographe du français,
    et un logiciel peut donc en vérifier les règles de façon sûre.
  ]
]

// --------------------------------------------
// Reprise de la diapositive 47 du cours 1 de 2026. Passée du cours 1 v2 au
// cours 2 v2 le 27/09/2026, avec le TD des programmes fautifs (TD 2b).
// Retitrée le 04/11/2026 (« L'indentation, en espaces ou en tabulation »).
#d("Aide syntaxique : indentation")[
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
    Un éditeur de code emploie une police à chasse fixe, où toutes les lettres
    ont la même largeur. Python compte les espaces qui commencent une ligne ;
    il faut donc les voir.

    Les deux lignes sont celles de `cours2/2b_erreurs/depart/surface.py` :
    la cinquième indentée par quatre espaces, la sixième par une tabulation.
    Le TD 2b fera corriger ce fichier ; le message d'erreur s'y lit à ce
    moment, ne pas le projeter ici.

    Python refuse ce mélange dans une même indentation, et le dit par
    `TabError` : l'indentation mélange deux caractères. Sur un éditeur réglé
    sur 4, le mélange ne se voit pas (colonne de gauche).

    VS Code insère quatre espaces pour une tabulation dans un fichier
    Python.

    Les blancs s'afficheront après le réglage du TD 2a (« render
    whitespace ») ; le TD 2b s'en sert.

    Fins de ligne, à dire en passant : Windows en met deux (`CRLF`), Linux et
    macOS un seul (`LF`). Un même fichier n'a donc pas la même taille selon la
    machine, et une comparaison peut signaler toutes les lignes comme
    modifiées. Repris plus loin avec git.

    Le saut de ligne est un caractère comme les autres ; le cours 3 en
    compte les octets (`fichiers.ipynb`, § 5).
  ]
]
