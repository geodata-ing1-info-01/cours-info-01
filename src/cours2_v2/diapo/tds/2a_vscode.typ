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
// 05/11/2026 : en 2026, les élèves suivaient les consignes sans voir ce qu'elles
// configuraient. Le TD commence par le contexte et la liste des étapes (un langage, le
// terminal), et le titre des diapositives détaillées rappelle l'étape. L'interpréteur
// passe avant le terminal, et le lancement du programme vient en dernier, pour vérifier
// les deux. Le réglage de conda quitte « Préparer la séance » pour l'étape du terminal.
//
// Inclus par `cours2_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 2_v2`.
#import "../../../commun/prelude.typ": *
#import "../../../cours1_v2/diapo/schemas.typ": consignes, comment, commandes, constat
#import "../schemas.typ": schema-vscode-configuration, schema-bouton-extensions, fenetre-vscode, schema-liste-terminaux
#import "../../../cours5/diapo/schemas.typ": repere

#let td = (
  numero: "2a",
  titre: "Configurer VS Code",
  annonce: "En classe entière. Objectif : configurer VS Code pour un projet Python, avec Git Bash comme terminal, et savoir où ses réglages sont écrits",
  dossier: "cours2/2a_vscode/",
  duree: "25′",
)
#separateur-td(..td)

// Le site du cours, en ligne (README.md). `texte` est ce qui s'affiche.
#let _site(chemin, texte) = underline(link("https://geodata-ing1-info-01.github.io/cours-info-01/" + chemin, texte))

// --------------------------------------------
// Nouveau (05/11/2026).
#d("VS Code : éditeur à configurer")[
  #annonce[
    VS Code n'est lié à aucun langage, et ne contient ni interpréteur ni compilateur.
    Il faut le configurer pour chaque langage employé.
  ]

  #schema-vscode-configuration()

  #legende[
    En bleu : ce que ce TD configure, une fois par poste.
  ]

  #notes[
    Reprendre « Comparaison : JupyterLab, Spyder, VS Code » : Spyder ne sert que Python
    et fonctionne sans réglage ; VS Code sert plusieurs langages, et demande cette
    configuration.

    Documentation de VS Code, sur le C++ : « The C/C++ extension doesn't include a C++
    compiler or debugger, since VS Code as an editor relies on command-line tools for
    the development workflow. »

    Le TD se fait en classe entière : lire les deux diapositives suivantes avant de
    commencer, pour que chacun sache ce que les consignes configurent.
  ]
]

