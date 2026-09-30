// Partie 3 du cours 1 — incluse par `cours1.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas_notebooks.typ": schema-notebook

// ========================= Markdown et notebook ============================

#separateur(
  "Markdown et notebook",
  annonce: "Le format de texte dans lequel s'écrit la documentation d'un projet, et le document qui en fait un carnet exécutable",
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

    Le `README` est nommé dès maintenant : livrable de fin de séance, et
    premier commit du cours 2.
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
#d("La syntaxe de Markdown")[
  #annonce[
    Une dizaine de marques suffisent, et le texte reste lisible sans être
    rendu : le dièse annonce un titre, le tiret une puce, les astérisques
    une emphase.
  ]

  #face-a-face(
    panneau("Ce qu'on écrit")[
      ```markdown
      # Un titre
      ## Un sous-titre

      Du texte, de l'*emphase*,
      du **gras**.

      - une puce
      1. une étape

      [un lien](https://typst.app)
      ![une photo](poele.jpg)
      ```
    ],
    panneau("Ce qui s'affiche")[
      #block(inset: 9pt, stroke: 0.8pt + estompe.lighten(50%), width: 100%)[
        #set text(size: 13pt)
        #text(size: 19pt, weight: "bold")[Un titre] \
        #text(size: 15pt, weight: "bold")[Un sous-titre]
        #v(0.3em)
        Du texte, de l'#text(style: "italic")[emphase], du
        #text(weight: "bold")[gras].
        #v(0.3em)
        • une puce \
        1. une étape
        #v(0.3em)
        #text(fill: accent)[#underline[un lien]] \
        #text(fill: estompe)[▭ une photo]
      ]
    ],
  )

  #legende[
    Syntaxe complète, publiée par Gruber :
    #link("https://daringfireball.net/projects/markdown/syntax")[daringfireball.net/projects/markdown/syntax].
  ]

  #notes[
    Ne pas faire apprendre la liste. Ce qui compte est que la colonne de
    gauche se lise déjà : l'intention de Gruber rendue concrète.

    Deux pièges, une minute chacun. Une ligne vide sépare les paragraphes,
    sans quoi deux lignes consécutives n'en font qu'un. Le dièse veut un
    espace : `#Titre` ne produit pas un titre.

    Lien et image : même syntaxe, un point d'exclamation devant pour
    l'image. Le chemin de l'image est relatif au `.md`, occasion de
    rappeler les chemins de la partie 1.

    Ce que la colonne de gauche ne montre pas et qui sert au TD 1f : un
    tableau s'écrit avec des barres verticales, un bloc de code entre trois
    accents graves. Renvoyer à la page de Gruber, en légende.

    L'aperçu est `Ctrl` + `Maj` + `V`, côte à côte avec `Ctrl` + `K` puis
    `V`.
  ]
]

// ------------------ Les bibliothèques dont le projet dépend -----------------

