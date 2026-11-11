// Partie 4 du cours 2 v2 : git local. Incluse par `cours2_v2.typ` ; un fichier inclus
// n'hérite pas des imports de son appelant.
//
// Réécriture des parties 2 à 6 du cours 2 de 2026 (support de Florent Geniet). `tag` et
// l'organisation main, develop, feature sont en annexe.
//
// Les graphes racontent l'histoire de « Git : fonctionnalités » (c1 à c8), rejouée par
// `diapo/rejeu/rejeu.sh` avec ses vrais identifiants et ses sorties (git 2.34, en
// français). Ses deux premiers commits sont ceux du TD 2c. Le conflit, et les deux
// diapositives qui le résolvent, viennent du rejeu du TD 2c. La pastille porte le début
// de l'identifiant, sauf dans « Git : fonctionnalités » et « L'organisation des branches
// à plusieurs », qui numérotent les commits.
#import "../../../commun/prelude.typ": *
#import "../../../commun/schemas_git.typ": graphe-git, marque-tete, marque-tete-branche, marque-conflit, rouge-attention
#import "../schemas.typ": schema-usages-git, schema-fonctionnalites-git, schema-git-init, schema-zones-git
#import "../../../cours5/diapo/schemas.typ": repere

// Une sortie de terminal, en chasse fixe sur fond gris. `taille` est celle
// du texte courant : le code en prend 0,78.
#let console(texte, taille: 17pt) = block(
  width: 100%, fill: gris, inset: (x: 10pt, y: 8pt),
)[
  #set text(size: taille)
  #set par(leading: 0.5em)
  #raw(texte, block: true)
]

// Une sortie de `git diff`, colorée comme dans Git Bash : lignes retirées en rouge,
// lignes ajoutées en vert, début de passage (`@@`) en bleu.
#let console-diff(texte, taille: 17pt) = {
  show raw.line: ligne => {
    let t = ligne.text
    let couleur = if t.starts-with("---") or t.starts-with("+++") { encre }
      else if t.starts-with("-") { rgb("#B3261E") }
      else if t.starts-with("+") { rgb("#2E7D32") }
      else if t.starts-with("@@") { attention }
      else { encre }
    text(fill: couleur, ligne)
  }
  console(texte, taille: taille)
}

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

#separateur(
  "Git local",
  annonce: "Enregistrer les versions successives d'un projet, les comparer, travailler sur une variante et la fusionner.",
)

// --------------------------------------------
// D'après « Git : c'est quoi ? » du cours 2 de 2026 (Florent Geniet).
#d("Git : vue d'ensemble")[
  #align(center, schema-usages-git(echelle: 1.15))

  #legende[
    Les parties en couleur sont traitées dans cette séance : le versionnement du code, en
    ligne de commande et dans un IDE. Le travail à plusieurs et l'hébergement du code en
    ligne sont pratiqués au cours 6.
  ]

  #notes[
    La séance traite le versionnement, avec les commandes git tapées dans le terminal de
    VS Code (TD 2c). Le travail à plusieurs est vu en théorie en fin de partie.

    git est le logiciel installé sur le poste ; GitHub et GitLab hébergent des dépôts git
    en ligne. Le module n'emploie pas de logiciel dédié comme GitKraken ou TortoiseGit.
  ]
]

// --------------------------------------------
// D'après « Fonctionnalités » du cours 2 de 2026 (Florent Geniet), une page par étape.
// La liste à puces est gardée à la demande de Nicolas (exception à la règle 3 de
// STYLE.md) ; ses lignes à venir sont posées mais masquées, pour que les puces ne bougent
// pas d'une page à l'autre.
#let _fonctionnalites = (
  (
    ligne: [Enregistrement des versions successives du projet],
    notes: [
      Rien n'indique ce qui distingue deux copies, ni laquelle est la bonne. Avec git, le
      dossier contient un seul fichier, et chaque commit décrit sa modification (texte sous
      la pastille). c4 et c6, absents ici, sont sur la branche de l'étape suivante.
    ],
  ),
  (
    ligne: [Modifications en parallèle, sur des branches],
    notes: [
      Alice part de c2 et ajoute le dénivelé cumulé, puis un seuil, pendant que Bruno
      ajoute la lecture des fichiers. Les commits d'une branche ne changent pas les
      fichiers de l'autre.
    ],
  ),
  (
    ligne: [Une branche par fonctionnalité, créée par le même développeur ou par un autre],
    notes: [
      Alice et Bruno sont les deux personnes du fichier partagé du cours 1. Au TD 2c,
      chacun crée seul une branche.
    ],
  ),
  (
    ligne: [Fusion de deux branches],
    notes: [
      c7 a deux parents, d'où le double trait. c8 renomme le script en `stats_trace.py`,
      comme au TD 4a.
    ],
  ),
  (
    ligne: [Étiquette sur certaines versions],
    notes: [
      Une étiquette nomme une version diffusée : v1, v2, v3. La commande `git tag` est
      employée au projet 7.
    ],
  ),
  (
    ligne: [Accès des utilisateurs aux versions étiquetées],
    notes: [Un utilisateur lance le programme dans une version étiquetée, sans le modifier.],
  ),
  (
    ligne: [Partage du dépôt sur une forge],
    notes: [
      Au cours 6, une copie du dépôt sur une forge contient tous les commits, les branches
      et les étiquettes. Chacun y envoie ses commits (`git push`) et récupère ceux des
      autres (`git pull`) ; Alice commence par `git clone`. Les utilisateurs téléchargent
      une version étiquetée depuis la forge.
    ],
  ),
)

