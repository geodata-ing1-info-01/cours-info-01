// Schémas dessinés du cours 1 v2. Nouveau (v2).
//
// S'importe depuis une partie, en plus du prélude, et nommément :
//
//     #import "../schemas.typ": schema-stockage-reseau
//
// Pas de `: *` : ce fichier ouvre `cetz.draw`, dont les noms (`grid`, `line`,
// `circle`, `content`, `rect`…) masqueraient ceux de typst chez qui
// l'importerait en bloc.
//
// Les dessins du poste, du commutateur, du nuage et du serveur sont ceux du
// cours 5 (« Local et distant ») : l'élève retrouve au cours 5 le même dessin,
// complété des temps d'aller-retour.

#import "../../commun/prelude.typ": *
#import "@preview/cetz:0.4.2"
#import cetz.draw: *
#import "../../cours5/diapo/schemas.typ": _etiquette, _fleche, _ecran, _clavier, _disque, _portable, _boitier-reseau, _nuage, _serveur

// ---------------------------------------------------------------------------
// Entrées et sorties d'un logiciel
//
// Relecture du 19/10/2026 : remplace les quatre boîtes « entrée / sortie,
// fichier / périphérique » du cours 1 de 2026. Dans votre ordinateur, des
// logiciels, dessinés en icônes d'application (le matériel vient au cours
// 5), et le disque avec les fichiers qu'il conserve. À l'horizontale, les
// flux du clavier et vers l'écran ; à la verticale, les fichiers ouverts et
// enregistrés ; vers la droite, la copie d'un fichier sur un autre
// ordinateur. Le clavier, l'écran, le disque et le portable sont les
// dessins du cours 5.

// Une icône d'application : une tuile arrondie, un pictogramme dedans.
#let _tuile(x, y, c: 1.6) = rect(
  (x - c / 2, y - c / 2), (x + c / 2, y + c / 2),
  radius: 0.25, fill: white, stroke: 1.4pt + accent,
)

// LibreOffice : une feuille de tableur, la ligne d'en-tête pleine.
#let _icone-tableur(x, y) = {
  _tuile(x, y)
  let (g, d, b, h) = (x - 0.55, x + 0.55, y - 0.5, y + 0.5)
  rect((g, h - 0.25), (d, h), fill: accent.lighten(30%), stroke: none)
  rect((g, b), (d, h), stroke: 1pt + accent)
  for k in range(1, 4) {
    line((g, h - k * 0.25), (d, h - k * 0.25), stroke: 0.8pt + accent)
  }
  for k in range(1, 3) {
    line((g + k * 1.1 / 3, b), (g + k * 1.1 / 3, h), stroke: 0.8pt + accent)
  }
}

// Le navigateur : un globe.
#let _icone-navigateur(x, y) = {
  _tuile(x, y)
  let r = 0.55
  circle((x, y), radius: r, fill: none, stroke: 1.2pt + accent)
  circle((x, y), radius: (0.24, r), fill: none, stroke: 1pt + accent)
  line((x - r, y), (x + r, y), stroke: 1pt + accent)
  for dy in (-0.28, 0.28) {
    let demi = calc.sqrt(r * r - dy * dy)
    line((x - demi, y + dy), (x + demi, y + dy), stroke: 0.8pt + accent)
  }
}

// Un programme : des lignes de code, deux en retrait.
#let _icone-script(x, y) = {
  _tuile(x, y)
  let lignes = ((0, 0.85), (0.3, 0.7), (0.3, 0.5), (0, 0.65))
  for (i, (retrait, longueur)) in lignes.enumerate() {
    let yy = y + 0.45 - i * 0.3
    line((x - 0.55 + retrait, yy), (x - 0.55 + retrait + longueur, yy),
         stroke: (paint: accent, thickness: 3pt, cap: "round"))
  }
}

