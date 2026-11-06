// Cours 6 v2, partie 1 : la forge. Incluse par `cours6_v2.typ`.
//
// Adaptée le 05/11/2026 de « Utiliser git en équipe », de Florent Geniet, 14/10/2026
// (`livraison/cours6/diapositives_cours6.pdf`). Ses figures sont reprises telles
// quelles (`images/forge/CREDITS.md`). Les phrases passent au format de STYLE.md ; les
// deux diapositives « Utilisations de git » en font une, avec les cercles rouges de la
// seconde. La dernière diapositive, sur l'accès au dépôt, est nouvelle. Les deux
// diapositives sur les services en ligne viennent du matériel du cours 5 v2.
#import "../../../commun/prelude.typ": *
#import "../../../cours1_v2/diapo/schemas.typ": terminal
#import "../../../cours5/diapo/schemas.typ": schema-commit-push

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
// Déplacée du cours 5 v2 (`06_reseau.typ`) le 06/11/2026.
#d("Commit local et push sur le réseau")[
  #annonce[
    Le commit écrit sur le disque du poste, le push traverse le réseau. Git
    est fait pour qu'on puisse travailler sans réseau et pousser plus tard.
  ]

  #align(center, schema-commit-push())

  #notes[
    Un outil qui enregistrerait directement sur le serveur attendrait le réseau
    à chaque enregistrement et ne fonctionnerait pas hors ligne.
  ]
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
// Déplacée du cours 5 v2 (`05_materiel.typ`) le 06/11/2026.
#d("Consommation électrique des services en ligne")[
  #annonce[
    Un fichier gardé en ligne consomme même quand personne ne le lit.
  ]

  #tableau(
    columns: (1fr, auto, 1fr),
    align: (left + horizon, right + horizon, left + horizon),
    [Quoi], [Électricité], [Équivalent],
    [une question à un assistant d'IA], [0,3 à 2 Wh], [10 s à 1 min de télévision],
    [la même, modèle « qui raisonne »], [7 à 33 Wh], [4 à 20 min de télévision],
    [une heure de vidéo en streaming], [80 Wh], [une ampoule LED de 10 W, 8 h],
    [garder 1 To en ligne pendant un an], [40 à 150 kWh], [1 à 3 disques toujours allumés],
    [le même To dans un tiroir], [0], [],
    [centres de données du monde, 2024], [415 TWh], [1,5 % du mondial, la France entière],
  )

  #legende[
    IA : Jegham et al. 2025, serveurs seuls ; IEA 2020 et 2025 ; disque :
    5 W × 8 760 h × 1 à 3 copies ; France : RTE 2024 ; télévision : 100 W.
  ]

  #notes[
    Les estimations pour une question à un assistant d'IA varient d'un facteur
    100 selon la source et le périmètre :
    - Google (2025) : 0,24 Wh pour une question médiane à Gemini ; chiffre du
      fournisseur ; serveurs et refroidissement, sans entraînement, fabrication,
      réseau ni appareil de l'utilisateur ;
    - Jegham et al. (université de Rhode Island, 2025) : GPT-4o, 0,4 Wh pour une
      question courte, 1,8 Wh pour une longue ; o3 et DeepSeek-R1, plus de
      30 Wh ;
    - Mistral AI, analyse de cycle de vie (Carbone 4, ADEME, 2025), commandée
      par le fournisseur : 1,14 g de CO₂e et 45 mL d'eau pour une réponse de
      400 tokens, fabrication et entraînement compris ;
    - une image générée coûte environ 60 fois plus qu'un texte (Luccioni et
      al., 2024).

    La consommation vient du volume : des milliards de questions par jour. L'IEA
    prévoit le doublement de la consommation des centres de données d'ici 2030,
    surtout à cause de l'IA.

    Ligne du disque : 5 W × 8 760 h = 44 kWh par an, deux ou trois copies, plus
    le refroidissement.

    À dire : supprimer en ligne ce qui ne sert plus ; garder les données lourdes
    d'un projet sur un disque local.
  ]
]

// --------------------------------------------
// Déplacée du cours 5 v2 (`05_materiel.typ`) le 06/11/2026.
#d("Coût d'un service en ligne")[
  #annonce[
    Le coût suit le nombre de machines qui tournent, et de personnes qui les
    font tourner.
  ]

  #tableau(
    columns: (1fr, 1.3fr, auto),
    align: (left + horizon, left + horizon, right + horizon),
    [Service], [Ce qui tourne], [Par an],
    [un site personnel, pages statiques], [une part d'un serveur partagé, ou GitHub Pages], [0 à 60 €],
    [OpenStreetMap, la carte du monde], [deux salles de serveurs, Amsterdam et Dublin], [100 000 à 170 000 €],
    [Wikipédia], [plusieurs centres de données], [3,4 M\$ d'hébergement],
    [Meta : Facebook, Instagram, WhatsApp], [des dizaines de centres de données], [72 milliards de \$ d'investissement],
  )

  #legende[
    Nom de domaine 10 € par an, hébergement partagé 3 à 5 € par mois ; OSMF,
    plan 2023, diffusion des tuiles offerte ; Wikimedia, exercice 2024-2025 ;
    Meta, résultats 2025.
  ]

  #notes[
    Trois ordres de grandeur entre un site personnel et OpenStreetMap, cinq
    entre OpenStreetMap et Meta.

    OpenStreetMap fonctionne avec deux salles : le rendu des tuiles est réparti
    entre plusieurs organisations, et leur diffusion est offerte.

    Le personnel est la plus grande dépense de Wikimedia.

    Un site sur GitHub Pages ne coûte que son nom de domaine, s'il en a un.
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
