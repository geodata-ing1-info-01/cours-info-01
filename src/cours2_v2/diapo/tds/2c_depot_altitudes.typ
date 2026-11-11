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
#import "../schemas.typ": schema-dossier-gitignore

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

// Un encart d'explication, en bleu, sur le modèle du bloc « Objectif ».
#let encart(titre, corps) = block(
  width: 100%, inset: (x: 13pt, y: 9pt), above: 0.8em,
  fill: accent.lighten(92%), stroke: (left: 3pt + accent),
)[
  #set text(size: 15pt)
  #show raw: set text(size: 1.1em)
  #text(fill: accent, weight: demi-gras)[#titre : ]#corps
]

#d("Étape 0 · Copie du programme")[
  #objectif[
    copier `altitudes.py` dans `travail/`, ouvrir ce dossier dans VS Code, et lancer le programme.
  ]

  #consignes(
    taille: 17pt,
    [Aller dans le dossier du TD, et copier le programme dans `travail/` : #commandes("cd ~/Desktop/info01/cours2/2c_depot_altitudes", "cp depart/altitudes.py travail/")],
    [Ouvrir `travail/` dans VS Code : #comment[File, Open Folder…, `cours2\2c_depot_altitudes\travail`.]],
    [Ouvrir un terminal : #comment[menu Terminal, New Terminal.]
      #constat[Le terminal de VS Code s'ouvre dans `travail`.]],
    [Lancer le programme : `python altitudes.py`.
      #constat[`moyenne : 93.7 m`.]],
  )

  #notes[
    `altitudes.py` est le programme du cours 1, lancé au TD 2a.

    Le guide détaille chaque commande, sa sortie, et ce qu'il faut faire si
    elle ne donne pas le résultat attendu.
  ]
]

#d("Étape 1 · Dépôt et premier commit")[
  #objectif[
    créer un dépôt git dans `travail/`, et y enregistrer `altitudes.py` par un premier commit.
  ]

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
    mettrait le nom d'un élève sur les commits des autres. Diapositive « L'auteur
    des commits : git config ».

    À relever sur un poste de la salle : la sortie de `ls -a` dans Git Bash (alias
    `ls -F`, en colonnes ; le guide donne celle du rejeu, un nom par ligne), et
    l'avertissement de `git add altitudes.py` sur les fins de ligne (« LF will be
    replaced by CRLF », si `core.autocrlf` vaut `true`), absent du rejeu sous Linux.
  ]
]

#d("Étape 2 · Modification du programme")[
  #objectif[
    remplacer dans `altitudes.py` le calcul de la moyenne par les altitudes extrêmes.
  ]

  #consignes(
    taille: 16pt,
    [Dans `altitudes.py`, remplacer la première ligne par : #commandes("\"\"\"Altitudes extrêmes d'une série de mesures.\"\"\"")],
    [Remplacer les lignes de `total = 0` jusqu'au `print` par ces trois lignes :
      #code("print(f\"altitude minimale : {min(altitudes):.1f} m\")\nprint(f\"altitude maximale : {max(altitudes):.1f} m\")\nprint(f\"max - min : {max(altitudes) - min(altitudes):.1f} m\")", taille: 13pt)],
    [Enregistrer le fichier, puis lancer le programme : `python altitudes.py`.
      #constat[`79.6`, `103.2` et `23.6`.]],
  )

  #encart[Le format `:.1f`][
    Python écrit la valeur entre accolades arrondie à un chiffre après la virgule : `.1`
    fixe le nombre de chiffres, `f` demande l'écriture décimale. Pour `2/3`, Python écrit
    `0.7` avec `:.1f`, et `0.6666666666666666` sans format.
  ]

  #notes[
    `min` et `max` sont des fonctions de Python, qui reçoivent la liste.

    Le `f` devant les guillemets fait de la chaîne une f-chaîne, dont les accolades
    reçoivent des valeurs ; le `f` de `:.1f` désigne l'écriture décimale. Le programme du
    cours 1 employait déjà `:.1f` pour la moyenne.

    Textes affichés sans accent : selon le terminal, Python n'écrit pas les
    accents de la même façon.
  ]
]

