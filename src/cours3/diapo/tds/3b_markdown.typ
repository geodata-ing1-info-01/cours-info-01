// TD 3b du cours 3 — « Une recette en Markdown », parcours standard.
//
// Inclus par `cours3.typ`, après le TD 3a, qui porte les réglages globaux et
// importe `td` pour le sommaire des TD ; compilable seul par
// `outils/compiler_tds.py`. Un fichier inclus n'hérite pas des imports de son
// appelant.
//
// Reprend le TD 3a Markdown du cours 1 sur une nouvelle recette, les
// gaufres : le fichier écrit par l'élève est lu par `generer_page` de
// `recette.ipynb` (TD 1a), puis versionné dans un dépôt qui ne contient que
// la recette. Le guide détaillé est `notebook/td/3b_markdown/guide.md`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *

#let td = (
  numero: "3b",
  titre: "Une recette en Markdown",
  annonce: "Parcours standard : écrire la recette des gaufres en Markdown, en faire une page avec le programme du TD 1a, puis la versionner ; un commit par étape",
  dossier: "cours3/3b_markdown/",
  duree: "45′",
)
#separateur-td(..td)

// --------------------------------------------
#d("Les étapes du TD")[
  #annonce[
    La recette des gaufres est livrée en texte brut. Elle devient un fichier
    Markdown, que le programme du TD 1a complète par le tableau des
    ingrédients et convertit en page HTML.
  ]

  #tableau(
    columns: (auto, 1fr, auto),
    align: (left + horizon, left + horizon, center + horizon),
    [Étape], [Ce qu'on fait], [Commits],
    [0], [copier `depart/gaufres/` dans `travail/` ; ouvrir `travail/gaufres/` dans VS Code], [0],
    [1], [écrire `recette.md` à partir de `recette_a_formater.txt`, avec l'aperçu ouvert à côté], [0],
    [2], [produire la page : un appel de `generer_page` à la fin de `recette.ipynb`], [0],
    [3], [créer le dépôt dans `travail/gaufres/`, un `.gitignore`, le premier commit], [1],
    [4], [ajouter un diagramme Mermaid de la préparation, relire le `diff`, committer], [2],
  )

  #legende[
    Le guide `guide_3b_markdown.pdf`, dans le dossier `3b_markdown/`, détaille
    chaque étape. `recette_attendue.md`, dans `depart/`, donne le résultat :
    à n'ouvrir qu'après avoir essayé.
  ]

  #notes[
    Reprise du TD 3a Markdown du cours 1, que beaucoup n'ont pas fini.
    Différence : la section `## Ingrédients` reste vide, le programme y
    écrit le tableau depuis `ingredients.csv`.

    Le dépôt ne contient que la recette : pas de notebook, pas de page
    produite.
  ]
]

// --------------------------------------------
#d("Le Markdown de la recette")[
  #annonce[
    Chaque élément du texte brut reçoit sa marque Markdown. L'aperçu de VS
    Code, `Ctrl` + `K` puis `V`, montre le résultat pendant la frappe.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Élément], [Ce qu'on tape], [Ce que l'aperçu affiche],
    [titre], [`# Gaufres`], [un grand titre],
    [section], [`## Préparation`], [un sous-titre],
    [italique, gras], [`*Pour 8 gaufres…*`, `**peu à peu**`], [le texte en italique, en gras],
    [étapes], [`1. Mélanger…` en début de ligne], [une liste numérotée],
    [photo], [`![Une gaufre…](photo.jpg)`], [l'image, dont le chemin part du fichier],
    [remarque], [`> Les gaufres se servent…`], [une citation, en retrait],
  )

  #legende[
    La section `## Ingrédients` reste vide : le programme y écrit le tableau
    des quantités, lu dans `ingredients.csv`.
  ]
]

// --------------------------------------------
#d("Le dépôt de la recette")[
  #annonce[
    Le dépôt est créé dans `travail/gaufres/` et ne contient que les fichiers
    de la recette. Les pages produites par le programme sont ignorées.
  ]

  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [`git init`], [crée le dépôt dans `gaufres/`],
    [`git config user.name "Prénom Nom"`], [le nom qui signe les commits, pour ce dépôt seulement],
    [`.gitignore`], [un fichier texte, deux lignes : `gaufres.md` et `gaufres.html`],
    [`git add .`, puis `git commit -m "…"`], [le premier commit : `recette.md`, `ingredients.csv`, `photo.jpg`, `style.css`, `.gitignore`],
    [`git diff`], [les lignes du diagramme ajoutées, avant le second commit],
  )

  #legende[
    Un notebook ne se versionne pas ici : son fichier `.ipynb` contient aussi
    les sorties des cellules, et son `diff` se lit mal.
  ]
]
