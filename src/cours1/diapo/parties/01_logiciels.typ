// Partie du cours 1 — incluse par `cours1.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
// Import nominatif, et non `: *` : `schemas.typ` ouvre `cetz.draw`, dont les
// noms (`grid`, `line`, `circle`, `content`…) masqueraient ceux de typst.
#import "../schemas.typ": schema-ou-sexecute

#separateur(
  "Logiciels et formats de fichier",
  annonce: "Ce qu'un logiciel fait, où il s'exécute, notions de base sur la manipulation et rôles des fichiers."
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

    « Webapp » est repris à la diapositive sur le lieu d'exécution.
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

#d("Entrées et sorties d'un logiciel")[
  #annonce[
    Ce qu'un logiciel reçoit et ce qu'il produit sont de deux natures : un
    fichier, qui se conserve, ou un flux vers un périphérique, qui ne garde rien.
  ]

  #layout(dispo => context {
    let ecart = 34pt
    let largeur = (dispo.width - 2 * ecart) / 3
    let gouttiere = 10pt
    // Entrées et sorties se répondent : mêmes deux natures de chaque côté.
    let entrees = (
      ("Entrée : un fichier", "un relevé GPS, une image"),
      ("Entrée : un périphérique", "clavier, souris, réseau"),
    )
    let sorties = (
      ("Sortie : un fichier", "une image, un tableau, une vidéo"),
      ("Sortie : un périphérique", "écran, son, réseau"),
    )
    // Les colonnes latérales portent deux boîtes, celle du milieu une seule :
    // la hauteur commune est celle de la plus haute des trois colonnes.
    let hauteur = calc.max(
      measure(bloc("Traitement", "le logiciel"), width: largeur).height,
      ..(entrees + sorties).map(
        s => 2 * measure(bloc(..s), width: largeur).height + gouttiere,
      ),
    )
    let colonne(paire) = grid(
      rows: ((hauteur - gouttiere) / 2,) * 2, row-gutter: gouttiere,
      ..paire.map(s => bloc(..s, hauteur: 100%)),
    )
    grid(
      columns: (largeur, ecart, largeur, ecart, largeur),
      rows: hauteur,
      align: horizon,
      colonne(entrees),
      fleche,
      bloc("Traitement", "le logiciel", plein: true, hauteur: hauteur),
      fleche,
      colonne(sorties),
    )
  })

  #legende[
    Un fichier sert à conserver un résultat et à l'échanger : avec un autre
    logiciel, avec une autre machine, ou avec quelqu'un d'autre.
  ]

  #notes[
    Le module s'intéresse à ce qui laisse un fichier, parce qu'un fichier
    se relit, se compare, se versionne, et surtout circule d'un logiciel
    à l'autre.
    
    Pas de sauvegarde en RAM. 
    
    Le réseau est du côté des périphériques, en entrée comme en sortie :
    pour le logiciel, c'est un flux qu'on lit ou qu'on écrit sans qu'il
    reste, comme le clavier ou l'écran.
  ]
]
// ------------------------------ Fichiers -----------------------------------
// --------------------------------------------
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

// --------------------------------------------
#d("Utilisation / utilité d'un fichier")[
  #annonce[
    Un fichier conserve un résultat après l'arrêt du programme : un état de
    travail à reprendre, ou un document final à transmettre.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Ce qu'il permet], [Quand cela vous servira],
    [Conserver un résultat],
      [relire dans une semaine ce que le programme a produit],
    [Passer d'un logiciel à l'autre],
      [le tableau écrit par l'un, ouvert par l'autre],
    [Changer de machine],
      [de votre poste à celui de la salle, et retour],
    [Le remettre à quelqu'un],
      [un rendu, ou le dépôt partagé du cours 2],
  )

  #legende[
    D'où la suite de cette partie : nommer un fichier, reconnaître son type,
    et savoir le désigner par son chemin.
  ]

  #notes[
     c'est le fichier qui reste. Les quatre lignes disent ce que ce
    « rester » permet, toutes vraies dès cette semaine — les trois
    premières aujourd'hui, la quatrième au cours 2.

    Deuxième ligne: un format de fichier
    est ce sur quoi deux logiciels se mettent d'accord sans se connaître.
    La partie 5 y revient.
  ]
]

