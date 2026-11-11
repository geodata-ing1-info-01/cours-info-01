// Cours 6 v2, partie 2 — prouver qui l'on est. Incluse par `cours6_v2.typ`.
//
// Déplacée du cours 5 le 05/11/2026 (`cours5/diapo/parties/03_prouver_qui_lon_est.typ`,
// inchangée dans le cours de 2026), sans reformulation.
//
//
// Le fil : la table des comptes d'un site, les quatre attaques contre le
// mot de passe d'un autre, une parade par attaque (l'empreinte, la longueur et
// le hasard, le chiffrement, le deuxième facteur), puis la clé, qui remplace
// le mot de passe pour les machines et les programmes.
#import "../../../commun/prelude.typ": *
#import "../../../cours5/diapo/schemas.typ": schema-cryptographie, schema-echange-ssh, schema-connexion, repere
#import "../../../cours5/diapo/style.typ": terminal
#import "../../../commun/schemas_github.typ": formulaire-token, token-genere, gestionnaire-identification, pastille

#separateur(
  "Mots de passe et clés SSH",
  annonce: "Le mot de passe, les quatre attaques possibles, leurs parades, puis la paire de clés et le token qui le remplacent.",
)

// --------------------------------------------
#d("Connexion à un site par mot de passe")[
  #annonce[
    Le site garde chaque compte dans une table : l'identifiant et le mot de
    passe. À la connexion, le serveur compare le mot de passe reçu avec celui
    de la table.
  ]

  #align(center, schema-connexion(
    entetes: ("identifiant", "mot de passe"),
    lignes: (
      ("alice", "Marseille2024!"),
      ("bob", "123456"),
      ("chloé", "123456"),
    ),
  ))

  #notes[
    La table est une base de données du serveur, une ligne par compte.
    L'identifiant est public ; le mot de passe est le seul secret.
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
    Chaque attaque a sa parade, dans l'ordre des numéros : l'empreinte (1), la
    longueur et le hasard (2), le chiffrement (3), le deuxième facteur (4).

    Un mot de passe obtenu est ensuite essayé sur les autres sites. 60 à 84 %
    des personnes interrogées réutilisent un mot de passe (Bitwarden, GoDaddy,
    2025).
  ]
]

// --------------------------------------------
#d("Fonction de hachage et empreinte")[
  #annonce[
    Une fonction de hachage répond à la question : ces deux contenus sont-ils
    identiques ? Elle calcule pour chaque contenu une empreinte de taille
    fixe, et on compare les empreintes.
  ]

  #block(width: 100%, inset: (x: 12pt, y: 9pt), fill: gris)[
    #set text(font: police-code, size: 14pt)
    #grid(
      columns: (auto, 1fr), column-gutter: 16pt, row-gutter: 5pt,
      [bonjour], [2cb4b1431b84ec15d35ed83bb927e27e8967d75f4bcd9cc4b25c8d879ae23e18],
      [Bonjour], [9172e8eec99f144f72eca9a568759580edadb2cfd154857f07e657569493bc44],
    )
  ]

  #tableau(
    columns: (1.45fr, 1fr),
    align: (left + horizon, left + horizon),
    [Propriété de SHA-256], [Sur l'exemple],
    [le même contenu donne toujours la même empreinte], [`bonjour` donne `2cb4b143…` partout],
    [une lettre de différence donne une empreinte sans rapport], [`Bonjour` donne `9172e8ee…`],
    [l'empreinte a toujours 64 caractères], [pour un mot, pour un fichier de 1 Go],
    [aucun calcul ne retrouve le contenu à partir de l'empreinte], [`2cb4b143…` ne permet pas de calculer `bonjour`],
  )

  #notes[
    SHA-256 : *Secure Hash Algorithm* ; empreinte de 256 bits, écrite en 64
    chiffres hexadécimaux.

    Autres usages : l'identifiant d'un commit (SHA-1, cours 2) ; la
    vérification d'un fichier téléchargé, sous Windows avec
    `certutil -hashfile fichier.zip SHA256`.
  ]
]

