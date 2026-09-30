// Cours 5 — ouverture. Incluse par `cours5.typ`, qui porte les réglages
// globaux ; un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#page-titre(
  titre: "Cours 5",
  sous-titre: "Matériel, réseau, mots de passe, clés SSH et secrets",
  auteur: "1re année géomatique",
  date: "13 octobre",
)

// --------------------------------------------
#d("Contenu de la séance")[
  #annonce[
    Les ordres de grandeur du matériel et du réseau, puis les mots de passe,
    les clés et les secrets. Ces derniers servent au prochain cours, sur les
    forges logicielles (GitHub).
  ]

  #tableau(
    columns: (1fr, auto, auto),
    align: (left + horizon, left + horizon, right + horizon),
    [Partie], [Nature], [Durée],
    [Le matériel], [cours], [30′],
    [Le réseau], [cours et TD 5a], [30′],
    [Prouver qui l'on est], [cours et TD 5b], [40′],
    [Les secrets de vos programmes], [cours ; TD 5c facultatif], [15′],
  )

  #legende[
    Durées indicatives. Aujourd'hui, tout est dans `cours5/` ; les deux TD en
    séance durent 35′ en tout.
  ]

  #notes[
    Moins de TD que dans les séances précédentes. La première moitié est de la
    culture générale ; la seconde prépare le cours 6.

    Le TD 5b est indispensable : le cours 6 commence par `git clone`, qui
    demande la clé. Le compte GitHub est à créer avant la séance (page « Avant
    les séances » du book).
  ]
]
