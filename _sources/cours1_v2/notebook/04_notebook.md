---
title: Un notebook et la syntaxe de Markdown
subtitle: Texte, code et résultats dans un même document, ouvert dans JupyterLab
---

Un notebook réunit dans un seul document du texte, du code et le résultat de
ce code. Il sert à explorer des données et à expliquer une démarche. Cette
page montre comment l'ouvrir dans JupyterLab, l'exécuter et le compléter par
du texte.

Le [TD 1d](td/1d_notebook/guide.md) fait lancer JupyterLab, exécuter les
cellules d'un notebook dans plusieurs ordres, puis ajouter une cellule de
texte écrite en Markdown.

## Programmation littérale

Dans un projet, le code est d'ordinaire dans un fichier, son explication dans
un autre, et son résultat n'est enregistré nulle part. Un **notebook**, ou
carnet, réunit les trois dans un seul document, dans l'ordre du
raisonnement : des blocs de texte, des blocs de code, et sous chaque bloc de
code le résultat de son exécution.

```{figure} figures/4_notebook_jupyterlab.svg
:alt: Capture de JupyterLab. À gauche, le panneau des fichiers contient trajet.ipynb. À droite, le notebook trajet.ipynb. En haut à droite, le nom du noyau, Python 3 (ipykernel), porte l'étiquette « le noyau, qui exécute le code ». Une cellule de texte, étiquetée « du texte, écrit en Markdown », contient le titre « Longueur d'un trajet » et une phrase sur les coordonnées projetées. Dessous, une cellule de code, étiquetée « une cellule de code », calcule avec numpy les longueurs des segments d'un trajet ; son numéro [1] porte l'étiquette « ordre d'exécution ». Sa sortie, étiquetée « sa sortie, gardée dans le fichier », affiche [500. 600. 800.] puis longueur totale : 1900.0 m. En bas, une phrase étiquetée « du texte qui commente le résultat » indique que le premier segment mesure 500 m.

Un notebook ouvert dans JupyterLab, avec deux cellules de texte, une cellule
de code et sa sortie.
```

**JupyterLab** affiche et exécute des notebooks dans un onglet du
navigateur. Le **noyau**, un programme Python lancé par JupyterLab, exécute
les cellules de code et garde leurs variables d'une cellule à l'autre. Son
nom est affiché en haut à droite, par exemple `Python 3 (ipykernel)`.

Le panneau de gauche de JupyterLab montre les fichiers du dossier ouvert. Un
notebook est un fichier d'extension `.ipynb`, enregistré dans un dossier comme
les autres fichiers.

L'idée d'écrire un programme comme un texte explicatif, dans lequel le code
s'insère à l'endroit où il est expliqué, est due à Donald Knuth, qui l'a
nommée **programmation littérale** (*literate programming*) en 1984.

- Le résultat de chaque bloc de code est **enregistré** dans le fichier du
  notebook : rouvert le lendemain, il affiche encore ce que le code a
  produit, sans être exécuté de nouveau.
- Le fichier `.ipynb` est un fichier texte au format JSON, qui contient
  chaque cellule, avec son type, son texte et sa sortie.

Le notebook sert à explorer des données et à expliquer une démarche. Le code
d'un outil qui doit s'exécuter seul, du début à la fin, s'écrit dans un
script `.py`, au cours 3.

## Lancer JupyterLab

JupyterLab est installé avec Anaconda, et se lance dans un terminal où conda
est actif, l'invite de commandes d'Anaconda ou Git Bash. L'invite de
commandes d'Anaconda n'a besoin d'aucun réglage, et reste disponible si le
réglage de Git Bash manque sur un ordinateur.

::::{grid} 1 1 2 2

:::{grid-item}
**Depuis l'invite de commandes d'Anaconda**, à essayer d'abord : menu
Démarrer, « Anaconda Prompt ». conda y est actif sans réglage.

```text
(base) …>cd Desktop\info01\cours1\1d_notebook
(base) …>jupyter lab
```
:::

:::{grid-item}
**Depuis Git Bash**, le terminal du module, après le réglage du TD 1c.

```text
$ cd ~/Desktop/info01/cours1/1d_notebook
$ jupyter lab
```
:::

::::

