// Partie 2 du cours 1 v2, première moitié : le terminal. Incluse par
// `cours1_v2.typ`. Un fichier inclus n'hérite pas des imports de son appelant.
//
// Nouveau (v2) : le terminal passe du cours 2 au cours 1, avec un TD. Les
// diapositives du cours 2 de 2026 (Beamer, listes à puces) sont réécrites ;
// les diapositives sur les chemins du cours 1 de 2026 sont reprises sans être
// reformulées, le quiz sur leur vocabulaire dans la partie 1.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": explorateur-copie, git-bash-copie, chaine-terminal, git-bash-ls

#separateur(
  "Terminal et premier programme",
  annonce: "Se déplacer dans les dossiers et agir sur les fichiers en tapant des commandes, puis lancer un programme Python écrit dans un éditeur de texte.",
)

// --------------------------------------------
// Nouveau (v2), 27/09 : interface graphique et ligne de commande, avant le
// vocabulaire du terminal.
#d("Interface graphique et ligne de commande")[
  #annonce[
    Dans une interface graphique, on choisit l'opération parmi celles que la
    fenêtre affiche. En ligne de commande, on tape le nom de l'opération, qu'il
    faut connaître.
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

// --------------------------------------------
// Nouveau (v2), 27/09.
#d("Une opération sur 120 fichiers")[
  #annonce[
    Dans Paint, il faut refaire les mêmes opérations pour chacune des 120
    images.
  ]

  #panneau[Interface graphique : Paint, pour chaque image][
    #grid(
      columns: (1fr, auto), column-gutter: 20pt, align: horizon,
      chaine(
        ("Ouvrir", [`depart/img_001.png`]),
        ("Redimensionner", "640 pixels de large"),
        ("Enregistrer sous", [dans `travail/`]),
      ),
      text(size: 34pt, weight: demi-gras)[× 120],
    )
  ]
  #panneau[Ligne de commande : Git Bash, pour toutes les images][
    #fenetre("Git Bash", code: true)[
      #text(size: 19pt, raw("$ magick mogrify -path travail -resize 640 depart/*.png"))
    ]
  ]

  #legende[
    Le motif `*` désigne les 120 fichiers de `depart/`. Des logiciels
    graphiques ont aussi un traitement par lots, limité aux opérations qu'ils
    prévoient.
  ]

  #notes[
    Commande exécutée avec ImageMagick 7.1 sur trois PNG de 1920 × 1080,
    qui donne trois PNG de 640 × 360 dans `travail/`.

    Ne pas faire taper la commande : `magick`, le programme d'ImageMagick,
    n'est disponible qu'au cours 4, dans l'environnement `animation`.

    Exemple de Software Carpentry (« Introducing the Shell ») : 1 520
    fichiers à ouvrir un par un, plus de 12 heures d'attention.
  ]
]

// --------------------------------------------
// Nouveau (v2), 27/09. Sources dans les notes ; la vitesse n'est pas une
// ligne du tableau, les mesures publiées étant partagées.
#d("Comparaison des deux interfaces")[
  #annonce[
    L'interface graphique se prend en main plus vite. La ligne de commande
    répète une opération sur beaucoup de fichiers, et la commande se
    conserve pour être relancée.
  ]

  #tableau(
    columns: (auto, 1fr, 1.25fr),
    align: left + horizon,
    [], [Interface graphique], [Ligne de commande],
    [Trouver une opération], [dans les menus affichés], [connaître son nom, ou lire l'aide],
    [Voir le résultat], [après chaque action], [en le demandant],
    [Premières utilisations], [peu d'erreurs], [des fautes de frappe, des options oubliées],
    [Traiter 120 fichiers], [120 fois la même opération], [une commande, avec un motif],
    [Refaire le travail plus tard], [refaire chaque action], [relancer la commande, gardée dans un fichier],
    [Travailler sur un serveur], [s'il a un bureau à distance], [par `ssh`, vu au cours 5],
  )

  #notes[
    Novices, MS-DOS contre Macintosh : plus d'erreurs et plus de temps en
    ligne de commande (Margono et Shneiderman, 1987).

    Ne pas dire que la ligne de commande est plus rapide en général : les
    mesures publiées sont partagées (Cockburn et al., _ACM Computing
    Surveys_, 2014). L'écart porte sur le nombre d'actions quand les
    fichiers sont nombreux.

    Garder une commande dans un fichier pour la relancer : Software
    Carpentry, « Shell Scripts » ; Wilson et al., « Good enough practices in
    scientific computing », 2017.

    Si la question vient : Power Automate pour le bureau, de Microsoft,
    enchaîne des clics et des opérations sur les fichiers sans commande.
  ]
]

