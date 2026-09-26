---
title: "TD 2b — Écrire et lancer un programme"
subtitle: Guide détaillé, étape par étape (version 2, proposition)
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

*Version 2 du cours 1 : proposition de travail pour 2027-2028. Ce guide
reprend le programme et la session interactive du TD 2a de 2026, sans VS
Code : le programme s'ouvre dans Notepad++ et se lance dans Git Bash.*

Un programme Python est un fichier texte. Le TD l'ouvre dans un éditeur de
texte, Notepad++, et le fait exécuter par l'interpréteur Python depuis le
terminal du TD 2a, Git Bash. Il le modifie, le relance, puis refait son
calcul ligne à ligne dans une session interactive. Il dure une dizaine de
minutes.

| Étape | Ce qu'on fait |
|---|---|
| 1 | ouvrir `altitudes.py` dans Notepad++ |
| 2 | le lancer dans Git Bash |
| 3 | le modifier, et le relancer avant et après l'enregistrement |
| 4 | refaire le calcul dans une session interactive de Python |

Le TD suppose la fin du TD 2a faite : l'invite de Git Bash commence par
`(base)`, et `python --version` affiche une version.

![Notepad++ et Git Bash, côte à côte](illustrations/deux_fenetres.png)

## 1 · Ouvrir le programme dans Notepad++

> **À faire :** ouvrir `cours1\2b_programme\altitudes.py` dans Notepad++.
>
> **À obtenir :** le programme affiché, en couleur.

1. Lancer Notepad++ (menu Démarrer, « Notepad++ »).
2. Menu Fichier, Ouvrir…, aller dans `Bureau\info01\cours1\2b_programme`,
   et choisir `altitudes.py`.

Le fichier compte huit lignes : une chaîne de documentation, une ligne
vide, puis six lignes de code.

```python
"""Moyenne d'une série d'altitudes, à la main plutôt qu'avec sum()."""

altitudes = [128.4, 131.0, 127.6]
total = 0
for altitude in altitudes:
    total = total + altitude
moyenne = total / len(altitudes)
print(f"moyenne : {moyenne:.1f} m")
```

**À noter** : les couleurs, et le nom du langage affiché en bas à gauche
de la fenêtre de Notepad++.

## 2 · Lancer le programme dans Git Bash

> **À faire :** placer Git Bash dans `2b_programme/` ; `python altitudes.py`.
>
> **À obtenir :** `moyenne : 129.0 m`.

Dans Git Bash, ouvert au TD 2a dans `2a_terminal/` :

```text
cd ../2b_programme
ls
python altitudes.py
```

`ls` affiche `altitudes.py`. La commande `python altitudes.py` lance
l'interpréteur Python, qui lit le fichier et l'exécute :

```text
moyenne : 129.0 m
```

Le programme n'écrit qu'une ligne, celle du `print` final. La moyenne de
128,4, 131,0 et 127,6 vaut bien 129,0.

**Vérification** : `ls` après l'exécution affiche toujours le seul
`altitudes.py`. Lancer un programme Python ne crée aucun fichier.

Si Git Bash affiche `python: command not found`, la fin du TD 2a (étape 6)
n'est pas faite sur ce poste. Si Python affiche `can't open file … No such
file or directory`, le dossier courant n'est pas `2b_programme` : lire
l'invite, et refaire le `cd`.

## 3 · Modifier, relancer

> **À faire :** ajouter une altitude à la liste, relancer sans enregistrer, puis enregistrer et relancer.
>
> **À obtenir :** `moyenne : 130.1 m` après l'enregistrement.

1. Dans Notepad++, ajouter `133.2` à la liste :

   ```python
   altitudes = [128.4, 131.0, 127.6, 133.2]
   ```

   Ne pas enregistrer. L'onglet du fichier porte une disquette rouge : le
   fichier affiché diffère du fichier enregistré.

2. Dans Git Bash, relancer : flèche vers le haut, qui rappelle la commande
   précédente, puis `Entrée`.

   **À noter** : la moyenne affichée.

3. Dans Notepad++, enregistrer : `Ctrl` + `S`. La disquette redevient
   bleue.

4. Relancer dans Git Bash.

**Vérification** :

```text
moyenne : 130.1 m
```

La moyenne des quatre altitudes vaut 130,05, arrondie à une décimale par
`:.1f`.

## 4 · Python en interactif

> **À faire :** ouvrir une session interactive de Python ; y refaire le calcul ligne à ligne ; la quitter.
>
> **À obtenir :** `129.0` affiché par la session, puis le retour à l'invite de Git Bash.

Dans Git Bash, taper `python` sans nom de fichier : l'interpréteur ouvre une
session interactive. Chaque ligne tapée est lue, exécutée, et son résultat
affiché aussitôt.

```text
$ python
Python 3.12.14 (main, Sep  2 2026, 23:27:36) [GCC 15.3.0] on linux
>>> altitudes = [128.4, 131.0, 127.6]
>>> total = 0
>>> for altitude in altitudes:
...     total = total + altitude
...
>>> total
387.0
>>> total / len(altitudes)
129.0
>>> exit()
```

Session relevée sous Linux ; la première ligne, qui donne la version de
Python, diffère sur les postes de la salle.

Les trois chevrons `>>>` sont l'invite de Python : la session attend une
ligne de Python. Les commandes de Git Bash ne s'y tapent pas. Les trois points `...`
marquent la suite d'un bloc commencé, ici la boucle : taper quatre espaces
avant `total = total + altitude`, puis `Entrée` sur une ligne vide pour
finir le bloc. `total` s'affiche sans `print` : la session affiche la
valeur de chaque expression tapée.

`exit()` quitte la session ; l'invite de Git Bash revient.

**Vérification** : après `exit()`, la ligne attend une commande après `$`.

Si une commande de Git Bash, comme `ls`, est tapée dans la session Python,
Python affiche `NameError: name 'ls' is not defined`. Lire l'invite avant
de taper : `$` pour Git Bash, `>>>` pour Python.

## Ce que le TD fait constater

À lire après avoir fait les étapes.

**Un programme est un fichier texte.** Notepad++ affiche `altitudes.py`
comme les fichiers `.css` et `.html` du TD 1a : il reconnaît l'extension
`.py`, et colore le code Python. Les couleurs ne sont pas dans le
fichier. N'importe quel éditeur de texte sert à écrire un programme ; le
cours 2 installe un éditeur de code, qui ajoute d'autres services.

**L'interpréteur lit le fichier enregistré.** À l'étape 3, la moyenne ne
change pas tant que le fichier n'est pas enregistré : `python` lit le
fichier sur le disque. Le texte affiché par Notepad++ n'y est qu'une fois
enregistré.

**Un programme, une session.** Le programme lancé en entier n'affiche que
ce que ses `print` écrivent, et se relance à l'identique. La session
interactive affiche la valeur de chaque ligne, et ne garde rien sur le
disque. Un notebook, à la partie 3, réunit les deux : du code enregistré
dans un fichier, exécuté morceau par morceau, avec les résultats affichés.
