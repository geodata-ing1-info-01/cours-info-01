# Diagnostic VS Code / Anaconda sur les postes de la salle

> Version pour les élèves, par symptôme : `src/avant/` du book (vérifier le
> réseau, les logiciels de texte, Anaconda) et `src/annexes/`
> (`configuration/` : Anaconda, JupyterLab, VS Code en trois pages,
> ordinateur personnel ; `faq.md` puis `problemes/`, une page par outil avec
> ses entrées numérotées R, B, A, X, J, V, G). Ce
> protocole-ci reste l'outil de l'enseignant pour établir la cause sur un
> poste ; ses conclusions alimentent les entrées des annexes. La section D,
> en fin de fichier, liste ce qui relève de l'image des postes.

Deux temps. D'abord un relevé de l'état du poste, par `collecte.cmd` qui
écrit un rapport texte à rapporter sur clé USB, ou à la main (section A bis)
si le script ne peut pas tourner. Ensuite une série de
tests dans VS Code, numérotés, à jouer dans l'ordre : chaque test isole un
maillon (shell, découverte, sélection, Jupyter), et son échec désigne la
section suivante à lire. Compter vingt minutes sur un poste, et le refaire sur
un second poste pour distinguer ce qui tient à l'image de ce qui tient au
compte.

Ce que le protocole doit établir, dans l'ordre :

1. quelle génération d'extension Python est active (classique ou Python
   Environments) ;
2. si `conda` est *découvert* par VS Code, indépendamment du terminal ;
3. si le terminal par défaut sait *activer* un environnement ;
4. si Jupyter reçoit la liste des environnements et sait lancer un noyau ;
5. ce qui survit à un redémarrage de la VM.

## A. Relevé automatique : `collecte.cmd`

