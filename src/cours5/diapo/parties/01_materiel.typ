// Cours 5, partie 1 — le matériel. Incluse par `cours5.typ`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": schema-composants, schema-processeur, pyramide-memoire, barres-temps, photo-reperee, legende-reperes, graphe-tendances, schema-puces-image, schema-operations

#separateur(
  "Le matériel",
  annonce: "Les composants d'un ordinateur, le rôle de chacun et les ordres de grandeur associés.",
)

// --------------------------------------------
// Avec la photo en place, le schéma est numéroté et la photo du boîtier
// ouvert est à sa droite, avec les mêmes numéros (fusion du 19/10/2026 avec
// « Un boîtier ouvert ») ; sans elle, le schéma seul.
#d("Les composants d'un ordinateur")[
  #if captures-disponibles {
    grid(
      columns: (auto, 1fr), column-gutter: 16pt, align: horizon,
      scale(86%, reflow: true, schema-composants(dessous: true, numeros: true)),
      [
        #photo-reperee("/illustrations/cours5/boitier_ouvert.jpg", 1400 / 1275, (
          (0.34, 0.50), (0.47, 0.42), (0.62, 0.53),
          (0.30, 0.66), (0.185, 0.58), (0.23, 0.21),
        ), hauteur: 262pt)
        #legende[
          Un PC de bureau des années 2010, panneau retiré. Photo
          PantheraLeo1359531, Wikimedia Commons, CC BY 4.0.
        ]
      ],
    )
  } else {
    align(center, schema-composants())
  }

  #notes[
    La suite de la partie détaille le processeur, la mémoire vive et le disque.

    Les numéros du schéma désignent les mêmes composants sur la photo. Le
    processeur est sous le ventilateur (1). La carte réseau est intégrée à la
    carte mère ; on n'en voit que la prise, parmi les connecteurs arrière (5).
    Ce poste n'a pas de carte graphique séparée : le processeur gère
    l'affichage. Les emplacements vides (4) permettent d'en ajouter une.

    La carte mère relie les composants par des pistes de cuivre. Un ensemble de
    pistes entre deux composants s'appelle un bus.

    Carte graphique : conçue pour calculer l'image affichée, utilisée aujourd'hui
    pour le calcul parallèle (diapositive « Processeur et carte graphique »).

    Carte réseau : câble ou Wi-Fi ; sujet de la partie 2.

    Alimentation : convertit le 230 V du secteur en 12 V, 5 V et 3,3 V.

    Un portable et un téléphone ont les mêmes composants, soudés sur une seule
    carte.
  ]
]

// « Un boîtier ouvert » et « La carte mère », retirées le 19/10/2026 : la
// photo du boîtier ouvert est passée sur « Les composants d'un ordinateur ».
// Gardées en commentaire pour une version ultérieure.
/*
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
*/

// --------------------------------------------
// Cinq diapositives sur un même schéma, `schema-processeur(etape)` : chacune
// ajoute un facteur au nombre d'opérations par seconde, jusqu'à la ligne
// « Processeur » d'« Opérations par seconde d'un portable » (19/10/2026,
// remplace « Le processeur » et ses quatre cœurs à 3 GHz).
#d("Le processeur : un cœur")[
  #annonce[
    Un cœur exécute les instructions du programme une par une, une par cycle.
  ]

  #schema-processeur(1)

  #legende[
    Une cadence de 2~GHz fait 2 milliards de cycles par seconde. 2~GHz est la
    cadence de base de l'AMD Ryzen 5 7530U (2023), le processeur de portable
    des diapositives suivantes.
  ]

  #notes[
    Une instruction : lire une valeur en mémoire, multiplier, additionner,
    comparer, sauter à une autre instruction. Une ligne de Python correspond à
    des dizaines ou des centaines d'instructions.

    Le compte suppose une instruction de calcul à chaque cycle ; il donne un
    maximum.

    Les quatre diapositives suivantes ajoutent chacune un facteur, jusqu'aux
    six cœurs du Ryzen 5 7530U.

    Cadence de base : celle que le processeur tient sur tous ses cœurs à la
    fois. Un cœur seul monte jusqu'à 4,5 GHz.
  ]
]

