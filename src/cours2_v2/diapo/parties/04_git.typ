// Partie 4 du cours 2 v2 — git local. Incluse par `cours2_v2.typ`.
// Un fichier inclus n'hérite pas des imports de son appelant.
//
// Nouveau (v2) : réécriture des parties 2 à 6 du cours 2 de 2026 (support de
// Florent Geniet), sur le modèle titre, annonce, preuve visuelle. Les treize
// pages « à quoi sert git » sont ramenées à trois ; `revert`, `tag`, `rebase`
// et l'organisation main, develop, feature passent en annexe.
//
// Reprise du 28/09/2026 : deux diapositives sur les systèmes de version et
// les copies d'un dépôt (théorie ; pratique au cours 6, et à l'étape 7 du
// TD 2d pour ceux qui ont fini) ; un graphe par notion, dessiné sur
// l'historique du TD ; `git status` et `git log` fondus dans les diapositives
// voisines ; le fichier binaire retiré ; une diapositive théorique sur les
// branches à plusieurs, en fin de partie.
//
// Toutes les sorties sont celles du rejeu du TD 2d (git 2.43, en français) :
// `src/cours2_v2/notebook/td/2d_depot_recette/rejeu/sortie.txt`. Dans les
// graphes, chaque pastille porte le début de l'identifiant du commit.
#import "../../../commun/prelude.typ": *
#import "../../../commun/schemas_git.typ": graphe-git, marque-tete, marque-conflit, rouge-attention

// Une sortie de terminal, en chasse fixe sur fond gris. `taille` est celle
// du texte courant : le code en prend 0,78.
#let console(texte, taille: 17pt) = block(
  width: 100%, fill: gris, inset: (x: 10pt, y: 8pt),
)[
  #set text(size: taille)
  #set par(leading: 0.5em)
  #raw(texte, block: true)
]

// Un historique de trois commits, en petit, pour les schémas de dépôts.
#let _historique = graphe-git(
  commits: (
    (nom: "c1", col: 0, voie: 0),
    (nom: "c2", col: 1, voie: 0, parents: ("c1",)),
    (nom: "c3", col: 2, voie: 0, parents: ("c2",)),
  ),
  echelle: 0.85, ecart-x: 1.2, taille-etiquette: 9pt,
)

// La dernière version seule, sans son historique.
#let _une-version = graphe-git(
  commits: ((nom: "c3", col: 0, voie: 0),),
  echelle: 0.85, taille-etiquette: 9pt,
)

// Une machine ou un support, et ce qu'il contient.
#let _machine(nom, corps, plein: false) = block(
  inset: (x: 9pt, y: 6pt), radius: 3pt,
  fill: if plein { accent.lighten(90%) } else { white },
  stroke: 1pt + accent.lighten(55%),
)[
  #align(center)[
    #text(size: 13pt, weight: demi-gras)[#nom]
    #v(0.15em, weak: true)
    #corps
  ]
]

#let _double-fleche(vertical: false) = align(center + horizon, text(
  size: 22pt, fill: accent,
  if vertical { sym.arrow.t.b } else { sym.arrow.l.r },
))

// Un cartouche de branche dessiné à la main, pour une branche qui désigne
// le même commit qu'une autre : `graphe-git` n'en place qu'un par commit.
#let _cartouche(d, p, nom, couleur, dy: -1.06) = d.content(
  (p.at(0), p.at(1) + dy),
  box(fill: couleur, inset: (x: 6pt, y: 3.5pt), radius: 4pt,
    text(size: 11pt, weight: demi-gras, fill: white)[#nom]),
)

#separateur(
  "Git local",
  annonce: "Enregistrer les versions successives d'un projet, les comparer, travailler sur une variante et la fusionner.",
)

// --------------------------------------------
#d("À quoi sert git")[
  #annonce[
    git enregistre les versions successives des fichiers d'un projet. Chaque
    version se relit, se compare et se restaure.
  ]

  #face-a-face(
    panneau("Sans git : une copie par version")[
      #console("recette.md\nrecette_v2.md\nrecette_v2_corrigee.md\nrecette_finale.md\nrecette_finale_OK.md")
    ],
    panneau("Avec git : un fichier et son historique")[
      #console("$ git log --oneline\n28cbb91 Ignore les fichiers produits par pandoc\nfe4fe8b Réduit les œufs à trois\na16d497 Ajoute la recette des crêpes", taille: 14pt)
    ],
  )

  #legende[
    Chaque ligne de droite est un commit : une version enregistrée, avec son
    identifiant et un message qui décrit ce qui a changé.
  ]

  #notes[
    Colonne de gauche : ce que la plupart ont déjà fait. Rien n'indique ce qui
    distingue deux copies, ni laquelle est la bonne.

    Colonne de droite : `git log --oneline` relevé à l'étape 4 du TD 2d.
  ]
]

