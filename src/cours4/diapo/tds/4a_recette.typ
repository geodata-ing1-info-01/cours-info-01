// TD 4a du projet 4 — « Un script Python, pas à pas », pour tous les élèves.
//
// Inclus par `cours4.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`. Un
// fichier inclus n'hérite pas des imports de son appelant.
//
// Depuis le 30/09/2026, le projet 4 revoit les opérations des cours 1 à 3 à
// un rythme lent, sur un petit programme sans Markdown ni pandoc. Partie A :
// le dossier du projet dans le terminal, VS Code, le dépôt. Partie B :
// `recette.py`, une étape par notion, un commit par étape. Le programme de
// départ, les corrigés et le guide détaillé sont écrits par
// `data/cours4/generer_recette.py`.
//
// Plan des diapositives, celui des TD 3e et 3f : le guide et le
// matériel, la vue d'ensemble, les aide-mémoire, puis une diapositive par
// étape (objectif en annonce, attendu et pistes, renvoi au guide, constat
// dans le corrigé seulement).
#import "../../../commun/prelude.typ": *
#import "../../../cours3/diapo/schemas.typ": attendu-pistes, arborescence, sortie

#let td = (
  numero: "4a",
  titre: "Un script Python, pas à pas",
  annonce: "TD d'application des cours 1 à 3 : créer et versionner le dossier d'un projet, puis y construire un script Python qui calcule les quantités d'une recette, un commit par étape",
  dossier: "cours4/4a_recette/",
  duree: "30′ + 75′",
)
#separateur-td(..td)

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
    [`guide_4a_recette.pdf`, `.html`, `guide.ipynb`], [`cours4/4a_recette/`], [le détail des étapes, le code à copier],
    [`recette.py`], [`depart/`], [le programme de départ, avec deux erreurs de syntaxe à corriger],
    [`recettes/`], [`depart/`], [quatre recettes en CSV, pour 4 personnes ; `cookies.csv` en unités américaines],
    [`README.md`], [`depart/modeles/`], [un modèle de README à adapter et compléter (étape B7)],
  )

  #notes[
    Copié depuis le PDF, le code perd ses indentations : copier depuis la
    page HTML.

    Le parcours avancé fait ce TD plus vite, puis le TD 4b dans le même
    dossier.
  ]
]

// --------------------------------------------
#d("Les étapes du TD")[
  #annonce[
    Le script calcule une recette pour un nombre de personnes, en SI ou US.
  ]

  #chaine(
    ([`recettes/crepes.csv`], "la recette, pour 4 personnes"),
    ([`python recette.py crepes -p 6 -u US`], "une commande"),
    ([`sortie/crepes_6_US.csv`], "pour 6 personnes, en oz et cup"),
  )

  #tableau(
    columns: (auto, 1.3fr, 1fr),
    align: (center + horizon, left + horizon, left + horizon),
    [Étape], [Objectif], [Résultat],
    [A1-A3], [préparer le projet : dossier, éditeur, dépôt], [un dépôt ; un commit],
    [B1], [lire un message d'erreur et corriger], [la recette pour 4 personnes s'affiche],
    [B2], [parcourir une liste dans une fonction], [la recette pour 6 personnes],
    [B3], [convertir avec un dictionnaire], [la recette en oz et cup],
    [B4, B5], [lire, puis écrire un fichier CSV], [le résultat écrit dans `sortie/`],
    [B6], [lire les arguments de la ligne de commande], [`recette.py cookies -p 8`],
  )

  #notes[
    Un commit à la fin de chaque étape. L'étape B7, en bonus : un README et
    une étiquette git. Trois aide-mémoire suivent, puis une diapositive par
    étape.
  ]
]

// --------------------------------------------
#d("Aide-mémoire : le terminal")[
  #annonce[
    Rappel du cours 1, pour l'étape A1. Les commandes se tapent dans Git
    Bash ; les chemins partent du dossier courant.
  ]

  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [`pwd`], [affiche le dossier courant],
    [`ls depart`], [liste le contenu du dossier `depart`],
    [`cd travail/recette`, `cd ..`], [descend dans un dossier ; remonte d'un niveau],
    [`mkdir travail/recette`], [crée un dossier],
    [`cp depart/recette.py travail/recette/`], [copie un fichier dans un dossier],
    [`cp depart/recettes/*.csv …`], [copie tous les fichiers dont le nom se termine par `.csv`],
    [`Tab`, flèche haut], [complète un nom ; rappelle la commande précédente],
  )

  #legende[
    Une commande qui réussit n'affiche souvent rien : `ls` vérifie le
    résultat.
  ]
]

