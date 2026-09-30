// TD 2a du cours 1 — « Configurer l'éditeur de code, et lancer un programme ».
//
// Inclus par `cours1.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`, qui
// en tire la feuille de TD déposée dans le dossier annoncé. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": capture-ide

#let td = (
  numero: "2a",
  titre: "Configurer l'éditeur de code, et lancer un programme",
  annonce: "Objectif : configurer un IDE pour Python, puis exécuter un programme de trois façons : en entier, ligne à ligne, pas à pas",
  dossier: "cours1/2a_vscode_python/",
  duree: "25′",
)
#separateur-td(..td)
#d("Visual Studio Code")[
  #align(center, capture-ide(hauteur: 330pt))

  #notes[
    L'annonce est passée ici pour laisser la place à la capture : l'éditeur du
    module, générique, une extension par langage, et trois zones aujourd'hui.

    Dire le choix et ses conséquences : VSCode n'est pas le seul éditeur, c'est
    celui du module. Il est générique, donc il faut le configurer pour chaque
    langage, par une extension, et la configuration dépend du système — c'est
    ce que la diapositive précédente vient de montrer sur le compilateur C++.

    Faire ouvrir la fenêtre en même temps, et faire retrouver les trois zones
    chez eux : les couleurs de la capture ne servent qu'à les nommer une fois.

    À faire remarquer sur la capture, sans l'écrire : `trajet.png` vient
    d'apparaître dans l'arborescence, produit par la commande tapée en bas.
    Les trois zones se répondent.

    Un éditeur de code n'est pas un traitement de texte : il enregistre du
    texte brut, et ce qu'il ajoute à l'écran — couleurs, numéros de ligne
    — est un affichage, pas du contenu.

    Les trois zones suffisent aujourd'hui ; débogueur, extensions et git
    viennent aux cours 2 et 3.

    VSCode s'affiche en anglais par défaut ; le module ne demande pas d'en
    changer. Les intitulés cités plus loin sont donc les intitulés anglais.
  ]
]

// Repli dessiné de la page d'accueil de Navigator, employé quand la capture
// n'est pas là : la liste des environnements en haut, une fiche par
// application en dessous, chacune avec son bouton de lancement.
#let _fiche-navigator(nom, retenue: false) = block(
  width: 100%, height: 84pt, inset: (x: 7pt, y: 8pt),
  stroke: if retenue { 1.4pt + accent } else { 0.8pt + gris.darken(12%) },
)[
  #align(center)[
    #text(size: 13.5pt, weight: if retenue { demi-gras } else { "regular" })[#nom]
    #v(14pt)
    #box(inset: (x: 9pt, y: 3pt), radius: 3pt, stroke: 0.8pt + estompe,
         text(size: 11.5pt, fill: estompe)[Launch])
  ]
]

#let _navigator-dessine = fenetre("Anaconda Navigator — Home", hauteur: 226pt)[
  #grid(
    columns: (auto, 1fr), column-gutter: 12pt, align: horizon,
    box(inset: (x: 10pt, y: 5pt), radius: 3pt, stroke: 0.9pt + estompe,
        text(size: 14pt, font: police-code)[base (root)]),
    text(size: 13pt, fill: estompe)[la liste des environnements installés],
  )
  #v(16pt)
  #grid(
    columns: (1fr, 1fr, 1fr, 1fr), column-gutter: 12pt,
    _fiche-navigator("JupyterLab"),
    _fiche-navigator("Spyder"),
    _fiche-navigator("Qt Console"),
    _fiche-navigator("VS Code", retenue: true),
  )
]

