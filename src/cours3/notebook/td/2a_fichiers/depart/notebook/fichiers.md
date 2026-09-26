---
title: Lecture et écriture de fichiers texte
execution: ../../travail
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# Lecture et écriture de fichiers texte

Ce notebook reprend le code de la recette dans son dernier état et explique
les lignes qui manipulent des fichiers. Ses sections suivent l'ordre des
diapositives de la partie 2 :

- 1 et 2 : ouvrir, lire et fermer un fichier ; le texte, une suite de
  caractères où l'objet fichier garde une position ;
- 3 à 6 : le fichier, une suite d'octets ; ASCII et UTF-8 ; la fin de ligne ;
  le mode binaire ;
- 7 à 9 : `with`, la lecture ligne par ligne, les modes d'écriture ;
- 10 et 11, après la séance : le CSV, les raccourcis de `pathlib`.

Comme le précédent, il se copie de `depart/notebook/` dans `travail/` avant
d'être ouvert. Une ligne qui se termine par `# à compléter` est à écrire ; la
cellule « Réponse » repliée qui la suit donne la solution.

## 0 · Le point de départ

Les chemins de la section 3.3 du notebook précédent : la racine, dossier
parent de `travail/`, les dossiers `DONNEES`, les données en entrée, et
`SORTIE`, où le notebook écrit, puis les fichiers qui s'en déduisent. La
cellule doit afficher `True True`.

```{code-cell} ipython3
from pathlib import Path

RACINE = Path.cwd().parent
DONNEES = RACINE / "depart" / "recettes"   # les données en entrée
SORTIE = RACINE / "travail"                # les fichiers produits

RECETTE = DONNEES / "crepes"
FICHIER_INGREDIENTS = RECETTE / "ingredients.csv"
FICHIER_RECETTE = RECETTE / "recette.md"

print(FICHIER_RECETTE.exists(), SORTIE.exists())
```

## 1 · Ouvrir, lire, fermer

Lire un fichier demande trois étapes : l'ouvrir avec la fonction `open`, le
lire avec une méthode de l'objet fichier que `open` renvoie, puis le fermer
avec la méthode `close`. L'objet fichier est nommé ici `fichier_ouvert`, pour
ne pas le confondre avec le texte qu'on en lit ; dans les fonctions utiles,
il s'appelle `fichier`. L'argument `encoding` est expliqué à la section 3.

- `read()` lit tout le texte depuis la position courante, en une seule chaîne,
  et place la position à la fin : un second `read()` renvoie une chaîne vide.
- `close()` ferme le fichier. Tant qu'il est ouvert, il est réservé par le
  programme : sous Windows, un autre programme ne peut ni l'effacer ni le
  remplacer.

```{code-cell} ipython3
fichier_ouvert = open(FICHIER_RECETTE, encoding="utf-8")   # un objet fichier, position au début
print(fichier_ouvert)

texte = fichier_ouvert.read()                               # tout le texte, en une chaîne
print(type(texte), len(texte), "caractères")
print(repr(fichier_ouvert.read()))                          # '' : la position est à la fin

fichier_ouvert.close()                                      # le fichier est rendu au système
print(fichier_ouvert.closed)
```

```{code-cell} ipython3
:tags: [raises-exception]

fichier_ouvert.read()           # un fichier fermé ne se lit plus : ValueError
```

Il existe plusieurs façons de lire un fichier ouvert :

| Lecture | Ce qui est obtenu | En mémoire |
|---|---|---|
| `texte = fichier_ouvert.read()` | une chaîne : tout le texte | tout le fichier |
| `ligne = fichier_ouvert.readline()` | une chaîne : la ligne suivante, fin de ligne comprise | une ligne |
| `lignes = fichier_ouvert.readlines()` | une liste de chaînes, une par ligne | tout le fichier, découpé |
| `for ligne in fichier_ouvert:` | une chaîne à chaque itération, une par ligne | une ligne à la fois |

La section 2 emploie `readline` et `readlines`, la section 8 la boucle `for`.

## 2 · Le texte, une suite de caractères

Un éditeur affiche le texte sur plusieurs lignes. Dans le fichier, le texte
est une seule suite de caractères, et chaque fin de ligne est un caractère.
L'objet fichier garde une position dans cette suite : chaque lecture part de
cette position et la fait avancer.

![Le texte affiché sur trois lignes, puis la même suite de caractères dans le fichier, et la position de lecture après open, readline et read](../illustrations/suite_caracteres.png)

