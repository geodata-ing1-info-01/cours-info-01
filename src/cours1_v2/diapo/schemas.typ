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
#import "../../cours5/diapo/schemas.typ": _etiquette, _fleche, _ecran, _clavier, _disque, _portable, _boitier-reseau, _nuage, _serveur, _cadenas

// ---------------------------------------------------------------------------
// Exécution de programmes et stockage de données
//
// 05/11/2026 : les deux fonctions de l'ordinateur sont nommées sur le schéma, en tête
// de chaque cadre. Le cadre du disque monte pour porter son titre.
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
  rect((5.3, 0), (18.1, 8.2), radius: 0.15, stroke: 1.6pt + accent)
  _etiquette((11.7, -0.1), "Votre ordinateur", none, largeur: 5cm)
  rect((5.9, 4.3), (17.5, 7.9), fill: accent.lighten(88%),
       stroke: 1pt + accent.lighten(40%))
  content((11.7, 7.75), anchor: "north",
          text(size: 17pt, weight: demi-gras, fill: accent)[Exécution de programmes])
  _icone-tableur(8.4, 6.0)
  _etiquette((8.4, 5.05), "LibreOffice", none, largeur: 3.2cm)
  _icone-navigateur(11.7, 6.0)
  _etiquette((11.7, 5.05), "Navigateur", none, largeur: 3.2cm)
  _icone-script(15.0, 6.0)
  _etiquette((15.0, 5.05), "Votre script", none, largeur: 3.2cm)

  // les flux, échangés avec les périphériques
  _clavier(2.3, 6.0)
  _etiquette((2.3, 5.35), "Clavier, souris", none, largeur: 3.8cm)
  _fleche((3.95, 6.0), (5.85, 6.0))
  action((4.6, 6.2), "flux")

  _ecran(23.4, 5.45)
  _etiquette((23.4, 4.7), "Écran, son", none, largeur: 3.8cm)
  _fleche((17.55, 6.0), (21.9, 6.0))
  action((19.7, 6.2), "flux")

  // le disque, et les fichiers qu'il conserve
  rect((6.7, 0.25), (16.1, 3.15), radius: 0.1, fill: gris.lighten(50%),
       stroke: 1pt + accent.lighten(40%))
  content((11.7, 3.05), anchor: "north",
          text(size: 17pt, weight: demi-gras, fill: accent)[Stockage de données])
  _disque(11.7, 1.75)
  _etiquette((11.7, 0.95), "Disque", none, largeur: 2.4cm)
  _fichier(8.4, 1.75, "releve.csv")
  _fichier(15.0, 1.75, "carte.png")

  _fleche((8.4, 2.4), (8.4, 4.25))
  action((8.2, 3.72), "ouvrir", anchor: "east")
  _fleche((15.0, 4.25), (15.0, 2.4))
  action((15.2, 3.72), "enregistrer", anchor: "west")

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
// Les couches de logiciels, du matériel aux applications web
//
// 05/11/2026 : la pile de « Couches matérielles et logicielles », complétée pour répondre
// à la question posée sur cette diapositive. Le navigateur est un programme : la
// couche des programmes est coupée en deux, et les applications web sont posées sur le
// navigateur seul. Les pilotes sont la partie basse du système : dans son cadre, juste
// au-dessus du matériel (OSTEP, chap. 36 : « At the lowest level, a piece of software in
// the OS must know in detail how a device works. »).

#let _case-programmes(icone, titre, exemples) = std.grid.cell(
  fill: accent.lighten(90%), stroke: 1pt + accent.lighten(35%), inset: (x: 14pt, y: 5pt),
  std.grid(
    columns: (34pt, 1fr), column-gutter: 14pt, align: left + horizon,
    icone,
    [
      #text(size: 19pt, weight: "semibold")[#titre]
      #linebreak()
      #text(size: 14pt, fill: estompe)[#exemples]
    ],
  ),
)