// --------------------------------------------
// Nouveau (28/09/2026), d'après Pro Git, chapitre 1.
#d("Les systèmes de version")[
  #annonce[
    Un système centralisé garde l'historique sur un serveur. Dans un système
    distribué, comme git, chaque copie du projet contient tout l'historique.
  ]

  #face-a-face(
    panneau("Centralisé : CVS (1986), Subversion (2000)")[
      #align(center)[
        #_machine("Serveur", _historique, plein: true)
        #v(0.2em)
        #grid(
          columns: 3, column-gutter: 12pt,
          ..range(1, 4).map(i => stack(
            dir: ttb, spacing: 3pt,
            _double-fleche(vertical: true),
            _machine("Poste " + str(i), _une-version),
          )),
        )
      ]
    ],
    panneau("Distribué : git, Mercurial (2005)")[
      #v(1.2em)
      #align(center, grid(
        columns: 5, column-gutter: 4pt, align: horizon,
        _machine("Poste 1", _historique), _double-fleche(),
        _machine("Poste 2", _historique), _double-fleche(),
        _machine("Clé USB", _historique),
      ))
    ],
  )

  #legende[
    À gauche, un poste n'a que la dernière version, et il faut le serveur
    pour faire un commit ou lire l'historique. À droite, chaque dépôt a
    tous les commits, et un commit se fait sans réseau.
  ]

  #notes[
    Avant : des copies à la main (diapositive précédente), puis RCS (1982),
    l'historique d'un fichier sur un seul poste.

    git est écrit par Linus Torvalds en avril 2005 pour le noyau Linux,
    quand la licence gratuite de BitKeeper, l'outil distribué employé
    jusque-là, est retirée. Mercurial date du même mois.

    Pro Git, chapitre 1 (git-scm.com/book/fr), dessine ces familles : le
    serveur central est un « point unique de panne », et dans un système
    distribué chaque copie est « une sauvegarde complète de toutes les
    données ».

    Presque toutes les commandes du jour s'exécutent sur le dépôt local,
    sans réseau.
  ]
]

// --------------------------------------------
// Nouveau (28/09/2026). Théorie seule ; la pratique est au cours 6, et à
// l'étape 7 du TD 2d pour ceux qui ont fini.
#d("Les copies d'un dépôt")[
  #annonce[
    Une copie d'un dépôt git a tous ses commits. Deux copies échangent
    ensuite leurs nouveaux commits, sur un même poste, par une clé USB ou
    par un serveur.
  ]

  // Le poste de la salle et l'ordinateur personnel ne se relient que par
  // la clé USB ou par la forge (pas d'accès au réseau de l'école depuis
  // chez soi). Disposition revue le 28/09/2026.
  #align(center, scale(125%, reflow: true, grid(
    columns: 5, column-gutter: 6pt, row-gutter: 4pt, align: center + horizon,
    [], [], _machine("Forge, au cours 6", _historique), _double-fleche(),
    _machine("Ordinateur personnel", _historique),
    [], [], _double-fleche(vertical: true), [], _double-fleche(vertical: true),
    _machine("Dépôt d'un camarade", _historique), _double-fleche(),
    _machine("Poste de la salle", _historique, plein: true), _double-fleche(),
    _machine("Clé USB", _historique),
  )))

  #legende[
    `git clone` crée une copie. `git pull` récupère les nouveaux commits
    d'une autre copie, `git push` y envoie les siens.
  ]

  #notes[
    Pas de pratique aujourd'hui, hors l'étape 7 du TD 2d (seconde copie par
    `git clone`, un commit passé par `git pull`), pour ceux qui ont fini.

    Comme le réseau de l'école n'est pas accessible depuis chez soi, les
    commits passent du poste de la salle à l'ordinateur personnel par la
    clé USB ou par la forge.

    Cours 6 : clone local d'abord, puis la forge, qui n'est qu'une copie de
    plus. Le cours 1 l'a annoncé sur le dossier partagé : chacun travaille
    dans sa copie, et les modifications se fusionnent.

    Une copie « distante » peut être un dossier du même poste ou une clé
    USB (P.-A. Champin, _Introduction à GIT_, IUT Lyon 1). Pas de dépôt
    commun dans `formationTemp`, où le cours 1 demande de ne pas
    travailler.
  ]
]

