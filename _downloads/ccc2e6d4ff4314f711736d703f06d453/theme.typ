// Thème de diapositives du module.
//
// Reprend l'identité du thème Beamer « Bruno » (Rémi Cérès et Mattéo Delabre,
// 2017-2019, licence CC0 1.0), analysé et porté dans `themes/bruno/`. Les
// valeurs relevées sur le PDF Beamer de référence y sont documentées ; elles
// sont ici transposées à une page de projection plus grande, en conservant les
// rapports d'origine (facteur 1,909, qui laisse le corps de texte à 21 pt).
//
// Chaque diapositive porte un titre descriptif, une phrase d'annonce si elle
// est nécessaire, puis une preuve visuelle (schéma, sortie, comparaison).
// Pas de liste à puces. Voir STYLE.md à la racine du dépôt.
//
//   typst compile cours1.typ                        # diapositives seules
//   typst compile --input notes=true cours1.typ     # avec les notes de conduite

// Bruno impose Fira Sans avec `BoldFont={* Medium}` : son « gras » n'est que du
// demi-gras. Fira Sans n'étant pas toujours installée, la pile retombe sur
// Lato, qui possède également une graisse 500.
#let police-texte = ("Fira Sans", "Lato", "DejaVu Sans")
#let police-code = ("DejaVu Sans Mono",)

// Les trois couleurs du thème d'origine, et rien de plus.
#let accent = rgb("#182936")      // brunoblue : texte, titres, structure
#let encre = rgb("#182936")
#let estompe = rgb("#6b7683")     // dérivée pour le texte secondaire
#let brun = rgb("#704730")        // brunomarroon : filet, et parties TD
#let gris = rgb("#E6E6E6")        // brunolightgray : pied de page, blocs

// Deux couleurs de signalement, ajoutées au thème d'origine. Elles codent une
// information et ne servent pas à mettre en valeur : `attention` sur un point
// à ne pas manquer, `alerte` sur une erreur fréquente et ses conséquences —
// la distinction des encadrés `note` et `warning` des pages de cours.
//
// `attention` est `brunoblue` éclairci et saturé : même teinte que le texte,
// donc lisible comme une variante de la structure et non comme une couleur
// nouvelle. `alerte` est un orange franc, choisi loin de `brun` : les deux
// sont chaudes, et un brun désaturé projeté à côté d'un orange se confond.
// Ne pas employer `alerte` dans un TD, où `brun` est déjà présente.
#let attention = rgb("#2A6F97")   // bleu clair : note, point d'attention
#let alerte = rgb("#B35309")      // orange : avertissement, erreur fréquente

// Le « gras » du thème, qui est un demi-gras.
#let demi-gras = 500

// Tailles de Bruno (classe 11 pt) multipliées par 1,909.
#let pt-tiny = 11.5pt             // pied de page
#let pt-footnotesize = 17pt
#let pt-normalsize = 21pt
#let pt-LARGE = 33pt              // titre de diapositive et de la page de titre

#let marge-x = 18.5mm             // 10 mm sur 160 mm, transposé
#let hauteur-pied = 21.6pt

// Largeur d'une diapositive : le 16:9 de typst, 297 x 167,06 mm.
#let largeur-diapo = 297mm
#let hauteur-diapo = 167.06mm

// La version annotée pose les notes à droite de la diapositive, sur une page
// deux fois plus large — c'est le format « second écran » de Beamer
// (`show notes on second screen`). Étirée sur un bureau étendu à deux écrans,
// la moitié gauche part au vidéoprojecteur et la moitié droite reste sur
// l'écran du présentateur ; imprimée ou lue à plat, elle donne la diapositive
// et ses notes côte à côte.
//
// La moitié gauche est au millimètre celle qui est projetée : les marges de
// droite absorbent toute la seconde moitié, si bien que la zone de diapositive
// mesure 260 x 156,76 mm dans les deux variantes. Une diapositive qui tient à
// la projection tient donc ici, et les deux PDF ont le même nombre de pages,
// page pour page.
//
// Aucun format de PDF ne distingue une note d'un contenu de page : ce que le
// lecteur affiche, il l'affiche en entier. C'est pourquoi la version annotée
// n'est pas projetable telle quelle, et pourquoi le PDF sans notes reste le
// document de projection.

