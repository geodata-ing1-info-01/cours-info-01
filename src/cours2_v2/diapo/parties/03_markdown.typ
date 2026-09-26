// Partie 3 du cours 2 v2 — Markdown. Incluse par `cours2_v2.typ`.
// Un fichier inclus n'hérite pas des imports de son appelant.
//
// Reprend les diapositives 74 à 76 du cours 1 de 2026 sans les reformuler ;
// la syntaxe minimale a été vue au cours 1 v2, dans les cellules d'un
// notebook. Trois diapositives nouvelles : ce qui s'ajoute à la syntaxe,
// pandoc, le README.
#import "../../../commun/prelude.typ": *

#separateur(
  "Markdown",
  annonce: "Le format de la documentation d'un projet : du texte lisible tel quel, converti en page web ou en document quand il le faut.",
)

#d("Les fichiers texte d'un projet")[
  #annonce[
    Le code n'est pas le seul texte d'un projet. Ses réglages et sa
    documentation s'écrivent aussi en texte, dans le même éditeur.
  ]

  #tableau(
    columns: (auto, 1fr, auto),
    align: left + horizon,
    [Fichier], [Ce qu'il porte], [Qui le lit],
    [`.py`], [les instructions du programme], [l'interpréteur],
    surligne[`.md`],
      surligne[la documentation, les notes, le `README`],
      surligne[un humain],
    [`.toml`, `.yml`], [les réglages du projet et ses dépendances], [un outil],
    [`.csv`], [un petit jeu d'essai, pour vérifier que le programme marche], [un programme],
  )

  #avertissement[
    Les données de travail ne sont pas des fichiers du projet. Elles sont
    stockées ailleurs, et le programme y accède par un chemin de fichier. Un
    projet ne contient qu'un petit jeu de données, pour le tester.
  ]

  #notes[
    On n'écrit pas que du code dans un éditeur de code : sur un projet réel,
    les fichiers de réglage et la documentation sont souvent plus nombreux
    que les fichiers de programme.

    L'avertissement est la règle qui compte pour le cours 2 : un dépôt
    n'avale pas les données. Un `.csv` de dix lignes qui sert à essayer le
    programme, oui ; le relevé de trois cents mégaoctets, non, et une image
    ou un `.xlsx` encore moins — ils ne se comparent pas ligne à ligne et
    alourdissent l'historique pour toujours.

    Où vont les données, alors : à côté du projet, dans un dossier que le
    programme reçoit en paramètre. C'est ce que fait `make_data.py` du
    module, et ce que le TD du cours 7 demandera.

    Le `README` est nommé dès maintenant ; le TD 3a versionne la recette,
    écrite en Markdown.
  ]
]
#d("Le format de la documentation")[
  #annonce[
    Un `.txt` n'a aucune mise en forme, un `.odt` en a mais se prête mal aux
    outils du code. Markdown est du texte brut où quelques signes portent la
    mise en forme, que l'éditeur sait rendre.
  ]

  #face-a-face(
    panneau[Ce qu'on écrit, `README.md`][
      #set text(size: 14pt)
      #raw(
        "# Trajet\n\nTrace le trajet de la gare à l'école.\n\n## Lancer\n\n    python trajet.py\n\nLe résultat est *trajet.png*.",
        block: true, lang: "md",
      )
    ],
    panneau("Ce que l'aperçu montre")[
      #block(width: 100%, inset: (x: 10pt, y: 7pt), stroke: 0.8pt + estompe.lighten(50%))[
        #text(size: 17pt, weight: "bold")[Trajet]
        #v(0.3em)
        #set text(size: 13.5pt)
        Trace le trajet de la gare à l'école.
        #v(0.35em)
        #text(size: 15pt, weight: "bold")[Lancer]
        #v(0.25em)
        #block(fill: gris, inset: (x: 7pt, y: 5pt), width: 100%)[
          #text(font: police-code, size: 12pt)[python trajet.py]
        ]
        #v(0.25em)
        Le résultat est #emph[trajet.png].
      ]
    ],
  )

  #legende[
    Moins de possibilités qu'un traitement de texte. En échange : l'éditeur, la
    comparaison ligne à ligne, le versionnement, et une conversion quand il en
    faut une.
  ]

  #notes[
    Le piège à désamorcer, sans quoi ils retournent à LibreOffice : « mon
    rapport doit être en PDF » n'est pas un argument contre Markdown,
    `pandoc` produisant le PDF depuis le `.md`. On perd le contrôle fin de
    la mise en page, on gagne de pouvoir relire, comparer et versionner.

    Le `.txt` n'est pas inférieur : c'est le format des sorties de programme
    et des relevés, où toute structure gênerait.

    Quatre signes suffisent pour un `README` : `#` pour un titre, une ligne
    vide entre deux paragraphes, quatre espaces pour du code, des étoiles
    pour l'emphase. La syntaxe complète est la diapositive suivante.
  ]
]
#d("L'intention de Markdown")[
  #annonce[
    John Gruber, 2004 : un format de texte facile à lire et à écrire,
    convertible en HTML, et publiable tel quel sans avoir l'air balisé.
  ]

  #face-a-face(
    panneau[Le fichier `.md`][
      ```markdown
      # Crêpes

      *1 heure de repos.*

      1. Mélanger la farine
      2. Casser les **œufs**
      ```
    ],
    panneau[Le même contenu en HTML][
      ```html
      <h1>Crêpes</h1>
      <p><em>1 heure de repos.</em></p>
      <ol><li>Mélanger la farine</li>
      <li>Casser les <strong>œufs</strong>
      </li></ol>
      ```
    ],
  )

  #legende[
    Les deux produisent le même affichage. Seul celui de gauche se lit sans
    être converti.
  ]

  #notes[
    Markdown est annoncé le 15 mars 2004 par John Gruber sur Daring
    Fireball. Aaron Swartz en est l'unique bêta-testeur ; les titres en
    `#` viennent d'atx, son propre format. L'inspiration revendiquée est
    le courriel en texte brut.

    L'intention, qui n'est pas évidente : Markdown n'est pas un HTML
    simplifié pour ceux qui n'y arriveraient pas. Sa contrainte de départ
    est que la source reste lisible sans conversion, et tout le reste en
    découle, y compris ce qu'il ne sait pas faire.

    Depuis 2014, CommonMark en fixe une spécification et une suite de
    tests. Ne le dire que si quelqu'un signale qu'un fichier ne rend pas
    pareil partout.
  ]
]

