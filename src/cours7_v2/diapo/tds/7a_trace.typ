// TD 7a du cours 7 v2 — « Une pull request sur son dépôt GitHub ». PROPOSITION (10/11/2026).
//
// Reprise du TD 7a de 2026 (`src/cours7/diapo/tds/7a_recette.typ`) sur le programme de la
// trace GPS, avec ce que la séance de 2026 a montré :
//   - le dépôt de départ est un dépôt modèle (« Use this template »), copié sur le compte de
//     l'élève sans commande : plus de `git remote set-url`, ni de push de `master` ;
//   - toutes les adresses sont en HTTPS : les adresses SSH (`git@github.com:…`) passent par
//     le port 22, fermé par le pare-feu de l'école ;
//   - l'adresse de chaque dépôt est écrite en entier, sur une diapositive à part ;
//   - le premier push est détaillé, de deux façons à départager par un essai sur un poste de
//     la salle : la fenêtre de Git Credential Manager, ou les questions de Git dans la
//     fenêtre Git Bash, Git Credential Manager retiré du dépôt. Puis les messages d'erreur
//     connus, et une diapositive de secours pour la connexion par le navigateur ;
//   - moins d'étapes : une branche, deux commits, un push, une pull request. Le second push
//     est facultatif.
//
// Données, corrigés et sorties : `data/cours7_v2/make_data.py`. Sorties relevées avec ces
// versions (Python 3.12) et en rejouant les commandes git sur un dépôt nu local (git 2.43,
// en français). Les lignes `remote:` de GitHub et les fenêtres sont à vérifier en salle.
//
// Inclus par `cours7_v2.typ` ; compilable seul par `outils/compiler_tds.py --cours 7_v2`.
#import "../../../commun/prelude.typ": *
#import "../../../commun/schemas_github.typ": page-depot, menu-code, formulaire-token, token-genere, fenetre-connexion, gestionnaire-identification, pastille
#import "../../../cours1_v2/diapo/schemas.typ": consignes, comment, commandes, constat, terminal

#let td = (
  numero: "7a",
  titre: "Une pull request sur son dépôt GitHub",
  annonce: "Objectif : copier sur son compte GitHub le dépôt modèle du TD, y ajouter l'option --profil sur une branche, pousser cette branche, puis la fusionner par une pull request",
  dossier: "cours7/7a_trace/",
  duree: "85′",
)
#separateur-td(..td)

// La sortie attendue d'une étape, et le commit qui la termine (comme au TD 4a v2).
#let test(titre: [Test], taille: 15pt, ..lignes) = panneau(titre, terminal(taille: taille, ..lignes))
#let commit(message) = panneau[Commit][
  #block(above: 0pt, text(size: 15pt, stack(
    spacing: 5pt, raw("git add stats_trace.py"), raw("git commit -m \"" + message + "\""),
  )))
]
#let deux-colonnes(gauche, droite, rapport: (1fr, 1fr)) = grid(
  columns: rapport, column-gutter: 16pt, align: top, gauche, droite,
)

// --------------------------------------------
#d("Objectif du TD")[
  #annonce[
    Ajouter à `stats_trace.py` l'option `--profil`, qui écrit le profil de la trace dans
    `profil.csv` : la distance parcourue depuis le départ, et l'altitude, à chaque position.
  ]

  #deux-colonnes(
    test(
      titre: [À la fin du TD],
      "$ python stats_trace.py trace.csv --profil",
      "…",
      "cumul en baisse : 50.3 m",
      "profil : profil.csv, 60 positions",
    ),
    panneau[`profil.csv`][
      #terminal(titre: "profil.csv", taille: 15pt,
        "distance,altitude", "0.0,79.6", "18.8,78.8", "63.4,79.9", "…", "1906.7,127.7")
    ],
  )

  #legende[
    La dernière distance est la distance parcourue du TD 4a. Dans un tableur, un graphique
    en nuage de points sur les deux colonnes donne la courbe de l'altitude selon la distance.
  ]

  #notes[
    Le programme de départ est celui de la fin du TD 4a v2, étape B6. Le travail sur le code
    est court : la séance porte sur GitHub, le push et la pull request.
  ]
]

