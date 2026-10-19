// TD 1d du cours 1 v2 — « Un notebook dans JupyterLab ».
//
// Le TD 1g de 2026, réduit à JupyterLab, avec une cellule de texte à écrire.
// Le notebook, `altitudes.ipynb`, est construit depuis
// `src/cours1_v2/notebook/td/1d_notebook/altitudes.md` par
// `outils/construire_notebooks.py`.
//
// Relecture du 19/10/2026 : « Lancer JupyterLab » et « La syntaxe minimale
// de Markdown » viennent de la partie 3 (`parties/03_notebook.typ`) ; la
// première ouvre le TD, la seconde précède l'étape qui écrit une cellule de
// texte. Elles sont donc aussi sur la feuille du TD, et ne sont plus dans la
// version sans les TD.
//
// Inclus par `cours1_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 1_v2`.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "1d",
  titre: "Un notebook dans JupyterLab",
  annonce: "Objectif : exécuter un notebook dans JupyterLab, voir ce que le noyau retient d'une cellule à l'autre, et documenter le notebook en Markdown",
  dossier: "cours1/1d_notebook/",
  duree: "12′",
)
#separateur-td(..td)

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


#d("Exécuter les cellules")[
  #annonce[
    `altitudes.ipynb` contient le programme du TD 1c, découpé en cellules.
    Pour exécuter une cellule, cliquer dedans, puis taper `Maj` + `Entrée`.
  ]

  #tableau(
    columns: (auto, 1.2fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [invite de commandes d'Anaconda, `cd Desktop\info01\cours1\1d_notebook`, `jupyter lab` ; ouvrir `altitudes.ipynb`],
      reponse[les cellules de code n'ont pas encore de numéro],
    [2], [exécuter les cellules une à une, de haut en bas],
      reponse[`[1]`, `[2]`… à gauche, dans l'ordre ; la moyenne vaut `129.0`],
    [3], [exécuter une seconde fois la cellule de la boucle, puis celle de la moyenne],
      reponse[`258.0` : le noyau a gardé `total`, la boucle l'a encore augmenté],
    [4], [Kernel #sym.arrow.r Restart Kernel and Run All Cells],
      reponse[les numéros repartent de `[1]`, la moyenne revient à `129.0`],
  )

  #legende[
    Le numéro entre crochets donne l'ordre dans lequel les cellules ont été
    exécutées.
  ]

  #notes[
    Étape 3 : `total` passe de 387,0 à 774,0, et la moyenne à 258,0. Le
    notebook sépare `total = 0` de la boucle pour que ce soit visible (le
    notebook du TD 1g de 2026 remettait `total` à zéro dans la même cellule,
    et la relance ne changeait rien).

    En français, si JupyterLab l'est sur les postes : Noyau, Redémarrer le
    noyau et exécuter toutes les cellules.
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

#d("Ajouter une cellule de texte")[
  #annonce[
    Une cellule de texte en tête du notebook, écrite en Markdown, décrit ce
    que fait le programme.
  ]

  #tableau(
    columns: (auto, 1.2fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [cliquer sur la première cellule, touche `Échap`, puis `A`],
      reponse[une cellule vide apparaît au-dessus],
    [2], [touche `M`, ou « Markdown » dans la liste en haut de la page],
      reponse[le `[ ]` disparaît : une cellule de texte n'a pas de numéro],
    [3], [y écrire un titre, une phrase, la liste des données, un lien],
      reponse[le texte reste brut tant qu'on l'édite],
    [4], [`Maj` + `Entrée` ; double-clic pour revenir au texte],
      reponse[titre, liste et lien mis en forme],
    [5], [`Ctrl` + `S`], reponse[le notebook est enregistré],
    [6], [si le temps le permet : `Ctrl` + `C` dans l'invite, puis `jupyter lab` depuis Git Bash],
      reponse[le notebook rouvert garde la cellule de texte],
  )

  #notes[
    Exemple à ne projeter qu'en fin de TD :
    `# Moyenne des altitudes`, une ligne vide, `Calcule la moyenne de trois
    altitudes, en mètres.`, puis `- 128.4`, `- 131.0`, `- 127.6`, puis
    `[Jupyter](https://jupyter.org)`.

    `A` insère au-dessus, `B` au-dessous, en mode commande (`Échap`).
  ]
]
