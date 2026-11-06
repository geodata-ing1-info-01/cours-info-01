// Partie 2 du cours 3 v2 : les mémoires et leurs ordres de grandeur. Incluse par
// `02a_lecture.typ`, après « Lecture d'un fichier : du disque au processeur ».
//
// Les diapositives sur les mémoires sont reprises du cours 5 le 04/11/2026
// (`cours5/diapo/parties/01_materiel.typ`), qui garde les siennes. Fusionnées deux
// à deux le 05/11/2026.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../../../cours5/diapo/schemas.typ": pyramide-memoire, barres-temps

// --------------------------------------------
// Fusion de « Mémoire vive et disque » et de « Hiérarchie des mémoires »
// (05/11/2026) : la pyramide reprenait déjà les tailles, les temps et l'effacement.
#d("Hiérarchie des mémoires")[
  #annonce[
    Les mémoires sont rangées selon leur proximité du processeur, la
    plus proche en haut. La mémoire vive est rapide et s'efface à l'extinction ; le
    disque est lent et conserve son contenu.
  ]

  #align(center, pyramide-memoire())

  #legende[
    La mémoire vive contient les variables d'un programme en cours. Le disque
    contient les fichiers et les programmes installés.
  ]

  #notes[
    Plus l'étage est proche du processeur, plus il est petit et rapide : les
    deux colonnes le montrent. Le réseau garde les données sur un autre
    ordinateur, que l'extinction du poste ne touche pas.

    Au cours 1 : un fichier conserve un résultat après l'arrêt du programme.
    Il le peut parce qu'il est sur le disque. Un travail non enregistré n'est
    qu'en mémoire vive.

    SSD : mémoire flash, sans pièce mobile, 100 µs. Disque dur : plateau tournant,
    10 ms, cent fois plus lent à l'accès. Les postes de la salle ont un SSD (relevé
    au TD 3d, facultatif).

    Le cache est une petite mémoire dans le processeur ; il garde les dernières
    données lues en mémoire vive. Une boucle sur des valeurs voisines est donc
    plus rapide qu'une boucle qui saute dans un tableau.
  ]
]

// --------------------------------------------
// Fusion de « Ordres de grandeur : tailles » et de « Ordres de grandeur : temps
// d'accès » (05/11/2026). Les tailles sont sur une seule rangée, pour laisser la
// place aux barres.
#d("Ordres de grandeur : tailles et temps d'accès")[
  #{
    let taille(unite, exemple) = {
      set par(leading: 0.4em)
      show raw: set text(size: 12pt)
      text(size: 16pt, weight: demi-gras, fill: accent)[#unite]
      linebreak()
      text(size: 12pt, fill: estompe)[#exemple]
    }
    grid(
      columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr), column-gutter: 10pt,
      taille[1 octet][8 bits \ une lettre : `a`],
      taille[1 Ko][le poème du cours 1 : 1,3 Ko],
      taille[1 Mo][une photo de téléphone : 3 Mo],
      taille[100 Mo][une dalle d'orthophoto : 75 Mo],
      taille[1 Go][une heure de vidéo HD : 1 à 3 Go],
      taille[1 To][le disque d'un portable],
    )
  }

  #barres-temps(echelle: [si la mémoire vive valait 1 s], interligne: 0pt, (
    ([cache du processeur], 1e-9, [1 ns], accent, [un centième de seconde]),
    ([mémoire vive], 1e-7, [100 ns], accent, [1 seconde]),
    ([SSD], 1e-4, [100 µs], accent, [un quart d'heure]),
    ([disque dur], 1e-2, [10 ms], accent, [une journée]),
    ([réseau de la salle], 5e-4, [0,5 ms], attention, [une heure et demie]),
    ([Paris – Marseille], 1.3e-2, [13 ms], attention, [un jour et demi]),
    ([Paris – New York], 7.5e-2, [75 ms], attention, [une semaine]),
    ([Paris – Sydney], 2.7e-1, [270 ms], attention, [un mois]),
  ))

  #legende[
    Chaque unité de taille vaut mille fois la précédente. Temps d'un accès ou d'un
    aller-retour sur une échelle logarithmique : chaque graduation vaut dix fois la
    précédente. Réseau mesuré depuis Paris (wondernetwork.com, septembre 2026).
  ]

  #notes[
    L'octet est défini plus loin, à « Fichiers binaires et fichiers texte ».

    Tailles. Kilo, méga, giga, téra : les mêmes préfixes que pour les mètres.
    Kio, Mio, Gio valent 1 024, 1 024², 1 024³ octets. L'explorateur Windows
    affiche des Kio sous le nom « Ko » : un disque de 1 To y fait 931 « Go ».
    Le signaler sans s'y attarder. Anaconda installé : 5 Go.

    Dalle d'orthophoto : 5 000 × 5 000 pixels, soit 25 millions de pixels × 3 octets
    (rouge, vert, bleu), sans compression. Le cours 3 de 2026 compare les formats
    d'image (`images.ipynb`).

    Temps : valeurs typiques. Colonne de droite : les mêmes temps multipliés par
    dix millions.
    Du cache au disque dur, chaque étage prend cent à mille fois plus de temps
    que le précédent. Les temps réseau, en bleu clair, commencent au niveau du
    disque dur.

    Ce sont des temps d'accès, jusqu'au premier octet. Le débit est traité au
    cours 5.

    Pendant une lecture sur le disque dur, le processeur pourrait faire
    l'équivalent d'une journée d'accès à la mémoire ; pendant un aller-retour
    vers New York, une semaine.

    Construction reprise de Brendan Gregg, *Systems Performance*, avec le cycle
    du processeur pour unité.

    Conséquences pour un programme, à dire :
    - lire un fichier une fois et garder son contenu en mémoire ;
    - écrire des nombres en binaire (images P5, `images.ipynb`) ;
    - numpy à la place d'une boucle Python (projet 7) ;
    - `commit` en local, `push` sur le réseau (cours 6).

    Mesurer avant de modifier : objet du projet 7.
  ]
]
