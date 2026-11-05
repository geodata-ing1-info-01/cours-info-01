---
title: "TD 4a — Un script Python, pas à pas"
subtitle: Présentation, énoncé et solutions (version 2, proposition)
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

*Version 2 du cours 4 : proposition de travail pour 2027-2028. Le TD garde les
étapes du TD 4a de 2026, sur le programme de la trace GPS des cours 1 à 3.*

Ce guide a trois parties. La présentation décrit le programme de départ, le
programme à obtenir et la méthode de travail. L'énoncé donne, pour chaque étape,
l'objectif, les consignes et le test à lancer. Les solutions donnent le code de
chaque étape, modification par modification, avec son explication.

Aux TD 3a à 3c, le code à écrire était donné. Dans ce TD, vous l'écrivez à partir des
consignes, qui en donnent une partie. Pour chaque étape, écrire d'abord le code, puis
lancer le test. Lire ensuite la solution, pour vérifier son code ou pour avancer si
l'essai n'aboutit pas.

Le code de ce guide se copie depuis `guide_4a_trace.html`, ouvert dans un
navigateur, ou depuis `guide.ipynb`, ouvert dans JupyterLab. Copié depuis le
PDF, il perd ses indentations.

# Présentation du TD

## Objectif du TD

### Le programme

Le TD part de `stats_trace.py`, le programme `altitudes.py` du TD 3c sous un autre
nom. Ce programme lit une trace GPS dans un fichier CSV, puis affiche ses altitudes
extrêmes et son dénivelé cumulé. Le TD lui ajoute le calcul de la distance
parcourue, puis celui de la vitesse moyenne.

Une fois corrigées les deux erreurs du programme de départ, le programme affiche :

{{sortie b1 trace.csv}}

À la fin du TD, deux options de la ligne de commande ajoutent les deux résultats :

{{sortie b6 trace.csv --distance --vitesse}}

### La trace GPS

`trace.csv` contient une position toutes les 30 secondes :

```text
durée,x,y,z
0,673120.5,6860840.2,128.4
30,673152.9,6860856.3,131.0
60,673186.9,6860870.9,127.6
…
1800,673627.7,6859286.4,126.9
```

`durée` : secondes depuis le départ. `x`, `y` : Lambert-93, en mètres. `z` :
altitude, en mètres.

Deux positions successives forment un **segment**. La distance parcourue est la somme
des longueurs des segments, et la vitesse moyenne est cette distance divisée par le
temps total.

![Les cinq premières positions de `trace.csv`, et les longueurs de leurs segments](illustrations/segments.png)

## Méthode de travail

### Un test à chaque étape

À la fin de chaque étape, le programme s'exécute sans erreur, et une commande de
test montre si la modification est juste. Une option s'écrit dans cet ordre :
d'abord sa déclaration, avec un message à la place du calcul ; puis les calculs
intermédiaires, avec des affichages provisoires qui permettent de les contrôler ;
enfin le résultat, une fois ces affichages retirés.

Pour l'option `--distance`, la sortie de `python stats_trace.py trace.csv --distance`
se termine ainsi :

| À la fin de l'étape | Lignes après `cumul en baisse` |
|----|------------------------|
| B2 | `distance : calcul manquant` |
| B3 | `positions lues : 61`, `position 0 : 673120.5 6860840.2`, `distance : calcul manquant` |
| B4 | `essai, 5.0 attendu : 5.0`, `premier segment : 36.2 m`, `distance : calcul manquant` |
| B5 | `distance parcourue : 2166.4 m` |