// Les lignes déjà dites en gris, la ligne de l'étape en noir, les suivantes masquées.
#let _liste-fonctionnalites(etape) = {
  set text(size: 16pt)
  for (i, f) in _fonctionnalites.enumerate() {
    let dite = i < etape - 1
    let puce = text(size: 0.7em, fill: if dite { estompe } else { accent })[■]
    let ligne = block(above: 0.65em, below: 0.65em, par(hanging-indent: 1.1em, leading: 0.45em,
      text(fill: if dite { estompe } else { encre })[#box(width: 1.1em, puce)#f.ligne]))
    if i < etape { ligne } else { hide(ligne) }
  }
}

#for etape in range(1, _fonctionnalites.len() + 1) {
  d("Git : fonctionnalités")[
    #grid(
      columns: (0.5fr, 1fr), column-gutter: 14pt, align: horizon,
      _liste-fonctionnalites(etape),
      align(center, schema-fonctionnalites-git(etape: etape, echelle: 0.93)),
    )

    #notes(_fonctionnalites.at(etape - 1).notes)
  ]
}

// --------------------------------------------
// D'après « Git : quand l'utiliser ? » du cours 2 de 2026 (Florent Geniet), en une page.
// Les listes sont gardées à la demande de Nicolas.

// Un petit graphe de commits : une branche, ou deux branches et une fusion.
#let _graphe-usage(plusieurs) = {
  let commits = (
    (nom: "a", col: 0, voie: 0, id: ""),
    (nom: "b", col: 1, voie: 0, id: "", parents: ("a",)),
    (nom: "c", col: 2, voie: 0, id: "", parents: ("b",)),
    (nom: "d", col: 3, voie: 0, id: "", parents: if plusieurs { ("c", "y") } else { ("c",) }),
  )
  if plusieurs {
    commits += (
      (nom: "x", col: 1.6, voie: 1, id: "", parents: ("b",)),
      (nom: "y", col: 2.4, voie: 1, id: "", parents: ("x",)),
    )
  }
  block(width: 100%, height: 2.1cm, align(center + bottom,
    graphe-git(commits: commits, echelle: 0.95, ecart-x: 1.6)))
}

#d("Git : cas d'usage")[
  #set text(size: 18pt)
  #set list(spacing: 0.8em)
  #face-a-face(
    panneau("En projet seul")[
      #_graphe-usage(false)
      #v(0.4em)
      #list(
        [Sauvegarde de chaque version du code],
        [Mise à disposition des versions terminées, si besoin],
        [Historique simple, souvent sur une seule branche],
      )
    ],
    panneau("En projet à plusieurs")[
      #_graphe-usage(true)
      #v(0.4em)
      #list(
        [Mise en commun du travail de chacun],
        [Travail en parallèle sur des branches, sans gêner les autres],
        [Règles communes pour les branches et les messages de commit],
      )
    ],
  )

  #v(0.4em)
  #legende[
    Au TD 4a, chacun versionne son projet seul. Au cours 6 et au projet du cours 7, le dépôt
    est partagé à plusieurs.
  ]

  #notes[
    Seul, on emploie git pour garder chaque version du code et revenir à l'une d'elles.
    À plusieurs, chacun travaille sur sa branche et la fusionne quand sa tâche est
    terminée ; les diapositives « Enregistrer une modification : add, puis commit » et
    « L'organisation des branches à plusieurs » donnent les règles communes.
  ]
]

// --------------------------------------------
// Prolonge « Structure d'une commande » du cours 1 v2.
#d("La commande git")[
  #annonce[
    git est un programme en ligne de commande. Le mot qui suit `git` est une
    sous-commande, qui a ses propres options et ses propres arguments.
  ]

  #tableau(
    columns: (auto, auto, auto, 1fr),
    align: left + horizon,
    [Commande tapée], [Sous-commande], [Options], [Arguments],
    [`git init`], [`init`], [], [],
    [`git add altitudes.py`], [`add`], [], [`altitudes.py`],
    [`git commit -m "Ajoute le dénivelé cumulé"`], [`commit`], [`-m "Ajoute le dénivelé cumulé"`], [],
    [`git log --oneline`], [`log`], [`--oneline`], [],
  )

  #legende[
    Forme : `git <sous-commande> [options] <arguments>`, celle des commandes
    du cours 1 avec un mot de plus. `-m` prend une valeur : le message.
  ]

  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [`git --help`], [liste les sous-commandes courantes],
    [`git add -h`], [affiche les options de `git add`],
    [`git add --help`], [ouvre la page du manuel de `git add`, dans le navigateur sous Windows],
  )

  #notes[
    `git` est un seul fichier exécutable, cherché dans `PATH` comme les
    autres commandes (cours 1) ; `conda` a la même forme (cours 3). Erreur
    fréquente : oublier la sous-commande, ou taper une commande du terminal
    après `git` (`git cd`).

    Les crochets et les chevrons de la forme suivent la notation du cours 1 :
    facultatif, à remplacer. Sous Linux et macOS, `git add --help` ouvre la page
    dans le terminal, et `q` la ferme.
  ]
]

