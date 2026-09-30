# Syllabus v2 — Introduction à l'informatique (proposition pour 2027-2028)

> Proposition de refonte ouverte le 24/09/2026, après les séances 1 et 2. Le module tel qu'il est joué en 2026-2027 reste décrit dans [`01_syllabus_v1.md`](01_syllabus_v1.md). Les orientations de la section 2 sont arrêtées ; le reste (contenu fin, budgets, points à vérifier) est à reprendre séance par séance. La répartition des séances entre intervenants se fera sur cette version.
> Ce qui peut en être repris dès 2026-2027 (séances 3 à 7) est dans le [syllabus v1.5](03_syllabus_v1_5.md).
> Les numéros de diapositive renvoient aux PDF projetés de 2026, avec TD (`src/cours<n>/diapo/cours<n>.pdf`, compilés le 24/09) ; le titre est donné à côté, les numéros bougeant à chaque modification.

## 1. Constats de 2026

**Cours 1 trop long.** 123 diapositives et dix TD pour 2 h. Les parties 1 à 3 ont été jouées, la partie 4 (bibliothèques et environnements, diapositives 90 à 122) ne l'a pas été. La capacité réelle observée est d'environ 90′ de contenu après 10′ d'ouverture.

**Cours 2 un peu trop ambitieux.** 95′ de TD annoncés (2a, 2b, 2c, 2d, 2e), plus l'exposé. Git y va jusqu'au `rebase`, au `tag` et à l'organisation main / develop / feature, que le cours 6 reprend en équipe.

**Ligne de commande vue sans pratique.** Au cours 2, 13 pages d'exposé, sans TD. Les élèves ont manqué d'aisance avec le terminal, dont tous les cours suivants dépendent.

**Un terminal différent à chaque séance**, sans que leur différence soit expliquée :

| Cours | Terminal employé |
|---|---|
| 1, TD 1c | terminal de VS Code (PowerShell, qui refuse `activate.ps1`), remplacé par un profil « Anaconda Prompt » |
| 2 | bash (captures sous Linux) |
| 3 | invite de commandes d'Anaconda (préparation), Git Bash avec `conda init bash` (TD 3f) |
| 4 | Git Bash dans VS Code |
| 5 | invite de commandes d'Anaconda ; « Git Bash a la sienne » pour la clé SSH |

**Configuration de VS Code plus longue que prévu.** Au TD 1c, chaque élève a configuré seul l'éditeur (extension, interpréteur, profil de terminal). Les problèmes de configuration, propres à chaque poste, et la prise en main d'un outil nouveau ont pris plus que les 25′ prévues, et c'est ce qui a repoussé la partie 4 hors de la séance.

**Travail perdu dans le dossier partagé.** À la séance 1, des élèves ont travaillé directement dans `formationTemp` et y ont perdu leur travail ([`src/avant/donnees.md`](../src/avant/donnees.md)). La différence entre le disque du poste et un dossier du réseau n'est expliquée nulle part avant le cours 5.

**Notions traitées deux fois.** Texte et binaire, ASCII et UTF-8 : cours 1 (diapositives 19, 20, 31) et cours 3 (TD 3d). `PATH` et activation : cours 1 (101) et cours 3 (« Où le terminal trouve pandoc »). Chemins : cours 1 (15 à 17), cours 2 (arborescence, 5 à 9), cours 3 (`pathlib`). Client et serveur : cours 1 (104 à 106) et cours 5 (22).

## 2. Orientations retenues

| Séance | Retire | Reçoit |
|---|---|---|
| **1** | VS Code et l'IDE (TD 1c, fonctions et édition d'un IDE), l'indentation et les programmes fautifs, environnements et bibliothèques (partie 4), Markdown, binaire et texte ; programme et application, place de l'interpréteur (en annexe) | stockage local et distant et copie des fichiers du cours, à la suite des logiciels et fichiers ; interface graphique et ligne de commande ; terminal Git Bash (choix justifié) et commandes de base, TD 1b sur les fichiers du TD 1a ; Python, programme en ligne de commande, une commande désigne un fichier cherché dans `PATH`, compilé et interprété, script de commandes ; premier programme édité dans Notepad++, lancé au terminal ; ouverture d'un notebook (invite de commandes d'Anaconda, puis Git Bash), avec la syntaxe minimale de Markdown dans ses cellules de texte |
| **2** | la ligne de commande ; `revert` et `rebase` (en annexe) ; `tag` (au projet 7) ; TD 2c et 2e | configuration de VS Code en classe entière, après la présentation de l'éditeur ; les réglages de VS Code ; l'IDE, l'indentation et le TD des trois programmes fautifs (venus du cours 1) ; Markdown complété (origine, conversion par pandoc, README), qui fournit les fichiers des premiers commits ; en théorie, les systèmes de version, les copies d'un dépôt et l'organisation des branches à plusieurs (`master`, `develop`, une branche par tâche) |
| **3** | la préparation du poste en autonomie ; dans `images.ipynb`, `hexdump`, les signatures BMP et PNG, le poids, la compression, le temps de lecture | les environnements, traités par la pratique : créer un environnement et y installer les paquets que demandent les notebooks ; le binaire et le texte du cours 1 ; `fichiers.ipynb` en TD |
| **4** | — | l'explication des bibliothèques et des environnements (partie 4 du cours 1 de 2026), à la création de l'environnement `animation` ; du temps pour la partie B |
| **5** | — | le serveur de notebook comme exemple de client et serveur |
| **6** | l'outil « trajectoire », numpy | la forge sur le dépôt du projet 4, précédée d'une copie du dépôt sans forge ; les organisations du travail à plusieurs |
| **7** | le benchmark de conversion en gris sur une image fournie | une option `--effet` ajoutée au programme du projet 4 (un effet au choix parmi quatre, appliqué à chaque image), écrite en boucle puis avec numpy ; le `tag` de la version rendue ; en facultatif, le poids, la compression et le temps de lecture de `images.ipynb` |

Le module a deux projets suivis : la recette (cours 1 à 3) et l'animation (cours 4, 6 et 7).

**Compétences visées.** Ce que chaque élève doit savoir faire seul à la fin du module. Tout contenu qui ne sert pas l'une de ces compétences, ou la notion qui l'explique, passe en annexe.

