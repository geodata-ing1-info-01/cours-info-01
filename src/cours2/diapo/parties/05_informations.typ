// Cours 2, partie 5 — lire ce que git dit, et lui dire quoi ignorer
// (diapositives 21 à 24).
#import "../../../commun/prelude.typ": *
#import "../beamer.typ": d-beamer as d
#import "../schemas.typ": *
#import "../style.typ": *

// Teintes des sorties de terminal, reprises de celles que git emploie.
#let _jaune = rgb("#D8B24A")
#let _vert = rgb("#7FD97F")
#let _rouge = rgb("#E86C6C")
#let _cyan = rgb("#6FD0D8")
#let _violet = rgb("#C08FE0")

// --------------------------------------------- 21/26
#d("Afficher les informations")[
  #grid(
    columns: (1fr, 1.5fr), column-gutter: 18pt, align: horizon,
    [
      Le graphe git peut être affiché avec la commande :
      #code("git log --graph --pretty=oneline --abbrev-commit --decorate")
    ],
    sortie-terminal((
      ("*   468a7db Merge branch 'main' of https://github.com/…/2D-Viewer", _jaune),
      ("|\\", none),
      ("| * e33576f Update package.json", _jaune),
      ("| * 7aabb31 fixing label rendering on prod", _jaune),
      ("| *   97fe1b2 Merge branch 'hotfix' into dev", _jaune),
      ("| |\\", none),
      ("| | * dd9c38a (origin/hotfix, hotfix) fixing label rendering", _cyan),
      ("| * | 932a982 package.json fix", _jaune),
      ("| * | e6c32bc version with exact numbers", _jaune),
      ("* | | 56840cf Adding exact-math library", _jaune),
      ("| |/", none),
      ("| * c0f07a8 Merge branch 'exact_math' into dev", _jaune),
      ("| * a4d7e7b (origin/exact_math) fix on the face choices", _violet),
      ("| * c48800f input data correction algorithm", _jaune),
      ("|/", none),
      ("* 1705866 Correction of the input data", _jaune),
    ), taille: 9.5pt),
  )

  #notes[
    Le TD 2a en fait l'alias `git llog`. Sans `--graph`, l'historique
    s'affiche en une seule colonne, sans les branches.
  ]
]

// --------------------------------------------- 22/26
#d("Afficher les informations")[
  Pour voir la différence entre deux commits :
  #code("git diff <commit_1> [commit_2]")

  #v(0.5em)
  #align(center, sortie-terminal((
    ("diff --git a/file.py b/file.py", none),
    ("index 6072655..e69de29 100644", none),
    ("--- a/file.py", none),
    ("+++ b/file.py", none),
    ("@@ -1,2 +0,0 @@", _cyan),
    ("-def fonction_1(a,b):", _rouge),
    ("-    return a+b", _rouge),
  ), taille: 13pt, largeur: 78%))
]

// --------------------------------------------- 23/26
#d("Afficher les informations")[
  Pour voir l'état du projet (ce qui est enregistré/pas enregistré) :
  #code("git status")

  #v(0.5em)
  #sortie-terminal((
    ("Sur la branche master", none),
    ("Modifications qui ne seront pas validées :", none),
    ("  (utilisez \"git add <fichier>...\" pour mettre à jour ce qui sera validé)", none),
    ("  (utilisez \"git restore <fichier>...\" pour annuler les modifications", none),
    ("   dans le répertoire de travail)", none),
    ("        modifié :       file.py", _rouge),
    ("", none),
    ("aucune modification n'a été ajoutée à la validation (utilisez \"git add\"", none),
    ("ou \"git commit -a\")", none),
  ), taille: 11.5pt)

  #notes[
    `git status` affiche la branche courante, l'état de chaque fichier et,
    entre parenthèses, les commandes possibles. À taper avant de demander de
    l'aide.
  ]
]

// --------------------------------------------- 24/26
#d("ignorer des fichiers")[
  Pour demander à git d'ignorer des fichiers, il est possible de créer un
  fichier *.gitignore*.\
  On peut ensuite lister les fichiers à ignorer dans ce fichier

  #code("cache
build
img/*.png")

  #notes[
    Trois sortes de fichiers à ignorer : les fichiers produits par une
    commande (`build`, `__pycache__`), les réglages du poste (`.vscode`), les
    secrets (mots de passe, clés). Les secrets reviennent au cours 5.
  ]
]
