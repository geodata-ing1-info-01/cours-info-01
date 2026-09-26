---
title: "TD 2c — Trois programmes fautifs"
subtitle: Guide détaillé, étape par étape (version 2, proposition)
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

*Version 2 du cours 1 : proposition de travail pour 2027-2028. Ce guide
reprend celui du TD 2b du cours 1 de 2026 ; les programmes s'ouvrent dans
Notepad++ et se lancent dans Git Bash, à la place de VS Code et de son
terminal.*

Le TD fait afficher par l'éditeur de texte, Notepad++, les caractères qu'on
ne voit pas, les espaces et les tabulations, puis corriger trois programmes
Python courts qui s'arrêtent sur un message d'erreur. Chacun contient une
faute d'un genre différent. On lance le programme, on lit le message, on
corrige la copie, et on relance jusqu'à ce que le message disparaisse. Le TD
dure une dizaine de minutes.

Comme au TD 2b, les programmes s'ouvrent et se corrigent dans Notepad++, et
se lancent dans Git Bash. La commande `python` est disponible dans Git Bash
depuis la fin du TD 2a.

| Étape | Ce qu'on fait |
|---|---|
| 1 | préparer le dossier du TD |
| 2 | afficher les caractères invisibles |
| 3 | corriger `surface.py` |
| 4 | corriger `moyenne.py` |
| 5 | corriger `chemin.py` |

Chaque étape commence par un encadré qui la résume. Ce que chaque étape fait
constater est expliqué à la fin du guide, dans « Ce que le TD fait
constater » : faire l'étape d'abord, et noter ce qu'on observe, avant de lire
l'explication.

## 1 · Préparer le dossier du TD

> **À faire :** ouvrir Git Bash dans le dossier `cours1/2c_erreurs/` ;
> copier les trois fichiers de `depart/` dans `travail/` ; ouvrir les copies
> dans Notepad++.
>
> **À obtenir :** l'invite de Git Bash se termine par `2c_erreurs`, et
> `travail/` contient `chemin.py`, `moyenne.py` et `surface.py`.

### Les deux dossiers du TD

Le dossier du TD est dans l'archive de la séance, extraite au TD 1a :

```text
~/Desktop/info01/cours1/2c_erreurs/
├── depart/
│   ├── chemin.py       compte les caractères du poème du TD 1a
│   ├── moyenne.py      calcule la moyenne de quatre altitudes
│   └── surface.py      calcule la surface d'une parcelle rectangulaire
├── travail/            vide
├── td_2c_erreurs.pdf   la feuille du TD
└── README.md
```

Dans Git Bash, `~` désigne le dossier personnel, `C:\Users\eleve` sur les
postes de la salle.

Comme au TD 1a, `depart/` contient les fichiers fournis, et ne se modifie
pas ; les corrections se font sur des copies, dans `travail/`. Si une copie
est abîmée, on en refait une à partir de `depart/`.

### Ouvrir Git Bash dans le dossier du TD

1. Dans l'explorateur de fichiers, ouvrir `Bureau\info01\cours1\2c_erreurs`.
2. Clic droit sur un endroit vide du dossier, « Afficher d'autres
   options », puis « Open Git Bash here ».

À défaut, ouvrir Git Bash depuis le menu Démarrer, puis taper :

```text
cd ~/Desktop/info01/cours1/2c_erreurs
```

Si Git Bash est encore ouvert dans `2b_programme/`, le dossier du TD 2b,
`cd ../2c_erreurs` y conduit.

**Vérification** : l'invite a la forme suivante (le nom du poste change
d'une machine à l'autre).

```text
(base)
eleve@POSTE MINGW64 ~/Desktop/info01/cours1/2c_erreurs
$
```

Si la ligne `(base)` manque, et que `python --version` ne répond pas, la fin
du TD 2a, qui rend Python disponible dans Git Bash, n'a pas été faite sur ce
poste. Si le dossier ne se termine pas par `2c_erreurs`, taper la commande
`cd` ci-dessus.

### Copier les fichiers

```text
cp depart/*.py travail/
ls travail
```

`cp depart/*.py travail/` copie dans `travail/` les fichiers de `depart/`
dont le nom se termine par `.py`. Le motif `*` a été vu au TD 2a.