#let schema-couches-logiciels() = stack(
  dir: ttb, spacing: 5pt,
  std.grid(
    columns: (1fr, 1fr),
    [],
    _case-programmes(icone-fenetre(taille: 26pt), "Applications web", [webapp : Géoportail, Google Docs]),
    _case-programmes(icone-fenetre(taille: 26pt), "Programmes", [application, app : LibreOffice, votre script]),
    _case-programmes(
      cetz.canvas(length: 0.55cm, { _icone-navigateur(0, 0) }),
      "Navigateur", [Firefox, Chrome],
    ),
  ),
  liaison("« ouvre releve.csv »", "le contenu"),
  stack(
    dir: ttb,
    couche(icone-engrenage(taille: 26pt), "Système d'exploitation", [OS : Windows, macOS, Linux, Android, iOS]),
    couche([], "Pilotes", [driver : carte graphique, imprimante, carte réseau]),
  ),
  liaison("« écris ces octets »", "les octets lus sur le disque"),
  couche(icone-puce(taille: 26pt), "Matériel", "processeur, mémoire, disque, réseau"),
)

// ---------------------------------------------------------------------------
// Les emplacements de stockage sur le réseau
//
// À gauche, le réseau local de l'école, dans un cadre : les postes de la
// salle, chacun avec son boîtier, le commutateur, le serveur de fichiers, le
// proxy. Le routeur est sur le bord du cadre. À droite, hors du cadre :
// Internet, les serveurs du stockage en ligne, et l'ordinateur de l'élève
// chez lui, qui n'atteint que ces derniers.
//
// Relecture du 19/10/2026 : reprend « Reconnaître un emplacement réseau à
// son chemin », retirée. Deux dossiers, en bas du cadre, renvoient chacun à
// l'endroit où il est enregistré : le Bureau au boîtier d'un poste,
// `formationTemp` au serveur ; leur chemin est écrit dessous. Le proxy, sur
// le chemin vers Internet, porte un cadenas : il demande un identifiant et
// un mot de passe.

// Un poste de la salle : l'écran du cours 5, réduit pour en aligner trois,
// et son boîtier à droite, où est le disque.
#let _poste(x, y) = {
  group({
    translate((x, y))
    scale(0.75)
    _ecran(0, 0)
  })
  let bx = x + 1.35
  rect((bx - 0.3, y - 0.42), (bx + 0.3, y + 1.0), radius: 0.05, fill: white,
       stroke: 1.2pt + accent)
  line((bx - 0.18, y + 0.75), (bx + 0.18, y + 0.75), stroke: 0.8pt + accent)
  line((bx - 0.18, y + 0.6), (bx + 0.18, y + 0.6), stroke: 0.8pt + accent)
  circle((bx, y - 0.15), radius: 0.07, fill: accent, stroke: none)
}

// Un dossier : son nom, et le chemin que l'explorateur affiche.
#let _dossier(pos, nom, chemin) = content(pos, anchor: "north", box(
  fill: white, stroke: 1.2pt + attention, radius: 3pt, inset: (x: 7pt, y: 5pt),
  align(center)[
    #text(size: 15pt, weight: demi-gras, fill: attention)[#nom] \
    #text(size: 15pt)[#raw(chemin)]
  ],
))

