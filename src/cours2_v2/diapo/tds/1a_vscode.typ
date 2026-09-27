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

// « Copier et décompresser les fichiers dans Git Bash » et « Lancer VS Code
// et ouvrir le dossier de la séance » fondues le 28/09/2026, avec le réglage
// de conda pour les postes passés par l'invite d'Anaconda au cours 1.
#d("Préparer la séance")[
  #tableau(
    columns: (auto, 1.3fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous vérifiez],
    [1], [copier `info01-cours2.zip` de `formationTemp` dans `info01`, sur le Bureau],
      [l'archive est à côté de `cours1`],
    [2], [Git Bash, `cd ~/Desktop/info01`, puis `unzip info01-cours2.zip`],
      [la liste des fichiers extraits défile],
    [3], [`ls cours2`], [`1a_vscode/`, `1b_erreurs/`, `2a_markdown/`, `3a_depot_recette/`],
    [4], [sans `(base)` : `source /c/ProgramData/anaconda3/etc/profile.d/conda.sh`, `conda init bash`, rouvrir Git Bash],
      [`(base)` au-dessus de l'invite],
    [5], [VS Code, depuis le menu Démarrer ; File #sym.arrow.r Open Folder…, `Desktop\info01\cours2` ; « Yes, I trust the authors »],
      [les quatre dossiers des TD, à gauche],
  )

  #legende[
    Le dossier ouvert dans VS Code est le projet : l'explorateur, la
    recherche et le terminal partent de lui.
  ]

  #notes[
    `unzip` est dans l'installation complète de Git for Windows depuis 2011 ;
    MinGit et Anaconda ne l'ont pas. À vérifier sur un poste de la salle
    (`which unzip`). Sinon, « Extraire tout… » à la souris.

    Étape 4 : seulement sur les postes où le réglage du TD 2b du cours 1 a
    échoué ou n'a pas été fait (repli sur l'invite de commandes d'Anaconda).
    Mêmes commandes qu'au cours 1.

    Répétée à chaque séance (proposition « pratique répétée » du syllabus
    v2, à valider).

    En 2026, VS Code était lancé depuis Anaconda Navigator, pour que son
    terminal trouve `python`. Avec Git Bash configuré, ce n'est plus
    nécessaire : le terminal lit `~/.bash_profile`.
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
      reponse[le texte est déjà coloré : VS Code colore Python sans extension],
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
    Même démarche pour tout langage : ouvrir le panneau, taper
    l'identifiant, installer.

    Chercher l'identifiant : plusieurs extensions non officielles portent
    le même titre. L'extension de Microsoft installe aussi Pylance, qui
    vérifie l'écriture, et le débogueur. Identifiants relevés sur le poste
    de préparation.

    Deuxième ligne : la coloration est fournie d'origine pour les langages
    courants. L'extension ajoute l'interpréteur, l'exécution et la
    vérification des règles d'écriture. Cette vérification ne porte pas sur
    le sens du programme.

    « Extension » d'un nom de fichier (TD 1a du cours 1) : le même mot pour
    deux choses sans rapport, à dire en une phrase si la question vient.

    Poste sans réseau : les extensions ne s'installent pas, et la suite du
    TD en dépend.
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
    Code. Sans `(base)` à l'étape 2 : refaire l'étape 4 de la préparation,
    puis ouvrir un nouveau terminal.
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

// Reprise de la diapositive 54 du cours 1 de 2026. « Deux niveaux de
// réglages » y est fondue le 28/09/2026.
#d("La palette de commandes et les réglages")[
  #annonce[
    Les commandes et les réglages se cherchent par leur nom. Un réglage vaut
    pour le compte (User) ou pour le dossier ouvert (Workspace), qui
    l'emporte.
  ]

  #tableau(
    columns: (auto, 120pt, 1fr),
    align: left + horizon,
    [], [Raccourci], [Ce qu'on y cherche],
    [La palette de commandes], [`Ctrl` + `Maj` + `P`], [le début d'un nom : « Python: Select Interpreter »],
    [Les réglages], [`Ctrl` + `,`], [un mot : « render whitespace »],
    [Les extensions], [`Ctrl` + `Maj` + `X`], [un identifiant : `ms-python.python`],
  )

  #v(0.3em)
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [User], [Workspace],
    [S'applique à], [tous les dossiers, pour ce compte], [le dossier ouvert],
    [Fichier], [`settings.json` du profil], [`.vscode/settings.json`],
  )

  #notes[
    La palette permet de trouver une commande sans savoir dans quel menu
    elle est. Toutes les consignes du module passent par elle, à commencer
    par le choix de l'interpréteur.

    Les réglages sont écrits dans des fichiers texte, `settings.json`. Un
    réglage peut donc se donner par écrit, et se versionner avec un projet
    au niveau Workspace. Le fichier User est dans
    `C:\Users\eleve\AppData\Roaming\Code\User\`.

    L'onglet des réglages (`Ctrl` + `,`) a deux onglets, User et Workspace :
    les montrer. Le second n'existe que si un dossier est ouvert. Exemples :
    le terminal Git Bash (User), l'interpréteur d'un projet (Workspace).

    Chaque réglage porte un nom en trois parties, `a.b.c`, qu'on retrouve
    dans la barre de recherche.

    `Ctrl` + `ù` est le raccourci du terminal sur un clavier français
    (#raw("Ctrl+`") sur un clavier américain) : à vérifier sur les postes,
    le menu Terminal fait la même chose.

    « Developer: Reload Window » sert quand une extension vient d'être
    installée ou un réglage changé et que l'affichage ne change pas. La
    documentation d'Anaconda le conseille pour un environnement absent de
    la liste.
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