La fin de ligne et la tabulation sont des caractères de contrôle, sans
symbole visible. Dans une chaîne Python, ils s'écrivent avec une barre
oblique inverse suivie d'une lettre : `\n` pour la fin de ligne, `\t` pour
la tabulation. `print` affiche leur effet ; `repr` affiche la chaîne telle
qu'elle s'écrit en Python. `\n` compte pour un seul caractère.

```{code-cell} ipython3
print("un\tdeux\ntrois")   # \t : tabulation, \n : fin de ligne
print(len("\n"))            # un seul caractère
print(repr("# Crêpes\n"))   # la chaîne telle qu'elle s'écrit en Python
```

Une fin de ligne tapée avec la touche Entrée entre les guillemets termine la
ligne de code : Python lève une erreur.

```{code-cell} ipython3
:tags: [raises-exception]

print("un
deux")
```

`readline()` lit depuis la position jusqu'à la prochaine fin de ligne,
incluse, et place la position juste après. Un second `readline()` lit donc la
ligne suivante.

```{code-cell} ipython3
fichier_ouvert = open(FICHIER_RECETTE, encoding="utf-8")
premiere = fichier_ouvert.readline()   # jusqu'à la première fin de ligne, incluse
deuxieme = fichier_ouvert.readline()   # la ligne suivante : ici, une ligne vide
reste = fichier_ouvert.read()          # de la position jusqu'à la fin
fichier_ouvert.close()

print(repr(premiere))
print(repr(deuxieme))
print(repr(reste[:40]))
```

`readlines()` renvoie une liste de chaînes, une par ligne du fichier, et
chaque ligne garde son `\n` à la fin.

```{code-cell} ipython3
print(repr(texte[:60]))

fichier_ouvert = open(FICHIER_RECETTE, encoding="utf-8")
lignes = fichier_ouvert.readlines()   # une liste : une chaîne par ligne
fichier_ouvert.close()
print(len(lignes), "lignes ;", repr(lignes[0]), repr(lignes[1]))
```

## 3 · Le fichier, une suite d'octets

Sur le disque, un fichier est une suite d'octets. L'encodage, donné par
l'argument `encoding` d'`open`, définit le caractère qui correspond à chaque
octet ou groupe d'octets. Décodés avec un autre encodage, les mêmes octets
donnent d'autres caractères.

