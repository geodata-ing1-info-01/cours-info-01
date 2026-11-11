// TD 6a du cours 6 v2 — « Utiliser GitHub ».
//
// Adapté le 05/11/2026 du TP de Florent Geniet, 14/10/2026 (`livraison/cours6/TP.pdf`),
// en consignes numérotées, les commandes dans un bloc de terminal. Sa suite d'étapes est
// gardée. Changements : `git checkout -b`, comme au cours 2 v2 ; `git add` avant
// `git merge --continue`, sans lequel git refuse ; un seul nom de branche,
// `calcul_de_distances` ; le deuxième facteur et la suppression du token, ajoutés.
//
// Rejoué le 05/11/2026 sur un dépôt nu local, sans GitHub (git 2.34) : les sorties des
// constats viennent de là. Les menus du site viennent du TP et sont à vérifier sur
// GitHub. Les captures de Florent Geniet restent dans `TP.pdf`, et iront dans le guide.
//
// Inclus par `cours6_v2.typ`.
#import "../../../commun/prelude.typ": *
#import "../../../cours1_v2/diapo/schemas.typ": consignes, comment, commandes, constat, terminal-etapes, etape-terminal

#let td = (
  numero: "6a",
  titre: "Utiliser GitHub",
  annonce: "Objectif : créer un dépôt sur GitHub, le synchroniser avec son poste, fusionner une pull request et résoudre un conflit",
  dossier: "cours6/",
  duree: none,
)
#separateur-td(..td)

// La consigne à gauche, ses commandes à droite.
#let _etape(liste, commandes-td) = grid(
  columns: (1.2fr, 1fr), column-gutter: 14pt, align: top,
  liste, commandes-td,
)

// 10/11/2026 : le compte se crée avant la séance, hors du réseau de l'école (fin du cours
// 5 v2) : en 2026, GitHub a refusé une partie des inscriptions faites ensemble dans la salle.
#d("Compte GitHub")[
  #objectif[
    se connecter au compte GitHub créé avant la séance, et vérifier que le poste ne garde pas
    l'identifiant d'un autre compte.
  ]

  #consignes(
    taille: 16pt,
    [Aller sur `github.com` et se connecter, avec le code du deuxième facteur.],
    [Sans compte : le créer depuis le partage de connexion de son téléphone. #comment[GitHub refuse les inscriptions nombreuses venues du réseau de l'école : diapositive « Création d'un compte GitHub », fin du cours 5.]],
    [Ouvrir le Gestionnaire d'identification de Windows, puis Informations d'identification Windows : supprimer `git:https://github.com` s'il existe. #comment[Menu Démarrer, « Gestionnaire d'identification ».]],
  )

  #notes[
    Le compte Windows `eleve` est commun : un identifiant GitHub resté sur le poste ferait
    pousser au nom d'un autre élève (diapositive « Token sur un poste partagé »).

    TP de Florent Geniet, étapes 1 à 3, pour le contenu de l'inscription.
  ]
]

#d("Token d'accès")[
  #objectif[
    créer un token limité aux dépôts, et le copier dans un fichier hors de tout dépôt.
  ]

  #consignes(
    taille: 16pt,
    [Ouvrir les identifiants : #comment[menu utilisateur, Settings, section Credentials.]],
    [Choisir « Personal access tokens (classic) », puis « Generate new token (classic) ».],
    [Nommer le token (champ Note), garder une expiration de 30 jours, et cocher seulement `repo`.],
    [Cliquer sur « Generate token ».],
    [Copier le token dans un nouveau fichier texte, hors de tout dépôt git. #comment[GitHub ne l'affiche qu'une fois.]],
  )

  #legende[
    Le token remplace le mot de passe du compte pour `git clone` et `git push`.
    Dans la documentation de GitHub, ce menu s'atteint aussi par Settings, Developer
    settings, Personal access tokens.
  ]

  #notes[
    Trois options dans le TP : un token, une application autorisée, une clé SSH. Le
    TP de 2026 choisit le token. La clé SSH demande le port 22, que le pare-feu de
    l'école peut fermer : à vérifier avant de la proposer.

    Documentation de GitHub : « Treat your access tokens like passwords », et les
    tokens à droits fins (*fine-grained*) sont recommandés quand ils conviennent. Le
    TP garde le token classique, plus simple à créer.

    Le fichier texte reste sur le poste le temps du TD : il est supprimé à la fin, et
    le token avec lui. La partie suivante du cours explique pourquoi.
  ]
]

