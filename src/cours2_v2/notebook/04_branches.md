---
title: Branches, fusion et conflits
subtitle: Faire évoluer une variante du projet, la fusionner, et organiser les branches à plusieurs
---

Cette partie présente les branches, qui font évoluer une variante du projet
sans toucher à la version principale, puis la fusion, qui réunit deux
branches, et le conflit, quand deux branches ont modifié la même ligne.
Elle se termine par l'organisation des branches quand on travaille à
plusieurs. Les exemples sont ceux des étapes 5 et 6 du [TD
2c](td/2c_depot_altitudes/guide.md) ; il est présenté en fin de page.

## Les branches

Une **branche** est un nom posé sur un commit. Elle avance d'un commit à
chaque commit fait sur elle. **HEAD** désigne la branche courante.

```{figure} figures/4_branches.svg
:alt: Le commit 02b, puis deux commits qui en partent : 862 sur la branche master, 18b sur la branche cumul, au-dessus. HEAD désigne 862.

Deux branches partent de `2cc` : `master` a reçu la description complétée
(`b3e`), `cumul` a reçu le dénivelé cumulé (`c56`). HEAD est sur `master`.
```

Une branche fait évoluer une **variante** sans toucher à la version
principale : ici, le calcul du dénivelé cumulé, pendant que `master` reçoit une
description complétée.

```{list-table}
:header-rows: 1

* - Commande
  - Ce qu'elle fait
* - `git branch`
  - liste les branches, et marque d'une étoile la branche courante
* - `git checkout -b <nom>`
  - crée une branche à partir du commit courant, et s'y place
* - `git checkout <nom>`
  - se place sur une branche
```

```text
$ git checkout -b cumul
Basculement sur la nouvelle branche 'cumul'
```

La branche créée par `git init` s'appelle `master` sur les postes
(git 2.43) ; GitHub nomme la sienne `main`. Git Bash affiche la branche
courante à la fin de l'invite, entre parenthèses : `~/…/travail
(cumul)`.

:::{note}
`git switch <branche>` fait la même chose que `git checkout <branche>` pour
les branches. Les cours 2, 3 et 4 emploient `git checkout`.
:::

## Changer de branche change les fichiers

`git checkout` remplace les fichiers du dossier par ceux du dernier commit
de la branche choisie.

```{figure} figures/4_checkout.svg
:alt: Deux panneaux. À gauche, sur master : le graphe avec HEAD sur 862, et la fin de la sortie du programme, sans le cumul. À droite, après git checkout cumul : le même graphe avec HEAD sur 18b, et la fin de la sortie, avec le cumul.

La fin de ce qu'affiche `python altitudes.py`, selon la branche courante.
```

Le calcul reste enregistré sur `cumul` quand on revient sur
`master`. Les fichiers non suivis ou ignorés, comme `resultat.txt`, ne
changent pas.

:::{warning}
Avant de changer de branche, enregistrer ses modifications par un commit,
ou les annuler par `git restore`. Si une modification non enregistrée devait
être écrasée, `git checkout` ne change pas de branche et affiche un message
d'erreur.
:::

## Fusionner : git merge

`git merge <branche>` apporte dans la **branche courante** les commits de
l'autre branche. La fusion se lance donc depuis la branche qui reçoit.

```{figure} figures/4_fusion.svg
:alt: Deux panneaux. À gauche, seule cumul a avancé : 02b puis 18b, avec master et cumul tous deux sur 18b. À droite, les deux branches ont avancé : 02b, puis 862 sur master et 18b sur cumul, puis 6db, qui a deux parents, 862 et 18b ; master est sur 6db.

Les deux cas d'une fusion.
```

Deux cas se présentent :

- **seule l'autre branche a avancé** : git déplace le nom de la branche
  courante jusqu'au dernier commit de l'autre, sans créer de commit. Cette
  opération s'appelle une **avance rapide**, en anglais *fast-forward* ;
- **les deux branches ont avancé** : git crée un **commit de fusion**, qui a
  deux parents, le dernier commit de chaque branche.

Au TD 2c, `master` a reçu la description complétée et `cumul` le dénivelé
cumulé. La fusion crée le commit `17ac578` :

```text
$ git checkout master
$ git merge cumul -m "Fusionne le dénivelé cumulé"
Fusion automatique de altitudes.py
Merge made by the 'ort' strategy.
 altitudes.py | 11 +++++++++++
 1 file changed, 11 insertions(+)
```

Le fichier fusionné a le dénivelé cumulé et la description complétée, parce que
les deux modifications portent sur des lignes différentes.

:::{note}
Sans `-m`, `git merge` ouvre l'éditeur vim pour le message du commit de
fusion. `Échap`, puis `:wq` et `Entrée`, gardent le message proposé.
:::

## Un conflit de fusion

Quand deux branches ont modifié **la même ligne** de deux façons
différentes, git ne peut pas choisir entre elles. La fusion s'arrête sur un
**conflit**, et git écrit les deux versions dans le fichier.

```{figure} figures/4_conflit.svg
:alt: Le commit 6db, puis deux commits qui en partent : 7e0 sur master, 6f7 sur mesure-4, au-dessus. Deux traits pointillés rouges partent de 7e0 et de 6f7 vers une étoile marquée Conflit.

