// Partie 1 du cours 1 v2 — incluse par `cours1_v2.typ`, qui porte les
// réglages globaux.
//

#import "../../../commun/prelude.typ": *
// Import nominatif, et non `: *` : `schemas.typ` ouvre `cetz.draw`, dont les
// noms (`grid`, `line`, `circle`, `content`…) masqueraient ceux de typst.
#import "../../../cours1/diapo/schemas.typ": schema-ou-sexecute
#import "../schemas.typ": schema-stockage-reseau, schema-entrees-sorties, schema-couches-logiciels, explorateur
#import "../../../cours5/diapo/schemas.typ": schema-composants, photo-reperee

// Nouveau (v2) : titre et annonce de la partie.
#separateur(
  "Matériel, logiciels, fichiers et stockage",
  annonce: "Quelques définitions et rappels"
)
// -------------------------------- Matériel ----------------------------------

// --------------------------------------------
// Repris du cours 5 le 04/11/2026 (`cours5/diapo/parties/01_materiel.typ`), qui
// garde la sienne. Seuls les renvois des notes changent.
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
    Le processeur est détaillé à la partie 3, avant la compilation. La mémoire
    vive et le disque sont repris sur « Exécution de programmes et stockage de données » ;
    leurs temps d'accès sont prévus au cours 3 v2.

    Les numéros du schéma désignent les mêmes composants sur la photo. Le
    processeur est sous le ventilateur (1). La carte réseau est intégrée à la
    carte mère ; on n'en voit que la prise, parmi les connecteurs arrière (5).
    Ce poste n'a pas de carte graphique séparée : le processeur gère
    l'affichage. Les emplacements vides (4) permettent d'en ajouter une.

    La carte mère relie les composants par des pistes de cuivre. Un ensemble de
    pistes entre deux composants s'appelle un bus.

    Carte graphique : conçue pour calculer l'image affichée, utilisée aujourd'hui
    pour le calcul parallèle.

    Carte réseau : câble ou Wi-Fi.

    Alimentation : convertit le 230 V du secteur en 12 V, 5 V et 3,3 V.

    Un portable et un téléphone ont les mêmes composants, soudés sur une seule
    carte.
  ]
]

// --------------------------------------------
// Reprises du cours 5 le 05/11/2026 (`cours5/diapo/parties/01_materiel.typ`), qui garde
// les siennes. La cadence n'est présentée qu'à la partie « Exécuter un programme » :
// « baisse sa fréquence » devient « ralentit ».
#d("Température du processeur")[
  #v(1em)
  #question("?")[
    Quelle température atteint un processeur pendant un calcul intensif de
    plusieurs minutes ?
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
    Pendant un calcul intensif, un processeur travaille entre 60 et 100 °C.
  ]

  #tableau(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    [Situation], [Température de la puce],
    [au repos, bureautique], [30 à 50 °C],
    [calcul intensif, poste de bureau], [60 à 90 °C],
    [calcul intensif, portable fin], [80 à 100 °C],
    [limite du fabricant, où le processeur ralentit], [95 °C (AMD), 100 °C (Intel)],
  )

  #legende[
    Ordres de grandeur ; limites des Ryzen 7000 et des Core de 13#super[e]
    génération, données par les fabricants.
  ]

  #notes[
    À la limite fixée par le fabricant, le processeur ralentit de lui-même pour ne
    pas s'abîmer. Sans radiateur ni ventilateur, il atteint cette limite en quelques
    secondes.

    Puissance : 65 à 250 W sur 1 à 2,5 cm², soit 50 à 100 W par cm². Une plaque
    de cuisson : moins de 10 W par cm².

    Cette limite a arrêté la montée en fréquence vers 2005 (« Évolution des
    processeurs de 1990 à 2022 », cours 5). Un portable qui ralentit pendant un long
    calcul baisse sa fréquence pour rester sous la limite.

    AMD (2022) : 95 °C pendant un calcul intensif est le fonctionnement prévu des Ryzen 7000.

    Le gestionnaire des tâches de Windows n'affiche pas la température du
    processeur ; il faut l'outil du fabricant.
  ]
]

