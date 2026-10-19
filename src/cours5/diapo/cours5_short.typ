// Cours 5, version courte : neuf diapositives du cours 5, présentées en tête
// du cours 6 (20 octobre 2026), la séance 5 n'ayant pas eu lieu.
//
// Les diapositives sont reprises de `parties/`, sans séparateur. Trois sont
// des fusions : « Ordres de grandeur : temps d'accès » avec « Si la mémoire
// vive valait une seconde », « Une clé à la place du mot de passe » avec
// « La connexion SSH », « Un secret dans un dépôt y reste » avec « Séparer
// le code et les secrets ». Les schémas sont ceux de `schemas.typ`.
//
//   typst compile --root . src/cours5/diapo/cours5_short.typ
//   typst compile --root . --input notes=true src/cours5/diapo/cours5_short.typ src/cours5/diapo/cours5_short-notes.pdf

#import "../../commun/prelude.typ": *
#import "schemas.typ": schema-composants, pyramide-memoire, barres-temps, schema-pixels, schema-client-serveur, schema-connexion, schema-echange-ssh, repere

#show: diapos.with(
  titre-court: "Introduction à l'informatique",
  auteur-court: "1re année géomatique",
)

#page-titre(
  titre: "Cours 5",
  sous-titre: "Matériel, réseau, mots de passe, clés SSH et secrets",
  auteur: "1re année géomatique",
  date: "20 octobre",
)

// --------------------------------------------
#d("Les composants d'un ordinateur")[
  #align(center, schema-composants())

  #notes[
    Carte graphique : conçue pour calculer l'image affichée, utilisée aujourd'hui
    pour le calcul parallèle (diapositive « Processeur et carte graphique »).

    Carte réseau : câble ou Wi-Fi.

    Alimentation : convertit le 230 V du secteur en 12 V, 5 V et 3,3 V.

    Un portable et un téléphone ont les mêmes composants, soudés sur une seule
    carte.
  ]
]

// --------------------------------------------
#d("Hiérarchie des mémoires")[
  #annonce[
    Les types de mémoire sont rangés selon leur proximité du processeur, le
    plus proche en haut.
  ]

  #align(center, pyramide-memoire())

  #notes[
    Plus l'étage est proche du processeur, plus il est petit et rapide : les
    deux colonnes le montrent. Le réseau garde les données sur un autre
    ordinateur, que l'extinction du poste ne touche pas.

    Au cours 1 : un fichier conserve un résultat après l'arrêt du programme.
    Il le peut parce qu'il est sur le disque.

    Le cache est une petite mémoire dans le processeur ; il garde les dernières
    données lues en mémoire vive. Une boucle sur des valeurs voisines est donc
    plus rapide qu'une boucle qui saute dans un tableau.

    Le réseau est un étage de plus, au-delà du disque.
  ]
]

// --------------------------------------------
// Fusion de « Ordres de grandeur : temps d'accès » et de « Si la mémoire
// vive valait une seconde ».
#d("Ordres de grandeur : temps d'accès")[
  #annonce[
    De la nanoseconde à la demi-seconde, sur une échelle logarithmique :
    chaque graduation vaut dix fois la précédente.
  ]

  #barres-temps(echelle: [si la mémoire vive valait 1 s], interligne: 3pt, (
    ([cache du processeur], 1e-9, [1 ns], accent, [un centième de seconde]),
    ([mémoire vive], 1e-7, [100 ns], accent, [1 seconde]),
    ([SSD], 1e-4, [100 µs], accent, [un quart d'heure]),
    ([disque dur], 1e-2, [10 ms], accent, [une journée]),
    ([réseau de la salle], 5e-4, [0,5 ms], attention, [une heure et demie]),
    ([Paris – Marseille], 1.3e-2, [13 ms], attention, [un jour et demi]),
    ([Paris – New York], 7.5e-2, [75 ms], attention, [une semaine]),
    ([Paris – Sydney], 2.7e-1, [270 ms], attention, [un mois]),
  ))

  #legende[
    Temps d'un accès ou d'un aller-retour, valeurs typiques ; réseau mesuré
    depuis Paris (wondernetwork.com, septembre 2026).
  ]

  #notes[
    Colonne de droite : les mêmes temps multipliés par dix millions.

    Du cache au disque dur, chaque étage prend cent à mille fois plus de temps
    que le précédent. Les temps réseau, en bleu clair, commencent au niveau du
    disque dur.

    Pendant une lecture sur le disque dur, le processeur pourrait faire
    l'équivalent d'une journée d'accès à la mémoire ; pendant un aller-retour
    vers New York, une semaine.

    Construction reprise de Brendan Gregg, *Systems Performance*, avec le cycle
    du processeur pour unité.

    Conséquences pour un programme, à dire :
    - lire un fichier une fois et garder son contenu en mémoire ;
    - écrire des nombres en binaire (images P5, cours 3) ;
    - numpy à la place d'une boucle Python (projet 7) ;
    - `commit` en local, `push` sur le réseau (la suite de la séance).
  ]
]

