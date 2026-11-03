# Lire le typst de ce dépôt

De quoi relire les sources des diapositives sans avoir à apprendre typst.
L'exemple est le début de
[`src/cours1/diapo/parties/00_ouverture.typ`](../cours1/diapo/parties/00_ouverture.typ),
commenté ligne à ligne, puis ce que font les gabarits appelés.

## La seule règle à comprendre : deux modes

Un fichier typst est en **mode balisage** : ce qu'on écrit est du texte à
composer. Le dièse bascule en **mode code** : ce qui suit est une expression à
évaluer.

> « An expression is introduced with a hash (`#`) and normal markup parsing
> resumes after the expression is finished. »

Deux conséquences, et elles expliquent presque toute la ponctuation du dépôt :

- **entre crochets `[…]`**, on est revenu en mode balisage, donc un appel de
  fonction y reprend un `#` ;
- **entre parenthèses `(…)`** d'un appel, on est en mode code, donc les noms
  d'arguments s'écrivent sans `#`.

C'est pourquoi `#annonce[…]` porte un dièse et `columns: (1fr, 1fr)` n'en porte
pas, dans la même diapositive.

## Le fichier, ligne à ligne

```typ
// Partie du cours 1 — incluse par `cours1.typ`…
```
`//` ouvre un commentaire jusqu'à la fin de la ligne, `/* … */` un commentaire
sur plusieurs lignes. Ils n'apparaissent pas dans le PDF.

```typ
#import "../../../commun/prelude.typ": *
```
`#` parce qu'on est en tête de fichier, donc en mode balisage. Le chemin est
relatif au fichier courant. `: *` importe **tous** les noms publics du fichier
visé — ici `d`, `annonce`, `tableau`, `notes` et le reste. Sans cette ligne,
aucun de ces noms n'existerait : un fichier inclus par `#include` n'hérite de
rien de celui qui l'inclut.

```typ
#separateur-module(
  "Introduction à l'informatique",
  annonce: "Objectifs, contenu et organisation du module",
  auteur: "1re année géomatique",
  date: "15 septembre",
)
```
Un appel de fonction. Le premier argument est **positionnel** : sa place suffit
à l'identifier. Les trois autres sont **nommés**, `nom: valeur`, et leur ordre
n'importe pas. La virgule finale est permise et évite les diffs inutiles quand
on ajoute une ligne.

```typ
#d("Objectif du cours")[
  …
]
```
Le même mécanisme, avec une particularité qui déroute au début : le bloc entre
crochets qui **suit** la parenthèse fermante est un argument de plus, passé en
dernière position. Un « content block » est délimité par des crochets, contient
du balisage quelconque, et vaut une valeur de type `content` — autrement dit,
du contenu qu'on manipule comme une donnée.

`#d("Objectif du cours")[…]` et `#d("Objectif du cours", […])` sont donc la
même chose. La première forme se lit mieux quand le contenu fait vingt lignes.

```typ
  #annonce[
    Consolider ou acquérir les bases informatiques…
  ]
```
Dièse obligatoire : à l'intérieur du bloc de `d`, on est de retour en mode
balisage. La fonction reçoit ici un seul argument, un bloc de contenu.

```typ
  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
    [Demandé dans les autres cours], [(re)vu dans ce module],
    [« ouvrez le projet fourni »], [travailler dans un éditeur de code…],
    …
  )
```
Quatre choses à la fois :

- `(1fr, 1fr)` est un **tuple**, écrit avec des parenthèses et des virgules.
  `fr` est une unité de fraction : les deux colonnes se partagent la largeur à
  parts égales. `(2fr, 1fr)` donnerait deux tiers et un tiers.
- `left + horizon` : les alignements **s'additionnent**, l'un horizontal,
  l'autre vertical.
- Les cellules sont des **blocs de contenu positionnels**, donnés à la suite.
  On est en mode code entre les parenthèses, donc `[…]` s'écrit sans dièse.
  Le tableau les remplit ligne par ligne, de gauche à droite.
- Le retour à la ligne dans l'appel n'a aucun effet : seule la virgule sépare.

```typ
  #notes[
    Ces bases sont en partie connues…
  ]
```
Rien de neuf syntaxiquement. Ce que la fonction en fait est autre chose, et
c'est la section suivante.

## Ce que font les gabarits appelés

Les fonctions employées ci-dessus sont définies dans
[`theme.typ`](theme.typ). Trois formes y suffisent.

