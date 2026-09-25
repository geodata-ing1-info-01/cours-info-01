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
les lignes qui manipulent des fichiers : ouvrir un fichier, le lire en bloc ou
ligne par ligne, y écrire, le fermer, et les modes d'ouverture.

Comme le précédent, il se copie de `depart/notebook/` dans `travail/` avant
d'être ouvert. Une ligne qui se termine par `# à compléter` est à écrire ; la
cellule « Réponse » repliée qui la suit donne la solution.

## 0 · Le point de départ

Les chemins de la section 3.3 du notebook précédent : la racine, dossier
parent de `travail/`, et les fichiers qui s'en déduisent. La cellule doit
afficher `True True`.

```{code-cell} ipython3
from pathlib import Path

RACINE = Path.cwd().parent
RECETTE = RACINE / "depart" / "recettes" / "crepes"
FICHIER_INGREDIENTS = RECETTE / "ingredients.csv"
FICHIER_RECETTE = RECETTE / "recette.md"
TRAVAIL = RACINE / "travail"

print(FICHIER_RECETTE.exists(), TRAVAIL.exists())
```

## 1 · Ouvrir, lire, fermer

Pour lire ou écrire un fichier, il faut d'abord l'ouvrir avec `open`. `open`
renvoie un objet fichier, qui garde une position de lecture ; le texte du
fichier se lit ensuite à partir de cet objet. Cet objet est nommé ici `fichier_ouvert`, pour ne pas le
confondre avec le texte qu'on en lit ; dans les fonctions utiles, il
s'appelle `fichier`.

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

Dans la chaîne renvoyée par `read()`, les lignes sont séparées par le
caractère de retour à la ligne, noté `\n`. `print` l'affiche comme un passage
à la ligne ; `repr` l'écrit `\n`. `readlines()` renvoie une liste de
chaînes, une par ligne du fichier, et chaque ligne garde son `\n` à la fin.

```{code-cell} ipython3
print(repr(texte[:60]))

fichier_ouvert = open(FICHIER_RECETTE, encoding="utf-8")
lignes = fichier_ouvert.readlines()   # une liste : une chaîne par ligne
fichier_ouvert.close()
print(len(lignes), "lignes ;", repr(lignes[0]), repr(lignes[1]))
```

Sous Windows, les lignes d'un fichier texte sont souvent séparées par deux
caractères, `\r\n`. À la lecture, `open` remplace `\r\n` par `\n` ; à
l'écriture sous Windows, il remplace `\n` par `\r\n`. Dans le programme, les
lignes sont donc toujours séparées par `\n`. L'argument `newline` d'`open`
modifie cette conversion.

## 2 · Fermer automatiquement avec `with`

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

## 3 · Les modes d'ouverture

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
est ouvert en mode binaire : Python lit et écrit des octets, sans encodage.

La cellule suivante écrit `essai.txt` en `"w"`, le complète en `"a"`, puis le
remplace en `"w"`.

```{code-cell} ipython3
essai = TRAVAIL / "essai.txt"

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

open(TRAVAIL / "absent.txt", encoding="utf-8")   # "r" par défaut : le fichier doit exister
```

```{code-cell} ipython3
:tags: [raises-exception]

open(essai, "x", encoding="utf-8")   # "x" : le fichier ne doit pas exister
```

`encoding` dit comment les caractères sont écrits en octets. Sans lui,
Python prend l'encodage du système, `cp1252` sous Windows, et un fichier écrit
en UTF-8 se lit de travers : « é » devient « Ã© ». La cellule force `cp1252`
pour le montrer.

```{code-cell} ipython3
with open(essai, encoding="cp1252") as fichier_ouvert:
    print(fichier_ouvert.read())
```

## 4 · Lire ligne par ligne

`read()` et `readlines()` lisent tout le fichier d'un coup. Un objet fichier
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

## 5 · Le CSV

*Les sections 5 et 6 se lisent et s'exécutent après la séance.*

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

## 6 · Les raccourcis de `pathlib`

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
(TRAVAIL / "essai.md").write_text(complete, encoding="utf-8")

print((TRAVAIL / "essai.md").read_text(encoding="utf-8")[:120])
```

`read_text` lit tout le fichier en une fois. Pour un fichier trop gros pour
la mémoire, ou pour arrêter la lecture avant la fin, on garde la boucle
`for ligne in fichier_ouvert` de la section 4.
