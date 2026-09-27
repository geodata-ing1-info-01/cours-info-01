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
#import "../../cours5/diapo/schemas.typ": _etiquette, _ecran, _portable, _boitier-reseau, _nuage, _serveur

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
// `std.rect` dans ce fichier. La fenêtre montre le dossier `depart/` du TD 2a,
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
         text(font: police-code, size: 13pt)[…\\2a_terminal\\depart])
  #block(width: 55%)[
    #_entree("raven.odt", choisie: true)
    #_entree("raven_brut.html")
    #_entree("style.css")
  ]
  #place(top + right, dx: -4pt, dy: 26pt,
         _menu("Ouvrir", "Couper", "Copier", "Renommer", choisi: 2))
]

// La même copie dans Git Bash. L'invite est en petit et estompée, la commande
// en grand : c'est elle que la diapositive compare au menu.
#let git-bash-copie() = fenetre("Git Bash", code: true)[
  #let invite = text(size: 12.5pt, fill: estompe, raw("eleve@POSTE-12 MINGW64 ~/Desktop/info01/cours1/2a_terminal"))
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
// `depart/` du TD 2a, telle que le guide du TD la montre. Une ligne par
// `raw`, pour estomper l'invite.
#let _invite-2a = "eleve@POSTE-12 MINGW64 ~/Desktop/info01/cours1/2a_terminal"

#let git-bash-ls() = fenetre("Git Bash", code: true)[
  #set par(leading: 0.45em)
  #let lignes = (
    (estompe, _invite-2a),
    (accent, "$ ls depart"),
    (accent, "auld_lang_syne.odt                raven_brut.html"),
    (accent, "auld_lang_syne_brut.html          raven_style.html"),
    (accent, "auld_lang_syne_style.html         raven_une_ligne.donnees"),
    (accent, "auld_lang_syne_une_ligne.donnees  raven_une_ligne.txt"),
    (accent, "auld_lang_syne_une_ligne.txt      style.css"),
    (accent, "raven.odt"),
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
    columns: (1fr, auto, 1.5fr, auto, 1fr),
    column-gutter: 8pt, row-gutter: 6pt,
    align: (center + horizon),
    explorateur([…\\depart], ("raven.odt", "raven_brut.html", "style.css"), choisi: 0, titre: "depart"),
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
