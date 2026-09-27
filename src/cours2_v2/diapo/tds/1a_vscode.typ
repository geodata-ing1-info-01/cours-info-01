// TD 1a du cours 2 v2 — « Configurer VS Code », en classe entière.
//
// Nouveau (v2) : reprend les diapositives 48 à 56 du cours 1 de 2026 (TD 2a),
// joué ici en classe entière. VS Code se lance depuis le menu Démarrer, et
// non depuis Navigator (lent à démarrer sur les postes en 2026) ; son
// terminal est Git Bash, configuré au cours 1, à la place du profil Anaconda
// Prompt. Le guide détaillé est `src/cours2_v2/notebook/td/1a_vscode/guide.md`.
//
// Inclus par `cours2_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 2_v2`.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "1a",
  titre: "Configurer VS Code",
  annonce: "En classe entière : copier les fichiers de la séance, ouvrir le dossier dans VS Code, installer l'extension Python, choisir l'interpréteur, faire de Git Bash le terminal",
  dossier: "cours2/1a_vscode/",
  duree: "25′",
)
#separateur-td(..td)

#d("Copier et décompresser les fichiers dans Git Bash")[
  #tableau(
    columns: (auto, 1.2fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous vérifiez],
    [1], [copier `info01-cours2.zip` de `formationTemp` dans le dossier `info01` du Bureau, comme au cours 1],
      [l'archive est à côté de `cours1`],
    [2], [Git Bash, puis `cd ~/Desktop/info01`], [l'invite se termine par `~/Desktop/info01`],
    [3], [`unzip info01-cours2.zip`], [la liste des fichiers extraits défile],
    [4], [`ls cours2`], [`1a_vscode/`, `2a_markdown/`, `3a_depot_recette/`],
  )

  #legende[
    `unzip` est fourni avec Git Bash. La décompression à la souris, « Extraire
    tout… », reste possible.
  ]

  #notes[
    `unzip` est dans l'installation complète de Git for Windows depuis 2011 ;
    MinGit et Anaconda ne l'ont pas. À vérifier sur un poste de la salle
    (`which unzip`).

    Répétée à chaque séance (proposition « pratique répétée » du syllabus
    v2, à valider).
  ]
]

// Nouveau (v2) : VS Code lancé depuis le menu Démarrer.
#d("Lancer VS Code et ouvrir le dossier de la séance")[
  #tableau(
    columns: (auto, 1.2fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous vérifiez],
    [1], [menu Démarrer, « Visual Studio Code »], [la page d'accueil de VS Code],
    [2], [File #sym.arrow.r Open Folder…, choisir `Desktop\info01\cours2`],
      [une fenêtre sur la confiance aux auteurs : « Yes, I trust the authors »],
    [3], [ouvrir l'explorateur, `Ctrl` + `Maj` + `E`],
      [les trois dossiers des TD, à gauche],
  )

  #legende[
    Le dossier ouvert est le projet : l'explorateur, la recherche et le
    terminal partent de lui.
  ]

  #notes[
    VS Code s'affiche en anglais par défaut ; le module ne demande pas d'en
    changer.

    En 2026, VS Code était lancé depuis Anaconda Navigator, pour que son
    terminal trouve `python`. Avec Git Bash configuré au cours 1, ce n'est
    plus nécessaire : le terminal lit `~/.bash_profile`.
  ]
]

// Reprise de la diapositive 50 du cours 1 de 2026, chemin mis à jour.
#d("Installer l'extension d'un langage")[
  #annonce[
    Une extension s'installe depuis le panneau Extensions, en cherchant son
    identifiant. Il en faut une par langage.
  ]

  #tableau(
    columns: (1.1fr, 1fr),
    align: left + horizon,
    [Ce qu'il faut faire], [Ce que vous observez],
    [ouvrir `1a_vscode/altitudes.py` avant toute installation],
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
    fichier : c'est le propos du TD 1a du cours 1. Si la question vient, une
    phrase suffit, le même mot pour deux choses sans rapport.

    Poste sans réseau : les extensions ne s'installent pas. Le prévoir,
    car la suite du TD en dépend cette fois.
  ]
]

