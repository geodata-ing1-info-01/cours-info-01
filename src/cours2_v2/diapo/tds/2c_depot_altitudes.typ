// TD 2c du cours 2 v2 — « Un dépôt git pour altitudes.py ».
//
// Nouveau (v2) : remplace les TD 2a, 2b et 2d de 2026 (dépôt
// `projet_2`, quatre branches). Un seul dépôt, celui d'`altitudes.py`, le programme
// du cours 1. Les diapositives résument les étapes ; le guide détaillé,
// `src/cours2_v2/notebook/td/2c_depot_altitudes/guide.md`, donne chaque commande
// et sa sortie. Sorties relevées par `rejeu/rejeu.sh`, à côté du guide.
//
// 05/11/2026 : la recette et pandoc sont retirés. Le programme gagne ici ses
// calculs sur la liste (altitudes extrêmes, écart, dénivelé cumulé) ; le cours 3
// le fait lire un fichier. Le code est fourni : `min`, `max`, `if` et `range` n'ont
// pas été vus. Corrigé : `data/cours2_v2/corriges/2c_depot_altitudes/`.
//
// Inclus par `cours2_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 2_v2`.
#import "../../../commun/prelude.typ": *
#import "../../../commun/schemas_git.typ": graphe-git, marque-tete
#import "../../../cours1_v2/diapo/schemas.typ": consignes, comment, commandes, constat

#let td = (
  numero: "2c",
  titre: "Un dépôt git pour altitudes.py",
  annonce: "Objectif : versionner un programme, en suivre les versions, les différences et les branches, et résoudre un conflit de fusion",
  dossier: "cours2/2c_depot_altitudes/",
  duree: "40′",
)
#separateur-td(..td)

// Les lignes de code à écrire, sur fond gris. Le thème réduit les `raw` ; cette
// règle, posée plus près, fixe la taille.
#let code(texte, taille: 12pt) = block(
  width: 100%, inset: (x: 9pt, y: 6pt), above: 5pt, below: 2pt, fill: gris,
)[
  #show raw: set text(size: taille)
  #raw(block: true, lang: "python", texte)
]