// --------------------------------------------
#d("Table des comptes avec empreintes")[
  #annonce[
    Le serveur garde l'empreinte du mot de passe. À la connexion, il calcule
    l'empreinte du mot de passe reçu et la compare à celle de la table.
  ]

  #align(center, schema-connexion(
    entetes: ("identifiant", "empreinte du mot de passe"),
    lignes: (
      ("alice", "2aa0358d8394e784…"),
      ("bob", "8d969eef6ecad3c2…"),
      ("chloé", "8d969eef6ecad3c2…"),
    ),
    calcul: "SHA-256", zoom: 100%,
  ))

  #v(0.2em)
  #tableau(
    columns: (1fr, 1.4fr),
    align: (left + horizon, left + horizon),
    [Avec la table volée], [Résultat],
    [taper `2aa0358d…` dans le formulaire], [le serveur calcule l'empreinte de `2aa0358d…` : `1ea04f0b…`, différente de celle de la table],
    [calculer l'empreinte de mots de passe candidats et comparer], [chez soi, sans limite d'essais : la devinette, attaque 2],
  )

  #notes[
    ANSSI (PG-078, 2021, § 4.6) : le stockage en clair est proscrit ; en cas de
    fuite, les mots de passe sont « directement révélés ».

    Le mot de passe voyage tel quel dans la connexion HTTPS ; le serveur calcule
    l'empreinte à l'arrivée. Si le navigateur envoyait l'empreinte, une
    empreinte volée suffirait pour se connecter.

    Faire remarquer que bob et chloé ont la même empreinte.
  ]
]

// --------------------------------------------
#d("Empreinte avec sel")[
  #annonce[
    Sans sel, deux comptes qui ont le même mot de passe ont la même
    empreinte. Le serveur tire au hasard un sel pour chaque compte, et
    calcule l'empreinte du sel suivi du mot de passe.
  ]

  #align(center, schema-connexion(
    entetes: ("identifiant", "sel", "empreinte de sel + mot de passe"),
    lignes: (
      ("alice", "7f3a9c", "8a7fb679f0999b58…"),
      ("bob", "b21e04", "fe80f1e0ed9d164d…"),
      ("chloé", "e5d1f8", "f63e6f06896874c6…"),
    ),
    calcul: "SHA-256", zoom: 100%,
  ))

  #v(0.2em)
  #tableau(
    columns: (1.3fr, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [Table volée, sels compris], [Sans sel], [Avec sel],
    [calculs pour essayer `123456`], [1, qui trouve bob et chloé], [3, un par compte],
    [liste publique d'empreintes déjà calculées], [donne `123456` pour `8d969eef…`], [ne sert pas : l'empreinte dépend du sel],
  )

  #legende[
    ANSSI 2021, § 4.6 : un sel tiré au hasard pour chaque compte, de
    128 bits au moins.
  ]

  #notes[
    Le sel n'est pas secret : il est volé avec la table. Pour essayer `123456`
    sur bob, le voleur calcule l'empreinte de `b21e04123456` ; sur chloé, celle
    de `e5d1f8123456`. Un calcul ne sert que pour un compte.

    Une liste calculée à l'avance ne contient pas les sels. Exemple de liste
    publique : chercher `8d969eef6ecad3c2` sur le web donne `123456`.

    Sur deux sites, le même mot de passe a deux empreintes différentes.

    Les sels sont raccourcis sur la diapositive ; un vrai sel fait 16 octets.
  ]
]

// --------------------------------------------
#d("Empreinte à calcul lent")[
  #annonce[
    Avec le sel, le voleur peut encore essayer des mots de passe, compte
    par compte. Une fonction lente, comme bcrypt, réduit le nombre d'essais
    par seconde.
  ]

  #tableau(
    columns: (auto, auto, 1fr, auto),
    align: (left + horizon, right + horizon, left + horizon, right + horizon),
    [Fonction], [Essais par seconde], [Usage], [8 caractères tirés au hasard],
    [SHA-256], [22 milliards], [vérifier un fichier, identifier un commit], [3,5 jours],
    [bcrypt (coût 5)], [184 000], [garder un mot de passe : le calcul est lent exprès], [1 100 ans],
  )

  #legende[
    Une carte graphique RTX 4090, hashcat 6.2.6 (Chick3nman, 2022) ; 95#super[8]
    combinaisons. ANSSI 2021, § 4.6 : une fonction lente pour garder les
    mots de passe.
  ]

  #notes[
    bcrypt et Argon2 répètent le calcul un grand nombre de fois ; le nombre de
    répétitions se règle par le coût. Le coût 10, courant, est 32 fois plus
    lent que le coût 5.

    Pour le site, un calcul par connexion est imperceptible. Pour le voleur,
    chaque essai prend ce temps.

    Dernière colonne : 95#super[8] = 6,6 × 10#super[15] combinaisons, divisées
    par le nombre d'essais par seconde d'une carte.
  ]
]