// --------------------------------------------
// Nouveau (28/09/2026) : git en ligne de commande, la sous-commande, l'aide.
// Prolonge « La forme d'une commande » du cours 1 v2.
#d("La commande git et ses sous-commandes")[
  #annonce[
    git est un programme en ligne de commande. Le mot qui suit `git` est une
    sous-commande, qui a ses propres options et ses propres arguments.
  ]

  #tableau(
    columns: (auto, auto, auto, 1fr),
    align: left + horizon,
    [Commande tapée], [Sous-commande], [Options], [Arguments],
    [`git init`], [`init`], [], [],
    [`git add recette.md crepes.jpg`], [`add`], [], [`recette.md`, `crepes.jpg`],
    [`git commit -m "Ajoute la recette"`], [`commit`], [`-m "Ajoute la recette"`], [],
    [`git log --oneline`], [`log`], [`--oneline`], [],
    [`git add -h`], [`add`], [`-h`], [],
  )

  #legende[
    Forme : `git <sous-commande> [options] <arguments>`, celle des commandes
    du cours 1 avec un mot de plus. `-m` prend une valeur : le message.
  ]

  #notes[
    `git` est un seul fichier exécutable, cherché dans `PATH` comme les
    autres commandes (cours 1). Chaque sous-commande est une opération :
    `init`, `add`, `commit`, `log`, et environ 150 autres
    (`git help -a`, git 2.43). La séance en emploie une douzaine.

    Erreur fréquente : oublier la sous-commande, ou taper une commande du
    terminal après `git` (`git cd`). git répond alors que ce n'est pas une
    commande git.

    Même découpage ailleurs dans le module : `conda activate`,
    `conda install` (cours 3).
  ]
]

// --------------------------------------------
// Nouveau (28/09/2026). Sorties relevées avec git 2.43 en français,
// réduites (`…`).
#d("L'aide de git")[
  #annonce[
    `git --help` liste les sous-commandes courantes. `-h` après une
    sous-commande affiche ses options.
  ]

  #face-a-face(
    panneau[`git --help`][
      #console("usage : git [-v | --version] [-h | --help] …\n           … <command> [<args>]\n\nCi-dessous les commandes Git habituelles dans\ndiverses situations :\n\ndémarrer une zone de travail\n   clone     Cloner un dépôt dans un nouveau répertoire\n   init      Créer un dépôt Git vide …\n\ntravailler sur la modification actuelle\n   add       Ajouter le contenu de fichiers dans l'index\n   …", taille: 13.5pt)
    ],
    panneau[`git add -h`][
      #console("usage : git add [<options>] [--] <chemin>...\n\n    -n, --[no-]dry-run    simuler l'action\n    -v, --[no-]verbose    mode verbeux\n    …\n    -f, --[no-]force      permettre l'ajout de\n                          fichiers ignorés\n    …", taille: 13.5pt)
    ],
  )

  #legende[
    `git add --help` ouvre la page complète du manuel : dans le navigateur
    sous Windows, dans le terminal sous Linux et macOS (`q` pour quitter).
  ]

  #notes[
    Sorties réduites : les lignes longues sont coupées, les groupes de
    sous-commandes suivants (historique, branches, collaboration) retirés.

    `git help add` fait la même chose que `git add --help`. Git for
    Windows ouvre la page HTML installée avec lui, sans réseau.

    Dans les crochets et les chevrons de l'usage, la notation du cours 1 :
    facultatif, à remplacer.
  ]
]

// --------------------------------------------
#d("Créer un dépôt : git init")[
  #annonce[
    `git init` fait du dossier courant un dépôt : il y crée un dossier
    caché, `.git`, qui contiendra l'historique.
  ]

  #console("$ cd ~/Desktop/info01/cours2/2d_depot_recette/travail\n$ pwd\n/c/Users/eleve/Desktop/info01/cours2/2d_depot_recette/travail\n$ git init\nDépôt Git vide initialisé dans …/2d_depot_recette/travail/.git/\n$ ls -a\n.\n..\ncrepes.jpg\n.git\nrecette.md", taille: 17pt)

  #legende[
    Les fichiers du dossier ne changent pas. Supprimer `.git` supprime
    l'historique, et laisse les fichiers.
  ]

  #notes[
    `cd` et `pwd` d'abord (ajoutés le 28/09/2026) : le dépôt se crée dans le
    dossier courant, quel qu'il soit. Un `git init` tapé dans `~` fait du
    dossier personnel entier un dépôt ; le supprimer par `rm -rf ~/.git`.
    L'invite de Git Bash affiche aussi le dossier courant.

    `git init` affiche d'abord une dizaine de lignes `astuce:` sur le nom de
    la branche initiale, `master`. Les laisser défiler. GitHub nomme sa
    branche initiale `main`.

    Avant le premier commit, dans le dépôt : `git config user.name` et
    `user.email`, sans `--global`, les postes étant partagés (étape 1 du TD).
    Faire écrire son propre nom : l'identité de l'exemple est recopiée
    telle quelle (erreur relevée par Software Carpentry).
  ]
]