// --------------------------------------------
// D'après « Puissance de calcul et consommation » du cours 5, le 05/11/2026 : sans la
// colonne des opérations par seconde. La ligne d'ASCI Red est remplacée par un serveur
// GPU, et l'annonce par la comparaison avec ce serveur. NVIDIA DGX H100 : huit H100,
// 10,2 kW au maximum (guide d'utilisation de NVIDIA) ; 10,2 kW × 8 760 h = 89 000 kWh.
#d("Consommation électrique des appareils")[
  #annonce[
    À pleine puissance, un serveur GPU pour l'IA générative consomme en quelques
    heures l'électricité d'un ordinateur portable pendant un an.
  ]

  #tableau(
    columns: (1.4fr, auto, auto),
    align: (left + horizon, right + horizon, right + horizon),
    [Appareil], [Puissance], [Électricité par an],
    [téléphone à touches], [0,01 à 0,5 W], [0,1 kWh],
    [smartphone], [1 à 5 W], [5 à 7 kWh],
    [ordinateur portable], [15 à 45 W], [30 à 60 kWh],
    [PC de bureau et carte graphique], [100 à 400 W], [200 à 400 kWh],
    [serveur, en continu], [300 à 800 W], [3 000 à 7 000 kWh],
    [serveur GPU pour l'IA générative, en continu], [10 000 W], [90 000 kWh],
  )

  #legende[
    Ordres de grandeur ; portable 8 h par jour. GPU : carte graphique, _graphics
    processing unit_. Serveur GPU : NVIDIA DGX H100, huit cartes, 10,2 kW au maximum,
    à pleine puissance toute l'année.
  ]

  #notes[
    Hypothèses de la dernière colonne : téléphone à touches rechargé une fois
    par semaine (batterie de 3 Wh), smartphone chaque jour (15 Wh), portable
    8 h par jour, serveur en continu.

    Serveur GPU : 10,2 kW × 8 760 h = 89 000 kWh, un maximum. Un portable consomme
    30 à 60 kWh par an, soit 3 à 6 h de ce serveur. Une carte H100 seule : jusqu'à
    700 W (fiche de NVIDIA). Le cours 5 donne la consommation d'une question à un
    assistant d'IA et celle des centres de données.

    Le téléphone à touches consomme quelques dizaines de milliwatts : sa
    batterie tient dix jours.

    Un smartphone a les composants d'un PC sur une puce de 2 cm, limités à 5 W
    par la batterie et l'absence de ventilateur.
  ]
]

// ------------------------------- Vocabulaire --------------------------------

// --------------------------------------------
// 05/11/2026 : fusion de « Logiciel : définition et termes courants » et de « Entrées et
// sorties d'un logiciel ». La définition passe dans les notes, les termes webapp et driver
// sur « Le système d'exploitation », et la phrase sur l'utilité d'un fichier sur « Fichier,
// extension et type de fichier ».
#d("Exécution de programmes et stockage de données")[
  #annonce[
    Deux fonctions principales d'un ordinateur sont l'exécution de programmes et le
    stockage de données.
  ]

  #align(center, scale(92%, reflow: true, schema-entrees-sorties()))

  #notes[
    Les entrées et sorties d'un programme sont des fichiers ou des flux échangés
    avec les périphériques.

    Lire le schéma à l'horizontale, puis à la verticale. Ce qu'un programme
    garde en mémoire vive disparaît quand il s'arrête. Pas de sauvegarde en
    RAM. Le fichier enregistré sur le disque est pérenne, et peut se rouvrir plus tard.

    Le réseau est du côté des périphériques, en entrée comme en sortie :
    pour le logiciel, c'est un flux qu'on lit ou qu'on écrit sans qu'il
    reste, comme le clavier ou l'écran. Sur la flèche de copie, le réseau
    transporte un flux, et le fichier est sur un disque à chaque bout.

    Logiciel, définition officielle à citer si besoin : « Ensemble des programmes,
    procédés et règles, et éventuellement de la documentation, relatifs au fonctionnement
    d'un ensemble de traitement de données » (_Journal officiel_ du 22/09/2000, vocabulaire
    de l'informatique). Le seul mot de cette partie à avoir une définition officielle.

    Transition vers la suite de la partie : les logiciels, puis les fichiers.
  ]
]