| Compétence | Vue | Réemployée |
|---|---|---|
| Fichiers et dossiers, extension, chemin | c1 | début de chaque séance |
| Dossier partagé et disque local ; copier et décompresser les données | c1 | début de chaque séance |
| Lancer un notebook sur un poste de l'école (invite de commandes d'Anaconda ou Git Bash) | c1 | c3, c4 |
| Terminal et interpréteur ; commandes simples ; une commande désigne un fichier cherché dans `PATH` ; script de commandes | c1 | c2 à c7, en Git Bash |
| Configurer et utiliser VS Code | c2 | c3, c4, c6, c7 |
| Git Bash dans VS Code | c2 | c3, c4, c6, c7 |
| Git local : `status`, `add`, `commit`, `log`, `diff`, `.gitignore`, branche, `merge`, conflit | c2 | c3, c4, c6, c7 |
| Créer un environnement conda et y installer un paquet demandé | c3 | c4 (depuis `environment.yml`), c7 (ajout de numpy et Pillow) |
| Écrire un README en Markdown | c1 (syntaxe minimale, dans un notebook), c2 (tableau, image), c3 (plan du README) | c3 (étape 4), c4 (B4), c7 (`RAPPORT.md`) |
| Lire et écrire des fichiers en Python | c3 | c4, c7 |
| Appeler une commande depuis Python (`subprocess`) | c3 (pandoc) | c4 (magick, ffmpeg) |
| Programme en ligne de commande simple (`main`, `argparse`) | c3 | c4 |
| Forge GitHub : `push`, `pull`, `clone`, pull request | c6 (clé SSH au c5) | c7 |
| Structure de projet Python (facultatif) | c3 (étapes 5 et 6) | c4 (B5) |

**Pratique répétée** *(propositions, à valider)* :

- Début de séance identique à partir du cours 2, fait sans guide (≈ 10′) : ouvrir Git Bash, copier l'archive depuis `formationTemp` et la décompresser, `cd`, `conda activate` à partir du cours 3, `git status`.
- Chaque TD, à partir du cours 2, est un dépôt git, avec un commit par étape et le `git log --oneline` montré en fin de TD.
- Guides de moins en moins détaillés pour une même compétence : code complet la première fois, puis l'objectif et la commande de vérification, puis l'objectif seul. Environnement : c3 complet, c4 objectif et vérification, c7 objectif. Branche et `merge` : c2 complet, c3 et c4 objectif et vérification, c6 et c7 objectif.
- Aucun TD facultatif dans les diapositives : ils vont dans les exercices complémentaires.
- Un aide-mémoire d'une page, complété à chaque séance (commande, forme, vérification attendue), à la place des diapositives de syntaxe.

**Une configuration par séance.** L'ordre des séances sert aussi à répartir les étapes d'installation et de configuration, qui sont ce qui déborde, et à laisser aux élèves le temps de prendre en main un outil avant le suivant : Git Bash et `conda init bash` au cours 1 (début du TD 1c, quand `python` sert pour la première fois), VS Code au cours 2 (en classe entière), un environnement conda au cours 3. Chaque séance n'en a qu'une, placée tôt, avec une vérification immédiate ; chaque outil est ensuite réemployé à la séance suivante avant qu'un autre s'ajoute.

Terminal de référence du module : **Git Bash**, configuré au cours 1 (`conda init bash`), rappelé au cours 2, employé ensuite partout, cours 5 compris. C'est le langage du cours 2 et des postes macOS et Linux des élèves, et le cours 4 l'emploie déjà. L'invite de commandes d'Anaconda, où conda est actif sans réglage, sert de recours : au cours 1, si le réglage de Git Bash échoue sur un poste, le Python de la séance et JupyterLab s'y lancent, et Git Bash se règle au cours 2.

---

## Cours 1 — Logiciels, fichiers, terminal et premier programme (CM)

Objectif : savoir où sont ses fichiers et où les ranger, se déplacer et agir sur des fichiers depuis un terminal, ouvrir, modifier et lancer un programme Python écrit dans un fichier texte, savoir quel fichier une commande lance, ouvrir un notebook.

*Section réécrite le 28/09/2026 d'après le premier jet des supports (`src/cours1_v2/`), qui s'écarte du plan initial sur des points jugés plus pertinents à l'écriture ; les raisons sont dans les commentaires des sources.*

- **🎓 10′ · Ouverture du module** : diapositives 2 à 8 de 2026, inchangées sur le fond.
- **Partie 1 · Logiciels, fichiers et stockage (≈ 30′)**
  - 🎓 logiciel, système d'exploitation, entrées et sorties, application web, utilité d'un fichier, extension et type de fichier, quiz des extensions (diapositives 10 à 14, 18, 21, 22) ; le quiz sur le vocabulaire des chemins (15, 16), placé ici parce que ce vocabulaire sert dès le chemin réseau et le TD 1a. Le détail en octets est au cours 3.
  - 🎓 ≈ 8′ · **stockage local et distant** *(nouveau, quatre diapositives)* : tableau des emplacements (disque du poste, `formationTemp`, espace personnel réseau, stockage en ligne, clé USB), schéma du réseau local de l'école et d'Internet, deux élèves dans le même dossier partagé, un emplacement réseau reconnu à son chemin (`\\serveur\…` ou lecteur réseau).
  - ⌨️ 15′ · **TD 1a, à la souris**, copie de l'archive comprise : copier l'archive de la séance depuis `formationTemp` dans `Desktop\info01` et la décompresser ; afficher les extensions ; exporter `depart/raven.odt` en PDF et en PNG dans `travail/` ; ouvrir une page HTML depuis le disque ; Bloc-notes et Notepad++ sur les mêmes fichiers. La table ASCII part au cours 3. En fin de séance, emporter son travail (où : à préciser, voir section 5).
