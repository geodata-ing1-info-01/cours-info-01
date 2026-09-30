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

Le programme du TD 1c, découpé en cellules. Rien de neuf dans le code : ce qui
change est qu'on peut l'arrêter au milieu, regarder une variable, et relancer
la suite sans refaire le début.

Exécuter une cellule : `Maj` + `Entrée`. Le numéro entre crochets à sa gauche
est l'ordre dans lequel elle a été exécutée, et non sa place dans la page.

Les blocs de texte sont du Markdown, celui du TD 1f, et acceptent en plus des
formules écrites en LaTeX.

## Les données

```{code-cell} ipython3
altitudes = [128.4, 131.0, 127.6]
altitudes
```

La dernière expression d'une cellule s'affiche sans `print`. C'est propre au
notebook, comme à la session interactive du TD 1c.

## La somme, un tour à la fois

```{code-cell} ipython3
total = 0
for altitude in altitudes:
    total = total + altitude
    print(total)
```

Les trois valeurs affichées sont celles que le débogueur montrait dans le
panneau Variables : 128,4 puis 259,4 puis 387,0.

## La moyenne

Un bloc de texte n'est pas limité au Markdown du TD 1f : ce qui est entre
dollars est lu comme une formule et rendu par MathJax, sans rien installer.
Entre deux dollars, elle est centrée sur sa propre ligne.

$$\bar{z} = \frac{1}{n}\sum_{i=1}^{n} z_i$$

Ici $n = 3$ et les $z_i$ sont les trois altitudes : la boucle ci-dessus a
calculé le $\sum z_i$, et il reste à diviser par $n$, que `len` donne.

```{code-cell} ipython3
moyenne = total / len(altitudes)
print(f"moyenne : {moyenne:.1f} m")
```

La formule et le code disent la même chose, et ni l'un ni l'autre ne remplace
l'autre : la première se lit, le second se vérifie. Un notebook les met sur la
même page, ce qu'un `.py` ne fait pas.

## Ce que le noyau retient

`total` existe encore, et vaut toujours ce que la boucle en a fait. Relancer la
cellule de la somme sans relancer celle des données ajouterait une seconde fois
les trois altitudes : le noyau ne repart pas de zéro entre deux exécutions.

```{code-cell} ipython3
total
```

:::{admonition} À faire
Relancez la cellule de la somme une seconde fois, sans toucher aux autres, et
lisez la valeur de `total`. Puis remettez la page d'aplomb :
**Noyau → Redémarrer et tout exécuter**.
:::
