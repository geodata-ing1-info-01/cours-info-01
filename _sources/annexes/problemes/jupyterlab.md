---
title: Problèmes avec JupyterLab et les notebooks
---

Le noyau et le client d'un notebook, le test de JupyterLab et son
lancement depuis l'invite de commandes d'Anaconda sont dans
[JupyterLab](../configuration/jupyterlab.md) ; la configuration des
notebooks dans VS Code, dans
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

Remède
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

Remède
: Si l'environnement est celui du TD, cliquer Install, ou taper dans
  l'invite de commandes d'Anaconda `conda install -n <env> -c conda-forge ipykernel`. Si
  le message concerne `base`, l'installation échouera ({ref}`A8 <dep-a8>`)
  : le noyau choisi n'est pas celui qu'on croit, rouvrir la liste
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

Remède
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
  des fichiers `.py` et du terminal ({ref}`V8 <dep-v8>`). C'est le sujet du
  TD 1i.

Remède
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

Remède
: Copier l'adresse complète, avec le `token`, de la fenêtre noire dans la
  barre d'adresse de Firefox. Ne pas fermer la fenêtre noire tant qu'on
  travaille : c'est le serveur. `Ctrl` + `C` dans cette fenêtre l'arrête.
