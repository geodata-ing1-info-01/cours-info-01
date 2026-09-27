// TD 1a du cours 1 v2 — « Fichiers, formats et extensions », à la souris.
//
// Première moitié du TD 1a de 2026 : copier les fichiers de la séance,
// exporter, ouvrir une page web depuis le disque, deux éditeurs de texte. Le
// renommage des extensions et l'espace dans un nom passent au TD 2a, en ligne
// de commande ; la table ASCII au cours 3.
//
// Inclus par `cours1_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 1_v2`, qui dépose la feuille dans
// `data/cours1_v2/1a_formats/`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": schema-exports

#let td = (
  numero: "1a",
  titre: "Fichiers, formats et extensions",
  annonce: "Copier les fichiers de la séance sur le poste, puis exporter et ouvrir les fichiers d'un même texte",
  dossier: "cours1/1a_formats/",
  duree: "15′",
)
#separateur-td(..td)

// Nouveau (v2) : la copie de l'archive devient la première étape du TD.
#d("Copier les fichiers de la séance sur le poste")[
  #annonce[
    L'archive de la séance est dans le dossier partagé. Elle se copie sur le
    Bureau, puis se décompresse.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous vérifiez],
    [1], [Bureau, raccourci `formationTemp` ; copier `info01-cours1.zip`],
      [la barre d'adresse commence par `\\`],
    [2], [le coller dans le dossier `info01` du Bureau, créé la première fois],
      [la barre d'adresse est `C:\Users\eleve\Desktop\info01`],
    [3], [clic droit sur l'archive, « Extraire tout… », effacer la fin du dossier proposé],
      [`cours1` apparaît à côté de l'archive],
    [4], [ouvrir `cours1\1a_formats`], [deux dossiers, `depart` et `travail`],
  )

  #legende[
    Le détail, avec les messages de Windows : page « Récupérer les fichiers
    d'une séance » du site du cours.
  ]

  #notes[
    Faire lire la barre d'adresse aux étapes 1 et 2, comme sur la
    diapositive « Reconnaître un emplacement réseau à son chemin ».

    Étape 3 : sans effacer la fin du chemin proposé, Windows crée
    `info01\info01-cours1\cours1`, et les chemins des diapositives ne
    correspondent plus.

    Fin de séance : dire où emporter son travail (à préciser).
  ]
]

// Reprise du TD 1a de 2026 ; chemins de l'exemple mis à jour pour le Bureau.
#d([Deux dossiers : `depart/` et `travail/`])[
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
    [], [Sur un poste de la salle],
    [Le fichier de départ], [`C:\Users\eleve\Desktop\info01\cours1\1a_formats\depart\raven.odt`],
    [Un fichier exporté], [`C:\Users\eleve\Desktop\info01\cours1\1a_formats\travail\raven.pdf`],
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

// --------------------------------------------
// Refait le 27/09 : en 2026, des élèves n'ont pas vu que le fichier de départ
// était le `.odt` ouvert dans Writer, dans `depart/`, et que les exports
// allaient dans `travail/`. Une diapositive pour la manipulation, une pour
// la comparaison.
#d("Exporter le document de départ")[
  #annonce[
    `depart/raven.odt` reste ouvert dans LibreOffice Writer. Chaque export en
    écrit une copie, dans un autre format, à enregistrer dans `travail/`.
  ]

  #schema-exports()

  #legende[
    La fenêtre d'enregistrement s'ouvre dans `depart/`, le dossier du
    document. Remonter d'un dossier, puis ouvrir `travail/`, avant
    d'enregistrer.
  ]

  #notes[
    Menu vérifié dans l'aide de LibreOffice : Fichier > Exporter sous >
    Exporter au format PDF. Version de LibreOffice des postes à vérifier.

    Aide de LibreOffice sur Exporter : la commande écrit une copie du
    document dans un nouveau fichier, et garde le document courant ouvert.

    L'export en image est sous Fichier > Exporter. « Enregistrer sous » ne
    propose pas le PNG.

    À la fin, fermer Writer sans enregistrer le `.odt`.
  ]
]

// --------------------------------------------
#d("Un même document, trois formats")[
  #annonce[
    Rouvrir les trois fichiers, et essayer dans chacun de sélectionner une
    ligne du poème, puis de chercher un mot avec `Ctrl` + `F`.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Fichier], [Origine], [Le texte est-il encore du texte ?],
    [`depart/raven.odt`], [le document de départ], reponse[oui, et il reste modifiable],
    [`travail/raven.pdf`], [l'export en PDF], reponse[oui : il se sélectionne et se cherche],
    [`travail/raven.png`], [l'export en image], reponse[non : des pixels, et la première page seulement],
  )

  #legende[
    Rouvrir les trois dans LibreOffice : le `.png` s'ouvre dans Draw, comme une
    image posée sur une page.
  ]

  #notes[
    Nommer ici la différence entre une page décrite (PDF, texte
    vectoriel) et une page photographiée (PNG, JPEG).

    Faire remarquer la perte : le PDF garde le texte mais fige la mise en page ;
    l'image perd tout sauf l'apparence.
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
    Sur un format que les étudiants reverront : le contenu dans un fichier, la présentation dans un autre, et
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
    [`file:///C:/Users/eleve/Desktop/info01/cours1/1a_formats/depart/raven_brut.html`],
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
    l'annonce de l'éditeur de code, au cours 2, qui fait la même chose
    pour Python. Le `.odt` y montre des `NUL` en surbrillance : Notepad++ marque
    les octets sans caractère. À vérifier sur un poste de la salle, Notepad++
    n'étant pas installé d'origine sous Windows.

    Choisir de petits fichiers : ceux du dossier font de 0,5 à 20 ko. Un
    fichier de plusieurs mégaoctets fige l'affichage sans rien apprendre.

    v2 : la diapositive des octets (`PK`) est au cours 3.

    Faire le lien avec l'extension : `raven_brut.html` est du texte, `.odt`
    n'en est pas, et le nom ne le disait pas.
  ]
]
