---
title: Python et conda
subtitle: Installer Miniforge, régler les canaux, créer l'environnement du module
---

Le module emploie conda pour installer Python et les outils des TD. Sur un
ordinateur personnel, on installe Miniforge, une distribution de conda
publiée par la communauté conda-forge. Les commandes sont les mêmes que
dans la salle : `conda create`, `conda activate`, `conda install`.

## Choisir l'installateur

Quatre installateurs donnent la commande `conda` ou un équivalent :

| | Anaconda | Miniconda | Miniforge | micromamba |
|---|---|---|---|---|
| Publié par | Anaconda, Inc. | Anaconda, Inc. | la communauté conda-forge | le projet mamba |
| Canal par défaut | `defaults`, les canaux d'Anaconda | `defaults` | `conda-forge`, seul | aucun, à choisir |
| Contenu de `base` | Python, des centaines de bibliothèques, Navigator, Spyder, JupyterLab | Python et conda | Python, conda et mamba | pas de `base`, pas de Python |
| Commande | `conda` | `conda` | `conda`, ou `mamba` | `micromamba` |
| Conditions d'utilisation | gratuit pour les étudiants dans le cadre des cours, payant pour une organisation de 200 personnes ou plus | les mêmes qu'Anaconda | aucune | aucune |

Le module conseille Miniforge. Son installation pèse quelques centaines de
Mo, contre plusieurs Go pour Anaconda. Il est gratuit pour tout le monde,
y compris après les études, en stage ou chez un employeur. Son seul canal
est conda-forge, celui que le module emploie dans la salle : il n'y a ni
fichier `.condarc` à écrire, ni conditions d'utilisation à accepter.

micromamba est un seul programme, sans environnement `base`. Sa commande
diffère de celle de la salle, et il sert surtout à préparer des
environnements sur des serveurs d'intégration continue.

## Installer Miniforge

### Sous Windows

1. Télécharger `Miniforge3-Windows-x86_64.exe` sur
   <https://conda-forge.org/download/>.
2. Lancer l'installateur, et garder « Just Me ». Miniforge s'installe alors
   dans `C:\Users\<nom>\miniforge3`, sans droits d'administrateur. Laisser
   décochée l'option qui ajoute Miniforge au `PATH`.
3. Menu Démarrer, taper `miniforge`, choisir « Miniforge Prompt ». Une
   fenêtre noire s'ouvre, et l'invite commence par `(base)`.

### Sous macOS et Linux

Dans le Terminal :

```bash
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh
```

Accepter la licence, garder le dossier proposé, `~/miniforge3`, et
répondre `yes` à la dernière question, qui propose d'initialiser conda dans
le terminal. Fermer puis rouvrir le Terminal : l'invite commence par
`(base)`. La documentation de Miniforge déconseille de l'installer par
Homebrew.

### Vérifier

Dans la Miniforge Prompt, ou dans le Terminal :

| Ce qu'on tape | Ce qu'on doit voir |
|---|---|
| `conda --version` | `conda` suivi d'un numéro de version |
| `conda config --show channels` | `conda-forge`, seul |
| `python -c "import sys; print(sys.executable)"` | un chemin dans le dossier `miniforge3` |

## Les canaux

Un paquet installé par conda vient d'un dépôt, que conda appelle un canal.
Le module prend tous ses paquets sur conda-forge. Les canaux et le fichier
`.condarc` qui les règle sont décrits dans {ref}`Anaconda, section
Configuration des dépôts <config-depots>`.

Avec Miniforge, conda-forge est déjà le seul canal. Une ligne de plus fixe
la priorité stricte, qui fait prendre chaque paquet dans le premier canal
de la liste qui le fournit, si on ajoute un canal plus tard :

```
conda config --set channel_priority strict
```

Avec Anaconda ou Miniconda déjà installé, trois commandes font passer
conda à conda-forge, dans l'invite de commandes d'Anaconda ou dans le
Terminal :

```
conda config --add channels conda-forge
conda config --remove channels defaults
conda config --set channel_priority strict
```

La première met conda-forge en tête de la liste des canaux, la deuxième
retire les canaux d'Anaconda, la troisième fixe la priorité stricte.
`conda config --show channels` doit ensuite afficher `conda-forge` seul.
Les paquets déjà installés dans `base` ne changent pas, et les
environnements créés ensuite prennent leurs paquets sur conda-forge. conda
ne demande plus d'accepter les conditions d'utilisation des canaux
d'Anaconda.

## L'environnement du module

Sur les postes de la salle, JupyterLab, numpy, Pillow et pandoc sont dans
`base`. Avec Miniforge, `base` ne contient que Python, conda et mamba, et
on n'y installe rien. Les outils du module vont dans un environnement
`info01`, créé une fois :

```
conda create -n info01 python jupyterlab numpy pillow pandoc
conda activate info01
```

L'invite passe à `(info01)`. `jupyterlab` installe aussi `ipykernel`, le
noyau des notebooks ([Les notebooks](../notions/notebooks.md)). Là où un TD
emploie `base`, activer `info01` à la place. Les TD qui ont leur propre
environnement le créent depuis leur fichier `environment.yml`, comme dans la
salle.

## conda dans les autres terminaux

Sous macOS et Linux, l'installateur a initialisé conda dans le Terminal, et
dans celui de VS Code, qui lit les mêmes fichiers.

Sous Windows, la Miniforge Prompt est un `cmd` activé, comme l'invite de
commandes d'Anaconda dans la salle ({ref}`Anaconda, section conda dans un
terminal <conda-terminal>`). Pour les autres terminaux :

- Git Bash : les commandes de la salle, avec le chemin de Miniforge, puis
  fermer et rouvrir Git Bash ({ref}`Anaconda, section Git Bash
  <conda-git-bash>`) :

  ```text
  source ~/miniforge3/etc/profile.d/conda.sh
  conda init bash
  ```

- `cmd` : taper une fois `conda init cmd.exe` dans la Miniforge Prompt,
  puis rouvrir le terminal ;
- PowerShell : autoriser d'abord les scripts pour le compte
  ({ref}`A7 <dep-a7>`), en tapant une fois dans un PowerShell la commande
  suivante, qui ne demande pas de droits d'administrateur :

  ```
  Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
  ```

  Puis taper `conda init powershell` dans la Miniforge Prompt, et rouvrir
  le terminal.

## D'autres gestionnaires d'environnements

Le module montre conda parce qu'il est installé sur les postes de la
salle, et qu'il installe aussi des programmes qui ne sont pas du Python,
comme pandoc ou ffmpeg. Pour ses propres projets, hors de ces contraintes,
uv et pixi décrivent l'environnement dans un fichier du projet, et le
recréent à l'identique sur une autre machine. Ils sont présentés dans
[venv, uv et pixi](../plus_loin/gestionnaires.md).

## Documentation officielle

- [Miniforge](https://github.com/conda-forge/miniforge) (en anglais) :
  les installateurs, l'installation et la désinstallation.
- [Getting started with conda](https://docs.conda.io/projects/conda/en/stable/user-guide/getting-started.html)
  (en anglais).