// --------------------------------------------
// « L'état du dépôt : git status » y est fondue le 28/09/2026.
#d("Trois zones : dossier, index, dépôt")[
  #annonce[
    Un commit enregistre ce que `git add` a placé dans l'index, et rien
    d'autre.
  ]

  #grid(
    columns: (1fr, auto, 1fr, auto, 1fr), column-gutter: 8pt, align: horizon,
    bloc("Dossier de travail", "les fichiers tels qu'on les modifie", hauteur: 90pt),
    align(center)[#text(size: 15pt, font: police-code)[git add] \ #text(size: 26pt, fill: accent)[→]],
    bloc("Index", "ce qui entrera dans le prochain commit", hauteur: 90pt),
    align(center)[#text(size: 15pt, font: police-code)[git commit] \ #text(size: 26pt, fill: accent)[→]],
    bloc("Dépôt", "l'historique des commits, dans .git", plein: true, hauteur: 90pt),
  )

  #v(0.5em)
  #tableau(
    columns: (1fr, auto),
    align: left + horizon,
    [Ce qu'affiche `git status`], [Zone],
    [« Fichiers non suivis », « Modifications qui ne seront pas validées »], [dossier de travail],
    [« Modifications qui seront validées »], [index],
    [« rien à valider, la copie de travail est propre »], [tout est dans le dépôt],
  )

  #legende[
    `git status` affiche aussi la branche courante et les commandes qui
    s'appliquent. La taper avant toute autre, et avant de demander de
    l'aide.
  ]

  #notes[
    L'index s'appelle aussi « zone de préparation » (_staging area_). Il
    permet de choisir ce qu'un commit contient : deux modifications sans
    rapport font deux commits. Index, _staged_ et zone de préparation
    désignent la même chose : le dire une fois.

    Le cycle de vie du cours 2 de 2026 (non suivi, suivi, modifié) se lit
    sur ce schéma.

    Git Bash affiche aussi la branche dans l'invite, entre parenthèses :
    `~/…/travail (master)`.
  ]
]

// --------------------------------------------
// « L'historique : git log » y est fondue le 28/09/2026, avec le graphe.
#d("Enregistrer une version : add, puis commit")[
  #annonce[
    `git add` place un fichier dans l'index ; `git commit` enregistre l'index
    comme une nouvelle version, avec un message.
  ]

  #grid(
    columns: (1.5fr, 1fr), column-gutter: 20pt, align: horizon,
    console("$ git add recette.md crepes.jpg\n$ git commit -m \"Ajoute la recette des crêpes\"\n[master (commit racine) a16d497] Ajoute la recette des crêpes\n 2 files changed, 24 insertions(+)\n create mode 100644 crepes.jpg\n create mode 100644 recette.md\n…\n$ git log --oneline\nfe4fe8b Réduit les œufs à trois\na16d497 Ajoute la recette des crêpes", taille: 14pt),
    align(center, graphe-git(
      commits: (
        (nom: "c1", col: 0, voie: 0, id: "a16"),
        (nom: "c2", col: 1, voie: 0, id: "fe4", parents: ("c1",)),
      ),
      branches: ((nom: "master", voie: 0, commit: "c2"),),
      echelle: 1.4,
      taille-etiquette: 10pt,
      extra: (pos, d) => marque-tete(d, pos("c2"), dx: 0.8, dy: 0.8),
    )),
  )

  #legende[
    `a16d497` est le début de l'identifiant du commit, calculé à partir de
    son contenu. Chaque commit désigne son parent, d'où la flèche de `fe4`
    vers `a16` ; `master` désigne le dernier commit, et avance à chaque
    commit.
  ]

  #notes[
    L'identifiant complet a 40 caractères (`git log` sans option, qui donne
    aussi l'auteur et la date). Les sept premiers suffisent à le désigner
    dans un dépôt. Il diffère sur chaque poste.

    `-m` donne le message sur la ligne de commande. Sans `-m`, git ouvre un
    éditeur de texte (vim dans Git Bash) : `Échap`, puis `:q!` pour en
    sortir sans enregistrer.

    `…` : le second commit, fait à l'étape 2 du TD. Un historique long
    s'affiche page par page : `q` pour quitter.

    Le graphe se lit de gauche à droite dans le temps ; `git log` affiche le
    plus récent en haut.
  ]
]

// --------------------------------------------
#d("Le message de commit")[
  #annonce[
    Le message décrit ce que le commit change, en une ligne, avec un verbe au
    présent. Un commit porte une seule modification.
  ]

  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
    [Message], [Ce qu'on en apprend dans six mois],
    [`modif`], [rien],
    [`corrections`], [rien : lesquelles ?],
    [`Réduit les œufs à trois`], [la quantité d'œufs a changé],
    [`Ignore les fichiers produits par pandoc`], [d'où vient le `.gitignore`],
  )

  #legende[
    Le verbe complète « Ce commit… » : ajoute, corrige, remplace, ignore.
  ]

  #notes[
    Repris des bonnes pratiques du cours 2 de 2026 (diapositives 66 à 71),
    ramenées à une.

    Ne pas committer un code qui ne s'exécute pas : le dire à l'oral.
  ]
]