#d("Étape 0 · Copier le programme")[
  #consignes(
    taille: 17pt,
    [Aller dans le dossier du TD, et copier le programme dans `travail/` : #commandes("cd ~/Desktop/info01/cours2/2c_depot_altitudes", "cp depart/altitudes.py travail/")],
    [Ouvrir `travail/` dans VS Code : #comment[File, Open Folder…, `cours2\2c_depot_altitudes\travail`.]],
    [Ouvrir un terminal : #comment[menu Terminal, New Terminal.]
      #constat[Le terminal de VS Code s'ouvre dans `travail`.]],
    [Lancer le programme : `python altitudes.py`.
      #constat[`moyenne : 129.0 m`.]],
  )

  #notes[
    `altitudes.py` est le programme du cours 1, lancé au TD 2a.

    Le guide détaille chaque commande, sa sortie, et ce qu'il faut faire si
    elle ne donne pas le résultat attendu.
  ]
]

#d("Étape 1 · Créer le dépôt et le premier commit")[
  #consignes(
    taille: 16pt,
    [Créer le dépôt : `git init`, puis lister le dossier : `ls -a`.
      #constat[`.git` parmi les noms.]],
    [Indiquer son identité pour ce dépôt : #commandes("git config user.name \"Prénom Nom\"", "git config user.email prenom.nom@ensg.eu")
      #constat[Pas de message ; `git config user.name` affiche le nom.]],
    [Afficher l'état du dépôt : `git status`.
      #constat[Un fichier non suivi.]],
    [Créer le premier commit : #commandes("git add altitudes.py", "git commit -m \"Ajoute le calcul de la moyenne\"")
      #constat[`[master (commit racine) …]`, 1 fichier.]],
  )

  #notes[
    `git config` sans `--global` : le réglage ne vaut que pour ce dépôt. Les
    postes sont partagés (même compte `eleve`) ; un réglage `--global`
    signerait les commits des autres élèves.
  ]
]

#d("Étape 2 · Modifier le programme")[
  #consignes(
    taille: 16pt,
    [Dans `altitudes.py`, remplacer la première ligne par : #commandes("\"\"\"Altitudes extrêmes d'une série de mesures.\"\"\"")],
    [Remplacer les lignes de `total = 0` jusqu'au `print` par ces trois lignes :
      #code("print(f\"altitude minimale : {min(altitudes):.1f} m\")\nprint(f\"altitude maximale : {max(altitudes):.1f} m\")\nprint(f\"max - min : {max(altitudes) - min(altitudes):.1f} m\")", taille: 13pt)],
    [Enregistrer le fichier, puis lancer le programme : `python altitudes.py`.
      #constat[`127.6`, `131.0` et `3.4`.]],
  )

  #notes[
    `min` et `max` sont des fonctions de Python, qui reçoivent la liste.

    Textes affichés sans accent : selon le terminal, Python n'écrit pas les
    accents de la même façon.
  ]
]

#d("Étape 2 · Comparer, puis enregistrer")[
  #consignes(
    taille: 17pt,
    [Afficher les modifications : `git status`, puis `git diff`.
      #constat[`modifié : altitudes.py` ; les lignes retirées en `-`, les lignes ajoutées en `+`.]],
    [Créer un commit : #commandes("git add altitudes.py", "git commit -m \"Remplace la moyenne par les altitudes extrêmes\"")],
    [Afficher l'historique : `git log --oneline`.
      #constat[Deux commits, le plus récent en haut.]],
  )

  #notes[
    Dans VS Code, le panneau du contrôle de code source (`Ctrl` + `Maj` +
    `G`) montre le même `diff`, côte à côte. Le faire regarder après le
    terminal.

    La moyenne n'est pas perdue : elle reste dans le premier commit.
  ]
]

#d("Étape 3 · Annuler une modification")[
  #consignes(
    taille: 17pt,
    [Dans `altitudes.py`, à la ligne `altitude maximale`, remplacer `max(altitudes)` par `max(altitude)`, puis enregistrer le fichier.],
    [Lancer le programme : `python altitudes.py`.
      #constat[`NameError` : le programme s'arrête à cette ligne.]],
    [Afficher la différence : `git diff`.
      #constat[La ligne en `-` et en `+`.]],
    [Restaurer le fichier : `git restore altitudes.py`.],
    [Afficher l'état du dépôt : `git status`, puis relancer le programme.
      #constat[« rien à valider » ; le programme affiche de nouveau ses trois lignes.]],
  )
]

#d("Étape 4 · Écrire un README")[
  #annonce[
    `README.md`, à la racine d'un projet, décrit ce qu'il fait et comment
    s'en servir.
  ]

  #consignes(
    taille: 16pt,
    [Dans VS Code, créer le fichier `README.md`, avec ces lignes : #comment[File, New File…]
      #block(width: 100%, inset: (x: 9pt, y: 6pt), above: 5pt, below: 2pt, fill: gris)[
        #show raw: set text(size: 12pt)
        #raw(block: true, "# Altitudes\n\nCe programme affiche des statistiques sur une série d'altitudes, en mètres.\n\n## Utilisation\n\nÉcrire les altitudes dans la liste `altitudes`, puis lancer `python altitudes.py`.")
      ]],
    [Afficher l'aperçu : `Ctrl` + `Maj` + `V`.
      #constat[Deux titres et deux paragraphes.]],
    [Créer un commit : #commandes("git add README.md", "git commit -m \"Ajoute un README\"")],
  )

  #notes[
    La syntaxe est celle des cellules de texte du cours 1 : titres et code en ligne.

    Le TD 4a reprend un README plus complet, à partir d'un modèle.
  ]
]