// --------------------------------------------
#d("Adresses du TD")[
  #annonce[
    Deux dépôts sur GitHub : le dépôt modèle du module, puis votre copie, créée à
    l'étape 1. `<compte>` : le nom de votre compte GitHub, en haut du menu de l'icône du
    compte, en haut à droite.
  ]

  #show table.cell: set text(size: 15pt)
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Dépôt], [Adresse],
    [modèle du module, à ouvrir dans le navigateur], [`https://github.com/geodata-ing1-info-01/td7a-trace`],
    [votre dépôt, dans le navigateur], [`https://github.com/<compte>/td7a-trace`],
    [votre dépôt, pour `git clone`], [`https://github.com/<compte>/td7a-trace.git`],
  )

  #legende[
    Toutes les adresses commencent par `https://`. Une adresse en `git@github.com:…` passe par
    le port 22, fermé par le pare-feu de l'école.
  ]

  #notes[
    En 2026, l'adresse du dépôt de départ n'était donnée que dans une commande, et les
    élèves ne savaient pas toujours quel dépôt cloner.

    Le dépôt modèle est à créer sur le compte du module, avec la branche `master`, puis à
    marquer « Template repository » (Settings, General). Son contenu :
    `data/cours7_v2/depot_modele/`.
  ]
]

// --------------------------------------------
#d("Les étapes du TD")[
  #objectif[
    obtenir sur GitHub un dépôt `td7a-trace` dont la branche `master` contient l'option
    `--profil`, fusionnée par une pull request.
  ]

  #let etape(titre, detail, hauteur: auto) = block(
    width: 100%, height: hauteur, inset: (x: 8pt, y: 6pt), fill: white,
    stroke: 1pt + accent.lighten(55%),
  )[
    #align(center + horizon)[
      #text(size: 13pt, weight: demi-gras)[#titre] \
      #text(size: 12pt)[#detail]
    ]
  ]
  #chaine(gabarit: etape, ecart: 16pt,
    ([1 · GitHub], [copie du dépôt modèle sur son compte]),
    ([2 · Clone], [clone en HTTPS, puis lancement du programme]),
    ([3 · Branche], [option `--profil`, puis écriture du profil : deux commits]),
  )
  #v(6pt)
  #chaine(gabarit: etape, ecart: 16pt,
    ([4 · Push], [création du token, puis premier `git push`]),
    ([5 · Fusion], [pull request, fusion sur GitHub, puis `git pull`]),
    ([6 · README (facultative)], [README sur `master`, puis second `git push`]),
  )

  #legende[
    En cas d'échec du push avec le token : diapositive « Secours · Connexion par le
    navigateur », à la fin du TD.
  ]

  #notes[
    Durées indicatives : étapes 1 et 2, 15 min ; étape 3, 25 min ; étape 4, 20 min ; étape
    5, 15 min. L'étape facultative et la suppression du token, en fin de séance.

    En 2026, les élèves n'ont pas eu le temps de faire toutes les étapes : le TD garde une
    seule pull request.

    À relever sur un poste de la salle : les pages de GitHub et les fenêtres de Windows,
    dessinées dans le guide et sur ces diapositives.
  ]
]

// --------------------------------------------
#d("Étape 1 · Copie du dépôt modèle")[
  #objectif[
    créer sur son compte GitHub le dépôt `td7a-trace`, copie du dépôt modèle du module.
  ]

  #deux-colonnes(rapport: (1fr, 1fr),
    consignes(
      taille: 15pt,
      [Se connecter à GitHub, puis ouvrir `https://github.com/geodata-ing1-info-01/td7a-trace`.],
      [Cliquer sur « Use this template » #pastille(1), puis sur « Create a new repository ».],
      [Owner : son compte. Repository name : `td7a-trace`. Laisser « Public ».],
      [Cliquer sur « Create repository ».
        #constat[La page de son dépôt s'ouvre, à l'adresse `github.com/<compte>/td7a-trace`.]],
    ),
    text(size: 12pt, page-depot("geodata-ing1-info-01", "td7a-trace", modele: true,
      fichiers: (".gitignore", "README.md", "stats_trace.py", "trace.csv", "trace_2.csv"),
      reperes: (modele: 1))),
  )

  #legende[
    La copie a un seul commit, « Initial commit », et sa propre adresse. Guide, étape 1.
  ]

  #notes[
    « Use this template » copie les fichiers, sans l'historique, sur le compte de l'élève.
    Les pull requests du TD se font dans ce dépôt, celui de l'élève. Avec un fork, elles
    viseraient par défaut le dépôt du module.
  ]
]