#d("Dépôt sur GitHub et clone")[
  #objectif[
    créer un dépôt privé sur GitHub, puis le cloner sur le poste.
  ]

  #_etape(
    consignes(
      taille: 16pt,
      [Créer un dépôt : #comment[bouton de création sur la page d'accueil.]],
      [Choisir la visibilité « Private », et cocher l'ajout d'un README.],
      [Copier l'adresse du dépôt : #comment[bouton Code, onglet HTTPS.]],
      [Cloner le dépôt dans Git Bash, puis entrer dans son dossier. #comment[Nom d'utilisateur : celui du compte. Mot de passe : le token.]],
    ),
    terminal-etapes(
      taille: 16pt,
      etape-terminal(numero: 4, "git clone <adresse du dépôt>", "cd <nom du dépôt>"),
    ),
  )

  #notes[
    Contrairement au cours 2, le dépôt naît sur la forge.

    Le TP nomme le bouton « Create project » : à vérifier sur la page de GitHub.

    Sous Windows, le gestionnaire d'identifiants de Git for Windows retient le token
    après le premier accès. À vérifier sur un poste de la salle.
  ]
]

#d("Branche créée sur le poste")[
  #objectif[
    créer la branche `develop` sur le poste, y décrire le projet dans `README.md`, et la pousser
    sur GitHub.
  ]

  #_etape(
    consignes(
      taille: 16pt,
      [Créer la branche `develop`, et s'y placer.],
      [Décrire le projet dans le README : une bibliothèque de calcul géométrique.],
      [Committer, puis pousser.
        #constat[`fatal: The current branch develop has no upstream branch.` La branche n'existe pas encore sur GitHub.]],
      [Pousser en créant la branche sur GitHub. #comment[`origin` désigne le serveur d'où vient le clone.]],
      [Recharger la page du dépôt, puis choisir `develop` dans la liste des branches.
        #constat[Avec `main`, le README n'a pas changé ; avec `develop`, il affiche la description.]],
    ),
    terminal-etapes(
      taille: 16pt,
      etape-terminal(numero: 1, "git checkout -b develop"),
      etape-terminal(numero: 3, "git add README.md", "git commit -m \"Décrit le projet\"", "git push"),
      etape-terminal(numero: 4, "git push --set-upstream origin develop"),
    ),
  )
]

#d("Branche créée sur GitHub")[
  #objectif[
    créer une branche sur GitHub, et y ajouter `src/calcul_distances.py` sur le poste.
  ]

  #_etape(
    consignes(
      taille: 16pt,
      [Sur GitHub, créer la branche `calcul_de_distances`, à partir de `develop`.],
      [Sur cette branche, ajouter au README une section « Fonctionnalités », avec une puce « calcul des distances ». #comment[L'enregistrement crée un commit.]],
      [Dans le dépôt local, récupérer la branche, et s'y placer.],
      [Créer `src/calcul_distances.py`, avec une fonction qui calcule la distance entre deux points 3D : #commandes("def distance_pt_pt(coords1, coords2):")],
      [Committer, puis pousser.],
    ),
    terminal-etapes(
      taille: 16pt,
      etape-terminal(numero: 3, "git pull", "git checkout calcul_de_distances"),
      etape-terminal(numero: 5, "git add src", "git commit -m \"Ajoute la distance\"", "git push"),
    ),
  )

  #notes[
    La racine carrée est dans la bibliothèque `math`.

    Le TP écrit aussi `calcul_des_distances` : un seul nom ici.
  ]
]

#d("Pull request")[
  #objectif[
    fusionner `calcul_de_distances` dans `develop` par une pull request.
  ]

  #consignes(
    [Sur GitHub, créer une pull request de `calcul_de_distances` vers `develop`. #comment[Vérifier la branche d'arrivée : `develop`.]],
    [Lire les différences affichées entre les deux branches.],
    [Fusionner : #comment[Create pull request, puis Merge pull request.]],
  )

  #legende[
    Une pull request demande de fusionner une branche dans une autre, et montre les différences
    avant la fusion.
  ]

  #notes[
    La revue par un camarade vient au projet 7, avec un collaborateur ajouté au dépôt.
  ]
]