// Sans pandoc depuis le 05/11/2026 : le fichier produit est la sortie du programme,
// comme `resume.txt` au TD 4a.
#d("Étape 4 · Ignorer un fichier produit")[
  #annonce[
    Le signe `>` écrit la sortie d'une commande dans un fichier, à la place du
    terminal.
  ]

  #consignes(
    taille: 16pt,
    [Écrire le résultat du programme dans un fichier : `python altitudes.py > resultat.txt`.
      #constat[Rien ne s'affiche ; `cat resultat.txt` affiche les trois lignes.]],
    [Afficher l'état du dépôt : `git status`.
      #constat[`resultat.txt` non suivi.]],
    [Créer le fichier `.gitignore`, avec la ligne `resultat.txt`. Afficher de nouveau l'état du dépôt.
      #constat[Seul `.gitignore` est non suivi.]],
    [Créer un commit : #commandes("git add .gitignore", "git commit -m \"Ignore le fichier du résultat\"")
      #constat[« rien à valider », alors que `resultat.txt` est dans le dossier.]],
  )

  #notes[
    `resultat.txt` se refait par la même commande : il n'a pas à être versionné.

    `.gitignore` se crée dans VS Code : File, New File, nom `.gitignore`,
    une ligne par motif.
  ]
]

// Calcul et légende repris du TD 3a du cours 3 v2 (05/11/2026).
#d("Étape 5 · Créer une branche")[
  #annonce[
    Le dénivelé cumulé est la somme des écarts d'altitude d'un point au suivant,
    avec un total pour les hausses et un total pour les baisses.
  ]

  #grid(
    columns: (1fr, 322pt), column-gutter: 16pt, align: top,
    consignes(
      taille: 15pt,
      [Créer la branche `cumul` : `git checkout -b cumul`.
        #constat[L'invite affiche `(cumul)`.]],
      [À la fin de `altitudes.py`, ajouter les lignes ci-contre. #comment[Les copier depuis le guide en HTML : copié depuis le PDF, le code perd ses indentations.]],
      [Enregistrer le fichier, puis lancer le programme : `python altitudes.py`.
        #constat[`cumul en hausse : 2.6 m` et `cumul en baisse : 3.4 m`.]],
      [Créer un commit : #commandes("git add altitudes.py", "git commit -m \"Ajoute le dénivelé cumulé\"")],
    ),
    code("hausse = 0\nbaisse = 0\nfor i in range(1, len(altitudes)):\n    ecart = altitudes[i] - altitudes[i - 1]\n    if ecart > 0:\n        hausse = hausse + ecart\n    else:\n        baisse = baisse - ecart\nprint(f\"cumul en hausse : {hausse:.1f} m\")\nprint(f\"cumul en baisse : {baisse:.1f} m\")", taille: 11pt),
  )

  #notes[
    Le code est fourni : `if` et `range` n'ont pas été vus. Le TD porte sur git.

    Sur 128.4, 131.0 et 127.6 : une hausse de 2.6 m, puis une baisse de 3.4 m.

    La branche courante s'affiche entre parenthèses à la fin de l'invite de
    Git Bash.
  ]
]

#d("Étape 5 · Revenir sur master, puis fusionner")[
  #consignes(
    taille: 16pt,
    [Revenir sur `master` : `git checkout master`, puis lancer le programme.
      #constat[Trois lignes : le cumul reste sur la branche `cumul`.]],
    [Dans `altitudes.py`, remplacer la première ligne par : #commandes("\"\"\"Altitudes extrêmes et dénivelé cumulé d'une série de mesures.\"\"\"")],
    [Créer un commit : #commandes("git add altitudes.py", "git commit -m \"Complète la description du programme\"")],
    [Fusionner la branche : `git merge cumul -m "Fusionne le dénivelé cumulé"`.],
    [Lancer le programme : `python altitudes.py`.
      #constat[Cinq lignes, et la première ligne du fichier complétée : deux modifications dans le même fichier.]],
  )
]

#d("Étape 6 · Modifier la même ligne sur deux branches")[
  #consignes(
    taille: 16pt,
    [Créer la branche `mesure-4` : `git checkout -b mesure-4`.],
    [Dans `altitudes.py`, ajouter `134.9` à la fin de la liste, puis créer un commit : #commandes("git add altitudes.py", "git commit -m \"Ajoute la mesure 134.9\"")],
    [Revenir sur `master` : `git checkout master`.],
    [Dans `altitudes.py`, ajouter `136.7` à la fin de la liste, puis créer un commit : #commandes("git add altitudes.py", "git commit -m \"Ajoute la mesure 136.7\"")
      #constat[Deux commits, un sur chaque branche.]],
  )

  #notes[
    Les étapes 5 et 6 sont celles qui débordent. Si le temps manque,
    s'arrêter après l'étape 5 ; l'étape 6 se fait seule, avec le guide.
  ]
]

#d("Étape 6 · Résoudre le conflit")[
  #consignes(
    taille: 16pt,
    [Fusionner la branche : `git merge mesure-4`.
      #constat[`CONFLIT (contenu)` ; les marqueurs dans `altitudes.py`.]],
    [Lancer le programme : `python altitudes.py`.
      #constat[`SyntaxError` : les marqueurs ne sont pas du Python.]],
    [Dans `altitudes.py`, écrire la ligne `altitudes = [128.4, 131.0, 127.6, 134.9, 136.7]`, puis retirer les marqueurs et enregistrer.],
    [Lancer le programme.
      #constat[`136.7`, `9.1`, `11.7` et `3.4`.]],
    [Terminer la fusion : #commandes("git add altitudes.py", "git commit -m \"Fusionne les deux mesures\"")
      #constat[Un commit de fusion.]],
  )
]

#d("Étape 6 · Lire le graphe")[
  #consignes(
    taille: 18pt,
    [Dessiner sur papier le graphe du dépôt.],
    [Comparer le dessin au graphe de git : `git log --oneline --graph --all --decorate`.
      #constat[Le même graphe : dix commits, deux fusions.]],
  )

  #legende[
    Pour aller plus loin : l'étape 7 du guide, une seconde copie du dépôt
    par `git clone`, puis `git pull`.
  ]

  #notes[
    Le dessin se fait avant la commande : le comparer ensuite au graphe de
    git, et au graphe du corrigé.
  ]
]

// Le graphe attendu à la fin de l'étape 6, au corrigé seulement (les élèves le
// dessinent avant `git log --graph`). Identifiants du rejeu, `rejeu/sortie.txt`.
#if corrige-visible {
  d("Le graphe du dépôt à la fin du TD")[
    #annonce[
      Dix commits, dont deux fusions. Chaque fusion a deux parents.
    ]

    #align(center, graphe-git(
      commits: (
        (nom: "c1", col: 0, voie: 0, id: "472"),
        (nom: "c2", col: 1, voie: 0, id: "d2f", parents: ("c1",)),
        (nom: "c3", col: 2, voie: 0, id: "9cd", parents: ("c2",)),
        (nom: "c4", col: 3, voie: 0, id: "02b", parents: ("c3",)),
        (nom: "c5", col: 4, voie: 1, id: "18b", parents: ("c4",)),
        (nom: "c6", col: 4, voie: 0, id: "862", parents: ("c4",)),
        (nom: "c7", col: 5, voie: 0, id: "6db", parents: ("c6", "c5")),
        (nom: "c8", col: 6, voie: 1, id: "6f7", parents: ("c7",)),
        (nom: "c9", col: 6, voie: 0, id: "7e0", parents: ("c7",)),
        (nom: "c10", col: 7, voie: 0, id: "91c", parents: ("c9", "c8")),
      ),
      branches: (
        (nom: "master", voie: 0, commit: "c10"),
        (nom: "cumul", voie: 1, commit: "c5"),
        (nom: "mesure-4", voie: 1, commit: "c8"),
      ),
      echelle: 1.1,
      taille-etiquette: 10pt,
      extra: (pos, d) => marque-tete(d, pos("c10"), dx: 0.7, dy: 0.8),
    ))

    #legende[
      Dans chaque pastille, le début de l'identifiant, comme dans
      `git log --oneline`. La flèche va d'un commit vers son parent.
    ]
  ]
}
