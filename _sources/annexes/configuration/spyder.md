---
title: Spyder
subtitle: L'éditeur de code scientifique d'Anaconda ; fichiers et cellules, environnements, notebooks
---

Spyder est un éditeur de code pour Python, livré avec Anaconda et installé
sur les postes de la salle, dans l'environnement `base`. Le module ne
l'emploie pas en séance (VS Code et JupyterLab), mais d'autres cours
l'emploient. Son test est dans la section « Vérifier », et le choix entre les
trois outils dans [Choisir entre JupyterLab, Spyder et VS Code](../notions/outils.md).

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

Ces touches exécutent le code dans la console :

| Touche | Code exécuté |
|---|---|
| `F5`, ou le triangle vert (Exécuter le fichier, Run file) | le fichier entier |
| `Ctrl` + `Entrée` (Exécuter la cellule, Run cell) | la cellule où est le curseur |
| `Maj` + `Entrée` | cette cellule, puis le curseur passe à la suivante |
| `F9` | la ligne, ou le texte sélectionné |

Les variables créées apparaissent dans l'explorateur de variables, et les
figures dans Graphiques.

Une cellule est un bloc du fichier qui commence par une ligne `# %%`. Python lit
cette ligne comme un commentaire, et Spyder comme un séparateur. Un fichier
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

Créer l'environnement avec conda, dans l'invite de commandes d'Anaconda ([Les
environnements](anaconda.md#les-environnements), TD 1h). Spyder peut ensuite y
ouvrir une console si le paquet `spyder-kernels` y est installé, à la
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
  environment) : la liste des environnements de conda, `base` et
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

Pour l'exécuter, le convertir en fichier Python : clic droit dans l'éditeur, ou
clic droit sur le fichier dans le volet Fichiers, puis « Convertir en fichier
Python » (Convert to Python file). Spyder ouvre un nouveau fichier, non
enregistré :

- chaque cellule de code devient une cellule du fichier, séparée par une
  ligne `# In[1]:`, `# In[2]:`… que Spyder traite comme `# %%` ;
- chaque cellule de texte devient un commentaire ;
- les résultats enregistrés dans le notebook ne sont pas repris.

Le fichier s'exécute ensuite cellule par cellule (`Ctrl` + `Entrée`), et
s'enregistre en `.py`. La conversion va dans un seul sens : le fichier
Python ne redevient pas un notebook. Le notebook d'un cours peut donc être
suivi dans Spyder de cette façon ; l'ouvrir dans JupyterLab ou dans VS Code
est plus direct.

## Vérifier

1. Menu Démarrer, taper `spyder`, Entrée, puis attendre. La fenêtre de Spyder
   s'ouvre, avec l'éditeur à gauche et la console en bas à droite. Sinon :
   {ref}`A12 <dep-a12>`.
2. Dans la console, taper `import sys; print(sys.executable)`, Entrée. Le même
   chemin que dans l'invite de commandes d'Anaconda s'affiche. Sinon :
   {ref}`A12 <dep-a12>`.
3. Menu Consoles, « Nouvelle console dans l'environnement ». La liste affiche
   `base`, et les environnements créés par le compte. Sinon :
   {ref}`A11 <dep-a11>`.

(spyder-git)=
## Git avec Spyder

Spyder n'a pas de terminal intégré. Le plus simple est de garder une fenêtre Git
Bash à côté de Spyder ([Git et Git Bash](git.md)) : les commandes git des TD ne
changent pas, et `git` ne dépend pas de conda. Spyder écrit et lance les
programmes (`F5`), sans réglage. Cette organisation convient à un élève que la
configuration de VS Code bloque.

## Documentation officielle

- [Tour de l'interface](https://docs.spyder-ide.org/current/quickstart.html)
  (en anglais).
- [FAQ de Spyder](https://docs.spyder-ide.org/current/faq.html) (en
  anglais), questions « How do I get Spyder to work with my existing Python
  packages/environment? » et « How do I use code cells in Spyder? ».