// --------------------------------------------
#d("Étape 2 · Clone en HTTPS")[
  #objectif[
    décompresser l'archive `info01-cours7.zip`, puis copier son dépôt `td7a-trace` dans
    `cours7/7a_trace/travail/`, avec l'adresse HTTPS de son dépôt.
  ]

  #consignes(
    taille: 14pt,
    [Copier l'archive `info01-cours7.zip` de `formationTemp` dans le dossier `info01` du Bureau.],
    [Ouvrir Git Bash depuis le menu Démarrer.],
    [Aller dans le dossier `~/Desktop/info01`, puis décompresser l'archive : #commandes("cd ~/Desktop/info01", "unzip info01-cours7.zip")],
    [Aller dans le dossier `travail` du TD : #commandes("cd cours7/7a_trace/travail")],
    [Sur la page de son dépôt, cliquer sur Code, onglet HTTPS, puis copier l'adresse #pastille(1).],
    [Cloner son dépôt, en collant l'adresse après `git clone` : #comment[clic droit, Paste, ou Maj + Inser.] #commandes("git clone https://github.com/<compte>/td7a-trace.git")
      #constat[`Clonage dans 'td7a-trace'...`, puis des lignes `remote:` ; un dossier `td7a-trace/` dans `travail/`.]],
  )

  #align(right, text(size: 12pt, menu-code("https://github.com/<compte>/td7a-trace.git", repere: 1)))

  #notes[
    Le clone d'un dépôt public ne demande pas de s'identifier. L'identification vient au
    premier push, à l'étape 4.

    `Repository not found` : `<compte>` n'a pas été remplacé, ou le nom du dépôt diffère.

    À relever sur un poste de la salle : la sortie de `git clone` depuis GitHub.
  ]
]

// --------------------------------------------
#d("Étape 2 · Projet dans VS Code")[
  #objectif[
    ouvrir le dossier `td7a-trace` dans VS Code, y indiquer son identité pour git, puis lancer
    le programme.
  ]

  #deux-colonnes(rapport: (1.1fr, 1fr),
    consignes(
      taille: 15pt,
      [Ouvrir le dossier du clone dans VS Code : #comment[File, Open Folder…, `Desktop\info01\cours7\7a_trace\travail\td7a-trace`.]],
      [Dans un terminal de VS Code, indiquer son identité pour ce dépôt : #commandes("git config user.name \"Prénom Nom\"", "git config user.email prenom.nom@ensg.eu")],
      [Lancer le programme : `python stats_trace.py trace.csv --distance`.],
    ),
    test(
      "$ python stats_trace.py trace.csv --distance",
      "altitude minimale : 78.8 m",
      "…",
      "cumul en baisse : 50.3 m",
      "distance parcourue : 1906.7 m",
    ),
  )

  #legende[
    Guide, étape 2.
  ]

  #notes[
    `git config` sans `--global`, comme aux TD 2c et 6a : le compte Windows `eleve` est
    commun.
  ]
]

