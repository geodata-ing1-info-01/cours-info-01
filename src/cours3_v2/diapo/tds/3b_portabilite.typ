// TD 3b du cours 3 v2 — « Le programme d'Alice, avec git ».
//
// Le dossier `travail/` est un dépôt git : sur `master`, les corrigés des TD 2c et 3a ;
// sur `seuil`, le programme d'Alice. `data/cours3_v2/make_data.py` le fabrique et rejoue
// les étapes du TD. Corrigé : `data/cours3_v2/corriges/3b_portabilite/`. Sorties relevées
// en rejouant le TD sur ce dépôt, Python 3.12, git 2.34 en français.
//
// Inclus par `cours3_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 3_v2`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": sortie
#import "../schemas_depot.typ": graphe-depot
#import "../../../cours1_v2/diapo/schemas.typ": consignes, comment, commandes, constat

#let td = (
  numero: "3b",
  titre: "Le programme d'Alice, avec git",
  annonce: "Objectif : rendre portable le programme d'Alice, fusionner sa branche avec git, puis écrire le résultat dans un fichier",
  dossier: "cours3/3b_portabilite/",
  duree: "55′",
)
#separateur-td(..td)

// Le contenu d'un fichier à créer, dans le bloc gris du TD 2c.
#let contenu(texte) = block(width: 100%, inset: (x: 9pt, y: 6pt), above: 5pt, below: 2pt, fill: gris)[
  #show raw: set text(size: 12pt)
  #raw(block: true, texte)
]

#d("Étape 1 · Dépôt fourni")[
  #annonce[
    Le dossier `travail/` contient un dépôt git. Sur `master`, il contient la
    correction du TD 3a ; sur la branche `seuil`, Alice a ajouté un seuil à ce programme.
  ]

  #objectif[
    ouvrir le dépôt de `travail/` dans VS Code, y indiquer son identité, puis afficher son graphe.
  ]

  #grid(
    columns: (1fr, 6.4cm), column-gutter: 16pt,
    consignes(
      taille: 16pt,
      [Ouvrir le dossier `travail/` du TD dans VS Code : #comment[File, Open Folder…, `Desktop\info01\cours3\3b_portabilite\travail`.]],
      [Dans un nouveau terminal, indiquer son identité pour ce dépôt : #comment[menu Terminal, New Terminal.] #commandes("git config user.name \"Prénom Nom\"", "git config user.email prenom.nom@ensg.eu")],
      [Afficher le graphe du dépôt : `git log --oneline --graph --all --decorate`.
        #constat[Trois commits sur une ligne : `HEAD -> master` sur le deuxième, `seuil` sur le troisième.]],
    ),
    panneau("Graphe du dépôt reçu", graphe-depot("fourni")),
  )

  #notes[
    `git config` sans `--global`, comme au TD 2c : le dépôt reçu n'a pas d'identité.
    Les trois commits fournis ont des identifiants fixes : `53a24f4`, `a55eaa5`,
    `fd6aeee`.
  ]
]

#d("Étape 2 · Programme d'Alice")[
  #objectif[
    passer sur la branche `seuil`, lancer le programme d'Alice, puis revenir sur `master`.
  ]

  #consignes(
    taille: 17pt,
    [Passer sur la branche d'Alice : `git checkout seuil`.],
    [Dans `altitudes.py`, repérer le chemin écrit dans `open`, et la ligne `SEUIL = 2.0`.],
    [Lancer le programme : `python altitudes.py`.
      #constat[`FileNotFoundError` : `C:/Users/alice/cours3/trace.csv` n'existe que sur le poste d'Alice.]],
    [Revenir sur `master` : `git checkout master`.
      #constat[VS Code affiche la version de `master` : `open("trace.csv", …)`, sans seuil.]],
  )

  #notes[
    Changer de branche change les fichiers du dossier (cours 2). Le chemin écrit
    dans `open` : « Pb 2 » de l'exposé.
  ]
]

