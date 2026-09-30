# Formatage en Markdown, et comparaison de versions — TD 1f, cours 1

Le dossier sert à deux TD : la mise en forme d'un texte brut en Markdown, à la
partie 3, et la comparaison de deux versions d'un même fichier, gardée en
annexe et jouée si l'horaire le permet.

| Dossier | Ce qu'il contient |
|---|---|
| `depart/` | les fichiers fournis, à ne pas modifier |
| `travail/` | vide : ce que vous écrivez |

| Fichier de `depart/` | Rôle |
|---|---|
| `recette_a_formater.txt` | le texte de départ, sans aucune structure |
| `ingredients.csv` | les ingrédients, à transformer en tableau |
| `recette.md` | le résultat attendu, à n'ouvrir qu'après avoir essayé |
| `crepes.jpg` | la photo que `recette.md` affiche (CC0, Wikimedia Commons) |
| `comparer.py` | compare deux versions d'un fichier texte, et applique le résultat ailleurs |

Ce que vous produisez va dans `travail/`, qui n'est pas versionné.

## Ce que le TD fait travailler

Le texte de départ n'a **aucune structure** : ni titre, ni liste, ni tableau.
C'est voulu. L'exercice n'est pas de recopier des marques, c'est de décider ce
qui est un titre, ce qui est une étape et ce qui est une donnée — la mise en
forme est une lecture du contenu.

1. Ouvrir `cours1/1f_markdown/` dans l'éditeur, puis
   `depart/recette_a_formater.txt`.
2. L'enregistrer sous `travail/recette.md`, et ouvrir l'aperçu côte à côte :
   `Ctrl` + `K` puis `V`.
3. Un titre en `#`, deux sous-titres en `##`.
4. Les étapes de préparation en liste numérotée.
5. Les ingrédients en tableau, depuis `depart/ingredients.csv`.
6. La photo, par `![légende](crepes.jpg)` — un chemin relatif, comme ceux de
   la partie 1, et le fichier est dans `depart/`.
7. L'ordre des opérations en bloc `mermaid`.

## Le tableau depuis le CSV

Il se tape à la main la première fois — l'intérêt est de constater qu'un
tableau Markdown n'est que des barres verticales, et que leur alignement n'est
même pas obligatoire. Une extension du catalogue le fait ensuite en une
commande ; chercher « CSV to Markdown Table » dans le panneau Extensions.
Plusieurs existent et se valent, aucune n'est indispensable.

## Le diagramme

Rien à installer : depuis la version 1.121, VSCode rend les diagrammes Mermaid
dans l'aperçu Markdown d'origine, par l'extension `mermaid-markdown-features`
livrée avec l'éditeur.

```mermaid
flowchart LR
  A[Farine et sel] --> C[Pâte]
  B[Œufs] --> C
  C --> D[Lait, peu à peu]
  D --> E[Repos, 1 h]
  E --> F[Cuisson]
```

Le dessin n'est pas dans le fichier : le `.md` ne contient que ces six lignes,
et les boîtes sont calculées à l'affichage, comme la coloration l'était pour le
code. La syntaxe complète des diagrammes est dans la documentation de Mermaid :
<https://mermaid.js.org/syntax/flowchart.html>.

## Pour aller plus loin

La remarque finale en citation par `>`, et une seconde photo prise par vous, ce
qui fait retravailler les chemins relatifs de la partie 1.

## La comparaison de deux versions

TD d'annexe, qui prépare le cours 2. Il part de ce qui a déjà été fait
à la partie 3 : modifier un fichier sous un autre nom. Les commandes
ci-dessous se lancent depuis `cours1/1f_markdown/`.

1. Ouvrir `travail/recette.md`, puis **Fichier → Enregistrer sous**, sous le
   nom `travail/recette_v2.md`. Dans cette copie, faire passer le repos à deux
   heures et le lait à 600 ml. Imposer ces deux corrections à toute la salle :
   les sorties qui suivent sont chiffrées et ne correspondront pas si chacun
   modifie ce qu'il veut.
2. Clic droit sur `recette.md`, **Sélectionner pour comparer** ; puis clic
   droit sur `recette_v2.md`, **Comparer avec l'élément sélectionné**. Deux
   lignes sont signalées, les trente-huit autres sont identiques.
3. Faire faire la même comparaison par un programme :

   ```console
   $ python depart/comparer.py creer travail/recette.md travail/recette_v2.md travail/modifs.diff
   modifs.diff : 19 lignes, dont 4 de différence
   ```

4. Ouvrir `travail/modifs.diff` dans l'éditeur, et en lire l'en-tête :

   ```
   --- recette.md
   +++ recette_v2.md
   @@ -1,6 +1,6 @@
    # Crêpes

   -*Pour 12 crêpes — 10 minutes de préparation, 1 heure de repos.*
   +*Pour 12 crêpes — 10 minutes de préparation, 2 heures de repos.*
   ```

5. Reconstruire la seconde version à partir de la première et du fichier de
   différences, sous un troisième nom :

   ```console
   $ python depart/comparer.py appliquer travail/recette.md travail/modifs.diff travail/recette_v3.md
   recette_v3.md : 40 lignes, reconstruites à partir de recette.md
   ```

6. Comparer `recette_v3.md` et `recette_v2.md` dans l'éditeur : aucune
   différence. 413 octets ont suffi à refaire un fichier de 953.

### Le cas du binaire

```console
$ pandoc travail/recette.md -o travail/recette.odt
$ pandoc travail/recette_v2.md -o travail/recette_v2.odt
$ python depart/comparer.py creer travail/recette.odt travail/recette_v2.odt travail/modifs.diff
recette.odt n'est pas un fichier texte : ses octets ne se lisent pas comme des
caractères. D'un fichier binaire, une comparaison ne peut dire que s'il diffère
d'un autre, pas ce qui y a changé.
```

Les deux `.odt` font 127 047 octets chacun, la photo comprise, et 965 de ces
octets diffèrent pour deux mots changés. Aucun n'est lisible ligne à ligne :
le contenu est compressé, donc redistribué. C'est la réponse complète à
« pourquoi un `.odt` se versionne mal », posée en première partie.

### Ce que le TD prépare

Comparer deux versions et transmettre leur différence sont deux des opérations que
git automatise. Ce qui manque encore, et qui est le sujet du cours 2 :
l'historique, les auteurs, et le fait de n'avoir plus à inventer un nom de
fichier par version.

### Ce qui a été mesuré

Relevé sur la machine de préparation, avec Python 3.12.14 et pandoc 3.11.

| Mesure | Valeur |
|---|---|
| `recette.md` | 953 octets, 40 lignes |
| `recette_v2.md` | 954 octets |
| `modifs.diff` | 413 octets, 19 lignes, dont 4 de contenu |
| `recette.odt` et `recette_v2.odt` | 127 047 octets chacun, 965 octets différents |
| `crepes.jpg` | 118 472 octets, soit l'essentiel des deux `.odt` |

`comparer.py` n'emploie que `difflib`, de la bibliothèque standard : rien à
installer, et le TD tourne dans n'importe quel environnement Python.
