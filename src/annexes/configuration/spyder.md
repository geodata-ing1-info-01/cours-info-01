---
title: Spyder
subtitle: L'éditeur de code scientifique d'Anaconda ; fichiers et cellules, environnements, notebooks
---

Spyder est un éditeur de code pour Python, livré avec Anaconda et installé
sur les postes de la salle, dans l'environnement `base`. Le module ne
l'emploie pas en séance (VS Code et JupyterLab), mais d'autres cours
l'emploient. Cette page dit comment Spyder exécute du code, quel Python il
utilise, et ce qu'il fait d'un notebook. Son test est en fin de page ; le choix entre les trois outils, dans
[Choisir entre JupyterLab, Spyder et VS Code](../notions/outils.md).

Spyder se lance depuis le menu Démarrer (taper `spyder`), depuis la fiche
Spyder de Navigator, ou en tapant `spyder` dans l'invite de commandes d'Anaconda. Le
premier lancement est long ({ref}`A12 <dep-a12>`). Sur un poste en
français, les menus sont en français ; le nom anglais est donné entre
parenthèses quand il diffère.

## La fenêtre

La fenêtre a trois zones :

- l'éditeur, à gauche : les fichiers `.py` ouverts, un onglet par fichier ;
- la console IPython, en bas à droite : un Python interactif. Ce qu'on y
  tape s'exécute tout de suite, et les variables restent en mémoire
  jusqu'au redémarrage du noyau, comme dans un notebook ;
- un groupe d'onglets, en haut à droite : l'explorateur de variables
  (Variable Explorer), qui liste les variables de la console et ouvre les
  listes, les tableaux NumPy et les DataFrames dans une grille ;
  Graphiques (Plots), où s'affichent les figures Matplotlib ; l'aide ; et
  les fichiers.

La barre d'état, en bas, affiche l'environnement Python de la console.

## Exécuter un fichier, ou une cellule

Trois façons d'exécuter du code, toutes dans la console :

| Ce qu'on fait | Ce qui s'exécute | Après |
|---|---|---|
| `F5`, ou le bouton triangle vert (Exécuter le fichier, Run file) | le fichier entier, du début à la fin | ses variables sont dans l'explorateur de variables, ses figures dans Graphiques |
| `Ctrl` + `Entrée` (Exécuter la cellule, Run cell) | la cellule où est le curseur | idem ; `Maj` + `Entrée` passe à la cellule suivante |
| `F9` | la ligne, ou le texte sélectionné | idem |

Une cellule est un bloc du fichier qui commence par une ligne `# %%`. Pour
Python, c'est un commentaire ; pour Spyder, c'est un séparateur. Un fichier
découpé ainsi s'exécute par morceaux, comme un notebook, et reste un
programme ordinaire : `python fichier.py` l'exécute en entier. Les
résultats ne sont pas enregistrés dans le fichier ; ils sont dans la
console et dans les volets.

```python
# %% Lecture
import pandas as pd
mesures = pd.read_csv("mesures.csv")

# %% Figure
mesures.plot(x="date", y="altitude")
```

## Le Python de la console

Par défaut, la console utilise le Python de Spyder lui-même : sur les
postes, celui de `base`. La vérification est la même que pour les autres
outils : dans la console, `import sys; print(sys.executable)` doit
afficher le chemin d'Anaconda ({ref}`A12 <dep-a12>`).

### Une console dans un autre environnement

Spyder ne crée pas d'environnement : c'est le travail de conda, dans
l'invite de commandes d'Anaconda ([Les environnements](anaconda.md#les-environnements),
TD 1h). Une fois l'environnement créé, Spyder peut y ouvrir une console, à
une condition : le paquet `spyder-kernels` doit y être installé, à la
version qui correspond à celle de Spyder (menu Aide, À propos de Spyder) :

```
conda install -n recette -c conda-forge spyder-kernels=3.1
```

`=3.1` pour Spyder 6.1, `=3.0` pour Spyder 6.0. Le paquet peut aussi
être mis dans la commande de création de l'environnement, avec les autres :

```
conda create -n recette -c conda-forge python spyder-kernels=3.1 pandoc
```

Puis, dans Spyder, au choix :

- menu Consoles, « Nouvelle console dans l'environnement » (New console in
  environment) : la liste des environnements que conda connaît, `base` et
  ceux créés par le compte. Choisir l'environnement ouvre une console
  dedans ; les autres consoles ne changent pas ;
