// Partie 2 du cours 1 v2, première moitié : le terminal. Incluse par
// `cours1_v2.typ`. Un fichier inclus n'hérite pas des imports de son appelant.
//
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": explorateur-copie, git-bash-copie, chaine-terminal, git-bash-ls, couleur-commande, couleur-sortie, terminal

#separateur(
  "Interface en ligne de commande / terminal",
  annonce: "Se déplacer dans les dossiers et agir sur les fichiers en tapant des commandes.",
)

// --------------------------------------------
// interface graphique et ligne de commande, avant le vocabulaire du terminal.
#d("Interface graphique et ligne de commande")[
  #annonce[
    Dans une interface graphique, on choisit l'opération parmi les menus et boutons affichés.
    En ligne de commande, on tape une commande, le nom de l'opération, puis ses paramètres.
  ]

  #face-a-face(
    panneau[Interface graphique : l'explorateur de fichiers][
      #explorateur-copie()
      #legende[La copie demande ensuite d'ouvrir `travail`, puis de choisir Coller au clic droit.]
    ],
    panneau[Ligne de commande : Git Bash][
      #git-bash-copie()
      #legende[On tape la ligne, puis on appuie sur Entrée. `cp` abrège _copy_.]
    ],
  )

  #notes[
    Les deux copies donnent le même fichier, `travail/raven.odt`, sur le
    disque du poste.

    Sigles anglais : GUI (_graphical user interface_) et CLI (_command-line
    interface_).

    Les menus reposent sur la reconnaissance d'une opération affichée, et la
    ligne de commande sur le rappel de son nom. Source : R. Budiu, « Memory
    Recognition and Recall in User Interfaces », Nielsen Norman Group, 2024.

    `cp` n'affiche rien quand la copie réussit.

    Paramètres de `cp` : le fichier à copier et le dossier de destination. La diapositive
    « La forme d'une commande » les distingue en options et arguments.
  ]
]

// Relecture du 19/10/2026 : « Une opération sur 120 fichiers » et
// « Comparaison des deux interfaces » sont retirées. La page de cours
// `02_terminal.md` garde la comparaison.

// --------------------------------------------
// Nouveau (05/11/2026) : les raisons de voir la ligne de commande dans ce module, en une
// diapositive. Les trois commandes ont été exécutées le 05/11/2026 (GDAL 3.4.1, Python
// 3.12 ; la dernière sur le corrigé du TD 3b).
#let _interet(titre, detail, commande) = grid(
  columns: (1.5fr, 1fr), column-gutter: 16pt, align: horizon,
  [
    // Sans ce réglage, l'interligne suit le corps de 21 pt du paragraphe, trop large pour le
    // détail en 14 pt.
    #set par(leading: 0.5em)
    #text(size: 18pt, weight: demi-gras)[#titre] \
    // Le code passe de 0,78 à 0,9 fois le texte : `*` serait illisible à sa taille.
    #show raw: set text(size: 1.15em)
    #text(size: 14pt, fill: estompe)[#detail]
  ],
  block(width: 100%, fill: gris, inset: (x: 10pt, y: 9pt), text(size: 16pt, raw(commande))),
)

// Étiquette d'un groupe de lignes, dans le gris des étiquettes de panneau.
#let _groupe(titre) = text(size: 15pt, fill: estompe, weight: demi-gras, titre)

