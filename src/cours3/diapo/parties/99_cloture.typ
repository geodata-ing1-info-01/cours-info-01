// Clôture du cours 3 — incluse en dernier par `cours3.typ`, après le TD 3f.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#d("À retenir")[
  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [Un chemin relatif], [part du dossier courant : celui du notebook, ou celui du terminal],
    [`Path.cwd()`], [le dossier courant ; `/` construit les chemins à partir de lui],
    [`encoding="utf-8"`], [dans chaque lecture et chaque écriture de texte],
    [`subprocess.run([...])`], [un programme externe, appelé depuis Python, en liste],
    [Un caractère], [un nombre ; ASCII en a 128, sur un octet ; UTF-8 écrit les autres sur deux à quatre],
    [`argparse`], [les valeurs sur la ligne de commande, vérifiées, et l'aide de `--help`],
    [Un environnement conda], [un Python et ses paquets ; `conda create -n nom … paquets` le crée avec eux (TD 3f, selon les groupes)],
  )

  #notes[
    Le projet 4 revoit ces notions sur un nouveau programme, pour les deux
    parcours ; le parcours avancé en fait un projet installable. Le dire en
    une phrase, sans détailler.

    Le dépôt de notes du cours : les notes du jour, un commit.
  ]
]