La fusion de `mesure-4` dans `master` s'arrête sur un conflit.
```

À l'étape 6 du TD 2c, la troisième ligne d'`altitudes.py` est modifiée des
deux côtés depuis `17a` :

```{list-table}
:header-rows: 1

* - Commit
  - La troisième ligne d'`altitudes.py`
* - `17a`, avant
  - `altitudes = [79.6, 103.2, 98.3]`
* - `f68`, sur `mesure-4`
  - `altitudes = [79.6, 103.2, 98.3, 92.5]`
* - `c07`, sur `master`
  - `altitudes = [79.6, 103.2, 98.3, 123.7]`
```

`mesure-4` et `master` ont chacune ajouté une mesure à la même ligne.

```text
$ git merge mesure-4
Fusion automatique de altitudes.py
CONFLIT (contenu) : Conflit de fusion dans altitudes.py
La fusion automatique a échoué ; réglez les conflits et validez le résultat.
```

Le début d'`altitudes.py` est alors :

```text
"""Altitudes extrêmes et dénivelé cumulé d'une série de mesures."""

<<<<<<< HEAD
altitudes = [79.6, 103.2, 98.3, 123.7]
=======
altitudes = [79.6, 103.2, 98.3, 92.5]
>>>>>>> mesure-4
```

- Entre `<<<<<<< HEAD` et `=======` : la ligne de la **branche courante**,
  `master`.
- Entre `=======` et `>>>>>>> mesure-4` : celle de la **branche fusionnée**.

:::{warning}
Les marqueurs sont des lignes de texte ordinaires. Laissés dans un fichier
Python, ils provoquent une `SyntaxError`.
:::

### Résoudre un conflit

1. Écrire la ligne voulue à la place des deux versions et des marqueurs.
   Ici, la bonne ligne garde les deux mesures :
   `altitudes = [79.6, 103.2, 98.3, 92.5, 123.7]`
2. Vérifier qu'il ne reste aucun marqueur : `Ctrl` + `F` dans VS Code,
   chercher `<<<<`.
3. `git add` puis `git commit` terminent la fusion.

```text
$ git add altitudes.py
$ git status
Sur la branche master
Tous les conflits sont réglés mais la fusion n'est pas terminée.
  (utilisez "git commit" pour terminer la fusion)

Modifications qui seront validées :
	modifié :         altitudes.py

$ git commit -m "Fusionne les deux mesures"
[master 83a406f] Fusionne les deux mesures
```

VS Code affiche au-dessus du conflit « Accept Current Change », « Accept
Incoming Change » et « Accept Both Changes ». Ici, aucune ne convient.

:::{note}
`git merge --abort` abandonne une fusion en conflit, et rend l'état d'avant
le `git merge`. Pendant la fusion, Git Bash affiche `(master|MERGING)` à la
fin de l'invite.
:::

## L'organisation des branches à plusieurs

À plusieurs, chacun travaille dans sa copie du dépôt, et les branches
suivent une organisation connue de toute l'équipe. La plus répandue,
appelée *git flow*, sépare trois sortes de branches.

```{figure} figures/4_organisation.svg
:alt: Quatre lignes de commits. En bas, master, avec c1 puis c9. Au-dessus, develop, avec c2, c6 et c8. En haut, la branche cumul, avec c3 et c4, fusionnée dans develop en c6. En bas, la branche mesures, avec c5 et c7, fusionnée dans develop en c8. c9, sur master, fusionne develop.

Alice écrit le calcul du cumul, Bruno ajoute des mesures. `c6` et `c8`
fusionnent les tâches dans `develop` ; `c9` porte la version terminée dans
`master`.
```

- **`master`** (ou `main`) ne reçoit que les **versions terminées**, celles
  qui peuvent être distribuées.
- **`develop`** réunit le travail en cours. Elle contient toujours une
  version qui fonctionne, et on n'y travaille pas directement : elle ne
  reçoit que des fusions.
- Une **branche par tâche** part de `develop`. On y travaille, puis elle est
  fusionnée dans `develop` quand la tâche est terminée. Si `develop` a
  changé entre-temps, on la fusionne dans la branche de tâche, pour
  travailler sur un état à jour.

:::{note}
Le module pratique une forme réduite de cette organisation : une branche
par tâche, fusionnée dans `master` par une *pull request* sur la forge
(cours 6 et projet 7), sans branche `develop`. Le projet 7 pose un `tag` sur
la version rendue.
:::

## TD de la partie

- [TD 2c — Un dépôt git pour altitudes.py](td/2c_depot_altitudes/guide.md),
  40 minutes. Les étapes 5 et 6 appliquent cette page : une branche
  fusionnée, puis un conflit résolu ; le graphe du dépôt se dessine sur
  papier avant d'être comparé à `git log --oneline --graph --all
  --decorate`. L'étape 7, pour ceux qui ont fini, copie le dépôt par
  `git clone` et fait passer un commit d'une copie à l'autre par
  `git pull`.

Pour s'entraîner à git après la séance, des jeux et des exercices sont
réunis dans [S'entraîner : jeux et exercices](../../apres/s_entrainer.md),
dont Learn Git Branching, en français.

Les TD des autres parties sont dans [Travaux dirigés de la séance 2,
version 2](travaux_diriges.md).