// --------------------------------------------
#d("Aide-mémoire : une étape, un commit")[
  #annonce[
    Rappel du cours 2, pour toutes les étapes. Les commandes se tapent dans
    le terminal Git Bash de VS Code, dans `travail/recette/`.
  ]

  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [`git init`], [crée le dépôt dans le dossier courant],
    [`git config user.name "Prénom Nom"`], [le nom qui signe les commits, pour ce dépôt ; de même `user.email`],
    [`.gitignore`], [une ligne par fichier ou dossier que git ne suit pas : ici `sortie/`],
    [`git status`], [les fichiers modifiés depuis le dernier commit],
    [`git diff`], [les lignes modifiées ; `q` pour quitter],
    [`git commit -am "…"`], [enregistre les fichiers suivis et modifiés],
    [`git restore recette.py`], [remet le fichier dans l'état du dernier commit],
  )
]

// --------------------------------------------
#d("Aide-mémoire : les données du programme")[
  #annonce[
    Rappel des cours 1 et 3, pour la partie B. Un ingrédient est un tuple de
    trois valeurs ; la recette est une liste d'ingrédients.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Écrit], [Signification],
    [`("Farine", 250, "g")`], [un tuple : le nom, la quantité, l'unité],
    [`[("Farine", 250, "g"), ("Lait", 500, "ml")]`], [une liste de deux tuples],
    [`for nom, quantite, unite in ingredients:`], [une boucle : les trois valeurs de chaque tuple, l'un après l'autre],
    [`resultat.append((nom, quantite, unite))`], [ajoute un tuple à la fin de la liste `resultat`],
    [`VERS_US = {"g": ("oz", 1 / 28.3495)}`], [un dictionnaire : la clé `"g"` et sa valeur],
    [`unite in VERS_US`, `VERS_US[unite]`], [vrai si la clé existe ; la valeur associée à la clé],
  )
]

// --------------------------------------------
#d("Étape A1 · Le dossier du projet, dans le terminal")[
  #annonce[
    Objectif : créer le dossier du projet par des commandes, en copiant les
    fichiers livrés.
  ]

  #grid(
    columns: (2fr, 1fr), column-gutter: 22pt, align: top,
    attendu-pistes(
      (
        [`travail/recette/` contient `recette.py` et le dossier `recettes/`],
        [`travail/recette/recettes/` contient les quatre fichiers CSV],
      ),
      (
        [extraire l'archive sur le Bureau, comme au cours 3],
        [ouvrir Git Bash dans `4a_recette/` : clic droit, « Open Git Bash here »],
        [créer les dossiers avec `mkdir`, copier les fichiers avec `cp` (`*.csv` pour les quatre CSV)],
        [vérifier chaque dossier avec `ls`],
      ),
    ),
    arborescence(
      (0, "4a_recette/"),
      (1, "depart/"),
      (2, "recette.py"),
      (2, "recettes/", "quatre CSV"),
      (1, "travail/"),
      (2, text(fill: attention)[recette/], "le projet"),
      (3, text(fill: attention)[recette.py]),
      (3, text(fill: attention)[recettes/]),
    ),
  )

  #legende[
    Guide, étape A1.
  ]

  #reponse(legende[
    Constaté : `mkdir` et `cp` n'affichent rien quand ils réussissent ;
    `ls travail/recette/recettes` liste les quatre fichiers.
  ])

  #notes[
    Git Bash dans le dossier : clic droit, « Afficher d'autres options »,
    « Open Git Bash here » ; sinon `cd ~/Desktop/cours4/4a_recette`.

    Erreur fréquente : `cp` lancé depuis `travail/`. `pwd` montre le dossier
    courant, qui doit être `4a_recette/`.
  ]
]

