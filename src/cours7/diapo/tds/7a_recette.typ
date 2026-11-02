// TD 7a du projet 7 — « Compléter un projet GitHub, par des pull requests », parcours standard.
//
// Inclus par `cours7.typ` ; compilable seul par `outils/compiler_tds.py`. Un
// fichier inclus n'hérite pas des imports de son appelant.
//
// Refait le 30/09/2026 : le TD part du dépôt de référence `td7a-recette`, le
// corrigé du TD 4a (programme de l'étape B6), que chaque élève copie sur son
// compte depuis le 02/11/2026, et lui ajoute la page HTML d'une recette (le texte
// complété par le tableau, puis pandoc), puis toutes les recettes et un
// sommaire ; deux pull requests. Pas de numpy au parcours standard.
// Corrigés et guide écrits par `data/cours7/generer_projet7.py` ; la page
// et le sommaire dessinés par `../schemas.typ`, d'après la sortie réelle.
#import "../../../commun/prelude.typ": *
#import "../../../cours3/diapo/schemas.typ": sortie
#import "../schemas.typ": page-recette, sommaire-recettes
#import "../../../cours1_v2/diapo/schemas.typ": consignes, comment, commandes

#let td = (
  numero: "7a",
  titre: "Compléter un projet GitHub, par des pull requests",
  annonce: "TD d'application : partir du dépôt GitHub du corrigé du TD 4a, ajouter à son programme l'écriture des pages HTML des recettes et d'un sommaire, sur des branches livrées par des pull requests",
  dossier: "cours7/7a_recette/",
  duree: "85′",
  statut: "parcours standard",
)
#separateur-td(..td)

// --------------------------------------------
#d("Ce que le programme écrira à la fin du TD")[
  #annonce[
    Au départ, `recette.py` écrit les quantités d'une recette dans un
    fichier CSV. À la fin du TD, il écrit aussi une page HTML par recette,
    avec son texte et le tableau des quantités, et un sommaire.
  ]

  #align(center, grid(
    columns: 2, column-gutter: 30pt, align: top,
    page-recette(largeur: 10.5cm), sommaire-recettes(largeur: 7.5cm),
  ))

  #legende[
    `python recette.py --toutes --page` : les dix pages et le sommaire, dans
    `sortie/`.
  ]
]

// --------------------------------------------
#d("Le guide et le matériel de départ")[
  #annonce[
    Le guide du TD détaille chaque étape : commandes, code et vérifications.
    Les diapositives suivantes en sont le résumé.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Fichier], [Emplacement], [Usage],
    [`guide_7a_recette.pdf`, `.html`, `guide.ipynb`], [`cours7/7a_recette/`], [le détail des étapes, le code à copier],
    [`recettes/*.md`], [`depart/`], [le texte de chaque recette, en Markdown, à copier dans le projet],
    [`recettes/*.csv`], [`depart/`], [six recettes de plus, pour 4 personnes],
    [`style.css`], [`depart/`], [la feuille de style des pages],
  )

  #notes[
    Tous partent du dépôt de référence `td7a-recette` (l'état B7 du TD 4a),
    cloné puis poussé vers un dépôt vide `td7a-recette` de l'élève : guide,
    étape D0. Le dépôt `recette` du cours 6 ne sert pas : ses numéros de
    ligne ne correspondent pas à ceux du guide.
  ]
]

// --------------------------------------------
#d("Les étapes du TD")[
  #annonce[
    Deux fonctionnalités, chacune sur sa branche, livrée par une pull
    request : la page d'une recette, puis toutes les pages et le sommaire.
  ]

  #tableau(
    columns: (auto, 1.3fr, 1fr),
    align: (center + horizon, left + horizon, left + horizon),
    [Étape], [Objectif], [Résultat],
    [D0], [récupérer le projet et le relancer], [`sortie/crepes_6_SI.csv`],
    [D1], [compléter le texte de la recette par le tableau, puis le convertir par pandoc], [`sortie/crepes.md`, puis `sortie/crepes.html`],
    [D2], [proposer la branche `page` par une pull request], [la branche fusionnée sur GitHub],
    [D3], [écrire les pages de toutes les recettes en une commande], [dix pages],
    [D4], [écrire une page qui relie les autres ; seconde pull request], [`sortie/index.html`],
  )

  #notes[
    Bonus, étape D5 : les pages publiées avec GitHub Pages.
  ]
]

