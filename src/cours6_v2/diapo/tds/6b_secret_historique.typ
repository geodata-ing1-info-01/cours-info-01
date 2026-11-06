// TD 6b — « Un secret dans l'historique », facultatif. Ancien TD 5b, repris le
// 05/11/2026 ; son dossier reste à construire dans `data/cours6_v2/`.
//
// 06/11/2026 : Git Bash remplace l'invite de commandes d'Anaconda, comme au TD 6a. Les
// commandes passent en consignes, et les réponses du tableau en constats. Commandes essayées
// sous Linux (bash, git 2.34), à relever sur un poste de la salle.
//
// Inclus par `cours6_v2.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`.
#import "../../../commun/prelude.typ": *
#import "../../../cours1_v2/diapo/schemas.typ": consignes, constat, terminal-etapes, etape-terminal

#let td = (
  numero: "6b",
  titre: "Un secret dans l'historique",
  annonce: "Objectif : suivre un secret enregistré par erreur dans un dépôt git, puis le tenir à l'écart des commits",
  dossier: "cours6/6b_secret_historique/",
  duree: "10′",
  statut: "facultatif",
)
#separateur-td(..td)

// La consigne à gauche, ses commandes à droite.
#let _etape(liste, commandes-td) = grid(
  columns: (1fr, 1.25fr), column-gutter: 14pt, align: top,
  liste, commandes-td,
)

#d("Historique d'un secret supprimé")[
  #objectif[
    committer dans `config.py` une clé inventée, supprimer ce fichier, et déterminer si la clé
    reste dans le dépôt.
  ]

  #_etape(
    consignes(
      taille: 16pt,
      [Créer un dépôt `travail`, et y entrer.],
      [Écrire une clé inventée dans `config.py`, puis committer ce fichier.],
      [Supprimer `config.py`, committer la suppression, puis lister le dossier.
        #constat[`config.py` n'y est plus : `git rm` l'a supprimé.]],
      [Afficher l'historique de `config.py`.
        #constat[La clé reste dans le dépôt : ligne `+CLE_API = …` du premier commit.]],
    ),
    terminal-etapes(
      taille: 15pt,
      etape-terminal(numero: 1, "git init travail", "cd travail"),
      etape-terminal(numero: 2, "echo 'CLE_API = \"d7f3a9c1e5b24086\"' > config.py", "git add config.py", "git commit -m \"Premier script de carte\""),
      etape-terminal(numero: 3, "git rm config.py", "git commit -m \"Supprime la clé du dépôt\"", "ls"),
      etape-terminal(numero: 4, "git log -p -- config.py"),
    ),
  )

  #notes[
    Le fichier n'est plus dans le dossier de travail. L'historique le contient
    toujours, et un clone reçoit les deux commits.
  ]
]

#d("Secret dans un fichier ignoré par git")[
  #objectif[
    écarter la clé des commits avec un modèle, `config.example.py`, et une règle d'exclusion, dans
    `.gitignore`.
  ]

  #_etape(
    consignes(
      taille: 16pt,
      [Écrire un modèle de configuration dans `config.example.py`, sans la clé.],
      [Exclure `config.py` des commits, par une règle dans `.gitignore`.],
      [Recréer `config.py`, avec la clé.],
      [Ajouter tous les fichiers, puis afficher l'état du dépôt.
        #constat[`config.example.py` et `.gitignore` ; `config.py` n'y est pas.]],
      [Afficher la règle qui exclut `config.py`.
        #constat[`.gitignore:1:config.py  config.py` : la règle qui l'exclut, et sa ligne.]],
      [Committer.],
    ),
    terminal-etapes(
      taille: 15pt,
      etape-terminal(numero: 1, "echo 'CLE_API = \"à remplir\"' > config.example.py"),
      etape-terminal(numero: 2, "echo config.py > .gitignore"),
      etape-terminal(numero: 3, "echo 'CLE_API = \"d7f3a9c1e5b24086\"' > config.py"),
      etape-terminal(numero: 4, "git add .", "git status"),
      etape-terminal(numero: 5, "git check-ignore -v config.py"),
      etape-terminal(numero: 6, "git commit -m \"Modèle de configuration, secret ignoré\""),
    ),
  )

  #notes[
    `git add` ignore le fichier qui contient la vraie valeur.

    `git add .` est la commande qui ajoute un secret par erreur : écrire le
    `.gitignore` avant.

    La première clé reste dans les deux premiers commits. La feuille du TD
    recrée le dépôt en dernière étape.
  ]
]
