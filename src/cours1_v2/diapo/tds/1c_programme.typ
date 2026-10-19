// TD 1c du cours 1 v2 — « Écrire et lancer un programme ».
//
// Reprend du TD 1b de 2026 le programme et la session interactive, sans
// VS Code : le programme s'ouvre dans Notepad++ et se lance dans Git Bash.
// La configuration de VS Code passe au cours 2, en classe entière.
//
// 27/09/2026 : une étape pour trouver quel python la commande lance, le
// réglage de conda (venu du TD 1b) et un script de commandes. Le TD des
// programmes fautifs (ancien TD 2c) est passé au cours 2 v2.
//
// Relecture du 19/10/2026 : les tableaux « Ce qu'il faut faire / Ce que
// vous constatez » deviennent des listes de consignes, comme aux TD 1a et
// 1b : la tâche en noir, la manière en gris, ce que la consigne fait
// constater sous elle, dans le corrigé seulement. `which python` remplace
// `type -a python`. Illustrations : le dossier d'Anaconda dans
// l'explorateur, la fenêtre de Git Bash rouverte avec `(base)`, le script.
//
// Inclus par `cours1_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 1_v2`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": consignes, comment, commandes, constat, git-bash-ouvert, explorateur-anaconda, terminal

#let td = (
  numero: "1c",
  titre: "Écrire et lancer un programme",
  annonce: "Objectif : lancer un programme Python depuis le terminal, en sachant quel Python l'exécute, puis utiliser Python en interactif",
  dossier: "cours1/1c_programme/",
  duree: "20′",
)
#separateur-td(..td)

