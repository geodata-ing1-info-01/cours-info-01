// TD 3b du cours 3 — « Une ligne de commande pour la recette ».
//
// Inclus par `cours3.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`, qui
// en tire la feuille de TD déposée dans le dossier annoncé. Un fichier inclus
// n'hérite pas des imports de son appelant.
//
// Le programme se construit pas à pas depuis les cellules du notebook du
// TD 1a : un fichier, `argparse` sur une branche, un README, puis, en bonus,
// `main` ; puis, dans le guide seulement, `src/` et `data/`, et
// `pyproject.toml`. Chaque étape a son
// corrigé dans `data/cours3/corriges/3b_cli/etape<n>/`.
//
// Depuis le 29/09/2026, le TD commence par l'environnement conda de la
// séance, selon les groupes (auparavant dans le TD 0a), puis par le guide
// détaillé et le matériel de départ (les deux notebooks des TD 1a et 2a),
// la vue d'ensemble et deux aide-mémoire. Chaque étape a ensuite une
// diapositive sur le même plan : l'objectif en annonce, l'attendu et les
// pistes côte à côte, le renvoi au guide en légende, et, dans le corrigé
// seulement, ce que l'étape fait constater.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *

#let td = (
  numero: "3b",
  titre: "Une ligne de commande pour la recette",
  annonce: "Parcours avancé. Objectif : transformer le code d'un notebook en programme lancé depuis un terminal, avec des paramètres, et en garder l'historique avec git",
  dossier: "cours3/3b_cli/",
  duree: "45′, +15′ selon les groupes",
)
#separateur-td(..td)

// --------------------------------------------
#d("Environnement de la séance : selon les groupes")[
  #annonce[
    Un environnement conda contient un Python et ses paquets, indépendants
    de ceux des autres environnements. Celui de la séance se crée une fois.
  ]

  #tableau(
    columns: (auto, 1.6fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce qui doit apparaître],
    [1], [menu Démarrer #sym.arrow.r Anaconda Prompt, puis `conda create -n info01-cours3 -c conda-forge python=3.12 jupyterlab jupyterlab-myst pandoc pillow`],
      [la liste des paquets à installer, puis `Proceed ([y]/n)?`],
    [2], [taper `y`, puis Entrée ; attendre la fin du téléchargement, plusieurs minutes],
      [`Executing transaction: done`],
    [3], [`conda activate info01-cours3`],
      [`(info01-cours3)` en tête de ligne],
    [4], [`pandoc --version`, puis `python -c "import PIL"`],
      [`pandoc 3…` ; aucun message après la seconde commande],
  )

  #legende[
    Dans le terminal Git Bash de VS Code, `conda activate info01-cours3`
    active l'environnement, une fois l'étape 0 faite.
  ]

  #notes[
    `-n` : le nom de l'environnement. `-c conda-forge` : le dépôt des
    paquets.

    Mesurer la durée de l'étape 2 sur un poste de la salle avant la
    séance. Si elle dépasse cinq minutes : lancer les étapes 1 et 2 pendant
    le TD 0a, et continuer les notebooks pendant le téléchargement.

    `conda env list` liste les environnements du poste, `*` sur l'actif :
    à montrer à ceux qui vont vite.

    `jupyterlab-myst` : affiche les encadrés MyST des notebooks
    (`:::{admonition} À faire`). Dans `base`, sans l'extension, ils
    s'affichent en texte brut.

    Préfixe `info01-` : distingue l'environnement de ceux des autres
    enseignements sur le même poste.

    `python -c` exécute le code écrit entre guillemets ; Pillow s'importe
    sous le nom `PIL`. `base`, l'environnement installé avec Anaconda,
    contient déjà pandoc et Pillow ; le TD fonctionne donc aussi sans
    environnement. Choix de conda : il installe aussi des programmes qui ne
    sont pas du Python, comme pandoc ou ffmpeg (projet 4).

    Séances suivantes : `conda activate info01-cours3` seulement, si
    l'environnement n'est pas effacé à la déconnexion (à vérifier). Le
    projet 4 crée un environnement depuis un fichier `environment.yml`.
  ]
]

// --------------------------------------------
#d("Le guide et le matériel de départ")[
  #annonce[
    Le guide du TD détaille chaque étape : dossier, code, commandes et
    vérifications. Les diapositives suivantes en sont le résumé.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Fichier], [Emplacement], [Usage],
    [`guide_3b_cli.pdf`, `.html`, `guide.ipynb`], [`cours3/3b_cli/`], [le détail des étapes, le code à copier],
    [`recette.ipynb`], [`cours3/1a_recette/travail/`], [le code des sections 1, 3.1, 3.3 et 4.3],
    [`fichiers.ipynb`], [`cours3/2a_fichiers/travail/`], [`read_text` et `write_text`, section 11],
    [`recettes/`, `style.css`], [`cours3/3b_cli/depart/`], [les données, copiées dans `travail/`],
    [`recette.py`], [`cours3/3b_cli/depart/secours/`], [le résultat de l'étape 1, en secours],
  )

  #notes[
    Copié depuis le PDF, le code perd ses indentations.

    Garder JupyterLab ouvert à côté de VS Code : les sections du notebook
    se relisent pendant l'étape 1.
  ]
]