// --------------------------------------------
#d("Créer un dépôt : git init")[
  #annonce[
    `git init` fait du dossier courant un dépôt : il y crée un dossier
    caché, `.git`, qui contiendra l'historique.
  ]

  #grid(
    columns: (1.6fr, 1fr), column-gutter: 18pt, align: horizon,
    console("$ cd ~/Desktop/info01/cours2/2c_depot_altitudes/travail\n$ pwd\n/c/Users/eleve/Desktop/info01/cours2/2c_depot_altitudes/travail\n$ git init\nDépôt Git vide initialisé dans …/2c_depot_altitudes/travail/.git/\n$ ls -a\n.\n..\naltitudes.py\n.git", taille: 16pt),
    schema-git-init(),
  )

  #legende[
    Les fichiers du dossier ne changent pas. Supprimer `.git` supprime
    l'historique, et laisse les fichiers.
  ]

  #notes[
    `cd` et `pwd` d'abord : le dépôt se crée dans le
    dossier courant, quel qu'il soit. Un `git init` tapé dans `~` fait du
    dossier personnel entier un dépôt ; le supprimer par `rm -rf ~/.git`.
    L'invite de Git Bash affiche aussi le dossier courant.

    `git init` affiche d'abord une dizaine de lignes `astuce:` sur le nom de
    la branche initiale, `master`. Les laisser défiler. GitHub nomme sa
    branche initiale `main`.
  ]
]

// --------------------------------------------
// Sources : Pro Git, « Paramétrage à la première utilisation de Git » ; manuels de
// `git-commit` (COMMIT INFORMATION) et de `git-config` (FILES) ; GitHub Docs, « Setting
// your commit email address ». Sorties relevées avec git 2.34, en français.
#d("L'auteur des commits : git config")[
  #annonce[
    Chaque commit enregistre le nom et l'adresse de son auteur. Sans eux, `git commit`
    s'arrête sur « Identité d'auteur inconnue ».
  ]

  #grid(
    columns: (1.1fr, 1fr), column-gutter: 18pt, align: horizon,
    console("$ git config user.name \"Alice Martin\"\n$ git config user.email alice.martin@ensg.eu\n$ git commit -m \"Ajoute le calcul de la moyenne\"\n…\n$ git log\ncommit 64ed21360dbd4701ade422da243da0fb242d008a\nAuthor: Alice Martin <alice.martin@ensg.eu>\nDate:   Mon Sep 21 16:14:20 2026 +0200\n\n    Ajoute le calcul de la moyenne", taille: 13pt),
    {
      show table.cell: set text(size: 14pt)
      tableau(
        columns: (auto, 1fr, 1.2fr),
        align: left + horizon,
        [], [`git config`], [`git config --global`],
        [S'applique à], [ce dépôt], [tous les dépôts du compte],
        [Fichier], [`.git/config`], [`~/.gitconfig`],
        [En salle], [à employer], [à éviter, car le compte est partagé],
      )
    },
  )

  #legende[
    Le nom et l'adresse indiquent qui a fait chaque modification, et à qui poser une
    question. git les accepte sans vérification. Le réglage du dépôt l'emporte sur celui
    du compte. Au cours 6, la forge demande une authentification pour recevoir des commits.
  ]

  #notes[
    Le message d'erreur propose `git config --global`, puis ajoute « Éliminez --global
    pour ne faire les réglages que dans ce dépôt » : en salle, suivre cette seconde
    phrase. Faire écrire son propre nom : l'identité de l'exemple est recopiée telle
    quelle (erreur relevée par Software Carpentry). L'adresse peut être inventée pour le
    module.

    Le nom et l'adresse restent dans le commit : Pro Git écrit que cette identité est
    « indélébile dans toutes les validations que vous pourrez réaliser ». Un nouveau
    réglage ne vaut que pour les commits suivants.

    Le manuel de `git-commit` précise que ce nom ne sert pas à l'authentification :
    « This name has no effect on authentication ». Prouver l'auteur d'un commit demande
    une signature (GPG ou SSH), hors du module. GitHub relie les commits à un compte par
    leur adresse ; avec l'adresse `noreply` qu'il fournit, l'adresse personnelle reste
    privée.
  ]
]

// --------------------------------------------
// Le premier commit, d'après « Commit » du cours 2 de 2026 (Florent Geniet).
#d("Enregistrer une modification : add, puis commit")[
  #annonce[
    `git add` ajoute un fichier à la prochaine version ; `git commit` enregistre
    cette version, avec un message.
  ]

  #grid(
    columns: (1.5fr, 1fr), column-gutter: 20pt, align: horizon,
    console("$ git status\n$ git add altitudes.py\n$ git status\n$ git commit -m \"Ajoute le calcul de la moyenne\"\n[master (commit racine) 64ed213] Ajoute le calcul de la moyenne\n$ git status\n…\n$ git log --oneline\n726d93f Remplace la moyenne par les altitudes extrêmes\n64ed213 Ajoute le calcul de la moyenne", taille: 13pt),
    align(center, graphe-git(
      commits: (
        (nom: "c1", col: 0, voie: 0, id: "64e", etiquette: "commit racine"),
        (nom: "c2", col: 1, voie: 0, id: "726", parents: ("c1",)),
      ),
      branches: ((nom: "master", voie: 0, commit: "c2"),),
      echelle: 1.4,
      taille-etiquette: 10pt,
      // Au-dessus de chaque commit, ce qu'il change, comme dans « Git : fonctionnalités ».
      extra: (pos, d) => for (nom, texte) in (("c1", "moyenne"), ("c2", "min et max")) {
        let (x, y) = pos(nom)
        d.content((x, y + 0.56), text(size: 11pt, fill: accent, texte), anchor: "south")
      },
    )),
  )

  // Ce qu'affichent les trois `git status` du terminal, réduit aux lignes de l'état.
  #let etat(titre, sortie) = stack(spacing: 6pt,
    text(size: 15pt, weight: demi-gras, fill: estompe, titre), console(sortie, taille: 14pt))
  #v(0.3em)
  #grid(
    columns: (1fr, 1fr, 1fr), column-gutter: 14pt,
    etat([Avant `git add`], "Fichiers non suivis:\n  altitudes.py"),
    etat([Après `git add`], "Modifications qui seront validées :\n  nouveau fichier : altitudes.py"),
    etat([Après `git commit`], "rien à valider, la copie de\ntravail est propre"),
  )

  #legende[
    `64ed213` est le début de l'identifiant du commit, calculé à partir de
    son contenu ; `master` désigne le dernier commit, et avance à chaque commit.
  ]

  #notes[
    L'identifiant complet a 40 caractères ; les sept premiers suffisent à le désigner
    dans un dépôt, et il diffère sur chaque poste. Sans `-m`, git ouvre vim dans Git
    Bash : `Échap`, puis `:q!` pour en sortir sans enregistrer. `…` : le second commit,
    fait à l'étape 2 du TD. Les sorties de `git status` viennent du rejeu du TD, sans la
    branche ni les conseils de git : les deux premières de l'étape 1, la troisième de
    l'étape 4.

    Un commit porte une seule modification, et son code s'exécute. Six mois plus tard,
    `modif` ou `corrections` n'indiquent pas ce qui a changé.
  ]
]

