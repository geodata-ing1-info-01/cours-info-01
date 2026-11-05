// Cours 5 v2, partie 5 : le matériel. Incluse par `cours5_v2.typ`.
//
// Ce qui reste de la partie matériel du cours 5 de 2026 (`cours5/diapo/parties/
// 01_materiel.typ`, inchangée) le 05/11/2026. Parties ailleurs en v2 : « Les
// composants d'un ordinateur », « Le processeur : un cœur » et la température au cours
// 1 ; « Puissance de calcul et consommation », sans ses opérations par seconde, au
// cours 1 ; la mémoire et le stockage au cours 3.
#import "../../../commun/prelude.typ": *
#import "../../../cours5/diapo/schemas.typ": schema-processeur, graphe-tendances, schema-puces-image, schema-operations

#separateur(
  "Le matériel",
  annonce: "Le processeur et la carte graphique, leur évolution, et ce que consomment et coûtent les services en ligne.",
)

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
    Reprend le schéma de « Exécution des instructions machine : un cœur », cours 1.

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

