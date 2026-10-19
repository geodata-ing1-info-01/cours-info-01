// TD 1b du cours 1 v2 — « Les fichiers du TD 1a en ligne de commande ».
//
// Nouveau (v2) : la seconde moitié du TD 1a de 2026 (renommer une extension,
// un espace dans un nom), faite dans Git Bash. La configuration de conda dans
// Git Bash est passée au début du TD 1c le 27/09. Les sorties ont été relevées en rejouant
// le TD sous Linux (bash 5.2, coreutils 9.4, LC_ALL=C) sur une copie du
// dossier livré ; les messages de Git Bash peuvent différer d'un mot.
//
// Relecture du 19/10/2026 : plus de page web dans le cours 1. Le nom avec
// espace et le motif `*` portent sur les fichiers `.txt` ; le test de la page
// sans mise en forme (`style.css` absent de `travail/`) est retiré pour le
// moment. Sorties de ces deux diapositives relevées de nouveau, avec bash 5.1
// et coreutils 8.32.
//
// Inclus par `cours1_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 1_v2`.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "1b",
  titre: "Les fichiers du TD 1a en ligne de commande",
  annonce: "Objectif : manipuler des fichiers en ligne de commande, dans Git Bash : se déplacer, copier, renommer, ouvrir",
  dossier: "cours1/1b_terminal/",
  duree: "15′",
)
#separateur-td(..td)

#d("Ouvrir Git Bash dans le dossier du TD")[
  #tableau(
    columns: (auto, 1.2fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous vérifiez],
    [1], [dans l'explorateur, ouvrir `cours1\1b_terminal`],
      [deux dossiers, `depart` et `travail`],
    [2], [clic droit sur un endroit vide, « Afficher d'autres options », « Open Git Bash here »],
      [une fenêtre Git Bash s'ouvre],
    [3], [lire la première ligne de l'invite],
      [elle se termine par `~/Desktop/info01/cours1/1b_terminal`],
  )

  #legende[
    À défaut : Git Bash depuis le menu Démarrer, puis
    `cd ~/Desktop/info01/cours1/1b_terminal`.
  ]

  #notes[
    `depart/` contient les fichiers du TD 1a : les deux TD travaillent sur
    les mêmes fichiers, chacun dans son dossier.

    Windows 11 range « Open Git Bash here » sous « Afficher d'autres
    options ». À vérifier sur un poste de la salle.

    La complétion : taper `cd ~/De`, puis `Tab`. La montrer une fois ici.
  ]
]

#d("Se déplacer et lister")[
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Commande], [Ce que vous constatez],
    [`pwd`], reponse[`/c/Users/eleve/Desktop/info01/cours1/1b_terminal`],
    [`ls`], reponse[`depart/`, `travail/` et les PDF du TD ; le `/` marque un dossier],
    [`ls depart`], reponse[les fichiers des deux textes, `raven.odt` compris],
    [`ls -a travail`], reponse[`./` et `../` : le dossier est vide, sauf ces deux entrées cachées],
    [`cd depart`, puis `pwd`], reponse[le dossier courant a changé, l'invite aussi],
    [`cd ..`], reponse[retour dans `1b_terminal`],
    [`ls ../1a_formats/travail`], reponse[les fichiers exportés au TD 1a, sans quitter le dossier],
  )

  #legende[
    La flèche vers le haut rappelle les commandes précédentes. `Tab` complète
    un nom de fichier ou de dossier commencé.
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

  #tableau(
    columns: (1.3fr, auto, 1fr),
    align: left + horizon,
    [Commandes], [Logiciel lancé], [Ce qui se passe],
    [`cp depart/raven.odt travail/` \ `mv travail/raven.odt travail/raven_odt.pdf` \ `start travail/raven_odt.pdf`],
      [un lecteur PDF], reponse[refus : le fichier n'est pas un PDF],
    [`cp depart/raven.odt travail/riri.fifi.loulou.odt` \ `start travail/riri.fifi.loulou.odt`],
      [LibreOffice Writer], reponse[s'ouvre : seule la fin du nom compte],
    [`cp depart/raven.odt travail/raven.loulou` \ `start travail/raven.loulou`],
      [aucun], reponse[une fenêtre de Windows demande de choisir le logiciel ; avec LibreOffice, le texte s'ouvre],
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

  #tableau(
    columns: (1.2fr, 1fr),
    align: left + horizon,
    [Commande], [Ce que vous constatez],
    [`cp depart/raven_une_ligne.txt travail/le corbeau.txt`],
      reponse[un message d'erreur : `cp` a reçu trois noms, `travail/le` et `corbeau.txt` séparés],
    [`cp depart/raven_une_ligne.txt "travail/le corbeau.txt"`],
      reponse[pas de message : la copie est faite],
    [`ls travail`], reponse[`'le corbeau.txt'`, entre apostrophes, parmi les fichiers],
    [`start "" "travail/le corbeau.txt"`],
      reponse[le poème s'ouvre dans le Bloc-notes],
  )

  #legende[
    Les noms des fichiers du module n'ont pas d'espace : `_` le remplace.
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

#d("Copier plusieurs fichiers d'un coup")[
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Commande], [Ce que vous constatez],
    [`mkdir travail/textes`], reponse[un dossier `textes/` dans `travail/`],
    [`cp depart/*.txt travail/textes/`], reponse[pas de message],
    [`ls travail/textes`], reponse[`auld_lang_syne_une_ligne.txt  raven_une_ligne.txt`],
    [`ls depart/*.odt`], reponse[`depart/auld_lang_syne.odt  depart/raven.odt`],
    [`rm travail/textes/auld_lang_syne_une_ligne.txt`], reponse[le fichier disparaît, sans passer par la corbeille],
  )

  #notes[
    `*` est remplacé par Git Bash avant que `cp` ne démarre : `cp` reçoit
    les deux noms. Diapositive « Le motif `*` ».

    Sorties relevées sur le dossier livré, le 19/10/2026.
  ]
]

// 28/09 : les équivalents PowerShell et invite de commandes sont dans l'annexe
// du guide du TD 1b seulement.
