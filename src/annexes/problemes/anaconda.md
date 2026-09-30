---
title: Problèmes avec Anaconda
subtitle: Invite de commandes d'Anaconda, conda, Navigator, outils installés dans un environnement
---

Les deux façons de lancer Anaconda, et ses fichiers, sont dans
[Installation et configuration](../configuration/anaconda.md).

(dep-anaconda)=
## Problèmes

(dep-a1)=
### A1. « Anaconda Prompt » n'est pas dans le menu Démarrer

Ce qu'on voit
: Taper `anaconda` dans le menu Démarrer ne propose rien, ou seulement
  Navigator.

Cause
: Anaconda n'est pas installé sur ce poste, ou ses raccourcis ont été
  créés pour un autre compte.

Vérifier
: Ouvrir un `cmd` (menu Démarrer, taper `cmd`) et taper
  `dir C:\ProgramData\anaconda3\Scripts\activate.bat`. Si la réponse est
  « Fichier introuvable », essayer `dir %USERPROFILE%\anaconda3` puis
  `dir C:\anaconda3`.

Remède
: Dans le `cmd`, taper, avec le chemin trouvé :

```
call C:\ProgramData\anaconda3\Scripts\activate.bat C:\ProgramData\anaconda3
```

L'invite passe à `(base)`. La fenêtre est alors une invite de commandes d'Anaconda. Si
aucun chemin n'existe, Anaconda n'est pas sur le poste : le signaler.

(dep-a2)=
### A2. « 'conda' n'est pas reconnu en tant que commande interne ou externe »

Ce qu'on voit
: Ce message dans un `cmd`. Dans PowerShell : « conda : Le terme 'conda'
  n'est pas reconnu », ou « CommandNotFoundError: Your shell has not been
  properly configured to use 'conda activate' ».