#let notes-visibles = sys.inputs.at("notes", default: "") == "true"

// Écart garanti entre le titre et le corps d'une diapositive, en plus du
// ressort qui répartit l'espace libre. Sans lui, une diapositive un peu pleine
// referme le ressort et l'annonce vient se coller sous le titre.
//
// Il vaut pour les deux variantes. La version annotée s'en passait, faute de
// place, du temps où sa bande de notes était prise sur la diapositive ; elle
// est maintenant ajoutée sous elle, et les deux variantes ont exactement la
// même zone de diapositive. `outils/verifier_diapos.py` doit donc désormais
// rendre le même verdict sur l'une et sur l'autre.
#let ecart-titre = 17pt

// Corrigé des TD.
//
// Ce qu'un TD fait constater ne se projette pas pendant qu'il se
// fait : la tentative, même infructueuse, améliore la rétention de la réponse
// donnée ensuite (effet de pré-test, Richland, Kornell & Kao 2009 ; Kornell,
// Hays & Bjork 2009), et un support à trous est plus efficace qu'un support
// complet (notes guidées, Konrad & al.). Les colonnes d'observation sont donc
// laissées vides à la projection, et remplies dans une seconde compilation.
//
//   typst compile --root . cours1.typ                     # à projeter
//   typst compile --root . --input corrige=true cours1.typ # après la séance
#let corrige-visible = sys.inputs.at("corrige", default: "") == "true"

// Petites capitales : ni Fira Sans ni Lato ne portent de table `smcp`, donc
// `smallcaps()` resterait sans effet. On les fabrique.
// Un sigle et son développement. Le sigle porte la couleur des termes de
// vocabulaire, et les initiales du développement la reprennent : on voit d'où
// viennent les lettres sans avoir à le dire. `initiale` sert aussi seule,
// quand le développement est écrit ailleurs.
#let initiale(lettre) = text(fill: attention, weight: demi-gras)[#lettre]

// Le corps tient sur une ligne : un retour avant le crochet fermant laisserait
// une espace, et le sigle est presque toujours suivi d'une virgule.
#let sigle(nom, developpement) = [#text(fill: attention, weight: demi-gras)[#nom], pour #emph(developpement)]

#let petites-capitales(corps) = text(size: 0.85em, tracking: 0.08em)[
  #upper(corps)
]

// Image de la page de titre, découpée en trapèze le long du bord droit. Beamer
// rogne avec \clip ; typst ne sait pas rogner selon une forme quelconque, donc
// la gauche est masquée par un polygone blanc. Proportions d'origine : le
// trapèze fait 32 % de la largeur en haut et 51 % en bas.
#let fond-titre(chemin, largeur, hauteur) = {
  place(top + right, image(chemin, height: hauteur))
  place(top + right, rect(
    width: 62% * largeur, height: hauteur,
    fill: gradient.linear(
      rgb("#000000"), rgb("#00000000"), angle: -15deg, space: rgb,
    ),
  ))
  place(top + left, polygon(
    fill: white,
    (0pt, 0pt),
    (0.68 * largeur, 0pt),
    (0.49 * largeur, hauteur),
    (0pt, hauteur),
  ))
}

