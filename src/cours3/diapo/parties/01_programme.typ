// Partie 1 du cours 3 — le programme de la recette, ses améliorations, et
// les trois bibliothèques qui les permettent.
//
// Incluse par `cours3.typ`, avant le TD 3b qui fait ouvrir `recette.ipynb`.
// Ordre : l'objectif du programme et ses données, le code de départ et ses
// trois problèmes, les améliorations jusqu'à la ligne de commande,
// puis `pathlib`, `subprocess` et `argparse`, avec l'essentiel pour les TD.
// Le détail est dans le texte des notebooks. Le cartouche « § n » renvoie à
// la section du notebook qui reprend la diapositive.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *
#import "../schemas_notebook.typ": schema-notebook-valeurs
#import "../schemas_programme.typ": schema-objectif, schema-etapes

// L'ouverture de la partie est commune au TD qui l'accompagne : voir
// `separateur-cours-td` dans `cours3.typ`.

// --------------------------------------------
#d("Objectif du programme")[
  #annonce[
    Le programme génère une recette avec les quantités et les unités
    adaptées au nombre de personnes. Il lit un fichier CSV et un fichier
    Markdown, et produit une page HTML.
  ]

  #schema-objectif()

  #legende[
    La page produite pour quatre personnes, en unités SI. Le fichier CSV
    donne les quantités pour une personne.
  ]

  #notes[
    Contenu réel de `depart/recettes/crepes/` ; la page est dessinée, sans
    la feuille de style `style.css`. L'ouvrir dans le navigateur en séance
    après le § 4 du notebook.
  ]
]

// --------------------------------------------
#d("Étapes du programme de génération de recette")[
  #annonce[
    Le programme insère dans la recette le tableau des ingrédients pour un
    nombre de personnes donné. pandoc convertit ensuite le résultat en page
    HTML.
  ]

  #schema-etapes()

  #notes[
    Fonctions utiles : données dans le notebook, résumées dans un tableau du
    notebook. Sujet de la séance : la désignation des fichiers et l'appel
    de pandoc.
  ]
]

// --------------------------------------------
#d("Organisation des données")[
  #annonce[
    Chaque recette a son dossier, qui contient les deux mêmes fichiers. Le
    programme écrit ses résultats dans `travail/`.
  ]

  #sortie("3b_recette/\n├── depart/\n│   ├── notebook/recette.ipynb       ← le notebook livré, à copier dans travail/\n│   ├── recettes/\n│   │   ├── crepes/\n│   │   │   ├── ingredients.csv      ← les quantités pour une personne\n│   │   │   └── recette.md           ← le texte, sans tableau des ingrédients\n│   │   ├── mousse_chocolat/\n│   │   ├── pate_pizza/\n│   │   └── salade_lentilles/\n│   └── style.css\n└── travail/                         ← le notebook et les fichiers produits", taille: 12pt)

  #notes[
    `depart/` ne se modifie pas. Le nom du dossier de recette servira de
    nom de recette sur la ligne de commande, au TD 3f.
  ]
]

