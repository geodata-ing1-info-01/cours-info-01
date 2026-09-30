// Cours 5, partie 1 — le matériel. Incluse par `cours5.typ`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": schema-composants, schema-coeurs, pyramide-memoire, barres-temps, photo-reperee, legende-reperes, graphe-tendances, schema-puces, schema-pixels

#separateur(
  "Le matériel",
  annonce: "Les composants d'un ordinateur, le rôle de chacun et les ordres de grandeur associés.",
)

// --------------------------------------------
#d("Les composants d'un ordinateur")[
  #align(center, schema-composants())

  #notes[
    La suite de la partie détaille le processeur, la mémoire vive et le disque.

    Carte graphique : conçue pour calculer l'image affichée, utilisée aujourd'hui
    pour le calcul parallèle (diapositives « Processeur et carte graphique »).

    Carte réseau : câble ou Wi-Fi ; sujet de la partie 2.

    Alimentation : convertit le 230 V du secteur en 12 V, 5 V et 3,3 V.

    Un portable et un téléphone ont les mêmes composants, soudés sur une seule
    carte.
  ]
]

// Les deux photos ne sont produites qu'avec les images en place : sans
// elles, le schéma dessiné qui précède porte seul les composants.
#if captures-disponibles {
d("Un boîtier ouvert")[
  #grid(
    columns: (auto, 1fr), column-gutter: 22pt, align: top,
    photo-reperee("/illustrations/cours5/boitier_ouvert.jpg", 1400 / 1275, (
      (0.23, 0.21), (0.20, 0.77), (0.34, 0.50), (0.47, 0.42),
      (0.62, 0.53), (0.30, 0.66), (0.185, 0.58),
    ), hauteur: 290pt),
    legende-reperes(
      [l'alimentation : du 230 V aux tensions des composants],
      [la carte mère : tout s'y branche],
      [le processeur, sous son ventilateur],
      [la mémoire vive, deux barrettes],
      [le disque, dans son berceau],
      [des emplacements pour cartes, vides : pas de carte graphique séparée],
      [les connecteurs arrière : écran, réseau, USB],
    ),
  )

  #legende[
    Un PC de bureau des années 2010, panneau retiré. Photo PantheraLeo1359531,
    Wikimedia Commons, CC BY 4.0.
  ]

  #notes[
    Le processeur est sous le ventilateur.

    Ce poste n'a pas de carte graphique séparée : le processeur gère
    l'affichage. Les emplacements vides permettent d'en ajouter une.
  ]
]

d("La carte mère")[
  #grid(
    columns: (auto, 1fr), column-gutter: 22pt, align: top,
    photo-reperee("/illustrations/cours5/carte_mere.jpg", 1400 / 933, (
      (0.66, 0.52), (0.66, 0.80), (0.43, 0.42), (0.47, 0.60),
      (0.32, 0.72), (0.72, 0.08), (0.64, 0.93),
    ), hauteur: 290pt),
    legende-reperes(
      [le processeur, sous son ventilateur],
      [la mémoire vive : quatre emplacements, deux occupés],
      [les emplacements pour cartes ; le long reçoit la carte graphique],
      [un emplacement pour un SSD au format M.2, 22 × 80 mm],
      [le jeu de puces, qui relie le reste au processeur],
      [les connecteurs arrière : USB, réseau, écran, son],
      [l'arrivée de l'alimentation, et les prises des disques],
    ),
  )

  #legende[
    Carte Gigabyte B550 de 2020, couchée, connecteurs arrière en haut. Photo
    Nicolasfoster, Wikimedia Commons, CC0.
  ]

  #notes[
    La carte mère relie les composants par des pistes de cuivre. Un ensemble de
    pistes entre deux composants s'appelle un bus.

    Se remplacent sans changer de carte : la mémoire, les cartes, les disques.
    Un processeur d'une autre génération demande en général une autre carte.
  ]
]
}

