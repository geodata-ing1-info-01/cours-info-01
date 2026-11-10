// TD 3c du cours 3 v2 — « Les ordres de grandeur de votre poste », facultatif.
//
// Le TD 5a du cours 5 de 2026, passé au cours 3 v2 le 06/11/2026, après la mémoire et le
// stockage. Inclus par `cours3_v2.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py --cours 3_v2`.
#import "../../../commun/prelude.typ": *
#import "../../../cours1_v2/diapo/schemas.typ": consignes, commandes

#let td = (
  numero: "3c",
  titre: "Les ordres de grandeur de votre poste",
  annonce: "Objectif : relever les caractéristiques du poste, puis comparer les vitesses du processeur, de la mémoire, du disque et du réseau",
  dossier: "cours3/3c_mesures/",
  duree: "15′",
  statut: "facultatif",
)
#separateur-td(..td)

#d("Relevé dans le gestionnaire des tâches")[
  #objectif[
    relever dans le gestionnaire des tâches le processeur, la mémoire, le disque et le lien réseau
    du poste.
  ]

  #consignes(
    taille: 17pt,
    [Ouvrir le gestionnaire des tâches : `Ctrl` + `Maj` + `Échap`, onglet Performance.],
    [Relever les quatre valeurs du tableau.],
  )

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

    Les valeurs relevées sont dans les fourchettes de « Ordres de grandeur : tailles
    et temps d'accès ».
  ]
]

#d("Mesures de vitesse en Python")[
  #objectif[
    mesurer les vitesses du processeur, de la mémoire, du disque et du réseau avec `mesures.py`.
  ]

  #consignes(
    taille: 17pt,
    [Dans le terminal de VS Code, aller dans le dossier du TD, puis lancer le programme : #commandes("cd ../../3c_mesures", "python mesures.py")],
    [Reporter les six lignes de résultat.],
  )

  #{
    show table.cell: set text(size: 15pt)
    tableau(
      columns: (auto, 125pt, 1fr),
      align: (left + horizon, left + horizon, left + horizon),
      inset: (x: 8pt, y: 5pt),
      [Mesure], [Sur votre poste], [Ce que vous constatez],
      [10 millions d'additions], [], reponse[30 à 100 ns par addition],
      [copier 100 Mo en mémoire], [], reponse[quelques Go/s],
      [écrire 100 Mo sur le disque], [], reponse[100 à 500 Mo/s : dix fois moins que la mémoire],
      [relire les mêmes 100 Mo], [], reponse[plus rapide : copie gardée en mémoire vive],
      [un aller-retour vers github.com], [], reponse[10 à 80 ms : Europe ou États-Unis],
      [télécharger 10 Mo], [], reponse[quelques centaines de Mbit/s],
    )
  }

  #notes[
    Le script mesure chaque opération avec `time.perf_counter()` avant et après.

    Sortie sur un poste Linux (septembre 2026) : 39 ns par addition ; 1,4 Go/s
    en mémoire ; 90 Mo/s en écriture ; 1 300 Mo/s en relecture ; 22 ms
    d'aller-retour ; 412 Mbit/s. Sur les VM, les valeurs seront différentes et
    les rapports entre elles semblables.

    À commenter : la relecture est plus rapide que l'écriture, parce que le
    système garde une copie du fichier en mémoire vive.

    Sans réseau, le script l'affiche et s'arrête après les mesures locales.
  ]
]