#let schema-stockage-reseau() = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + accent.lighten(45%))
  let lien = 1.4pt + accent
  let renvoi = (end: ">", fill: attention, scale: 1.1)
  let y-reseau = 6.6

  // le réseau local de l'école
  rect((0, 0.4), (17.2, 8.9), radius: 0.2, fill: gris.lighten(55%),
       stroke: (paint: accent, thickness: 1.2pt, dash: "dashed"))
  content((0.35, 8.6), anchor: "north-west",
          text(size: 14pt, weight: demi-gras, fill: accent)[#petites-capitales[réseau local de l'école]])

  // les postes de la salle, chacun avec son boîtier, reliés au commutateur
  for x in (1.4, 4.4, 7.4) {
    line((x, 5.35), (4.4, y-reseau - 0.35), stroke: lien)
    _poste(x, 4.1)
  }
  _etiquette((4.4, 3.2), "Les postes de la salle", none, largeur: 6.2cm)

  _boitier-reseau(4.4, y-reseau)
  _etiquette((4.4, y-reseau + 0.5), "Le commutateur", none, largeur: 5cm, anchor: "south")

  // le serveur de fichiers de l'école
  line((5.5, y-reseau), (16.4, y-reseau), stroke: lien)
  line((11.0, y-reseau), (11.0, 5.4), stroke: lien)
  _serveur(11.0, 4.1)
  _etiquette((11.0, 2.65), [Le serveur de l'école], none, largeur: 4.6cm)

  // le proxy : la sortie vers Internet, avec un mot de passe
  rect((13.2, y-reseau - 0.4), (14.8, y-reseau + 0.4), radius: 0.06, fill: white,
       stroke: 1.4pt + accent)
  _cadenas(14.0, y-reseau, accent, echelle: 0.28)
  _etiquette((14.0, y-reseau - 0.55), "Le proxy", [mot de passe],
             largeur: 3.2cm)

  // le routeur, au bord du réseau local
  _boitier-reseau(17.2, y-reseau, l: 1.6, voyants: 3)
  _etiquette((17.2, y-reseau + 0.5), "Le routeur", none, largeur: 3cm, anchor: "south")

  // les deux dossiers, et le disque où chacun est enregistré
  _dossier((4.4, 2.35), "Bureau", "C:\\Users\\eleve\\Desktop")
  line((6.65, 1.65), (8.75, 1.65), (8.75, 3.6), stroke: 1.4pt + attention, mark: renvoi)
  _dossier((14.6, 4.35), "formationTemp", "\\\\serveur\\formationTemp")
  line((12.35, 3.7), (11.95, 3.7), stroke: 1.4pt + attention, mark: renvoi)

  // Internet, le stockage en ligne, l'ordinateur chez soi
  line((18.0, y-reseau), (18.8, y-reseau), stroke: lien)
  _nuage(20.4, y-reseau)
  content((20.4, y-reseau), text(size: 16pt, weight: demi-gras, fill: accent)[Internet])

  line((22.3, y-reseau), (23.8, y-reseau), stroke: lien)
  _serveur(24.7, y-reseau + 0.4)
  _etiquette((24.7, y-reseau - 1.05), "Le stockage en ligne",
             "Google Drive, OneDrive, Dropbox, Nextcloud", largeur: 4.6cm)

  line((20.4, y-reseau - 0.95), (20.4, 3.0), stroke: lien)
  _portable(20.4, 1.6)
  _etiquette((20.4, 1.15), "Chez vous", "votre ordinateur", largeur: 4cm)
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
// La fenêtre de Git Bash juste ouverte dans un dossier de TD, ce que
// l'élève doit voir (relecture du 19/10/2026) : au TD 1b, dans
// `1b_terminal`, sans ligne `(base)` ; au TD 1c, après le réglage de
// conda, avec. Couleurs de l'invite réelle, assombries pour le fond blanc,
// comme sur « L'invite de Git Bash » ; le dossier courant, à vérifier, est
// encadré, et la ligne `(base)` aussi quand elle est demandée.
#let git-bash-ouvert(dossier: "1b_terminal", base: false, taille: 15pt) = {
  // La barre de titre de `fenetre` (theme.typ), recopiée : le corps de
  // `fenetre` commence par une ligne vide, qui ferait déborder les
  // diapositives où cette fenêtre suit une liste de consignes.
  let cadre(corps) = box(
    stroke: 1.5pt + attention, inset: (x: 3pt, y: 2pt), outset: (y: 2pt), radius: 2pt, corps,
  )
  let lignes = {
    set align(left)
    set text(font: police-code, size: taille)
    set par(leading: 0.85em)
    if base { cadre("(base)"); linebreak() }
    text(fill: rgb("#1a7f37"), "eleve@POSTE-12")
    " "
    text(fill: rgb("#a2248f"), "MINGW64")
    " "
    cadre(text(fill: rgb("#9a6700"), "~/Desktop/info01/cours1/" + dossier))
    linebreak()
    [\$ #box(width: 0.6em, height: 0.95em, fill: estompe)]
  }
  block(width: 100%, stroke: 1pt + accent.lighten(55%), clip: true, {
    block(width: 100%, fill: gris, inset: (x: 9pt, y: 6pt), below: 0pt, std.grid(
      columns: (auto, 1fr), column-gutter: 9pt, align: horizon,
      box(height: 8pt, {
        for i in range(3) {
          place(horizon + left, dx: i * 11pt, std.circle(radius: 3.5pt, stroke: 0.8pt + estompe))
        }
        h(29pt)
      }),
      text(size: 13pt, fill: estompe, "MINGW64:/c/Users/eleve/Desktop/info01/cours1/" + dossier),
    ))
    block(width: 100%, inset: (x: 10pt, y: 9pt), above: 0pt, lignes)
  })
}

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

// Le dossier d'Anaconda dans l'explorateur, au TD 1c : `C:\ProgramData` est
// masqué, d'où le chemin tapé dans la barre d'adresse ; `python.exe`, le
// fichier de l'interpréteur, est surligné.
#let explorateur-anaconda() = explorateur(
  [C:\\ProgramData\\anaconda3], ("python.exe", "pythonw.exe", "python3.dll"),
  choisi: 0, titre: "anaconda3",
)

// Les mêmes trois fenêtres, l'une sous l'autre, pour une colonne à droite
// des consignes (relecture du 19/10/2026).
#let schema-exports-vertical() = {
  let fleche(corps) = align(center, stack(
    dir: ltr, spacing: 8pt,
    text(size: 22pt, fill: accent)[↓],
    align(horizon, text(size: 12pt, fill: estompe)[#corps]),
  ))
  stack(
    dir: ttb, spacing: 4pt,
    explorateur([…\\depart], ("raven.odt", "raven_une_ligne.txt"), choisi: 0, titre: "depart"),
    fleche[double-clic],
    writer-exports(),
    fleche[exports],
    explorateur([…\\travail], ("raven.pdf", "raven.png"), titre: "travail"),
  )
}

// ---------------------------------------------------------------------------
// Une fenêtre de terminal, une ligne par `raw`
//
// Les lignes d'invite (`eleve@…`) sont estompées, les commandes et les
// sorties à la taille du texte. `raw` est à 0,78 em du texte qui l'entoure :
// `taille` est donc celle du texte, pas celle du code affiché.
#let terminal(titre: "Git Bash", taille: 19pt, ..lignes) = {
  // Sans cet espacement, le corps de `fenetre` commence par une ligne vide.
  set block(spacing: 0pt)
  fenetre(titre, code: true)[
    #set par(leading: 0.45em)
    #for ligne in lignes.pos() [
      #text(size: taille, fill: if ligne.starts-with("eleve@") { estompe } else { accent }, raw(ligne)) \
    ]
  ]
}

// Les commandes d'une étape de TD, dans une fenêtre de terminal
//
// 05/11/2026 : au TD 1b, les commandes à taper sortent des phrases de consignes.
// Chaque numéro renvoie à la consigne de même numéro ; plusieurs commandes se
// suivent sous un seul numéro, et `numero:` saute les consignes sans commande.
// `constat` s'affiche sous ses commandes, dans le
// corrigé seulement (STYLE.md, « TD et corrigé »).
//
//   #terminal-etapes(
//     etape-terminal("pwd"),
//     etape-terminal("cd depart", "pwd", constat: [L'invite montre `depart`.]),
//   )
#let etape-terminal(..commandes, constat: none, numero: none) = (
  commandes: commandes.pos(), constat: constat, numero: numero,
)

#let terminal-etapes(titre: "Git Bash", taille: 19pt, ..etapes) = {
  // Sans cet espacement, le corps de `fenetre` commence par une ligne vide.
  set block(spacing: 0pt)
  fenetre(titre, code: true, std.grid(
    columns: (auto, 1fr), column-gutter: 10pt, row-gutter: 9pt, align: left,
    ..etapes.pos().enumerate().map(((i, e)) => (
      text(size: taille * 0.78, fill: estompe, str(if e.numero != none { e.numero } else { i + 1 })),
      stack(
        dir: ttb, spacing: 6pt,
        ..e.commandes.map(c => text(size: taille, raw("$ " + c))),
        ..if e.constat != none and corrige-visible {
          (text(font: police-texte, size: taille * 0.75, fill: attention, e.constat),)
        },
      ),
    )).flatten(),
  ))
}

