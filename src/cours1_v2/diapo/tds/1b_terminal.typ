// TD 1b du cours 1 v2 — « Rejouer le TD 1a mais en ligne de commande ».
//
// Inclus par `cours1_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 1_v2`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": consignes, comment, constat, git-bash-ouvert, terminal-etapes, etape-terminal

#let td = (
  numero: "1b",
  titre: "Rejouer le TD 1a mais en ligne de commande",
  annonce: "Objectif : manipuler des fichiers en ligne de commande, dans Git Bash : se déplacer, copier, renommer, ouvrir",
  dossier: "cours1/1b_terminal/",
  duree: "15′",
)
#separateur-td(..td)

// 05/11/2026 : les commandes à taper sortent des phrases, dans un bloc de
// terminal. « Copier, renommer, ouvrir », « Un espace dans un nom de fichier » et
// « Copier plusieurs fichiers d'un coup » passent en deux temps : les consignes,
// sans les commandes, à côté de la liste des commandes possibles, puis la
// solution sur la diapositive suivante. Les deux dernières réunissent leurs
// consignes sur une diapositive.
//
// Les lignes de ce tableau sont celles de « Les commandes de base » (partie 2).
// 09/11/2026 : une pile à espacement fixe remplace `panneau`, dont l'espace entre
// l'étiquette et le tableau faisait déborder les diapositives.
#let _rappel-commandes = stack(
  dir: ttb, spacing: 8pt,
  text(size: 15pt, fill: estompe, weight: demi-gras)[Commandes possibles],
  {
    show table.cell: set text(size: 14pt)
    show raw: set text(size: 1.15em)
    tableau(
      entete: false,
      columns: (auto, 0.75fr, auto, 1.25fr),
      align: left + horizon,
      [`ls dossier`], [liste le dossier nommé],
      [`mkdir nom`], [crée un dossier],
      [`cp source destination`], [copie un fichier],
      [`rm fichier`], [supprime, sans passer par la corbeille],
      [`mv source destination`], [déplace ou renomme],
      [`start fichier`], [ouvre avec le logiciel associé],
    )
  },
)

#d("Étape 1 · Git Bash dans le dossier du TD")[
  #objectif[
    ouvrir Git Bash dans le dossier du TD, `cours1\1b_terminal`, à partir de l'explorateur.
  ]

  #consignes(
    [Dans l'explorateur, ouvrir le dossier `cours1\1b_terminal`. Il contient les dossiers `depart` et `travail`.],
    [Faire un clic droit sur un endroit vide de la fenêtre. Choisir « Afficher d'autres options », puis « Open Git Bash here ».],
    [Dans la fenêtre de Git Bash, vérifier que la première ligne de l'invite se termine par le dossier du TD, comme sur le schéma.],
  )

  #v(4pt)
  #align(center, box(width: 82%, git-bash-ouvert()))

  #legende[
    Si le menu ne propose pas Git Bash : ouvrir Git Bash depuis le menu
    Démarrer, puis taper `cd ~/Desktop/info01/cours1/1b_terminal`.
  ]

  #notes[
    `depart/` contient les fichiers du TD 1a : les deux TD travaillent sur
    les mêmes fichiers, chacun dans son dossier.

    Windows 11 range « Open Git Bash here » sous « Afficher d'autres
    options ». À vérifier sur un poste de la salle.

    La complétion : taper `cd ~/De`, puis `Tab`. La montrer une fois ici.

    À relever sur un poste de la salle : les colonnes PowerShell et invite de
    commandes de la dernière annexe du guide, tirées de la documentation de
    Microsoft et jamais exécutées ; la présence de l'invite PowerShell d'Anaconda.
  ]
]