// --------------------------------------------
#d("Le code brut, chemins en dur", cellule: "1 et 2")[
  #annonce[
    Le programme de création de recette, avec des chemins écrits en dur : il
    ne fonctionne que sur un poste. Les fonctions utiles du bloc 1 sont
    utilisées sans détailler leur code, vu dans le second notebook.
  ]

  #code-commente(
    taille-code: 12pt, taille-texte: 12pt,
    ("ingredients = lire_ingredients(\"C:/Users/alice/…/ingredients.csv\")", "lit le CSV"),
    ("ingredients = adapter(ingredients, 4, \"SI\")", "4 personnes, SI"),
    ("with open(\"C:/Users/alice/…/recette.md\", encoding=\"utf-8\") as fichier:", "ouvre la recette"),
    ("    source = fichier.read()", "tout son texte"),
    ("complete = source.replace(\"## Ingrédients\",\n    \"## Ingrédients\\n\\n\" + tableau(ingredients))", "insère le tableau"),
    ("with open(\"C:/Users/alice/…/crepes.md\", \"w\", encoding=\"utf-8\") as fichier:", "ouvre la sortie"),
    ("    fichier.write(complete)", "l'écrit"),
  )

  #avertissement[
    Ces chemins correspondent à ceux d'un poste spécifique. 
    Sur un autre, ou après un déplacement du dossier, les trois lignes sont donc à adapter.
  ]

  #notes[
    Diapositive présentée avant l'ouverture du notebook (TD 3b) ; le code s'exécute au § 2.
    Au § 2, on doit obtenir une erreur `FileNotFoundError` sur le premier chemin. 
    Puis faire modifier ce même bloc, où chacun adapte avec les chemins de son poste. 
    Ceux-ci sont lus dans la barre d'adresse de l'explorateur, mais il faut remplacer les `\` des chemins windows avec des `/` pour respecter les conventions de python. 
    Le code doit fonctionner (ne pas envoyer d'erreur), mais ne fonctionne toujours que sur un poste.
  ]
]

// --------------------------------------------
#d("Code de départ : trois problèmes")[
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Problème], [Correction dans `recette.ipynb`],
    [1], [le même début de chemin écrit trois fois : trois lignes à modifier pour changer de poste ou de recette], [une seule racine, les autres chemins construits avec `/` (§ 3.1 et 3.2)],
    [2], [un chemin absolu, propre à un poste : `C:/Users/alice/…` n'existe pas ailleurs, ni après un déplacement du dossier], [la racine déduite du dossier courant, `Path.cwd().parent` (§ 3.3)],
    [3], [la page HTML à produire à la main : pandoc lancé dans le terminal après le programme], [pandoc lancé par le programme, avec `subprocess` (§ 4.3)],
  )

  #legende[
    Les lignes `open` et `with` des fonctions utiles, qui lisent et écrivent
    ces fichiers, sont détaillées dans le second notebook, `fichiers.ipynb`.
  ]
]

// --------------------------------------------
#d("Améliorations du programme")[
  #tableau(
    columns: (5cm, auto, 1fr),
    align: left + horizon,
    [], [Étape], [Ce qui change],
    table.cell(rowspan: 2)[Correction des problèmes], [Chemins], [une racine, les autres chemins construits à partir d'elle],
    [Page HTML], [pandoc lancé depuis le programme Python],
    [Explication du code], [Lecture des fichiers], [les lignes `open` et `with` des fonctions utiles],
    table.cell(rowspan: 2)[Nouvelles fonctionnalités], [Plusieurs recettes], [une boucle sur les dossiers de `recettes/`],
    [Ligne de commande], [un script lancé dans le terminal à la place du notebook],
  )

  #notes[
    Notebooks autonomes : un texte explicatif par section, une réponse
    repliée sous chaque ligne à compléter. Diapositive à projeter pendant le
    travail.
  ]
]


// --------------------------------------------
#d("Trois bibliothèques de la séance")[
  #annonce[
    Les améliorations précédentes s'écrivent avec des fonctions de la
    bibliothèque standard de Python, livrée avec Python : trois
    bibliothèques à importer, sans installation.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr, auto),
    align: left + horizon,
    [Bibliothèque], [Problème résolu], [Ce qu'elle fournit], [Où],
    [`pathlib`], [des chemins écrits en entier, propres à un poste], [des chemins construits à partir d'une racine ; le parcours d'un dossier], [`recette.ipynb` § 3],
    [`subprocess`], [la conversion en HTML tapée à la main dans le terminal], [le lancement de pandoc depuis Python], [`recette.ipynb` § 4],
    [`argparse`], [des valeurs modifiées dans le code avant chaque lancement], [la lecture des valeurs écrites après le nom du script, et l'aide `--help`], [`recette.py`, TD 3f],
  )

  #legende[
    Documentation : docs.python.org/fr/3/library/ suivi du nom de la
    bibliothèque.
  ]

  #notes[
    `csv`, employé par les fonctions utiles, fait aussi partie de la
    bibliothèque standard.
  ]
]

// --------------------------------------------
#d("pathlib : manipulation des chemins")[
  #annonce[
    `pathlib` simplifie la manipulation des chemins en Python. Les fonctions
    ci-dessous sont parmi les plus courantes ; la documentation décrit les
    autres, comme `glob`, `with_suffix` ou `read_text` :
    docs.python.org/fr/3/library/pathlib.html.
  ]

  #code-commente(
    taille-code: 14.5pt, taille-texte: 13.5pt,
    ("from pathlib import Path", "la classe des chemins"),
    ("Path(\"C:/Users/alice/Desktop/cours3\")", "déclare un chemin ; ne crée et ne vérifie rien"),
    ("Path.cwd()", "le dossier courant"),
    ("dossier / \"recettes\" / \"crepes\"", "ajoute un dossier ou un fichier au chemin"),
    ("", ""),
    ("chemin.name, chemin.stem, chemin.suffix", "`recette.md`, `recette`, `.md`"),
    ("chemin.parent", "le dossier qui contient le chemin"),
    ("", ""),
    ("chemin.exists(), chemin.is_dir(), chemin.is_file()", "existe ; est un dossier ; est un fichier"),
    ("dossier.iterdir()", "les fichiers et sous-dossiers, sans ordre"),
    ("chemin.resolve()", "le chemin absolu, sans `..`"),
    ("chemin.relative_to(racine)", "le chemin à partir de `racine`"),
  )

  #notes[
    Exemples de la colonne de droite avec `chemin = RACINE / "depart" /
    "recettes" / "crepes" / "recette.md"`. La diapositive suivante emploie
    ces fonctions sur le TD.
  ]
]

// --------------------------------------------
#d("pathlib : application au TD", cellule: "3.2 et 3.3")[
  #annonce[
    Le code n'écrit qu'un chemin, celui de la racine du TD. Les autres
    chemins sont construits à partir de la racine avec l'opérateur `/`.
  ]

  #face-a-face(
    panneau("L'arborescence du TD")[
      #sortie("3b_recette/                ← RACINE\n├── depart/\n│   └── recettes/          ← DONNEES\n│       └── crepes/\n│           ├── ingredients.csv\n│           └── recette.md\n└── travail/               ← SORTIE\n    └── crepes.md", taille: 12pt)
    ],
    panneau("Le code")[
      #sortie("from pathlib import Path\n\nRACINE = Path.cwd().parent\nDONNEES = RACINE / \"depart\" / \"recettes\"\nSORTIE = RACINE / \"travail\"\nDONNEES / \"crepes\" / \"recette.md\"\n\nfor dossier in DONNEES.iterdir():\n    print(dossier.name)", taille: 12pt)
    ],
  )

  #legende[
    `Path.cwd()` renvoie le dossier courant, qui est le dossier du notebook,
    ou celui du terminal pour un script.
  ]

  #notes[
    Un `Path` s'écrit avec des `/` quel que soit le système, et s'affiche
    avec des `\` sous Windows. Construire un chemin ne vérifie pas qu'il
    existe : `exists()` le fait.
  ]
]


// --------------------------------------------
// Correction du code de la diapositive « Le code brut, chemins en dur », en
// deux étapes, comme dans le notebook : les chemins en paramètres d'une
// fonction (§ 3.1), puis une racine et des chemins construits (§ 3.2, 3.3).
// Le code est allégé : « … » tient la place des lignes qui ne changent pas.
#d("Correction 1 : les chemins en paramètres", cellule: "3.1")[
  #annonce[
    Les trois chemins sont déclarés une fois, en tête, et passés à la
    fonction `generer`.
  ]

  // Les deux panneaux se suivent de près : l'espacement par défaut des blocs
  // ne laisse pas la place au code.
  #set block(spacing: 0.55em)
  #panneau("Avant, § 2 : les trois lignes qui contiennent un chemin")[
    #sortie("ingredients = lire_ingredients(\"C:/…/crepes/ingredients.csv\")\nwith open(\"C:/…/crepes/recette.md\", encoding=\"utf-8\") as fichier:\nwith open(\"C:/…/travail/crepes.md\", \"w\", encoding=\"utf-8\") as fichier:", taille: 10pt)
  ]
  #panneau("Après, § 3.1 : trois chemins déclarés, passés à la fonction")[
    #sortie("FICHIER_INGREDIENTS = \"C:/…/crepes/ingredients.csv\"\nFICHIER_RECETTE = \"C:/…/crepes/recette.md\"\nFICHIER_SORTIE = \"C:/…/travail/crepes.md\"\ndef generer(fichier_ingredients, fichier_recette, fichier_sortie):\n    ingredients = lire_ingredients(fichier_ingredients)\n    …\n    with open(fichier_recette, encoding=\"utf-8\") as fichier:\n    …\n    with open(fichier_sortie, \"w\", encoding=\"utf-8\") as fichier:\n    …\ngenerer(FICHIER_INGREDIENTS, FICHIER_RECETTE, FICHIER_SORTIE)", taille: 10pt)
  ]

  #notes[
    `…` : les lignes qui ne changent pas. Les chemins restent absolus : ils
    ne valent que sur un poste, d'où l'étape 2.

    Code allégé du § 3.1 : la fonction a aussi deux paramètres `personnes`
    et `unites`, avec des valeurs par défaut, et `C:/…` abrège
    `C:/Users/alice/Desktop/cours3/3b_recette/…`.
  ]
]

// --------------------------------------------
#d("Correction 2 : une racine", cellule: "3.2 et 3.3")[
  #annonce[
    Un seul chemin est déclaré : la racine du TD, déduite du dossier courant.
    Les autres chemins sont construits à partir d'elle avec l'opérateur `/`.
  ]

  #face-a-face(
    panneau("L'arborescence du TD")[
      #sortie("3b_recette/                 ← RACINE\n├── depart/\n│   └── recettes/           ← DONNEES\n│       └── crepes/         ← RECETTE\n│           ├── ingredients.csv\n│           └── recette.md\n└── travail/                ← SORTIE\n    ├── recette.ipynb       ← Path.cwd()\n    └── crepes.md", taille: 11pt)
    ],
    panneau("Après, § 3.3")[
      #sortie("RACINE = Path.cwd().parent\nDONNEES = RACINE / \"depart\" / \"recettes\"\nSORTIE = RACINE / \"travail\"\nRECETTE = DONNEES / \"crepes\"\n\nFICHIER_INGREDIENTS = RECETTE / \"ingredients.csv\"\nFICHIER_RECETTE = RECETTE / \"recette.md\"\nFICHIER_SORTIE = SORTIE / \"crepes.md\"\n\ngenerer(FICHIER_INGREDIENTS, FICHIER_RECETTE,\n        FICHIER_SORTIE)", taille: 11pt)
    ],
  )

  #legende[
    La fonction `generer` et son appel ne changent pas. Le code fonctionne
    sur tout poste où `depart/` et `travail/` sont côte à côte.
  ]

  #notes[
    Le § 3.2 écrit d'abord la racine en dur, `Path("C:/…/3b_recette")`,
    puis le § 3.3 la déduit du dossier courant : `Path.cwd()` est
    `travail/`, le dossier du notebook, et `.parent` le dossier au-dessus.
  ]
]

// --------------------------------------------
// Rappel des trois problèmes du code de départ : les deux premiers sont
// corrigés par pathlib, le troisième ouvre la diapositive de subprocess.
#d("Problèmes du code de départ, après pathlib")[
  #annonce[
    pathlib corrige les deux premiers problèmes. Le troisième, la page HTML
    produite à la main, se corrige avec subprocess.
  ]

  #let fait(corps) = text(fill: estompe)[#corps]
  #tableau(
    columns: (auto, 1fr, auto),
    align: left + horizon,
    [], [Problème], [État],
    fait[1], fait[le même début de chemin écrit trois fois], fait[corrigé : une racine, § 3.1 et 3.2],
    fait[2], fait[un chemin absolu, propre à un poste], fait[corrigé : `Path.cwd().parent`, § 3.3],
    surligne[3], surligne[la page HTML à produire à la main : pandoc lancé dans le terminal après le programme], surligne[à corriger : `subprocess`, § 4.3],
  )
]

// --------------------------------------------
#d("Produire la page : une commande en plus", cellule: "4.1")[
  #annonce[
    Le notebook écrit la recette en Markdown. La page HTML se produit
    ensuite par une commande, `pandoc`, tapée dans un terminal : une étape à
    la main, en plus du notebook.
  ]

  #chaine(
    ([`recette.ipynb`], "écrit travail/crepes.md"),
    ([`pandoc`, dans le terminal], "lit crepes.md, écrit crepes.html"),
    ([`crepes.html`], "la page, ouverte par un double-clic"),
  )

  #v(0.5em)
  #sortie("(base) C:\\Users\\moi> cd Desktop\\cours3\\3b_recette\\travail\n(base) C:\\Users\\moi\\Desktop\\cours3\\3b_recette\\travail> pandoc crepes.md -o crepes.html", taille: 12pt)

  #v(0.3em)
  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [`pandoc`], [le programme lancé, livré avec Anaconda],
    [`crepes.md`], [le fichier à lire, l'entrée],
    [`-o crepes.html`], [le fichier à écrire, la sortie ; le format suit l'extension],
  )

  #notes[
    `-o` : raccourci d'`--output`. Documentation : pandoc.org/MANUAL.html.
    Le § 4.2 essaie les options une à une depuis le notebook, avec `!`.
  ]
]

// --------------------------------------------
#d("subprocess : appeler pandoc depuis Python", cellule: "4.3")[
  #annonce[
    Objectif : que le programme Python lance lui-même pandoc. La fonction
    `subprocess.run` reçoit la commande sous forme de liste : le nom du
    programme, puis ses arguments, un élément par mot.
  ]

  #tableau(
    columns: (auto, auto, auto, auto, auto),
    align: left + horizon,
    [Dans le terminal], [`pandoc`], [`crepes.md`], [`-o`], [`crepes.html`],
    [Dans la liste Python], [`"pandoc"`], [`"crepes.md"`], [`"-o"`], [`"crepes.html"`],
  )

  #v(0.6em)
  #code-commente(
    ("import subprocess", "la bibliothèque, livrée avec Python"),
    ("commande = [\"pandoc\", \"crepes.md\", \"-o\", \"crepes.html\"]", "un élément par mot de la commande"),
    ("subprocess.run(commande, check=True)", "lance pandoc ; `check=True` lève une erreur Python en cas d'échec"),
  )

  #legende[
    Un chemin `Path` se passe par `str(chemin)` : la commande ne reçoit que
    des chaînes.
  ]

  #notes[
    Liste : chaque élément est transmis au programme sans découpage,
    espaces et accents compris. `os.system` et la syntaxe `!` du
    notebook sont montrés dans le notebook, § 4.2 et 4.3.

    Le terminal trouve pandoc dans les dossiers de `PATH` : § 4.4, à lire
    après la séance.
  ]
]

// --------------------------------------------
// Point d'attention : les chemins relatifs d'une commande partent du dossier
// courant. La même conversion, lancée depuis trois dossiers de l'arborescence.
#d("Le dossier courant d'une commande", cellule: "4.1")[
  #annonce[
    La même conversion s'écrit différemment selon le dossier d'où elle est
    lancée : celui du terminal, ou, depuis Python, celui du notebook ou du
    script.
  ]

  #face-a-face(
    panneau("L'arborescence")[
      #sortie("cours3/                    ← dossier courant C\n└── 3b_recette/           ← dossier courant B\n    ├── depart/\n    └── travail/           ← dossier courant A\n        ├── recette.ipynb\n        ├── crepes.md\n        └── crepes.html", taille: 11pt)
    ],
    panneau("La même conversion, depuis chaque dossier")[
      #tableau(
        columns: (auto, 1fr),
        align: left + horizon,
        [], [Commande],
        [A], [`pandoc crepes.md -o crepes.html`],
        [B], [`pandoc travail\crepes.md -o travail\crepes.html`],
        [C], [`pandoc 3b_recette\travail\crepes.md -o 3b_recette\travail\crepes.html`],
      )
    ],
  )

  #avertissement[
    Depuis `cours3/`, `-o crepes.html` écrit la page dans `cours3/`, loin de
    `crepes.md`. Et `pandoc crepes.md …` y échoue : le fichier n'y est pas.
  ]

  #notes[
    Le notebook tourne dans `travail/` : `subprocess.run(["pandoc",
    "crepes.md", …])` n'y fonctionne que parce que `crepes.md` est à côté du
    notebook. Le même appel dans un script lancé depuis un autre dossier
    échoue. Diapositive suivante : des chemins construits à partir de la
    racine.

    Dans une chaîne Python, `\t` est une tabulation : écrire les chemins
    avec `/` ou avec `Path`, jamais `"3b_recette\travail"`.
  ]
]

// --------------------------------------------
#d("Les chemins de l'appel dans le programme", cellule: "4.3")[
  #annonce[
    Dans `generer_page`, les chemins passés à pandoc sont construits à partir
    de la racine : ils désignent les mêmes fichiers quel que soit le dossier
    courant.
  ]

  #code-commente(
    taille-code: 12.5pt, taille-texte: 12.5pt,
    ("page = fichier_sortie.with_suffix(\".html\")", "`travail/crepes.md` devient `travail/crepes.html`"),
    ("commande = [\"pandoc\", str(fichier_sortie), \"-o\", str(page),", "les deux chemins, en chaînes"),
    ("            \"--standalone\", \"--css\", \"style.css\"]", "une page complète, et sa feuille de style"),
    ("subprocess.run(commande, check=True)", "lance pandoc"),
  )

  #v(0.4em)
  #sortie("print(str(fichier_sortie))\nC:\\Users\\moi\\Desktop\\cours3\\3b_recette\\travail\\crepes.md", taille: 12pt)

  #legende[
    `fichier_sortie` vaut `RACINE / "travail" / "crepes.md"`, et `RACINE`
    est absolue : le chemin passé à pandoc est complet.
  ]

  #notes[
    Code allégé de `generer_page` (§ 4.3) : la vraie commande ajoute
    `--metadata pagetitle=…`. `style.css` reste relatif : le navigateur suit
    ce chemin depuis la page, et la feuille est copiée à côté d'elle.
  ]
]

// --------------------------------------------
#d("Du notebook à la ligne de commande")[
  #annonce[
    Dans le notebook, changer une valeur oblige à relancer les cellules qui
    en dépendent. Le script du TD 3f reçoit les valeurs sur la ligne de
    commande, et une seule commande produit la page.
  ]

  #grid(
    columns: (auto, 1fr),
    column-gutter: 20pt,
    align: top,
    schema-notebook-valeurs(),
    [
      #panneau("Invite de commandes d'Anaconda : recette.py, TD 3f")[
        #sortie("> python recette.py pate_pizza -p 6 -u US\n…\\sortie\\pate_pizza.html :\n6 personne(s), unités US", taille: 11pt)
      ]
      #v(0.3em)
      #tableau(
        columns: (auto, auto),
        align: left + horizon,
        [Notebook], [Ligne de commande],
        [`NOM = "pate_pizza"`], [`pate_pizza`],
        [`PERSONNES = 6`], [`-p 6`],
        [`UNITES = "US"`], [`-u US`],
      )
    ],
  )

  #notes[
    Schéma : la cellule des valeurs n'existe pas telle quelle dans
    `recette.ipynb`, où `generer` reçoit les valeurs à l'appel ; elle
    représente le cas d'un notebook paramétré en tête. Sortie du terminal :
    exécution réelle du corrigé du TD 3f, chemin abrégé.
  ]
]

// --------------------------------------------
// Un script minimal, sans fonction `main` : la fonction `main` est présentée
// dans le TD 3f, en bonus (29/09/2026).
#d("Un script qui lit la ligne de commande")[
  #annonce[
    Le script lit le nom de la recette, écrit après le nom du script. La
    bibliothèque `argparse` vérifie qu'il est donné, et produit l'aide.
  ]

  #face-a-face(
    panneau("recette.py")[
      #sortie("import argparse\n\nanalyseur = argparse.ArgumentParser()\nanalyseur.add_argument(\"nom\")\noptions = analyseur.parse_args()\nprint(\"Recette demandée :\", options.nom)", taille: 12pt)
    ],
    panneau("Invite de commandes d'Anaconda")[
      #sortie("> python recette.py crepes\nRecette demandée : crepes\n\n> python recette.py\nusage: recette.py [-h] nom\nrecette.py: error: the following\narguments are required: nom\n\n> python recette.py --help\nusage: recette.py [-h] nom\n…", taille: 12pt)
    ],
  )

  #legende[
    `options.nom` contient le texte écrit après `recette.py`.
  ]

  #notes[
    Sorties réelles. `options.nom` porte le nom donné à `add_argument`.
    Sans argument, `parse_args` affiche l'usage et arrête le script, avant
    le `print`. La diapositive suivante ajoute les deux options de la
    recette, `-p` et `-u`.
  ]
]

// --------------------------------------------
#d("argparse : les arguments d'un script")[
  #annonce[
    `argparse`, bibliothèque standard, lit les arguments écrits après le nom
    du script : il les vérifie, les convertit, et construit l'aide de `--help`.
  ]

  #code-commente(
    taille-code: 11pt, taille-texte: 12.5pt,
    ("analyseur = argparse.ArgumentParser()", "l'analyseur des arguments"),
    ("analyseur.add_argument(\"nom\", choices=recettes_disponibles)", "obligatoire ; une valeur de la liste"),
    ("analyseur.add_argument(\"-p\", \"--personnes\", type=int, default=4)", "option ; convertie en entier ; 4 si absente"),
    ("analyseur.add_argument(\"-u\", \"--unites\", choices=(\"SI\", \"US\"), default=\"SI\")", "option ; SI ou US ; SI si absente"),
    ("options = analyseur.parse_args()", "lit la ligne de commande ; message et arrêt si elle est invalide"),
    ("options.nom, options.personnes, options.unites", "les valeurs lues"),
  )

  #legende[
    Documentation : docs.python.org/fr/3/library/argparse.html.
  ]

  #tableau(
    entete: false,
    columns: (1fr, 1fr),
    align: left + horizon,
    [`python recette.py pate_pizza -p 6 -u US`], [`nom`, puis deux options],
    [`python recette.py gaufres`], [`invalid choice`, et la liste],
    [`python recette.py --help`], [l'aide, depuis les `add_argument`],
  )

  #notes[
    Un argument sans tiret est obligatoire et positionnel ; avec des tirets,
    c'est une option, qui a une valeur par défaut. `type=int` convertit et
    rejette `six`. `choices` rejette ce qui n'est pas dans la liste ; la
    liste des recettes vient de `iterdir()` sur `recettes/`, comme à la
    section 3.4 de `recette.ipynb`.

    Faire lire `--help` : l'aide est produite à partir des `add_argument`,
    sans rien écrire d'autre.
  ]
]