// --------------------------------------------
// 05/11/2026 : la question sur la webapp et le driver est ajoutée, en bas, à celle sur le
// téléphone. La diapositive suivante y répond.
#d("Couches matérielles et logicielles")[
  #annonce[
    Un programme ne s'adresse pas directement au matériel : il passe par le système (OS).
  ]

  #couche(
    icone-fenetre(taille: 26pt), "Programmes",
    "LibreOffice, un navigateur, votre script", plein: true,
  )
  #liaison("« ouvre releve.csv »", "le contenu")
  #couche(
    icone-engrenage(taille: 26pt), "Système d'exploitation",
    "Windows, macOS, Linux",
  )
  #liaison("« écris ces octets »", "les octets lus sur le disque")
  #couche(
    icone-puce(taille: 26pt), "Matériel",
    "processeur, mémoire, disque, réseau",
  )

  #block(
    width: 100%, inset: (x: 14pt, y: 7pt), above: 0.5em,
    fill: gris, stroke: (left: 3pt + accent),
  )[
    #text(size: 17pt)[
      Où placer une webapp et un driver sur ce schéma ? Quel OS tourne sur votre téléphone ?
    ]
  ]

  #notes[
    Le système orchestre les programmes ouverts en même temps et gère aussi
    les droits d'accès (il empêche un programme d'écrire dans la mémoire d'un
    autre). Conséquences pratiques : un programme peut dépendre de l'OS et du
    matériel, et ne fonctionner que sur certaines combinaisons ; les chemins
    de fichiers ne s'écrivent pas pareil d'un système à l'autre, et les
    outils installés diffèrent.

    Les questions servent à interroger la salle et à ouvrir une discussion sur le sens
    de ces mots. Faire répondre à l'oral, puis passer aux réponses.

    La question sur le téléphone sert à faire constater que le schéma vaut aussi pour
    les smartphones. Réponse attendue : Android ou iOS.
    Éventuellement évoquer le lien entre Linux et Android.
  ]
]

// --------------------------------------------
// 05/11/2026 : la pile de la diapositive précédente, avec les applications web, les
// pilotes et les systèmes des téléphones.
#d("Couches matérielles et logicielles — réponses")[
  #annonce[
    Un programme ne s'adresse pas directement au matériel : il passe par le système (OS).
  ]

  #schema-couches-logiciels()

  #notes[
    Ce qu'il faut en tirer : aucun de ces mots n'a de définition arrêtée, et
    tous désignent des logiciels. « App » est l'abréviation anglaise
    d'application, répandue par les magasins d'applications des téléphones ; le
    mot ne désigne pas une technologie particulière, le même logiciel existant
    souvent en site web, en programme de bureau et en application mobile.

    Les définitions d'usage : Grand dictionnaire terminologique de l'OQLF.

    Une application web s'utilise dans le navigateur, et une partie de ses calculs
    se fait en général sur un serveur.

    Le système transmet une demande générale au pilote, et le pilote commande le
    composant en détail. Les pilotes font partie du système : plus de 70 % du code de
    Linux en 2001 (Arpaci-Dusseau, _Operating Systems: Three Easy Pieces_, chap. 36).

    OS et driver ramènent à la vieille partition du vocabulaire officiel :
    logiciel de base, qui fait fonctionner la machine et donne accès au
    matériel (Windows, macOS, Linux, et les pilotes), contre logiciel
    d'application, qui sert à accomplir une tâche (LibreOffice, Firefox, un
    lecteur de musique).
  ]
]

