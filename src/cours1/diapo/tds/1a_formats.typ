// TD 1a du cours 1 — « Fichiers, formats et extensions ».
//
// Inclus par `cours1.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`, qui
// en tire la feuille de TD déposée dans le dossier annoncé. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "1a",
  titre: "Fichiers, formats et extensions",
  annonce: "Objectif : distinguer l'extension d'un fichier et son contenu, sur un même texte enregistré dans plusieurs formats",
  dossier: "cours1/1a_formats/",
  duree: "20′",
)
#separateur-td(..td)
#d("Deux dossiers : `depart/` et `travail/`")[
  #annonce[
    `depart/` contient les fichiers du TD et ne se modifie pas ; `travail/`
    reçoit vos copies. Une copie abîmée se refait, un original abîmé ne se
    refait pas.
  ]

  #avertissement[
    Première étape : afficher les extensions, que Windows masque par défaut.
    Explorateur #sym.arrow.r Affichage #sym.arrow.r Afficher #sym.arrow.r
    Extensions de noms de fichiers.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Sur un poste où l'archive est dans `Documents`],
    [Le fichier de départ], [`C:\Users\alice\Documents\cours1\1a_formats\depart\raven.odt`],
    [Sa copie renommée], [`C:\Users\alice\Documents\cours1\1a_formats\travail\raven_odt.pdf`],
  )

  #legende[
    Sous macOS et Linux, `/Users/alice/…` ou `/home/alice/…`, avec des `/`.
    Les diapositives qui suivent n'écrivent que la fin du chemin, à partir de
    `cours1/`.
  ]

  #notes[
    Faire lire les deux chemins en entier une fois : c'est le vocabulaire de
    la partie — racine, dossiers, nom, extension — sur les fichiers qu'ils
    ont sous la main. Puis dire qu'on abrège.

    `travail/` est livré vide. Tout ce que le TD fait copier ou fabriquer y
    va ; `depart/` reste tel quel, sauf la couleur de `style.css` plus loin,
    qu'on remet.
  ]
]

#d("Copier et renommer : à la souris, ou au clavier")[
  #annonce[
    Les deux font exactement la même chose. Le clavier va plus vite pour qui
    le connaît déjà ; il est repris pour lui-même au cours 2.
  ]

  #face-a-face(
    panneau("Dans l'explorateur")[
      #tableau(
        entete: false,
        columns: (auto, 1fr),
        align: left + horizon,
        [1], [`depart/raven.odt`, `Ctrl` + `C`],
        [2], [dans `travail/`, `Ctrl` + `V`],
        [3], [`F2`, taper `raven_odt.pdf`, Entrée],
        [4], [confirmer le changement d'extension],
      )
    ],
    panneau("Dans un terminal (cmd sous Windows)")[
      #block(width: 100%, inset: (x: 10pt, y: 9pt), fill: gris)[
        #set text(size: 20pt)
        #raw("cd cours1\\1a_formats\ncopy depart\\raven.odt travail\\raven_odt.pdf\ncopy depart\\raven.odt travail\\raven.loulou")
      ]
      #v(0.3em)
      #text(size: 13pt, fill: estompe)[
        macOS, Linux : `cp depart/raven.odt travail/raven_odt.pdf`
      ]
    ],
  )

  #legende[
    Le terminal est pour ceux qui connaissent : aucune des étapes du TD ne
    l'exige. Windows demande confirmation quand l'extension change, c'est
    normal.
  ]

  #notes[
    Ne pas enseigner le terminal ici : le montrer une fois, dire qu'il fait
    la même chose, et laisser ceux qui le pratiquent déjà l'employer. Le
    cours 2 y consacre une partie.

    `cmd` et non PowerShell : `copy` y suffit, et c'est la fenêtre que
    « Ouvrir dans le terminal » donne sur la plupart des postes de la salle.
    PowerShell accepte aussi `copy`, en alias.
  ]
]