**Vérification** : `ls travail` affiche `chemin.py`, `moyenne.py` et
`surface.py`.

### Ouvrir les copies dans Notepad++

1. Lancer Notepad++ depuis le menu Démarrer.
2. Menu Fichier, Ouvrir. Aller dans `Bureau\info01\cours1\2c_erreurs\travail`,
   sélectionner les trois fichiers (`Ctrl` + `A`), puis cliquer sur Ouvrir.
   Chaque fichier s'ouvre dans un onglet.

Le titre de la fenêtre de Notepad++ donne le chemin complet du fichier
affiché : il doit contenir `2c_erreurs\travail`.

## 2 · Afficher les caractères invisibles

> **À faire :** régler Notepad++ pour qu'il affiche les espaces, les
> tabulations et les fins de ligne ; lire deux indications de la barre
> d'état.
>
> **À obtenir :** dans un fichier ouvert, un point entre les mots, et des
> points au début des lignes indentées.

### Afficher tous les caractères

Un espace et une tabulation ne se distinguent pas à l'œil : les deux
laissent un blanc. Notepad++ peut les afficher, par un point pour chaque
espace et une flèche pour chaque tabulation. Il affiche aussi, à la fin de
chaque ligne, le ou les caractères qui la terminent : `CR`, `LF`, ou les
deux.

Menu Affichage, Symboles spéciaux, Afficher tous les caractères. Le même
choix active et désactive l'affichage.

Passer à l'onglet de `moyenne.py`.

**Vérification** : un point apparaît entre chaque mot, quatre points au
début de la ligne 7, `total = total + altitude`, et `LF` à la fin de chaque
ligne.

### La barre d'état

La barre d'état est la bande grise, en bas de la fenêtre. Avec un fichier
Python ouvert, elle affiche entre autres :

| L'indication | Ce qu'elle dit |
|---|---|
| `Python file`, à gauche | le langage que l'éditeur a associé au fichier, d'après son extension |
| `Ln : 7    Col : 5` | la ligne et la colonne du curseur |
| `Unix (LF)` ou `Windows (CR LF)` | comment les lignes du fichier se terminent |
| `UTF-8` | l'encodage du fichier |

**À noter** : laquelle des deux fins de ligne, `Unix (LF)` ou
`Windows (CR LF)`, la barre d'état affiche pour `moyenne.py`.

## 3 · Corriger `surface.py`

> **À faire :** lancer `travail/surface.py` ; lire le message ; trouver la
> faute dans l'éditeur ; la corriger ; relancer.
>
> **À obtenir :** `python travail/surface.py` affiche une surface, et plus
> aucun message d'erreur.

### Lancer et lire le message

Dans Git Bash, taper la commande suivante, puis Entrée :

```text
python travail/surface.py
```

Le message se lit de bas en haut. La dernière ligne donne le genre de
l'erreur et sa description ; au-dessus, `File "…\travail\surface.py", line 6`
désigne le fichier et le numéro de la ligne fautive, puis vient la ligne
elle-même :

```text
    return aire
TabError: inconsistent use of tabs and spaces in indentation
```

Dans Git Bash, le séparateur des dossiers s'écrit `/`. Écrit avec `\`,
`travail\surface.py` y devient `travailsurface.py`, un fichier qui n'existe
pas.

### Trouver la faute

Dans Notepad++, passer à l'onglet de `surface.py`, et regarder les lignes 5
et 6, qui forment le corps de la fonction `surface`. Elles paraissent
alignées. Notepad++ ne souligne aucune faute.

**À noter** : ce que l'affichage des caractères invisibles montre au début
de la ligne 5, et au début de la ligne 6.

### Corriger et relancer

1. Au début de la ligne 6, supprimer le blanc qui précède `return`.
2. Taper quatre espaces, pour que la ligne soit indentée comme la ligne 5.
   Selon son réglage, la touche de tabulation de Notepad++ insère une
   tabulation ou des espaces : taper les quatre espaces à la barre
   d'espace, et vérifier que quatre points s'affichent.
