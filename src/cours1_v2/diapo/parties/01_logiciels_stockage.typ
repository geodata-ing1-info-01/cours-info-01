// Partie 1 du cours 1 v2 — incluse par `cours1_v2.typ`, qui porte les
// réglages globaux. Un fichier inclus n'hérite pas des imports de son appelant.
//
// Reprend les diapositives 10 à 14, 18, 21 et 22 du cours 1 de 2026, sans les
// reformuler. Les chemins passent à la partie 2 (terminal), le binaire et le
// texte au cours 3, sauf le quiz sur le vocabulaire des chemins (diapositives
// 15 et 16 de 2026), placé après les formats. Quatre diapositives nouvelles
// sur le stockage, à la fin.
#import "../../../commun/prelude.typ": *
// Import nominatif, et non `: *` : `schemas.typ` ouvre `cetz.draw`, dont les
// noms (`grid`, `line`, `circle`, `content`…) masqueraient ceux de typst.
#import "../../../cours1/diapo/schemas.typ": schema-ou-sexecute
#import "../schemas.typ": schema-stockage-reseau, schema-entrees-sorties

// Nouveau (v2) : titre et annonce de la partie.
#separateur(
  "Logiciels, fichiers et stockage",
  annonce: "Ce qu'un logiciel fait, le rôle des fichiers et les disques où ils sont enregistrés."
)
// ------------------------------- Vocabulaire --------------------------------

// --------------------------------------------
#d("Logiciel : définition et termes courants")[
  #bloc-titre("Définition : logiciel")[
    #set text(size: 19pt)
    Ensemble des programmes, procédés et règles, et éventuellement de la
    documentation, relatifs au fonctionnement d'un ensemble de traitement de
    données.
  ]
  #legende[
    Source : _Journal officiel_ du 22/09/2000 (vocabulaire de l'informatique).
    Le seul de ces mots à avoir une définition officielle.
  ]

  #v(0.6em)
  #annonce[
    Autres termes courants, qui désignent chacun un type de logiciel.
  ]
  #grid(
    columns: (1fr,) * 5, gutter: 12pt,
    ..("application", "app", "webapp", "OS", "driver").map(terme => block(
      width: 100%, inset: (x: 8pt, y: 13pt), fill: gris,
      stroke: 0.8pt + accent.lighten(50%),
    )[
      #align(center, text(size: 19pt, weight: demi-gras)[#terme])
    ]),
  )

  #legende[
    Les définitions d'usage : Grand dictionnaire terminologique de l'OQLF.
  ]

  #notes[
    Les cinq termes se traitent à l'oral, en demandant à la salle ce que chacun
    désigne et en quoi ils diffèrent. Ne rien écrire de plus à l'écran.

    Ce qu'il faut en tirer : aucun de ces mots n'a de définition arrêtée, et
    tous désignent des logiciels. « App » est l'abréviation anglaise
    d'application, répandue par les magasins d'applications des téléphones ; le
    mot ne désigne pas une technologie particulière, le même logiciel existant
    souvent en site web, en programme de bureau et en application mobile.

    OS et driver ramènent à la vieille partition du vocabulaire officiel :
    logiciel de base, qui fait fonctionner la machine et donne accès au
    matériel (Windows, macOS, Linux, et les pilotes), contre logiciel
    d'application, qui sert à accomplir une tâche (LibreOffice, Firefox, un
    lecteur de musique). La dire, sans l'afficher.

    // « Webapp » est repris à la diapositive sur le lieu d'exécution,
    // masquée depuis le 19/10/2026.
  ]
]

// --------------------------------------------
#d("Le système d'exploitation")[
  #annonce[
    Un programme ne s'adresse pas directement au matériel : il passe par le système.
  ]

  #couche(
    icone-fenetre(taille: 26pt), "Vos programmes",
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

  // Une seule question : le numéro de `question()` ne code plus rien, et la
  // place qu'il prend manque à la troisième couche.
  #block(
    width: 100%, inset: (x: 14pt, y: 7pt), above: 0.5em,
    fill: gris, stroke: (left: 3pt + accent),
  )[
    #text(size: 18pt)[Quel système d'exploitation tourne sur votre téléphone ?]
  ]

  #notes[
    Le système arbitre entre tous les programmes ouverts en même temps : c'est
    lui qui empêche l'un d'écrire dans la mémoire d'un autre. Conséquence
    pratique : les chemins de fichiers ne s'écrivent pas pareil d'un système à
    l'autre et les outils installés diffèrent. Le matériel est repris au
    cours 5.

    La question sert à faire constater que le schéma vaut aussi pour ce qu'ils
    ont en poche. Réponse attendue : Android ou iOS. Ordre de grandeur mondial
    si elle est demandée : environ 70 % Android, 30 % iOS (StatCounter, 2026).
    Éventuellement évoquer le lien entre Linux et Android.
  ]
]

