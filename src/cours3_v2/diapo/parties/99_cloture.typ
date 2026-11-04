// Clôture du cours 3 — incluse en dernier par `cours3_v2.typ`, après le TD 3c.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#d("À retenir")[
  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [Un chemin relatif], [part du dossier courant : celui du notebook, ou celui du terminal],
    [`Path(__file__)`], [le chemin du script ; `/` construit les chemins à partir de son dossier],
    [`encoding="utf-8"`], [dans chaque lecture et chaque écriture de texte],
    [`f.read()`], [copie le contenu du fichier du disque vers la mémoire vive],
    [Un caractère], [un nombre ; ASCII en a 128, sur un octet ; UTF-8 écrit les autres sur deux à quatre],
    [`argparse`], [les valeurs sur la ligne de commande, vérifiées, et l'aide de `--help`],
  )

  #notes[
    Le projet 4 revoit ces notions sur un nouveau programme. Le dire en une
    phrase, sans détailler.

    Le dépôt de notes du cours : les notes du jour, un commit.
  ]
]