// --------------------------------------------
// Le dessin n'est produit qu'avec l'image en place
// (`illustrations/cours5/telecharger.py`).
#if captures-disponibles {
{
  // Le dessin seul, sans titre, sur toute la hauteur de la page : à la taille
  // d'une demi-diapositive, le texte manuscrit ne se lit pas au projecteur.
  v(1fr)
  align(center, image("/illustrations/cours5/xkcd_936.png", height: 405pt))
  align(center, legende[
    Randall Munroe, xkcd n° 936, *Password Strength*, 2011, CC BY-NC 2.5.
  ])
  v(1fr)
  notes[
    Laisser le temps de lire le dessin.

    `Tr0ub4dor&3` : un mot peu courant, une majuscule, des substitutions
    connues, un chiffre, un signe ; 28 bits. `correct horse battery staple` :
    quatre mots tirés au hasard ; 44 bits.
  ]
  pagebreak(weak: true)
}

d("L'entropie d'un mot de passe")[
  #annonce[
    _n_ bits d'entropie font 2#super[_n_] mots de passe possibles, et autant
    d'essais. L'entropie compte les choix faits au hasard.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: (left + horizon, left + horizon),
    [Dans le dessin], [Le compte],
    [`Tr0ub4dor&3`], [un mot peu courant (16 bits), une majuscule, des substitutions connues, un chiffre, un signe : 28 bits],
    [`correct horse battery staple`], [4 mots tirés au hasard parmi 2 048 : 4 × 11 = 44 bits],
    [1 000 essais par seconde], [des essais au formulaire ; sur une table bcrypt volée, 44 bits tombent en 4 mois],
  )

  #legende[
    La CNIL (2022) demande 80 bits pour un mot de passe seul : 12 caractères
    de quatre classes, 14 de trois, ou 7 mots tirés au hasard.
  ]

  #notes[
    Calcul : _L_ caractères tirés parmi _N_ donnent _L_ × log#sub[2] _N_ bits ;
    _k_ mots tirés parmi _M_ donnent _k_ × log#sub[2] _M_ bits. 8 caractères
    parmi 95 : 53 bits. 7 mots parmi 7 776 : 90 bits.

    Le dessin compte les choix de la personne : `Tr0ub4dor&3` a 11 caractères,
    mais c'est un mot et des règles connues. ANSSI (PG-078, p. 26) : l'entropie
    calculée ne vaut que pour un tirage au hasard.

    Seuils officiels :
    - CNIL, délibération 2022-100 : 80 bits si le mot de passe est seul ;
      50 bits si les essais sont limités ; 13 bits avec un matériel (carte
      bancaire) ;
    - ANSSI, PG-078, tableau 3 : 65 bits pour 9 à 11 caractères, 85 pour 12 à
      14, 100 pour 15 et plus ;
    - NIST, SP 800-63B-4 (2025) : 15 caractères au moins si le mot de passe est
      seul.

    4 mois : 2#super[44] essais à 1,6 million par seconde, la vitesse de la
    table Hive 2026.
  ]
]
}

// --------------------------------------------
#d("Temps pour deviner un mot de passe")[
  #annonce[
    Avec une table d'empreintes volée, le voleur essaie les mots de passe
    dans l'ordre le plus probable, sur seize cartes graphiques.
  ]

  #tableau(
    columns: (1.2fr, 1.5fr, auto, auto),
    align: (left + horizon, left + horizon, right + horizon, right + horizon),
    [Mot de passe], [Comment il est trouvé], [Entropie], [Temps],
    [`123456`], [il est dans les listes de fuites], [0 bit], [instantané],
    [`Marseille2024!`], [un nom de ville, une année, un signe à la fin : des règles connues des programmes], [≈ 30 bits], [secondes à heures],
    [`k7#Qp2vL`, 8 caractères tirés au hasard], [toutes les combinaisons : 95#super[8]], [53 bits], [132 ans],
    [`lune orange pont carte vélo sel pluie`], [toutes les combinaisons : 7 776#super[7]], [90 bits], [hors de portée],
  )

  #legende[
    Hive Systems, table 2026 : empreintes bcrypt de coût 10, seize RTX 5090.
    Au formulaire, le serveur limite les essais ; ces temps sont ceux d'une
    table volée.
  ]

  #notes[
    Les programmes de devinette essaient d'abord les listes de fuites, puis les
    mots du dictionnaire avec un chiffre et un signe aux positions habituelles.
    Les formulaires qui imposent majuscule, chiffre et signe produisent la
    deuxième ligne.

    Pour un mot de passe tiré au hasard, la longueur fait le temps de calcul ;
    les classes de caractères comptent peu.

    Entropies estimées pour les deux premières lignes : `123456` est le premier
    essai de toute liste ; `Marseille2024!` = une ville (≈ 15 bits), une année
    (≈ 7 bits), une majuscule et un signe aux positions habituelles. 30 bits à
    1,6 million d'essais par seconde : une dizaine de minutes.

    Un mot de passe trouvé est essayé sur les autres sites : il faut un mot de
    passe différent par site.
  ]
]

