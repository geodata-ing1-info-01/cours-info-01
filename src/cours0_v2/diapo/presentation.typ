// Présentation du module : couverture et six diapositives, projetées en ouverture de la
// séance 1. Inclus par `cours0_v2.typ` (la présentation seule) et par
// `src/cours1_v2/diapo/cours1_v2.typ`, avant « Objectifs du cours 1 ». Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../commun/prelude.typ": *
#import "schemas.typ": schema-progression, schema-programme-td

#separateur-module(
  "Introduction à l'informatique",
  annonce: "Objectif, progression et organisation du module",
  auteur: "1re année géomatique",
  date: "2027-2028",
)

// --------------------------------------------
// Repris de « Objectif du cours » ; lignes du tableau refaites d'après les séances v2.
#d("Objectif du module")[
  #annonce[
    Consolider ou acquérir les bases informatiques nécessaires aux autres
    enseignements, en particulier ceux de programmation et les TD utilisant
    Python.
  ]

  #tableau(
    columns: (1fr, 1.2fr),
    align: left + horizon,
    [Demandé dans les autres cours], [Vu dans ce module],
    [« ouvrez le projet fourni »], [éditeur de code, arborescence d'un projet (séances 1 et 2)],
    [« lancez le script sur vos données »], [ligne de commande, chemins, arguments d'un programme (séances 1 et 3)],
    [« installez Python et numpy »], [environnement, et fichier qui le décrit pour un autre poste (séance 5)],
    [« rendez votre code »], [git, README, dépôt sur GitHub (séances 2, 3 et 6)],
  )

  #notes[
    Ces bases sont en partie connues, par le lycée ou la prépa.

    Elles servent dans les cours d'informatique, et dans tout cours qui demande
    une expérimentation ou un rendu sous forme de code.
  ]
]

// --------------------------------------------
// Repris tel quel de l'introduction retirée du cours 1 v2 le 04/11/2026.
#d("Objectifs du module liés à la programmation")[
  #annonce[
    Maîtriser la forme d'un projet de code : documentation, organisation des
    fichiers, bibliothèques et environnements.
  ]

  #tableau(
    columns: (1.7fr, 0.8fr, 1fr),
    align: (left + horizon, center + horizon, center + horizon),
    [], [ce cours], [cours de programmation],
    [Quel algorithme choisir ?], [], [oui],
    [Comment écrire cette boucle ?], [], [oui],
    [Où mettre ce fichier ?], [oui], [],
    [Comment lancer le script ailleurs ?], [oui], [],
  )

  #notes[
    L'algorithmique relève du cours de programmation, qui se déroule en
    parallèle. Ajouter oralement : « retrouver la version qui marchait » relève
    aussi de ce module.

    Développer l'annonce à l'oral : ces pratiques servent déjà quand on
    programme seul, et deviennent nécessaires dès qu'on travaille en équipe ou
    qu'on distribue son programme à un utilisateur.
  ]
]

// --------------------------------------------
// Nouveau, 11/11/2026.
#d("Progression du module")[
  #annonce[
    Sept séances de deux heures. Chaque séance alterne explications courtes et TD sur machine.
  ]

  #schema-progression()

  #legende[
    En brun, les deux TD d'application des séances précédentes, avec un travail à rendre.
  ]

  #notes[
    Séance 1 : la ligne de commande sert ensuite à git, et les programmes du module
    sont des outils en ligne de commande, plus simples à écrire qu'un programme à
    fenêtres (diapositive « Intérêt de la ligne de commande »).

    Séance 5 : réutiliser un programme ou une bibliothèque évite de les réécrire, mais
    chaque poste doit alors les installer.

    Culture informatique, au fil des séances : matériel, puissance de calcul et
    consommation (séance 1) ; mémoires et ordres de grandeur (séance 3) ;
    consommation et coût des services en ligne, sécurité (séance 6).
  ]
]

// --------------------------------------------
// Nouveau, 11/11/2026.
#d("Notions reprises d'une séance à l'autre")[
  #annonce[
    Chaque séance reprend la ligne de commande ou git, sur un exercice court.
  ]

  #show table.cell: set text(size: 15pt)
  #show raw: set text(size: 1.15em)
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (center + horizon, left + horizon, left + horizon),
    [Séance], [Ligne de commande], [git],
    [1], [commandes de base, chemins], [],
    [2], [commandes git], [dépôt, commit, branche, fusion],
    [3], [arguments d'un programme : argparse], [fusion d'une branche],
    [4], [dossier du projet, options du programme], [un commit par étape],
    [5], [appel d'un programme depuis Python : subprocess, PATH], [],
    [6], [], [dépôt sur GitHub : clone, push, pull],
    [7], [option `--profil`], [branche, push, pull request],
  )

  #notes[
    git ne se comprend qu'en le pratiquant : chaque séance le reprend sur un exercice
    court, de la séance 2 à la séance 7, sauf la séance 5.
  ]
]

// --------------------------------------------
// Nouveau, 11/11/2026.
#d("Évolution du programme des TD")[
  #annonce[
    Les TD reprennent un même programme, qui calcule des statistiques sur des
    altitudes, puis sur une trace GPS.
  ]

  #v(0.6em)
  #schema-programme-td()

  #legende[
    Le TD 6a, sur GitHub, emploie son propre dépôt.
  ]

  #notes[
    `stats_trace.py` est `altitudes.py` du TD 3b, renommé. `carte_trace.py` importe
    `stats_trace.py`. Le dépôt `td7a-trace` part de `stats_trace.py` à la fin de l'étape B6
    du TD 4a.
  ]
]

// --------------------------------------------
// Nouveau, 11/11/2026.
#d("Pratique après le module")[
  #annonce[
    Le module introduit ces notions sans les couvrir en entier. Elles s'acquièrent en
    les pratiquant, dès qu'un cours ou un projet demande d'écrire du code.
  ]

  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: 110pt,
    gutter: 12pt,
    bloc("Autres cours", "TD et projets en Python : terminal, environnement, fichiers", hauteur: 100%),
    bloc("Projets à plusieurs", "un dépôt git partagé, des branches, des pull requests", hauteur: 100%),
    bloc("Seul", "jeux et exercices de la page « S'entraîner » du site", hauteur: 100%),
  )

  #notes[
    Aide-mémoire en fin de séances 1, 2, 3 et 5 ; « À retenir » en fin de séance 6.

    Page du site : Après les séances, S'entraîner (Terminus, Learn Git Branching,
    GameShell…).
  ]
]
