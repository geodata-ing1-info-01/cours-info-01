---
title: Environnement Python et notebooks
subtitle: Installer une fois, retrouver partout, et savoir où tourne le code
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

:::{note}
Cette partie était prévue en séance 3. Elle a été avancée pour que les autres
cours du programme disposent d'un environnement Python fonctionnel dès la
première semaine. Le bloc « binaire, hexadécimal, PGM » qu'elle remplace a
rejoint le cours 3, où il précède l'introduction de `numpy` et le traitement
d'image.
:::

## L'environnement de développement

Vous allez installer Python, puis `numpy`, puis `ffmpeg`, puis `pandoc`, sur un
poste de laboratoire, sur votre portable, peut-être sous un autre système
d'exploitation. Sans méthode, chaque poste diverge et le travail cesse d'être
reproductible.

Un *environnement* est un dossier isolé contenant une version précise de Python
et les outils choisis. Il se décrit dans un fichier, se recrée à l'identique
ailleurs, et se supprime sans conséquence sur le reste de la machine.

Nous utilisons `conda` avec le canal `conda-forge`, qui installe aussi bien des
bibliothèques Python (`numpy`, `Pillow`) que des programmes complets (`ffmpeg`,
`imagemagick`, `pandoc`, `typst`), sur les trois systèmes. L'objectif est
d'installer des outils de façon reproductible, pas de distribuer un projet.

La liste complète est dans `environment.yml`, à la racine du dépôt, et c'est ce
fichier qu'on distribue : `conda env create -f environment.yml` recrée
l'environnement à l'identique. La commande ci-dessous en est le résumé
projetable en séance.

## Installation

Installez Miniforge, une distribution conda préconfigurée sur conda-forge :
<https://conda-forge.org/download/>. Puis, dans un terminal :

```bash
conda create -n recette -c conda-forge python=3.12 markdown tabulate

conda activate recette
```

Le prompt affiche alors `(recette)`. Vérifiez ensuite que les outils répondent :

```bash
python --version
pandoc --version
ffmpeg -version
```

:::{admonition} À faire 1 — vérifier quel Python s'exécute
:class: tip

Exécutez la cellule suivante. Elle affiche le chemin de l'interpréteur qui
exécute réellement ce notebook. Ce chemin doit contenir le nom de
l'environnement actif.
:::

```{code-cell} python
import sys
import platform
from pathlib import Path

print("Python  :", sys.version.split()[0])
print("Exécutable :", sys.executable)
print("Système :", platform.system(), platform.release())
print("Dossier courant :", Path.cwd())
```

:::{warning}
Un message `ModuleNotFoundError: No module named 'numpy'` alors que le paquet
vient d'être installé signifie presque toujours que l'environnement actif n'est
pas celui où l'installation a eu lieu. Vérifiez `sys.executable` avant toute
autre hypothèse.
:::

## D'où viennent les paquets, et par quel outil

`conda` n'est ni le seul ni le premier outil d'installation, et aucun n'a fait
disparaître les précédents. `pip` paraît en 2008 et installe des bibliothèques
Python, et rien d'autre : il ne sait pas installer `ffmpeg` ni un compilateur
C++, qui ne sont pas du Python. `conda` paraît en 2012 et fait les deux, ce qui
est la raison du choix de ce module. `conda-forge`, le dépôt communautaire d'où
viennent nos paquets, ouvre en 2015. Depuis, `mamba` (2019) a réécrit le
solveur de conda au point de devenir le sien, et deux outils récents, `pixi`
(2023) et `uv` (2024), reprennent l'un l'écosystème conda et l'autre celui de
pip. Ils sont excellents et hors programme : un seul outil suffit ici.

`pyenv`, né la même année que conda, n'installe aucun paquet : il choisit la
version de Python active. Son nom le fait souvent confondre avec les autres.

Une commande d'installation va chercher le paquet dans un **dépôt**. Les deux
que vous croiserez n'y laissent pas entrer la même chose.

```{list-table}
:header-rows: 1

* - Dépôt
  - Taille
  - Comment on y entre
* - PyPI, ce que `pip` installe
  - 886 022 projets
  - publication immédiate, par qui veut, sans relecture
* - conda-forge, ce que `conda` installe ici
  - 29 411 paquets
  - une recette, relue par des humains, puis construite pour les trois systèmes
```

Aucun des deux n'est le bon ou le mauvais : un paquet conda-forge est le plus
souvent construit à partir des mêmes sources que le paquet PyPI, quelques jours
plus tard. Ce qui change est la porte d'entrée.

