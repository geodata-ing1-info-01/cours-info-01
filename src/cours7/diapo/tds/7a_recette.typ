// TD 7a du projet 7 — « Compléter son projet, par des pull requests », parcours standard.
//
// Inclus par `cours7.typ` ; compilable seul par `outils/compiler_tds.py`. Un
// fichier inclus n'hérite pas des imports de son appelant.
//
// Refait le 30/09/2026 : le TD part du programme du TD 4a (étape B6),
// récupéré depuis GitHub, et lui ajoute la page HTML d'une recette (le texte
// complété par le tableau, puis pandoc), puis toutes les recettes et un
// sommaire ; deux pull requests. Pas de numpy au parcours standard.
// Corrigés et guide écrits par `data/cours7/generer_projet7.py` ; la page
// et le sommaire dessinés par `../schemas.typ`, d'après la sortie réelle.
#import "../../../commun/prelude.typ": *
#import "../../../cours3/diapo/schemas.typ": attendu-pistes, sortie
#import "../schemas.typ": page-recette, sommaire-recettes

#let td = (
  numero: "7a",
  titre: "Compléter son projet, par des pull requests",
  annonce: "Parcours standard. TD d'application : récupérer son projet du projet 4 depuis GitHub, lui ajouter l'écriture des pages HTML des recettes et d'un sommaire, sur des branches livrées par des pull requests",
  dossier: "cours7/7a_recette/",
  duree: "85′",
)
#separateur-td(..td)

// --------------------------------------------
#d("Ce que le programme écrira à la fin du TD")[
  #annonce[
    Aujourd'hui, `recette.py` écrit les quantités d'une recette dans un
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
    Le dépôt de chaque élève est celui du cours 6. Sinon, le dépôt de
    référence `recette` (l'état B7 du TD 4a), cloné puis poussé vers un
    dépôt vide de l'élève : guide, étape D0, cas B.
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
#d("Étape D0 · Récupérer le projet")[
  #annonce[
    Objectif : retrouver sur le poste le projet publié au cours 6, et le
    faire tourner.
  ]

  #attendu-pistes(
    (
      [le dépôt `recette` dans `travail/`],
      [`python recette.py crepes -p 6` écrit `sortie/crepes_6_SI.csv`],
      [`git log --oneline` affiche l'historique du projet 4],
    ),
    (
      [cloner son dépôt : `git clone git@github.com:<compte>/recette.git`],
      [sans dépôt utilisable : cloner le dépôt de référence, puis `git remote set-url`],
      [donner son nom et son adresse pour ce dépôt : `git config user.name`, `user.email`],
    ),
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
    Markdown, et le tableau des quantités, calculé par le programme. La
    section `## Ingrédients` du texte est vide : le programme y met le
    tableau.
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
#d("Étape D1 · Écrire le texte complété")[
  #annonce[
    Objectif : écrire `sortie/crepes.md`, le texte de la recette avec le
    tableau des quantités à la place de la section vide.
  ]

  #attendu-pistes(
    (
      [`python recette.py crepes -p 6 --page` écrit `sortie/crepes.md`, avec le tableau pour 6 personnes],
      [un commit sur la branche `page`],
    ),
    (
      [créer la branche `page` ; copier les `.md` des recettes et `style.css`],
      [écrire `tableau(ingredients)` : une ligne Markdown par ingrédient],
      [écrire `ecrire_markdown` : remplacer `## Ingrédients` par un titre et le tableau (`replace`), puis écrire le résultat],
      [ajouter l'option `--page`, qui appelle `ecrire_markdown`],
    ),
  )

  #legende[
    Guide, étape D1.1.
  ]
]

// --------------------------------------------
#d("Étape D1 · La page HTML, par pandoc")[
  #annonce[
    Objectif : convertir le texte complété en page HTML, avec la feuille de
    style, pour l'ouvrir dans un navigateur.
  ]

  #attendu-pistes(
    (
      [`python recette.py crepes -p 6 --page` écrit aussi `sortie/crepes.html`],
      [`start sortie/crepes.html` ouvre la page de la première diapositive du TD],
      [un commit],
    ),
    (
      [écrire `ecrire_page(markdown)` : copier `style.css`, puis lancer pandoc par `subprocess.run` (cours 3)],
      [la page : le même chemin, avec l'extension `.html` (`with_suffix`)],
      [appeler `ecrire_page` après `ecrire_markdown`],
    ),
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
#d("Étape D2 · La pull request")[
  #annonce[
    Objectif : proposer la branche `page` sur GitHub, la fusionner dans
    `master`, puis ramener le résultat sur le poste.
  ]

  #attendu-pistes(
    (
      [la pull request de `page`, fusionnée sur GitHub],
      [`git log --oneline --graph` montre le commit `Merge pull request #1`],
    ),
    (
      [envoyer la branche : `git push -u origin page`],
      [sur le site : Compare & pull request, puis Merge pull request],
      [ramener `master` sur le poste : `git checkout master`, `git pull`],
    ),
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

  #attendu-pistes(
    (
      [dix recettes dans `recettes/` : dix `.csv` et dix `.md`],
      [`noms_des_recettes()` renvoie `['cookies', 'crepes', …, 'tarte_pommes']`],
    ),
    (
      [créer la branche `livre` ; copier les six recettes de plus],
      [les fichiers `.csv` de `recettes/` : `DONNEES.glob("*.csv")`],
      [le nom d'un fichier sans son extension : `stem` (`crepes.csv` donne `crepes`)],
      [ajouter chaque nom à une liste, dans l'ordre (`sorted`), et la renvoyer],
    ),
  )

  #legende[
    Guide, étape D3.1.
  ]
]

// --------------------------------------------
#d("Étape D3 · Le programme, pour chaque nom")[
  #annonce[
    Objectif : répéter les lignes du programme pour chaque recette de la
    liste, avec `--toutes`, ou pour la seule recette nommée.
  ]

  #attendu-pistes(
    (
      [`python recette.py --toutes --page` écrit les dix pages],
      [`python recette.py crepes --page` écrit toujours la seule page des crêpes],
      [un commit sur la branche `livre`],
    ),
    (
      [rendre le nom facultatif : `nargs="?"` ; ajouter l'option `--toutes`],
      [construire la liste `noms` : tous les noms avec `--toutes`, sinon `[options.nom]`],
      [placer les lignes du programme dans `for nom in noms:` : les sélectionner, puis `Tab`],
      [dans ces lignes, remplacer `NOM` par `nom`],
    ),
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
    Objectif : une page qui mène à toutes les autres, puis la seconde pull
    request.
  ]

  #grid(
    columns: (1.5fr, 1fr), column-gutter: 20pt, align: top,
    attendu-pistes(
      (
        [`sortie/index.html` affiche un lien par recette],
        [la branche `livre` fusionnée sur GitHub],
      ),
      (
        [écrire `sortie/index.md` : un titre, puis un lien par recette, `- [Crêpes](crepes.html)`],
        [le texte du lien : la première ligne du fichier `.md` de la recette],
        [convertir par `ecrire_page`, comme une recette],
        [un commit, puis la pull request de `livre`],
      ),
    ),
    sommaire-recettes(largeur: 5.6cm),
  )

  #legende[
    Guide, étape D4. En bonus, l'étape D5 publie les pages avec GitHub
    Pages.
  ]

  #reponse(legende[
    Constaté : les liens sont relatifs ; le sommaire et les pages
    fonctionnent tant qu'ils sont dans le même dossier.
  ])
]