// --------------------------------------------
#d("Trois zones : dossier, index, dépôt")[
  #annonce[
    Un commit enregistre ce que `git add` a placé dans l'index, et rien
    d'autre.
  ]

  #align(center, schema-zones-git(echelle: 0.95))

  #legende[
    Faire des commits souvent : git ne peut revenir qu'à une version enregistrée par un
    commit. `git status` affiche aussi la branche courante et les commandes qui
    s'appliquent. La taper avant toute autre, et avant de demander de l'aide.
  ]

  #notes[
    L'index s'appelle aussi « zone de préparation » (_staging area_). Il
    permet de choisir ce qu'un commit contient : deux modifications sans
    rapport font deux commits. Index, _staged_ et zone de préparation
    désignent la même chose : le dire une fois.

    Git Bash affiche aussi la branche dans l'invite, entre parenthèses :
    `~/…/travail (master)`.
  ]
]

// --------------------------------------------
// Les graphes de l'histoire, dans le style de « Git : fonctionnalités » : ce que change
// chaque commit à côté de sa pastille, `master` en bas, la branche au-dessus. Le
// pointillé à gauche du premier commit figure les précédents. `ecart` : distance entre
// deux commits sur la diapositive, en centimètres.
#let _graphe-histoire(commits, branches: (), tete: none, echelle: 1.0, ecart: 2.2, extra: none) = graphe-git(
  commits: commits,
  // Le texte des étiquettes ne suit pas l'échelle : l'écart entre commits et la place
  // du cartouche, au-delà de l'étiquette, la compensent.
  branches: branches.map(b => (..b, ecart: 0.3 + 0.75 / echelle)),
  echelle: echelle,
  ecart-x: ecart / echelle,
  taille-etiquette: 11pt,
  extra: (pos, d) => {
    let (x, y) = pos(commits.first().nom)
    d.line((x - 0.56, y), (x - 1.4, y), stroke: (paint: estompe, thickness: 1.3pt, dash: "dotted"))
    if tete != none { marque-tete-branche(d, tete) }
    if extra != none { extra(pos, d) }
  },
)

// Les commits de l'histoire, après c1.
#let _c2 = (nom: "c2", col: 0, voie: 0, id: "726", etiquette: "min et max")
#let _c3 = (nom: "c3", col: 1, voie: 0, id: "3b8", etiquette: "fichier texte", parents: ("c2",))
#let _c4 = (nom: "c4", col: 1, voie: 1, id: "529", etiquette: "dénivelé cumulé", parents: ("c2",))
#let _c5 = (nom: "c5", col: 2, voie: 0, id: "27f", etiquette: "trace GPS", parents: ("c3",))
#let _c6 = (nom: "c6", col: 2, voie: 1, id: "3b5", etiquette: "seuil", parents: ("c4",))

// --------------------------------------------
// Objets relevés par `git ls-tree` sur le rejeu.
#let _graphe-contenus = graphe-git(
  commits: (
    (nom: "c1", col: 0, voie: 0, id: "64e"),
    (nom: "c2", col: 1, voie: 0, id: "726", parents: ("c1",)),
  ),
  ecart-x: 3.4,
  taille-etiquette: 10pt,
  extra: (pos, d) => {
    let fleche = (paint: estompe, thickness: 0.9pt)
    for (c, message, nom, fichier, id) in (
      ("c1", "moyenne", "f1", "altitudes.py", "81bd4a3"),
      ("c2", "min et max", "f2", "altitudes.py", "6e3cc79"),
    ) {
      let (x, y) = pos(c)
      d.content((x, y + 0.56), text(size: 11pt, fill: accent, message), anchor: "south")
      d.content((x, y - 1.75), name: nom, box(stroke: 1pt + estompe, fill: white, inset: 5pt, radius: 3pt,
        align(center, stack(spacing: 4pt,
          text(size: 10pt, font: police-code, fichier),
          text(size: 9pt, font: police-code, fill: estompe, id)))))
      d.line((x, y - 0.48), nom + ".north", stroke: fleche, mark: (end: "straight", fill: estompe, scale: 0.7))
    }
    // `git diff` compare deux contenus.
    let bas = -2.75
    d.line("f1.south", ("f1.south", "|-", (0, bas)), ("f2.south", "|-", (0, bas)), "f2.south",
      stroke: 1.2pt + attention, mark: (start: "straight", end: "straight", fill: attention, scale: 0.7))
    d.content(((pos("c1").at(0) + pos("c2").at(0)) / 2, bas - 0.1), anchor: "north",
      text(size: 11pt, font: police-code, fill: attention)[git diff])
  },
)

