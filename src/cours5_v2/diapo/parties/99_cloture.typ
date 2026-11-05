// Clôture du cours 5 v2 — incluse en dernier par `cours5_v2.typ`. Un fichier inclus
// n'hérite pas des imports de son appelant.
//
// Remplace « Au cours 6 : compte GitHub et clé SSH » (05/11/2026) : les mots de passe et
// les clés passent au cours 6.
#import "../../../commun/prelude.typ": *

#d("À retenir")[
  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [`subprocess.run`], [lance un programme externe ; la commande est une liste, un élément par mot],
    [Une dépendance], [un nom et une exigence de version, écrits dans un fichier],
    [Un environnement], [un dossier par projet, avec son Python et ses paquets ; `environment.yml` le décrit],
    [`PATH`], [les dossiers où chercher une commande ; `conda activate` y place l'environnement en tête],
    [`export`], [transmet une variable aux programmes lancés ensuite],
    [`pyproject.toml`], [la fiche du projet, lue par pip ; `[project.scripts]` déclare les commandes à installer],
  )

  #notes[
    Le cours 6 reprend la distribution du code par une forge, et l'accès à ce code.
  ]
]