// --------------------------------------------
#d("Étape A2 · Le projet dans VS Code")[
  #annonce[
    Objectif : un éditeur ouvert sur le dossier du projet, avec un terminal
    Git Bash dans ce dossier.
  ]

  #attendu-pistes(
    (
      [`travail/recette/` ouvert dans VS Code],
      [un terminal Git Bash dont l'invite commence par `(base)` et se termine par `travail/recette`],
      [les espaces du code affichés par des points],
    ),
    (
      [ouvrir le dossier : File, Open Folder, `travail/recette`],
      [choisir Git Bash : `Ctrl` + `Maj` + `P`, « Terminal: Select Default Profile »],
      [ouvrir un terminal : Terminal, New Terminal],
      [afficher les espaces : `Ctrl` + `,`, « Render Whitespace », `all`],
    ),
  )

  #legende[
    Guide, étape A2. Sur un thème sombre, les points se voient mal : un
    thème clair (`Ctrl` + `K`, puis `Ctrl` + `T`, « Light Modern ») les rend
    plus visibles.
  ]

  #reponse(legende[
    Constaté : `pwd` dans le terminal de VS Code se termine par
    `travail/recette`.
  ])

  #notes[
    Sans `(base)` : `source /c/ProgramData/anaconda3/etc/profile.d/conda.sh`,
    puis `conda init bash`, puis un nouveau terminal (guide, A2.2).

    L'affichage des espaces sert à l'étape B1 (tabulation).
  ]
]

// --------------------------------------------
#d("Étape A3 · Le dépôt git")[
  #annonce[
    Objectif : enregistrer l'état de départ du projet, pour que chaque étape
    suivante ait son commit.
  ]

  #attendu-pistes(
    (
      [un dépôt git dans `travail/recette/`],
      [un fichier `.gitignore` qui contient `sortie/`],
      [un premier commit, avec `recette.py`, `recettes/` et `.gitignore`],
    ),
    (
      [créer le dépôt : `git init`],
      [donner son nom et son adresse, pour ce dépôt seulement : `git config user.name`, `user.email`],
      [écrire `.gitignore` : `echo "sortie/" > .gitignore`],
      [vérifier avec `git status`, puis `git add .` et `git commit -m`],
    ),
  )

  #legende[
    Guide, étape A3.
  ]

  #reponse(legende[
    Constaté : avant le commit, `git status` liste trois entrées non
    suivies ; après, « rien à valider ».
  ])

  #notes[
    Vérifier que le dépôt est dans `travail/recette/` : `git status` y
    liste `recettes/`.
  ]
]

// --------------------------------------------
#d("Étape B1 · Corriger le programme de départ")[
  #annonce[
    Objectif : lire un message d'erreur de Python et corriger la ligne qu'il
    désigne.
  ]

  #attendu-pistes(
    (
      [`python recette.py` affiche la recette des crêpes pour 4 personnes],
      [un commit par erreur corrigée],
    ),
    (
      [lancer `python recette.py`, lire le numéro de ligne, puis la dernière ligne du message],
      [`SyntaxError: expected ':'` : ajouter le deux-points qui manque],
      [`TabError` : repérer la flèche (une tabulation) parmi les points, la remplacer par des espaces],
      [relire `git diff`, puis faire le commit de chaque correction],
    ),
  )

  #legende[
    Guide, étape B1 : le programme de départ en entier.
  ]

  #reponse(legende[
    Constaté : deux erreurs, l'une après l'autre ; Python s'arrête sur la
    première qu'il rencontre.
  ])

  #notes[
    Faire lire le message à voix haute : fichier, ligne, ligne recopiée,
    nom de l'erreur.

    Ligne 20 : `:` manquant. Ligne 21 : une tabulation au lieu de huit
    espaces.
  ]
]

// --------------------------------------------
#d("Étape B2 · Multiplier les quantités")[
  #annonce[
    Objectif : afficher la recette pour un autre nombre de personnes que
    celui de la recette, en multipliant chaque quantité par le même nombre.
  ]

  #attendu-pistes(
    (
      [`python recette.py` affiche la recette des crêpes pour 6 personnes : `Farine : 375.0 g`, `Lait : 750.0 ml`],
      [une fonction `adapter(ingredients, personnes_recette, personnes)`, qui renvoie une nouvelle liste d'ingrédients],
      [un commit],
    ),
    (
      [dans `adapter`, calculer le facteur : `personnes / personnes_recette`, soit 6 / 4 = 1,5],
      [reprendre la boucle de `afficher`],
      [partir d'une liste vide, y ajouter chaque ingrédient multiplié par le facteur (`append`), la renvoyer (`return`)],
      [dans le programme, appeler `adapter` avec `PERSONNES_RECETTE` et `PERSONNES`, puis `afficher`],
    ),
  )

  #legende[
    Guide, étape B2 : le code de la fonction. À partir de cette étape, le
    guide ne donne que les lignes à modifier.
  ]

  #reponse(legende[
    Constaté : pour 4 personnes, les quantités de départ ; pour 2, la
    moitié. Les œufs s'affichent `6.0` : le facteur 1,5 donne un nombre à
    virgule.
  ])
]