:::{warning}
**Installer un paquet exécute du code écrit par quelqu'un d'autre**, tout de
suite, avec vos droits et sur vos fichiers. Le nom que vous tapez est la seule
chose que vous contrôlez, et c'est par là que passent les attaques : quelqu'un
publie `reqeusts` à côté de `requests`, la commande passe, rien ne se voit.
Des campagnes de plusieurs centaines de faux paquets ont été relevées sur PyPI.

Le réflexe tient en une phrase : **le nom d'un paquet se copie depuis la
documentation du projet, il ne se tape pas de mémoire.**
:::

Chiffres relevés le 8 septembre 2026 dans l'index de PyPI et par l'API de
GitHub. Sonatype a recensé plus de 454 600 nouveaux paquets malveillants en
2025, tous dépôts confondus (*State of the Software Supply Chain*, 2026).

## Dépendances directes et dépendances transitives

Un programme ne contient pas tout le code qu'il exécute. Ses lignes `import`
désignent du code publié par d'autres, réutilisé au lieu d'être réécrit. Ce
qu'on y gagne n'est pas du temps de frappe : une bibliothèque diffusée a été
relue, corrigée et éprouvée par plus de gens qu'un programme écrit dans la
semaine. Une bibliothèque dont un programme a besoin pour s'exécuter est une
**dépendance** de ce programme.

La relation est récursive : une dépendance déclare à son tour les siennes, qui
déclarent les leurs. Les paquets écrits dans le fichier d'un projet sont ses
dépendances **directes** ; celles qu'ils entraînent sont **transitives**, et
calculer l'ensemble à partir du fichier s'appelle **résoudre** les dépendances.
C'est le travail de `conda`, et ce n'est pas un simple parcours : deux paquets
peuvent exiger deux versions incompatibles d'un troisième, et l'outil doit
trouver un jeu de versions qui convienne à tous.

L'ordre de grandeur se mesure sur l'environnement du module. `environment.yml`
déclare sept paquets ; `conda create --dry-run` en installe 293. Entre les deux,
`pillow` déclare 14 dépendances, `ffmpeg` 53, et elles se recouvrent largement —
le dernier nombre n'est la somme d'aucun des précédents. Personne ne tient cette
liste à la main, et c'est ce qui justifie l'outil.

## Ajouter une bibliothèque à un environnement

Quand une dépendance n'est pas présente dans l'environnement actif, l'exécution
s'arrête avant la première ligne utile.

Le dossier `cours1/4a_recette/depart/recette/` contient un petit projet Python écrit
comme ceux que vous ouvrirez cette année : un `pyproject.toml` qui dit ce qu'est
le projet et ce dont il dépend, un `environment.yml` qui décrit l'environnement,
un `README.md`, et le paquet `recette/`. Le programme convertit en page HTML
le `recette.md` que vous avez écrit au TD 3a, avec la
bibliothèque `markdown`.

Les deux fichiers de description ne font pas le même travail, et aucun des deux
n'installe quoi que ce soit — ils disent ce qu'il faut installer.

```{list-table}
:header-rows: 1

* - Fichier
  - Décrit
  - Employé par
* - `environment.yml`
  - l'environnement : la version de Python, et tout ce qu'il faut sur la machine, y compris ce qui n'est pas du Python
  - `conda`
* - `pyproject.toml`
  - le projet : son nom, sa version, les bibliothèques que le code importe, la commande qu'il installe
  - `pip`, et les outils de construction
```

### YAML et TOML

Ces deux fichiers sont écrits dans deux formats de texte faits pour décrire et
non pour calculer : des données structurées, écrites par un humain, relues par
un programme. En **YAML**, l'indentation porte la structure et le tiret marque
un élément de liste ; en **TOML**, des sections entre crochets contiennent une
valeur par nom. Comme `.json`, ils décrivent des données ; contrairement à lui,
ils acceptent des commentaires, ce qui explique qu'un humain les écrive. On les
retrouve bien au-delà de Python : réglages d'un outil, description d'une chaîne
d'intégration, composition de conteneurs.

Un piège de YAML mérite d'être connu avant de taper le fichier : l'indentation
se fait avec des espaces, jamais avec une tabulation. C'est la question des
caractères invisibles, rencontrée à la partie précédente.

`pyproject.toml` ne porte pas que les dépendances. Le même fichier déclare le
nom du projet, sa version, sa description, les versions de Python acceptées, la
commande que l'installation doit créer (`[project.scripts]`) et l'outil qui sait
fabriquer le paquet (`[build-system]`).