// --------------------------------------------
#d("Le processeur")[
  #annonce[
    Il exécute les instructions du programme une par une. Un cœur suit une
    file d'instructions ; une cadence de 3 GHz est de 3 milliards de cycles
    par seconde.
  ]

  #align(center, schema-coeurs())

  #legende[
    Un programme Python ordinaire occupe un seul cœur. Les trois autres
    servent aux autres programmes ouverts.
  ]

  #notes[
    Une instruction : lire une valeur en mémoire, additionner, comparer, sauter
    à une autre instruction. Une ligne de Python correspond à des dizaines ou
    des centaines d'instructions.

    Cœurs : 4 sur les postes de la salle (relevé au TD 5a), 4 à 8 sur un
    portable, 32 à 128 sur un serveur de calcul.
  ]
]

// --------------------------------------------
#d("Température du processeur")[
  #v(1em)
  #question("?")[
    Quelle température atteint un processeur qui calcule sans arrêt, par
    exemple pendant un traitement d'image de plusieurs minutes ?
  ]

  #v(1.5em)
  #grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    gutter: 14pt,
    etiquette("40 °C"), etiquette("60 °C"), etiquette("90 °C"), etiquette("150 °C"),
  )

  #notes[
    Faire voter à main levée, puis passer aux réponses.

    Les réponses se partagent souvent entre 40 et 60 °C, la température
    ressentie du boîtier.
  ]
]

// --------------------------------------------
#d("Température du processeur — réponses")[
  #annonce[
    En charge, un processeur travaille entre 60 et 100 °C. À la limite fixée
    par le fabricant, il baisse de lui-même sa fréquence pour ne pas
    s'abîmer.
  ]

  #tableau(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    [Situation], [Température de la puce],
    [au repos, bureautique], [30 à 50 °C],
    [en charge, poste de bureau], [60 à 90 °C],
    [en charge, portable fin], [80 à 100 °C],
    [limite du fabricant, où la fréquence baisse], [95 °C (AMD), 100 °C (Intel)],
    [sans radiateur ni ventilateur], [la limite en quelques secondes],
  )

  #legende[
    Ordres de grandeur ; limites des Ryzen 7000 et des Core de 13#super[e]
    génération, données par les fabricants.
  ]

  #notes[
    Puissance : 65 à 250 W sur 1 à 2,5 cm², soit 50 à 100 W par cm². Une plaque
    de cuisson : moins de 10 W par cm².

    Cette limite a arrêté la montée en fréquence vers 2005 (« Trente ans de
    processeurs »). Un portable qui ralentit pendant un long calcul baisse sa
    fréquence pour rester sous la limite.

    AMD (2022) : 95 °C en charge est le fonctionnement prévu des Ryzen 7000.

    Le gestionnaire des tâches de Windows n'affiche pas la température du
    processeur ; il faut l'outil du fabricant.
  ]
]

// --------------------------------------------
#d("Mémoire vive et disque")[
  #annonce[
    Deux mémoires. La mémoire vive est rapide et s'efface à l'extinction ; le
    disque est lent et conserve.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [], [Mémoire vive (RAM)], [Disque (SSD, disque dur)],
    [Taille], [8 à 32 Go], [500 Go à 4 To],
    [Temps d'accès], [100 ns], [100 µs (SSD), 10 ms (disque dur)],
    [À l'extinction], [effacée], [conservé],
    [Ce qu'on y trouve], [les variables d'un programme en cours], [les fichiers, les programmes installés],
  )

  #legende[
    Au cours 1 : un fichier conserve un résultat après l'arrêt du programme.
    Il le peut parce qu'il est sur le disque.
  ]

  #notes[
    Ouvrir un fichier le copie du disque vers la mémoire vive ; l'enregistrer le
    recopie sur le disque. Un travail non enregistré n'est qu'en mémoire vive.

    SSD : mémoire flash, sans pièce mobile. Disque dur : plateau tournant, cent
    fois plus lent à l'accès. Les postes de la salle ont un SSD (relevé au
    TD 5a).
  ]
]

// --------------------------------------------
#d("Le chemin d'une donnée")[
  #annonce[
    Une donnée traitée par le processeur passe par tous les étages : plus
    l'étage est proche du processeur, plus il est petit et rapide.
  ]

  #align(center, pyramide-memoire())

  #notes[
    Le cache est une petite mémoire dans le processeur ; il garde les dernières
    données lues en mémoire vive. Une boucle sur des valeurs voisines est donc
    plus rapide qu'une boucle qui saute dans un tableau.

    Le réseau est un étage de plus, au-delà du disque.
  ]
]