#d("Les deux temps du TD")[
  #annonce[
    VS Code ne connaît d'avance ni le langage du fichier ouvert, ni
    l'interpréteur Python à utiliser. Il faut donc configurer l'IDE avant de
    pouvoir l'utiliser pleinement.
  ]

  #v(0.5em)
  #grid(
    columns: (1.15fr, 1fr), column-gutter: 28pt,
    [
      #text(size: 18pt, fill: accent, weight: demi-gras)[Configurer l'IDE]
      #v(0.6em)
      #panneau("Le langage")[
        #text(size: 17pt)[
          Installation de l'extension Python dans VS Code.
        ]
      ]
      #v(0.8em)
      #panneau("L'interpréteur")[
        #text(size: 17pt)[
          Configurer l'interpréteur Python pour utiliser celui fourni par
          Anaconda.
        ]
      ]
    ],
    [
      #text(size: 18pt, fill: accent, weight: demi-gras)[Lancer un programme]
      #v(0.6em)
      #text(size: 17pt)[
        Ouvrir le dossier du TD. Trois façons : en entier, ligne à ligne, pas
        à pas.
      ]
    ],
  )

  #notes[
    La configuration se fait une fois sur le poste, et elle tient pour
    l'année ; le lancement est le travail de la séance. Le dire, pour que
    l'installation ne passe pas pour le contenu du TD.

    Deux réglages parce qu'il y a deux inconnues : quel langage l'éditeur
    doit reconnaître, et quel interpréteur il doit appeler. Les annoncer
    ensemble évite la question « pourquoi on installe encore quelque
    chose ? » deux diapositives plus loin.

    Ce qu'est un environnement Python n'est pas encore expliqué, et n'a pas
    à l'être ici : la partie 4 s'en charge, et le TD 4a le fabrique. Pour
    aujourd'hui, un interpréteur, celui qu'Anaconda a posé.
  ]
]

#d("La page d'accueil d'Anaconda Navigator")[
  #annonce[
    En haut, le Python dans lequel Navigator lancera ce qu'on ouvre ; en
    dessous, une fiche par application, chacune avec son bouton *Launch*.
  ]

  #align(center, illustration(
    "/illustrations/cours1/anaconda_navigator_accueil.png",
    _navigator-dessine,
    hauteur: 236pt,
  ))

  #legende[
    #if captures-disponibles [
      Page d'accueil de Navigator, documentation Anaconda.
    ]
    Après l'installation, la liste du haut ne contient que `base (root)`.
  ]

  #notes[
    La capture sert à ce qu'un schéma ne montre pas : le nombre réel de
    fiches, et le fait que VS Code est l'une d'elles parmi une vingtaine.
    Faire retrouver la sienne plutôt que la désigner.

    `base (root)` est l'environnement livré avec Anaconda, et le seul tant
    qu'aucun autre n'a été créé. La doc Anaconda le donne pour sélectionné
    au démarrage de Navigator. Ne pas commenter le mot « environnement »
    aujourd'hui : il est nommé, il sera expliqué à la partie 4.

    Les fiches ne sont pas les mêmes d'un poste à l'autre, et une
    application non installée porte *Install* à la place de *Launch* : le
    dire avant qu'on le remarque. Seule celle de VS Code sert aujourd'hui.
  ]
]

