// Cours 5 — clôture. Incluse par `cours5.typ`.
#import "../../../commun/prelude.typ": *

#d("Vers le cours 6")[
  #annonce[
    Le cours 6 utilise le compte, la clé et le deuxième facteur mis en place
    aujourd'hui.
  ]

  #tableau(
    columns: (1fr, 1fr),
    align: (left + horizon, left + horizon),
    [Fait aujourd'hui], [Au cours 6],
    [un compte sur la forge], [un dépôt distant pour chaque projet],
    [une clé SSH sur ce compte], [`git clone`, `git push`, `git pull` sans mot de passe],
    [un deuxième facteur sur le compte], [demandé par GitHub à la première connexion],
    [le secret dans un fichier ignoré], [le `.gitignore` du dépôt de chacun],
    [le commit en local, le push sur le réseau], [travailler à plusieurs sur le même dépôt : branches, fusion],
  )

  #legende[
    Le cours 6 commence par `git clone` : la clé doit fonctionner avant la
    séance.
  ]

  #notes[
    Un TD 5b non terminé se termine avant le cours 6, seul, avec la feuille du
    TD dans `cours5/5b_cle_ssh/`.
  ]
]
