// TD 7b du projet 7 — « Reprendre et compléter le projet d'un autre » (la fenêtre du train), parcours avancé.
//
// Inclus par `cours7.typ` ; compilable seul par `outils/compiler_tds.py`. Un
// fichier inclus n'hérite pas des imports de son appelant.
//
// Refait le 30/09/2026 : le TD part du dépôt de référence `train` (deux plans
// qui défilent, sans la fenêtre), le fait tourner, le lit, puis lui ajoute
// deux effets du clip « Moon », la fenêtre du train et les ombres des
// poteaux (numpy), sur deux branches parties du même commit ; la seconde pull
// request s'arrête sur un conflit. Les images des effets sont calculées par
// les programmes du TD (`data/cours7/make_data.py illustrations`). Corrigés,
// dépôt de référence et guide écrits par `data/cours7/generer_projet7.py`.
#import "../../../commun/prelude.typ": *
#import "../../../cours3/diapo/schemas.typ": attendu-pistes, sortie
#import "../schemas.typ": effets-train, couches-depart, effet-fenetre, effet-poteaux

#let td = (
  numero: "7b",
  titre: "Reprendre et compléter le projet d'un autre",
  annonce: "Parcours avancé. TD d'application : récupérer un projet commencé par d'autres, le faire tourner, puis lui ajouter deux effets sur deux branches, dont un calculé avec numpy, et résoudre le conflit de leur fusion",
  dossier: "cours7/7b_train/",
  duree: "100′",
)
#separateur-td(..td)

// --------------------------------------------
#d("Le projet : la vue depuis un train")[
  #annonce[
    Dans la scène de la mer du clip « Moon » de Kid Francescoli, la caméra
    filme la mer depuis un train. Le programme du dépôt `train` fait défiler
    le paysage ; le TD lui ajoute deux effets du clip.
  ]

  #align(center, effets-train(largeur: 5.9cm))

  #legende[
    L'image numéro 3 de la vidéo, calculée par le programme à chaque étape
    du TD. Effet 1 : le cadre de la vitre. Effet 2 : les ombres des poteaux
    de la voie, qui passent très vite.
  ]

  #notes[
    Clip : Kid Francescoli, « Moon », réalisé par Cauboyz (2017), décors en
    carton sur table tournante. Le montrer 20 secondes à partir de la scène
    de la mer, si la salle le permet.
  ]
]

// --------------------------------------------
#d("Deux effets, deux branches")[
  #annonce[
    Chaque effet se développe sur sa branche, partie du même commit, comme
    le feraient deux personnes en même temps. Les deux modifient la même
    fonction : leur réunion s'arrête sur un conflit.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Branche], [L'effet], [Ce qui change dans `train.py`],
    [`fenetre`], [le cadre de la vitre, posé par-dessus le paysage], [une ligne dans la fonction `image`],
    [`poteaux`], [des bandes sombres qui traversent l'image très vite], [une fonction `ecrire_poteaux` (numpy) et deux lignes dans `image`, au même endroit],
  )

  #legende[
    Chaque branche arrive sur `master` par une pull request. La seconde
    s'arrête sur un conflit, que l'on résout sur le poste.
  ]
]

// --------------------------------------------
#d("Le guide et le dépôt de départ")[
  #annonce[
    Le guide du TD détaille chaque étape. Le projet se récupère sur GitHub :
    le dossier du TD ne contient que le guide.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Fichier], [Emplacement], [Usage],
    [`guide_7b_train.pdf`, `.html`, `guide.ipynb`], [`cours7/7b_train/`], [le détail des étapes, le code à copier],
    [le dépôt `train`], [sur GitHub, compte du module], [`train.py`, `decor/`, `environment.yml`, un README],
  )

  #notes[
    Le nom du compte GitHub du module est à donner en début de séance. Le
    dépôt de référence est écrit par `generer_projet7.py --depots`.
  ]
]