#let diapos(
  titre: "",
  sous-titre: "",
  auteur: "",
  date: "",
  fond: none,
  titre-court: none,
  auteur-court: none,
  corps,
) = {
  let titre-pied = if titre-court != none { titre-court } else { titre }
  let auteur-pied = if auteur-court != none { auteur-court } else { auteur }

  set text(font: police-texte, size: pt-normalsize, fill: encre, lang: "fr")
  set par(justify: false, leading: 0.65em)
  show strong: set text(weight: demi-gras)
  show raw: set text(font: police-code, size: 0.78em)

  // itemize item [square], itemize subitem [circle].
  set list(
    marker: (
      text(fill: accent, size: 0.7em)[■],
      text(fill: accent, size: 0.7em)[●],
    ),
    indent: 11pt, body-indent: 13pt, spacing: 0.62em,
  )
  show list: set block(above: 0.62em, below: 0.62em)

  set page(
    // Deux fois plus large quand les notes sont demandées ; la moitié
    // supplémentaire est absorbée par la marge de droite, et le flux reste
    // donc dans la moitié gauche.
    width: largeur-diapo * (if notes-visibles { 2 } else { 1 }),
    height: hauteur-diapo,
    // Le bandeau supérieur est vidé par le thème : la zone de texte commence au
    // bord du papier.
    margin: (
      left: marge-x,
      right: marge-x + (if notes-visibles { largeur-diapo } else { 0mm }),
      top: 0mm,
      bottom: 10.3mm,
    ),
    // La barre de pied de page est posée en avant-plan, seul moyen de la coller
    // au bord inférieur et de la faire courir sur toute la largeur du papier,
    // comme le fait Beamer en donnant à \textwidth la valeur de \paperwidth.
    foreground: context {
      let numero = counter(page).get().first()
      let total = counter(page).final().first()
      place(bottom + left, block(
        width: largeur-diapo, height: hauteur-pied, fill: gris,
        inset: (x: marge-x),
      )[
        #set text(size: pt-tiny, fill: accent)
        #align(horizon)[
          #titre-pied
          #h(1fr)
          #auteur-pied
          #h(2em)
          #numero #sym.slash #total
        ]
      ])
    },
  )

  corps
}

// Page de titre, posée explicitement là où on la veut : le deck peut ainsi
// ouvrir sur la couverture du module et ne présenter la séance qu'ensuite.
// Beamer ne centre pas ce bloc : il répartit l'espace libre selon
// \beamer@frametopskip contre \beamer@framebottomskip, soit 0,4 contre 0,6.
#let page-titre(titre: "", sous-titre: "", auteur: "", date: "", fond: none) = {
  context {
    let l = page.width
    let h = page.height
    page(
      background: if fond != none { fond-titre(fond, l, h) },
      {
        v(0.4fr)
        block(width: 70%)[
          #text(size: pt-LARGE, weight: demi-gras)[#titre]
          #v(0.2em)
          #line(length: 70%, stroke: 0.955pt + brun)
          #v(1.35em)
          #text(size: pt-normalsize)[#sous-titre]
          #v(1.4em)
          #text(size: pt-footnotesize)[
            #auteur \
            #date
          ]
        ]
        v(0.6fr)
      },
    )
  }
}

// Couverture du module : la seule diapositive qui présente l'ensemble des sept
// séances, et la seule à porter la mention de l'auteur sur fond plein.
#let separateur-module(titre-module, annonce: none, auteur: "", date: "") = {
  set page(foreground: none, fill: accent)
  align(horizon + left, block(width: 82%)[
    #text(size: pt-footnotesize, fill: brun.lighten(30%), weight: demi-gras)[
      #petites-capitales("Module")
    ]
    #v(0.5em)
    #text(size: pt-LARGE * 1.15, fill: white, weight: demi-gras)[#titre-module]
    #v(0.45em)
    #line(length: 45%, stroke: 1.5pt + brun.lighten(25%))
    #if annonce != none [
      #v(0.6em)
      #text(size: pt-normalsize, fill: white.darken(18%))[#annonce]
    ]
    #v(2.2em)
    #text(size: pt-footnotesize, fill: white.darken(32%))[
      #auteur #h(1fr) #date
    ]
  ])
  pagebreak(weak: true)
}

// Une diapositive : un titre descriptif, un sous-titre facultatif en petites
// capitales, puis le corps. Décalage du titre et rapport de centrage du corps
// relevés sur le PDF Beamer (26 pt sur 255, et 0,85 contre 1).
//
// `cellule` renvoie à la section d'un notebook que les étudiants exécutent
// pendant que la diapositive est projetée : la ligne de titre reçoit alors
// un cartouche « § n » à droite. Son brun est celui des TD : la diapositive
// dit qu'à ce moment on est sur machine. Le
// numéro est celui du titre de section du notebook, pas le rang d'exécution
// que JupyterLab affiche entre crochets.
#let cartouche-cellule(numero, fichier) = box(
  inset: (x: 8pt, y: 4pt), fill: brun.lighten(88%), stroke: 0.8pt + brun.lighten(45%),
)[
  #text(font: police-code, size: 12pt, fill: brun, weight: demi-gras)[
    #if fichier != none [#fichier #sym.dot.c ]§ #numero
  ]
]