// --------------------------------------------
// Nouveau (v2).
#d("Tableau, bloc de code et image")[
  #annonce[
    Trois marques s'ajoutent à la syntaxe vue dans le notebook du cours 1.
    Le texte reste lisible sans aperçu.
  ]

  #face-a-face(
    panneau("Ce qu'on écrit")[
      #raw(
        "| Ingrédient | Quantité |\n|---|---|\n| Farine | 250 g |\n| Œufs | 4 |\n\n```bash\npandoc recette.md -o recette.html\n```\n\n![Une crêpe qui cuit.](crepes.jpg)",
        block: true, lang: "md",
      )
    ],
    panneau("Ce qui s'affiche")[
      #set text(size: 15pt)
      #table(
        columns: 2, stroke: 0.6pt + estompe.lighten(40%), inset: 5pt,
        [*Ingrédient*], [*Quantité*], [Farine], [250 g], [Œufs], [4],
      )
      #block(fill: gris, inset: 6pt, width: 100%)[
        #text(font: police-code, size: 12pt)[pandoc recette.md -o recette.html]
      ]
      #block(width: 100%, height: 42pt, stroke: 0.8pt + estompe.lighten(40%), inset: 6pt)[
        #text(size: 12pt, fill: estompe)[la photo `crepes.jpg`]
      ]
    ],
  )

  #legende[
    L'image n'est pas dans le `.md` : il en donne le chemin, relatif au
    fichier. La photo doit rester à côté.
  ]

  #notes[
    Un tableau n'est que des barres verticales ; leur alignement n'est pas
    obligatoire. La ligne `|---|---|` sépare l'en-tête.

    Le bloc de code : trois accents graves avant et après, le langage après
    les trois premiers pour la coloration. `AltGr` + `7` sur un clavier
    français.

    Le diagramme `mermaid` du TD 3a de 2026 est en annexe.
  ]
]

// --------------------------------------------
// Nouveau (v2).
#d("Convertir un fichier Markdown : pandoc")[
  #annonce[
    pandoc lit un fichier Markdown et écrit le même contenu dans un autre
    format. Il déduit le format de l'extension du fichier demandé.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Commande], [Produit], [S'ouvre avec],
    [`pandoc recette.md -o recette.html`], [une page web], [le navigateur],
    [`pandoc recette.md -o recette.odt`], [un document], [LibreOffice Writer],
    [`pandoc recette.md -o recette.pdf`], [un PDF], [passe par un moteur PDF, absent des postes],
  )

  #legende[
    `-o` pour _output_ : le fichier à écrire. Le `.md` reste la source ; les
    fichiers produits se refont par la même commande.
  ]

  #notes[
    pandoc est dans l'environnement `base` d'Anaconda sur les postes
    (confirmé par l'équipe, 26/09/2026).

    Le PDF passe par LaTeX ou typst (`--pdf-engine=typst`), non installés :
    ne pas le faire en séance.

    « Les fichiers produits se refont » prépare le `.gitignore` du TD 3a.
  ]
]

// --------------------------------------------
// Nouveau (v2).
#d("Le README d'un projet")[
  #annonce[
    `README.md`, à la racine d'un projet, décrit ce qu'il fait et comment
    s'en servir. La forge l'affiche en page d'accueil du dépôt.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Section], [Son contenu],
    [le titre et une phrase], [ce que fait le projet],
    [Installation], [ce qu'il faut installer, et la commande],
    [Utilisation], [la commande qui le lance, et ce qu'elle produit],
    [Données], [où sont les données, et d'où elles viennent],
  )

  #legende[
    Le README de chaque projet du module suit ce plan : cours 3 (la recette),
    projet 4 (l'animation), projet 7 (`RAPPORT.md`).
  ]

  #notes[
    Le README s'écrit pour quelqu'un qui découvre le dossier : un camarade,
    un correcteur, soi-même dans six mois.

    La forge (cours 6) le convertit en page web, comme pandoc.
  ]
]
