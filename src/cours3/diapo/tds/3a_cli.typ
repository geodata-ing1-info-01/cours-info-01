// TD 3a du cours 3 — « Une ligne de commande pour la recette ».
//
// Inclus par `cours3.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`, qui
// en tire la feuille de TD déposée dans le dossier annoncé. Un fichier inclus
// n'hérite pas des imports de son appelant.
//
// Le programme se construit pas à pas depuis les cellules du notebook du
// TD 1a : un fichier, `main`, `argparse` sur une branche, un README ; puis,
// dans le guide seulement, `src/` et `data/`, et `pyproject.toml`. Chaque étape a son
// corrigé dans `data/cours3/corriges/3a_cli/etape<n>/`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *

#let td = (
  numero: "3a",
  titre: "Une ligne de commande pour la recette",
  annonce: "Parcours avancé : construire recette.py depuis les cellules du notebook, un fichier, une fonction main, argparse, un README ; un commit par étape",
  dossier: "cours3/3a_cli/",
  duree: "45′",
)
#separateur-td(..td)

// --------------------------------------------
#d("Les étapes du TD")[
  #annonce[
    Le code du notebook devient un programme `recette.py`, lancé depuis un
    terminal. Chaque étape se termine par un commit.
  ]

  #tableau(
    columns: (auto, 1fr, auto),
    align: (left + horizon, left + horizon, center + horizon),
    [Étape], [Ce qu'on fait], [Commits],
    [0], [préparer le dossier `travail/` et créer le dépôt git], [0],
    [1], [écrire `recette.py` avec le code du notebook], [1],
    [2], [mettre le programme dans une fonction `main`], [2],
    [3], [les trois valeurs sur la ligne de commande, sur une branche], [5],
    [4], [écrire un `README.md`], [6],
  )

  #legende[
    Le guide `guide_3a_cli.pdf`, dans le dossier `3a_cli/`, détaille chaque
    étape : le dossier où se placer, le code à écrire, les commandes et la
    façon de vérifier le résultat. Il contient aussi deux étapes à faire
    après la séance : ranger le code dans `src/` et les données dans
    `data/`, puis installer le programme comme une commande.
  ]
]

// --------------------------------------------
#d("Une étape, un commit")[
  #annonce[
    Chaque étape se termine par un commit, avec les commandes du cours 2.
    L'étape 3 se fait sur une branche, fusionnée ensuite dans `master`.
  ]

  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [`git status`], [les fichiers modifiés depuis le dernier commit],
    [`git diff`], [les lignes modifiées dans `recette.py`],
    [`git add recette.py`], [ajoute le fichier au prochain commit],
    [`git commit -m "Une fonction main"`], [enregistre l'état ; le message nomme l'étape],
    [`git checkout -b arguments`], [crée la branche et s'y place],
    [`git checkout master`, `git merge arguments`], [revient sur master, y ramène les commits de la branche],
    [`git log --oneline --graph`], [un commit par ligne, les branches dessinées],
  )

  #legende[
    `sortie/` est dans `.gitignore` : les fichiers produits par le programme
    ne sont pas versionnés, le programme les reproduit.
  ]

  #notes[
    Les commandes sont celles du cours 2. Un commit à la fin de chaque
    étape ; si une étape échoue, `git restore recette.py` remet le fichier à
    l'état du dernier commit.

    `master` : le nom que `git init` donne à la première branche sur les
    postes ; `main` si le poste est réglé autrement.
  ]
]


