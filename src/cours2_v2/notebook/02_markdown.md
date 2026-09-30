---
title: Une recette en Markdown
subtitle: Un format texte pour les documents d'un projet, converti par pandoc
---

Cette partie présente Markdown comme le format des documents d'un projet :
un fichier texte, écrit dans l'éditeur de code, que git compare ligne à
ligne. Elle complète la syntaxe vue au cours 1 dans les cellules d'un
notebook, puis présente la conversion d'un fichier Markdown par pandoc. Le
[TD 2c](td/2c_markdown/guide.md) l'accompagne ; il est présenté en fin de
page.

## Un format texte pour les documents

Un fichier **Markdown**, d'extension `.md`, est du **texte brut**, comme un
programme. Quelques signes y portent la mise en forme : `#` pour un titre,
`1.` pour une étape, `|` pour les colonnes d'un tableau.

::::{grid} 1 1 2 2
:::{grid-item}
**Ce qu'on écrit**, `recette.md`

```markdown
## Ingrédients

| Ingrédient | Quantité |
|---|---|
| Farine | 250 g |
| Œufs | 4 |

## Préparation

1. Mélanger la farine et le sel.
2. Casser les œufs.
```
:::
:::{grid-item}
**Ce que l'aperçu montre**

**Ingrédients**

| Ingrédient | Quantité |
|---|---|
| Farine | 250 g |
| Œufs | 4 |

**Préparation**

1. Mélanger la farine et le sel.
2. Casser les œufs.
:::
::::

La recette écrite en Markdown au TD 2c devient le premier projet versionné
par git, au TD 2d. Ce format convient pour trois raisons :

- il s'écrit dans l’**éditeur de code**, comme un programme ;
- **git compare ses lignes**, et `git diff` montre la ligne modifiée ;
- ses modifications se comprennent **sans programmer** : une quantité, une
  étape, un conseil. Un fichier modifié reste utilisable, et aucun
  programme ne s'arrête sur une erreur.

Un document LibreOffice (`.odt`) a une mise en forme, mais git ne compare
pas son contenu ligne à ligne : il indique seulement que le fichier a
changé.

:::{note}
Markdown a été publié par John Gruber le 15 mars 2004. Son intention : un
format facile à lire et à écrire, convertible en HTML, et lisible tel quel
sans avoir l'air balisé. Depuis 2014, CommonMark en fixe une spécification.
:::

## Le tableau et l'image

La syntaxe vue au cours 1 (titres, paragraphes, listes, gras, liens) sert
toujours. Le TD 2c y ajoute le tableau et l'image.

```{list-table}
:header-rows: 1

* - Ce qu'on tape
  - Ce qui s'affiche
* - `| Ingrédient | Quantité |`, puis `|---|---|`, puis une ligne
    `| Farine | 250 g |` par ingrédient
  - un tableau à deux colonnes, avec une ligne d'en-tête
* - `![Une crêpe qui cuit.](crepes.jpg)`
  - la photo `crepes.jpg`, avec sa légende comme texte de remplacement
```

Dans un tableau, les barres verticales n'ont pas besoin d'être alignées ; la
ligne `|---|---|` sépare l'en-tête du reste.

:::{warning}
L'image n'est pas dans le fichier `.md` : il en donne le **chemin**, relatif
au fichier. La photo doit rester à côté du `.md`, sinon l'aperçu et la page
produite affichent seulement la légende.
:::

VS Code affiche l'aperçu d'un fichier Markdown sans extension à installer :

- `Ctrl` + `K`, puis `V` : l'aperçu à droite, le fichier à gauche ;
- `Ctrl` + `Maj` + `V` : l'aperçu seul, dans un onglet.

L'aperçu ne change rien au fichier : ce qui est enregistré reste le texte
tapé.

## Convertir un fichier Markdown : pandoc

**pandoc** lit un fichier Markdown et écrit le même contenu dans un autre
format. L'option `-o`, pour *output*, donne le fichier à écrire, et pandoc
déduit le format de son extension.

```{list-table}
:header-rows: 1

* - Commande
  - Produit
  - S'ouvre avec
* - `pandoc recette.md -o recette.html`
  - une page web
  - le navigateur
* - `pandoc recette.md -o recette.odt`
  - un document
  - LibreOffice Writer
```

pandoc est installé avec Anaconda, dans l'environnement `base`. Il
n'affiche rien quand la conversion réussit. Dans Git Bash, `start
recette.html` ouvre la page, comme un double-clic.

Le fichier `.md` est la **source** ; la page et le document sont des
**fichiers produits**, qui se refont depuis elle par la même commande. Le
TD 2d en tire une règle de git : la source se versionne, les fichiers
produits ne se versionnent pas.

:::{note}
Un PDF demande en plus un moteur de mise en page, LaTeX ou typst, qui n'est
pas installé sur les postes. Le cours 3 lance pandoc depuis un programme
Python.
:::

Le **README** d'un projet, `README.md`, s'écrit de la même façon. La forge
l'affiche en page d'accueil du dépôt (cours 6), et le cours 3 en donne le
plan.

## TD de la partie

- [TD 2c — Une recette en Markdown, convertie par
  pandoc](td/2c_markdown/guide.md), 12 minutes : mettre en forme un texte
  brut en Markdown, avec l'aperçu de VS Code, puis le convertir en page web
  et en document LibreOffice.

Les TD des autres parties sont dans [Travaux dirigés de la séance 2,
version 2](travaux_diriges.md).
