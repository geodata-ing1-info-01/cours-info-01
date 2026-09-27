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
#import "../../../commun/schemas_git.typ": graphe-git, marque-tete

#let td = (
  numero: "3a",
  titre: "Un dépôt git pour la recette",
  annonce: "Versionner la recette du TD 2a : commits, différences, fichiers ignorés, une branche fusionnée, un conflit résolu, le graphe du dépôt",
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

// Refaite le 28/09/2026 : le `.odt` n'est plus versionné puis retiré
// (`git rm --cached`), et la comparaison d'un fichier binaire est retirée
// du cours 2.
#d("Étape 4 : des fichiers produits par pandoc")[
  #tableau(
    columns: (auto, 1.25fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [4], [`pandoc recette.md -o recette.html`, puis `-o recette.odt` ; `git status`],
      reponse[deux fichiers non suivis],
    [4], [un fichier `.gitignore` avec deux lignes, `*.html` et `*.odt` ; `git status`],
      reponse[seul `.gitignore` est non suivi],
    [4], [`git add .gitignore`, `git commit -m "Ignore les fichiers produits par pandoc"`],
      reponse[« rien à valider », alors que `recette.html` et `recette.odt` sont dans le dossier],
  )

  #notes[
    `.gitignore` se crée dans VS Code : File, New File, nom `.gitignore`,
    une ligne par motif.
  ]
]

// Coupée en deux le 28/09/2026, avec l'ajout du graphe dessiné.
#d("Étape 5 : une branche, une fusion")[
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
  )

  #notes[
    La branche courante s'affiche entre parenthèses à la fin de l'invite de
    Git Bash.
  ]
]

#d("Étape 6 : un conflit, puis le graphe du dépôt")[
  #tableau(
    columns: (auto, 1.25fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [6], [branche `pour-18` : 18 crêpes ; sur `master` : 2 heures de repos, sur la même ligne],
      reponse[deux commits, un sur chaque branche],
    [6], [`git merge pour-18`], reponse[`CONFLIT (contenu)` ; les marqueurs dans `recette.md`],
    [6], [écrire la bonne ligne, retirer les marqueurs ; `git add`, `git commit`],
      reponse[un commit de fusion],
    [6], [dessiner sur papier le graphe du dépôt, puis `git log --oneline --graph --all --decorate`],
      reponse[le même graphe : neuf commits, deux fusions],
  )

  #legende[
    Pour aller plus loin : l'étape 7 du guide, une seconde copie du dépôt
    par `git clone`, puis `git pull`.
  ]

  #notes[
    Les étapes 5 et 6 sont celles qui débordent. Si le temps manque,
    s'arrêter après l'étape 5 ; l'étape 6 se fait seule, avec le guide.

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
