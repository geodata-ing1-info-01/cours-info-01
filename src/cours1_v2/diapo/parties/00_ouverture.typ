// Partie du cours 1 v2 — incluse par `cours1_v2.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
//
// La présentation du module la précède : `src/cours0_v2/diapo/presentation.typ`.
#import "../../../commun/prelude.typ": *

#page-titre(
  titre: "Cours 1",
  sous-titre: "Logiciels, fichiers, terminal et premier programme",
  auteur: "1re année géomatique",
  date: "2027-2028",
)

// --------------------------------------------
// Nouveau (v2), 04/11/2026. L'avertissement et les notes sur la séance viennent
// d'« Organisation : sept séances de deux heures ».
#d("Objectifs du cours 1")[
  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: 120pt,
    gutter: 12pt,
    bloc("Rappeler", "les bases du fonctionnement d'un ordinateur : composants, logiciels, fichiers, stockage", hauteur: 100%),
    bloc("Découvrir", "la ligne de commande : le terminal, les commandes de base, les chemins", hauteur: 100%),
    bloc("Exécuter", "un premier programme Python, dans le terminal puis dans un notebook", hauteur: 100%),
  )

  #legende[
    L'écriture de programmes relève du cours de programmation.
  ]

  #avertissement[
    Une partie de la séance 1 reprend des notions surement vues au lycée et/ou
    prépa, et avance vite : posez vos questions tout de suite.
  ]

  #notes[
    Au TD 1c, le programme est fourni ; la seule modification est une valeur
    ajoutée à une liste.

    Sur l'avertissement : ces notions sont rappelées pour que la suite du
    module parte du même point pour tout le monde. Passer vite, en disant qu'on
    a conscience que ce sera une redite pour une partie de la salle, et que
    tout ce qui suit s'appuie dessus. Notions concernées : données en
    tableau et fichiers csv, le Web, HTML et CSS, les formats d'image (SNT,
    seconde) ; binaire, hexadécimal, encodage du texte, système d'exploitation
    et ligne de commande (NSI, première) ; écrire et exécuter un programme
    Python (NSI, ou tronc commun en CPGE). Programmes de SNT et de NSI :
    Bulletin officiel spécial n°1 du 22 janvier 2019.

    Séance 1, à annoncer à l'oral (relecture du 19/10/2026 : la diapositive
    « Contenu de la séance » est retirée, et « Les fichiers du cours » ouvre le
    TD 1a) : trois parties, du matériel et des fichiers jusqu'au notebook.
    Matériel, logiciels, fichiers et stockage, cours et TD 1a ; le terminal,
    cours et TD 1b ; programme Python et notebook, avec le processeur, compiler
    et interpréter, cours et TD 1c, 1d. Durées à revoir après la réorganisation
    du 19/10/2026 (avant : 30′, 50′ pour le terminal et le premier programme,
    15′ pour le notebook). Les diapositives brunes sont les TD : quatre, dans
    les trois parties.

    Si la séance déborde, le notebook et le TD 1d passent en début de
    séance suivante. Le TD des programmes fautifs est au cours 2 v2 depuis le
    27/09/2026.
  ]
]