// Un fichier : une page cornée, son nom dessous.
#let _fichier(x, y, nom) = {
  let (l, h, pli) = (0.85, 1.1, 0.28)
  let (g, d, b, s) = (x - l / 2, x + l / 2, y - h / 2, y + h / 2)
  line((g, b), (d, b), (d, s - pli), (d - pli, s), (g, s), close: true,
       fill: white, stroke: 1.2pt + accent)
  line((d - pli, s), (d - pli, s - pli), (d, s - pli), stroke: 1pt + accent)
  for k in range(3) {
    let yy = s - 0.45 - k * 0.18
    line((g + 0.15, yy), (d - 0.15, yy), stroke: 0.8pt + accent.lighten(45%))
  }
  // `raw` est à 0,78 em : 15 pt pour un nom de fichier lisible.
  content((x, b - 0.1), anchor: "north", text(size: 15pt, fill: accent, raw(nom)))
}

#let schema-entrees-sorties() = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + accent.lighten(45%))
  let action(pos, corps, anchor: "south") = content(
    pos, anchor: anchor, text(size: 15pt, fill: accent)[#corps])

  // votre ordinateur, et les logiciels qui s'y exécutent
  rect((5.3, 0), (18.1, 7.6), radius: 0.15, stroke: 1.6pt + accent)
  _etiquette((11.7, -0.1), "Votre ordinateur", none, largeur: 5cm)
  rect((5.9, 3.7), (17.5, 7.3), fill: accent.lighten(88%),
       stroke: 1pt + accent.lighten(40%))
  content((11.7, 7.15), anchor: "north",
          text(size: 17pt, weight: demi-gras, fill: accent)[Un logiciel en cours d'exécution])
  _icone-tableur(8.4, 5.4)
  _etiquette((8.4, 4.45), "LibreOffice", none, largeur: 3.2cm)
  _icone-navigateur(11.7, 5.4)
  _etiquette((11.7, 4.45), "Navigateur", none, largeur: 3.2cm)
  _icone-script(15.0, 5.4)
  _etiquette((15.0, 4.45), "Programme", none, largeur: 3.2cm)

  // les flux, échangés avec les périphériques
  _clavier(2.3, 5.4)
  _etiquette((2.3, 4.75), "Clavier, souris", none, largeur: 3.8cm)
  _fleche((3.95, 5.4), (5.85, 5.4))
  action((4.6, 5.6), "flux")

  _ecran(23.4, 4.85)
  _etiquette((23.4, 4.1), "Écran, son", none, largeur: 3.8cm)
  _fleche((17.55, 5.4), (21.9, 5.4))
  action((19.7, 5.6), "flux")

  // le disque, et les fichiers qu'il conserve
  rect((6.7, 0.25), (16.1, 2.6), radius: 0.1, fill: gris.lighten(50%),
       stroke: 1pt + accent.lighten(40%))
  _disque(11.7, 1.75)
  _etiquette((11.7, 0.95), "Disque", none, largeur: 2.4cm)
  _fichier(8.4, 1.75, "releve.csv")
  _fichier(15.0, 1.75, "carte.png")

  _fleche((8.4, 2.4), (8.4, 3.65))
  action((8.2, 3.0), "ouvrir", anchor: "east")
  _fleche((15.0, 3.65), (15.0, 2.4))
  action((15.2, 3.0), "enregistrer", anchor: "west")

  // la copie d'un fichier sur un autre ordinateur, et retour
  line((15.55, 1.75), (22.05, 1.75), stroke: 1.4pt + accent,
       mark: (start: ">", end: ">", fill: accent, scale: 1.2))
  action((20.1, 1.95), "copie")
  content((20.1, 1.55), anchor: "north",
          text(size: 13pt, fill: estompe)[clé USB, réseau])
  _portable(23.4, 0.75)
  _etiquette((23.4, -0.1), "Un autre ordinateur", none, largeur: 5.6cm)
})

// ---------------------------------------------------------------------------
// Les emplacements de stockage sur le réseau
//
// À gauche, le réseau local de l'école, dans un cadre : les postes de la
// salle, le commutateur, le serveur de fichiers. Le routeur est sur le bord du
// cadre. À droite, hors du cadre : Internet, les serveurs du stockage en ligne,
// et l'ordinateur de l'élève chez lui, qui n'atteint que ces derniers.

// Un poste de la salle : l'écran du cours 5, réduit pour en aligner trois.
#let _poste(x, y) = group({
  translate((x, y))
  scale(0.75)
  _ecran(0, 0)
})