// Nouveau (v2) : Git Bash, terminal par défaut.
#d("Git Bash, terminal de VS Code")[
  #annonce[
    VS Code ouvre par défaut un terminal PowerShell. Un réglage lui fait
    ouvrir Git Bash, celui du cours 1.
  ]

  #tableau(
    columns: (auto, 1.2fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [`Ctrl` + `Maj` + `P`, « Terminal: Select Default Profile », puis « Git Bash »],
      reponse[la palette se ferme ; rien d'autre ne change],
    [2], [Terminal #sym.arrow.r New Terminal],
      reponse[un terminal en bas, avec `(base)` et `MINGW64 ~/Desktop/info01/cours2`],
    [3], [`python --version`], reponse[la version d'Anaconda, comme au cours 1],
  )

  #legende[
    Si « Git Bash » n'est pas proposé à l'étape 1 : fermer et relancer VS
    Code. Sans `(base)` à l'étape 2 : le début du TD 2b du cours 1 n'a pas été
    faite sur ce poste.
  ]

  #notes[
    Le réglage écrit est `terminal.integrated.defaultProfile.windows`, au
    niveau User. VS Code lance Git Bash avec `--login -i` : il lit
    `~/.bash_profile`, où `conda init bash` a écrit au cours 1.

    L'erreur `activate.ps1 cannot be loaded because running scripts is
    disabled on this system` de 2026 ne se produit plus : PowerShell n'est
    plus lancé.
  ]
]

// Adaptée de la diapositive 55 du cours 1 de 2026.
#d("Choisir l'interpréteur Python")[
  #annonce[
    Plusieurs Python peuvent coexister sur une machine. L'extension Python
    exécute les programmes avec celui qu'on lui désigne.
  ]

  #tableau(
    columns: (auto, 1.2fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [`Ctrl` + `Maj` + `P`, « Python: Select Interpreter »],
      reponse[une liste de chemins ; celui d'Anaconda contient `anaconda3`],
    [2], [choisir `base`, `C:\ProgramData\anaconda3\python.exe`],
      reponse[`3.x ('base')` dans la barre d'état, en bas à droite],
    [3], [ouvrir `1a_vscode/altitudes.py`, bouton #sym.triangle.filled.r en haut à droite],
      reponse[la commande apparaît dans le terminal, puis `moyenne : 129.0 m`],
  )

  #legende[
    Le bouton écrit dans le terminal la commande qu'on taperait soi-même :
    `python` suivi du chemin du fichier.
  ]

  #notes[
    Faire lire le chemin en plus du nom : deux Python d'un même poste
    peuvent porter des noms voisins.

    Le bouton exécute avec l'interpréteur choisi ; le terminal emploie le
    `python` de son `PATH`. Quand les deux diffèrent, un
    `ModuleNotFoundError` peut apparaître d'un côté seulement. Revu au
    cours 3, avec les environnements.
  ]
]

// Reprise de la diapositive 54 du cours 1 de 2026.
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
    permet d'en donner un par écrit, puis de le versionner avec un projet quand il est au niveau Workspace,
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

// Nouveau (v2), d'après `src/annexes/configuration/vscode.md`.
#d("Deux niveaux de réglages")[
  #annonce[
    Un réglage s'écrit pour le compte, dans tous les dossiers ouverts, ou pour
    un seul dossier. Le réglage du dossier l'emporte.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [User], [Workspace],
    [S'applique à], [tous les dossiers ouverts avec ce compte, sur ce poste], [le dossier ouvert],
    [Fichier], [`settings.json` du profil de VS Code], [`.vscode/settings.json`, dans le dossier],
    [Voyage avec le projet], [non], [oui, et se versionne avec lui],
    [Exemple], [le terminal Git Bash], [l'interpréteur d'un projet],
  )

  #legende[
    Le fichier User est dans `C:\Users\eleve\AppData\Roaming\Code\User\`.
  ]

  #notes[
    L'onglet des réglages (`Ctrl` + `,`) a deux onglets, User et Workspace :
    le montrer. Le second n'existe que si un dossier est ouvert.
  ]
]

#d("Deux réglages, puis leur fichier")[
  #tableau(
    columns: (auto, 1.2fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [`Ctrl` + `,`, onglet User, chercher « render whitespace », choisir `all`],
      reponse[un point par espace dans le code],
    [2], [chercher « auto save », choisir `afterDelay`],
      reponse[plus de point blanc sur l'onglet d'un fichier modifié],
    [3], [palette, « Preferences: Open User Settings (JSON) »],
      reponse[trois lignes : les deux réglages, et le terminal Git Bash],
  )

  #legende[
    #reponse[
      Le même réglage se lit dans l'interface et dans `settings.json` :
      l'interface écrit ce fichier texte.
    ]
  ]

  #notes[
    Contenu attendu de `settings.json`, à ne montrer qu'après :
    `"terminal.integrated.defaultProfile.windows": "Git Bash"`,
    `"editor.renderWhitespace": "all"`, `"files.autoSave": "afterDelay"`.
    D'autres lignes peuvent y être, écrites par des extensions.

    `files.autoSave` : un programme lancé lit le fichier enregistré (cours 1,
    TD 2b) ; l'enregistrement automatique évite l'écart.
  ]
]