Copier le script sur le bureau, double-cliquer, attendre `Termine`. Le rapport
`diagnostic_<poste>_<utilisateur>.txt` est écrit à côté du script (sinon sur
le Bureau, sinon à la racine du profil ; le chemin s'affiche à la fin). Il se
lit section par section, et chaque section commence par une ligne « Ce qu'on
regarde » qui résume la colonne de droite ci-dessous :

| Section | Ligne à lire | Ce qu'elle décide |
|---|---|---|
| 0 | réponse de `curl.exe -sS -I -m 10` | une ligne `HTTP/…` = la session réseau est ouverte ; rien en 10 s ou `Could not resolve host` = à ouvrir (raccourci d'authentification) ; `407` ou certificat = proxy |
| 1 | `APPDATA=` | un chemin `\\serveur\…` ou hors `C:` = profil itinérant : verrou de Navigator et réglages sur le réseau |
| 2 | `ms-python.python@…`, `ms-python.vscode-python-envs@…`, `ms-toolsai.jupyter@…` | versions ; présence de l'extension Environments |
| 2 | `settings.json` User | `python.useEnvironmentsExtension`, `python.condaPath`, `terminal.integrated.defaultProfile.windows` déjà posés ? |
| 3 | `MachinePolicy` / `UserPolicy` | `Undefined` = pas de GPO, `Set-ExecutionPolicy -Scope CurrentUser` est possible ; sinon inutile |
| 3 | `LocalMachine`, `CurrentUser` | `Restricted` attendu sur Windows PowerShell 5.1 |
| 3 | `where pwsh` | s'il existe, VS Code le prend comme PowerShell par défaut |
| 3 | `conda initialize` dans un profil | un `conda init powershell` a été fait ; sous `Restricted` c'est le profil lui-même qui est refusé |
| 4 | `where conda` | vide = conda hors PATH : la découverte par PATH échoue, tout repose sur les emplacements connus et le registre |
| 4 | `where python` | qui répond en premier (Anaconda, `C:\Python27`, alias Store) |
| 5 | cible du raccourci « Anaconda Prompt » | chemin réel d'Anaconda, à recopier dans le profil cmd et dans `python.condaPath` |
| 5 | `environments.txt` | absent pour ce compte = l'image a été faite sous un autre compte ; une source de découverte en moins |
| 6 | `PythonCore\2.7`, `ContinuumAnalytics` | d'où vient le 2.7 ; Anaconda est-il inscrit au registre |
| 7 | `conda info` → `envs directories`, `conda env list` | ce que conda lui-même connaît ; référence pour comparer avec ce que VS Code affiche |
| 7 | `ipykernel` dans base | sinon Jupyter proposera de l'installer, ce qui passe par le terminal |
| 9 | `Python.log`, `Python Environments.log` | lignes `Probing conda binary`, `Conda not found`, `running scripts is disabled` |
| 10 | `pythonw.exe` dans `tasklist`, fin de `navigator.log` | un `pythonw.exe` sans fenêtre = instance Navigator bloquée (« already running ») ; le journal dit sur quoi elle attendait (`anaconda.cloud`, mise à jour, `conda info`) |

## A bis. Le même relevé à la main

Si le script ne se lance pas (blocage des `.cmd` par stratégie, droits
insuffisants, clé USB en lecture seule), tout se relève depuis un `cmd`
ordinaire (menu Démarrer, taper `cmd`), commande par commande. Les numéros
renvoient aux sections du rapport. Noter les réponses telles quelles ; une
capture d'écran de la fenêtre suffit.

**A0. Réseau.**
```
curl.exe -sS -I -m 10 https://repo.anaconda.com
netsh winhttp show proxy
```
(`curl.exe` avec son extension : dans PowerShell, `curl` seul est un alias
d'`Invoke-WebRequest`.)

**A1. Poste.**
```
ver
echo %USERNAME% %COMPUTERNAME% %USERDOMAIN%
echo %APPDATA%  et  echo %PROGRAMDATA%
```

**A2. VS Code.** Si `code` n'est pas reconnu, aller dans le dossier de
l'exécutable : `cd "%LOCALAPPDATA%\Programs\Microsoft VS Code\bin"` (installation
utilisateur) ou `cd "%ProgramFiles%\Microsoft VS Code\bin"` (installation
machine).
```
code --version
code --list-extensions --show-versions
type "%APPDATA%\Code\User\settings.json"
```
Sans ligne de commande du tout : dans VS Code, Aide → À propos (version), le
panneau Extensions (`Ctrl+Maj+X`) filtre `@installed` (versions), palette
« Preferences: Open User Settings (JSON) » (réglages User).

**A3. PowerShell.** Ouvrir un PowerShell ordinaire (menu Démarrer), sans
droits particuliers : ce sont des commandes, pas des scripts, donc
`Restricted` les laisse passer.
```
$PSVersionTable.PSVersion
Get-ExecutionPolicy -List
Test-Path $PROFILE ; $PROFILE
Select-String "conda initialize" $PROFILE
```
Retour dans cmd : `where pwsh` (PowerShell 7 présent ?) et
`reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell"`,
`reg query "HKCU\SOFTWARE\Policies\Microsoft\Windows\PowerShell"`
(« ERROR: … unable to find » = pas de GPO PowerShell).

**A4. PATH et variables.**
```
echo %PATH%
set CONDA
set JUPYTER
where python
where conda
where jupyter
dir "%LOCALAPPDATA%\Microsoft\WindowsApps\python*.exe"
```

**A5. Anaconda.** Menu Démarrer, taper « Anaconda Prompt », clic droit →
Ouvrir l'emplacement du fichier → clic droit sur le raccourci → Propriétés →
champ Cible : recopier la ligne entière (elle contient `activate.bat` et le
dossier d'Anaconda). Puis, avec ce dossier (ci-dessous `C:\ProgramData\anaconda3`,
à adapter) :
```
dir "C:\ProgramData\anaconda3\Scripts\conda.exe"
dir "C:\ProgramData\anaconda3\Scripts\activate.bat"
dir "C:\ProgramData\anaconda3\condabin\conda.bat"
dir "C:\ProgramData\anaconda3\shell\condabin\conda-hook.ps1"
type "%USERPROFILE%\.conda\environments.txt"
type "%USERPROFILE%\.condarc"
```
Si le raccourci n'existe pas, tester l'existence des emplacements usuels :
`dir %PROGRAMDATA%\anaconda3`, `dir %USERPROFILE%\anaconda3`, `dir C:\anaconda3`,
`dir %LOCALAPPDATA%\anaconda3`, `dir %USERPROFILE%\miniconda3`.

**A6. Registre.**
```
reg query HKLM\SOFTWARE\Python /s
reg query HKLM\SOFTWARE\WOW6432Node\Python /s
reg query HKCU\SOFTWARE\Python /s
dir C:\Python27
```

**A7. conda.** Dans une invite de commandes d'Anaconda (menu Démarrer), ou dans le cmd après
`call "C:\ProgramData\anaconda3\Scripts\activate.bat" "C:\ProgramData\anaconda3"` :
```
conda --version
conda info
conda env list
conda list -n base ipykernel
python -c "import sys; print(sys.executable)"
jupyter kernelspec list
```

**A8. Kernelspecs.**
```
dir "%APPDATA%\jupyter\kernels"
dir "%PROGRAMDATA%\jupyter\kernels"
dir "C:\ProgramData\anaconda3\share\jupyter\kernels"
```

**A10. Navigator.**
```
tasklist /v /fi "imagename eq pythonw.exe"
dir /s /b "%USERPROFILE%\.anaconda" "%APPDATA%\.anaconda"
```
puis ouvrir `navigator.log` (dans le dossier `logs` trouvé) au Bloc-notes et
lire la fin.

**A9. Journaux.** Plutôt que les fichiers, passer par VS Code : panneau
Output (`Ctrl+Maj+U`), liste déroulante à droite → « Python », « Python
Environments », « Jupyter » ; « Developer: Set Log Level… » → Trace pour la
suite des tests. Les fichiers eux-mêmes sont sous
`%APPDATA%\Code\logs\<date>\window1\exthost\` dans les sous-dossiers de
chaque extension, et « Developer: Open Extension Logs Folder » y mène.

## B. Tests dans VS Code

Préparer un dossier `test_diag` sur le bureau avec `a.py` (une ligne :
`print(1)`) et `b.ipynb` (une cellule : `import sys; print(sys.executable)`),
et un second dossier `test_nb` ne contenant que `b.ipynb`.

Chaque test : ce qu'on fait, ce qu'on doit voir, ce que signifie un échec.
Noter le numéro du premier test qui échoue : c'est l'information utile.

### B1. Lancement depuis le bureau, dossier trusted

Ouvrir VS Code depuis le raccourci du bureau, Fichier → Ouvrir le dossier →
`test_diag`, répondre **Yes, I trust** au bandeau.

Attendu : pas de mention « Restricted Mode » dans la barre d'état.
Échec : refaire « Workspaces: Manage Workspace Trust ». Tant que le dossier
n'est pas trusted, l'extension Python ne se charge pas (`untrustedWorkspaces:
false` dans son manifeste) et aucun test suivant n'a de sens.

### B2. Génération de l'extension Python

Regarder la barre d'activité à gauche.

Attendu : noter s'il y a une icône Python (= extension Python Environments
active) ou non (= extension classique). Palette, « Preferences: Open User
Settings (JSON) », noter la valeur de `python.useEnvironmentsExtension`.

Ce n'est pas un test qui échoue, mais il choisit les commandes des tests
suivants. Si deux postes n'ont pas la même génération, fixer le réglage
explicitement sur tous.

### B3. Découverte, sans terminal

Ouvrir `a.py`. Palette, « Python: Select Interpreter ». Lire la liste.

Attendu : une entrée `base` (ou « Python 3.x ('base') … anaconda3 ») avec
le chemin d'Anaconda relevé en section A5.
Échec : conda n'est pas découvert. Ne pas encore toucher au terminal.

- Nouvelle génération : palette, « Python Environments: Run Python
  Environment Tool (PET) in Terminal… » → « Find All Environments ». La sortie
  liste les gestionnaires trouvés (`conda: <chemin>`) et les environnements.
  `conda` absent de la sortie = aucune des sources (PATH, registre,
  emplacements connus, `environments.txt`) ne l'a vu.
- Classique : Output (Ctrl+Maj+U), canal « Python », « Developer: Set Log
  Level… » → Trace, puis « Python: Clear Cache and Reload Window ». Chercher
  `Probing conda binary` et la ligne qui suit.

Remède à tester dans la foulée : `python.condaPath` au niveau User avec le
chemin de `Scripts\conda.exe` relevé en A5, « Developer: Reload Window »,
refaire B3. Si `base` apparaît, la cause était la découverte, et ce réglage
(ou Anaconda dans le PATH de l'image) suffit pour tous les dossiers.

### B4. Sélection et barre d'état

Choisir `base` dans la liste de B3.

Attendu : la barre d'état affiche `base` et le chemin. Fermer VS Code,
rouvrir le même dossier : le choix est conservé.
Échec à la réouverture : état de workspace non conservé (profil itinérant,
VM réinitialisée, `%APPDATA%\Code\User\workspaceStorage` non inscriptible).

### B5. Terminal par défaut et activation

Terminal → Nouveau terminal. Lire le nom de l'onglet (powershell, pwsh, cmd)
et la première commande que l'extension y écrit, et le message qui suit.

| Ce qu'on lit | Ce que ça signifie |
|---|---|
| onglet cmd, invite `(base)` | activation OK, rien à faire |
| `…\Scripts\activate` puis `conda activate base` et `CommandNotFoundError` / `conda n'est pas reconnu` | extension classique dans PowerShell, sans hook conda, conda hors PATH |
| `conda-hook.ps1 cannot be loaded because running scripts is disabled` | nouvelle extension dans PowerShell, stratégie `Restricted` |
| `profile.ps1 cannot be loaded …` | `conda init powershell` a été fait, le profil est refusé |
| rien n'est écrit dans le terminal | `python.terminal.activateEnvironment` à `false`, ou `python-envs.terminal.autoActivationType` à `off`, ou aucun interpréteur choisi (B4) |

Puis taper `python -c "import sys; print(sys.executable)"`.
Attendu : le `python.exe` d'Anaconda. Si c'est `C:\Python27\…` ou l'alias du
Store, le PATH du terminal ne contient pas Anaconda et l'activation a échoué.

Remède : le profil cmd du TD 1c (`terminal.integrated.profiles.windows` +
`defaultProfile.windows`), niveau User, puis « Developer: Reload Window » et
refaire B5. Si B5 passe alors que B3 échouait, on a un terminal qui marche
mais toujours pas de découverte : les deux sont indépendants.

### B6. Exécution d'un fichier

Bouton Run en haut à droite sur `a.py`.

Attendu : `1` dans le terminal, commande écrite avec le chemin complet du
python d'Anaconda.
Échec avec B5 réussi : rare ; regarder la commande écrite, elle dit quel
python a été retenu.

### B7. Jupyter : liste des noyaux

Ouvrir `b.ipynb`, cliquer « Select Kernel » en haut à droite.

Attendu : soit `base` directement, soit « Select Another Kernel… » → « Python
Environments… » → `base` dans la liste (le premier niveau ne montre que les
noyaux déjà utilisés).
Échec, `base` absent aussi de « Python Environments… » : Jupyter relaie la
liste de l'extension Python. Si B3 réussit et B7 échoue, vérifier
`jupyter.kernels.excludePythonEnvironments` dans les réglages User et dans
`.vscode/settings.json`, puis Output → « Jupyter », niveau Trace, chercher
`base`.

### B8. Jupyter : lancement du noyau

Choisir `base`, exécuter la cellule.

Attendu : le chemin du `python.exe` d'Anaconda.
Échec : Output → « Jupyter », chercher `ipykernel_launcher` et l'erreur qui
suit. Cas typiques : `ipykernel` absent (proposition d'installer ; accepter,
et lire dans quel terminal la commande est tapée), `conda run` en erreur
(la collecte d'environnement pour conda passe par `cmd`, pas par PowerShell,
donc la stratégie d'exécution n'est pas en cause ici), timeout au premier
démarrage (VM lente : réessayer une fois).

### B9. Dossier notebooks seuls

Fermer, ouvrir `test_nb`, accepter le trust, refaire B7 et B8 sans ouvrir
aucun `.py`.

Attendu : identique à B7/B8.
Échec seulement ici : soit le bandeau de trust n'a pas été accepté (B1), soit
le sélecteur a été ouvert avant la fin de la découverte (attendre dix
secondes, « Python Environments: Refresh All Environment Managers », rouvrir
le sélecteur), soit le choix fait en B4 était un chemin entré à la main et
non une découverte : B3 sur ce dossier le dira.

### B10. Lancement depuis Anaconda Navigator

Fermer VS Code. Navigator → fiche VS Code → Launch. Rouvrir `test_diag`,
refaire B3 et B5.

Attendu : B3 réussit même s'il échouait en B1 (conda hérité du PATH de
Navigator), et en B5 `python` est celui d'Anaconda même si l'activation
affiche une erreur.
Ce test ne corrige rien ; il confirme que le problème est le PATH du
processus VS Code, et donc que `python.condaPath` ou le PATH de l'image sont
les bons remèdes.

### B11. Persistance

Créer un fichier vide sur le bureau, poser le réglage `python.condaPath` en
User, redémarrer la VM, se reconnecter.

Attendu : fichier et réglage toujours là.
Échec : la VM est réinitialisée à chaque démarrage. Seuls comptent alors ce
qui est dans l'image (à demander au service informatique : PATH système,
stratégie PowerShell, réglages User dans le profil par défaut) et ce qui
voyage avec le dossier du TD (`.vscode/settings.json`, qui accepte le profil
de terminal et `python.defaultInterpreterPath`, mais pas `python.condaPath`,
de portée `machine`).