#let schema-stockage-reseau() = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + accent.lighten(45%))
  let lien = 1.4pt + accent
  let y-reseau = 6.0

  // le réseau local de l'école
  rect((0, 0), (15.0, 8.6), radius: 0.2, fill: gris.lighten(55%),
       stroke: (paint: accent, thickness: 1.2pt, dash: "dashed"))
  content((0.35, 8.3), anchor: "north-west",
          text(size: 14pt, weight: demi-gras, fill: accent)[#petites-capitales[réseau local de l'école]])

  // les postes de la salle, reliés au commutateur
  for x in (1.6, 4.1, 6.6) {
    line((x, 4.0), (4.1, y-reseau - 0.35), stroke: lien)
    _poste(x, 2.8)
  }
  _etiquette((4.1, 2.25), "Les postes de la salle", "le disque du poste : Bureau, Documents",
             largeur: 7cm)

  _boitier-reseau(4.1, y-reseau)
  _etiquette((4.1, y-reseau + 0.5), "Le commutateur", none, largeur: 5cm, anchor: "south")

  // le serveur de fichiers de l'école
  line((5.2, y-reseau), (11.8, y-reseau), stroke: lien)
  line((10.4, y-reseau), (10.4, 5.2), stroke: lien)
  _serveur(10.4, 3.9)
  // `raw` est à 0,78 em : 16 pt pour qu'il ait la taille du texte voisin.
  _etiquette((10.4, 2.45), [Le serveur de l'école],
             [#text(size: 16pt)[`formationTemp`], espaces personnels], largeur: 5.6cm)

  // le routeur, au bord du réseau local
  _boitier-reseau(12.9, y-reseau, voyants: 3)
  _etiquette((12.9, y-reseau - 0.5), "Le routeur", [relie l'école \ à Internet],
             largeur: 3.4cm)

  // Internet, le stockage en ligne, l'ordinateur chez soi
  line((14.0, y-reseau), (16.4, y-reseau), stroke: lien)
  _nuage(18.0, y-reseau)
  content((18.0, y-reseau), text(size: 16pt, weight: demi-gras, fill: accent)[Internet])

  line((19.9, y-reseau), (21.7, y-reseau), stroke: lien)
  _serveur(22.6, y-reseau + 0.4)
  _etiquette((22.6, y-reseau - 1.05), "Le stockage en ligne",
             "Google Drive, OneDrive, Dropbox, Nextcloud", largeur: 5.6cm)

  line((18.0, y-reseau - 0.95), (18.0, 3.2), stroke: lien)
  _portable(18.0, 1.8)
  _etiquette((18.0, 1.35), "Chez vous", "votre ordinateur", largeur: 4cm)
})

// ---------------------------------------------------------------------------
// Copier un fichier dans l'explorateur de fichiers
//
// Dessin de typst, sans cetz : `grid` et `rect` s'écrivent `std.grid` et
// `std.rect` dans ce fichier. La fenêtre montre le dossier `depart/` du TD 1b,
// `raven.odt` sélectionné et le menu du clic droit, « Copier » en surbrillance.

#let _icone-fichier = box(width: 12pt, height: 15pt, baseline: 3pt,
  std.rect(width: 12pt, height: 15pt, radius: 1pt, fill: white, stroke: 0.8pt + estompe))

#let _entree(nom, choisie: false) = block(
  width: 100%, above: 1pt, below: 1pt, inset: (x: 5pt, y: 3pt),
  fill: if choisie { attention.lighten(85%) },
  [#_icone-fichier #h(6pt) #text(font: police-code, size: 13pt, nom)],
)

#let _menu(..articles, choisi: none) = block(
  width: 4.2cm, fill: white, stroke: 0.8pt + accent.lighten(55%), radius: 3pt,
  inset: 4pt,
  align(left, for (i, article) in articles.pos().enumerate() {
    block(width: 100%, above: 1pt, below: 1pt, inset: (x: 7pt, y: 3.5pt),
          fill: if i == choisi { attention.lighten(85%) },
          text(size: 14pt, article))
  }),
)

#let explorateur-copie() = fenetre("Explorateur de fichiers")[
  #block(width: 100%, stroke: 0.6pt + estompe, inset: (x: 6pt, y: 4pt), radius: 2pt,
         text(font: police-code, size: 13pt)[…\\1b_terminal\\depart])
  #block(width: 55%)[
    #_entree("raven.odt", choisie: true)
    #_entree("raven_une_ligne.txt")
    #_entree("auld_lang_syne.odt")
  ]
  #place(top + right, dx: -4pt, dy: 26pt,
         _menu("Ouvrir", "Couper", "Copier", "Renommer", choisi: 2))
]

