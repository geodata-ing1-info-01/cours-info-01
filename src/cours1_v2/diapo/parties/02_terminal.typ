// Partie 2 du cours 1 v2, première moitié : le terminal. Incluse par
// `cours1_v2.typ`. Un fichier inclus n'hérite pas des imports de son appelant.
//
// Nouveau (v2) : le terminal passe du cours 2 au cours 1, avec un TD. Les
// diapositives du cours 2 de 2026 (Beamer, listes à puces) sont réécrites ;
// les trois diapositives sur les chemins du cours 1 de 2026 sont reprises
// sans être reformulées.
#import "../../../commun/prelude.typ": *

#separateur(
  "Terminal et premier programme",
  annonce: "Se déplacer dans les dossiers et agir sur les fichiers en tapant des commandes, puis lancer un programme Python écrit dans un éditeur de texte.",
)

// --------------------------------------------
#d("Le terminal et l'interpréteur de commandes")[
  #annonce[
    Le terminal est la fenêtre : il affiche du texte et transmet ce qu'on
    tape. L'interpréteur de commandes lit chaque ligne et lance le programme
    qu'elle nomme.
  ]

  #chaine(
    ("Ce qu'on tape", "ls depart, puis Entrée"),
    ("Le terminal", "la fenêtre, qui transmet la ligne"),
    ("L'interpréteur de commandes", "bash : découpe la ligne, lance ls"),
    ("Le programme ls", "écrit la liste des fichiers"),
    pleins: (2,),
  )

  #v(0.4em)
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
    [Invite de commandes], [menu Démarrer], [cmd], [non employé],
    [Terminal Windows], [menu Démarrer], [PowerShell], [non employé],
    [Anaconda Prompt], [menu Démarrer], [cmd et conda], [en dépannage],
    surligne[Git Bash], surligne[clic droit dans un dossier],
      surligne[bash], surligne[à toutes les séances],
    [Terminal de VS Code], [dans l'éditeur], [au choix], [Git Bash, dès le cours 2],
  )

  #legende[
    bash est l'interpréteur des terminaux de Linux ; zsh, très proche, celui
    de macOS. Les commandes du module s'y tapent à l'identique.
  ]

  #notes[
    Raison du choix (syllabus v2) : en 2026, chaque séance employait un
    terminal différent (PowerShell remplacé par un profil Anaconda Prompt au
    cours 1, bash au cours 2, Anaconda Prompt et Git Bash au cours 3), sans
    que la différence soit expliquée.

    Windows 11 : « Open Git Bash here » est sous « Afficher d'autres
    options » du menu contextuel. À vérifier sur un poste de la salle.

    PowerShell n'est pas employé : sans droits d'administrateur, il
    n'exécute pas le script d'activation de conda, `activate.ps1 cannot be loaded because running scripts is
    disabled on this system`, relevé en 2026 sur les postes.
  ]
]

// --------------------------------------------
// Nouveau (v2) : captures trouvées en ligne, en attendant celles d'un poste de
// la salle ; sources dans `src/cours1_v2/images/terminaux/CREDITS.md`.
#let _capture(fichier, legende-capture) = block(width: 100%)[
  #align(center, box(
    stroke: 1pt + accent.lighten(55%),
    image("/src/cours1_v2/images/terminaux/" + fichier, height: 98pt),
  ))
  #v(-0.3em)
  #align(center, text(size: 14pt, fill: estompe)[#legende-capture])
]

#d("Quatre terminaux à l'écran")[
  #annonce[
    L'invite, au début de chaque ligne, indique quel interpréteur lit la
    commande.
  ]

  #grid(
    columns: (1fr, 1fr), column-gutter: 16pt, row-gutter: 10pt,
    _capture("git_bash_2011.png")[Git Bash : `utilisateur@machine`, puis `$`],
    _capture("cmd_windows11.png")[Invite de commandes : `C:\Users\…>`],
    _capture("powershell_terminal_windows.png")[PowerShell : `PS C:\Users\…>`],
    _capture("miniforge_prompt.png")[Anaconda Prompt : `(base) C:\Users\…>`],
  )

  #notes[
    Captures en ligne (Wikimedia Commons, The Carpentries), sources dans
    `CREDITS.md`. La capture de Git Bash date de 2011 (`MINGW32`) : à
    remplacer par une capture d'un poste de la salle, comme celle de
    l'Anaconda Prompt (ici le Miniforge Prompt, même fenêtre `cmd`).

    Faire repérer l'invite sur chacune : elle indique le langage à employer.
  ]
]

