---
title: Formats de fichier
subtitle: Un même texte sous quatre formes
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

## Préparation

Les fichiers de cette page sont ceux du TD 1a, dans `cours1/1a_formats/depart/`.
Ils sont fabriqués à partir de textes du domaine public, et livrés avec le cours.

```{code-cell} python
from pathlib import Path

def dossier_seance(depart: Path = Path.cwd()) -> Path:
    """Le dossier de la séance, celui qui contient `1a_formats/`.

    Le notebook s'ouvre depuis l'archive du cours, depuis le dépôt ou pendant
    la construction du book, et le dossier courant change à chaque fois : on
    remonte donc jusqu'à le trouver.
    """
    for dossier in [depart, *depart.parents]:
        for candidat in (dossier, dossier / "data" / "cours1"):
            if (candidat / "1a_formats").is_dir():
                return candidat
    raise FileNotFoundError("dossier de la séance introuvable depuis " + str(depart))

# Dans le dépôt du cours, les fichiers fabriqués sont rangés dans produit/.
DONNEES = dossier_seance() / "1a_formats"
if (DONNEES / "produit").is_dir():
    DONNEES = DONNEES / "produit"
DONNEES = DONNEES / "depart"

for fichier in sorted(DONNEES.iterdir()):
    if fichier.is_file():
        print(f"{fichier.name:<34} {fichier.stat().st_size:>6} octets")
```

Deux textes sont disponibles : *The Raven* d'Edgar Allan Poe (1845) et
*Auld Lang Syne* de Robert Burns (1788). La suite prend le poème ; refaites
ensuite les mêmes opérations avec la chanson.

## Ce que contient un fichier texte

```{code-cell} python
brut = (DONNEES / "raven_une_ligne.txt").read_text(encoding="utf-8")
print(f"{len(brut)} caractères, {brut.count(chr(10))} saut de ligne")
print(brut[:180], "…")
```

Le poème entier tient sur une seule ligne. Un fichier texte ne contient pas des
lignes : il contient des caractères, dont l'un, noté `\n`, signifie « saut de
ligne ». En l'absence de ce caractère, le texte n'est pas découpé.

:::{admonition} À faire 1 — remettre le texte en forme
:class: tip

Copiez `depart/raven_une_ligne.txt` dans `travail/`, ouvrez la copie dans
VSCode et rendez-la lisible : un vers par ligne, une ligne vide entre les strophes. La ponctuation (`,` `—` `?`) et les
majuscules en début de vers vous servent de repères.

Comparez ensuite votre résultat avec le corrigé, distribué après la séance.

En ajoutant ces sauts de ligne, vous avez ajouté au fichier une information
qu'il ne contenait pas : sa structure. Elle n'était pas déductible
automatiquement.
:::

## Extension et contenu

```{code-cell} python
a = (DONNEES / "raven_une_ligne.txt").read_bytes()
b = (DONNEES / "raven_une_ligne.donnees").read_bytes()
print("Contenus identiques :", a == b)
```

Ces deux fichiers portent des extensions différentes et contiennent exactement
les mêmes octets. L'extension n'agit pas sur le contenu : elle indique au
système quel logiciel proposer par défaut.

:::{admonition} À faire 2 — renommer une extension
:class: tip

1. Affichez les extensions dans votre explorateur de fichiers. Elles sont
   masquées par défaut sous Windows et macOS ; activez-les une fois, vous en
   aurez besoin tout le semestre.
2. Copiez `raven_une_ligne.donnees` dans `travail/` et double-cliquez sur la
   copie. Le système ne sait pas quoi en faire.
3. Renommez-la en `.txt` : il s'ouvre dans un éditeur. Renommez-le en `.html` :
   le navigateur l'ouvre. Le fichier lui-même n'a pas changé.
:::

:::{warning}
Une extension peut donc être trompeuse, par erreur ou volontairement. Un fichier
reçu en `.pdf` peut contenir autre chose. Le seul moyen de savoir ce qu'un
fichier contient est de regarder ses octets, ce que nous ferons au cours 3 avec
un éditeur hexadécimal.
:::

## Structure d'un fichier `.odt`

