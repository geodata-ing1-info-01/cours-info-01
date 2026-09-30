// TD 1b du cours 1 — « Un .odt est une archive ZIP ».
//
// Inclus par `cours1.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`, qui
// en tire la feuille de TD déposée dans le dossier annoncé. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "1b",
  titre: "Un .odt est une archive ZIP",
  annonce: "Objectif : voir de quoi est fait un document de traitement de texte, et le modifier sans son logiciel",
  dossier: "cours1/1b_archive_odt/",
  duree: "12′",
  facultatif: true,
)
#separateur-td(..td)
#d[`.odt` un format qui est une archive de plusieurs fichiers][
  #annonce[
    Copier `depart/raven.odt` dans `travail/` sous le nom `raven.zip`, puis
    l'ouvrir avec le gestionnaire d'archives : il s'extrait comme n'importe
    quelle archive, dans un dossier `raven/`.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Fichier dans l'archive], [Ce qu'il contient],
    [`mimetype`], [une ligne, le type du document],
    [`content.xml`], [le texte, entouré de balises],
    [`styles.xml`], [la mise en forme : polices, couleurs, titres],
    [`meta.xml`], [auteur, dates, nombre de mots],
    [`META-INF/manifest.xml`], [la liste de ce que contient l'archive],
  )

  #legende[
    Six fichiers en tout. `.docx`, `.xlsx` et `.epub` sont construits de la
    même façon.
  ]

  #notes[
    Faire ouvrir `content.xml` dans l'éditeur : le poème est là, en clair.
    C'est aussi la réponse à « pourquoi un `.odt` se versionne mal » : le
    fichier livré est compressé, donc illisible pour `git diff`.

    Le texte est dans `content.xml`, la mise en forme dans `styles.xml` :
    la séparation contenu / présentation déjà vue avec HTML et CSS.
  ]
]

// --------------------------------------------
#d[`content.xml`, avant et après][
  #annonce[
    Ouvrir `content.xml` avec Notepad++ plutôt qu'avec le Bloc-notes : il
    colore les balises. Le fichier est long, chercher avec `Ctrl` + `F` les
    endroits à modifier : `Text_20_body`, `The Raven`.
  ]

  #face-a-face(
    panneau("Avant")[
      #block(width: 100%, fill: gris, inset: (x: 10pt, y: 10pt))[
        #set text(font: police-code, size: 13pt)
        #raw("<text:p text:style-name=")#text(fill: brun, weight: demi-gras)[#raw("\"Text_20_body\"")]#raw(">") \
        #raw("Once upon a midnight dreary,") \
        #raw("while I pondered, weak and weary,")
      ]
      #v(0.4em)
      #text(size: 14pt, fill: estompe)[un paragraphe ordinaire]
    ],
    panneau("Après")[
      #block(width: 100%, fill: gris, inset: (x: 10pt, y: 10pt))[
        #set text(font: police-code, size: 13pt)
        #raw("<text:p text:style-name=")#text(fill: brun, weight: demi-gras)[#raw("\"Heading_20_1\"")]#raw(">") \
        #raw("Once upon a midnight dreary,") \
        #raw("while I pondered, weak and weary,")
      ]
      #v(0.4em)
      #text(size: 14pt, fill: brun)[le même texte, devenu un titre]
    ],
  )

  #legende[
    Le texte n'a pas bougé : seul le nom du style a changé. Ce que `_20_` vient
    faire dans ce nom est la dernière diapositive de la partie.
  ]

  #notes[
    `Ctrl` + `F` est le raccourci qui fait tenir le TD dans le temps : sans lui,
    ils lisent 1 300 caractères de balises pour trouver un mot. Le faire
    faire une fois sur `Text_20_body`, puis sur `The Raven` ; la recherche
    resservira dans l'éditeur de code, avec le même raccourci.

    `content.xml` fait ici 4 ko sur 21 lignes, dont une de 1 300
    caractères : lisible au Bloc-notes en activant le retour à la ligne,
    plus confortable dans l'éditeur de code, qui colore et replie les
    balises.

    Le `_20_` intrigue toujours. Un nom de style est un nom XML, où
    l'espace est interdit ; ODF encode chaque caractère interdit par son
    code hexadécimal entouré de tirets bas, et l'espace vaut 20. Ce n'est
    donc pas un nom en trois morceaux, c'est « Text body ». Le nom lisible
    est dans l'attribut `style:display-name`, celui que LibreOffice
    affiche. Rapprochement utile : le `%20` des adresses web, même
    interdiction, même encodage. Référence OpenDocument v1.3 partie 3,
    donnée dans le notebook.

    Sur la couleur : ODF n'accepte pas de nom de couleur. Vérifié,
    `fo:color="red"` est ignoré et le titre reste noir ; il faut
    `fo:color="#c0392b"`. Occasion de dire ce qu'est un code hexadécimal,
    deux chiffres par composante. CSS accepte les deux écritures, on le
    verra au TD 3a.
  ]
]