// --------------------------------------------
// Nouveau (05/11/2026) ; les deux listes, « Configurer un langage » et « Configurer le
// terminal », réunies le même jour. Extension C/C++ et compilateur : documentation de VS
// Code, « C/C++ for Visual Studio Code ». Les numéros sont ceux des diapositives suivantes.
#d("Configurer VS Code : étapes")[
  #face-a-face(
    panneau[Un langage, ici Python][
      #consignes(
        taille: 16pt,
        [Installer l'extension du langage, avec une connexion internet. #comment[« Python », de Microsoft ; en C++, « C/C++ », de Microsoft.]],
        [Indiquer le chemin de l'interpréteur ou du compilateur. #comment[`python.exe` d'Anaconda ; en C++, #box[`g++.exe`].]],
        [Lancer un programme pour vérifier. #comment[`altitudes.py` ; en C++, `altitudes.cpp`.]],
      )
    ],
    panneau[Le terminal, ici Git Bash][
      #consignes(
        taille: 16pt,
        [Installer le terminal sur le poste. #comment[Git for Windows, déjà installé.]],
        [Le choisir comme terminal de VS Code. #comment[« Terminal: Select Default Profile ».]],
        [Y activer conda, pour que `python` lance le Python d'Anaconda. #comment[`conda init bash`, une fois par poste (TD 1c).]],
        [Vérifier. #comment[`(base)` au-dessus de l'invite, puis #box[`which python`].]],
      )
    ],
  )

  #legende[
    L'interpréteur ou le compilateur doit être installé sur le poste : ici, Anaconda fournit
    Python. En cas de problème : FAQ du site du cours,
    #_site("annexes/faq.html", "geodata-ing1-info-01.github.io/cours-info-01").
  ]

  #notes[
    Le C++ montre que la démarche ne dépend pas du langage : il n'est pas configuré
    ici. Le cours 1 a montré `g++ altitudes.cpp`.

    VS Code ouvre un terminal installé sur le poste. Le module emploie Git Bash, celui du
    cours 1. Sans conda activé, `python` lance dans Git Bash un autre Python que celui
    d'Anaconda, ou aucun : TD 1c, « Quel programme python la commande lance ».

    PowerShell, le terminal par défaut, n'exécute pas le script d'activation de conda sur
    les postes de la salle (relevé en 2026).

    Notebooks dans VS Code : extension Jupyter, hors de ce TD (annexes, « Notebooks »).
  ]
]

// « Copier et décompresser les fichiers dans Git Bash » et « Lancer VS Code
// et ouvrir le dossier de la séance » fondues le 28/09/2026.
#d("Préparer la séance")[
  #annonce[
    Copier les fichiers du TD sur le Bureau, lancer VS Code, puis ouvrir le dossier de la
    séance : `info01\cours2`, depuis le Bureau.
  ]

  #consignes(
    taille: 16pt,
    [Copier l'archive `info01-cours2.zip` de `formationTemp` dans le dossier `info01` du Bureau.
      #constat[L'archive est à côté de `cours1`.]],
    [Décompresser l'archive dans Git Bash : #commandes("cd ~/Desktop/info01", "unzip info01-cours2.zip")
      #constat[La liste des fichiers extraits défile.]],
    [Lister le dossier de la séance : `ls cours2`.
      #constat[`2a_vscode/`, `2b_erreurs/`, `2c_depot_altitudes/`.]],
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

    Répétée à chaque séance (proposition « pratique répétée » du syllabus
    v2, à valider).

    En 2026, VS Code était lancé depuis Anaconda Navigator, pour que son
    terminal trouve `python`. Avec Git Bash configuré, ce n'est plus
    nécessaire : le terminal lit `~/.bash_profile`.
  ]
]

// Reprise de la diapositive 50 du cours 1 de 2026, chemin mis à jour. 05/11/2026 : la
// recherche se fait par le nom, `python`, comme le font les utilisateurs, avec le schéma
// du bouton Extensions, et la capture de la liste sur la diapositive suivante.
#d("Python, étape 1 : installer l'extension")[
  #annonce[
    Une extension s'installe depuis le panneau Extensions, avec une connexion internet.
    Il en faut une par langage.
  ]

  #grid(
    columns: (1.2fr, 1fr), column-gutter: 16pt, align: top,
    consignes(
      taille: 16pt,
      [Ouvrir `2a_vscode/altitudes.py`, avant toute installation.
        #constat[Le texte est déjà coloré : VS Code colore Python sans extension.]],
      [Ouvrir le panneau Extensions : #comment[bouton à quatre carrés, dans la barre de gauche, ou `Ctrl` + `Maj` + `X`.]],
      [Taper `python` dans la zone de recherche.
        #constat[Une liste d'extensions, dont plusieurs s'appellent « Python ».]],
      [Choisir « Python », de Microsoft, puis cliquer sur Install.
        #constat[Pylance et le débogueur s'installent avec, et la barre d'état propose un interpréteur.]],
    ),
    schema-bouton-extensions(),
  )

  #legende[
    Une extension installée le reste, pour les séances suivantes et les autres cours.
  ]

  #notes[
    Même démarche pour tout langage : ouvrir le panneau, taper le nom du langage,
    choisir, installer.

    L'extension de Microsoft installe aussi Pylance, qui vérifie l'écriture, et le
    débogueur.

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

// Nouveau (05/11/2026) : la vraie liste, en capture. Les repères reprennent les numéros
// des consignes de la diapositive précédente, et ne cachent ni le bouton ni la ligne.
// Capture recadrée sur la liste : 420 × 300 pixels, en haut à gauche d'une image de
// 1400 × 446. Les positions des repères sont en pixels.
#let _capture-extensions(hauteur) = {
  let echelle = hauteur / 300
  box(width: 420 * echelle, height: hauteur, clip: true, stroke: 1pt + accent.lighten(55%))[
    // Les deux dimensions : avec la largeur seule, `image` se limite à la hauteur de la
    // boîte et recadre au centre.
    #place(top + left, image("/src/annexes/configuration/captures/vscode_extensions_python.png", width: 1400 * echelle, height: 446 * echelle))
    #for (numero, x, y) in ((2, 24, 262), (3, 392, 50), (4, 300, 88)) {
      place(top + left, dx: x * echelle - 10pt, dy: y * echelle - 10pt, repere(numero, taille: 20pt))
    }
  ]
}

