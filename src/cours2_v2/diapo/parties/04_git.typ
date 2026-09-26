// Partie 4 du cours 2 v2 — git local. Incluse par `cours2_v2.typ`.
// Un fichier inclus n'hérite pas des imports de son appelant.
//
// Nouveau (v2) : réécriture des parties 2 à 6 du cours 2 de 2026 (support de
// Florent Geniet), sur le modèle titre, annonce, preuve visuelle. Les treize
// pages « à quoi sert git » sont ramenées à trois ; `revert`, `tag`, `rebase`
// et l'organisation main, develop, feature passent en annexe.
//
// Toutes les sorties sont celles du rejeu du TD 3a (git 2.43, en français) :
// `src/cours2_v2/notebook/td/3a_depot_recette/rejeu/sortie.txt`.
#import "../../../commun/prelude.typ": *
#import "../../../commun/schemas_git.typ": graphe-git, marque-tete, marque-conflit

// Une sortie de terminal, en chasse fixe sur fond gris. `taille` est celle
// du texte courant : le code en prend 0,78.
#let console(texte, taille: 17pt) = block(
  width: 100%, fill: gris, inset: (x: 10pt, y: 8pt),
)[
  #set text(size: taille)
  #set par(leading: 0.5em)
  #raw(texte, block: true)
]

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
      #console("$ ls\nrecette.md\n$ git log --oneline\n4d1a6ac Ignore les fichiers produits par pandoc\n393d861 Ajoute la recette au format .odt\nfe4fe8b Réduit les œufs à trois\na16d497 Ajoute la recette des crêpes", taille: 14pt)
    ],
  )

  #legende[
    Chaque ligne de droite est un commit : une version enregistrée, avec son
    identifiant et un message qui décrit ce qui a changé.
  ]

  #notes[
    Colonne de gauche : ce que la plupart ont déjà fait. Rien n'indique ce qui
    distingue deux copies, ni laquelle est la bonne.

    Colonne de droite : `git log --oneline` relevé à l'étape 4 du TD 3a.
  ]
]

// --------------------------------------------
#d("Une variante, puis la fusion")[
  #annonce[
    Une branche fait évoluer une variante sans toucher à la version
    principale. La fusion réunit ensuite les deux.
  ]

  #grid(
    columns: (1fr, 1.1fr), column-gutter: 20pt, align: horizon,
    align(center, graphe-git(
      commits: (
        (nom: "c4", col: 0, voie: 0),
        (nom: "c5", col: 1, voie: 0, parents: ("c4",)),
        (nom: "c6", col: 1, voie: 1, parents: ("c4",)),
        (nom: "c7", col: 2, voie: 0, parents: ("c5", "c6")),
      ),
      branches: (
        (nom: "master", voie: 0, commit: "c7"),
        (nom: "sans-gluten", voie: 1, commit: "c6"),
      ),
      echelle: 1.3,
      taille-etiquette: 11pt,
    )),
    console("*   978eeb6 Fusionne la variante sans gluten\n|\\\n| * 34808ea Remplace la farine de blé par du sarrasin\n* | 492c373 Ajoute un conseil de conservation\n|/\n* 4d1a6ac Ignore les fichiers produits par pandoc", taille: 13pt),
  )

  #legende[
    À gauche, le graphe dessiné ; à droite, le même, écrit par
    `git log --oneline --graph`.
  ]

  #notes[
    Le même mécanisme sert à plusieurs : chacun sa branche, puis la fusion.
    Le travail à plusieurs, sur une forge, est au cours 6.

    Les flèches vont d'un commit vers son parent, dans le sens où git les
    enregistre. Le commit de fusion a deux parents (double trait).
  ]
]

// --------------------------------------------
#d("Quand employer git")[
  #annonce[
    git sert dès qu'un projet est fait de fichiers texte qui évoluent : du
    code, sa documentation, ses réglages.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Situation], [Ce que git apporte],
    [seul sur un projet], [revenir à la version qui marchait ; voir ce qui a changé depuis],
    [à plusieurs], [chacun sa copie et ses branches ; la fusion des modifications (cours 6)],
    [un rendu], [l'historique montre comment le travail a avancé],
  )

  #v(0.4em)
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Ce que git versionne mal], [Pourquoi],
    [les fichiers binaires (`.odt`, images)], [git n'affiche pas ce qui a changé dedans],
    [les fichiers produits par une commande], [ils se refont depuis leur source],
    [les données volumineuses], [chaque version est gardée pour toujours],
  )

  #notes[
    Le deuxième tableau prépare le `.gitignore` et le `diff` du `.odt`, à
    l'étape 4 du TD.

    Le projet 4 emploie git seul ; le cours 6 et le projet 7, à plusieurs.
  ]
]

