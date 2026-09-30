// TD 3a — « Préparation du poste de travail ».
//
// Inclus par `cours3.typ`, après l'exposé, en tête des TD, qui porte les
// réglages globaux et importe `td` pour le sommaire des TD ; compilable seul
// par `outils/compiler_tds.py`. Un fichier inclus n'hérite pas des imports de
// son appelant.
//
// Récupérer l'archive, lire l'arborescence extraite, copier les deux
// notebooks dans `travail/`, vérifier que les outils se lancent, puis ouvrir
// JupyterLab sur le dossier `cours3/`. Depuis le 29/09/2026, tous les TD
// sont en fin de séance, et l'environnement conda, selon les groupes, est
// passé en tête du TD 3f (`tds/3f_cli.typ`), le seul qui s'en sert.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *

#let td = (
  numero: "3a",
  titre: "Préparation du poste de travail",
  annonce: "Objectif : préparer le poste pour les TD de la séance, avec l'archive extraite, les deux notebooks copiés dans travail/ et JupyterLab ouvert sur cours3/",
  dossier: "cours3/",
  duree: "10′",
)
#separateur-td(..td)

// --------------------------------------------
#d("Lancement de la séance : récupération données")[
  #annonce[
    L'archive `info01-cours3.zip` est dans le dossier partagé `formationTemp`.
    Il faut la copier sur le Bureau (ou autre dossier de votre préférence) puis la décompresser.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous devez obtenir],
    [1], [ouvrir le dossier partagé `formationTemp`, copier `info01-cours3.zip` sur le Bureau],
      [l'archive sur le Bureau, 16 Mo],
    [2], [clic droit sur l'archive #sym.arrow.r Extraire tout ; dans le dossier proposé, effacer la fin, `\info01-cours3`, puis Extraire],
      [un dossier `cours3/` sur le Bureau, à côté de l'archive],
    [3], [ouvrir `cours3/` et lire la barre d'adresse de l'explorateur],
      [`C:\Users\eleve\Desktop\cours3`],
  )

  #avertissement[
    Ne pas travailler dans le dossier partagé, ne pas chercher à ouvrir un fichier
    de l'archive avec vscode ou autre.
  ]

  #notes[
    Vécu à la séance 1 : des fichiers ouverts depuis l'archive sans
    extraction, et du travail fait dans le dossier partagé, perdu ou écrasé
    par le voisin.
    Faire les trois étapes avec les étudiants, avant de lancer quoi que ce soit.

    Sans l'étape 2, le dossier extrait est `Desktop\info01-cours3\cours3` :
    un dossier de plus, et les chemins des diapositives ne correspondent
    plus. Même consigne que la page « Récupérer les fichiers d'une séance ».
  ]
]

// --------------------------------------------
#d("Le dossier cours3 après extraction")[
  #annonce[
    Chaque TD a son dossier. Dans chacun, `depart/` contient les fichiers
    livrés, et `travail/`, vide, reçoit les copies et ce que vous écrivez.
  ]

  #align(center, arborescence(
    (0, "Desktop/", "le Bureau, `C:\\Users\\eleve\\Desktop`"),
    (1, "info01-cours3.zip", "l'archive copiée"),
    (1, "cours3/", "le dossier extrait"),
    (2, "3b_recette/"),
    (3, "depart/"),
    (4, "notebook/"),
    (5, "recette.ipynb", "le premier notebook"),
    (4, "recettes/", "les données"),
    (3, "travail/", "vide"),
    (3, "td_3b_recette.pdf", "la feuille du TD"),
    (2, "3c_fichiers/", "la même organisation, avec `fichiers.ipynb`"),
    (2, "3d_images/", "facultatif"),
    (2, "3e_markdown/", "parcours standard"),
    (2, "3f_cli/", "parcours avancé"),
    taille: 11.5pt,
  ))
]

// --------------------------------------------
#d("Les deux notebooks à copier")[
  #annonce[
    Chaque notebook se copie de `depart/notebook/` dans le dossier
    `travail/` du même TD. Le notebook s'ouvre et s'exécute dans
    `travail/`.
  ]

  #grid(
    columns: (1fr, 1fr), column-gutter: 24pt,
    arborescence(
      (0, "3b_recette/"),
      (1, "depart/"),
      (2, "notebook/"),
      (3, "recette.ipynb", "à copier"),
      (1, "travail/"),
      (2, text(fill: attention)[recette.ipynb], "la copie"),
    ),
    arborescence(
      (0, "3c_fichiers/"),
      (1, "depart/"),
      (2, "notebook/"),
      (3, "fichiers.ipynb", "à copier"),
      (1, "travail/"),
      (2, text(fill: attention)[fichiers.ipynb], "la copie"),
    ),
  )

  #v(0.6em)
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire, dans l'explorateur de fichiers],
    [1], [ouvrir `cours3/3b_recette/depart/notebook/`, clic droit sur `recette.ipynb` #sym.arrow.r Copier],
    [2], [ouvrir `cours3/3b_recette/travail/`, clic droit dans le dossier #sym.arrow.r Coller],
    [3], [même chose pour `fichiers.ipynb`, de `3c_fichiers/depart/notebook/` dans `3c_fichiers/travail/`],
  )

  #legende[
    Le fichier de `depart/` reste tel quel : il sert à recommencer.
  ]

  #notes[
    Le notebook lit `depart/` par un chemin qui remonte d'un dossier, `..`,
    ce qui suppose qu'il est dans `travail/`. Ouvert depuis
    `depart/notebook/`, il ne trouve pas les recettes.

    Un glisser-déposer sur le même disque déplace le fichier, et `depart/`
    ne le contient plus.
  ]
]