// --------------------------------------------
#d("Les étapes du TD")[
  #annonce[
    Objectif : transformer le code d'un notebook en programme lancé depuis un
    terminal, avec des paramètres, et en garder l'historique avec git.
  ]

  #chaine(
    ([`recette.ipynb`], "des cellules"),
    ([`recette.py`], "un script"),
    ([`python recette.py crepes -p 6`], "une commande"),
  )

  #tableau(
    columns: (auto, 1.2fr, 1fr),
    align: (center + horizon, left + horizon, left + horizon),
    [Étape], [Objectif], [Résultat],
    [0], [séparer les données dans un dépôt], [un dépôt git avec les données],
    [1], [passer du notebook au script], [la page des crêpes ; un commit],
    [2], [des arguments, sur une branche], [trois arguments et `--help`],
    [3], [documenter l'usage du programme], [un `README.md`],
    [4 (bonus)], [structurer le script avec `main`], [la même page, produite par `main()`],
  )

  #legende[
    Deux aide-mémoire suivent, les commandes git et le passage du notebook au
    script, puis une diapositive par étape ; l'étape 4 est un bonus. Les
    étapes 5 et 6, après la séance, sont dans le guide.
  ]
]

// --------------------------------------------
#d("Aide-mémoire : une étape, un commit")[
  #annonce[
    Rappel du cours 2, pour toutes les étapes. Chaque étape se termine par un
    commit ; l'étape 2 se fait sur une branche, fusionnée ensuite dans
    `master`.
  ]

  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [`git status`], [les fichiers modifiés depuis le dernier commit],
    [`git diff`], [les lignes modifiées dans `recette.py`],
    [`git add recette.py`], [ajoute le fichier au prochain commit],
    [`git commit -m "Un README"`], [enregistre l'état ; le message nomme l'étape],
    [`git checkout -b arguments`], [crée la branche et s'y place],
    [`git checkout master`, `git merge arguments`], [revient sur master, y ramène les commits de la branche],
    [`git log --oneline --graph`], [un commit par ligne, les branches dessinées],
  )

  #legende[
    `sortie/` est dans `.gitignore` : les fichiers produits par le programme
    ne sont pas versionnés, le programme les reproduit.
  ]

  #notes[
    Si une étape échoue, `git restore recette.py` remet le fichier à l'état
    du dernier commit.

    `master` : le nom que `git init` donne à la première branche sur les
    postes ; `main` si le poste est réglé autrement.
  ]
]

// --------------------------------------------
#d("Aide-mémoire : du notebook au script")[
  #annonce[
    Rappel de la partie 1, pour les étapes 1 et 2. `python recette.py`
    exécute le fichier en entier, de haut en bas.
  ]

  #tableau(
    columns: (1fr, 1fr, 1fr),
    align: left + horizon,
    [], [Notebook], [Script],
    [Afficher], [la dernière expression de la cellule], [`print` ; une expression seule n'affiche rien],
    [Dossier courant], [celui du fichier `.ipynb`], [celui du terminal],
    [Les valeurs (recette, personnes, unités)], [modifiées dans la cellule, puis la cellule relancée], [passées sur la ligne de commande],
    [Les fonctions], [la cellule des `def`, exécutée en premier], [les `def` en haut du fichier ; le corps d'une fonction s'exécute à chaque appel],
  )

  #legende[
    Python lit le fichier de haut en bas. Les fonctions sont écrites avant
    la première ligne qui les appelle : au moment de l'appel, elles existent.
  ]

  #notes[
    Deuxième ligne : le § 3.3 de `recette.ipynb`. Dans le TD, le script est
    lancé depuis le dossier qui contient `recettes/`, et
    `RACINE = Path.cwd()`.

    Quatrième ligne : un `def` définit la fonction sans exécuter son corps.
    Un `import recette` depuis un autre fichier fait la même lecture de haut
    en bas : les `def` définissent les fonctions, et les lignes du programme
    s'exécutent aussi. La fonction `main` (étape 4, en bonus) règle ce
    problème.
  ]
]