// --------------------------------------------
#d("Les étapes du TD")[
  #annonce[
    Récupérer le projet, le comprendre, puis lui ajouter les deux effets,
    chacun par une pull request.
  ]

  #tableau(
    columns: (auto, 1.3fr, 1fr),
    align: (center + horizon, left + horizon, left + horizon),
    [Étape], [Objectif], [Résultat],
    [E0], [récupérer un projet et son environnement, le faire tourner], [`sortie/train.mp4` : le paysage qui défile],
    [E1], [comprendre comment le programme compose une image], [trois réponses],
    [E2], [effet 1, la fenêtre du train, sur la branche `fenetre`], [la fenêtre sur `master`],
    [E3], [effet 2, les ombres des poteaux, avec numpy ; le conflit des deux branches], [les deux effets sur `master`],
  )

  #notes[
    Bonus, étape E4 : un troisième plan, une ligne de plus dans
    `decor/plans.csv`.
  ]
]

// --------------------------------------------
#d("Étape E0 · Récupérer le projet et son environnement")[
  #annonce[
    Objectif : faire tourner un projet récupéré, avec l'environnement que
    décrit son dépôt.
  ]

  #attendu-pistes(
    (
      [le dépôt `train` dans `travail/`, poussé vers votre compte],
      [l'environnement `train`, actif],
      [`python train.py --images 48 --video` écrit `sortie/train.mp4` : les voiles et la plage défilent],
    ),
    (
      [cloner le dépôt du module, puis le diriger vers le sien : `git clone`, `git remote set-url origin`],
      [régler la fusion de `git pull` : `git config pull.rebase false`],
      [créer et activer l'environnement : `conda env create -f environment.yml`, `conda activate train`],
    ),
  )

  #legende[
    Guide, étape E0. La création de l'environnement dure plusieurs minutes :
    lire le README pendant ce temps.
  ]

  #reponse(legende[
    Constaté : la plage, deux fois plus rapide que les voiles, paraît plus
    proche.
  ])
]

// --------------------------------------------
#d("Étape E1 · Une image, couche par couche")[
  #annonce[
    Chaque image de la vidéo superpose des couches : le fond, puis chaque
    plan de `decor/plans.csv`, décalé de numéro × vitesse colonnes. Le
    damier marque les pixels transparents.
  ]

  #align(center, couches-depart(largeur: 4.9cm))

  #legende[
    `magick` pose les couches dans l'ordre de sa commande. Les deux effets
    du TD sont deux couches de plus.
  ]
]

// --------------------------------------------
#d("Étape E1 · Lire le code")[
  #annonce[
    Objectif : trouver dans `train.py` où les couches sont posées, avant de
    le modifier.
  ]

  #attendu-pistes(
    (
      [la ligne qui ajoute un plan à la commande, et combien de fois elle s'exécute],
      [le décalage des voiles à l'image 10],
      [l'effet d'un échange des lignes de `plans.csv`],
    ),
    (
      [lire `decor/plans.csv` : un plan par ligne, du plus lointain au plus proche],
      [lire la fonction `image` et sa boucle `for`],
      [échanger les deux lignes, lancer `python train.py --numero 40`, puis `git restore decor/plans.csv`],
    ),
  )

  #legende[
    Guide, étape E1 ; les réponses sont à la fin du guide.
  ]

  #reponse(legende[
    Constaté : le plan posé en dernier passe devant les autres.
  ])
]

// --------------------------------------------
#d("Étape E2 · Effet 1, la fenêtre du train")[
  #annonce[
    La fenêtre, `decor/fenetre.png`, est déjà dans le dépôt : noire sur le
    cadre, transparente sur la vitre. Posée en dernière couche, elle laisse
    voir le paysage par la vitre.
  ]

  #align(center, effet-fenetre(largeur: 6.6cm))
]