Allen Downey décrit cette méthode dans
[*Think Python*, section 5.2](https://greenteapress.com/thinkpython/html/chap05.html),
sous le nom de développement incrémental, sur le même calcul de distance.

Une étape se termine par ces opérations :

1. Enregistrer le fichier (`Ctrl` + `S`).
2. Lancer la commande de test, par exemple `python stats_trace.py trace.csv --distance`, puis comparer la sortie à celle de l'énoncé.
3. Faire le commit de l'étape, en deux commandes : `git add stats_trace.py`, puis `git commit -m "…"`.

Les textes affichés par le programme sont ceux de la sortie de l'énoncé, à recopier
tels quels : la comparaison ne montre alors que les vraies différences. Ils sont écrits
sans accent : selon le terminal, Python n'écrit pas les accents de la même façon.

**Si une étape échoue.** `git status` montre les fichiers modifiés depuis le
dernier commit. `git diff` montre les lignes modifiées (`q` pour quitter).
`git restore stats_trace.py` remet le fichier dans l'état du dernier commit.

## Les étapes

La partie A, étapes A1 à A3, dure 30 minutes. La partie B, étapes B1 à B6, dure
75 minutes. L'étape B7 est un bonus.

| Énoncé | Objectif | Commits à la fin | Solution |
|-----|----------------------|------|----|
| [A1](#@Étape A1) | créer le dossier du projet dans le terminal | 0 | [A1](#@Solution de l'étape A1) |
| [A2](#@Étape A2) | ouvrir le projet dans VS Code | 0 | [A2](#@Solution de l'étape A2) |
| [A3](#@Étape A3) | versionner le programme de départ | 1 | [A3](#@Solution de l'étape A3) |
| [B1](#@Étape B1) | lire un message d'erreur, corriger le programme | 3 | [B1](#@Solution de l'étape B1) |
| [B2](#@Étape B2) | ajouter l'option `--distance`, sans le calcul | 4 | [B2](#@Solution de l'étape B2) |
| [B3](#@Étape B3) | lire les positions de la trace | 5 | [B3](#@Solution de l'étape B3) |
| [B4](#@Étape B4) | écrire la fonction `distance_entre` | 6 | [B4](#@Solution de l'étape B4) |
| [B5](#@Étape B5) | écrire la fonction `distance_parcourue` | 7 | [B5](#@Solution de l'étape B5) |
| [B6](#@Étape B6) | ajouter l'option `--vitesse` | 8 | [B6](#@Solution de l'étape B6) |
| [B7](#@Étape B7) (bonus) | écrire un README, poser une étiquette | 9 | [B7](#@Solution de l'étape B7) |

### Les notions employées

| Notion | Vue au | Employée aux étapes |
|---|---|---|
| le terminal : `cd`, `ls`, `mkdir`, `cp` | cours 1 | A1 |
| VS Code et son terminal | cours 2 | A2 et les suivantes |
| git : `init`, `add`, `commit`, `.gitignore` | cours 2 | A3 et les suivantes |
| les messages d'erreur de Python | cours 2 | B1 |
| `argparse`, la lecture d'un fichier | cours 3 | B2 et B3 |
| une fonction : `def`, `return` | présentée à l'étape B4 | B4 à B6 |

# Énoncé

Les étapes A1 à A3 préparent le projet. Les étapes B1 à B6 modifient le programme.

## Étape A1 · Créer le dossier du projet

> **Objectif :** créer le dossier du projet par des commandes, en copiant les fichiers livrés.

Le projet est un dossier à part, dans `travail/` : les fichiers de `depart/` restent
tels qu'ils ont été livrés.

**Consignes**

1. Copier l'archive `info01-cours4.zip` de `formationTemp` dans le dossier `info01` du Bureau.
2. Ouvrir Git Bash depuis le menu Démarrer.
3. Aller dans le dossier `~/Desktop/info01`, puis décompresser l'archive.
4. Aller dans le dossier du TD, `cours4/4a_trace`.
5. Créer le dossier du projet, `travail/stats_trace`.
6. Copier `depart/stats_trace.py` dans ce dossier.
7. Copier les deux traces de `depart/` dans ce dossier, en une seule commande, avec le motif `*.csv`.

**Commandes possibles**

| Commande | Effet |
|---|---|
| `cd dossier` | entre dans le dossier |
| `ls dossier` | liste le contenu du dossier |
| `unzip archive.zip` | décompresse l'archive dans le dossier courant |
| `mkdir nom` | crée un dossier |
| `cp source destination` | copie un fichier |
| `*.csv` | désigne tous les fichiers dont le nom se termine par `.csv` |

**Test**

`ls travail/stats_trace` affiche `stats_trace.py`, `trace.csv` et `trace_2.csv`.

Si `cp` affiche `No such file or directory`, relire le chemin : la touche `Tab`
complète les noms de dossiers et de fichiers.

Solution : [étape A1](#@Solution de l'étape A1).

## Étape A2 · Ouvrir le projet dans VS Code

> **Objectif :** ouvrir le dossier du projet dans VS Code, avec un terminal Git Bash dans ce dossier.

**Consignes**

1. Lancer VS Code depuis le menu Démarrer.
2. Ouvrir le dossier du projet : menu File, Open Folder…, `Desktop\info01\cours4\4a_trace\travail\stats_trace`, puis « Sélectionner un dossier ». Si VS Code demande si l'on fait confiance aux auteurs des fichiers, répondre « Yes, I trust the authors ».
3. Ouvrir un terminal : menu Terminal, New Terminal.
4. Dans l'explorateur de VS Code, à gauche, ouvrir `stats_trace.py`.

**Test**

L'invite du terminal est :

```text
(base)
eleve@POSTE MINGW64 ~/Desktop/info01/cours4/4a_trace/travail/stats_trace
$
```

Dans `stats_trace.py`, chaque espace du code apparaît comme un point gris, et chaque
tabulation comme une flèche.

Si l'invite ou l'affichage diffèrent, la [solution de l'étape A2](#@Solution de l'étape A2)
donne le réglage à refaire.

## Étape A3 · Créer le dépôt git

> **Objectif :** enregistrer l'état de départ du projet dans un premier commit.

À chaque lancement, le programme ajoute une ligne au fichier `resume.txt` (TD 3c).
Ce fichier n'est pas versionné, car le programme le modifie à chaque lancement. Le fichier
`.gitignore` donne la liste des fichiers et des dossiers que git ne suit pas, un par
ligne.

**Consignes**

1. Dans le terminal de VS Code, créer le dépôt dans le dossier du projet.
2. Indiquer son nom et son adresse électronique, pour ce dépôt seulement.
3. Dans l'explorateur de VS Code, créer un fichier nommé `.gitignore` (icône New File), y écrire la ligne `resume.txt`, puis enregistrer (`Ctrl` + `S`).
4. Afficher l'état du dépôt.
5. Faire le premier commit, avec tous les fichiers et le message `Le programme de départ et les traces`.
6. Afficher l'historique.

**Commandes possibles**

| Commande | Effet |
|---|---|
| `git init` | crée le dépôt dans le dossier courant |
| `git config user.name "Prénom Nom"` | le nom qui signe les commits, pour ce dépôt ; de même `user.email` |
| `git status` | les fichiers modifiés depuis le dernier commit |
| `git add .` | ajoute au prochain commit les fichiers du dossier courant |
| `git commit -m "…"` | enregistre le commit, avec ce message |
| `git log --oneline` | l'historique, une ligne par commit |

**Test**

Avant le commit, `git status` liste `.gitignore`, `stats_trace.py`, `trace.csv` et
`trace_2.csv` parmi les fichiers non suivis. Après le commit, `git log --oneline`
affiche une ligne.

Solution : [étape A3](#@Solution de l'étape A3).

## Étape B1 · Corriger le programme de départ

> **Objectif :** lire un message d'erreur de Python et corriger la ligne qu'il désigne. Le programme de départ contient deux erreurs.

**Consignes**

1. Dans le terminal, lancer le programme : `python stats_trace.py trace.csv`.
2. Lire le message d'erreur. Il donne le fichier et le numéro de la ligne, recopie la ligne, puis nomme l'erreur.
3. Dans VS Code, corriger cette ligne, puis enregistrer le fichier (`Ctrl` + `S`).
4. Faire le commit de la correction, avec un message qui la décrit : `git add stats_trace.py`, puis `git commit -m "Correction : …"`.
5. Relancer le programme, puis refaire les consignes 2 à 4 sur la seconde erreur.

**Test**

{{sortie b1 trace.csv}}

`git log --oneline` affiche trois lignes, une par commit.

Solution : [étape B1](#@Solution de l'étape B1).

## Étape B2 · Ajouter l'option de distance

> **Objectif :** ajouter au programme l'option `--distance`, qui affiche pour l'instant le message `distance : calcul manquant`.

Le calcul est écrit aux étapes B3 à B5. Déclarée dès cette étape, l'option permet de
tester ces trois étapes avec la même commande.

Une option sans valeur se déclare comme l'option `--seuil` du TD 3b, avec
`action="store_true"` à la place de `type` et de `default` :

```python
analyseur.add_argument("--distance", action="store_true", help="…")
```

Après `parse_args`, `options.distance` vaut `True` quand la commande contient
`--distance`, et `False` sinon. Le bloc `if options.distance:` ne s'exécute donc que
si la commande contient l'option.

**Consignes**

1. Dans `stats_trace.py`, avant la ligne `options = analyseur.parse_args()`, déclarer l'option `--distance`, avec le texte d'aide `affiche la distance parcourue`.
2. À la fin du fichier, ajouter le bloc `if options.distance:`, qui affiche `distance : calcul manquant`.
3. Enregistrer le fichier.

**Test**

Avec l'option, le message s'affiche à la fin de la sortie :

{{sortie b2 trace.csv --distance}}

Sans l'option, `python stats_trace.py trace.csv` affiche les cinq lignes de l'étape
B1, sans le message.

`python stats_trace.py --help` décrit l'option :

```text
  --distance            affiche la distance parcourue
```

**Commit**

```text
git add stats_trace.py
git commit -m "L'option --distance, sans le calcul"
```

Solution : [étape B2](#@Solution de l'étape B2).

## Étape B3 · Lire les positions de la trace

> **Objectif :** garder les colonnes `x` et `y` de la trace dans deux listes, et contrôler les valeurs lues.

Le programme découpe déjà chaque ligne de la trace en `duree`, `x`, `y` et `z`, mais
il ne garde que `z`, dans la liste `altitudes`.

**Consignes**

1. Sous la ligne `altitudes = []`, créer deux listes vides, `liste_x` et `liste_y`.
2. Dans la boucle de lecture, sous la ligne `altitudes.append(float(z))`, convertir `x` et `y` en nombres avec `float`, puis les ajouter à `liste_x` et à `liste_y`.
3. Dans le bloc `if options.distance:`, au-dessus du message, afficher provisoirement `positions lues : `, suivi de `len(liste_x)`.
4. Sous cette ligne, afficher provisoirement `position 0 : `, suivi de `liste_x[0]` et de `liste_y[0]`.
5. Enregistrer le fichier.

**Test**

{{sortie b3 trace.csv --distance}}

Ouvrir `trace.csv` dans VS Code, puis vérifier que la ligne 2 commence par
`0,673120.5,6860840.2` et que la dernière position est à la ligne 62.

`python stats_trace.py trace_2.csv --distance` affiche `positions lues : 121`.

**Commit**

```text
git add stats_trace.py
git commit -m "Les positions de la trace"
```

Solution : [étape B3](#@Solution de l'étape B3).

## Étape B4 · Écrire la fonction distance_entre

> **Objectif :** écrire la fonction `distance_entre(x1, y1, x2, y2)`, qui renvoie la distance entre deux points, et l'essayer sur un cas dont le résultat est connu.

`len` et `min`, employées depuis le cours 3, sont des fonctions fournies par Python.
`def` permet d'en écrire de nouvelles. Les paramètres d'une fonction reçoivent les
valeurs données à l'appel, et `return` renvoie le résultat à l'endroit de l'appel.
Une fonction s'écrit avant son premier appel, car Python exécute le fichier de haut
en bas. Ce programme affiche `ecart : 2.6 m` :

```python
def ecart(a, b):
    """La différence entre deux valeurs."""
    return b - a


resultat = ecart(128.4, 131.0)
print(f"ecart : {resultat:.1f} m")
```

Les coordonnées `x` et `y` sont en mètres. La distance entre deux points est
l'hypoténuse du triangle rectangle de côtés `x2 - x1` et `y2 - y1`, comme sur la
figure de la présentation : √((x2 − x1)² + (y2 − y1)²). En Python, `**` élève à une
puissance : `3 ** 2` vaut `9`. `math.sqrt` donne la racine carrée, après `import math`.

**Consignes**

1. En tête de `stats_trace.py`, ajouter la ligne `import math`.
2. Sous les lignes `import`, écrire la fonction `distance_entre(x1, y1, x2, y2)`, qui renvoie la distance avec `return`.
3. Dans le bloc `if options.distance:`, retirer les deux affichages provisoires de l'étape B3.
4. À leur place, afficher provisoirement `essai, 5.0 attendu : `, suivi de `distance_entre(0, 0, 3, 4)`. Le triangle de côtés 3 et 4 a une hypoténuse de longueur 5.
5. Sous cette ligne, appeler `distance_entre` avec `liste_x[0]`, `liste_y[0]`, `liste_x[1]` et `liste_y[1]`, et garder le résultat dans la variable `premier_segment`.
6. Afficher provisoirement `premier segment : `, suivi de `premier_segment` avec un chiffre après la virgule, puis ` m`.
7. Enregistrer le fichier.

**Test**

{{sortie b4 trace.csv --distance}}

Sur les deux premières lignes de la trace, `x2 - x1` vaut 32,4 et `y2 - y1` vaut
16,1. À la calculatrice, √(32,4² + 16,1²) donne 36,2.

Si la sortie diffère, ce tableau donne les causes les plus fréquentes :

| Sortie | Cause |
|---------------------|-----------|
| `NameError: name 'distance_entre' is not defined` | la fonction est écrite après son appel |
| `NameError: name 'math' is not defined…` | la ligne `import math` manque |
| `essai, 5.0 attendu : None` | la fonction ne contient pas `return` |
| `TypeError: unsupported operand type(s) for -: 'str' and 'str'` | `float` manque dans la boucle de lecture (étape B3) |

**Commit**

```text
git add stats_trace.py
git commit -m "La fonction distance_entre"
```

Solution : [étape B4](#@Solution de l'étape B4).

## Étape B5 · Écrire la fonction distance_parcourue

> **Objectif :** écrire la fonction `distance_parcourue(liste_x, liste_y)`, qui calcule la somme des longueurs des segments, puis afficher le résultat final.

La position 0 n'a pas de position précédente : la boucle commence donc à `i = 1`, et
`liste_x[i - 1]` désigne la position précédente. Le TD 3a parcourait les altitudes de
la même façon.

**Consignes : écrire la fonction**

1. Sous `distance_entre`, déclarer la fonction `distance_parcourue(liste_x, liste_y)`.
2. Dans la fonction, créer la variable `total`, qui vaut 0.
3. Écrire la boucle : `for i in range(1, len(liste_x)):`.
4. Dans la boucle, appeler `distance_entre` avec `liste_x[i - 1]`, `liste_y[i - 1]`, `liste_x[i]` et `liste_y[i]`, et garder le résultat dans la variable `segment`.
5. Dans la boucle, ajouter `segment` à `total`.
6. Dans la boucle, afficher provisoirement `position `, suivi de `i`, puis `, cumul : `, suivi de `total` avec un chiffre après la virgule.
7. Après la boucle, au niveau de la ligne `for`, renvoyer `total` avec `return`.

**Consignes : appeler la fonction**

1. Dans le bloc `if options.distance:`, retirer tout le contenu.
2. À la place, écrire `distance = distance_parcourue(liste_x, liste_y)`.
3. Afficher `distance parcourue : `, suivi de `distance` avec un chiffre après la virgule, puis ` m`.
4. Enregistrer le fichier.

**Test**

{{extrait b5.2 trace.csv --distance}}

La première valeur est celle du premier segment, à l'étape B4. La valeur augmente
ensuite d'environ 36 m à chaque ligne. Si la sortie s'arrête à `position 1`, avec
`distance parcourue : 36.2 m`, le `return` est dans la boucle.

**Consignes : retirer l'affichage provisoire**

1. Retirer le `print` de la boucle.
2. Enregistrer le fichier.

**Test**

{{sortie b5 trace.csv --distance}}

La trace compte 60 segments d'environ 36 m, et 60 × 36 = 2160 : le résultat a le bon
ordre de grandeur.

`python stats_trace.py trace_2.csv --distance` se termine par
`distance parcourue : 4327.6 m`.

**Commit**

```text
git add stats_trace.py
git commit -m "Le calcul de la distance parcourue"
```

Solution : [étape B5](#@Solution de l'étape B5).

## Étape B6 · Ajouter l'option de vitesse

> **Objectif :** ajouter l'option `--vitesse`, qui affiche la vitesse moyenne, dans le même ordre que pour la distance : l'option, le calcul intermédiaire, puis le résultat.

La vitesse moyenne est la distance parcourue divisée par le temps total. Le temps
total est la dernière valeur de la colonne `durée` moins la première. `durees[-1]`
désigne le dernier élément de la liste `durees`. Une vitesse en m/s, multipliée par
3,6, donne des km/h.

**Consignes : déclarer l'option**

1. Avant la ligne `options = analyseur.parse_args()`, déclarer l'option `--vitesse`, avec le texte d'aide `affiche la vitesse moyenne`.
2. À la fin du fichier, ajouter le bloc `if options.vitesse:`, qui affiche `vitesse : calcul manquant`.
3. Enregistrer le fichier.

**Test**

`python stats_trace.py trace.csv --vitesse` se termine par
`vitesse : calcul manquant`.

**Consignes : calculer le temps total**

1. Sous la ligne `liste_y = []`, créer une liste vide, `durees`.
2. Dans la boucle de lecture, convertir `duree` en nombre avec `float`, puis l'ajouter à `durees`.
3. Dans le bloc `if options.vitesse:`, au-dessus du message, calculer `temps_total`, la dernière durée moins la première.
4. Sous cette ligne, afficher provisoirement `temps total : `, suivi de `temps_total` sans chiffre après la virgule (`:.0f`), puis ` s`.
5. Enregistrer le fichier.

**Test**

`python stats_trace.py trace.csv --vitesse` se termine par ces deux lignes :

```text
temps total : 1800 s
vitesse : calcul manquant
```

La dernière ligne de `trace.csv` commence par `1800`.

**Consignes : calculer la vitesse**

1. Sous `distance_parcourue`, écrire la fonction `vitesse_moyenne(distance, temps)`, qui renvoie la vitesse en m/s.
2. Dans le bloc `if options.vitesse:`, retirer les deux `print`.
3. Sous le calcul de `temps_total`, écrire `distance = distance_parcourue(liste_x, liste_y)`.
4. Appeler `vitesse_moyenne` avec `distance` et `temps_total`, et garder le résultat dans la variable `vitesse`.
5. Afficher `vitesse moyenne : `, suivi de `vitesse` avec deux chiffres après la virgule, puis ` m/s, soit `, suivi de `vitesse * 3.6` avec un chiffre après la virgule, puis ` km/h`.
6. Enregistrer le fichier.

**Test**

{{sortie b6 trace.csv --distance --vitesse}}

`python stats_trace.py trace.csv --vitesse`, sans `--distance`, se termine par la même
ligne `vitesse moyenne`.

À la calculatrice, 2166,4 / 1800 donne 1,20. La seconde trace a été fabriquée à la
même vitesse : `python stats_trace.py trace_2.csv --vitesse` se termine aussi par
cette ligne.

**Commit**

```text
git add stats_trace.py
git commit -m "L'option --vitesse"
```

`git log --oneline` affiche huit lignes.

Solution : [étape B6](#@Solution de l'étape B6).

## Étape B7 (bonus) · Écrire un README et poser une étiquette

> **Objectif :** permettre à une autre personne de lancer le programme, et nommer la version finale.

**Consignes**

1. Copier le modèle de README dans le projet : `cp ../../depart/modeles/README.md .`
2. Ouvrir `README.md` dans VS Code et remplacer chaque passage « (À compléter …) ». `Ctrl` + `Maj` + `V` affiche l'aperçu.
3. Coller chaque commande du README dans le terminal, et vérifier qu'elle fonctionne.
4. Faire le commit du README : `git add README.md`, puis `git commit -m "Un README"`.
5. Poser l'étiquette `v1.0` sur ce commit : `git tag -a v1.0 -m "Première version"`.

**Test**

`git log --oneline` affiche neuf lignes, la première marquée `tag: v1.0`.

Solution : [étape B7](#@Solution de l'étape B7).

# Solutions

## Lecture des blocs de modification

Une solution suit l'ordre des consignes : une explication, puis les lignes qu'elle
décrit. Elle ne donne que les lignes qui changent, comme dans cet extrait de l'étape
B2 :

{{modif b2.1}}

Les lignes en vert, entre deux lignes `+++`, sont à ajouter. Les lignes en rouge,
entre deux lignes `---`, sont à supprimer. Les autres lignes ne changent pas et
indiquent l'endroit de la modification. Le signe `…` remplace des lignes qui ne
changent pas.

Le nombre en tête d'une ligne est le numéro de la ligne dans VS Code, quand les
modifications sont faites de haut en bas. Une ligne à ajouter n'a pas de numéro. Si
le fichier n'a pas les mêmes lignes vides que le guide, les numéros diffèrent de
quelques lignes, et les lignes qui ne changent pas permettent de retrouver l'endroit.

Les lignes à ajouter se copient telles quelles, avec leur indentation, sans les
lignes `+++`.

## Solution de l'étape A1

Décompresser l'archive dans le dossier `info01` du Bureau, puis aller dans le dossier
du TD :

```text
cd ~/Desktop/info01
unzip info01-cours4.zip
cd cours4/4a_trace
```

Créer le dossier du projet, puis y copier le programme et les traces. `mkdir` crée un
dossier. `cp` copie le fichier nommé en premier dans le dossier nommé en second.
`*.csv` désigne tous les fichiers dont le nom se termine par `.csv`. Une commande qui
réussit n'affiche rien.

```text
mkdir travail/stats_trace
cp depart/stats_trace.py travail/stats_trace/
cp depart/*.csv travail/stats_trace/
```

Lister ensuite le dossier du projet :

```text
ls travail/stats_trace
```

Erreur fréquente : `cp` lancé depuis `travail/`. `pwd` montre le dossier courant, qui
doit être `4a_trace/`.

## Solution de l'étape A2

Le dossier ouvert est le projet : l'explorateur, à gauche, montre ses fichiers, et le
terminal s'ouvre dans ce dossier. Les réglages suivants datent du TD 2a, et sont à
refaire si le test de l'étape échoue.

**L'invite commence par `PS`.** Le terminal est PowerShell. Ouvrir la palette de
commandes (`Ctrl` + `Maj` + `P`), taper `default profile`, choisir « Terminal: Select
Default Profile », puis « Git Bash ». Fermer le terminal (icône de corbeille), puis
en ouvrir un nouveau.

**L'invite ne contient pas `(base)`.** conda n'est pas encore réglé dans Git Bash sur
ce poste. Le régler une fois, puis fermer le terminal et en ouvrir un nouveau :

```text
source /c/ProgramData/anaconda3/etc/profile.d/conda.sh
conda init bash
```

**Les espaces n'apparaissent pas.** Ouvrir les réglages (`Ctrl` + `,`), taper `render
whitespace` dans la zone de recherche, et choisir `all` pour « Editor: Render
Whitespace ». Sur un thème sombre, les points et les flèches se voient mal. Un thème
clair les rend plus visibles : `Ctrl` + `K`, puis `Ctrl` + `T`, et choisir « Light
Modern ».

## Solution de l'étape A3

Créer le dépôt, puis régler le nom et l'adresse. Le poste est partagé : le nom et
l'adresse sont réglés pour ce dépôt seulement, sans `--global`.

```text
git init
git config user.name "Prénom Nom"
git config user.email "prenom.nom@exemple.fr"
```

Dans l'explorateur de VS Code, créer le fichier `.gitignore` (icône New File), y
écrire la ligne `resume.txt`, puis enregistrer. Afficher ensuite l'état du dépôt :

```text
git status
```

`git status` liste `.gitignore`, `stats_trace.py`, `trace.csv` et `trace_2.csv` parmi
les fichiers non suivis. Faire alors le premier commit, puis afficher l'historique :

```text
git add .
git commit -m "Le programme de départ et les traces"
git log --oneline
```

## Solution de l'étape B1

**Première erreur.** Python s'arrête sur cette erreur :

{{sortie depart trace.csv}}

`SyntaxError: expected ':'` signale un deux-points manquant : une ligne `for` se
termine par `:`. Corriger la ligne 18 et enregistrer :

{{modif b1.1}}

```text
git add stats_trace.py
git commit -m "Correction : le deux-points de la boucle"
```

**Seconde erreur.** Relancer le programme. Python s'arrête sur une seconde erreur :

{{sortie b1.1 trace.csv}}

`TabError` signale un mélange d'espaces et de tabulations dans l'indentation d'un
même bloc. La ligne 20 commence par deux flèches (deux tabulations), et la ligne 19
par des points (des espaces). Effacer les flèches, puis les remplacer par huit
espaces :

{{modif b1.2}}

```text
git add stats_trace.py
git commit -m "Correction : l'indentation de la ligne 20"
```

## Solution de l'étape B2

**Déclarer l'option.** `add_argument` déclare `--distance` à la suite de `--seuil`,
avant `parse_args`. Les deux tirets disparaissent du nom de la valeur lue :
`--distance` donne `options.distance`.

{{modif b2.1}}

**Afficher le message.** Ajouter le bloc `if` à la fin du fichier. Il n'affiche le
message que si la commande contient l'option.

{{modif b2.2}}

## Solution de l'étape B3

**Créer les listes.** Les deux listes sont vides au départ, comme `altitudes`.

{{modif b3.1}}

**Remplir les listes.** Ajouter les deux lignes dans la boucle de lecture, au même
niveau d'indentation que `altitudes.append`. `float` convertit le texte lu en
nombre, comme pour `z`.

{{modif b3.2}}

**Contrôler les valeurs lues.** `len` donne le nombre d'éléments d'une liste, et
l'indice 0 désigne le premier élément. Ces deux affichages sont provisoires :
l'étape B4 les retire.

{{modif b3.3}}

## Solution de l'étape B4

**Importer le module.** Ajouter l'import en tête du fichier, avec les autres.

{{modif b4.1}}

**Écrire la fonction.** Écrire la fonction avant le code qui l'appelle. Les paramètres
`x1`, `y1`, `x2` et `y2` reçoivent les quatre nombres donnés à l'appel, et `return`
renvoie la distance à l'endroit de l'appel.

{{modif b4.2}}

**Essayer la fonction.** Le premier affichage appelle la fonction sur un triangle
dont l'hypoténuse est connue : un résultat différent de `5.0` désigne une erreur dans
la formule. Le second l'appelle sur les deux premières positions de la trace, avec
`liste_x[0]`, `liste_y[0]`, `liste_x[1]` et `liste_y[1]`, et la variable
`premier_segment` reçoit la valeur renvoyée. Ces trois lignes remplacent les affichages
de l'étape B3.

{{modif b4.3}}

## Solution de l'étape B5

**Écrire la fonction, avec un affichage provisoire.** Le total part de 0. La boucle
commence à `i = 1`, parce que la position 0 n'a pas de position précédente, et
s'arrête à la dernière position. La variable `segment` reçoit la distance entre la
position `i - 1` et la position `i`. Le `print` de la boucle montre le total après
chaque segment. La ligne `return` est au niveau de `for`, hors de la boucle : indentée
dans la boucle, elle arrêterait la fonction après le premier segment.

{{modif b5.1}}

**Afficher le résultat final.** Remplacer les affichages de l'étape B4 et le message
`distance : calcul manquant` par l'appel de la fonction et l'affichage du résultat.

{{modif b5.2}}

Le premier test montre le total après chaque segment :

{{extrait b5.2 trace.csv --distance}}

**Retirer l'affichage provisoire.** Une fois les valeurs contrôlées, supprimer le
`print` de la boucle.

{{modif b5.3}}

## Solution de l'étape B6

**Déclarer l'option.** Déclarer `--vitesse` comme `--distance`.

{{modif b6.1}}

**Afficher le message.** Ajouter un second bloc `if` à la fin du fichier. Les deux blocs
sont séparés, pour que chaque option fonctionne sans l'autre.

{{modif b6.2}}

**Créer la liste des durées.** Créer `durees` à côté des deux listes de l'étape B3.

{{modif b6.3}}

**Remplir la liste.** Ajouter la ligne dans la boucle de lecture. La variable `duree`
existe depuis le TD 3a, sans avoir servi jusqu'ici.

{{modif b6.4}}

**Calculer le temps total.** `durees[-1]` désigne la dernière durée, et `durees[0]`
la première. Le format `:.0f` affiche le nombre sans chiffre après la virgule.

{{modif b6.5}}

**Écrire la fonction.** Elle divise la distance par le temps.

{{modif b6.6}}

**Afficher le résultat final.** Le bloc appelle `distance_parcourue` sans recopier sa
boucle, puis passe le résultat à `vitesse_moyenne`. `vitesse * 3.6` convertit la
vitesse en km/h pour l'affichage.

{{modif b6.7}}

## Solution de l'étape B7

`..` désigne le dossier parent : `../../` remonte de `travail/stats_trace/` à
`4a_trace/`. Le `.` final désigne le dossier courant.

```text
cp ../../depart/modeles/README.md .
```

Après avoir complété le README, faire le commit, puis poser l'étiquette. Une étiquette
git, un _tag_, nomme un commit : `v1.0` désigne la version finale sans chercher son
identifiant.

```text
git add README.md
git commit -m "Un README"
git tag -a v1.0 -m "Première version"
git log --oneline
```

## Le programme à la fin du TD

{{programme b6}}
