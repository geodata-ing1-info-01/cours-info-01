// Schémas du cours 5 v2. S'importe par noms, comme ceux des autres cours :
//
//     #import "../schemas.typ": schema-isolation-carte
#import "../../commun/prelude.typ": *
#import "@preview/cetz:0.4.2"
#import "../../cours1/diapo/schemas.typ": _environnement, hauteur-environnement, _trait, _boite-paquet, _exigence, _depot
#import "../../cours1_v2/diapo/schemas.typ": _dossier-path

// `schema-path` du cours 1 v2, avec l'environnement `carte` à la place du Python 2.7. Chemins de
// Git Bash attendus sur un poste de la salle, à relever. Le premier dossier qui contient le
// programme demandé est surligné.
#let schema-path-carte() = face-a-face(
  panneau[Avant `conda activate carte` : le `python.exe` de `anaconda3` est lancé][
    #_dossier-path("/c/ProgramData/anaconda3", [`python.exe`], lance: true)
    #_dossier-path("/usr/bin", [`ls`, `cp`, `bash`…])
    #_dossier-path("/c/Windows/system32", [`cmd.exe`…])
  ],
  panneau[Après `conda activate carte` : les dossiers de l'environnement passent en tête][
    #_dossier-path("/c/Users/eleve/.conda/envs/carte", [`python.exe`], lance: true)
    #_dossier-path("…/envs/carte/Library/bin", [`ogr2ogr.exe`], lance: true)
    #_dossier-path("/c/ProgramData/anaconda3", [`python.exe`])
    #_dossier-path("/usr/bin", [`ls`, `cp`, `bash`…])
    #_dossier-path("/c/Windows/system32", [`cmd.exe`…])
  ],
)

// `schema-depots` du cours 1 de 2026, avec l'environnement du cours 5 v2 à la place de celui de la
// recette. Nombres de projets et de paquets relevés le 8 septembre 2026.
#let schema-depots-carte() = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  set-style(stroke: 0.9pt + _trait)

  let l-env = 8.4
  let h-env = hauteur-environnement(3)
  let (l-dep, h-dep) = (9.5, 3.1)
  let (x-dep, x-env) = (16.2, 0.3)
  let y-env = 2.0

  group(name: "env", {
    translate((x-env, y-env))
    _environnement(l-env, "carte", (
      ("python 3.12", accent),
      ("numpy 2.5", accent),
      ("folium 0.20", alerte),
    ))
  })
  content((x-env + l-env / 2, y-env - 0.25), anchor: "north",
          text(size: 14pt, fill: estompe)[#petites-capitales("votre machine")])

  group(name: "pypi", {
    translate((x-dep, 4.5))
    _depot(l-dep, h-dep, "PyPI", "886 022", "projets",
           "publication immédiate, par qui veut")
  })
  group(name: "forge", {
    translate((x-dep, 0.7))
    _depot(l-dep, h-dep, "conda-forge", "29 411", "paquets",
           "une recette, relue avant d'entrer", plein: true)
  })

  let xa = x-dep - 0.55
  let xb = x-env + l-env + 0.55
  let ym = y-env + h-env / 2
  bezier((xa, 2.25), (xb, ym), ((xa + xb) / 2, ym - 0.45),
         stroke: 2.4pt + alerte, mark: (end: ">", fill: alerte, scale: 1.5))
  content(((xa + xb) / 2, ym + 0.35), anchor: "south", box(width: 7.0cm)[
    #align(center)[
      #text(size: 15pt, fill: alerte, weight: demi-gras,
            font: police-code)[conda install folium]
      #v(0.2em)
      #text(size: 14pt, fill: alerte)[s'exécute avec vos droits]
    ]
  ])
})

// `schema-diamant` du cours 1 de 2026, sur les déclarations réelles de `folium` : une exigence
// directe sur `jinja2`, et une autre par `branca`. Relevées le 06/11/2026 avec `importlib.metadata`.
#let schema-version-jinja2() = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  set-style(stroke: 1.2pt + accent.lighten(30%),
            mark: (end: ">", fill: accent.lighten(30%), scale: 1.2))

  let y-haut = 8.4
  let y-milieu = 5.0
  let y-bas = 1.7

  group(name: "folium", {
    translate((13.0, y-haut))
    _boite-paquet("folium", "0.20.0", "b", largeur: 5.4)
  })
  group(name: "branca", {
    translate((6.2, y-milieu))
    _boite-paquet("branca", "0.8.2", "b")
  })
  group(name: "jinja2", {
    translate((13.0, y-bas))
    _boite-paquet("jinja2", "3.1.6", "b", couleur: attention, largeur: 5.4)
  })

  line("folium.b.west", "branca.b.north")
  line("branca.b.south", "jinja2.b.west")
  line("folium.b.south", "jinja2.b.north")

  _exigence("folium.b.west", "branca.b.north", "branca >=0.6.0", position: 52%)
  _exigence("branca.b.south", "jinja2.b.west", "jinja2 >=3", position: 45%)
  _exigence("folium.b.south", "jinja2.b.north", "jinja2 >=2.9", position: 50%)

  content((13.0, y-bas - 1.35), anchor: "north", box(width: 17cm)[
    #align(center)[
      #text(size: 16pt, fill: attention, weight: demi-gras)[
        une seule version installée, qui satisfait les deux exigences
      ]
    ]
  ])
})

// `schema-isolation` du cours 1 de 2026, avec l'environnement du cours 5 v2 à la place de
// celui de la recette. Le cours de 2026 reste inchangé.
#let schema-isolation-carte() = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  set-style(stroke: 0.9pt + _trait)

  let l = 10.2
  let (xa, xb) = (1.6, 14.2)
  let y = 2.5
  let h = hauteur-environnement(3)

  rect((0.5, 1.1), (25.5, y + h + 1.3), radius: 0.15,
       stroke: 1.2pt + estompe, fill: gris.lighten(55%))
  content((1.0, y + h + 0.75), anchor: "west",
          text(size: 15pt, fill: estompe)[#petites-capitales("votre machine")])

  group(name: "a", {
    translate((xa, y))
    _environnement(l, "carte", (
      ("python 3.12", accent),
      ("numpy 2.5", alerte),
      ("folium 0.20", accent),
    ))
  })
  group(name: "b", {
    translate((xb, y))
    _environnement(l, "autre-projet", (
      ("python 3.11", accent),
      ("numpy 1.26", alerte),
      ("pandas 2.2", accent),
    ))
  })

  rect((xa, 1.5), (xb + l, 2.15), radius: 0.08,
       stroke: 1pt + estompe.lighten(40%), fill: white)
  content(((xa + xb + l) / 2, 1.83),
          text(size: 14pt, fill: estompe)[
            le Python du système, auquel aucun des deux n'a touché
          ])

  let y-numpy = y + h - 1.0 - (0.75 + 0.28) * 2 + 0.375
  line((xa + l, y-numpy), (xb, y-numpy),
       stroke: (paint: alerte, thickness: 1.2pt, dash: "dashed"))
  content((13.0, 0.85), anchor: "north",
          text(size: pt-footnotesize, fill: alerte, weight: demi-gras)[
            la même bibliothèque, en deux versions, sans qu'elles se croisent
          ])
})