// --------------------------------------------
#d("Étape 3 · Option --profil")[
  #objectif[
    sur une branche `profil`, ajouter à `stats_trace.py` l'option `--profil`, qui affiche pour
    l'instant un message.
  ]

  #deux-colonnes(
    consignes(
      taille: 14pt,
      [Créer la branche et y passer : `git checkout -b profil`.],
      [Sous la déclaration de `--vitesse`, déclarer l'option `--profil`, avec le texte d'aide `écrit le profil altimétrique dans profil.csv`.],
      [Dans la boucle de lecture, ajouter `or options.profil` à la condition du bloc qui garde les positions.],
      [À la fin du fichier, ajouter le bloc `if options.profil:`, qui affiche `profil : calcul manquant`.],
      [Enregistrer le fichier, puis lancer le test.],
    ),
    stack(
      spacing: 10pt,
      test(
        "$ python stats_trace.py trace.csv --profil",
        "…",
        "cumul en baisse : 50.3 m",
        "profil : calcul manquant",
      ),
      commit("L'option --profil"),
    ),
  )

  #legende[
    Même ordre qu'au TD 4a : l'option, puis le calcul. Guide, étape 3.
  ]
]

// --------------------------------------------
#d("Étape 3 · Écriture du profil")[
  #objectif[
    écrire dans `profil.csv` la distance cumulée et l'altitude de chaque position, puis écarter
    `profil.csv` des commits.
  ]

  #deux-colonnes(
    consignes(
      taille: 14pt,
      [Sous `distance_parcourue`, écrire la fonction `profil(points)`, qui renvoie la liste des tuples `(distance cumulée, altitude)`, en partant de `(0, altitude de la position 0)`.],
      [Dans le bloc `if options.profil:`, remplacer le message par l'écriture de `profil.csv` : la ligne `distance,altitude`, puis une ligne par tuple.],
      [Afficher `profil : profil.csv, ` suivi du nombre de positions.],
      [Ajouter la ligne `profil.csv` à `.gitignore`.],
      [Enregistrer, lancer le test, puis ouvrir `profil.csv` dans VS Code.],
    ),
    stack(
      spacing: 10pt,
      test(
        "$ python stats_trace.py trace.csv --profil",
        "…",
        "profil : profil.csv, 60 positions",
      ),
      panneau[Commit][
        #block(above: 0pt, text(size: 15pt, stack(
          spacing: 5pt, raw("git add stats_trace.py .gitignore"),
          raw("git commit -m \"Le profil altimétrique\""),
        )))
      ],
    ),
  )

  #legende[
    `profil.csv` commence par `0.0,79.6` et finit par `1906.7,127.7`, la distance parcourue.
    Guide, étape 3 : le code de la fonction.
  ]

  #notes[
    La fonction reprend la boucle de `distance_parcourue`, en gardant le total à chaque
    position. `points[i][2]` : l'altitude, troisième valeur du tuple.

    `profil.csv` est refait à chaque lancement : il n'a rien à faire dans l'historique, comme
    `resume.txt`.
  ]
]

// --------------------------------------------
#d("Étape 4 · Création du token")[
  #objectif[
    créer sur GitHub un token valable 7 jours, avec le droit `repo`, et le copier.
  ]

  #deux-colonnes(rapport: (1fr, 1.05fr),
    consignes(
      taille: 14pt,
      [Ouvrir le formulaire : #comment[menu du compte, Settings, Developer settings, Personal access tokens, Tokens (classic), Generate new token (classic).]],
      [Note : `td7a` #pastille(1). Expiration : 7 days #pastille(2). Cocher `repo` #pastille(3).],
      [Cliquer sur « Generate token » #pastille(4).],
      [Copier le token avec le bouton à sa droite, puis le coller dans un nouveau fichier de Notepad++, sans l'enregistrer. #comment[GitHub ne l'affiche qu'une fois.]],
    ),
    text(size: 11pt, formulaire-token(reperes: (note: 1, expiration: 2, repo: 3, generer: 4))),
  )

  #legende[
    Le token remplace le mot de passe du compte pour `git push` : cours 6, « Accès à GitHub par
    token ».
  ]

  #notes[
    Le fichier n'est pas enregistré : le token ne reste pas sur le disque de cet ordinateur, que d'autres élèves emploient.
    S'il est perdu, en créer un autre.
  ]
]