#let d(titre-diapo, sous-titre: none, cellule: none, fichier: none, corps) = {
  v(52.5pt)
  let titre = [
    #set text(size: pt-LARGE, fill: accent, weight: demi-gras)
    #set par(leading: 0.4em)
    #titre-diapo
    #if sous-titre != none [
      #linebreak()
      #text(size: pt-normalsize, fill: estompe)[
        #petites-capitales(sous-titre)
      ]
    ]
  ]
  block(below: 0em, width: 100%, if cellule == none { titre } else {
    grid(
      columns: (1fr, auto), column-gutter: 12pt,
      align: (left + horizon, right + horizon),
      titre, cartouche-cellule(cellule, fichier),
    )
  })
  // Un écart garanti, puis le ressort. Sans le premier, une diapositive un peu
  // pleine referme le ressort et vient coller l'annonce sous le titre — ce qui
  // arrive vite dans la version annotée, dont le bas de page est réservé aux
  // notes. `outils/verifier_diapos.py` mesure cet écart page par page.
  v(ecart-titre)
  v(0.85fr)
  corps
  v(1fr)
  pagebreak(weak: true)
}

// Gabarit commun aux diapositives de séparation : fond plein, filet et titre.
// Bruno n'en fournit aucun ; celui-ci n'emploie que les couleurs du thème.
#let _separation(fond, sur-fond, filet, titre-partie, annonce, mention, dossier) = {
  set page(
    foreground: none,
    fill: if notes-visibles { white } else { fond },
    // En double largeur, seule la moitié projetée reçoit le fond plein.
    background: if notes-visibles {
      place(top + left, rect(width: largeur-diapo, height: 100%, fill: fond))
    },
  )
  align(horizon + left, block(width: 78%)[
    #if mention != none [
      #text(size: pt-footnotesize, fill: filet, weight: demi-gras)[
        #if type(mention) == str { petites-capitales(mention) } else { mention }
      ]
      #v(0.5em)
    ]
    #line(length: 40%, stroke: 1.5pt + filet)
    #v(0.7em)
    #text(size: pt-LARGE, fill: sur-fond, weight: demi-gras)[#titre-partie]
    #if annonce != none [
      #v(0.45em)
      #text(size: pt-normalsize, fill: sur-fond.lighten(35%))[#annonce]
    ]
    // Le dossier de travail, sur l'ouverture plutôt que dans une légende trois
    // diapositives plus loin : c'est la première chose que la salle a besoin de
    // savoir pour commencer, et la première question posée quand elle manque.
    #if dossier != none [
      #v(0.7em)
      #text(size: pt-footnotesize, font: police-code, fill: sur-fond.lighten(20%))[
        #dossier
      ]
    ]
  ])
  pagebreak(weak: true)
}

// Diapositive de section, entre deux parties de la séance : fond bleu.
#let separateur(titre-partie, annonce: none, mention: none, dossier: none) = _separation(
  accent, white, brun.lighten(25%), titre-partie, annonce, mention, dossier,
)

// Ouverture d'un TD : fond brun, la seconde couleur du thème. Elle code une
// information réelle et répétée, le passage de l'exposé au travail sur machine.
//
// Un TD se décrit par un dictionnaire, défini en tête de son fichier et passé
// ici par `..td`. Le même dictionnaire sert au sommaire des TD (`sommaire-td`)
// quand le support est compilé sans eux, et `outils/compiler_tds.py` y lit le
// dossier où déposer la feuille de TD : une seule description, trois emplois.
//
//   #let td = (
//     numero: "2c",                      // chiffre : le bloc ; lettre : l'ordre dedans
//     titre: "Le même programme en C++",
//     annonce: "…",                      // une phrase, facultative
//     dossier: "cours1/2c_hello_cpp/",   // tel que l'étudiant le voit
//     duree: "10′",                      // indicative, facultative
//     facultatif: true,                  // ce que la séance ne fait pas
//   )
//   #separateur-td(..td)
//
// `dossier` est le chemin dans l'archive remise aux étudiants — sans `data/`,
// ni `produit/`, ni `fourni/`, qui sont l'affaire du dépôt. Toute ouverture de
// TD doit le porter : sans lui, la salle cherche ses fichiers au lieu d'écouter
// la consigne.
#let mention-td(numero, facultatif) = {
  petites-capitales("TD")
  if numero != none [ #numero]
  if facultatif [ #h(0.3em) #sym.dot.c #h(0.3em) #petites-capitales("facultatif")]
}

#let separateur-td(
  numero: none, titre: "", annonce: none, dossier: none,
  duree: none, facultatif: false,
) = {
  let dossier-et-duree = if dossier != none and duree != none [
    #dossier #h(1.5em) #text(font: police-texte, fill: white.darken(30%))[#sym.approx #duree]
  ] else { dossier }
  _separation(brun, white, gris, titre, annonce, mention-td(numero, facultatif), dossier-et-duree)
}