// --------------------------------------------
#d("Hameçonnage")[
  #annonce[
    Attaque 4 : le mot de passe est donné par son propriétaire, sur une
    page qui imite le site.
  ]

  #let repere-h(n) = box(
    baseline: 25%, inset: (x: 5pt, y: 1pt), fill: alerte, radius: 2pt,
    text(size: 11pt, fill: white, weight: demi-gras)[#n],
  )

  #grid(
    columns: (1.55fr, 1fr), column-gutter: 18pt, align: top,
    fenetre("Boîte de réception")[
      #set text(size: 14pt)
      #set par(leading: 0.6em)
      #grid(
        columns: (auto, 1fr), column-gutter: 10pt, row-gutter: 5pt,
        text(fill: estompe)[De :], [Service informatique \<support\@securite-compte.net\> #repere-h(1)],
        text(fill: estompe)[Objet :], [Votre compte sera suspendu dans 24 h #repere-h(2)],
      )
      #v(0.5em)
      Bonjour,

      Suite à une mise à jour de nos systèmes, vous devez confirmer votre
      identité sous 24 heures, faute de quoi votre accès sera suspendu.

      #text(fill: attention)[#underline[https://ecole.fr/compte]] #repere-h(3)
      #text(size: 12pt, fill: estompe)[(le lien pointe vers `http://ecole-fr.verif-compte.net/…`)]

      Merci de votre compréhension. \
      #text(fill: estompe)[Pièce jointe : `Formulaire.pdf.exe` #repere-h(4)]
    ],
    tableau(
      columns: (auto, 1fr),
      align: (left + top, left + top),
      [], [À lire],
      [#repere-h(1)], [le domaine de l'expéditeur : ce n'est pas celui de l'école],
      [#repere-h(2)], [l'urgence et la menace],
      [#repere-h(3)], [le domaine réel du lien, en le survolant : ce n'est pas celui affiché],
      [#repere-h(4)], [une pièce jointe exécutable],
    ),
  )

  #notes[
    Lire le domaine : ce qui précède le premier `/`, en partant de la droite
    jusqu'au deuxième point. `ecole-fr.verif-compte.net` est un sous-domaine de
    `verif-compte.net`.

    En cas de doute : ne pas cliquer ; aller sur le site par son adresse
    habituelle ; contacter le service par un autre moyen. Un service
    informatique ne demande pas de mot de passe par courriel.

    Message construit pour la diapositive ; le domaine n'existe pas.
  ]
]

// --------------------------------------------
#d("Parades contre les quatre attaques")[
  #annonce[
    Le mot de passe de la messagerie est à protéger en premier : il permet de
    réinitialiser tous les autres.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [Attaque], [Parade], [Ce que cela demande],
    [1. lu dans la table], [l'empreinte, avec un sel et un calcul lent], [rien de votre part : c'est le site qui le fait],
    [2. deviné], [long, tiré au hasard, différent sur chaque site], [un gestionnaire de mots de passe, qui tire au hasard et retient],
    [3. intercepté], [le chiffrement du trajet], [HTTPS, SSH, WPA sur le Wi-Fi ; déjà en place presque partout],
    [4. pris sur le poste], [un deuxième facteur], [un téléphone, ou une clé physique],
  )

  #legende[
    Le gestionnaire du navigateur ou du téléphone suffit pour commencer ;
    KeePassXC et Bitwarden sont les deux libres courants.
  ]

  #notes[
    Avec un gestionnaire, on retient un seul mot de passe, celui du
    gestionnaire : une phrase de sept mots, utilisée nulle part ailleurs.

    Le changement périodique n'est plus recommandé (CNIL 2022, NIST) : il
    produit `Marseille2024!` puis `Marseille2025!`. On change un mot de passe
    quand il a fui.
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

    Microsoft (2023) : moins 98,6 % de comptes compromis avec un deuxième
    facteur, même quand le mot de passe a fui.

    GitHub impose un deuxième facteur depuis 2023 ; il s'active sur le compte GitHub,
    à la création du compte, avec une application à codes. Garder les codes
    de secours : sans eux, la perte du téléphone fait perdre le compte.

    Passkey : une paire de clés gardée par le téléphone ou l'ordinateur, à la
    place du mot de passe ; même principe que la clé SSH.
  ]
]