// --------------------------------------------
#d("Ce qui a changé : git diff")[
  #annonce[
    `git diff` montre les lignes modifiées depuis le dernier commit : en `-`
    l'ancienne version, en `+` la nouvelle, avec trois lignes de contexte.
  ]

  #console("$ git diff\ndiff --git a/recette.md b/recette.md\nindex aae4747..45bc5f0 100644\n--- a/recette.md\n+++ b/recette.md\n@@ -9,7 +9,7 @@\n | Ingrédient | Quantité |\n |---|---|\n | Farine | 250 g |\n-| Œufs | 4 |\n+| Œufs | 3 |\n | Lait | 500 ml |\n | Sel | 1 pincée |\n | Beurre fondu | 50 g |", taille: 14pt)

  #legende[
    `@@ -9,7 +9,7 @@` : le passage commence à la ligne 9, et fait 7 lignes
    avant comme après. VS Code montre le même écart côte à côte.
  ]

  #notes[
    Dans Git Bash, les lignes `-` sont en rouge, les `+` en vert. Une ligne
    modifiée est une ligne retirée puis une ligne ajoutée.

    Dans VS Code : panneau du contrôle de code source (`Ctrl` + `Maj` +
    `G`), clic sur le fichier.
  ]
]

// --------------------------------------------
#d("Annuler une modification non validée : git restore")[
  #annonce[
    `git restore` remet un fichier dans l'état du dernier commit. La
    modification est perdue : elle n'avait pas été enregistrée.
  ]

  #face-a-face(
    panneau("Une ligne abîmée par erreur")[
      #console("$ git diff\n@@ -21,4 +21,4 @@\n 5. Laisser reposer une heure.\n-6. Cuire dans une poêle chaude, une minute par face.\n+6. Cuire.", taille: 13pt)
    ],
    panneau("Remise en état")[
      #console("$ git restore recette.md\n$ git status\nSur la branche master\nrien à valider, la copie de travail est propre", taille: 13pt)
    ],
  )

  #legende[
    Sortie de gauche réduite à la ligne `@@` et aux lignes modifiées ; les
    quatre lignes d'en-tête du `diff` sont celles de la diapositive
    précédente.
  ]

  #notes[
    git ne peut restaurer que ce qu'il a enregistré : une raison de faire
    des commits souvent.

    Revenir sur un commit (`git revert`) : page « Git et le dépôt local »
    de la séance 2 de 2026, dans l'archive du book.
  ]
]

// --------------------------------------------
// Reprend le second tableau de « Quand employer git » et l'avertissement sur
// les données de la partie Markdown (28/09/2026).
#d("Ignorer des fichiers : .gitignore")[
  #annonce[
    Un fichier `.gitignore` liste des motifs de noms. `git status` n'affiche
    plus les fichiers qui y correspondent, et `git add` ne les ajoute pas.
  ]

  #tableau(
    columns: (auto, 1fr, auto),
    align: left + horizon,
    [Ce qu'on ne versionne pas], [Pourquoi], [Motif],
    [les fichiers produits par une commande], [ils se refont depuis leur source], [`*.html`],
    [les données de travail], [chaque version resterait dans l'historique], [`donnees/`],
    [les mots de passe et les clés], [toute copie du dépôt les contiendrait], [`.env`],
  )

  #v(0.3em)
  #grid(
    columns: (0.6fr, 0.8fr, 1.6fr), column-gutter: 14pt,
    panneau[`.gitignore`][#console("*.html\n*.odt", taille: 13pt)],
    panneau[`ls`][#console("crepes.jpg\nrecette.html\nrecette.md\nrecette.odt", taille: 13pt)],
    panneau[`git status`][#console("Sur la branche master\nrien à valider, la copie de\ntravail est propre", taille: 13pt)],
  )

  #legende[
    `.gitignore` se versionne avec le projet.
  ]

  #notes[
    Un fichier déjà suivi le reste : `git rm --cached fichier` le retire du
    dépôt et le laisse sur le disque.

    Les données : le projet n'en garde qu'un petit jeu d'essai. Un `.csv` de dix lignes qui sert à essayer le programme,
    oui ; le relevé de trois cents mégaoctets, non. Elles restent à côté du
    projet, dans un dossier que le programme reçoit en paramètre.

    Mots de passe et clés : cours 5.

    Les motifs sont ceux du terminal (cours 1) : `*` remplace une suite de
    caractères.
  ]
]