#let _repere-capture(numero, corps) = grid(
  columns: (auto, 1fr), column-gutter: 8pt, align: left + horizon,
  repere(numero, taille: 20pt), text(size: 16pt)[#corps],
)

#d("Python, étape 1 : liste des extensions")[
  #annonce[
    Plusieurs extensions portent des noms voisins. Il faut lire le nom de l'éditeur.
  ]

  #grid(
    columns: (auto, 1fr), column-gutter: 20pt, align: horizon,
    _capture-extensions(232pt),
    stack(
      dir: ttb, spacing: 14pt,
      _repere-capture(2)[le bouton Extensions],
      _repere-capture(3)[la zone de recherche : `python`],
      _repere-capture(4)[l'extension à choisir : « Python », éditeur Microsoft, avec une coche bleue],
    ),
  )

  #legende[
    Capture de la documentation de VS Code, 2022 (CC BY 3.0 US). L'extension y est déjà
    installée : sur un poste neuf, sa ligne porte le bouton Install, comme les autres.
  ]

  #notes[
    Liste relevée sur le Marketplace le 05/11/2026 pour `python` : Python (Microsoft,
    244 millions d'installations), Python (shiro, 278 000), Python Debugger (Microsoft),
    Python Environments (Microsoft), Python Indent, Python for VSCode, Python Extension
    Pack, autoDocstring. L'ordre change : faire lire le nom de l'éditeur.

    Sur la page de l'extension, à droite, la ligne Identifier donne `ms-python.python`,
    si la question vient (annexes, « Python et environnement conda »).
  ]
]

// Adaptée de la diapositive 55 du cours 1 de 2026. Le lancement du programme a sa
// diapositive, après le terminal, depuis le 05/11/2026.
// La capture est recadrée sur la liste, à partir de la ligne 120 d'une image de
// 1095 × 406. Par défaut, le repère 3 est sur la ligne `base`.
#let _capture-interpreteur(largeur, numero: 3, x: 640, y: 133, pixels: 270) = {
  let echelle = largeur / 1095
  box(width: largeur, height: pixels * echelle, clip: true, stroke: 1pt + accent.lighten(55%))[
    #place(top + left, dy: -120 * echelle, image("/src/annexes/configuration/captures/vscode_select_interpreter.png", width: 1095 * echelle, height: 406 * echelle))
    #place(top + left, dx: x * echelle - 10pt, dy: y * echelle - 10pt, repere(numero, taille: 20pt))
  ]
}

#d("Python, étape 2 : choisir l'interpréteur")[
  #annonce[
    L'extension Python exécute les programmes avec le Python qu'on lui désigne.
  ]

  #consignes(
    taille: 16pt,
    [Ouvrir la palette de commandes : `Ctrl` + `Maj` + `P`. #comment[Une zone de saisie s'ouvre en haut de la fenêtre.]],
    [Taper `select interpreter`, puis choisir « Python: Select Interpreter ».
      #constat[Une liste de chemins ; celui d'Anaconda contient `anaconda3`.]],
    [Choisir la ligne `base`, de chemin `C:\ProgramData\anaconda3\python.exe`.
      #constat[`3.x ('base')` dans la barre d'état, en bas à droite.]],
  )

  #grid(
    columns: (auto, 1fr), column-gutter: 14pt, align: horizon,
    _capture-interpreteur(500pt),
    stack(
      dir: ttb, spacing: 6pt,
      text(size: 14pt, fill: estompe)[Ensuite, en bas à droite de la fenêtre :],
      block(width: 100%, fill: accent, inset: (x: 8pt, y: 5pt), text(size: 13pt, fill: white)[Python #h(5pt) #"3.x ('base')"]),
    ),
  )

  #legende[
    Capture de la documentation de VS Code (CC BY 3.0 US), sur un autre poste : `base` y est
    dans `miniconda3`. Si la ligne `base` manque : diapositive suivante.
  ]

  #notes[
    Plusieurs Python peuvent coexister sur une machine. Faire lire le chemin en plus du
    nom : deux Python d'un même poste peuvent porter des noms voisins.

    Sur la capture, le cadre rouge d'origine marque le Python déjà choisi sur ce poste-là.

    Le bouton exécute avec l'interpréteur choisi ; le terminal emploie le
    `python` de son `PATH`. Quand les deux diffèrent, un
    `ModuleNotFoundError` peut apparaître d'un côté seulement. Revu au
    cours 5, avec les environnements.
  ]
]