// La même copie dans Git Bash. L'invite est en petit et estompée, la commande
// en grand : c'est elle que la diapositive compare au menu.
#let git-bash-copie() = fenetre("Git Bash", code: true)[
  #let invite = text(size: 12.5pt, fill: estompe, raw("eleve@POSTE-12 MINGW64 ~/Desktop/info01/cours1/1b_terminal"))
  #invite
  #v(-2pt)
  #text(size: 19pt, raw("$ cp depart/raven.odt travail/"))
  #v(8pt)
  #invite
  #v(-2pt)
  #text(size: 19pt, raw("$"))
]

// ---------------------------------------------------------------------------
// Du clavier au programme, en colonne
//
// Les quatre étapes de « Le terminal et l'interpréteur de commandes », plus
// serrées que `chaine-verticale` pour laisser la moitié droite à une fenêtre
// de terminal. `plein` remplit la boîte de l'interpréteur.

#let _etape-serree(titre, detail, plein: false) = block(
  width: 100%, inset: (x: 8pt, y: 4pt),
  fill: if plein { accent.lighten(88%) } else { white },
  stroke: 1pt + accent.lighten(if plein { 40% } else { 55% }),
)[
  #align(center)[
    #text(size: 14pt, weight: demi-gras)[#titre]
    #linebreak()
    #text(size: 11.5pt, fill: estompe)[#detail]
  ]
]

#let chaine-terminal(..etapes, plein: none) = {
  let contenu = ()
  for (i, (titre, detail)) in etapes.pos().enumerate() {
    if i > 0 { contenu.push(align(center, text(size: 14pt, fill: accent)[↓])) }
    contenu.push(_etape-serree(titre, detail, plein: i == plein))
  }
  std.grid(columns: 1, row-gutter: 1pt, ..contenu)
}

// La commande `ls depart` dans Git Bash, avec sa sortie : la liste du dossier
// `depart/` du TD 1b, telle que le guide du TD la montre (relevée de nouveau
// le 19/10/2026, sans les pages web). Une ligne par `raw`, pour estomper
// l'invite.
#let _invite-2a = "eleve@POSTE-12 MINGW64 ~/Desktop/info01/cours1/1b_terminal"

#let git-bash-ls() = fenetre("Git Bash", code: true)[
  #set par(leading: 0.45em)
  #let lignes = (
    (estompe, _invite-2a),
    (accent, "$ ls depart"),
    (accent, "auld_lang_syne.odt                raven.odt"),
    (accent, "auld_lang_syne_une_ligne.donnees  raven_une_ligne.donnees"),
    (accent, "auld_lang_syne_une_ligne.txt      raven_une_ligne.txt"),
    (accent, ""),
    (estompe, _invite-2a),
    (accent, "$"),
  )
  #for (couleur, ligne) in lignes [
    #text(size: 17pt, fill: couleur, raw(ligne)) \
  ]
]

// ---------------------------------------------------------------------------
// Exporter un document : du dossier `depart/` au dossier `travail/`
//
// TD 1a. Trois fenêtres de gauche à droite : l'explorateur sur `depart/`,
// Writer avec le document de départ ouvert et le menu Fichier, l'explorateur
// sur `travail/` avec les deux exports. Le titre de la fenêtre de Writer
// montre que le document ouvert reste `raven.odt`.

