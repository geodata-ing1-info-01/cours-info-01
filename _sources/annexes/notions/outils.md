---
title: Choisir entre JupyterLab, Spyder et VS Code
subtitle: Ce que fait chaque outil, et l'outil à employer pour chaque tâche
---

Les postes de la salle ont trois outils pour écrire et exécuter du Python :
JupyterLab, Spyder et VS Code. Chacun a sa fiche dans Anaconda Navigator,
et se lance par son bouton Launch.

```{figure} ../configuration/navigator_accueil.svg
:alt: La page d'accueil d'Anaconda Navigator, avec une fiche par application, dont JupyterLab, Spyder et VS Code
:width: 100%

Les fiches de JupyterLab, Spyder et VS Code dans Anaconda Navigator.
```

Les trois outils exécutent le même Python, celui de l'environnement choisi.
Un fichier `.py` écrit dans l'un s'exécute dans les deux autres, et un
notebook `.ipynb` s'ouvre dans JupyterLab et dans VS Code. L'outil se
choisit donc d'après la tâche.

Le module emploie JupyterLab et VS Code. D'autres cours emploient Spyder.

## Ce que fait chaque outil

JupyterLab
: Un client de notebooks, affiché dans le navigateur. Un notebook réunit du
  texte, des cellules de code et leurs résultats dans un même fichier.
  JupyterLab fonctionne sur les postes sans réglage. Il est décrit dans la
  page [JupyterLab](../configuration/jupyterlab.md).

Spyder
: Un éditeur de code pour Python seulement. Sa fenêtre réunit l'éditeur,
  une console interactive, un explorateur de variables et un volet de
  figures. Il exécute un fichier `.py` en entier avec `F5`, ou cellule par
  cellule quand le fichier est découpé par des lignes `# %%`. Spyder
  fonctionne sur les postes sans réglage. Il est décrit dans la page
  [Spyder](../configuration/spyder.md).

VS Code
: Un éditeur de code pour tous les langages. La prise en charge de chaque
  langage s'installe par une extension. Sa fenêtre réunit l'explorateur des
  fichiers du dossier ouvert, l'éditeur, un terminal et les commandes de
  git. Il ouvre les fichiers `.py` et les notebooks `.ipynb`. Sur les
  postes, il faut installer les extensions Python et Jupyter et régler le
  terminal avant de s'en servir, comme l'indique la page [VS
  Code](../../avant/vscode.md) des pages « Avant les séances ». Il est
  décrit dans la page [VS Code](../configuration/vscode.md).

Un même notebook s'ouvre dans JupyterLab et dans VS Code, parce que les
deux outils démarrent le même noyau. La page [Les notebooks](notebooks.md)
l'explique.

## Quel outil pour quelle tâche

| Tâche | Outil | Raison |
|---|---|---|
| Suivre un cours et exécuter ses exemples un à un | un notebook, dans JupyterLab ou dans VS Code | le texte, le code et les résultats sont dans le même fichier, dans l'ordre de lecture |
| Explorer des données, essayer une bibliothèque | un notebook, ou la console de Spyder | chaque essai s'exécute à part, et son résultat s'affiche aussitôt |
| Écrire un programme de calcul, et regarder ses variables et ses figures | Spyder | après `F5`, l'explorateur de variables et le volet de figures montrent l'état du programme |
| Écrire un programme de plusieurs fichiers, suivi avec git | VS Code | l'explorateur des fichiers, le terminal et git sont dans la même fenêtre |
| Écrire dans un autre langage que Python (C++, R, JavaScript…) | VS Code | chaque langage s'ajoute au même éditeur par une extension, comme le montre la page [C++](../plus_loin/cpp.md) |
| Rédiger un fichier Markdown, comme un README | VS Code ou JupyterLab | les deux affichent un aperçu du texte mis en forme à côté du fichier |

Le module emploie VS Code parce qu'il sert aux projets suivis avec git et
aux autres langages que les élèves rencontrent dans d'autres cours. Les
élèves n'apprennent ainsi qu'un éditeur pour tous ces usages.

## Ce que chaque outil ouvre

| | JupyterLab | Spyder | VS Code |
|---|---|---|---|
| Fichiers `.py` | éditeur simple, exécution dans un terminal de JupyterLab | exécution par `F5`, ou par cellules `# %%` | exécution avec l'extension Python |
| Notebooks `.ipynb` | ouverture et exécution | conversion en fichier `.py`, ou plugin `spyder-notebook` | ouverture et exécution avec l'extension Jupyter |
| Autres langages | par un autre noyau (R, Julia), hors module | aucun | une extension par langage |

Chaque outil choisit l'environnement conda d'une façon différente. La page
de chacun le décrit : [JupyterLab](../configuration/jupyterlab.md),
[Spyder](../configuration/spyder.md), et [VS Code : Python et environnement
conda](../configuration/vscode_python.md).

## Notebook ou fichier Python

Le choix entre un notebook et un fichier `.py` est traité dans la page
[Les notebooks](notebooks.md).