## C. Lecture croisée

| B3 | B5 | B7 | Diagnostic | Remède |
|---|---|---|---|---|
| échec | échec | échec | conda ni découvert ni activable | `python.condaPath` (User) + profil cmd |
| échec | OK | échec | terminal réparé, découverte non | `python.condaPath` ou PATH de l'image |
| OK | échec | OK | découverte OK, PowerShell bloqué | profil cmd, ou `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` si A3 sans GPO |
| OK | OK | échec | filtre Jupyter ou dossier non trusted | B1, `jupyter.kernels.excludePythonEnvironments` |
| OK | OK | OK, B9 échec | trust ou timing sur le dossier notebooks | B1, attendre / Refresh |

Rapporter, avec le fichier de `collecte.cmd` : la génération d'extension
(B2), le premier test en échec, et le texte exact de la première commande et
du premier message lus en B5.

## D. Ce qui relève de l'image des postes

Plusieurs entrées des annexes n'ont qu'un contournement côté élève. Le
remède complet est dans l'image des machines, et relève du service
informatique. Par ordre d'effet sur les séances :

1. Stratégie d'exécution PowerShell fixée à `RemoteSigned` par stratégie de
   groupe : valeur par défaut de Windows Server, aucun droit d'installation
   ouvert, et les entrées A7 et V5 disparaissent (VS Code fonctionne avec
   son terminal par défaut).
