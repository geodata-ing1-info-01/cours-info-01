// Cours 5 — clôture. Incluse par `cours5.typ`.
#import "../../../commun/prelude.typ": *

#d("Vers le cours 6")[
  #annonce[
    Au cours 6, chacun crée son compte GitHub, avec un deuxième facteur, et y
    déclare une clé SSH, avant de publier son dépôt.
  ]

  #tableau(
    columns: (1fr, 1fr),
    align: (left + horizon, left + horizon),
    [Vu aujourd'hui], [Au cours 6],
    [la clé à la place du mot de passe], [une clé SSH créée sur le poste et déclarée sur le compte GitHub ; `git clone`, `git push`, `git pull` sans mot de passe],
    [le deuxième facteur], [activé à la création du compte GitHub],
    [le secret dans un fichier ignoré], [le `.gitignore` du dépôt de chacun],
    [le commit en local, le push sur le réseau], [travailler à plusieurs sur le même dépôt : branches, fusion],
  )
]