// --------------------------------------------
#d("Étape 0 · Le dossier de travail et le dépôt")[
  #annonce[
    Objectif : un dossier de projet séparé des fichiers livrés, versionné,
    avec le Python et le pandoc d'Anaconda dans le terminal.
  ]

  #attendu-pistes(
    (
      [`travail/` ouvert dans VS Code, avec `recettes/` et `style.css`],
      [un terminal Git Bash dont l'invite commence par `(base)`],
      [un dépôt dans `travail/` ; un `.gitignore` qui contient `sortie/`],
    ),
    (
      [copier les données de `depart/` dans `travail/`, puis ouvrir `travail/` : Fichier #sym.arrow.r Ouvrir le dossier],
      [rendre conda disponible dans Git Bash, une fois par poste : guide, § 0.3],
      [selon les groupes, activer l'environnement : `conda activate info01-cours3`],
      [créer le dépôt : `git init`, l'identité git (`git config user.name`, `user.email`), puis le `.gitignore`],
    ),
  )

  #legende[
    Guide, étape 0. VS Code affiche l'état git du dossier ouvert : ouvrir
    `travail/`, le dossier du dépôt. Pas de commit à cette étape.
  ]

  #reponse(legende[
    Constaté : `pwd` se termine par `travail` ; `which python` donne le
    Python d'Anaconda ; `git status` liste `recettes/`, `style.css` et
    `.gitignore`, non suivis.
  ])

  #notes[
    Le terminal de l'éditeur s'ouvre dans le dossier ouvert : c'est depuis
    `travail/` que tout se lance.

    Vérifier que le dépôt est dans `travail/` et non dans `3b_cli/` : `git
    status` doit lister `recettes/`, pas `depart/`.
  ]
]

// --------------------------------------------
#d("Étape 1 · Le notebook devient un script")[
  #annonce[
    Objectif : un fichier `recette.py` qui fait, lancé depuis le terminal, ce
    que faisait le notebook.
  ]

  #attendu-pistes(
    (
      [`python recette.py`, lancé dans `travail/`, écrit `sortie/crepes.html`],
      [la page s'ouvre par un double-clic],
      [un commit ; `sortie/` reste hors du dépôt],
    ),
    (
      [reprendre les sections 1, 3.1, 3.3 et 4.3 de `recette.ipynb`, dans leur dernière version],
      [construire les chemins depuis le dossier du terminal : `RACINE = Path.cwd()`],
      [ajouter un `print` là où le notebook affichait],
      [en cas de blocage, partir de `depart/secours/recette.py`],
    ),
  )

  #legende[
    Guide, étape 1 : le code, en quatre blocs.
  ]

  #reponse(legende[
    Constaté : avant les lignes du programme, `python recette.py` ne fait
    rien et n'affiche aucune erreur ; après le commit, `git status` n'a rien
    à valider.
  ])

  #notes[
    Le corrigé de l'étape : `corriges/3b_cli/etape1/recette.py`, identique à
    `depart/secours/recette.py`. Les cellules à recopier sont celles de la
    version finale : pas les chemins en dur de la section 2, pas les `!`.
    Les chemins passés à pandoc sont en `str(…)`.

    La copie de `style.css` dans `sortie/` (`shutil.copy`) est la seule ligne
    absente du notebook, où le CSS était déjà à côté : la dire.

    Erreur fréquente : `python recette.py` lancé depuis `3b_cli/` et non
    `travail/` ; `Path.cwd()` ne trouve alors pas `recettes/`.
  ]
]

// --------------------------------------------
#d("Étape 2 · Les arguments, sur une branche")[
  #annonce[
    Objectif : choisir la recette, le nombre de personnes et les unités au
    lancement, sans ouvrir le code.
  ]

  #attendu-pistes(
    (
      [`python recette.py pate_pizza -p 6 -u US` écrit la page de la pâte à pizza, pour 6 personnes, en unités US],
      [`--help` décrit les trois arguments],
      [un commit par argument sur la branche `arguments`, fusionnée dans `master`],
    ),
    (
      [créer la branche : `git checkout -b arguments`],
      [écrire le bloc `argparse` en tête du programme, sans indentation : `add_argument`, `choices`, `type=int`, `default`],
      [prendre les recettes possibles dans les dossiers de `recettes/` (section 3.4)],
      [faire un commit par argument, puis revenir sur `master` et `git merge arguments`],
    ),
  )

  #legende[
    Guide, étape 2.
  ]

  #reponse(legende[
    Constaté : `python recette.py` seul répond `arguments are required: nom`,
    `gaufres` répond `invalid choice` ; la fusion se fait en avance rapide.
  ])

  #notes[
    `import argparse` en tête du fichier, et les trois lignes `NOM = …`
    disparaissent de la tête au fur et à mesure. Corrigé de la fin de
    l'étape : `corriges/3b_cli/etape2/recette.py`.

    Faire lire `--help` après chaque `add_argument` : l'aide change à chaque
    commit. `help="…"` dans `add_argument` complète l'aide ; le corrigé
    l'écrit, le TD peut s'en passer.
  ]
]