// --------------------------------------------
#d("Processeur et carte graphique : une image")[
  #annonce[
    Éclaircir une image applique la même multiplication à chaque pixel. Le
    processeur traite les pixels quatre par quatre, la carte graphique tous à
    la fois.
  ]

  #align(center, schema-pixels())

  #notes[
    Dalle de 5 000 × 5 000 pixels : 25 millions de pixels, 3 millions d'étapes
    sur 8 cœurs, 1 500 sur 16 000 cœurs. L'écart réel est plus faible : un cœur
    de processeur est plus rapide, traite plusieurs valeurs par instruction, et
    l'image doit être copiée dans la mémoire de la carte.

    La carte graphique n'accélère que la même opération sur beaucoup de données.

    Dans le module : numpy (projet 7) applique une opération à tout un tableau,
    sur le processeur. Le calcul sur carte graphique relève des cours de
    traitement d'image et d'apprentissage.
  ]
]

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
#d("Quatre façons d'obtenir un mot de passe")[
  #annonce[
    Le mot de passe se lit à trois endroits : la table, le réseau, le poste.
    Il peut aussi être deviné.
  ]

  #align(center, schema-connexion(
    entetes: ("identifiant", "mot de passe"),
    lignes: (
      ("alice", "Marseille2024!"),
      ("bob", "123456"),
      ("chloé", "123456"),
    ),
    reperes: true,
  ))

  #v(0.3em)
  #set text(size: pt-footnotesize)
  #grid(
    columns: (auto, 1fr, auto, 1fr), column-gutter: 10pt, row-gutter: 9pt,
    align: (center + horizon, left + horizon),
    repere(1), [lire la table : une fuite de données du site],
    repere(2), [deviner : essayer des mots de passe au formulaire],
    repere(3), [intercepter : lire le réseau s'il n'est pas chiffré],
    repere(4), [le prendre sur le poste : hameçonnage, logiciel espion],
  )

  #legende[
    22 % des intrusions commencent par un identifiant et un mot de passe
    volés (Verizon, *Data Breach Investigations Report* 2025). Le site
    haveibeenpwned.com indique les fuites où figure une adresse de courriel.
  ]

  #notes[
    Parades, à dire (la diapositive « Une parade par menace » n'est pas
    reprise) : (1) l'empreinte, avec un sel et un calcul lent, à la charge du
    site ; (2) un mot de passe long, tiré au hasard, différent sur chaque
    site, donc un gestionnaire de mots de passe ; (3) le chiffrement du
    trajet, HTTPS, SSH, WPA ; (4) le deuxième facteur, diapositive suivante.

    Le mot de passe de la messagerie d'abord : il réinitialise tous les
    autres. Le gestionnaire du navigateur ou du téléphone suffit pour
    commencer ; KeePassXC et Bitwarden sont les deux libres courants.

    Un mot de passe obtenu est ensuite essayé sur les autres sites. 60 à 84 %
    des personnes interrogées réutilisent un mot de passe (Bitwarden, GoDaddy,
    2025).
  ]
]

