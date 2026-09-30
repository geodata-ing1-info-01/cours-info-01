// Gabarits propres au cours 3, pour montrer du code et ses sorties. Les
// gabarits communs sont dans `src/commun/schemas.typ`.
#import "../../commun/prelude.typ": *

// Une sortie de terminal ou de cellule, passée en chaîne (les `\n` y sont
// des retours à la ligne) : rendue en `raw` pour que les colonnes restent
// alignées, sur fond gris, en taille réduite pour tenir sur une diapositive.
#let sortie(texte, taille: 13pt) = block(
  width: 100%, inset: (x: 10pt, y: 8pt), fill: gris,
)[
  // Le thème règle la taille des blocs `raw` par une règle `show` ; celle-ci,
  // posée plus près, la remplace.
  #show raw: set text(size: taille)
  #raw(block: true, texte)
]

// Un code commenté ligne à ligne : à gauche chaque ligne de code, à droite
// ce qu'elle fait, en une ligne courte. Une paire par ligne ; une paire dont
// le code est vide fait une ligne blanche. Le code se met en `raw` avec
// coloration Python. Le commentaire est lu comme du balisage typst : les
// accents graves y donnent du code en ligne.
//
//   #code-commente(
//     ("from pathlib import Path", "importer la bibliothèque"),
//     ("dossier = Path(\"depart\")", "déclarer un chemin"),
//   )
#let code-commente(..lignes, taille-code: 14pt, taille-texte: 13.5pt) = {
  let paires = lignes.pos()
  // Le thème réduit les `raw` par une règle `show` ; celle-ci, posée plus
  // près, fixe la taille du code.
  show raw: set text(size: taille-code)
  grid(
    columns: (auto, 1fr), column-gutter: 20pt, row-gutter: 6pt,
    align: (left + horizon, left + horizon),
    ..paires.map(paire => (
      if paire.at(0) == "" { [] } else { raw(lang: "python", paire.at(0)) },
      text(size: taille-texte, fill: estompe, eval(paire.at(1), mode: "markup")),
    )).flatten(),
  )
}

// Une arborescence de dossiers, dessinée avec les traits de la commande
// `tree`. Chaque entrée est un tableau `(niveau, nom)` ou `(niveau, nom,
// note)`, dans l'ordre de lecture ; le niveau 0 est la racine. La note est
// écrite à droite, en gris. Un nom passé en contenu plutôt qu'en chaîne
// garde sa mise en forme : `text(fill: attention)[recette.ipynb]` pour un
// fichier à copier.
//
//   #arborescence(
//     (0, "cours3/"),
//     (1, "3b_recette/"),
//     (2, "travail/", "vide"),
//   )
#let arborescence(..entrees, taille: 12pt) = {
  let e = entrees.pos()
  // Une entrée est la dernière de son dossier quand aucune entrée du même
  // niveau ne la suit avant une entrée de niveau inférieur.
  let derniere(i) = {
    let n = e.at(i).at(0)
    let resultat = true
    let fini = false
    for j in range(i + 1, e.len()) {
      if not fini {
        let m = e.at(j).at(0)
        if m < n { fini = true }
        else if m == n { resultat = false; fini = true }
      }
    }
    resultat
  }
  // Le dernier ancêtre de l'entrée i au niveau k.
  let ancetre(i, k) = {
    let trouve = none
    for j in range(0, i) {
      if e.at(j).at(0) == k { trouve = j }
    }
    trouve
  }
  let blanc = "\u{00A0}"
  let lignes = ()
  for (i, entree) in e.enumerate() {
    let n = entree.at(0)
    let prefixe = ""
    for k in range(1, n) {
      let a = ancetre(i, k)
      prefixe += if a != none and not derniere(a) { "│" + blanc * 2 } else { blanc * 3 }
    }
    if n > 0 { prefixe += if derniere(i) { "└─" + blanc } else { "├─" + blanc } }
    let note = if entree.len() > 2 { entree.at(2) } else { "" }
    lignes.push(text(font: police-code, size: taille)[#prefixe#entree.at(1)])
    lignes.push(text(size: taille, fill: estompe, if type(note) == str { eval(note, mode: "markup") } else { note }))
  }
  grid(
    columns: (auto, auto), column-gutter: 22pt, row-gutter: 0.42em,
    align: (left + horizon, left + horizon),
    ..lignes,
  )
}

// Le panneau des fichiers de JupyterLab, dessiné : la ligne du chemin, en
// haut, puis le contenu du dossier ouvert. `chemin` est la liste des
// dossiers depuis le dossier de lancement ; `entrees` les noms affichés.
#let panneau-jupyterlab(chemin, entrees, largeur: 100%) = block(
  width: largeur, stroke: 1pt + estompe, radius: 3pt, clip: true,
)[
  #block(width: 100%, fill: gris, inset: (x: 10pt, y: 7pt), below: 0pt)[
    #box(width: 13pt, height: 9pt, stroke: 1.2pt + encre, radius: 1pt, baseline: 0pt)
    #text(font: police-code, size: 12pt, chemin.map(dossier => " / " + dossier).join() + " /")
  ]
  #block(width: 100%, inset: (x: 10pt, y: 8pt))[
    #set text(font: police-code, size: 12pt)
    #set par(leading: 0.7em)
    #entrees.join(linebreak())
  ]
]

// Une étape de TD : l'attendu, ce qui doit exister ou fonctionner à la fin
// de l'étape, puis les pistes, les opérations à faire, numérotées dans
// l'ordre. Les deux listes sont l'une sous l'autre : côte à côte, en deux
// tableaux, leurs lignes semblaient se répondre (30/09/2026). Une coche
// marque ce qu'on vérifie, un numéro l'ordre des opérations : c'est
// l'exception de STYLE.md aux listes sur les diapositives, réservée aux
// diapositives d'étape de TD. Chaque argument est une liste de contenus, une
// ligne par élément. Le code complet reste dans le guide.
//
//   #attendu-pistes(
//     ([`python recette.py` affiche la recette pour 6 personnes],),
//     ([calculer le facteur], [reprendre la boucle de `afficher`]),
//   )
#let attendu-pistes(attendu, pistes, taille: 15pt) = {
  let titre(t) = text(size: taille, weight: demi-gras, fill: encre)[#t]
  let liste(elements, marque) = {
    set text(size: taille)
    grid(
      columns: (auto, 1fr), column-gutter: 8pt, row-gutter: 0.42em,
      ..elements.enumerate().map(((i, x)) => (marque(i), x)).flatten(),
    )
  }
  stack(
    spacing: 0.45em,
    titre[Attendu à la fin de l'étape],
    liste(attendu, i => text(fill: attention)[#sym.checkmark]),
    v(0.35em),
    titre[Pistes],
    liste(pistes, i => [#str(i + 1).]),
  )
}
