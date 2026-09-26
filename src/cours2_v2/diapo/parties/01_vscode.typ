// Partie 1 du cours 2 v2 — l'éditeur de code, avant sa configuration.
// Incluse par `cours2_v2.typ`. Un fichier inclus n'hérite pas des imports de
// son appelant.
#import "../../../commun/prelude.typ": *
#import "../../../cours1/diapo/schemas.typ": capture-ide

// Nouveau (v2).
#separateur(
  "Configurer l'éditeur de code",
  annonce: "Toute la salle fait la même étape en même temps ; on passe à la suivante quand chacun a fini.",
)

// Reprise de la diapositive 48 du cours 1 de 2026.
#d("Visual Studio Code")[
  #align(center, capture-ide(hauteur: 330pt))

  #notes[
    L'annonce est passée ici pour laisser la place à la capture : l'éditeur du
    module, générique, une extension par langage, et trois zones aujourd'hui.

    Dire le choix et ses conséquences : VSCode n'est pas le seul éditeur, c'est
    celui du module. Il est générique, donc il faut le configurer pour chaque
    langage, par une extension, et la configuration dépend du système — c'est
    ce que la diapositive précédente vient de montrer sur le compilateur C++.

    Faire ouvrir la fenêtre en même temps, et faire retrouver les trois zones
    chez eux : les couleurs de la capture ne servent qu'à les nommer une fois.

    À faire remarquer sur la capture, sans l'écrire : `trajet.png` vient
    d'apparaître dans l'arborescence, produit par la commande tapée en bas.
    Les trois zones se répondent.

    Un éditeur de code n'est pas un traitement de texte : il enregistre du
    texte brut, et ce qu'il ajoute à l'écran — couleurs, numéros de ligne
    — est un affichage, pas du contenu.

    Les trois zones suffisent pour la configuration ; le panneau git vient
    au TD 3a.

    VSCode s'affiche en anglais par défaut ; le module ne demande pas d'en
    changer. Les intitulés cités plus loin sont donc les intitulés anglais.
  ]
]

