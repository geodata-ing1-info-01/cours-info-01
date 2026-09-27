---
title: Fichiers et encodage
subtitle: Lire et écrire un fichier en Python, et ce qu'un fichier texte contient, du caractère à l'octet
---

Cette partie explique les lignes du programme de la recette qui ouvrent, lisent
et écrivent un fichier. Elle part de ce qu'un éditeur affiche, un texte sur
plusieurs lignes, et descend d'un niveau à chaque section : le texte est une
suite de caractères, chaque caractère est écrit en octets, et l'encodage
définit ce passage. Elle présente ensuite le mode binaire, qui lit les octets
sans les décoder, puis `with` et les modes d'écriture. Deux TD l'accompagnent,
le notebook `fichiers.ipynb` du TD 2a et, facultatif, le notebook
`images.ipynb` du TD 2b ; ils sont présentés en fin de page.

## Lire un fichier : ouvrir, lire, fermer

Lire un fichier demande trois étapes : l'ouvrir avec la fonction `open`, le
lire avec une méthode de l'objet fichier que `open` renvoie, puis le fermer
avec la méthode `close`.

```python
# 1. ouvrir : f est l'objet fichier
f = open(chemin, encoding="utf-8")
# 2. lire, ici avec la méthode read
texte = f.read()
# 3. fermer
f.close()
```

