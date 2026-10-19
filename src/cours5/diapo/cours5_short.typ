// Cours 5, version courte : neuf diapositives du cours 5, dont une
// facultative, présentées en tête du cours 6 (20 octobre 2026), la séance 5
// n'ayant pas eu lieu.
//
// Les diapositives sont reprises de `parties/`, sans séparateur. Deux sont
// des fusions : « Ordres de grandeur : temps d'accès » avec « Si la mémoire
// vive valait une seconde », « Mot de passe ou paire de clés » avec
// « Connexion SSH avec une paire de clés ». Deux sont propres à cette
// version : « Parades contre les quatre attaques », sur le schéma des
// attaques, et « Empreinte, sel et calcul lent », facultative. Les schémas
// sont ceux de `schemas.typ`.
//
// Retirées le 19/10/2026 au soir : « Processeur et carte graphique »,
// « Client et serveur », « Séparation du code et des secrets ».
//
//   typst compile --root . src/cours5/diapo/cours5_short.typ
//   typst compile --root . --input notes=true src/cours5/diapo/cours5_short.typ src/cours5/diapo/cours5_short-notes.pdf

#import "../../commun/prelude.typ": *
#import "schemas.typ": schema-composants, pyramide-memoire, barres-temps, schema-connexion, schema-empreinte-sel, schema-cryptographie, schema-echange-ssh, repere

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
    pour le calcul parallèle.

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
#d("Quatre attaques contre un mot de passe")[
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
    Le mot de passe de la messagerie d'abord : il réinitialise tous les
    autres. Le gestionnaire du navigateur ou du téléphone suffit pour
    commencer ; KeePassXC et Bitwarden sont les deux libres courants.

    Un mot de passe obtenu est ensuite essayé sur les autres sites. 60 à 84 %
    des personnes interrogées réutilisent un mot de passe (Bitwarden, GoDaddy,
    2025).
  ]
]

// --------------------------------------------
// Ajoutée le 19/10/2026 : les quatre parades sur le schéma des quatre
// attaques, aux mêmes repères. Elle tient lieu de « Parades contre les quatre
// attaques » du cours complet, qui est un tableau.
#d("Parades contre les quatre attaques")[
  #annonce[
    Le site protège sa table et le trajet ; vous protégez le mot de passe et
    le poste.
  ]

  #align(center, schema-connexion(
    entetes: ("identifiant", "empreinte du mot de passe"),
    lignes: (
      ("alice", "c41e07b29d1f58a3…"),
      ("bob", "5e823f9a1c07e4b6…"),
      ("chloé", "0b3dd2a47e9c1f05…"),
    ),
    calcul: "bcrypt", reperes: true, zoom: 106%,
    mot-de-passe: "k7#Qp2vLx9!R", chiffre: true, telephone: true,
  ))

  #v(0.3em)
  #set text(size: pt-footnotesize)
  #grid(
    columns: (auto, 1fr, auto, 1fr), column-gutter: 10pt, row-gutter: 9pt,
    align: (center + horizon, left + horizon),
    repere(1), [une empreinte du mot de passe, qu'on ne sait pas inverser],
    repere(2), [un mot de passe long, tiré au hasard, un par site],
    repere(3), [le trajet chiffré : HTTPS, SSH, WPA sur le Wi-Fi],
    repere(4), [un deuxième facteur : un code reçu sur le téléphone],
  )

  #notes[
    1 et 3 sont faits par le site : on ne les vérifie que par le cadenas du
    navigateur (HTTPS). 2 et 4 dépendent de vous.

    1 : détail à la diapositive suivante, facultative. bob et chloé ont le
    même mot de passe et deux empreintes différentes, grâce au sel.

    2 : un gestionnaire de mots de passe tire au hasard et retient. Le
    navigateur et le téléphone en ont un, sans installation ; KeePassXC et
    Bitwarden sont les deux libres courants. Le mot de passe de la messagerie
    d'abord : il réinitialise tous les autres.

    4 : le deuxième facteur arrête aussi l'hameçonnage du mot de passe, mais
    un code peut être donné sur une fausse page ; une clé physique ou une
    passkey vérifie l'adresse du site (diapositive suivante).
  ]
]