// --------------------------------------------
#d("Étape B3 · Convertir les unités")[
  #annonce[
    Objectif : afficher la recette en unités américaines ou SI, avec une table
    de conversion.
  ]

  #grid(
    columns: (1.7fr, 1fr), column-gutter: 20pt, align: top,
    attendu-pistes(
      (
        [avec `UNITES = "US"`, la recette s'affiche en oz et cup : `Farine : 13.2 oz`],
        [les œufs, sans unité, gardent leur quantité],
        [une fonction `convertir(ingredients, table)` ; un commit],
      ),
      (
        [écrire deux dictionnaires, `VERS_US` et `VERS_SI` : pour chaque unité, l'autre unité et le facteur],
        [dans `convertir`, reprendre la boucle de `adapter`],
        [si l'unité est une clé de la table (`if unite in table:`), multiplier la quantité et changer l'unité ; sinon, garder l'ingrédient],
        [dans le programme, après `adapter`, appeler `convertir` avec `VERS_US` ou `VERS_SI` selon `UNITES`],
      ),
    ),
    panneau("Un dictionnaire")[
      #sortie("VERS_US = {\n  \"g\": (\"oz\", 1 / 28.3495),\n  \"ml\": (\"cup\", 1 / 236.588),\n}\n\n\"g\" in VERS_US   # True\n\"\" in VERS_US    # False : les œufs\n\nunite, facteur = VERS_US[\"ml\"]\n# unite : \"cup\"\n# facteur : 1 / 236.588", taille: 10.5pt)
    ],
  )

  #legende[
    Guide, étape B3. 1 oz = 28,3495 g ; 1 cup = 236,588 ml.
  ]

  #reponse(legende[
    Constaté : en SI, les crêpes ne changent pas, car elles sont déjà en
    SI ; `VERS_SI` sert aux cookies, à l'étape B4.
  ])
]

// --------------------------------------------
#d("Étape B4 · Lire un fichier CSV")[
  #annonce[
    Objectif : lire les ingrédients dans un fichier, pour toutes les recettes.
  ]

  #grid(
    columns: (1.9fr, 1fr), column-gutter: 20pt, align: top,
    attendu-pistes(
      (
        [`python recette.py` affiche la même recette qu'à l'étape B3, lue dans `recettes/crepes.csv`],
        [avec `NOM = "cookies"` et `UNITES = "SI"`, les cookies s'affichent en g et ml],
        [la liste initiale des ingrédients, `INGREDIENTS`, a disparu ; un commit],
      ),
      (
        [écrire `lire_ingredients(chemin)` : ouvrir le fichier, le lire avec `csv.reader` (`fichiers.ipynb`, § 10)],
        [laisser de côté la ligne des noms de colonnes : `next(lecteur)`],
        [convertir la quantité, lue comme une chaîne, en nombre : `float`],
        [construire les chemins depuis le dossier du script : `RACINE = Path(__file__).parent`, `DONNEES = RACINE / "recettes"`],
        [lire `DONNEES / (NOM + ".csv")` à la place de la liste initiale],
      ),
    ),
    panneau("recettes/crepes.csv")[
      #sortie("ingredient,quantite,unite\nFarine,250,g\nLait,500,ml\nŒufs,4,\nSel,2,g\nBeurre fondu,50,g", taille: 11pt)
    ],
  )

  #legende[
    Guide, étape B4. Documentation du module `csv` : #link("https://docs.python.org/fr/3/library/csv.html")[docs.python.org/fr/3/library/csv.html].
  ]

  #reponse(legende[
    Constaté : une quantité lue dans le fichier est une chaîne ; sans
    `float`, `adapter` s'arrête sur `TypeError`.
  ])

  #notes[
    `"250" * 1.5` donne `TypeError: can't multiply sequence by non-int of
    type 'float'` : à montrer si un élève oublie `float`.

    `__file__` : le chemin du script en cours d'exécution ; les chemins
    construits à partir de lui ne dépendent pas du dossier du terminal.
  ]
]

