// TD 5b — « Un secret dans l'historique », facultatif.
//
// Inclus par `cours5.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`.
#import "../../../commun/prelude.typ": *
#import "../style.typ": terminal

#let td = (
  numero: "5b",
  titre: "Un secret dans l'historique",
  annonce: "Objectif : suivre un secret enregistré par erreur dans un dépôt git, puis le tenir à l'écart des commits",
  dossier: "cours5/5b_secret_historique/",
  duree: "10′",
  statut: "facultatif",
)
#separateur-td(..td)

#d("Committer, supprimer, relire")[
  #annonce[
    Committer un fichier qui contient une clé inventée, puis le supprimer
    dans un second commit.
  ]

  #terminal("Anaconda Prompt", "> git init travail
> cd travail
> echo CLE_API = \"d7f3a9c1e5b24086\" > config.py
> git add config.py
> git commit -m \"Premier script de carte\"
> git rm config.py
> git commit -m \"Supprime la clé du dépôt\"
> git log -p -- config.py", taille: 12pt)

  #v(0.3em)
  #tableau(
    columns: (auto, 1fr),
    align: (left + horizon, left + horizon),
    [Question], [Ce que vous constatez],
    [`config.py` est-il encore dans le dossier ?], reponse[non : `git rm` l'a supprimé],
    [La clé est-elle encore dans le dépôt ?], reponse[oui : ligne `+CLE_API = …` du premier commit],
  )

  #notes[
    Le fichier n'est plus dans le dossier de travail. L'historique le contient
    toujours, et un clone reçoit les deux commits.
  ]
]

#d("Tenir le secret à l'écart")[
  #annonce[
    Le dépôt contient un modèle et une règle d'exclusion. `git add` ignore le
    fichier qui contient la vraie valeur.
  ]

  #terminal("Anaconda Prompt", "> echo CLE_API = \"à remplir\" > config.example.py
> echo config.py > .gitignore
> echo CLE_API = \"d7f3a9c1e5b24086\" > config.py
> git add .
> git status
> git commit -m \"Modèle de configuration, secret ignoré\"", taille: 12pt)

  #v(0.3em)
  #tableau(
    columns: (auto, 1fr),
    align: (left + horizon, left + horizon),
    [Question], [Ce que vous constatez],
    [Que liste `git status` après `git add .` ?], reponse[`config.example.py` et `.gitignore` ; `config.py` n'y est pas],
    [Que dit `git check-ignore -v config.py` ?], reponse[`.gitignore:1:config.py  config.py` : la règle qui l'exclut, et sa ligne],
  )

  #notes[
    `git add .` est la commande qui ajoute un secret par erreur : écrire le
    `.gitignore` avant.

    La première clé reste dans les deux premiers commits. La feuille du TD
    recrée le dépôt en dernière étape.
  ]
]
