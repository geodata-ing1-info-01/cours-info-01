// Clôture du cours 2 v2 — incluse en dernier par `cours2_v2.typ`.
// Un fichier inclus n'hérite pas des imports de son appelant.
//
// Comme au cours 1 v2 : une partie à part, avec trois aide-mémoire, git d'abord. Les
// notions de l'ancien tableau « À retenir » sont dans les notes du premier.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": schema-zones-commandes

#separateur(
  "À retenir",
  annonce: "Récapituler les commandes git de la séance, puis les raccourcis de VS Code.",
)

// --------------------------------------------
// Les lignes reprennent les mots des diapositives de la partie git.
#d("Aide-mémoire : enregistrer des versions avec git")[
  #align(center, schema-zones-commandes(echelle: 0.9))

  #v(0.3em)
  #show table.cell: set text(size: 12.5pt)
  #tableau(
    columns: (auto, 1fr, auto, 1fr),
    align: left + horizon,
    table.cell(colspan: 2)[Créer un dépôt, enregistrer], table.cell(colspan: 2)[Comparer, annuler, ignorer],
    [`git init`], [crée le dépôt `.git`], [`git diff`], [montre les lignes modifiées],
    [`git config user.name "Nom"`], [nomme l'auteur des commits], [`git restore fichier`], [remet le fichier du dernier commit],
    [`git status`], [affiche l'état, à taper d'abord], [`git revert commit`], [défait un commit par un nouveau commit],
    [`git add fichier`], [place le fichier dans l'index], [`.gitignore`], [liste les fichiers que git ignore],
    [`git commit -m "message"`], [enregistre l'index dans un commit], [`git commande -h`], [affiche les options],
    [`git log --oneline`], [liste les commits], [`git commande --help`], [ouvre le manuel],
  )

  #notes[
    Faire retrouver, pour quelques lignes, la diapositive ou l'étape du TD 2c où la
    commande a servi.

    Notions de la séance, à rappeler à l'oral : un commit enregistre ce que `git add` a
    placé dans l'index, avec le contenu complet des fichiers ; `git status` se tape avant
    toute autre commande ; un fichier qui se refait par une commande ne se versionne pas ;
    une copie d'un dépôt contient tout l'historique (cours 6).
  ]
]

// --------------------------------------------
// Le conflit est celui du TD 2c, comme dans « Résoudre un conflit ».
#d("Aide-mémoire : branches, fusion et conflit")[
  #show table.cell: set text(size: 13pt)
  #tableau(
    columns: (auto, 1fr, auto, 1fr),
    align: left + horizon,
    table.cell(colspan: 2)[Branches], table.cell(colspan: 2)[Fusion],
    [`git branch`], [liste les branches, `*` devant la branche courante], [`git merge nom`], [apporte les commits de `nom` dans la branche courante],
    [`git checkout -b nom`], [crée la branche `nom` et s'y place], [`git rebase nom`], [refait les commits de la branche courante à la suite de `nom`],
    [`git checkout nom`], [passe sur la branche `nom`, et change les fichiers du dossier], [`git log --oneline --graph --all`], [affiche le graphe de toutes les branches],
  )

  #v(0.5em)
  #grid(
    columns: (auto, 1fr), column-gutter: 16pt, align: horizon,
    block(fill: gris, inset: (x: 10pt, y: 8pt), text(size: 15pt,
      raw(block: true, "<<<<<<< HEAD\naltitudes = [79.6, 103.2, 98.3, 123.7]\n=======\naltitudes = [79.6, 103.2, 98.3, 92.5]\n>>>>>>> mesure-4"))),
    tableau(
      columns: (auto, 1fr),
      align: left + horizon,
      table.cell(colspan: 2)[Conflit],
      [`<<<<<<< HEAD`], [ouvre la version de la branche courante],
      [`>>>>>>> nom`], [ferme la version de la branche fusionnée, après `=======`],
      [`git add`, `git commit`], [terminent la fusion, une fois la ligne voulue écrite à la place des marqueurs],
      [`git merge --abort`], [annule la fusion en cours],
    ),
  )

  #notes[
    Notions à rappeler : une branche est un nom posé sur un commit, et `HEAD` désigne la
    branche courante ; un conflit vient de deux modifications de la même ligne, et se
    résout à la main.
  ]
]

// --------------------------------------------
// Les raccourcis et les réglages du TD 2a, et les deux usages de git dans VS Code vus en
// partie git.
#d("Aide-mémoire : VS Code")[
  #show table.cell: set text(size: 13pt)
  #tableau(
    columns: (auto, 1fr, auto, 1fr),
    align: left + horizon,
    table.cell(colspan: 2)[Raccourcis et menus], table.cell(colspan: 2)[Réglages, Python et git],
    [`Ctrl` + `Maj` + `P`], [ouvre la palette de commandes], [User], [règle VS Code pour le compte, dans `settings.json`],
    [`Ctrl` + `,`], [ouvre les réglages], [Workspace], [règle le dossier ouvert, dans `.vscode/settings.json`, et l'emporte sur User],
    [`Ctrl` + `Maj` + `X`], [ouvre les extensions], [« Python: Select Interpreter »], [choisit le Python de l'extension],
    [Terminal, New Terminal], [ouvre Git Bash dans le dossier ouvert], [bouton #sym.triangle.filled.r], [lance le fichier Python ouvert],
    [`Ctrl` + `Maj` + `G`], [ouvre le panneau Source Control], [bouton +, puis Commit], [font `git add`, puis `git commit`],
    [`Ctrl` + `Maj` + `V`], [affiche l'aperçu d'un fichier Markdown], [« Resolve in Merge Editor »], [ouvre l'éditeur de fusion d'un fichier en conflit],
  )

  #notes[
    Un éditeur de code colore, vérifie et lance le code ; son terminal, au module, est
    Git Bash.

    Cours 3 : `altitudes.py` lit ses mesures dans un fichier.
  ]
]
