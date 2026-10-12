---
title: "S'entraîner : jeux et exercices"
subtitle: La ligne de commande et git, en jouant, dans le navigateur ou dans Git Bash
---

La ligne de commande et git s'apprennent en les pratiquant. Les ressources
ci-dessous sont gratuites ; la plupart se jouent dans le navigateur, sans
installation ni compte. Elles complètent les TD, et se font seul, après la
séance, au rythme de chacun. Elles ont été choisies en septembre 2026 parmi
les plus citées par des enseignants et des développeurs.

:::{note}
La plupart sont en anglais ; Learn Git Branching et GameShell existent en
français. Un jeu dans le navigateur ne modifie aucun fichier du poste : il
simule le terminal ou git, ou exécute les commandes sur un serveur. Un jeu
joué dans Git Bash emploie les vraies commandes, sur les fichiers du poste.
:::

## La ligne de commande

```{list-table}
:header-rows: 1
:widths: 22 50 28

* - Ressource
  - Ce qu'on y fait
  - Accès
* - [Terminus](https://web.mit.edu/mprat/Public/web/Terminus/Web/main.html)
    (MIT)
  - une aventure textuelle : on se déplace de lieu en lieu avec `cd` et
    `ls`, on lit avec `cat`, on agit avec `mv`, `cp` et `rm`. Pour un
    premier contact, environ 30 minutes.
  - navigateur, sans compte, en anglais ; terminal simulé
* - [CMD Challenge](https://cmdchallenge.com)
  - des défis à résoudre en une ligne de commande : copier, supprimer par
    motif `*`, chercher avec `grep`. Les premiers défis sont à la portée du
    cours 1 ; la seconde moitié va plus loin.
  - navigateur, sans compte, en anglais ; vrai bash, exécuté sur un serveur
* - [The Command Line
    Murders](https://github.com/veltman/clmystery)
  - une enquête policière à résoudre dans le terminal, avec `cd`, `ls`,
    `cat`, `head` et `grep`. Environ 1 à 2 heures.
  - archive à télécharger (bouton *Code*, *Download ZIP*), puis jouée dans
    Git Bash ; sans compte, en anglais
* - [GameShell](https://github.com/phyver/GameShell)
  - des missions à accomplir dans un vrai terminal bash : `cd`, `mkdir`,
    `mv`, `cp`, `rm`, les motifs, puis `find`, `grep` et les tubes. Conçu
    pour la première année de licence, environ 3 heures.
  - **en français** ; à installer sur un ordinateur sous Linux ou macOS
    (non prévu pour Git Bash)
```

## git

```{list-table}
:header-rows: 1
:widths: 22 50 28

* - Ressource
  - Ce qu'on y fait
  - Accès
* - [Learn Git Branching](https://learngitbranching.js.org/?locale=fr_FR)
  - des niveaux où l'on tape des commandes git et où l'on voit le graphe des
    commits se modifier : commit, branches, merge, rebase, puis les dépôts
    distants. L'introduction prend 30 minutes.
  - navigateur, **en français**, sans compte ; git simulé
* - [Visualizing Git](https://git-school.github.io/visualizing-git/)
  - un bac à sable sans consignes : chaque commande git tapée modifie le
    graphe dessiné à côté. Pour vérifier ce que fait une commande.
  - navigateur, sans compte, en anglais ; git simulé
* - [Git Exercises](https://gitexercises.fracz.com)
  - 23 exercices en vrai git, sur un dépôt téléchargé : un commit partiel,
    un conflit de fusion, un rebase, un commit perdu. Chaque exercice se
    valide par la commande `git verify`.
  - dans Git Bash, sans compte, en anglais ; la validation demande un accès
    à Internet
* - [Oh My Git!](https://ohmygit.org)
  - un jeu de cartes et un terminal pour apprendre git, avec le dépôt
    dessiné en direct ; les derniers niveaux traitent des dépôts distants.
  - jeu à télécharger (Windows, Linux, macOS), sans compte, en anglais ;
    plutôt sur un ordinateur personnel
```

## Un outil pour lire une commande

[ExplainShell](https://explainshell.com) décompose une commande copiée dans
sa page : chaque option et chaque argument y est relié à l'extrait
correspondant du manuel. Il sert à comprendre une commande trouvée dans une
documentation, avant de la taper.

:::{warning}
Une commande trouvée en ligne se relit avant d'être lancée dans Git Bash,
surtout si elle contient `rm`. Un jeu dans le navigateur n'agit sur aucun
fichier ; le terminal du poste agit sur les vrais fichiers.
:::
