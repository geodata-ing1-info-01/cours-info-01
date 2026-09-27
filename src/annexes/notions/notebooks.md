---
title: Les notebooks
subtitle: Le fichier .ipynb, le noyau et le client, et les outils qui ouvrent un notebook
---

Cette page réunit ce qu'il faut savoir d'un notebook pour choisir un outil
et comprendre ses messages. Les notebooks sont enseignés dans les séances.
La page [Le client et le noyau d'un
notebook](../../cours4/notebook/01_client_noyau.md) du cours 4 les reprend
avec des TD.

## Le fichier d'un notebook

Un notebook réunit dans un seul document des blocs de texte, des blocs de
code, et sous chaque bloc de code le résultat de son exécution. Ces blocs
s'appellent des cellules. Les cellules de texte s'écrivent en Markdown.

```{figure} ../../cours1/notebook/figures/3_notebook.svg
:alt: Un document nommé trajet.ipynb, fait de blocs empilés. En haut, un bloc de texte, étiqueté « texte », avec le titre « Longueur du trajet » et deux lignes de texte. Dessous, un bloc étiqueté « code », numéroté [1], qui contient trois lignes Python : import numpy as np, points = np.loadtxt("trajet.csv"), print(points.shape). Dessous, un bloc étiqueté « résultat », numéroté [1], qui affiche (128, 2). En bas, un bloc en pointillé indique que le document continue.

Les trois sortes de blocs d'un notebook, dans l'ordre où ils sont écrits
(schéma du cours 1).
```

Le fichier porte l'extension `.ipynb`. Il est écrit au format JSON, un
format de texte, et contient la liste des cellules. Pour chaque cellule de code, il
enregistre le code, le numéro de sa dernière exécution et ses résultats.
Un éditeur de texte montre ce JSON. Un client de notebooks le met en forme.

Le mot anglais *notebook* est gardé dans le module, parce que les logiciels
l'affichent : la fiche « Notebook » de Navigator, le lanceur de JupyterLab,
« Jupyter Notebook » dans VS Code. On rencontre aussi le mot « carnet »
dans des textes en français. Avec une majuscule, Notebook désigne une
application, le client de notebooks le plus ancien du projet Jupyter.

## Le noyau et le client

Pour travailler avec un notebook, il faut deux choses : un noyau
(*kernel*), côté serveur, qui exécute le code des cellules, et un client,
qui affiche le document et lui envoie les cellules.

- Le noyau. Pour un notebook Python, c'est un interpréteur Python : celui
  de `base` (Anaconda), ou celui d'un autre environnement. Le paquet qui
  fait d'un Python un noyau s'appelle `ipykernel` ; `base` l'a.
- Le client. Soit JupyterLab, livré avec Anaconda, qui s'affiche dans le
  navigateur ; soit un autre client, comme VS Code avec l'extension
  Jupyter.

```{figure} ../schemas/client_serveur.svg
:alt: Sur la machine, un client (JupyterLab dans le navigateur, ou VS Code) envoie la cellule à exécuter à un serveur (jupyter-server et ipykernel) qui renvoie le résultat
:width: 100%

Le client et le serveur d'un notebook, tous deux sur le poste (schéma du
cours 1).
```

## Ce que le noyau garde en mémoire

Le noyau est un processus Python qui garde les variables en mémoire entre
deux cellules. Le redémarrer les efface toutes. L'ordre d'exécution des
cellules est celui des compteurs `[1]`, `[2]`, qui peut différer de l'ordre
de la page. Le noyau garde aussi en mémoire ce que des cellules effacées
ont défini. Quand une valeur change dans une cellule, il faut relancer dans
l'ordre les cellules qui en dépendent.

```{figure} ../../cours3/notebook/figures/3_notebook_valeurs.svg
:alt: Un notebook dont la cellule des valeurs est modifiée : les cellules qui en dépendent sont à relancer.

Dans un notebook, une valeur modifiée demande de relancer les cellules qui
en dépendent (schéma du cours 3).
```

Avant de rendre ou de partager un notebook, on le réexécute en entier, de
haut en bas : redémarrer le noyau (Restart), puis tout exécuter (Run All).

## Les outils qui ouvrent un notebook

Les postes de la salle ont trois clients de notebooks : JupyterLab et
Notebook, les deux fiches de Navigator décrites dans la page
[JupyterLab](../configuration/jupyterlab.md), et VS Code avec l'extension
Jupyter.

VS Code ouvre le même fichier, mais sans serveur : il démarre `ipykernel`
lui-même, dans l'environnement choisi comme noyau. Un environnement
employé comme noyau dans VS Code a donc seulement besoin d'`ipykernel`,
sans `jupyterlab`.

```{figure} ../schemas/deux_clients.svg
:alt: À gauche, JupyterLab dans le navigateur passe par jupyter-server pour parler à ipykernel ; à droite, VS Code démarre ipykernel directement, sans serveur
:width: 100%

Deux clients, le même noyau (schéma du cours 1).
```

La configuration des notebooks dans VS Code est dans [VS Code :
notebooks](../configuration/vscode_notebooks.md). Spyder n'est pas un
client de notebooks : il affiche le JSON du fichier, et la page
[Spyder](../configuration/spyder.md) donne deux façons de l'exécuter
quand même.

## Notebook ou fichier Python

Un notebook garde les résultats avec le code, et se lit de haut en bas. Un
fichier `.py` s'exécute du début à la fin, et donne le même résultat à
chaque exécution. Il convient donc à un programme qu'on donne à quelqu'un
d'autre, ou qu'on relance un mois plus tard.

Dans le module, on explore dans un notebook ou dans la console de Spyder,
puis on place le code dans un fichier `.py` une fois qu'il est au point. La
partie [Du notebook au
programme](../../cours3/notebook/03_du_notebook_au_programme.md) du cours 3
montre ce passage.