// --------------------------------------------
#d("Créer un dépôt : git init")[
  #annonce[
    `git init` fait du dossier courant un dépôt : il y crée un dossier
    caché, `.git`, qui contiendra l'historique.
  ]

  #console("$ git init\nDépôt Git vide initialisé dans …/3a_depot_recette/travail/.git/\n$ ls -a\n.\n..\ncrepes.jpg\n.git\nrecette.md", taille: 16pt)

  #legende[
    Les fichiers du dossier ne changent pas. Supprimer `.git` supprime
    l'historique, et laisse les fichiers.
  ]

  #notes[
    `git init` affiche d'abord une dizaine de lignes `astuce:` sur le nom de
    la branche initiale, `master`. Les laisser défiler ; le cours 6 renomme
    la branche en `main` pour GitHub.

    Avant le premier commit, dans le dépôt : `git config user.name` et
    `user.email`, sans `--global`, les postes étant partagés (étape 1 du TD).
  ]
]

// --------------------------------------------
#d("Trois zones : dossier, index, dépôt")[
  #annonce[
    Un commit enregistre ce que `git add` a placé dans l'index, et rien
    d'autre.
  ]

  #grid(
    columns: (1fr, auto, 1fr, auto, 1fr), column-gutter: 8pt, align: horizon,
    bloc("Dossier de travail", "les fichiers tels qu'on les modifie", hauteur: 70pt),
    align(center)[#text(size: 15pt, font: police-code)[git add] \ #text(size: 26pt, fill: accent)[→]],
    bloc("Index", "ce qui entrera dans le prochain commit", hauteur: 70pt),
    align(center)[#text(size: 15pt, font: police-code)[git commit] \ #text(size: 26pt, fill: accent)[→]],
    bloc("Dépôt", "l'historique des commits, dans .git", plein: true, hauteur: 70pt),
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

  #notes[
    L'index s'appelle aussi « zone de préparation » (_staging area_). Il
    permet de choisir ce qu'un commit contient : deux modifications sans
    rapport font deux commits.

    Le cycle de vie du cours 2 de 2026 (non suivi, suivi, modifié) se lit
    sur ce schéma.
  ]
]

// --------------------------------------------
#d("Enregistrer une version : add, puis commit")[
  #annonce[
    `git add` place un fichier dans l'index ; `git commit` enregistre l'index
    comme une nouvelle version, avec un message.
  ]

  #console("$ git add recette.md crepes.jpg\n$ git commit -m \"Ajoute la recette des crêpes\"\n[master (commit racine) a16d497] Ajoute la recette des crêpes\n 2 files changed, 24 insertions(+)\n create mode 100644 crepes.jpg\n create mode 100644 recette.md\n$ git log --oneline\na16d497 Ajoute la recette des crêpes", taille: 16pt)

  #legende[
    `a16d497` est le début de l'identifiant du commit, calculé à partir de
    son contenu : il diffère sur chaque poste.
  ]

  #notes[
    L'identifiant complet a 40 caractères (`git log` sans option). Les sept
    premiers suffisent à le désigner dans un dépôt.

    `-m` donne le message sur la ligne de commande. Sans `-m`, git ouvre un
    éditeur de texte (vim dans Git Bash) : `Échap`, puis `:q!` pour en
    sortir sans enregistrer.
  ]
]

// --------------------------------------------
#d("L'état du dépôt : git status")[
  #annonce[
    `git status` affiche la branche courante et la zone de chaque fichier
    modifié, avec les commandes qui s'appliquent.
  ]

  #console("$ git status\nSur la branche master\nModifications qui ne seront pas validées :\n  (utilisez \"git add <fichier>...\" pour mettre à jour ce qui sera validé)\n  (utilisez \"git restore <fichier>...\" pour annuler les modifications dans le répertoire de travail)\n\tmodifié :         recette.md\n\naucune modification n'a été ajoutée à la validation (utilisez \"git add\" ou \"git commit -a\")", taille: 13.5pt)

  #legende[
    La commande à taper avant toute autre, et avant de demander de l'aide.
  ]

  #notes[
    Relevé à l'étape 2 du TD, après avoir modifié le nombre d'œufs. Dans Git
    Bash, le nom du fichier est en rouge.

    Git Bash affiche aussi la branche dans l'invite, entre parenthèses :
    `~/…/travail (master)`.
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
#d("L'historique : git log")[
  #annonce[
    `git log` liste les commits, du plus récent au plus ancien : identifiant,
    auteur, date et message.
  ]

  #console("$ git log\ncommit fe4fe8b8194a1e259bf68a1d8144411b3968be67\nAuthor: Alice Martin <alice.martin@ensg.eu>\nDate:   Mon Sep 21 16:15:20 2026 +0200\n\n    Réduit les œufs à trois\n\ncommit a16d497f388f634cc7fdc355a2b6b3f06701f6d3\nAuthor: Alice Martin <alice.martin@ensg.eu>\nDate:   Mon Sep 21 16:14:20 2026 +0200\n\n    Ajoute la recette des crêpes", taille: 14pt)

  #legende[
    `git log --oneline` : une ligne par commit. `--graph` y ajoute le dessin
    des branches.
  ]

  #notes[
    L'auteur est celui de `git config user.name` et `user.email` : d'où la
    configuration de l'étape 1.

    Un historique long s'affiche page par page : `q` pour quitter, espace
    pour avancer.
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

    Revenir sur un commit (`git revert`) est en annexe.
  ]
]

