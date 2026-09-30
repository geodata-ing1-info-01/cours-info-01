// TD 1b du cours 2 v2 — « Trois programmes fautifs ».
//
// Le TD 2b de 2026, dans VS Code et son terminal Git Bash. Joué au cours 1 v2
// (TD 2c, dans Notepad++) jusqu'au 27/09/2026, puis passé au cours 2 v2 avec
// la diapositive sur l'indentation, après la partie sur l'éditeur de code.
//
// Inclus par `cours2_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 2_v2`.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "1b",
  titre: "Trois programmes fautifs",
  annonce: "Objectif : lire ce que l'éditeur montre d'un fichier, puis les messages d'erreur de Python, et corriger la ligne qu'ils désignent, sur trois programmes",
  dossier: "cours2/1b_erreurs/",
  duree: "10′",
)
#separateur-td(..td)

// « Les caractères invisibles dans VS Code » fondue dans la légende de la
// diapositive suivante le 28/09/2026 (le réglage est fait au TD 1a).
#d("Corriger trois programmes")[
  #annonce[
    Chacun des trois fichiers de `depart/` porte une faute d'un genre
    différent. Les copier dans `travail/`, lancer, lire le message, corriger,
    relancer, dans le terminal de VS Code.
  ]

  #tableau(
    columns: (auto, 1.2fr, 1fr),
    align: left + horizon,
    [Fichier], [Ce que dit le message], [La faute],
    [`surface.py`],
      [`TabError: inconsistent use of tabs and spaces`, ligne 6],
      reponse[la ligne 6 est indentée par une tabulation, la ligne 5 par des espaces],
    [`moyenne.py`],
      [`SyntaxError: expected ':'`, ligne 6],
      reponse[il manque les deux-points à la fin du `for`],
    [`chemin.py`],
      [`FileNotFoundError: No such file or directory: 'C:/Users/alice/…'`],
      reponse[le chemin est celui d'un autre poste ; écrire `../../cours1/1a_formats/depart/raven_une_ligne.txt`],
  )

  #legende[
    VS Code dessine un point par espace et une flèche par tabulation (réglage
    du TD 1a) ; la barre d'état, en bas à droite, indique l'indentation et
    la fin de ligne, `LF` ou `CRLF`. Une fois corrigés, les trois programmes
    affichent `294.0`, `130.05` et `1341 caractères`.
  ]

  #notes[
    L'ordre des trois fautes est celui de leur difficulté de lecture ; le
    suivre. Copier les fichiers au terminal, `cp depart/*.py travail/`, et les
    lancer depuis `1b_erreurs/` : `python travail/chemin.py`.

    VS Code souligne les deux premières avant tout lancement ; pas la
    troisième.

    La première ne se voit pas à l'œil sans l'affichage des espaces, les deux
    lignes étant alignées à l'écran.

    La deuxième se voit dans le message, qui nomme le caractère attendu et
    place un accent circonflexe sous l'endroit exact. Faire lire le
    message en entier.

    La troisième est d'une autre nature : le programme est correct,
    l'éditeur ne souligne rien, et il fonctionne chez Alice. Il échoue
    ici parce que le chemin absolu qu'il contient n'existe que sur son poste.
    Le chemin relatif part du dossier où le terminal se trouve, `1b_erreurs/`,
    remonte de deux dossiers et va chercher le fichier du TD 1a du cours 1 :
    il vaut sur tous les postes où les deux archives sont extraites dans
    `info01/`. La diapositive « Le chemin d'un fichier » du cours 1 s'y
    vérifie, sur l'erreur la plus fréquente des rendus des autres cours.

    Messages réels, obtenus avec Python 3.12.

    La vérification demandée : le programme n'affiche plus de message
    d'erreur.

    Fins de ligne : un caractère sous Linux et macOS, deux sous Windows. Les
    nommer en montrant la barre d'état. Intitulés de la barre d'état à
    vérifier sur la version de VS Code des postes.
  ]
]