// ---------------------------------------------------------------------------
// Trois lignes, et le moment où chacune est traduite
//
// 05/11/2026, refait après relecture : un programme de trois lignes, une opération
// par ligne, et non une boucle que l'élève n'a pas vue à ce moment de la séance.
// Le gris marque la traduction, le bleu l'exécution par le processeur. Les deux
// colonnes viennent de « Compile Time V.S. Run Time » (Stanford CS106L). La largeur
// des cases ne suit aucune échelle.

#let _bleu-execution = attention.lighten(72%)

#let _case-traduction(corps, largeur: auto) = box(
  width: largeur, height: 40pt, fill: gris, stroke: 0.8pt + estompe.lighten(30%),
  inset: (x: 5pt), align(center + horizon, text(size: 13pt, corps)),
)

#let _case-execution(corps, hauteur: 40pt) = box(
  height: hauteur, fill: _bleu-execution, stroke: 0.8pt + attention,
  inset: (x: 6pt), align(center + horizon, text(size: 13pt, corps)),
)

#let _resultat-traduction = box(height: 40pt, inset: (left: 6pt), align(
  horizon, text(size: 15pt, weight: demi-gras, "129.0"),
))

#let programme-trois-lignes() = block(
  width: 100%, fill: gris.lighten(45%), inset: (x: 12pt, y: 7pt),
)[
  #set block(spacing: 6pt)
  #text(size: 14pt, weight: demi-gras, fill: estompe)[Un programme de trois lignes, en Python]
  #std.grid(
    columns: (auto, auto, auto), column-gutter: 14pt, row-gutter: 3pt, align: left + horizon,
    text(size: 14pt, fill: estompe, "1"), text(size: 18pt, raw("total = 128.4 + 131.0 + 127.6")), _case-execution(hauteur: 22pt)[additionne],
    text(size: 14pt, fill: estompe, "2"), text(size: 18pt, raw("moyenne = total / 3")), _case-execution(hauteur: 22pt)[divise],
    text(size: 14pt, fill: estompe, "3"), text(size: 18pt, raw("print(moyenne)")), _case-execution(hauteur: 22pt)[affiche],
  )
]