// --------------------------------------------
// Facultative (19/10/2026) : la parade 1 en détail, pour qui demande ce
// qu'est une empreinte. Résume « Fonction de hachage et empreinte », « Empreinte
// avec sel » et « Empreinte à calcul lent » du cours complet.
#d("Empreinte, sel et calcul lent")[
  #annonce[
    Le site garde une empreinte du mot de passe. Un message chiffré se rouvre
    avec la clé, alors qu'une empreinte ne se défait pas.
  ]

  #align(center, schema-empreinte-sel())

  #notes[
    Facultative : à passer si le temps manque.

    À la connexion, le serveur calcule l'empreinte du mot de passe reçu et la
    compare à celle de la table. Un site qui chiffrerait ses mots de passe les
    perdrait tous si la clé était volée avec la table.

    Empreinte : SHA-256, 64 caractères pour un mot comme pour un fichier de
    1 Go. Le même calcul donne l'identifiant d'un commit (cours 2).

    Sans sel, une liste publique d'empreintes déjà calculées donne
    `123456` pour `8d969eef…`. Le sel n'est pas secret : il est volé avec la
    table, mais un calcul ne sert plus que pour un compte.

    bcrypt : une carte graphique RTX 4090, hashcat (Chick3nman, 2022). 8
    caractères tirés au hasard : 3,5 jours avec SHA-256, 1 100 ans avec
    bcrypt. ANSSI (PG-078, 2021, § 4.6) : sel et fonction lente.
  ]
]

// --------------------------------------------
#d("Authentification à deux facteurs")[
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
// Ajoutée le 19/10/2026 : ce qu'est une paire de clés, et le rôle de chacune.
#d("Cryptographie symétrique et asymétrique")[
  #annonce[
    La cryptographie asymétrique emploie une paire de clés, créées ensemble.
    La clé publique peut être communiquée à tous ; la clé privée n'est connue
    que de son détenteur.
  ]

  #align(center, schema-cryptographie())

  #legende[
    Ce que fait l'une des deux clés, seule l'autre le défait ou le vérifie. La
    clé privée ne se calcule pas à partir de la clé publique.
  ]

  #notes[
    Symétrique : une seule clé, que les deux côtés doivent avoir ; il faut la
    leur transmettre sans qu'on l'intercepte. Exemples : AES, le Wi-Fi (WPA),
    une session SSH une fois ouverte.

    Asymétrique : RSA (1977), les courbes elliptiques (Ed25519, 2011). Le
    calcul (arithmétique sur de grands nombres) est hors programme ; une
    partie des étudiants l'a vu en NSI.

    Chiffrer : n'importe qui ferme un message avec la clé publique, seul le
    détenteur de la clé privée l'ouvre. Signer : le détenteur signe avec la
    clé privée, n'importe qui vérifie avec la clé publique. SSH se sert de la
    signature ; une clé Ed25519 ne sait d'ailleurs que signer.

    L'asymétrique est lent : HTTPS et SSH s'en servent pour reconnaître le
    serveur et convenir d'une clé symétrique, qui chiffre ensuite la session.
  ]
]

// --------------------------------------------
// Fusion de « Mot de passe ou paire de clés » et de « Connexion SSH avec une paire de clés ».
#d("Connexion SSH avec une paire de clés")[
  #annonce[
    Pour une machine ou un programme, une paire de clés remplace le mot de
    passe. Le serveur vérifie que vous détenez la clé privée sans la recevoir.
  ]

  #align(center, schema-echange-ssh(cles: true, pas: 1.25))

  #notes[
    Les deux clés sont créées ensemble par `ssh-keygen`.

    Rien n'est tapé, et le serveur ne garde rien de secret. Les quatre attaques :
    le serveur ne garde que la clé publique, inutile seule ; une clé de
    256 bits ne se devine pas ; rien de secret ne passe sur le réseau ; rien
    n'est tapé, donc rien ne peut être obtenu par hameçonnage.

    Le défi est un nombre tiré au hasard. Seule la clé privée produit une
    signature que la clé publique valide : la signature prouve la détention de
    la clé privée. Un défi ne sert qu'une fois : intercepter la signature ne
    donne rien. Toute la session est ensuite chiffrée. SSH : *Secure Shell*,
    un terminal à distance.

    Usages de la même paire : la forge
    (`git clone git@github.com:alice/projet.git`), un serveur de calcul
    (`ssh alice@calcul.ecole.fr`), la copie de fichiers (`scp`), VS Code à
    distance (Remote – SSH). Une paire par poste.
  ]
]