// 09/11/2026 : deux groupes. L'automatisation et les programmes viennent de la ligne de
// commande elle-même ; les logiciels scientifiques et les serveurs demandent seulement de
// savoir s'en servir. « Opérations répétées » devient « Automatisation des tâches », car
// des logiciels à interface graphique proposent aussi un traitement par lot.
#d("Intérêt de la ligne de commande")[
  // Une longueur placée entre deux éléments remplace `spacing` : l'étiquette reste près de
  // ses lignes, et le second groupe s'écarte du premier.
  #stack(
    dir: ttb, spacing: 14pt,
    _groupe[Intérêt face à une interface graphique],
    10pt,
    _interet(
      "Automatisation des tâches",
      [Le traitement par lot, comme cette copie des `.txt` de `depart`, est plus courant qu'en interface graphique. Une suite de commandes s'enregistre dans un script, et se relance avec d'autres paramètres.],
      "$ cp depart/*.txt travail/textes/",
    ),
    _interet(
      "Programmes plus simples à écrire",
      [Le cours 3 construit ce programme. Avec une interface graphique, il faudrait aussi programmer les fenêtres, les boutons et leur comportement.],
      "$ python altitudes.py trace.csv -s 2",
    ),
    26pt,
    _groupe[Intérêt de savoir s'en servir],
    10pt,
    _interet(
      "Logiciels scientifiques et serveurs de calcul",
      [Beaucoup de ces outils ne s'utilisent qu'en ligne de commande : GDAL pour les données géographiques, PDAL pour les nuages de points, et les serveurs de calcul, utilisés à distance.],
      "$ gdal_translate carte.png carte.tif",
    ),
  )

  #notes[
    Deux intérêts distincts. Face à une interface graphique, la ligne de commande facilite
    l'automatisation et simplifie l'écriture d'un programme. Savoir s'en servir donne accès
    aux outils sans autre interface.

    Outils du module en ligne de commande : `python` à la partie suivante, `conda` au
    TD 1c, `git` au cours 2.

    L'interface graphique reste adaptée pour découvrir un logiciel et pour une
    opération ponctuelle. MIT, _The Missing Semester_ : « These are great for 80% of
    use-cases ».

    Logiciels : `gdal_translate` convertit une image. PDAL pour les nuages de points ;
    MicMac, de l'IGN et de l'ENSG, par la commande `mm3d`. QGIS propose des fenêtres
    pour une partie de GDAL. Software Carpentry, _The Unix Shell_ : « some tools and
    resources such as cloud computing systems usually require users to be familiar
    with the shell ». Serveurs : accès par `ssh`, aux cours 5 et 6.

    Automatisation : le TD 1b fait cette copie. Software Carpentry : « excels at making
    repetitive tasks automatic and fast ». Exemple de la page de cours, 120 images :
    `magick mogrify -path travail -resize 640 depart/*.png`. Des logiciels à interface
    graphique proposent aussi un traitement par lot, comme QGIS, par « Exécuter comme
    processus de lot » dans la boîte à outils de traitements.

    Programmes : `argparse` fournit aussi `--help` et le message d'erreur. Un programme
    en ligne de commande se lance aussi depuis un autre programme (`subprocess`, cours 5).
  ]
]

// --------------------------------------------
#d("Le terminal et l'interpréteur de commandes")[
  #annonce[
    Le terminal est la fenêtre : il affiche du texte et transmet ce qu'on
    tape. L'interpréteur de commandes reçoit chaque ligne et lance le programme
    qu'elle nomme.
  ]

  // 27/09 : la chaîne passe en colonne, à côté d'une fenêtre qui montre la
  // commande et sa sortie.
  #grid(
    columns: (0.9fr, 1.45fr), column-gutter: 18pt, align: horizon,
    // 09/11/2026 : la commande et la liste en couleur, comme dans la fenêtre, et une
    // dernière étape, le retour de l'invite.
    chaine-terminal(
      ("Ce qu'on tape", [#text(fill: couleur-commande, weight: demi-gras)[ls depart], puis Entrée]),
      ("Le terminal", "la fenêtre, qui transmet la ligne"),
      ("L'interpréteur de commandes", "bash : découpe la ligne, lance ls"),
      ("Le programme ls", text(fill: couleur-sortie, weight: demi-gras)[écrit la liste des fichiers]),
      ("L'interpréteur de commandes", "réaffiche l'invite, puis attend la ligne suivante"),
      plein: (2, 4),
    ),
    git-bash-ls(),
  )

  #legende[
    Le mot « terminal » désigne souvent les deux à la fois. Le langage des
    commandes est celui de l'interpréteur : cmd, PowerShell ou bash.
  ]

  #notes[
    Même rôle que l'interpréteur Python de la suite de la partie : un
    programme qui lit du texte et le fait exécuter. L'interpréteur de
    commandes lit une ligne à la fois, tapée au clavier.

    Le nom vient des terminaux physiques (clavier et écran reliés à un
    ordinateur central) ; la fenêtre en imite un. Ne le dire que si la
    question vient.
  ]
]

