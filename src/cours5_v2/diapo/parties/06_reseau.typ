// Cours 5 v2, partie 6 — le réseau. Incluse par `cours5_v2.typ`. Reprise du cours 5 de
// 2026 le 05/11/2026 : seuls les renvois aux mots de passe, passés au cours 6, changent.
// 06/11/2026 : restent client et serveur. « Commit local et push sur le réseau » passe
// au cours 6, et les six autres diapositives attendent dans `../a_reprendre/reseau.typ`.
#import "../../../commun/prelude.typ": *
#import "../../../cours5/diapo/schemas.typ": schema-client-serveur
// Le schéma du notebook, dessiné pour la partie 4 du cours 1 : le client et
// le serveur sur le même poste, redit ici après le projet 4, qui le présente
// au parcours standard avec les trois emplacements du serveur.
#import "../../../cours1/diapo/schemas_notebooks.typ": schema-client-serveur as schema-notebook-local

#separateur(
  "Le réseau",
  annonce: "Client et serveur, sur le même poste ou à distance.",
)

// --------------------------------------------
#d("Client et serveur")[
  #annonce[
    Le client envoie une requête, le serveur répond. Le serveur répond à
    beaucoup de clients à la fois.
  ]

  #align(center, schema-client-serveur())

  #v(0.15em)
  #tableau(
    columns: (1fr, 1fr, 1.4fr),
    align: left + horizon,
    [Client], [Serveur], [Contenu de la requête],
    [le navigateur], [le site web], [l'adresse de la page demandée],
    [`git push`], [la forge], [les nouveaux commits],
    [`ssh`], [un serveur de calcul], [l'ouverture d'un terminal],
  )

  #notes[
    Le cours 6 ajoute `git pull`, qui demande à la forge les commits des autres.
  ]
]

// --------------------------------------------
#d("Client et serveur sur le même poste")[
  #annonce[
    Client et serveur sont deux programmes. Ils peuvent tourner sur le même
    poste : c'est le cas de JupyterLab.
  ]

  #align(center, scale(80%, reflow: true, schema-notebook-local()))

  #legende[
    `jupyter lab`, lancé dans un terminal, démarre le serveur. Le navigateur
    est le client : il se connecte à l'adresse `localhost:8888`, qui désigne
    le poste lui-même.
  ]

  #notes[
    Démonstration, deux minutes, dans Git Bash ou l'invite de commandes d'Anaconda :
    - `jupyter lab` : le terminal affiche l'adresse `http://localhost:8888/lab?token=…`
      et reste occupé, c'est le serveur ;
    - le navigateur s'ouvre sur cette adresse ; exécuter une cellule : le
      terminal affiche une ligne à chaque requête ;
    - fermer le terminal, puis exécuter une cellule : le navigateur signale
      que le serveur ne répond plus. Le client est toujours ouvert, le
      serveur est arrêté.

    `localhost` est le nom du poste pour lui-même (adresse `127.0.0.1`) ;
    8888 est le port du serveur. Rien ne sort du poste.

    Le jeton de l'adresse est un mot de passe à usage unique : un autre poste
    du réseau ne peut pas exécuter de code sur ce serveur sans lui. Lien avec
    le cours 6.

    Schéma de la partie 4 du cours 1 de 2026.
  ]
]