Tant qu'il est ouvert, le fichier est réservé par le programme : sous
Windows, un autre programme ne peut ni l'effacer ni le remplacer. Après
`close()`, `f.read()` lève une erreur `ValueError`. L'argument `encoding` est
expliqué plus bas, à la section [Le fichier, une suite
d'octets](#le-fichier-une-suite-doctets).

Il existe plusieurs façons de lire un fichier ouvert :

```{list-table}
:header-rows: 1

* - Lecture
  - Ce qui est obtenu
  - En mémoire
* - `texte = f.read()`
  - une chaîne : tout le texte
  - tout le fichier
* - `ligne = f.readline()`
  - une chaîne : la ligne suivante, fin de ligne comprise
  - une ligne
* - `lignes = f.readlines()`
  - une liste de chaînes, une par ligne
  - tout le fichier, découpé
* - `for ligne in f:`
  - une chaîne à chaque itération, une par ligne
  - une ligne à la fois
```

Sur un fichier de plusieurs gigaoctets, un nuage de points LiDAR écrit en
texte par exemple, `read()` échoue faute de mémoire ; la boucle `for` le
traite ligne par ligne, et `break` arrête la lecture avant la fin.

## Le texte, une suite de caractères

Un éditeur affiche le texte sur plusieurs lignes. Dans le fichier, le texte
est une seule suite de caractères, et chaque fin de ligne est un caractère,
noté ⏎ sur la figure. L'objet fichier garde une position dans cette suite :
chaque lecture part de cette position et la fait avancer. `readline` lit
jusqu'au prochain ⏎, inclus.

```{figure} figures/2_suite_caracteres.svg
:alt: À gauche, le début de recette.md affiché sur trois lignes ; à droite, la même suite de caractères dans le fichier, les deux fins de ligne en couleur. Dessous, la position de lecture après open, après readline, puis après read.

Le texte affiché sur trois lignes, et la même suite de caractères dans le
fichier. ␣ représente l'espace.
```

### Les caractères de contrôle, `\n` et `\t`

La fin de ligne et la tabulation sont des caractères de contrôle, sans
symbole visible. Dans une chaîne Python, ils s'écrivent avec une barre
oblique inverse suivie d'une lettre : `\n` pour la fin de ligne, `\t` pour la
tabulation. `print` affiche leur effet ; `repr` affiche la chaîne telle
qu'elle s'écrit en Python. `\n` compte pour un seul caractère.

```python
print("un\tdeux\ntrois")
print(len("\n"))
print(repr("# Crêpes\n"))
```

```text
un      deux
trois
1
'# Crêpes\n'
```

Une fin de ligne tapée avec la touche Entrée entre les guillemets termine la
ligne de code : Python lève `SyntaxError: unterminated string literal`. La
barre oblique inverse permet d'écrire ce caractère dans une chaîne.

## Fichiers binaires et fichiers texte

Tout fichier est une suite de **bits**, qui valent 0 ou 1, regroupés par
**octets** de huit. Un octet peut prendre 2⁸ = 256 valeurs, que les outils
écrivent avec deux chiffres **hexadécimaux**, de `00` à `FF` : la base seize
compte de `0` à `9` puis de `A` à `F`, et un chiffre hexadécimal représente
quatre bits.

```{figure} ../../cours1/notebook/figures/octet.svg
:alt: Quatre étapes : huit bits, 01010010 ; une valeur, 82 sur 256 possibles ; représentée par deux chiffres hexadécimaux, 52, de 00 à FF ; un caractère, si c'est du texte, R, par la table ASCII.

Un octet, sa valeur, son écriture hexadécimale, et le caractère qu'il code
dans un fichier texte.
```

Un fichier est dit **texte** quand chacun de ses octets représente un
caractère, et **binaire** sinon : ses octets ont alors le sens que leur donne
son format. Tous les fichiers sont des suites de bits ; « binaire » signifie
ici que le fichier n'est pas fait pour être lu caractère par caractère.

```{list-table}
:header-rows: 1

* -
  - Fichier texte
  - Fichier binaire
* - Ses octets
  - des caractères, tous
  - ce que le format décide
* - Qui le lit
  - n'importe quel éditeur de texte
  - le logiciel qui connaît le format
* - Ce qu'on en fait
  - le lire, le comparer, le versionner
  - l'ouvrir dans son logiciel
```

Cette différence revient dans tout le module : un fichier texte se compare ligne
à ligne et se versionne avec git, un fichier binaire non.

## Le fichier, une suite d'octets

Sur le disque, un fichier est une suite d'octets. L'encodage, donné par
l'argument `encoding` de `open`, définit le caractère qui correspond à chaque
octet ou groupe d'octets. Décodés avec un autre encodage, les mêmes octets
donnent d'autres caractères.

```{figure} figures/2_suite_octets.svg
:alt: Les dix octets de la ligne de titre de la recette des crêpes, suivis d'une fin de ligne ; décodés en UTF-8, ils donnent neuf caractères, c3 aa formant ê ; décodés en cp1252, dix caractères, c3 donnant Ã et aa donnant ª.

Les mêmes octets, décodés en UTF-8 puis en cp1252.
```

`recette.md` est écrit en UTF-8. Sans l'argument `encoding`, Python prend
l'encodage du système, `cp1252` sous Windows, et le fichier se lit de
travers : « ê » devient « Ãª », « é » devient « Ã© ». Chaque lecture et
chaque écriture de texte porte donc `encoding="utf-8"`.

## ASCII et UTF-8

Un encodage écrit chaque caractère en octets. Le code ASCII définit 128
caractères, écrits sur un octet chacun : les lettres sans accent, les
chiffres, la ponctuation, l'espace et le retour à la ligne. UTF-8 reprend ces
128 codes sur les mêmes octets, et écrit tous les autres caractères sur deux,
trois ou quatre octets.

```{list-table}
:header-rows: 1

* - Caractère
  - ASCII
  - UTF-8
* - `a`
  - `61`
  - `61`
* - `é`
  - absent
  - `c3 a9`
* - `œ`
  - absent
  - `c5 93`
* - `😀`
  - absent
  - `f0 9f 98 80`
```

`len` compte les caractères d'une chaîne, et `encode("utf-8")` renvoie ses
octets : « œuf » a trois caractères et quatre octets, « oeuf » quatre et
quatre. `"œ".encode("ascii")` lève `UnicodeEncodeError`, car `œ` n'a pas de
code ASCII. `œ` manque aussi en ISO 8859-1, l'encodage courant des textes
français avant UTF-8 ; les fichiers anciens écrivent donc « oeuf ».

En UTF-8, chaque octet, écrit en binaire, commence par un certain nombre de
`1`, suivis d'un `0`. Ce nombre de `1` en tête donne le rôle de l'octet :

```{list-table}
:header-rows: 1

* - Début de l'octet
  - `1` en tête
  - Rôle de l'octet
* - `0xxxxxxx`
  - 0
  - un caractère ASCII, écrit sur un seul octet
* - `10xxxxxx`
  - 1
  - un octet de suite, qui continue un caractère
* - `110xxxxx`
  - 2
  - le premier octet d'un caractère de 2 octets
* - `1110xxxx`
  - 3
  - le premier octet d'un caractère de 3 octets
* - `11110xxx`
  - 4
  - le premier octet d'un caractère de 4 octets
```

Le premier octet d'un caractère écrit sur plusieurs octets porte autant de
`1` en tête que le caractère compte d'octets. Le début `10`, avec un seul
`1`, est réservé aux octets de suite : un premier octet a donc toujours au
moins deux `1` en tête. Les octets de suite commencent par `1` : aucun octet
d'un caractère écrit sur plusieurs octets ne ressemble à un caractère ASCII.
Un octet `0a`, par exemple, est toujours une fin de ligne, jamais une partie
de `é`.

Les bits notés `x`, mis bout à bout, forment le numéro du caractère. Pour
`é`, `c3 a9` s'écrit `11000011 10101001` : sans `110` ni `10`, il reste
`00011101001`, soit 233, le numéro que `ord("é")` renvoie.

Des noms de communes de France portent des caractères hors ASCII : Œuilly
(Aisne, et Marne), Plœuc-L'Hermitage (Côtes-d'Armor), L'Haÿ-les-Roses
(Val-de-Marne), Aÿ-Champagne (Marne). Pour qu'ils apparaissent tels quels sur
une carte, le fichier qui les porte est en UTF-8, et le programme qui le lit
écrit `encoding="utf-8"` ; lu sans cet argument sous Windows, « Plœuc »
devient « PlÅ“uc ».