// --------------------------------------------
#d("Aide-mémoire : une branche, une pull request")[
  #annonce[
    Rappel du cours 6, pour les étapes D1 à D4. Chaque fonctionnalité se
    développe sur une branche, puis arrive sur `master` par une pull
    request.
  ]

  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [`git checkout -b page`], [crée la branche et s'y place],
    [`git commit -am "…"`], [enregistre les fichiers suivis et modifiés],
    [`git push -u origin page`], [envoie la branche sur GitHub],
    [Compare & pull request, Create pull request], [sur le site : la demande de fusion],
    [Merge pull request, Confirm merge], [sur le site : la branche fusionnée dans `master`],
    [`git checkout master`, `git pull`], [ramène sur le poste le `master` de GitHub],
  )
]

// --------------------------------------------
// Consignes numérotées depuis le 02/11/2026, comme au cours 1 v2 : la
// liste « Attendu, Pistes » se lisait mal. L'étape tient sur deux
// diapositives.
#d("Étape D0 · Copie du dépôt de départ")[
  #annonce[
    Objectif : copier le dépôt de départ du module sur son compte GitHub et
    sur le poste.
  ]

  #consignes(
    taille: 16pt,
    [Sur son compte GitHub, créer un dépôt vide nommé `td7a-recette`.
      #comment[Bouton New repository, sans cocher « Add a README file ».]],
    [Dans le terminal Git Bash ouvert dans `cours7/7a_recette/`, cloner le dépôt de départ du module dans `travail/recette/` :
      #commandes("cd travail", "git clone git@github.com:geodata-ing1-info-01/td7a-recette.git recette", "cd recette")],
    [Envoyer le dépôt cloné vers son dépôt `td7a-recette`, en remplaçant `<compte>` par son nom de compte GitHub :
      #commandes("git remote set-url origin git@github.com:<compte>/td7a-recette.git", "git push -u origin master")],
    [Sur la page GitHub de son dépôt, vérifier que `recette.py` et les commits du TD 4a y sont.],
  )

  #legende[
    Guide, étape D0.
  ]
]

// --------------------------------------------
#d("Étape D0 · Lancement du programme")[
  #annonce[
    Objectif : faire tourner le programme du dépôt cloné, dans
    `travail/recette/`.
  ]

  #consignes(
    taille: 16pt,
    [Donner son nom et son adresse pour ce dépôt :
      #commandes("git config user.name \"Prénom Nom\"", "git config user.email \"prenom.nom@exemple.fr\"")],
    [Lancer le programme : `python recette.py crepes -p 6`. Il affiche les ingrédients pour 6 personnes et écrit `sortie/crepes_6_SI.csv`.],
  )

  #legende[
    Guide, étape D0.
  ]

  #reponse(legende[
    Constaté : le clone contient le code et tout son historique ; `sortie/`
    n'y est pas, le programme le refait.
  ])
]

// --------------------------------------------
#d("Étape D1 · Le texte complété par le tableau")[
  #annonce[
    La page d'une recette réunit son texte, écrit à la main dans un fichier
    Markdown, et le tableau des quantités, que `recette.py` calcule déjà.
    L'étape D1 modifie le programme pour qu'il écrive ce tableau dans la
    section `## Ingrédients`, vide dans le texte.
  ]

  #face-a-face(
    panneau("recettes/crepes.md : le texte, section vide")[
      #sortie("# Crêpes\n\n*10 minutes de préparation, …*\n\n## Ingrédients\n\n## Préparation\n\n1. Mélanger la farine et le sel …", taille: 11pt)
    ],
    panneau("sortie/crepes.md : le tableau à sa place")[
      #sortie("## Ingrédients pour 6 personnes, en unités SI\n\n| Ingrédient | Quantité |\n|---|---|\n| Farine | 375.0 g |\n| Lait | 750.0 ml |\n…\n\n## Préparation", taille: 11pt)
    ],
  )
]