// --------------------------------------------
#d("Lancement de la séance : test notebook")[
  #annonce[
    La séance demande d'exécuter des notebooks et d'écrire du code Python.
    Avant de commencer, chacun vérifie que ses outils se lancent.\
    Par défault on utilisera vscode ou jupyter lab.
    Si ça ne fonctionne pas demandez, selon les cas ça sera dépannage ou changement de poste.
  ]

  #tableau(
    columns: (auto, 1.3fr, 1fr),
    align: left + horizon,
    [Outil], [Comment le lancer], [Ce qui doit apparaître],
    [JupyterLab], [Anaconda Navigator #sym.arrow.r fiche JupyterLab #sym.arrow.r *Launch* ; si rien ne vient après trente secondes : invite de commandes d'Anaconda, puis `jupyter lab`],
      [un onglet du navigateur, adresse `localhost`],
    [Un éditeur], [VS Code, configuré au TD 1c ; sinon Spyder, depuis Navigator],
      [l'éditeur, avec un terminal qui répond à `python --version`],
    [Un terminal], [menu Démarrer #sym.arrow.r Anaconda Prompt],
      [`(base)` en tête de ligne],
  )

  #legende[
    En cas de problème : les pages « Avant les séances » du support, ou la
    main levée.
  ]

  #notes[
    Dix minutes, pas plus.
    Navigator a été lent ou muet sur les VM à la séance 1 : donner la commande `jupyter lab` tout de suite à ceux qui n'ont rien au bout de trente secondes.

    VS Code sert aux TD 3e et 3f. Les notebooks s'ouvrent dans JupyterLab.
    Si pb d'environnement d'Anaconda sur ces postes avec vscode, et pas le temps de configurer tenter spyder.

    Un poste qui ne lance ni JupyterLab ni un éditeur en dix minutes : en
    changer ou suivre avec un collègue, la séance ne peut pas attendre.
  ]
]

// --------------------------------------------
#d("JupyterLab ouvert sur le dossier cours3")[
  #annonce[
    Le panneau de gauche de JupyterLab montre le dossier de lancement et ses
    sous-dossiers. Il ne remonte pas au-dessus de ce dossier.
  ]

  #tableau(
    columns: (auto, 1.3fr, 1fr),
    align: left + horizon,
    [Lancement], [Ce qu'il faut faire], [Dossier affiché],
    [Invite de commandes d'Anaconda], [`cd Desktop\cours3`, puis `jupyter lab`],
      [`cours3/`],
    [Anaconda Navigator], [fiche JupyterLab #sym.arrow.r *Launch*],
      [`C:\Users\eleve` : ouvrir `Desktop`, puis `cours3`],
    [Autre disque (`D:`, clé USB)], [invite de commandes : `cd /d D:\…\cours3`, puis `jupyter lab`],
      [`cours3/` ; ce disque n'apparaît pas depuis Navigator],
  )

  #legende[
    Pour écrire le chemin après `cd /d`, glisser le dossier `cours3/` depuis
    l'explorateur dans la fenêtre de l'invite de commandes. Cette fenêtre
    fait tourner le serveur de JupyterLab et reste ouverte pendant la séance.
  ]

  #notes[
    L'invite de commandes d'Anaconda s'ouvre dans `C:\Users\eleve` ; le
    chemin relatif `Desktop\cours3` part de là. `/d` change aussi de disque :
    sans lui, `cd D:\…` ne change pas le disque courant.

    Bureau synchronisé par OneDrive : le chemin passe par `OneDrive\Bureau`
    ou `OneDrive\Desktop`. Le glisser-déposer du dossier donne le bon
    chemin dans tous les cas.

    JupyterLab déjà lancé sur le mauvais dossier : fermer l'onglet, taper
    `Ctrl+C` dans l'invite de commandes, puis relancer depuis le bon dossier.
  ]
]

// --------------------------------------------
#d("Le panneau des fichiers de JupyterLab")[
  #annonce[
    La ligne du haut du panneau donne le chemin du dossier affiché, depuis
    le dossier de lancement. Le Bureau y porte son nom réel, `Desktop`.
  ]

  #panneau-jupyterlab(
    ("Desktop", "cours3", "3b_recette", "travail"),
    ("recette.ipynb",),
    largeur: 60%,
  )

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Action], [Effet],
    [double-clic sur un dossier], [affiche son contenu],
    [clic sur un nom de la ligne du haut], [revient à ce dossier],
    [clic sur l'icône de dossier], [revient au dossier de lancement],
    [double-clic sur `recette.ipynb`], [ouvre le notebook dans un onglet],
  )

  #legende[
    Le panneau dessiné est celui de JupyterLab lancé depuis Navigator, dans
    le dossier du compte. Lancé depuis `cours3/`, le chemin commence à
    `3b_recette`.
  ]
]