#d("Étape 2 · Comparaison et commit")[
  #objectif[
    afficher les modifications de `altitudes.py`, puis les enregistrer par un commit.
  ]

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

#d("Étape 3 · Annulation d'une modification")[
  #objectif[
    introduire une erreur dans `altitudes.py`, puis revenir à la version du dernier commit.
  ]

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

#d("Étape 4 · Ajout d'un fichier README")[
  #objectif[
    décrire le programme dans un fichier `README.md`, et l'enregistrer par un commit.
  ]

  #consignes(
    taille: 16pt,
    [Dans VS Code, créer le fichier `README.md`, avec ces lignes : #comment[explorateur, clic droit sur un endroit vide, New File…]
      #block(width: 100%, inset: (x: 9pt, y: 6pt), above: 5pt, below: 2pt, fill: gris)[
        #show raw: set text(size: 12pt)
        #raw(block: true, "# Altitudes\n\nCe programme affiche des statistiques sur une série d'altitudes, en mètres.\n\n## Utilisation\n\nÉcrire les altitudes dans la liste `altitudes`, puis lancer `python altitudes.py`.")
      ]],
    [Afficher l'aperçu : `Ctrl` + `Maj` + `V`.
      #constat[Deux titres et deux paragraphes.]],
    [Créer un commit : #commandes("git add README.md", "git commit -m \"Ajoute un README\"")],
  )

  #legende[
    `README.md`, à la racine d'un projet, décrit ce qu'il fait et comment s'en servir.
  ]

  #notes[
    La syntaxe est celle des cellules de texte du cours 1 : titres et code en ligne.

    Le TD 4a reprend un README plus complet, à partir d'un modèle.
  ]
]

// Un fichier de notes personnelles, créé dans VS Code comme `README.md` : aucune commande
// nouvelle avant `.gitignore`.
#d("Étape 4 · Fichier à ignorer")[
  #objectif[
    écrire ses notes de travail dans `notes.txt`, et exclure ce fichier des commits.
  ]

  #grid(
    columns: (1fr, 250pt), column-gutter: 16pt, align: top,
    consignes(
    taille: 15pt,
    [Dans VS Code, créer le fichier `notes.txt`, avec ces lignes : #comment[explorateur, clic droit, New File…]
      #block(width: 100%, inset: (x: 9pt, y: 6pt), above: 5pt, below: 2pt, fill: gris)[
        #show raw: set text(size: 12pt)
        #raw(block: true, "À faire :\n- ajouter le dénivelé cumulé\n- lire les altitudes dans un fichier texte")
      ]],
    [Afficher l'état du dépôt : `git status`.
      #constat[`notes.txt` non suivi.]],
    [Créer le fichier `.gitignore` de la même façon, avec la ligne `notes.txt`. Afficher de nouveau l'état du dépôt.
      #constat[Seul `.gitignore` est non suivi.]],
    [Créer un commit, puis afficher l'état du dépôt : #commandes("git add .gitignore", "git commit -m \"Ignore le fichier de notes\"", "git status")
      #constat[« rien à valider », alors que `notes.txt` est dans le dossier.]],
    ),
    schema-dossier-gitignore(),
  )

  #legende[
    `notes.txt` sert à la personne qui travaille, et ne fait pas partie du programme. Au
    cours 6, le dépôt est partagé, et ces notes restent sur le poste.
  ]

  #notes[
    `.gitignore` se crée comme `notes.txt` : explorateur, clic droit sur un endroit
    vide, New File…, nom `.gitignore`, une ligne par motif. Le menu File, New File…
    ouvre un fichier sans nom, à enregistrer ensuite ; l'explorateur crée le fichier
    dans le dossier ouvert, avec son nom.

    À relever sur un poste de la salle : la sortie de `ls` dans Git Bash, en colonnes
    (guide, étape 4.4).

    `ls` n'affiche ni `.git` ni `.gitignore`, et `ls -a` les affiche. L'explorateur de
    VS Code montre `.gitignore`, et masque `.git` par défaut.
  ]
]