// ------------------------------ Fichiers -----------------------------------
// --------------------------------------------
// Masquée à la relecture du 19/10/2026 : le lieu d'exécution d'une
// application web n'est plus projeté. Retirer `/*` et `*/` pour la remettre.
/*
#d("Où s'exécute une application web ?")[
  #align(center, schema-ou-sexecute())

  #notes[
    Ce que la diapositive fait remarquer, et qui ne se dit pas tout seul : des
    tâches qui demandaient un logiciel installé se font dans un navigateur, et
    le lieu du calcul, donc celui des fichiers, a changé sans qu'on le dise.

    Presque aucune application web n'est entièrement
    d'un côté. Une messagerie affiche chez vous mais cherche dans vos
    messages sur son serveur. La question utile n'est pas « où est-ce que
    ça tourne ? » mais « qu'est-ce qui part, et quand ? ».

    Le critère de complexité explique les exemples : recadrer une image
    tient dans le navigateur ; chercher dans l'index du web, calculer un
    itinéraire sur tout le réseau routier ou faire tourner un grand modèle,
    non — et surtout, les données sont là-bas, pas chez vous. Une requête
    sur une base de données est le cas le plus courant : la page envoie la
    question, le serveur renvoie les lignes qui correspondent. Il explique aussi les évolutions : ce qui se calculait à distance
    il y a dix ans se calcule parfois en local aujourd'hui.
  ]
]
*/
// -------------------------- Extensions et formats ---------------------------
// --------------------------------------------
#d("Fichier, extension et type de fichier")[
  #annonce[
    Un fichier conserve un résultat. On peut l'ouvrir avec un autre logiciel ou le
    copier sur une autre machine.
  ]

  #grid(
    columns: (1fr, 1fr), column-gutter: 26pt, align: top,
    [
      #{
        // Sans cet espacement, le corps de `fenetre` commence par une ligne vide.
        set block(spacing: 0pt)
        explorateur(
          [C:\\Users\\alice\\Documents],
          ("altitudes.py", "carte.png", "raven.odt", "releve_2026.csv"),
          choisi: 3,
        )
      }
      #legende[L'explorateur affiche ce qui est stocké sur le disque.]
    ],
    [
      #annonce[
        Le type d'un fichier (texte, vidéo…) est indiqué par son *extension*. Le
        système s'en sert pour choisir le logiciel à lancer.
      ]
      #align(center)[
        #grid(
          columns: (auto, auto),
          row-gutter: 9pt,
          align: center,
          text(font: police-code, size: 27pt, fill: estompe)[releve\_2026],
          text(font: police-code, size: 27pt, fill: accent, weight: "bold")[.csv],
          text(size: 13pt, fill: estompe)[le nom, que vous choisissez],
          text(size: 13pt, fill: accent)[l'extension],
        )
      ]
    ],
  )
  #avertissement[
    Windows masque les extensions qu'il connaît : `raven.odt` s'affiche
    `raven`. Réglage à changer une fois, avant le TD 1a.
  ]

  #notes[
    À dire, sans l'afficher : l'extension est la fin du nom, après le dernier point. Le
    système choisit d'après elle le logiciel lancé au double-clic. Elle se
    change en renommant le fichier, comme le reste du nom. 
    L'extension indique le type du contenu sans le garantir. Le TD 1b le fait constater au terminal.

    Si besoin faire activer l'affichage des extensions dans l'explorateur, sans quoi le
    TD qui suit est impossible à suivre : `F2` ne montrerait pas ce qu'on renomme.

    État vérifié en 2026 : Windows 11 masque toujours les extensions des types
    connus par défaut, et le réglage se trouve dans Explorateur > Affichage >
    Afficher > Extensions de noms de fichiers. Sous macOS, Finder > Réglages >
    Avancé > « Afficher tous les suffixes de fichiers ». 

    Exemples d'usage d'un fichier, à donner à l'oral : relire dans une
    semaine ce que le programme a produit ; un tableau (tableur) écrit par un
    logiciel, puis importé ou ouvert dans un autre ; un transfert entre
    postes (et vers un stockage externe, comme une clé USB).

    Un format de fichier est un moyen d'échange et d'interaction entre
    logiciels.
  ]
]
// --------------------------------------------
#d("Reconnaître un format à son extension")[
  #annonce[
    Pour chacune de ces extensions, dites de quel type de contenu il s'agit, et si le fichier
    est lisible dans un éditeur de texte.
  ]

  #grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    gutter: 9pt,
    etiquette(".mp3"), etiquette(".mp4"), etiquette(".jpg"), etiquette(".png"),
    etiquette(".svg"), etiquette(".tif"), etiquette(".pdf"), etiquette(".odt"),
    etiquette(".xlsx"), etiquette(".csv"), etiquette(".zip"), etiquette(".exe"),
    etiquette(".py", couleur: attention), etiquette(".md", couleur: attention),
    etiquette(".json", couleur: attention), etiquette(".yaml", couleur: attention),
  )

  #notes[
    Interroger la salle, en trois minutes, sans commenter chaque réponse. Les
    deux qui peuvent faire débat : `.svg` (une image, mais du texte XML) et `.csv` (du
    texte, pas un fichier Excel). Ne pas s'attarder sur `.tif`.

    La dernière ligne est celle des formats utilisés en programmation (python). 
    Probable que les étudiants ne les connaissent pas tous.
  ]
]

