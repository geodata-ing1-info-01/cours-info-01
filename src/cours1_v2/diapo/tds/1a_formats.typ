// TD 1a du cours 1 v2 — « Fichiers, formats et extensions », à la souris.
//
//
// Inclus par `cours1_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 1_v2`, qui dépose la feuille dans
// `data/cours1_v2/1a_formats/`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": schema-exports-vertical, consignes, comment, sous-etapes, constat, schema-dossier-depart

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
    L'archive de la séance, `info01-cours1.zip`, est dans `formationTemp`. Chaque élève
    travaille sur une copie, sur le disque de son poste.
  ]

  #tableau(
    columns: (auto, 1.3fr, 1fr),
    align: left + horizon,
    [Copie], [Emplacement], [Qui y a accès],
    [de], [`formationTemp` : serveur de l'école], [toute la promotion],
    [vers], [Bureau : disque de l'ordinateur], [votre session, sur ce poste],
  )

  #v(6pt)
  #align(center)[
    #block(
      inset: (x: 20pt, y: 13pt), fill: gris,
      stroke: 1pt + accent.lighten(62%),
    )[
      #set text(size: 22pt)
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
    Chaque dossier contient la feuille du TD et son guide détaillé, en PDF.
  ]

  #notes[
    La copie de l'archive est la diapositive suivante.

    À dire : le Bureau est conservé d'une séance à l'autre, sur ce poste
    seulement ; `formationTemp` est modifiable par tous, ce que montre la
    dernière étape du TD.

    Rappeler le nom du dossier à chaque TD.

    Version 2 : aucun TD facultatif dans la séance. Les TD 1b (archive
    `.odt`), 1i et 1j de 2026 restent dans l'archive 2026 du book ; le TD 1e
    (C++) est l'annexe « C++ ».
  ]
]