// Sommaire des TD d'un bloc, projeté à leur place quand le support est compilé
// sans eux (`--input tds=false`) : une seule diapositive, sur le fond brun des
// TD, qui dit ce qu'il y a à faire, dans quel dossier, et ce qui est
// facultatif. Les dictionnaires sont ceux des fichiers de TD, importés par
// l'assemblage : ce que le sommaire liste et ce que le TD projette ne peuvent
// pas diverger.
// Vrai quand un fichier de TD est compilé seul, en feuille de TD, par
// `outils/compiler_tds.py` (`--input feuille=true`). Un TD qui s'ouvre dans le
// cours par `separateur-cours-td` garde ainsi son ouverture brune sur la
// feuille.
#let feuille-seule = sys.inputs.at("feuille", default: "") == "true"

// Ouverture commune d'une partie de l'exposé et du TD qui se joue en même
// temps : la page est partagée par une oblique, comme la page de titre du
// cours, le bleu de l'exposé à gauche, le brun du TD à droite. À droite, pas
// de texte : la mention du TD, le notebook à suivre pendant l'exposé, le
// dossier et la durée. Les arguments du TD sont ceux de `separateur-td`,
// passés par `..td` ; `notebook` est le fichier à ouvrir, en chaîne ou en
// contenu (deux noms séparés par `\`).
//
//   #separateur-cours-td("Chemins et fichiers", annonce-partie: "…",
//                        notebook: "recette.ipynb", ..td)
#let separateur-cours-td(
  titre-partie, annonce-partie: none, notebook: none,
  numero: none, titre: "", annonce: none, dossier: none,
  duree: none, facultatif: false,
) = {
  let l = largeur-diapo
  let haut = hauteur-diapo
  set page(
    foreground: none,
    fill: if notes-visibles { white } else { accent },
    // En double largeur, seule la moitié projetée reçoit les fonds.
    background: {
      if notes-visibles {
        place(top + left, rect(width: l, height: 100%, fill: accent))
      }
      place(top + left, polygon(
        fill: brun, (0.57 * l, 0pt), (l, 0pt), (l, haut), (0.49 * l, haut),
      ))
    },
  )
  // L'exposé, à gauche de l'oblique.
  place(horizon + left, block(width: 0.43 * l)[
    #line(length: 40%, stroke: 1.5pt + brun.lighten(25%))
    #v(0.7em)
    #text(size: pt-LARGE, fill: white, weight: demi-gras)[#titre-partie]
    #if annonce-partie != none [
      #v(0.45em)
      #text(size: pt-normalsize, fill: white.darken(12%))[#annonce-partie]
    ]
  ])
  // Le TD, à droite. Le décalage part du bord gauche de la zone de texte,
  // ce qui vaut aussi en double largeur.
  place(horizon + left, dx: 0.62 * l - 2 * marge-x, block(width: 0.38 * l)[
    #text(size: pt-footnotesize, fill: gris, weight: demi-gras)[
      #mention-td(numero, facultatif)
    ]
    #v(0.5em)
    #line(length: 40%, stroke: 1.5pt + gris)
    #v(0.7em)
    #if notebook != none [
      #text(size: pt-normalsize, fill: white.darken(12%))[Notebook à suivre pendant l'exposé]
      #v(0.4em)
      #text(size: pt-normalsize * 1.15, font: police-code, fill: white, weight: demi-gras)[#notebook]
    ] else [
      #text(size: pt-LARGE, fill: white, weight: demi-gras)[#titre]
    ]
    #if dossier != none [
      #v(0.9em)
      #text(size: pt-footnotesize, font: police-code, fill: white.darken(8%))[
        #dossier
        #if duree != none [
          #h(1.5em) #text(font: police-texte, fill: white.darken(30%))[#sym.approx #duree]
        ]
      ]
    ]
  ])
  pagebreak(weak: true)
}