// --------------------------------------------
#d("Un fichier binaire dans git")[
  #annonce[
    git compare un fichier texte ligne à ligne. D'un fichier binaire, il
    indique seulement qu'il a changé.
  ]

  #console("$ pandoc recette.md -o recette.odt\n$ git diff\ndiff --git a/recette.md b/recette.md\n@@ -10,7 +10,7 @@\n |---|---|\n | Farine | 250 g |\n | Œufs | 3 |\n-| Lait | 500 ml |\n+| Lait | 600 ml |\n | Sel | 1 pincée |\n | Beurre fondu | 50 g |\n \ndiff --git a/recette.odt b/recette.odt\nindex 094bec8..572146e 100644\nBinary files a/recette.odt and b/recette.odt differ", taille: 13.5pt)

  #legende[
    Même modification, deux fichiers : la ligne du lait dans `recette.md`,
    une seule phrase pour `recette.odt`, régénéré par pandoc.
  ]

  #notes[
    Sortie réelle de l'étape 4, réduite : les lignes `index` et `---`, `+++`
    de `recette.md` sont retirées. La dernière ligne reste en anglais avec
    git 2.43 en français.

    Le TD 1b du cours 1 (en annexe) ouvre un `.odt` : une archive ZIP.
  ]
]

// --------------------------------------------
#d("Ignorer des fichiers : .gitignore")[
  #annonce[
    Un fichier `.gitignore` liste des motifs de noms. `git status` n'affiche
    plus les fichiers qui y correspondent, et `git add` ne les ajoute pas.
  ]

  #face-a-face(
    panneau[`.gitignore`, à la racine du dépôt][
      #console("*.html\n*.odt")
    ],
    panneau("Les fichiers produits sont dans le dossier, absents de git status")[
      #console("$ ls\ncrepes.jpg\nrecette.html\nrecette.md\nrecette.odt\n$ git status\nSur la branche master\nrien à valider, la copie de travail est propre", taille: 14pt)
    ],
  )

  #legende[
    `.gitignore` se versionne avec le projet. Un fichier déjà suivi le
    reste : `git rm --cached recette.odt` le retire du dépôt et le laisse sur
    le disque.
  ]

  #notes[
    Trois sortes de fichiers à ignorer : ce qu'une commande produit
    (`*.html`, `__pycache__/`), les réglages d'un poste, les secrets (mots de
    passe, clés : cours 5).

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
        (nom: "c4", col: 0, voie: 0),
        (nom: "c5", col: 1, voie: 0, parents: ("c4",)),
        (nom: "c6", col: 1, voie: 1, parents: ("c4",)),
      ),
      branches: (
        (nom: "master", voie: 0, commit: "c5"),
        (nom: "sans-gluten", voie: 1, commit: "c6"),
      ),
      echelle: 1.4,
      taille-etiquette: 11pt,
      extra: (pos, d) => marque-tete(d, pos("c5"), dx: 1.0, dy: 0.9),
    )),
    console("$ git checkout -b sans-gluten\nBasculement sur la nouvelle branche 'sans-gluten'\n…\n$ git checkout master\n…\n$ git log --oneline --graph --all --decorate\n* 492c373 (HEAD -> master) Ajoute un conseil…\n| * 34808ea (sans-gluten) Remplace la farine…\n|/\n* 4d1a6ac Ignore les fichiers produits…", taille: 12.5pt),
  )

  #legende[
    `git checkout -b nom` crée une branche et s'y place ; `git checkout nom`
    change de branche ; `git branch` les liste.
  ]

  #notes[
    Sortie abrégée (`…`) : les commits et les messages entre les deux
    commandes sont dans le rejeu du TD, étape 5.

    `git switch` fait la même chose que `git checkout` pour les branches ;
    les cours 3 et 4 emploient `checkout`, on garde `checkout`.

    La branche initiale s'appelle `master` sur les postes (git 2.43), `main`
    sur GitHub.
  ]
]