// --------------------------------------------
#d("L'invite de Git Bash")[
  #annonce[
    Avant chaque commande, Git Bash affiche une invite : l'utilisateur, la
    machine et le dossier courant. La commande se tape après le `$`.
  ]

  #grid(
    columns: (1.25fr, 1fr), column-gutter: 18pt, align: horizon,
    fenetre("MINGW64:/c/Users/eleve/Desktop/info01/cours1", code: true)[
      #raw("eleve@POSTE-12 MINGW64 ~/Desktop/info01/cours1\n$ ls\n1a_formats/  2a_terminal/  2b_programme/\n2c_erreurs/  3a_notebook/\n\neleve@POSTE-12 MINGW64 ~/Desktop/info01/cours1\n$ ")
    ],
    tableau(
      columns: (auto, 1fr),
      align: left + horizon,
      [Dans l'invite], [Ce qu'il désigne],
      [`eleve`], [l'utilisateur],
      [`POSTE-12`], [la machine],
      [`MINGW64`], [Git Bash sous Windows],
      [`~`], [le dossier personnel, `C:\Users\eleve`],
      [`~/Desktop/…`], [le dossier courant],
      [`$`], [l'attente d'une commande],
    ),
  )

  #legende[
    Le `/` à la fin d'un nom signale un dossier. Après le TD 2a, une ligne
    `(base)` s'ajoute au-dessus : l'environnement conda actif.
  ]

  #notes[
    Schéma : l'invite réelle est en couleur (utilisateur en vert, `MINGW64`
    en violet, dossier en jaune). Le nom du poste est inventé.

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
#d("Les commandes de base")[
  #annonce[
    Chaque commande de base a son équivalent à la souris dans l'explorateur
    de fichiers.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Commande], [Ce qu'elle fait], [Dans l'explorateur],
    [`pwd`], [affiche le dossier courant], [la barre d'adresse],
    [`ls` #h(0.3em) `ls dossier`], [liste le contenu d'un dossier], [la fenêtre ouverte],
    [`cd dossier` #h(0.3em) `cd ..`], [change de dossier courant], [double-clic ; flèche « dossier parent »],
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
// Reprise des diapositives 15 à 17 du cours 1 de 2026, sans reformulation.

// --------------------------------------------
#d("Quizz : vocabulaire associé aux chemins de fichier")[
  #annonce[
    Un chemin dit où trouver un fichier dans l'arborescence des dossiers.
    Plusieurs mots en désignent les parties : dites à quoi chacun correspond
    dans cet exemple.
  ]

  #align(center)[
    #text(font: police-code, size: 25pt, fill: encre)[C:\\Users\\alice\\Documents\\raven.odt]
  ]

  #v(0.5em)
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Le mot], [Ce qu'il désigne dans l'exemple],
    [la racine, ou le disque], [],
    [un nom de dossier], [],
    [le nom du fichier], [],
    [le chemin du fichier], [],
    [le dossier parent], [],
  )

  #notes[
    Trois minutes, à l'oral, sans commenter chaque réponse : la diapositive
    suivante donne les réponses.

    Racine : le point de départ que la machine connaît. `C:` désigne le
    disque sous Windows ; sous macOS et Linux, la racine est `/`
  ]
]

// --------------------------------------------
#d("Quizz : vocabulaire associé aux chemins de fichier - Réponse")[
  // Le chemin s'écrit d'un seul tenant, sans blanc entre les segments : c'est
  // ainsi qu'il apparaît dans l'explorateur. Les colonnes sont donc mesurées
  // sur les segments eux-mêmes, et les étiquettes, plus larges, sont posées
  // par `place` : elles débordent de leur colonne sans l'élargir.
  #align(center)[
    #context {
      let taille = 25pt
      let segments = (
        (estompe, "C:\\", "la racine, ou le disque"),
        (brun, "Users\\alice\\Documents\\", "trois noms de dossier"),
        (accent, "raven.odt", "le nom du fichier, extension comprise"),
      )
      let morceau(couleur, chaine) = text(
        font: police-code, size: taille, fill: couleur,
        weight: if couleur == brun { demi-gras } else { "regular" },
        chaine,
      )
      grid(
        columns: segments.map(((c, t, _)) => measure(morceau(c, t)).width),
        column-gutter: 0pt,
        row-gutter: 13pt,
        ..segments.map(((c, t, _)) => morceau(c, t)),
        ..segments.map(((c, _, e)) => {
          // L'étiquette est mesurée puis posée à sa largeur naturelle : sans
          // cela, elle se replierait sur la largeur de son segment.
          let etiq = text(size: 14pt, fill: c)[#e]
          box(width: 100%, height: 1.2em)[
            #place(center + top, box(width: measure(etiq).width, etiq))
          ]
        }),
      )
    }
  ]

  #v(0.6em)
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Le mot], [Ce qu'il désigne dans l'exemple],
    [la racine, ou le disque],
      [#text(fill: estompe)[`C:\`], le point de départ ; `/` sous macOS et Linux],
    [un nom de dossier],
      [#text(fill: brun)[`Users`, `alice`, `Documents`] : trois, du plus large au plus précis],
    [le nom du fichier],
      [`raven.odt`, extension comprise],
    [le chemin du fichier], [tout, de la racine au fichier],
    [le dossier parent],
      [#text(fill: estompe)[`C:\`]#text(fill: brun)[`Users\alice\Documents`], le dossier qui le contient],
  )

  #legende[
    Un chemin se lit de gauche à droite, de la racine au fichier ; chaque
    séparateur descend d'un dossier.
  ]

  #notes[
    Insister sur la dernière ligne : « dossier parent » est le mot des
    messages d'erreur et des fonctions de Python (`Path.parent`). Le cours 3
    s'en sert sans le redéfinir.
  ]
]