#let sommaire-td(..tds) = {
  set page(
    foreground: none,
    fill: if notes-visibles { white } else { brun },
    background: if notes-visibles {
      place(top + left, rect(width: largeur-diapo, height: 100%, fill: brun))
    },
  )
  align(horizon + left, block(width: 100%)[
    #text(size: pt-footnotesize, fill: gris, weight: demi-gras)[
      #petites-capitales("Travaux dirigés")
    ]
    #v(0.5em)
    #line(length: 40%, stroke: 1.5pt + gris)
    #v(1.1em)
    #set text(fill: white)
    #grid(
      columns: (auto, 1fr, auto),
      column-gutter: 24pt, row-gutter: 1.05em,
      align: (left + top, left + top, right + top),
      ..for td in tds.pos() {
        let facultatif = td.at("facultatif", default: false)
        let duree = td.at("duree", default: none)
        (
          text(weight: demi-gras)[TD #td.numero],
          [
            #td.titre
            #if facultatif [
              #text(size: pt-footnotesize, fill: white.darken(30%))[— facultatif]
            ]
            #linebreak()
            #text(size: pt-footnotesize, font: police-code, fill: white.darken(20%))[#td.dossier]
          ],
          text(size: pt-footnotesize, fill: white.darken(30%))[
            #if duree != none [#sym.approx #duree]
          ],
        )
      }
    )
  ])
  pagebreak(weak: true)
}

// Reprise de l'exposé après un TD placé au milieu d'une partie, et non à sa
// fin. Sans elle, rien ne dit où le travail sur machine s'arrête : la
// diapositive suivante reprend le fond blanc de l'exposé, mais après quatre
// diapositives blanches de TD, ce n'est pas un signal.
// Même fond que les diapositives de section, et la couleur ne code toujours
// qu'une chose : le bleu ouvre un bloc de cours, le brun un bloc sur machine.
#let separateur-reprise(titre, annonce: none) = separateur(
  titre, annonce: annonce, mention: "Reprise du cours",
)

// Phrase d'annonce placée entre le titre et la preuve visuelle.
#let annonce(corps) = block(width: 100%, below: 0.8em)[
  #set text(size: 17pt)
  #corps
]

// Notes de conduite : ce que l'enseignant dit, et qui n'a donc pas à être
// projeté. Masquées par défaut (voir --input notes=true en tête de fichier).
#let notes(corps) = {
  if notes-visibles {
    // Les notes vont dans la moitié droite, hors du flux : le décalage vaut
    // une largeur de diapositive, et la largeur du bloc est celle de la zone de
    // texte. Le décalage est une constante et non une mesure, ce qui compte —
    // un bloc mesuré dans le flux y consomme de la hauteur, déséquilibre les
    // deux ressorts du gabarit et remonte le corps de la diapositive.
    //
    // `dy` aligne le haut des notes sur celui du titre, dont le gabarit `d`
    // donne le décalage.
    place(top + left, dx: largeur-diapo, dy: 52.5pt, block(width: 100%)[
      #set text(size: 12pt, fill: estompe)
      #set par(leading: 0.55em)
      #corps
    ])
  }
}

// Légende sous une preuve visuelle (source, condition de mesure…).
#let legende(corps) = block(width: 100%, above: 0.6em)[
  #set text(size: 13pt, fill: estompe)
  #corps
]


// Tableau.
//
// Le style est ici et nulle part ailleurs : les diapositives ne passent que le
// contenu, les colonnes et l'alignement. Le corps est réduit d'un cran par
// rapport au texte courant, les colonnes sont séparées par un filet, et la
// ligne d'en-tête ressort par un fond très clair, un demi-gras et un filet
// plus marqué.
//
// `entete: false` pour un tableau dont la première ligne est déjà une donnée,
// comme les tableaux d'appariement « terme / définition ».
#let tableau(entete: true, ..args) = {
  let filet-leger = 0.4pt + gris.darken(10%)
  let contenu = table(
    inset: (x: 9pt, y: 7pt),
    fill: (x, y) => if entete and y == 0 { gris.lighten(45%) },
    stroke: (x, y) => (
      left: if x > 0 { 0.5pt + gris.darken(6%) },
      top: if y == 0 { none } else if y == 1 and entete {
        0.9pt + accent
      } else { filet-leger },
    ),
    ..args,
  )
  set text(size: pt-footnotesize)
  if entete {
    show table.cell.where(y: 0): set text(weight: demi-gras)
    contenu
  } else {
    contenu
  }
}

