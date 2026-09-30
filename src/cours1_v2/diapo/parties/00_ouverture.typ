// Partie du cours 1 v2 — incluse par `cours1_v2.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

// =============================== Introduction ===============================

#separateur-module(
  "Introduction à l'informatique",
  annonce: "Objectifs, contenu et organisation du module",
  auteur: "1re année géomatique",
  date: "proposition pour 2027-2028",
)

// --------------------------------------------
#d("Objectif du cours")[
  #annonce[
    Consolider ou acquérir les bases informatiques nécessaires aux autres
    enseignements, en particulier ceux de programmation et les TD utilisant
    Python.
  ]

  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
    [Demandé dans les autres modules et cours], [(re)vu dans ce module],
    [« ouvrez le projet fourni »], [travailler dans un éditeur de code, lire une arborescence],
    [« installez Python et numpy »], [créer un environnement et le réinstaller ailleurs],
    [« le script lit `donnees.csv` »], [manipuler des fichiers depuis Python],
    [« rendez votre code »], [versionner avec git, partager un dépôt, documentation README.md],
  )

  #notes[
    Ces bases sont en partie connues, par le lycée ou la prépa. Les maîtriser
    évite de prendre du retard dans les autres cours : on s'y consacre au
    contenu du cours plutôt qu'à l'outil qu'on ne sait pas employer.
    Ces notions sont utiles pour les autres cours informatiques et de programmation
    mais aussi pour tous les cours non informatiques qui demandent des expérimentations
    ou rendu de projet sous forme de code.
  ]
]

// --------------------------------------------
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
#d("Les trois compétences du module")[

  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: 88pt,
    gutter: 12pt,
    bloc("Éditer", "éditeur de code, arborescence de projet", hauteur: 100%),
    bloc("Versionner", "git : enregistrer, revenir, partager", hauteur: 100%),
    bloc("Structurer", "README, environnement, ligne de commande", hauteur: 100%),
  )

  #annonce[
    Des notions de culture informatique au fil de l'eau, rattachées aux enseignements et projets en cours.
  ]

  #v(0.6em)
  #block(
    width: 100%, inset: (x: 14pt, y: 9pt), fill: gris,
    stroke: 1pt + accent.lighten(62%),
  )[
    #grid(
      columns: (auto, 1fr), column-gutter: 16pt, align: horizon,
      text(size: 17pt, weight: demi-gras)[Culture informatique],
      align(right, text(size: 14pt, fill: estompe)[
        ordres de grandeur, sécurité informatique, du programme au logiciel
      ]),
    )
  ]

  #notes[
    Les trois blocs sont les fils rouges : chaque séance en reprend au
    moins un, les deux projets les mobilisent ensemble.
  ]
]

