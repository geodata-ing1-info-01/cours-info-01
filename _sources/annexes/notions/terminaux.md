---
title: Les terminaux en ligne de commande
subtitle: cmd, PowerShell, l'invite de commandes d'Anaconda, et Python comme troisième interpréteur
---

Un terminal est une fenêtre dans laquelle on tape une commande, puis
Entrée ; la réponse s'affiche en dessous, et l'invite revient pour la
commande suivante. Le programme qui lit la commande et l'exécute s'appelle
un interpréteur de commandes. Windows en a deux ; l'invite de commandes d'Anaconda est
l'un des deux, ouvert avec un réglage particulier.

## Les deux interpréteurs de Windows

| | `cmd` | PowerShell |
|---|---|---|
| Nom complet | Invite de commandes (`cmd.exe`) | Windows PowerShell (`powershell.exe`) |
| Ouvrir | menu Démarrer, taper `cmd` | menu Démarrer, taper `powershell` |
| Aspect de l'invite | `C:\Users\eleve>` | `PS C:\Users\eleve>` |
| Fichiers de commandes | `.bat`, `.cmd` | `.ps1` |
| Fichiers de commandes sur les postes de la salle | exécutés | bloqués par le réglage de l'école ({ref}`A7 <dep-a7>`) |

Les deux lancent les mêmes programmes : `python`, `conda`, `curl.exe`,
`git`. Ils diffèrent par leurs commandes internes (`dir` dans `cmd`,
`Get-ChildItem` dans PowerShell, qui accepte aussi `dir`), et par la façon
d'écrire un fichier de commandes. `cmd` est le plus ancien et le plus
simple ; PowerShell est le plus complet, et celui que VS Code ouvre par
défaut.

Sous macOS et Linux, l'application Terminal joue le même rôle, avec un
interpréteur nommé `zsh` ou `bash`.

## L'invite de commandes d'Anaconda

L'invite de commandes d'Anaconda, « Anaconda Prompt » dans le menu Démarrer
et dans la documentation d'Anaconda, est un `cmd` dans lequel
l'environnement `base` d'Anaconda a été activé. Le raccourci du menu Démarrer le montre : clic
droit, Propriétés, champ Cible :

```
%windir%\System32\cmd.exe "/K" C:\ProgramData\anaconda3\Scripts\activate.bat C:\ProgramData\anaconda3
```

Lu de gauche à droite : lancer `cmd.exe` ; `/K` lui demande d'exécuter ce
qui suit puis de rester ouvert ; ce qui suit est le script `activate.bat`,
avec le dossier d'Anaconda en argument. Ce script active l'environnement
`base` dans la fenêtre ([Les environnements conda](environnements.md)).

Anaconda installe aussi un raccourci « Anaconda PowerShell Prompt », qui
fait la même chose dans PowerShell. Sur les postes de la salle, il peut
échouer, parce qu'il passe par un fichier `.ps1` ({ref}`A7 <dep-a7>`).

## Trois interpréteurs, trois langages

`cmd` et PowerShell sont des interpréteurs : chacun lit une ligne, l'exécute,
et attend la suivante. Chacun a son langage : `dir`, `set`, `call` pour
`cmd` ; `Get-ChildItem`, `$env:PATH` pour PowerShell.

Python est un interpréteur au même sens. `python.exe` lancé seul, sans
nom de fichier, ouvre une session où l'on tape une ligne de Python, Entrée,
et lit le résultat ; l'invite y est `>>>`. C'est un terminal dont le
langage est Python :

```
(base) C:\Users\eleve>python
Python 3.13.5 | packaged by Anaconda, Inc. | … on win32
Type "help", "copyright", "credits" or "license" for more information.
>>> 2 + 3
5
>>> exit()

(base) C:\Users\eleve>
```

`exit()` puis Entrée revient à `cmd`. Les trois interpréteurs se ressemblent
donc ; ce qui les distingue est le langage qu'ils lisent, et donc ce qu'on
peut leur demander : `cmd` et PowerShell servent à lancer des programmes et
à manipuler des fichiers, Python à calculer.

## Les scripts

Un script est un fichier qui contient des lignes dans le langage d'un
interpréteur, que l'interpréteur lit à la suite au lieu d'attendre qu'on
les tape. Un fichier `.bat` est un script pour `cmd`, un `.ps1` un script
pour PowerShell, un `.py` un script pour Python. Lancer un script, c'est
donner le fichier à son interpréteur :

| Interpréteur | Script | Lancement |
|---|---|---|
| `cmd` | `collecte.bat` | `cmd /K collecte.bat`, ou double-clic |
| PowerShell | `collecte.ps1` | `powershell -File collecte.ps1` (bloqué sur les postes) |
| Python | `altitudes.py` | `python altitudes.py`, ou le bouton Run de VS Code |

`activate.bat`, que le raccourci « Anaconda Prompt » exécute, est un script
`cmd` ; ce qu'il fait est décrit dans
[Les environnements conda](environnements.md).

## Le terminal de VS Code

Le terminal intégré de VS Code est l'un de ces interpréteurs, ouvert dans
un panneau de l'éditeur. Par défaut c'est PowerShell ; le réglage décrit
dans [Python et environnement conda](../configuration/vscode_python.md)
lui substitue un `cmd` lancé avec `activate.bat`, exactement comme le
raccourci « Anaconda Prompt ».