// --------------------------------------------
#d("Étape 3 · Un README")[
  #annonce[
    Objectif : qu'une autre personne sache installer et lancer le programme
    sans lire le code.
  ]

  #attendu-pistes(
    (
      [un `README.md` : ce que fait le programme, son installation, un exemple de commande, les recettes, l'auteur],
      [ses commandes s'exécutent telles quelles],
      [un commit],
    ),
    (
      [copier le modèle `depart/modeles/README.md`],
      [le compléter, l'aperçu Markdown ouvert : `Ctrl+Maj+V`],
      [`git add README.md`, puis le commit],
    ),
  )

  #legende[
    Guide, étape 3. Le cours 6 publie le README avec le dépôt.
  ]

  #reponse(legende[
    Constaté : le modèle a cinq parties et quatre passages « (À compléter
    …) ».
  ])

  #notes[
    Le corrigé, `corriges/3b_cli/etape3/README.md`, est une façon de le
    remplir. Ce qui compte : les commandes du README s'exécutent telles
    quelles, depuis le dossier du projet.

    Fin du TD en séance : étapes 0 à 3, cinq commits. L'étape 4 est un
    bonus ; les étapes 5 et 6 sont dans le guide, à faire après la séance.
  ]
]

// --------------------------------------------
// Bonus : la fonction `main`, présentée ici plutôt que dans l'exposé
// (29/09/2026) : une amélioration de structure, dont le bénéfice ne se voit
// qu'à l'import et à l'étape 6.
#d("Bonus : une fonction main")[
  #annonce[
    Les lignes du programme passent dans une fonction `main`, appelée en bas
    du fichier. Le script fait la même chose, et un autre fichier peut
    importer ses fonctions sans lancer le programme.
  ]

  #face-a-face(
    panneau("Étape 2 : le programme de haut en bas")[
      #sortie("def lire_ingredients(chemin):\n    …\n\nanalyseur = argparse.ArgumentParser(…)\n…\nprint(page, …)", taille: 11pt)
    ],
    panneau("Étape 4 : le programme dans main")[
      #sortie("def lire_ingredients(chemin):\n    …\n\ndef main():\n    analyseur = argparse.ArgumentParser(…)\n    …\n    print(page, …)\n\nif __name__ == \"__main__\":\n    main()", taille: 11pt)
    ],
  )

  #legende[
    `if __name__ == "__main__":` se lit « si ce fichier est celui lancé par
    `python` ». `__name__` vaut `"__main__"` quand le fichier est lancé, et
    `"recette"` quand il est importé.
  ]

  #notes[
    Python lit un fichier de haut en bas, qu'il soit lancé ou importé. Sans
    `main`, `import recette` exécute le programme : un fichier de tests qui
    importe `lire_ingredients` produirait la page. Le projet 7 écrit un tel
    fichier ; la commande installée de l'étape 6 appelle `recette:main`.
  ]
]

// --------------------------------------------
#d("Étape 4 (bonus) · Une fonction main")[
  #annonce[
    Objectif : séparer les définitions du programme principal, qui ne
    s'exécute que lorsque le fichier est lancé par `python`.
  ]

  #attendu-pistes(
    (
      [la même page qu'à l'étape 2],
      [`main()` appelée sous `if __name__ == "__main__":`],
      [un commit],
    ),
    (
      [écrire `def main():` au-dessus de la première ligne du programme],
      [indenter les lignes du programme : sélection, puis `Tab`],
      [appeler `main()` en bas du fichier, sous `if __name__ == "__main__":`],
      [vérifier avec `python -c "import recette"`, avant et après ; relire `git diff` avant le commit],
    ),
  )

  #legende[
    Guide, étape 4. L'étape 6, après la séance, s'en sert.
  ]

  #reponse(legende[
    Constaté : avant, `python -c "import recette"` s'arrête sur `the
    following arguments are required: nom` ; après, il n'affiche rien. Sans
    l'appel, `python recette.py crepes` ne produit rien.
  ])

  #notes[
    Corrigé : `corriges/3b_cli/etape4/recette.py`, l'état final du TD, que
    le projet 7 reprend.
  ]
]

// Les étapes 5 (`src/` et `data/`) et 6 (`pyproject.toml`) ne sont plus
// projetées (syllabus v1.5, 24/09/2026) : elles restent dans le guide, pour
// qui veut les faire après la séance. Les diapositives sont dans
// l'historique git.
