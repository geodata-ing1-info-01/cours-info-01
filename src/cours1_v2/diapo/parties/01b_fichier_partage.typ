// Partie du cours 1 v2 — incluse par `cours1_v2.typ` juste après le TD 1a.
// Un fichier inclus n'hérite pas des imports de son appelant.
//
#import "../../../commun/prelude.typ": *

// --------------------------------------------
#d("Modifications simultanées d'un fichier partagé")[
  #annonce[
    Un fichier du dossier partagé est le même pour toute la salle. Avec un
    éditeur de texte, le dernier qui enregistre remplace la version de
    l'autre.
  ]

  #chaine(
    ("10 h 00", "Alice ouvre info01-salle.txt dans formationTemp"),
    ("10 h 02", "Bruno ouvre le même fichier"),
    ("10 h 10", "Alice ajoute son prénom et enregistre"),
    ("10 h 15", "Bruno ajoute le sien et enregistre : le prénom d'Alice a disparu"),
  )

  #v(0.4em)
  #avertissement[
    Ne pas travailler dans `formationTemp`. Copier les fichiers sur le poste,
    et travailler dans la copie.
  ]

  #notes[
    Avant de projeter : demander combien de prénoms chacun a lus dans
    `info01-salle.txt` à la fin du TD 1a. Chaque Bloc-notes a lu le fichier
    à l'ouverture, puis l'a réécrit en entier avec une seule ligne ajoutée.
    Le fichier rouvert est celui du dernier enregistrement ; les prénoms en
    plus sont ceux d'élèves qui ont ouvert le fichier après un premier
    enregistrement.

    Cas vécu à la séance 1 de 2026 : du travail perdu dans `formationTemp`
    (`src/avant/donnees.md`).

    LibreOffice pose un fichier de verrou (`.~lock.raven.odt#`), et affiche
    un avertissement au second qui ouvre le document. Le Bloc-notes et Notepad++ ne le font
    pas.

    Git, au cours 2, et la forge, au cours 6, évitent ce problème : chacun
    travaille dans sa copie, et les modifications se fusionnent.
  ]
]