// Nouveau (05/11/2026). Discovery et réglages : documentation de VS Code, « Python
// environments ». Coller le chemin plutôt que « Find… » : `C:\ProgramData` est masqué.
#d("Python, étape 2 : dépannage")[
  #annonce[
    Si la ligne `base` manque, il faut indiquer à VS Code le chemin du Python d'Anaconda.
  ]

  #consignes(
    taille: 16pt,
    [Dans la même liste, choisir « Enter interpreter path… ».],
    [Coller le chemin, puis appuyer sur Entrée : `C:\ProgramData\anaconda3\python.exe`. #comment[« Find… » n'affiche pas `C:\ProgramData`, un dossier masqué.]],
    [Vérifier la barre d'état, en bas à droite.
      #constat[`3.x ('base')`.]],
  )

  #v(0.2em)
  #_capture-interpreteur(500pt, numero: 1, x: 460, y: 53, pixels: 74)

  #v(0.2em)
  #{
    show table.cell: set text(size: 14pt)
    tableau(
      columns: (0.8fr, 1.2fr),
      align: left + horizon,
      inset: (x: 8pt, y: 5pt),
      [Si la liste reste incomplète], [Ce qu'il faut faire],
      [Un environnement manque, ou n'existe plus], [Palette : « Python: Clear Cache and Reload Window »],
      [`base` et les environnements restent absents], [Réglage User `python.condaPath` : `C:\ProgramData\anaconda3\Scripts\conda.exe`],
    )
  }

  #legende[
    Capture de la documentation de VS Code (CC BY 3.0 US). Détail : site du cours,
    #_site("annexes/problemes/vscode.html#dep-v6", "problème V6").
  ]

  #notes[
    L'extension ne lit pas la liste dans un fichier : elle la construit. Elle cherche dans
    le `PATH` reçu au lancement de VS Code, le registre de Windows, les installations de
    python.org, les dossiers du projet, et lance `conda info --envs` quand elle trouve
    conda. Lancé depuis le menu Démarrer, VS Code ne reçoit pas le `PATH` d'Anaconda.

    `python.condaPath` lui donne le chemin de conda, au niveau User seulement.
    `python.defaultInterpreterPath` donne un Python de repli, tant qu'aucun n'est choisi.

    Réglages : compte, `%APPDATA%\Code\User\settings.json` ; dossier ouvert,
    `.vscode\settings.json`, qui l'emporte.
  ]
]