// --------------------------------------------
// Une capture de terminal, les logos des systèmes où il existe à sa droite, puis son nom,
// la façon de l'ouvrir et son invite, sous l'image (09/11/2026).
#let _terminal(fichier, logos, nom, lancer, invite, hauteur: 70pt) = align(center, stack(
  dir: ttb, spacing: 5pt,
  grid(
    columns: (auto, auto), column-gutter: 8pt, align: horizon,
    box(
      stroke: 1pt + accent.lighten(55%),
      image("/src/cours1_v2/images/terminaux/" + fichier, height: hauteur),
    ),
    stack(
      dir: ttb, spacing: 7pt,
      ..logos.map(f => image("/src/cours1_v2/images/os/" + f, height: 18pt)),
    ),
  ),
  text(size: 15pt, weight: demi-gras)[#nom],
  text(size: 13pt, fill: estompe)[#lancer],
  text(size: 13pt, fill: estompe)[Invite : #invite],
))

// 09/11/2026 : Git Bash en grand, sur les deux tiers de droite ; cmd et PowerShell l'un sous
// l'autre, sur le tiers de gauche. L'annonce sur l'invite est retirée : la diapositive
// suivante la détaille.
#d("Les trois terminaux du poste de l'école")[
  #grid(
    columns: (1fr, auto, 2fr), column-gutter: 14pt, align: top,
    stack(
      dir: ttb, spacing: 14pt,
      _terminal("cmd_windows11.png", ("windows.svg",), [Invite de commandes (cmd)],
        [Démarrer #sym.arrow.r `cmd`], [`C:\Users\…>`]),
      _terminal("powershell_terminal_windows.png", ("windows.svg",), [PowerShell],
        [Démarrer #sym.arrow.r Terminal], [`PS C:\Users\…>`]),
    ),
    line(angle: 90deg, length: 225pt, stroke: (paint: accent.lighten(55%), thickness: 1pt, dash: "dashed")),
    _terminal("git_bash_2011.png", ("linux_tux.svg", "macos_apple.svg", "windows.svg"),
      [bash / Git Bash], [clic droit #sym.arrow.r Open Git Bash here],
      [`utilisateur@machine`, puis `$`], hauteur: 190pt),
  )

  #v(2pt)
  #block(
    width: 100%, inset: (x: 13pt, y: 8pt),
    fill: attention.lighten(90%), stroke: (left: 3pt + attention),
  )[
    #set text(size: 16pt)
    #text(fill: attention, weight: demi-gras)[Le module emploie Git Bash.]
    Git Bash est installé avec git sur les postes. Son interpréteur, bash,
    est celui de Linux et de la plupart des serveurs.
  ]

  #notes[
    Faire repérer l'invite sur chaque capture : elle indique le langage à
    employer. La diapositive suivante détaille celle de Git Bash.

    Logos des systèmes : cmd et PowerShell sous Windows ; bash sous Linux et macOS, et sous
    Windows avec Git Bash.

    Lancer Git Bash : sous Windows 11, « Open Git Bash here » est sous
    « Afficher d'autres options » du menu contextuel (à vérifier sur un
    poste de la salle). Aussi : Démarrer #sym.arrow.r Git Bash. Le
    Terminal Windows ouvre PowerShell.

    Mêmes opérations, lister et copier : `dir`, `copy` (cmd) ;
    `Get-ChildItem`, `Copy-Item` (PowerShell) ; `ls`, `cp` (bash).
    PowerShell connaît `ls`, `cp` comme autres noms, sans leurs options :
    `ls -a` échoue. Les commandes du TD 1b dans les trois interpréteurs
    sont en annexe de son guide.

    PowerShell n'est pas employé : sans droits d'administrateur, il
    n'exécute pas le script d'activation de conda (`activate.ps1 cannot be
    loaded because running scripts is disabled on this system`, relevé en
    2026 sur les postes). PowerShell 7 s'installe aussi sous Linux et
    macOS. Microsoft le recommande pour automatiser Windows (Microsoft
    Learn, « Windows commands », 2025) ; cmd reste pour la compatibilité
    avec MS-DOS (R. Turner, Microsoft, 2018).

    macOS : zsh par défaut, très proche de bash ; les commandes du module
    s'y tapent à l'identique.

    Chiffres : serveurs web 92 % sous Unix, dont Linux (W3Techs, septembre
    2026) ; Linux sur les 500 machines du TOP500 depuis novembre 2017 ;
    plus de 60 % des cœurs des clients d'Azure (page Azure, 27/09/2026).
    Développeurs : bash 49 %, PowerShell 23 % (Stack Overflow 2025).

    Git Bash fournit aussi `ssh`, employé au cours 5. Software Carpentry
    recommande Git for Windows, sans droits d'administrateur ; le MIT
    (_Missing Semester_) écarte cmd et PowerShell. Aucune étude trouvée qui
    compare la facilité d'apprentissage de bash et de PowerShell.

    Raison du choix (syllabus v2) : en 2026, chaque séance employait un
    terminal différent, sans que la différence soit expliquée.

    Non montrés : l'invite de commandes d'Anaconda (partie 3) et le
    terminal de VS Code (cours 2). La capture de Git Bash date de 2011
    (`MINGW32`) : à remplacer par une capture d'un poste de la salle.
  ]
]

// --------------------------------------------
#d("L'invite de Git Bash")[
  #annonce[
    Avant chaque commande, Git Bash affiche une invite qui rappelle
    l'utilisateur, la machine et le dossier courant. La commande se tape après le `$`.
  ]

  // Les couleurs de l'invite réelle de Git Bash, assombries pour le fond
  // blanc : chaque élément de l'invite a la couleur de sa ligne du tableau.
  #let vert = rgb("#1a7f37")
  #let violet = rgb("#a2248f")
  #let jaune = rgb("#9a6700")
  #let invite = (
    text(fill: vert, "eleve@POSTE-12"), " ",
    text(fill: violet, "MINGW64"), " ",
    text(fill: jaune, "~/Desktop/info01/cours1"),
  ).join()
  #let ligne(couleur, element, sens) = (
    text(fill: couleur, raw(element)), text(fill: couleur, sens),
  )
  #grid(
    columns: (1.25fr, 1fr), column-gutter: 18pt, align: horizon,
    fenetre("MINGW64:/c/Users/eleve/Desktop/info01/cours1", code: true)[
      #set text(size: 11pt)
      #invite \
      \$ ls \
      1a#sym.underscore;formats/#h(0.6em)1b#sym.underscore;terminal/#h(0.6em)1c#sym.underscore;programme/#h(0.6em)1d#sym.underscore;notebook/ \
      #v(0.4em)
      #invite \
      \$
    ],
    tableau(
      columns: (auto, 1fr),
      align: left + horizon,
      [Dans l'invite], [Ce qu'il désigne],
      ..ligne(vert, "eleve", [l'utilisateur]),
      ..ligne(vert, "POSTE-12", [la machine]),
      ..ligne(violet, "MINGW64", [Git Bash sous Windows]),
      ..ligne(jaune, "~", [le dossier personnel, `C:\Users\eleve`]),
      ..ligne(jaune, "~/Desktop/…", [le dossier courant]),
      [`$`], [l'attente d'une commande],
    ),
  )

  #legende[
    Le `/` à la fin d'un nom signale un dossier. Après le TD 1c, une ligne
    `(base)` s'ajoute au-dessus : l'environnement conda actif.
  ]

  #notes[
    Schéma : les couleurs sont celles de l'invite réelle (utilisateur et
    machine en vert, `MINGW64` en violet, dossier en jaune), assombries pour
    le fond blanc. Le nom du poste est inventé.

    Le dossier courant est celui où s'exécutent les commandes : `ls` sans
    argument liste ce dossier. Le faire repérer sur leur écran au TD 1b.

    Git Bash ajoute `-F` à `ls` (alias de `/etc/profile.d/aliases.sh`), d'où
    le `/` après les dossiers.
  ]
]