// --------------------------------------------
#d("Ordres de grandeur : tailles")[
  #annonce[
    Chaque unité vaut mille fois la précédente.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: (left + horizon, right + horizon, left + horizon),
    [Unité], [Octets], [Un exemple],
    [1 octet], [1], [une lettre : `a`],
    [1 Ko], [1 000], [le poème du cours 1, 1 341 caractères : 1,3 Ko],
    [1 Mo], [1 000 000], [une photo de téléphone : 3 Mo],
    [100 Mo], [10#super[8]], [une dalle d'orthophoto, 5 000 × 5 000 pixels × 3 octets : 75 Mo],
    [1 Go], [10#super[9]], [une heure de vidéo HD : 1 à 3 Go ; Anaconda installé : 5 Go],
    [1 To], [10#super[12]], [le disque d'un portable],
  )

  #notes[
    Kilo, méga, giga, téra : les mêmes préfixes que pour les mètres.

    Kio, Mio, Gio valent 1 024, 1 024², 1 024³ octets. L'explorateur Windows
    affiche des Kio sous le nom « Ko » : un disque de 1 To y fait 931 « Go ».
    Le signaler sans s'y attarder.

    Dalle d'orthophoto : 25 millions de pixels × 3 octets (rouge, vert, bleu),
    sans compression. Le cours 3 compare les formats d'image.
  ]
]

// --------------------------------------------
#d("Ordres de grandeur : temps d'accès")[
  #annonce[
    De la nanoseconde à la demi-seconde, sur une échelle logarithmique :
    chaque graduation vaut dix fois la précédente.
  ]

  #barres-temps((
    ([cache du processeur], 1e-9, [1 ns], accent),
    ([mémoire vive], 1e-7, [100 ns], accent),
    ([SSD], 1e-4, [100 µs], accent),
    ([disque dur], 1e-2, [10 ms], accent),
    ([réseau de la salle], 5e-4, [0,5 ms], attention),
    ([Paris – Marseille], 1.3e-2, [13 ms], attention),
    ([Paris – New York], 7.5e-2, [75 ms], attention),
    ([Paris – Sydney], 2.7e-1, [270 ms], attention),
  ))

  #legende[
    Temps d'un accès ou d'un aller-retour, valeurs typiques ; réseau mesuré
    depuis Paris (wondernetwork.com, septembre 2026).
  ]

  #notes[
    Chaque barre est environ mille fois plus longue que la précédente. Les temps
    réseau, en bleu clair, commencent au niveau du disque dur.

    Ce sont des temps d'accès, jusqu'au premier octet. Le débit est traité en
    partie 2.
  ]
]

// --------------------------------------------
#d("Si la mémoire vive valait une seconde")[
  #annonce[
    Les temps de la diapositive précédente, multipliés par dix millions.
  ]

  #tableau(
    columns: (1fr, auto, auto),
    align: (left + horizon, right + horizon, right + horizon),
    [Accès], [Temps réel], [À l'échelle],
    [cache du processeur], [1 ns], [un centième de seconde],
    [mémoire vive], [100 ns], [1 seconde],
    [SSD], [100 µs], [un quart d'heure],
    [disque dur], [10 ms], [une journée],
    [Paris – Marseille, aller-retour], [13 ms], [un jour et demi],
    [Paris – New York, aller-retour], [75 ms], [une semaine],
    [Paris – Sydney, aller-retour], [270 ms], [un mois],
  )

  #notes[
    Pendant une lecture sur le disque dur, le processeur pourrait faire
    l'équivalent d'une journée d'accès à la mémoire ; pendant un aller-retour
    vers New York, une semaine.

    Construction reprise de Brendan Gregg, *Systems Performance*, avec le cycle
    du processeur pour unité.

    Conséquences pour un programme, à dire :
    - lire un fichier une fois et garder son contenu en mémoire ;
    - écrire des nombres en binaire (images P5, cours 3) ;
    - numpy à la place d'une boucle Python (projet 7) ;
    - `commit` en local, `push` sur le réseau (partie 2).

    Mesurer avant de modifier : c'est l'objet du projet 7.
  ]
]