// --------------------------------------------
// Le premier push, de deux façons : par la fenêtre de Git Credential Manager, ou par les
// questions de Git dans la fenêtre Git Bash. Garder l'une des deux après l'essai sur un
// poste de la salle, avec ses lignes du tableau des messages d'erreur.
#d("Étape 4 · Push par la fenêtre de connexion")[
  #objectif[
    envoyer la branche `profil` sur GitHub depuis le terminal de VS Code, en donnant le token
    dans la fenêtre de Git Credential Manager.
  ]

  #consignes(
    taille: 14pt,
    [Ouvrir le Gestionnaire d'identification de Windows, Informations d'identification Windows, et supprimer `git:https://github.com` s'il existe. #comment[Menu Démarrer, « Gestionnaire d'identification ».]],
    [Dans le terminal de VS Code, envoyer la branche : #commandes("git push -u origin profil")],
    [Dans la fenêtre « Connect to GitHub » : onglet Token, coller le token avec Ctrl + V, puis cliquer sur « Sign in ».],
  )

  #test(taille: 13pt,
    "To https://github.com/<compte>/td7a-trace.git",
    " * [new branch]      profil -> profil",
    "la branche 'profil' est paramétrée pour suivre 'origin/profil'.",
  )

  #notes[
    Git Credential Manager est installé et activé avec Git for Windows. Git lui passe la main,
    dans Git Bash comme dans le terminal de VS Code, et il ouvre sa propre fenêtre. Il garde
    ensuite le token dans le Gestionnaire d'identification : le push suivant ne demande rien.

    La première consigne retire l'identifiant d'un compte qui aurait déjà poussé depuis le
    poste : Git Credential Manager le donnerait à GitHub sans rien demander.

    GitHub ajoute deux lignes `remote:` avec l'adresse d'une pull request.

    À relever sur un poste de la salle : la sortie complète du premier push, lignes
    `remote:` comprises.
  ]
]

// --------------------------------------------
#d("Étape 4 · Fenêtre de connexion")[
  #annonce[
    Au premier push, Git Credential Manager ouvre cette fenêtre. L'onglet Token reçoit le
    token copié dans Notepad++.
  ]

  #grid(
    columns: (1fr, 1fr), column-gutter: 18pt, align: horizon,
    text(size: 13pt, fenetre-connexion(onglet: "token", reperes: (onglet: 1, champ: 2, valider: 3))),
    [
      #set text(size: 15pt)
      #stack(spacing: 0.6em,
        [#pastille(1) l'onglet Token],
        [#pastille(2) le token, collé avec Ctrl + V],
        [#pastille(3) la validation],
      )
      #v(0.6em)
      #text(size: 14pt, fill: estompe)[Au push suivant, Git ne demande plus rien : Windows a gardé le token.]
    ],
  )

  #notes[
    Fenêtre dessinée d'après Git Credential Manager 2.x ; disposition à vérifier sur un poste
    de la salle, et à remplacer par une capture dans le guide.
  ]
]

// --------------------------------------------
#d("Étape 4 · Push par le terminal")[
  #objectif[
    envoyer la branche `profil` sur GitHub depuis la fenêtre Git Bash, en répondant aux deux
    questions de Git : le nom du compte, puis le token.
  ]

  #consignes(
    taille: 14pt,
    [Dans la fenêtre Git Bash, aller dans le clone, puis retirer Git Credential Manager de ce dépôt : #commandes("cd ~/Desktop/info01/cours7/7a_trace/travail/td7a-trace", "git config credential.helper \"\"")],
    [Envoyer la branche : `git push -u origin profil`.],
    [À `Username` : taper le nom de son compte GitHub, puis Entrée. #comment[Le nom de l'adresse `github.com/<compte>/td7a-trace`.]],
    [À `Password` : coller le token avec Maj + Inser, puis Entrée. #comment[Rien ne s'affiche, ni le token ni des étoiles.]],
  )

  #test(taille: 14pt,
    "$ git push -u origin profil",
    "Username for 'https://github.com': <compte>",
    "Password for 'https://<compte>@github.com':",
    "To https://github.com/<compte>/td7a-trace.git",
    " * [new branch]      profil -> profil",
    "la branche 'profil' est paramétrée pour suivre 'origin/profil'.",
  )

  #notes[
    `git config credential.helper ""`, sans `--global`, vide la liste des gestionnaires
    d'identifiants pour ce seul dépôt : Git pose ses questions lui-même, et ne garde pas le
    token. Le poste et le compte Windows `eleve` ne changent pas. `git config --unset
    credential.helper` rend la main à Git Credential Manager.

    La fenêtre Git Bash, parce que VS Code prend à son compte les questions de Git dans son
    terminal (variable `GIT_ASKPASS`) : une boîte en haut de sa fenêtre, ou une proposition
    de connexion à GitHub.

    GitHub ne vérifie pas le nom du compte, seulement le token (documentation de GitHub,
    « Managing your personal access tokens »). Ctrl + V peut ne pas coller dans Git Bash.

    Questions relevées avec git 2.43 et un serveur local qui refuse l'accès : elles ne sont
    pas traduites.
  ]
]

