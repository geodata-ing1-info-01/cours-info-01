---
title: Anaconda
subtitle: Python et ses outils, lancés par l'interface graphique ou en ligne de commande
---

Anaconda est une distribution Python : un ensemble qui réunit Python, des
centaines de bibliothèques déjà installées, l'outil `conda` qui gère les
environnements, et des applications (Anaconda Navigator, Spyder,
JupyterLab). Sur les postes de la salle, il est installé pour tous les
utilisateurs, dans `C:\ProgramData\anaconda3`.

Anaconda se lance de deux façons : par une interface graphique, Anaconda
Navigator, ou en ligne de commande, l'invite de commandes d'Anaconda. Les deux donnent
accès aux mêmes applications et au même Python. Le test des deux est dans
[Anaconda et JupyterLab](../../avant/python.md).

## Lancer Anaconda Navigator

Menu Démarrer, taper `anaconda`, choisir « Anaconda Navigator ».

```{figure} menu_demarrer_anaconda.svg
:alt: Le menu Démarrer après avoir tapé anaconda, avec Navigator, Prompt et Spyder dans la liste
:width: 100%

Le menu Démarrer, après avoir tapé `anaconda`.
```

Après le chargement (jusqu'à deux minutes la première fois), la page
d'accueil affiche une fiche par application. En haut, une liste déroulante
indique l'environnement actif, `base (root)`.

```{figure} navigator_accueil.svg
:alt: La page d'accueil d'Anaconda Navigator, avec la liste des environnements et une fiche par application
:width: 100%

La page d'accueil d'Anaconda Navigator.
```

Le bouton Launch d'une fiche lance l'application dans l'environnement
affiché en haut. Quand Navigator est lent ou ne s'ouvre pas
({ref}`A4 <dep-a4>`, {ref}`A5 <dep-a5>`), la section suivante donne
l'autre façon de lancer les mêmes applications.

## Lancer l'invite de commandes d'Anaconda

Menu Démarrer, taper `anaconda`, choisir « Anaconda Prompt », le nom
anglais de l'invite de commandes d'Anaconda. Une fenêtre noire s'ouvre tout
de suite. La ligne qui attend une commande s'appelle
l'invite ; elle commence par `(base)`, le nom de l'environnement actif, puis
le dossier courant.

```{figure} ../../avant/anaconda_prompt.svg
:alt: La fenêtre de l'invite de commandes d'Anaconda, avec une commande tapée et sa réponse
:width: 100%

Une commande tapée dans l'invite de commandes d'Anaconda, et sa réponse.
```

Chaque application se lance en tapant son nom, puis Entrée :

| Application | Commande | Détail |
|---|---|---|
| JupyterLab | `jupyter lab` | [JupyterLab](jupyterlab.md) |
| Spyder | `spyder` | [Spyder](spyder.md) |
| VS Code | `code` suivi du chemin du dossier | [VS Code](vscode.md) |
| Anaconda Navigator | `anaconda-navigator` | |

L'application démarre avec l'environnement actif dans la fenêtre, celui
qu'indique l'invite. La fenêtre de l'invite de commandes d'Anaconda reste ouverte pendant
que l'application est ouverte ; elle affiche ce que l'application écrit,
et une erreur de démarrage s'y lit.

## Les environnements

Un environnement est un dossier qui contient un Python et les paquets
installés avec lui. `base` est celui d'Anaconda. Sur les postes de la
salle, son dossier n'est pas modifiable par un compte élève : on n'y
installe rien. Chaque TD qui a besoin d'un paquet crée son propre
environnement, qui va dans `C:\Users\<nom>\.conda\envs`. Le TD 4a fait
créer le premier ; les commandes, dans l'invite de commandes d'Anaconda :

```
conda create -n recette -c conda-forge python pandoc
conda activate recette
conda env list
conda list -n recette
```

Dans l'ordre : créer l'environnement `recette` avec Python et pandoc, pris
sur le canal conda-forge ; l'activer (l'invite passe à `(recette)`) ; lister
les environnements connus ; lister les paquets de `recette`. Ce que
change l'activation est expliqué dans
[Les environnements conda](../notions/environnements.md).