#d("Programmation littérale")[
  #annonce[
    Le texte, le code et son résultat tiennent dans un seul document.
  ]

  #align(center, schema-notebook())

  #legende[
    Trois sortes de blocs, dans l'ordre où on les écrit. Le terme est de Donald
    Knuth, 1984.
  ]

  #notes[
    L'idée à faire passer, et la seule : ailleurs, le code est dans un
    fichier, l'explication dans un autre, et le résultat nulle part. Ici
    les trois sont au même endroit, et dans l'ordre du raisonnement.

    Le bloc de texte s'écrit en Markdown — celui de la partie précédente,
    sans rien de neuf à apprendre.

    Le résultat est enregistré dans le document : rouvert demain, il
    affiche encore ce que le code a produit aujourd'hui. C'est ce qui rend
    un notebook lisible sans l'exécuter, et ce qui le fait mal se
    versionner, diapositive suivante.

    Knuth : « Considérons les programmes comme des œuvres de littérature ».
    Une phrase, sans développer ; c'est le nom de l'idée qui sert, pas son
    histoire.

    Ce qu'un notebook n'est pas : un moyen de livrer un outil. On y
    explore et on y explique ; ce qui doit tourner tout seul devient un
    script, au cours 3.
  ]
]
#d("Le bloc de texte : du Markdown")[
  #annonce[
    Le bloc de texte s'écrit en Markdown, et s'affiche mis en forme.
  ]

  #face-a-face(
    panneau("Ce qu'on tape dans le bloc")[
      ```markdown
      # Longueur d'un trajet

      Les points du trajet sont donnés en
      **coordonnées projetées**, en mètres.
      ```
    ],
    panneau("Ce que le notebook affiche")[
      #v(0.4em)
      #text(size: 24pt, weight: demi-gras)[Longueur d'un trajet]
      #v(0.5em)
      #text(size: 16pt)[
        Les points du trajet sont donnés en #strong[coordonnées projetées],
        en mètres.
      ]
    ],
  )

  #legende[
    Le `#` fait un titre, les deux astérisques mettent en gras : rien de neuf
    depuis le TD 1f, Markdown.
  ]

  #notes[
    Rien à apprendre ici, et c'est le propos : le Markdown écrit une demi-
    heure plus tôt sert tel quel dans un notebook. Le dire, puis passer.

    Le bloc bascule entre les deux états : `Maj` + `Entrée` affiche la mise
    en forme, un double clic revient au texte source. C'est la même
    alternance que l'aperçu de l'éditeur.

    Un bloc de texte ne s'exécute pas au sens du code : il n'y a pas de
    noyau derrière, seulement une mise en forme. Le numéro `[1]` n'apparaît
    donc que sur les blocs de code.
  ]
]
#d("Un notebook dans JupyterLab")[
  #annonce[
    Les trois sortes de blocs dans une vraie fenêtre.
  ]

  #align(center)[
    #if captures-disponibles {
      box(stroke: 1pt + accent.lighten(55%),
          image("/illustrations/cours1/notebook_jupyterlab.png", width: 88%))
    } else {
      scale(78%, reflow: true, schema-notebook())
    }
  ]

  #legende[
    Capture réelle. Le code y calcule la longueur d'un trajet de quatre points.
  ]

  #notes[
    Montrer où sont les trois blocs de la diapositive précédente, dans
    l'ordre : le titre et la phrase en haut, la cellule de code au milieu
    avec son `[1]`, la sortie juste en dessous, puis le texte qui commente
    le résultat.

    Le `[1]` est le rang d'exécution, pas le rang dans le document. Une
    cellule relancée passe à `[2]` : c'est ce qui trahit un notebook
    exécuté dans le désordre.

    À droite en haut, le nom du noyau, `Python 3 (ipykernel)`. C'est ce
    qu'on choisit à l'ouverture, et le sujet du TD 4.

    À gauche, l'arborescence : un notebook est un fichier dans un dossier,
    comme le reste.
  ]
]
#d("Lancer JupyterLab depuis Anaconda")[
  #annonce[
    JupyterLab est livré avec Anaconda, et se lance depuis la page d'accueil de
    Navigator, comme VS Code au TD 1c.
  ]

  #align(center, illustration(
    "/illustrations/cours1/anaconda_navigator_accueil.png",
    fenetre("Anaconda Navigator — Home", hauteur: 210pt)[
      #text(size: 13pt, fill: estompe)[
        une fiche par application, chacune avec son bouton *Launch*
      ]
    ],
    hauteur: 214pt,
  ))

  #legende[
    La même page qu'au TD 1c, une fiche plus loin. Le numéro sous le nom est
    la version installée : il n'y a rien à installer.
  ]

  #notes[
    Deux façons d'ouvrir la même application, et c'est le propos : la fiche de
    Navigator et `jupyter lab` au terminal lancent le même serveur. La seconde
    est celle que le TD fait taper, parce qu'elle montre l'adresse.

    Le mot « Launch » sous JupyterLab, et non « Install » : la distribution
    Anaconda pose JupyterLab dans `base`, avec `ipykernel`. C'est ce qui
    permet au TD de se faire sans rien installer, et c'est aussi ce dont VS
    Code a besoin pour exécuter un notebook. Une installation Miniconda ou
    Miniforge, elle, part d'un `base` minimal : la fiche porterait
    « Install ». Le TD 1i le fait vérifier au lieu de le supposer.

    Ce qui s'ouvre est un onglet de navigateur sur une adresse `localhost` :
    la page est chez eux, le serveur aussi. Le dire ici et le faire
    constater au TD ; le pourquoi est à la partie 4.

    Ne pas ouvrir Spyder ni Qt Console : une application, un TD.
  ]
]