// --------------------------------------------
#d("Étape 4 · Messages d'erreur au push")[
  #show table.cell: set text(size: 11.5pt)
  #show raw: set text(size: 10.5pt)
  #tableau(
    columns: (1.2fr, 1fr),
    align: left + horizon,
    [Message], [Cause et solution],
    [`Invalid username or token. Password authentication is not supported`, puis `Échec d'authentification`], [mot de passe du compte saisi, token mal collé ou expiré : relancer le push et coller le token ; sinon, créer un autre token],
    [`Permission to <compte>/td7a-trace.git denied to <autre compte>`, puis `error: 403`], [identifiant d'un autre compte gardé par Windows : le supprimer du Gestionnaire d'identification, puis relancer],
    [`Permission to <compte>/td7a-trace.git denied to <compte>`], [token sans le droit `repo` : en créer un autre, `repo` coché],
    [`Permission to geodata-ing1-info-01/td7a-trace.git denied to <compte>`], [clone fait avec l'adresse du dépôt modèle : `git remote set-url origin https://github.com/<compte>/td7a-trace.git`, puis relancer],
    [`Repository not found`], [adresse erronée : `git remote -v` affiche l'adresse du clone],
    [une boîte de VS Code demande `Username`, ou propose une connexion à GitHub], [push lancé dans le terminal de VS Code, sans Git Credential Manager : le relancer depuis la fenêtre Git Bash],
    [la fenêtre ou la question ne vient pas, le push attend], [fenêtre cachée derrière VS Code : la chercher dans la barre des tâches ; sinon, diapositive « Secours »],
  )

  #notes[
    Messages de GitHub relevés dans sa documentation et sur les forums ; ils commencent par
    `remote:`. `Échec d'authentification pour …` est le message de git en français
    (`Authentication failed for …` en anglais). Les messages plus anciens de GitHub disent
    `Support for password authentication was removed on August 13, 2021`.

    Ligne 2 : push par la fenêtre de connexion seulement. Ligne 6 : push par le terminal
    seulement. Chacune se retire avec la diapositive de sa méthode, si celle-ci est écartée.

    À relever sur un poste de la salle : le message d'un push vers le dépôt modèle (ligne 4).
  ]
]

// --------------------------------------------
#d("Étape 5 · Pull request et fusion")[
  #objectif[
    fusionner la branche `profil` dans `master` sur GitHub, par une pull request, puis ramener
    la fusion sur le poste.
  ]

  #deux-colonnes(rapport: (1.05fr, 1fr),
    consignes(
      taille: 14pt,
      [Sur la page de son dépôt, cliquer sur « Compare & pull request », puis sur « Create pull request ».],
      [Sur la page de la pull request, cliquer sur « Merge pull request », puis sur « Confirm merge ».],
      [Dans VS Code, revenir sur `master`, puis ramener la fusion : #commandes("git checkout master", "git pull")],
      [Afficher le graphe : `git log --oneline --graph`.],
    ),
    test(taille: 13pt,
      "$ git log --oneline --graph",
      "*   f58602e Merge pull request #1 from <compte>/profil",
      "|\\",
      "| * fa52c72 Le profil altimétrique",
      "| * f3484f4 L'option --profil",
      "|/",
      "* 88b09fe Initial commit",
    ),
  )

  #legende[
    Les identifiants diffèrent d'un dépôt à l'autre. Guide, étape 5.
  ]

  #notes[
    Avant le `git pull`, le `master` du poste est en retard de trois commits : les deux de la
    branche `profil`, et celui de la fusion, écrit par GitHub. `git pull` les ramène en avance
    rapide (Fast-forward).
  ]
]