![Les octets de « # Crêpes » décodés en UTF-8, puis en cp1252](../illustrations/suite_octets.png)

`recette.md` est écrit en UTF-8. Sans l'argument `encoding`, Python prend
l'encodage du système, `cp1252` sous Windows, et le fichier se lit de
travers : « ê » devient « Ãª », « é » devient « Ã© ». La seconde cellule
force `cp1252` pour le montrer sur tous les systèmes.

```{code-cell} ipython3
en_utf8 = open(FICHIER_RECETTE, encoding="utf-8")
print(repr(en_utf8.readline()))
en_utf8.close()
```

```{code-cell} ipython3
en_cp1252 = open(FICHIER_RECETTE, encoding="cp1252")
print(repr(en_cp1252.readline()))
en_cp1252.close()
```

La section 4 montre comment UTF-8 écrit chaque caractère en octets.

## 4 · ASCII et UTF-8

Un encodage écrit chaque caractère en octets. Le code ASCII définit 128
caractères, écrits sur un octet chacun : les lettres sans accent, les chiffres, la ponctuation, l'espace et le
retour à la ligne. UTF-8 reprend ces 128 codes sur les mêmes octets, et écrit
tous les autres caractères sur deux, trois ou quatre octets : `é` et `œ` en
prennent deux, `😀` quatre.

`len` compte les caractères d'une chaîne ; `encode("utf-8")` renvoie ses
octets, et `hex(" ")` les écrit en hexadécimal, séparés par des espaces.

```{code-cell} ipython3
for texte in ("a", "é", "œ", "😀"):
    octets = texte.encode("utf-8")  # à compléter
    print(texte, len(texte), "caractère,", len(octets), "octet(s) :", octets.hex(" "))
```

```{code-cell} ipython3
:tags: [raises-exception]

"œ".encode("ascii")   # œ n'a pas de code ASCII : UnicodeEncodeError
```

En UTF-8, le premier octet d'un caractère indique sur combien d'octets le
caractère est écrit. Le nombre d'octets se lit sur les premiers bits de cet
octet, écrit en binaire :

| Premier octet, en binaire | En hexadécimal | Nombre d'octets du caractère |
|---|---|---|
| `0xxxxxxx` | `00` à `7f` | 1 : les 128 caractères ASCII |
| `110xxxxx` | `c2` à `df` | 2 |
| `1110xxxx` | `e0` à `ef` | 3 |
| `11110xxx` | `f0` à `f4` | 4 |

Les octets suivants du caractère commencent tous par `10` en binaire (`80` à
`bf` en hexadécimal). Un premier octet ne commence jamais par `10` : un
programme ne peut donc pas les confondre. Les bits notés `x`, mis bout à
bout, forment le numéro du caractère.

```{code-cell} ipython3
# Chaque octet en hexadécimal, puis en binaire sur 8 bits
for texte in ("a", "é", "œ", "😀"):
    print(texte, " ".join(f"{octet:02x}={octet:08b}" for octet in texte.encode("utf-8")))
```

Pour `é`, le premier octet `c3` s'écrit `11000011` : il commence par `110`,
le caractère occupe donc deux octets, `c3 a9`. Pour `😀`, le premier octet
`f0` commence par `11110` : le caractère occupe quatre octets.

Un programme qui lit un fichier en UTF-8 applique cette règle octet après
octet. En pseudo-code :

```text
position ← 0
texte ← chaîne vide
tant que position < nombre d'octets du fichier :
    premier ← octets[position]
    si premier commence par 0 en binaire      : n ← 1
    sinon si premier commence par 110         : n ← 2
    sinon si premier commence par 1110        : n ← 3
    sinon si premier commence par 11110       : n ← 4
    sinon : erreur, le fichier n'est pas en UTF-8
    vérifier que les n - 1 octets suivants commencent par 10,
        sinon : erreur, le fichier n'est pas en UTF-8
    caractère ← le caractère dont le numéro est formé par les bits x
                des octets[position] à octets[position + n - 1]
    ajouter caractère à la fin de texte
    position ← position + n
```

Python applique cette règle quand un fichier est ouvert avec
`encoding="utf-8"`, ou quand on appelle `octets.decode("utf-8")`. Si la
règle n'est pas respectée, Python lève une erreur `UnicodeDecodeError`.

Lus avec un autre encodage, les mêmes octets donnent d'autres caractères. En
`cp1252`, l'encodage par défaut de Windows, chaque octet est un caractère :
`c3 a9` se lit `Ã©` au lieu de `é`, l'erreur montrée à la section 3.

```{code-cell} ipython3
octets = "é".encode("utf-8")
print(octets.decode("utf-8"), octets.decode("cp1252"))
```

Le mot « œuf » a trois caractères et, en UTF-8, quatre octets ; « oeuf »,
écrit sans la ligature, en a quatre et quatre. `œ` n'existe ni en ASCII, ni
en ISO 8859-1, l'encodage courant des textes français avant UTF-8 ; les
fichiers anciens écrivent donc « oeuf ».

Des noms de communes de France portent ces caractères : Œuilly (Aisne, et
Marne), Plœuc-L'Hermitage (Côtes-d'Armor), L'Haÿ-les-Roses (Val-de-Marne),
Aÿ-Champagne (Marne). Un fichier en ASCII ne peut pas les écrire. Pour qu'ils
apparaissent tels quels sur une carte, le fichier qui les porte est en
UTF-8, et le programme qui le lit écrit `encoding="utf-8"` ; lu sans cet
argument sous Windows, « Plœuc » devient « PlÅ“uc ».

```{code-cell} ipython3
for nom in ("œuf", "oeuf", "Œuilly", "Plœuc-L'Hermitage", "L'Haÿ-les-Roses", "Aÿ-Champagne"):
    octets = nom.encode("utf-8")
    print(f"{nom:18} {len(nom):3} caractères, {len(octets):3} octets")
```

## 5 · La fin de ligne

Sous Linux et macOS, un fichier texte code la fin de ligne par un octet,
`0a`. Sous Windows, il la code souvent par deux octets, `0d 0a`, écrits
`\r\n` dans une chaîne Python. À la lecture, `open` remplace `\r\n` par
`\n` ; à l'écriture sous Windows, il remplace `\n` par `\r\n`. Dans le
programme, les lignes sont donc toujours séparées par `\n`. L'argument
`newline` d'`open` modifie cette conversion.