// L'étape 5 commence par son énoncé, à faire seul, avec le calcul en pseudo-code ; les deux
// diapositives suivantes donnent la solution et le code Python. L'objectif reprend le « À
// faire » du guide. Calcul et légende repris du TD 3a du cours 3 v2.
#let _code-cumul = code("hausse = 0\nbaisse = 0\nfor i in range(1, len(altitudes)):\n    ecart = altitudes[i] - altitudes[i - 1]\n    if ecart > 0:\n        hausse = hausse + ecart\n    else:\n        baisse = baisse - ecart\nprint(f\"cumul en hausse : {hausse:.1f} m\")\nprint(f\"cumul en baisse : {baisse:.1f} m\")", taille: 11pt)

#d("Étape 5 · Énoncé : branche et fusion")[
  #objectif[
    créer la branche `cumul` et y ajouter le dénivelé cumulé ; revenir sur `master` et y
    compléter la description du programme ; fusionner `cumul` dans `master`.
  ]

  #grid(
    columns: (1fr, 322pt), column-gutter: 16pt, align: top,
    [
      #consignes(
        taille: 15pt,
        [Chercher les commandes dans les diapositives « Les branches » et « Fusionner deux branches ».],
        [Faire l'étape seul, sans regarder les deux diapositives suivantes.],
        [Comparer avec la solution, sur ces deux diapositives.],
      )
      #v(0.5em)
      #set text(size: 15pt)
      Le pseudo-code ci-contre décrit le calcul à ajouter à la fin de `altitudes.py`, sur
      `cumul` ; la solution donne son code Python.

      Sur `master`, la première ligne devient : #commandes("\"\"\"Altitudes extrêmes et dénivelé cumulé d'une série de mesures.\"\"\"")
    ],
    block(width: 100%, inset: (x: 10pt, y: 8pt), fill: gris, text(size: 17pt,
      raw(block: true, "hausse ← 0 ; baisse ← 0\npour chaque altitude, à partir de la deuxième :\n    écart ← altitude − altitude précédente\n    si écart > 0 :\n        hausse ← hausse + écart\n    sinon :\n        baisse ← baisse − écart\nafficher hausse et baisse"))),
  )

  #legende[
    Le dénivelé cumulé est la somme des écarts d'altitude d'un point au suivant, avec un total pour
    les hausses et un total pour les baisses.
  ]

  #notes[
    Le code Python est dans la solution : `if` et `range` n'ont pas été vus, et le TD
    porte sur git. La boucle `for` est celle de la moyenne, au cours 1.

    Laisser chercher quelques minutes avant de passer à la solution. Pour vérifier :
    `git log --oneline --graph` montre la fusion.
  ]
]

#d("Étape 5 · Solution : création d'une branche")[
  #objectif[
    ajouter le calcul du dénivelé cumulé à `altitudes.py`, sur une nouvelle branche, `cumul`.
  ]

  #grid(
    columns: (1fr, 322pt), column-gutter: 16pt, align: top,
    consignes(
      taille: 15pt,
      [Créer la branche `cumul` : `git checkout -b cumul`.
        #constat[L'invite affiche `(cumul)`.]],
      [À la fin de `altitudes.py`, ajouter les lignes ci-contre. #comment[Les copier depuis le guide en HTML : copié depuis le PDF, le code perd ses indentations.]],
      [Enregistrer le fichier, puis lancer le programme : `python altitudes.py`.
        #constat[`cumul en hausse : 23.6 m` et `cumul en baisse : 4.9 m`.]],
      [Créer un commit : #commandes("git add altitudes.py", "git commit -m \"Ajoute le dénivelé cumulé\"")],
    ),
    _code-cumul,
  )

  #notes[
    Sur 79.6, 103.2 et 98.3 : une hausse de 23.6 m, puis une baisse de 4.9 m.

    La branche courante s'affiche entre parenthèses à la fin de l'invite de
    Git Bash.
  ]
]

#d("Étape 5 · Solution : fusion de la branche")[
  #objectif[
    modifier `altitudes.py` sur `master`, puis y fusionner la branche `cumul`.
  ]

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