```toml
[project]
name = "page-html"
version = "0.1.0"
requires-python = ">=3.10"
dependencies = ["markdown>=3.5"]
```

C'est ce fichier que lisent les outils de construction et les dépôts. Vous le
lisez aujourd'hui pour installer ; l'écrire est ce qui rend un code installable
par quelqu'un d'autre, c'est-à-dire distribuable. La fabrication d'un paquet est
le sujet du cours 3 : le code que vous réutilisez depuis le début de cette page
est disponible parce que quelqu'un a écrit un fichier de cette forme.

:::{admonition} À faire 2 — un environnement neuf, et ce qu'il faut y ajouter
:class: tip

On repart d'un environnement vide plutôt que de celui d'Anaconda, pour voir ce qu'un
environnement contient d'origine.

1. Ouvrez `cours1/4a_recette/depart/recette/` dans l'éditeur, et lisez la ligne
   `dependencies` de `pyproject.toml` : le projet annonce avoir besoin de
   `markdown`.
2. Créez l'environnement décrit par le fichier voisin, et activez-le :

   ```bash
   conda env create -f environment.yml
   conda activate recette
   ```

3. Regardez ce qu'il contient : `conda list` affiche **28 paquets**, dont
   `pip`, `setuptools`, et une douzaine de bibliothèques C sans lesquelles
   l'interpréteur ne démarre pas. Aucun ne s'appelle `markdown`.
4. Lancez `python -m recette`. Le programme s'arrête sur
   `ModuleNotFoundError: No module named 'markdown'`. Le paquet est là et sa
   syntaxe est correcte ; c'est la dépendance qui manque. (`-m`
   exécute un paquet plutôt qu'un fichier.)
5. Installez la bibliothèque, puis relancez la même commande :

   ```bash
   conda install -c conda-forge markdown
   python -m recette
   ```

6. Ouvrez `recette.html` par l'adresse `file:///` que le programme affiche.
   Changez une couleur dans `style.css`, enregistrez, rechargez la page.
7. Ajoutez enfin `- markdown` sous `dependencies` dans `environment.yml`, puis
   `conda env update -f environment.yml`. Rien ne s'installe, puisque c'est
   déjà fait — mais sur une machine neuve, `conda env create` installera
   désormais les deux d'un coup.
:::

L'étape 5 installe **trois** paquets : `markdown`, et deux qu'il réclame,
`importlib-metadata` et `zipp`. La même commande dans `base` n'en installe
qu'**un seul**, de 85 ko, parce que les deux autres y avaient déjà été tirés
par autre chose. Ce qui est déjà là ne se réinstalle pas.

L'étape 7 est la conclusion de la partie. Une installation faite à la main ne
se retrouve pas ; notée dans le fichier qui décrit l'environnement, elle
redevient reproductible. C'est la différence entre se souvenir de ce qu'on a
tapé et l'avoir écrit.

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

source = dossier_seance() / "3a_markdown" / "depart" / "recette.md"

try:
    import markdown
except ImportError:
    print("markdown n'est pas installé : conda install -c conda-forge markdown")
else:
    html = markdown.markdown(
        source.read_text(encoding="utf-8"),
        extensions=["tables", "fenced_code"],
    )
    print(html[:180], "…")