// --------------------------------------------
#d("Mot de passe ou paire de clés")[
  #annonce[
    Pour une machine ou un programme, une paire de clés remplace le mot de
    passe. Rien n'est tapé, et le serveur ne garde rien de secret.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [Attaque], [Avec un mot de passe], [Avec une paire de clés],
    [1. lu dans la table], [une empreinte, d'où un mot de passe faible se retrouve], [la clé publique, inutile seule],
    [2. deviné], [30 bits pour `Marseille2024!`, 90 pour sept mots], [une clé de 256 bits : hors de portée],
    [3. intercepté], [il passe sur le réseau, chiffré par HTTPS], [rien de secret ne passe sur le réseau],
    [4. pris sur le poste], [il est tapé, donc exposé à l'hameçonnage], [rien n'est tapé ; le fichier de la clé privée reste à protéger],
  )

  #notes[
    Ligne 4 : un logiciel espion peut copier le fichier de la clé privée. La
    phrase de passe, posée par `ssh-keygen`, le chiffre sur le disque
    (diapositive « Création d'une paire de clés SSH »).

    Usages de la même paire : la forge
    (`git clone git@github.com:alice/projet.git`), un serveur de calcul
    (`ssh alice@calcul.ecole.fr`), la copie de fichiers (`scp`), VS Code à
    distance (Remote – SSH).

    Une paire par poste. Les forges acceptent aussi HTTPS avec un jeton : un
    autre secret à garder.
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
#d("Connexion SSH avec une paire de clés")[
  #annonce[
    Le serveur vérifie que vous détenez la clé privée sans la recevoir.
  ]

  #align(center, schema-echange-ssh())

  #notes[
    Le défi est un nombre tiré au hasard. Seule la clé privée produit une
    signature que la clé publique valide : la signature prouve la détention de
    la clé privée. Un défi ne sert qu'une fois : intercepter la signature ne
    donne rien.

    En pratique, le défi est l'identifiant de la session, tiré au hasard à son
    ouverture.

    Toute la session est ensuite chiffrée. SSH : *Secure Shell*, un terminal à
    distance.
  ]
]

// --------------------------------------------
#d("Création d'une paire de clés SSH")[
  #annonce[
    `ssh-keygen` écrit les deux fichiers dans `.ssh/`, dans votre dossier
    personnel.
  ]

  #terminal("Anaconda Prompt", "> ssh-keygen -t ed25519 -C \"alice.martin@etu.ecole.fr\"