// --------------------------------------------
#d("Le deuxième facteur")[
  #annonce[
    Il existe trois sortes de preuves d'identité, appelées facteurs. Un
    deuxième facteur ajoute au mot de passe une preuve d'une autre sorte.
  ]

  #grid(
    columns: (1fr, 1fr, 1fr), gutter: 14pt, rows: 56pt,
    bloc("Ce que je sais", "un mot de passe", plein: true, hauteur: 100%),
    bloc("Ce que je possède", "un téléphone, une clé physique", plein: true, hauteur: 100%),
    bloc("Ce que je suis", "une empreinte digitale, un visage", hauteur: 100%),
  )

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [Forme], [Comment], [Limite],
    [code par SMS], [un code reçu par message], [détournable en faisant transférer le numéro],
    [application à codes], [un code changé toutes les 30 s], [le code se donne sur une page d'hameçonnage],
    [clé physique, passkey], [l'appareil vérifie l'adresse du site], [résiste aux deux],
  )

  #legende[
    Les trois facteurs : ANSSI, PG-078, 2021. Comptes compromis : moins
    99,2 % avec un deuxième facteur (Microsoft, 2023).
  ]

  #notes[
    Termes de l'ANSSI : facteur de connaissance, facteur de possession, facteur
    inhérent (la biométrie).

    Un mot de passe et une question secrète sont deux facteurs de
    connaissance : un même hameçonnage obtient les deux.

    GitHub impose un deuxième facteur depuis 2023 ; il est activé dans la
    séance, à la création du compte, avec une application à codes. Garder les
    codes de secours : sans eux, la perte du téléphone fait perdre le compte.

    Passkey : une paire de clés gardée par le téléphone ou l'ordinateur, à la
    place du mot de passe ; même principe que la clé SSH.
  ]
]

// --------------------------------------------
// Fusion de « Une clé à la place du mot de passe » et de « La connexion SSH ».
#d("Clé SSH : la paire et la connexion")[
  #annonce[
    Pour une machine ou un programme, une paire de clés remplace le mot de
    passe. Le serveur vérifie que vous détenez la clé privée sans la recevoir.
  ]

  #align(center, schema-echange-ssh(cles: true, pas: 1.25))

  #notes[
    Les deux clés sont créées ensemble par `ssh-keygen`. Un message fermé avec
    la clé publique ne peut être ouvert qu'avec la clé privée.

    Rien n'est tapé, et le serveur ne garde rien de secret. Les quatre façons :
    le serveur ne garde que la clé publique, inutile seule ; une clé de
    256 bits ne se devine pas ; rien de secret ne passe sur le réseau ; rien
    n'est tapé, donc rien ne peut être obtenu par hameçonnage.

    Le défi est un nombre tiré au hasard. Le renvoyer ouvert prouve la
    détention de la clé privée. Un défi ne sert qu'une fois : l'intercepter ne
    donne rien. Toute la session est ensuite chiffrée. SSH : *Secure Shell*,
    un terminal à distance.

    La clé privée ne se calcule pas à partir de la clé publique. Le calcul
    (arithmétique sur de grands nombres) est hors programme.

    Usages de la même paire : la forge
    (`git clone git@github.com:alice/projet.git`), un serveur de calcul
    (`ssh alice@calcul.ecole.fr`), la copie de fichiers (`scp`), VS Code à
    distance (Remote – SSH). Une paire par poste.
  ]
]

// --------------------------------------------
// Fusion de « Un secret dans un dépôt y reste » et de « Séparer le code et
// les secrets » : la sortie de `git log -p` passe en notes.
#d("Séparer le code et les secrets")[
  #annonce[
    Un secret supprimé par un nouveau commit reste dans le commit qui l'a
    ajouté. Le code lit donc le secret dans un fichier que git ignore.
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

  #legende[
    En 2025, 28,65 millions de secrets ont été ajoutés dans des commits
    publics sur GitHub ; 64 % de ceux trouvés en 2022 étaient encore valides
    en 2026 (GitGuardian, *State of Secrets Sprawl 2026*).
  ]

  #notes[
    Secret : clé privée SSH, mot de passe, jeton d'API (*token*) d'un service
    de cartographie ou d'IA, et le fichier `.env` ou `config.py` qui les range.

    `git log -p -- config.py` affiche le commit qui ajoute la clé et celui qui
    la supprime. Des programmes lisent les commits publics en continu et
    testent les clés trouvées : un secret poussé est copié avant d'être
    supprimé. S'il a fui : le révoquer d'abord, puis le remplacer.

    Le `.gitignore` du cours 2. Avant de committer : `git status` ne
    doit pas lister le fichier du secret.

    Démonstration complète : TD 5b, facultatif, dans l'archive `cours5/`.
  ]
]