#let explorateur(chemin, noms, choisi: none, titre: "Explorateur de fichiers") = fenetre(titre)[
  #set align(left)
  #block(width: 100%, stroke: 0.6pt + estompe, inset: (x: 6pt, y: 4pt), radius: 2pt,
         text(font: police-code, size: 12pt, chemin))
  #for (i, nom) in noms.enumerate() { _entree(nom, choisie: i == choisi) }
]

#let _article-menu(corps, choisi: false) = block(
  width: 100%, above: 1pt, below: 1pt, inset: (x: 7pt, y: 3.5pt),
  fill: if choisi { attention.lighten(85%) },
  text(size: 13pt, corps),
)

#let writer-exports() = fenetre("raven.odt - LibreOffice Writer")[
  #set align(left)
  #text(size: 13pt)[#box(fill: attention.lighten(85%), inset: (x: 4pt, y: 2pt))[Fichier] #h(8pt) Édition #h(8pt) Affichage]
  #v(2pt)
  #block(width: 100%, stroke: 0.8pt + accent.lighten(55%), radius: 3pt, inset: 4pt)[
    #_article-menu[Enregistrer]
    #_article-menu(choisi: true)[Exporter… #h(1fr) PNG]
    #_article-menu(choisi: true)[Exporter sous #sym.arrow.r Exporter au format PDF…]
    #_article-menu[Fermer]
  ]
]

#let schema-exports() = {
  let fleche-texte(corps) = align(center + horizon)[
    #text(size: 12pt, fill: estompe)[#corps]
    #v(-6pt)
    #text(size: 26pt, fill: accent)[→]
  ]
  let legende-panneau(corps) = align(center, text(size: 14pt, fill: estompe, corps))
  std.grid(
    columns: (1.2fr, auto, 1.5fr, auto, 0.8fr),
    column-gutter: 8pt, row-gutter: 6pt,
    align: (center + horizon),
    explorateur([…\\depart], ("raven.odt", "raven_une_ligne.txt", "auld_lang_syne.odt"), choisi: 0, titre: "depart"),
    fleche-texte[double-clic],
    writer-exports(),
    fleche-texte[exports],
    explorateur([…\\travail], ("raven.pdf", "raven.png"), titre: "travail"),
    legende-panneau[le document de départ],
    [],
    legende-panneau[le document ouvert reste `raven.odt`],
    [],
    legende-panneau[les deux exports],
  )
}

// ---------------------------------------------------------------------------
// Une fenêtre de terminal, une ligne par `raw`
//
// Les lignes d'invite (`eleve@…`) sont estompées, les commandes et les
// sorties à la taille du texte. `raw` est à 0,78 em du texte qui l'entoure :
// `taille` est donc celle du texte, pas celle du code affiché.
#let terminal(titre: "Git Bash", taille: 19pt, ..lignes) = fenetre(titre, code: true)[
  #set par(leading: 0.45em)
  #for ligne in lignes.pos() [
    #text(size: taille, fill: if ligne.starts-with("eleve@") { estompe } else { accent }, raw(ligne)) \
  ]
]

// ---------------------------------------------------------------------------
// La recherche d'une commande dans PATH, avant et après `conda activate`
//
// Deux colonnes de dossiers, dans l'ordre de PATH. Le premier dossier qui
// contient `python.exe` est surligné : c'est lui que la commande lance. Le
// Python 2.7 des postes est un exemple, à vérifier en salle.

#let _dossier-path(chemin, contenu, lance: false) = block(
  width: 100%, inset: (x: 8pt, y: 5pt), above: 3pt, below: 3pt,
  fill: if lance { attention.lighten(85%) } else { white },
  stroke: 0.8pt + accent.lighten(if lance { 20% } else { 55% }),
)[
  #text(font: police-code, size: 12.5pt)[#chemin]
  #h(1fr)
  #text(size: 13pt, fill: estompe)[#contenu]
]

