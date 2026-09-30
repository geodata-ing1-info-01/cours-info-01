// Partie 3 du cours 1 v2 — un notebook et la syntaxe minimale de Markdown.
// Incluse par `cours1_v2.typ`. Un fichier inclus n'hérite pas des imports de
// son appelant.
//
// Reprend les diapositives 79 à 82 du cours 1 de 2026. La syntaxe de Markdown
// est réduite à ce qu'une cellule de texte demande ; l'intention de Markdown,
// la conversion par pandoc et le README sont au cours 2.
#import "../../../commun/prelude.typ": *
#import "../../../cours1/diapo/schemas_notebooks.typ": schema-notebook

#separateur(
  "Un notebook et la syntaxe de Markdown",
  annonce: "Un document qui réunit du texte, du code et ses résultats ; le texte s'y écrit en Markdown.",
)

#d("Programmation littérale")[
  #annonce[
    Le texte, le code et son résultat tiennent dans un seul document. Les
    cours et les TD de Python du module emploient des notebooks, qu'il faut
    donc savoir lancer et exécuter.
  ]

  // 28/09 : la capture de « Un notebook dans JupyterLab », réunie ici.
  #align(center)[
    #if captures-disponibles {
      box(stroke: 1pt + accent.lighten(55%),
          image("/illustrations/cours1/notebook_jupyterlab.png", height: 165pt))
    } else {
      scale(70%, reflow: true, schema-notebook())
    }
  ]

  #legende[
    Du texte, une cellule de code et sa sortie, puis du texte. Le noyau, un
    programme Python lancé par JupyterLab, exécute les cellules et garde
    leurs variables. Le terme « programmation littérale » est de Donald
    Knuth, 1984.
  ]

  #notes[
    Pourquoi en parler dès le cours 1 : le notebook montre l'explication, le
    code et le résultat ensemble, ce qui sert à apprendre et à expliquer ;
    les cours 3 et 4 font leurs TD de Python dans des notebooks.

    L'idée à faire passer, et la seule : ailleurs, le code est dans un
    fichier, l'explication dans un autre, et le résultat nulle part. Ici
    les trois sont au même endroit, et dans l'ordre du raisonnement.

    v2 : le bloc de texte s'écrit en Markdown, dont la syntaxe minimale est
    deux diapositives plus loin.

    Le résultat est enregistré dans le document : rouvert demain, il
    affiche encore ce que le code a produit aujourd'hui. C'est ce qui rend
    un notebook lisible sans l'exécuter.

    Knuth : « Considérons les programmes comme des œuvres de littérature ».
    Une phrase, sans développer ; c'est le nom de l'idée qui sert, pas son
    histoire.

    Ce qu'un notebook n'est pas : un moyen de livrer un outil. On y
    explore et on y explique ; ce qui doit tourner tout seul devient un
    script, au cours 3.

    Sur la capture, montrer les trois blocs, dans
    l'ordre : le titre et la phrase en haut, la cellule de code au milieu
    avec son `[1]`, la sortie juste en dessous, puis le texte qui commente
    le résultat.

    Le `[1]` est le rang d'exécution, pas le rang dans le document. Une
    cellule relancée passe à `[2]` : c'est ce qui trahit un notebook
    exécuté dans le désordre.

    À droite en haut, le nom du noyau, `Python 3 (ipykernel)`. C'est ce
    qu'on choisit à l'ouverture ; les noyaux sont au cours 3.

    À gauche, l'arborescence : un notebook est un fichier dans un dossier,
    comme le reste.
  ]
]
// --------------------------------------------
// Nouveau (v2) : la syntaxe réduite à ce qu'une cellule de texte demande.
#d("La syntaxe minimale de Markdown")[
  #annonce[
    Une cellule de texte s'écrit en Markdown : du texte brut, où quelques
    signes indiquent la mise en forme.
  ]

  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
    [Ce qu'on tape], [Ce qui s'affiche],
    [`# Altitudes`, `## Les données`], [#text(size: 20pt, weight: "bold")[Altitudes] #h(0.6em) #text(size: 16pt, weight: "bold")[Les données]],
    [deux lignes séparées par une ligne vide], [deux paragraphes],
    [`du *texte* en **gras**`], [du #emph[texte] en #strong[gras]],
    [`- une puce`], [• une puce],
    [`1. une étape`], [1. une étape],
    [`[le site](https://jupyter.org)`], [#text(fill: attention)[#underline[le site]]],
    [``la variable `total` ``], [la variable #raw("total")],
  )

  #legende[
    Le texte tapé reste lisible sans être affiché mis en forme. Le cours 2
    y ajoute les tableaux et les images.
  ]

  #notes[
    Deux pièges, une minute chacun. Une ligne vide sépare les paragraphes,
    sans quoi deux lignes consécutives n'en font qu'un. Le dièse veut un
    espace : `#Titre` ne produit pas un titre.

    Intention de Markdown (John Gruber, 15 mars 2004, Daring Fireball) :
    un format facile à lire et à écrire, convertible en HTML, et lisible
    tel quel sans avoir l'air balisé. Syntaxe complète :
    daringfireball.net/projects/markdown/syntax. Depuis 2014, CommonMark en
    fixe une spécification.

    Dans JupyterLab, `Maj` + `Entrée` affiche la cellule mise en forme, un
    double-clic revient au texte tapé. Une cellule de texte n'a pas de
    numéro `[1]` : aucun noyau ne l'exécute. (28/09 : « Le bloc de texte :
    du Markdown » retirée, réunie ici.)
  ]
]
// --------------------------------------------
// Nouveau (v2) : remplace « Lancer JupyterLab depuis Anaconda » ; Navigator
// était lent à démarrer sur les postes en 2026. 27/09 : l'invite de commandes
// d'Anaconda d'abord, Git Bash ensuite.
#d("Lancer JupyterLab")[
  #annonce[
    JupyterLab est installé avec Anaconda, et se lance dans un terminal où
    conda est actif. Le module donne deux terminaux, pour ne pas être bloqué
    si le réglage de Git Bash manque sur un poste.
  ]

  #face-a-face(
    panneau("Depuis l'invite de commandes d'Anaconda")[
      #text(size: 16pt)[```console
      (base) …>cd Desktop\info01\cours1\1d_notebook
      (base) …>jupyter lab
      ```]
      #v(0.3em)
      #text(size: 15pt, fill: estompe)[
        Menu Démarrer, « Anaconda Prompt ». conda y est actif sans réglage :
        à essayer d'abord.
      ]
    ],
    panneau("Depuis Git Bash")[
      #text(size: 16pt)[```console
      $ cd ~/Desktop/info01/cours1/1d_notebook
      $ jupyter lab
      ```]
      #v(0.3em)
      #text(size: 15pt, fill: estompe)[
        Le terminal du module, après le réglage du TD 1c.
      ]
    ],
  )

  #legende[
    Le navigateur s'ouvre sur `localhost:8888`, le poste lui-même : le
    serveur de JupyterLab tourne sur le poste, et le terminal reste occupé
    tant qu'il tourne. `Ctrl` + `C` l'arrête. Le cours 5 y revient.
  ]

  #notes[
    En 2026, Navigator a mis plusieurs minutes à s'ouvrir sur les postes, et
    répondait parfois « already running » sans fenêtre. Il reste le dernier
    secours : page d'accueil, fiche JupyterLab, bouton Launch.

    L'invite de commandes d'Anaconda emploie `cmd` : chemins avec des `\`.
    Elle s'ouvre dans le dossier personnel, `C:\Users\eleve`, que l'invite
    affiche à la place de `…`. Nom du raccourci à vérifier sur les postes
    (« Anaconda Prompt »).

    Le client et le serveur d'un notebook sont au cours 5 (syllabus v2).
  ]
]