## La fin de ligne

La fin de ligne est un caractère de contrôle, écrit `\n` en Python. Sous
Linux et macOS, un fichier texte la code par l'octet `0a` ; sous Windows,
souvent par les deux octets `0d 0a`, écrits `\r\n`.

```{figure} figures/2_fin_de_ligne.svg
:alt: La même ligne écrite sous Linux, avec deux octets 0a, et sous Windows, avec deux fois 0d 0a ; dans les deux cas, le texte lu contient deux \n.

La même ligne, écrite sous Linux et sous Windows, lue en mode texte.
```

En mode texte, `open` remplace `\r\n` par `\n` à la lecture ; à l'écriture
sous Windows, il remplace chaque `\n` par `\r\n`. Dans le programme, les
lignes sont donc toujours séparées par `\n`. L'argument `newline` d'`open`
modifie cette conversion : le module `csv` demande `newline=""`.

## Le mode binaire

Le deuxième argument d'`open` est le mode d'ouverture. Avec le mode `"rb"`,
Python lit les octets du fichier sans les décoder : `read` renvoie un objet
`bytes`, et les fins de ligne restent `\r\n`. Il n'y a pas d'argument
`encoding`. La position compte des octets : `read(4)` lit les 4 octets
suivants.

```{figure} figures/2_mode_binaire.svg
:alt: Les octets du fichier écrit sous Windows, et la position après open, après read(4), qui renvoie b'# Cr', après read(2), qui renvoie les deux octets de ê, puis à la fin.

Le fichier écrit sous Windows, lu en mode binaire.
```

Python affiche un objet `bytes` précédé de `b` : les octets qui correspondent
à un caractère ASCII visible s'affichent comme ce caractère, les autres en
hexadécimal, `\xc3`. Le mode `"wb"` écrit des octets. Un programme lit et
écrit une image en mode binaire ; le notebook facultatif `images.ipynb` en
donne des exemples.