// --------------------------------------------
// Vue d'ensemble de D1 (02/11/2026) : les cinq modifications du programme,
// dans l'ordre ; les trois diapositives suivantes en reprennent les numéros.
#d("Étape D1 · Les modifications du programme")[
  #annonce[
    Objectif : modifier `recette.py` pour qu'il écrive aussi la page HTML de
    la recette, quand la commande porte une nouvelle option, `--page`.
  ]

  #consignes(
    taille: 16pt,
    [Ajouter au projet le texte des recettes, un fichier Markdown par recette dans `recettes/`, dont la section `## Ingrédients` est vide.],
    [Écrire une fonction, `tableau`, qui convertit la liste des ingrédients en tableau Markdown.],
    [Écrire une fonction, `ecrire_markdown`, qui place ce tableau dans le texte de la recette et écrit le résultat dans `sortie/`.],
    [Modifier le programme principal pour qu'il écrive ce texte complété, seulement avec l'option #box[`--page`] :
      #commandes("python recette.py crepes -p 6 --page")],
    [Convertir le texte complété en page HTML avec pandoc : une fonction, `ecrire_page`.],
  )

  #legende[
    Sur une branche `page`. Modifications 1 à 4 : guide, étape D1.1, puis
    un commit. Modification 5 : guide, étape D1.2, puis un commit.
  ]
]

// --------------------------------------------
// Les données que transforment `tableau` et `ecrire_markdown` (02/11/2026),
// avant les consignes de code : sorties réelles du programme, crêpes pour 6
// personnes en unités SI (guide, étape D1.1).
#let appel(..lignes) = align(horizon + center, stack(
  spacing: 6pt,
  ..lignes.pos().map(l => text(size: 15pt, raw(l))),
  text(size: 26pt, fill: accent)[→],
))

#d("Étape D1 · Des ingrédients au tableau Markdown")[
  #annonce[
    Dans le programme, les ingrédients sont une liste de tuples : nom,
    quantité, unité. L'appel `tableau(ingredients)` renvoie leur tableau
    Markdown, une ligne par ingrédient.
  ]

  #grid(
    columns: (1fr, auto, 1fr), column-gutter: 14pt, align: (top, horizon, top),
    panneau("ingredients : une liste de tuples")[
      #sortie("[(\"Farine\", 375.0, \"g\"),\n (\"Lait\", 750.0, \"ml\"),\n (\"Œufs\", 6.0, \"\"),\n (\"Sel\", 3.0, \"g\"),\n (\"Beurre fondu\", 75.0, \"g\")]", taille: 11pt)
    ],
    appel("tableau(ingredients)"),
    panneau("le tableau Markdown renvoyé")[
      #sortie("| Ingrédient | Quantité |\n|---|---|\n| Farine | 375.0 g |\n| Lait | 750.0 ml |\n| Œufs | 6.0  |\n| Sel | 3.0 g |\n| Beurre fondu | 75.0 g |", taille: 11pt)
    ],
  )

  #legende[
    Les crêpes, pour 6 personnes en unités SI. Guide, étape D1.1.
  ]
]

// --------------------------------------------
#d("Étape D1 · De la recette au texte complété")[
  #annonce[
    L'appel `ecrire_markdown("crepes", 6, "SI", ingredients)` lit le texte de
    la recette, remplace sa ligne `## Ingrédients` par un titre suivi du
    tableau, puis écrit le résultat dans `sortie/`.
  ]

  #grid(
    columns: (1fr, auto, 1fr), column-gutter: 14pt, align: (top, horizon, top),
    stack(
      spacing: 10pt,
      panneau("recettes/crepes.md : le texte")[
        #sortie("# Crêpes\n…\n## Ingrédients\n\n## Préparation", taille: 10pt)
      ],
      panneau("tableau(ingredients)")[
        #sortie("| Ingrédient | Quantité |\n|---|---|\n| Farine | 375.0 g |\n…", taille: 10pt)
      ],
    ),
    appel("ecrire_markdown(", "\"crepes\", 6, \"SI\",", "ingredients)"),
    panneau("sortie/crepes.md : le texte complété")[
      #sortie("# Crêpes\n…\n## Ingrédients pour 6 personnes, en unités SI\n\n| Ingrédient | Quantité |\n|---|---|\n| Farine | 375.0 g |\n…\n\n## Préparation", taille: 10pt)
    ],
  )
]

