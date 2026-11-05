// Cours 5 v2, partie 1 : lancer un programme depuis Python. Incluse par `cours5_v2.typ`.
//
// Repris le 05/11/2026 du cours 3 de 2026 (`cours3/diapo/parties/01_programme.typ`),
// qui reste inchangé. Sans les cartouches de notebook, et sur `recette.py` du projet 4
// à la place du notebook. Commandes essayées le 05/11/2026 avec pandoc 3.11, sous Linux.
#import "../../../commun/prelude.typ": *
#import "../../../cours3/diapo/schemas.typ": code-commente, sortie

#separateur(
  "Lancer un programme depuis Python",
  annonce: "subprocess lance un programme en ligne de commande depuis un programme Python : ici, pandoc.",
)

// --------------------------------------------
#d("Produire la page : une commande en plus")[
  #annonce[
    Le programme écrit la recette en Markdown. La page HTML se produit
    ensuite par une commande, `pandoc`, tapée dans un terminal : une étape à
    la main, en plus du programme.
  ]

  #chaine(
    ([`recette.py`], "écrit travail/crepes.md"),
    ([`pandoc`, dans le terminal], "lit crepes.md, écrit crepes.html"),
    ([`crepes.html`], "la page, ouverte par un double-clic"),
  )

  #v(0.5em)
  #sortie("$ cd travail\n$ pandoc crepes.md -o crepes.html", taille: 12pt)

  #v(0.3em)
  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [`pandoc`], [le programme lancé, livré avec Anaconda],
    [`crepes.md`], [le fichier à lire, l'entrée],
    [`-o crepes.html`], [le fichier à écrire, la sortie ; le format suit l'extension],
  )

  #notes[
    `-o` : raccourci d'`--output`. Documentation : pandoc.org/MANUAL.html.
  ]
]

// --------------------------------------------
#d("subprocess : appeler pandoc depuis Python")[
  #annonce[
    Objectif : que le programme Python lance lui-même pandoc. La fonction
    `subprocess.run` reçoit la commande sous forme de liste : le nom du
    programme, puis ses arguments, un élément par mot.
  ]

  #tableau(
    columns: (auto, auto, auto, auto, auto),
    align: left + horizon,
    [Dans le terminal], [`pandoc`], [`crepes.md`], [`-o`], [`crepes.html`],
    [Dans la liste Python], [`"pandoc"`], [`"crepes.md"`], [`"-o"`], [`"crepes.html"`],
  )

  #v(0.6em)
  #code-commente(
    ("import subprocess", "la bibliothèque, livrée avec Python"),
    ("commande = [\"pandoc\", \"crepes.md\", \"-o\", \"crepes.html\"]", "un élément par mot de la commande"),
    ("subprocess.run(commande, check=True)", "lance pandoc ; `check=True` lève une erreur Python en cas d'échec"),
  )

  #legende[
    `str(chemin)` convertit un chemin `Path` en chaîne. `subprocess.run` accepte
    aussi le `Path` directement.
  ]

  #notes[
    Liste : chaque élément est transmis au programme sans découpage,
    espaces et accents compris.

    Essayé le 05/11/2026 : un fichier absent lève `CalledProcessError` ; un
    programme introuvable, comme `pandocc`, lève `FileNotFoundError`.

    Python trouve pandoc dans les dossiers de `PATH`, comme le terminal : partie
    « PATH et variables d'environnement ».
  ]
]

// --------------------------------------------
#d("Le dossier courant d'une commande")[
  #annonce[
    La même conversion s'écrit différemment selon le dossier d'où elle est
    lancée : celui du terminal, ou, depuis Python, celui d'où le script est
    lancé.
  ]

  #face-a-face(
    panneau("L'arborescence")[
      #sortie("cours5/                    ← dossier courant C\n└── recette/              ← dossier courant B\n    ├── depart/\n    └── travail/           ← dossier courant A\n        ├── crepes.md\n        └── crepes.html", taille: 11pt)
    ],
    panneau("La même conversion, depuis chaque dossier")[
      #tableau(
        columns: (auto, 1fr),
        align: left + horizon,
        [], [Commande],
        [A], [`pandoc crepes.md -o crepes.html`],
        [B], [`pandoc travail/crepes.md -o travail/crepes.html`],
        [C], [`pandoc recette/travail/crepes.md -o recette/travail/crepes.html`],
      )
    ],
  )

  #avertissement[
    Depuis `cours5/`, `-o crepes.html` écrit la page dans `cours5/`, loin de
    `crepes.md`. Et `pandoc crepes.md …` y échoue : le fichier n'y est pas.
  ]

  #notes[
    `subprocess.run(["pandoc", "crepes.md", …])` ne fonctionne que si le script
    est lancé depuis `travail/`, où se trouve `crepes.md`. Lancé depuis un autre
    dossier, le même appel échoue. Diapositive suivante : des chemins construits
    à partir de la racine.

    Dans une chaîne Python, `\t` est une tabulation : écrire les chemins
    avec `/` ou avec `Path`, jamais `"recette\travail"`.

    Les trois commandes et l'échec depuis `cours5/` ont été essayés le 05/11/2026.
  ]
]

// --------------------------------------------
#d("Les chemins de l'appel dans le programme")[
  #annonce[
    Dans le programme, les chemins passés à pandoc sont construits à partir
    de la racine : ils désignent les mêmes fichiers quel que soit le dossier
    courant.
  ]

  #code-commente(
    taille-code: 12.5pt, taille-texte: 12.5pt,
    ("page = fichier_sortie.with_suffix(\".html\")", "`travail/crepes.md` devient `travail/crepes.html`"),
    ("commande = [\"pandoc\", str(fichier_sortie), \"-o\", str(page),", "les deux chemins, en chaînes"),
    ("            \"--standalone\", \"--css\", \"style.css\"]", "une page complète, et sa feuille de style"),
    ("subprocess.run(commande, check=True)", "lance pandoc"),
  )

  #v(0.4em)
  #sortie("print(str(fichier_sortie))\nC:\\Users\\moi\\Desktop\\cours5\\recette\\travail\\crepes.md", taille: 12pt)

  #legende[
    `fichier_sortie` vaut `RACINE / "travail" / "crepes.md"`, et `RACINE`
    est absolue (`Path(__file__)`, cours 3) : le chemin passé à pandoc est complet.
  ]

  #notes[
    `style.css` reste relatif : le navigateur suit ce chemin depuis la page, et
    la feuille est copiée à côté d'elle.
  ]
]