// --------------------------------------------
#d("Étape B5 · Écrire un fichier CSV")[
  #annonce[
    Objectif : écrire le résultat dans un fichier, avec les mêmes colonnes
    que les fichiers lus.
  ]

  #attendu-pistes(
    (
      [`python recette.py` écrit aussi `sortie/crepes_6_US.csv`],
      [le fichier écrit a la même première ligne que ceux de `recettes/`],
      [`git status` ne liste pas `sortie/` ; un commit],
    ),
    (
      [écrire `ecrire_ingredients(chemin, ingredients)` : ouvrir le fichier en écriture, `open(chemin, "w", …)` (`fichiers.ipynb`, § 9)],
      [avec `csv.writer`, écrire la ligne des colonnes, puis une ligne par ingrédient : `writerow`],
      [dans le programme, créer `sortie/` (`SORTIE = RACINE / "sortie"`, `SORTIE.mkdir(exist_ok=True)`), puis construire le nom du fichier avec `NOM`, `PERSONNES` et `UNITES`],
    ),
  )

  #legende[
    Guide, étape B5. Documentation du module `csv` : #link("https://docs.python.org/fr/3/library/csv.html")[docs.python.org/fr/3/library/csv.html].
  ]

  #reponse(legende[
    Constaté : le fichier écrit a la même première ligne que ceux de
    `recettes/` ; `.gitignore` l'écarte du dépôt.
  ])

  #notes[
    Pour ceux qui ont fini : copier le fichier écrit dans `recettes/` et le
    relire en SI pour 4 personnes ; les quantités reviennent à l'arrondi
    près (374,2 g de farine au lieu de 375).
  ]
]

// --------------------------------------------
#d("Étape B6 · Les arguments, avec argparse")[
  #annonce[
    Objectif : donner la recette, le nombre de personnes et les unités au
    lancement de la commande, au lieu de les changer dans le code. Les
    fonctions et le calcul ne changent pas.
  ]

  #attendu-pistes(
    (
      [`python recette.py cookies -p 8 -u SI` affiche les cookies pour 8 personnes en SI, et écrit leur CSV],
      [`python recette.py --help` décrit les trois arguments],
      [un commit],
    ),
    (
      [créer l'analyseur : `argparse.ArgumentParser` (cours 3)],
      [déclarer l'argument `nom`, puis les options `-p` (`type=int`, `default=4`) et `-u` (`choices`, `default`)],
      [remplacer les trois lignes `NOM = …`, `PERSONNES = …`, `UNITES = …` par les valeurs lues : `options.nom`, `options.personnes`, `options.unites`],
    ),
  )

  #legende[
    Guide, étape B6. Fin du TD en séance ; l'étape B7 est un bonus.
  ]

  #reponse(legende[
    Constaté : `python recette.py` seul répond `the following arguments are
    required: nom` ; un nom inconnu s'arrête sur `FileNotFoundError`.
  ])
]

// --------------------------------------------
#d("Étape B7 (bonus) · Un README, une étiquette")[
  #annonce[
    Objectif : qu'une autre personne sache lancer le programme, et nommer la
    version finale.
  ]

  #attendu-pistes(
    (
      [un `README.md` complété, dont les commandes fonctionnent],
      [l'étiquette `v1.0` sur le dernier commit],
      [un commit : le README],
    ),
    (
      [copier le modèle : `cp ../../depart/modeles/README.md .`],
      [remplacer chaque « (À compléter …) » ; l'aperçu : `Ctrl` + `Maj` + `V`],
      [faire le commit, puis poser l'étiquette : `git tag -a v1.0 -m "Première version"`],
    ),
  )

  #legende[
    Guide, étape B7.
  ]

  #reponse(legende[
    Constaté : `git log --oneline` affiche neuf lignes, et
    `(HEAD -> master, tag: v1.0)` sur la première.
  ])
]