// --------------------------- Chemins et adresses ----------------------------

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

// --------------------------------------------
#d("Le chemin d'un fichier")[
  #annonce[
    Un chemin #text(fill: attention, weight: demi-gras)[absolu] part de la
    racine, un chemin #text(fill: attention, weight: demi-gras)[relatif] du
    dossier où l'on se trouve.
  ]

  #v(0.4em)
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Windows], [macOS et Linux],
    [Le séparateur de dossiers], [la barre inversée `\`, _backslash_], [la barre `/`, _slash_],
  )

  #v(0.5em)
  #grid(
    columns: (auto, 1fr), column-gutter: 18pt, align: horizon,
    block(inset: (x: 10pt, y: 8pt), fill: gris)[
      #set text(font: police-code, size: 12.5pt)
      #set par(leading: 0.6em)
      C:\\Users\\alice\\ \
      └─ cours1\\ \
      #h(0.75em)├─ 1a_formats\\ \
      #h(0.75em)│#h(0.3em)└─ raven.odt \
      #h(0.75em)└─ 1d_erreurs\\ \
      #h(2.05em)└─ chemin.py
    ],
    tableau(
      columns: (auto, 1fr, auto),
      align: left + horizon,
      [], [Le chemin de `raven.odt`], [Depuis],
      [Absolu], [`C:\Users\alice\cours1\1a_formats\raven.odt`], [la racine],
      [Relatif], [`1a_formats\raven.odt`], [`cours1`],
      [Relatif qui remonte], [`..\1a_formats\raven.odt`], [`1d_erreurs`],
    ),
  )

  #legende[
    Sous macOS et Linux, l'autre séparateur : `/home/alice/cours1/1a_formats/raven.odt`.
    Un projet qui n'écrit que des chemins relatifs se copie, se déplace et
    s'envoie sans rien changer : `C:\Users\alice` n'existe que sur un poste.
  ]

  #notes[
    L'intérêt du relatif, à dire avec la légende : un programme ne connaît
    pas a priori le chemin absolu du dossier d'un utilisateur, mais il peut
    imposer une arborescence relative : `chemin.py` lit `../1a_formats/`,
    et il tourne chez tout le monde. C'est le chemin en dur, absolu, qui
    casse au premier changement de poste, et le TD 1d en fait corriger un —
    celui-là même, sur ce fichier.

    Lire l'arborescence avant le tableau : les trois chemins désignent le
    même fichier, `raven.odt`, et ne diffèrent que par l'endroit d'où on le
    demande. 

    Deux notations à donner en passant, et à écrire au tableau plutôt qu'à
    projeter : deux points désignent le dossier parent, un point le dossier
    courant. Elles s'écrivent pareil sur les trois systèmes, seul le
    séparateur qui les suit change.
  ]
]

// -------------------------- Extensions et formats ---------------------------
// --------------------------------------------
#d("Fichier, extension et type de fichier")[
  #annonce[
    Le type d'un fichier (texte, vidéo…) est indiqué par son *extension*, la
    fin du nom après le dernier point. Le système s'en sert pour choisir le
    logiciel à lancer, mais elle reste une indication sur le contenu, pas une
    garantie.
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

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [L'extension], [Ce qu'elle décide],
    [ce qu'elle fait], [le système choisit le logiciel à lancer au double-clic],
    [ce qu'elle ne fait pas], [elle ne modifie aucun octet du fichier],
    [comment on la change], [en renommant le fichier, comme le reste du nom],
  )

  #notes[
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

// --------------------------- Texte et binaire -------------------------------
// --------------------------------------------
#d("Fichiers binaires et fichiers texte")[
  #annonce[
    Tout fichier est une suite de *bits*, 0 ou 1, comptés par *octets* de huit :
    256 valeurs, représentées par deux chiffres hexadécimaux. Fichier *texte* si
    chaque octet est un caractère, *binaire* sinon.
  ]

  #chaine(
    ecart: 22pt,
    ("Huit bits", "01010010"),
    ("Une valeur", "82 sur 256 possibles"),
    ("Représentée par deux chiffres hexadécimaux", "52, de 00 à FF"),
    ("Un caractère, si c'est du texte", "R, par la table ASCII"),
  )

  #v(0.3em)
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Fichier texte], [Fichier binaire],
    [Ses octets], [des caractères, tous], [ce que le format décide],
    [Qui le lit], [n'importe quel éditeur de texte], [le logiciel qui connaît le format],
    [Ce qu'on en fait], [lire, comparer, versionner], [l'ouvrir dans son logiciel],
  )

  #legende[
    2#super[8] = 256 ; seize chiffres, de `0` à `F`. Le binaire est repris au cours 3.
  ]

  #notes[
    Ne pas faire calculer : donner 2 puissance 8, et passer. L'hexadécimal
    est là parce que c'est l'écriture de tous les outils : un chiffre par
    groupe de quatre bits, donc deux par octet.

    Insister sur le sens de « binaire » : ce n'est pas que le fichier soit
    écrit en binaire, ils le sont tous. C'est qu'il n'est pas fait pour être
    lu caractère par caractère.

    La dernière ligne du tableau est celle qui porte le module : ce qui est
    du texte se compare et se versionne, ce qui est binaire non. La grille
    des extensions qui suit demande, pour chaque format, de quel côté il est.
  ]
]

// --------------------------------------------
#d("Le fichier texte")[
  #annonce[
    Un fichier texte est une suite de caractères, chacun rangé dans un octet
    selon une table d'*encodage*. Il s'ouvre avec un éditeur de texte, qui
    montre tout ce qu'il contient.
  ]

  #face-a-face(
    panneau("raven_une_ligne.txt, les huit premiers octets")[
      #block(width: 100%, inset: (x: 12pt, y: 10pt), fill: gris)[
        #octets(
          ("4F", "6E", "63", "65", "20", "75", "70", "6F"),
          ("O", "n", "c", "e", "␣", "u", "p", "o"),
          taille: 16pt,
        )
      ]
    ],
    panneau("Ce qui l'ouvre")[
      #block(width: 100%, inset: (x: 12pt, y: 10pt), fill: gris)[
        #set text(size: 16pt)
        Bloc-notes, Notepad++, l'éditeur de code du module — pas un
        traitement de texte, qui ajoute sa mise en forme
      ]
    ],
  )

  #v(0.4em)
  #tableau(
    columns: (auto, 1fr, auto),
    align: left + horizon,
    [La table], [Ce qu'elle code], [Où on la voit],
    [ASCII], [128 caractères, l'anglais sans accent : `O` vaut `4F`], [en entier, au TD 1a],
    [UTF-8], [toutes les langues, ASCII inclus ; `é` prend deux octets], [la suite du cours],
  )

  #legende[
    Octets réels, relevés sur le fichier du TD 1a.
  ]

  #notes[
    L'intuition à laisser : « texte » veut dire « octets plus une table de
    correspondance ». Les accents cassés que tout le monde a déjà vus
    viennent de là, une table pour écrire et une autre pour lire.

    Ne pas dire « ASCII » pour parler d'un fichier texte d'aujourd'hui : le
    mot traîne dans beaucoup de documentations, il est faux depuis vingt ans.
    UTF-8 est détaillé plus tard dans le module.
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
    et `.yaml`. Deux autres sont des archives ZIP de XML, `.odt` et `.xlsx`,
    ouvertes en direct plus loin dans la séance.
  ]
]

// ------------------------ TD : fichiers et extensions -----------------------
// --------------------------------------------