![La même ligne écrite sous Linux et sous Windows : octets différents, même texte lu](../illustrations/fin_de_ligne.png)

La cellule suivante écrit un fichier avec des fins de ligne de Windows, quel
que soit le système : le mode `"w"` ouvre le fichier en écriture (section 9),
et `newline="\r\n"` impose `\r\n` à chaque `\n`. Relu en mode texte, le
fichier donne des `\n`.

```{code-cell} ipython3
FICHIER_WINDOWS = SORTIE / "fin_windows.txt"

fichier_ouvert = open(FICHIER_WINDOWS, "w", encoding="utf-8", newline="\r\n")
fichier_ouvert.write("# Crêpes\n\n*10 minutes\n")   # chaque \n est écrit \r\n
fichier_ouvert.close()

fichier_ouvert = open(FICHIER_WINDOWS, encoding="utf-8")
print(repr(fichier_ouvert.read()))                   # relu : des \n
fichier_ouvert.close()
```

## 6 · Le mode binaire

Le deuxième argument d'`open` est le mode d'ouverture. Avec le mode `"rb"`,
Python lit les octets du fichier sans les décoder : `read` renvoie un objet
`bytes`, et les fins de ligne restent `\r\n`. Il n'y a pas d'argument
`encoding`. La position compte des octets : `read(4)` lit les 4 octets
suivants.

![Le fichier écrit sous Windows lu en mode binaire, avec la position en octets après chaque lecture](../illustrations/mode_binaire.png)

Python affiche un objet `bytes` précédé de `b` : les octets qui
correspondent à un caractère ASCII visible s'affichent comme ce caractère,
les autres en hexadécimal, `\xc3`.

```{code-cell} ipython3
fichier_ouvert = open(FICHIER_WINDOWS, "rb")
debut = fichier_ouvert.read(4)   # les 4 premiers octets
suite = fichier_ouvert.read(2)   # les 2 suivants : les octets de ê
reste = fichier_ouvert.read()    # jusqu'à la fin
fichier_ouvert.close()

print(debut)
print(suite)
print(reste)
print(reste.hex(" "))            # les mêmes octets, en hexadécimal
```

Le mode `"wb"` écrit des octets. Un programme lit et écrit une image en mode
binaire ; le notebook facultatif `images.ipynb` en donne des exemples.

## 7 · Fermer automatiquement avec `with`

Un fichier ouvert doit être fermé, même si une erreur se produit pendant sa
lecture ou son écriture. Le bloc `with` s'en charge :

- le fichier est ouvert au début du bloc ;
- dans le bloc indenté, il est accessible sous le nom écrit après `as` ;
- à la fin du bloc, il est fermé, y compris en cas d'erreur.

En Python, on ouvre en général les fichiers avec `with`. Les fonctions
utiles de la recette emploient cette forme, `with open(chemin, …) as fichier:`.

```{code-cell} ipython3
with open(FICHIER_RECETTE, encoding="utf-8") as fichier_ouvert:   # ouvert pour la durée du bloc
    texte = fichier_ouvert.read()

print(fichier_ouvert.closed)   # True : à la sortie du bloc, déjà fermé
print(texte[:60])
```

## 8 · Lire ligne par ligne

`read()` et `readlines()` lisent tout le fichier d'un coup (sections 1 et 2). Un objet fichier
se parcourt aussi avec `for` : à chaque itération, une ligne est lue, avec
son `\n` final. Cette lecture convient à un fichier plus gros que la mémoire,
ou dont seul le début est utile.

La cellule suivante affiche les trois premières lignes de la recette,
numérotées, puis sort de la boucle avec `break` : la suite du fichier n'est
pas lue. `strip()` enlève le `\n` de chaque ligne.

```{code-cell} ipython3
with open(FICHIER_RECETTE, encoding="utf-8") as fichier_ouvert:
    numero = 0
    for ligne in fichier_ouvert:
        numero = numero + 1  # à compléter
        print(numero, ligne.strip())
        if numero == 3:
            break
```

## 9 · Les modes d'ouverture

Le deuxième argument d'`open` indique le mode d'ouverture. Par défaut, le
fichier est ouvert en lecture seule, le mode `"r"`.

| Mode | Ce qu'il fait | Si le fichier n'existe pas | S'il existe |
|---|---|---|---|
| `"r"` | lire (défaut) | erreur | lu |
| `"w"` | écrire | créé | vidé, puis réécrit |
| `"a"` | ajouter à la fin | créé | conservé, complété |
| `"x"` | créer et écrire | créé | erreur |