- Le navigateur s'ouvre sur `localhost:8888`, le poste lui-même : le serveur
  de JupyterLab tourne sur le poste.
- Le terminal reste occupé tant que JupyterLab tourne. `Ctrl` + `C` dans le
  terminal l'arrête.
- Le panneau de gauche de JupyterLab montre le dossier dans lequel
  `jupyter lab` a été lancé, et ce qu'il contient. Il faut donc se placer
  dans le dossier du TD avant de taper `jupyter lab`.
- Anaconda Navigator reste un dernier recours : page d'accueil, fiche
  JupyterLab, bouton *Launch*. Navigator peut mettre plusieurs minutes à
  s'ouvrir.

Le cours 5 explique l'organisation en client et serveur d'un notebook.

## Exécution des cellules

Une cellule de code s'exécute avec `Maj` + `Entrée`, après un clic dans la
cellule. Sa sortie s'affiche dessous.

Le numéro entre crochets, `[1]`, est le **rang d'exécution** de la cellule,
qui peut différer de sa place dans le document. Une cellule exécutée une seconde fois
prend le numéro suivant. Des numéros qui ne se suivent pas du haut vers le
bas indiquent que les cellules ont été exécutées dans le désordre.

Dans `altitudes.ipynb`, le notebook du TD 1d, une boucle ajoute chaque
altitude à la variable `total`. Exécuter une seconde fois la cellule de la boucle, puis celle de la
moyenne, donne `187.4` au lieu de `93.7`, car le noyau a gardé la valeur de
`total`, et la boucle l'a augmentée une seconde fois.

:::{warning}
Les cellules peuvent être exécutées dans n'importe quel ordre, et une cellule
modifiée mais non exécutée n'a aucun effet. Un notebook qui donne le bon
résultat sur le poste de son auteur peut en donner un autre, exécuté du
début à la fin sur un autre poste. Avant de le partager, l'exécuter en
entier depuis le début : menu *Kernel*, *Restart Kernel and Run All
Cells*.
:::

## La syntaxe minimale de Markdown

Une cellule de texte s'écrit en **Markdown** : du texte brut, où quelques
signes indiquent la mise en forme.

```{list-table}
:header-rows: 1

* - Ce qu'on tape
  - Ce qui s'affiche
* - `# Altitudes`, `## Les données`
  - un titre, puis un sous-titre plus petit
* - deux lignes séparées par une ligne vide
  - deux paragraphes
* - `du *texte* en **gras**`
  - du *texte* en **gras**
* - `- une puce`
  - une liste à puces
* - `1. une étape`
  - une liste numérotée
* - `[le site](https://jupyter.org)`
  - [le site](https://jupyter.org), un lien
* - ``la variable `total` ``
  - la variable `total`, en police de code
```

:::{warning}
Deux lignes consécutives, sans ligne vide entre elles, ne font qu'un seul
paragraphe. Le dièse d'un titre est suivi d'une espace : `# Titre` produit un
titre, et `#Titre` n'en produit pas.
:::

Le texte tapé reste lisible sans être mis en forme, selon l'intention de
John Gruber, qui a publié Markdown en 2004. Le TD 2c emploie cette syntaxe pour
écrire un README.

Pour transformer une cellule en cellule de texte dans JupyterLab, appuyer sur
`Échap`, puis sur `M`, ou choisir « Markdown » dans la liste en haut de la
page. `Maj` + `Entrée` affiche la cellule mise en forme, et un double-clic revient
au texte tapé. Une cellule de texte n'a pas de numéro `[1]` : aucun programme
ne l'exécute.

## TD de la partie

- [TD 1d — Un notebook dans JupyterLab](td/1d_notebook/guide.md), 12
  minutes :
  - lancer JupyterLab depuis l'invite de commandes d'Anaconda, et ouvrir
    `altitudes.ipynb` ;
  - exécuter les cellules dans plusieurs ordres, et déterminer ce que le
    noyau garde d'une cellule à l'autre ;
  - ajouter en tête du notebook une cellule de texte, écrite en Markdown ;
  - si le temps le permet, relancer JupyterLab depuis Git Bash.

Les TD des autres parties sont dans [Travaux dirigés de la séance
1](travaux_diriges.md).
