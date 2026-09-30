# recette — une recette Markdown mise à l'échelle

Le programme lit une recette écrite en Markdown et un tableau d'ingrédients
donné **pour une personne, en unités SI**. Il multiplie les quantités par le
nombre de convives, les convertit si on le lui demande, insère le tableau à
l'endroit où la recette annonce ses ingrédients, et écrit une page HTML.

```
recette/
├── pyproject.toml      ce qu'est le projet, et ce dont il dépend
├── README.md           ce fichier
├── data/               ce que le programme lit, et sa feuille de style
│   ├── ingredients.csv     les quantités pour une personne, en unités SI
│   ├── recette.md          la recette, sans son tableau d'ingrédients
│   └── style.css           la présentation de la page produite
├── src/recette/        le code, en trois modules
│   ├── __init__.py         ce qui fait de `recette/` un paquet
│   ├── calculs.py          lire, mettre à l'échelle, convertir
│   ├── tableau.py          le tableau Markdown, et le gabarit de la page
│   └── __main__.py         le programme en ligne de commande
├── recette_a_la_main.py     le programme, avec le `tabulate` du projet
└── recette_avec_tabulate.py le même, avec celui de la bibliothèque
```

`recette.html` et `src/recette.egg-info/` ne sont pas versionnés : le premier
est ce que le programme écrit, le second ce que l'installation dépose.

Il manque à ce projet deux choses que le TD demande d'écrire : un
`environment.yml`, et la section « Installation » de ce fichier.

## Trois façons de s'en servir

| Ce qu'on tape | Comment on change les valeurs |
|---|---|
| `python recette_a_la_main.py` | en ouvrant le fichier et en modifiant `PERSONNES` et `UNITES` |
| `python recette_avec_tabulate.py` | de même |
| `python -m recette --personnes 12` | en les donnant au lancement |

Les deux premiers ne diffèrent que par une ligne : l'un importe `tabulate` de
`recette.tableau`, où la fonction est écrite en cinq lignes, l'autre de la
bibliothèque `tabulate`. Même nom, même appel, même sortie — c'est le plus
court exemple de ce qu'on gagne et de ce qu'on paie à installer une
dépendance.

Une fois le projet installé, `python -m recette` s'écrit aussi `recette`.
`recette --help` dit ce que la commande accepte.

## Ce que fait chaque module

Un ingrédient est un triplet : son nom, sa quantité, son unité. Une recette
est la liste de ses ingrédients. `calculs.py` ne touche qu'à ça :

| Fonction | Ce qu'elle fait |
|---|---|
| `lire_ingredients` | lit le CSV et rend des nombres, pas du texte |
| `adapter` | met à l'échelle et convertit, en une passe |
| `convertir` | une quantité et son unité, en onces ou en cups |
| `en_table` | rend les lignes du tableau, quantités écrites |

`tableau.py` porte ce qui met en forme : `tabulate`, qui écrit les barres
verticales du tableau Markdown, et `GABARIT`, l'enveloppe HTML qui donne à la
page son titre et sa feuille de style.

Les trois programmes appellent ces fonctions dans le même ordre, puis posent
le tableau sous le titre « Ingrédients » et convertissent le tout en HTML.
Leur corps tient en une dizaine de lignes, qui se lisent de haut en bas.

Les unités qui se comptent, les œufs, n'ont pas d'équivalent américain :
elles traversent la conversion inchangées, faute d'entrée dans la table.

## Ce qui est demandé

Trois ajouts, dans cet ordre.

1. **`environment.yml`**, à la racine du projet, décrivant l'environnement
   conda dans lequel le code tourne.
2. **La section « Installation » de ce README** : les commandes à taper, dans
   l'ordre, depuis un poste où rien n'est encore installé. La dernière étape
   du TD consiste à les suivre sur un environnement effacé, ce qui est le seul
   moyen de savoir si elles sont complètes.
3. **La documentation de `recette_avec_tabulate.py`.** `recette_a_la_main.py`
   porte en tête une chaîne qui dit ce que le programme fait, comment on le
   lance, et ce qui le distingue de l'autre ; le second n'en a pas. Écrivez-la
   sur le même modèle.

Si le temps le permet, **une section « Exemples »** avec trois lignes de
commande et ce qu'elles produisent : une recette pour deux, une pour douze en
unités américaines, et une page écrite ailleurs que dans le dossier du projet.
Les commandes que vous écrivez doivent avoir été lancées : un exemple qui ne
marche pas est pire que pas d'exemple.

## Pourquoi ces conversions sont écrites à la main

Des bibliothèques savent convertir des unités (`pint` est la plus employée),
et quelques paquets visent la cuisine en particulier, sans être maintenus.
Deux facteurs et un dictionnaire suffisent ici, et le sujet de la séance est
justement de savoir quand une bibliothèque vaut la peine d'être installée :
elle le vaut pour convertir du Markdown en HTML, huit mille lignes, pas pour
diviser par 28,3495.
