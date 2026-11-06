// Diapositives de réseau sorties du cours 5 v2 le 06/11/2026, à replacer ou à couper : la
// séance est pleine sans elles. Ce fichier n'est inclus nulle part. Il se compile seul :
//
//   typst compile --root . src/cours5_v2/diapo/a_reprendre/reseau.typ
//
// La partie réseau du cours 5 de 2026 (`cours5/diapo/parties/`) reste inchangée. Déjà
// transférés en v2 : « Commit local et push sur le réseau » au cours 6 (`01_forge.typ`). Le
// cours 5 v2 garde « Client et serveur : JupyterLab ». « Client et serveur » est sortie de sa
// partie 5 le 06/11/2026 : `ssh` n'arrive qu'au cours 6.
#import "../../../commun/prelude.typ": *
#import "../../../cours5/diapo/schemas.typ": schema-client-serveur, schema-local-distant, schema-tuyau

#show: diapos.with(
  titre-court: "Réseau : diapositives à replacer",
  auteur-court: "cours 5 v2, 06/11/2026",
)

#d("Diapositives de réseau à replacer")[
  #show table.cell: set text(size: 14pt)
  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
    [Diapositive], [Lien avec les autres supports],
    [Client et serveur], [cours 6 : `git push`, `git pull`, `ssh`],
    [Liens entre le poste et un serveur], [TD 3d : un aller-retour vers `github.com`],
    [Adresse IP, nom de domaine, port, protocole], [cours 6 : ports 443 et 22, hameçonnage],
    [Débit et latence], [TD 3d : le téléchargement de 10 Mo],
    [Latence et distance], [aucun],
    [Débit selon le type de lien], [TD 3d : la vitesse du lien réseau],
    [Liaisons sans fil], [cours 6 : interception],
  )

  #legende[
    Déjà transférée : « Commit local et push sur le réseau », au cours 6. Le cours 5 garde
    « Client et serveur : JupyterLab ».
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
#d("Liens entre le poste et un serveur")[
  #annonce[
    Entre votre poste et un serveur, les données traversent une suite de
    liens. Chaque lien ajoute du temps ; la distance en ajoute le plus.
  ]

  #align(center, schema-local-distant())

  #notes[
    Réseau local : celui de l'école, jusqu'au pare-feu. Au-delà : les réseaux
    des opérateurs, puis le serveur. GitHub est aux États-Unis, avec des relais
    en Europe.

    Les temps sont des allers-retours et s'additionnent : moins de 1 ms dans la
    salle, des dizaines de millisecondes jusqu'au serveur.
  ]
]

// --------------------------------------------
#d("Adresse IP, nom de domaine, port, protocole")[
  #annonce[
    Pour joindre un serveur, il faut son adresse, et savoir à quel service on
    s'adresse dessus.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [Élément], [Exemple], [Rôle],
    [adresse IP], [`140.82.121.4`], [le numéro de la machine sur le réseau],
    [nom de domaine], [`github.com`], [le nom lisible par une personne ; le DNS le traduit en adresse IP],
    [port], [`443`, `22`], [le service visé sur la machine : le web, SSH],
    [protocole], [`https`, `ssh`], [les règles d'échange sur ce port],
  )

  #v(0.5em)
  #grid(
    columns: (1fr, 1fr), align: center,
    [
      #set text(font: police-code, size: 18pt)
      #text(fill: estompe)[https://]#text(fill: brun, weight: demi-gras)[github.com]#text(fill: estompe)[/alice/projet]
    ],
    [
      #set text(font: police-code, size: 18pt)
      #text(fill: estompe)[ssh alice\@]#text(fill: brun, weight: demi-gras)[calcul.ecole.fr]
    ],
  )
  #legende[En brun, le nom de domaine : il identifie le serveur.]

  #notes[
    Le DNS est un annuaire. La requête DNS est faite une fois ; la réponse est
    gardée en mémoire.

    Port 443 : web chiffré (HTTPS). Port 22 : SSH. Le pare-feu de l'école peut
    fermer le port 22 en sortie : à vérifier avant le cours 6.

    Lire le nom de domaine sert contre l'hameçonnage (cours 6).
  ]
]

// --------------------------------------------
#d("Débit et latence")[
  #annonce[
    Deux grandeurs indépendantes : le temps d'arrivée du premier octet, et
    le nombre d'octets qui arrivent chaque seconde.
  ]

  #align(center, schema-tuyau())

  #v(0.3em)
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [temps = latence + taille ÷ débit], [1 Ko sur une fibre à 1 Gbit/s], [1 Go sur la même fibre],
    [Paris – New York, 75 ms], [75 ms + 0,008 ms : la latence seule compte], [75 ms + 8 s : le débit seul compte],
  )

  #notes[
    Petit message : seule la latence compte. Gros fichier : seul le débit
    compte. Un `git push` ordinaire envoie quelques Ko ; l'attente vient des
    allers-retours.

    Débit en bits par seconde, taille en octets : voir « Débit selon le type
    de lien ».
  ]
]

