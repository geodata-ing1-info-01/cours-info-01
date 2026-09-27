// TD 2b du cours 1 v2 — « Écrire et lancer un programme ».
//
// Reprend du TD 2a de 2026 le programme et la session interactive, sans
// VS Code : le programme s'ouvre dans Notepad++ et se lance dans Git Bash.
// La configuration de VS Code passe au cours 2, en classe entière.
//
// Inclus par `cours1_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 1_v2`.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "2b",
  titre: "Écrire et lancer un programme",
  annonce: "Rendre Python disponible dans Git Bash ; ouvrir un programme dans Notepad++, le lancer, le modifier et le relancer ; puis Python en interactif",
  dossier: "cours1/2b_programme/",
  duree: "10′",
)
#separateur-td(..td)

// Déplacée de la fin du TD 2a le 27/09 : le réglage se fait au moment où
// `python` sert pour la première fois.
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
    [3], [fermer Git Bash, le rouvrir dans `2b_programme`],
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

#d("Le programme du TD")[
  #annonce[
    Six lignes qui calculent une moyenne d'altitudes.
  ]

  #face-a-face(
    panneau[`altitudes.py`][
      ```python
      altitudes = [128.4, 131.0, 127.6]
      total = 0
      for altitude in altitudes:
          total = total + altitude
      moyenne = total / len(altitudes)
      print(f"moyenne : {moyenne:.1f} m")
      ```
    ],
    panneau("Lancé en entier")[
      ```console
      $ python altitudes.py
      moyenne : 129.0 m
      ```
      #v(0.4em)
      #text(size: 14pt, fill: estompe)[
        Une seule ligne de sortie, celle du `print` final. Ce qui s'est
        passé entre-temps n'est pas visible.
      ]
    ],
  )

  #legende[
    Sortie réelle, Python 3.12. La moyenne de 128,4, 131,0 et 127,6 vaut bien
    129,0.
  ]

  #notes[
    Six lignes, une boucle donc un état qui change, un résultat vérifiable
    de tête : le `hello world` n'avait aucune de ces propriétés.

    Ce programme ne montre que sa dernière ligne ; la session interactive
    sert à voir ce qu'il fait entre le début et la fin. v2 : le pas à pas
    (débogueur) est en annexe.
  ]
]

// Nouveau (v2) : remplace « Lancer le programme » du TD 2a de 2026 (VS Code).
#d("Lancer, modifier, relancer")[
  #tableau(
    columns: (auto, 1.25fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [Notepad++ : Fichier #sym.arrow.r Ouvrir, `cours1\2b_programme\altitudes.py`],
      reponse[le code en couleur : Notepad++ reconnaît l'extension `.py`],
    [2], [Git Bash dans `cours1/2b_programme/`, puis `python altitudes.py`],
      reponse[`moyenne : 129.0 m`],
    [3], [ajouter `133.2` à la liste, sans enregistrer ; relancer],
      reponse[toujours `129.0` : python lit le fichier enregistré],
    [4], [`Ctrl` + `S`, puis relancer],
      reponse[`moyenne : 130.1 m`],
  )

  #legende[
    La flèche vers le haut rappelle la commande précédente dans Git Bash :
    inutile de la retaper.
  ]

  #notes[
    Étape 2 : Git Bash rouvert dans `2b_programme/` à la première
    diapositive du TD. Si `python` n'est pas trouvé, le réglage de conda
    dans Git Bash n'a pas été fait sur ce poste.

    Étape 3 : l'onglet de Notepad++ porte une disquette rouge tant que le
    fichier n'est pas enregistré.

    Sortie de l'étape 4 relevée avec Python 3.12 : 130,05 arrondi à une
    décimale par `:.1f`.
  ]
]
#d("Python en interactif")[
  #annonce[
    Dans Git Bash, taper `python` sans nom de fichier ouvre une session
    interactive : chaque ligne est lue, exécutée, et son résultat affiché
    aussitôt.
  ]

  ```console
  $ python
  Python 3.12.14 (main, Sep  2 2026, 23:27:36) [GCC 15.3.0] on linux
  >>> altitudes = [128.4, 131.0, 127.6]
  >>> total = 0
  >>> for altitude in altitudes:
  ...     total = total + altitude
  ...
  >>> total
  387.0
  >>> total / len(altitudes)
  129.0
  >>> exit()
  ```

  #legende[
    Session réelle. `total` s'affiche sans `print` : c'est propre à la session
    interactive, et c'est ce qui permet de regarder à l'intérieur.
  ]

  #notes[
    Faire remarquer les trois chevrons : c'est l'invite de Python, pas
    celle du terminal. Les confondre produit un `SyntaxError` quand on
    tape une commande du système. Les trois points sont la suite d'un bloc
    commencé.

    On entre par `python`, on sort par `exit()` ou `Ctrl` + `D`. Le dire
    tout de suite.

    La session donne accès à `total`, que le script ne montrait pas. Si la
    salle suit, refaire la boucle en affichant `total` à chaque tour :
    128,4 puis 259,4 puis 387,0.

    Un script se relance à l'identique et ne laisse rien à l'écran ; une
    session montre tout et ne laisse rien sur le disque. Deux usages, pas
    deux niveaux.

    Amorce de la dernière partie : un notebook est cette session, avec le
    texte conservé autour.
  ]
]