// --------------------------------------------
#d("Étape E2 · La fenêtre, sur la branche fenetre")[
  #annonce[
    Objectif : ajouter l'effet sur sa propre branche, pendant que la branche
    du second effet attend.
  ]

  #attendu-pistes(
    (
      [deux branches, `fenetre` et `poteaux`, sur le même commit],
      [`python train.py --numero 40` : le paysage derrière la vitre],
      [la pull request de `fenetre`, fusionnée sur GitHub],
    ),
    (
      [créer les deux branches : `git branch fenetre`, `git branch poteaux`],
      [se placer sur `fenetre` : `git checkout fenetre`],
      [dans `image`, après la boucle des plans, ajouter `decor/fenetre.png` et `-composite` à la commande],
      [le commit, le `push`, la pull request, la fusion sur GitHub],
    ),
  )

  #legende[
    Guide, étape E2.
  ]

  #reponse(legende[
    Constaté : `git branch <nom>` crée la branche sans s'y placer ; l'étoile
    reste sur `master`.
  ])
]

// --------------------------------------------
#d("Étape E3 · Effet 2, les ombres des poteaux")[
  #annonce[
    Les ombres sont un calque : une image de 640 × 480 pixels, sombre sur
    des bandes verticales, transparente ailleurs. Le programme le calcule
    avec numpy pour chaque image ; les bandes avancent de 90 pixels par image.
  ]

  #align(center, effet-poteaux(largeur: 6.6cm))
]

// --------------------------------------------
#d("Étape E3 · Le calque, avec numpy")[
  #annonce[
    Objectif : calculer une image avec numpy, puis la poser comme une couche
    de plus.
  ]

  #attendu-pistes(
    (
      [`python train.py --numero 3` : deux bandes sombres sur le paysage],
      [`python train.py --images 48 --video` : les bandes passent vite vers la gauche],
      [un commit sur la branche `poteaux`],
    ),
    (
      [se placer sur `poteaux` : la fenêtre n'y est pas encore],
      [dans `ecrire_poteaux`, un tableau de zéros : `np.zeros((480, 640, 4), dtype=np.uint8)`],
      [les colonnes des bandes : `(np.arange(640) + 90 * numero) % 400 < 24` ; leur opacité à 110],
      [enregistrer le calque (Pillow), puis le poser dans `image`, après la boucle des plans],
    ),
  )

  #legende[
    Guide, étape E3.1. Les deux diapositives sur numpy, avant le TD,
    expliquent le tableau et le masque.
  ]
]

// --------------------------------------------
#d("Étape E3 · La pull request et le conflit")[
  #annonce[
    Objectif : réunir deux branches qui ont modifié la même ligne du
    programme.
  ]

  #grid(
    columns: (1.25fr, 1fr), column-gutter: 20pt, align: top,
    attendu-pistes(
      (
        [les deux effets sur `master` : la vidéo de la dernière image de la première diapositive],
        [la pull request de `poteaux`, fusionnée après le conflit],
      ),
      (
        [pousser `poteaux`, ouvrir la pull request : « This branch has conflicts »],
        [ramener `master` dans la branche, sur le poste : `git pull origin master`],
        [garder les deux versions : les poteaux, puis la fenêtre],
        [`git add`, `git commit --no-edit`, `git push`, puis la fusion sur GitHub],
      ),
    ),
    panneau("Le conflit, dans image")[
      #sortie("<<<<<<< HEAD\n    ecrire_poteaux(POTEAUX, numero)\n    commande = commande + [str(POTEAUX),\n                           \"-composite\"]\n=======\n    commande = commande + [str(DECOR /\n        \"fenetre.png\"), \"-composite\"]\n>>>>>>> …", taille: 10pt)
    ],
  )

  #legende[
    Guide, étapes E3.2 et E3.3.
  ]

  #reponse(legende[
    Constaté : git réunit seul les lignes modifiées ailleurs ; il s'arrête
    sur les lignes que les deux branches ont changées au même endroit.
  ])

  #notes[
    L'ordre des couches suit la profondeur : le paysage, les poteaux dehors,
    puis la fenêtre. Avec ce cadre noir, l'autre ordre donne presque la même
    image : les ombres noires ne se voient pas sur le cadre.
  ]
]
