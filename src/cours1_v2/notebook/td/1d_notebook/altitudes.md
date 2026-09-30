---
title: Altitudes
subtitle: Le programme du TD 1c, cellule par cellule
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# Altitudes

Ce notebook reprend le programme `altitudes.py` du TD 1c, découpé en
cellules. Le code est le même ; chaque cellule s'exécute seule, et on peut
regarder une variable entre deux cellules.

Exécuter une cellule : `Maj` + `Entrée`. Le numéro entre crochets à sa gauche
est l'ordre dans lequel elle a été exécutée, et non sa place dans la page.

## Les données

```{code-cell} ipython3
altitudes = [128.4, 131.0, 127.6]
altitudes
```

La dernière expression d'une cellule s'affiche sans `print`, comme dans la
session interactive du TD 1c.

## La somme

La somme commence à zéro.

```{code-cell} ipython3
total = 0
```

La boucle ajoute chaque altitude à `total`, et affiche la somme à chaque
tour.

```{code-cell} ipython3
for altitude in altitudes:
    total = total + altitude
    print(total)
```

## La moyenne

```{code-cell} ipython3
moyenne = total / len(altitudes)
print(f"moyenne : {moyenne:.1f} m")
```

## Ce que le noyau retient

Le noyau garde les variables d'une cellule à l'autre, jusqu'à ce qu'il soit
redémarré. La cellule suivante affiche la valeur actuelle de `total`.

```{code-cell} ipython3
total
```

:::{admonition} À faire
Exécutez une seconde fois la cellule de la boucle, sans exécuter celle qui
met `total` à zéro, puis la cellule de la moyenne. Lisez les valeurs
affichées.

Pour revenir à un état où chaque cellule a été exécutée une fois, dans
l'ordre : menu **Kernel → Restart Kernel and Run All Cells**.
:::
