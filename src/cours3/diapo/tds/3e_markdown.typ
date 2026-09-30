// TD 3e — « Une recette en Markdown », parcours standard.
//
// Inclus par `cours3.typ`, avant le TD 3f, qui porte les réglages globaux et
// importe `td` pour le sommaire des TD ; compilable seul par
// `outils/compiler_tds.py`. Un fichier inclus n'hérite pas des imports de son
// appelant.
//
// Depuis le 29/09/2026 : le TD ajoute une recette, les gaufres, à un dépôt
// git de recettes, `travail/recettes/`, créé à partir des quatre recettes du
// TD 3b. Le dossier ouvert dans VS Code, le dépôt et le dossier du notebook
// `pages.ipynb`, qui produit les pages, sont le même dossier. Le guide
// détaillé est `notebook/td/3e_markdown/guide.md`.
//
// Plan : le guide et le matériel, la vue d'ensemble, les deux aide-mémoire
// (Markdown, git), puis une diapositive par étape, sur le même plan que le
// TD 3f : l'objectif en annonce, l'attendu et les pistes côte à côte, le
// renvoi au guide en légende, ce que l'étape fait constater dans le corrigé.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *

#let td = (
  numero: "3e",
  titre: "Une recette en Markdown",
  annonce: "Objectif : ajouter une recette, écrite en Markdown, à un dépôt git de recettes, et en produire la page HTML avec le programme du TD 3b",
  dossier: "cours3/3e_markdown/",
  duree: "45′",
  statut: "parcours standard",
)
#separateur-td(..td)

// --------------------------------------------
#d("Le guide et le matériel de départ")[
  #annonce[
    Le guide du TD détaille chaque étape : dossier, commandes et
    vérifications. Les diapositives suivantes en sont le résumé.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Fichier], [Emplacement], [Usage],
    [`guide_3e_markdown.pdf`, `.html`, `guide.ipynb`], [`cours3/3e_markdown/`], [le détail des étapes],
    [`recettes/`], [`depart/`], [quatre recettes, `pages.ipynb` et `style.css` : le futur dépôt, copié dans `travail/`],
    [`gaufres/`], [`depart/`], [le texte, les ingrédients et la photo de la recette à ajouter],
    [`recette_attendue.md`], [`depart/`], [le résultat de l'étape 2, à n'ouvrir qu'après avoir essayé],
  )

  #notes[
    `pages.ipynb` reprend le code final de `recette.ipynb` (TD 3b), sans
    cellule à compléter : le TD ne dépend pas de l'état du notebook du TD 3b.
  ]
]

// --------------------------------------------
#d("Les étapes du TD")[
  #annonce[
    Objectif : ajouter une recette, écrite en Markdown, à un dépôt git de
    recettes, et en produire la page HTML avec le programme du TD 3b.
  ]

  #chaine(
    ([`travail/recettes/`], "le dépôt des recettes"),
    ([`gaufres/recette.md`], "la recette ajoutée, en Markdown"),
    ([`gaufres/page.html`], "sa page, par pages.ipynb"),
  )

  #tableau(
    columns: (auto, 1.3fr, 1fr),
    align: (center + horizon, left + horizon, left + horizon),
    [Étape], [Objectif], [Résultat],
    [0], [versionner les recettes existantes], [un dépôt, un commit],
    [1], [vérifier le programme des pages], [une page par recette],
    [2], [structurer un texte en Markdown], [`gaufres/recette.md`],
    [3], [produire la page, versionner la recette], [la page ; deux commits],
    [4], [modifier un fichier suivi, lire le `diff`], [le diagramme ; trois commits],
  )

  #legende[
    Deux aide-mémoire suivent, la syntaxe Markdown et les commandes git,
    puis une diapositive par étape.
  ]
]

// --------------------------------------------
#d("Aide-mémoire : la syntaxe Markdown")[
  #annonce[
    Rappel du cours 1, pour l'étape 2. L'aperçu de VS Code, `Ctrl` + `K`
    puis `V`, montre le résultat pendant la frappe.
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
]