// --------------------------------------------
#d("Les branches")[
  #annonce[
    Une branche est un nom posé sur un commit. Elle avance d'un commit à
    chaque commit fait sur elle ; `HEAD` désigne la branche courante.
  ]

  #grid(
    columns: (1fr, 1.2fr), column-gutter: 20pt, align: horizon,
    align(center, graphe-git(
      commits: (
        (nom: "c3", col: 0, voie: 0, id: "28c"),
        (nom: "c5", col: 1, voie: 0, id: "220", parents: ("c3",)),
        (nom: "c4", col: 1, voie: 1, id: "939", parents: ("c3",)),
      ),
      branches: (
        (nom: "master", voie: 0, commit: "c5"),
        (nom: "sans-gluten", voie: 1, commit: "c4"),
      ),
      echelle: 1.4,
      taille-etiquette: 10pt,
      extra: (pos, d) => marque-tete(d, pos("c5"), dx: 1.0, dy: 0.9),
    )),
    console("$ git checkout -b sans-gluten\nBasculement sur la nouvelle branche 'sans-gluten'\n…\n$ git checkout master\n…\n$ git log --oneline --graph --all --decorate\n* 22060f2 (HEAD -> master) Ajoute un conseil…\n| * 9399bb0 (sans-gluten) Remplace la farine…\n|/\n* 28cbb91 Ignore les fichiers produits…", taille: 12.5pt),
  )

  #legende[
    `git checkout -b nom` crée une branche et s'y place ; `git checkout nom`
    change de branche ; `git branch` les liste.
  ]

  #notes[
    Sortie abrégée (`…`) : les commits et les messages entre les deux
    commandes sont dans le rejeu du TD, étape 5.

    Des débutants prennent une branche pour un dossier et tentent un `cd`
    vers elle (Isomöttönen et Cochez, 2014). Le graphe montre un nom posé
    sur un commit.

    `git switch` fait la même chose que `git checkout` pour les branches ;
    les cours 3 et 4 emploient `checkout`, on garde `checkout`.

    La branche initiale s'appelle `master` sur les postes (git 2.43), `main`
    sur GitHub.
  ]
]

// --------------------------------------------
// Le graphe de « Les branches », avec HEAD sur l'une ou l'autre branche.
#let _variante(tete) = graphe-git(
  commits: (
    (nom: "c3", col: 0, voie: 0, id: "28c"),
    (nom: "c5", col: 1, voie: 0, id: "220", parents: ("c3",)),
    (nom: "c4", col: 1, voie: 1, id: "939", parents: ("c3",)),
  ),
  branches: (
    (nom: "master", voie: 0, commit: "c5"),
    (nom: "sans-gluten", voie: 1, commit: "c4"),
  ),
  echelle: 1.15,
  taille-etiquette: 10pt,
  extra: (pos, d) => marque-tete(d, pos(tete), dx: 0.9, dy: if tete == "c5" { 0.75 } else { -0.75 }),
)

// Graphes ajoutés le 28/09/2026 ; `grep` retiré (non vu au cours 1 v2).
#d("Changer de branche change les fichiers")[
  #annonce[
    `git checkout` remplace les fichiers du dossier par ceux du dernier
    commit de la branche choisie.
  ]

  #face-a-face(
    panneau("Sur master")[
      #align(center, _variante("c5"))
      #v(0.3em)
      #console("| Farine | 250 g |", taille: 14pt)
    ],
    panneau[Après `git checkout sans-gluten`][
      #align(center, _variante("c4"))
      #v(0.3em)
      #console("| Farine de sarrasin | 250 g |", taille: 14pt)
    ],
  )

  #legende[
    Sous chaque graphe, la ligne de la farine dans `recette.md`, ouvert
    dans VS Code.
  ]

  #notes[
    `git checkout` s'arrête avec un message si une modification non validée
    serait écrasée : faire un commit, ou `git restore`, avant.

    Les autres fichiers du dossier, non suivis ou ignorés (`recette.html`),
    ne bougent pas.
  ]
]