- **Partie 2 · Terminal et premier programme (≈ 55′)** *(le terminal est repris du cours 2 de 2026)*
  - 🎓 ≈ 20′ · interface graphique et ligne de commande (trois diapositives : une même copie, une opération sur 120 fichiers, comparaison) ; le terminal et l'interpréteur de commandes ; les terminaux du poste (cmd, PowerShell, Git Bash) et le choix de Git Bash ; lire l'invite ; `commande [options] <arguments>`, `--help` ; les commandes de base, avec leur équivalent dans l'explorateur ; chemin absolu et relatif (17), chemins dans Git Bash (`/c/`, `~`) ; fichiers cachés et motif `*`, présenté comme un motif de noms de fichiers.
  - ⌨️ 15′ · **TD 1b · Les fichiers du TD 1a en ligne de commande**, dans `cours1/1b_terminal/` : `pwd`, `ls`, `ls -a`, `cd` ; `cp`, `mv` puis `start` pour voir l'effet d'une extension ; un nom avec espace ; `mkdir`, `*`, `rm`. Les équivalents PowerShell et invite de commandes sont en annexe du guide, à la demande d'élèves de 2026.
  - 🎓 ≈ 10′ · **premier programme** : Python, un programme en ligne de commande (lancé dans Git Bash ou dans l'invite de commandes d'Anaconda) ; une commande désigne un fichier exécutable, cherché dans `PATH`, et `conda activate` met Anaconda en tête ; compiler ou interpréter (40, refaite) et ce que chacun apporte, avec le choix de Python ; un fichier ou une session interactive ; un script de commandes, qui lance aussi `python`. Programme et application (39) et la place de l'interpréteur (42) passent en annexe du book.
  - ⌨️ 20′ · **TD 1c · Écrire et lancer un programme** : quel `python` la commande lance (`type -a python`, `python.exe` d'Anaconda lancé par son chemin) ; `conda init bash`, une fois par poste, avec repli sur l'invite de commandes d'Anaconda s'il échoue ; `altitudes.py` dans Notepad++, lancé, modifié, relancé avant et après l'enregistrement ; `commandes.sh`, si le temps le permet (le `.bat` équivalent en annexe du guide) ; Python en interactif.
- **Partie 3 · Un notebook et la syntaxe minimale de Markdown (≈ 20′)**
  - 🎓 un notebook : texte, code et résultat dans un seul document, employé par les cours et TD de Python du module ; le noyau exécute les cellules et garde les variables (79, 81, sur une capture réelle).
  - 🎓 une cellule de texte est écrite en Markdown : une diapositive-tableau, ce qu'on tape, ce qui s'affiche ; l'intention de Markdown (Gruber, 2004) dans ses notes. Le tableau, l'image et la conversion par pandoc sont au cours 2, le plan du README au cours 3.
  - 🎓 lancer JupyterLab : depuis l'invite de commandes d'Anaconda, sans réglage, puis depuis Git Bash ; Navigator en dernier secours.
  - ⌨️ 12′ · **TD 1d** : `altitudes.ipynb` ouvert dans JupyterLab ; exécuter les cellules dans le désordre, voir ce que le noyau retient ; ajouter une cellule de texte en tête ; relancer JupyterLab depuis Git Bash si le temps le permet.
- **Clôture** : « À retenir » : logiciel, extension, disque local et réseau, terminal, chemin relatif, une commande désigne un fichier, interpréteur, automatiser (un logiciel pour ce qu'il prévoit, un script pour répéter, un programme pour le reste), notebook.

**Budget** : 10 + 30 + 55 + 20 = **≈ 115′** pour 36 diapositives d'exposé et quatre TD (62′), au-dessus des ≈ 100′ joués en 2026. Si la séance déborde, retirer dans l'ordre : l'étape du script au TD 1c, la relance de JupyterLab depuis Git Bash au TD 1d, la variante `./` de l'étape « quel python ». La partie 3 porte une compétence (lancer un notebook) : elle passe en dernier au cours 2, dont le Markdown s'appuie sur elle.

**En annexe** : TD 1b (`.odt` archive ZIP) et TD 1j (trajet), dans l'archive 2026 du book ; TD 1e (C++), page « C++ » ; programme et application, place de l'interpréteur, page « Programme, application et interpréteur » ; équivalents PowerShell et invite de commandes (guide du TD 1b), `commandes.bat` (guide du TD 1c). Le débogueur pas à pas reste dans l'archive 2026, à reprendre au cours 2 avec l'IDE si le temps le permet.

## Cours 2 — Éditeur de code, Markdown et git local (CM)

Objectif : travailler dans un éditeur de code configuré, écrire de la documentation en Markdown, et versionner ce travail avec git en local.

*Section mise à jour le 28/09/2026 d'après la refonte des supports (`src/cours2_v2/`) : diapositives fusionnées pour tenir en 120′, graphes git, systèmes de version et copies d'un dépôt en théorie.*

- **🎓 8′ · L'IDE**, en ouverture de séance *(placée avant la configuration le 28/09/2026 : l'éditeur est expliqué avant d'être configuré)* : les fonctions d'un IDE ; édition (coloration syntaxique, chasse fixe, indentation en espaces ou en tabulations) ; dossier ouvert = projet (diapositives 43 à 47 du cours 1 de 2026) ; en fin de partie, la fenêtre de VS Code et ses trois zones, dessinée (`src/cours2_v2/diapo/schemas.typ`), qui introduit le TD 2a. Le débogueur pas à pas (61, 62) s'y ajoute si le temps le permet.
- **⌨️ 20′ · Configuration de VS Code, en classe entière** : l'enseignant projette, chaque élève fait la même étape en même temps, on ne passe à la suivante que lorsque la salle a fini. Lancer VS Code ; installer l'extension Python ; choisir l'interpréteur ; faire de Git Bash le terminal par défaut (`terminal.integrated.defaultProfile.windows`) ; ouvrir le dossier `cours2/` ; vérifier `(base)` et `python --version` dans le terminal intégré. Reprend les diapositives 50 à 56 du cours 1 de 2026, remplace le profil « Anaconda Prompt » par Git Bash, et s'appuie sur [`src/annexes/configuration/vscode.md`](../src/annexes/configuration/vscode.md).
  - Le guide du TD, plus détaillé qu'en 2026 : une capture par étape, la vérification attendue, et la réponse aux blocages connus (PowerShell et `activate.ps1`, interpréteur absent de la liste, webview de l'aperçu). Distribué avant la séance pour les élèves qui veulent prendre de l'avance.
- **Les réglages (5′)**, en classe entière, à la suite de la configuration : 🎓 la palette de commandes (`Ctrl` + `Maj` + `P`) et les réglages (`Ctrl` + `,`), diapositive 54 du cours 1 de 2026 ; deux niveaux, User (le compte, tous les dossiers) et Workspace (`.vscode/settings.json` du dossier ouvert, qui l'emporte), d'après [`src/annexes/configuration/vscode.md`](../src/annexes/configuration/vscode.md), section « Les réglages »). ⌨️ Chaque élève règle au niveau User `editor.renderWhitespace` sur `all` (les espaces et tabulations du TD 2b, qui suit) et `files.autoSave` ; il ouvre le `settings.json` correspondant pour voir le même réglage en texte. Le profil de terminal Git Bash, réglé à l'étape précédente, en est un troisième exemple.
- **⌨️ 10′ · TD 2b · Trois programmes fautifs** *(venu du cours 1 le 27/09/2026)*, dans VS Code : lire les espaces dessinés et la barre d'état, puis corriger `surface.py` (`TabError`), `moyenne.py` (`SyntaxError`) et `chemin.py` (chemin absolu remplacé par `../../cours1/…`), et relancer dans le terminal.
- **Une recette en Markdown (≈ 14′)**, sans séparateur de partie *(ramenée le 28/09/2026 de quatre diapositives à une : Markdown sert ici à fabriquer le projet que git versionne ; la diapositive est placée en fin de la partie « L'éditeur de code », avant la fenêtre de VS Code, et le TD 2c suit le TD 2b)*
  - 🎓 une diapositive, « Markdown, un format texte pour les documents » : du texte brut comme un programme, écrit dans l'éditeur de code, dont git compare les lignes, et dont les modifications se comprennent sans programmer ; un extrait de la recette et son aperçu ; le `README.md` s'écrit de la même façon. L'intention de Markdown (Gruber, 2004) passe dans les notes de la diapositive Markdown du cours 1 ; le plan du README et le bloc de code passent au cours 3.
  - ⌨️ 12′ · TD 2c : la recette en Markdown avec l'aperçu de VS Code (TD 1f de 2026, sans le diagramme `mermaid`, qui passe en annexe), la forme du tableau et de l'image donnée dans la consigne ; en dernière étape, `pandoc recette.md -o recette.html`, ouvrir la page dans le navigateur, puis `pandoc recette.md -o recette.odt`, l'ouvrir dans LibreOffice (d'après [`data/cours1/1f_markdown/README.md`](../data/cours1/1f_markdown/README.md)). pandoc n'a pas de diapositive d'exposé : le TD 2d reprend ces commandes pour les fichiers à ignorer, et le cours 3 appelle pandoc depuis Python. `recette.md` est le fichier du premier commit du TD git.
- **Git local (≈ 62′)**
  - 🎓 22′ · dix-huit diapositives. À quoi sert git (diapositives 15 à 27 de 2026, treize pages, ramenées à trois) : les versions successives ; les systèmes de version, centralisé et distribué (d'après Pro Git, chapitre 1) ; les copies d'un dépôt (poste, clé USB, dépôt d'un camarade, forge), qui échangent leurs commits par `clone`, `pull` et `push`, en théorie. Puis git en ligne de commande : une sous-commande après `git` (`git <sous-commande> [options] <arguments>`, suite de « La forme d'une commande » du cours 1), l'aide par `git --help`, `git add -h` et `git add --help` (deux diapositives ajoutées le 28/09/2026). Puis `init`, zone de préparation et `status`, commit et `log` (28 à 35, 62 à 64) ; le message de commit (une diapositive tirée de 66 à 71) ; `diff` ; annuler une modification non validée (`restore`) ; `.gitignore` (65), avec ce qu'on ne versionne pas (fichiers produits, données, secrets) ; branche et `HEAD`, changer de branche, `merge` avec avance rapide ou commit de fusion (41 à 45) ; conflit et sa résolution (47 à 49, sans `rebase --continue`) ; en théorie, l'organisation des branches à plusieurs : `master` pour les versions terminées, `develop`, une branche par tâche (reprend 72, gardée le 28/09/2026 ; le module ne pratique que la branche de tâche). Chaque notion a son graphe, dessiné sur l'historique du TD (`commun/schemas_git.typ`).
  - ⌨️ 40′ · un dépôt pour la recette : premier commit, modifier le Markdown, lire le `diff`, committer à nouveau ; produire la page et le `.odt` par pandoc, et les ignorer par `.gitignore` ; une branche pour une variante de la recette, fusionnée ; la même ligne modifiée sur deux branches, puis le conflit résolu ; dessiner sur papier le graphe du dépôt, puis le comparer à `git log --oneline --graph --all --decorate` (le graphe attendu est au corrigé). Tout depuis le terminal intégré de VS Code. Remplace les TD 2a, 2b et 2d de 2026, qui travaillaient sur `projet_2` et quatre branches. Le `diff` d'un fichier binaire est retiré (28/09/2026).
  - Pour aller plus loin, dans le guide seulement (étape 7) : `git clone` du dépôt dans un autre dossier ou sur une clé USB, un commit dans la copie, `git pull` depuis la copie.
- **En annexe** : `revert`, `rebase` (diapositives 36, 46 ; TD 2c de 2026). L'organisation main / develop / feature (72) reste au cours 2, en théorie. `tag` (37, TD 2e) passe au projet 7, sur la version rendue.

**Budget** : 10 (IDE et Markdown) + 25 (configuration et réglages) + 10 (TD 2b) + 12 (TD 2c) + 62 (git) = **119′**, 1′ de marge, pour 27 diapositives d'exposé et quatre TD. Pour y tenir, le 28/09/2026 : la partie « Configurer l'éditeur de code » et son séparateur retirés, sa diapositive « Visual Studio Code » placée en fin de partie IDE ; « Copier les fichiers » et « Lancer VS Code » fondues, avec le réglage de conda pour les postes passés par l'invite d'Anaconda au cours 1 ; la palette et les deux niveaux de réglages fondus ; « Les fonctions d'édition de texte d'un IDE » retirée ; la diapositive des caractères invisibles du TD 2b fondue dans sa voisine ; les quatre diapositives Markdown et leur séparateur ramenés à une diapositive ; au TD 2d, le `.odt` n'est plus versionné puis retiré. Si la séance déborde, retirer dans l'ordre : la diapositive « L'organisation des branches à plusieurs », puis l'étape `.odt` du TD 2c. Le rappel de Git Bash n'est plus une partie à part : la dernière étape de la configuration (`(base)` et `python --version` dans le terminal intégré) le vérifie. Le premier poste à surveiller est la configuration : si elle dépasse 25′ en classe entière, le guide distribué avant la séance doit la faire commencer avant.

## Cours 3 — Environnements, chemins et fichiers en Python, ligne de commande (CM)

Objectif : installer un projet dans son propre environnement, manipuler chemins et fichiers en Python, construire un programme en ligne de commande. Séance surtout pratique.

- **⌨️ 20′ · Un environnement pour la séance** *(remplace la préparation du poste, et la partie 4 du cours 1 de 2026)* : copier l'archive, ouvrir le dossier dans VS Code ; `conda create -n cours3 python=3.12`, `conda activate cours3` ; lancer `recette.ipynb` dans ce noyau et lire l'erreur (`pandoc` introuvable) ; `conda install -c conda-forge pandoc`, relancer ; même démarche pour Pillow, demandé par `images.ipynb` ; constater que ces paquets ne sont pas dans `base` ; choisir cet environnement comme interpréteur et comme noyau. La création depuis un `environment.yml` est faite au projet 4.
  - L'explication des bibliothèques et des environnements (90 à 101) passe au projet 4, décision du 28/09/2026 ; ici, la pratique seule. `PATH` est vu au cours 1 (TD 1c) : « Où le terminal trouve pandoc » le rappelle, et l'activation s'y ajoute.
- **Chemins (20′)** : `recette.ipynb`, comme en 2026 ; le renvoi au « programme recette du cours 1 » disparaît, la recette est présentée ici.
- **Fichiers (20′)** : ⌨️ `fichiers.ipynb` en TD, comme en 2026 (`open`, `with`, modes, `encoding`, ligne par ligne, CSV, `read_text`).
- **Texte et binaire (15′)** : 🎓 le schéma bit → octet → hexadécimal → caractère (diapositive 19 du cours 1 de 2026, « Fichiers binaires et fichiers texte », reprise dans la partie encodage du cours 3 le 28/09/2026) et la table ASCII (31), puis quelques cellules d'`images.ipynb` exécutées avec la salle : § 1 (cellules 1 à 5, PGM `P2` lu comme texte puis ouvert comme image), § 2 (7 à 10, le même en `P5`, octets et en-tête), § 7 (42, 47, 49 : octets de « é » en UTF-8, « é » décodé en cp1252, « œuf »). Le reste du notebook passe en lecture autonome : § 3 et 4 (`hexdump`, signatures) en annexe, § 5 et 6 (poids, compression, temps de lecture) repris au projet 7.
- **Ligne de commande (45′)** : TD 3f comme en 2026, l'étape 6 (`pyproject.toml`, `pip install -e .`) reçoit la diapositive 102 du cours 1 de 2026. L'étape 4 (le README) reçoit la diapositive « Le README d'un projet » du cours 2 v2, avec le bloc de code Markdown (`src/cours2_v2/diapo/a_reprendre/readme_cours3.typ`, décision du 28/09/2026).

**Budget** : 20 + 20 + 20 + 15 + 45 = **120′**, sans marge. Ce qui se retire d'abord : les étapes facultatives du TD 3f, puis les § 5 et 6 de `fichiers.ipynb` (CSV, `pathlib`) en lecture autonome.

## Projet (séance 4) — Une animation, du notebook au programme

Inchangé sur le fond. La partie A (créer l'environnement `animation`, lancer JupyterLab) devient une application du cours 3 et passe de 35′ à ≈ 20′ ; les 15′ gagnées vont à la partie B, dont l'étape B4 (README) peut alors se faire en séance. La partie A reçoit l'explication des bibliothèques et des environnements (dépendances, versions, `environment.yml`) ; en 2026, les notes du cours 4 la présentent comme un rappel du cours 1, renvoi à retirer pour la version 2.

## Cours 5 — Matériel, réseau ; mots de passe, clés, secrets (CM)

Inchangé sur le fond. La diapositive « Client et serveur » reçoit l'exemple du serveur de notebook sur son propre poste (`localhost:8888`, diapositives 104 à 106 du cours 1 de 2026), et « Local et distant » renvoie à la partie stockage du cours 1. Les TD passent de l'invite de commandes d'Anaconda à Git Bash (`cat ~/.ssh/id_ed25519.pub` au lieu de `type %USERPROFILE%\…`).

## Cours 6 — La forge, sur le dépôt du projet 4 (CM)

Objectif : avoir employé une fois GitHub de bout en bout (dépôt distant, `push`, `pull`, `clone`, conflit, pull request). L'outil « trajectoire » de 2026 est retiré : le cours 6 ne demande pas d'écrire de code nouveau.

- **🎓 15′ · La forge** : compte, dépôt distant, `remote`, `clone`, `push`, `pull`, en partant des copies d'un dépôt vues au cours 2 (la forge est une copie de plus) ; les organisations du travail à plusieurs, d'après Pro Git, chapitre 5.1 (centralisée, gestionnaire d'intégration, qui est celle de la pull request) ; branche de fonctionnalité et pull request.
- **⌨️ 20′ · Publier son dépôt** : créer un dépôt vide sur GitHub ; `git remote add origin`, `git push -u origin master` avec la clé SSH du cours 5 ; voir l'historique sur le site.
- **⌨️ 20′ · Deux copies du même dépôt** : d'abord sans forge, `git clone` du dépôt dans un autre dossier ou sur une clé USB, un commit dans la copie, `git pull` depuis la copie (ce que proposait l'étape 7, facultative, du TD 2d) ; puis par la forge : `git clone` depuis GitHub dans un autre dossier, un commit dans ce clone, `push`, `pull` dans le premier dossier.
- **⌨️ 20′ · Un conflit** : modifier une ligne du README sur le site, la même ligne en local ; `pull`, résoudre le conflit, `push`.
- **⌨️ 20′ · Une pull request** : une branche qui améliore le README, poussée ; ouvrir la pull request sur le site, la fusionner ; `pull` dans le dossier local.
- **Élèves sans projet 4 terminé** : un dépôt de référence par TD (montre, tourbillon) à copier et publier à la place du leur.

**Budget** : 15 + 20 + 20 + 20 + 20 = **95′**, avec 25′ de marge pour les problèmes de clé SSH et d'authentification.

## Projet (séance 7) — Un effet pour l'animation

Objectif : ajouter une fonctionnalité au projet 4 par une pull request, et comparer une boucle Python et numpy sur les images de l'animation. Remplace le benchmark de conversion en gris sur une image fournie.

- **⌨️ Ajouter les paquets** : `conda install -c conda-forge numpy pillow` dans l'environnement `animation`, les ajouter à `environment.yml`, commit.
- **⌨️ Un effet au choix** : sur une branche, une option `--effet` ajoutée au programme du projet 4 (`argparse`, cours 3 et projet 4), qui applique l'effet à chaque image avant la création de la vidéo. Chaque élève choisit un effet parmi quatre ; le guide donne le calcul par pixel et le nom des fonctions numpy utiles.

  | Effet | Calcul par pixel | Version numpy |
  |---|---|---|
  | Caméra thermique | le niveau de gris, puis une table de 256 couleurs, du bleu au rouge | `table[gris]` |
  | Glitch | le canal rouge décalé de *k* pixels à droite, le bleu à gauche ; *k* change à chaque image | `np.roll` sur un canal |
  | Pixel art | l'image découpée en blocs de *n* × *n*, chaque bloc prend la couleur de son premier pixel, puis les couleurs sont réduites à quelques valeurs | tranches `[::n, ::n]`, `np.repeat`, `// 64 * 64` |
  | Vieux film | sépia (combinaison des trois canaux), bruit aléatoire, assombrissement selon la distance au centre | opérations sur le tableau entier, `np.hypot` |

  Les effets sont rangés du plus simple au plus long à écrire. Les effets s'appliquent aux deux TD du projet 4, car ils ne dépendent pas de la façon dont les images sont produites. Une version en boucle sur les pixels, puis une version numpy ; les chronométrer sur toute la série d'images, pour que l'écart soit multiplié par le nombre d'images.
- **⌨️ Vérifier** : un test qui compare les deux versions sur une petite image (`np.array_equal`), à la place de l'autograder de 2026.
- **⌨️ Pull request et revue** : pousser la branche, ouvrir la pull request, faire relire par un camarade ajouté comme collaborateur, qui a choisi un autre effet ; fusionner.
- **⌨️ `RAPPORT.md`** : une image avant et après l'effet, le tableau des temps, une phrase d'interprétation.
- **⌨️ Une version publiée** : `git tag v1` sur le commit rendu, `git push --tags` ; la version apparaît sur la page du dépôt. Reprend le TD 2e de 2026.
- **Facultatif** : appliquer deux effets à la suite (`--effet` répété) ; pour le TD de la montre, un cinquième effet, l'incrustation sur une photo choisie par l'élève à la place du fond blanc.
- **Facultatif, repris des § 5 et 6 d'`images.ipynb` du cours 3** : poids d'une image non compressée (largeur × hauteur × canaux) comparé au `shape` et au `dtype` du tableau numpy ; taille du dossier des images PNG comparée à la taille de la vidéo ; temps de lecture de la série en PNG et en `.npy`.
- **Guide** : l'objectif et la commande de vérification seulement, sans code à coller (troisième emploi de l'environnement, de la branche et du `merge`).

---

## 3. Contenu de 2026 et ce qu'il devient

Statuts : **gardé** (même séance), **réduit** (même séance, moins de temps ou de diapositives), **déplacé** (autre séance), **annexe** (hors séance, dans les annexes ou les exercices complémentaires), **retiré** (ne figure plus dans le module), **ajouté** (absent en 2026). Le détail diapositive par diapositive est à la section 4.

| 2026 | Contenu de 2026 | v2 | Statut |
|---|---|---|---|
| c1 | Ouverture du module | c1 | gardé |
| c1 | Logiciel, système d'exploitation, entrées et sorties, application web, extension, quiz des extensions | c1 | gardé |
| c1 | Chemins (quiz, absolu et relatif) | c1 : quiz en partie 1, après les formats ; « Le chemin d'un fichier » en partie terminal | gardé |
| c1 | Binaire et texte, octet, hexadécimal, ASCII, UTF-8 | c3, texte et binaire | déplacé |
| c1 | TD 1a, fichiers et extensions | c1, TD 1a à la souris, TD 1b en ligne de commande ; table ASCII au c3 | réduit |
| c1 | TD 1b, un `.odt` est une archive ZIP | — | annexe |
| c1 | Programme, compilé et interprété, place de l'interpréteur | c1, « compiler ou interpréter » refaite ; programme et application, place de l'interpréteur en annexe | réduit |
| c1 | Du code source aux instructions machine | — | annexe |
| c1 | Fonctions et édition d'un IDE | c2 | déplacé |
| c1 | Palette de commandes et réglages | c2, avec les niveaux User et Workspace et deux réglages faits par chaque élève | déplacé |
| c1 | TD 1c, configurer VS Code | c2, en classe entière, terminal Git Bash | déplacé |
| c1 | TD 1c, lancer un programme, Python en interactif | c1, TD 1c, dans Notepad++ et Git Bash | gardé |
| c1 | Débogueur pas à pas | archive 2026 ; c2 si le temps le permet | annexe |
| c1 | Indentation ; TD 1d, trois programmes fautifs | c2, TD 2b, dans VS Code | déplacé |
| c1 | TD 1e, le même programme en C++ | — | annexe |
| c1 | Markdown : syntaxe minimale | c1, dans les cellules de texte du notebook | réduit |
| c1 | Markdown : intention, syntaxe complète, TD 1f recette | intention dans les notes du c1 ; tableau, image, TD recette et conversion par pandoc au c2 (une diapositive et le TD 2c) ; plan du README et bloc de code au c3 ; diagramme `mermaid` en annexe | déplacé |
| c1 | Notebook, TD 1g ouvert de trois façons | c1, TD 1d, JupyterLab lancé depuis l'invite de commandes d'Anaconda puis Git Bash | réduit |
| c1 | Bibliothèques, dépendances, environnements (partie 4) | p4, partie A ; c3 pour la pratique | déplacé |
| c1 | `pyproject.toml` | c3, TD 3f étape 6 | déplacé |
| c1 | Le terminal de l'éditeur | c2 | déplacé |
| c1 | Client et serveur d'un notebook | c5, réseau | déplacé |
| c1 | TD 1h, installer le projet recette | c3, `conda create` et installation des paquets demandés | déplacé |
| c1 | TD 1i, le client et le noyau ; TD 1j, installer le projet trajet | — | annexe |
| c2 | Terminal, bash, commandes, arborescence, fichiers cachés, `*` | c1, partie terminal, avec TD | déplacé |
| c2 | Git : à quoi il sert, quand l'employer (13 pages) | c2, trois diapositives : les versions successives, les systèmes de version, les copies d'un dépôt | réduit |
| c2 | `init`, suivi, zone de préparation, commit | c2 | gardé |
| c2 | `revert` | — | annexe |
| c2 | `tag` | projet 7, sur la version rendue | déplacé |
| c2 | Branches, `HEAD`, `merge` | c2 | gardé |
| c2 | `rebase` | — | annexe |
| c2 | Conflits | c2 | gardé |
| c2 | `status`, `log`, `diff` | c2, avant le TD | gardé |
| c2 | `.gitignore` | c2 | gardé |
| c2 | Bonnes pratiques : messages de commit | c2, une diapositive | réduit |
| c2 | Bonnes pratiques : organisation main / develop / feature | c2, une diapositive théorique (`master`, `develop`, une branche par tâche) ; c6, les organisations du travail et la pull request | réduit |
| c2 | TD 2a, 2b, 2d (dépôt `projet_2`, quatre branches, conflit) | c2, un seul TD sur le dépôt de la recette | réduit |
| c2 | TD 2c (annuler et `rebase`) | — | annexe |
| c2 | TD 2e (publier une version) | projet 7, `tag` de la version rendue | déplacé |
| c3 | Préparation du poste en autonomie | c3, remplacée par le TD d'environnement | retiré |
| c3 | Chemins, `recette.ipynb`, pandoc, `PATH`, `subprocess` | c3 | gardé |
| c3 | `fichiers.ipynb` | c3, en TD | gardé |
| c3 | `images.ipynb` § 1, 2, 7 (PGM `P2` et `P5`, UTF-8) | c3, cellules exécutées avec la salle | réduit |
| c3 | `images.ipynb` § 3, 4 (`hexdump`, signatures) | — | annexe |
| c3 | `images.ipynb` § 5, 6 (poids, compression, temps de lecture) | projet 7, facultatif | déplacé |
| c3 | Du notebook au programme, `main`, `argparse`, TD 3f | c3 | gardé |
| p4 | Présentation, TD montre et tourbillon | p4 | gardé |
| p4 | Partie A, créer l'environnement et exécuter le notebook (35′) | p4, ≈ 20′ | réduit |
| p4 | Partie B, du notebook au programme | p4, avec 15′ de plus ; B4 (README) en séance | gardé |
| c5 | Matériel et réseau, ordres de grandeur, TD 5a | c5 | gardé |
| c5 | Mots de passe, clé SSH, secrets, TD 5b et 5c | c5, dans Git Bash au lieu de l'invite de commandes d'Anaconda | gardé |
| c6 | Forge : compte, `remote`, `clone`, `push`, `pull` | c6, sur le dépôt du projet 4 | gardé |
| c6 | Outil « trajectoire », jalons J1 à J5 | — | retiré |
| c6 | Boucle contre numpy | projet 7, sur l'effet choisi | déplacé |
| c6 | Lecture texte ligne par ligne contre lecture binaire d'un bloc | — ; en partie au c3 (`images.ipynb`) et au projet 7 (PNG contre `.npy`) | retiré |
| c6 | `conda install numpy` | projet 7 | déplacé |
| c6 | Conflit pré-amorcé (jalon J3) | c6, conflit entre le site et le dépôt local | gardé |
| p7 | Benchmark de conversion en gris sur une image fournie | projet 7, remplacé par un effet au choix appliqué à l'animation | retiré |
| p7 | Pull request, revue par un camarade, `RAPPORT.md` | projet 7 | gardé |
| p7 | Conflit par une branche pré-amorcée | c6 | déplacé |
| p7 | Plafond : flou, accès ligne contre colonne | — | retiré |
| p7 | Plafond : lecture PNG contre `.npy` | projet 7, facultatif | gardé |
| p7 | Squelette fourni, GitHub Classroom, autograder | projet 7, dépôt de l'élève publié au c6 ; test d'égalité boucle et numpy écrit par l'élève | retiré |
| — | Stockage local et distant, copie des fichiers du cours | c1 | ajouté |
| — | Conversion d'un `.md` par pandoc (HTML, `.odt`) | c2, dernière étape du TD 2c | ajouté |
| — | Systèmes de version, centralisé et distribué ; copies d'un dépôt | c2, en théorie ; pratique au c6, et à l'étape 7 du TD 2d pour ceux qui ont fini | ajouté |
| — | Graphe du dépôt dessiné par l'élève, comparé à `git log --graph` | c2, fin du TD 2d | ajouté |
| — | `conda init bash`, Git Bash comme terminal du module | c1 (TD 1c), rappel au c2 | ajouté |
| — | Interface graphique et ligne de commande ; choix de Git Bash | c1 | ajouté |
| — | Une commande désigne un fichier cherché dans `PATH` ; script de commandes | c1 | ajouté |
| — | Équivalents PowerShell et invite de commandes des commandes du TD 1b | c1, annexe du guide | ajouté |
| — | Première utilisation d'une pull request | c6 | ajouté |
| — | Ajouter des paquets à un environnement existant et à son `environment.yml` | projet 7 | ajouté |
| — | Option `--effet` : quatre effets au choix sur les images de l'animation | projet 7 | ajouté |
| — | Début de séance identique, fait sans guide *(à valider)* | c2 à p7 | ajouté |
| — | Aide-mémoire d'une page, complété à chaque séance *(à valider)* | c1 à p7 | ajouté |

## 4. Déplacements, diapositive par diapositive

| Diapositives de 2026 | Titre | Vers |
|---|---|---|
| c1 · 15, 16 | Quiz chemins | c1, partie 1, après les formats |
| c1 · 17 | Le chemin d'un fichier | c1, partie 2 (terminal), avec c2 · 5 à 11 |
| c1 · 19, 20, 31 | Binaire et texte ; Le fichier texte ; Table ASCII | c3 : la 19 dans la partie encodage (reprise le 28/09/2026), les autres à l'ouverture de `images.ipynb` |
| c1 · 39, 42 | Programme et application ; La place de l'interpréteur | annexe du book |
| c1 · 40 | Deux chemins du texte à l'exécution | c1, « Compiler ou interpréter », refaite |
| c1 · 33 à 37 | TD 1b | annexe |
| c1 · 41, 67 à 73 | Du code source aux instructions ; TD 1e | annexe |
| c1 · 43 à 47 | Fonctions et édition d'un IDE, indentation | c2 ; l'indentation avec le TD 2b |
| c1 · 63 à 66 | TD 1d, trois programmes fautifs | c2, TD 2b |
| c1 · 48 à 56 | TD 1c, configuration de VS Code | c2, classe entière |
| c1 · 57 à 60 | Programme du TD, lancer, Python interactif, invite de commandes d'Anaconda | c1, TD 1c sans VS Code, dans Git Bash ; l'invite d'Anaconda sur « Python, un programme en ligne de commande » |
| c1 · 61, 62 | Débogueur | archive 2026, ou c2 si le temps le permet |
| c1 · 74 à 78, 83 à 87 | Markdown, TD 1f | syntaxe minimale et intention (notes) au c1 (partie 3) ; TD recette au c2 ; README (78) au c3 |
| c1 · 54 | La palette de commandes et les réglages | c2, les réglages |
| c1 · 79 à 82, 88 à 89 | Notebook, TD 1g | c1 allégé (partie 3, TD 1d) |
| c1 · 90 à 101 | Bibliothèques, dépendances, environnements | p4, partie A ; `PATH` (101) au c1 |
| c1 · 102 | `pyproject.toml` | c3, TD 3f étape 6 |
| c1 · 103 | Le terminal de l'éditeur | c2 |
| c1 · 104 à 106 | Client et serveur d'un notebook | c5, réseau |
| c1 · 107 à 113 | TD 1h, installer le projet recette | c3, ouverture pratique (même démarche sur l'environnement de la séance) |
| c1 · 114 à 122 | TD 1i, TD 1j | annexes |
| c2 · 2 à 14 | Terminal, bash, commandes, arborescence, fichiers cachés, `*` | c1, partie 2 (terminal) |
| c2 · 15 à 27 | Git : c'est quoi ? ; Fonctionnalités ; Quand l'utiliser ? | c2, ramenées à trois diapositives (à quoi sert git, les systèmes de version, les copies d'un dépôt) |
| c2 · 36, 46 | `revert`, `rebase` | annexe |
| c2 · 37 | `tag` | projet 7 |
| c2 · 72 | Organisation main / develop / feature | c2, « L'organisation des branches à plusieurs », en théorie ; c6 |
| c2 · 62 à 64 | Afficher les informations | c2, avant le TD |
| c2 · 66 à 71 | Bonnes pratiques | c2, une diapositive (messages de commit) |
| c2 · TD 2a, 2b, 2d | Premier dépôt, branches et fusions, conflit | c2, un seul TD sur le dépôt de la recette |
| c2 · TD 2c | Annuler et `rebase` | annexe |
| c2 · TD 2e | Publier une version | projet 7 (`tag`) |
| c3 · `images.ipynb` § 1, 2, 7 | PGM `P2` et `P5`, UTF-8 | c3, cellules exécutées avec la salle |
| c3 · `images.ipynb` § 3, 4 | `hexdump`, signatures | annexe |
| c3 · `images.ipynb` § 5, 6 | Poids, compression, temps de lecture | projet 7, facultatif |
| c6 de 2026 | Outil « trajectoire », numpy | retirés ; numpy au projet 7 |

## 5. À vérifier avant d'écrire les supports

1. Sur un poste de la salle : `conda init bash` dans Git Bash tient-il d'une session à l'autre sans droits d'administrateur ? Toute l'orientation « Git Bash partout » en dépend.
2. Réponses du 26 et 27/09/2026 : le Bureau du poste est conservé d'une séance à l'autre ; pas d'accès au réseau de l'école depuis chez soi ; pas de stockage en ligne fourni par l'école, a priori. Reste à relever : le nom et le chemin de l'espace personnel, et le chemin réel de `formationTemp`.
3. Notepad++ est-il installé sur tous les postes de la salle ?
4. Les autres cours du programme demandent-ils, en septembre, de lancer un script, d'ouvrir un notebook, ou d'utiliser VS Code ? Si c'est VS Code, le reporter au cours 2 les gêne pendant une semaine.
5. `start` ouvre-t-il un fichier depuis Git Bash sur les postes de la salle, ou faut-il `explorer.exe` ?
6. `unzip` est-il présent dans le Git Bash des postes ? Sinon, la décompression du début de séance se fait à la souris.
7. Un environnement créé par `conda create` apparaît-il comme noyau dans JupyterLab lancé depuis `base`, ou faut-il y installer `ipykernel` ? Le TD d'environnement du cours 3 en dépend.
8. Le temps de la boucle Python de chaque effet sur toute la série d'images du projet 4 : assez long pour montrer l'écart, assez court pour finir en séance (réduire la taille ou le nombre d'images si besoin). Écrire les quatre effets en boucle et en numpy avant de rédiger le guide.
9. pandoc est-il présent dans `base` sur les postes de la salle ? Le TD Markdown du cours 2 en dépend ; au cours 3, l'environnement `cours3` ne voit plus celui de `base` et l'erreur « pandoc introuvable » reste à montrer.
10. `D:` est-il un disque du poste ?
11. Dans Git Bash, sans conda, que lancent `python --version` et `type -a python` (un Python 2.7 dans `C:\Python27` est supposé) ? `python` seul affiche-t-il l'invite `>>>` dans la fenêtre de Git Bash, ou faut-il `winpty` ?
12. Les commandes PowerShell et invite de commandes du guide du TD 1b, et `commandes.bat`, fonctionnent-elles en salle ?
13. Le nom du raccourci de l'invite de commandes d'Anaconda (« Anaconda Prompt ») et son dossier de départ.
14. Le compte `eleve` est-il partagé entre plusieurs élèves ? `~/.bash_profile`, écrit par `conda init bash`, le serait aussi.