### Définir une fonction

```typ
#let annonce(corps) = block(width: 100%, below: 0.8em)[
  #set text(size: 17pt)
  #corps
]
```
`#let nom(paramètres) = valeur` définit une fonction. Ici elle rend un `block`,
c'est-à-dire un bloc de niveau paragraphe, dont le contenu est le bloc entre
crochets. `#corps` insère l'argument reçu — dièse, puisqu'on est dans un bloc
de contenu.

### Paramètres nommés et valeur par défaut

```typ
#let d(titre-diapo, sous-titre: none, corps) = { … }
```
`titre-diapo` et `corps` sont positionnels, `sous-titre` est nommé et vaut
`none` si on ne le donne pas. `none` est une valeur, celle de « rien ». C'est
`corps`, dernier paramètre positionnel, qui reçoit le bloc écrit après la
parenthèse.

Les tirets sont permis dans les noms : `titre-diapo` est un identifiant, pas
une soustraction.

### Transmettre des arguments sans les connaître

```typ
#let tableau(entete: true, ..args) = {
  let contenu = table(
    inset: (x: 9pt, y: 7pt),
    …
    ..args,
  )
  …
}
```
`..args` est un **argument sink** : il collecte tout ce que l'appelant a passé
en plus — les colonnes, l'alignement, les cellules. `..args` à l'intérieur de
`table(…)` fait l'inverse, le **spreading** : il les redistribue à la fonction
appelée.

C'est ce qui permet aux diapositives de ne donner que le contenu : tout le
style des tableaux est écrit une fois dans `tableau`, et rien n'est répété.

### `set`, et jusqu'où il agit

```typ
#set text(size: 17pt)
```
Un **set rule** change la valeur par défaut d'un paramètre pour tout ce qui
suit. Sa portée est la clé :

> « When nested inside of a code or content block, it is only in effect until
> the end of that block. »

Le `#set text(size: 17pt)` d'`annonce` ne déborde donc pas sur le reste de la
diapositive : il s'arrête au crochet fermant. Au premier niveau d'un fichier,
le même `set` vaudrait jusqu'à la fin.

Il existe aussi les **show rules**, `show raw: set text(font: police-code)`,
qui appliquent un style à tous les éléments d'un type — ici tout le code en
chasse fixe.

## Le reste de ce qu'on croise dans le dépôt

| Écrit | Ce que c'est |
|---|---|
| `21pt`, `18.5mm`, `0.8em` | longueurs : points, millimètres, et `em` = taille de police courante |
| `100%`, `1fr` | proportion de l'espace disponible, et fraction de l'espace **restant** |
| `accent.lighten(88%)` | une couleur, éclaircie ; les couleurs sont des valeurs avec des méthodes |
| `#if notes-visibles { … } else { … }` | condition ; les accolades délimitent un bloc de code |
| `sys.inputs.at("notes", default: "")` | lit `--input notes=…` passé à `typst compile` |
| `place(top + left, dx: …, …)` | pose du contenu **hors du flux** : il n'occupe aucune hauteur |
| `context { … }` | ouvre un contexte où l'on peut interroger la mise en page |
| `measure(x, width: w)` | mesure un contenu sans le composer ; demande un `context` |
| `layout(dispo => …)` | donne accès à la taille disponible ; `=>` introduit une fonction anonyme |
| `..items.map(f)` | méthode de tableau, comme en Python |

Deux pièges rencontrés dans ce dépôt, et qui coûtent du temps :

**Une ligne de continuation qui commence par `-`** est lue comme une nouvelle
expression, pas comme la suite de la précédente. Il faut entourer l'expression
de parenthèses.

**Un bloc mesuré dans le flux consomme de la hauteur**, même s'il ne rend rien
de visible : c'est ce qui déséquilibrait les ressorts du gabarit `d` et
remontait le corps des diapositives.

## Pour aller plus loin

La documentation officielle est courte et bien faite :
[scripting](https://typst.app/docs/reference/scripting/) pour les modes, les
variables et les fonctions ; [styling](https://typst.app/docs/reference/styling/)
pour `set` et `show` ; [arguments](https://typst.app/docs/reference/foundations/arguments/)
pour les sinks et le spreading.

Les gabarits propres à ce dépôt sont décrits dans
[`src/cours1/diapo/README.md`](../cours1/diapo/README.md).