#d("Push après une modification distante")[
  #objectif[
    pousser `src/calcul_perimetre.py` sur `develop`, sans la dernière fusion de GitHub.
  ]

  #_etape(
    consignes(
      taille: 15pt,
      [Dans le dépôt local, sans `git pull`, revenir sur `develop`, puis créer la branche `calcul_perimetre`.],
      [Recréer le dossier `src`, et y créer `calcul_perimetre.py` : #commandes("def perimetre_polygone(coords):", "    pass")],
      [Committer.],
      [Revenir sur `develop`, puis fusionner `calcul_perimetre`.],
      [Pousser.
        #constat[`! [rejected] develop -> develop (non-fast-forward)` : le dépôt distant contient la fusion de l'étape précédente, et le poste ne l'a pas.]],
      [Récupérer les commits, puis pousser de nouveau. #comment[Si `git pull` demande de réconcilier des branches divergentes : `git config pull.rebase false`, puis recommencer. L'éditeur s'ouvre sur le message de fusion : enregistrer et fermer.]],
    ),
    terminal-etapes(
      taille: 15pt,
      etape-terminal(numero: 1, "git checkout develop", "git checkout -b calcul_perimetre"),
      etape-terminal(numero: 3, "git add src", "git commit -m \"Ajoute le périmètre\""),
      etape-terminal(numero: 4, "git checkout develop", "git merge calcul_perimetre"),
      etape-terminal(numero: 5, "git push"),
      etape-terminal(numero: 6, "git pull", "git push"),
    ),
  )

  #notes[
    Selon le réglage de git au cours 2, Vim peut s'ouvrir sur le message de fusion :
    `:wq`.
  ]
]

#d("Résolution d'un conflit")[
  #objectif[
    modifier la même ligne de `src/calcul_perimetre.py` sur GitHub et sur le poste, puis résoudre
    le conflit.
  ]

  #_etape(
    consignes(
      taille: 16pt,
      [Sur GitHub, branche `develop` : coder `perimetre_polygone` dans `src/calcul_perimetre.py`, en appelant `distance_pt_pt`.],
      [Dans le dépôt local, sur `develop` : remplacer `pass` par `return -1`.],
      [Committer, puis récupérer les commits.
        #constat[`CONFLICT (content): Merge conflict in src/calcul_perimetre.py`]],
      [Ouvrir le fichier. Garder la version de GitHub, sous `=======`. Supprimer la vôtre, sous `<<<<<<< HEAD`, et les trois lignes de marqueurs.],
      [Valider la fusion, puis pousser. #comment[L'éditeur s'ouvre : enregistrer et fermer.]],
    ),
    terminal-etapes(
      taille: 16pt,
      etape-terminal(numero: 3, "git add src", "git commit -m \"Retourne -1\"", "git pull"),
      etape-terminal(numero: 5, "git add src", "git merge --continue", "git push"),
    ),
  )

  #notes[
    Le conflit est créé à dessein : les deux modifications portent sur la même ligne.
  ]
]

#d("Suppression du dépôt et du token")[
  #objectif[
    supprimer sur GitHub le dépôt et le token du TD, puis le fichier du token.
  ]

  #consignes(
    [Sur GitHub, supprimer le dépôt : #comment[Settings du dépôt, Danger Zone, Delete this repository.]],
    [Supprimer le token : #comment[menu utilisateur, Settings, Credentials, Personal access tokens (classic), Delete.]],
    [Supprimer le fichier texte qui contient le token.],
  )

  #legende[
    Un token oublié reste valable jusqu'à son expiration.
  ]

  #notes[
    La suppression du dépôt termine le TP de 2026. Celle du token est ajoutée pour la
    v2, avec la partie sur les secrets.
  ]
]
