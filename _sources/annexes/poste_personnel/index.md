---
title: Configuration d'un ordinateur personnel
subtitle: Installer chez soi les outils du module, et ce qui change par rapport à la salle
---

Les pages sur la configuration des postes de la salle valent aussi chez soi
pour l'usage des outils. Sur un ordinateur personnel, on a les droits
d'administrateur, il n'y a pas de session réseau à ouvrir, et le système
peut être Windows, macOS ou Linux. Les pages suivantes décrivent ce qui
change : l'installation, les chemins et le terminal. Les outils
s'installent dans cet ordre :

1. [Python et conda](conda.md) : Miniforge, les canaux, l'environnement du
   module, et conda dans les terminaux ;
2. [VS Code](vscode.md) : l'installation, le terminal selon le système, les
   chemins à changer dans les réglages ;
3. [Git et éditeurs de texte](git_outils.md) : git et Git Bash, Notepad++,
   LibreOffice.

## Correspondance avec la salle

Les pages de cours et les TD décrivent les postes de la salle. Avec
Miniforge, installé comme le décrit [Python et conda](conda.md), les noms
changent ainsi :

| Dans la salle | Sur un ordinateur personnel |
|---|---|
| Anaconda, dans `C:\ProgramData\anaconda3` | Miniforge, dans `C:\Users\<nom>\miniforge3` sous Windows, `~/miniforge3` sous macOS et Linux |
| l'invite de commandes d'Anaconda, « Anaconda Prompt » | « Miniforge Prompt » sous Windows, le Terminal sous macOS et Linux |
| l'environnement `base`, qui contient JupyterLab, numpy, Pillow et pandoc | l'environnement `info01`, créé une fois ([Python et conda](conda.md)) |
| Anaconda Navigator | pas d'équivalent : les outils se lancent depuis un terminal |
| Spyder, dans `base` | à installer dans un environnement, s'il sert : `conda install -n info01 spyder` |

Là où un TD emploie l'environnement `base`, activer `info01` à la place.
Les TD qui ont leur propre environnement le créent depuis leur fichier
`environment.yml`, comme dans la salle.

```{toctree}
:maxdepth: 1

conda
vscode
git_outils
```