#d("Étape 0 : le dossier de travail et le dépôt")[
  #annonce[
    `travail/` reçoit les données et devient un dépôt git. Le code n'y est
    pas encore : c'est l'étape 1.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [copier `depart/recettes/` et `depart/style.css` dans `travail/` ; dans VS Code, Fichier #sym.arrow.r Ouvrir le dossier `travail/` ; ouvrir un terminal Git Bash],
      reponse[`recettes/` et `style.css` dans l'explorateur ; `pwd` se termine par `travail`],
    [2], [une fois par poste : `source /c/ProgramData/anaconda3/etc/profile.d/conda.sh`, puis `conda init bash`, et un nouveau terminal],
      reponse[l'invite commence par `(base)` ; `which python` : le Python d'Anaconda],
    [3], [`git init` ; créer le fichier texte `.gitignore` (`touch .gitignore`), puis y écrire dans VS Code la ligne `sortie/`],
      reponse[`git status` liste `recettes/`, `style.css` et `.gitignore` non suivis],
  )

  #legende[
    `sortie/` est le dossier que le programme va écrire : il ne sera pas
    versionné. `depart/` reste tel quel ; `depart/secours/recette.py` est le
    résultat attendu de l'étape 1, pour qui reste bloqué.
  ]

  #notes[
    Le terminal de l'éditeur s'ouvre dans le dossier ouvert : c'est depuis
    `travail/` que tout se lance. Le premier commit vient à l'étape 1, avec
    le code.

    Vérifier que le dépôt est dans `travail/` et non dans `3a_cli/` : `git
    status` doit lister `recettes/`, pas `depart/`.
  ]
]

#d("Le même code, dans un fichier")[
  #annonce[
    Copier dans un script python, fichier `recette.py`, le code des cellules, dans
    leur ordre (dernière version). 
    `python recette.py` l'exécute en entier.
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
    Première ligne : dans un script, une expression seule n'affiche rien ;
    `print` partout où le notebook affichait.

    Deuxième ligne : le § 3.3 de `recette.ipynb`. Dans le TD, le script est lancé depuis le dossier qui contient
    `recettes/`, et `RACINE = Path.cwd()`.

    Troisième ligne : les valeurs en tête de fichier obligent à ouvrir le
    fichier pour les changer. `argparse` permet de les passer sur la ligne
    de commande.

    Quatrième ligne : un `def` définit la fonction sans exécuter son corps.
    Un `import recette` depuis un autre fichier fait la même lecture de haut
    en bas : les `def` définissent les fonctions, et les lignes du programme
    s'exécutent aussi. La fonction `main` (partie 1, puis étape 2) règle ce
    problème.
  ]
]

// --------------------------------------------
#d("Étape 1 : le code du notebook dans un fichier")[
  #annonce[
    Un fichier `recette.py`, écrit dans l'éditeur, qui reprend les cellules
    du notebook `recette.ipynb` dans l'ordre, et produit `sortie/crepes.html`.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [en tête : les `import` (`csv`, `shutil`, `subprocess`, `Path`) ; `NOM = "crepes"`, `PERSONNES = 4`, `UNITES = "SI"` ; `RACINE = Path.cwd()`, puis `DONNEES`, `STYLE` et `SORTIE` déduits],
      reponse[`python recette.py` ne fait encore rien : pas d'erreur, pas de sortie],
    [2], [copier les fonctions utiles (section 1), le programme (la fonction `generer` de la section 3.1 et les chemins de la section 3.3, avec `read_text` et `write_text`), l'appel de pandoc (section 4.3) ; finir par un `print` du chemin de la page],
      reponse[`python recette.py` écrit `sortie/crepes.html` ; la page s'ouvre par un double-clic],
    [3], [`git add .`, puis `git commit -m "Le programme du notebook, dans un fichier"`],
      reponse[`git status` : rien à valider ; `sortie/` n'est pas listé],
  )

  #notes[
    Le notebook affichait la dernière expression d'une cellule ; le script
    n'affiche que ce que `print` écrit.

    Le corrigé de l'étape : `corriges/3a_cli/etape1/recette.py`, identique à
    `depart/secours/recette.py`. Les cellules à recopier sont celles de la
    version finale : pas les chemins en dur de la section 2, pas les `!`.
    Les chemins passés à pandoc sont en `str(…)`.

    La copie de `style.css` dans `sortie/` (`shutil.copy`) est la seule ligne
    absente du notebook, où le CSS était déjà à côté : la dire.

    Erreur fréquente : `python recette.py` lancé depuis `3a_cli/` et non
    `travail/` ; `Path.cwd()` ne trouve alors pas `recettes/`.
  ]
]

#d("Étape 2 : une fonction main")[
  #annonce[
    Les lignes du programme, sous les fonctions utiles, passent dans une
    fonction `main`, appelée en bas du fichier. Le fichier produit est le
    même qu'avant.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [écrire `def main():` au-dessus des lignes du programme, et les indenter de quatre espaces],
      reponse[`python recette.py` ne produit plus rien : `main` est définie, pas appelée],
    [2], [en bas du fichier : `if __name__ == "__main__":` puis, indenté, `main()`],
      reponse[`python recette.py` produit la même page qu'à l'étape 1],
    [3], [`git diff`, puis `git commit -am "Une fonction main"`],
      reponse[le diff montre les mêmes lignes, indentées ; `git log --oneline` : deux lignes],
  )

  #legende[
    `git commit -am` ajoute les fichiers déjà suivis et valide en une
    commande. Un fichier nouveau demande `git add`.
  ]

  #notes[
    L'étape 1 de la question fait constater ce que dit la diapositive
    « Lecture d'un script par Python » : `def` ne lance rien. Les trois valeurs
    restent en tête du fichier pour l'instant ; `main` les lit comme
    variables globales.

    Corrigé : `corriges/3a_cli/etape2/recette.py`.
  ]
]