// Deux colonnes de comparaison, pour opposer deux objets de même nature.
#let face-a-face(gauche, droite, ecart: 22pt) = grid(
  columns: (1fr, 1fr), gutter: ecart, gauche, droite,
)

// Étiquette d'un panneau de comparaison.
#let panneau(titre, corps) = block(width: 100%)[
  #text(size: 15pt, fill: estompe, weight: demi-gras)[#titre]
  #v(0.35em)
  #corps
]

// ---------------------------------------------------------------------------
// Pictogrammes
//
// Dessinés avec les primitives de typst (rect, circle, line, rotate) : ni
// police d'icônes, ni fichier externe, donc rien à installer. Ils servent à
// distinguer les couches d'un schéma, jamais à décorer.

#let icone-fenetre(taille: 34pt, couleur: accent) = box(
  width: taille, height: taille * 0.78,
)[
  #place(top + left, rect(
    width: taille, height: taille * 0.78, radius: 2pt, stroke: 1.6pt + couleur,
  ))
  #place(top + left, rect(
    width: taille, height: taille * 0.2, radius: 2pt, fill: couleur,
  ))
  #place(top + left, dx: taille * 0.08, dy: taille * 0.05,
         circle(radius: taille * 0.04, fill: white))
  #place(top + left, dx: taille * 0.2, dy: taille * 0.05,
         circle(radius: taille * 0.04, fill: white))
]

#let icone-engrenage(taille: 34pt, couleur: accent) = box(
  width: taille, height: taille,
)[
  #for i in range(6) {
    place(center + horizon, rotate(i * 30deg, rect(
      width: taille * 0.16, height: taille * 0.98, radius: 1pt, fill: couleur,
    )))
  }
  #place(center + horizon, circle(radius: taille * 0.33, fill: couleur))
  #place(center + horizon, circle(radius: taille * 0.14, fill: white))
]

#let icone-puce(taille: 34pt, couleur: accent) = box(
  width: taille, height: taille,
)[
  #let c = taille * 0.6
  #for i in range(3) {
    let d = (i - 1) * c * 0.33
    place(center + horizon, dx: d, dy: -c * 0.62,
          rect(width: 1.6pt, height: c * 0.2, fill: couleur))
    place(center + horizon, dx: d, dy: c * 0.62,
          rect(width: 1.6pt, height: c * 0.2, fill: couleur))
    place(center + horizon, dx: -c * 0.62, dy: d,
          rect(width: c * 0.2, height: 1.6pt, fill: couleur))
    place(center + horizon, dx: c * 0.62, dy: d,
          rect(width: c * 0.2, height: 1.6pt, fill: couleur))
  }
  #place(center + horizon, rect(
    width: c, height: c, radius: 2pt, stroke: 1.6pt + couleur,
  ))
  #place(center + horizon, rect(
    width: c * 0.38, height: c * 0.38, radius: 1pt, fill: couleur,
  ))
]

// ---------------------------------------------------------------------------

// Question posée à la salle, à laquelle les étudiants répondent à l'oral.
#let question(numero, corps) = block(
  width: 100%, inset: (x: 14pt, y: 11pt),
  fill: gris, stroke: (left: 3pt + accent),
)[
  #grid(
    columns: (auto, 1fr), column-gutter: 12pt, align: horizon,
    text(size: 21pt, fill: accent, weight: demi-gras)[#numero],
    text(size: 18pt)[#corps],
  )
]

// Erreur fréquente, et sa conséquence. Répondant en diapositive à l'encadré
// `warning` des pages de cours : une forme qu'on reconnaît à la deuxième
// occurrence, ce qu'un mot en couleur ne fait pas. Un par diapositive au plus,
// et pas dans un TD, où le brun est déjà à l'écran.
#let avertissement(corps) = block(
  width: 100%, inset: (x: 13pt, y: 10pt), above: 0.7em,
  fill: alerte.lighten(92%), stroke: (left: 3pt + alerte),
)[
  #set text(size: 18pt)
  #text(fill: alerte, weight: demi-gras)[Attention. ] #corps
]