#let schema-moment-traduction() = {
  let colonne(corps) = text(size: 14pt, weight: demi-gras, fill: estompe, corps)
  let ligne(numero) = _case-traduction[traduit \ ligne #numero]
  std.grid(
    columns: (auto, 165pt, 1fr), column-gutter: 12pt, row-gutter: 8pt, align: left + horizon,
    stroke: (x, y) => if x == 2 {
      (left: (paint: accent.lighten(30%), thickness: 1pt, dash: "dashed"))
    },
    inset: (x, y) => if x == 2 { (left: 10pt) } else { 0pt },
    [],
    colonne[Avant le lancement],
    colonne[Pendant l'exécution #sym.arrow.r],

    [#text(size: 17pt, weight: demi-gras)[Compilateur] \ #text(size: 13pt, fill: estompe)[le même programme, en C++]],
    _case-traduction(largeur: 100%)[traduit les lignes 1, 2, 3, enregistre l'exécutable],
    stack(
      dir: ltr, spacing: 3pt,
      _case-execution[additionne], _case-execution[divise], _case-execution[affiche],
      _resultat-traduction,
    ),

    [#text(size: 17pt, weight: demi-gras)[Interpréteur] \ #text(size: 13pt, fill: estompe)[Python]],
    text(size: 13pt, fill: estompe)[aucune étape],
    stack(
      dir: ltr, spacing: 2pt,
      ligne(1), _case-execution[additionne], h(3pt),
      ligne(2), _case-execution[divise], h(3pt),
      ligne(3), _case-execution[affiche],
      _resultat-traduction,
    ),
  )
}

// ---------------------------------------------------------------------------
// Modifier un programme, puis le relancer
//
// 05/11/2026 : reprend la chaîne de l'ancienne « Exécution d'un programme Python »
// (`chaine-terminal`), à l'horizontale, à côté de celle d'un programme compilé. La
// colonne « Compiler » reste vide pour Python : l'étape en moins se voit.

#let schema-modifier-relancer() = {
  let colonne(corps) = align(center, text(size: 14pt, weight: demi-gras, fill: estompe, corps))
  let f = align(center + horizon, text(size: 20pt, fill: accent, sym.arrow.r))
  let code(corps) = text(size: 14pt, raw(corps))
  std.grid(
    columns: (auto, 0.75fr, 18pt, 1.5fr, 18pt, 1fr),
    column-gutter: 3pt, row-gutter: 5pt, align: left + horizon,
    [], colonne[Modifier, enregistrer], [], colonne[Compiler], [], colonne[Lancer],

    text(size: 15pt, weight: demi-gras)[Compilé : \ C++],
    etape("Notepad++", code("altitudes.cpp"), hauteur: 48pt), f,
    etape("Le compilateur", code("g++ altitudes.cpp -o altitudes.exe"), hauteur: 48pt), f,
    etape("Le programme", code("./altitudes.exe"), hauteur: 48pt),

    text(size: 15pt, weight: demi-gras)[Interprété : \ Python],
    etape("Notepad++", code("altitudes.py"), hauteur: 48pt), f,
    align(center + horizon, text(size: 13pt, fill: estompe)[aucune étape]), f,
    etape("L'interpréteur", code("python altitudes.py"), hauteur: 48pt),
  )
}

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
  // Les commandes à taper sont le contenu principal : le code passe de 0,78
  // à 0,9 fois la taille du texte (0,78 × 1,15).
  show raw: set text(size: 1.15em)
  std.grid(
    columns: (auto, 1fr), column-gutter: 10pt, row-gutter: 0.6em,
    ..elements.pos().enumerate().map(((i, x)) => (
      text(fill: accent, weight: demi-gras)[#str(i + 1).], x,
    )).flatten(),
  )
}

// La manière de faire une consigne, en gris : la tâche reste en noir et se
// lit d'un coup d'œil, la manière se lit au moment de la faire (relecture
// du 19/10/2026).
//
//   #consignes([Copier `info01-cours1.zip` : #comment[clic droit, Copier.]])
#let comment(corps) = text(fill: estompe)[#corps]

// Les opérations d'une consigne, lettrées a, b… sous la tâche, en gris.
//
//   #consignes([Exporter en PDF. #sous-etapes([Menu Fichier…], [Enregistrer.])])
#let sous-etapes(..elements) = block(above: 4pt, below: 2pt, {
  set text(fill: estompe)
  std.grid(
    columns: (auto, 1fr), column-gutter: 8pt, row-gutter: 0.4em,
    ..elements.pos().enumerate().map(((i, x)) => (
      [#"abcdefgh".at(i).], x,
    )).flatten(),
  )
})

// Plusieurs commandes à taper l'une après l'autre, sous une consigne.
//
//   #consignes([Copier, puis ouvrir : #commandes("cp a b", "start b")])
#let commandes(..lignes) = block(above: 5pt, below: 2pt, stack(
  dir: ttb, spacing: 5pt,
  ..lignes.pos().map(l => raw(l)),
))

// Ce qu'une consigne fait constater, écrit sous elle : affiché dans le
// corrigé seulement, comme une colonne `reponse` (STYLE.md, « TD et
// corrigé »). Hors du corrigé, rien ne s'affiche et la consigne garde sa
// hauteur.
//
//   #consignes([Lister `depart` : `ls depart`. #constat[les fichiers des deux textes]])
#let constat(corps) = reponse(block(
  // Mesuré depuis la ligne de base du texte au-dessus : à moins, ses jambages touchent.
  above: 4.5pt, below: 0pt,
  text(size: 0.85em, fill: attention)[#corps],
))

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
