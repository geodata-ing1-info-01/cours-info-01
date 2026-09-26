// Partie 1 du cours 3 — le programme de la recette, ses améliorations, et
// les trois bibliothèques qui les permettent.
//
// Incluse par `cours3.typ`, avant le TD 1a qui fait ouvrir `recette.ipynb`.
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
    Fonctions utiles : reprises du cours 1, résumées dans un tableau du
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

  #sortie("1a_recette/\n├── depart/\n│   ├── notebook/recette.ipynb       ← le notebook livré, à copier dans travail/\n│   ├── recettes/\n│   │   ├── crepes/\n│   │   │   ├── ingredients.csv      ← les quantités pour une personne\n│   │   │   └── recette.md           ← le texte, sans tableau des ingrédients\n│   │   ├── mousse_chocolat/\n│   │   ├── pate_pizza/\n│   │   └── salade_lentilles/\n│   └── style.css\n└── travail/                         ← le notebook et les fichiers produits", taille: 12pt)

  #notes[
    `depart/` ne se modifie pas. Le nom du dossier de recette servira de
    nom de recette sur la ligne de commande, au TD 3a.
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
    Diapositive présentée avant l'ouverture du notebook (TD 1a) ; le code s'exécute au § 2.
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
    columns: (5cm, auto, 1fr, auto),
    align: left + horizon,
    [], [Étape], [Ce qui change], [Où],
    table.cell(rowspan: 2)[Correction des problèmes], [Chemins], [une racine, les autres chemins construits à partir d'elle], [`recette.ipynb` § 3.1 à 3.3],
    [Page HTML], [pandoc lancé depuis le programme Python], [`recette.ipynb` § 4],
    [Explication du code], [Lecture des fichiers], [les lignes `open` et `with` des fonctions utiles], [`fichiers.ipynb`],
    table.cell(rowspan: 2)[Nouvelles fonctionnalités], [Plusieurs recettes], [une boucle sur les dossiers de `recettes/`], [`recette.ipynb` § 3.4],
    [Ligne de commande], [un script lancé dans le terminal à la place du notebook], [TD 3a],
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
    [`argparse`], [des valeurs modifiées dans le code avant chaque lancement], [la lecture des valeurs écrites après le nom du script, et l'aide `--help`], [`recette.py`, TD 3a],
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
      #sortie("1a_recette/                ← RACINE\n├── depart/\n│   └── recettes/          ← DONNEES\n│       └── crepes/\n│           ├── ingredients.csv\n│           └── recette.md\n└── travail/               ← SORTIE\n    └── crepes.md", taille: 12pt)
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
#d("subprocess : appel d'un programme externe", cellule: "4.3")[
  #annonce[
    `subprocess.run` reçoit la commande du terminal sous forme de liste, qui
    contient le nom du programme puis ses arguments.
  ]

  #sortie("(base) …\\1a_recette\\travail> pandoc crepes.md -o crepes.html", taille: 13pt)

  #v(0.4em)
  #code-commente(
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
    notebook sont montrés dans le notebook, § 4.2 et 4.4.

    Le terminal trouve pandoc dans les dossiers de `PATH` : § 4.4, à lire
    après la séance.
  ]
]

// --------------------------------------------
#d("Du notebook à la ligne de commande")[
  #annonce[
    Dans le notebook, changer une valeur oblige à relancer les cellules qui
    en dépendent. Le script du TD 3a reçoit les valeurs sur la ligne de
    commande, et une seule commande produit la page.
  ]

  #grid(
    columns: (auto, 1fr),
    column-gutter: 20pt,
    align: top,
    schema-notebook-valeurs(),
    [
      #panneau("Anaconda Prompt : recette.py, TD 3a")[
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
    exécution réelle du corrigé du TD 3a, chemin abrégé.
  ]
]