// --------------------------------------------
#d("Le processeur : instructions vectorielles")[
  #annonce[
    Une instruction vectorielle applique la même opération à 8 nombres à la fois.
  ]

  #schema-processeur(2)

  #legende[
    Multiplier quatre nombres et en additionner quatre autres demande deux
    instructions. Nombres de 32 bits traités par une instruction : 4 depuis
    1999 (SSE), 8 depuis 2011 (AVX), 16 depuis 2016 (AVX-512).
  ]

  #notes[
    Les cases blanches et claires sont des registres : une mémoire de quelques
    octets dans le cœur, où une instruction lit ses nombres et écrit ses
    résultats. Un registre AVX a 256 bits, soit 8
    nombres de 32 bits. Les nombres y sont chargés avant, depuis la mémoire,
    par le cache.

    Usages : la même opération sur chaque pixel d'une image, sur chaque case
    d'un tableau numpy.

    Moitié moins de nombres par instruction pour les nombres de 64 bits, ceux
    de Python et, par défaut, de numpy.

    Sigle anglais : SIMD, *single instruction, multiple data*.
  ]
]

// --------------------------------------------
#d("Le processeur : multiplication et addition")[
  #annonce[
    Une seule instruction calcule a × b + c, et compte pour deux opérations.
  ]

  #schema-processeur(3)

  #legende[
    Instruction FMA, pour *fused multiply-add* : chez AMD depuis 2012, chez
    Intel depuis 2013.
  ]

  #notes[
    La multiplication et l'addition se font dans la même unité, en un seul
    passage, avec un seul arrondi à la fin.

    Les fabricants comptent deux opérations par instruction FMA quand ils
    annoncent une puissance de calcul.

    Calculs faits de a × b + c : produit de matrices, filtre sur une image,
    moyenne pondérée, évaluation d'un polynôme.
  ]
]

// --------------------------------------------
#d("Le processeur : deux instructions par cycle")[
  #annonce[
    Deux unités de calcul exécutent deux instructions indépendantes dans le
    même cycle.
  ]

  #schema-processeur(4)

  #legende[
    Deux instructions par cycle sur un processeur x86 depuis le Pentium
    (1993).
  ]

  #notes[
    Indépendantes : aucune des deux n'attend le résultat de l'autre. Le cœur
    lit les instructions à l'avance et lance ensemble celles qui n'attendent
    pas un résultat en cours de calcul. Processeur dit superscalaire.

    Le cœur Zen 3 du Ryzen 5 7530U a deux unités de multiplication-addition
    sur 8 nombres. Il a d'autres unités, qui travaillent pendant le même cycle :
    quatre pour les nombres entiers, deux pour les additions seules, trois
    lectures et deux écritures en mémoire par cycle. Une lecture et une
    multiplication se font donc dans le même cycle, sur deux unités
    différentes.

    Le maximum suppose les nombres déjà dans les registres. Une lecture en
    mémoire vive prend 100 ns, soit 200 cycles à 2 GHz ; le cache raccourcit
    cette attente.
  ]
]

// --------------------------------------------
#d("Le processeur : six cœurs")[
  #annonce[
    Chaque cœur suit sa file d'instructions ; un programme Python ordinaire
    n'en occupe qu'un.
  ]

  #schema-processeur(5)

  #legende[
    Deux cœurs sur les processeurs grand public depuis 2005 (AMD Athlon 64
    X2, Intel Pentium D).
  ]

  #notes[
    Le cœur 1, en bleu clair avec le logo, exécute le programme Python. Les
    autres cœurs servent aux autres programmes ouverts.

    Sur son cœur, un programme Python ordinaire n'emploie pas les
    instructions vectorielles ; numpy les emploie.

    Cœurs : 4 sur les postes de la salle (relevé au TD 5a), 4 à 8 sur un
    portable, 32 à 128 sur un serveur de calcul.

    Les cœurs se sont multipliés quand la fréquence a cessé de monter, vers
    2005 (diapositive suivante).

    Un programme occupe plusieurs cœurs s'il découpe son travail en parties
    indépendantes. numpy le fait pour le produit de matrices.

    Le gestionnaire des tâches affiche pour le Ryzen 5 7530U 6 cœurs et 12
    processeurs logiques : chaque cœur suit deux files d'instructions, qui se
    partagent ses unités.
  ]
]

