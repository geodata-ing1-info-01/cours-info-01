// Cours 5, partie 4 — les secrets de vos programmes. Incluse par `cours5.typ`.
#import "../../../commun/prelude.typ": *
#import "../style.typ": terminal

#separateur(
  "Les secrets de vos programmes",
  annonce: "Un jeton d'API, token en anglais, est un mot de passe utilisé par un programme. Il se perd des mêmes façons qu'un mot de passe, et aussi par le dépôt git.",
)

// --------------------------------------------
#d("Ce qui est un secret")[
  #annonce[
    Un secret donne accès à quelque chose. Il ne va ni dans un dépôt, ni
    dans un message, ni dans une capture d'écran.
  ]

  #face-a-face(
    panneau("À garder")[
      #tableau(
        columns: (auto, 1fr),
        align: (left + horizon, left + horizon),
        [Quoi], [Donne accès à],
        [#text(fill: brun, weight: demi-gras)[clé privée SSH]], [vos comptes, vos serveurs],
        [#text(fill: brun, weight: demi-gras)[mot de passe]], [un compte],
        [#text(fill: brun, weight: demi-gras)[jeton d'API (#emph[token])]], [un service payant ou limité, de cartographie ou d'IA],
        [#text(fill: brun, weight: demi-gras)[fichier `.env`, `config.py`]], [là où sont rangés les trois précédents],
      )
    ],
    panneau("À partager")[
      #tableau(
        columns: (auto, 1fr),
        align: (left + horizon, left + horizon),
        [Quoi], [Pourquoi],
        [#text(fill: attention, weight: demi-gras)[clé publique SSH]], [ne sert à rien sans la privée],
        [#text(fill: attention, weight: demi-gras)[le code]], [le travail rendu],
        [#text(fill: attention, weight: demi-gras)[README, `environment.yml`]], [ils permettent de relancer le code],
        [#text(fill: attention, weight: demi-gras)[données publiques]], [orthophotos, BD TOPO],
      )
    ],
  )

  #notes[
    Jeton d'API : une chaîne que le script envoie au service pour s'identifier.
    Les documentations disent *token*, ou « clé d'API ». Le quota ou la facture
    va sur le compte du jeton.

    Les données personnelles d'autres personnes (noms, adresses) relèvent du
    RGPD : jamais dans un dépôt public.
  ]
]

// --------------------------------------------
#d("Un secret dans un dépôt y reste")[
  #annonce[
    Le commit qui supprime le fichier ne supprime pas le commit qui l'a
    ajouté. `git log -p` affiche les deux.
  ]

  #terminal("Anaconda Prompt", "> git log --oneline
b638a2d Supprime la clé du dépôt
9cb1911 Premier script de carte
> git log -p -- config.py
commit b638a2d  Supprime la clé du dépôt
    -CLE_API = \"d7f3a9c1e5b24086\"
commit 9cb1911  Premier script de carte
    +CLE_API = \"d7f3a9c1e5b24086\"")

  #legende[
    Sortie réelle, abrégée. En 2025, 28,65 millions de secrets ont été
    ajoutés dans des commits publics sur GitHub ; 64 % de ceux trouvés en 2022
    étaient encore valides en 2026 (GitGuardian, *State of Secrets Sprawl 2026*).
  ]

  #notes[
    Des programmes lisent les commits publics en continu et testent les clés
    trouvées : un secret poussé est copié avant d'être supprimé.

    Le TD 5c rejoue cette sortie ; il est facultatif.
  ]
]

// --------------------------------------------
#d("Séparer le code et les secrets")[
  #annonce[
    Le code lit le secret dans un fichier que git ignore. Le dépôt contient
    un modèle de ce fichier, sans la valeur.
  ]

  #face-a-face(
    panneau("Dans le dépôt, pour tout le monde")[
      #block(width: 100%, inset: (x: 12pt, y: 10pt), fill: gris)[
        #set text(size: 17pt)
        #raw(block: true, "carte.py            import config
                    cle = config.CLE_API
config.example.py   CLE_API = \"à remplir\"
.gitignore          config.py
README.md")
      ]
    ],
    panneau("Sur votre poste seulement")[
      #block(width: 100%, inset: (x: 12pt, y: 10pt), stroke: 1.2pt + brun)[
        #set text(size: 17pt)
        #raw(block: true, "config.py           CLE_API = \"d7f3a9c1e5b24086\"")
      ]
      #v(0.5em)
      #text(size: 15pt, fill: estompe)[
        Qui clone le dépôt copie `config.example.py` en `config.py` et y met
        sa propre clé. `git status` ne liste jamais `config.py`.
      ]
    ],
  )

  #notes[
    C'est le `.gitignore` du cours 2. Un fichier `.env` lu par le programme suit
    le même principe.

    Avant de committer : `git status` ne doit pas lister le fichier du secret.
    Les forges détectent une partie des jetons poussés ; ne pas compter dessus.
  ]
]

// --------------------------------------------
#d("Si un secret a fui")[
  #annonce[
    Supprimer le fichier ne suffit pas. Le secret est d'abord rendu inutile,
    puis remplacé.
  ]

  #chaine(
    ("Révoquer", "régénérer la clé sur le service qui l'a émise"),
    ("Remplacer", "mettre la nouvelle dans le fichier ignoré"),
    ("Nettoyer", "réécrire l'historique, ou recréer le dépôt"),
    ("Prévenir", "le responsable du projet ou du service"),
    gabarit: bloc, pleins: (0,),
  )

  #legende[
    Révoquer d'abord : l'historique a peut-être déjà été copié.
  ]

  #notes[
    Réécrire l'historique : `git filter-repo`, hors programme. Sur un petit
    projet, recréer le dépôt est plus simple.

    Mot de passe personnel qui a fui : le changer sur le site concerné, puis
    partout où il était réutilisé.
  ]
]

// --------------------------------------------
#d("Mises à jour et sauvegardes")[
  #annonce[
    Une mise à jour corrige une faille connue et publiée. Une sauvegarde
    permet de retrouver ses fichiers après la perte, le vol ou le chiffrement
    d'un poste.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [], [Mises à jour], [Sauvegardes],
    [Quoi], [système, navigateur, Anaconda, les applications du téléphone], [ce qui ne se refait pas : documents, données, photos],
    [Quand], [dès qu'elles sont proposées], [régulièrement, en automatique],
    [Règle], [redémarrer quand c'est demandé], [3-2-1 : trois copies, deux supports, une hors du poste],
    [Pour le code], [`conda update`, de temps en temps], [un dépôt poussé sur la forge est une copie du code ; les données ignorées par git sont à sauvegarder à part],
  )

  #notes[
    Une faille publiée est exploitée dans les jours qui suivent.

    Pour un étudiant : la forge garde le code et le rapport. Les données
    lourdes, ignorées par git, vont sur un disque externe ou l'espace de
    stockage de l'école.

    Mesures de cybermalveillance.gouv.fr non traitées : antivirus (celui de
    Windows suffit), applications des magasins officiels, Wi-Fi public,
    séparation des usages personnels et professionnels.
  ]
]