// --------------------------------------------
#d("Le terminal et l'interpréteur de commandes")[
  #annonce[
    Le terminal est la fenêtre : il affiche du texte et transmet ce qu'on
    tape. L'interpréteur de commandes lit chaque ligne et lance le programme
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
#d("Les terminaux d'un poste Windows")[
  #annonce[
    Plusieurs terminaux sont installés sur les postes de la salle, chacun
    avec son interpréteur. Le module emploie Git Bash, installé avec git.
  ]

  #tableau(
    columns: (auto, 1fr, auto, 1fr),
    align: left + horizon,
    [Terminal], [Où le trouver], [Interpréteur], [Dans le module],
    [Invite de commandes], [menu Démarrer], [cmd], [celle d'Anaconda, pour Python et JupyterLab],
    [Terminal Windows], [menu Démarrer], [PowerShell], [non employé],
    surligne[Git Bash], surligne[clic droit dans un dossier],
      surligne[bash], surligne[à toutes les séances],
  )

  #legende[
    bash est l'interpréteur des terminaux de Linux ; zsh, très proche, celui
    de macOS. Les commandes du module s'y tapent à l'identique.
  ]

  #notes[
    Non montrés ici (27/09) : l'invite de commandes d'Anaconda, qui lance
    JupyterLab à la partie 3, et le terminal de VS Code, au cours 2.

    Raison du choix (syllabus v2) : en 2026, chaque séance employait un
    terminal différent (PowerShell remplacé par un profil « Anaconda Prompt » au
    cours 1, bash au cours 2, invite de commandes d'Anaconda et Git Bash au cours 3), sans
    que la différence soit expliquée.

    Windows 11 : « Open Git Bash here » est sous « Afficher d'autres
    options » du menu contextuel. À vérifier sur un poste de la salle.

    PowerShell n'est pas employé : sans droits d'administrateur, il
    n'exécute pas le script d'activation de conda, `activate.ps1 cannot be loaded because running scripts is
    disabled on this system`, relevé en 2026 sur les postes.
  ]
]

// --------------------------------------------
// Nouveau (v2), 27/09 : les raisons du choix de bash. Sources dans les notes.
#d("Le choix de Git Bash")[
  #annonce[
    bash n'est pas fourni avec Windows. Le module l'emploie parce qu'il est
    l'interpréteur de Linux, installé sur la plupart des serveurs, et que Git
    Bash est installé avec git.
  ]

  #tableau(
    columns: (auto, 1fr, 1.2fr, 1.1fr),
    align: left + horizon,
    [], [cmd], [PowerShell], surligne[bash, dans Git Bash],
    [Sur les postes], [avec Windows], [avec Windows], surligne[avec git],
    [Sous Linux et macOS], [absent], [à installer], surligne[bash ; zsh sous macOS],
    [Statut], [conservé pour la compatibilité], [recommandé par Microsoft], surligne[logiciel libre, GNU],
    [Lister, copier], [`dir`, `copy`], [`Get-ChildItem`, `Copy-Item`], surligne[`ls`, `cp`],
    [Développeurs], [non compté], [23 %], surligne[49 %],
  )

  #legende[
    Serveurs web : 92 % sous Unix, dont Linux (W3Techs, septembre 2026).
    Développeurs : enquête Stack Overflow 2025. Les commandes du TD 2a dans
    les trois interpréteurs sont en annexe de son guide.
  ]

  #notes[
    Microsoft recommande PowerShell pour automatiser Windows (Microsoft
    Learn, « Windows commands », 2025). cmd
    reste pour la compatibilité avec les scripts de MS-DOS et évolue peu
    (R. Turner, blog Windows Command Line de Microsoft, 2018).

    PowerShell connaît `ls`, `cp`, `mv`, `rm` comme autres noms de ses
    commandes, sans leurs options : `ls -a` échoue, `ls -Force` liste les
    fichiers cachés.

    Linux : 500 des 500 machines du TOP500 depuis novembre 2017 ; plus de
    60 % des cœurs des clients d'Azure, le nuage de Microsoft (page Azure,
    lue le 27/09/2026).

    Git Bash fournit aussi `ssh`, employé au cours 5.

    Software Carpentry recommande Git for Windows sous Windows, sans droits
    d'administrateur. Le MIT (_Missing Semester_) écarte cmd et PowerShell,
    propres à Windows.

    Aucune étude trouvée qui compare la facilité d'apprentissage de bash et
    de PowerShell.
  ]
]