// --------------------------------------------
// Tableau mis à jour d'après le syllabus v2 ; avertissement et notes repris.
#d("Organisation : sept séances de deux heures")[
  #annonce[
    Chaque séance alterne explications courtes et TD sur machine.
  ]

  #tableau(
    columns: (auto, 1fr, auto),
    align: (center + horizon, left + horizon, center + horizon),
    [], [Sujet], [Type],
    [1], [Logiciels, fichiers, terminal et premier programme], [cours],
    [2], [Éditeur de code, Markdown et git local], [cours],
    [3], [Environnements, fichiers en Python, ligne de commande], [cours],
    [4], [Premier projet : une animation, du notebook au programme], [projet],
    [5], [Matériel, réseau ; mots de passe, clés, secrets], [cours],
    [6], [La forge, sur le dépôt du projet 4], [cours],
    [7], [Second projet : un effet pour l'animation], [projet],
  )

  #avertissement[
    Une partie de la séance 1 reprend des notions surement vues au lycée et/ou prépa.
  ]

  #notes[
    Développer l'annonce à l'oral : les deux projets font revoir et pratiquer
    le contenu des séances précédentes, par l'élaboration d'un livrable de
    code complet.

    Les deux projets appliquent ce qui précède sur un livrable complet.
    L'important est ici plus la qualité de la forme que le fond,
    c'est à dire est-ce que le projet est bien structuré et documenté
    et moins est-ce que le code est bon/performant.

    Sur l'avertissement : ces notions sont rappelées pour que la suite du
    module parte du même point pour tout le monde. Passer vite, en disant qu'on
    a conscience que ce sera une redite pour une partie de la salle. Notions concernées : données en
    tableau et fichiers csv, le Web, HTML et CSS, les formats d'image (SNT,
    seconde) ; binaire, hexadécimal, encodage du texte, système d'exploitation
    et ligne de commande (NSI, première) ; écrire et exécuter un programme
    Python (NSI, ou tronc commun en CPGE). Programmes de SNT et de NSI :
    Bulletin officiel spécial n°1 du 22 janvier 2019.

    Justification du choix : ce qui est reproché aux étudiants dans les autres
    cours n'est pas toujours l'algorithmique. C'est un chemin de fichier faux,
    un environnement mal installé, un code qui ne s'installe pas sur une autre
    machine. Ce qui évite ces erreurs n'est enseigné nulle part ailleurs.

    Version 2 : titres des séances d'après `syllabus/02_syllabus_v2.md`.
  ]
]
// ================================ Séance 1 ==================================

#page-titre(
  titre: "Cours 1",
  sous-titre: "Version 2, proposition de travail",
  auteur: "1re année géomatique",
  date: "2027-2028",
)

// --------------------------------------------
// Nouveau (v2) : l'arborescence des cinq TD de la version 2.
#d("Les fichiers du cours")[
  #annonce[
    Une archive par séance, un dossier par TD. Aujourd'hui, tout est dans
    `cours1/`.
  ]

  #align(center)[
    #block(
      inset: (x: 20pt, y: 13pt), fill: gris,
      stroke: 1pt + accent.lighten(62%),
    )[
      #set text(size: 23pt)
      #set align(left)
      #raw(
"cours1/                un dossier par TD, dans l'ordre de la séance
├── 1a_formats/
├── 1b_terminal/
├── 1c_programme/
└── 1d_notebook/")
    ]
  ]

  #legende[
    Dans chaque dossier, la feuille du TD et son guide détaillé, en PDF.
  ]

  #notes[
    L'archive se copie depuis le dossier partagé au premier TD, après la
    diapositive sur le stockage : ne pas la faire copier avant.

    Rappeler le nom du dossier à chaque TD.

    Version 2 : aucun TD facultatif dans la séance. Les TD 1b (archive
    `.odt`), 1i et 1j de 2026 restent dans l'archive 2026 du book ; le TD 1e
    (C++) est l'annexe « C++ ».
  ]
]

// --------------------------------------------
// Nouveau (v2) : trois parties, d'après le budget du syllabus v2.
#d("Contenu de la séance")[
  #annonce[
    Trois parties, des logiciels et fichiers jusqu'au notebook.
  ]

  #tableau(
    columns: (1fr, auto, auto),
    align: (left + horizon, left + horizon, right + horizon),
    [Partie], [Nature], [Durée],
    [Logiciels, fichiers et stockage], [cours et TD 1a], [30′],
    [Terminal et premier programme], [cours et TD 1b, 1c], [50′],
    [Un notebook et la syntaxe de Markdown], [cours et TD 1d], [15′],
  )

  #avertissement[
    La première partie de révision avance vite : posez vos questions tout de suite, tout ce
    qui suit s'appuie dessus.
  ]

  #legende[
    Durées indicatives.
  ]

  #notes[
    Les diapositives brunes sont les TD : quatre, dans les trois parties.

    Si la séance déborde, la partie 3 passe en début de cours 3, qui ouvre
    des notebooks. Le TD des programmes fautifs est au cours 2 v2 depuis le
    27/09/2026.
  ]
]