// --------------------------------------------
#d("Un même document, trois formats")[
  #annonce[
    Ouvrir `depart/raven.odt` dans LibreOffice Writer, l'exporter sous deux
    autres formes dans `travail/`, et comparer ce qu'il reste du texte.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Fichier, dans `travail/`], [Comment], [Le texte est-il encore du texte ?],
    [`raven.pdf`], [Fichier #sym.arrow.r Exporter au format PDF], reponse[oui : il se sélectionne et se cherche],
    [`raven.png`], [Fichier #sym.arrow.r Exporter…, type PNG], reponse[non : des pixels, et la première page seulement],
    [`raven.odt`], [le fichier de départ, dans `depart/`], reponse[oui, et il reste modifiable],
  )

  #legende[
    Rouvrir les trois dans LibreOffice : le `.png` s'ouvre dans Draw, comme une
    image posée sur une page.
  ]

  #notes[
    L'export en image existe bien depuis Writer, sous Fichier > Exporter, et non
    dans « Enregistrer sous ». C'est le moment de nommer la différence entre une
    page décrite (PDF, texte vectoriel) et une page photographiée (PNG, JPEG).

    Faire remarquer la perte : le PDF garde le texte mais fige la mise en page ;
    l'image perd tout sauf l'apparence.
  ]
]
// --------------------------------------------
#d("Renommer une extension, et voir l'incidence pour leur ouverture")[
  #annonce[
    Quatre copies de `depart/raven.odt` dans `travail/`, renommées, puis
    ouvertes par double-clic.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Nom donné], [Ce que le système lance], [Ce qui se passe],
    [`raven_odt.pdf`], [un lecteur PDF], reponse[refus : le fichier n'est pas un PDF],
    [`raven_odt.jpg`], [une visionneuse], reponse[refus : _Not a JPEG file: starts with 0x50 0x4b_],
    [`riri.fifi.loulou.odt`], [LibreOffice Writer], reponse[s'ouvre : seule la fin du nom compte],
    [`raven.loulou`], [rien : il demande quel logiciel choisir], reponse[choisir LibreOffice : s'ouvre, le contenu n'a pas changé],
  )

  #legende[
    #reponse[
      Le système ne regarde que le nom. Extension inconnue : Windows et macOS
      demandent de choisir un logiciel, et retiennent ce choix pour la suite ;
      Linux, lui, regarde le contenu.
    ]
  ]

  #notes[
    `0x50 0x4b` est « PK » : la visionneuse nomme elle-même les octets
    qu'elle a lus. Y revenir à « Comment un logiciel reconnaît un fichier
    ».

    La quatrième ligne surprend et c'est la plus utile : avec une
    extension inventée, Windows n'a plus de convention à appliquer, et il
    n'ouvre rien — il affiche « Comment voulez-vous ouvrir ce fichier ? »
    et propose une liste. Vérifié sous Windows 11 : il ne regarde pas le
    contenu. Cocher « Toujours » associe l'extension au logiciel, et le
    double-clic suivant ouvre directement. Sous Linux (GNOME), le système
    lit les premiers octets et propose LibreOffice de lui-même. Laisser la
    salle inventer l'extension.

    Les copies sont dans `travail/`, `depart/` reste intact : si une copie
    est abîmée, on en refait une.
  ]
]

// --------------------------------------------
#d("Ouvrir une page html depuis son disque")[
  #annonce[
    Double-cliquer sur `depart/raven_brut.html` : le navigateur l'ouvre sans
    réseau. L'adresse commence par `file:///`.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Fichier ouvert], [Ce que vous constatez],
    [`raven_brut.html`], reponse[la page s'affiche, l'adresse est un chemin de votre disque],
    [`raven_style.html`], reponse[le même texte, mis en forme : il appelle `style.css`],
    [`style.css`], reponse[changez-y une couleur, enregistrez, puis `F5` dans le navigateur],
  )

  #legende[
    Le fichier `.html` est identique dans les deux cas. Seule la ligne
    `<link rel="stylesheet" href="style.css">` les distingue.
  ]

  #notes[
    Même leçon que l'archive `.odt`, sur un format que les étudiants
    reverront : le contenu dans un fichier, la présentation dans un autre, et
    on change l'un sans toucher l'autre.

    Pour la couleur, CSS accepte `color: crimson` aussi bien que
    `color: #c0392b` — contrairement à ODF. Faire essayer les deux.

    Fichiers dans `cours1/1a_formats/depart/`. Si `style.css` n'est pas dans
    le même dossier que le `.html`, la page s'affiche sans mise en forme :
    bonne occasion de reparler des chemins relatifs. Ici on modifie un fichier
    de `depart/`, exprès : c'est une couleur, et on la remet ensuite.
  ]
]

