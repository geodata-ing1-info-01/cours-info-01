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
  annonce: "Mettre en forme un texte brut en Markdown, avec l'aperçu de VS Code, puis le convertir en page web et en document LibreOffice",
  dossier: "cours2/2a_markdown/",
  duree: "15′",
)
#separateur-td(..td)
#d("Voir le rendu sans quitter l'éditeur")[
  #annonce[
    VS Code connaît le Markdown d'origine : rien à installer, et l'aperçu
    s'ouvre à côté du fichier, dans la même fenêtre.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [L'action], [Ce qu'elle ouvre], [Quand s'en servir],
    [`Ctrl` + `K` puis `V`],
      [l'aperçu à droite, l'éditeur reste à gauche],
      [pendant qu'on écrit : le rendu suit la frappe],
    [`Ctrl` + `Maj` + `V`],
      [l'aperçu seul, dans un onglet],
      [pour relire, une fois le texte écrit],
  )

  #legende[
    Les deux aperçus défilent avec le fichier. Ils ne changent rien au `.md` :
    ce qui est enregistré reste le texte que vous avez tapé.
  ]

  #notes[
    Le raccourci le plus employé de l'année : en prendre l'habitude maintenant, et écrire
    le fichier de notes du jour avec l'aperçu ouvert.

    Le montrer en direct plutôt que le décrire. Faire remarquer que
    l'éditeur et l'aperçu se suivent quand on fait défiler l'un des deux.

    Rien n'est installé pour cela : `markdown-language-features` est livré
    avec l'éditeur, contrairement à Python et C++, qui ont demandé une
    extension. C'est le contraste à nommer.

    En français, l'entrée du menu est Affichage #sym.arrow.r Ouvrir
    l'aperçu sur le côté. Libellés dépendants de la version, à vérifier sur
    le poste de démonstration.
  ]
]
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
    [3], [un titre en `#`, deux sous-titres en `##`],
    [4], [les étapes de préparation en liste numérotée],
    [5], [les ingrédients en tableau, depuis `depart/ingredients.csv`],
    [6], [copier `depart/crepes.jpg` dans `travail/`, puis la photo par `![légende](crepes.jpg)`],
  )

  #legende[
    `depart/recette.md` donne le résultat attendu : ne
    l'ouvrir qu'après avoir essayé.
  ]

  #notes[
    Le texte de départ n'a aucune structure, et c'est voulu : ils doivent
    la décider, pas la recopier. La discussion utile est de savoir ce qui
    est un titre et ce qui est une étape — la mise en forme est une
    lecture du contenu.

    Habitude à prendre, l'aperçu côte à côte : `Ctrl` + `K` puis `V`. On
    écrit à gauche, on voit à droite, sans rien lancer.

    Étape 5 : le tableau se tape à la main, ou se produit depuis le CSV
    par une extension du catalogue. À la main la première fois,
    l'extension ensuite — un tableau Markdown n'est que des barres
    verticales, dont l'alignement n'est même pas obligatoire.

    Étape 6 : `crepes.jpg` est copiée dans `travail/`, à côté du fichier
    qu'ils écrivent : le chemin relatif tient en un nom. Une image ne
    s'insère pas dans un `.md`, elle s'y désigne : le fichier reste à côté.

    Pour ceux qui vont vite : une citation par `>`, et une seconde photo
    prise par eux.
  ]
]

// Nouveau (v2).
#d("Convertir la recette")[
  #annonce[
    Les commandes se tapent dans le terminal de VS Code, dans le dossier de
    la recette.
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
    [5], [modifier une quantité dans `recette.md`, puis refaire l'étape 2 et `F5` dans le navigateur],
      reponse[la page suit la source],
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

    Vérifié avec pandoc 3 sous Linux le 26/09/2026 (rejeu du TD 3a).
  ]
]