// Nouveau (v2) : la copie de l'archive devient la première étape du TD.
// 09/11/2026 : l'arborescence attendue sur le Bureau, à droite des consignes, dans la
// notation de « Les fichiers du cours ». Pour laisser la place, les indications en gris
// passent à 85 % de la taille des consignes.
#let _indication(corps) = comment(text(size: 0.85em, corps))
#d("Étape 1 · Récupération des fichiers de la séance")[
  #objectif[
    copier `info01-cours1.zip` depuis `formationTemp` sur le Bureau, et l'extraire dans un dossier
    `info01`.
  ]

  #grid(
    columns: (2fr, 1fr), column-gutter: 18pt, align: top,
    [
      #consignes(
        taille: 16pt,
        [Ouvrir `formationTemp` : #_indication[double-clic sur son raccourci, sur le Bureau.]],
        [Copier `info01-cours1.zip` : #_indication[clic droit sur l'archive, Copier.]],
        [Créer le dossier `info01` sur le Bureau, s'il n'existe pas : #_indication[clic droit sur le Bureau, Nouveau, Dossier.]],
        [Coller l'archive dans `info01` : #_indication[ouvrir `info01`, puis clic droit, Coller.]],
        [Extraire l'archive : #_indication[clic droit sur `info01-cours1.zip`, Extraire tout…]],
        [Extraire dans `info01` même : #_indication[dans la fenêtre qui s'ouvre, effacer `\info01-cours1` à la fin du chemin, puis cliquer sur Extraire.]],
      )

      #legende[
        Le détail, avec les messages de Windows : page « Récupérer les fichiers
        d'une séance » du site du cours.
      ]
    ],
    [
      #block(
        width: 100%, inset: (x: 10pt, y: 10pt), fill: gris,
        stroke: 1pt + accent.lighten(62%),
      )[
        #set text(size: 18pt)
        #set align(left)
        #raw(
"Bureau/
└── info01/
    ├── info01-cours1.zip
    └── cours1/
        ├── 1a_formats/
        ├── 1b_terminal/
        ├── 1c_programme/
        └── 1d_notebook/")
      ]
      #legende[Arborescence attendue après la consigne 6.]
    ],
  )

  #notes[
    Faire lire la barre d'adresse aux consignes 1 et 4, comme sur la
    diapositive « Les emplacements de stockage sur le réseau » : dans
    `formationTemp`, elle commence par `\\` ; dans `info01`, elle indique
    `C:\Users\eleve\Desktop\info01`. Après la consigne 6, `cours1` est à côté
    de l'archive.

    Consigne 6 : sans effacer la fin du chemin proposé, Windows crée
    `info01\info01-cours1\cours1`, et les chemins des diapositives ne
    correspondent plus.

    À relever sur un poste de la salle : les identifiants que Windows demande à
    l'ouverture de `formationTemp` (les mêmes que ceux de la session ?). Le guide
    écrit seulement « ses identifiants d'élève ».

    Fin de séance : dire où emporter son travail (à préciser).
  ]
]
// 06/11/2026 : l'annonce explique les deux dossiers. La vérification du dossier vient de la diapositive
// précédente, et l'affichage des extensions, qui était dans un encadré, devient une consigne.
#d("Organisation des TD")[
  #annonce[
    Dans chaque TD, `depart/` contient les fichiers livrés, à ne pas modifier. `travail/`, vide au
    départ, contiendra les fichiers que vous produisez.
  ]

  #objectif[
    retrouver ces deux dossiers au TD 1a, et afficher les extensions de leurs fichiers.
  ]

  #consignes(
    taille: 16pt,
    [Ouvrir `cours1\1a_formats\`, et vérifier qu'il contient `depart\` et `travail\`.],
    [Ouvrir `depart\`, et afficher les extensions, que Windows masque par défaut : #comment[dans l'explorateur, Affichage, Afficher, Extensions de noms de fichiers.]
      #constat[Les noms des fichiers se terminent par `.odt`, `.donnees` ou `.txt`.]],
  )

  #v(0.3em)
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

    `travail/` est livré vide. Tout ce que le TD fait copier ou fabriquer y
    va ; `depart/` reste tel quel.
  ]
]

// --------------------------------------------
// Refait le 27/09 : en 2026, des élèves n'ont pas vu que le fichier de départ
// était le `.odt` ouvert dans Writer, dans `depart/`, et que les exports
// allaient dans `travail/`. Une diapositive pour la manipulation, une pour
// la comparaison.
// Relecture du 19/10/2026 : l'annonce décrivait un état (« reste ouvert »,
// « chaque export en écrit une copie ») sans dire quoi faire ; elle devient
// une liste de consignes, comme la copie de l'archive. Seconde relecture du
// même jour : chaque tâche en noir, sa manière en gris, en deux opérations
// lettrées pour les exports ; le schéma passe en colonne à droite.
// 09/11/2026 : une troisième copie, en texte, par Enregistrer sous. La diapositive suivante
// compare `raven.odt` et `raven.txt`, qui contiennent les mêmes caractères. Pour la place,
// les consignes passent à 15 pt et le schéma à 46 %. 11/11/2026 : 14 pt et 38 %, le titre numéroté
// tenant sur deux lignes.
#d("Étape 2 · Conversion d'un document en d'autres formats")[
  #objectif[
    exporter `depart\raven.odt` en PDF et en PNG, puis l'enregistrer en texte, dans `travail\`, avec
    LibreOffice Writer.
  ]

  #grid(
    columns: (2.1fr, 1fr), column-gutter: 16pt, align: top,
    [#consignes(
      taille: 14pt,
      [Ouvrir `raven.odt` avec LibreOffice Writer : #comment[double-clic, dans `depart\`.]],
      [Exporter le document en PDF, dans `travail\`.
        #sous-etapes(
          [Menu Fichier, Exporter sous, Exporter au format PDF…, puis Exporter.],
          [La fenêtre d'enregistrement affiche `depart\`. Cliquer sur la flèche vers le haut, double-cliquer sur `travail`, puis Enregistrer.],
        )],
      [Exporter le document en PNG, dans `travail\`.
        #sous-etapes(
          [Menu Fichier, Exporter…, puis choisir le type PNG.],
          [Vérifier que la fenêtre affiche `travail\`, puis Enregistrer.],
        )],
      [Enregistrer le document en texte, dans `travail\`.
        #sous-etapes(
          [Menu Fichier, Enregistrer sous…, type « Texte (.txt) ».],
          [Vérifier que la fenêtre affiche `travail\`, puis Enregistrer.],
          [À la question de Writer, choisir « Utiliser le format Texte ! ».],
        )],
      [Fermer Writer sans enregistrer.],
    )],
    align(center, scale(38%, reflow: true, schema-exports-vertical())),
  )
  #legende[
    Le détail, avec les fenêtres de LibreOffice : guide du TD 1a, étape 2.
  ]

  #notes[
    Menu vérifié dans l'aide de LibreOffice : Fichier > Exporter sous >
    Exporter au format PDF. Version de LibreOffice des postes à vérifier.

    Aide de LibreOffice sur Exporter : la commande écrit une copie du
    document dans un nouveau fichier, et garde le document courant ouvert.

    L'export en image est sous Fichier > Exporter. « Enregistrer sous » ne
    propose pas le PNG.

    Après la consigne 2, la barre de titre de Writer indique toujours
    `raven.odt` : l'export ne remplace pas le document ouvert.

    Après la consigne 4, elle indique `raven.txt` : « Enregistrer sous » remplace le document
    ouvert par la copie. La question de Writer prévient que le format Texte ne garde pas la
    mise en forme. Libellés de la question et du type à relever sur un poste de la salle.
  ]
]

// --------------------------------------------
// 05/11/2026 : le tableau devient une liste de consignes. La solution sort de sa colonne,
// et passe sous chaque consigne, dans le corrigé seulement.
// 09/11/2026 : les trois copies de la diapositive précédente, dont `raven.txt`, ouvert dans
// Writer pour que seul le fichier change. La question « Le texte est-il encore du texte ? »
// devient un essai de modification.
#d("Étape 3 · Manipulation du texte selon le format")[
  #objectif[
    comparer `depart\raven.odt` et ses trois copies de `travail\`, `raven.txt`, `raven.pdf` et
    `raven.png`, et déterminer quels fichiers permettent de sélectionner, de chercher et de modifier
    le texte.
  ]

  #consignes(
    taille: 16pt,
    [Rouvrir `raven.odt`, le document de départ, dans LibreOffice : #comment[dans `depart\`.]],
    [Sélectionner une ligne du poème, chercher un mot avec `Ctrl` + `F`, puis essayer de modifier un mot.
      #constat[Les trois opérations fonctionnent.]],
    [Recommencer avec `raven.txt`, la copie en texte : #comment[dans Writer, Fichier, Ouvrir, puis `travail\raven.txt`.]
      #constat[Les trois opérations fonctionnent. Le titre a la même police et la même taille que les strophes.]],
    [Recommencer avec `raven.pdf`, l'export en PDF : #comment[double-clic sur le fichier, dans `travail\`, pour l'ouvrir dans le lecteur PDF du poste.]
      #constat[On peut sélectionner et chercher le texte. Le lecteur PDF ne permet pas de le modifier.]],
    [Recommencer avec `raven.png`, l'export en image : #comment[dans Writer, Fichier, Ouvrir, puis `travail\raven.png`. Le `.png` s'ouvre dans Draw, comme une image posée sur une page.]
      #constat[Aucune des trois opérations ne fonctionne. L'image ne contient que des pixels, de la première page seulement.]],
  )

  #notes[
    Ouvert depuis LibreOffice, un PDF s'ouvre dans Draw, où chaque ligne devient un cadre de
    texte modifiable. Le faire ouvrir par double-clic, dans le lecteur PDF du poste.

    Nommer ici la différence entre une page décrite (PDF, texte
    vectoriel) et une page photographiée (PNG, JPEG).

    Faire remarquer la perte : le PDF garde le texte mais fige la mise en page ;
    l'image perd tout sauf l'apparence.
  ]
]
// --------------------------------------------
// Relecture du 19/10/2026 : le tableau des fichiers devient une liste de
// consignes. La façon d'ouvrir un fichier dans un éditeur, qui n'était que
// dans les notes, passe sur la diapositive ; l'annonce, qui donnait le
// résultat avant l'essai, passe dans les notes, à dire après. Seconde
// relecture : le titre « Deux éditeurs de texte, les mêmes fichiers »
// devient une consigne, l'annonce écarte LibreOffice, et les icônes des
// deux éditeurs (`images/editeurs/CREDITS.md`) sont à droite. Chaque élève
// emploie l'un ou l'autre, pas les deux.
#let _editeur(fichier, nom) = align(center, stack(
  dir: ttb, spacing: 6pt,
  image("/src/cours1_v2/images/editeurs/" + fichier, height: 46pt),
  text(size: 14pt, fill: estompe)[#nom],
))

// 09/11/2026 : la comparaison des tailles, avant l'éditeur, et un avertissement qui donne la
// cause.
#d("Étape 4 · Contenu d'un fichier dans un éditeur de texte")[
  #objectif[
    comparer la taille de trois fichiers de `depart\`, `raven_une_ligne.txt`,
    `raven_une_ligne.donnees` et `raven.odt`, puis ce qu'un éditeur de texte affiche pour chacun.
  ]

  #grid(
    columns: (1fr, auto), column-gutter: 24pt, align: (top, horizon),
    consignes(
      taille: 14pt,
      [Dans `depart\`, comparer la taille des trois fichiers : #comment[Affichage, Détails, colonne Taille.]
        #constat[2 Ko pour le `.txt` et le `.donnees`, 8 Ko pour le `.odt`, avec les mêmes strophes.]],
      [Ouvrir `raven_une_ligne.txt` avec le Bloc-notes ou Notepad++ : #comment[dans `depart\`, clic droit sur le fichier, Ouvrir avec, puis l'éditeur choisi.]
        #constat[Le poème s'affiche en entier.]],
      [Ouvrir de la même façon `raven_une_ligne.donnees`, puis `raven.odt`, et comparer avec `raven_une_ligne.txt`.
        #constat[`.donnees` : le même poème, l'extension ne change rien au contenu. `.odt` : `PK`, puis des signes sans suite, le fichier n'est pas du texte. Notepad++ y affiche `NUL` à la place des octets sans caractère.]],
      [Fermer chaque fenêtre sans enregistrer.],
    ),
    stack(
      dir: ttb, spacing: 12pt,
      _editeur("bloc_notes.svg", "Bloc-notes"),
      align(center, text(size: 15pt, fill: estompe)[ou]),
      _editeur("notepadpp.svg", "Notepad++"),
    ),
  )

  #avertissement(couleur: attention)[
    Enregistrer un `.odt` depuis un éditeur de texte modifie ses octets, et Writer ne peut plus
    l'ouvrir.
  ]

  #notes[
    Tailles : 1 385 octets pour le `.txt` et le `.donnees`, 8 100 pour le `.odt`, que
    l'explorateur arrondit à 2 et 8 Ko. Dans le `.odt`, le texte (`content.xml`) occupe 4 ko
    avant compression, et les styles (`styles.xml`) 60 ko.

    Avertissement : le Bloc-notes remplace les octets qu'il ne sait pas afficher, et une seule
    lettre ajoutée décale les positions enregistrées dans l'archive. Dans les deux cas, LibreOffice
    refuse le fichier (simulation du 09/11/2026).

    Sous macOS et Linux, l'éditeur de texte du système refuse souvent les
    fichiers non texte : le faire alors en démonstration depuis le poste
    enseignant.

    Les deux règles du Bloc-notes, à dire après les essais : il affiche un caractère par
    octet, selon un encodage qu'il devine, et il n'interprète rien d'autre —
    ni image, ni mise en forme. Ce qui n'a pas de caractère correspondant
    apparaît en carré ou en signe étrange.

    Notepad++ lit les mêmes octets. Il colore un fichier d'après son
    extension, quand il l'associe à un langage tel que le `.py`
    du TD 1c. 
    Le `.odt` y montre des `NUL` en surbrillance : Notepad++
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
// Nouveau (09/11/2026), étape facultative : l'archive d'un `.odt`, d'après le TD 1b de 2026
// (`src/cours1/diapo/tds/1b_archive_odt.typ`), sans la modification ni la recompression.
// L'explorateur de Windows ne reconnaît une archive qu'à son extension. La copie est donc
// renommée en `.zip` avant d'être extraite.
#d[Étape 5 (facultative) · Structure d'un fichier `.odt`][
  #objectif[
    copier `depart\raven.odt` dans `travail\` sous le nom `raven.zip`, l'extraire, puis déterminer
    dans quels fichiers de l'archive se trouvent le texte du poème et sa mise en forme.
  ]

  #consignes(
    taille: 16pt,
    [Copier `raven.odt` de `depart\` dans `travail\` : #comment[clic droit, Copier, puis dans `travail\`, clic droit, Coller.]],
    [Renommer la copie en `raven.zip` : #comment[clic droit, Renommer, puis Oui pour confirmer le changement d'extension.]],
    [Extraire `raven.zip` : #comment[clic droit, Extraire tout…, puis Extraire.]
      #constat[Le dossier `travail\raven\` contient `content.xml`, `styles.xml`, `meta.xml`, `manifest.rdf`, `mimetype` et le dossier `META-INF`.]],
    [Ouvrir `content.xml`, puis `styles.xml`, avec le Bloc-notes ou Notepad++ : #comment[dans `travail\raven\`, clic droit sur le fichier, Ouvrir avec, puis l'éditeur choisi.]
      #constat[`content.xml` : le texte du poème, entre des balises. `styles.xml` : la mise en forme, avec les polices et les tailles.]],
  )

  #notes[
    L'explorateur ne reconnaît une archive qu'à son extension. Sans le changement d'extension,
    il ne propose pas Extraire tout. 7-Zip, s'il est installé, ouvre le `.odt` sans le renommer
    (clic droit, 7-Zip, Ouvrir l'archive).

    Le texte est dans `content.xml`, la mise en forme dans `styles.xml`. Un `.docx`, un `.xlsx`
    et un `.epub` sont construits de la même façon.

    Le TD 1b de 2026, dans l'archive 2026 du site, va plus loin : il modifie `content.xml` et
    `styles.xml`, puis recompresse l'archive.
  ]
]

// --------------------------------------------
// Relecture du 19/10/2026 : toute la salle modifie le même fichier du
// dossier partagé. La diapositive qui suit le TD, « Modifications
// simultanées d'un fichier partagé », explique ce qu'on y constate.
// 06/11/2026 : le tableau devient une liste de consignes.
#d("Étape 6 · Modification à plusieurs d'un fichier partagé")[
  #avertissement(couleur: attention)[
    Toute la salle fait cette étape en même temps. Attendre le signal de l'enseignant avant de
    commencer.
  ]

  #objectif[
    ajouter chacun une ligne au même fichier du dossier partagé, `info01-salle.txt`, puis relire ce
    fichier.
  ]

  #consignes(
    taille: 17pt,
    [Ouvrir le fichier dans le Bloc-notes, puis attendre le signal : #comment[dans `formationTemp`, clic droit sur `info01-salle.txt`, Ouvrir avec, Bloc-notes.]
      #constat[Le fichier est vide.]],
    [Au signal, écrire son prénom, puis enregistrer : `Ctrl` + `S`.
      #constat[Le Bloc-notes enregistre sans aucun message.]],
    [Fermer le Bloc-notes, puis rouvrir le fichier.
      #constat[Un prénom, ou quelques-uns : la plupart ont disparu.]],
  )

  #legende[
    Ne modifier aucun autre fichier de `formationTemp`.
  ]

  #notes[
    Avant la séance : déposer dans `formationTemp` un fichier texte vide,
    `info01-salle.txt`, à côté de l'archive. Le vider avant chaque groupe.

    Deux signaux : un pour ouvrir le fichier, quand la salle a fini la diapositive précédente ; un
    pour écrire, quand toute la salle a le fichier ouvert. Chacun doit avoir lu le fichier vide. Faire
    écrire le prénom seul : le fichier est lisible par toute la promotion.

    À vérifier sur un poste de la salle : l'élève a le droit d'écrire dans
    `formationTemp`, et le Bloc-notes de Windows 11 enregistre sans signaler
    que le fichier a changé depuis son ouverture. Notepad++ propose de
    recharger un fichier modifié ailleurs : ne pas l'employer ici.

    Demander combien de prénoms chacun lit, puis passer à la diapositive qui
    suit le TD.
  ]
]
