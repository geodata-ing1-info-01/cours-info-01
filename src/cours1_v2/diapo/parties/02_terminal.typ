// Partie 2 du cours 1 v2, première moitié : le terminal. Incluse par
// `cours1_v2.typ`. Un fichier inclus n'hérite pas des imports de son appelant.
//
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": explorateur-copie, git-bash-copie, chaine-terminal, git-bash-ls

#separateur(
  "Le terminal",
  annonce: "Se déplacer dans les dossiers et agir sur les fichiers en tapant des commandes.",
)

// --------------------------------------------
// interface graphique et ligne de commande, avant le vocabulaire du terminal.
#d("Interface graphique et ligne de commande")[
  #annonce[
    Dans une interface graphique, on choisit l'opération parmi les menus et boutons affichés. 
    En ligne de commande, on tape le nom de l'opération, qu'il faut donc connaître.
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
  ]
]

// Relecture du 19/10/2026 : « Une opération sur 120 fichiers » et
// « Comparaison des deux interfaces » sont retirées. La page de cours
// `02_terminal.md` garde la comparaison.

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
    chaine-terminal(
      ("Ce qu'on tape", "ls depart, puis Entrée"),
      ("Le terminal", "la fenêtre, qui transmet la ligne"),
      ("L'interpréteur de commandes", "bash : découpe la ligne, lance ls"),
      ("Le programme ls", "écrit la liste des fichiers"),
      plein: 2,
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
#let _capture(fichier, nom, lancer, invite, hauteur: 100pt) = align(center, stack(
  dir: ttb, spacing: 5pt,
  text(size: 16pt, weight: demi-gras)[#nom],
  text(size: 13pt, fill: estompe)[#lancer],
  box(
    stroke: 1pt + accent.lighten(55%),
    image("/src/cours1_v2/images/terminaux/" + fichier, height: hauteur),
  ),
  text(size: 13pt, fill: estompe)[Invite : #invite],
))

#let _systemes(..logos, texte) = align(center, stack(
  dir: ttb, spacing: 5pt,
  line(length: 92%, stroke: 1pt + accent.lighten(55%)),
  stack(
    dir: ltr, spacing: 12pt,
    ..logos.pos().map(f => image("/src/cours1_v2/images/os/" + f, height: 20pt)),
  ),
  text(size: 13pt, fill: estompe)[#texte],
))

#d("Les trois terminaux du poste")[
  #annonce[
    L'invite, au début de chaque ligne, indique quel interpréteur lit la
    commande.
  ]

  #grid(
    columns: (1fr, 1fr, auto, 1fr), column-gutter: 10pt, row-gutter: 6pt,
    _capture("cmd_windows11.png", [Invite de commandes (cmd)],
      [Démarrer #sym.arrow.r `cmd`], [`C:\Users\…>`]),
    _capture("powershell_terminal_windows.png", [PowerShell],
      [Démarrer #sym.arrow.r Terminal], [`PS C:\Users\…>`]),
    grid.cell(rowspan: 2, line(angle: 90deg, length: 190pt, stroke: (paint: accent.lighten(55%), thickness: 1pt, dash: "dashed"))),
    _capture("git_bash_2011.png", [bash / Git Bash],
      [clic droit #sym.arrow.r Open Git Bash here], [`utilisateur@machine`, puis `$`]),
    grid.cell(colspan: 2, _systemes("windows.svg")[Windows]),
    _systemes("linux_tux.svg", "macos_apple.svg", "windows.svg")[Linux, macOS ; Windows avec Git Bash],
  )

  #v(2pt)
  #block(
    width: 100%, inset: (x: 13pt, y: 8pt),
    fill: attention.lighten(90%), stroke: (left: 3pt + attention),
  )[
    #set text(size: 16pt)
    #text(fill: attention, weight: demi-gras)[Le module emploie Git Bash.]
    Git Bash est installé avec git sur les postes. Son interpréteur, bash,
    est celui de Linux et de la plupart des serveurs, et les mêmes commandes
    fonctionnent sous macOS.
  ]

  #notes[
    Faire repérer l'invite sur chaque capture : elle indique le langage à
    employer.

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
    Avant chaque commande, Git Bash affiche une invite qui rappelle : l'utilisateur, la
    machine et le dossier courant. La commande se tape après le `$`.
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
    [`cd ..`], [remonte au dossier parent], [flèche « dossier parent »],
  )
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
#d("Le chemin d'un fichier en ligne de commande")[
  #annonce[
    En ligne de commande, un fichier se désigne par son chemin, écrit après
    le nom de la commande. Un chemin #text(fill: attention, weight: demi-gras)[absolu] part de la
    racine, un chemin #text(fill: attention, weight: demi-gras)[relatif] du
    dossier où l'on se trouve.
  ]

  #v(0.4em)
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Windows], [macOS et Linux],
    [Le séparateur de dossiers], [la barre inversée `\`, _backslash_], [la barre `/`, _slash_],
  )

  #v(0.5em)
  #grid(
    columns: (auto, 1fr), column-gutter: 18pt, align: horizon,
    block(inset: (x: 10pt, y: 8pt), fill: gris)[
      #set text(font: police-code, size: 12.5pt)
      #set par(leading: 0.6em)
      C:\\Users\\alice\\ \
      └─ cours1\\ \
      #h(0.75em)├─ 1a_formats\\ \
      #h(0.75em)│#h(0.3em)└─ depart\\ \
      #h(0.75em)│#h(1.6em)└─ raven.odt \
      #h(0.75em)└─ 1c_programme\\ \
      #h(2.05em)└─ altitudes.py
    ],
    tableau(
      columns: (auto, 1fr, auto),
      align: left + horizon,
      [], [Le chemin de `raven.odt`], [Depuis],
      [Absolu], [`C:\Users\alice\cours1\1a_formats\depart\raven.odt`], [la racine],
      [Relatif], [`1a_formats\depart\raven.odt`], [`cours1`],
      [Relatif qui remonte], [`..\1a_formats\depart\raven.odt`], [`1c_programme`],
    ),
  )

  #legende[
    Sous macOS, Linux et python, utilisation d'un autre séparateur : `/home/alice/cours1/1a_formats/depart/raven.odt`.
  ]

  #notes[
    L'intérêt du relatif, à dire avec la légende : un programme ne connaît
    pas a priori le chemin absolu du dossier d'un utilisateur, mais il peut
    imposer une arborescence relative, comme `../1a_formats/`, et il tourne
    chez tout le monde. Le chemin en dur, absolu, casse au premier
    changement de poste ; le TD 2b en fait corriger un.
    (28/09 : exemple refait sur les dossiers de la v2.)

    Lire l'arborescence avant le tableau : les trois chemins désignent le
    même fichier, `raven.odt`, et ne diffèrent que par l'endroit d'où on le
    demande. 

    Deux notations à donner en passant, et à écrire au tableau plutôt qu'à
    projeter : deux points désignent le dossier parent, un point le dossier
    courant. Elles s'écrivent pareil sur les trois systèmes, seul le
    séparateur qui les suit change.
  ]
]

// --------------------------------------------
// Nouveau (v2).
#d("Les chemins dans Git Bash")[
  #annonce[
    Git Bash écrit les chemins à la façon de Linux : des barres obliques, et
    le disque `C:` devient `/c`.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Dans l'explorateur], [Dans Git Bash], [],
    [`C:\Users\eleve\Desktop\info01`], [`/c/Users/eleve/Desktop/info01`], [chemin absolu],
    [`C:\Users\eleve`], [`~`], [le dossier personnel],
    [le dossier ouvert], [`.`], [le dossier courant],
    [le dossier au-dessus], [`..`], [le dossier parent],
    [`..\1a_formats\depart`], [`../1a_formats/depart`], [chemin relatif],
  )

  #legende[
    Un chemin copié depuis la barre d'adresse de l'explorateur garde ses
    `\` : dans Git Bash, il s'écrit entre guillemets.
  ]

  #notes[
    `cd "C:\Users\eleve\Desktop"` fonctionne dans Git Bash ; sans
    guillemets, les `\` sont lus comme des caractères d'échappement.
    À vérifier sur un poste de la salle, avec le glisser-déposer d'un
    dossier dans la fenêtre de Git Bash.

    `~` se tape `AltGr` + `2`, puis espace, sur un clavier français.
  ]
]

// --------------------------------------------
// 28/09 : « Les fichiers cachés » et « Le motif * » réunies, textes gardés.
#d([Fichiers cachés et motif `*`])[
  #face-a-face(
    panneau[Un nom qui commence par un point désigne un fichier caché : `ls` ne l'affiche pas, `ls -a` l'affiche.][
      ```console
      $ ls travail
      $ ls -a travail
      ./  ../
      ```
      #v(0.2em)
      #text(size: 14pt, fill: estompe)[
        `.` et `..`, le dossier courant et son parent, sont les deux
        entrées cachées de tout dossier.
      ]
    ],
    panneau[Dans un nom de fichier, `*` remplace n'importe quelle suite de caractères.][
      #tableau(
        columns: (auto, 1fr),
        align: left + horizon,
        [Commande], [Noms désignés dans `depart/`],
        [`ls depart/*.txt`], [les deux fichiers `.txt`],
        [`ls depart/raven*`], [les trois fichiers de *The Raven*],
        [`cp depart/*.odt travail/`], [les deux documents LibreOffice],
      )
    ],
  )

  #legende[
    Git Bash remplace le motif par la liste des noms qui correspondent, puis
    lance la commande. Le TD 1c crée un fichier caché, `.bash_profile`,
    dans le dossier personnel ; le cours 2 un dossier caché, `.git`.
  ]

  #notes[
    Sorties relevées sur le dossier livré du TD 1a, `travail/` encore vide
    (bash 5.2 sous Linux, `ls -F`). `ls depart/*.txt` donne
    `auld_lang_syne_une_ligne.txt` et `raven_une_ligne.txt`.

    Dans l'explorateur de Windows : Affichage, Afficher, Éléments masqués.
    Windows marque un fichier caché par un attribut ; Git Bash suit la
    convention du point, celle de Linux et de macOS.

    Le cours 2 de 2026 appelait ces motifs « expressions régulières », à
    tort : les expressions régulières (`grep`, module `re` de Python) ont
    une autre syntaxe, où `*` répète le caractère précédent.

    `?` remplace un seul caractère ; ne le donner que si la question vient.
  ]
]