#d("Étape 6 · Même ligne sur deux branches")[
  #objectif[
    modifier la même ligne de `altitudes.py` sur `master` et sur une nouvelle branche, `mesure-4`.
  ]

  #consignes(
    taille: 16pt,
    [Créer la branche `mesure-4` : `git checkout -b mesure-4`.],
    [Dans `altitudes.py`, ajouter `92.5` à la fin de la liste, puis créer un commit : #commandes("git add altitudes.py", "git commit -m \"Ajoute la mesure 92.5\"")],
    [Revenir sur `master` : `git checkout master`.],
    [Dans `altitudes.py`, ajouter `123.7` à la fin de la liste, puis créer un commit : #commandes("git add altitudes.py", "git commit -m \"Ajoute la mesure 123.7\"")
      #constat[Deux commits, un sur chaque branche.]],
  )

  #notes[
    Les étapes 5 et 6 sont celles qui débordent. Si le temps manque,
    s'arrêter après l'étape 5 ; l'étape 6 se fait seule, avec le guide.
  ]
]

#d("Étape 6 · Résolution du conflit")[
  #objectif[
    fusionner `mesure-4` dans `master`, et garder les deux altitudes ajoutées.
  ]

  #consignes(
    taille: 16pt,
    [Fusionner la branche : `git merge mesure-4`.
      #constat[`CONFLIT (contenu)` ; les marqueurs dans `altitudes.py`.]],
    [Lancer le programme : `python altitudes.py`.
      #constat[`SyntaxError` : les marqueurs ne sont pas du Python.]],
    [Dans `altitudes.py`, écrire la ligne `altitudes = [79.6, 103.2, 98.3, 92.5, 123.7]`, puis retirer les marqueurs et enregistrer.],
    [Lancer le programme.
      #constat[`123.7`, `44.1`, `54.8` et `10.7`.]],
    [Terminer la fusion : #commandes("git add altitudes.py", "git commit -m \"Fusionne les deux mesures\"")
      #constat[Un commit de fusion.]],
  )
]

#d("Étape 6 · Graphe du dépôt")[
  #objectif[
    dessiner le graphe du dépôt, puis le comparer à celui que git affiche.
  ]

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

    À relever sur un poste de la salle : la sortie de `ls -a` dans `copie/` (guide,
    étape 7.1).
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
        (nom: "c1", col: 0, voie: 0, id: "64e"),
        (nom: "c2", col: 1, voie: 0, id: "726", parents: ("c1",)),
        (nom: "c3", col: 2, voie: 0, id: "409", parents: ("c2",)),
        (nom: "c4", col: 3, voie: 0, id: "ccd", parents: ("c3",)),
        (nom: "c5", col: 4, voie: 1, id: "e0e", parents: ("c4",)),
        (nom: "c6", col: 4, voie: 0, id: "f42", parents: ("c4",)),
        (nom: "c7", col: 5, voie: 0, id: "5e6", parents: ("c6", "c5")),
        (nom: "c8", col: 6, voie: 1, id: "a24", parents: ("c7",)),
        (nom: "c9", col: 6, voie: 0, id: "414", parents: ("c7",)),
        (nom: "c10", col: 7, voie: 0, id: "e0c", parents: ("c9", "c8")),
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