Enter file in which to save the key (C:\\Users\\alice\\.ssh\\id_ed25519):
Your identification has been saved in C:\\Users\\alice\\.ssh\\id_ed25519
Your public key has been saved in C:\\Users\\alice\\.ssh\\id_ed25519.pub
The key fingerprint is:
SHA256:UdftFYrZHMVT1F9jJrEyd+9auv49Mi15wkj7o+uNUm4 alice.martin@etu.ecole.fr", taille: 13pt)

  #v(0.3em)
  #tableau(
    columns: (auto, auto, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [Fichier], [Taille], [Contenu],
    [#text(fill: brun, weight: demi-gras)[`id_ed25519`]], [419 octets],
      [la clé privée, lisible par vous seul ; ne jamais l'ouvrir ni la copier],
    [#text(fill: attention, weight: demi-gras)[`id_ed25519.pub`]], [107 octets],
      [la clé publique, une seule ligne : `ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFKIay24YXuydFOmWVIyBfd3aAkOOtGncHYAqvz+ZW75 alice.martin\@etu.ecole.fr`],
  )

  #notes[
    Sortie réelle (OpenSSH 9.6, Windows), sans les deux questions sur la phrase
    de passe. Répondre aux trois questions par Entrée : emplacement par défaut,
    pas de phrase de passe.

    La phrase de passe chiffre la clé privée sur le disque et protège en cas de
    vol du poste. À recommander sur un portable personnel ; en salle, on s'en
    passe pour ne pas la retaper à chaque `push`.

    `-C` : un commentaire qui étiquette la clé. `ed25519` : le type de clé
    courant. `SHA256:Udft…` : l'empreinte de la clé publique.
  ]
]

// --------------------------------------------
// Nouveau (05/11/2026) : le TD 6a emploie un token, qui n'était présenté que dans ses
// consignes. Documentation de GitHub, « Managing your personal access tokens ».
#d("Accès à GitHub par token")[
  #annonce[
    Un token est une chaîne générée par GitHub, que git envoie par HTTPS à la place
    du mot de passe du compte.
  ]

  #chaine(
    ("Création", "sur GitHub : droits cochés, expiration"),
    ("Premier accès", [`git clone`, avec le token à la place du mot de passe]),
    ("Vérification", "GitHub contrôle le token et ses droits"),
    ("Accès suivants", "le token reste enregistré sur le poste"),
  )

  #v(0.5em)
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [], [Mot de passe du compte], [Token],
    [Créé par], [vous], [GitHub, au hasard],
    [Droits], [tout le compte], [ceux cochés à sa création],
    [Durée], [jusqu'à son changement], [jusqu'à l'expiration choisie],
    [Après une fuite], [le changer partout où il sert], [supprimer ce token seul],
  )

  #legende[
    GitHub n'affiche le token qu'une fois. Il se garde comme un mot de passe : hors
    de tout dépôt.
  ]

  #notes[
    Documentation de GitHub : « Treat your access tokens like passwords ». Un token
    volé donne ses droits sans deuxième facteur.

    Le TD 6a coche `repo`, qui ouvre tous les dépôts du compte. Les tokens à droits
    fins (_fine-grained_) se limitent à certains dépôts, et GitHub les recommande quand
    ils conviennent.

    Sous Windows, le gestionnaire d'identifiants de Git for Windows ouvre une fenêtre
    de connexion, et retient le token. Le compte `eleve` étant commun, supprimer le
    token à la fin du TD le rend inutilisable sur le poste.

    Le token passe par HTTPS, port 443. La clé SSH passe par le port 22.
  ]
]

// --------------------------------------------
// Ajoutée le 10/11/2026 : le formulaire que le TD 6a et le TD 7a v2 font remplir. Menus
// d'après la documentation de GitHub, « Managing your personal access tokens ».
#d("Création d'un token sur GitHub")[
  #annonce[
    Le token se crée dans les réglages du compte GitHub. Son nom, sa durée et ses droits se
    choisissent à sa création, et GitHub ne l'affiche qu'une fois.
  ]

  #grid(
    columns: (1.1fr, 1fr), column-gutter: 16pt, align: top,
    text(size: 12pt, formulaire-token(reperes: (note: 1, expiration: 2, repo: 3, generer: 4))),
    [
      #text(size: 12pt, token-genere(repere: 5))
      #v(0.4em)
      #set text(size: 14pt)
      #stack(
        spacing: 0.55em,
        [#pastille(1) un nom, pour retrouver le token],
        [#pastille(2) une durée courte : 7 jours pour un TD],
        [#pastille(3) le droit d'écrire dans ses dépôts],
        [#pastille(4) la création],
        [#pastille(5) la copie, aussitôt : GitHub ne l'affiche plus],
      )
    ],
  )

  #legende[
    Menu du compte, Settings, Developer settings, Personal access tokens, Tokens (classic), puis
    Generate new token (classic).
  ]

  #notes[
    `repo` ouvre tous les dépôts du compte, publics et privés. Pour des dépôts publics,
    le droit `public_repo` permet aussi le push. Le TD coche `repo`, nommé par la
    documentation et par les messages d'erreur.

    Les tokens à droits fins (_fine-grained_) se limitent à certains dépôts, mais leur
    formulaire est plus long : hors du TD.

    Le token commence par `ghp_`. Un token publié par erreur dans un dépôt public est
    détecté et révoqué par GitHub.
  ]
]