#d("Ce qui a changé : git diff")[
  #annonce[
    `git diff` montre les lignes modifiées depuis le dernier commit : en `-`
    l'ancienne version, en `+` la nouvelle, avec trois lignes de contexte.
  ]

  #grid(
    columns: (1.5fr, 1fr), column-gutter: 18pt, align: horizon,
    console-diff("$ git diff\ndiff --git a/altitudes.py b/altitudes.py\nindex 81bd4a3..6e3cc79 100644\n--- a/altitudes.py\n+++ b/altitudes.py\n@@ -1,8 +1,6 @@\n-\"\"\"Moyenne d'une série d'altitudes, à la main plutôt qu'avec sum().\"\"\"\n+\"\"\"Altitudes extrêmes d'une série de mesures.\"\"\"\n \n altitudes = [79.6, 103.2, 98.3]\n-total = 0\n-for altitude in altitudes:\n-    total = total + altitude\n-moyenne = total / len(altitudes)\n-print(f\"moyenne : {moyenne:.1f} m\")\n+print(f\"altitude minimale : {min(altitudes):.1f} m\")\n+print(f\"altitude maximale : {max(altitudes):.1f} m\")\n+print(f\"max - min : {max(altitudes) - min(altitudes):.1f} m\")", taille: 13pt),
    stack(spacing: 8pt,
      text(size: 15pt, weight: demi-gras, fill: estompe)[Contenu des commits],
      align(center, _graphe-contenus),
      text(size: 13pt)[
        À chaque commit, git enregistre le contenu complet des fichiers ajoutés ou
        modifiés, et réutilise celui des fichiers inchangés. `git diff` calcule l'écart
        entre deux contenus quand on le tape.
      ],
    ),
  )

  #legende[
    Sur la ligne `index`, git affiche les identifiants des deux contenus comparés.
    `@@ -1,8 +1,6 @@` : le passage commence à la ligne 1, et fait 8 lignes
    avant et 6 lignes après. VS Code montre le même écart côte à côte.
  ]

  #notes[
    Dans Git Bash, les lignes `-` sont en rouge, les `+` en vert. Une ligne
    modifiée est une ligne retirée puis une ligne ajoutée.

    Beaucoup d'étudiants pensent que git enregistre des différences. Chaque commit
    désigne l'état complet du projet, et `git diff`, `git log -p` calculent les écarts à
    l'affichage. `git gc` compresse ensuite certains contenus en différences pour
    gagner de la place, et git les reconstitue en entier à la lecture. `81bd4a3` fait
    242 octets, `6e3cc79` 252 octets. Dans la suite de l'histoire, git réutilise pour
    `27f` (trace GPS) le `altitudes.txt` enregistré par `3b8` (fichier texte).

    Dans VS Code : panneau du contrôle de code source (`Ctrl` + `Maj` +
    `G`), clic sur le fichier.
  ]
]

// --------------------------------------------
// Le schéma de droite, d'après « Annuler un commit » du cours 2 de 2026 (Florent Geniet) :
// la variante du rejeu qui défait `3b8`.
#let _graphe-revert = _graphe-histoire(
  (_c2, (.._c3, teinte: rgb("#F5C6C6")),
    (nom: "r", col: 2, voie: 0, id: "503", etiquette: "git revert 3b8", parents: ("c3",))),
  echelle: 1.25,
  ecart: 2.9,
  // Un pont au-dessus de `726` et `503` : les deux commits ont le même contenu.
  extra: (pos, d) => {
    let (a, b) = (pos("c2"), pos("r"))
    let sommet = ((a.at(0) + b.at(0)) / 2, a.at(1) + 1.2)
    d.line((a.at(0), a.at(1) + 0.46), sommet, (b.at(0), b.at(1) + 0.46), stroke: 0.9pt + estompe)
    d.content((sommet.at(0), sommet.at(1) + 0.08), text(size: 12pt, fill: accent)[même contenu],
      anchor: "south")
  },
)