#d("Étape 3 · Fichiers à ignorer")[
  #objectif[
    exclure des commits les données et les résultats, puis enregistrer ce réglage par un commit.
  ]

  #consignes(
    taille: 16pt,
    [Afficher l'état du dépôt : `git status`.
      #constat[Trois fichiers non suivis : `parcours.txt`, `trace.csv` et `trace_2.csv`.]],
    [Dans VS Code, créer le fichier `.gitignore`, avec ces lignes : #comment[File, New File…]
      #contenu("*.csv\n*.txt")],
    [Afficher de nouveau l'état du dépôt : `git status`.
      #constat[Seul `.gitignore` est non suivi.]],
    [Créer un commit : #commandes("git add .gitignore", "git commit -m \"Ignore les données et les résultats\"")],
  )

  #notes[
    `*.csv` et `*.txt` écartent les traces, `parcours.txt` et `resume.txt`, écrit
    à l'étape 9.
  ]
]

#d("Étape 4 · Chemin construit avec pathlib")[
  #objectif[
    faire trouver `trace.csv` à `altitudes.py`, quel que soit le dossier du terminal, avec `__file__`.
  ]

  #consignes(
    taille: 16pt,
    [Lancer le programme depuis le dossier du TD : #commandes("cd ..", "python travail/altitudes.py")
      #constat[`FileNotFoundError` : `trace.csv` est cherché dans `3b_portabilite/`.]],
    [Dans `altitudes.py`, ajouter ces lignes après la description, puis remplacer `"trace.csv"` par `FICHIER` dans `open` :
      #contenu("from pathlib import Path\n\nFICHIER = Path(__file__).parent / \"trace.csv\"")],
    [Enregistrer le fichier, puis relancer : `python travail/altitudes.py`.
      #constat[`cumul en hausse : 98.4 m`, depuis le dossier du TD.]],
    [Revenir dans `travail/`, lire la modification, puis créer un commit : #commandes("cd travail", "git diff", "git add altitudes.py", "git commit -m \"Construit le chemin à partir du dossier du script\"")],
  )

  #notes[
    Exposé : « Chemin relatif : le dossier du terminal », puis « Dossier du script :
    `__file__` ». Pour ceux qui vont vite : essayer d'abord `Path.cwd() /
    "trace.csv"` ; depuis le dossier du TD, ce chemin échoue aussi.
  ]
]

#d("Étape 5 · Fichier en argument")[
  #objectif[
    remplacer le chemin écrit dans `altitudes.py` par un argument lu par `argparse`.
  ]

  #consignes(
    taille: 16pt,
    [Dans `altitudes.py`, remplacer les lignes `from pathlib…` et `FICHIER = …` par ces lignes :
      #contenu("import argparse\nfrom pathlib import Path\n\nanalyseur = argparse.ArgumentParser(description=\"Altitudes et cumul d'une trace GPS.\")\nanalyseur.add_argument(\"fichier\", help=\"le fichier CSV de la trace\")\noptions = analyseur.parse_args()\n\nFICHIER = Path(options.fichier)")],
    [Enregistrer le fichier, puis lancer le programme sur les deux traces : #commandes("python altitudes.py trace.csv", "python altitudes.py trace_2.csv")
      #constat[`cumul en hausse` : `98.4`, puis `29.2`.]],
    [Créer un commit : #commandes("git add altitudes.py", "git commit -m \"Lit le fichier en argument\"")],
  )

  #notes[
    Le chemin donné sur la ligne de commande part du dossier du terminal : celui
    de la personne qui lance le programme.
  ]
]

#d("Étape 6 · Fusion de la branche seuil")[
  #objectif[
    fusionner la branche `seuil` dans `master`, puis repérer le conflit dans `altitudes.py`.
  ]

  #consignes(
    taille: 16pt,
    [Fusionner la branche d'Alice : `git merge seuil -m "Fusionne le seuil d'Alice"`.
      #constat[`CONFLIT (contenu) : Conflit de fusion dans altitudes.py`.]],
    [Afficher l'état du dépôt : `git status`.
      #constat[`altitudes.py` est « modifié des deux côtés ».]],
    [Dans `altitudes.py`, chercher les marqueurs `<<<<<<<`, `=======` et `>>>>>>>`.
      #constat[Une seule ligne en conflit, celle de `open`.]],
  )

  #v(0.3em)
  #panneau("Le conflit dans altitudes.py")[
    #sortie("altitudes = []\n<<<<<<< HEAD\nwith open(FICHIER, encoding=\"utf-8\") as fichier:\n=======\nwith open(\"C:/Users/alice/cours3/trace.csv\", encoding=\"utf-8\") as fichier:\n>>>>>>> seuil", taille: 12pt)
  ]

  #notes[
    Sur les deux branches, la ligne de `open` a changé : l'élève y a mis `FICHIER`,
    Alice son chemin absolu. Alice seule a modifié les lignes du seuil, et git les
    fusionne sans conflit.
  ]
]

#d("Étape 6 · Résolution du conflit")[
  #objectif[
    garder la ligne de `master` dans le conflit, puis terminer la fusion.
  ]

  #grid(
    columns: (1fr, 11cm), column-gutter: 16pt,
    consignes(
      taille: 16pt,
      [Lancer le programme : `python altitudes.py trace.csv`.
        #constat[`SyntaxError` : les marqueurs ne sont pas du Python.]],
      [Au-dessus du conflit, cliquer sur « Accept Current Change », puis enregistrer.
        #constat[La ligne `with open(FICHIER, …)` reste, sans marqueurs.]],
      [Relancer le programme.
        #constat[`cumul en hausse : 88.7 m` : le seuil de 2 m d'Alice s'applique.]],
      [Terminer la fusion, puis afficher le graphe : #commandes("git add altitudes.py", "git commit -m \"Fusionne le seuil d'Alice\"", "git log --oneline --graph --all --decorate")
        #constat[Un commit de fusion, à deux parents.]],
    ),
    panneau("Graphe après la fusion", graphe-depot("fusion")),
  )

  #notes[
    « Accept Current Change » garde la version de la branche courante, `master`
    (`HEAD`) : diapositive « Résoudre un conflit dans VS Code » du cours 2.
  ]
]

#d("Étape 7 · Seuil en option")[
  #objectif[
    remplacer `SEUIL = 2.0`, écrit dans le code par Alice, par une option `-s` lue par `argparse`.
  ]

  #consignes(
    taille: 16pt,
    [Dans `altitudes.py`, après la ligne `analyseur.add_argument("fichier", …)`, ajouter ces lignes :
      #contenu("analyseur.add_argument(\"-s\", \"--seuil\", type=float, default=0,\n                       help=\"variation ignorée sous ce seuil, en mètres\")")],
    [Après la ligne `FICHIER = Path(options.fichier)`, ajouter `SEUIL = options.seuil`, puis supprimer la ligne `SEUIL = 2.0`.],
    [Enregistrer le fichier, puis lancer le programme, sans puis avec un seuil : #commandes("python altitudes.py trace.csv", "python altitudes.py trace.csv -s 2")
      #constat[`cumul en hausse` : `98.4`, puis `88.7`.]],
    [Créer un commit : #commandes("git add altitudes.py", "git commit -m \"Lit le seuil en option\"")],
  )
]

#d("Étape 8 · Interface du programme")[
  #objectif[
    lancer `altitudes.py` sur `trace_2.csv` sans modifier le code, puis avec des arguments
    manquants ou faux, et lire son aide.
  ]

  #consignes(
    taille: 17pt,
    [Lancer le programme sur la seconde trace, sans modifier le code : #commandes("python altitudes.py trace_2.csv", "python altitudes.py trace_2.csv -s 2")
      #constat[`cumul en hausse` : `29.2`, puis `11.4`.]],
    [Lancer le programme sans argument : `python altitudes.py`.
      #constat[`the following arguments are required: fichier`.]],
    [Donner un seuil qui n'est pas un nombre : `python altitudes.py trace.csv -s deux`.
      #constat[`argument -s/--seuil: invalid float value: 'deux'`.]],
    [Lire l'aide : `python altitudes.py --help`.
      #constat[Les deux arguments, avec les textes de `help=`.]],
  )

  #notes[
    `trace_2.csv` : de la gare de Noisy-Champs à Geodata Paris. Le terrain varie de
    8,4 m : la plus grande partie du cumul sans seuil vient du bruit.

    L'aide est produite à partir des `add_argument`, sans rien écrire d'autre.
  ]
]

#d("Étape 9 · Écriture du résumé dans un fichier")[
  #objectif[
    écrire le résumé de `altitudes.py` dans `resume.txt`, et comparer les modes d'ouverture `"w"`
    et `"a"`.
  ]

  #consignes(
    taille: 16pt,
    [À la fin de `altitudes.py`, ajouter ces lignes :
      #v(2pt)
      #sortie("with open(\"resume.txt\", \"w\", encoding=\"utf-8\") as sortie:\n    sortie.write(f\"{FICHIER.name} : seuil {SEUIL}, hausse {hausse:.1f} m, baisse {baisse:.1f} m\\n\")", taille: 11pt)],
    [Enregistrer le fichier, puis lancer le programme deux fois : #commandes("python altitudes.py trace.csv", "python altitudes.py trace.csv -s 2")],
    [Afficher le résumé : `cat resume.txt`.
      #constat[Une seule ligne, celle du seuil 2.0 : le mode `"w"` vide le fichier à l'ouverture.]],
    [Remplacer `"w"` par `"a"`, enregistrer, puis relancer les deux commandes et `cat resume.txt`.
      #constat[Trois lignes : le mode `"a"` écrit à la fin du fichier.]],
  )

  #notes[
    `\n` : `write` n'ajoute pas de fin de ligne, contrairement à `print`.

    `resume.txt` part du dossier du terminal. `FICHIER.name` donne le nom du
    fichier, sans son dossier.

    Pour ceux qui vont vite : écrire le résumé à côté de la trace, avec
    `FICHIER.parent / "resume.txt"`.
  ]
]

#d("Étape 9 · Commit et graphe final")[
  #objectif[
    enregistrer l'écriture du résumé par un commit, puis afficher le graphe du dépôt.
  ]

  #consignes(
    taille: 16pt,
    [Afficher l'état du dépôt : `git status`.
      #constat[Seul `altitudes.py` est modifié : `.gitignore` écarte `resume.txt`.]],
    [Créer un commit, puis afficher le graphe : #commandes("git add altitudes.py", "git commit -m \"Écrit le résumé dans resume.txt\"", "git log --oneline --graph --all --decorate")
      #constat[Neuf commits, dont la fusion.]],
  )

  #align(center, graphe-depot("final"))
]

#d("Étape 10 · Lecture d'une ligne selon l'encodage")[
  #objectif[
    facultatif : comparer la première ligne de `parcours.txt` en UTF-8, en cp1252 et sans décodage.
  ]

  #consignes(
    taille: 16pt,
    [Ouvrir `parcours.txt` dans VS Code.
      #constat[La première ligne est `Forêt,2 km`, et la barre d'état affiche `UTF-8` et `LF`.]],
    [Dans le terminal, ouvrir une session interactive : `python`.],
    [Lire la première ligne de `parcours.txt` en UTF-8 : #commandes("f = open(\"parcours.txt\", encoding=\"utf-8\")", "f.readline()")
      #constat[`'Forêt,2 km\n'`]],
    [Lire la même ligne en cp1252 : #commandes("f = open(\"parcours.txt\", encoding=\"cp1252\")", "f.readline()")
      #constat[`'ForÃªt,2 km\n'` : les deux octets de `ê` sont lus comme deux caractères.]],
    [Lire la même ligne sans la décoder : #commandes("f = open(\"parcours.txt\", \"rb\")", "f.readline()")
      #constat[`b'For\xc3\xaat,2 km\n'` : le `ê` occupe les octets `c3` et `aa`.]],
    [Quitter la session : `exit()`.],
  )

  #notes[
    Les trois fichiers ouverts restent ouverts jusqu'à `exit()`. Dans un programme,
    employer `with`.

    À vérifier sur un poste de la salle : dans le terminal de VS Code, `ê` et
    `Ãª` s'affichent correctement.
  ]
]