// --------------------------------------------
#d("La forme d'une commande")[
  #annonce[
    Une commande commence par le nom du programme à lancer. Suivent des
    options, qui commencent par un tiret, et des arguments, souvent des noms
    de fichiers.
  ]

  #tableau(
    columns: (auto, auto, auto, 1fr),
    align: left + horizon,
    [Commande tapée], [Programme], [Options], [Arguments],
    [`ls`], [`ls`], [], [],
    [`ls -a depart`], [`ls`], [`-a`], [`depart`],
    [`cp depart/raven.odt travail/`], [`cp`], [], [`depart/raven.odt`, `travail/`],
    [`python --version`], [`python`], [`--version`], [],
    [`ls --help`], [`ls`], [`--help`], [],
  )

  #legende[
    Une option d'une lettre prend un tiret, une option en toutes lettres en
    prend deux. `--help` affiche l'aide de la plupart des commandes.
  ]

  #notes[
    L'interpréteur découpe la ligne aux espaces : le premier mot est le
    programme, les autres lui sont transmis. D'où les guillemets autour d'un
    nom de fichier qui contient une espace, au TD 1b.

    Forme générale, à écrire au tableau :
    `commande [options] <arguments>`. Les crochets désignent ce qui est
    facultatif, les chevrons ce qu'on remplace.
  ]
]