#d("Annuler une modification : git restore, git revert")[
  #annonce[
    Avant un commit, `git restore` remet le fichier dans l'état du dernier commit, et la
    modification est perdue. Après un commit, `git revert` le défait par un nouveau commit.
  ]

  #face-a-face(
    panneau("Modification non validée", stack(spacing: 8pt,
      console-diff("$ git diff\n@@ -2,5 +2,5 @@\n-print(f\"altitude maximale : {max(altitudes):.1f} m\")\n+print(f\"altitude maximale : {max(altitude):.1f} m\")", taille: 12.5pt),
      console("$ git restore altitudes.py\n$ git status\nSur la branche master\nrien à valider, la copie de travail est propre", taille: 12.5pt),
    )),
    panneau("Commit déjà fait")[
      #v(0.6em)
      #align(center, _graphe-revert)
    ],
  )

  #legende[
    À gauche, une ligne abîmée par erreur est remise en état. À droite, `3b8` reste dans
    l'historique, et `503` remet le contenu de `726`.
  ]

  #notes[
    git ne peut restaurer que ce qu'il a enregistré : une raison de faire
    des commits souvent. La sortie de `git diff` est réduite à la ligne `@@` et aux
    lignes modifiées.

    `git revert` ouvre l'éditeur pour le message du nouveau commit (vim dans Git Bash :
    `:wq` garde le message proposé). `git reset`, qui retire des commits de la branche,
    n'est pas vu.

    `git rev-parse` affiche le même arbre pour `503` et `726` (rejeu, variante revert).
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

  #show table.cell: set text(size: 15pt)
  #tableau(
    columns: (auto, 1fr, auto),
    align: left + horizon,
    [Ce qu'on ne versionne pas], [Pourquoi], [Motif],
    [les notes personnelles], [elles ne font pas partie du programme], [`notes.txt`],
    [les fichiers produits par un programme], [ils se refont depuis leur source], [`__pycache__/`],
    [les données de travail], [chaque version resterait dans l'historique], [`donnees/`],
    [les mots de passe et les clés], [toute copie du dépôt les contiendrait], [`.env`],
  )

  #v(0.3em)
  #grid(
    columns: (0.6fr, 0.8fr, 1.6fr), column-gutter: 14pt,
    panneau[`.gitignore`][#console("notes.txt", taille: 13pt)],
    panneau[`ls`][#console("altitudes.py\nnotes.txt\nREADME.md", taille: 13pt)],
    panneau[`git status`][#console("Sur la branche master\nrien à valider, la copie de\ntravail est propre", taille: 13pt)],
  )

  #legende[
    `.gitignore` se versionne avec le projet.
  ]

  #notes[
    `notes.txt` : la liste des tâches écrite à l'étape 4 du TD. `__pycache__/` : Python
    y range la version compilée d'un module importé.

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

#let _master-et-cumul = ((nom: "master", voie: 0, commit: "c3"), (nom: "cumul", voie: 1, commit: "c4"))

#d("Les branches")[
  #annonce[
    Une branche est un nom posé sur un commit. Elle avance d'un commit à
    chaque commit fait sur elle ; `HEAD` désigne la branche courante.
  ]

  #grid(
    columns: (1fr, 1.2fr), column-gutter: 20pt, align: horizon,
    align(center, _graphe-histoire((_c2, _c3, _c4), branches: _master-et-cumul, tete: "master", echelle: 1.25)),
    console("$ git checkout -b cumul\nBasculement sur la nouvelle branche 'cumul'\n…\n$ git checkout master\n…\n$ git log --oneline --graph --all --decorate\n* 3b88896 (HEAD -> master) Lit les altitudes dans un fichier texte\n| * 5298338 (cumul) Ajoute le dénivelé cumulé\n|/\n* 726d93f Remplace la moyenne par les altitudes extrêmes\n* 64ed213 Ajoute le calcul de la moyenne", taille: 12pt),
  )

  #legende[
    `git checkout -b nom` crée une branche et s'y place ; `git checkout nom`
    change de branche ; `git branch` les liste.
  ]

  #notes[
    Les `…` remplacent le commit fait sur chaque branche ; la sortie complète est dans
    `diapo/rejeu/sortie.txt`.

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
#let _variante(tete) = _graphe-histoire((_c2, _c3, _c4), branches: _master-et-cumul, tete: tete, echelle: 0.85)

#d("Changer de branche change les fichiers")[
  #annonce[
    `git checkout` remplace les fichiers du dossier par ceux du dernier
    commit de la branche choisie.
  ]

  #face-a-face(
    panneau("Sur master")[
      #align(center, _variante("master"))
      #v(0.3em)
      #console("$ python altitudes.py\n…\nmax - min : 23.6 m", taille: 13pt)
    ],
    panneau[Après `git checkout cumul`][
      #align(center, _variante("cumul"))
      #v(0.3em)
      #console("$ python altitudes.py\n…\nmax - min : 23.6 m\ncumul en hausse : 23.6 m\ncumul en baisse : 4.9 m", taille: 13pt)
    ],
  )

  #legende[
    Sous chaque graphe, la fin de ce qu'affiche le programme. Le cumul n'existe
    que sur la branche `cumul`.
  ]

  #notes[
    `git checkout` s'arrête avec un message si une modification non validée
    serait écrasée : faire un commit, ou `git restore`, avant.

    Les fichiers non suivis ou ignorés ne bougent pas. `git checkout cumul` retire du
    dossier `altitudes.txt`, suivi sur `master` seulement, et `git checkout master` le
    remet.
  ]
]