// --------------------------------------------
#d("Changer de branche change les fichiers")[
  #annonce[
    `git checkout` remplace les fichiers du dossier par ceux du dernier
    commit de la branche choisie.
  ]

  #console("$ git checkout sans-gluten\nBasculement sur la branche 'sans-gluten'\n$ grep Farine recette.md\n| Farine de sarrasin | 250 g |\n$ git checkout master\nBasculement sur la branche 'master'\n$ grep Farine recette.md\n| Farine | 250 g |", taille: 16pt)

  #legende[
    `grep` affiche les lignes d'un fichier qui contiennent un mot. Le fichier
    ouvert dans VS Code change de la même façon.
  ]

  #notes[
    `git checkout` s'arrête avec un message si une modification non validée
    serait écrasée : faire un commit, ou `git restore`, avant.

    Les autres fichiers du dossier, non suivis ou ignorés (`recette.html`),
    ne bougent pas.
  ]
]

// --------------------------------------------
#d("Fusionner : git merge")[
  #annonce[
    `git merge` apporte dans la branche courante les commits d'une autre
    branche. Quand les deux ont avancé, git crée un commit de fusion.
  ]

  #console("$ git checkout master\n$ git merge sans-gluten -m \"Fusionne la variante sans gluten\"\nFusion automatique de recette.md\nMerge made by the 'ort' strategy.\n recette.md | 2 +-\n 1 file changed, 1 insertion(+), 1 deletion(-)\n$ grep -n -e Farine -e Conseil recette.md\n11:| Farine de sarrasin | 250 g |\n26:## Conseil", taille: 15pt)

  #legende[
    La fusion se lance depuis la branche qui reçoit. Le fichier fusionné a
    la farine de la variante et le conseil de `master`.
  ]

  #notes[
    Si seule l'autre branche a avancé, git déplace simplement `master` sur
    son dernier commit (_fast-forward_), sans commit de fusion.

    Sans `-m`, git ouvre un éditeur pour le message du commit de fusion
    (vim dans Git Bash) : `:wq` pour garder le message proposé.
  ]
]

// --------------------------------------------
#d("Un conflit de fusion")[
  #annonce[
    Quand les deux branches ont modifié la même ligne, git arrête la fusion
    et écrit les deux versions dans le fichier.
  ]

  #face-a-face(
    panneau("Ce que git affiche")[
      #console("$ git merge pour-18\nFusion automatique de recette.md\nCONFLIT (contenu) : Conflit de fusion dans recette.md\nLa fusion automatique a échoué ; réglez les conflits et validez le résultat.", taille: 12.5pt)
    ],
    panneau[Ce que contient `recette.md`][
      #console("# Crêpes\n\n<<<<<<< HEAD\n*Pour 12 crêpes — 10 minutes de préparation, 2 heures de repos.*\n=======\n*Pour 18 crêpes — 10 minutes de préparation, 1 heure de repos.*\n>>>>>>> pour-18", taille: 12.5pt)
    ],
  )

  #legende[
    Entre `<<<<<<< HEAD` et `=======`, la ligne de la branche courante ; entre
    `=======` et `>>>>>>>`, celle de la branche fusionnée.
  ]

  #notes[
    `master` a allongé le repos, `pour-18` a changé le nombre de crêpes : la
    même ligne. Étape 6 du TD.

    Les marqueurs sont du texte ordinaire : un fichier Python qui les garde
    ne s'exécute plus.
  ]
]

// --------------------------------------------
#d("Résoudre un conflit")[
  #annonce[
    Écrire la ligne voulue à la place des deux versions et des marqueurs,
    puis `git add` et `git commit` terminent la fusion.
  ]

  #console("*Pour 18 crêpes — 10 minutes de préparation, 2 heures de repos.*\n$ git add recette.md\n$ git status\nSur la branche master\nTous les conflits sont réglés mais la fusion n'est pas terminée.\n  (utilisez \"git commit\" pour terminer la fusion)\n$ git commit -m \"Fusionne la version pour 18 crêpes\"\n[master 0b0495c] Fusionne la version pour 18 crêpes", taille: 14pt)

  #legende[
    VS Code affiche au-dessus du conflit « Accept Current Change », « Accept
    Incoming Change », « Accept Both Changes ». Ici, aucune ne convient : la
    bonne ligne prend un morceau de chacune.
  ]

  #notes[
    `git merge --abort` annule la fusion en cours et rend l'état d'avant.

    Vérifier qu'il ne reste aucun marqueur : `grep -n "<<<<" recette.md` ne
    doit rien afficher.

    Sortie réduite : la première ligne est la ligne résolue de
    `recette.md`, écrite dans VS Code.
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
