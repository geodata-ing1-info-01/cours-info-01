// TD 1a du cours 1 v2 — « Fichiers, formats et extensions », à la souris.
//
// Première moitié du TD 1a de 2026 : copier les fichiers de la séance,
// exporter, ouvrir une page web depuis le disque, deux éditeurs de texte. Le
// renommage des extensions et l'espace dans un nom passent au TD 1b, en ligne
// de commande ; la table ASCII au cours 3.
//
// Relecture du 19/10/2026 : « Les fichiers du cours » ouvre le TD, juste
// avant la copie de l'archive ; une dernière étape fait modifier à toute la
// salle un même fichier de `formationTemp`. Ce qu'elle fait constater est
// expliqué après le TD, par `parties/01b_fichier_partage.typ`. Le TD
// n'aborde plus la page web : « Ouvrir une page html depuis son disque » et
// « L'adresse que le navigateur affiche » sont retirées, et `depart/` n'a
// plus de fichiers `.html` ni `.css` (`data/cours1_v2/make_data.py`).
//
// Inclus par `cours1_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 1_v2`, qui dépose la feuille dans
// `data/cours1_v2/1a_formats/`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": schema-exports, consignes, schema-dossier-depart

#let td = (
  numero: "1a",
  titre: "Fichiers, formats et extensions",
  annonce: "Objectif : récupérer les fichiers de la séance, distinguer l'extension d'un fichier et son contenu sur un même texte enregistré dans plusieurs formats, puis modifier à plusieurs un fichier du dossier partagé",
  dossier: "cours1/1a_formats/",
  duree: "15′",
)
#separateur-td(..td)

// --------------------------------------------
// Nouveau (v2) : l'arborescence des cinq TD de la version 2. Placée au début
// du TD 1a le 19/10/2026, juste avant la copie de l'archive.
#d("Les fichiers du cours")[
  #annonce[
    Une archive par séance, un dossier par TD. Aujourd'hui, tout est dans
    `cours1/`.
  ]

  #align(center)[
    #block(
      inset: (x: 20pt, y: 13pt), fill: gris,
      stroke: 1pt + accent.lighten(62%),
    )[
      #set text(size: 23pt)
      #set align(left)
      #raw(
"cours1/                un dossier par TD, dans l'ordre de la séance
├── 1a_formats/
├── 1b_terminal/
├── 1c_programme/
└── 1d_notebook/")
    ]
  ]

  #legende[
    Dans chaque dossier, la feuille du TD et son guide détaillé, en PDF.
  ]

  #notes[
    La copie de l'archive est la diapositive suivante.

    Rappeler le nom du dossier à chaque TD.

    Version 2 : aucun TD facultatif dans la séance. Les TD 1b (archive
    `.odt`), 1i et 1j de 2026 restent dans l'archive 2026 du book ; le TD 1e
    (C++) est l'annexe « C++ ».
  ]
]

