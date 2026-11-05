// Cours 6 v2, partie 1 : la forge. Incluse par `cours6_v2.typ`.
//
// Adaptée le 05/11/2026 de « Utiliser git en équipe », de Florent Geniet, 14/10/2026
// (`livraison/cours6/diapositives_cours6.pdf`). Ses figures sont reprises telles
// quelles (`images/forge/CREDITS.md`). Les phrases passent au format de STYLE.md ; les
// deux diapositives « Utilisations de git » en font une, avec les cercles rouges de la
// seconde. La dernière diapositive, sur l'accès au dépôt, est nouvelle.
#import "../../../commun/prelude.typ": *
#import "../../../cours1_v2/diapo/schemas.typ": terminal

#separateur(
  "Partager son code sur une forge",
  annonce: "Les usages de git, et les commandes qui synchronisent un dépôt avec une forge.",
)

// La commande à gauche, la figure de Florent Geniet à droite.
#let _commande(figure, ..lignes) = grid(
  columns: (1fr, auto), column-gutter: 24pt, align: horizon,
  terminal(taille: 24pt, ..lignes),
  image("/src/cours6_v2/images/forge/" + figure, height: 250pt),
)

// --------------------------------------------
#d("Utilisations de git")[
  #annonce[
    Le cours 2 versionne le code sur un poste. Ce cours porte sur le travail à
    plusieurs et sur l'hébergement du code en ligne.
  ]

  #align(center, image("/src/cours6_v2/images/forge/usages_git.png", height: 235pt))

  #legende[
    Une forge, comme GitHub ou GitLab, héberge des dépôts git. Partie adaptée du cours
    de Florent Geniet, 14 octobre 2026.
  ]

  #notes[
    Les deux cercles rouges sont le sujet de la séance.

    Le cercle de droite rappelle les outils du cours 2.
  ]
]

// --------------------------------------------
#d("Système décentralisé")[
  #annonce[
    git est décentralisé : chacun a sa propre copie du projet, avec son historique.
    La forge est une copie de plus, que l'équipe prend pour référence.
  ]

  #align(center, image("/src/cours6_v2/images/forge/decentralise.png", height: 255pt))

  #notes[
    Rien ne distingue techniquement la copie de la forge des autres.

    Le cours 2 a déjà montré des copies d'un dépôt sur un même poste.
  ]
]

// --------------------------------------------
#d("Synchronisation des dépôts : git clone")[
  #annonce[
    `git clone` récupère un dépôt depuis un serveur distant.
  ]

  #_commande("clone.png", "$ git clone <url du projet>")

  #legende[
    `<url du projet>` : à remplacer par l'adresse du dépôt, sans les chevrons.
  ]

  #notes[
    `git clone` copie tout le dépôt, avec son historique, et enregistre l'adresse
    sous le nom `origin`.
  ]
]

// --------------------------------------------
#d("Synchronisation des dépôts : adresse du projet")[
  #annonce[
    L'adresse se copie sur la page du dépôt : bouton Code, puis onglet HTTPS ou SSH.
  ]

  #align(center, image("/src/cours6_v2/images/forge/adresse_depot.png", height: 265pt))

  #notes[
    Capture de Florent Geniet, sur son dépôt `premier_projet`.

    HTTPS et SSH donnent deux adresses du même dépôt, qui s'authentifient
    différemment : la suite de la séance y revient.
  ]
]

// --------------------------------------------
#d("Synchronisation des dépôts : git pull")[
  #annonce[
    `git pull` récupère les commits du dépôt distant, et met à jour son propre dépôt.
  ]

  #_commande("pull.png", "$ git pull")

  #legende[
    Si les deux dépôts ont des commits différents, `git pull` les fusionne, comme
    `git merge` au cours 2.
  ]
]

// --------------------------------------------
#d("Synchronisation des dépôts : git push")[
  #annonce[
    `git push` envoie ses commits au dépôt distant, et le met à jour.
  ]

  #_commande("push.png", "$ git push")
]

// --------------------------------------------
#d("Synchronisation des dépôts : pull avant push")[
  #annonce[
    Un `pull` précède un `push` : le dépôt distant refuse un `push` s'il contient des
    commits que le poste n'a pas.
  ]

  #_commande("pull_avant_push.png", "$ git pull", "$ git push")

  #notes[
    Le TD 6a le fait constater. Une branche qui n'existe pas encore sur la forge n'a
    rien à récupérer : `git pull` y répond par une erreur, sans conséquence.
  ]
]

// --------------------------------------------
// Nouveau (05/11/2026) : la diapositive qui pose le problème, avant les mots de passe.
// Sortie relevée le 05/11/2026, sur github.com, avec un compte et un dépôt qui n'existent
// pas. Rôles : documentation de GitHub. Ver Shai-Hulud : alerte de la CISA du 23/09/2025.
#d("Dépôt en ligne : authentification, droits, piratage")[
  #annonce[
    Une forge doit savoir qui écrit dans un dépôt. Un compte volé donne accès à tout
    ce que ce compte a le droit de faire.
  ]

  #grid(
    columns: (1fr, 1fr, 1fr), gutter: 12pt, rows: 100pt,
    bloc("Authentification", "prouver qui l'on est : jeton, clé SSH, deuxième facteur", hauteur: 100%),
    bloc("Droits", "ce que chaque compte peut faire sur un dépôt : lire, écrire, administrer", hauteur: 100%),
    bloc("Piratage", "avec un compte volé : lire un dépôt privé, pousser du code malveillant, effacer un dépôt", plein: true, hauteur: 100%),
  )

  #v(0.4em)
  #terminal(
    taille: 14pt,
    "$ git clone https://eleve-exemple:motdepasse@github.com/eleve-exemple/projet-prive.git",
    "remote: Invalid username or token. Password authentication is not supported for Git operations.",
    "fatal: Authentication failed for 'https://github.com/eleve-exemple/projet-prive.git/'",
  )

  #legende[
    GitHub refuse le mot de passe du compte pour git depuis le 13 août 2021. En
    septembre 2025, le logiciel malveillant Shai-Hulud a touché plus de 500 paquets
    JavaScript avec les identifiants de leurs développeurs (CISA, agence américaine).
  ]

  #notes[
    Diapositive qui ouvre la partie sur la sécurité : les trois boîtes annoncent la
    suite, et le terminal montre le premier obstacle du TD.

    Un dépôt public se lit sans compte ; écrire demande un droit. Rôles d'un dépôt
    d'organisation sur GitHub : Read, Triage, Write, Maintain, Admin. Sur un dépôt
    personnel : le propriétaire et ses collaborateurs.

    Shai-Hulud : un ver, qui se propage seul, sur le dépôt de paquets npm. Même
    mécanisme sur PyPI (cours 5) : qui détient le jeton d'un développeur publie à sa
    place, et tous ceux qui installent le paquet exécutent le code.
  ]
]