// --------------------------------------------
// Graphes ajoutés le 28/09/2026.
#d("Fusionner : git merge")[
  #annonce[
    `git merge` apporte dans la branche courante les commits d'une autre
    branche. Quand les deux ont avancé, git crée un commit de fusion.
  ]

  #face-a-face(
    panneau("Seule sans-gluten a avancé")[
      #align(center, graphe-git(
        commits: (
          (nom: "c3", col: 0, voie: 0, id: "28c"),
          (nom: "c4", col: 1, voie: 0, id: "939", parents: ("c3",), place: "dessus"),
        ),
        branches: ((nom: "master", voie: 0, commit: "c4"),),
        echelle: 0.95,
        taille-etiquette: 10pt,
        extra: (pos, d) => _cartouche(d, pos("c4"), "sans-gluten", brun),
      ))
      #text(size: 14pt, fill: estompe)[`master` avance jusqu'au commit de la branche (avance rapide).]
    ],
    panneau("Les deux branches ont avancé")[
      #align(center, graphe-git(
        commits: (
          (nom: "c3", col: 0, voie: 0, id: "28c"),
          (nom: "c5", col: 1, voie: 0, id: "220", parents: ("c3",)),
          (nom: "c4", col: 1, voie: 1, id: "939", parents: ("c3",)),
          (nom: "c6", col: 2, voie: 0, id: "eda", parents: ("c5", "c4")),
        ),
        branches: (
          (nom: "master", voie: 0, commit: "c6"),
          (nom: "sans-gluten", voie: 1, commit: "c4"),
        ),
        echelle: 0.95,
        taille-etiquette: 10pt,
      ))
      #text(size: 14pt, fill: estompe)[`eda`, le commit de fusion, a deux parents (double trait).]
    ],
  )

  #console("$ git merge sans-gluten -m \"Fusionne la variante sans gluten\"\nFusion automatique de recette.md\nMerge made by the 'ort' strategy.", taille: 13pt)

  #notes[
    La fusion se lance depuis la branche qui reçoit, ici `master`.

    Le TD fait le cas de droite (étape 5). Le cas de gauche se produit
    quand `master` n'a pas reçu de commit depuis la création de la
    branche ; en anglais, _fast-forward_. L'étape 7 du TD le montre avec
    `git pull`.

    Sans `-m`, git ouvre un éditeur pour le message du commit de fusion
    (vim dans Git Bash) : `:wq` pour garder le message proposé.
  ]
]

// --------------------------------------------
// Graphe ajouté le 28/09/2026 ; puis la ligne avant et après chaque
// modification, et le contenu du fichier passé à « Résoudre un conflit ».
#d("Un conflit de fusion")[
  #annonce[
    Quand les deux branches ont modifié la même ligne, git arrête la fusion
    et écrit les deux versions dans le fichier.
  ]

  #grid(
    columns: (0.75fr, 1.6fr), column-gutter: 18pt, align: horizon,
    align(center, graphe-git(
      commits: (
        (nom: "c6", col: 0, voie: 0, id: "eda"),
        (nom: "c8", col: 1, voie: 0, id: "b6b", parents: ("c6",)),
        (nom: "c7", col: 1, voie: 1, id: "c50", parents: ("c6",)),
      ),
      branches: (
        (nom: "master", voie: 0, commit: "c8"),
        (nom: "pour-18", voie: 1, commit: "c7"),
      ),
      echelle: 1.1,
      taille-etiquette: 10pt,
      extra: (pos, d) => {
        let cible = (2 * 1.75, 0.0)
        let tiret = (paint: rouge-attention, thickness: 1pt, dash: "dashed")
        d.line((pos("c8").at(0) + 0.5, 0.0), (cible.at(0) - 0.3, 0.0), stroke: tiret)
        d.line((pos("c7").at(0) + 0.45, pos("c7").at(1) - 0.2), (cible.at(0) - 0.25, 0.2), stroke: tiret)
        marque-conflit(d, cible)
      },
    )),
    tableau(
      columns: (auto, 1fr),
      align: left + horizon,
      [Commit], [La troisième ligne de `recette.md`],
      [`eda`, avant], [#text(size: 18pt)[#raw("*Pour 12 crêpes — …, 1 heure de repos.*")]],
      [`c50`, `pour-18`], [#text(size: 18pt)[#raw("*Pour ")#underline(raw("18"))#raw(" crêpes — …, 1 heure de repos.*")]],
      [`b6b`, `master`], [#text(size: 18pt)[#raw("*Pour 12 crêpes — …, ")#underline(raw("2 heures"))#raw(" de repos.*")]],
    ),
  )

  #v(0.3em)
  #console("$ git merge pour-18\nFusion automatique de recette.md\nCONFLIT (contenu) : Conflit de fusion dans recette.md", taille: 14pt)

  #legende[
    `pour-18` a changé le nombre de crêpes, `master` le temps de repos : la
    même ligne, modifiée des deux côtés depuis `eda`. La partie modifiée est
    soulignée, et « … » abrège « 10 minutes de préparation ».
  ]

  #notes[
    Étape 6 du TD. La dernière ligne de git, « La fusion automatique a
    échoué ; réglez les conflits et validez le résultat. », est retirée de
    la sortie.

    Deux modifications sur deux lignes différentes se fusionnent sans
    conflit (la farine et le conseil, diapositive précédente).
  ]
]

