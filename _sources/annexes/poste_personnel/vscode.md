---
title: VS Code
subtitle: Installer VS Code chez soi, régler le terminal et les chemins de conda
---

Télécharger VS Code sur <https://code.visualstudio.com>. Sous Windows,
prendre le « User Installer » : il s'installe dans le profil, sans droits
d'administrateur. Puis suivre les pages de la salle, [VS
Code](../configuration/vscode.md) et [Python et environnement
conda](../configuration/vscode_python.md), en changeant les chemins comme
le décrit cette page.

## Les réglages du compte sous Windows

Les réglages de la salle ([Fichiers de
réglages](../configuration/vscode_reglages.md)) nomment
`C:\ProgramData\anaconda3`. Avec Miniforge, ils deviennent, en remplaçant
`<nom>` par le nom du dossier du compte (`echo %USERPROFILE%`, dans la
Miniforge Prompt, affiche le chemin complet) :

```json
{
  "python.condaPath": "C:\\Users\\<nom>\\miniforge3\\Scripts\\conda.exe",
  "python.defaultInterpreterPath": "C:\\Users\\<nom>\\miniforge3\\envs\\info01\\python.exe",
  "python-envs.defaultEnvManager": "ms-python.python:conda",
  "python-envs.defaultPackageManager": "ms-python.python:conda",
  "terminal.integrated.profiles.windows": {
    "Miniforge Prompt": {
      "path": "C:\\Windows\\System32\\cmd.exe",
      "args": ["/K", "C:\\Users\\<nom>\\miniforge3\\Scripts\\activate.bat", "C:\\Users\\<nom>\\miniforge3"]
    }
  },
  "terminal.integrated.defaultProfile.windows": "Miniforge Prompt",
  "editor.renderWhitespace": "all",
  "files.autoSave": "afterDelay"
}
```

`python.defaultInterpreterPath` désigne le Python de `info01`,
l'environnement du module ([Python et conda](conda.md)). Le profil
« Miniforge Prompt » reprend la cible du raccourci du même nom, dans le
menu Démarrer. Git Bash n'a pas besoin de profil : l'installateur de Git
for Windows le place dans `C:\Program Files\Git`, où VS Code le trouve
seul ([Git et éditeurs de texte](git_outils.md)).

## Le terminal selon le système

Sous macOS et Linux, le terminal de VS Code lit les fichiers que
l'installateur de Miniforge a modifiés, et l'invite commence par `(base)`.
Il n'y a rien à régler. L'extension Python trouve en général conda dans
`~/miniforge3`. Sinon, donner son chemin complet dans `python.condaPath` :
`/Users/<nom>/miniforge3/bin/conda` sous macOS,
`/home/<nom>/miniforge3/bin/conda` sous Linux.

Sous Windows, le terminal par défaut de VS Code est un PowerShell. Le
profil « Miniforge Prompt » ci-dessus le remplace. Pour garder PowerShell,
il faut autoriser les scripts pour le compte et initialiser conda, comme le
décrit [Python et conda](conda.md), section conda dans les autres
terminaux. Sans cela, le terminal affiche `activate.ps1 cannot be loaded
because running scripts is disabled` ({ref}`A7 <dep-a7>`).

## L'alias python du Microsoft Store

Sous Windows, si `python` répond « Python n'a pas été trouvé ; exécutez
sans arguments pour l'installer à partir du Microsoft Store »
({ref}`V7 <dep-v7>`), Windows lance un raccourci vers le Microsoft Store au
lieu du Python de conda. Pour le désactiver : Paramètres, Applications,
Paramètres avancés des applications, Alias d'exécution d'application, et
désactiver `python.exe` et `python3.exe`.
