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
#import "../../cours5/diapo/schemas.typ": _disque, _memoire, _processeur, _fleche, _etiquette as _etiquette-composant

// Le début de `trace.csv`, un caractère par case ; `⏎` note le retour à la
// ligne, `…` la suite du fichier. Le `é` de `durée` sert aux schémas d'encodage.
#let _caracteres = ("d", "u", "r", "é", "e", ",", "x", ",", "y", ",", "z", "⏎", "0", ",", "…")
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
  let lignes = ("durée,x,y,z", "0,673120.5,…", "30,673152.9,…")
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
  _rangee(xr, yc, none, vifs: (11,))
  _note(xn, yc + 0.31)[une suite de caractères]

  _code(0, 2.6, "f = open(chemin, encoding=\"utf-8\")")
  _rangee(xr, 2.3, 0)
  _note(xn, 2.6)[rien n'est lu]

  _code(0, 1.3, "ligne = f.readline()")
  _rangee(xr, 1.0, 12)
  _note(xn, 1.3)[la première ligne, ⏎ compris]

  _code(0, 0.0, "reste = f.read()")
  _rangee(xr, -0.3, fin, nom: "fin")
  _note(xn, 0.0)[la suite, jusqu'à la fin]
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

// Décoder les octets de `durée,x,y,z⏎` : en UTF-8, `c3 a9` donne `é` ; en
// cp1252, chacun des deux octets donne un caractère.
#let _octets-entete = ("64", "75", "72", "c3", "a9", "65", "2c", "78", "2c", "79", "2c", "7a")
#let _lettres-fin = (("e", 1), (",", 1), ("x", 1), (",", 1), ("y", 1), (",", 1), ("z", 1))

#let schema-decodage() = cetz.canvas(length: 1cm, {
  let xr = 6.4
  let xn = xr + 13 * _octet + 0.5
  let hex = _octets-entete + ("0a",)

  _etiquette(xr - 0.3, 3.2)[octets du fichier]
  _cases(xr, 3.2, _octets-hex(hex, vifs: (3, 4)))
  _note(xn, 3.51)[13 octets]

  _etiquette(xr - 0.3, 1.6, "encoding=\"utf-8\"", code: true)
  _cases(xr, 1.6, (("d", 1), ("u", 1), ("r", 1), ("é", 2, true)) + _lettres-fin + (("⏎", 1),))
  _note(xn, 1.91)[12 caractères : `c3 a9` donne `é`]

  _etiquette(xr - 0.3, 0, "encoding=\"cp1252\"", code: true)
  _cases(xr, 0, (("d", 1), ("u", 1), ("r", 1), ("Ã", 1, true), ("©", 1, true)) + _lettres-fin + (("⏎", 1),))
  _note(xn, 0.31)[13 caractères : `c3` donne `Ã`, `a9` donne `©`]
})

// La même ligne écrite sous Linux et sous Windows : les octets diffèrent par
// la fin de ligne, le texte lu en mode texte est le même.
#let schema-fin-de-ligne() = cetz.canvas(length: 1cm, {
  let xr = 5.4
  let xn = xr + 15 * _octet + 0.5
  let lettres = (("d", 1), ("u", 1), ("r", 1), ("é", 2)) + _lettres-fin

  _etiquette(xr - 0.3, 4.6)[Linux, macOS]
  _cases(xr, 4.6, _octets-hex(_octets-entete + ("0a", "30"), vifs: (12,)))
  _note(xn, 4.91)[14 octets]
  _etiquette(xr - 0.3, 3.8)[texte lu]
  _cases(xr, 3.8, lettres + (("\\n", 1, true), ("0", 1)))

  _etiquette(xr - 0.3, 1.9)[Windows]
  _cases(xr, 1.9, _octets-hex(_octets-entete + ("0d", "0a", "30"), vifs: (12, 13)))
  _note(xn, 2.21)[15 octets]
  _etiquette(xr - 0.3, 1.1)[texte lu]
  _cases(xr, 1.1, lettres + (("\\n", 2, true), ("0", 1)))

  _note(xr, 0.4)[dans les deux cas, la chaîne `'durée,x,y,z\n0'`]
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
  _note(xn, 3.4)[`b'dur'` : 3 octets]

  _code(0, 1.8, "suite = f.read(2)")
  rangee(1.5, 5)
  _note(xn, 1.8)[`b'\xc3\xa9'` : les octets de `é`]

  _code(0, 0.2, "reste = f.read()")
  rangee(-0.1, n + 1, nom: "fin")
  _note(xn, 0.2)[jusqu'à la fin : `b'e,x,y,z\r\n0,…'`]
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
// La lecture d'un fichier, du disque au processeur (04/11/2026)
//
// Le disque, la mémoire vive et le processeur sont les dessins de « Les
// composants d'un ordinateur », au cours 1 v2. Les temps d'accès sont ceux de
// « Hiérarchie des mémoires ».
#let schema-lecture-memoire() = cetz.canvas(length: 1cm, {
  let y = 3
  let etape(x, code, acces) = {
    content((x, y + 0.5), {
      set smartquote(enabled: false)
      text(size: 14pt, font: police-code, fill: accent)[#code]
    })
    content((x, y - 0.75), align(center, text(size: 13pt, fill: estompe)[
      copie \ accès : #acces
    ]))
  }
  _disque(3, y)
  _fleche((4.5, y), (9.9, y))
  etape(7.2, "texte = f.read()", [0,1 à 10 ms])
  _memoire(11.5, y)
  _fleche((13.1, y), (18.5, y))
  etape(15.8, "texte.upper()", [100 ns])
  _processeur(20, y)
  // Le thème réduit les `raw` en ligne ; ici le code garde presque la taille de
  // la légende.
  let role(corps) = {
    show raw: set text(size: 12.5pt)
    corps
  }
  _etiquette-composant((3, y - 1.5), "Disque", role[`trace.csv`, conservé à l'extinction], largeur: 5.4cm)
  _etiquette-composant((11.5, y - 1.5), "Mémoire vive", role[`texte`, effacé à la fin du programme], largeur: 5.4cm)
  _etiquette-composant((20, y - 1.5), "Processeur", [le cache, puis les registres], largeur: 5.4cm)
})