// --------------------------------------------
// Reçoit le 28/09/2026 le contenu du fichier en conflit, venu de la
// diapositive précédente.
#d("Résoudre un conflit")[
  #annonce[
    Écrire la ligne voulue à la place des deux versions et des marqueurs,
    puis `git add` et `git commit` terminent la fusion.
  ]

  #face-a-face(
    panneau[`recette.md` après `git merge`][
      #console("# Crêpes\n\n<<<<<<< HEAD\n*Pour 12 crêpes — 10 minutes de\npréparation, 2 heures de repos.*\n=======\n*Pour 18 crêpes — 10 minutes de\npréparation, 1 heure de repos.*\n>>>>>>> pour-18", taille: 14pt)
    ],
    panneau[La ligne écrite, puis la fin de la fusion][
      #console("*Pour 18 crêpes — 10 minutes de\npréparation, 2 heures de repos.*\n$ git add recette.md\n$ git commit -m \"Fusionne la version\npour 18 crêpes\"\n[master e87b68f] Fusionne la version\npour 18 crêpes", taille: 14pt)
    ],
  )

  #legende[
    Entre `<<<<<<< HEAD` et `=======`, la ligne de la branche courante ; entre
    `=======` et `>>>>>>>`, celle de la branche fusionnée. La bonne ligne
    prend un morceau de chacune.
  ]

  #notes[
    Les lignes longues sont coupées pour tenir dans la colonne.

    VS Code affiche au-dessus du conflit « Accept Current Change », « Accept
    Incoming Change », « Accept Both Changes ». Ici, aucune ne convient.

    Entre `git add` et `git commit`, `git status` affiche « Tous les
    conflits sont réglés mais la fusion n'est pas terminée. »

    `git merge --abort` annule la fusion en cours et rend l'état d'avant.

    Vérifier qu'il ne reste aucun marqueur : `Ctrl` + `F` dans VS Code,
    chercher `<<<<`.

    Les marqueurs sont du texte ordinaire : un fichier Python qui les garde
    ne s'exécute plus.
  ]
]

// --------------------------------------------
// Nouveau (28/09/2026). Théorie seule : reprend en une diapositive
// l'organisation master / develop / branche de tâche du cours 2 de 2026
// (diapositive 72, « Bonnes pratiques », animée en quatre étapes), gardée
// à la demande de Nicolas. Pratique au cours 6 (pull request) et au
// projet 7, sans `develop`.
#d("L'organisation des branches à plusieurs")[
  #annonce[
    `master` ne reçoit que les versions terminées. `develop` réunit le
    travail en cours ; chaque tâche se fait sur sa propre branche, fusionnée
    dans `develop` quand elle est terminée.
  ]

  #align(center, graphe-git(
    commits: (
      (nom: "c1", col: 0, voie: 0),
      (nom: "c2", col: 1, voie: 1, parents: ("c1",)),
      (nom: "c3", col: 2, voie: 2, parents: ("c2",)),
      (nom: "c4", col: 3, voie: 2, parents: ("c3",)),
      (nom: "c5", col: 2, voie: -1, parents: ("c2",), place: "dessous"),
      (nom: "c6", col: 4, voie: 1, parents: ("c2", "c4")),
      (nom: "c7", col: 4, voie: -1, parents: ("c5",), place: "dessous"),
      (nom: "c8", col: 5, voie: 1, parents: ("c6", "c7")),
      (nom: "c9", col: 6, voie: 0, parents: ("c1", "c8")),
    ),
    branches: (
      (nom: "master", voie: 0, commit: "c9"),
      (nom: "develop", voie: 1, commit: "c8"),
      (nom: "conseil", voie: 2, commit: "c4"),
      (nom: "sans-gluten", voie: -1, commit: "c7"),
    ),
    echelle: 1.0,
    taille-etiquette: 10pt,
  ))

  #legende[
    Alice fait le conseil, Bruno la variante sans gluten, chacun dans sa
    copie du dépôt. `c6` et `c8` fusionnent les tâches dans `develop` ;
    `c9` porte la version terminée dans `master`.
  ]

  #notes[
    Théorie seule aujourd'hui. Le TD 2d fait une branche et une fusion, seul,
    sur un dépôt.

    Les quatre règles du cours de 2026 : `master` ne reçoit que des
    versions complètes, qui peuvent être distribuées ; `develop` contient
    toujours une version qui fonctionne, et on n'y travaille pas
    directement ; une branche par fonctionnalité ; quand `develop` change,
    on le fusionne dans les branches de fonctionnalité pour rester à jour.
    Ce modèle s'appelle git flow.

    Le module ne pratique que la branche de tâche fusionnée dans `master`,
    par une pull request (cours 6, projet 7) : à dire si la question vient.
    Le `tag` de la version terminée est au projet 7.
  ]
]
