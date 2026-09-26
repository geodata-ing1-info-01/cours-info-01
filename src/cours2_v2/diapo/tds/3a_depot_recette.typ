// TD 3a du cours 2 v2 — « Un dépôt git pour la recette ».
//
// Nouveau (v2) : remplace les TD 3a, 4a et 4c du cours 2 de 2026 (dépôt
// `projet_2`, quatre branches). Un seul dépôt, celui de la recette écrite au
// TD 2a. Les diapositives résument les étapes ; le guide détaillé,
// `src/cours2_v2/notebook/td/3a_depot_recette/guide.md`, donne chaque commande
// et sa sortie. Sorties relevées par `rejeu/rejeu.sh`, à côté du guide.
//
// Inclus par `cours2_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 2_v2`.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "3a",
  titre: "Un dépôt git pour la recette",
  annonce: "Versionner la recette du TD 2a : commits, différences, fichiers ignorés, une branche fusionnée, un conflit résolu",
  dossier: "cours2/3a_depot_recette/",
  duree: "40′",
)
#separateur-td(..td)

#d("Étapes 0 et 1 : le dépôt et le premier commit")[
  #tableau(
    columns: (auto, 1.25fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [0], [copier `recette.md` et `crepes.jpg` du TD 2a dans `3a_depot_recette/travail/` ; ouvrir `travail/` dans VS Code],
      [le terminal de VS Code s'ouvre dans `travail`],
    [1], [`git init`, puis `ls -a`], reponse[`.git` parmi les noms],
    [1], [`git config user.name "Prénom Nom"`, puis `git config user.email …`],
      reponse[pas de message ; `git config user.name` affiche le nom],
    [1], [`git status`], reponse[deux fichiers non suivis],
    [1], [`git add recette.md crepes.jpg`, `git commit -m "Ajoute la recette des crêpes"`],
      reponse[`[master (commit racine) …]`, 2 fichiers],
  )

  #legende[
    Sans recette au TD 2a : `cp ../depart/recette.md ../depart/crepes.jpg .` depuis `travail/`.
  ]

  #notes[
    Le guide détaille chaque commande, sa sortie, et ce qu'il faut faire si
    elle ne donne pas le résultat attendu.

    `git config` sans `--global` : le réglage ne vaut que pour ce dépôt. Les
    postes sont partagés (même compte `eleve`) ; un réglage `--global`
    signerait les commits des autres élèves. Même choix au TD 3a du cours 3.
  ]
]

#d("Étapes 2 et 3 : modifier, comparer, restaurer")[
  #tableau(
    columns: (auto, 1.25fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [2], [passer les œufs de 4 à 3 ; `git status`, puis `git diff`],
      reponse[`modifié : recette.md` ; la ligne en `-` et en `+`],
    [2], [`git add recette.md`, `git commit -m "Réduit les œufs à trois"`, `git log --oneline`],
      reponse[deux commits, le plus récent en haut],
    [3], [abîmer une ligne de la préparation, enregistrer ; `git diff`],
      reponse[la ligne abîmée en `+`],
    [3], [`git restore recette.md`, puis `git status`],
      reponse[« rien à valider » ; la ligne est revenue dans VS Code],
  )

  #notes[
    Dans VS Code, le panneau du contrôle de code source (`Ctrl` + `Maj` +
    `G`) montre le même `diff`, côte à côte. Le faire regarder après le
    terminal.
  ]
]

#d("Étape 4 : un fichier produit par pandoc")[
  #tableau(
    columns: (auto, 1.25fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [4], [`pandoc recette.md -o recette.odt`, `git add recette.odt`, `git commit -m "Ajoute la recette au format .odt"`],
      reponse[un commit de plus],
    [4], [passer le lait à 600 ml, refaire le `.odt` ; `git diff`],
      reponse[la ligne du lait ; pour le `.odt`, « Binary files … differ »],
    [4], [`git rm --cached recette.odt` ; un fichier `.gitignore` avec `*.html` et `*.odt`],
      reponse[`git status` : `.odt` supprimé du dépôt, `.gitignore` non suivi],
    [4], [`git add .gitignore recette.md`, `git commit -m "Ignore les fichiers produits par pandoc"`],
      reponse[« rien à valider », alors que `recette.odt` est toujours là],
  )

  #notes[
    `.gitignore` se crée dans VS Code : File, New File, nom `.gitignore`,
    une ligne par motif.

    `git rm --cached` retire le fichier de l'index et laisse le fichier sur
    le disque. Sans `--cached`, il l'efface aussi.
  ]
]

#d("Étapes 5 et 6 : une branche, une fusion, un conflit")[
  #tableau(
    columns: (auto, 1.25fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [5], [`git checkout -b sans-gluten` ; farine de sarrasin ; commit],
      reponse[l'invite affiche `(sans-gluten)`],
    [5], [`git checkout master` ; ajouter une section « Conseil » ; commit],
      reponse[la farine est redevenue du blé],
    [5], [`git merge sans-gluten -m "Fusionne la variante sans gluten"`],
      reponse[sarrasin et conseil dans le même fichier],
    [6], [branche `pour-18` : 18 crêpes ; sur `master` : 2 heures de repos, sur la même ligne],
      reponse[deux commits, un sur chaque branche],
    [6], [`git merge pour-18`], reponse[`CONFLIT (contenu)` ; les marqueurs dans `recette.md`],
    [6], [écrire la bonne ligne, retirer les marqueurs ; `git add`, `git commit`],
      reponse[`git log --oneline --graph` : deux fusions],
  )

  #notes[
    Les étapes 5 et 6 sont celles qui débordent. Si le temps manque,
    s'arrêter après l'étape 5 ; l'étape 6 se fait seule, avec le guide.

    La branche courante s'affiche entre parenthèses à la fin de l'invite de
    Git Bash.
  ]
]