3. Enregistrer, `Ctrl` + `S`. Une disquette rouge sur l'onglet du fichier
   signale une modification non enregistrée : Git Bash exécute le fichier
   tel qu'il est sur le disque.
4. Relancer `python travail/surface.py`. La flèche vers le haut du clavier
   rappelle la commande précédente dans Git Bash.

**Vérification** : Git Bash affiche `294.0`, et rien d'autre.

## 4 · Corriger `moyenne.py`

> **À faire :** lancer `travail/moyenne.py` ; lire le message ; corriger la
> ligne qu'il désigne ; relancer.
>
> **À obtenir :** `python travail/moyenne.py` affiche une moyenne, et plus
> aucun message d'erreur.

### Lancer et lire le message

```text
python travail/moyenne.py
```

Le message désigne la ligne 6. Il la recopie, et place un accent
circonflexe, `^`, sous l'endroit où Python s'est arrêté :

```text
    for altitude in altitudes
                             ^
SyntaxError: expected ':'
```

**À noter** : ce que le message dit attendre, et l'endroit précis que
désigne le `^`.

### Corriger et relancer

1. Passer à l'onglet de `moyenne.py`, et aller à la ligne 6. Son numéro est
   dans la marge de gauche ; `Ctrl` + `G`, puis `6` et Entrée, y conduit
   directement.
2. Ajouter à cette ligne le caractère que le message demande, à l'endroit
   qu'il désigne.
3. Enregistrer, puis relancer `python travail/moyenne.py`.

**Vérification** : Git Bash affiche `130.05`, et rien d'autre.

## 5 · Corriger `chemin.py`

> **À faire :** lancer `travail/chemin.py` ; lire le message ; remplacer le
> chemin du fichier lu par un chemin relatif ; relancer.
>
> **À obtenir :** `python travail/chemin.py` affiche un nombre de
> caractères, et plus aucun message d'erreur.

### Lancer et lire le message

```text
python travail/chemin.py
```

Le message se termine par :

```text
FileNotFoundError: [Errno 2] No such file or directory: 'C:/Users/alice/cours1/1a_formats/depart/raven_une_ligne.txt'
```

Passer à l'onglet de `chemin.py`. Le programme ouvre un fichier texte, le
lit en entier, et affiche son nombre de caractères.

**À noter** : à quel poste, et à quel utilisateur, appartient le chemin écrit
à la ligne 3 ; si ce chemin existe sur le vôtre.

### Retrouver le fichier sur son poste

Le fichier que le programme veut lire est `raven_une_ligne.txt`, le poème du
TD 1a. Sur les postes de la salle, il est ici :

```text
C:\Users\eleve\Desktop\info01\cours1\1a_formats\depart\raven_une_ligne.txt
```

Le dossier courant de Git Bash est `~/Desktop/info01/cours1/2c_erreurs`,
celui que l'invite affiche. Un chemin relatif se lit à partir de ce dossier
courant : `..` désigne le dossier parent, ici `cours1/`, et la suite du
chemin descend de là jusqu'au fichier.

### Corriger et relancer

1. À la ligne 3 de `travail/chemin.py`, remplacer le texte entre guillemets
   par :

   ```text
   ../1a_formats/depart/raven_une_ligne.txt
   ```

   Garder les guillemets, et écrire les séparateurs avec `/`, que Python
   accepte sous Windows comme ailleurs.
2. Enregistrer, puis relancer `python travail/chemin.py`, depuis la même
   fenêtre de Git Bash.

**Vérification** : Git Bash affiche `1341 caractères`.

Si le message `FileNotFoundError` revient, avec le nouveau chemin, vérifier
dans l'ordre : que l'invite se termine par `2c_erreurs` ; que
`ls ../1a_formats/depart` affiche `raven_une_ligne.txt` ; que le chemin ne
contient pas de faute de frappe.

**À noter** : à partir de quel dossier le chemin relatif est compté, celui
du fichier `chemin.py` ou celui du terminal. Pour le vérifier, taper
`cd travail`, puis `python chemin.py`, et comparer ; revenir ensuite avec
`cd ..`.

## Ce que le TD fait constater

Cette section se lit après avoir fait les étapes.

### Étape 2 : ce que l'éditeur affiche des caractères invisibles

