// TD 1b du cours 1 v2 — « Les fichiers du TD 1a en ligne de commande ».
//
// Inclus par `cours1_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 1_v2`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": consignes, commandes, constat, git-bash-ouvert

#let td = (
  numero: "1b",
  titre: "rejouer le TD 1a mais en ligne de commande",
  annonce: "Objectif : manipuler des fichiers en ligne de commande, dans Git Bash : se déplacer, copier, renommer, ouvrir",
  dossier: "cours1/1b_terminal/",
  duree: "15′",
)
#separateur-td(..td)

#d("Ouvrir Git Bash dans le dossier du TD")[
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
  ]
]

#d("Se déplacer et lister le contenu d'un dossier")[
  #annonce[
    Taper chaque commande dans Git Bash, puis appuyer sur Entrée.
  ]

  #consignes(
    taille: 16pt,
    [Afficher le dossier courant : `pwd`.
      #constat[`/c/Users/eleve/Desktop/info01/cours1/1b_terminal`]],
    [Lister le contenu du dossier courant : `ls`.
      #constat[`depart/`, `travail/` et les PDF du TD. Le `/` final marque un dossier.]],
    [Lister le contenu de `depart` : `ls depart`.
      #constat[Les fichiers des deux textes, `raven.odt` compris.]],
    [Lister le contenu de `travail`, entrées cachées comprises : `ls -a travail`.
      #constat[`./` et `../` seulement : le dossier est vide, à part ces deux entrées cachées.]],
    [Entrer dans `depart` : `cd depart`. Taper ensuite `pwd`, et relire l'invite.
      #constat[Le dossier courant est maintenant `depart`, et l'invite le montre.]],
    [Revenir dans `1b_terminal` : `cd ..`.],
    [Sans quitter `1b_terminal`, lister les fichiers exportés au TD 1a : `ls ../1a_formats/travail`.
      #constat[`raven.pdf` et `raven.png`, si les exports du TD 1a sont faits.]],
  )

  #legende[
    Pour retrouver une commande déjà tapée, appuyer sur la flèche vers le
    haut. Pour compléter un nom commencé, appuyer sur `Tab`.
  ]

  #notes[
    Faire lire l'invite après chaque `cd` : elle affiche le dossier courant,
    d'où partent les chemins relatifs.

    `ls` d'un dossier vide n'affiche rien : pas de message. Le faire
    remarquer avant `ls -a`.
  ]
]

#d("Copier, renommer, ouvrir")[
  #annonce[
    `cp` copie, `mv` renomme, `start` ouvre un fichier avec le logiciel que
    Windows associe à son extension, comme un double-clic.
  ]

  #consignes(
    taille: 16pt,
    [Copier `raven.odt` dans `travail` : `cp depart/raven.odt travail/`.],
    [Renommer la copie en `raven_odt.pdf` : `mv travail/raven.odt travail/raven_odt.pdf`.],
    [Ouvrir le fichier renommé : `start travail/raven_odt.pdf`. Noter le logiciel qui s'ouvre et ce qu'il affiche.
      #constat[Un lecteur PDF s'ouvre, et signale une erreur : le contenu du fichier n'est pas du PDF.]],
    [Copier `raven.odt` sous le nom `riri.fifi.loulou.odt`, puis ouvrir la copie : #commandes("cp depart/raven.odt travail/riri.fifi.loulou.odt", "start travail/riri.fifi.loulou.odt")
      #constat[Writer ouvre le texte : seule la fin du nom compte.]],
    [Copier `raven.odt` sous le nom `raven.loulou`, puis ouvrir la copie. Si Windows demande un logiciel, choisir LibreOffice Writer. #commandes("cp depart/raven.odt travail/raven.loulou", "start travail/raven.loulou")
      #constat[Windows ne connaît pas l'extension `.loulou` et demande quel logiciel employer. Writer ouvre le texte.]],
  )

  #legende[
    #reponse[
      Le système ne regarde que le nom. `mv` a changé le nom ; le contenu
      est le même, octet pour octet.
    ]
  ]

  #notes[
    Repris du TD 1a de 2026 (« Renommer une extension »), au terminal.

    `start` est fourni par Git for Windows (`/usr/bin/start`, qui appelle
    `cmd //c start`). À vérifier sur un poste ; à défaut,
    `explorer.exe travail\raven_odt.pdf`.

    Extension inconnue : Windows affiche « Comment voulez-vous ouvrir ce
    fichier ? ». Vérifié sous Windows 11 en 2026 : il ne regarde pas le
    contenu.
  ]
]

#d("Un espace dans un nom de fichier")[
  #annonce[
    L'interpréteur coupe la ligne aux espaces. Un nom qui en contient s'écrit
    entre guillemets.
  ]

  #consignes(
    taille: 16pt,
    [Copier `raven_une_ligne.txt` sous le nom `le corbeau.txt`, sans guillemets, puis lire le message : #commandes("cp depart/raven_une_ligne.txt travail/le corbeau.txt")
      #constat[Un message d'erreur : `cp` a reçu trois noms, dont `travail/le` et `corbeau.txt`.]],
    [Refaire la copie, avec le nom entre guillemets : #commandes("cp depart/raven_une_ligne.txt \"travail/le corbeau.txt\"")
      #constat[Aucun message : la copie est faite.]],
    [Lister le contenu de `travail` : `ls travail`.
      #constat[`'le corbeau.txt'`, entre apostrophes, parmi les fichiers.]],
    [Ouvrir la copie : `start "" "travail/le corbeau.txt"`.
      #constat[Le poème s'ouvre dans le Bloc-notes.]],
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

#d("Copier plusieurs fichiers d'un coup avec '*'")[
  #consignes(
    taille: 16pt,
    [Créer un dossier `textes` dans `travail` : `mkdir travail/textes`.],
    [Copier dans ce dossier tous les fichiers `.txt` de `depart` : `cp depart/*.txt travail/textes/`.
      #constat[Aucun message.]],
    [Lister le contenu de `textes` : `ls travail/textes`.
      #constat[`auld_lang_syne_une_ligne.txt  raven_une_ligne.txt`]],
    [Lister les fichiers `.odt` de `depart` : `ls depart/*.odt`.
      #constat[`depart/auld_lang_syne.odt  depart/raven.odt`]],
    [Supprimer l'une des copies, puis lister de nouveau `textes` : #commandes("rm travail/textes/auld_lang_syne_une_ligne.txt", "ls travail/textes")
      #constat[Le fichier a disparu. `rm` ne le met pas dans la corbeille.]],
  )

  #notes[
    `*` est remplacé par Git Bash avant que `cp` ne démarre : `cp` reçoit
    les deux noms. Diapositive « Le motif `*` ».

    Sorties relevées sur le dossier livré, le 19/10/2026.
  ]
]

// 28/09 : les équivalents PowerShell et invite de commandes sont dans l'annexe
// du guide du TD 1b seulement.