// --------------------------------------------
// Étapes D1 à D4 en consignes numérotées depuis le 02/11/2026, comme D0.
#d("Étape D1 · Modifications 1 à 3 : texte et tableau")[
  #annonce[
    Objectif : ajouter au projet le texte des recettes, et à `recette.py`
    les deux fonctions qui le complètent par le tableau des quantités.
  ]

  #consignes(
    taille: 16pt,
    [Créer la branche `page` : `git checkout -b page`.],
    [Copier dans `recettes/` le texte des quatre recettes qui ont déjà leur fichier CSV :
      #commandes("cp ../../depart/recettes/crepes.md ../../depart/recettes/pate_pizza.md recettes/", "cp ../../depart/recettes/mousse_chocolat.md ../../depart/recettes/cookies.md recettes/")],
    [Dans `recette.py`, avant le programme principal, ajouter une fonction `tableau(ingredients)`, qui renvoie le tableau Markdown des ingrédients, une ligne par ingrédient.],
    [Ajouter une fonction `ecrire_markdown(nom, personnes, unites, ingredients)`, qui lit le fichier de la recette, `recettes/<nom>.md`, remplace `## Ingrédients` par un titre suivi du tableau (`replace`), puis écrit le texte obtenu dans `sortie/`.],
  )

  #legende[
    Guide, étape D1.1.
  ]
]

// --------------------------------------------
#d("Étape D1 · Modification 4 : l'option --page")[
  #annonce[
    Objectif : écrire le texte complété quand la commande porte l'option
    `--page`.
  ]

  #consignes(
    taille: 16pt,
    [Ajouter l'option `--page` à l'analyseur de la ligne de commande.],
    [À la fin du programme, appeler `ecrire_markdown` quand l'option `--page` est donnée.],
    [Lancer `python recette.py crepes -p 6 --page`, puis ouvrir `sortie/crepes.md` : le tableau pour 6 personnes y remplace la section vide.],
    [Enregistrer un commit :
      #commandes("git add recettes", "git commit -am \"Le texte de la recette, complété par le tableau des ingrédients\"")],
  )

  #legende[
    Guide, étape D1.1.
  ]
]

// --------------------------------------------
#d("Étape D1 · Modification 5 : générer la page HTML en appelant pandoc")[
  #annonce[
    Objectif : convertir le texte complété en page HTML, avec la feuille de
    style.
  ]

  #consignes(
    taille: 16pt,
    [Copier la feuille de style dans le projet : `cp ../../depart/style.css .`],
    [Dans `recette.py`, ajouter `import shutil` et `import subprocess`, puis la constante `STYLE = RACINE / "style.css"` sous `SORTIE`.],
    [Ajouter une fonction `ecrire_page(markdown)` : elle copie `style.css` dans `sortie/`, puis lance pandoc par `subprocess.run` (cours 3). La page a le même chemin que le texte, avec l'extension `.html` (`with_suffix`).],
    [À la fin du programme, appeler `ecrire_page` après `ecrire_markdown`.],
    [Lancer `python recette.py crepes -p 6 --page`, puis `start sortie/crepes.html` : la page de la première diapositive du TD.],
    [Enregistrer un commit :
      #commandes("git add style.css", "git commit -am \"La page HTML de la recette, par pandoc\"")],
  )

  #legende[
    Guide, étape D1.2.
  ]

  #reponse(legende[
    Constaté : la page reprend le texte tel quel ; seul le tableau vient du
    programme.
  ])

  #notes[
    `pagetitle` : le titre de l'onglet du navigateur ; le titre de la page
    reste celui du fichier Markdown.
  ]
]

// --------------------------------------------
#d("Étape D2 · Soumettre les modifications avec une pull request")[
  #annonce[
    Objectif : proposer la branche `page` sur GitHub, la fusionner dans
    `master`, puis ramener le résultat sur le poste.
  ]

  #consignes(
    taille: 16pt,
    [Envoyer la branche sur GitHub : `git push -u origin page`.],
    [Sur la page GitHub du dépôt, cliquer sur Compare & pull request, puis sur Create pull request.],
    [Sur la page de la pull request, cliquer sur Merge pull request, puis sur Confirm merge.],
    [Sur le poste, revenir sur `master` et y ramener la fusion :
      #commandes("git checkout master", "git pull")],
    [Vérifier que `git log --oneline --graph` montre le commit `Merge pull request #1`.],
  )

  #legende[
    Guide, étape D2.
  ]

  #reponse(legende[
    Constaté : après la fusion sur GitHub, le `master` du poste est en
    retard d'un commit jusqu'au `git pull`.
  ])
]

