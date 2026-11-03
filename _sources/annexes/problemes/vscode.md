---
title: Problèmes avec VS Code
---

La configuration de VS Code est dans [Installation et
configuration](../configuration/vscode.md) : [généralités](../configuration/vscode.md),
[Python et environnement conda](../configuration/vscode_python.md),
[notebooks](../configuration/vscode_notebooks.md).

(dep-vscode)=
## Problèmes

(dep-v1)=
### V1. VS Code n'est pas dans le menu Démarrer

Ce qu'on voit
: Rien ne répond à `visual studio code` ni à `code`.

Vérifier
: Dans un `cmd`, `dir "%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe"`
  puis `dir "%ProgramFiles%\Microsoft VS Code\Code.exe"`.

Remède
: Si l'un des deux fichiers existe, double-cliquer dessus dans
  l'explorateur, puis clic droit sur l'icône de la barre des tâches,
  « Épingler à la barre des tâches ». Si aucun n'existe, VS Code n'est pas
  sur le poste : le signaler.

(dep-v2)=
### V2. VS Code ne trouve pas Python selon d'où on l'a lancé

Ce qu'on voit
: Lancé depuis Navigator, VS Code propose `base` et son terminal trouve
  `python`. Lancé depuis le menu Démarrer, ni l'un ni l'autre. Ou l'inverse
  selon les réglages déjà faits.

Cause
: Un programme reçoit de celui qui le lance la liste des dossiers où
  chercher les commandes. Navigator, qui s'exécute dans `base`, transmet à VS
  Code une liste qui contient Anaconda ; le menu Démarrer transmet celle du
  compte, qui ne le contient pas ({ref}`A2 <dep-a2>`).

Remède
: Toujours lancer VS Code depuis le menu Démarrer, une fois l'interpréteur
  et le terminal réglés ([Python et environnement
  conda](../configuration/vscode_python.md)). Le résultat ne dépend alors ni de Navigator ni d'une fenêtre
  ouverte avant.

(dep-v3)=
### V3. L'extension Python ne s'installe pas

Ce qu'on voit
: Le panneau Extensions reste vide, ou affiche « We cannot connect to the
  Extensions Marketplace », ou l'installation ne finit pas.

Cause
: Les extensions viennent d'un serveur. Sans session réseau
  ({ref}`R1 <dep-r1>`) ou derrière un proxy ({ref}`R2 <dep-r2>`), VS Code
  ne l'atteint pas.

Vérifier
: Ouvrir <https://marketplace.visualstudio.com> dans Firefox.

Remède
: Ouvrir la session réseau et relancer l'installation. Sans réseau, une
  extension s'installe depuis un fichier `.vsix` : panneau Extensions,
  bouton `…` en haut, « Install from VSIX… ». L'extension Python en
  demande deux autres, Pylance et Python Debugger, à installer de la même
  façon [à décider : fournir les `.vsix` avec l'archive du TD].

(dep-v4)=
### V4. « Restricted Mode » : l'extension Python ne fait rien

Ce qu'on voit
: « Restricted Mode » en bas de la fenêtre. « Python: Select Interpreter »
  n'est pas dans la palette. Aucun terminal ne s'ouvre, ou VS Code demande
  d'abord si on fait confiance au dossier.

Cause
: Le dossier ouvert n'a pas été approuvé, et l'extension Python ne se
  charge que dans un dossier approuvé.

Remède
: Cliquer sur « Restricted Mode » en bas de la fenêtre, puis « Trust ». Ou
  palette, « Workspaces: Manage Workspace Trust ».

(dep-v5)=
### V5. Le terminal de VS Code affiche une erreur dès qu'il s'ouvre

Ce qu'on voit
: À chaque nouveau terminal, une ligne de commande s'écrit toute seule,
  puis `… activate.ps1 cannot be loaded because running scripts is disabled
  on this system` ({ref}`A7 <dep-a7>`), `'conda' n'est pas reconnu`
  ({ref}`A2 <dep-a2>`), ou `CondaError: Run 'conda init' before 'conda
  activate'`. L'invite ne commence pas par `(base)`.

Cause
: Le terminal est un PowerShell, qui ne peut pas activer l'environnement
  sur les postes de la salle. Ou c'est un « Command Prompt » ordinaire, où
  l'extension Python tape `conda activate base` : cette commande ne marche
  dans un `cmd` qu'après un `conda init cmd.exe`, rarement fait sur les
  postes.

Remède
: Faire le réglage du terminal, profil « Anaconda Prompt » ([Python et
  environnement conda](../configuration/vscode_python.md)). S'il est fait
  et que l'erreur reste : vérifier que le fichier a été enregistré, que
  l'onglet du terminal s'appelle « Anaconda Prompt », que les chemins sont
  ceux du raccourci « Anaconda Prompt », et faire palette, « Developer: Reload
  Window ». Si le fichier de réglages est souligné en rouge :
  {ref}`V10 <dep-v10>`.

(dep-v6)=
### V6. « Python: Select Interpreter » ne propose pas Anaconda

Ce qu'on voit
: La liste ne contient que « Enter interpreter path… », ou des Python qui
  ne sont pas celui d'Anaconda (`C:\Python27`, le Python du Microsoft
  Store).

Cause
: L'extension cherche Anaconda à plusieurs endroits du poste, dont
  `C:\ProgramData\anaconda3`. Elle ne le trouve pas quand il est installé
  ailleurs, ou quand la recherche a échoué une fois et que son résultat
  est resté en cache.