// --------------------------------------------
#d("Latence et distance")[
  #annonce[
    Dans la fibre, la lumière parcourt 200 000 km par seconde. Un aller-retour
    ne peut pas aller plus vite que la distance ne le permet.
  ]

  #tableau(
    columns: (auto, auto, auto, 1fr),
    align: (left + horizon, right + horizon, right + horizon, left + horizon),
    [Depuis Paris, vers], [Distance], [Aller-retour mesuré], [Part de la vitesse de la lumière],
    [Londres], [341 km], [7 ms], [49 %],
    [Marseille], [662 km], [13 ms], [55 %],
    [New York], [5 812 km], [75 ms], [77 %],
    [Johannesburg], [8 732 km], [155 ms], [57 %],
    [Tokyo], [9 717 km], [242 ms], [40 %],
    [Sydney], [16 964 km], [267 ms], [64 %],
  )

  #legende[
    Moyennes mesurées entre serveurs, wondernetwork.com, septembre 2026. La
    dernière colonne compare au temps qu'aurait mis la lumière dans une fibre
    tendue en ligne droite.
  ]

  #notes[
    Paris–Sydney ne descendra pas sous 170 ms, le temps de la lumière dans la
    fibre sur l'aller-retour. Les gains possibles portent sur les détours des
    câbles et les équipements traversés (dernière colonne).

    Les grands services ont des serveurs sur chaque continent pour cette raison.
  ]
]

// --------------------------------------------
#d("Débit selon le type de lien")[
  #annonce[
    Le lien le plus lent du trajet fixe le débit. Le plus souvent, c'est le
    dernier : le Wi-Fi ou la 4G.
  ]

  #tableau(
    columns: (1fr, auto, auto),
    align: (left + horizon, right + horizon, right + horizon),
    [Lien], [Débit courant], [Transférer 1 Go],
    [Ethernet de la salle, câble], [1 Gbit/s], [8 s],
    [Fibre à domicile], [300 Mbit/s à 1 Gbit/s], [8 à 27 s],
    [Wi-Fi], [50 à 300 Mbit/s], [27 s à 3 min],
    [4G], [10 à 50 Mbit/s], [3 à 13 min],
    [ADSL], [10 Mbit/s], [13 min],
  )

  #avertissement[
    Les débits sont en bits par seconde, les fichiers en octets : 1 Gbit/s
    transfère 125 Mo par seconde.
  ]

  #notes[
    Le facteur 8 entre bits et octets est l'erreur la plus fréquente. Les
    opérateurs donnent les débits en bits par seconde.

    Débits observés en pratique. Le TD 3d du cours 3 en mesure un depuis la salle.
  ]
]

// --------------------------------------------
#d("Liaisons sans fil")[
  #annonce[
    Portée, débit, latence et consommation changent d'une technologie à
    l'autre.
  ]

  #tableau(
    columns: (0.65fr, 0.95fr, 1.35fr, 0.7fr, 1.35fr),
    align: (left + horizon, left + horizon, left + horizon, left + horizon, left + horizon),
    [Lien], [Portée], [Débit], [Latence], [Sert à],
    [Bluetooth], [10 m], [1 à 2 Mbit/s], [10 ms], [écouteurs, capteurs],
    [Wi-Fi], [10 à 50 m], [100 à 1 000 Mbit/s, partagés], [2 à 10 ms], [la salle, la maison],
    [4G ; 5G], [1 à 10 km], [10 à 100 ; 100 à 1 000 Mbit/s], [40 ms ; 15 ms], [le terrain : RTK, cartes],
    [LoRa], [2 à 15 km], [0,3 à 50 kbit/s], [secondes], [un capteur, des années de pile],
    [GNSS], [satellites, 20 000 km], [50 bit/s, réception seule], [], [se positionner],
  )

  #legende[
    Une onde est partagée : le débit du Wi-Fi se divise entre les postes de
    la salle. Une onde s'écoute : sans chiffrement (WPA, puis HTTPS et SSH),
    quiconque est à portée lit ce qui passe.
  ]

  #notes[
    Débits et latences observés en pratique.

    Le Wi-Fi se partage entre les postes connectés ; les postes de la salle sont
    câblés pour cette raison.

    GNSS : le récepteur écoute les satellites et calcule sa position ; il
    n'émet rien. Le message de navigation passe à 50 bit/s : une première
    position à froid prend 30 s. Les corrections RTK arrivent par la 4G.

    LoRa : un relevé par heure, une pile qui dure cinq ans.

    Le chiffrement du Wi-Fi (WPA) protège contre qui est à portée. HTTPS et SSH
    chiffrent sur tout le trajet, opérateur compris. Le cours 6 y revient
    (interception, attaque 3).
  ]
]