// 09/11/2026 : `1a_formats/travail` se liste depuis `depart`, à deux dossiers au-dessus. Le
// retour dans `1b_terminal` passe en dernier : la diapositive suivante part de ce dossier.
#d("Étape 2 · Déplacements et contenu d'un dossier")[
  #objectif[
    avec la ligne de commande : afficher le dossier courant, lister le contenu de `depart` et de
    `travail`, entrer dans le dossier `depart`, lister depuis ce dossier le contenu de
    `1a_formats/travail`, puis revenir dans `1b_terminal`.
  ]

  #grid(
    columns: (1.8fr, 1fr), column-gutter: 14pt, align: top,
    consignes(
      taille: 15pt,
      [Afficher le dossier courant.
        #constat[`/c/Users/eleve/Desktop/info01/cours1/1b_terminal`]],
      [Lister le contenu du dossier courant.
        #constat[`depart/`, `travail/` et les PDF du TD. Le `/` final marque un dossier.]],
      [Lister le contenu de `depart`.
        #constat[Les fichiers des deux textes, `raven.odt` compris.]],
      [Lister le contenu de `travail`, entrées cachées comprises.
        #constat[`./` et `../` seulement : le dossier est vide, à part ces deux entrées cachées.]],
      [Entrer dans `depart`. Afficher le dossier courant, et relire l'invite.
        #constat[Le dossier courant est maintenant `depart`, et l'invite le montre.]],
      [Sans quitter `depart`, lister le contenu de `1a_formats/travail`.
        #constat[`raven.pdf`, `raven.png` et `raven.txt`, si le TD 1a est fait.]],
      [Revenir dans `1b_terminal` pour la suite du TD.],
    ),
    terminal-etapes(
      taille: 18pt,
      etape-terminal("pwd"),
      etape-terminal("ls"),
      etape-terminal("ls depart"),
      etape-terminal("ls -a travail"),
      etape-terminal("cd depart", "pwd"),
      etape-terminal("ls ../../1a_formats/travail"),
      etape-terminal("cd .."),
    ),
  )

  #legende[
    Taper chaque commande dans Git Bash, puis appuyer sur Entrée.
    Pour retrouver une commande déjà tapée, appuyer sur la flèche vers le
    haut. Pour compléter un nom commencé, appuyer sur `Tab`.
  ]

  #notes[
    Faire lire l'invite après chaque `cd` : elle affiche le dossier courant,
    d'où partent les chemins relatifs.

    `ls` d'un dossier vide n'affiche rien : pas de message. Le faire
    remarquer avant `ls -a`.

    Depuis `depart`, `../..` désigne `cours1`, et `../../1a_formats/travail` le dossier
    `travail` du TD 1a. Si l'étape facultative du TD 1a est faite, la liste contient aussi `raven.zip` et le
    dossier `raven/`.
  ]
]

// 09/11/2026 : l'objectif nomme les trois copies, leur dossier et ce qu'il faut noter ; les
// consignes 4 et 5 nomment le dossier `travail`.
#d("Étape 3 · Copie et renommage d'un fichier")[
  #objectif[
    en ligne de commande, obtenir dans `travail` trois copies de `depart/raven.odt`, nommées
    `raven_odt.pdf`, `riri.fifi.loulou.odt` et `raven.loulou`, puis ouvrir chacune et noter quel
    logiciel Windows lance et ce que ce logiciel affiche.
  ]

  #consignes(
    taille: 15pt,
    [Copier `raven.odt` de `depart` dans `travail`.],
    [Renommer la copie en `raven_odt.pdf`.],
    [Ouvrir le fichier renommé. Noter le logiciel qui s'ouvre et ce qu'il affiche.],
    [Copier `raven.odt` dans `travail` sous le nom `riri.fifi.loulou.odt`, puis ouvrir la copie.],
    [Copier `raven.odt` dans `travail` sous le nom `raven.loulou`, puis ouvrir la copie. Si Windows demande un logiciel, choisir LibreOffice Writer.],
  )

  #_rappel-commandes

  #notes[
    Laisser chercher avant de passer à la solution : les commandes de la
    liste suffisent, et le chemin de la source se lit dans l'invite et par
    `ls`.
  ]
]