#d("Lancer VS Code depuis Anaconda")[
  #annonce[
    Sur les postes de la salle, VS Code se lance depuis Anaconda Navigator :
    il est alors configuré pour utiliser l'interpréteur Python affiché en haut
    de la page d'accueil, sans aucun réglage préalable.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous observez],
    [1], [menu Démarrer #sym.arrow.r Anaconda Navigator], [la page d'accueil, une fiche par application],
    [2], [en haut, lire la liste déroulante], reponse[une seule entrée, `base (root)`, déjà sélectionnée],
    [3], [fiche VS Code #sym.arrow.r Launch], reponse[VS Code s'ouvre],
    [4], [Terminal #sym.arrow.r Nouveau terminal, taper `python --version`], reponse[un numéro de version, sans message d'erreur],
  )

  #legende[
    L'autre chemin, VS Code lancé depuis le bureau, marche aussi, mais son
    terminal demande un réglage, plus loin dans ce TD.
  ]

  #notes[
    Doc Anaconda, « Visual Studio Code » : « launch the application from
    Navigator 1.9.12 or later by clicking the VS Code tile on the Home
    page » ; « it will automatically use the Python interpreter in the
    currently selected environment ». D'où l'étape 2 avant l'étape 3 : ce
    qui est affiché en haut décide du Python que VS Code recevra.

    Ce que la doc ne dit pas, et qui est à vérifier sur un poste de la salle
    avant la séance : l'étape 4. Navigator lance VS Code avec les variables
    de l'environnement sélectionné ; le terminal intégré en hérite, et
    `python` devrait répondre sans qu'aucun script d'activation ne tourne.
    Si PowerShell affiche quand même une erreur `activate.ps1`, appliquer le
    réglage de la diapositive « VS Code hors Anaconda ».

    Étape 4 : le numéro exact dépend de la version d'Anaconda installée sur
    les postes, d'où la réponse volontairement vague. Le relever avant la
    séance pour pouvoir dire s'ils lisent la bonne.

    L'extension Python n'est pas installée par Navigator : c'est l'objet de
    la diapositive suivante. Sur un poste où elle l'est déjà, la barre
    d'état nomme l'interpréteur dès l'ouverture.

    Ne pas ouvrir Spyder ni Jupyter depuis Navigator aujourd'hui : une
    application, un TD.
  ]
]
#d("Installer l'extension d'un langage")[
  #annonce[
    Une extension s'installe depuis le panneau Extensions, en cherchant son
    identifiant. Il en faut une par langage.
  ]

  #tableau(
    columns: (1.1fr, 1fr),
    align: left + horizon,
    [Ce qu'il faut faire], [Ce que vous observez],
    [Fichier #sym.arrow.r Ouvrir le dossier, sur `cours1/2a_vscode_python/`],
      [deux programmes, `bonjour.py` et `altitudes.py`, et un `README.md`],
    [Ouvrir `bonjour.py` avant toute installation],
      reponse[le texte est déjà coloré : l'éditeur connaît Python de naissance],
    [`Ctrl` + `Maj` + `X`, chercher `ms-python.python`, installer],
      reponse[Pylance et le débogueur s'installent avec, et la barre d'état
              propose un interpréteur],
  )

  #legende[
    Chercher l'identifiant, `ms-python.python`, et jamais le nom affiché. Une
    extension installée le reste, pour les séances suivantes et les autres
    cours.
  ]

  #notes[
    La démarche vaut pour tout langage nouveau : ouvrir le panneau, taper
    l'identifiant, installer. C'est le motif à retenir, et il se refera tel
    quel à chaque langage ajouté.

    Chercher l'identifiant en chasse fixe et non le nom affiché : plusieurs
    extensions non officielles portent le même titre. Celle de Microsoft
    entraîne Pylance, qui vérifie l'écriture, et le débogueur ; il n'y a donc
    qu'une extension à chercher. Identifiants relevés sur le poste de
    préparation.

    Deuxième ligne, la surprise voulue : la coloration ne vient pas de
    l'extension, elle est fournie d'origine pour les langages courants. Ce
    que l'extension apporte vient après : l'interpréteur, l'exécution, la
    vérification des règles d'écriture. Cette vérification porte sur les
    règles d'écriture et non sur le sens, un programme pouvant être
    irréprochable pour elle et faire le contraire de ce qu'on voulait.

    Ne pas rouvrir ici le sens de « extension » appliqué au nom d'un
    fichier : c'est le propos du TD 1a. Si la question vient, une phrase
    suffit, le même mot pour deux choses sans rapport.

    L'éditeur n'a pas pu être piloté sur le poste de préparation : la
    proposition automatique de l'extension C/C++ dépend d'un réglage, à
    vérifier en salle.

    Poste sans réseau : les extensions ne s'installent pas. Le prévoir,
    car la suite du TD en dépend cette fois.
  ]
]
#d("La palette de commandes et les réglages")[
  #annonce[
    Les commandes et les réglages se cherchent par leur nom, sans parcourir
    les menus. Quatre panneaux, et les raccourcis qui les ouvrent.
  ]

  #tableau(
    columns: (auto, 82pt, 1fr),
    align: left + horizon,
    [], [Raccourci], [Rôle],
    [La palette de commandes], [`Ctrl` + `Maj` + `P`], [taper le début d'un nom : « Python: Select Interpreter »],
    [Les réglages], [`Ctrl` + `,`], [chercher un mot : « default profile », « render whitespace »],
    [Les extensions], [`Ctrl` + `Maj` + `X`], [chercher un identifiant : `ms-python.python`],
    [Le terminal], [`Ctrl` + `ù`], [ouvrir, masquer, rouvrir],
    [Le fichier `settings.json`], [], [les mêmes réglages, écrits en texte],
  )

  #legende[
    Intitulés de l'interface en anglais. Les réglages ont deux niveaux :
    *User*, pour vous sur ce poste, et *Workspace*, rangé avec le projet.
  ]

  #notes[
    La palette est ce qui rend l'éditeur apprenable : on n'a pas à
    savoir où est un menu, on tape ce qu'on veut. Toutes les consignes du
    module passent par elle, à commencer par le choix de l'interpréteur.

    Les réglages sont des fichiers texte, `settings.json`, et c'est ce qui
    permet d'en donner un par écrit (diapositive « VS Code hors Anaconda »)
    puis de le versionner avec un projet quand il est au niveau Workspace,
    dans `.vscode/settings.json`. Ouvrir le JSON une fois devant eux, sans y
    écrire. On l'atteint par la palette, « Open User Settings (JSON) ».

    Chaque réglage porte un nom en trois parties, `a.b.c` : le dire en
    montrant la barre de recherche, c'est ce qui rend la liste navigable.

    `Ctrl` + `ù` ouvre le terminal, et le menu Terminal fait la même chose
    pour qui a un clavier différent.

    `Ctrl` + `ù` est le raccourci du terminal sur un clavier français
    (#raw("Ctrl+`") sur un clavier américain) : à vérifier sur les postes,
    le menu Terminal fait la même chose.

    « Developer: Reload Window » sert quand une extension vient d'être
    installée ou un réglage changé et que rien ne bouge : c'est la doc
    Anaconda elle-même qui le conseille pour un environnement qui
    n'apparaît pas dans la liste.
  ]
]
#d("Choisir l'interpréteur Python")[
  #annonce[
    Plusieurs Python peuvent coexister sur une machine. Désigner celui de
    l'éditeur suffit : les terminaux qu'il ouvre ensuite emploient le même.
  ]

  #tableau(
    columns: (auto, 1.2fr, 1fr),
    align: left + horizon,
    [Où], [Ce qu'il faut faire], [Ce qui le prouve],
    [Dans l'éditeur],
      [`Ctrl` + `Maj` + `P`, « Python: Select Interpreter », choisir celui d'Anaconda],
      [le terminal ouvert ensuite commence par `(base)`],
    [Windows, hors éditeur],
      [menu Démarrer, chercher « Anaconda Prompt »],
      [l'invite commence par `(base)`],
    [Linux, macOS],
      [un terminal ordinaire suffit],
      [l'invite commence par `(base)`],
  )

  #legende[
    Le nom entre parenthèses, en tête d'invite, désigne le Python qui
    répondra. C'est la seule marque visible, et elle se relit avant chaque
    installation.
  ]

  #notes[
    Première ligne, la seule à retenir aujourd'hui : la documentation de VSCode
    est explicite, « when you open a terminal in VS Code, the extension
    automatically activates your selected Python environment so that `python`,
    `pip`, and related commands use the correct interpreter ». Le terminal
    s'aligne donc sur l'interpréteur choisi, à condition qu'il s'y prête,
    c'est la diapositive suivante.

    La liste proposée par « Select Interpreter » cite un chemin par Python
    trouvé. Celui d'Anaconda porte `anaconda3` dans son chemin et `base` pour
    nom ; sur un poste où un autre Python est installé, c'est là que la
    confusion se joue. Faire lire le chemin, pas seulement le nom.

    Ce choix évite le `ModuleNotFoundError` de fin de séance, le terminal
    pouvant ouvrir un autre Python. Il ne coûte rien aujourd'hui, aucune
    bibliothèque n'étant importée.

    Les postes de la salle ont Anaconda, d'où l'invite de commandes d'Anaconda (« Anaconda Prompt » du menu
    Démarrer). `cmd` et PowerShell ne connaissent pas `conda` tant qu'ils n'ont
    pas été initialisés : première cause de « la commande n'existe pas ».

    `base` est le nom du Python livré avec Anaconda, et le seul aujourd'hui.
    Pourquoi il porte un nom, et comment on en fabrique un autre, est
    l'objet de la partie 4 et du TD 4a. Ne pas anticiper.
  ]
]
#d("VS Code hors Anaconda : changer de terminal")[
  #annonce[
    Lancé depuis le bureau, VS Code ouvre un terminal PowerShell, qui refuse le
    script d'activation. Sans droits d'administrateur, on lui donne le terminal
    de l'invite de commandes d'Anaconda.
  ]

  #block(width: 100%, inset: (x: 10pt, y: 6pt), fill: gris)[
    #set text(size: 13pt)
    #raw("… \\activate.ps1 cannot be loaded because running scripts is disabled on this system.")
  ]

  #v(0.2em)
  #text(size: 14pt, fill: estompe)[Palette, « Open User Settings (JSON) », puis ajouter :]
  #block(width: 100%, inset: (x: 10pt, y: 7pt), fill: gris,
         stroke: 0.8pt + gris.darken(15%))[
    #set text(size: 15.5pt)
    #raw(lang: "json", "\"terminal.integrated.profiles.windows\": {\n  \"Anaconda Prompt\": {\n    \"path\": \"C:\\\\Windows\\\\System32\\\\cmd.exe\",\n    \"args\": [\"/K\", \"C:\\\\ProgramData\\\\anaconda3\\\\Scripts\\\\activate.bat\", \"C:\\\\ProgramData\\\\anaconda3\"]\n  }\n},\n\"terminal.integrated.defaultProfile.windows\": \"Anaconda Prompt\"")
  ]

  #legende[
    Les chemins d'Anaconda sont ceux du raccourci « Anaconda Prompt » : clic
    droit #sym.arrow.r Propriétés #sym.arrow.r Cible. Puis ouvrir un nouveau
    terminal : l'invite commence par `(base)`.
  ]

  #notes[
    Le message vient de la stratégie d'exécution de PowerShell, `Restricted`
    par défaut sous Windows. L'issue vscode-python #2559 en fait le tour, et
    ses solutions ont chacune une condition : `Set-ExecutionPolicy
    RemoteSigned -Scope CurrentUser` marche sans droits d'administrateur,
    sauf si une stratégie de groupe fixe la politique, ce qui est le cas
    probable en salle ; un profil PowerShell lancé avec `-ExecutionPolicy
    ByPass` et `conda-hook.ps1` (dernier message utile du fil) est dans le
    même cas ; le mécanisme d'activation par variables d'environnement de
    l'extension (#11039, par défaut depuis fin 2023) n'exécute aucun script,
    mais la version installée sur les postes a montré l'erreur. D'où `cmd` :
    `activate.bat` n'est pas soumis à la stratégie, c'est ce que fait le
    raccourci « Anaconda Prompt », et c'est la solution que les promotions
    précédentes avaient trouvée.

    Le chemin `C:\ProgramData\anaconda3` vaut pour une installation
    « tous les utilisateurs » ; une installation personnelle est dans
    `C:\Users\<nom>\anaconda3`. Ne pas le deviner : le lire dans la cible
    du raccourci, qui contient la ligne complète à recopier.

    À faire une fois par poste, au niveau User. Les guillemets et les
    doubles barres obliques inverses sont ceux du format JSON, à recopier
    tels quels ; si `settings.json` contient déjà des réglages, ajouter
    ceux-ci avant l'accolade finale, séparés par une virgule.

    Variante plus simple si `conda` répond déjà dans un `cmd` ordinaire du
    poste : `"terminal.integrated.defaultProfile.windows": "Command Prompt"`
    suffit. Essayer d'abord celle-là.

    Sous macOS et Linux, rien de tout cela : le terminal de l'éditeur est
    un shell ordinaire, et l'activation ne pose pas de problème.
  ]
]
#d("Le programme du TD")[
  #annonce[
    Six lignes qui calculent une moyenne d'altitudes.
  ]

  #face-a-face(
    panneau[`altitudes.py`][
      ```python
      altitudes = [128.4, 131.0, 127.6]
      total = 0
      for altitude in altitudes:
          total = total + altitude
      moyenne = total / len(altitudes)
      print(f"moyenne : {moyenne:.1f} m")
      ```
    ],
    panneau("Lancé en entier")[
      ```console
      $ python altitudes.py
      moyenne : 129.0 m
      ```
      #v(0.4em)
      #text(size: 14pt, fill: estompe)[
        Une seule ligne de sortie, celle du `print` final. Ce qui s'est
        passé entre-temps n'est pas visible.
      ]
    ],
  )

  #legende[
    Sortie réelle, Python 3.12. La moyenne de 128,4, 131,0 et 127,6 vaut bien
    129,0.
  ]

  #notes[
    Six lignes, une boucle donc un état qui change, un résultat vérifiable
    de tête : le `hello world` n'avait aucune de ces propriétés.

    Les altitudes sont celles de « Coloration syntaxique », devenues un
    programme qui tourne.

    Ce programme ne montre que sa dernière ligne ; les deux autres façons,
    la session interactive et le pas à pas, servent à voir ce qu'il fait
    entre le début et la fin.
  ]
]
#d("Lancer le programme")[
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire],
    [1], [Fichier #sym.arrow.r Ouvrir le dossier, puis choisir `cours1/2a_vscode_python/`],
    [2], [`Ctrl` + `Maj` + `P`, « Python: Select Interpreter », choisir celui d'Anaconda],
    [3], [Terminal #sym.arrow.r Nouveau terminal : il s'ouvre en bas, dans `2a_vscode_python/`, l'invite commence par `(base)`],
    [4], [taper `python altitudes.py`, puis Entrée],
  )

  #legende[
    Deux autres chemins pour le même lancement : le bouton d'exécution en haut
    à droite, et le menu Run #sym.arrow.r Run Without Debugging (`Ctrl` +
    `F5`). L'un comme l'autre écrit sa commande dans le terminal avant de
    l'exécuter, et c'est cette commande qu'il faut savoir écrire : elle est
    identique sur les trois systèmes.
  ]

  #notes[
    Projeter les étapes une par une : une étape sous-entendue est une étape
    où la moitié de la salle s'arrête sans le dire.

    Rien n'apparaît dans l'arborescence : lancer un programme Python ne laisse
    rien sur le disque. C'est vérifié pour de bon au TD 2c, facultatif,
    quand le C++ produira un fichier.

    Le bouton et le menu exécutent avec l'interpréteur sélectionné, pas
    forcément celui qu'on croit : c'est l'origine du `ModuleNotFoundError`
    annoncé à la partie 4. Les montrer après le terminal, jamais avant.
  ]
]
#d("Python en interactif")[
  #annonce[
    Dans le même terminal, taper `python` sans nom de fichier ouvre une session
    interactive : chaque ligne est lue, exécutée, et son résultat affiché
    aussitôt.
  ]

  ```console
  $ python
  Python 3.12.14 (main, Sep  2 2026, 23:27:36) [GCC 15.3.0] on linux
  >>> altitudes = [128.4, 131.0, 127.6]
  >>> total = 0
  >>> for altitude in altitudes:
  ...     total = total + altitude
  ...
  >>> total
  387.0
  >>> total / len(altitudes)
  129.0
  >>> exit()
  ```

  #legende[
    Session réelle. `total` s'affiche sans `print` : c'est propre à la session
    interactive, et c'est ce qui permet de regarder à l'intérieur.
  ]

  #notes[
    Faire remarquer les trois chevrons : c'est l'invite de Python, pas
    celle du terminal. Les confondre produit un `SyntaxError` quand on
    tape une commande du système. Les trois points sont la suite d'un bloc
    commencé.

    On entre par `python`, on sort par `exit()` ou `Ctrl` + `D`. Le dire
    tout de suite.

    La session donne accès à `total`, que le script ne montrait pas. Si la
    salle suit, refaire la boucle en affichant `total` à chaque tour :
    128,4 puis 259,4 puis 387,0.

    Un script se relance à l'identique et ne laisse rien à l'écran ; une
    session montre tout et ne laisse rien sur le disque. Deux usages, pas
    deux niveaux.

    Amorce de la dernière partie : un notebook est cette session, avec le
    texte conservé autour.
  ]
]
#d("En option : sans VS Code, depuis l'invite de commandes d'Anaconda")[
  #annonce[
    L'éditeur n'est qu'une fenêtre autour du terminal. Tout ce qui précède se
    refait dans l'invite de commandes d'Anaconda seule, pour le voir.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut taper], [Ce que vous observez],
    [1], [menu Démarrer #sym.arrow.r Anaconda Prompt], [l'invite commence par `(base)`],
    [2], [`cd `, puis glisser le dossier `2a_vscode_python` dans la fenêtre, Entrée], reponse[le chemin collé apparaît dans l'invite],
    [3], [`python altitudes.py`], reponse[la même sortie que dans l'éditeur],
    [4], [`python`, les lignes de la session interactive, `exit()`], reponse[le même `129.0`],
  )

  #legende[
    Ce que VS Code faisait à votre place : se placer dans le dossier du projet,
    à l'étape 2.
  ]

  #notes[
    Facultatif, pour ceux qui ont fini, ou pour un poste où VS Code résiste.
    L'intérêt est de faire voir que l'éditeur n'ajoute rien à l'exécution :
    le terminal intégré et l'invite de commandes d'Anaconda lancent le même `python`.

    Étape 2 : glisser un dossier depuis l'explorateur dans la fenêtre du
    terminal colle son chemin complet, entre guillemets s'il contient un
    espace. C'est le moyen le plus sûr de ne pas taper un chemin faux ;
    `cd` pour lui-même est au cours 2. Sous Windows, `cd /d` si le dossier
    est sur un autre disque que `C:`.

    L'invite de commandes d'Anaconda ouvre déjà `(base)`, donc aucune activation à taper
    aujourd'hui. C'est au TD 4a, une fois un second Python fabriqué, que
    `conda activate` prendra un sens. Sous macOS et Linux, un terminal
    ordinaire remplace l'invite de commandes d'Anaconda.
  ]
]
#d("Exécuter pas à pas : poser un arrêt, puis lancer")[
  #annonce[
    Le débogueur arrête le programme sur une ligne choisie et laisse regarder
    les variables, sans rien ajouter au code. D'abord l'arrêt, puis le
    lancement.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous observez],
    [1], [ouvrir `altitudes.py`, cliquer dans la marge à gauche du numéro de la ligne 4], [un point rouge : le programme s'y arrêtera],
    [2], [`F5`], [en haut, VS Code demande quoi déboguer],
    [3], [choisir « Python Debugger », puis « Python File »], reponse[le programme démarre et s'arrête ligne 4, surlignée en jaune],
    [4], [regarder à gauche, panneau Run and Debug (`Ctrl` + `Maj` + `D`)], reponse[Variables : `altitudes`, `total` à `0` ; la barre de boutons en haut],
  )

  #legende[
    La question de l'étape 2 ne vient qu'au premier lancement : ne rien créer
    d'autre, ne pas enregistrer de configuration. Le point rouge est un réglage
    de l'éditeur, le fichier n'a pas changé.
  ]

  #notes[
    Les deux premières façons montrent le début et la fin ; celle-ci
    montre le milieu, ligne par ligne. Réflexe à installer : on ne sème
    pas des `print`, on pose un point d'arrêt.

    Ligne 4 est choisie exprès, c'est le corps de la boucle : l'arrêt se
    répète trois fois et `total` change sous leurs yeux.

    Étape 3 : l'extension propose « Python File », « Module », « Django »…
    Le premier. Si VS Code propose de créer `launch.json`, refuser : c'est
    pour plus tard. Étape 4 : le panneau s'ouvre de lui-même au premier
    arrêt ; le raccourci sert quand il a été fermé.

    Raccourcis par défaut, relevés dans la documentation de VSCode et non
    sur les postes : vérifier que personne n'a un jeu modifié.
  ]
]
#d("Exécuter pas à pas : avancer et lire les variables")[
  #annonce[
    Une ligne à la fois, avec `F10`. À chaque arrêt, prédire la valeur de
    `total` avant de la lire.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Bouton], [Touche], [Ce qu'il fait],
    [Continue], [`F5`], [reprend jusqu'au prochain arrêt, ou jusqu'à la fin],
    [Step Over], [`F10`], [exécute la ligne surlignée et s'arrête à la suivante],
    [Step Into], [`F11`], [entre dans la fonction appelée — pas aujourd'hui],
    [Restart], [`Ctrl` + `Maj` + `F5`], [recommence du début],
    [Stop], [`Maj` + `F5`], [arrête le programme],
  )

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous observez],
    [5], [`F10`, trois fois, en regardant Variables], reponse[`total` : `128.4`, puis `259.4`, puis `387.0`],
    [6], [`F5`], reponse[le programme finit : `moyenne : 129.0 m` dans le terminal],
  )

  #notes[
    Faire prédire la valeur avant chaque `F10` : c'est le seul moment du
    TD où ils calculent, et c'est ce qui rend la boucle réelle.

    La ligne surlignée est celle qui va s'exécuter, pas celle qui vient de
    l'être : la confusion est fréquente à la première lecture de `total`.

    Ne pas aller plus loin : `F11` entre dans les fonctions appelées et
    perd tout le monde. Le débogage pour lui-même est au cours 2.

    Après l'étape 6 le point rouge est toujours là : un second `F5`
    recommence et s'y arrête. Le faire remarquer, puis cliquer sur le point
    pour l'enlever.
  ]
]