// --------------------------------------------
#d("Étape D3 · La liste des noms des recettes")[
  #annonce[
    Objectif : écrire la page de chaque recette en une commande, `--toutes`.
    Le programme a d'abord besoin de la liste des noms des recettes.
  ]

  #consignes(
    taille: 16pt,
    [Créer la branche `livre`, puis y copier les six recettes de plus :
      #commandes("git checkout -b livre", "cp ../../depart/recettes/*.csv ../../depart/recettes/*.md recettes/")],
    [Vérifier que `ls recettes` liste dix fichiers `.csv` et dix fichiers `.md`.],
    [Dans `recette.py`, ajouter une fonction `noms_des_recettes()`. Pour chaque fichier `.csv` de `recettes/`, pris dans l'ordre (`sorted(DONNEES.glob("*.csv"))`), elle ajoute à une liste son nom sans l'extension (`stem`), puis renvoie la liste.],
  )

  #legende[
    Guide, étape D3.1. La fonction renvoie `['cookies', 'crepes', …, 'tarte_pommes']`.
  ]
]

// --------------------------------------------
#d("Étape D3 · Le programme, pour chaque nom")[
  #annonce[
    Objectif : répéter les lignes du programme pour chaque recette de la
    liste, avec `--toutes`, ou pour la seule recette nommée.
  ]

  #consignes(
    taille: 16pt,
    [Rendre le nom de la recette facultatif (`nargs="?"`), et ajouter l'option `--toutes`.],
    [Construire la liste `noms` : tous les noms avec `--toutes`, sinon `[options.nom]`. Sans l'un ni l'autre, arrêter le programme par `analyseur.error`.],
    [Sélectionner les lignes de `ingredients = lire_ingredients(…)` jusqu'à la fin du fichier, appuyer sur `Tab`, puis écrire au-dessus `for nom in noms:`.],
    [Dans ces lignes, remplacer `NOM` par `nom`.],
    [Lancer `python recette.py --toutes --page` : il écrit les dix pages. `python recette.py crepes --page` écrit toujours la seule page des crêpes.],
    [Enregistrer un commit :
      #commandes("git add recettes", "git commit -am \"Toutes les recettes\"")],
  )

  #legende[
    Guide, étape D3.2.
  ]

  #reponse(legende[
    Constaté : sans nom ni `--toutes`, `analyseur.error` arrête le programme
    avec un message.
  ])

  #notes[
    Erreur fréquente : `NOM` laissé dans la boucle au lieu de `nom` ; la
    même recette est écrite dix fois.
  ]
]

// --------------------------------------------
#d("Étape D4 · Le sommaire")[
  #annonce[
    Objectif : une page qui mène à toutes les autres.
  ]

  #grid(
    columns: (1.6fr, 1fr), column-gutter: 20pt, align: top,
    consignes(
      taille: 16pt,
      [Dans `recette.py`, ajouter une fonction `ecrire_sommaire(noms)`. Elle écrit `sortie/index.md` : un titre, puis un lien par recette, `- [Crêpes](crepes.html)`. Elle le convertit ensuite par `ecrire_page`.],
      [Pour le texte de chaque lien, prendre la première ligne du fichier `.md` de la recette, sans le `# `.],
      [À la fin du programme, après la boucle, appeler `ecrire_sommaire(noms)` quand `--page` et `--toutes` sont donnés.],
      [Lancer `python recette.py --toutes --page`, puis `start sortie/index.html` : chaque lien ouvre une page.],
    ),
    sommaire-recettes(largeur: 5.6cm),
  )

  #legende[
    Guide, étape D4.
  ]

  #reponse(legende[
    Constaté : les liens sont relatifs ; le sommaire et les pages
    fonctionnent tant qu'ils sont dans le même dossier.
  ])
]

// --------------------------------------------
#d("Étape D4 · La seconde pull request")[
  #annonce[
    Objectif : livrer la branche `livre` sur GitHub, comme la branche `page`
    à l'étape D2.
  ]

  #consignes(
    taille: 16pt,
    [Enregistrer un commit, puis envoyer la branche sur GitHub :
      #commandes("git commit -am \"Le sommaire\"", "git push -u origin livre")],
    [Sur GitHub, ouvrir la pull request de `livre`, puis la fusionner : Compare & pull request, Create pull request, Merge pull request, Confirm merge.],
    [Sur le poste, revenir sur `master` et y ramener la fusion :
      #commandes("git checkout master", "git pull")],
  )

  #legende[
    Guide, étape D4. En bonus, l'étape D5 publie les pages avec GitHub
    Pages.
  ]
]
