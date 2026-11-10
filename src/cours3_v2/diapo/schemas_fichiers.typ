// Schémas du cours 3 : le contenu d'un fichier, ses octets, la position de
// lecture et d'écriture.
//
// Séparé de `schemas.typ` : ce fichier ouvre `cetz.draw`, dont les noms
// masqueraient ceux de typst chez qui l'importerait en bloc.
//
//     #import "../schemas_fichiers.typ": schema-position-lecture

#import "../../commun/prelude.typ": *
#import "@preview/cetz:0.4.2"
#import cetz.draw: *
#import "../../cours5/diapo/schemas.typ": _disque, _memoire, _processeur, _fleche, repere

// Le début de `trace.csv`, un caractère par case ; `⏎` note le retour à la
// ligne, `…` la suite du fichier.
#let _caracteres = ("X", ",", "Y", ",", "e", "l", "e", ",", "t", "i", "m", "e", "⏎", "6", "…")
#let _case = 0.62

#let _code(x, y, texte) = content((x, y), anchor: "west", {
  set smartquote(enabled: false)
  text(size: 12pt, font: police-code)[#texte]
})

// Le thème réduit les `raw` en ligne ; ici le code garde la taille de la
// note.
#let _note(x, y, corps) = content((x, y), anchor: "west", {
  show raw: set text(size: 11.5pt)
  text(size: 12pt, fill: estompe)[#corps]
})