```

Les tableaux et les blocs de code ne font pas partie du Markdown publié par John
Gruber en 2004 : la bibliothèque sait les traduire, mais il faut le demander,
d'où le second argument.

Le bloc `mermaid` de la recette arrive dans la page sous la forme de ses six
lignes de texte, et non sous la forme d'un dessin. Mermaid est un service de
l'aperçu de l'éditeur, pas du HTML : le navigateur reçoit du texte et affiche du
texte. C'est la même distinction que pour la coloration syntaxique, qui n'est
pas non plus dans le fichier.

## Trois façons d'exécuter du Python

```{raw} html
<svg viewBox="0 0 720 182" width="100%" style="max-width:720px;height:auto;display:block;margin:1.2rem auto;font-family:inherit" role="img">
  <defs><marker id="fl" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7"
     markerHeight="7" orient="auto-start-reverse">
     <path d="M0,0 L10,5 L0,10 z" fill="currentColor"/></marker></defs>
  <rect x="255" y="8" width="200" height="46" rx="6" fill="rgba(31,111,139,.10)"
     stroke="currentColor" stroke-width="1.5" opacity=".85"/>
  <text x="355.0" y="36" text-anchor="middle" fill="currentColor"
     font-size="14" font-weight="600" opacity="1">Du texte Python</text>
  <line x1="355" y1="54" x2="120" y2="96" stroke="currentColor"
     stroke-width="1.5" marker-end="url(#fl)" opacity=".8"/>
  <line x1="355" y1="54" x2="355" y2="96" stroke="currentColor"
     stroke-width="1.5" marker-end="url(#fl)" opacity=".8"/>
  <line x1="355" y1="54" x2="590" y2="96" stroke="currentColor"
     stroke-width="1.5" marker-end="url(#fl)" opacity=".8"/>
  <rect x="10" y="100" width="220" height="70" rx="6" fill="none"
     stroke="currentColor" stroke-width="1.5" opacity=".85"/>
  <text x="120.0" y="132" text-anchor="middle" fill="currentColor"
     font-size="14" font-weight="600" opacity="1">Interpréteur interactif</text>
  <text x="120.0" y="148" text-anchor="middle" fill="currentColor"
     font-size="12.5" font-weight="400" opacity=".75">tape → réponse immédiate</text>
  <rect x="245" y="100" width="220" height="70" rx="6" fill="none"
     stroke="currentColor" stroke-width="1.5" opacity=".85"/>
  <text x="355.0" y="132" text-anchor="middle" fill="currentColor"
     font-size="14" font-weight="600" opacity="1">Script .py</text>
  <text x="355.0" y="148" text-anchor="middle" fill="currentColor"
     font-size="12.5" font-weight="400" opacity=".75">python script.py</text>
  <rect x="480" y="100" width="230" height="70" rx="6" fill="none"
     stroke="currentColor" stroke-width="1.5" opacity=".85"/>
  <text x="595.0" y="132" text-anchor="middle" fill="currentColor"
     font-size="14" font-weight="600" opacity="1">Notebook</text>
  <text x="595.0" y="148" text-anchor="middle" fill="currentColor"
     font-size="12.5" font-weight="400" opacity=".75">cellules + résultats conservés</text>

</svg>
```

```{list-table}
:header-rows: 1

* - Forme
  - Convient pour
  - Limite
* - Interpréteur (`python`)
  - essayer une ligne, faire un calcul
  - rien n'est conservé
* - Script (`.py`)
  - un outil qu'on relance et qu'on versionne
  - les résultats intermédiaires ne sont pas visibles
* - Notebook (`.ipynb`)
  - explorer, documenter, enseigner
  - fichier lourd, difficile à versionner
```

```{code-cell} python
largeur, hauteur = 1920, 1080
pixels = largeur * hauteur
print(f"{pixels:,} pixels".replace(",", " "))
print(f"En couleur, non compressée : {pixels * 3 / 1_000_000:.1f} Mo")
```

Le second chiffre resservira au cours 5, consacré aux ordres de grandeur, et au
TD 7 : une image est un tableau de nombres, et sa taille se calcule.

## Interface et noyau

Un notebook n'exécute rien par lui-même. Deux composants se répartissent le
travail.

```{raw} html
<svg viewBox="0 0 720 140" width="100%" style="max-width:720px;height:auto;display:block;margin:1.2rem auto;font-family:inherit" role="img">
  <defs><marker id="fl" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7"
     markerHeight="7" orient="auto-start-reverse">
     <path d="M0,0 L10,5 L0,10 z" fill="currentColor"/></marker></defs>
  <rect x="20" y="34" width="265" height="76" rx="6" fill="none"
     stroke="currentColor" stroke-width="1.5" opacity=".85"/>
  <text x="152.5" y="68" text-anchor="middle" fill="currentColor"
     font-size="14" font-weight="600" opacity="1">Interface</text>
  <text x="152.5" y="86" text-anchor="middle" fill="currentColor"
     font-size="12.5" font-weight="400" opacity=".75">navigateur ou VSCode</text>
  <line x1="295" y1="58" x2="425" y2="58" stroke="currentColor"
     stroke-width="1.5" marker-end="url(#fl)" opacity=".8"/>
  <text x="360.0" y="51.0" text-anchor="middle"
     fill="currentColor" font-size="12" opacity=".7">code</text>
  <line x1="425" y1="92" x2="295" y2="92" stroke="currentColor"
     stroke-width="1.5" marker-end="url(#fl)" opacity=".8"/>
  <text x="360.0" y="85.0" text-anchor="middle"
     fill="currentColor" font-size="12" opacity=".7">résultats</text>
  <rect x="435" y="34" width="265" height="76" rx="6" fill="rgba(31,111,139,.10)"
     stroke="currentColor" stroke-width="1.5" opacity=".85"/>
  <text x="567.5" y="68" text-anchor="middle" fill="currentColor"
     font-size="14" font-weight="600" opacity="1">Noyau (kernel)</text>
  <text x="567.5" y="86" text-anchor="middle" fill="currentColor"
     font-size="12.5" font-weight="400" opacity=".75">un processus Python</text>

