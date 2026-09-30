// TD 5a — « Les ordres de grandeur de votre poste ».
//
// Inclus par `cours5.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "5a",
  titre: "Les ordres de grandeur de votre poste",
  annonce: "Objectif : relever les caractéristiques du poste, puis comparer les vitesses du processeur, de la mémoire, du disque et du réseau",
  dossier: "cours5/5a_mesures/",
  duree: "15′",
)
#separateur-td(..td)

#d("Le poste, dans le gestionnaire des tâches")[
  #annonce[
    `Ctrl` + `Maj` + `Échap`, onglet Performance. Relever quatre valeurs.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [Rubrique], [Où lire], [Sur votre poste],
    [Processeur], [en haut à droite : le nom ; en bas : « Cœurs », « Vitesse de base »], reponse[4 cœurs, 2 à 3 GHz selon les postes],
    [Mémoire], [en haut à droite : la taille totale], reponse[8 ou 16 Go],
    [Disque], [le titre de la rubrique : SSD ou HDD ; la capacité], reponse[SSD, 100 à 250 Go sur les VM],
    [Ethernet ou Wi-Fi], [la vitesse du lien, en bas], reponse[1 Gbit/s en Ethernet],
  )

  #legende[
    Si le gestionnaire ne s'ouvre pas : `systeminfo` dans l'invite de commandes d'Anaconda
    donne le processeur et la mémoire.
  ]

  #notes[
    Deux minutes. Les valeurs du corrigé sont supposées : les relever sur une VM
    de la salle avant la séance.

    Les valeurs relevées sont dans les fourchettes de « Mémoire vive et
    disque ».
  ]
]

#d("Quatre mesures en Python")[
  #annonce[
    Dans l'invite de commandes d'Anaconda, depuis `cours5/5a_mesures/` : `python mesures.py`.
    Reporter les six lignes de résultat.
  ]

  #tableau(
    columns: (auto, 110pt, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [Mesure], [Sur votre poste], [Ce que vous constatez],
    [10 millions d'additions], [], reponse[30 à 100 ns par addition],
    [copier 100 Mo en mémoire], [], reponse[quelques Go/s],
    [écrire 100 Mo sur le disque], [], reponse[100 à 500 Mo/s : dix fois moins que la mémoire],
    [relire les mêmes 100 Mo], [], reponse[plus rapide : copie gardée en mémoire vive],
    [un aller-retour vers github.com], [], reponse[10 à 80 ms : Europe ou États-Unis],
    [télécharger 10 Mo], [], reponse[quelques centaines de Mbit/s],
  )

  #notes[
    Le script mesure chaque opération avec `time.perf_counter()` avant et après,
    comme au projet 7.

    Sortie sur un poste Linux (septembre 2026) : 39 ns par addition ; 1,4 Go/s
    en mémoire ; 90 Mo/s en écriture ; 1 300 Mo/s en relecture ; 22 ms
    d'aller-retour ; 412 Mbit/s. Sur les VM, les valeurs seront différentes et
    les rapports entre elles semblables.

    À commenter : la relecture est plus rapide que l'écriture, parce que le
    système garde une copie du fichier en mémoire vive.

    Sans réseau, le script l'affiche et s'arrête après les mesures locales.
  ]
]
