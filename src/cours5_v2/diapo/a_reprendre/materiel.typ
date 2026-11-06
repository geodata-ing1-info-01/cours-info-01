// Diapositives de matériel sorties du cours 5 v2 le 06/11/2026, et ce qu'elles sont
// devenues. Ce fichier n'est inclus nulle part. Il se compile seul :
//
//   typst compile --root . src/cours5_v2/diapo/a_reprendre/materiel.typ
//
// La partie matériel du cours 5 de 2026 (`cours5/diapo/parties/01_materiel.typ`) reste
// inchangée.
#import "../../../commun/prelude.typ": *
#import "../../../cours5/diapo/schemas.typ": schema-processeur

#show: diapos.with(
  titre-court: "Matériel : ce que sont devenues les diapositives",
  auteur-court: "cours 5 v2, 06/11/2026",
)

#d("Diapositives de matériel du cours 5")[
  #show table.cell: set text(size: 13.5pt)
  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
    [Diapositive], [Situation],
    [Évolution des processeurs de 1990 à 2022], [cours 1, après « plusieurs cœurs »],
    [Le processeur : instructions vectorielles], [annexe du site],
    [Le processeur : multiplication et addition], [annexe du site],
    [Le processeur : deux instructions par cycle], [annexe du site],
    [Processeur et carte graphique], [annexe du site],
    [Opérations par seconde d'un portable], [annexe du site],
    [Consommation électrique des services en ligne], [cours 6, partie forge],
    [Coût d'un service en ligne], [cours 6, partie forge],
    [TD 5a, les ordres de grandeur du poste], [TD 3d, facultatif],
    [Le processeur : six cœurs], [à couper : doublon de « plusieurs cœurs », cours 1],
  )

  #legende[
    Annexe du site : page « Le processeur et la carte graphique », dans « Pour aller plus
    loin ».
  ]
]

// --------------------------------------------
#d("Le processeur : six cœurs")[
  #annonce[
    Chaque cœur suit sa file d'instructions ; un programme Python ordinaire
    n'en occupe qu'un.
  ]

  #schema-processeur(5)

  #legende[
    Deux cœurs sur les processeurs grand public depuis 2005 (AMD Athlon 64
    X2, Intel Pentium D).
  ]

  #notes[
    Le cœur 1, en bleu clair avec le logo, exécute le programme Python. Les
    autres cœurs servent aux autres programmes ouverts.

    Sur son cœur, un programme Python ordinaire n'emploie pas les
    instructions vectorielles ; numpy les emploie.

    Cœurs : 4 sur les postes de la salle (relevé au TD 3d), 4 à 8 sur un
    portable, 32 à 128 sur un serveur de calcul.

    Les cœurs se sont multipliés quand la fréquence a cessé de monter, vers
    2005 (diapositive suivante).

    Un programme occupe plusieurs cœurs s'il découpe son travail en parties
    indépendantes. numpy le fait pour le produit de matrices.

    Le gestionnaire des tâches affiche pour le Ryzen 5 7530U 6 cœurs et 12
    processeurs logiques : chaque cœur suit deux files d'instructions, qui se
    partagent ses unités.
  ]
]