## Fermer automatiquement avec `with`

Un fichier ouvert doit être fermé, même si une erreur se produit pendant sa
lecture ou son écriture. Le bloc `with` s'en charge : le fichier est ouvert
au début du bloc, accessible dans le bloc indenté sous le nom écrit après
`as`, et fermé à la fin du bloc, y compris en cas d'erreur.

```python
with open(chemin, encoding="utf-8") as f:
    texte = f.read()
# ici, f est fermé
```

```{list-table}
:header-rows: 1

* - Situation
  - `open`, puis `close()`
  - `with`
* - une erreur survient pendant la lecture
  - le fichier reste ouvert : `close()` n'est pas atteint
  - fermé
* - `close()` oublié
  - le fichier reste ouvert jusqu'à la fin du programme
  - aucun `close()` à écrire
```

En Python, on ouvre en général les fichiers avec `with`. Les fonctions
utiles de la recette emploient cette forme.

## Les modes d'écriture

Par défaut, un fichier est ouvert en lecture seule, le mode `"r"`. Le mode
`"w"` vide le fichier à l'ouverture, puis écrit depuis le début. Le mode `"a"`
conserve le contenu et écrit à la fin. Dans les deux modes, un fichier absent
est créé.

```{figure} figures/2_modes_ecriture.svg
:alt: Un fichier qui contient « un » suivi d'une fin de ligne. Ouvert en mode w, il est vidé, puis write écrit « deux » depuis le début. Ouvert en mode a, il est conservé, et write écrit « deux » à la fin.

Les modes `"w"` et `"a"` sur un fichier qui contient `un⏎`.
```

```{list-table}
:header-rows: 1

* - Mode
  - Ce qu'il fait
  - Si le fichier n'existe pas
  - S'il existe
* - `"r"`
  - lire (défaut)
  - erreur
  - lu
* - `"w"`
  - écrire
  - créé
  - vidé, puis réécrit
* - `"a"`
  - ajouter à la fin
  - créé
  - conservé, complété
* - `"x"`
  - créer et écrire
  - créé
  - erreur
```

Ces modes lisent et écrivent des chaînes de caractères. Avec la lettre `b` en
plus (`"rb"`, `"wb"`), le fichier est ouvert en mode binaire.

## Les lignes du programme

La fonction `generer` lit la recette, puis écrit la page complétée :

```python
# ouvrir la recette, lire tout son texte, fermer à la fin du bloc
with open(fichier_recette, encoding="utf-8") as fichier:
    source = fichier.read()

intitule = f"## Ingrédients pour {personnes} personnes en {unites}"
complete = source.replace("## Ingrédients", intitule + "\n\n" + tableau(ingredients))

# ouvrir la sortie en mode "w" (créée ou vidée), y écrire la chaîne
with open(fichier_sortie, "w", encoding="utf-8") as fichier:
    fichier.write(complete)
```

Les objets `Path` ont des méthodes qui font ces trois opérations, ouvrir,
lire ou écrire, fermer, en une ligne : `chemin.read_text(encoding="utf-8")`,
`chemin.write_text(texte, encoding="utf-8")` et `chemin.read_bytes()`.

## TD de la partie

- TD 2a, `fichiers.ipynb`, dans le dossier `cours3/2a_fichiers/` de
  l'archive : les sections suivent l'ordre de cette page ; les sections 10 et
  11, le CSV et les raccourcis de `pathlib`, se font après la séance, et la
  section 12, facultative, lit à la main un fichier `.npy` en mode binaire.
- TD 2b, `images.ipynb`, facultatif, dans `cours3/2b_images/` : une image
  PGM en texte et en binaire, la signature d'un format, une image en cinq
  formats et la compression.

Les TD des autres parties sont dans [Travaux dirigés de la séance
3](travaux_diriges.md).