// --------------------------------------------
#d("Aide-mémoire : les commandes git")[
  #annonce[
    Rappel du cours 2, pour les étapes 0, 3 et 4. Les commandes se tapent dans
    le terminal Git Bash de VS Code, dans le dossier du dépôt.
  ]

  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [`git init`], [crée le dépôt dans le dossier courant],
    [`git config user.name "Prénom Nom"`], [l'identité git : le nom qui signe les commits, pour ce dépôt seulement ; de même `user.email`],
    [`.gitignore`], [un fichier texte : une ligne par fichier que git ne suit pas],
    [`git status`], [les fichiers modifiés, ajoutés ou non suivis],
    [`git add .`, puis `git commit -m "…"`], [enregistre l'état des fichiers dans un commit],
    [`git diff`], [les lignes modifiées depuis le dernier commit ; `q` pour quitter],
    [`git log --oneline`], [un commit par ligne],
  )
]

// --------------------------------------------
#d("Étape 0 · Le dépôt des recettes")[
  #annonce[
    Objectif : versionner le dossier des recettes, ouvert dans VS Code, pour
    y ajouter ensuite une recette.
  ]

  #attendu-pistes(
    (
      [`travail/recettes/` ouvert dans VS Code],
      [un dépôt et un commit : les quatre recettes, `style.css` et `.gitignore`],
      [le panneau du contrôle de code source, sans modification],
    ),
    (
      [copier `depart/recettes/` dans `travail/`],
      [ouvrir le dossier du dépôt : Fichier #sym.arrow.r Ouvrir le dossier, `travail/recettes`],
      [créer le dépôt : `git init`, puis l'identité git (`git config user.name` et `user.email`, sans `--global`)],
      [écrire `.gitignore` : `page.md`, `page.html`, `pages.ipynb`, `.ipynb_checkpoints/`, puis faire le commit],
    ),
  )

  #legende[
    Guide, étape 0. VS Code affiche l'état git du dossier ouvert : ses
    outils git ne fonctionnent que si ce dossier est le dépôt.
  ]

  #reponse(legende[
    Constaté : `git status` liste `.gitignore`, les quatre dossiers et
    `style.css`, sans `pages.ipynb`.
  ])

  #notes[
    Le notebook n'est pas versionné : son `.ipynb` contient les sorties des
    cellules, qui changent à chaque exécution. Les pages non plus : le
    notebook les refait.

    Identité : le nom et l'adresse qui signent les commits. Distincte des
    identifiants de connexion à GitHub (« credentials », cours 5). Sans
    `--global` : le poste est partagé, le réglage ne vaut que pour ce dépôt.
  ]
]

// --------------------------------------------
#d("Étape 1 · Tester le notebook des pages")[
  #annonce[
    Objectif : vérifier que le programme du TD 3b produit la page de chaque
    recette du dépôt.
  ]

  #attendu-pistes(
    (
      [une `page.html` dans chaque dossier de recette],
      [`git status` n'affiche aucune modification],
    ),
    (
      [ouvrir `travail/recettes/pages.ipynb` dans JupyterLab],
      [exécuter tout le notebook : Run #sym.arrow.r Run All Cells],
      [ouvrir une page par un double-clic],
    ),
  )

  #legende[
    Guide, étape 1.
  ]

  #reponse(legende[
    Constaté : les pages et le notebook sont dans le dossier, et `.gitignore`
    les écarte : « rien à valider ».
  ])
]

