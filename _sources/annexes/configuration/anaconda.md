---
title: Anaconda
subtitle: La distribution Python, conda dans un terminal, les environnements et les dépôts, Anaconda Navigator
---

Anaconda est une distribution Python : un ensemble qui réunit Python, des
centaines de bibliothèques déjà installées, l'outil `conda` qui gère les
environnements, et des applications (Anaconda Navigator, Spyder,
JupyterLab). Sur les postes de la salle, il est installé pour tous les
utilisateurs, dans `C:\ProgramData\anaconda3`. Sur un ordinateur personnel, le
module conseille Miniforge ([Python et conda](../poste_personnel/conda.md)).

Le module emploie Anaconda surtout en ligne de commande, avec `conda` et le
Python de la distribution. Anaconda Navigator, une interface graphique qui
lance les applications, sert de secours. Le test des deux est dans [Anaconda et
JupyterLab](../../avant/python.md).

(conda-terminal)=
## conda dans un terminal

Dans un `cmd` ouvert depuis le menu Démarrer, ou dans un Git
Bash qui n'a pas été configuré, `conda` n'est pas reconnu
({ref}`A2 <dep-a2>`), et `python` désigne un autre Python, ou aucun.

Il faut d'abord activer un environnement dans le terminal. Un script
d'Anaconda ajoute les dossiers de l'environnement en tête de la variable
`PATH`, et le terminal y trouve ensuite `conda`, `python` et les autres
programmes de l'environnement. La variable `PATH` est expliquée dans
[Variables d'environnement et recherche des
programmes](../notions/variables_environnement.md), et le contenu des
scripts d'activation dans [Les environnements
conda](../notions/environnements.md).

La mise en place dépend du terminal employé.

::::{tab-set}

:::{tab-item} Git Bash
Le [TD
1c](../../cours1_v2/notebook/td/1c_programme/guide.md) fait cette
configuration. Taper une fois ces commandes dans Git Bash :

```text
source /c/ProgramData/anaconda3/etc/profile.d/conda.sh
conda init bash
```

`source` exécute le script `conda.sh` dans le terminal ouvert, ce qui y
définit la commande `conda`. `conda init bash` écrit une instruction
équivalente dans le fichier `~/.bash_profile`, que Git Bash lit à chaque
ouverture. Il affiche une ligne par fichier examiné, `no change` ou
`modified`. Fermer ensuite Git Bash, puis le rouvrir.

1. Ouvrir Git Bash. L'invite commence par `(base)`. Sinon : {ref}`A3 <dep-a3>`.
2. Taper `which python`. La commande affiche `/c/ProgramData/anaconda3/python`.
   Sinon : {ref}`A16 <dep-a16>`.
3. Taper `conda --version`. La commande affiche `conda 25.x` ou `conda 24.x`.
   Sinon : {ref}`A2 <dep-a2>`.

Si un message d'erreur s'affiche :

- `source` affiche `No such file or directory` : {ref}`A14 <dep-a14>`.
- `conda init bash` écrit `needs sudo`, ou Windows demande des droits
  d'administrateur : {ref}`A15 <dep-a15>`.
- Chaque nouveau Git Bash affiche l'aide de `cygpath` : {ref}`G7 <dep-g7>`.

Le réglage est écrit dans le dossier personnel du compte. Il reste d'une
séance à l'autre sur le même poste, et se refait sur un autre poste. Il
vaut aussi pour le Git Bash ouvert dans VS Code, qui lit le même fichier
([Python et environnement conda](vscode_python.md)).
:::

:::{tab-item} Invite de commandes d'Anaconda
Menu Démarrer, taper `anaconda`, choisir « Anaconda Prompt », le nom
anglais de l'invite de commandes d'Anaconda. Une fenêtre noire s'ouvre tout
de suite. La ligne qui attend une commande s'appelle
l'invite ; elle commence par `(base)`, le nom de l'environnement actif, puis
le dossier courant.

