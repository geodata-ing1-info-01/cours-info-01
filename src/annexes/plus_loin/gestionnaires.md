---
title: venv, uv et pixi
subtitle: D'autres façons de créer un environnement Python, pour ses propres projets
---

Le module emploie conda pour tous ses environnements, parce qu'il est
installé sur les postes de la salle, et qu'il installe aussi des
programmes qui ne sont pas du Python. Cette page décrit trois autres outils
qu'on rencontre dans les projets Python, pour qui veut les essayer sur un
ordinateur personnel.

## venv

`venv` fait partie de Python : il crée un environnement qui réutilise le
Python qui l'a créé, et y installe des paquets avec `pip`, depuis PyPI.
Dans le dossier d'un projet :

```
python -m venv .venv
.venv\Scripts\activate.bat
pip install pandas
```

Sous macOS et Linux, la deuxième ligne est `source .venv/bin/activate`.
L'invite prend `(.venv)` en tête. Le dossier `.venv` contient tout
l'environnement, et se supprime comme un dossier ordinaire.

VS Code trouve un venv placé à la racine du dossier ouvert, sous
n'importe quel nom, et le propose dans « Select Interpreter » avec le
type Workspace ([Comment VS Code gère les environnements](../notions/vscode_environnements.md)).
Un venv placé ailleurs se choisit par « Enter interpreter path… ».

## uv

uv (Astral) fait la même chose que venv et pip, plus vite, et sait aussi
télécharger un Python. C'est un programme à part, qui s'installe sans
droits d'administrateur, au choix :

- `conda install -c conda-forge uv` dans un environnement conda ;
- `pip install uv` dans un environnement existant ;
- l'installateur d'Astral (<https://docs.astral.sh/uv/>), qui le pose
  dans `C:\Users\<nom>\.local\bin`.

Il a besoin du réseau : les paquets viennent de PyPI, et les Python
qu'il télécharge de GitHub. Son cache est dans
`C:\Users\<nom>\AppData\Local\uv\cache`, ses Python dans
`C:\Users\<nom>\AppData\Roaming\uv\python`.

Usage minimal, dans le dossier d'un projet :

```
uv venv
uv pip install pandas
```

`uv venv` crée `.venv` avec le premier Python trouvé ; `--python 3.13`
demande une version (téléchargée si besoin), et
`--python C:\ProgramData\anaconda3\python.exe` réutilise celui d'Anaconda.
L'environnement s'active comme un venv ordinaire.

Mode projet, qui décrit l'environnement dans des fichiers :

```
uv init
uv add pandas
uv run script.py
```

`uv init` crée `pyproject.toml` ; `uv add` y inscrit le paquet, met à
jour `uv.lock` (les versions exactes) et l'installe dans `.venv` ; `uv
run` exécute avec cet environnement, en le recréant s'il manque. Quelqu'un
qui reçoit le projet tape `uv sync` et obtient le même environnement.

Côté VS Code, rien à configurer : le `.venv` est trouvé comme tout venv.
Avec l'extension Python Environments, `python-envs.alwaysUseUv` (vrai par
défaut) fait que « Create Environment » passe par `uv venv` dès qu'uv est
dans le `PATH`.

## pixi

pixi (prefix.dev) installe les mêmes paquets que conda, depuis conda-forge
par défaut, donc aussi des programmes qui ne sont pas du Python, comme
pandoc ou ffmpeg. Il décrit l'environnement dans un fichier du projet, à la
façon d'uv. pixi est un programme à part, qui s'installe sans droits
d'administrateur. Sous Windows, dans un PowerShell :

```
powershell -ExecutionPolicy ByPass -c "irm -useb https://pixi.sh/install.ps1 | iex"
```

Sous macOS et Linux, dans le Terminal :

```
curl -fsSL https://pixi.sh/install.sh | sh
```

Fermer puis rouvrir le terminal. Usage minimal, dans le dossier d'un
projet :

```
pixi init
pixi add python pandoc
pixi run python script.py
```

`pixi init` crée `pixi.toml`, qui décrit le projet ; `pixi add` y inscrit
les paquets, met à jour `pixi.lock` (les versions exactes) et les installe
dans le dossier `.pixi` du projet ; `pixi run` exécute une commande dans
cet environnement. `pixi shell` ouvre un terminal où l'environnement est
activé. Quelqu'un qui reçoit le projet tape `pixi install` et obtient le
même environnement.

## Lequel choisir

| | conda | venv | uv | pixi |
|---|---|---|---|---|
| Paquets | conda-forge : Python et autres programmes | PyPI : Python seulement | PyPI : Python seulement | conda-forge, et PyPI en plus |
| Où est l'environnement | un dossier par environnement, dans `envs` | `.venv`, dans le projet | `.venv`, dans le projet | `.pixi`, dans le projet |
| Fichier qui le décrit | `environment.yml`, facultatif | `requirements.txt`, facultatif | `pyproject.toml` et `uv.lock` | `pixi.toml` et `pixi.lock` |
| Installe un Python | oui | non, il réutilise celui qui le lance | oui | oui |

conda installe des paquets qui ne sont pas du Python (pandoc, ffmpeg,
ImageMagick, typst), et c'est la raison du choix du module. venv et uv ne
connaissent que PyPI, donc que des paquets Python et les bibliothèques
qu'ils embarquent. En échange, ils sont plus rapides, et `pyproject.toml`
est le format que la plupart des projets Python publient.

Pour un projet personnel, hors des contraintes des postes de la salle, uv
convient quand tous les paquets sont sur PyPI, et pixi quand il faut aussi
des programmes de conda-forge. Tous deux recréent l'environnement à
l'identique depuis les fichiers du projet.
