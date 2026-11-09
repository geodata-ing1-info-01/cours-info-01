// TD 2b du cours 2 v2 — « Trois programmes fautifs ».
//
// Le TD 1d de 2026, dans VS Code et son terminal Git Bash. Joué au cours 1 v2
// (alors TD 2c, dans Notepad++) jusqu'au 27/09/2026, puis passé au cours 2 v2 avec
// la diapositive sur l'indentation, après la partie sur l'éditeur de code.
//
// Inclus par `cours2_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 2_v2`.
#import "../../../commun/prelude.typ": *
#import "../../../cours1_v2/diapo/schemas.typ": consignes, comment, commandes, constat

#let td = (
  numero: "2b",
  titre: "Trois programmes fautifs",
  annonce: "Objectif : lire ce que l'éditeur montre d'un fichier, puis les messages d'erreur de Python, et corriger la ligne qu'ils désignent, sur trois programmes",
  dossier: "cours2/2b_erreurs/",
  duree: "10′",
)
#separateur-td(..td)

// 04/11/2026 : le tableau devient une liste de consignes, comme au cours 1 v2.
// 09/11/2026 : le dossier du TD ouvert dans VS Code, lancement par le bouton.
// « Les caractères invisibles dans VS Code » fondue dans la légende de la
// diapositive suivante le 28/09/2026 (le réglage est fait au TD 2a).
#d("Messages d'erreur de Python : trois programmes")[
  #objectif[
    ouvrir le dossier `cours2/2b_erreurs` dans VS Code, puis corriger `surface.py`, `moyenne.py`
    et `chemin.py` à partir de leurs messages d'erreur.
  ]

  #consignes(
    taille: 15pt,
    [Ouvrir `Desktop\info01\cours2\2b_erreurs` dans VS Code : #comment[File, Open Folder…, puis « Yes, I trust the authors ».]
      #constat[`2B_ERREURS` en haut de l'arborescence, avec `depart` et `travail`.]],
    [Copier les trois programmes dans `travail/`, dans un nouveau terminal : #comment[menu Terminal, New Terminal.] #commandes("cp depart/*.py travail/")],
    [Ouvrir `travail/surface.py`, puis le lancer avec le bouton #sym.triangle.filled.r. Lire le message, corriger la ligne qu'il désigne, puis relancer.
      #constat[`TabError: inconsistent use of tabs and spaces`, ligne 6 : la ligne 6 est indentée par une tabulation, la ligne 5 par des espaces.]],
    [Faire de même avec `travail/moyenne.py`.
      #constat[`SyntaxError: expected ':'`, ligne 6 : il manque les deux-points à la fin du `for`.]],
    [Faire de même avec `travail/chemin.py`.
      #constat[`FileNotFoundError: No such file or directory: 'C:/Users/alice/…'` : le chemin est celui d'un autre poste. Écrire `../../cours1/1a_formats/depart/raven_une_ligne.txt`.]],
  )

  #legende[
    Chacun des trois fichiers de `depart/` porte une faute d'un genre différent.
    VS Code dessine un point par espace et une flèche par tabulation (réglage
    du TD 2a) ; la barre d'état, en bas à droite, indique l'indentation et
    la fin de ligne, `LF` ou `CRLF`. Une fois corrigés, les trois programmes
    affichent `294.0`, `93.4` et `1341 caractères`.
  ]

  #notes[
    L'ordre des trois fautes est celui de leur difficulté de lecture ; le
    suivre. Le terminal de VS Code s'ouvre dans le dossier ouvert, `2b_erreurs/`. La
    commande de copie n'a donc pas besoin de `cd`, et le bouton lance chaque programme
    depuis ce dossier.

    Dans `2b_erreurs`, ouvert pour la première fois, l'extension prend `base` grâce au
    réglage `python.defaultInterpreterPath` du TD 2a, et la barre d'état affiche
    `('base')`. Sinon, vérifier ce réglage dans `settings.json`.

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
    Le chemin relatif part du dossier où le terminal se trouve, `2b_erreurs/`,
    remonte de deux dossiers et va chercher le fichier du TD 1a :
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