// Nouveau (v2), 27/09 : la commande et le fichier qu'elle lance.
#d("Quel programme python la commande lance")[
  #grid(
    columns: (2fr, 1fr), column-gutter: 16pt, align: (top, horizon),
    consignes(
      taille: 16pt,
      [Aller dans le dossier du TD : `cd ../1c_programme`. #comment[Git Bash est encore ouvert dans `1b_terminal`.]],
      [Afficher le fichier que lance la commande `python` : `which python`.
        #constat[Un Python 2.7 dans `/c/Python27`, ou `no python` : ce n'est pas le Python d'Anaconda.]],
      [Ouvrir le dossier d'Anaconda dans l'explorateur : #comment[taper son chemin dans la barre d'adresse, comme sur le schéma, puis Entrée.]
        #constat[`python.exe` parmi les fichiers du dossier.]],
      [Lancer ce Python par son chemin complet : #commandes("/c/ProgramData/anaconda3/python.exe --version")
        #constat[`Python 3.` suivi de la version d'Anaconda.]],
    ),
    align(center, scale(72%, reflow: true, explorateur-anaconda())),
  )

  #legende[
    Dans Git Bash, `C:\` s'écrit `/c/`, et chaque `\` devient `/`.
  ]

  #notes[
    À vérifier sur un poste : ce qu'affiche l'étape 2 sans conda (Python
    2.7 attendu, dans `/c/Python27`) et le contenu du dossier d'Anaconda.

    `C:\ProgramData` est un dossier masqué : l'explorateur ne l'affiche
    pas, d'où le chemin tapé dans la barre d'adresse.

    Variante, si le temps le permet : `cd /c/ProgramData/anaconda3`, puis
    `./python.exe --version`, où `./` désigne le dossier courant.
  ]
]

// Déplacée de la fin du TD 1b le 27/09 : le réglage se fait au moment où
// `python` sert pour la première fois.
#d("Python dans Git Bash, une fois par poste")[
  #annonce[
    `conda init bash` règle Git Bash pour qu'il active conda à chaque
    ouverture.
  ]

  #consignes(
    taille: 15pt,
    [Configurer conda pour Git Bash : #commandes("source /c/ProgramData/anaconda3/etc/profile.d/conda.sh", "conda init bash")
      #constat[Une liste de fichiers, et `modified` devant `.bash_profile`.]],
    [Fermer Git Bash, puis le rouvrir dans `1c_programme` : #comment[clic droit dans le dossier, Open Git Bash here.]],
    [Vérifier le Python lancé : `which python`, puis `python --version`.
      #constat[`/c/ProgramData/anaconda3/python` ; `Python 3.`]],
    [Afficher les fichiers cachés du dossier personnel : `ls -a ~`.
      #constat[`.bash_profile` parmi les noms : un fichier caché, créé à l'étape 1.]],
  )

  #v(2pt)
  #align(center, box(width: 62%, git-bash-ouvert(dossier: "1c_programme", base: true, taille: 11pt)))

  #legende[
    Si le réglage échoue : invite de commandes d'Anaconda, dans le menu
    Démarrer.
  ]

  #notes[
    `conda init bash` écrit dans `~/.bash_profile` l'activation de conda. À
    chaque ouverture, Git Bash met alors les dossiers d'Anaconda en tête de
    `PATH`. Dans l'invite de commandes d'Anaconda, conda est actif sans
    réglage.

    Le chemin de l'étape 1 est celui d'Anaconda sur les postes de la salle.
    Sur un ordinateur personnel : page « Git et Git Bash » des annexes.

    À VÉRIFIER sur un poste de la salle, avant d'écrire la version finale.
    `conda init` réécrit aussi des fichiers de `C:\ProgramData\anaconda3`
    quand leur contenu diffère ; sans droits d'administrateur, il affiche
    alors `needs sudo` et lance une demande d'élévation (issue conda #10774).
    Test : `…/conda.exe init bash --dry-run` ; seul `~/.bash_profile` doit
    être en `modified`.

    Repli sans droits, qui n'écrit que dans le dossier personnel :
    `echo 'eval "$(/c/ProgramData/anaconda3/Scripts/conda.exe shell.bash hook)"' >> ~/.bash_profile`.

    Message connu (guide du TD 3f) : si chaque nouveau terminal
    affiche l'aide de `cygpath`, puis `bash: : No such file or directory`,
    l'environnement est activé quand même ; le `cygpath` d'Anaconda échoue
    sous Git Bash. Correctif, une fois :
    `sed -i '1i cygpath() { /usr/bin/cygpath "$@"; }' ~/.bash_profile`.

    Vérifier aussi où est `~` : `pwd -W` dans `~`. Si le profil est sur un
    partage réseau (`HOMEDRIVE`), `.bash_profile` y est aussi.

    Git Bash lit `~/.bash_profile` au démarrage (shell de connexion) ; conda
    y écrit pour cette raison sous Windows.
  ]
]

#d("Le programme du TD")[
  #annonce[
    Le programme `altitudes.py` calcule la moyenne de trois altitudes, puis
    l'affiche.
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
        Une seule ligne de sortie, celle du `print` final. Les étapes du
        calcul ne s'affichent pas.
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
    sert à voir ce qu'il fait entre le début et la fin. Le pas à pas
    (débogueur) est dans l'archive 2026 ; à reprendre au cours 2, avec
    l'éditeur de code.
  ]
]

// Nouveau (v2) : remplace « Lancer le programme » du TD 1b de 2026 (VS Code).
#d("Lancer, modifier, relancer")[
  #consignes(
    taille: 16pt,
    [Ouvrir `altitudes.py` dans Notepad++ : #comment[Fichier, Ouvrir, puis `cours1\1c_programme\altitudes.py`.]
      #constat[Le code en couleur : Notepad++ reconnaît l'extension `.py`.]],
    [Lancer le programme dans Git Bash : `python altitudes.py`.
      #constat[`moyenne : 129.0 m`]],
    [Dans Notepad++, ajouter `133.2` à la liste, sans enregistrer : #commandes("altitudes = [128.4, 131.0, 127.6, 133.2]")],
    [Relancer le programme dans Git Bash. #comment[Flèche vers le haut, puis Entrée.]
      #constat[Toujours `129.0` : python lit le fichier enregistré.]],
    [Enregistrer dans Notepad++ (`Ctrl` + `S`), puis relancer le programme.
      #constat[`moyenne : 130.1 m`]],
  )

  #notes[
    Étape 2 : Git Bash rouvert dans `1c_programme/` à la deuxième
    diapositive du TD. Si `python` n'est pas trouvé, le réglage de conda
    dans Git Bash n'a pas été fait sur ce poste.

    Étape 3 : l'onglet de Notepad++ porte une disquette rouge tant que le
    fichier n'est pas enregistré.

    Sortie de l'étape 5 relevée avec Python 3.12 : 130,05 arrondi à une
    décimale par `:.1f`.
  ]
]

#d("Python en interactif")[
  #grid(
    columns: (1fr, 1.1fr), column-gutter: 18pt, align: top,
    consignes(
      taille: 16pt,
      [Ouvrir une session interactive dans Git Bash : `python`.
        #constat[`>>>`, l'invite de Python.]],
      [Taper une à une les trois premières lignes de `altitudes.py`, comme dans la session à droite. #comment[Après la ligne indentée, appuyer une fois de plus sur Entrée.]],
      [Afficher la valeur de `total` : taper `total`.],
      [Calculer la moyenne : `total / len(altitudes)`.],
      [Quitter la session : `exit()`.],
    ),
    terminal(
      taille: 14pt,
      "$ python",
      "Python 3.12.14 (main, Sep  2 2026, 23:27:36) [GCC 15.3.0] on linux",
      ">>> altitudes = [128.4, 131.0, 127.6]",
      ">>> total = 0",
      ">>> for altitude in altitudes:",
      "...     total = total + altitude",
      "...",
      ">>> total",
      "387.0",
      ">>> total / len(altitudes)",
      "129.0",
      ">>> exit()",
    ),
  )

  #legende[
    Session réelle. Dans une session interactive, une variable tapée seule
    affiche sa valeur, sans `print`.
  ]

  #notes[
    À vérifier en salle : dans la fenêtre de Git Bash, `python` seul peut ne
    pas afficher `>>>`. Dans ce cas, `winpty python`, ou l'invite de
    commandes d'Anaconda.

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

    Lien avec « Programmation littérale », vue avant le TD : un notebook
    est cette session, avec le texte conservé autour.
  ]
]

// Nouveau (v2), 27/09 : le script de la diapositive « Un script de commandes »,
// retirée du cours le 19/10/2026 ; la page de cours `03_premier_programme.md`
// garde la section, et l'annonce reprend sa définition. Facultatif depuis le
// 28/09.
#d("Lancer le script, si le temps le permet")[
  #annonce[
    Un script est un fichier texte qui contient des commandes. `bash` les
    exécute dans l'ordre, comme si on les tapait.
  ]

  #consignes(
    taille: 16pt,
    [Ouvrir `commandes.sh` dans Notepad++, et lire ses six lignes, reproduites ci-dessous.
      #constat[Deux commentaires, qui commencent par `#`, puis quatre commandes. Notepad++ reconnaît l'extension `.sh`.]],
    [Lancer le script dans Git Bash : `bash commandes.sh`.
      #constat[Les deux fichiers `.txt` copiés dans `copies/`, puis `moyenne : 130.1 m`.]],
    [Relancer le script : #comment[flèche vers le haut, puis Entrée.]
      #constat[La même sortie, sans erreur : `mkdir -p` accepte un dossier qui existe.]],
  )

  #v(4pt)
  #panneau[`commandes.sh`][
    #text(size: 18pt)[```bash
    # Commandes du TD 1b, puis le programme du TD 1c.
    # Lancer depuis 1c_programme : bash commandes.sh
    mkdir -p copies
    cp ../1b_terminal/depart/*.txt copies/
    ls copies
    python altitudes.py
    ```]
  ]

  #legende[
    Le même script pour l'invite de commandes, `commandes.bat` : annexe du
    guide.
  ]

  #notes[
    La moyenne est celle de l'étape 5 de « Lancer, modifier, relancer »,
    avec quatre altitudes. Sortie de `bash commandes.sh` relevée sous Linux, sur
    une copie de l'archive.

    Une ligne qui commence par `#` est un commentaire. `python` y est une
    commande comme les autres.
  ]
]
