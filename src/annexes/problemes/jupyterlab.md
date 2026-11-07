---
title: Problèmes avec JupyterLab et les notebooks
---

Le noyau et le client d'un notebook sont expliqués dans [Les
notebooks](../notions/notebooks.md), le test de JupyterLab dans [Anaconda et
JupyterLab](../../avant/python.md), et son lancement depuis un terminal dans
[JupyterLab sans Navigator](../configuration/jupyterlab.md). La configuration des
notebooks dans VS Code est dans
[VS Code : notebooks](../configuration/vscode_notebooks.md).

(dep-jupyter)=
## Problèmes

(dep-j1)=
### J1. Le noyau voulu n'est pas dans la liste

Ce qu'on voit
: Dans VS Code, le bouton « Select Kernel » ne propose pas `base` ni
  l'environnement du TD. Dans JupyterLab, la liste des noyaux ne contient
  que « Python 3 ».

Cause
: Dans VS Code, le premier niveau de la liste ne montre que les noyaux déjà
  employés ; les environnements sont sous « Python Environments… ». Cette
  liste vient de l'extension Python : si elle ne trouve pas Anaconda
  ({ref}`V6 <dep-v6>`), les notebooks ne le trouvent pas non plus. Dans
  JupyterLab, « Python 3 » est le noyau de l'environnement qui a lancé
  JupyterLab, en général `base` ; les autres environnements n'y
  apparaissent pas.

Solution
: Dans VS Code : « Select Another Kernel… », puis « Python Environments… ».
  Si la liste est vide, attendre dix secondes et rouvrir. Si
  l'environnement n'apparaît nulle part : {ref}`V6 <dep-v6>`, puisque
  Jupyter reprend la liste de l'extension Python
  ({ref}`Ce que l'extension Jupyter en fait <vscode-jupyter-envs>`).
  Dans JupyterLab : lancer `jupyter lab` depuis l'environnement voulu
  (`conda activate <env>` d'abord, dans l'invite de commandes d'Anaconda).

(dep-j2)=
### J2. « Running cells with … requires the ipykernel package »

Ce qu'on voit
: Ce message dans VS Code, avec un bouton Install.

Cause
: Le noyau est le paquet `ipykernel`, installé dans l'environnement qui
  exécute le notebook. `base` l'a ; un environnement créé au TD 1h ne l'a
  que si on l'y a installé.

Solution
: Si l'environnement est celui du TD, cliquer Install, ou taper dans
  l'invite de commandes d'Anaconda `conda install -n <env> -c conda-forge ipykernel`. Si
  le message concerne `base`, l'installation échouera ({ref}`A8 <dep-a8>`),
  car le noyau choisi n'est pas le bon. Rouvrir alors la liste
  ({ref}`J1 <dep-j1>`).

(dep-j3)=
### J3. Le noyau ne démarre pas, ou s'arrête

Ce qu'on voit
: La cellule reste sur `[*]`. Ou « Kernel died », « Failed to start the
  Kernel », « timed out waiting for kernel to be ready ».

Cause
: Sur un poste lent, le premier démarrage d'un noyau dépasse parfois le
  délai prévu. Sinon, l'environnement choisi n'existe plus
  ({ref}`A11 <dep-a11>`), ou une cellule précédente a arrêté le noyau
  (boucle qui ne se termine pas, mémoire pleine).

Vérifier
: Dans VS Code, panneau Output (`Ctrl` + `Maj` + `U`), liste déroulante
  « Jupyter » : lire les lignes qui suivent `ipykernel_launcher`.

Solution
: Cliquer Restart et réessayer une fois. Si le message cite un chemin qui
  n'existe pas, rechoisir le noyau ({ref}`J1 <dep-j1>`). Une cellule qui
  ne finit pas s'arrête par le bouton Interrupt, puis Restart.

(dep-j4)=
### J4. Le notebook n'exécute pas le Python attendu

Ce qu'on voit
: `import sys; print(sys.executable)` dans une cellule affiche un autre
  chemin que l'invite de commandes d'Anaconda. Un `import` échoue dans le notebook et
  réussit dans le terminal.

Cause
: Le noyau du notebook se choisit à part, indépendamment de l'interpréteur
  des fichiers `.py` et du terminal ({ref}`V8 <dep-v8>`). Le TD 1i traite ce
  sujet.

Solution
: Bouton du noyau en haut à droite, choisir l'environnement voulu, puis
  Restart et « Run All ». Les cellules s'exécutent dans l'ordre où on les
  lance, qui peut différer de l'ordre où elles sont affichées : après un
  changement de noyau, tout relancer depuis le début.

(dep-j5)=
### J5. JupyterLab n'ouvre aucune page

Ce qu'on voit
: Une fenêtre noire affiche des lignes, dont une adresse
  `http://localhost:8888/lab?token=…`, mais aucun onglet ne s'ouvre, ou
  une page vide.

Cause
: JupyterLab est un serveur qui s'exécute sur le poste. Il demande au
  navigateur par défaut de s'ouvrir sur son adresse, et sur certains postes
  aucun navigateur n'est défini par défaut.

Solution
: Copier l'adresse complète, avec le `token`, de la fenêtre noire dans la
  barre d'adresse de Firefox. La fenêtre noire exécute le serveur : la garder
  ouverte pendant le travail. `Ctrl` + `C` dans cette fenêtre l'arrête.

(dep-j6)=
### J6. JupyterLab ne montre pas le dossier voulu, ou le disque `D:`

Ce qu'on voit
: Le panneau de gauche ne contient pas le dossier cherché. On ne peut ni remonter
  au-dessus du dossier affiché, ni changer de disque.

Cause
: JupyterLab montre le dossier d'où il a été lancé, et ce qu'il contient. Son
  serveur refuse tout chemin en dehors (`outside root contents directory`). Lancé
  depuis le menu Démarrer ou depuis Navigator, il part en général du dossier du
  compte, `C:\Users\<nom>`. [À vérifier sur un poste, ainsi que l'emplacement de
  `Documents`, qui peut être sur `D:`.]

Vérifier
: Dans la fenêtre noire, la ligne `Serving notebooks from local directory` donne
  ce dossier.

Solution
: Arrêter JupyterLab (`Ctrl` + `C`, deux fois, dans la fenêtre noire), se placer
  dans le dossier voulu, puis relancer. Dans Git Bash :

  ```text
  cd /d/mon_dossier
  jupyter lab
  ```

  Dans l'invite de commandes d'Anaconda :

  ```text
  cd /d D:\mon_dossier
  jupyter lab
  ```

  `cd /d D:\`, dans l'invite de commandes, montre tout le disque. Le code d'un
  notebook n'est pas limité : `open("D:/mon_dossier/fichier.csv")` lit le fichier.

  Sur un ordinateur personnel, un réglage rend ce dossier permanent, y compris
  depuis Navigator. `jupyter lab --generate-config` crée le fichier
  `~/.jupyter/jupyter_lab_config.py` ; y écrire, avec des `/` :

  ```python
  c.ServerApp.root_dir = "D:/mon_dossier"
  ```

  Ce réglage est à éviter sur les postes de la salle : le compte est commun, et
  JupyterLab refuse de démarrer si le dossier n'existe pas (`No such directory`).
