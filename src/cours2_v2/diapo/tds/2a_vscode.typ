// TD 2a du cours 2 v2 — « Configurer VS Code », en classe entière.
//
// Nouveau (v2) : reprend les diapositives 48 à 56 du cours 1 de 2026 (TD 2c),
// joué ici en classe entière. VS Code se lance depuis le menu Démarrer, et
// non depuis Navigator (lent à démarrer sur les postes en 2026) ; son
// terminal est Git Bash, configuré au cours 1, à la place du profil Anaconda
// Prompt. Le guide détaillé est `src/cours2_v2/notebook/td/2a_vscode/guide.md`.
//
// 04/11/2026 : les tableaux « Ce qu'il faut faire / Ce que vous vérifiez »
// deviennent des listes de consignes, comme au cours 1 v2.
//
// Inclus par `cours2_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 2_v2`.
#import "../../../commun/prelude.typ": *
#import "../../../cours1_v2/diapo/schemas.typ": consignes, comment, commandes, constat

#let td = (
  numero: "2a",
  titre: "Configurer VS Code",
  annonce: "En classe entière. Objectif : configurer VS Code pour un projet Python, avec Git Bash comme terminal, et savoir où ses réglages sont écrits",
  dossier: "cours2/2a_vscode/",
  duree: "25′",
)
#separateur-td(..td)

// « Copier et décompresser les fichiers dans Git Bash » et « Lancer VS Code
// et ouvrir le dossier de la séance » fondues le 28/09/2026, avec le réglage
// de conda pour les postes passés par l'invite d'Anaconda au cours 1.
#d("Préparer la séance")[
  #consignes(
    taille: 16pt,
    [Copier l'archive `info01-cours2.zip` de `formationTemp` dans le dossier `info01` du Bureau.
      #constat[L'archive est à côté de `cours1`.]],
    [Décompresser l'archive dans Git Bash : #commandes("cd ~/Desktop/info01", "unzip info01-cours2.zip")
      #constat[La liste des fichiers extraits défile.]],
    [Lister le dossier de la séance : `ls cours2`.
      #constat[`2a_vscode/`, `2b_erreurs/`, `2c_depot_recette/`.]],
    [Si `(base)` n'est pas au-dessus de l'invite, régler conda, puis rouvrir Git Bash : #commandes("source /c/ProgramData/anaconda3/etc/profile.d/conda.sh", "conda init bash")],
    [Lancer VS Code depuis le menu Démarrer, puis ouvrir le dossier de la séance : #comment[File, Open Folder…, `Desktop\info01\cours2`, puis « Yes, I trust the authors ».]
      #constat[Les trois dossiers des TD, à gauche.]],
  )

  #legende[
    Le dossier ouvert dans VS Code est le projet : l'explorateur, la
    recherche et le terminal partent de lui.
  ]

  #notes[
    `unzip` est dans l'installation complète de Git for Windows depuis 2011 ;
    MinGit et Anaconda ne l'ont pas. À vérifier sur un poste de la salle
    (`which unzip`). Sinon, « Extraire tout… » à la souris.

    Étape 4 : seulement sur les postes où le réglage du TD 1c a
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

  #consignes(
    taille: 17pt,
    [Ouvrir `2a_vscode/altitudes.py`, avant toute installation.
      #constat[Le texte est déjà coloré : VS Code colore Python sans extension.]],
    [Ouvrir le panneau Extensions : `Ctrl` + `Maj` + `X`.],
    [Chercher l'identifiant `ms-python.python`, puis cliquer sur Install.
      #constat[Pylance et le débogueur s'installent avec, et la barre d'état propose un interpréteur.]],
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

    Première consigne : la coloration est fournie d'origine pour les langages
    courants. L'extension ajoute l'interpréteur, l'exécution et la
    vérification des règles d'écriture. Cette vérification ne porte pas sur
    le sens du programme.

    « Extension » d'un nom de fichier (TD 1a) : le même mot pour
    deux choses sans rapport, à dire en une phrase si la question vient.

    Poste sans réseau : les extensions ne s'installent pas, et la suite du
    TD en dépend.
  ]
]

// Nouveau (v2) : Git Bash, terminal par défaut.
#d("Choisir Git Bash comme terminal de VS Code")[
  #annonce[
    VS Code ouvre par défaut un terminal PowerShell. Un réglage lui fait
    ouvrir Git Bash, celui du cours 1.
  ]

  #consignes(
    taille: 17pt,
    [Ouvrir la palette de commandes : `Ctrl` + `Maj` + `P`.],
    [Choisir « Terminal: Select Default Profile », puis « Git Bash ».
      #constat[La palette se ferme ; rien d'autre ne change.]],
    [Ouvrir un terminal : #comment[menu Terminal, New Terminal.]
      #constat[Un terminal en bas, avec `(base)` et `MINGW64 ~/Desktop/info01/cours2`.]],
    [Vérifier le Python lancé : `python --version`.
      #constat[La version d'Anaconda, comme au cours 1.]],
  )

  #legende[
    Si « Git Bash » n'est pas proposé à l'étape 2 : fermer et relancer VS
    Code. Sans `(base)` à l'étape 3 : refaire l'étape 4 de la préparation,
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

  #consignes(
    taille: 17pt,
    [Ouvrir la palette de commandes, puis choisir « Python: Select Interpreter ».
      #constat[Une liste de chemins ; celui d'Anaconda contient `anaconda3`.]],
    [Choisir `base`, `C:\ProgramData\anaconda3\python.exe`.
      #constat[`3.x ('base')` dans la barre d'état, en bas à droite.]],
    [Ouvrir `2a_vscode/altitudes.py`, puis cliquer sur le bouton #sym.triangle.filled.r en haut à droite.
      #constat[La commande apparaît dans le terminal, puis `moyenne : 129.0 m`.]],
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

#d("Modifier deux réglages, puis lire leur fichier")[
  #consignes(
    taille: 17pt,
    [Ouvrir les réglages : `Ctrl` + `,`, onglet User.],
    [Chercher « render whitespace », puis choisir `all`.
      #constat[Un point par espace dans le code.]],
    [Chercher « auto save », puis choisir `afterDelay`.
      #constat[Plus de point blanc sur l'onglet d'un fichier modifié.]],
    [Ouvrir le fichier des réglages : #comment[palette de commandes, « Preferences: Open User Settings (JSON) ».]
      #constat[Trois lignes : les deux réglages, et le terminal Git Bash.]],
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
    TD 1c) ; l'enregistrement automatique évite l'écart.
  ]
]