// --------------------------------------------
#d("Reconnaître un format à son extension — réponses")[
  #grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    gutter: 9pt,
    etiquette(".mp3", reponse: "son, avec perte"),
    etiquette(".mp4", reponse: "vidéo, la plus courante"),
    etiquette(".jpg", reponse: "photo, avec perte"),
    etiquette(".png", reponse: "image, sans perte"),
    etiquette(".svg", reponse: "image vectorielle : texte"),
    etiquette(".tif", reponse: "image, y compris GeoTIFF"),
    etiquette(".pdf", reponse: "document mis en page"),
    etiquette(".odt", reponse: "LibreOffice, archive ZIP"),
    etiquette(".xlsx", reponse: "Excel, archive ZIP"),
    etiquette(".csv", reponse: "tableau : du texte"),
    etiquette(".zip", reponse: "archive de fichiers"),
    etiquette(".exe", reponse: "programme Windows"),
    etiquette(".py", reponse: "code Python : du texte", couleur: attention),
    etiquette(".md", reponse: "documentation : du texte", couleur: attention),
    etiquette(".json", reponse: "données, réglages : texte", couleur: attention),
    etiquette(".yaml", reponse: "réglages : du texte", couleur: attention),
  )

  #legende[
    Six de ces seize formats sont du texte : ceux qu'on peut ouvrir dans un
    éditeur, comparer ligne à ligne et versionner. En bleu, les quatre que vous
    écrirez vous-mêmes dans ce module.
  ]

  #notes[
    Les six formats texte de la grille : `.svg`, `.csv`, `.py`, `.md`, `.json`
    et `.yaml`. Deux autres sont des archives ZIP de XML, `.odt` et `.xlsx`.
    v2 : le TD qui ouvrait l'archive `.odt` (TD 1b de 2026) est en annexe.
  ]
]

// ------------------------------- Chemins -----------------------------------

// --------------------------------------------
#d("Quizz : vocabulaire associé aux chemins de fichier")[
  #annonce[
    Un chemin dit où trouver un fichier dans l'arborescence des dossiers.
    Les parties d'un chemin ont chacune un nom : dites à quoi chacun
    correspond dans cet exemple.
  ]

  #align(center)[
    #text(font: police-code, size: 25pt, fill: encre)[C:\\Users\\alice\\Documents\\raven.odt]
  ]

  #v(0.5em)
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Nom de la partie du chemin], [Ce qu'il désigne dans l'exemple],
    [la racine, ou le disque], [],
    [un nom de dossier], [],
    [le nom du fichier], [],
    [le chemin du fichier], [],
    [le dossier parent], [],
  )

  #notes[
    Trois minutes, à l'oral, sans commenter chaque réponse : la diapositive
    suivante donne les réponses.

    Racine : le point de départ que la machine connaît. `C:` désigne le
    disque sous Windows ; sous macOS et Linux, la racine est `/`
  ]
]