// --------------------------------------------
#d("L'adresse que le navigateur affiche")[
  #annonce[
    Une adresse web est un chemin de fichier, précédé de la machine où aller
    le chercher — une #sigle("URL")[#initiale("U")niform #initiale("R")esource #initiale("L")ocator].
    Celle de la page ouverte depuis le disque a la même forme.
  ]

  #align(center)[
    #grid(
      columns: (auto, auto, auto, auto),
      row-gutter: 11pt,
      align: center,
      text(font: police-code, size: 22pt, fill: estompe, "https://"),
      text(font: police-code, size: 22pt, fill: brun, weight: demi-gras, "www.ensg.eu"),
      text(font: police-code, size: 22pt, fill: encre, "/cours/info01/"),
      text(font: police-code, size: 22pt, fill: accent, weight: demi-gras, "raven.html"),
      text(size: 13pt, fill: estompe)[le protocole],
      text(size: 13pt, fill: brun)[à quelle machine],
      text(size: 13pt, fill: estompe)[le chemin sur cette machine],
      text(size: 13pt, fill: accent)[le fichier],
    )
  ]

  #v(0.5em)
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Dans la barre d'adresse], [Ce que vous en dites],
    [`file:///C:/Users/alice/Documents/cours1/1a_formats/depart/raven_brut.html`],
      reponse[la même structure ; le chemin est celui du disque, avec des `/`],
    [Pourquoi trois barres après `file:` ?],
      reponse[deux ouvrent la place de la machine, restée vide : c'est la vôtre ; la troisième est la racine],
  )

  #notes[
    C'est la diapositive qui explique pourquoi une page ouverte par double-clic
    affiche `file:///`. Poser la question des trois barres avant de projeter
    la réponse : entre `file:` et le chemin, la place de la machine est vide,
    puisque c'est la machine locale, et `/C:/` est la racine du disque.

    Faire remarquer les `/` : le navigateur écrit tous les chemins à la façon
    d'Unix, même sous Windows.

    « Protocole » : la façon convenue de demander la ressource à la machine.
    `https` pour une page web, `file` pour un fichier du disque ; le mot
    suffit ici, le réseau est au cours 5.
  ]
]

// --------------------------------------------
#d("Un espace dans le nom d'un fichier")[
  #annonce[
    Copier `raven_brut.html` dans `travail/` sous le nom `raven brut.html`,
    l'ouvrir par double-clic, puis regarder l'adresse que le navigateur affiche.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Étape], [Ce que vous constatez],
    [copier, puis renommer avec `F2`],
      [l'explorateur accepte l'espace et l'affiche tel quel],
    [ouvrir par double-clic],
      reponse[la page s'affiche, sans mise en forme : `style.css` n'est pas dans `travail/`],
    [lire l'adresse],
      reponse[Chrome et Edge écrivent `raven%20brut.html` ; Firefox montre l'espace],
    [copier l'adresse, la coller dans l'éditeur],
      reponse[`%20` dans les deux cas : l'adresse réelle n'a pas d'espace, seul l'affichage diffère],
  )

  #legende[
    Une adresse ne peut pas contenir d'espace : il y est écrit `%20`, le code
    du caractère espace. Ce que la barre affiche est une présentation, ce qui
    se copie est l'adresse.
  ]

  #notes[
    Constaté en séance de préparation : Firefox affiche l'espace dans la
    barre d'adresse, Chromium écrit `%20`. Ce n'est pas une différence
    d'adresse : Firefox décode les `%xx` pour l'affichage et, par défaut,
    recopie la forme encodée quand on copie l'adresse — réglage
    `browser.urlbar.decodeURLsOnCopy`, à `false` d'origine. D'où la dernière
    ligne : faire copier-coller, c'est ce qui met tout le monde d'accord.
    Refaire l'essai sur un poste de la salle avant la séance, avec le
    navigateur qui y est installé.

    La copie perd sa feuille de style, puisque `style.css` est resté dans
    `depart/` : c'est le chemin relatif `href="style.css"` qui ne trouve
    plus rien. Le faire remarquer, sans corriger.

    Ne pas ouvrir le dossier des caractères permis dans un nom de fichier.
    Retenir : un espace dans un nom passe partout aujourd'hui, mais il se
    paiera en ligne de commande au cours 3, où il faudra des guillemets.
  ]
]