## Documentation officielle

- Anaconda Navigator : [Getting started with Navigator](https://www.anaconda.com/docs/tools/anaconda-navigator/getting-started)
  (en anglais).
- Invite de commandes d'Anaconda et conda : [Getting started with conda](https://docs.conda.io/projects/conda/en/stable/user-guide/getting-started.html)
  (en anglais).

## Configuration des dépôts

Un paquet installé par conda vient d'un dépôt, un serveur qui en tient
des milliers à disposition. conda appelle ces dépôts des canaux
(*channels*). Il en existe plusieurs : `conda-forge`, tenu par une
communauté, où chaque paquet entre après relecture d'une recette ; les
canaux d'Anaconda (`defaults`, c'est-à-dire `pkgs/main` et `pkgs/r`),
tenus par l'entreprise, avec des conditions d'utilisation ; et PyPI, le
dépôt de `pip`, que conda n'emploie pas. Le réglage des canaux dit à conda
où chercher, et dans quel ordre.

```{figure} ../schemas/depots.svg
:alt: Un environnement conda sur la machine, et deux dépôts à distance, PyPI et conda-forge ; une flèche va de conda-forge vers l'environnement
:width: 100%

Un environnement, et les dépôts d'où viennent ses paquets (schéma du
cours 1).
```

Le module prend ses paquets sur conda-forge, d'où le `-c conda-forge` des
commandes. Deux réglages, à faire une fois par compte dans l'Anaconda
Prompt, rendent ce choix permanent et évitent les questions que conda
pose sinon.

### Canal conda-forge par défaut

Écrire dans le fichier `C:\Users\<nom>\.condarc` (le créer avec le
Bloc-notes s'il n'existe pas ; le nom commence par un point et n'a pas
d'extension) :

```yaml
channels:
  - conda-forge
channel_priority: strict
```

Avec ce fichier, `conda create -n recette python pandoc` prend tout sur
conda-forge, sans `-c`, et les canaux d'Anaconda ne sont plus consultés,
y compris quand c'est VS Code qui lance `conda create`
([Comment VS Code gère les environnements](../notions/vscode_environnements.md)).
Vérifier : `conda config --show channels` affiche `conda-forge` seul.

### Conditions d'utilisation des canaux d'Anaconda

Depuis Anaconda 2025.06, conda demande une fois par compte d'accepter
les conditions d'utilisation des canaux d'Anaconda avant de s'en servir
({ref}`A10 <dep-a10>`). La question n'est posée que dans un terminal ;
lancé par VS Code, conda ne peut pas la poser et échoue. Faire le test une
fois, dans l'invite de commandes d'Anaconda :

```
conda tos
```

La réponse est un tableau des canaux avec, pour chacun, accepté ou non.
S'il reste des canaux non acceptés et qu'on compte s'en servir :

```
conda tos accept
```

Avec le fichier `.condarc` ci-dessus, les canaux d'Anaconda ne sont plus
consultés et la question ne se pose plus.

## Fichiers utiles

| Quoi | Où |
|---|---|
| Installation | `C:\ProgramData\anaconda3` |
| Python de `base` | `C:\ProgramData\anaconda3\python.exe` |
| Script qu'exécute l'invite de commandes d'Anaconda | `C:\ProgramData\anaconda3\Scripts\activate.bat` |
| Environnements créés par le compte | `C:\Users\<nom>\.conda\envs` |
| Liste des environnements connus | `C:\Users\<nom>\.conda\environments.txt` |
| Réglages de conda pour le compte (canaux) | `C:\Users\<nom>\.condarc` |
| Réglages et journaux de Navigator | `C:\Users\<nom>\.anaconda\navigator` et `C:\Users\<nom>\AppData\Roaming\.anaconda\navigator` |

`conda info`, dans l'invite de commandes d'Anaconda, affiche ces chemins tels que conda
les voit.
