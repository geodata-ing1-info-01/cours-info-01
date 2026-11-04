// Introduction du module : les cinq premières diapositives du cours 1 v2,
// retirées le 04/11/2026. À reprendre, dans le cours 1 ou dans un autre
// document, quand les autres cours v2 seront finis. Ce fichier n'est inclus
// nulle part.
//
// À mettre à jour à ce moment : le tableau des séances (le matériel du cours 5
// passe aux cours 1 et 3). L'avertissement d'« Organisation : sept séances de
// deux heures » et les notes propres à la séance 1 sont passés sur « Objectifs
// du cours 1 » (`parties/00_ouverture.typ`).
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
// Tableau mis à jour d'après le syllabus v2 ; notes reprises.
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

  #notes[
    Développer l'annonce à l'oral : les deux projets font revoir et pratiquer
    le contenu des séances précédentes, par l'élaboration d'un livrable de
    code complet.

    Les deux projets appliquent ce qui précède sur un livrable complet.
    L'important est ici plus la qualité de la forme que le fond,
    c'est à dire est-ce que le projet est bien structuré et documenté
    et moins est-ce que le code est bon/performant.

    Justification du choix : ce qui est reproché aux étudiants dans les autres
    cours n'est pas toujours l'algorithmique. C'est un chemin de fichier faux,
    un environnement mal installé, un code qui ne s'installe pas sur une autre
    machine. Ce qui évite ces erreurs n'est enseigné nulle part ailleurs.

    Version 2 : titres des séances d'après `syllabus/02_syllabus_v2.md`.
  ]
]
