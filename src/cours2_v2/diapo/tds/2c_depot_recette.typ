// TD 2c du cours 2 v2 — « Un dépôt git pour la recette ».
//
// Nouveau (v2) : remplace les TD 2a, 2b et 2d de 2026 (dépôt
// `projet_2`, quatre branches). Un seul dépôt, celui d'une recette en Markdown.
// Les diapositives résument les étapes ; le guide détaillé,
// `src/cours2_v2/notebook/td/2c_depot_recette/guide.md`, donne chaque commande
// et sa sortie. Sorties relevées par `rejeu/rejeu.sh`, à côté du guide.
//
// 04/11/2026 : le TD Markdown (ancien TD 2c) est retiré ; ce TD, ancien TD 2d,
// prend sa lettre et part de `depart/recette.md`. Les tableaux « Ce qu'il faut
// faire / Ce que vous constatez » deviennent des listes de consignes.
//
// Inclus par `cours2_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 2_v2`.
#import "../../../commun/prelude.typ": *
#import "../../../commun/schemas_git.typ": graphe-git, marque-tete
#import "../../../cours1_v2/diapo/schemas.typ": consignes, comment, commandes, constat

#let td = (
  numero: "2c",
  titre: "Un dépôt git pour la recette",
  annonce: "Objectif : versionner une recette, en suivre les versions, les différences et les branches, et résoudre un conflit de fusion",
  dossier: "cours2/2c_depot_recette/",
  duree: "40′",
)
#separateur-td(..td)

#d("Étape 0 · Copier la recette")[
  #consignes(
    taille: 17pt,
    [Aller dans le dossier du TD, et copier la recette et sa photo dans `travail/` : #commandes("cd ~/Desktop/info01/cours2/2c_depot_recette", "cp depart/recette.md depart/crepes.jpg travail/")],
    [Ouvrir `travail/` dans VS Code : #comment[File, Open Folder…, `cours2\2c_depot_recette\travail`.]],
    [Ouvrir un terminal : #comment[menu Terminal, New Terminal.]
      #constat[Le terminal de VS Code s'ouvre dans `travail`.]],
  )

  #notes[
    `recette.md` est en Markdown : syntaxe minimale vue au cours 1, dans les
    cellules du notebook.

    Pourquoi une recette pour git : une quantité, une étape ou un conseil
    changés se lisent dans `git diff` sans connaître le programme, et rien
    ne s'arrête sur une erreur.

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
      #constat[Deux fichiers non suivis.]],
    [Créer le premier commit : #commandes("git add recette.md crepes.jpg", "git commit -m \"Ajoute la recette des crêpes\"")
      #constat[`[master (commit racine) …]`, 2 fichiers.]],
  )

  #notes[
    `git config` sans `--global` : le réglage ne vaut que pour ce dépôt. Les
    postes sont partagés (même compte `eleve`) ; un réglage `--global`
    signerait les commits des autres élèves.
  ]
]

#d("Étape 2 · Modifier la recette et comparer")[
  #consignes(
    taille: 17pt,
    [Dans `recette.md`, passer les œufs de 4 à 3, puis enregistrer le fichier.],
    [Afficher les modifications : `git status`, puis `git diff`.
      #constat[`modifié : recette.md` ; la ligne en `-` et en `+`.]],
    [Créer un commit : #commandes("git add recette.md", "git commit -m \"Réduit les œufs à trois\"")],
    [Afficher l'historique : `git log --oneline`.
      #constat[Deux commits, le plus récent en haut.]],
  )

  #notes[
    Dans VS Code, le panneau du contrôle de code source (`Ctrl` + `Maj` +
    `G`) montre le même `diff`, côte à côte. Le faire regarder après le
    terminal.
  ]
]

#d("Étape 3 · Annuler une modification")[
  #consignes(
    taille: 17pt,
    [Dans `recette.md`, remplacer la dernière étape de la préparation par « Cuire. », puis enregistrer le fichier.],
    [Afficher la différence : `git diff`.
      #constat[La ligne modifiée en `+`.]],
    [Restaurer le fichier : `git restore recette.md`.],
    [Afficher l'état du dépôt : `git status`.
      #constat[« rien à valider » ; la ligne est revenue dans VS Code.]],
  )
]

