---
title: Choisir entre JupyterLab, Spyder et VS Code
subtitle: Trois outils pour le même Python, et la tâche qui convient à chacun
---

Les postes de la salle ont trois outils pour écrire et exécuter du Python :
JupyterLab, Spyder et VS Code. Les trois exécutent le même Python, celui de
l'environnement choisi. Un fichier `.py` écrit dans l'un s'exécute dans les
deux autres, et un notebook `.ipynb` s'ouvre dans JupyterLab et dans VS
Code. Le choix de l'outil ne change pas le langage ; il dépend de la tâche.

Le module emploie VS Code et JupyterLab ; d'autres cours emploient Spyder.

## Ce que chacun est

JupyterLab
: Un client de notebooks, affiché dans le navigateur. Un notebook mélange
  du texte, des cellules de code et leurs résultats, enregistrés dans le
  même fichier. Rien à configurer sur les postes.
  Page : [JupyterLab](jupyterlab.md).

Spyder
: Un éditeur de code pour Python, avec une console interactive, un
  explorateur de variables et un volet de figures. Il exécute un fichier
  `.py` en entier, ou par cellules. Il n'exécute que du Python. Rien à
  configurer sur les postes. Page : [Spyder](spyder.md).

VS Code
: Un éditeur de code pour tous les langages. Chaque langage s'ajoute par
  une extension ; le terminal et git sont dans la fenêtre. Il ouvre les
  fichiers `.py` et les notebooks `.ipynb`. À configurer sur les postes :
  c'est le TD 2a. Page : [VS Code](vscode.md).

## Quel outil pour quelle tâche

| Tâche | Outil | Ce qui le justifie |
|---|---|---|
| Suivre un cours, exécuter ses exemples un à un | un notebook, dans JupyterLab ou VS Code | le texte, le code et les résultats sont dans le même fichier, dans l'ordre de lecture |
| Explorer des données, essayer une bibliothèque | un notebook ; ou Spyder, avec sa console et l'explorateur de variables | on exécute par petits morceaux, on regarde le résultat, on corrige |
| Écrire un programme de calcul scientifique, regarder ses variables et ses figures | Spyder | le fichier reste un programme ; après `F5`, les variables et les figures sont dans les volets |
| Un programme de plusieurs fichiers, suivi avec git | VS Code | l'explorateur, le terminal, git et les extensions sont dans la même fenêtre |
| Un autre langage que Python (C++, R, JavaScript…) | VS Code | une extension par langage, et le même éditeur pour tous ; le TD 2c compile du C++ ainsi |
| Rédiger du Markdown, un README | VS Code, avec son aperçu ; JupyterLab aussi | |

Les deux dernières lignes sont la raison de choisir VS Code dans le module :
un seul éditeur à apprendre, qui sert ensuite pour chaque langage rencontré
dans les autres cours, sans reprendre en main un logiciel à chaque fois.

## Ce que chacun ouvre et exécute

| | JupyterLab | Spyder | VS Code |
|---|---|---|---|
| Fichiers `.py` | éditeur simple, exécution dans son terminal | oui : `F5`, ou par cellules `# %%` | oui, avec l'extension Python |
| Notebooks `.ipynb` | oui | par conversion en fichier `.py`, ou avec le plugin `spyder-notebook` | oui, avec l'extension Jupyter |
| Autres langages | avec un autre noyau (R, Julia), hors module | non | une extension par langage |
| Environnement conda | celui qui lance `jupyter lab`, ou un noyau `ipykernel` installé dans l'environnement | menu Consoles ou Préférences ; `spyder-kernels` installé dans l'environnement | interpréteur choisi dans la barre d'état ; pour un notebook, `ipykernel` dans l'environnement |
| Configuration sur les postes | aucune | aucune | extensions Python et Jupyter, interpréteur, terminal (TD 2a) |

## Notebook ou fichier Python

Un notebook garde les résultats avec le code, et se lit de haut en bas.
Mais ses cellules s'exécutent dans l'ordre où on les lance, et le noyau
garde en mémoire ce que des cellules effacées ont défini ; c'est le sujet
du TD 3b. Un fichier `.py` s'exécute du début à la fin, et donne le même
résultat à chaque fois : c'est la forme d'un programme qu'on donne à
quelqu'un d'autre, ou qu'on relance dans un mois.

D'où la règle suivie dans le module : explorer dans un notebook, ou dans la
console de Spyder ; quand le code est au point, le mettre dans un fichier
`.py`. Le passage de l'un à l'autre est le sujet de la dernière partie du
[cours 3](../../cours3/index.md).