// Relecture du 19/10/2026 : fusionnée avec « Utilisation / utilité d'un
// fichier », dont le tableau est retiré et les exemples passent en notes.
// Les quatre boîtes de 2026 sont remplacées par `schema-entrees-sorties`.
#d("Entrées et sorties d'un logiciel")[
  #annonce[
    Les entrées et sorties d'un logiciel sont des fichiers ou des flux
    échangés avec les périphériques. Un fichier conserve un résultat, que
    l'on peut ensuite ouvrir avec un autre logiciel, copier sur une autre
    machine ou remettre à quelqu'un d'autre.
  ]

  #align(center, schema-entrees-sorties())

  #notes[
    Lire le schéma à l'horizontale, puis à la verticale. Ce qu'un programme
    garde en mémoire vive disparaît quand il s'arrête. Pas de sauvegarde en
    RAM. Le fichier enregistré sur le disque reste, et se rouvre plus tard.
    Le processeur et la mémoire vive sont au cours 5 : ne pas les détailler
    ici.

    Le module s'intéresse à ce qui laisse un fichier, parce qu'un fichier
    se relit, se compare, se versionne, et surtout circule d'un logiciel
    à l'autre.

    Le réseau est du côté des périphériques, en entrée comme en sortie :
    pour le logiciel, c'est un flux qu'on lit ou qu'on écrit sans qu'il
    reste, comme le clavier ou l'écran. Sur la flèche de copie, le réseau
    transporte un flux, et le fichier est sur un disque à chaque bout.

    Exemples d'usage d'un fichier, à donner à l'oral : relire dans une
    semaine ce que le programme a produit ; le tableau écrit par un
    logiciel, ouvert par un autre ; de votre poste à celui de la salle, et
    retour ; un rendu, ou le dépôt partagé du cours 6.

    Un format de fichier est ce sur quoi deux logiciels se mettent d'accord
    sans se connaître.

    Transition vers la suite de la partie : reconnaître le type d'un
    fichier, et savoir sur quel disque il est enregistré.
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
  #avertissement[
    Windows masque les extensions qu'il connaît : `raven.odt` s'affiche
    `raven`. Réglage à changer une fois, avant le TD 1a.
  ]

  #notes[
    À dire, sans l'afficher (relecture du 19/10/2026, le tableau est
    retiré) : l'extension est la fin du nom, après le dernier point. Le
    système choisit d'après elle le logiciel lancé au double-clic. Elle se
    change en renommant le fichier, comme le reste du nom, et ce renommage
    ne modifie aucun octet du fichier : l'extension indique le type du
    contenu sans le garantir. Le TD 1b le fait constater au terminal.

    Faire activer l'affichage des extensions dans l'explorateur, sans quoi le
    TD qui suit est impossible à suivre : `F2` ne montrerait pas ce
    qu'on renomme.

    État vérifié en 2026 : Windows 11 masque toujours les extensions des types
    connus par défaut, et le réglage se trouve dans Explorateur > Affichage >
    Afficher > Extensions de noms de fichiers. Sous macOS, Finder > Réglages >
    Avancé > « Afficher tous les suffixes de fichiers ». À faire une fois, utile
    tout le semestre.
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

    La dernière ligne est celle du module, et elle est volontairement groupée :
    ce sont les quatre fichiers qu'ils éditeront eux-mêmes. Probable que les étudiants
    ne les connaissent pas.
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
// Diapositives 15 et 16 du cours 1 de 2026, sans reformulation.

