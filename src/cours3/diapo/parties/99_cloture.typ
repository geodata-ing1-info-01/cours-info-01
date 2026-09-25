// Clôture du cours 3 — incluse en dernier par `cours3.typ`, après le TD 3a.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#d("À retenir")[
  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [Un chemin relatif], [part du dossier courant : celui du notebook, ou celui du terminal],
    [`Path(__file__).parent`], [le dossier du script, d'où qu'on le lance],
    [`encoding="utf-8"`], [dans chaque lecture et chaque écriture de texte],
    [`subprocess.run([...])`], [un programme externe, appelé depuis Python, en liste],
    [`if __name__ == "__main__":`], [`main()` s'exécute quand le fichier est lancé par `python` ; un `import` ne l'exécute pas],
    [Un caractère], [un nombre ; ASCII en a 128, sur un octet ; UTF-8 écrit les autres sur deux à quatre],
    [`argparse`], [les valeurs sur la ligne de commande, vérifiées, et l'aide de `--help`],
    [Un environnement conda], [un Python et ses paquets ; `conda create -n nom … paquets` le crée avec eux (TD 0a, selon les groupes)],
  )

  #notes[
    Le projet 4 reprend `recette.py` là où le TD l'a laissé : en faire un
    projet installable, avec son `pyproject.toml`, puis un environnement
    qui ne contient que ce qu'il faut. Le dire en une phrase, sans détailler.

    Le dépôt de notes du cours : les notes du jour, un commit.
  ]
]