// --------------------------------------------
// Le rebase d'après « Fusionner deux branches » du cours 2 de 2026.
#d("Fusionner deux branches : git merge, git rebase")[
  #annonce[
    `git merge` apporte dans la branche courante les commits d'une autre branche.
    `git rebase` refait les commits de la branche courante à la suite du dernier commit
    d'une autre branche.
  ]

  #face-a-face(
    panneau[Avec `git merge`][
      #align(center, _graphe-histoire(
        (_c2, _c3, _c4, _c5, _c6, (nom: "c7", col: 3, voie: 0, id: "153", etiquette: "fusion", parents: ("c5", "c6"))),
        branches: ((nom: "master", voie: 0, commit: "c7"), (nom: "cumul", voie: 1, commit: "c6")),
        echelle: 0.8,
        ecart: 2.3,
      ))
      #console("$ git merge cumul -m \"Fusionne le dénivelé cumulé\"\nFusion automatique de altitudes.py\nMerge made by the 'ort' strategy.", taille: 12pt)
      #text(size: 13pt, fill: estompe)[`153`, le commit de fusion, a deux parents (double trait).]
    ],
    panneau[Avec `git rebase`][
      #align(center, _graphe-histoire(
        (_c2, _c3, _c5,
          (nom: "c4r", col: 3, voie: 1, id: "0a4", etiquette: "dénivelé cumulé", parents: ("c5",)),
          (nom: "c6r", col: 4, voie: 1, id: "03f", etiquette: "seuil", parents: ("c4r",))),
        branches: ((nom: "master", voie: 0, commit: "c5"), (nom: "cumul", voie: 1, commit: "c6r")),
        echelle: 0.8,
        ecart: 2.3,
      ))
      #console("$ git checkout cumul\n$ git rebase master\nRebasage et mise à jour de refs/heads/cumul avec succès.", taille: 12pt)
      #text(size: 13pt, fill: estompe)[git refait `529` et `3b5` en `0a4` et `03f`, à la suite de `27f`.]
    ],
  )

  #notes[
    La fusion se lance depuis la branche qui reçoit, ici `master` ; le rebase, depuis la
    branche à refaire, ici `cumul`. Le TD fait la fusion, à l'étape 5.

    Après le rebase, `git merge cumul` depuis `master` avance `master` jusqu'à `03f`
    sans commit de fusion : « Mise à jour 27f004c..03fde43 », puis « Fast-forward »
    (avance rapide). À l'étape 7 du TD, `git pull` fait aussi une avance rapide.

    Le rebase change l'identifiant des commits refaits. Ne pas l'employer sur des
    commits déjà envoyés sur une forge (cours 6).

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

  #grid(
    columns: (0.75fr, 1.6fr), column-gutter: 18pt, align: horizon,
    align(center, _graphe-histoire(
      (
        (nom: "c7", col: 0, voie: 0, id: "5e6", etiquette: "fusion"),
        (nom: "c9", col: 1, voie: 0, id: "414", etiquette: "mesure 123.7", parents: ("c7",)),
        (nom: "c8", col: 1, voie: 1, id: "a24", etiquette: "mesure 92.5", parents: ("c7",)),
      ),
      branches: ((nom: "master", voie: 0, commit: "c9"), (nom: "mesure-4", voie: 1, commit: "c8")),
      echelle: 0.9,
      // La fusion des deux derniers commits, en rouge : elle s'arrête sur le conflit.
      extra: (pos, d) => {
        let (a, b) = (pos("c9"), pos("c8"))
        let cible = (2 * a.at(0) - pos("c7").at(0), a.at(1))
        let tiret = (paint: rouge-attention, thickness: 1pt, dash: "dashed")
        d.line((a.at(0) + 0.5, a.at(1)), (cible.at(0) - 0.3, cible.at(1)), stroke: tiret)
        d.line((b.at(0) + 0.45, b.at(1) - 0.2), (cible.at(0) - 0.25, cible.at(1) + 0.2), stroke: tiret)
        marque-conflit(d, cible)
      },
    )),
    tableau(
      columns: (auto, 1fr),
      align: left + horizon,
      [Commit], [La troisième ligne d'`altitudes.py`],
      [`5e6`, avant], [#text(size: 18pt)[#raw("altitudes = [79.6, 103.2, 98.3]")]],
      [`a24`, `mesure-4`], [#text(size: 18pt)[#raw("altitudes = [79.6, 103.2, 98.3, ")#underline(raw("92.5"))#raw("]")]],
      [`414`, `master`], [#text(size: 18pt)[#raw("altitudes = [79.6, 103.2, 98.3, ")#underline(raw("123.7"))#raw("]")]],
    ),
  )

  #v(0.3em)
  #console("$ git merge mesure-4\nFusion automatique de altitudes.py\nCONFLIT (contenu) : Conflit de fusion dans altitudes.py", taille: 14pt)

  #legende[
    `mesure-4` et `master` ont chacune ajouté une mesure à la même ligne, modifiée
    des deux côtés depuis `5e6`. La partie modifiée est soulignée.
  ]

  #notes[
    Le conflit vient du TD 2c, étape 6 : l'histoire de « Git : fonctionnalités » n'en
    a pas. La dernière ligne de git, « La fusion automatique a
    échoué ; réglez les conflits et validez le résultat. », est retirée de
    la sortie.

    Deux modifications sur deux lignes différentes se fusionnent sans
    conflit (le cumul et la description du programme, diapositive précédente).
  ]
]

// --------------------------------------------
#d("Résoudre un conflit")[
  #annonce[
    Écrire la ligne voulue à la place des deux versions et des marqueurs,
    puis `git add` et `git commit` terminent la fusion.
  ]

  #face-a-face(
    panneau[`altitudes.py` après `git merge`][
      #console("<<<<<<< HEAD\naltitudes = [79.6, 103.2, 98.3, 123.7]\n=======\naltitudes = [79.6, 103.2, 98.3, 92.5]\n>>>>>>> mesure-4", taille: 14pt)
    ],
    panneau[La ligne écrite, puis la fin de la fusion][
      #console("altitudes = [79.6, 103.2, 98.3, 92.5, 123.7]\n$ git add altitudes.py\n$ git commit -m \"Fusionne les deux mesures\"\n[master e0c82f8] Fusionne les deux mesures", taille: 14pt)
    ],
  )

  #legende[
    Entre `<<<<<<< HEAD` et `=======`, la ligne de la branche courante ; entre
    `=======` et `>>>>>>>`, celle de la branche fusionnée. La bonne ligne
    garde les deux mesures.
  ]

  #notes[
    VS Code affiche au-dessus du conflit « Accept Current Change », « Accept
    Incoming Change », « Accept Both Changes ». Ici, aucune ne convient :
    « Accept Both Changes » garde les deux lignes l'une sous l'autre, et seule la
    seconde affectation compte. L'éditeur de fusion de la diapositive suivante réunit
    les deux mesures sur une ligne.

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
// Capture de VS Code 1.145 sur le dépôt du TD 2c rejoué jusqu'au conflit de l'étape 6 ;
// sa fabrication est décrite dans `images/git/CREDITS.md`.
#d("Résoudre un conflit dans VS Code")[
  #annonce[
    VS Code ouvre son éditeur de fusion par le bouton « Resolve in Merge Editor »,
    en bas à droite du fichier en conflit.
  ]

  #align(center, box(stroke: 1pt + accent.lighten(55%),
    image("/src/cours2_v2/images/git/vscode_fusion.png", width: 585pt)))

  #legende[
    Incoming montre la version de `mesure-4`, la branche fusionnée, et Current celle de
    `master`, la branche courante. Après un clic sur « Accept Combination (Incoming
    First) », VS Code écrit dans Result la ligne de la diapositive précédente. Avec
    « Complete Merge », en bas à droite, il enregistre le fichier et fait le `git add` ;
    `git commit` termine la fusion.
  ]

  #notes[
    Le TD 2c fait écrire la ligne à la main ; avec l'éditeur de fusion, on obtient le
    même fichier.
    Relire la ligne de Result avant « Complete Merge » : VS Code combine les caractères
    des deux lignes sans tenir compte du sens du programme.

    Après « Complete Merge », `git status` affiche « Tous les conflits sont réglés mais
    la fusion n'est pas terminée » (vérifié sur le rejeu).
  ]
]