#d("Étape 3 : les arguments, sur une branche")[
  #annonce[
    Une branche `arguments`, et un commit par argument ajouté à `argparse` :
    la recette, puis le nombre de personnes, puis les unités. La branche est
    ensuite fusionnée dans `master`.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [`git checkout -b arguments` ; dans `main` : l'analyseur, `nom` avec `choices` = les dossiers de `recettes/` (boucle de la section 3.4), `NOM = options.nom` ; supprimer `NOM` en tête ; commit],
      reponse[`python recette.py` seul : `arguments are required: nom` ; `gaufres` : `invalid choice`],
    [2], [`-p/--personnes`, `type=int`, `default=4` ; `PERSONNES = options.personnes` ; commit],
      reponse[`python recette.py pate_pizza -p 6` : la pâte à pizza pour six],
    [3], [`-u/--unites`, `choices=("SI", "US")`, `default="SI"` ; `UNITES = options.unites` ; commit],
      reponse[`pate_pizza -p 6 -u US` : en onces et en cups ; `--help` : les trois arguments],
    [4], [`git checkout master`, `git merge arguments`, `git log --oneline --graph`],
      reponse[cinq commits sur une ligne : fusion en avance rapide],
  )

  #notes[
    `import argparse` en tête du fichier, et les trois lignes `NOM = …`
    disparaissent de la tête au fur et à mesure. Corrigé de la fin de
    l'étape : `corriges/3a_cli/etape3/recette.py`.

    Faire lire `--help` après chaque `add_argument` : l'aide change à chaque
    commit. `help="…"` dans `add_argument` complète l'aide ; le corrigé
    l'écrit, le TD peut s'en passer.
  ]
]

#d("Étape 4 : un README")[
  #annonce[
    Le dépôt reçoit un fichier `README.md` qui dit ce que fait le programme,
    comment l'installer et comment le lancer. Un modèle à compléter est dans
    `depart/modeles/`.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [copier `depart/modeles/README.md` dans `travail/`, l'ouvrir dans l'éditeur],
      reponse[cinq parties ; quatre passages « (À compléter …) »],
    [2], [compléter : la phrase d'objectif, la façon de récupérer le dossier, un exemple avec `-p` et `-u`, la liste des recettes, votre nom],
      reponse[l'aperçu Markdown de l'éditeur (`Ctrl+Maj+V` dans VS Code) montre la page],
    [3], [`git add README.md`, `git commit -m "Un README"`],
      reponse[six commits dans `git log --oneline`],
  )

  #legende[
    Le README est le premier fichier lu par qui ouvre le dépôt : il dit
    comment installer et lancer. Le cours 6 le publie avec le dépôt.
  ]

  #notes[
    Le corrigé, `corriges/3a_cli/etape4/README.md`, est une façon de le
    remplir. Ce qui compte : les commandes du README s'exécutent telles
    quelles, depuis le dossier du projet.

    Fin du TD : quatre étapes, six commits. Les étapes 5 et 6 sont dans le
    guide, à faire après la séance.
  ]
]

// Les étapes 5 (`src/` et `data/`) et 6 (`pyproject.toml`) ne sont plus
// projetées (syllabus v1.5, 24/09/2026) : elles restent dans le guide, pour
// qui veut les faire après la séance. Les diapositives sont dans
// l'historique git.