2. `PATH` système complété par `C:\ProgramData\anaconda3\condabin` :
   `conda` répond dans tout terminal et VS Code le découvre seul (A2, V6).
3. Réseau : autoriser `repo.anaconda.com`, `conda.anaconda.org`,
   `anaconda.cloud`, `anaconda.com`, `api.anaconda.org`,
   `marketplace.visualstudio.com`, `update.code.visualstudio.com`, ou faire
   refuser franchement ces connexions plutôt que les laisser expirer (A4) ;
   déclarer le proxy dans `C:\ProgramData\anaconda3\.condarc`
   (`proxy_servers`) et dans les variables système `HTTP_PROXY` /
   `HTTPS_PROXY` (R2).
4. Profil par défaut (`C:\Users\Default`) garni de ce que chaque élève
   refait sinon : `AppData\Roaming\Code\User\settings.json` avec le
   profil de terminal et `python.condaPath` ;
   `.anaconda\navigator\anaconda-navigator.ini` avec
   `hide_update_dialog = True` et le mode hors ligne, ou le raccourci
   Navigator retiré du menu Démarrer (A4, A6) ; l'acceptation des
   conditions conda (A10), par `conda tos accept` lancé en administrateur ou
   par la variable système `CONDA_PLUGINS_AUTO_ACCEPT_TOS=true`.
5. Exclusion de `C:\ProgramData\anaconda3` de l'analyse antivirus en temps
   réel (dossier en lecture seule pour les élèves), pour raccourcir la
   première ouverture de Navigator après un démarrage (A4).
6. Logiciels dans l'image : Notepad++, LibreOffice, Git for Windows, et les
   extensions VS Code `ms-python.python`, `ms-toolsai.jupyter` dans le
   profil par défaut (B1, G1, V3).
7. À plus long terme, une image sans Navigator, avec Miniforge (conda
   configuré sur conda-forge, sans conditions d'utilisation) et VS Code.

