// Partie 2 du cours 3 v2 : le disque et la mémoire vive. Incluse par
// `02b_encodage.typ`, après « Fichiers binaires et fichiers texte », où l'octet
// est défini, et avant « Fichier texte : une suite d'octets ».
//
// Les quatre premières diapositives sont reprises du cours 5 le 04/11/2026
// (`cours5/diapo/parties/01_materiel.typ`), qui garde les siennes. Seuls les
// renvois des notes changent. La cinquième est nouvelle.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../../../cours5/diapo/schemas.typ": pyramide-memoire, barres-temps
#import "../schemas_fichiers.typ": schema-lecture-memoire

// --------------------------------------------
#d("Mémoire vive et disque")[
  #annonce[
    Deux mémoires. La mémoire vive est rapide et s'efface à l'extinction ; le
    disque est lent et conserve.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [], [Mémoire vive (RAM)], [Disque (SSD, disque dur)],
    [Taille], [8 à 32 Go], [500 Go à 4 To],
    [Temps d'accès], [100 ns], [100 µs (SSD), 10 ms (disque dur)],
    [À l'extinction], [effacée], [conservé],
    [Ce qu'on y trouve], [les variables d'un programme en cours], [les fichiers, les programmes installés],
  )

  #legende[
    Au cours 1 : un fichier conserve un résultat après l'arrêt du programme.
    Il le peut parce qu'il est sur le disque.
  ]

  #notes[
    Ouvrir un fichier le copie du disque vers la mémoire vive ; l'enregistrer le
    recopie sur le disque. Un travail non enregistré n'est qu'en mémoire vive.

    SSD : mémoire flash, sans pièce mobile. Disque dur : plateau tournant, cent
    fois plus lent à l'accès. Les postes de la salle ont un SSD (relevé au
    TD 5a).
  ]
]

// --------------------------------------------
#d("Hiérarchie des mémoires")[
  #annonce[
    Les types de mémoire sont rangés selon leur proximité du processeur, le
    plus proche en haut.
  ]

  #align(center, pyramide-memoire())

  #notes[
    Plus l'étage est proche du processeur, plus il est petit et rapide : les
    deux colonnes le montrent. La couleur reprend la ligne « À l'extinction »
    de la diapositive précédente ; le réseau garde les données sur un autre
    ordinateur, que l'extinction du poste ne touche pas.

    Le cache est une petite mémoire dans le processeur ; il garde les dernières
    données lues en mémoire vive. Une boucle sur des valeurs voisines est donc
    plus rapide qu'une boucle qui saute dans un tableau.

    Le réseau est un étage de plus, au-delà du disque.
  ]
]

// --------------------------------------------
#d("Ordres de grandeur : tailles")[
  #annonce[
    Chaque unité vaut mille fois la précédente.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: (left + horizon, right + horizon, left + horizon),
    [Unité], [Octets], [Un exemple],
    [1 octet], [1], [une lettre : `a`],
    [1 Ko], [1 000], [le poème du cours 1, 1 341 caractères : 1,3 Ko],
    [1 Mo], [1 000 000], [une photo de téléphone : 3 Mo],
    [100 Mo], [10#super[8]], [une dalle d'orthophoto, 5 000 × 5 000 pixels × 3 octets : 75 Mo],
    [1 Go], [10#super[9]], [une heure de vidéo HD : 1 à 3 Go ; Anaconda installé : 5 Go],
    [1 To], [10#super[12]], [le disque d'un portable],
  )

  #notes[
    Kilo, méga, giga, téra : les mêmes préfixes que pour les mètres.

    Kio, Mio, Gio valent 1 024, 1 024², 1 024³ octets. L'explorateur Windows
    affiche des Kio sous le nom « Ko » : un disque de 1 To y fait 931 « Go ».
    Le signaler sans s'y attarder.

    Dalle d'orthophoto : 25 millions de pixels × 3 octets (rouge, vert, bleu),
    sans compression. Le cours 3 de 2026 compare les formats d'image (`images.ipynb`).
  ]
]

// --------------------------------------------
// Fusion de « Ordres de grandeur : temps d'accès » et de « Si la mémoire vive
// valait une seconde » (19/10/2026), comme dans `cours5_short.typ`.
#d("Ordres de grandeur : temps d'accès")[
  #annonce[
    De la nanoseconde à la demi-seconde, sur une échelle logarithmique :
    chaque graduation vaut dix fois la précédente.
  ]

  #barres-temps(echelle: [si la mémoire vive valait 1 s], interligne: 3pt, (
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
    Temps d'un accès ou d'un aller-retour, valeurs typiques ; réseau mesuré
    depuis Paris (wondernetwork.com, septembre 2026).
  ]

  #notes[
    Colonne de droite : les mêmes temps multipliés par dix millions.
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

// --------------------------------------------
// Nouveau (v2), 04/11/2026.
#d("Lecture d'un fichier : du disque au processeur")[
  #annonce[
    L'appel `f.read()` copie le contenu du fichier du disque vers la mémoire
    vive. Pour exécuter une instruction, le processeur copie ensuite les données
    nécessaires dans son cache.
  ]

  #align(center, schema-lecture-memoire())

  #legende[
    Une modification de `texte` reste en mémoire vive. Le fichier sur le disque
    ne change qu'avec `f.write`.
  ]

  #notes[
    La colonne « En mémoire » de « Lire un fichier : ouvrir, lire, fermer »
    désigne la mémoire vive.

    `f.read()` passe par le système d'exploitation (cours 1), qui lit le disque
    par blocs et garde ces blocs en mémoire vive. Python décode ensuite les
    octets en caractères : diapositive suivante.

    Les registres sont une mémoire de quelques octets dans le cœur, où une
    instruction lit ses nombres et écrit ses résultats. Cœur et instructions :
    « Exécution des instructions machine : un cœur », cours 1.

    Le texte d'un programme suit le même chemin : `python` lit le fichier
    enregistré (cours 1).
  ]
]
