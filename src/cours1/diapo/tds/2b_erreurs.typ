// TD 2b du cours 1 — « Trois programmes fautifs ».
//
// Inclus par `cours1.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`, qui
// en tire la feuille de TD déposée dans le dossier annoncé. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "2b",
  titre: "Trois programmes fautifs",
  annonce: "Objectif : lire les messages d'erreur de Python et corriger la ligne qu'ils désignent, sur trois programmes",
  dossier: "cours1/2b_erreurs/",
  duree: "10′",
)
#separateur-td(..td)

#d("Afficher les caractères invisibles")[
  #annonce[
    Un espace et une tabulation ne se distinguent pas à l'œil. L'éditeur sait
    les dessiner, et dire ce qu'il insère.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [L'action], [Ce qu'elle donne],
    [`View` #sym.arrow.r `Render Whitespace` #sym.arrow.r `All`],
      [un point médian par espace, une flèche par tabulation],
    [`Spaces: 4`, dans la barre d'état],
      [ce que la touche de tabulation insère ; cliquer dessus pour le changer],
    [`LF` ou `CRLF`, dans la barre d'état],
      [comment les lignes se terminent : un caractère sous Linux et macOS, deux sous Windows],
    [`Ctrl` + `Maj` + `P`, puis « render whitespace »],
      [la même bascule sans passer par les menus],
  )

  #legende[
    Les intitulés sont ceux de l'interface en anglais, celle qu'on a par
    défaut. En français : Affichage #sym.arrow.r Rendu des espaces #sym.arrow.r Tout.
  ]

  #notes[
    Le faire faire, machine ouverte, avant de projeter la diapositive suivante :
    c'est à faire, pas à expliquer.

    À laisser activé toute l'année. C'est le seul moyen de voir qu'une
    indentation mélange espaces et tabulations, et cela reviendra au cours 2
    quand git signalera des lignes modifiées qui semblent identiques.

    La barre d'état est en bas à droite. `Spaces: 4` se règle par fichier ;
    l'extension Python la met à 4 d'elle-même, ce qui est la convention du
    langage.

    Les fins de ligne : un fichier n'a pas la même taille selon la machine qui
    l'a écrit. Nommer `LF` et `CRLF` aujourd'hui suffit, le cours 2 y revient.
  ]
]

// Sans capture, cette diapositive n'ajouterait rien au bloc de la précédente.
#if captures-disponibles {
d("Les caractères invisibles, affichés")[
  #annonce[
    Les mêmes lignes, une fois l'affichage des espaces activé : la deuxième est
    indentée par quatre espaces, la troisième par une tabulation.
  ]

  #align(center)[
    #illustration(
      "/illustrations/cours1/vscode_espaces.png",
      none,
      hauteur: hauteur-capture-pleine,
    )
  ]

  #legende[
    Un point par espace, une flèche par tabulation. En bas à droite,
    `Spaces: 4` et `LF`.
  ]

  #notes[
    Faire pointer la ligne 3 par la salle avant de la désigner : c'est la
    seule qui diffère, et elle ne se distingue pas sans cet affichage.

    Le message d'erreur désigne la bonne ligne. Lire le numéro de ligne
    d'une erreur est un réflexe à prendre aujourd'hui.
  ]
]
}
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
    programmes affichent `294.0`, `130.05` et `1341 caractères`. L'éditeur
    souligne les deux premières fautes avant tout lancement ; pas la
    troisième.
  ]

  #notes[
    L'ordre des trois fautes est celui de leur difficulté de lecture ; le
    suivre.

    La première ne se voit pas à l'œil, les deux lignes étant alignées à
    l'écran. C'est là qu'on fait activer l'affichage des espaces,
    Affichage #sym.arrow.r Rendu des espaces #sym.arrow.r Tout. Réglage à
    garder toute l'année.

    La deuxième se voit dans le message, qui nomme le caractère attendu et
    place un accent circonflexe sous l'endroit exact. Faire lire le
    message en entier.

    La troisième est d'une autre nature, et c'est le point : le programme est
    correct, l'éditeur ne souligne rien, et il tourne chez Alice. Il échoue
    ici parce que le chemin absolu qu'il contient n'existe que sur son poste.
    Le chemin relatif part du dossier où le terminal se trouve, `2b_erreurs/`,
    remonte d'un cran et va chercher le fichier du TD 1a : il vaut sur tous
    les postes, Windows compris. C'est la diapositive « Le chemin d'un
    fichier » vérifiée par eux, et l'erreur la plus fréquente des rendus des
    autres cours.

    La vérification demandée n'est pas que le programme affiche le bon
    résultat, mais qu'il n'affiche plus de message.
  ]
]