// Nouveau (v2) : la copie de l'archive devient la première étape du TD.
// Relecture du 19/10/2026 : une liste de consignes à la place du tableau,
// difficile à suivre pendant la manipulation ; les vérifications passent en
// notes.
#d("Copier les fichiers de la séance sur le poste")[
  #consignes(
    [Sur le Bureau, ouvrir le raccourci `formationTemp`.],
    [Copier `info01-cours1.zip` : clic droit, Copier.],
    [Sur le Bureau, créer le dossier `info01` s'il n'existe pas : clic droit, Nouveau, Dossier.],
    [Ouvrir `info01`, et y coller l'archive : clic droit, Coller.],
    [Extraire l'archive : clic droit sur `info01-cours1.zip`, Extraire tout…],
    [Dans la fenêtre qui s'ouvre, effacer `\info01-cours1` à la fin du chemin, puis cliquer sur Extraire.],
    [Ouvrir `cours1\1a_formats\` : il contient `depart\` et `travail\`.],
  )

  #legende[
    Le détail, avec les messages de Windows : page « Récupérer les fichiers
    d'une séance » du site du cours.
  ]

  #notes[
    Faire lire la barre d'adresse aux étapes 1 et 4, comme sur la
    diapositive « Reconnaître un emplacement réseau à son chemin » : dans
    `formationTemp`, elle commence par `\\` ; dans `info01`, elle indique
    `C:\Users\eleve\Desktop\info01`. Après l'étape 6, `cours1` est à côté
    de l'archive.

    Étape 6 : sans effacer la fin du chemin proposé, Windows crée
    `info01\info01-cours1\cours1`, et les chemins des diapositives ne
    correspondent plus.

    Fin de séance : dire où emporter son travail (à préciser).
  ]
]

// Reprise du TD 1a de 2026 ; chemins de l'exemple mis à jour pour le Bureau.
// Relecture du 19/10/2026 : l'avertissement d'abord, puis la fenêtre de
// l'explorateur sur `depart\` à la place du tableau des chemins.
#d([Deux dossiers : `depart/` et `travail/`])[
  #avertissement[
    Avant d'ouvrir un fichier : afficher les extensions, que Windows masque
    par défaut.
    Explorateur #sym.arrow.r Affichage #sym.arrow.r Afficher #sym.arrow.r
    Extensions de noms de fichiers.
  ]

  #annonce[
    `depart/` contient les fichiers du TD, et ne se modifie pas. Ce que vous
    produisez va dans `travail/`, vide au départ.
  ]

  #schema-dossier-depart()

  #notes[
    Faire lire en entier une fois le chemin de la barre d'adresse : le
    vocabulaire de la partie (racine, dossiers, nom) s'y applique aux
    fichiers qu'ils ont sous la main. Puis dire qu'on abrège : les
    diapositives qui suivent n'écrivent que la fin du chemin, à partir de
    `cours1/`.

    L'explorateur affiche d'abord « Bureau > info01 > cours1 > 1a_formats >
    depart » ; un clic dans la barre montre le chemin complet. Sous macOS et
    Linux, `/Users/alice/…` ou `/home/alice/…`, avec des `/`.

    À dire : une copie abîmée se refait, un original abîmé ne se refait pas.

    `travail/` est livré vide. Tout ce que le TD fait copier ou fabriquer y
    va ; `depart/` reste tel quel.
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
#d("Deux éditeurs de texte, les mêmes fichiers")[
  #annonce[
    Un éditeur de texte n'affiche rien d'autre que des caractères : il lit
    chaque octet et montre le caractère correspondant.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Fichier, dans `depart/`], [Dans le Bloc-notes], [Dans Notepad++],
    [`raven_une_ligne.txt`], reponse[le poème, lisible en entier], reponse[le même],
    [`raven_une_ligne.donnees`], reponse[le même poème : l'extension ne change rien au contenu], reponse[le même],
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

    Notepad++ lit les mêmes octets. Il colore un fichier d'après son
    extension, quand il l'associe à un langage : aucun fichier de ce TD n'en
    a, depuis que les `.css` et `.html` sont retirés (19/10/2026) ; le `.py`
    du TD 1c le sera. Le `.odt` y montre des `NUL` en surbrillance : Notepad++
    marque les octets sans caractère. À vérifier sur un poste de la salle,
    Notepad++ n'étant pas installé d'origine sous Windows.

    Choisir de petits fichiers : ceux du dossier font de 0,5 à 20 ko. Un
    fichier de plusieurs mégaoctets fige l'affichage sans rien apprendre.

    v2 : la diapositive des octets (`PK`) est au cours 3.

    Faire le lien avec l'extension : `raven_une_ligne.donnees` est du texte
    sous une extension qu'aucun logiciel ne connaît, `raven.odt` n'en est
    pas, et le nom ne le disait pas.
  ]
]

// --------------------------------------------
// Relecture du 19/10/2026 : toute la salle modifie le même fichier du
// dossier partagé. La diapositive qui suit le TD, « Modifications
// simultanées d'un fichier partagé », explique ce qu'on y constate.
#d("Modifier à plusieurs un fichier partagé")[
  #annonce[
    Toute la salle ouvre le même fichier de `formationTemp` dans le
    Bloc-notes, puis y ajoute une ligne. Ce fichier est le seul du dossier
    partagé que le TD fait modifier.
  ]

  #tableau(
    columns: (auto, 1.5fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [dans `formationTemp`, clic droit sur `info01-salle.txt`, Ouvrir avec, Bloc-notes ; attendre le signal],
      reponse[le fichier est vide],
    [2], [au signal, écrire son prénom, puis `Ctrl` + `S`],
      reponse[le Bloc-notes enregistre sans aucun message],
    [3], [fermer le Bloc-notes, puis rouvrir le fichier],
      reponse[un prénom, ou quelques-uns : la plupart ont disparu],
  )

  #notes[
    Avant la séance : déposer dans `formationTemp` un fichier texte vide,
    `info01-salle.txt`, à côté de l'archive. Le vider avant chaque groupe.

    Attendre que toute la salle ait le fichier ouvert avant de donner le
    signal : chacun doit avoir lu le fichier vide. Faire écrire le prénom
    seul : le fichier est lisible par toute la promotion.

    À vérifier sur un poste de la salle : l'élève a le droit d'écrire dans
    `formationTemp`, et le Bloc-notes de Windows 11 enregistre sans signaler
    que le fichier a changé depuis son ouverture. Notepad++ propose de
    recharger un fichier modifié ailleurs : ne pas l'employer ici.

    Demander combien de prénoms chacun lit, puis passer à la diapositive qui
    suit le TD.
  ]
]
