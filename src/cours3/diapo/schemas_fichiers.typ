// Schémas du cours 3 : le contenu d'un fichier, ses octets, la position de
// lecture et d'écriture.
//
// Séparé de `schemas.typ` pour la même raison que `schemas_notebook.typ` :
// ce fichier ouvre `cetz.draw`, dont les noms masqueraient ceux de typst
// chez qui l'importerait en bloc.
//
//     #import "../schemas_fichiers.typ": schema-position-lecture

#import "../../commun/prelude.typ": *
#import "@preview/cetz:0.4.2"
#import cetz.draw: *

// Le début de `recette.md`, un caractère par case ; `␣` note l'espace, `⏎`
// le retour à la ligne, `…` la suite du fichier.
#let _caracteres = ("#", "␣", "C", "r", "ê", "p", "e", "s", "⏎", "⏎", "*", "1", "0", "…")
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

// Le début de `recette.md` tel qu'un éditeur l'affiche, sur trois lignes,
// puis tel qu'il est dans le fichier, une suite de caractères où chaque fin
// de ligne est un caractère `⏎`. Dessous, deux lectures qui avancent la
// position : `readline` s'arrête après le premier `⏎`.
#let schema-position-lecture() = cetz.canvas(length: 1cm, {
  let xr = 9.6                                   // début des cases
  let fin = _caracteres.len()
  let xn = xr + fin * _case + 0.4                // début des notes

  // L'éditeur : numéros de ligne, texte, `⏎` en couleur en fin de ligne.
  let lignes = ("# Crêpes", "", "*10 minutes…")
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
  _rangee(xr, yc, none, vifs: (8, 9))
  _note(xn, yc + 0.31)[une suite de caractères]

  _code(0, 2.6, "f = open(chemin, encoding=\"utf-8\")")
  _rangee(xr, 2.3, 0)
  _note(xn, 2.6)[rien n'est lu]

  _code(0, 1.3, "ligne = f.readline()")
  _rangee(xr, 1.0, 9)
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

// Décoder les octets de `# Crêpes⏎` : en UTF-8, `c3 aa` donne `ê` ; en
// cp1252, chacun des deux octets donne un caractère.
#let schema-decodage() = cetz.canvas(length: 1cm, {
  let xr = 6.4
  let xn = xr + 10 * _octet + 0.5
  let hex = ("23", "20", "43", "72", "c3", "aa", "70", "65", "73", "0a")

  _etiquette(xr - 0.3, 3.2)[octets du fichier]
  _cases(xr, 3.2, _octets-hex(hex, vifs: (4, 5)))
  _note(xn, 3.51)[10 octets]

  _etiquette(xr - 0.3, 1.6, "encoding=\"utf-8\"", code: true)
  _cases(xr, 1.6, (("#", 1), ("␣", 1), ("C", 1), ("r", 1), ("ê", 2, true),
                   ("p", 1), ("e", 1), ("s", 1), ("⏎", 1)))
  _note(xn, 1.91)[9 caractères : `c3 aa` donne `ê`]

  _etiquette(xr - 0.3, 0, "encoding=\"cp1252\"", code: true)
  _cases(xr, 0, (("#", 1), ("␣", 1), ("C", 1), ("r", 1), ("Ã", 1, true),
                 ("ª", 1, true), ("p", 1), ("e", 1), ("s", 1), ("⏎", 1)))
  _note(xn, 0.31)[10 caractères : `c3` donne `Ã`, `aa` donne `ª`]
})

// La même ligne écrite sous Linux et sous Windows : les octets diffèrent par
// la fin de ligne, le texte lu en mode texte est le même.
#let schema-fin-de-ligne() = cetz.canvas(length: 1cm, {
  let xr = 5.4
  let xn = xr + 14 * _octet + 0.5
  let debut = ("23", "20", "43", "72", "c3", "aa", "70", "65", "73")
  let lettres = (("#", 1), ("␣", 1), ("C", 1), ("r", 1), ("ê", 2),
                 ("p", 1), ("e", 1), ("s", 1))

  _etiquette(xr - 0.3, 4.6)[Linux, macOS]
  _cases(xr, 4.6, _octets-hex(debut + ("0a", "0a", "2a"), vifs: (9, 10)))
  _note(xn, 4.91)[12 octets]
  _etiquette(xr - 0.3, 3.8)[texte lu]
  _cases(xr, 3.8, lettres + (("\\n", 1, true), ("\\n", 1, true), ("*", 1)))

  _etiquette(xr - 0.3, 1.9)[Windows]
  _cases(xr, 1.9, _octets-hex(debut + ("0d", "0a", "0d", "0a", "2a"), vifs: (9, 10, 11, 12)))
  _note(xn, 2.21)[14 octets]
  _etiquette(xr - 0.3, 1.1)[texte lu]
  _cases(xr, 1.1, lettres + (("\\n", 2, true), ("\\n", 2, true), ("*", 1)))

  _note(xr, 0.4)[dans les deux cas, la chaîne `'# Crêpes\n\n*'`]
})

// Le fichier de Windows ouvert en `"rb"` : la position compte des octets,
// et `read` renvoie des `bytes`.
#let schema-position-octets() = cetz.canvas(length: 1cm, {
  let xr = 7.4
  let hex = ("23", "20", "43", "72", "c3", "aa", "70", "65", "73", "0d", "0a", "0d", "0a", "2a")
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

  _code(0, 3.4, "debut = f.read(4)")
  rangee(3.1, 4)
  _note(xn, 3.4)[`b'# Cr'` : 4 octets]

  _code(0, 1.8, "suite = f.read(2)")
  rangee(1.5, 6)
  _note(xn, 1.8)[`b'\xc3\xaa'` : les octets de `ê`]

  _code(0, 0.2, "reste = f.read()")
  rangee(-0.1, n + 1, nom: "fin")
  _note(xn, 0.2)[jusqu'à la fin : `b'pes\r\n\r\n*…'`]
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
