// TD 2a du cours 2 v2 — « Une recette en Markdown, convertie par pandoc ».
//
// Le TD 3a du cours 1 de 2026, sans le diagramme `mermaid` (en annexe), et
// complété par la conversion en page web et en `.odt`. `travail/recette.md`
// est le fichier du premier commit du TD 3a.
//
// Inclus par `cours2_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 2_v2`.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "2a",
  titre: "Une recette en Markdown, convertie par pandoc",
  annonce: "Objectif : structurer un texte brut en Markdown, avec l'aperçu de VS Code, puis le convertir en page web et en document LibreOffice",
  dossier: "cours2/2a_markdown/",
  duree: "12′",
)
#separateur-td(..td)
// « Voir le rendu sans quitter l'éditeur » fondue dans la diapositive
// suivante le 28/09/2026.
#d("Mettre en forme une recette")[
  #annonce[
    Un texte brut sans aucune structure, à reprendre en Markdown. Le rendu se
    vérifie à côté, sans quitter l'éditeur.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire],
    [1], [dans l'explorateur de VS Code, `2a_markdown/depart/recette_a_formater.txt`],
    [2], [l'enregistrer sous `travail/recette.md`, et ouvrir l'aperçu par `Ctrl` + `K` puis `V`],
    [3], [un titre `# Crêpes`, deux sous-titres `## Ingrédients` et `## Préparation`],
    [4], [les étapes de préparation en liste numérotée : `1. Mélanger…`],
    [5], [les ingrédients en tableau, depuis `depart/ingredients.csv` : `| Ingrédient | Quantité |`, puis `|---|---|`, puis une ligne `| Farine | 250 g |` par ingrédient],
    [6], [copier `depart/crepes.jpg` dans `travail/`, puis la photo par `![légende](crepes.jpg)`],
  )

  #legende[
    `Ctrl` + `Maj` + `V` ouvre l'aperçu seul, dans un onglet. L'aperçu ne
    change rien au `.md`. `depart/recette.md` donne le résultat attendu :
    ne l'ouvrir qu'après avoir essayé.
  ]

  #notes[
    Aperçu : VS Code le fournit sans extension
    (`markdown-language-features`), alors que Python a demandé une
    extension au TD 1a. Le montrer en direct ; l'éditeur et l'aperçu
    défilent ensemble. Menu en français : Affichage #sym.arrow.r Ouvrir
    l'aperçu sur le côté (libellés à vérifier sur le poste de démonstration).

    Le texte de départ n'a aucune structure : les élèves décident de ce qui
    est un titre et de ce qui est une étape.

    Étape 5 : le tableau se tape à la main. L'alignement des barres n'est
    pas obligatoire ; la ligne `|---|---|` sépare l'en-tête. Une extension
    du catalogue produit le tableau depuis le CSV ; à montrer ensuite, si
    la question vient.

    Étape 6 : `crepes.jpg` est copiée dans `travail/`, à côté du fichier
    écrit : le chemin relatif tient en un nom. Le `.md` désigne l'image,
    qui reste un fichier à part.

    Pour ceux qui vont vite : une citation par `>`, et une seconde photo
    prise par eux.
  ]
]

// Nouveau (v2). Reçoit le 28/09/2026 l'essentiel de la diapositive d'exposé
// « Convertir un fichier Markdown : pandoc », retirée ; l'étape « modifier
// une quantité, refaire la page » est retirée.
#d("Convertir la recette")[
  #annonce[
    pandoc écrit le contenu d'un fichier Markdown dans un autre format, qu'il
    déduit de l'extension du fichier demandé par `-o`. Les commandes se
    tapent dans le terminal de VS Code.
  ]

  #tableau(
    columns: (auto, 1.1fr, 1fr),
    align: left + horizon,
    [], [Commande], [Ce que vous constatez],
    [1], [`cd ~/Desktop/info01/cours2/2a_markdown/travail`], [l'invite se termine par `travail`],
    [2], [`pandoc recette.md -o recette.html`], reponse[pas de message ; `recette.html` dans l'explorateur],
    [3], [`start recette.html`], reponse[la page dans le navigateur, photo comprise],
    [4], [`pandoc recette.md -o recette.odt`, puis `start recette.odt`],
      reponse[le même contenu dans LibreOffice : titres, tableau, liste],
  )

  #legende[
    Le `.md` est la source ; la page et le document se refont depuis lui.
  ]

  #notes[
    Étape 3 : sans `crepes.jpg` dans `travail/`, la page affiche la légende
    à la place de la photo. Chemin relatif, encore.

    Le `.odt` produit reprend les styles par défaut de LibreOffice (Titre 1,
    Titre 2, tableau). `--reference-doc` choisit un autre modèle : ne pas le
    montrer.

    pandoc est dans l'environnement `base` d'Anaconda sur les postes
    (confirmé par l'équipe, 26/09/2026). Le PDF passe par LaTeX ou typst,
    non installés : ne pas le faire en séance.

    Suite : le TD 3a ignore ces fichiers produits ; le cours 3 appelle
    pandoc depuis Python.

    Vérifié avec pandoc 3 sous Linux le 26/09/2026 (rejeu du TD 3a).
  ]
]
