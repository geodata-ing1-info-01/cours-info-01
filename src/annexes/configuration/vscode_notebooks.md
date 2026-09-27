---
title: Notebooks
subtitle: Extension Jupyter, choix du noyau
---

Ce qu'est un notebook et son noyau est expliqué dans [Les
notebooks](../notions/notebooks.md). Cette page suppose l'extension Python installée
et l'interpréteur choisi ([Python et environnement conda](vscode_python.md)).

## Installer l'extension Jupyter

Panneau Extensions (`Ctrl` + `Maj` + `X`), taper `jupyter` dans la zone
de recherche, choisir « Jupyter », de Microsoft (identifiant
`ms-toolsai.jupyter` dans le volet de droite), Install. Elle ajoute
l'affichage des fichiers `.ipynb` à VS Code.

## Choisir le noyau

Ouvrir un fichier `.ipynb` du TD. En haut à droite, le bouton « Select
Kernel » ouvre une liste. Le premier niveau ne montre que les noyaux déjà
employés ; les environnements sont sous « Select Another Kernel… », puis
« Python Environments… ». Choisir `base`, ou l'environnement du TD. Le nom
choisi s'affiche à la place du bouton. Si l'environnement n'est pas dans la
liste : {ref}`J1 <dep-j1>`.

La liste est celle de l'extension Python, et l'interpréteur choisi pour
le dossier y est en tête : avec `python.defaultInterpreterPath` sur `base`
([Fichiers de réglages](vscode_reglages.md)), c'est `base` qui est
proposé. Sur les postes de la salle, `base` contient déjà `ipykernel`, le
paquet qui fait d'un environnement un noyau ; la première cellule
s'exécute sans installation.

Le noyau se choisit à part de l'interpréteur des fichiers `.py` et du
terminal. Les trois peuvent différer, et c'est la cause la plus fréquente
d'un `import` qui marche dans l'un et pas dans l'autre ({ref}`J4 <dep-j4>`).

## Vérifier

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Exécuter une cellule contenant `import sys; print(sys.executable)` (`Maj` + `Entrée`) | le chemin d'Anaconda, le même que dans l'invite de commandes d'Anaconda | {ref}`J2 <dep-j2>`, {ref}`J4 <dep-j4>` |
| Bouton Restart, puis Run All | toutes les cellules s'exécutent, dans l'ordre, sans erreur | {ref}`J3 <dep-j3>` |

## Un noyau dans son propre environnement

Un environnement créé au TD 4a n'a de noyau que si le paquet `ipykernel` y
est installé. VS Code le propose au premier lancement ({ref}`J2 <dep-j2>`)
; sinon, dans l'invite de commandes d'Anaconda :

```
conda install -n recette -c conda-forge ipykernel
```

Puis rouvrir la liste des noyaux.
