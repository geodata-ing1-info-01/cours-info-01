---
title: Comment VS Code gère les environnements Python
subtitle: Découverte, choix de l'interpréteur, création d'un environnement depuis l'éditeur
---

Cette page dit ce que VS Code fait quand il cherche un Python, comment il
en choisit un, et ce qui se passe quand on lui demande de créer un
environnement conda. Elle a été écrite d'après l'extension Python 2026.4
et l'extension Python Environments 1.36 (septembre 2026).

## Un peu d'histoire

- Jusqu'en 2020, un seul réglage, `python.pythonPath`, désignait le Python
  à employer. L'extension savait déjà trouver plusieurs sortes
  d'environnements (Python installés seuls, venv, conda, pyenv, pipenv) ;
  conda avait ses réglages propres (`python.condaPath`) parce
  qu'Anaconda dominait en science des données, mais venv était traité au
  même niveau.
- En 2020, `python.pythonPath` est remplacé par `python.defaultInterpreterPath`,
  qui ne sert qu'au premier chargement d'un dossier ; ensuite le choix
  fait dans « Select Interpreter » est mémorisé par dossier, hors des
  fichiers de réglages.
- En 2024, la découverte est confiée à un programme séparé, Python
  Environment Tools (PET), livré avec l'extension.
- Depuis 2025, une extension à part, Python Environments, reprend la
  gestion des environnements. D'abord optionnelle, activée par le réglage
  `python.useEnvironmentsExtension`, elle est devenue une dépendance de
  l'extension Python : avec la version 2026.4, elle est installée avec
  elle et prend la main sans réglage. Le même réglage, à `false`, la
  remet de côté.

## La découverte : PET et ses familles

PET a une sonde par famille d'environnements. Il cherche, dans cet
ordre de familles :

| Famille | Ce qui est cherché |
|---|---|
| conda | les environnements que `conda info --envs` connaît, `base` compris |
| venv, virtualenv | les dossiers qui contiennent un `pyvenv.cfg` |
| pyenv, poetry, pipenv, pixi, uv, hatch | les environnements créés par ces outils, à leurs emplacements habituels |
| Python installés seuls | le registre Windows, le Microsoft Store, `python.org`, Homebrew, le Python du système |

Une famille trouvée apparaît dans « Select Interpreter » avec son type :
Conda, Global (Python installé seul), Workspace (venv du dossier ouvert).

## Où les venv sont cherchés

Un venv n'a ni registre ni commande qui le liste : il n'est trouvé que là
où on le cherche.

- Dans le dossier ouvert : les sous-dossiers directs qui contiennent un
  `pyvenv.cfg`, quel que soit leur nom (`.venv`, `venv`, un autre). Un
  venv dans un sous-sous-dossier n'est pas vu. L'extension Python
  Environments y ajoute `python-envs.workspaceSearchPaths`, par défaut
  `[".venv", "*/.venv"]` : un `.venv` à la racine ou dans un sous-dossier.
