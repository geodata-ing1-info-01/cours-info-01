// TD 2c du cours 1 v2 — « Trois programmes fautifs ».
//
// Le TD 2b de 2026, joué dans Notepad++ et Git Bash à la place de VS Code.
//
// Inclus par `cours1_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 1_v2`.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "2c",
  titre: "Trois programmes fautifs",
  annonce: "Afficher les caractères invisibles, puis corriger trois programmes Python qui refusent de s'exécuter",
  dossier: "cours1/2c_erreurs/",
  duree: "10′",
)
#separateur-td(..td)

// Nouveau (v2) : les menus de Notepad++ à la place de ceux de VS Code.
#d("Afficher les caractères invisibles")[
  #annonce[
    Un espace et une tabulation ne se distinguent pas à l'œil. Notepad++ peut
    les dessiner.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [L'action, dans Notepad++], [Ce qu'elle donne],
    [Affichage #sym.arrow.r Symboles spéciaux #sym.arrow.r Afficher tous les caractères],
      [un point par espace, une flèche par tabulation, `CR` `LF` en fin de ligne],
    [la barre d'état, en bas à droite],
      [`Windows (CR LF)` ou `Unix (LF)` : comment les lignes se terminent],
  )

  #legende[
    Intitulés de Notepad++ en français, à vérifier sur la version installée
    dans la salle.
  ]

  #notes[
    Le faire faire, machine ouverte, avant de projeter la diapositive suivante :
    c'est à faire, pas à expliquer.

    Les fins de ligne : un caractère sous Linux et macOS, deux sous Windows.
    Les nommer ; git y revient au cours 2.

    VS Code, au cours 2 : Affichage, Rendu des espaces, Tout.
  ]
]
#d("Corriger trois programmes")[
  #annonce[
    Chacun des trois fichiers de `depart/` porte une faute d'un genre
    différent. Les copier dans `travail/`, lancer, lire le message, corriger,
    relancer.
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
      reponse[le chemin est celui d'un autre poste ; écrire `../1a_formats/depart/raven_une_ligne.txt`],
  )

  #legende[
    Messages réels, obtenus avec Python 3.12. Une fois corrigés, les trois
    programmes affichent `294.0`, `130.05` et `1341 caractères`.
  ]

  #notes[
    L'ordre des trois fautes est celui de leur difficulté de lecture ; le
    suivre. Copier les fichiers au terminal, `cp depart/*.py travail/`, et les
    lancer depuis `2c_erreurs/` : `python travail/chemin.py`.

    v2 : Notepad++ ne souligne aucune faute. VS Code, au cours 2, souligne
    les deux premières avant tout lancement ; pas la troisième.

    La première ne se voit pas à l'œil, les deux lignes étant alignées à
    l'écran. C'est là qu'on fait activer l'affichage des espaces,
    Affichage #sym.arrow.r Rendu des espaces #sym.arrow.r Tout. Réglage à
    garder toute l'année. v2 : dans Notepad++, Affichage, Symboles
    spéciaux, Afficher tous les caractères.

    La deuxième se voit dans le message, qui nomme le caractère attendu et
    place un accent circonflexe sous l'endroit exact. Faire lire le
    message en entier.

    La troisième est d'une autre nature, et c'est le point : le programme est
    correct, l'éditeur ne souligne rien, et il tourne chez Alice. Il échoue
    ici parce que le chemin absolu qu'il contient n'existe que sur son poste.
    Le chemin relatif part du dossier où le terminal se trouve, `2c_erreurs/`,
    remonte d'un cran et va chercher le fichier du TD 1a : il vaut sur tous
    les postes, Windows compris. C'est la diapositive « Le chemin d'un
    fichier » vérifiée par eux, et l'erreur la plus fréquente des rendus des
    autres cours.

    La vérification demandée n'est pas que le programme affiche le bon
    résultat, mais qu'il n'affiche plus de message.
  ]
]