```{figure} menu_demarrer_anaconda.svg
:alt: Le menu Démarrer après avoir tapé anaconda, avec Navigator, Prompt et Spyder dans la liste
:width: 100%

Le menu Démarrer, après avoir tapé `anaconda`.
```

```{figure} ../../avant/anaconda_prompt.svg
:alt: La fenêtre de l'invite de commandes d'Anaconda, avec une commande tapée et sa réponse
:width: 100%

Une commande tapée dans l'invite de commandes d'Anaconda, et sa réponse.
```

Le raccourci ouvre un `cmd` et y exécute `activate.bat`
([Les terminaux en ligne de commande](../notions/terminaux.md)). L'invite
de commandes d'Anaconda fonctionne donc sans réglage. Pour le vérifier :

1. Taper `conda --version`. La commande affiche `conda 25.x` ou `conda 24.x`.
2. Taper `where python`. La première ligne affiche
   `C:\ProgramData\anaconda3\python.exe`.
:::

:::{tab-item} cmd
1. Dans l'invite de commandes d'Anaconda, taper `conda init cmd.exe`.
2. Ouvrir un nouveau `cmd`. `conda activate base` y fonctionne ensuite.

Ces étapes restent [à vérifier sur un poste de la salle].
:::

:::{tab-item} PowerShell
1. Dans un PowerShell, autoriser les scripts pour le compte ({ref}`A7 <dep-a7>`).
   Cette commande ne demande pas de droits d'administrateur :

   ```
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

2. Dans l'invite de commandes d'Anaconda, taper `conda init powershell`.
3. Fermer le PowerShell, puis le rouvrir.

Ces étapes restent [à vérifier sur un poste de la salle].
:::

::::

## Les environnements

Un environnement est un dossier qui contient un Python et les paquets
installés avec lui. `base` est celui d'Anaconda. Sur les postes de la
salle, son dossier n'est pas modifiable par un compte élève : on n'y
installe rien. Chaque TD qui a besoin d'un paquet crée son propre
environnement, qui va dans `C:\Users\<nom>\.conda\envs`. Le TD 1h fait
créer le premier, avec ces commandes, dans l'invite de commandes d'Anaconda :

```
conda create -n recette -c conda-forge python pandoc
conda activate recette
conda env list
conda list -n recette
```

Dans l'ordre : créer l'environnement `recette` avec Python et pandoc, pris
sur le canal conda-forge ; l'activer (l'invite passe à `(recette)`) ; lister
les environnements connus ; lister les paquets de `recette`. Ce que
change l'activation est expliqué dans
[Les environnements conda](../notions/environnements.md).

Une application lancée depuis un terminal est cherchée dans
l'environnement actif, et démarre avec lui. Navigator fait de même avec
l'environnement choisi en haut de sa page. Le lancement de chaque
application est décrit dans sa page : [VS Code](vscode.md),
[Spyder](spyder.md), [JupyterLab](jupyterlab.md).

(config-depots)=
## Configuration des dépôts

Un paquet installé par conda vient d'un dépôt, un serveur qui en tient
des milliers à disposition. conda appelle ces dépôts des canaux
(*channels*). Il en existe plusieurs : `conda-forge`, tenu par une
communauté, où chaque paquet entre après relecture d'une recette ; les
canaux d'Anaconda (`defaults`, c'est-à-dire `pkgs/main` et `pkgs/r`),
tenus par l'entreprise, avec des conditions d'utilisation ; et PyPI, le
dépôt de `pip`, que conda n'emploie pas. Le réglage des canaux dit à conda
où chercher, et dans quel ordre.

```{figure} ../schemas/depots.svg
:alt: Un environnement conda sur la machine, et deux dépôts à distance, PyPI et conda-forge ; une flèche va de conda-forge vers l'environnement
:width: 100%