- Dans des dossiers globaux : ceux des outils (le `~/.virtualenvs` de
  virtualenvwrapper, les venv de pipenv et de poetry, les Python de pyenv
  et d'uv), et ceux qu'on déclare soi-même : `python.venvPath` et
  `python.venvFolders` (extension classique), `python-envs.globalSearchPaths`
  (extension Python Environments).
- Un venv activé dans le terminal qui a lancé VS Code, par sa variable
  `VIRTUAL_ENV`.

Un venv créé ailleurs se choisit une fois par « Enter interpreter path… »,
et VS Code s'en souvient pour ce dossier.

## Comment conda est trouvé

PET cherche `conda` dans les dossiers du `PATH`, dans les variables
laissées par une activation (`CONDA_PREFIX`, `CONDA_EXE`), dans le
registre Windows, et aux emplacements habituels d'installation. Sur les
postes de la salle, lancé depuis le menu Démarrer, VS Code n'a ni le
`PATH` ni les variables de l'invite de commandes d'Anaconda
([Variables d'environnement](variables_environnement.md)) ; c'est le
dernier indice qui répond, `C:\ProgramData\anaconda3` étant un des
emplacements habituels. Le journal « Python Environments » le montre :
`Discovered manager: (Conda) C:\ProgramData\anaconda3\Scripts\conda.exe`.
Le réglage `python.condaPath` donne le chemin quand cette recherche
échoue, sur un poste où Anaconda est ailleurs ; VS Code lance ensuite
`conda info --json` pour obtenir la liste des environnements
([Python et environnement conda](../configuration/vscode_python.md)).

## Le choix de l'interpréteur à l'ouverture d'un dossier

Extension classique : le choix mémorisé pour ce dossier s'il y en a un ;
sinon `python.defaultInterpreterPath` s'il est renseigné ; sinon un venv
du dossier s'il y en a un ; sinon le premier Python trouvé.

Extension Python Environments : d'abord un gestionnaire, puis un
environnement de ce gestionnaire. Le gestionnaire est le premier de ces
quatre critères qui répond :

1. `python-envs.pythonProjects`, un gestionnaire fixé pour ce dossier ;
2. `python-envs.defaultEnvManager`, le gestionnaire par défaut, venv si
   on ne l'a pas changé ;
3. `python.defaultInterpreterPath` : le chemin est résolu par PET, qui en
   déduit l'environnement et son gestionnaire (un `python.exe` d'Anaconda
   donne conda) ;
4. sinon, un venv du dossier, à défaut le Python du système.

Puis l'environnement : le choix mémorisé pour le dossier s'il existe,
sinon celui que le gestionnaire propose. Conda n'est donc jamais choisi
d'office : il l'est si un réglage le désigne, ou si on l'a choisi une fois
dans la liste.

## Les deux extensions

Sur les postes de la salle, Python Environments est installée avec
l'extension Python et prend la main : une vue « Python » dans la barre de
gauche, avec les projets et les gestionnaires trouvés ; la liste « Select
Interpreter », l'activation dans le terminal
(`python-envs.terminal.autoActivationType`), la création d'environnement
et la proposition d'installer un paquet manquant passent par elle, et les
réglages `python-envs.*` prennent le pas sur les anciens.

Avec `python.useEnvironmentsExtension` à `false`, puis « Developer: Reload
Window », l'extension Python fait tout elle-même, avec ses anciens
réglages (`python.terminal.activateEnvironment`). Les gestionnaires
intégrés de Python Environments :

| Gestionnaire | Trouve l'existant | Crée | Gestionnaire de paquets associé |
|---|---|---|---|
| venv | oui | oui | pip (uv à la place, s'il est installé et que `python-envs.alwaysUseUv` est vrai) |
| conda | oui | oui | conda |
| system (Python installés seuls) | oui | non | pip |
| pyenv | oui | non | pip |
| poetry | oui | non | poetry |
| pipenv | oui | non | pip |

Pixi et hatch sont trouvés par PET, mais leur gestion passe par une
extension tierce branchée sur cette API.

(vscode-jupyter-envs)=
## Ce que l'extension Jupyter en fait

L'extension Jupyter ne cherche pas les environnements elle-même : elle
prend la liste de l'extension Python. La rubrique « Python
Environments… » du sélecteur de noyau montre donc ce que « Python: Select
Interpreter » montre, ni plus ni moins. Si `base` manque dans l'un, il
manque dans l'autre, et le remède est celui de l'extension Python
(`python.condaPath`, puis « Python: Clear Cache and Reload Window »).

`ipykernel` n'est pas exigé pour figurer dans la liste. Au moment du
choix, l'extension lance le Python de l'environnement avec
`import ipykernel` ; si l'import échoue, elle propose d'installer le
paquet ({ref}`J2 <dep-j2>`). Pour un environnement conda, elle demande
aussi à l'extension Python les variables qu'`activate.bat` produirait,
et démarre le noyau avec.

Une seconde source s'ajoute : les noyaux déclarés par un fichier
`kernel.json`, dans `AppData\Roaming\jupyter\kernels` et dans le
`share\jupyter` de l'environnement choisi. C'est ainsi qu'apparaît un
noyau enregistré par `python -m ipykernel install --user --name recette`.

Réglages utiles : `jupyter.kernels.excludePythonEnvironments` retire des
environnements du sélecteur (la commande « Jupyter: Filter Kernels » le
remplit par des cases à cocher) ; `jupyter.notebookFileRoot`, par défaut
le dossier du notebook, est le dossier courant du noyau.

Pour déboguer : `jupyter.logging.level` à `debug`, puis « Jupyter: Show
Output ». Le journal montre la liste reçue, le test `import ipykernel`,
la commande de lancement du noyau et ses variables. Côté extension
Python, canal « Python » du panneau Output, avec « Developer: Set Log
Level… » sur Trace.

## Créer un environnement conda depuis VS Code

Les deux extensions savent le faire (« Python: Create Environment », ou
le bouton de la vue Python). Les commandes qu'elles lancent :

- extension classique : `conda create --yes --prefix <dossier ouvert>\.conda python=<version>` ;
  l'environnement vit dans un dossier `.conda` à l'intérieur du projet ;
- extension Python Environments : `conda create --yes --name <nom> python`
  pour un environnement nommé, ou `conda create --yes --prefix <chemin> python`
  pour un environnement dans le projet, puis `conda install --yes …` pour
  les paquets cochés.

VS Code lance `conda` comme un processus à part, sans passer par le
terminal ni par PowerShell : le réglage qui bloque les scripts `.ps1`
({ref}`A7 <dep-a7>`) n'intervient pas, et le profil de terminal ne change
rien à cette étape. Les droits non plus : `--prefix` écrit dans le dossier
du projet, `--name` dans `C:\Users\<nom>\.conda\envs`, et le cache des
paquets dans `C:\Users\<nom>\.conda\pkgs`.

Deux choses peuvent faire échouer la création sur les postes de la
salle, et elles se règlent une fois pour toutes dans la configuration de
conda ([Anaconda, section Configuration](../configuration/anaconda.md)) :

- les conditions d'utilisation des canaux d'Anaconda : VS Code lance
  conda sans terminal interactif, donc conda ne peut pas poser la
  question et répond `CondaToSNonInteractiveError` ({ref}`A10 <dep-a10>`)
  tant qu'elles n'ont pas été acceptées, ou tant que ces canaux restent
  configurés ;
- le canal : VS Code n'ajoute pas `-c conda-forge` ; conda prend les
  canaux du fichier `.condarc`, et à défaut ceux d'Anaconda.

Une fois l'environnement créé, son activation dans un nouveau terminal
suit la règle habituelle : `conda activate` tapé par l'extension, qui
fonctionne dans le profil `cmd` et échoue dans PowerShell. Le module crée
ses environnements dans l'invite de commandes d'Anaconda, avec `-c conda-forge`, puis les
choisit dans VS Code : c'est le chemin où rien de tout cela ne se pose.