#d("Étape 3 : solution")[
  #terminal-etapes(
    etape-terminal("cp depart/raven.odt travail/"),
    etape-terminal("mv travail/raven.odt travail/raven_odt.pdf"),
    etape-terminal("start travail/raven_odt.pdf",
      constat: [Un lecteur PDF s'ouvre, et signale une erreur : le contenu du fichier n'est pas du PDF.]),
    etape-terminal("cp depart/raven.odt travail/riri.fifi.loulou.odt", "start travail/riri.fifi.loulou.odt",
      constat: [Writer ouvre le texte : seule la fin du nom compte.]),
    etape-terminal("cp depart/raven.odt travail/raven.loulou", "start travail/raven.loulou",
      constat: [Windows ne connaît pas l'extension `.loulou` et demande quel logiciel employer. Writer ouvre le texte.]),
  )

  #legende[
    `start` ouvre un fichier avec le logiciel que Windows associe à son
    extension, comme un double-clic.
    #reponse[
      Le système ne regarde que le nom. `mv` a changé le nom ; le contenu
      est le même, octet pour octet.
    ]
  ]

  #notes[
    Repris du TD 1a de 2026 (« Renommer une extension »), au terminal.

    `start` est fourni par Git for Windows (`/usr/bin/start`, qui appelle
    `cmd //c start`). À vérifier sur un poste ; à défaut,
    `explorer.exe travail\\raven_odt.pdf` (dans Git Bash, un `\` seul disparaît).

    Extension inconnue : Windows affiche « Comment voulez-vous ouvrir ce
    fichier ? ». Vérifié sous Windows 11 en 2026 : il ne regarde pas le
    contenu.
  ]
]

// 09/11/2026 : l'annonce pose le problème avant l'objectif ; la diapositive de solution
// donne les guillemets.
#d("Étape 4 · Espace dans un nom de fichier")[
  #annonce[
    Dans une commande, les espaces séparent le programme, ses options et ses arguments. Le
    chemin `travail/le corbeau.txt` devient donc deux arguments.
  ]

  #objectif[
    copier `raven_une_ligne.txt` dans `travail` sous le nom `le corbeau.txt`, puis ouvrir la copie ;
    déterminer comment écrire ce nom dans une commande.
  ]

  #consignes(
    taille: 15pt,
    [Copier `raven_une_ligne.txt` de `depart` dans `travail`, sous le nom `le corbeau.txt`. Lire le message.],
    [Écrire le nom pour qu'il reste un seul argument, puis refaire la copie. #comment[Essayer les guillemets.]],
    [Lister le contenu de `travail`.],
    [Ouvrir la copie. #comment[Avec `start`, écrire `""` avant un nom entre guillemets.]],
  )

  #_rappel-commandes

  #notes[
    Laisser chercher. Solution à la diapositive suivante.
  ]
]

#d("Étape 4 : solution")[
  #annonce[
    Entre guillemets, un nom qui contient un espace reste un seul argument.
  ]

  #terminal-etapes(
    etape-terminal("cp depart/raven_une_ligne.txt travail/le corbeau.txt",
      constat: [Un message d'erreur : `cp` a reçu trois noms, dont `travail/le` et `corbeau.txt`.]),
    etape-terminal("cp depart/raven_une_ligne.txt \"travail/le corbeau.txt\"",
      constat: [Aucun message : la copie est faite.]),
    etape-terminal("ls travail",
      constat: [`'le corbeau.txt'`, entre apostrophes, parmi les fichiers.]),
    etape-terminal("start \"\" \"travail/le corbeau.txt\"",
      constat: [Le poème s'ouvre dans le Bloc-notes.]),
  )

  #legende[
    Dans les noms de fichiers du module, `_` remplace l'espace.
  ]

  #notes[
    Message relevé sous Linux avec coreutils 8.32 : `cp: target
    'corbeau.txt' is not a directory`. coreutils 9.4 écrit `No such file or
    directory` ; le sens est le même. `ls` met entre apostrophes un nom qui
    contient un espace, comme il faudrait le taper.

    `start` prend son premier argument entre guillemets pour le titre d'une
    fenêtre : d'où `""` avant le nom. Ne pas s'y attarder ; à vérifier sur un
    poste.
  ]
]

#d("Étape 5 · Copie de plusieurs fichiers avec un motif")[
  #objectif[
    employer le caractère générique `*` pour copier d'un coup les fichiers `.txt` de `depart` dans un nouveau
    dossier, `travail/textes`, et pour lister les fichiers `.odt`.
  ]

  #consignes(
    taille: 17pt,
    [Créer un dossier `textes` dans `travail`.],
    [Copier dans ce dossier tous les fichiers `.txt` de `depart`.],
    [Lister le contenu de `textes`.],
    [Lister les fichiers `.odt` de `depart`.],
    [Supprimer l'une des copies, puis lister de nouveau `textes`.],
  )

  #_rappel-commandes

  #notes[
    Laisser chercher. Solution à la diapositive suivante.

    Le caractère générique `*` est sur « Fichiers cachés et caractère générique `*` », en fin
    de partie 2.
  ]
]

#d("Étape 5 : solution")[
  #terminal-etapes(
    etape-terminal("mkdir travail/textes"),
    etape-terminal("cp depart/*.txt travail/textes/",
      constat: [Aucun message.]),
    etape-terminal("ls travail/textes",
      constat: [`auld_lang_syne_une_ligne.txt  raven_une_ligne.txt`]),
    etape-terminal("ls depart/*.odt",
      constat: [`depart/auld_lang_syne.odt  depart/raven.odt`]),
    etape-terminal("rm travail/textes/auld_lang_syne_une_ligne.txt", "ls travail/textes",
      constat: [Le fichier a disparu. `rm` ne le met pas dans la corbeille.]),
  )

  #notes[
    `*` est remplacé par Git Bash avant que `cp` ne démarre : `cp` reçoit
    les deux noms. Diapositive « Fichiers cachés et caractère générique `*` ».

    Sorties relevées sur le dossier livré, le 19/10/2026, et de nouveau le
    05/11/2026.
  ]
]

// 28/09 : les équivalents PowerShell et invite de commandes sont dans l'annexe
// du guide du TD 1b seulement.