// --------------------------------------------
#d("Étape 6 (facultative) · README et second push")[
  #objectif[
    décrire l'option `--profil` dans `README.md`, sur `master`, puis envoyer ce commit sur
    GitHub.
  ]

  #consignes(
    taille: 15pt,
    [Dans `README.md`, ajouter au tableau des options la ligne de `--profil`.],
    [Faire le commit : #commandes("git add README.md", "git commit -m \"L'option --profil dans le README\"")],
    [Envoyer le commit : `git push`, dans le terminal du premier push. #comment[Si Git demande le compte et le token : les donner comme à l'étape 4.]
      #constat[Par la fenêtre de connexion, Git ne demande rien : Windows a gardé le token. Par le terminal, Git redemande le compte et le token.]],
    [Sur la page de son dépôt, vérifier que le README affiche la ligne.],
  )

  #legende[
    Un commit sur `master`, envoyé sans pull request : pour une modification de la
    documentation seule.
  ]
]

// --------------------------------------------
#d("Fin du TD · Suppression du token")[
  #objectif[
    retirer le token du poste et de GitHub, pour que l'élève suivant ne puisse pas s'en servir.
  ]

  #deux-colonnes(rapport: (1.1fr, 1fr),
    consignes(
      taille: 15pt,
      [Dans le Gestionnaire d'identification de Windows, Informations d'identification Windows : supprimer `git:https://github.com` s'il existe #pastille(1).],
      [Sur GitHub, dans Personal access tokens, Tokens (classic) : cliquer sur « Delete » à côté du token `td7a`.],
      [Fermer le fichier où le token a été collé, sans l'enregistrer.],
    ),
    text(size: 12pt, gestionnaire-identification(repere: 1)),
  )

  #notes[
    Le compte Windows `eleve` est commun à tous les élèves : diapositive « Token sur un poste
    partagé », cours 6.
  ]
]

// --------------------------------------------
// Secours : la connexion par le navigateur, si le token échoue. En 2026, depuis Git Bash,
// elle n'a pas fonctionné : elle reste une solution de repli.
#d("Secours · Connexion par le navigateur")[
  #annonce[
    Si le push échoue avec le token, Git Credential Manager peut ouvrir une connexion à GitHub
    dans le navigateur, sans token.
  ]

  #grid(
    columns: (1fr, 1fr), column-gutter: 18pt, align: top,
    text(size: 13pt, fenetre-connexion(onglet: "navigateur", reperes: (onglet: 1, valider: 2))),
    consignes(
      taille: 14pt,
      [Si le push s'est fait par le terminal, rendre la main à Git Credential Manager : `git config --unset credential.helper`.],
      [Supprimer `git:https://github.com` du Gestionnaire d'identification, puis relancer `git push -u origin profil`.],
      [Dans la fenêtre « Connect to GitHub », onglet Browser/Device #pastille(1) : cliquer sur « Sign in with your browser » #pastille(2).],
      [Dans le navigateur, se connecter à son compte, puis cliquer sur « Authorize git-ecosystem ».],
      [Revenir au terminal : le push se termine.],
    ),
  )

  #legende[
    Si le navigateur est déjà connecté au compte d'un autre élève : s'en déconnecter d'abord sur
    github.com, puis relancer le push.
  ]

  #notes[
    Le push depuis le terminal de VS Code passe par le même Git Credential Manager. Si la
    fenêtre ne s'ouvre pas du tout, `git config --get credential.helper` doit afficher
    `manager` : à vérifier sur un poste de la salle avant la séance.
  ]
]
