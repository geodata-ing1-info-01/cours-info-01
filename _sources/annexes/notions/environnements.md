---
title: Les environnements conda
subtitle: Ce qu'est un environnement, ce que fait son activation, et les scripts qui la font
---

## Un environnement

Un environnement est un dossier qui contient un Python et les paquets
installés avec lui. Anaconda en crée un à l'installation, `base`, dans
`C:\ProgramData\anaconda3` sur les postes de la salle. On peut en créer
d'autres, chacun avec son Python et ses paquets, indépendants des autres :
un projet qui a besoin d'une version précise d'une bibliothèque a le sien,
et un environnement abîmé se supprime sans toucher aux autres. Sur les
postes de la salle, c'est aussi le seul moyen d'installer un paquet, parce
que `base` n'est pas modifiable par un compte élève ; les environnements du
compte vont dans `C:\Users\<nom>\.conda\envs`.

L'outil qui crée, liste et supprime les environnements est `conda`. Les
commandes qui reviennent dans le module :

| Commande | Ce qu'elle fait |
|---|---|
| `conda create -n recette -c conda-forge python pandoc` | crée l'environnement `recette`, avec Python et pandoc pris sur le canal conda-forge |
| `conda activate recette` | active `recette` dans la fenêtre |
| `conda deactivate` | revient à l'environnement précédent |
| `conda env list` | liste les environnements connus, avec une étoile devant l'actif |
| `conda list -n recette` | liste les paquets de `recette` |
| `conda install -n recette -c conda-forge ipykernel` | ajoute un paquet à `recette` |
| `conda info` | affiche l'environnement actif et les dossiers que conda emploie |

## Ce que change l'activation

À tout moment, dans une fenêtre de terminal, un environnement au plus est
actif ; son nom est écrit entre parenthèses en tête de l'invite. Activer
un environnement ne lance aucun programme : cela modifie des variables
d'environnement de la fenêtre
([Variables d'environnement](variables_environnement.md)) :

- `PATH` reçoit en tête les dossiers de l'environnement
  (`C:\ProgramData\anaconda3`, `…\Scripts`, `…\Library\bin`, et quelques
  autres). Comme le terminal parcourt `PATH` dans l'ordre, `python`,
  `conda`, `jupyter` désignent désormais ceux de l'environnement, avant
  tout autre Python du poste ;
- `CONDA_PREFIX` reçoit le dossier de l'environnement, et
  `CONDA_DEFAULT_ENV` son nom ; d'autres programmes les lisent pour savoir
  dans quel environnement ils tournent ;
- l'invite reçoit `(base)` ou `(recette)` en tête.

Ces modifications ne valent que pour cette fenêtre. Un autre `cmd` ouvert
depuis le menu Démarrer ne les a pas : `python` y désigne un autre Python,
ou aucun, et `conda` n'y est pas reconnu ({ref}`A2 <dep-a2>`,
{ref}`V7 <dep-v7>`). L'invite de commandes d'Anaconda est un `cmd` dans lequel cette
activation a été faite à l'ouverture ([Les terminaux](terminaux.md)).

## Les scripts d'activation

L'activation est faite par des fichiers de commandes, un par
interpréteur. Pour `cmd`, c'est `C:\ProgramData\anaconda3\Scripts\activate.bat`,
celui que le raccourci « Anaconda Prompt » exécute. Son contenu, débarrassé
de ses commentaires :

```bat
@SET "_args1=%1"
@SET _args1_first=%_args1:~0,1%
@SET _args1_last=%_args1:~-1%
@SET _args1_first=%_args1_first:"=+%
@SET _args1_last=%_args1_last:"=+%
@SET _args1=

@IF "%_args1_first%"=="+" IF NOT "%_args1_last%"=="+" @(
    @CALL "%~dp0..\condabin\conda.bat" activate
    @GOTO :CLEANUP
)

@CALL "%~dp0..\condabin\conda.bat" activate %*

:CLEANUP
@SET _args1_first=
@SET _args1_last=
```

Les six premières lignes et le `IF` corrigent un cas particulier de
guillemets dans le raccourci. L'essentiel tient en une ligne : `CALL
"…\condabin\conda.bat" activate <environnement>`, qui demande à conda
d'activer l'environnement reçu en argument (`C:\ProgramData\anaconda3`,
c'est-à-dire `base`). Le `@` en tête de chaque ligne empêche `cmd`
d'afficher la commande avant de l'exécuter.

`conda.bat activate` ne modifie pas les variables lui-même : il lance
`conda.exe`, qui calcule les nouvelles valeurs et les écrit dans un petit
fichier de commandes temporaire, puis il exécute ce fichier et le
supprime. Ce fichier généré, avec les valeurs des postes de la salle,
contient :

```bat
@SET "PATH=C:\ProgramData\anaconda3;C:\ProgramData\anaconda3\Library\mingw-w64\bin;C:\ProgramData\anaconda3\Library\usr\bin;C:\ProgramData\anaconda3\Library\bin;C:\ProgramData\anaconda3\Scripts;C:\ProgramData\anaconda3\bin;C:\ProgramData\anaconda3\condabin;C:\Windows\System32;…"
@SET "CONDA_PREFIX=C:\ProgramData\anaconda3"
@SET "CONDA_SHLVL=1"
@SET "CONDA_DEFAULT_ENV=base"
@SET "CONDA_PROMPT_MODIFIER=(base) "
@SET "CONDA_EXE=C:\ProgramData\anaconda3\Scripts\conda.exe"
@SET "CONDA_PYTHON_EXE=C:\ProgramData\anaconda3\python.exe"
```

Chaque ligne est un `SET`, la commande de `cmd` qui donne une valeur à une
variable d'environnement. `conda activate recette`, tapé plus tard dans la
même fenêtre, refait exactement cela avec les dossiers de `recette` ;
`conda deactivate` remet les valeurs précédentes.

Les autres interpréteurs ont leur script, qui fait la même chose dans
leur langage : `conda-hook.ps1` pour PowerShell (un fichier `.ps1`, que
le réglage des postes de la salle bloque, {ref}`A7 <dep-a7>`), `conda.sh`
pour `bash` et `zsh` sous macOS et Linux, chargé au démarrage du terminal
par une ligne que `conda init` a écrite dans `~/.bashrc` ou `~/.zshrc`.