Ces quatre modes lisent et écrivent des chaînes de caractères, et utilisent
l'argument `encoding`. Avec la lettre `b` en plus (`"rb"`, `"wb"`), le fichier
est ouvert en mode binaire : Python lit et écrit des octets, sans encodage
(section 6).

La cellule suivante écrit `essai.txt` en `"w"`, le complète en `"a"`, puis le
remplace en `"w"`.

![Un fichier qui contient « un », écrit en mode w puis en mode a](../illustrations/modes_ecriture.png)

```{code-cell} ipython3
essai = SORTIE / "essai.txt"

with open(essai, "w", encoding="utf-8") as fichier_ouvert:   # créé, ou vidé s'il existait
    fichier_ouvert.write("première ligne\n")
print(essai.read_text(encoding="utf-8"))

with open(essai, "a", encoding="utf-8") as fichier_ouvert:   # ajouté à la fin
    fichier_ouvert.write("deuxième ligne\n")
print(essai.read_text(encoding="utf-8"))

with open(essai, "w", encoding="utf-8") as fichier_ouvert:   # de nouveau "w" : tout est remplacé
    fichier_ouvert.write("tout est remplacé\n")
print(essai.read_text(encoding="utf-8"))
```

```{code-cell} ipython3
:tags: [raises-exception]

open(SORTIE / "absent.txt", encoding="utf-8")   # "r" par défaut : le fichier doit exister
```

```{code-cell} ipython3
:tags: [raises-exception]

open(essai, "x", encoding="utf-8")   # "x" : le fichier ne doit pas exister
```

## 10 · Le CSV

*Les sections 10 et 11 se lisent et s'exécutent après la séance.*

Une ligne du CSV est une chaîne : `strip()` enlève son `\n`, et `split(",")`
la coupe aux virgules, en une liste de trois chaînes.

```{code-cell} ipython3
with open(FICHIER_INGREDIENTS, encoding="utf-8") as fichier_ouvert:
    for ligne in fichier_ouvert:
        print(ligne.strip().split(","))
```

La bibliothèque `csv` fait ce découpage, et traite aussi une virgule placée à
l'intérieur d'un champ entre guillemets, ce que `split` ne fait pas.
`next()` lit la première ligne, celle des noms de colonnes, et la laisse de
côté, comme dans la fonction `lire_ingredients` du notebook précédent.

```{code-cell} ipython3
import csv

with open(FICHIER_INGREDIENTS, encoding="utf-8", newline="") as fichier_ouvert:
    lecteur = csv.reader(fichier_ouvert)   # découpe chaque ligne en liste de chaînes
    next(lecteur)                          # la ligne d'en-tête, laissée de côté
    for nom, quantite, unite in lecteur:
        print(nom, float(quantite), unite)
```

## 11 · Les raccourcis de `pathlib`

Pour lire ou écrire un fichier en entier, il faut l'ouvrir, lire ou écrire
son contenu, puis le fermer. Les objets `Path` ont des méthodes qui font ces
trois opérations en une ligne :

| Avec `open` | Avec `pathlib` |
|---|---|
| `with open(chemin, encoding="utf-8") as fichier_ouvert:` puis `texte = fichier_ouvert.read()` | `texte = chemin.read_text(encoding="utf-8")` |
| `with open(chemin, "w", encoding="utf-8") as fichier_ouvert:` puis `fichier_ouvert.write(texte)` | `chemin.write_text(texte, encoding="utf-8")` |
| `with open(chemin, "rb") as fichier_ouvert:` puis `octets = fichier_ouvert.read()` | `octets = chemin.read_bytes()` |

La cellule suivante reprend le programme de la recette avec `read_text` et
`write_text` à la place des deux blocs `with`.

```{code-cell} ipython3
source = FICHIER_RECETTE.read_text(encoding="utf-8")
complete = source.replace("## Ingrédients", "## Ingrédients\n\n(tableau)")
(SORTIE / "essai.md").write_text(complete, encoding="utf-8")

print((SORTIE / "essai.md").read_text(encoding="utf-8")[:120])
```

`read_text` lit tout le fichier en une fois. Pour un fichier trop gros pour
la mémoire, ou pour arrêter la lecture avant la fin, on garde la boucle
`for ligne in fichier_ouvert` de la section 8.
