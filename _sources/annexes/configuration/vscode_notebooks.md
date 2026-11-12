---
title: Notebooks
subtitle: Extension Jupyter, choix du noyau
---

Le notebook et son noyau sont expliqués dans [Les
notebooks](../notions/notebooks.md). Cette page suppose l'extension Python installée
et l'interpréteur choisi ([Python et environnement conda](vscode_python.md)).

## Installer l'extension Jupyter

1. Ouvrir le panneau Extensions : `Ctrl` + `Maj` + `X`.
2. Taper `jupyter` dans la zone de recherche.
3. Choisir « Jupyter », de Microsoft.
4. Cliquer sur Install.

L'extension ajoute à VS Code le choix du noyau et l'exécution des cellules.

## Choisir le noyau

1. Ouvrir un fichier `.ipynb` du TD.
2. En haut à droite, cliquer sur le bouton « Select Kernel ». Le premier niveau
   de la liste ne montre que les noyaux déjà employés.
3. Choisir « Select Another Kernel… », s'il est proposé, puis « Python
   Environments… ».
4. Choisir `base`, ou l'environnement du TD. Le nom choisi s'affiche à la place
   du bouton. Si l'environnement n'est pas dans la liste : {ref}`J1 <dep-j1>`.

La liste est celle de l'extension Python, et l'interpréteur choisi pour
le dossier y est en tête : avec `python.defaultInterpreterPath` sur `base`
([Fichiers de réglages](vscode_reglages.md)), l'extension propose `base`.
Sur les postes de la salle, `base` contient déjà `ipykernel`, le
paquet qui fait d'un environnement un noyau ; la première cellule
s'exécute sans installation.

Le noyau se choisit à part de l'interpréteur des fichiers `.py` et du
terminal. Les trois peuvent différer, ce qui explique le plus souvent un
`import` qui fonctionne dans l'un et échoue dans l'autre ({ref}`J4 <dep-j4>`).

## Vérifier

1. Exécuter une cellule contenant `import sys; print(sys.executable)` (`Maj` +
   `Entrée`). Le chemin d'Anaconda s'affiche, le même que dans l'invite de
   commandes d'Anaconda. Si un message demande `ipykernel` : {ref}`J2 <dep-j2>`.
   Si le chemin diffère : {ref}`J4 <dep-j4>`.
2. Bouton Restart, puis Run All. Toutes les cellules s'exécutent, dans l'ordre,
   sans erreur. Si le noyau ne démarre pas : {ref}`J3 <dep-j3>`.

## Un noyau dans son propre environnement

Un environnement créé au TD 1h n'a de noyau que si le paquet `ipykernel` y
est installé. VS Code le propose au premier lancement ({ref}`J2 <dep-j2>`).
Sinon, taper dans l'invite de commandes d'Anaconda :

```
conda install -n recette -c conda-forge ipykernel
```

Puis rouvrir la liste des noyaux.