// --------------------------------------------
#d("Évolution des processeurs de 1990 à 2022")[
  #annonce[
    Le nombre de transistors double environ tous les deux ans. Depuis 2005, la
    fréquence ne monte plus, et les transistors en plus servent à ajouter des
    cœurs.
  ]

  #align(center, graphe-tendances(hauteur: 6.7))

  #legende[
    Transistor : un interrupteur électronique ; tous les circuits d'une puce
    en sont faits. Pentium (1993) : 3,1 millions ; puce du Ryzen 5 7530U :
    10,7 milliards sur 180 mm². Un point par processeur, échelle verticale
    logarithmique. Karl Rupp, *microprocessor-trend-data*, CC BY 4.0.
  ]

  #notes[
    Loi de Moore : le nombre de transistors double environ tous les deux ans
    depuis 1970. Les transistors rétrécissent, et la même surface en porte
    deux fois plus.

    Jusque vers 2005, un transistor plus petit commutait aussi plus vite sans
    chauffer davantage par cm² (loi de Dennard), et la fréquence montait.
    Depuis, la tension d'alimentation ne baisse plus assez pour cela.

    Les transistors en plus servent aux facteurs des diapositives « Le
    processeur » : des instructions de 8 puis de 16 nombres, les unités de
    multiplication-addition, deux unités par cœur, plus de cœurs ; et aussi de
    plus grands caches, une carte graphique intégrée.

    La fréquence plafonne vers 3 GHz depuis 2005, parce que la puissance à
    évacuer plafonne vers 100 W. Le gain vient depuis du nombre de cœurs ; un
    programme qui n'en utilise qu'un gagne peu d'une génération à l'autre.

    De 1995 à 2025 : mémoire vive de 8 Mo à 16 Go ; disque de 1 Go à 1 To ; prix
    du Go de disque de 1 000 \$ à 2 centimes ; modem à 28,8 kbit/s, fibre à
    1 Gbit/s.
  ]
]

// --------------------------------------------
// Fusion de « Processeur et carte graphique : la puce » et de « … : une
// image » (19/10/2026). L'image est un paysage en pixel art, et le processeur
// a 8 cœurs sur les deux schémas.
#d("Processeur et carte graphique")[
  #annonce[
    Le processeur consacre sa surface au contrôle et au cache, la carte
    graphique au calcul.
  ]

  #align(center, schema-puces-image())

  #legende[
    Puces d'après NVIDIA, *CUDA C++ Programming Guide*, figure 1 ; proportions
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
#d("Opérations par seconde d'un portable")[
  #annonce[
    Le nombre d'opérations par seconde est un maximum théorique, atteint
    quand chaque unité de calcul travaille à chaque cycle.
  ]

  #schema-operations()

  #legende[
    AMD Ryzen 5 7530U (2023, 15 W) à sa cadence de base : six cœurs Zen 3, et
    une carte graphique intégrée de 448 unités. Nombres à virgule de 32 bits.
    Caractéristiques : Notebookcheck, CPU-Monkey.
  ]

  #notes[
    Le calcul : unités de calcul × cycles par seconde × opérations par cycle.
    La première ligne se refait avec les cœurs et la cadence relevés au TD 5a,
    en gardant 32 opérations par cycle comme ordre de grandeur.

    La ligne du processeur reprend « Le processeur : six cœurs ».

    La carte graphique fait les quatre cinquièmes du total, avec beaucoup
    d'unités simples (diapositive « Processeur et carte graphique »).

    Un programme Python ordinaire reste loin de ce maximum : une addition y
    prend 30 à 100 ns (TD 5a), soit 10 à 30 millions par seconde, cent mille
    fois moins. numpy emploie les instructions vectorielles ; la carte
    graphique demande des bibliothèques dédiées.

    Cadence de base 2 GHz ; jusqu'à 4,5 GHz sur un seul cœur.
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

    Cette limite a arrêté la montée en fréquence vers 2005 (« Évolution des
    processeurs de 1990 à 2022 »). Un portable qui ralentit pendant un long calcul baisse sa
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
#d("Hiérarchie des mémoires")[
  #annonce[
    Les types de mémoire sont rangés selon leur proximité du processeur, le
    plus proche en haut.
  ]

  #align(center, pyramide-memoire())

  #notes[
    Plus l'étage est proche du processeur, plus il est petit et rapide : les
    deux colonnes le montrent. La couleur reprend la ligne « À l'extinction »
    de la diapositive précédente ; le réseau garde les données sur un autre
    ordinateur, que l'extinction du poste ne touche pas.

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
// Fusion de « Ordres de grandeur : temps d'accès » et de « Si la mémoire vive
// valait une seconde » (19/10/2026), comme dans `cours5_short.typ`.
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

    Ce sont des temps d'accès, jusqu'au premier octet. Le débit est traité en
    partie 2.

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