// --------------------------------------------
// Théorie seule : l'organisation master, develop, branche de tâche de « Bonnes
// pratiques », dans le cours 2 de 2026, avec les commits c1 à c6 de « Git :
// fonctionnalités ». Pratique au cours 6 (pull request) et au projet 7, sans `develop`.
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
      (nom: "c4", col: 2, voie: 2, parents: ("c2",)),
      (nom: "c6", col: 3, voie: 2, parents: ("c4",)),
      (nom: "c3", col: 2, voie: -1, parents: ("c2",), place: "dessous"),
      (nom: "c5", col: 3, voie: -1, parents: ("c3",), place: "dessous"),
      // Les fusions, sans numéro : l'histoire de départ n'en a qu'une, c7.
      (nom: "f1", col: 4, voie: 1, id: "", parents: ("c2", "c6")),
      (nom: "f2", col: 5, voie: 1, id: "", parents: ("f1", "c5")),
      (nom: "f3", col: 6, voie: 0, id: "", parents: ("c1", "f2")),
    ),
    branches: (
      (nom: "master", voie: 0, commit: "f3"),
      (nom: "develop", voie: 1, commit: "f2"),
      (nom: "cumul", voie: 2, commit: "c6"),
      (nom: "trace", voie: -1, commit: "c5"),
    ),
    echelle: 1.0,
    taille-etiquette: 10pt,
  ))

  #legende[
    Les commits sont ceux de « Git : fonctionnalités » : Alice écrit le dénivelé cumulé
    et le seuil, Bruno la lecture du fichier texte et de la trace GPS, chacun dans sa
    copie du dépôt. Deux fusions réunissent les tâches dans `develop`, et une troisième
    porte la version terminée dans `master`.
  ]

  #notes[
    Théorie seule aujourd'hui. Le TD 2c fait une branche et une fusion, seul,
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

// --------------------------------------------
// Nouveau (28/09/2026), d'après Pro Git, chapitre 1. Cette diapositive et la suivante
// passent en fin de partie, après les branches, le 09/11/2026.
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
    Avant : des copies à la main (diapositive « Git : fonctionnalités »), puis RCS (1982),
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
// Capture de VS Code 1.145 sur le rejeu de l'histoire, arrêté avant le commit `27f`
// (trace GPS) ; sa fabrication est décrite dans `images/git/CREDITS.md`. Image de
// 1300 × 454 pixels : les repères sont placés en pixels.
#let _capture-source-control(largeur) = {
  let echelle = largeur / 1300
  box(width: largeur, height: 454 * echelle, stroke: 1pt + accent.lighten(55%))[
    #place(top + left, image("/src/cours2_v2/images/git/vscode_source_control.png", width: largeur))
    #for (numero, x, y) in ((1, 64, 131), (2, 552, 236), (3, 440, 92), (4, 925, 22), (5, 512, 236), (6, 165, 331)) {
      place(top + left, dx: x * echelle - 9pt, dy: y * echelle - 9pt, repere(numero, taille: 18pt))
    }
  ]
}

#d("git dans VS Code : le panneau Source Control")[
  #annonce[
    VS Code lance les commandes git depuis son panneau Source Control.
  ]

  #align(center, _capture-source-control(540pt))
  #v(-6pt)

  #let element(numero, corps) = grid(
    columns: (auto, 1fr), column-gutter: 6pt, align: left + horizon,
    repere(numero, taille: 18pt), text(size: 13pt, corps),
  )
  #grid(
    columns: (1fr, 1fr, 1fr), column-gutter: 12pt, row-gutter: 4pt,
    element(1)[panneau : `Ctrl` + `Maj` + `G`],
    element(2)[bouton + : `git add`],
    element(3)[message et Commit : `git commit -m`],
    element(4)[fichier ouvert : `git diff`],
    element(5)[bouton ↶ : `git restore`],
    element(6)[Graph : `git log --graph --all`],
  )

  #legende[
    La capture précède le commit `27f` (trace GPS) : `altitudes.py` est modifié (M), et
    `trace.csv`, copié depuis `cours3/3a_denivele/depart/` (TD 3a), n'est pas suivi (U).
  ]

  #notes[
    VS Code et Git Bash agissent sur le même dépôt : un commit fait dans VS Code
    apparaît dans le `git log` de Git Bash, et inversement.

    Pour changer de branche, cliquer sur le nom de la branche, en bas à gauche de la
    fenêtre (`git checkout`).
  ]
]