// --------------------------------------------
#d("La table ASCII, caractère par caractère")[
  #annonce[
    Les 95 caractères affichables d'ASCII et leur valeur, lue en hexadécimal :
    le rang donne le premier chiffre, la colonne le second. `R` est ainsi à la
    ligne `5_` et dans la colonne `2`, soit `52`.
  ]

  #align(center)[
    #block(inset: (x: 16pt, y: 13pt), fill: gris)[
      #grid(
        columns: 17,
        column-gutter: 11pt,
        row-gutter: 9pt,
    [],
    align(center, text(size: 15pt, fill: estompe)[0]),
    align(center, text(size: 15pt, fill: estompe)[1]),
    align(center, text(size: 15pt, fill: estompe)[2]),
    align(center, text(size: 15pt, fill: estompe)[3]),
    align(center, text(size: 15pt, fill: estompe)[4]),
    align(center, text(size: 15pt, fill: estompe)[5]),
    align(center, text(size: 15pt, fill: estompe)[6]),
    align(center, text(size: 15pt, fill: estompe)[7]),
    align(center, text(size: 15pt, fill: estompe)[8]),
    align(center, text(size: 15pt, fill: estompe)[9]),
    align(center, text(size: 15pt, fill: estompe)[A]),
    align(center, text(size: 15pt, fill: estompe)[B]),
    align(center, text(size: 15pt, fill: estompe)[C]),
    align(center, text(size: 15pt, fill: estompe)[D]),
    align(center, text(size: 15pt, fill: estompe)[E]),
    align(center, text(size: 15pt, fill: estompe)[F]),
    align(center, text(size: 15pt, fill: estompe)[2\_]),
    align(center, text(font: police-code, size: 21pt)[#"␣"]),
    align(center, text(font: police-code, size: 21pt)[#"!"]),
    align(center, text(font: police-code, size: 21pt)[#"\""]),
    align(center, text(font: police-code, size: 21pt)[#"#"]),
    align(center, text(font: police-code, size: 21pt)[#"$"]),
    align(center, text(font: police-code, size: 21pt)[#"%"]),
    align(center, text(font: police-code, size: 21pt)[#"&"]),
    align(center, text(font: police-code, size: 21pt)[#"'"]),
    align(center, text(font: police-code, size: 21pt)[#"("]),
    align(center, text(font: police-code, size: 21pt)[#")"]),
    align(center, text(font: police-code, size: 21pt)[#"*"]),
    align(center, text(font: police-code, size: 21pt)[#"+"]),
    align(center, text(font: police-code, size: 21pt)[#","]),
    align(center, text(font: police-code, size: 21pt)[#"-"]),
    align(center, text(font: police-code, size: 21pt)[#"."]),
    align(center, text(font: police-code, size: 21pt)[#"/"]),
    align(center, text(size: 15pt, fill: estompe)[3\_]),
    align(center, text(font: police-code, size: 21pt)[#"0"]),
    align(center, text(font: police-code, size: 21pt)[#"1"]),
    align(center, text(font: police-code, size: 21pt)[#"2"]),
    align(center, text(font: police-code, size: 21pt)[#"3"]),
    align(center, text(font: police-code, size: 21pt)[#"4"]),
    align(center, text(font: police-code, size: 21pt)[#"5"]),
    align(center, text(font: police-code, size: 21pt)[#"6"]),
    align(center, text(font: police-code, size: 21pt)[#"7"]),
    align(center, text(font: police-code, size: 21pt)[#"8"]),
    align(center, text(font: police-code, size: 21pt)[#"9"]),
    align(center, text(font: police-code, size: 21pt)[#":"]),
    align(center, text(font: police-code, size: 21pt)[#";"]),
    align(center, text(font: police-code, size: 21pt)[#"<"]),
    align(center, text(font: police-code, size: 21pt)[#"="]),
    align(center, text(font: police-code, size: 21pt)[#">"]),
    align(center, text(font: police-code, size: 21pt)[#"?"]),
    align(center, text(size: 15pt, fill: estompe)[4\_]),
    align(center, text(font: police-code, size: 21pt)[#"@"]),
    align(center, text(font: police-code, size: 21pt)[#"A"]),
    align(center, text(font: police-code, size: 21pt)[#"B"]),
    align(center, text(font: police-code, size: 21pt)[#"C"]),
    align(center, text(font: police-code, size: 21pt)[#"D"]),
    align(center, text(font: police-code, size: 21pt)[#"E"]),
    align(center, text(font: police-code, size: 21pt)[#"F"]),
    align(center, text(font: police-code, size: 21pt)[#"G"]),
    align(center, text(font: police-code, size: 21pt)[#"H"]),
    align(center, text(font: police-code, size: 21pt)[#"I"]),
    align(center, text(font: police-code, size: 21pt)[#"J"]),
    align(center, text(font: police-code, size: 21pt)[#"K"]),
    align(center, text(font: police-code, size: 21pt)[#"L"]),
    align(center, text(font: police-code, size: 21pt)[#"M"]),
    align(center, text(font: police-code, size: 21pt)[#"N"]),
    align(center, text(font: police-code, size: 21pt)[#"O"]),
    align(center, text(size: 15pt, fill: estompe)[5\_]),
    align(center, text(font: police-code, size: 21pt)[#"P"]),
    align(center, text(font: police-code, size: 21pt)[#"Q"]),
    align(center, text(font: police-code, size: 21pt)[#"R"]),
    align(center, text(font: police-code, size: 21pt)[#"S"]),
    align(center, text(font: police-code, size: 21pt)[#"T"]),
    align(center, text(font: police-code, size: 21pt)[#"U"]),
    align(center, text(font: police-code, size: 21pt)[#"V"]),
    align(center, text(font: police-code, size: 21pt)[#"W"]),
    align(center, text(font: police-code, size: 21pt)[#"X"]),
    align(center, text(font: police-code, size: 21pt)[#"Y"]),
    align(center, text(font: police-code, size: 21pt)[#"Z"]),
    align(center, text(font: police-code, size: 21pt)[#"["]),
    align(center, text(font: police-code, size: 21pt)[#"\\"]),
    align(center, text(font: police-code, size: 21pt)[#"]"]),
    align(center, text(font: police-code, size: 21pt)[#"^"]),
    align(center, text(font: police-code, size: 21pt)[#"_"]),
    align(center, text(size: 15pt, fill: estompe)[6\_]),
    align(center, text(font: police-code, size: 21pt)[#"`"]),
    align(center, text(font: police-code, size: 21pt)[#"a"]),
    align(center, text(font: police-code, size: 21pt)[#"b"]),
    align(center, text(font: police-code, size: 21pt)[#"c"]),
    align(center, text(font: police-code, size: 21pt)[#"d"]),
    align(center, text(font: police-code, size: 21pt)[#"e"]),
    align(center, text(font: police-code, size: 21pt)[#"f"]),
    align(center, text(font: police-code, size: 21pt)[#"g"]),
    align(center, text(font: police-code, size: 21pt)[#"h"]),
    align(center, text(font: police-code, size: 21pt)[#"i"]),
    align(center, text(font: police-code, size: 21pt)[#"j"]),
    align(center, text(font: police-code, size: 21pt)[#"k"]),
    align(center, text(font: police-code, size: 21pt)[#"l"]),
    align(center, text(font: police-code, size: 21pt)[#"m"]),
    align(center, text(font: police-code, size: 21pt)[#"n"]),
    align(center, text(font: police-code, size: 21pt)[#"o"]),
    align(center, text(size: 15pt, fill: estompe)[7\_]),
    align(center, text(font: police-code, size: 21pt)[#"p"]),
    align(center, text(font: police-code, size: 21pt)[#"q"]),
    align(center, text(font: police-code, size: 21pt)[#"r"]),
    align(center, text(font: police-code, size: 21pt)[#"s"]),
    align(center, text(font: police-code, size: 21pt)[#"t"]),
    align(center, text(font: police-code, size: 21pt)[#"u"]),
    align(center, text(font: police-code, size: 21pt)[#"v"]),
    align(center, text(font: police-code, size: 21pt)[#"w"]),
    align(center, text(font: police-code, size: 21pt)[#"x"]),
    align(center, text(font: police-code, size: 21pt)[#"y"]),
    align(center, text(font: police-code, size: 21pt)[#"z"]),
    align(center, text(font: police-code, size: 21pt)[#"{"]),
    align(center, text(font: police-code, size: 21pt)[#"|"]),
    align(center, text(font: police-code, size: 21pt)[#"}"]),
    align(center, text(font: police-code, size: 21pt)[#"~"]),
    align(center, text(font: police-code, size: 21pt, fill: estompe)[·]),
      )
    ]
  ]

  #legende[
    Les valeurs de `00` à `1F` ne sont pas des caractères affichables : ce sont
    des commandes, dont le saut de ligne `0A`. `7F` non plus. Les majuscules
    commencent à `41`, les minuscules `20` plus loin, à `61`.
  ]

  #notes[
    Ne pas la lire ligne à ligne : elle est là pour être consultée pendant
    l'étape qui suit, et pour que « une table d'encodage » cesse d'être
    une abstraction.

    Trois lectures à faire faire, pas plus : `R` en `52`, l'espace en `20`,
    et le passage de `A` à `a` en ajoutant `20`.

    UTF-8 reprend ces 95 valeurs à l'identique : cette table reste vraie
    pour tout ce qui s'écrit sans accent.
  ]
]

// --------------------------------------------
#d("Deux éditeurs de texte, les mêmes fichiers")[
  #annonce[
    Un éditeur de texte n'affiche rien d'autre que des caractères : il lit
    chaque octet et montre le caractère correspondant. Le Bloc-notes s'arrête
    là ; Notepad++ reconnaît l'extension et colore ce qu'il sait lire.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Fichier, dans `depart/`], [Dans le Bloc-notes], [Dans Notepad++],
    [`raven_une_ligne.txt`], reponse[le poème, lisible en entier], reponse[le même, sans couleur],
    [`style.css`], reponse[des règles, lisibles], reponse[sélecteurs et propriétés colorés],
    [`raven_brut.html`], reponse[le texte et ses balises], reponse[les balises colorées, repliables],
    [`raven.odt`], reponse[`PK`, puis du charabia : binaire], reponse[le même charabia, et des `NUL`],
  )

  #avertissement[
    Ne rien enregistrer, et fermer sans sauver : un `.odt` réenregistré par un
    éditeur de texte est détruit.
  ]

  #notes[
    Clic droit #sym.arrow.r Ouvrir avec #sym.arrow.r Bloc-notes. Sous macOS et
    Linux, l'éditeur de texte du système refuse souvent les fichiers non
    texte : le faire alors en démonstration depuis le poste enseignant.

    Les deux règles du Bloc-notes, à dire avant : il affiche un caractère par
    octet, selon un encodage qu'il devine, et il n'interprète rien d'autre —
    ni image, ni mise en forme. Ce qui n'a pas de caractère correspondant
    apparaît en carré ou en signe étrange.

    Notepad++ lit les mêmes octets : la couleur ne vient pas du fichier, elle
    vient de l'extension, que l'éditeur associe à un langage (`.css`,
    `.html`) ; renommer `style.css` en `style.txt` la fait disparaître. C'est
    l'annonce de la partie 2, où l'éditeur de code fait la même chose pour
    Python. Le `.odt` y montre des `NUL` en surbrillance : Notepad++ marque
    les octets sans caractère. À vérifier sur un poste de la salle, Notepad++
    n'étant pas installé d'origine sous Windows.

    Choisir de petits fichiers : ceux du dossier font de 0,5 à 20 ko. Un
    fichier de plusieurs mégaoctets fige l'affichage sans rien apprendre.

    Le `PK` vient d'être vu sur la diapositive des octets. Le faire retrouver
    par la salle plutôt que le désigner.

    Faire le lien avec l'extension : `raven_brut.html` est du texte, `.odt`
    n'en est pas, et le nom ne le disait pas.
  ]
]