// --------------------------------------------
#d("Quizz : vocabulaire associé aux chemins de fichier")[
  #annonce[
    Un chemin dit où trouver un fichier dans l'arborescence des dossiers.
    Plusieurs mots en désignent les parties : dites à quoi chacun correspond
    dans cet exemple.
  ]

  #align(center)[
    #text(font: police-code, size: 25pt, fill: encre)[C:\\Users\\alice\\Documents\\raven.odt]
  ]

  #v(0.5em)
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Le mot], [Ce qu'il désigne dans l'exemple],
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
    [Le mot], [Ce qu'il désigne dans l'exemple],
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
// Nouveau (v2) : quatre diapositives, d'après le syllabus v2 (partie 1) et les
// faits donnés par l'équipe le 26/09/2026 : le Bureau du poste est conservé
// d'une séance à l'autre ; l'espace personnel réseau existe, mais les élèves
// ne savent pas encore s'en servir en septembre.
// Relecture du 19/10/2026 : « Deux élèves dans le même dossier partagé »
// passe après le TD 1a, dans `01b_fichier_partage.typ`.

// --------------------------------------------
#d("Les emplacements de stockage")[
  #annonce[
    Un fichier est enregistré sur un disque : celui du poste, ou celui d'une
    autre machine que le poste atteint par le réseau. L'explorateur les
    présente de la même façon.
  ]

  #tableau(
    columns: (1.25fr, 1fr, 1fr),
    align: left + horizon,
    [Emplacement], [Qui y a accès], [D'une séance à l'autre],
    [Bureau, Documents : disque du poste], [votre session, sur ce poste], [conservés, sur ce poste seulement],
    [`formationTemp` : serveur de l'école], [toute la promotion], [modifiable par tous],
    [espace personnel : serveur de l'école], [vous, depuis tout poste], [conservé],
    [stockage en ligne : serveur hors de l'école], [vous, et qui vous invitez], [conservé, recopié sur le poste],
    [clé USB], [qui a la clé], [ce que vous emportez],
  )

  #notes[
    Lire un fichier sur le réseau est plus lent que sur le disque du poste ;
    les ordres de grandeur sont au cours 5.

    À compléter avant la séance : le nom de l'espace personnel de l'élève,
    son chemin, et comment l'ouvrir. Les élèves ne s'en servent pas encore
    en septembre : le nommer, sans en faire dépendre le TD.

    À vérifier : si le disque `D:` des postes (Documents) est local.

    Stockage en ligne synchronisé : OneDrive, Google Drive, Dropbox. Le
    fichier est sur le poste et sur le serveur ; un logiciel recopie chaque
    modification dans les deux sens.
  ]
]

// --------------------------------------------
// Nouveau (v2), 27/09 : le schéma des emplacements, entre le tableau et le
// cas du dossier partagé.
#d("Les emplacements de stockage sur le réseau")[
  #annonce[
    Le serveur de l'école est relié aux postes par le réseau local. Le
    stockage en ligne est sur des serveurs hors de l'école, atteints par
    Internet.
  ]

  #align(center, schema-stockage-reseau())

  #notes[
    Faire situer sur le schéma chaque ligne du tableau précédent. La clé USB
    n'y figure pas.

    Depuis chez soi, `formationTemp` et l'espace personnel ne sont pas
    accessibles. Depuis l'école, Internet l'est.

    L'école ne fournit pas de stockage en ligne, a priori. Nextcloud est un
    logiciel libre, installé par des universités et des associations. Les
    trois autres sont des services de Google, Microsoft et Dropbox.

    Même dessin au cours 5 (« Local et distant »), avec les temps
    d'aller-retour.
  ]
]

// --------------------------------------------
#d("Reconnaître un emplacement réseau à son chemin")[
  #annonce[
    Un chemin qui commence par deux barres inversées désigne un dossier d'une
    autre machine : le nom qui suit est celui du serveur.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Chemin affiché dans la barre d'adresse], [Où est le fichier],
    [`C:\Users\eleve\Desktop\info01\cours1`], [sur le disque du poste],
    [`\\serveur\formationTemp\info01-cours1.zip`], [sur le serveur nommé `serveur`, par le réseau],
    [`Z:\info01-cours1.zip`], [sur un lecteur réseau : un dossier de serveur auquel Windows a donné une lettre],
  )

  #legende[
    Un lecteur réseau a une icône propre dans « Ce PC », qui distingue `Z:`
    d'un disque du poste.
  ]

  #notes[
    À compléter avant la séance : le vrai chemin de `formationTemp` sur les
    postes (`\\…\…`), et la lettre de lecteur s'il y en a une. Le relever dans
    la barre d'adresse de l'explorateur, raccourci du Bureau ouvert.

    La règle affichée dans `src/avant/donnees.md` (« une autre lettre que
    `C:` ») est fausse si `D:` est un disque du poste : à vérifier.
  ]
]