// --------------------------------------------
#d("Le chemin d'un fichier")[
  #annonce[
    Un chemin #text(fill: attention, weight: demi-gras)[absolu] part de la
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
      #h(0.75em)│#h(0.3em)└─ raven.odt \
      #h(0.75em)└─ 2b_erreurs\\ \
      #h(2.05em)└─ chemin.py
    ],
    tableau(
      columns: (auto, 1fr, auto),
      align: left + horizon,
      [], [Le chemin de `raven.odt`], [Depuis],
      [Absolu], [`C:\Users\alice\cours1\1a_formats\raven.odt`], [la racine],
      [Relatif], [`1a_formats\raven.odt`], [`cours1`],
      [Relatif qui remonte], [`..\1a_formats\raven.odt`], [`2b_erreurs`],
    ),
  )

  #legende[
    Sous macOS et Linux, l'autre séparateur : `/home/alice/cours1/1a_formats/raven.odt`.
    Un projet qui n'écrit que des chemins relatifs se copie, se déplace et
    s'envoie sans rien changer : `C:\Users\alice` n'existe que sur un poste.
  ]

  #notes[
    L'intérêt du relatif, à dire avec la légende : un programme ne connaît
    pas a priori le chemin absolu du dossier d'un utilisateur, mais il peut
    imposer une arborescence relative : `chemin.py` lit `../1a_formats/`,
    et il tourne chez tout le monde. C'est le chemin en dur, absolu, qui
    casse au premier changement de poste, et le TD 2b en fait corriger un —
    celui-là même, sur ce fichier.

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
#d("Les fichiers cachés")[
  #annonce[
    Un nom qui commence par un point désigne un fichier caché : `ls` ne
    l'affiche pas, `ls -a` l'affiche.
  ]

  #face-a-face(
    panneau[`ls`, sur le dossier `travail/` vide][
      ```console
      $ ls travail
      $
      ```
    ],
    panneau[`ls -a`, sur le même dossier][
      ```console
      $ ls -a travail
      ./  ../
      $
      ```
    ],
  )

  #legende[
    `.` et `..`, le dossier courant et son parent, sont les deux entrées
    cachées de tout dossier. Le TD 2a crée un fichier caché, `.bash_profile`,
    dans le dossier personnel ; le cours 2 un dossier caché, `.git`.
  ]

  #notes[
    Sorties relevées sur le dossier livré du TD 1a, `travail/` encore vide
    (bash 5.2 sous Linux, `ls -F`).

    Dans l'explorateur de Windows : Affichage, Afficher, Éléments masqués.
    Windows marque un fichier caché par un attribut ; Git Bash suit la
    convention du point, celle de Linux et de macOS.
  ]
]

// --------------------------------------------
#d([Le motif `*`])[
  #annonce[
    Dans un nom de fichier, `*` remplace n'importe quelle suite de
    caractères. Git Bash remplace le motif par la liste des noms qui
    correspondent, puis lance la commande.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Commande], [Noms que le motif désigne dans `depart/`],
    [`ls depart/*.txt`], [`auld_lang_syne_une_ligne.txt`, `raven_une_ligne.txt`],
    [`ls depart/raven*`], [les cinq fichiers de *The Raven*],
    [`cp depart/*.html travail/`], [les quatre pages web, copiées dans `travail/`],
  )

  #legende[
    Le motif s'emploie avec toutes les commandes : l'interpréteur le
    remplace avant que le programme ne démarre.
  ]

  #notes[
    Le cours 2 de 2026 appelait ces motifs « expressions régulières », à
    tort : les expressions régulières (`grep`, module `re` de Python) ont
    une autre syntaxe, où `*` répète le caractère précédent.

    `?` remplace un seul caractère ; ne le donner que si la question vient.

    Sorties relevées sur le dossier livré du TD 1a.
  ]
]