// --------------------------------------------
#d("Quizz : vocabulaire associé aux chemins de fichier - Réponse")[
  // Le chemin s'écrit d'un seul tenant, sans blanc entre les segments : c'est
  // ainsi qu'il apparaît dans l'explorateur. Les colonnes sont donc mesurées
  // sur les segments eux-mêmes, et les étiquettes, plus larges, sont posées
  // par `place` : elles débordent de leur colonne sans l'élargir.
  #align(center)[
    #context {
      let taille = 25pt
      let segments = (
        (estompe, "C:\\", "la racine, ou le disque"),
        (brun, "Users\\alice\\Documents\\", "trois noms de dossier"),
        (accent, "raven.odt", "le nom du fichier, extension comprise"),
      )
      let morceau(couleur, chaine) = text(
        font: police-code, size: taille, fill: couleur,
        weight: if couleur == brun { demi-gras } else { "regular" },
        chaine,
      )
      grid(
        columns: segments.map(((c, t, _)) => measure(morceau(c, t)).width),
        column-gutter: 0pt,
        row-gutter: 13pt,
        ..segments.map(((c, t, _)) => morceau(c, t)),
        ..segments.map(((c, _, e)) => {
          // L'étiquette est mesurée puis posée à sa largeur naturelle : sans
          // cela, elle se replierait sur la largeur de son segment.
          let etiq = text(size: 14pt, fill: c)[#e]
          box(width: 100%, height: 1.2em)[
            #place(center + top, box(width: measure(etiq).width, etiq))
          ]
        }),
      )
    }
  ]

  #v(0.6em)
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Nom de la partie du chemin], [Ce qu'il désigne dans l'exemple],
    [la racine, ou le disque],
      [#text(fill: estompe)[`C:\`], le point de départ ; `/` sous macOS et Linux],
    [un nom de dossier],
      [#text(fill: brun)[`Users`, `alice`, `Documents`] : trois, du plus large au plus précis],
    [le nom du fichier],
      [`raven.odt`, extension comprise],
    [le chemin du fichier], [tout, de la racine au fichier],
    [le dossier parent],
      [#text(fill: estompe)[`C:\`]#text(fill: brun)[`Users\alice\Documents`], le dossier qui le contient],
  )

  #legende[
    Un chemin se lit de gauche à droite, de la racine au fichier ; chaque
    séparateur descend d'un dossier.
  ]

  #notes[
    Insister sur la dernière ligne : « dossier parent » est le mot des
    messages d'erreur et des fonctions de Python (`Path.parent`). Le cours 3
    s'en sert sans le redéfinir.
  ]
]

// ------------------------------- Stockage ----------------------------------
#d("Les emplacements de stockage sur le réseau")[
  #annonce[
    Le Bureau est sur le disque du poste, `formationTemp` sur le disque du
    serveur de l'école. Pour aller sur Internet, les postes passent par le
    proxy de l'école, avec demande de mot de passe.
  ]

  #align(center, scale(85%, reflow: true, schema-stockage-reseau()))

  #legende[
    Un chemin qui commence par `\\` désigne un dossier d'une autre machine,
    ici le serveur.
  ]

  #notes[
    Faire situer sur le schéma le disque du poste, `formationTemp`,
    l'espace personnel et le stockage en ligne. La clé USB n'y figure pas.

    Lire un fichier sur le réseau est plus lent que sur le disque du poste.

    À compléter avant la séance : le nom de l'espace personnel de l'élève,
    son chemin, et comment l'ouvrir. Les élèves ne s'en servent pas encore
    en septembre : le nommer, sans en faire dépendre le TD.

    À vérifier : si le disque `D:` des postes (Documents) est local.

    Stockage en ligne synchronisé : OneDrive, Google Drive, Dropbox. Le
    fichier est sur le poste et sur le serveur ; un logiciel recopie chaque
    modification dans les deux sens.

    Depuis chez soi, `formationTemp` et l'espace personnel ne sont pas
    accessibles. Depuis l'école, Internet l'est.
    Le serveur de l'école porte aussi les espaces personnels.

    À compléter avant la séance : le vrai chemin de `formationTemp` sur les
    postes (`\\…\…`), la lettre de lecteur s'il y en a une, et le
    fonctionnement du proxy (identifiant de l'école, fenêtre du navigateur).
    Le chemin se relève dans la barre d'adresse de l'explorateur, raccourci
    du Bureau ouvert. La règle de `src/avant/donnees.md` (« une autre lettre
    que `C:` ») est fausse si `D:` est un disque du poste : à vérifier.
  ]
]