// --------------------------------------------
#d("Modifier un document sans logiciel de bureautique")[
  #annonce[
    Éditer les fichiers extraits, recompresser, renommer en `.odt` : LibreOffice
    rouvre le document modifié.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Étape], [Ce que vous faites],
    [changer le texte], [dans `content.xml`, remplacer `>The Raven<` par `>Le Corbeau<`],
    [changer la taille], [dans `styles.xml`, sur `Heading_20_1`, passer `fo:font-size` de `115%` à `220%`],
    [changer un style], [dans `content.xml`, remplacer `Text_20_body` par `Heading_20_1` sur un paragraphe],
    [recompresser], [sélectionner les six fichiers, et les compresser en `raven2.zip`],
    [renommer], [`raven2.zip` #sym.arrow.r `raven2.odt`, puis ouvrir],
  )

  #avertissement[
    Compresser les six fichiers depuis l'intérieur de `raven/`, pas le dossier
    lui-même : sinon l'archive contient `raven/content.xml` et LibreOffice
    refuse de l'ouvrir.
  ]

  #notes[
    Résultat attendu : le titre en grand et le poème renommé, sans qu'aucun
    traitement de texte soit intervenu.

    Le piège est sur la diapositive parce que tout le monde le fait une
    fois : le dossier compressé au lieu de son contenu donne des chemins
    `raven/content.xml` dans l'archive, et LibreOffice répond « source file
    could not be loaded ». Sous Windows : entrer dans le dossier, tout
    sélectionner (`Ctrl` + `A`), clic droit, Compresser dans un fichier ZIP.

    Un format ouvert et documenté se manipule avec des outils quelconques.
    C'est l'argument à retenir, plus que la technique elle-même.
  ]
]

// --------------------------------------------
#d("Le même espace dans un nom de style")[
  #annonce[
    Un nom de style suit la même règle : LibreOffice affiche un nom lisible, et
    `content.xml` écrit l'espace `_20_`.
  ]

  // Le volet des styles, à gauche, et ce que `content.xml` écrit à leur place.
  // Une ligne par style : la répétition fait voir la règle mieux qu'un seul
  // exemple commenté.
  #v(0.2em)
  #align(center)[
    #let ligne(nom, interne) = (
      block(width: 100%, inset: (x: 12pt, y: 7pt), fill: gris,
            stroke: (bottom: 0.8pt + gris.darken(12%)))[
        #text(size: 16pt)[#nom]
      ],
      align(horizon + center, text(size: 20pt, fill: accent)[→]),
      align(horizon, text(font: police-code, size: 16pt, fill: brun,
                          weight: demi-gras)[#interne]),
    )
    #grid(
      columns: (215pt, auto, auto),
      column-gutter: 16pt,
      row-gutter: 0pt,
      align: left,
      block(width: 100%, inset: (x: 12pt, y: 6pt), fill: accent)[
        #text(size: 14pt, fill: white, weight: demi-gras)[Styles]
      ],
      [], align(horizon, text(size: 14pt, fill: estompe)[dans `content.xml`]),
      ..ligne("Corps de texte", "Text_20_body"),
      ..ligne("Titre 1", "Heading_20_1"),
      ..ligne("Titre 2", "Heading_20_2"),
    )
  ]

  #v(0.6em)
  #tableau(
    columns: (auto, 1fr, auto),
    align: left + horizon,
    [], [Ce qui interdit l'espace], [L'espace s'y écrit],
    [Une adresse web], [la syntaxe des URL], [`%20`],
    [Un nom de style ODF], [la syntaxe des noms XML], [`_20_`],
  )

  #legende[
    20 est le code du caractère espace. Les deux l'écrivent parce que les deux
    l'interdisent, chacun avec sa marque.
  ]

  #notes[
    Boucler la partie ici : c'est le `_20_` aperçu dans `content.xml`, et
    l'étudiant vient de produire le `%20` lui-même en renommant un fichier.

    Le nom lisible est dans l'attribut `style:display-name` ; c'est lui que
    LibreOffice affiche, traduit en français dans l'interface. La chaîne
    montre donc deux passages : la traduction, puis l'encodage.

    Référence OpenDocument v1.3 partie 3 pour l'encodage des noms, donnée
    dans le notebook. Ne pas la citer à l'oral.

    Le code hexadécimal lui-même est au cours 3 : dire « le code du
    caractère espace » et rien de plus.
  ]
]