Cause
: La commande `conda` n'est connue que de l'invite de commandes d'Anaconda. Un `cmd` ou
  un PowerShell ordinaire ne la connaît pas
  ([Variables d'environnement](../notions/variables_environnement.md)).

Remède
: Taper la commande dans l'invite de commandes d'Anaconda ({ref}`A1 <dep-a1>`). Dans VS
  Code, faire le réglage du terminal, qui ouvre un `cmd` activé
  ({ref}`V5 <dep-v5>`).

(dep-a3)=
### A3. L'invite ne commence pas par `(base)`

Ce qu'on voit
: L'invite est `C:\Users\<nom>>` ou `PS C:\Users\<nom>>`, sans nom entre
  parenthèses.

Cause
: Aucun environnement n'est activé. La commande `python` lance alors un
  autre Python que celui d'Anaconda, ou aucun ({ref}`V7 <dep-v7>`).

Vérifier
: `python -c "import sys; print(sys.executable)"` : le chemin doit
  contenir `anaconda3`.

Remède
: Si `conda` répond dans cette fenêtre, taper `conda activate base`. Sinon,
  ouvrir une invite de commandes d'Anaconda ({ref}`A1 <dep-a1>`). Dans VS Code, voir
  {ref}`V5 <dep-v5>`.

(dep-a4)=
### A4. Anaconda Navigator met plusieurs minutes à s'ouvrir

Ce qu'on voit
: Après le clic, rien pendant une à plusieurs minutes. Parfois une fenêtre
  noire apparaît et disparaît. Puis la fenêtre de Navigator s'ouvre, ou le
  message de {ref}`A5 <dep-a5>` si on a cliqué une seconde fois.

Cause
: Au démarrage, Navigator charge plusieurs centaines de Mo de fichiers,
  lance plusieurs commandes `conda`, puis contacte des serveurs (page
  d'accueil, mise à jour, compte). Après le démarrage du poste, la première
  ouverture est la plus longue. Sans session réseau ({ref}`R1 <dep-r1>`),
  chaque requête vers un serveur attend dix à trente secondes avant
  d'abandonner.

Vérifier
: Ouvrir le Gestionnaire des tâches (`Ctrl` + `Maj` + `Échap`). Un
  processus « Anaconda Navigator » ou `pythonw.exe` est présent tant que
  Navigator se lance. S'il est présent depuis plus de cinq minutes sans
  fenêtre, il est bloqué.

Remède
: Cliquer une seule fois, puis attendre deux minutes, avec la session
  réseau ouverte. Répondre No à une proposition de mise à jour
  ({ref}`A6 <dep-a6>`). Pour arrêter un Navigator bloqué, voir
  {ref}`A13 <dep-a13>`. Navigator n'est pas nécessaire : VS Code se lance
  depuis le menu Démarrer ([VS Code](../configuration/vscode.md)). Une mention
  « offline mode » dans Navigator n'est pas une erreur : elle signale
  l'absence de réseau, et Navigator fonctionne quand même.

(dep-a5)=
### A5. « There is an instance of Anaconda Navigator already running »

Ce qu'on voit
: Ce message, et aucune fenêtre de Navigator.

Cause
: Un Navigator est déjà lancé : celui du premier clic, qui n'a pas fini de
  s'ouvrir ({ref}`A4 <dep-a4>`), ou un Navigator resté ouvert depuis une
  session précédente, ou un Navigator bloqué sans fenêtre.

Vérifier
: Gestionnaire des tâches (`Ctrl` + `Maj` + `Échap`), onglet Processus :
  chercher « Anaconda Navigator » ou `pythonw.exe`.

Remède
: Si le premier clic date de moins de deux minutes, attendre. Sinon, dans
  le Gestionnaire des tâches, arrêter le processus ({ref}`A13 <dep-a13>`),
  puis relancer Navigator une seule fois. Si le message revient alors
  qu'aucun processus n'est présent, taper `anaconda-navigator --reset`
  dans l'invite de commandes d'Anaconda, puis relancer.

(dep-a6)=
### A6. Navigator propose une mise à jour, ou affiche « updating packages » sans avancer

Ce qu'on voit
: Au démarrage, une boîte « Update Application ». Si on accepte, Navigator
  se relance et repropose la même mise à jour, ou affiche « updating
  packages on 'root' » et ne va pas plus loin.

Cause
: Sur les postes de la salle, `base` n'est pas modifiable par un compte
  élève. La mise à jour ne peut pas se faire, et Navigator ne le détecte
  pas.

Remède
: Répondre No, et cocher « Don't show again » si la case est proposée. Si
  la mise à jour a été acceptée et que Navigator ne va plus loin, terminer
  le processus ({ref}`A5 <dep-a5>`). Dans Preferences, cocher « Hide update
  dialog on startup » évite la question les fois suivantes.

(dep-a7)=
### A7. « … cannot be loaded because running scripts is disabled on this system »

Ce qu'on voit
: Dans PowerShell, au démarrage du terminal de VS Code ou après
  `conda activate` : `… \activate.ps1 cannot be loaded because running
  scripts is disabled on this system`, ou le même message pour
  `conda-hook.ps1` ou `profile.ps1`.

Cause
: PowerShell est réglé pour exécuter les commandes tapées, mais aucun
  fichier de script : sa stratégie d'exécution est `Restricted`, la
  valeur par défaut de Windows. L'activation d'un environnement dans
  PowerShell passe par un script.

Remède
: Employer un `cmd` à la place de PowerShell : `activate.bat` n'est pas un
  script PowerShell et n'est pas concerné. C'est ce que fait l'Anaconda
  Prompt ([Les terminaux](../notions/terminaux.md)), et ce que le réglage
  du terminal donne à VS Code ({ref}`V5 <dep-v5>`).

  Le compte peut aussi changer la stratégie pour lui-même, sans droits
  d'administration, si aucune stratégie de groupe ne l'impose. Dans un
  terminal PowerShell, `Get-ExecutionPolicy -List` le dit : les lignes
  `MachinePolicy` et `UserPolicy` doivent être à `Undefined`. Alors :

  ```
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```

  Répondre `O`, fermer et rouvrir le terminal. `RemoteSigned` autorise les
  scripts du poste et exige une signature pour ceux téléchargés. Le
  réglage suit le compte, pas le poste ; sur une machine virtuelle remise
  à zéro, il est à refaire.

(dep-a8)=
### A8. « EnvironmentNotWritableError » à `conda install`

Ce qu'on voit
: `EnvironmentNotWritableError: The current user does not have write
  permissions to the target environment. environment location:
  C:\ProgramData\anaconda3`.

Cause
: La commande visait `base`, que le compte élève ne peut pas modifier.

Remède
: Créer son propre environnement et y installer ce dont on a besoin :

```
conda create -n recette -c conda-forge python pandoc
conda activate recette
```

Cet environnement va dans `C:\Users\<nom>\.conda\envs\recette`, où le
compte a tous les droits. C'est ce que fait le TD 4a.

(dep-a9)=
### A9. « CondaHTTPError » à `conda create`, ou « Solving environment » très long

Ce qu'on voit
: `CondaHTTPError: HTTP 000 CONNECTION FAILED for url <…>`, ou `HTTP 403`,
  `HTTP 407`, une erreur `SSL`. Ou bien une ligne « Solving environment »
  qui dure plusieurs minutes.

Cause
: `000 CONNECTION FAILED` : la session réseau n'est pas ouverte
  ({ref}`R1 <dep-r1>`). `407` ou `SSL` : le réseau passe par un proxy
  ({ref}`R2 <dep-r2>`). `403` : le serveur a répondu par un refus ; voir aussi
  {ref}`A10 <dep-a10>`. Une résolution longue sans message d'erreur : la
  première commande qui emploie `conda-forge` télécharge la liste des
  paquets du canal, plusieurs dizaines de Mo, avant de calculer quoi
  installer. Sur un réseau lent, cela prend plusieurs minutes.

Vérifier
: Dans un `cmd`, `curl.exe -sS -I -m 10 https://conda.anaconda.org` doit
  répondre par une ligne `HTTP/… 200`.

Remède
: Ouvrir la session réseau et relancer la commande. Si le message contient
  `JSONDecodeError` ou `Invalid index`, taper `conda clean --index-cache`
  puis relancer. N'indiquer qu'un canal, `-c conda-forge` : la résolution
  reste plus courte.

(dep-a10)=
### A10. « CondaToSNonInteractiveError: Terms of Service have not been accepted »

Ce qu'on voit
: Ce message, avec les adresses `https://repo.anaconda.com/pkgs/main` et
  `https://repo.anaconda.com/pkgs/r`. Ou une question `Do you accept the
  Terms of Service (ToS) for https://repo.anaconda.com/pkgs/main?
  [(a)ccept/(r)eject/(v)iew]`.

Cause
: Depuis Anaconda 2025.06, conda demande une fois par compte d'accepter
  les conditions d'utilisation des canaux d'Anaconda. Ces canaux sont
  consultés par défaut, même avec `-c conda-forge`.

Remède
: Répondre `a` à la question. Ou, une fois pour toutes, taper :

```
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main --channel https://repo.anaconda.com/pkgs/r
```

Autre possibilité : ne pas consulter ces canaux. `conda create -n recette
--override-channels -c conda-forge python pandoc` n'emploie que
conda-forge, qui n'a pas de conditions à accepter ; et le fichier
`.condarc` décrit dans [Anaconda, section
Configuration](../configuration/anaconda.md) rend ce choix permanent, y
compris pour un `conda create` lancé par VS Code.

(dep-a11)=
### A11. Un environnement créé n'apparaît pas dans la liste

Ce qu'on voit
: `conda env list` ne cite pas l'environnement. Ou il y est, mais VS Code
  (« Select Interpreter », « Select Kernel ») ou Navigator ne le proposent
  pas.

Cause
: conda tient la liste des environnements dans
  `C:\Users\<nom>\.conda\environments.txt`. VS Code et Navigator lisent
  cette liste à leur démarrage et ne la relisent pas d'eux-mêmes.

Vérifier
: `conda env list` dans l'invite de commandes d'Anaconda.

Remède
: Si conda connaît l'environnement : dans VS Code, palette
  (`Ctrl` + `Maj` + `P`), « Python: Clear Cache and Reload Window » ou
  « Python Environments: Refresh Environment Managers » ; dans Navigator,
  onglet Environments, bouton « Update index ». Si conda ne le connaît
  pas : l'activer une fois par son chemin, `conda activate
  C:\Users\<nom>\.conda\envs\<nom>`, ce qui l'ajoute à la liste.

(dep-a12)=
### A12. Spyder met du temps à s'ouvrir, ou ne s'ouvre pas

Ce qu'on voit
: Après le clic, rien pendant une minute ou plus. Ou une fenêtre qui
  s'ouvre puis se ferme. Ou la console de Spyder affiche un autre chemin
  que l'invite de commandes d'Anaconda.

Cause
: Comme Navigator, Spyder charge beaucoup de fichiers au premier
  lancement après le démarrage du poste. Une fenêtre qui se ferme aussitôt
  est une erreur de démarrage, que le lancement par bouton ne montre pas.

Vérifier
: Dans l'invite de commandes d'Anaconda, taper `spyder` puis Entrée : la fenêtre
  affiche ce que Spyder écrit, et une erreur y reste lisible.

Remède
: Attendre une minute au premier lancement. Si Spyder ne s'ouvre pas
  depuis l'invite de commandes d'Anaconda non plus, taper `spyder --reset`, qui remet ses
  réglages à zéro, puis relancer. Si la console affiche un autre chemin
  que l'invite de commandes d'Anaconda : Préférences (menu Outils, ou Tools), rubrique
  « Interpréteur Python », choisir l'option par défaut, celle de Spyder.

(dep-a13)=
### A13. Arrêter Navigator bloqué au démarrage

Ce qu'on voit
: L'icône de démarrage de Navigator reste à l'écran, sans fenêtre, depuis
  plusieurs minutes. L'onglet Processus du Gestionnaire des tâches ne montre
  pas d'application « Anaconda Navigator ».

Cause
: Tant que sa fenêtre n'est pas ouverte, Navigator est un programme Python
  sans fenêtre, `pythonw.exe`, rangé dans les processus en arrière-plan. Il
  attend des commandes `conda` ou des serveurs ({ref}`A4 <dep-a4>`).

Vérifier
: Ouvrir le Gestionnaire des tâches (`Ctrl` + `Maj` + `Échap`), onglet
  Détails. Clic droit sur l'en-tête d'une colonne, « Sélectionner les
  colonnes », cocher « Ligne de commande », puis OK. Le processus de
  Navigator est le `pythonw.exe` dont la ligne de commande contient
  `anaconda-navigator`.

Remède
: Clic droit sur ce processus, « Fin de l'arborescence du processus » :
  les commandes `conda` qu'il a lancées s'arrêtent avec lui, et l'icône
  disparaît. Dans l'invite de commandes d'Anaconda, une seule commande fait
  la même chose :

  ```text
  taskkill /F /T /IM pythonw.exe
  ```

  Elle arrête tous les programmes `pythonw.exe`, dont Spyder s'il est
  ouvert. Ensuite, lancer JupyterLab sans Navigator : dans l'invite de
  commandes d'Anaconda, se placer dans le dossier de la séance avec `cd`,
  puis taper `jupyter lab` ([JupyterLab](../configuration/jupyterlab.md)).
  Ces manipulations restent à vérifier sur un poste de la salle.

## Outils installés dans un environnement

Le module installe pandoc, typst, ImageMagick et ffmpeg avec conda, dans
l'environnement du TD. Ces outils ne répondent que dans une fenêtre où cet
environnement est activé.

(dep-x1)=
### X1. « 'pandoc' n'est pas reconnu » après un `conda install` réussi

Ce qu'on voit
: `'pandoc' n'est pas reconnu en tant que commande interne ou externe`
  (ou `typst`, `magick`, `ffmpeg`), alors que l'installation s'est bien
  passée.

Cause
: L'outil est installé dans un environnement, et la fenêtre où on tape la
  commande a un autre environnement actif, ou aucun.

Vérifier
: `conda list -n <env> pandoc` dit dans quel environnement il est.
  `where pandoc` dans la fenêtre dit s'il y est visible.

Remède
: `conda activate <env>` dans la fenêtre. Dans VS Code, choisir cet
  environnement comme interpréteur ({ref}`V6 <dep-v6>`), puis ouvrir un
  nouveau terminal.

(dep-x2)=
### X2. `convert` répond « Format de lecteur non valide »

Ce qu'on voit
: `convert image.png image.jpg` répond `Format de lecteur non valide` ou
  affiche une aide sur les systèmes de fichiers.

Cause
: `convert.exe` est aussi le nom d'un utilitaire de Windows, qui convertit
  des disques, et Windows le trouve avant celui d'ImageMagick.

Remède
: Employer `magick` : `magick image.png image.jpg`. C'est la commande
  d'ImageMagick 7, et la seule que le module emploie.