L'affichage des caractères invisibles montre la différence entre un espace
et une tabulation, qui est dans le fichier et ne se voit pas autrement. Cet
affichage est le seul moyen de repérer une indentation qui mélange les deux,
et il resservira au cours 2 : git y signalera des lignes modifiées qui
semblent identiques, et qui ne diffèrent que par des espaces et des
tabulations.

`Unix (LF)` et `Windows (CR LF)` nomment la façon dont les lignes se
terminent. Linux et macOS terminent une ligne par un caractère, `LF` (saut
de ligne, de valeur `0A`) ; Windows par deux, `CR` puis `LF`. Les fichiers du
TD sont écrits avec `LF` : Notepad++ affiche `LF` à la fin de chaque ligne,
et `Unix (LF)` dans la barre d'état. Un même texte n'a donc pas la même
taille selon le système qui l'a enregistré ; le cours 2 y revient avec git.

### Les trois fautes

| Fichier | Ce que dit le message | La faute |
|---|---|---|
| `surface.py` | `TabError: inconsistent use of tabs and spaces in indentation`, ligne 6 | la ligne 5 est indentée par quatre espaces, la ligne 6 par une tabulation |
| `moyenne.py` | `SyntaxError: expected ':'`, ligne 6 | il manque les deux-points à la fin de la ligne du `for` |
| `chemin.py` | `FileNotFoundError: [Errno 2] No such file or directory: 'C:/Users/alice/…'` | le chemin est celui du poste d'Alice ; il faut écrire `../1a_formats/depart/raven_une_ligne.txt` |

Messages relevés avec Python 3.12. Une fois corrigés, les trois programmes
affichent `294.0`, `130.05` et `1341 caractères`.

Les trois fautes sont rangées par difficulté de lecture. Dans `surface.py`,
les lignes 5 et 6 sont alignées à l'écran, et diffèrent dans le fichier : la
ligne 5 commence par quatre espaces, la ligne 6 par une tabulation. Python
refuse une indentation qui mélange les deux, et seul l'affichage des
caractères invisibles montre ce mélange à l'écran. Dans `moyenne.py`, le
message suffit à trouver la faute : il nomme le caractère attendu, `:`,
et le `^` désigne la fin de la ligne 6, où il manque. En Python, une ligne
qui ouvre un bloc (`for`, `if`, `def`) se termine par deux-points.

Notepad++ ne souligne aucune des trois fautes : il colore le code d'après
l'extension, sans vérifier les règles d'écriture de Python. L'éditeur de
code du cours 2, VS Code, souligne les deux premières avant tout lancement.

### Un programme correct sur un autre poste

La troisième faute est d'une autre nature. `chemin.py` respecte les règles
d'écriture du langage, l'éditeur ne souligne rien, et le programme
fonctionne sur le poste d'Alice, qui l'a écrit. Il échoue ailleurs parce
qu'il contient un chemin **absolu**, `C:/Users/alice/…`, qui part de la
racine du disque et n'existe que sur ce poste-là.

Un chemin **relatif** part du dossier courant, celui où se trouve le
terminal ; le dossier du fichier `.py` n'intervient pas. Depuis `2c_erreurs/`,
`../1a_formats/depart/raven_une_ligne.txt` remonte d'un dossier, puis
descend dans celui du TD 1a. Il désigne le bon fichier sur tout poste où
l'archive du cours est extraite de la même façon, quel que soit le nom de
l'utilisateur, et quel que soit le système. Lancé depuis `travail/`, le même
programme échoue : le dossier parent y est `2c_erreurs/`, qui ne contient pas
`1a_formats/`.

Le dossier dans lequel Git Bash a été ouvert, ou celui où `cd` a conduit,
décide donc de ce que désigne un chemin relatif. Un chemin absolu
dans un programme est l'erreur la plus fréquente des rendus de code des
autres cours : le programme ne fonctionne que sur le poste de son auteur.

### Ce que « le programme fonctionne » veut dire ici

La vérification demandée à chaque étape est que le programme se lance et
n'affiche plus de message d'erreur. Elle ne dit pas que le résultat est
juste : un programme qui calcule autre chose que ce qu'on voulait s'exécute
sans message.