Remède
: Cliquer « Enter interpreter path… », puis « Find… », et choisir le fichier
  `C:\ProgramData\anaconda3\python.exe`. Pour que la liste devienne
  complète (avec les environnements du TD 1h) : le réglage
  `python.condaPath`, décrit dans [Python et environnement
  conda](../configuration/vscode_python.md), puis « Developer: Reload
  Window ». Le chemin exact est celui du raccourci « Anaconda Prompt »
  ({ref}`A1 <dep-a1>`).

(dep-v7)=
### V7. `python` lance un autre Python que celui d'Anaconda

Ce qu'on voit
: « Python n'a pas été trouvé ; exécutez sans arguments pour l'installer à
  partir du Microsoft Store… ». Ou `Python 2.7`. Ou `ModuleNotFoundError`
  sur un module qui est pourtant dans `base`.

Cause
: Sans environnement activé ({ref}`A3 <dep-a3>`), `python` est le premier
  `python.exe` que Windows trouve : souvent un raccourci du Microsoft Store
  qui ne fait que proposer une installation, ou un vieux Python du poste
  ([Variables d'environnement](../notions/variables_environnement.md)).

Vérifier
: `where python` dans le terminal liste tous les `python.exe` trouvés,
  dans l'ordre. `python -c "import sys; print(sys.executable)"` dit lequel
  répond.

Remède
: Employer un terminal `cmd` activé, par le réglage du terminal ([Python et
  environnement conda](../configuration/vscode_python.md)). Le bouton Run
  n'est pas concerné : il lance l'interpréteur choisi, par son chemin
  complet.

(dep-v8)=
### V8. `ModuleNotFoundError` alors que le paquet est installé

Ce qu'on voit
: `ModuleNotFoundError: No module named 'pandas'` (ou un autre), alors que
  `conda list` dit que le paquet est là.

Cause
: Le paquet est dans un environnement, et le programme s'exécute dans un
  autre. Trois choix indépendants désignent l'environnement : l'interpréteur
  (bouton Run), le terminal (ce qui y est activé), le noyau du notebook.

Vérifier
: Dans chacun des trois, `import sys; print(sys.executable)` : les chemins
  doivent être identiques. `conda list -n <env> <paquet>` dit dans quel
  environnement le paquet est.

Remède
: Choisir le même environnement aux trois endroits ([Python et
  environnement conda](../configuration/vscode_python.md),
  {ref}`J4 <dep-j4>`), ou installer le paquet dans celui qui s'exécute :
  `conda install -n <env> -c conda-forge <paquet>`.

(dep-v9)=
### V9. Le raccourci clavier du terminal ne répond pas

Ce qu'on voit
: `Ctrl` + `ù` n'ouvre rien, ou ouvre autre chose.

Cause
: Le raccourci dépend de la disposition du clavier, et le poste n'a pas
  forcément celle attendue.

Remède
: Menu Terminal, New Terminal. Ou palette, « Terminal: Create New
  Terminal ».

(dep-v10)=
### V10. Le fichier de réglages est souligné en rouge, ou ne s'enregistre pas

Ce qu'on voit
: « Unable to write into user settings. Please open the user settings to
  correct errors/warnings in it and try again ». Ou un réglage ajouté qui
  ne produit rien, avec une ligne soulignée en rouge dans `settings.json`.

Cause
: Une erreur de syntaxe dans le fichier : virgule manquante entre deux
  réglages, virgule en trop avant l'accolade finale, barre oblique inverse
  simple dans un chemin.

Vérifier
: Palette, « Preferences: Open User Settings (JSON) ». Le panneau Problems
  (`Ctrl` + `Maj` + `M`) indique la ligne.

Remède
: Corriger la ligne indiquée. Chaque réglage est séparé du suivant par une
  virgule ; le dernier n'en a pas ; les chemins s'écrivent avec `\\`. En
  cas de doute, passer par l'interface : palette, « Preferences: Open
  Settings (UI) », qui écrit le fichier elle-même.

(dep-v11)=
### V11. « Error loading webview: Could not register service worker »

Ce qu'on voit
: À l'ouverture de l'aperçu Markdown (`Ctrl` + `Maj` + `V`), d'un
  notebook ou de la page des réglages, un cadre vide avec `Error loading
  webview: Error: Could not register service worker: InvalidStateError:
  Failed to register a ServiceWorker: The document is in an invalid
  state`.

Cause
: Ces vues sont des pages web internes, servies par un programme de cache
  du navigateur intégré, le *service worker*. Son cache est dans le profil
  du compte, `C:\Users\<nom>\AppData\Roaming\Code\Service Worker`. Quand
  il a été écrit par une version antérieure de VS Code, la version en
  place ne parvient plus à l'enregistrer. Sur les postes de la salle, le
  profil date de la création de l'image et a traversé plusieurs mises à
  jour de VS Code.

Vérifier
: Dans l'explorateur de fichiers, la date de modification du dossier
  `Service Worker` est antérieure au dernier démarrage de VS Code.

Remède
: D'abord palette, « Developer: Reload Webviews », qui suffit parfois pour
  la session. Sinon, fermer VS Code entièrement, puis dans un `cmd`
  supprimer les caches, que VS Code recrée au démarrage suivant :

  ```
  rmdir /s /q "%APPDATA%\Code\Service Worker"
  rmdir /s /q "%APPDATA%\Code\Cache"
  rmdir /s /q "%APPDATA%\Code\Code Cache"
  rmdir /s /q "%APPDATA%\Code\CachedData"
  rmdir /s /q "%APPDATA%\Code\GPUCache"
  ```

  Les réglages (`User\`), les extensions et l'historique des fichiers
  ouverts ne sont pas dans ces dossiers. Relancer VS Code et rouvrir
  l'aperçu. Si l'erreur reste, un antivirus ou une stratégie empêche
  l'écriture dans `Service Worker` : lancer `code --verbose` depuis un
  `cmd` affiche le refus dans la console.
