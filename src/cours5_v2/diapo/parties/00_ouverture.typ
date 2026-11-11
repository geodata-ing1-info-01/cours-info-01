// Ouverture du cours 5 v2 — incluse par `cours5_v2.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#page-titre(
  titre: "Cours 5",
  sous-titre: "Réutiliser des programmes et des bibliothèques",
  auteur: "1re année géomatique",
  date: "2027-2028",
)

// --------------------------------------------
#d("Objectifs de la séance")[
  #chaine(
    gabarit: bloc, pleins: (1,),
    ([Cours 3], [permettre à une autre personne d'utiliser ce code]),
    ([Cours 5], [réutiliser des outils existants, et les réinstaller]),
    ([Cours 6], [partager ce code et travailler à plusieurs]),
  )

  #v(0.3em)
  #annonce[
    Ajouter des fonctionnalités à un programme sans tout recoder : appeler un programme
    existant, utiliser une bibliothèque.\
    Décrire ces dépendances, pour les réinstaller sur un autre poste.
  ]

  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
    [Vu aux cours précédents], [Aujourd'hui],
    [lancer un programme au terminal], [`subprocess.run`, depuis un programme Python],
    [`import math`, la bibliothèque standard], [`import folium`, une bibliothèque à installer],
    [`which python`, `(base)`], [`PATH`, `sys.path`, un environnement],
    [copier un script sur un autre poste], [`environment.yml`, `pyproject.toml`],
  )

  #notes[
    Plan, à annoncer à l'oral : le problème, sans détail de Python ; appeler un programme
    existant ; les bibliothèques et les autres dépendances ; l'environnement et le fichier de
    projet ; en partie facultative, JupyterLab et le noyau. Puis le TD.

    Le déroulé reste à chronométrer.
  ]
]