// --------------------------------------------
// 28/09 : une ligne par forme de commande, en deux diapositives.
#d("Les commandes de base : se déplacer")[
  #annonce[
    Chaque commande de base a son équivalent à la souris dans l'explorateur
    de fichiers.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Commande], [Ce qu'elle fait], [Dans l'explorateur],
    [`pwd`], [affiche le dossier courant], [la barre d'adresse],
    [`ls`], [liste le dossier courant], [la fenêtre ouverte],
    [`ls dossier`], [liste le dossier nommé], [ouvrir ce dossier],
    [`cd dossier`], [descend dans le dossier nommé], [double-clic sur le dossier],
  )

  // 09/11/2026 : la ligne `cd ..` est retirée, `..` n'étant présenté qu'ensuite.
  #notes[
    Montrer `cd ..` sur « Le chemin d'un fichier en ligne de commande », après la
    présentation de `..`.
  ]
]

#d("Les commandes de base : agir sur les fichiers")[
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Commande], [Ce qu'elle fait], [Dans l'explorateur],
    [`cp source destination`], [copie un fichier], [`Ctrl` + `C`, puis `Ctrl` + `V`],
    [`mv source destination`], [déplace ou renomme], [glisser ; `F2`],
    [`mkdir nom`], [crée un dossier], [Nouveau dossier],
    [`rm fichier`], [supprime, sans passer par la corbeille], [`Suppr`],
    [`start fichier`], [ouvre avec le logiciel associé], [double-clic],
  )

  #notes[
    `cp -r` et `rm -r` pour un dossier : le donner si la question vient.

    `start` est propre à Windows (Git Bash le fournit) ; `open` sous macOS,
    `xdg-open` sous Linux. À vérifier sur un poste de la salle ; à défaut,
    `explorer.exe fichier`.

    L'aide-mémoire de la séance reprend ce tableau (proposition du syllabus
    v2, à valider).
  ]
]

// ------------------------------- Chemins -----------------------------------