// --------------------------------------------
#d("Processeur et carte graphique : la puce")[
  #annonce[
    Le processeur consacre sa surface au contrôle et au cache, la carte
    graphique au calcul.
  ]

  #align(center, schema-puces())

  #legende[
    D'après NVIDIA, *CUDA C++ Programming Guide*, figure 1 ; proportions
    indicatives.
  ]

  #notes[
    Contrôle : lecture des instructions, prévision des sauts, réordonnancement.
    Il rend un cœur rapide sur un programme quelconque et occupe de la surface.
    Sur la carte graphique, un contrôle pilote une rangée d'unités, qui
    exécutent toutes la même instruction.

    Cache : il évite d'attendre la mémoire vive. La carte graphique en a peu ;
    pendant qu'une rangée attend ses données, une autre calcule.

    Le schéma montre 10 rangées de 22 unités. Une carte courante a 3 000 à
    16 000 unités, que les fabricants appellent des cœurs.
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

    Vidéo facultative : MythBusters pour NVIDIA, 2008, 1 min 30.
    https://www.youtube.com/watch?v=fKK933KK6Gg
  ]
]

// --------------------------------------------
#d("Trente ans de processeurs")[
  #annonce[
    La fréquence a cessé de monter vers 2005 ; les transistors et les cœurs
    continuent.
  ]

  #align(center, graphe-tendances(hauteur: 7.9))

  #legende[
    Un point par processeur, échelle verticale logarithmique. Karl Rupp,
    *microprocessor-trend-data*, CC BY 4.0.
  ]

  #notes[
    Loi de Moore : le nombre de transistors double environ tous les deux ans
    depuis 1970.

    La fréquence plafonne vers 3 GHz depuis 2005, parce que la puissance à
    évacuer plafonne vers 100 W. Le gain vient depuis du nombre de cœurs ; un
    programme qui n'en utilise qu'un gagne peu d'une génération à l'autre.

    De 1995 à 2025 : mémoire vive de 8 Mo à 16 Go ; disque de 1 Go à 1 To ; prix
    du Go de disque de 1 000 \$ à 2 centimes ; modem à 28,8 kbit/s, fibre à
    1 Gbit/s.
  ]
]

// --------------------------------------------
#d("Puissance de calcul et consommation")[
  #annonce[
    Un smartphone calcule autant que le premier superordinateur à dépasser
    mille milliards d'opérations par seconde, en 1997, pour cent mille fois
    moins d'électricité.
  ]

  #tableau(
    columns: (1.4fr, auto, auto, auto),
    align: (left + horizon, right + horizon, right + horizon, right + horizon),
    [Appareil], [Opérations par seconde], [Puissance], [Électricité par an],
    [téléphone à touches], [10#super[7]], [0,01 à 0,5 W], [0,1 kWh],
    [smartphone], [10#super[12]], [1 à 5 W], [5 à 7 kWh],
    [ordinateur portable], [10#super[12]], [15 à 45 W], [30 à 60 kWh],
    [PC de bureau et carte graphique], [10#super[13] à 10#super[14]], [100 à 400 W], [200 à 400 kWh],
    [serveur, en continu], [10#super[13]], [300 à 800 W], [3 000 à 7 000 kWh],
    [ASCI Red, superordinateur, 1997], [1,3 · 10#super[12]], [850 000 W], [7 500 000 kWh],
  )

  #legende[
    Ordres de grandeur ; opérations en virgule flottante, processeur graphique
    compris. ASCI Red : 1,3 TFLOPS mesurés, 850 kW hors refroidissement.
  ]

  #notes[
    Hypothèses de la dernière colonne : téléphone à touches rechargé une fois
    par semaine (batterie de 3 Wh), smartphone chaque jour (15 Wh), portable
    8 h par jour, serveur en continu.

    Le téléphone à touches consomme quelques dizaines de milliwatts : sa
    batterie tient dix jours.

    Un smartphone a les composants d'un PC sur une puce de 2 cm, limités à 5 W
    par la batterie et l'absence de ventilateur.
  ]
]

// --------------------------------------------
#d("L'électricité des services en ligne")[
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
#d("Ce que coûte un service en ligne")[
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
