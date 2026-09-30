// Séance 7, projet d'application 2 : un projet récupéré sur GitHub, complété, livré par des pull requests.
//
// Refait le 30/09/2026 (`syllabus/cours/7_projet_effets/refonte_30-09.md`) :
// chaque TD part d'un dépôt git récupéré sur GitHub (cours 6), le complète
// sur des branches, et livre chaque branche par une pull request.
//
//   - parcours standard : TD 7a, la recette en pages (le programme du
//     projet 4, sa page HTML par pandoc, toutes les recettes, un sommaire) ;
//   - parcours avancé : TD 7b, la fenêtre du train (un projet récupéré, la
//     fenêtre et les ombres des poteaux sur deux branches, numpy, un
//     conflit), précédé de deux diapositives sur numpy.
//
// Le TD 4c du projet 4 et les TD 7a et 7b d'avant le 30/09/2026 sont dans
// l'historique git ; le 4c reste en proposition (`propositions/`).
//
//   python outils/compiler_diapos.py --cours 7
//   python outils/compiler_diapos.py --cours 7 --notes
//   python outils/compiler_diapos.py --cours 7 --sans-tds

#import "../../commun/prelude.typ": *
#import "../../cours3/diapo/schemas.typ": code-commente, sortie

#show: diapos.with(
  titre-court: "Introduction à l'informatique",
  auteur-court: "1re année géomatique",
)

#let tds = sys.inputs.at("tds", default: "") != "false"

#import "tds/7a_recette.typ": td as td-7a
#import "tds/7b_train.typ": td as td-7b

#page-titre(
  titre: "Séance 7 : projet d'application 2",
  sous-titre: "TD d'application des cours 1 à 6 : un projet récupéré sur GitHub, complété sur des branches, livré par des pull requests",
  auteur: "1re année géomatique",
  date: "",
)

// --------------------------------------------
#d("Contenu de la séance")[
  #annonce[
    Un TD d'application des cours 1 à 6, sur un projet récupéré depuis
    GitHub : lui ajouter des fonctionnalités sur des branches, puis livrer
    chaque branche par une pull request, fusionnée sur le site.
  ]

  #tableau(
    columns: (auto, 1fr, auto),
    align: (left + horizon, left + horizon, center + horizon),
    [Parcours], [Ce qu'on fait], [Durée],
    [Tous], [présentation de la séance ; le chemin d'une pull request], [10 min],
    [Standard], [TD 7a : ajouter à son script l'écriture des pages HTML des recettes et d'un sommaire, livrée par deux pull requests], [85 min],
    [Avancé], [exposé : représenter une image par un tableau de nombres, avec numpy], [10 min],
    [], [TD 7b : reprendre un projet commencé par d'autres, lui ajouter deux fonctionnalités sur deux branches, résoudre le conflit de leur fusion], [100 min],
  )

  #notes[
    Le guide de chaque TD, dans son dossier, détaille chaque étape : le
    faire ouvrir dès le début. La clé SSH du cours 6 doit être enregistrée
    sur le compte GitHub de chaque élève.
  ]
]

// --------------------------------------------
#d("Deux parcours")[
  #annonce[
    Chaque élève garde son parcours. Les deux TD partent d'un dépôt GitHub.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Parcours standard], [Parcours avancé],
    [Le projet], [`recette`, le dépôt du projet 4 publié au cours 6], [`train`, un dépôt du module, commencé par d'autres],
    [Ce qu'on ajoute], [l'écriture des pages HTML des recettes et d'un sommaire], [la fenêtre du train, les ombres des poteaux (numpy)],
    [Dossier], [`cours7/7a_recette/`], [`cours7/7b_train/`],
  )

  #legende[
    Sans dépôt utilisable du projet 4, le TD 7a part du dépôt de référence
    `recette`, cloné puis poussé vers un dépôt vide de son compte.
  ]
]