// Nouveau (v2) : Git Bash, terminal par défaut. 05/11/2026 : le schéma de la liste des
// terminaux, avec sa consigne ; des élèves ne trouvaient pas ce bouton en 2026.
#d("Terminal, étape 2 : choisir Git Bash")[
  #annonce[
    VS Code ouvre par défaut un terminal PowerShell. Un réglage lui fait
    ouvrir Git Bash, celui du cours 1.
  ]

  #grid(
    columns: (1.1fr, 1fr), column-gutter: 16pt, align: top,
    consignes(
      taille: 16pt,
      [Ouvrir la palette de commandes : `Ctrl` + `Maj` + `P`.],
      [Choisir « Terminal: Select Default Profile », puis « Git Bash ».
        #constat[La palette se ferme ; rien d'autre ne change.]],
      [Ouvrir un terminal : #comment[menu Terminal, New Terminal.]
        #constat[Un terminal en bas, avec `MINGW64 ~/Desktop/info01/cours2`.]],
      [Lister les terminaux : #comment[flèche à droite du signe +, en haut à droite du panneau du terminal.]
        #constat[PowerShell, Git Bash, Command Prompt…]],
    ),
    schema-liste-terminaux(),
  )

  #legende[
    Cette liste ouvre aussi un terminal d'un autre type. Le menu réel a d'autres entrées. Si
    « Git Bash » n'est pas proposé : fermer et relancer VS Code.
  ]

  #notes[
    Le réglage écrit est `terminal.integrated.defaultProfile.windows`, au
    niveau User. VS Code lance Git Bash avec `--login -i` : il lit
    `~/.bash_profile`, où `conda init bash` a écrit au cours 1.

    L'erreur `activate.ps1 cannot be loaded because running scripts is
    disabled on this system` de 2026 ne se produit plus : PowerShell n'est
    plus lancé.

    La flèche n'apparaît qu'une fois le panneau du terminal ouvert, d'où la consigne 3
    avant la consigne 4. « Select Default Profile », dans cette liste, fait la même chose
    que les consignes 1 et 2.
  ]
]

// Nouveau (05/11/2026) : la vérification du terminal, et le réglage de conda, venu de
// « Préparer la séance ».
#d("Terminal, étapes 3 et 4 : activer conda, vérifier")[
  #consignes(
    taille: 17pt,
    [Vérifier la première ligne de l'invite.
      #constat[`(base)`, au-dessus de `eleve@POSTE-12`.]],
    [Vérifier le Python lancé : `which python`.
      #constat[`/c/ProgramData/anaconda3/python`.]],
    [Si `(base)` manque, régler conda, puis fermer ce terminal et en ouvrir un nouveau : #commandes("source /c/ProgramData/anaconda3/etc/profile.d/conda.sh", "conda init bash")],
  )

  #legende[
    Fermer un terminal : icône de corbeille, en haut à droite du panneau. Le réglage reste
    d'une séance à l'autre sur le même poste.
  ]

  #notes[
    Étape 3 : seulement sur les postes où le réglage du TD 1c a échoué ou n'a pas été
    fait (repli sur l'invite de commandes d'Anaconda). Mêmes commandes qu'au cours 1.

    Le terminal de VS Code et la fenêtre Git Bash lisent le même `~/.bash_profile`.
  ]
]

// Le lancement du programme, sorti de « Choisir l'interpréteur Python » le 05/11/2026.
// Étape 3 de « Configurer un langage : étapes », après le terminal, où elle s'exécute.
// Fenêtre dessinée, avec des points de suspension dans les chemins, dont la forme exacte
// est à relever sur un poste.
#d("Python, étape 3 : lancer un programme")[
  #consignes(
    taille: 16pt,
    [Ouvrir `2a_vscode/altitudes.py`, dans l'arborescence.],
    [Cliquer sur le bouton #sym.triangle.filled.r en haut à droite du fichier.
      #constat[La commande apparaît dans le terminal, puis `moyenne : 93.7 m`.]],
  )

  #v(0.2em)
  #fenetre-vscode(hauteur: 206pt, reperes: true, commande: "…/anaconda3/python.exe …/2a_vscode/altitudes.py", lignes: (4, 8))

  #legende[
    Le bouton écrit dans le terminal la commande qu'on taperait soi-même :
    `python` suivi du chemin du fichier.
  ]

  #notes[
    Ce lancement vérifie les deux parties : l'extension et l'interpréteur fournissent le
    bouton et le chemin de `python`, et la commande s'exécute dans Git Bash. D'où sa place
    après le réglage du terminal.
  ]
]

// Nouveau (05/11/2026). Messages repris de `annexes/problemes/git.md`, qui en donne la
// cause.
#d("Git Bash : problèmes fréquents")[
  #{
    show table.cell: set text(size: 14pt)
    tableau(
      columns: (0.72fr, 1.28fr),
      align: left + horizon,
      inset: (x: 8pt, y: 6pt),
      [Ce qu'on voit], [Ce qu'il faut faire],
      [L'invite commence par `PS`], [Fermer ce terminal (corbeille), puis en ouvrir un nouveau],
      [Pas de `(base)` ; `python` introuvable, ou une autre version], [Régler conda : `conda init bash`, « Terminal, étapes 3 et 4 »],
      [`conda init bash` écrit `needs sudo`, ou Windows demande des droits], [Refuser, puis taper : #linebreak() #text(size: 15pt, raw("echo 'eval \"$(/c/ProgramData/anaconda3/Scripts/conda.exe shell.bash hook)\"' >> ~/.bash_profile"))],
      [`Usage: cygpath …`, puis `bash: : No such file or directory`], [Taper une fois : #linebreak() #text(size: 15pt, raw("sed -i '1i cygpath() { /usr/bin/cygpath \"$@\"; }' ~/.bash_profile"))],
    )
  }

  #legende[
    Après chaque correction : fermer le terminal et en ouvrir un nouveau. Détail : site du
    cours, #_site("annexes/problemes/git.html", "« Problèmes avec git et Git Bash »").
  ]

  #notes[
    Message de `cygpath` : `base` est activé quand même. Anaconda fournit son propre
    `cygpath`, qui échoue sous Git Bash ; la fonction ajoutée en tête de
    `~/.bash_profile` appelle celui de Git.

    Si le réglage échoue, le terminal de secours est l'invite de commandes d'Anaconda :
    annexes, « Python et environnement conda ».
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
    [Les extensions], [`Ctrl` + `Maj` + `X`], [un nom : `python`],
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