// --------------------------------------------
// Nouveau (v2) : captures trouvées en ligne, en attendant celles d'un poste de
// la salle ; sources dans `src/cours1_v2/images/terminaux/CREDITS.md`.
#let _capture(fichier, legende-capture, hauteur: 98pt) = block(width: 100%)[
  #align(center, box(
    stroke: 1pt + accent.lighten(55%),
    image("/src/cours1_v2/images/terminaux/" + fichier, height: hauteur),
  ))
  #v(-0.3em)
  #align(center, text(size: 14pt, fill: estompe)[#legende-capture])
]

#d("Trois terminaux à l'écran")[
  #annonce[
    L'invite, au début de chaque ligne, indique quel interpréteur lit la
    commande.
  ]

  #grid(
    columns: (1fr, 1fr, 1fr), column-gutter: 12pt,
    _capture("git_bash_2011.png", hauteur: 125pt)[Git Bash : \ `utilisateur@machine`, puis `$`],
    _capture("cmd_windows11.png", hauteur: 125pt)[Invite de commandes : \ `C:\Users\…>`],
    _capture("powershell_terminal_windows.png", hauteur: 125pt)[PowerShell : \ `PS C:\Users\…>`],
  )

  #notes[
    Captures en ligne (Wikimedia Commons, The Carpentries), sources dans
    `CREDITS.md`. La capture de Git Bash date de 2011 (`MINGW32`) : à
    remplacer par une capture d'un poste de la salle. L'invite de commandes
    d'Anaconda, qui n'a pas encore été vue, est retirée (27/09).

    Faire repérer l'invite sur chacune : elle indique le langage à employer.
  ]
]

// --------------------------------------------
#d("L'invite de Git Bash")[
  #annonce[
    Avant chaque commande, Git Bash affiche une invite : l'utilisateur, la
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
      1a#sym.underscore;formats/#h(0.6em)2a#sym.underscore;terminal/#h(0.6em)2b#sym.underscore;programme/#h(0.6em)3a#sym.underscore;notebook/ \
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
    Le `/` à la fin d'un nom signale un dossier. Après le TD 2b, une ligne
    `(base)` s'ajoute au-dessus : l'environnement conda actif.
  ]

  #notes[
    Schéma : les couleurs sont celles de l'invite réelle (utilisateur et
    machine en vert, `MINGW64` en violet, dossier en jaune), assombries pour
    le fond blanc. Le nom du poste est inventé.

    Le dossier courant est celui où s'exécutent les commandes : `ls` sans
    argument liste ce dossier. Le faire repérer sur leur écran au TD 2a.

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
    nom de fichier qui contient une espace, au TD 2a.

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
// Reprise de la diapositive 17 du cours 1 de 2026, sans reformulation. Le quiz
// des diapositives 15 et 16 est dans la partie 1, après les formats.

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
      #h(0.75em)└─ 2b_programme\\ \
      #h(2.05em)└─ altitudes.py
    ],
    tableau(
      columns: (auto, 1fr, auto),
      align: left + horizon,
      [], [Le chemin de `raven.odt`], [Depuis],
      [Absolu], [`C:\Users\alice\cours1\1a_formats\depart\raven.odt`], [la racine],
      [Relatif], [`1a_formats\depart\raven.odt`], [`cours1`],
      [Relatif qui remonte], [`..\1a_formats\depart\raven.odt`], [`2b_programme`],
    ),
  )

  #legende[
    Sous macOS et Linux, l'autre séparateur : `/home/alice/cours1/1a_formats/depart/raven.odt`.
    Un projet qui n'écrit que des chemins relatifs se copie, se déplace et
    s'envoie sans rien changer : `C:\Users\alice` n'existe que sur un poste.
  ]

  #notes[
    L'intérêt du relatif, à dire avec la légende : un programme ne connaît
    pas a priori le chemin absolu du dossier d'un utilisateur, mais il peut
    imposer une arborescence relative, comme `../1a_formats/`, et il tourne
    chez tout le monde. Le chemin en dur, absolu, casse au premier
    changement de poste ; le TD 1b du cours 2 en fait corriger un.
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
        [`ls depart/raven*`], [les cinq fichiers de *The Raven*],
        [`cp depart/*.html travail/`], [les quatre pages web],
      )
    ],
  )

  #legende[
    Git Bash remplace le motif par la liste des noms qui correspondent, puis
    lance la commande. Le TD 2b crée un fichier caché, `.bash_profile`,
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