// --------------------------------------------
// 09/11/2026 : les exemples passent en chemins de Git Bash, qui suit la convention de
// Linux, sur les dossiers du poste (`/c/Users/eleve/Desktop/info01`). Les correspondances
// de l'ancienne « Les chemins dans Git Bash » viennent en tête ; celle-ci laisse sa place à
// « Le fichier exécutable d'une commande ». Exemple refait le 28/09 sur les dossiers v2.
#d("Le chemin d'un fichier en ligne de commande")[
  #annonce[
    En ligne de commande, un fichier se désigne par son chemin, écrit après
    le nom de la commande. Un chemin #text(fill: attention, weight: demi-gras)[absolu] part de la
    racine, un chemin #text(fill: attention, weight: demi-gras)[relatif] du
    dossier où l'on se trouve.
  ]

  #grid(
    columns: (1.6fr, 1fr), column-gutter: 16pt, align: horizon,
    {
      show table.cell: set text(size: 14pt)
      tableau(
        columns: (auto, auto, 1fr),
        align: left + horizon,
        [Dans l'explorateur], [Dans Git Bash], [],
        [`C:\Users\eleve`], [`/c/Users/eleve`], [chemin absolu],
        [`C:\Users\eleve`], [`~`], [le dossier personnel],
        [le dossier au-dessus], [`..`], [le dossier parent],
      )
    },
    block(inset: (x: 10pt, y: 8pt), fill: gris)[
      #set text(font: police-code, size: 12.5pt)
      #set par(leading: 0.6em)
      \~/Desktop/info01/cours1/ \
      ├─ 1a_formats/depart/raven.odt \
      └─ 1c_programme/altitudes.py
    ],
  )

  #v(0.3em)
  #{
    show table.cell: set text(size: 14pt)
    tableau(
      columns: (auto, 1fr, auto),
      align: left + horizon,
      [], [Le chemin de `raven.odt`], [Depuis],
      [Absolu], [`/c/Users/eleve/Desktop/info01/cours1/1a_formats/depart/raven.odt`], [la racine],
      [Relatif], [`1a_formats/depart/raven.odt`], [`cours1`],
      [Relatif qui remonte], [`../1a_formats/depart/raven.odt`], [`1c_programme`],
    )
  }

  #legende[
    Exemples dans Git Bash, qui écrit les chemins à la façon de Linux et de macOS : le disque
    `C:` devient `/c`, et chaque `\` devient `/`. Sous Windows, Python accepte aussi les `/`.
  ]

  #notes[
    Les exemples sont les chemins que les élèves tapent au TD 1b. L'explorateur de Windows
    affiche les mêmes chemins avec `C:` et des `\`.

    L'intérêt du relatif, à dire avec la légende : un programme ne connaît
    pas a priori le chemin absolu du dossier d'un utilisateur, mais il peut
    imposer une arborescence relative, comme `../1a_formats/`, et il tourne
    chez tout le monde. Le chemin en dur, absolu, casse au premier
    changement de poste ; le TD 2b en fait corriger un.

    Lire l'arborescence avant le tableau : les trois chemins désignent le
    même fichier, `raven.odt`, et ne diffèrent que par l'endroit d'où on le
    demande.

    Un point désigne le dossier courant, comme dans `./python.exe` au TD 1c. Le donner en
    passant.

    Un chemin copié depuis la barre d'adresse de l'explorateur garde ses `\` : dans Git
    Bash, il s'écrit entre guillemets. `cd "C:\Users\eleve\Desktop"` fonctionne ; sans
    guillemets, les `\` sont lus comme des caractères d'échappement. À vérifier sur un poste
    de la salle, avec le glisser-déposer d'un dossier dans la fenêtre de Git Bash.

    `~` se tape `AltGr` + `2`, puis espace, sur un clavier français.
  ]
]

// --------------------------------------------
// Nouveau (09/11/2026), à la place de « Les chemins dans Git Bash », passée sur la
// diapositive précédente. Le TD 1c emploie `which python` et lance Python par son chemin :
// cette diapositive présente les deux.
// 09/11/2026, seconde version : le Bloc-notes remplace `ls`. `which ls` affiche
// `/usr/bin/ls`, un chemin propre à Git Bash, que l'élève ne retrouve pas dans
// l'explorateur avec la règle de « Le chemin d'un fichier en ligne de commande » ; le
// chemin du Bloc-notes, en `/c/`, la suit. Sorties de Git Bash sous Windows, à relever sur
// un poste de la salle (voir les notes).
#d("Le fichier exécutable d'une commande")[
  #annonce[
    Une commande lance un fichier exécutable. `which` affiche le chemin de ce fichier, et ce
    chemin peut remplacer le nom de la commande.
  ]

  #terminal(
    taille: 19pt,
    "$ which notepad",
    "/c/Windows/system32/notepad",
    "$ /c/Windows/system32/notepad.exe depart/raven_une_ligne.txt",
  )

  // Sans chemin, le premier fichier trouvé ; d'où le chemin ou le réglage quand plusieurs
  // versions d'un programme sont installées.
  #v(0.3em)
  #{
    show table.cell: set text(size: 15pt)
    tableau(
      columns: (auto, 1fr),
      align: left + horizon,
      [Commande tapée], [Fichier lancé],
      [`notepad fichier`], [le premier fichier `notepad` trouvé dans les dossiers du `PATH`, ici `/c/Windows/system32/notepad`],
      [`/c/Windows/system32/notepad.exe fichier`], [le fichier de ce chemin, `C:\Windows\System32\notepad.exe`, sans recherche],
    )
  }

  #legende[
    Les deux commandes ouvrent le fichier dans le Bloc-notes. Quand plusieurs versions d'un
    programme sont installées sur le poste, comme Python au TD 1c, il faut écrire le chemin
    du fichier, ou régler le `PATH`.
  ]

  #notes[
    À relever sur un poste de la salle avant la séance : la casse affichée par `which
    notepad`, qui suit l'écriture du `PATH` du poste (`/c/WINDOWS/system32` sur certains
    postes) ; l'ouverture du poème dans le Bloc-notes sous Windows 11, où `notepad.exe`
    lance la nouvelle application ; l'attente de Git Bash jusqu'à la fermeture du
    Bloc-notes, avant l'invite suivante.

    Git Bash parcourt dans l'ordre la liste de dossiers du `PATH` (`echo $PATH`). Au TD 1c,
    conda ajoute son dossier en tête de cette liste, et `python` lance alors le Python
    d'Anaconda.

    Si la question vient : `which ls` affiche `/usr/bin/ls`. Git Bash appelle `/` son
    dossier d'installation, `C:\Program Files\Git`, et ce fichier est donc
    `C:\Program Files\Git\usr\bin\ls.exe` ; `cygpath -w /usr/bin/ls` affiche ce chemin.
    Seuls les chemins qui commencent par `/c/` suivent la règle de la diapositive
    précédente.

    Dans cmd, `where notepad` affiche le même fichier ; dans PowerShell, `Get-Command
    notepad`.
  ]
]

// --------------------------------------------
// 28/09 : « Les fichiers cachés » et « Le motif * » réunies, textes gardés.
// 09/11/2026 : l'arborescence du dossier du TD 1b, tel qu'il est livré, à gauche ; les
// exemples de droite s'y appliquent. `*` est nommé « caractère générique ». Deux exemples
// sur trois, et la légende passe dans les notes.
#let _phrase-panneau(corps) = text(size: 15pt, fill: estompe, weight: demi-gras, corps)
#d([Fichiers cachés et caractère générique `*`])[
  #grid(
    columns: (1fr, 1.2fr), column-gutter: 22pt, align: top,
    [
      #block(width: 100%, inset: (x: 10pt, y: 9pt), fill: gris, stroke: 1pt + accent.lighten(62%))[
        #set text(size: 18pt)
        #set align(left)
        #raw(
"1b_terminal/
├── depart/
│   ├── auld_lang_syne.odt
│   ├── auld_lang_syne_une_ligne.donnees
│   ├── auld_lang_syne_une_ligne.txt
│   ├── raven.odt
│   ├── raven_une_ligne.donnees
│   └── raven_une_ligne.txt
└── travail/           vide")
      ]
      #legende[Le dossier du TD 1b, tel qu'il est livré.]
    ],
    [
      #_phrase-panneau[Un nom qui commence par un point désigne un fichier caché : `ls` ne l'affiche pas, `ls -a` l'affiche.]
      ```console
      $ ls travail
      $ ls -a travail
      ./  ../
      ```
      #text(size: 14pt, fill: estompe)[
        `.` et `..`, le dossier courant et son parent, sont les deux
        entrées cachées de tout dossier.
      ]
      #v(0.3em)
      #_phrase-panneau[Dans un nom de fichier, le caractère générique `*` remplace n'importe quelle suite de caractères.]
      #tableau(
        columns: (auto, 1fr),
        align: left + horizon,
        [Commande], [Noms désignés dans `depart/`],
        [`ls depart/*.txt`], [les deux fichiers `.txt`],
        [`ls depart/raven*`], [les trois fichiers de _The Raven_],
      )
    ],
  )

  #notes[
    Sorties relevées le 09/11/2026 sur le dossier livré du TD 1b (bash 5.2 sous Linux,
    `ls -F`). `ls depart/*.txt` donne `auld_lang_syne_une_ligne.txt` et
    `raven_une_ligne.txt` ; `ls depart/raven*`, `raven.odt`, `raven_une_ligne.donnees` et
    `raven_une_ligne.txt`.

    Les exemples portent sur le dossier du TD 1b, ouvert juste après, car le `travail/` du
    TD 1a contient déjà les exports.

    Git Bash remplace le motif, par exemple `*.txt`, par la liste des noms qui
    correspondent, puis lance la commande. Troisième exemple, retiré pour la place :
    `cp depart/*.odt travail/` copie les deux documents LibreOffice.

    `*` s'appelle aussi joker (_wildcard_). L'expression entière, `*.txt`, est un motif,
    _glob_ en anglais ; le cours 3 emploie le mot avec `Path.glob`.

    Fichiers cachés à venir : `.bash_profile`, créé au TD 1c dans le dossier personnel ; le
    dossier `.git`, au cours 2.

    Dans l'explorateur de Windows : Affichage, Afficher, Éléments masqués.
    Windows marque un fichier caché par un attribut ; Git Bash suit la
    convention du point, celle de Linux et de macOS.

    Le cours 2 de 2026 appelait ces motifs « expressions régulières », à
    tort : les expressions régulières (`grep`, module `re` de Python) ont
    une autre syntaxe, où `*` répète le caractère précédent.

    `?` remplace un seul caractère ; ne le donner que si la question vient.
  ]
]
