// Dernière diapositive de la partie « L'éditeur de code », juste avant le
// TD 1a qui configure la fenêtre qu'elle montre. Incluse par `cours2_v2.typ`.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": fenetre-vscode

// --------------------------------------------
// Venue de la partie « Configurer l'éditeur de code » (retirée le
// 28/09/2026) ; reprise de la diapositive 48 du cours 1 de 2026, avec une
// fenêtre dessinée (`../schemas.typ`).
#d("Visual Studio Code")[
  #annonce[
    L'éditeur du module a trois zones : l'arborescence du dossier ouvert, le
    fichier, et le terminal, qui part de ce dossier.
  ]

  #fenetre-vscode(hauteur: 240pt)

  #notes[
    Schéma de la fenêtre après la configuration du TD 1a. En bas, la barre
    d'état : position, indentation, encodage, fin de ligne, interpréteur
    (TD 1b).

    Générique : une extension par langage, et une configuration qui dépend
    du système. Le panneau git vient au TD 3a.

    Faire retrouver les trois zones sur les postes au début du TD 1a.

    La commande du terminal part du dossier ouvert, `cours2` : le chemin
    du programme est relatif à lui.

    Un éditeur de code enregistre du texte brut ; les couleurs et les
    numéros de ligne ne sont qu'un affichage.

    VS Code s'affiche en anglais par défaut ; le module ne demande pas d'en
    changer. Les intitulés cités dans les TD sont les intitulés anglais.
  ]
]
