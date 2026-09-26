// TD 2a du cours 1 v2 — « Les fichiers du TD 1a en ligne de commande ».
//
// Nouveau (v2) : la seconde moitié du TD 1a de 2026 (renommer une extension,
// un espace dans un nom), faite dans Git Bash, puis la configuration de conda
// dans Git Bash, une fois par poste. Les sorties ont été relevées en rejouant
// le TD sous Linux (bash 5.2, coreutils 9.4, LC_ALL=C) sur une copie du
// dossier livré ; les messages de Git Bash peuvent différer d'un mot.
//
// Inclus par `cours1_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 1_v2`.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "2a",
  titre: "Les fichiers du TD 1a en ligne de commande",
  annonce: "Se déplacer, copier, renommer et ouvrir des fichiers dans Git Bash, puis y rendre Python disponible",
  dossier: "cours1/2a_terminal/",
  duree: "15′",
)
#separateur-td(..td)

#d("Ouvrir Git Bash dans le dossier du TD")[
  #tableau(
    columns: (auto, 1.2fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous vérifiez],
    [1], [dans l'explorateur, ouvrir `cours1\2a_terminal`],
      [deux dossiers, `depart` et `travail`],
    [2], [clic droit sur un endroit vide, « Afficher d'autres options », « Open Git Bash here »],
      [une fenêtre Git Bash s'ouvre],
    [3], [lire la première ligne de l'invite],
      [elle se termine par `~/Desktop/info01/cours1/2a_terminal`],
  )

  #legende[
    À défaut : Git Bash depuis le menu Démarrer, puis
    `cd ~/Desktop/info01/cours1/2a_terminal`.
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
    [`pwd`], reponse[`/c/Users/eleve/Desktop/info01/cours1/2a_terminal`],
    [`ls`], reponse[`depart/`, `travail/` et les PDF du TD ; le `/` marque un dossier],
    [`ls depart`], reponse[les fichiers des deux textes, `raven.odt` compris],
    [`ls -a travail`], reponse[`./` et `../` : le dossier est vide, sauf ces deux entrées cachées],
    [`cd depart`, puis `pwd`], reponse[le dossier courant a changé, l'invite aussi],
    [`cd ..`], reponse[retour dans `2a_terminal`],
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
    [`cp depart/raven_brut.html travail/raven brut.html`],
      reponse[un message d'erreur : `cp` a reçu trois noms, `travail/raven` et `brut.html` séparés],
    [`cp depart/raven_brut.html "travail/raven brut.html"`],
      reponse[pas de message : la copie est faite],
    [`ls travail`], reponse[`raven brut.html` parmi les fichiers],
    [`start "" "travail/raven brut.html"`],
      reponse[la page s'ouvre, sans mise en forme : `style.css` n'est pas dans `travail/`],
  )

  #legende[
    Les noms des fichiers du module n'ont pas d'espace : `_` le remplace.
  ]

  #notes[
    Message relevé sous Linux : `cp: target 'brut.html': No such file or
    directory`. La version de coreutils de Git Bash peut écrire `is not a
    directory` ; le sens est le même.

    `start` prend son premier argument entre guillemets pour le titre d'une
    fenêtre : d'où `""` avant le nom. Ne pas s'y attarder ; à vérifier sur un
    poste.

    La page sans mise en forme : le chemin relatif `href="style.css"` ne
    trouve rien dans `travail/`. `cp depart/style.css travail/`, puis `F5`
    dans le navigateur.
  ]
]

#d("Copier plusieurs fichiers d'un coup")[
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Commande], [Ce que vous constatez],
    [`mkdir travail/pages`], reponse[un dossier `pages/` dans `travail/`],
    [`cp depart/*.html travail/pages/`], reponse[pas de message],
    [`ls travail/pages`], reponse[les quatre pages web des deux textes],
    [`ls depart/*.txt`], reponse[`depart/auld_lang_syne_une_ligne.txt  depart/raven_une_ligne.txt`],
    [`rm travail/pages/auld_lang_syne_brut.html`], reponse[le fichier disparaît, sans passer par la corbeille],
  )

  #notes[
    `*` est remplacé par Git Bash avant que `cp` ne démarre : `cp` reçoit
    les quatre noms. Diapositive « Le motif `*` ».

    Sortie de `ls depart/*.txt` relevée sur le dossier livré.
  ]
]

#d("Python dans Git Bash, une fois par poste")[
  #annonce[
    Anaconda n'est pas encore visible depuis Git Bash. Une commande de conda
    l'y rend disponible, dans toutes les fenêtres Git Bash ouvertes ensuite.
  ]

  #tableau(
    columns: (auto, 1.25fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [`python --version`],
      reponse[`python` introuvable, ou un message qui renvoie au Microsoft Store],
    [2], [`source /c/ProgramData/anaconda3/etc/profile.d/conda.sh`, puis `conda init bash`],
      reponse[une liste de fichiers ; `modified` devant `.bash_profile`],
    [3], [fermer Git Bash, le rouvrir dans `2a_terminal`],
      reponse[`(base)` au-dessus de l'invite],
    [4], [`python --version`], reponse[`Python 3.` suivi de la version d'Anaconda],
    [5], [`ls -a ~`], reponse[`.bash_profile` parmi les noms : un fichier caché, créé à l'étape 2],
  )

  #legende[
    Le chemin de l'étape 2 est celui d'Anaconda sur les postes de la salle.
    Sur un ordinateur personnel : page « Git et Git Bash » des annexes.
  ]

  #notes[
    À VÉRIFIER sur un poste de la salle, avant d'écrire la version finale.
    `conda init` réécrit aussi des fichiers de `C:\ProgramData\anaconda3`
    quand leur contenu diffère ; sans droits d'administrateur, il affiche
    alors `needs sudo` et lance une demande d'élévation (issue conda #10774).
    Test : `…/conda.exe init bash --dry-run` ; seul `~/.bash_profile` doit
    être en `modified`.

    Repli sans droits, qui n'écrit que dans le dossier personnel :
    `echo 'eval "$(/c/ProgramData/anaconda3/Scripts/conda.exe shell.bash hook)"' >> ~/.bash_profile`.

    Message connu (guide du TD 3a du cours 3) : si chaque nouveau terminal
    affiche l'aide de `cygpath`, puis `bash: : No such file or directory`,
    l'environnement est activé quand même ; le `cygpath` d'Anaconda échoue
    sous Git Bash. Correctif, une fois :
    `sed -i '1i cygpath() { /usr/bin/cygpath "$@"; }' ~/.bash_profile`.

    Même démarche que l'étape 0.3 du TD 3a du cours 3 de 2026 (`source`,
    puis `conda init bash`).

    Vérifier aussi où est `~` : `pwd -W` dans `~`. Si le profil est sur un
    partage réseau (`HOMEDRIVE`), `.bash_profile` y est aussi.

    Git Bash lit `~/.bash_profile` au démarrage (shell de connexion) ; conda
    y écrit pour cette raison sous Windows.
  ]
]
