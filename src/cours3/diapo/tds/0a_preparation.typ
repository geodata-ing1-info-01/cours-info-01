// TD 0a du cours 3 — « Préparation du poste de travail ».
//
// Inclus par `cours3.typ`, après l'ouverture, qui porte les réglages globaux
// et importe `td` pour le sommaire des TD ; compilable seul par
// `outils/compiler_tds.py`. Un fichier inclus n'hérite pas des imports de son
// appelant.
//
// Trois diapositives : récupérer l'archive, vérifier que les outils se
// lancent, puis, selon les groupes, créer l'environnement `info01-cours3`.
// Les deux premières étaient dans l'ouverture jusqu'au 25/09/2026. La
// troisième a été ajoutée pour 2026 (syllabus v1.5, 24/09/2026) : la partie 4
// du cours 1 (bibliothèques et environnements) n'a pas été jouée. Les groupes
// qui ne la font pas lancent JupyterLab depuis `base`. La diapositive de
// rappel des commandes conda et l'installation en deux temps sont dans
// l'historique git (avant le 25/09/2026).
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "0a",
  titre: "Préparation du poste de travail",
  annonce: "Récupérer l'archive de la séance et vérifier que les outils se lancent ; selon les groupes, créer l'environnement conda de la séance",
  dossier: "cours3/",
  duree: "10′, +15′ selon les groupes",
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
      [l'archive sur le Bureau, 14 Mo],
    [2], [clic droit sur l'archive #sym.arrow.r Extraire tout],
      [un dossier `cours3/`, quatre sous-dossiers `1a_recette/`, `2a_fichiers/`, `2b_images/`, `3a_cli/`],
    [3], [ouvrir `cours3/1a_recette/` : `depart/`, `travail/` vide, la feuille du TD],
      [`depart/notebook/` contient `recette.ipynb`],
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
    [JupyterLab], [Anaconda Navigator #sym.arrow.r fiche JupyterLab #sym.arrow.r *Launch* ; si rien ne vient après trente secondes : Anaconda Prompt, puis `jupyter lab`],
      [un onglet du navigateur, adresse `localhost`],
    [Un éditeur], [VS Code, configuré au TD 2a du cours 1 ; sinon Spyder, depuis Navigator],
      [l'éditeur, avec un terminal qui répond à `python --version`],
    [Un terminal], [menu Démarrer #sym.arrow.r Anaconda Prompt],
      [`(base)` en tête de ligne],
  )

  #legende[
    En cas de problème : les pages « Avant les séances » du support, ou la
    main levée.
  ]

  #notes[
    Groupes qui créent l'environnement (diapositive suivante) : ne vérifier
    ici que l'Anaconda Prompt ; JupyterLab se lance à la dernière étape,
    depuis `info01-cours3`.

    Dix minutes, pas plus. 
    Navigator a été lent ou muet sur les VM à la séance 1 : donner la commande `jupyter lab` tout de suite à ceux qui n'ont rien au bout de trente secondes.

    VS Code sert pour le TD 3a, pas pour les notebooks. 
    Si pb d'environnement d'Anaconda sur ces postes avec vscode, et pas le temps de configurer tenter spyder.

    Un poste qui ne lance ni JupyterLab ni un éditeur en dix minutes : en
    changer ou suivre avec un collègue, la séance ne peut pas attendre.
  ]
]

// --------------------------------------------
#d("Environnement de la séance : selon les groupes")[
  #annonce[
    Un environnement conda contient un Python et ses paquets, indépendants
    de ceux des autres environnements.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire, dans l'Anaconda Prompt],
    [1], [`conda create -n info01-cours3 -c conda-forge python=3.12 jupyterlab jupyterlab-myst pandoc pillow`, puis `y`],
    [2], [`conda activate info01-cours3`],
    [3], [`pandoc --version`, puis `python -c "import PIL"`],
    [4], [`cd` vers le dossier `cours3/` extrait sur le Bureau, puis `jupyter lab`],
  )

  #legende[
    `-n` donne le nom de l'environnement, `-c conda-forge` le dépôt des
    paquets. Le terminal de `jupyter lab` fait tourner le serveur des
    notebooks et reste ouvert.
  ]

  #notes[
    Le téléchargement prend plusieurs minutes. Mesurer la durée de l'étape 1
    sur un poste de la salle avant la séance. Si elle dépasse cinq minutes :
    lancer l'étape 1 dès le début de la séance, commencer la partie 1 dans
    `base`, et revenir aux étapes 2 à 4 quand l'installation est finie.

    `conda env list` liste les environnements du poste, `*` sur l'actif :
    à montrer à ceux qui vont vite.

    `jupyterlab-myst` : affiche les encadrés MyST des notebooks
    (`:::{admonition} À faire`). Dans `base`, sans l'extension, ils
    s'affichent en texte brut.

    Préfixe `info01-` : distingue l'environnement de ceux des autres
    enseignements sur le même poste.

    `python -c` exécute le code écrit entre guillemets ; Pillow s'importe
    sous le nom `PIL`. `base`, l'environnement installé avec Anaconda,
    contient déjà pandoc et Pillow ; les notebooks fonctionnent donc aussi
    sans ce TD. Choix de conda : il installe aussi des programmes qui ne sont
    pas du Python, comme pandoc ou ffmpeg (projet 4).

    Pour écrire le chemin après `cd`, glisser le dossier `cours3/` depuis
    l'explorateur dans la fenêtre du terminal. À la section 4.4 de
    `recette.ipynb`, `shutil.which("pandoc")` renvoie un chemin dans
    `envs\info01-cours3\Library\bin`.

    Séances suivantes : `conda activate info01-cours3` seulement, si
    l'environnement n'est pas effacé à la déconnexion (à vérifier). Le
    projet 4 crée un environnement depuis un fichier `environment.yml`.
  ]
]