- menu Outils (Tools), Préférences, rubrique « Interpréteur Python »,
  « Utiliser l'interpréteur Python suivant » : choisir l'environnement dans
  la liste, ou donner le chemin de son Python,
  `C:\Users\<nom>\.conda\envs\recette\python.exe`. Valider, puis menu
  Consoles, « Redémarrer le noyau » (Restart kernel). Ce choix devient
  celui de toutes les nouvelles consoles.

Quand `spyder-kernels` manque dans l'environnement, la console n'a pas
d'invite : elle affiche à la place un message qui donne le chemin du Python
choisi et la commande `conda install spyder-kernels=3.1` à taper. La taper
dans l'invite de commandes d'Anaconda, l'environnement activé, puis « Redémarrer le
noyau ».

:::{note}
Les commandes d'installation ne se tapent pas dans la console de Spyder :
depuis Spyder 6.1, `!conda install` et `%pip install` y sont désactivés.
Elles se tapent dans l'invite de commandes d'Anaconda.
:::

## Les notebooks dans Spyder

Spyder édite des fichiers `.py`. Un fichier `.ipynb` ouvert dans son éditeur
s'affiche tel qu'il est écrit sur le disque : du JSON, le format interne du
notebook, montré dans le [cours 1](../../cours1/notebook/03_markdown_notebook.md).
Pour l'exécuter, deux possibilités.

### Convertir le notebook en fichier Python

Clic droit dans l'éditeur, ou clic droit sur le fichier dans le volet
Fichiers, puis « Convertir en fichier Python » (Convert to Python file).
Spyder ouvre un nouveau fichier, non enregistré :

- chaque cellule de code devient une cellule du fichier, séparée par une
  ligne `# In[1]:`, `# In[2]:`… que Spyder traite comme `# %%` ;
- chaque cellule de texte devient un commentaire ;
- les résultats enregistrés dans le notebook ne sont pas repris.

Le fichier s'exécute ensuite cellule par cellule (`Ctrl` + `Entrée`), et
s'enregistre en `.py`. La conversion va dans un seul sens : le fichier
Python ne redevient pas un notebook. Le notebook d'un cours peut donc être
suivi dans Spyder de cette façon ; l'ouvrir dans JupyterLab ou dans VS Code
est plus direct.

### Le plugin spyder-notebook

`spyder-notebook` est une extension de Spyder qui affiche et exécute de
vrais notebooks dans un onglet de Spyder, avec l'interface de Jupyter
Notebook ; le noyau est le Python de l'environnement de Spyder. Elle
s'installe avec conda, dans l'environnement où Spyder est installé :

```
conda install -c conda-forge spyder-notebook
```

La version 0.7 demande Spyder 6.1. Sur les postes de la salle, cette
installation n'est pas possible pour un compte élève : `base` n'y est pas
modifiable. Sur un ordinateur personnel, elle l'est ; elle peut être longue,
et le module n'en a pas besoin.

## Vérifier

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Menu Démarrer, taper `spyder`, Entrée, puis attendre | la fenêtre de Spyder : l'éditeur à gauche, la console en bas à droite | {ref}`A12 <dep-a12>` |
| Dans la console, `import sys; print(sys.executable)` puis Entrée | le chemin d'Anaconda, le même que dans l'invite de commandes d'Anaconda | {ref}`A12 <dep-a12>` |
| Menu Consoles, « Nouvelle console dans l'environnement » | `base`, et les environnements créés par le compte | {ref}`A11 <dep-a11>` |

## Documentation officielle

- [Tour de l'interface](https://docs.spyder-ide.org/current/quickstart.html)
  (en anglais).
- [FAQ de Spyder](https://docs.spyder-ide.org/current/faq.html) (en
  anglais), questions « How do I get Spyder to work with my existing Python
  packages/environment? » et « How do I use code cells in Spyder? ».
- [Spyder Notebook](https://docs.spyder-ide.org/current/plugins/notebook.html)
  (en anglais) : le plugin.