// Une rangée : le contenu du fichier, et la position de lecture sous la case
// `position` (0 : avant le premier caractère ; `none` : pas de position).
// Les cases d'indice `vifs` sont en couleur.
#let _rangee(x0, y, position, vifs: (), nom: "position") = {
  for (i, c) in _caracteres.enumerate() {
    let x = x0 + i * _case
    let vif = i in vifs
    rect((x, y), (x + _case, y + 0.62),
         stroke: 0.7pt + accent.lighten(40%),
         fill: if vif { attention.lighten(80%) } else { white })
    content((x + _case / 2, y + 0.31),
            text(size: 12pt, font: police-code,
                 fill: if vif { attention } else { encre })[#c])
  }
  if position != none {
    let x = x0 + position * _case
    line((x, y - 0.05), (x, y + 0.67), stroke: 2.4pt + attention)
    content((x, y - 0.3), text(size: 10.5pt, fill: attention, weight: demi-gras)[#nom])
  }
}

// Le début de `trace.csv` tel qu'un éditeur l'affiche, sur trois lignes,
// puis tel qu'il est dans le fichier, une suite de caractères où chaque fin
// de ligne est un caractère `⏎`. Dessous, deux lectures qui avancent la
// position : `readline` s'arrête après le premier `⏎`.
#let schema-position-lecture() = cetz.canvas(length: 1cm, {
  let xr = 9.6                                   // début des cases
  let fin = _caracteres.len()
  let xn = xr + fin * _case + 0.4                // début des notes

  // L'éditeur : numéros de ligne, texte, `⏎` en couleur en fin de ligne.
  let lignes = ("X,Y,ele,time", "670307.7,…", "670295.1,…")
  let (x0, y0, h) = (0.6, 4.1, 0.55)
  rect((x0, y0), (x0 + 5.6, y0 + 3 * h + 0.3), stroke: 0.7pt + estompe.lighten(40%), fill: gris.lighten(50%))
  content((x0, y0 + 3 * h + 0.55), anchor: "west", text(size: 11pt, fill: estompe)[à l'écran])
  for (k, l) in lignes.enumerate() {
    let y = y0 + 3 * h + 0.15 - (k + 0.5) * h
    content((x0 + 0.3, y), text(size: 10pt, font: police-code, fill: estompe)[#(k + 1)])
    content((x0 + 0.7, y), anchor: "west", {
      set smartquote(enabled: false)
      text(size: 12pt, font: police-code, fill: encre)[#l]
      if k < 2 { text(size: 12pt, font: police-code, fill: attention)[⏎] }
    })
  }
  let yc = y0 + (3 * h + 0.3) / 2 - 0.31
  line((x0 + 5.8, yc + 0.31), (xr - 0.2, yc + 0.31), stroke: 0.9pt + estompe, mark: (end: ">", fill: estompe))
  content((xr, yc + 1.0), anchor: "west", text(size: 11pt, fill: estompe)[dans le fichier])
  _rangee(xr, yc, none, vifs: (12,))
  _note(xn, yc + 0.31)[une suite de caractères]

  _code(0, 2.6, "f = open(chemin, encoding=\"utf-8\")")
  _rangee(xr, 2.3, 0)
  _note(xn, 2.6)[rien n'est lu]

  _code(0, 1.3, "ligne = f.readline()")
  _rangee(xr, 1.0, 13)
  _note(xn, 1.3)[la première ligne, ⏎ compris]

  _code(0, 0.0, "reste = f.read()")
  _rangee(xr, -0.3, fin, nom: "fin")
  _note(xn, 0.0)[la suite, jusqu'à la fin]
})

// La boucle `for` sur un fichier : chaque tour lit la ligne suivante, à partir
// de la position de lecture. Une case par ligne de `trace.csv`, abrégée par `…`.
#let schema-boucle-fichier() = cetz.canvas(length: 1cm, {
  let lignes = ("X,Y,ele,time⏎", "670307.7,…,79.6,…⏎", "670295.1,…,78.8,…⏎", "…")
  let xr = 5.8
  let bords = (xr,)
  for l in lignes { bords.push(bords.last() + l.clusters().len() * 0.25 + 0.45) }
  let xn = bords.last() + 0.4
  let rangee(y, lue) = {
    for (i, l) in lignes.enumerate() {
      let vif = i == lue
      rect((bords.at(i), y), (bords.at(i + 1), y + 0.62),
           stroke: 0.7pt + accent.lighten(40%),
           fill: if vif { attention.lighten(80%) } else { white })
      content(((bords.at(i) + bords.at(i + 1)) / 2, y + 0.31), {
        set smartquote(enabled: false)
        text(size: 11pt, font: police-code, fill: if vif { attention } else { encre })[#l]
      })
    }
    let x = bords.at(lue + 1)
    line((x, y - 0.05), (x, y + 0.67), stroke: 2.4pt + attention)
    content((x, y - 0.3), text(size: 10.5pt, fill: attention, weight: demi-gras)[position])
  }

  _code(0, 2.9, "f.readline()")
  rangee(2.6, 0)
  _note(xn, 2.9)[l'en-tête, ⏎ compris]

  _code(0, 1.5, "for ligne in f:")
  _note(4.1, 1.5)[tour 1]
  rangee(1.2, 1)
  _note(xn, 1.5)[`ligne` : le 1#super[er] point]

  _note(4.1, 0.1)[tour 2]
  rangee(-0.2, 2)
  _note(xn, 0.1)[`ligne` : le 2#super[e] point]
})

// --------------------------------------------
// Schémas des octets : une rangée de cases, chaque case portant un octet en
// hexadécimal ou un caractère. Une case est `(texte, largeur)` ou
// `(texte, largeur, true)` : la largeur compte en octets (`ê` en UTF-8 en
// couvre deux), `true` met la case en couleur. Les rangées d'un même schéma
// s'alignent ainsi octet par octet.
#let _octet = 0.78

#let _cases(x0, y, cases, taille: 11.5pt) = {
  let x = x0
  for c in cases {
    let l = c.at(1) * _octet
    let vif = c.len() > 2 and c.at(2)
    rect((x, y), (x + l, y + 0.62),
         stroke: 0.7pt + accent.lighten(40%),
         fill: if vif { attention.lighten(80%) } else { white })
    content((x + l / 2, y + 0.31),
            text(size: taille, font: police-code,
                 fill: if vif { attention } else { encre })[#c.at(0)])
    x += l
  }
}

// Le nom d'une rangée, calé à droite contre ses cases ; `code: true` pour
// une ligne de code, passée en chaîne.
#let _etiquette(x, y, corps, code: false) = content((x, y + 0.31), anchor: "east",
  if code {
    set smartquote(enabled: false)
    text(size: 12pt, font: police-code)[#corps]
  } else {
    show raw: set text(size: 11.5pt)
    text(size: 12pt, fill: estompe)[#corps]
  })

#let _octets-hex(liste, vifs: ()) = liste.enumerate().map(((i, o)) =>
  (o, 1, i in vifs))

// Décoder les octets de `Forêt,2 km⏎`, la première ligne de `parcours.txt` : en
// UTF-8, `c3 aa` donne `ê` ; en cp1252, chacun des deux octets donne un caractère.
#let _octets-entete = ("46", "6f", "72", "c3", "aa", "74", "2c", "32", "20", "6b", "6d")
#let _lettres-fin = (("t", 1), (",", 1), ("2", 1), (" ", 1), ("k", 1), ("m", 1))

#let schema-decodage() = cetz.canvas(length: 1cm, {
  let xr = 6.4
  let xn = xr + 12 * _octet + 0.5
  let hex = _octets-entete + ("0a",)

  _etiquette(xr - 0.3, 3.2)[octets du fichier]
  _cases(xr, 3.2, _octets-hex(hex, vifs: (3, 4)))
  _note(xn, 3.51)[12 octets]

  _etiquette(xr - 0.3, 1.6, "encoding=\"utf-8\"", code: true)
  _cases(xr, 1.6, (("F", 1), ("o", 1), ("r", 1), ("ê", 2, true)) + _lettres-fin + (("⏎", 1),))
  _note(xn, 1.91)[11 caractères : `c3 aa` donne `ê`]

  _etiquette(xr - 0.3, 0, "encoding=\"cp1252\"", code: true)
  _cases(xr, 0, (("F", 1), ("o", 1), ("r", 1), ("Ã", 1, true), ("ª", 1, true)) + _lettres-fin + (("⏎", 1),))
  _note(xn, 0.31)[12 caractères : `c3` donne `Ã`, `aa` donne `ª`]
})

// La première ligne de `parcours.txt`, écrite sous Linux et sous Windows : les fichiers diffèrent par
// la fin de ligne, le texte lu en mode texte est le même. Les cases portent des
// caractères : ce schéma vient avant la diapositive qui définit l'octet.
#let schema-fin-de-ligne() = cetz.canvas(length: 1cm, {
  let xr = 5.4
  let xn = xr + 13 * _octet + 0.5
  let lettres = ("F", "o", "r", "ê", "t", ",", "2", " ", "k", "m").map(c => (c, 1))

  _etiquette(xr - 0.3, 4.6)[Linux, macOS]
  _cases(xr, 4.6, lettres + (("\\n", 1, true), ("É", 1)))
  _note(xn, 4.91)[12 caractères]
  _etiquette(xr - 0.3, 3.8)[texte lu]
  _cases(xr, 3.8, lettres + (("\\n", 1, true), ("É", 1)))

  _etiquette(xr - 0.3, 1.9)[Windows]
  _cases(xr, 1.9, lettres + (("\\r", 1, true), ("\\n", 1, true), ("É", 1)))
  _note(xn, 2.21)[13 caractères]
  _etiquette(xr - 0.3, 1.1)[texte lu]
  _cases(xr, 1.1, lettres + (("\\n", 2, true), ("É", 1)))

  _note(xr, 0.4)[dans les deux cas, la chaîne `'Forêt,2 km\nÉ'`]
})

// Le fichier de Windows ouvert en `"rb"` : la position compte des octets,
// et `read` renvoie des `bytes`.
#let schema-position-octets() = cetz.canvas(length: 1cm, {
  let xr = 7.4
  let hex = _octets-entete + ("0d", "0a")
  let n = hex.len()
  let xn = xr + (n + 1) * _octet + 0.4
  let rangee(y, position, nom: none) = {
    _cases(xr, y, _octets-hex(hex) + (("…", 1),))
    let x = xr + position * _octet
    line((x, y - 0.05), (x, y + 0.67), stroke: 2.4pt + attention)
    content((x, y - 0.3), text(size: 10.5pt, fill: attention, weight: demi-gras)[#if nom == none [position #position] else [#nom]])
  }

  _code(0, 5.0, "f = open(chemin, \"rb\")")
  rangee(4.7, 0)
  _note(xn, 5.0)[pas d'`encoding`]

  _code(0, 3.4, "debut = f.read(3)")
  rangee(3.1, 3)
  _note(xn, 3.4)[`b'For'` : 3 octets]

  _code(0, 1.8, "suite = f.read(2)")
  rangee(1.5, 5)
  _note(xn, 1.8)[`b'\xc3\xaa'` : les octets de `ê`]

  _code(0, 0.2, "reste = f.read()")
  rangee(-0.1, n + 1, nom: "fin")
  _note(xn, 0.2)[jusqu'à la fin : `b't,2 km\r\n…'`]
})

// Les modes `"w"` et `"a"` sur un fichier qui contient `un⏎` : le contenu
// après l'ouverture, puis après `write`, et la position d'écriture.
#let schema-modes-ecriture() = cetz.canvas(length: 1cm, {
  let xr = 11.3
  let xn = xr + 8 * _case + 0.5
  let un = (("u", 1), ("n", 1), ("⏎", 1))
  let deux = (("d", 1, true), ("e", 1, true), ("u", 1, true), ("x", 1, true), ("⏎", 1, true))
  let cases(y, liste) = {
    let x = xr
    for c in liste {
      let vif = c.len() > 2 and c.at(2)
      rect((x, y), (x + _case, y + 0.62), stroke: 0.7pt + accent.lighten(40%),
           fill: if vif { attention.lighten(80%) } else { white })
      content((x + _case / 2, y + 0.31),
              text(size: 12pt, font: police-code, fill: encre)[#c.at(0)])
      x += _case
    }
  }
  let position(y, n) = {
    let x = xr + n * _case
    line((x, y - 0.05), (x, y + 0.67), stroke: 2.4pt + attention)
  }
  let code(y, texte) = content((0, y + 0.31), anchor: "west", {
    set smartquote(enabled: false)
    text(size: 11pt, font: police-code)[#texte]
  })

  _etiquette(xr - 0.3, 6.2)[`essai.txt` avant]
  cases(6.2, un)

  code(4.5, "with open(essai, \"w\", encoding=\"utf-8\") as f:")
  content((xr + 0.2, 4.81), anchor: "west", text(size: 12pt, fill: estompe)[(vide)])
  position(4.5, 0)
  _note(xn, 4.81)[vidé à l'ouverture]
  code(3.6, "    f.write(\"deux\\n\")")
  cases(3.6, deux)
  position(3.6, 5)
  _note(xn, 3.91)[écrit depuis le début]

  code(1.6, "with open(essai, \"a\", encoding=\"utf-8\") as f:")
  cases(1.6, un)
  position(1.6, 3)
  _note(xn, 1.91)[conservé]
  code(0.7, "    f.write(\"deux\\n\")")
  cases(0.7, un + deux)
  position(0.7, 8)
  _note(xn, 1.01)[écrit à la fin]
})

// ---------------------------------------------------------------------------
// La lecture d'un fichier, du disque au processeur (04/11/2026, repris le 05/11)
//
// Trois composants, et ce que chacun contient au fil de deux lignes de code :
// 1. `f.read()` copie le fichier du disque vers la mémoire vive ;
// 2. pour `upper`, le processeur copie `texte` dans son cache, puis ses registres ;
// 3. le résultat est écrit en mémoire vive, sous un autre nom.
//
// Le disque, la mémoire vive et le processeur sont les dessins de « Les
// composants d'un ordinateur », au cours 1 v2. Les temps d'accès sont ceux de
// « Hiérarchie des mémoires ».
#let schema-lecture-memoire() = cetz.canvas(length: 1cm, {
  let (bas, haut) = (0.3, 4.55)
  let (r1, r2) = (2.35, 0.95)                    // les deux rangées de contenus
  let largeur = 4.4
  let (xd, xm, xp) = (0, 9.4, 20.6)              // bord gauche des composants
  let demi = 1.7                                 // demi-largeur d'un contenu

  let composant(x0, nom, note) = {
    rect((x0, bas), (x0 + largeur, haut), radius: 0.12,
         stroke: 0.9pt + accent.lighten(30%), fill: gris.lighten(72%))
    content((x0 + largeur / 2, haut + 0.38), text(size: 15pt, weight: demi-gras, fill: accent)[#nom])
    content((x0 + largeur / 2, bas - 0.32), text(size: 12pt, fill: estompe)[#note])
  }
  // Le dessin d'un composant, réduit pour laisser la place aux contenus.
  let dessin(x, trace) = group({
    set-origin((x, 3.6))
    scale(0.55)
    trace
  })
  // Un contenu : un fichier ou une variable en code, une mémoire en texte.
  let contenu(cx, y, corps, code: true, vif: false) = {
    rect((cx - demi, y - 0.36), (cx + demi, y + 0.36), radius: 0.06,
         stroke: 0.9pt + accent, fill: if vif { attention.lighten(80%) } else { white })
    content((cx, y), if code {
      text(size: 12pt, font: police-code, fill: if vif { attention } else { encre })[#corps]
    } else {
      text(size: 13pt, fill: encre)[#corps]
    })
  }
  // Le numéro sur la flèche, le code au-dessus, le temps dessous.
  let etape(n, a, b, code: none, dessous: none) = {
    _fleche(a, b)
    let (mx, my) = ((a.at(0) + b.at(0)) / 2, a.at(1))
    content((mx, my), repere(n, taille: 17pt))
    if code != none {
      content((mx, my + 0.58), {
        set smartquote(enabled: false)
        text(size: 11.5pt, font: police-code, fill: accent)[#code]
      })
    }
    if dessous != none { content((mx, my - 0.54), text(size: 12.5pt, fill: estompe)[#dessous]) }
  }

  composant(xd, [Disque], [conservé à l'extinction])
  composant(xm, [Mémoire vive], [effacé à la fin du programme])
  composant(xp, [Processeur], [mémoires du processeur])

  let (cd, cm, cp) = (xd + largeur / 2, xm + largeur / 2, xp + largeur / 2)
  dessin(cd, _disque(0, 0))
  dessin(cm, _memoire(0, 0))
  dessin(cp, _processeur(0, 0))

  contenu(cd, r1, "trace.csv")
  contenu(cm, r1, "texte")
  contenu(cm, r2, "majuscules", vif: true)
  contenu(cp, r1, [cache], code: false)
  contenu(cp, r2, [registres], code: false)

  etape(1, (cd + demi, r1), (cm - demi, r1), code: "texte = f.read()", dessous: [accès : 0,1 à 10 ms])
  etape(2, (cm + demi, r1), (cp - demi, r1), code: "majuscules = texte.upper()", dessous: [accès : 100 ns])
  _fleche((cp, r1 - 0.36), (cp, r2 + 0.36))
  etape(3, (cp - demi, r2), (cm + demi, r2), dessous: [résultat écrit en mémoire vive])
})

// ---------------------------------------------------------------------------
// CR et LF sur une feuille, puis sur une machine à écrire.

#let _fleche-cr-lf(a, b) = line(a, b, stroke: 1.8pt + attention,
  mark: (end: ">", fill: attention, scale: 1.1))

#let _sigle(position, sigle) = content(position,
  text(size: 16pt, weight: "bold", fill: attention)[#sigle])

// Une feuille A4 lignée, avec les deux premières lignes de `parcours.txt`. Au
// bout de la première ligne, CR ramène le point de frappe à la marge. LF, à droite
// de la feuille, la fait avancer d'une ligne, comme la molette de la machine.
#let schema-page-cr-lf() = cetz.canvas(length: 1cm, {
  let l = 5.3
  let h = l * 1.414
  let marge = 1.2
  rect((0, 0), (l, h), stroke: 0.8pt + accent.lighten(40%), fill: white)
  for i in range(9) {
    let y = h - 1.1 - i * 0.7
    line((0.15, y), (l - 0.15, y), stroke: 0.5pt + attention.lighten(75%))
  }
  line((marge, 0.15), (marge, h - 0.15), stroke: 0.6pt + estompe.lighten(40%))

  let y1 = h - 1.8
  let y2 = y1 - 1.4
  let ecrire(y, texte) = content((marge + 0.15, y + 0.06), anchor: "south-west",
    text(size: 13pt, font: police-code)[#texte])
  ecrire(y1, "Forêt,2 km")
  ecrire(y2, "École,640 m")

  let fin = 4.25
  let yc = y1 + 0.8
  line((fin, y1 + 0.05), (fin, y1 + 0.55), stroke: 2pt + attention)
  _fleche-cr-lf((fin, yc), (0.95, yc))
  _sigle((2.7, yc + 0.4), "CR")
  _fleche-cr-lf((l + 0.35, y1 + 0.25), (l + 0.35, y2 + 0.25))
  _sigle((l + 0.9, (y1 + y2) / 2 + 0.25), "LF")
})

// Une machine à écrire mécanique, de face : le levier de retour du chariot à
// gauche (CR), la molette du rouleau à droite (LF).
#let schema-machine-a-ecrire() = cetz.canvas(length: 1cm, {
  let trait = 0.9pt + accent
  let legende(position, ancre, cote, sigle, texte) = content(position, anchor: ancre,
    box(width: 4.8cm, align(cote)[
      #set par(leading: 0.4em)
      #text(size: 16pt, weight: "bold", fill: attention)[#sigle] \
      #text(size: 12pt, fill: estompe)[#texte]
    ]))

  // Corps et clavier.
  line((1.5, 0), (13.5, 0), (12.7, 2.5), (2.3, 2.5), close: true,
       fill: accent.lighten(88%), stroke: trait)
  for (n, y) in ((12, 0.75), (11, 1.35), (10, 1.95)) {
    for k in range(n) {
      circle((7.5 - (n - 1) * 0.31 + k * 0.62, y), radius: 0.19,
             fill: white, stroke: 0.7pt + accent)
    }
  }
  rect((5.6, 0.2), (9.4, 0.42), radius: 0.1, fill: white, stroke: 0.7pt + accent)

  // Feuille, puis rouleau devant elle.
  rect((5.2, 3.0), (9.8, 7.3), fill: white, stroke: 0.8pt + accent.lighten(40%))
  content((5.6, 3.48), anchor: "south-west", text(size: 12pt, font: police-code)[Forêt,2 km])
  rect((1.8, 2.7), (13.2, 3.4), radius: 0.3, fill: accent.lighten(60%), stroke: trait)

  // Levier, à gauche.
  line((1.95, 3.25), (1.1, 3.95), stroke: 3pt + accent)
  rect((0.35, 3.85), (1.3, 4.15), radius: 0.12, fill: accent, stroke: none)
  _fleche-cr-lf((0.25, 4.6), (1.5, 4.6))
  legende((0, 7.3), "north-west", left, "CR", [le levier ramène le chariot en début de ligne])

  // Molette, à droite.
  circle((13.75, 3.05), radius: 0.48, fill: accent.lighten(30%), stroke: trait)
  arc((13.75, 3.05), start: 160deg, stop: 20deg, radius: 0.85, anchor: "origin",
      stroke: 1.8pt + attention, mark: (end: ">", fill: attention, scale: 1.1))
  legende((15.0, 7.3), "north-east", right, "LF", [la molette fait tourner le rouleau d'une ligne])
})