Un environnement, et les dépôts d'où viennent ses paquets (schéma du
cours 1).
```

Le module prend ses paquets sur conda-forge, d'où le `-c conda-forge` des
commandes. Le fichier `.condarc` rend ce choix permanent, une fois par compte.

### Canal conda-forge par défaut

Écrire dans le fichier `C:\Users\<nom>\.condarc` (le créer avec le
Bloc-notes s'il n'existe pas ; le nom commence par un point et n'a pas
d'extension) :

```yaml
channels:
  - conda-forge
channel_priority: strict
```

Avec ce fichier, `conda create -n recette python pandoc` prend tout sur
conda-forge, sans `-c`, et les canaux d'Anaconda ne sont plus consultés,
y compris quand VS Code lance `conda create`
([Comment VS Code gère les environnements](../notions/vscode_environnements.md)).
Vérifier : `conda config --show channels` affiche `conda-forge` seul.

### Conditions d'utilisation des canaux d'Anaconda

Depuis Anaconda 2025.06, conda demande une fois par compte d'accepter
les conditions d'utilisation des canaux d'Anaconda avant de s'en servir
({ref}`A10 <dep-a10>`). La question n'est posée que dans un terminal ;
lancé par VS Code, conda ne peut pas la poser et échoue. Avec le fichier
`.condarc` ci-dessus, les canaux d'Anaconda ne sont plus consultés et la
question ne se pose plus. Sans ce fichier, faire le test une fois, dans
l'invite de commandes d'Anaconda :

```
conda tos
```

La commande affiche un tableau des canaux avec, pour chacun, accepté ou non.
S'il reste des canaux non acceptés et qu'on compte s'en servir :

```
conda tos accept
```

## Anaconda Navigator

Anaconda Navigator est une interface graphique qui lance les applications
d'Anaconda. Menu Démarrer, taper `anaconda`, choisir « Anaconda
Navigator ».

Après le chargement (jusqu'à deux minutes la première fois), la page
d'accueil affiche une fiche par application. En haut, une liste déroulante
indique l'environnement actif, `base (root)`.

```{figure} navigator_accueil.svg
:alt: La page d'accueil d'Anaconda Navigator, avec la liste des environnements et une fiche par application
:width: 100%

La page d'accueil d'Anaconda Navigator.
```

Le bouton Launch d'une fiche lance l'application dans l'environnement
affiché en haut. Quand Navigator est lent ({ref}`A4 <dep-a4>`) ou ne s'ouvre
pas ({ref}`A5 <dep-a5>`), chaque application se lance
aussi depuis un terminal, comme l'indique sa page. Un Navigator bloqué au
démarrage, dont l'icône reste à l'écran, s'arrête depuis le Gestionnaire
des tâches ({ref}`A13 <dep-a13>`).

## Fichiers utiles

| Quoi | Où |
|---|---|
| Installation | `C:\ProgramData\anaconda3` |
| Python de `base` | `C:\ProgramData\anaconda3\python.exe` |
| Script qu'exécute l'invite de commandes d'Anaconda | `C:\ProgramData\anaconda3\Scripts\activate.bat` |
| Environnements créés par le compte | `C:\Users\<nom>\.conda\envs` |
| Liste des environnements connus | `C:\Users\<nom>\.conda\environments.txt` |
| Réglages de conda pour le compte (canaux) | `C:\Users\<nom>\.condarc` |
| Réglages et journaux de Navigator | `C:\Users\<nom>\.anaconda\navigator` et `C:\Users\<nom>\AppData\Roaming\.anaconda\navigator` |

`conda info`, dans l'invite de commandes d'Anaconda, affiche ces chemins tels que conda
les voit.

## Documentation officielle

- Anaconda Navigator : [Getting started with Navigator](https://www.anaconda.com/docs/tools/anaconda-navigator/getting-started)
  (en anglais).
- Invite de commandes d'Anaconda et conda : [Getting started with conda](https://docs.conda.io/projects/conda/en/stable/user-guide/getting-started.html)
  (en anglais).