// --------------------------------------------
#d("Étape 2 · La recette des gaufres en Markdown")[
  #annonce[
    Objectif : ajouter au dépôt une recette, écrite en Markdown, qui suit
    l'organisation des autres.
  ]

  #attendu-pistes(
    (
      [`gaufres/` dans le dépôt : `recette.md`, `ingredients.csv`, `photo.jpg`],
      [dans l'aperçu : titre, ligne en italique, photo, deux sous-titres, six étapes numérotées, citation],
      [la section `## Ingrédients` laissée vide],
    ),
    (
      [copier `depart/gaufres/` dans `travail/recettes/`],
      [renommer `recette_a_formater.txt` en `recette.md`],
      [mettre le texte en forme, l'aperçu ouvert à côté du fichier (aide-mémoire Markdown)],
    ),
  )

  #legende[
    Guide, étape 2. `depart/recette_attendue.md` donne le résultat, à
    n'ouvrir qu'après avoir essayé.
  ]

  #notes[
    Reprise du TD 3e Markdown du cours 1, que beaucoup n'ont pas fini.
    Différence : la section `## Ingrédients` reste vide, le notebook y écrit
    le tableau depuis `ingredients.csv` à l'étape 3.
  ]
]

// --------------------------------------------
#d("Étape 3 · La page des gaufres, puis le commit")[
  #annonce[
    Objectif : produire la page de la nouvelle recette avec le même
    programme, puis enregistrer la recette dans le dépôt.
  ]

  #attendu-pistes(
    (
      [`gaufres/page.html` : la photo et le tableau des ingrédients pour quatre personnes],
      [un commit qui contient les trois fichiers de `gaufres/`],
      [`git log --oneline` affiche deux commits],
    ),
    (
      [relancer `pages.ipynb` : Run All Cells],
      [vérifier avec `git status`, puis `git add gaufres` et le commit],
      [pour une autre quantité : `generer_page(RACINE / "gaufres", personnes=8)`],
    ),
  )

  #legende[
    Guide, étape 3.
  ]

  #reponse(legende[
    Constaté : le notebook traite la nouvelle recette sans changement de
    code ; `git status` ne liste que `gaufres/`.
  ])
]

// --------------------------------------------
#d("Étape 4 · Un diagramme de la préparation")[
  #annonce[
    Objectif : ajouter à la recette un diagramme de la préparation, écrit en
    texte avec Mermaid.
  ]

  #let noeud(corps, largeur: auto) = box(
    width: largeur, stroke: 1pt + accent.lighten(40%), inset: (x: 8pt, y: 6pt), radius: 3pt,
  )[#text(size: 13pt)[#corps]]
  // Les deux premières étapes du diagramme de l'étape 4 : le texte, puis le
  // dessin qu'en fait l'aperçu.
  #face-a-face(
    panneau("Le texte, dans recette.md")[
      #sortie("```mermaid\nflowchart LR\n  A[Farine, sucre, levure, sel] --> C[Pâte]\n  B[Œufs] --> C\n```", taille: 12pt)
    ],
    panneau("Le dessin, dans l'aperçu de VS Code")[
      #v(0.3em)
      #grid(
        columns: (auto, 22pt, auto), row-gutter: 10pt, align: horizon,
        noeud(largeur: 190pt)[Farine, sucre, levure, sel], text(fill: accent)[→],
        grid.cell(rowspan: 2, noeud[Pâte]),
        noeud(largeur: 190pt)[Œufs], text(fill: accent)[→],
      )
    ],
  )

  #attendu-pistes(
    (
      [le diagramme complet, après la sixième étape],
      [`git log --oneline` affiche trois commits],
    ),
    (
      [écrire une ligne par flèche : `A --> C`],
      [relire `git diff`, puis faire le commit],
    ),
  )

  #legende[
    Guide, étape 4. Documentation : #link("https://mermaid.js.org/syntax/flowchart.html")[mermaid.js.org/syntax/flowchart.html].
  ]

  #notes[
    `flowchart LR` : de gauche à droite. Chaque étape a une lettre, et son
    texte entre crochets à sa première apparition ; `C` réutilise le nœud
    « Pâte ». L'aperçu de VS Code dessine le diagramme ; pandoc ne le
    dessine pas, la page produite à l'étape 3 affiche le texte du bloc.
  ]
]