#let schema-path() = face-a-face(
  panneau[Sans conda : le premier `python.exe` trouvé, surligné, est lancé][
    #_dossier-path("/usr/bin", [`ls`, `cp`, `bash`…])
    #_dossier-path("/c/Windows/system32", [`cmd.exe`…])
    #_dossier-path("/c/Python27", [`python.exe`, Python 2.7], lance: true)
  ],
  panneau[Après `conda activate` : les dossiers d'Anaconda passent en tête][
    #_dossier-path("/c/ProgramData/anaconda3", [`python.exe`, Python 3], lance: true)
    #_dossier-path("/usr/bin", [`ls`, `cp`, `bash`…])
    #_dossier-path("/c/Windows/system32", [`cmd.exe`…])
    #_dossier-path("/c/Python27", [`python.exe`, Python 2.7])
  ],
)

// ---------------------------------------------------------------------------
// Une liste de consignes de TD, numérotée
//
// Relecture du 19/10/2026 : remplace les tableaux « Ce qu'il faut faire /
// Ce que vous vérifiez », difficiles à suivre pendant la manipulation. Même
// présentation que les pistes du gabarit `attendu-pistes` du cours 3, en plus
// grand : une consigne par ligne, qui commence par un verbe ; le numéro donne
// l'ordre des opérations.
//
//   #consignes([ouvrir…], [copier…])
#let consignes(..elements, taille: 18pt) = {
  set text(size: taille)
  std.grid(
    columns: (auto, 1fr), column-gutter: 10pt, row-gutter: 0.6em,
    ..elements.pos().enumerate().map(((i, x)) => (
      text(fill: accent, weight: demi-gras)[#str(i + 1).], x,
    )).flatten(),
  )
}

// ---------------------------------------------------------------------------
// Le dossier `depart\` du TD 1a, et la barre d'adresse à vérifier
//
// Relecture du 19/10/2026 : remplace le tableau des chemins de « Deux
// dossiers : depart/ et travail/ ». La fenêtre de l'explorateur sur
// `depart\`, ses six fichiers sur deux colonnes, le poème de Poe à gauche,
// celui de Burns à droite (sans les pages web, retirées du TD le même jour).
// La barre d'adresse est cerclée de la couleur `attention`, et une flèche la
// désigne : c'est elle qu'on lit avant d'ouvrir ou d'enregistrer un fichier.

#let _entree-serree(nom) = block(
  width: 100%, above: 1pt, below: 1pt, inset: (x: 5pt, y: 2.5pt),
  [#_icone-fichier #h(6pt) #text(font: police-code, size: 12pt, nom)],
)

#let schema-dossier-depart() = {
  let barre = block(
    width: 100%, stroke: 1.6pt + attention, inset: (x: 6pt, y: 4pt), radius: 2pt,
    text(font: police-code, size: 12pt,
         "C:\\Users\\eleve\\Desktop\\info01\\cours1\\1a_formats\\depart"),
  )
  let colonne(noms) = stack(..noms.map(_entree-serree))
  // Un seul `stack`, et l'espacement des blocs réduit : avec celui de la
  // diapositive, entre la barre de titre et le contenu, la fenêtre ne
  // tiendrait plus sous l'avertissement et l'annonce.
  set block(spacing: 0pt)
  let fenetre-depart = fenetre("depart", align(left, stack(
    spacing: 6pt,
    barre,
    std.grid(
      columns: (1fr, 1fr), column-gutter: 8pt,
      colonne(("raven.odt", "raven_une_ligne.donnees", "raven_une_ligne.txt")),
      colonne(("auld_lang_syne.odt", "auld_lang_syne_une_ligne.donnees",
               "auld_lang_syne_une_ligne.txt")),
    ),
  )))
  std.grid(
    columns: (1fr, 5.4cm), column-gutter: 8pt,
    fenetre-depart,
    [
      #v(20pt)
      #std.grid(
        columns: (auto, 1fr), column-gutter: 6pt, align: (horizon, horizon),
        text(size: 30pt, fill: attention)[#sym.arrow.l.long],
        text(size: 15pt, fill: attention, weight: demi-gras)[Vérifier ici le dossier ouvert],
      )
    ],
  )
}