// Refaite le 28/09/2026 : le `.odt` n'est plus versionné puis retiré
// (`git rm --cached`), et la comparaison d'un fichier binaire est retirée
// du cours 2. Annonce ajoutée le 04/11/2026 : pandoc était présenté au TD
// Markdown, retiré.
#d("Étape 4 · Ignorer les fichiers produits par pandoc")[
  #annonce[
    pandoc convertit un fichier Markdown en page web ou en document
    LibreOffice, d'après l'extension demandée.
  ]

  #consignes(
    taille: 16pt,
    [Produire la page et le document : #commandes("pandoc recette.md -o recette.html", "pandoc recette.md -o recette.odt")],
    [Afficher l'état du dépôt : `git status`.
      #constat[Deux fichiers non suivis.]],
    [Créer le fichier `.gitignore`, avec les deux lignes `*.html` et `*.odt`. Afficher de nouveau l'état du dépôt.
      #constat[Seul `.gitignore` est non suivi.]],
    [Créer un commit : #commandes("git add .gitignore", "git commit -m \"Ignore les fichiers produits par pandoc\"")
      #constat[« rien à valider », alors que `recette.html` et `recette.odt` sont dans le dossier.]],
  )

  #notes[
    `.gitignore` se crée dans VS Code : File, New File, nom `.gitignore`,
    une ligne par motif.
  ]
]

// Coupée en deux le 28/09/2026, avec l'ajout du graphe dessiné.
#d("Étape 5 · Créer une branche, puis la fusionner")[
  #consignes(
    taille: 16pt,
    [Créer la branche `sans-gluten` : `git checkout -b sans-gluten`.
      #constat[L'invite affiche `(sans-gluten)`.]],
    [Dans `recette.md`, remplacer la farine par de la farine de sarrasin, puis créer un commit : #commandes("git add recette.md", "git commit -m \"Remplace la farine de blé par du sarrasin\"")],
    [Revenir sur `master` : `git checkout master`.
      #constat[La farine est redevenue du blé.]],
    [À la fin de `recette.md`, ajouter une section « Conseil », puis créer un commit : #commandes("git add recette.md", "git commit -m \"Ajoute un conseil de conservation\"")],
    [Fusionner la branche : `git merge sans-gluten -m "Fusionne la variante sans gluten"`.
      #constat[Sarrasin et conseil dans le même fichier.]],
  )

  #notes[
    La branche courante s'affiche entre parenthèses à la fin de l'invite de
    Git Bash.
  ]
]

#d("Étape 6 · Modifier la même ligne sur deux branches")[
  #consignes(
    taille: 16pt,
    [Créer la branche `pour-18` : `git checkout -b pour-18`.],
    [À la troisième ligne de `recette.md`, écrire « Pour 18 crêpes », puis créer un commit : #commandes("git add recette.md", "git commit -m \"Passe la recette à 18 crêpes\"")],
    [Revenir sur `master` : `git checkout master`.],
    [À la même ligne, écrire « 2 heures de repos », puis créer un commit : #commandes("git add recette.md", "git commit -m \"Allonge le repos à deux heures\"")
      #constat[Deux commits, un sur chaque branche.]],
  )

  #notes[
    Les étapes 5 et 6 sont celles qui débordent. Si le temps manque,
    s'arrêter après l'étape 5 ; l'étape 6 se fait seule, avec le guide.
  ]
]

#d("Étape 6 · Résoudre le conflit, puis lire le graphe")[
  #consignes(
    taille: 16pt,
    [Fusionner la branche : `git merge pour-18`.
      #constat[`CONFLIT (contenu)` ; les marqueurs dans `recette.md`.]],
    [Dans `recette.md`, écrire la ligne « Pour 18 crêpes », avec « 2 heures de repos », puis retirer les marqueurs.],
    [Terminer la fusion : #commandes("git add recette.md", "git commit -m \"Fusionne la version pour 18 crêpes\"")
      #constat[Un commit de fusion.]],
    [Dessiner sur papier le graphe du dépôt.],
    [Comparer le dessin au graphe de git : `git log --oneline --graph --all --decorate`.
      #constat[Le même graphe : neuf commits, deux fusions.]],
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

// Nouveau (28/09/2026) : le graphe attendu à la fin de l'étape 6, au corrigé
// seulement (les élèves le dessinent avant `git log --graph`). Identifiants
// du rejeu, `rejeu/sortie.txt`.
#if corrige-visible {
  d("Le graphe du dépôt à la fin du TD")[
    #annonce[
      Neuf commits, dont deux fusions. Chaque fusion a deux parents.
    ]

    #align(center, graphe-git(
      commits: (
        (nom: "c1", col: 0, voie: 0, id: "a16"),
        (nom: "c2", col: 1, voie: 0, id: "fe4", parents: ("c1",)),
        (nom: "c3", col: 2, voie: 0, id: "28c", parents: ("c2",)),
        (nom: "c4", col: 3, voie: 1, id: "939", parents: ("c3",)),
        (nom: "c5", col: 3, voie: 0, id: "220", parents: ("c3",)),
        (nom: "c6", col: 4, voie: 0, id: "eda", parents: ("c5", "c4")),
        (nom: "c7", col: 5, voie: 1, id: "c50", parents: ("c6",)),
        (nom: "c8", col: 5, voie: 0, id: "b6b", parents: ("c6",)),
        (nom: "c9", col: 6, voie: 0, id: "e87", parents: ("c8", "c7")),
      ),
      branches: (
        (nom: "master", voie: 0, commit: "c9"),
        (nom: "sans-gluten", voie: 1, commit: "c4"),
        (nom: "pour-18", voie: 1, commit: "c7"),
      ),
      echelle: 1.25,
      taille-etiquette: 10pt,
      extra: (pos, d) => marque-tete(d, pos("c9"), dx: 0.7, dy: 0.8),
    ))

    #legende[
      Dans chaque pastille, le début de l'identifiant, comme dans
      `git log --oneline`. La flèche va d'un commit vers son parent.
    ]
  ]
}