</svg>
```

L'interface affiche le texte et les résultats. Le *noyau* est un processus
Python : il exécute le code et garde les variables en mémoire. Cette séparation
explique deux comportements qui déroutent souvent.

Redémarrer le noyau efface toutes les variables. Le texte des cellules reste à
l'écran, mais son effet a disparu.

L'ordre d'exécution ne suit pas nécessairement l'ordre d'affichage. Les
compteurs `[1]`, `[2]` indiquent l'ordre réel. Un notebook qui fonctionne chez
vous peut échouer chez quelqu'un d'autre s'il n'a jamais été relancé depuis le
début.

:::{admonition} À faire 3 — provoquer puis réparer l'incohérence
:class: tip

1. Lancez `jupyter lab` depuis le terminal, avec l'environnement d'Anaconda actif.
2. Créez un notebook `essai.ipynb`. Première cellule : `x = 10`. Seconde
   cellule : `print(x * 2)`. Exécutez dans l'ordre, vous obtenez `20`.
3. Remplacez le contenu de la première cellule par `x = 3`, mais n'exécutez que
   la seconde. Elle affiche toujours `20` : le noyau ignore ce que vous n'avez
   pas exécuté.
4. Choisissez *Kernel → Restart Kernel and Run All Cells*. Vous obtenez `6`.

Prenez l'habitude de relancer un notebook depuis le début avant de le partager.
:::

## Deux formats de notebook

```{code-cell} python
# Un .ipynb est un fichier JSON : du texte, mais du texte destiné à un programme.
exemple = {
    "cells": [
        {"cell_type": "code",
         "execution_count": 1,
         "metadata": {},
         "source": ["print('bonjour')"],
         "outputs": [{"output_type": "stream", "name": "stdout",
                      "text": ["bonjour\n"]}]},
    ],
    "metadata": {"kernelspec": {"name": "python3"}},
    "nbformat": 4, "nbformat_minor": 5,
}

import json
print(json.dumps(exemple, indent=1)[:420], "…")
```

Un `.ipynb` réunit dans un même fichier le code, les résultats (y compris les
images, encodées en base64) et des métadonnées. Il s'échange facilement, mais se
relit et se compare mal : deux exécutions du même notebook produisent des
différences considérables.

MyST Markdown est l'autre possibilité. Le contenu est écrit en Markdown, les
cellules de code sont des blocs ` ```{code-cell} `, et les résultats sont
recalculés à la construction plutôt que stockés. Cette page est écrite ainsi.

Sur la page que vous lisez, remplacer `1920` par `3840` produit une différence
de 2 lignes au format MyST, contre 23 lignes au format `.ipynb`, dont les
résultats enregistrés. Mesuré sur cette page, le `.ipynb` ayant été exécuté :
c'est là que sont les résultats qui gonflent la différence.

```{list-table}
:header-rows: 1

* -
  - `.ipynb`
  - MyST (`.md`)
* - Nature
  - JSON produit par l'outil
  - Markdown écrit par un humain
* - Résultats
  - stockés dans le fichier
  - recalculés à la construction
* - Comparaison de versions
  - difficile
  - ligne à ligne
* - Édition
  - JupyterLab, VSCode
  - n'importe quel éditeur
```

:::{admonition} À faire 4 — convertir dans les deux sens
:class: tip

```bash
jupytext --to ipynb 03_environnement_python.md
jupytext --to myst essai.ipynb
```

Ouvrez les deux résultats dans VSCode, comparez leur taille et leur lisibilité,
puis répondez en trois lignes : lequel choisiriez-vous pour rédiger un cours ?
pour envoyer un résultat par courriel ?
:::

## Bilan de la séance

Un logiciel transforme une entrée en sortie, et son traitement part d'un texte
écrit par un humain. Une extension nomme un fichier sans dire ce qu'il contient.
Le contenu et la présentation se séparent, en HTML comme ailleurs. Un
environnement rend l'outillage reproductible d'un poste à l'autre. Un notebook
s'exécute dans un noyau, qui conserve l'état entre les cellules.

Le choix d'un format décide de ce que l'on pourra en faire : le relire, le
comparer, le versionner. C'est le sujet du cours 2, consacré à la ligne de
commande et à git. L'annexe « Comparer deux versions d'un fichier » en donne
l'avant-goût, et se fait seul.