// --------------------------------------------
// Ajoutée le 10/11/2026 : les postes de la salle ont un compte Windows `eleve` commun.
#d("Token sur un poste partagé")[
  #annonce[
    Après le premier `git push`, Windows garde le token dans son Gestionnaire
    d'identification, pour le compte Windows ouvert. Sur un compte Windows commun, le token
    reste à la disposition de l'élève suivant.
  ]

  #grid(
    columns: (1fr, 1.1fr), column-gutter: 16pt, align: top,
    text(size: 12pt, gestionnaire-identification(repere: 1)),
    [
      #show table.cell: set text(size: 13pt)
      #tableau(
        columns: (auto, 1fr),
        align: left + horizon,
        [Situation], [Conséquence],
        [votre token reste sur le poste], [l'élève suivant pousse dans vos dépôts],
        [le token d'un autre est resté], [votre push échoue : `Permission … denied to <autre compte>`],
        [vous supprimez l'identifiant #pastille(1)], [le push suivant redemande le compte et le token],
      )
    ],
  )

  #legende[
    Gestionnaire d'identification : menu Démarrer, « Gestionnaire d'identification »,
    Informations d'identification Windows. Supprimer aussi le token sur GitHub à la fin de la
    séance.
  ]

  #notes[
    Deux noms proches : Git Credential Manager, le programme livré avec Git for Windows, que
    git appelle pour s'identifier ; le Gestionnaire d'identification, l'endroit de Windows
    où ce programme range le token. Il l'écrit sous le nom `git:https://github.com`, un seul
    identifiant par site : le push d'un autre compte échoue alors avec `Permission … denied
    to <compte resté>` et `error: 403`.

    Sur un ordinateur personnel, garder le token est commode, jusqu'à son expiration.
  ]
]

// --------------------------------------------
// Ajoutée le 11/11/2026 : ce qu'est un token, comparé à la clé SSH vue plus haut.
#d("Token ou clé SSH")[
  #annonce[
    Le token et la clé SSH remplacent tous deux le mot de passe du compte pour git.
  ]

  #show table.cell: set text(size: 14pt)
  #show raw: set text(size: 13pt)
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [], [Token], [Clé SSH],
    [Forme], [`ghp_`, puis 30 caractères tirés au hasard et 6 de contrôle], [deux fichiers : la clé privée et la clé publique],
    [Créé par], [GitHub, qui l'affiche une seule fois], [`ssh-keygen`, sur le poste],
    [Envoyé à GitHub à chaque push], [le token, dans la connexion chiffrée par HTTPS], [une signature calculée avec la clé privée, qui reste sur le poste],
    [Adresse du dépôt], [`https://github.com/…`, port 443], [`git@github.com:…`, port 22, fermé à l'école],
    [Durée], [jusqu'à l'expiration choisie], [jusqu'à sa suppression sur GitHub],
    [Droits], [ceux cochés à la création], [tous les dépôts du compte],
  )

  #legende[
    Le token lui-même n'est pas chiffré. Qui le lit, dans un fichier ou sur un écran, peut
    s'en servir jusqu'à son expiration, comme d'un mot de passe.
  ]

  #notes[
    Git envoie le token dans l'en-tête `Authorization` de chaque requête HTTPS, encodé en
    base64, un encodage réversible. TLS chiffre la connexion entière. Avec le token, git
    envoie aussi le nom du compte, que GitHub ne vérifie pas.

    Les 6 derniers caractères sont une somme de contrôle (CRC32) des 30 autres. Avec le
    préfixe `ghp_`, elle permet de reconnaître un token dans un texte : poussé par erreur
    dans un dépôt public, il est révoqué par GitHub (documentation de GitHub, « Remediating
    a leaked secret »).

    Un token n'ouvre pas l'interface web de GitHub, seulement git et l'API, et sans deuxième
    facteur.

    Sous Windows, le Gestionnaire d'identification protège le token par la session Windows.
    Tout programme lancé dans cette session le relit en clair, par exemple
    `git credential fill`. Sur le compte `eleve` commun, il se supprime donc à la fin du TD.

    À l'école, le token : port 22 fermé, compte Windows commun. Sur un ordinateur personnel,
    la clé SSH évite de coller un token, et n'expire pas.
  ]
]