Un `.txt` ne contient que des caractères ; il n'a aucun endroit où noter qu'un
mot est en gras. Un `.odt`, le format de LibreOffice Writer, le peut. La cellule
suivante montre comment.

```{code-cell} python
import zipfile

with zipfile.ZipFile(DONNEES / "raven.odt") as archive:
    for membre in archive.namelist():
        print(membre)
```

Un `.odt` est une archive ZIP contenant des fichiers XML. Le texte est dans
`content.xml`, entouré de balises qui décrivent la mise en forme. Les formats
`.docx`, `.xlsx` et `.epub` sont construits de la même façon.

Les noms de style qu'on y lit surprennent : `Text_20_body`, `Heading_20_1`. Ce
ne sont pas des noms en plusieurs morceaux. Un nom de style est un nom XML, où
l'espace est interdit ; ODF encode donc chaque caractère interdit par son code
hexadécimal entouré de tirets bas, et l'espace vaut `20` en hexadécimal. Il
faut donc lire « Text body » et « Heading 1 ». C'est le même principe que le
`%20` des adresses web, où l'espace est interdit pour la même raison.

Le nom lisible existe aussi dans le fichier : il est rangé dans l'attribut
`style:display-name`, et c'est lui que LibreOffice montre dans son panneau des
styles. La règle est fixée par la spécification OpenDocument, partie 3, aux
sections sur [`style:name` et
`style:display-name`](https://docs.oasis-open.org/office/OpenDocument/v1.3/OpenDocument-v1.3-part3-schema.html).

:::{admonition} À faire 3 — ouvrir l'ODT, puis l'ouvrir autrement
:class: tip

Ouvrez `raven.odt` avec LibreOffice Writer et observez la mise en page.

Copiez-le ensuite dans `travail/` sous le nom `raven.zip`, ouvrez-le comme une
archive, et lisez `content.xml` dans VSCode. C'est le TD 1b, facultatif,
dans `cours1/1b_archive_odt/`.
:::

## Contenu et présentation en HTML

En HTML, le contenu porte des balises qui décrivent sa structure. La
présentation est décrite ailleurs, dans une feuille de style CSS.

```{code-cell} python
print((DONNEES / "raven_brut.html").read_text(encoding="utf-8")[:400])
```

:::{admonition} À faire 4 — comparer deux rendus
:class: tip

1. Ouvrez `raven_brut.html` dans votre navigateur, par double-clic ou par
   glisser-déposer. L'adresse commence par `file://` : le navigateur lit un
   fichier local, sans serveur ni réseau.
2. Le poème s'affiche en un seul bloc. Les sauts de ligne présents dans le
   fichier ne sont pas rendus : en HTML, la structure se déclare avec des
   balises comme `<p>` et `<br>`.
3. Ouvrez `raven_style.html`. Le contenu est le même ; l'en-tête contient une
   ligne de plus, `<link rel="stylesheet" href="style.css">`.
4. Modifiez `style.css` dans VSCode (`background`, `font-family`, `max-width`)
   et rechargez la page avec `F5`.
:::

```{code-cell} python
print((DONNEES / "style.css").read_text(encoding="utf-8")[:300])
```

Le fichier de contenu et le fichier de style sont séparés : l'apparence change
sans que le texte soit touché. On retrouvera ce principe dans le Markdown d'un
`README`, et plus généralement dans la séparation entre un programme et sa
configuration.

## Bilan

```{list-table}
:header-rows: 1

* - Format
  - Contient
  - S'ouvre avec
  - Se versionne bien
* - `.txt`
  - des caractères
  - n'importe quel éditeur
  - oui
* - `.md`
  - des caractères et un balisage léger
  - un éditeur, l'aperçu VSCode
  - oui
* - `.html` et `.css`
  - des caractères, de la structure, du style
  - un éditeur et un navigateur
  - oui
* - `.odt`, `.docx`
  - une archive ZIP de fichiers XML
  - LibreOffice, Word
  - non
```

La dernière colonne annonce le cours 2. Un format texte se relit, se compare
ligne à ligne et se versionne ; une archive compressée, non.

:::{seealso}
Suite : [Environnement Python et notebooks](03_environnement_python.md).
:::