// --------------------------------------------
#d("Point d'entrée d'un script : la fonction main")[
  #annonce[
    Les lignes du programme sont placées dans une fonction `main`. La fin du
    fichier appelle `main` seulement si le fichier est lancé avec
    `python recette.py`.
  ]

  #code-commente(
    taille-code: 13pt, taille-texte: 12.5pt,
    ("def lire_ingredients(chemin):", "les fonctions utiles, sans changement"),
    ("", ""),
    ("def main():", "le programme, dans une fonction"),
    ("    ingredients = lire_ingredients(...)", "les lignes du programme, indentées"),
    ("", ""),
    ("if __name__ == \"__main__\":", "vrai si le fichier est lancé avec `python`"),
    ("    main()", "exécute le programme"),
  )

  #notes[
    Le résultat de `python recette.py` est le même qu'avant le passage dans
    `main`.

    `__name__` est une variable que Python définit dans chaque fichier. Avec
    le test, un autre fichier peut importer les fonctions de `recette.py`
    sans exécuter le programme.

    Une commande installée avec `pyproject.toml` appelle aussi `main` :
    `recette = "recette:main"`.
  ]
]
// --------------------------------------------
#d("Lecture d'un script par Python")[
  #annonce[
    Lancé ou importé, un fichier est lu de haut en bas, et chaque ligne est
    exécutée. Un `def` crée la fonction sans exécuter son corps.
  ]

  #let non(corps) = text(fill: estompe)[#corps]
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [`recette.py`], [`python recette.py`], [`from recette import lire_ingredients`],
    [`import csv`], [exécutée : `csv` est chargé], [exécutée : `csv` est chargé],
    [`def lire_ingredients(chemin): …`], [la fonction est créée], [la fonction est créée],
    [`def main(): …`], [la fonction est créée], [la fonction est créée],
    [`if __name__ == "__main__":`], [`__name__` vaut `"__main__"` : vrai], non[`__name__` vaut `"recette"` : faux],
    [`    main()`], [exécutée : la page est produite], non[ignorée],
  )

  #legende[
    Sans le test, `main()` serait aussi exécutée à l'import : récupérer
    `lire_ingredients` pour la réutiliser ou la tester produirait la page et
    lancerait pandoc.
  ]

  #notes[
    `__name__` est une variable que Python définit dans chaque fichier : le
    nom du module à l'import, `"__main__"` pour le fichier lancé.

    Cas courant de l'import : un fichier de tests, `test_recette.py`, qui
    appelle `lire_ingredients` sur un CSV connu et vérifie le résultat. Le
    projet 7 en écrit un.

    Le corps d'une fonction ne s'exécute qu'à l'appel : `lire_ingredients`
    n'ouvre aucun fichier tant que `main` ne l'appelle pas.
  ]
]

// --------------------------------------------
#d("Script minimal : main et argparse")[
  #annonce[
    Le script lit un argument, le nom de la recette, sur la ligne de
    commande. `argparse` vérifie sa présence et produit l'aide.
  ]

  #face-a-face(
    panneau("recette.py")[
      #sortie("import argparse\n\n\ndef main():\n    analyseur = argparse.ArgumentParser()\n    analyseur.add_argument(\"nom\")\n    options = analyseur.parse_args()\n    print(\"Recette demandée :\", options.nom)\n\n\nif __name__ == \"__main__\":\n    main()", taille: 11.5pt)
    ],
    panneau("Anaconda Prompt")[
      #sortie("> python recette.py crepes\nRecette demandée : crepes\n\n> python recette.py\nusage: recette.py [-h] nom\nrecette.py: error: the following\narguments are required: nom\n\n> python recette.py --help\nusage: recette.py [-h] nom\n…", taille: 11.5pt)
    ],
  )

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
    taille-code: 12pt, taille-texte: 12.5pt,
    ("analyseur = argparse.ArgumentParser()", "l'analyseur des arguments"),
    ("analyseur.add_argument(\"nom\", choices=recettes_disponibles)", "obligatoire ; une valeur de la liste"),
    ("analyseur.add_argument(\"-p\", \"--personnes\", type=int, default=4)", "option ; convertie en entier ; 4 si absente"),
    ("analyseur.add_argument(\"-u\", \"--unites\", choices=(\"SI\", \"US\"))", "option ; deux valeurs possibles"),
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
