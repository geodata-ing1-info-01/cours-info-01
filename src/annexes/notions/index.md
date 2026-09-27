---
title: Notions
---

Ces pages expliquent ce que les pages de configuration et de problèmes
tiennent pour acquis :

- [Les terminaux en ligne de commande](terminaux.md) : `cmd`, PowerShell,
  l'invite de commandes d'Anaconda, et Python comme troisième interpréteur.
- [Variables d'environnement et recherche des programmes](variables_environnement.md) :
  ce que contient `PATH`, comment le terminal trouve un programme quand
  on tape son nom, et comment afficher son chemin.
- [Les environnements conda](environnements.md) : ce qu'est un
  environnement, ce que change son activation, et le contenu des scripts
  d'activation.
- [Comment VS Code gère les environnements Python](vscode_environnements.md) :
  comment il les trouve, comment il en choisit un, et ce qu'il fait quand
  on lui demande d'en créer un.
- [Git Bash : une fenêtre, bash et des programmes](git_bash.md) : ce que
  contient Git for Windows, comment bash trouve `git` et `ls`, et pourquoi
  Cmder, conda et VS Code donnent le même bash.

```{toctree}
:maxdepth: 1

terminaux
variables_environnement
environnements
vscode_environnements
git_bash
```