// --------------------------------------------
#d("Une fonctionnalité, une pull request")[
  #annonce[
    Une fonctionnalité se développe sur une branche. La pull request
    demande sa fusion dans `master`, sur le site ; le poste récupère ensuite
    le résultat.
  ]

  #code-commente(
    taille-code: 12.5pt, taille-texte: 12pt,
    ("git checkout -b page", "une branche pour la fonctionnalité"),
    ("git commit -am \"La page HTML d'une recette\"", "un ou plusieurs commits sur la branche"),
    ("git push -u origin page", "la branche envoyée sur GitHub"),
    ("Compare & pull request, Create", "sur le site : la demande de fusion, ses commits, ses modifications"),
    ("Merge pull request, Confirm merge", "sur le site : la branche fusionnée dans `master`"),
    ("git checkout master ; git pull", "le `master` de GitHub ramené sur le poste"),
  )

  #legende[
    Dans un projet à plusieurs, une autre personne relit la pull request
    avant de la fusionner. Ici, chacun fusionne les siennes, dans son dépôt.
  ]
]

// --------------------------------------------
#if tds {
  include "tds/7a_recette.typ"
} else {
  sommaire-td(td-7a)
}

// --------------------------------------------
#separateur(
  "Parcours avancé · Une image, un tableau",
  annonce: "numpy représente une image comme un tableau de nombres, et calcule sur des colonnes entières",
)

// --------------------------------------------
#d("Une image, un tableau numpy")[
  #annonce[
    Une image de 640 × 480 pixels est un tableau de 480 lignes, 640 colonnes
    et 4 valeurs par pixel : rouge, vert, bleu et opacité, de 0 à 255.
  ]

  #code-commente(
    taille-code: 12.5pt, taille-texte: 12pt,
    ("import numpy as np", "la bibliothèque, sous le nom court `np`"),
    ("calque = np.zeros((480, 640, 4), dtype=np.uint8)", "un tableau rempli de zéros : un pixel noir et transparent partout"),
    ("calque.shape", "`(480, 640, 4)` : lignes, colonnes, valeurs par pixel"),
    ("calque[10, 20]", "le pixel de la ligne 10, colonne 20 : quatre valeurs"),
    ("calque[:, 20, 3] = 110", "l'opacité de la colonne 20, sur toutes les lignes (`:`)"),
    ("Image.fromarray(calque).save(\"poteaux.png\")", "le tableau enregistré comme image (Pillow)"),
  )

  #legende[
    `uint8` : des entiers de 0 à 255, sur un octet (cours 3).
  ]
]

// --------------------------------------------
#d("Choisir des colonnes avec un masque")[
  #annonce[
    Une opération sur un tableau numpy se fait sur chaque valeur à la fois.
    Une comparaison donne un tableau de booléens, qui choisit des colonnes.
  ]

  #code-commente(
    taille-code: 12.5pt, taille-texte: 12pt,
    ("np.arange(640)", "les numéros de colonnes : 0, 1, … 639"),
    ("(np.arange(640) + 90 * numero) % 400", "pour chaque colonne, sa place dans un motif de 400 pixels, décalé de 90 par image"),
    ("colonnes = … < 24", "`True` sur 24 colonnes sur 400 : les bandes des poteaux"),
    ("calque[:, colonnes, 3] = 110", "l'opacité de ces colonnes seulement, sur toutes les lignes"),
  )

  #legende[
    Le même calcul avec des boucles `for` parcourt 307 200 pixels ; numpy
    l'écrit en trois lignes, sans boucle.
  ]

  #notes[
    TD 7b, étape E3 : la fonction `ecrire_poteaux`. Le décalage de 90 pixels
    par image fait passer les bandes vers la gauche, plus vite que les
    plans (4 et 8 pixels par image).
  ]
]

// --------------------------------------------
#if tds {
  include "tds/7b_train.typ"
} else {
  sommaire-td(td-7b)
}

// --------------------------------------------
#d("Ce qu'on rend")[
  #annonce[
    Le dépôt GitHub, avec ses pull requests fusionnées.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Parcours standard, `recette`], [Parcours avancé, `train`],
    [Pull requests fusionnées], [`page`, puis `livre`], [`fenetre`, puis `poteaux`],
    [`git log --oneline --graph`], [deux commits de fusion], [trois commits de fusion, dont celui du conflit],
    [Le résultat], [`sortie/index.html` et dix pages], [`sortie/train.mp4` : la vue complète],
  )
]