// Ce que le TD fait constater : masqué à la projection, remplacé par
// un filet à compléter, et affiché dans la compilation « corrigé ».
#let reponse(corps) = if corrige-visible {
  corps
} else {
  box(width: 100%, baseline: 0.15em)[
    #line(length: 100%, stroke: 0.6pt + gris.darken(18%))
  ]
}

// Étiquette d'extension, en chasse fixe, pour les grilles de reconnaissance.
//
// `couleur` distingue un sous-ensemble de la grille — les formats du module,
// que les étudiants éditeront eux-mêmes. Elle teinte le fond autant que le
// texte : sur une grille de seize étiquettes, une couleur de texte seule ne se
// voit pas à la projection.
#let etiquette(nom, reponse: none, couleur: none) = block(
  width: 100%, inset: (x: 8pt, y: 5pt),
  fill: if couleur == none { gris } else { couleur.lighten(88%) },
  stroke: 0.8pt + if couleur == none { gris.darken(12%) } else { couleur.lighten(45%) },
)[
  #align(center)[
    #text(font: police-code, size: 15pt, weight: demi-gras,
          fill: if couleur == none { accent } else { couleur })[#nom]
    #if reponse != none [
      #v(0.2em)
      #text(size: 11.5pt, fill: estompe)[#reponse]
    ]
  ]
]

// Bloc Beamer : bandeau de titre bleu sur texte blanc, corps sur fond gris,
// angles vifs. Le thème d'origine n'appelle jamais blocks[rounded].
#let bloc-titre(titre, corps) = block(width: 100%, breakable: false)[
  #block(width: 100%, fill: accent, inset: (x: 11pt, y: 7pt))[
    #text(fill: white, size: pt-normalsize)[#titre]
  ]
  #block(width: 100%, fill: gris, inset: (x: 11pt, y: 11pt))[
    #corps
  ]
]

// ---------------------------------------------------------------------------
// Illustrations
//
// Fenêtre d'application, dessinée : barre de titre, trois pastilles, corps.
// Sert à montrer à quoi ressemble une interface sans photographier un produit
// précis, donc sans capture d'écran à versionner ni à refaire à chaque
// changement de version du logiciel.
#let fenetre(titre, corps, code: false, hauteur: auto) = block(
  width: 100%, height: hauteur, stroke: 1pt + accent.lighten(55%), clip: true,
)[
  #block(width: 100%, fill: gris, inset: (x: 9pt, y: 6pt))[
    #grid(
      columns: (auto, 1fr), column-gutter: 9pt, align: horizon,
      box(height: 8pt)[
        #for i in range(3) {
          place(horizon + left, dx: i * 11pt,
                circle(radius: 3.5pt, stroke: 0.8pt + estompe))
        }
        #h(29pt)
      ],
      text(size: 13pt, fill: estompe)[#titre],
    )
  ]
  #block(width: 100%, inset: (x: 10pt, y: 9pt))[
    #if code {
      set text(font: police-code, size: 12.5pt)
      set par(leading: 0.7em)
      corps
    } else { corps }
  ]
]

// Captures d'écran.
//
// Elles ne sont pas versionnées : volumineuses, elles vieillissent avec les
// versions des logiciels et n'ont pas à peser sur l'historique. Elles vivent
// dans `data/cours<n>/illustrations/`, hors dépôt, et sont fournies à part.
// Le document compile sans elles : `illustration` retombe sur l'équivalent
// dessiné passé en second argument.
//
//   typst compile --input captures=true cours1.typ
#let captures-disponibles = sys.inputs.at("captures", default: "") == "true"

// `hauteur` met l'image à l'échelle, elle ne la rogne pas : une capture
// d'écran tronquée ne montre plus ce pour quoi elle est là.
#let illustration(chemin, repli, hauteur: auto, largeur: auto) = {
  if captures-disponibles {
    block(
      stroke: 1pt + accent.lighten(55%),
      image(chemin, height: hauteur, width: largeur, fit: "contain"),
    )
  } else {
    repli
  }
}
