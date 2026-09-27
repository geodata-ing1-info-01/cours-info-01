# Syllabus v2 — Introduction à l'informatique (proposition pour 2027-2028)

> Proposition de refonte ouverte le 24/09/2026, après les séances 1 et 2. Le module tel qu'il est joué en 2026-2027 reste décrit dans [`01_syllabus_v1.md`](01_syllabus_v1.md). Les orientations de la section 2 sont arrêtées ; le reste (contenu fin, budgets, points à vérifier) est à reprendre séance par séance. La répartition des séances entre intervenants se fera sur cette version.
> Ce qui peut en être repris dès 2026-2027 (séances 3 à 7) est dans le [syllabus v1.5](03_syllabus_v1_5.md).
> Les numéros de diapositive renvoient aux PDF projetés de 2026, avec TD (`src/cours<n>/diapo/cours<n>.pdf`, compilés le 24/09) ; le titre est donné à côté, les numéros bougeant à chaque modification.

## 1. Constats de 2026

**Cours 1 trop long.** 123 diapositives et dix TD pour 2 h. Les parties 1 à 3 ont été jouées, la partie 4 (bibliothèques et environnements, diapositives 90 à 122) ne l'a pas été. La capacité réelle observée est d'environ 90′ de contenu après 10′ d'ouverture.

**Cours 2 un peu trop ambitieux.** 95′ de TD annoncés (3a, 4a, 4b, 4c, 6a), plus l'exposé. Git y va jusqu'au `rebase`, au `tag` et à l'organisation main / develop / feature, que le cours 6 reprend en équipe.

**Ligne de commande vue sans pratique.** Au cours 2, 13 pages d'exposé, sans TD. Les élèves ont manqué d'aisance avec le terminal, dont tous les cours suivants dépendent.

**Un terminal différent à chaque séance**, sans que leur différence soit expliquée :

| Cours | Terminal employé |
|---|---|
| 1, TD 2a | terminal de VS Code (PowerShell, qui refuse `activate.ps1`), remplacé par un profil « Anaconda Prompt » |
| 2 | bash (captures sous Linux) |
| 3 | invite de commandes d'Anaconda (préparation), Git Bash avec `conda init bash` (TD 3a) |
| 4 | Git Bash dans VS Code |
| 5 | invite de commandes d'Anaconda ; « Git Bash a la sienne » pour la clé SSH |

**Configuration de VS Code plus longue que prévu.** Au TD 2a du cours 1, chaque élève a configuré seul l'éditeur (extension, interpréteur, profil de terminal). Les problèmes de configuration, propres à chaque poste, et la prise en main d'un outil nouveau ont pris plus que les 25′ prévues, et c'est ce qui a repoussé la partie 4 hors de la séance.

**Travail perdu dans le dossier partagé.** À la séance 1, des élèves ont travaillé directement dans `formationTemp` et y ont perdu leur travail ([`src/avant/donnees.md`](../src/avant/donnees.md)). La différence entre le disque du poste et un dossier du réseau n'est expliquée nulle part avant le cours 5.

**Notions traitées deux fois.** Texte et binaire, ASCII et UTF-8 : cours 1 (diapositives 19, 20, 31) et cours 3 (TD 2b). `PATH` et activation : cours 1 (101) et cours 3 (« Où le terminal trouve pandoc »). Chemins : cours 1 (15 à 17), cours 2 (arborescence, 5 à 9), cours 3 (`pathlib`). Client et serveur : cours 1 (104 à 106) et cours 5 (22).

## 2. Orientations retenues

| Séance | Retire | Reçoit |
|---|---|---|
| **1** | VS Code et l'IDE (TD 2a, fonctions et édition d'un IDE), environnements et bibliothèques (partie 4), Markdown, binaire et texte | stockage local et distant et copie des fichiers du cours, à la suite des logiciels et fichiers ; terminal Git Bash et commandes de base, traités avec le premier programme (édité dans Notepad++, lancé au terminal), une partie du TD 1a faite en ligne de commande ; ouverture d'un notebook, avec la syntaxe minimale de Markdown dans ses cellules de texte |
| **2** | la ligne de commande ; `revert`, `tag`, `rebase` et organisation main / develop / feature (en annexe) ; TD 4b et 6a | configuration de VS Code en classe entière en début de séance ; les réglages de VS Code ; l'IDE ; Markdown complété (origine, conversion par pandoc, README), qui fournit les fichiers des premiers commits |
| **3** | la préparation du poste en autonomie ; dans `images.ipynb`, `hexdump`, les signatures BMP et PNG, le poids, la compression, le temps de lecture | les environnements, traités par la pratique : créer un environnement et y installer les paquets que demandent les notebooks ; le binaire et le texte du cours 1 ; `fichiers.ipynb` en TD |
| **4** | l'explication des environnements (acquise au cours 3) | du temps pour la partie B |
| **5** | — | le serveur de notebook comme exemple de client et serveur |
| **6** | l'outil « trajectoire », numpy | la forge sur le dépôt du projet 4 |
| **7** | le benchmark de conversion en gris sur une image fournie | une option `--effet` ajoutée au programme du projet 4 (un effet au choix parmi quatre, appliqué à chaque image), écrite en boucle puis avec numpy ; en facultatif, le poids, la compression et le temps de lecture de `images.ipynb` |

Le module a deux projets suivis : la recette (cours 1 à 3) et l'animation (cours 4, 6 et 7).

**Compétences visées.** Ce que chaque élève doit savoir faire seul à la fin du module. Tout contenu qui ne sert pas l'une de ces compétences, ou la notion qui l'explique, passe en annexe.

| Compétence | Vue | Réemployée |
|---|---|---|
| Fichiers et dossiers, extension, chemin | c1 | début de chaque séance |
| Dossier partagé et disque local ; copier et décompresser les données | c1 | début de chaque séance |
| Lancer un notebook sur un poste de l'école | c1 | c3, c4 |
| Terminal et interpréteur ; commandes simples | c1 | c2 à c7, en Git Bash |
| Configurer et utiliser VS Code | c2 | c3, c4, c6, c7 |
| Git Bash dans VS Code | c2 | c3, c4, c6, c7 |
| Git local : `status`, `add`, `commit`, `log`, `diff`, `.gitignore`, branche, `merge`, conflit | c2 | c3, c4, c6, c7 |
| Créer un environnement conda et y installer un paquet demandé | c3 | c4 (depuis `environment.yml`), c7 (ajout de numpy et Pillow) |
| Écrire un README en Markdown | c1 (syntaxe minimale, dans un notebook), c2 | c3 (étape 4), c4 (B4), c7 (`RAPPORT.md`) |
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

**Une configuration par séance.** L'ordre des séances sert aussi à répartir les étapes d'installation et de configuration, qui sont ce qui déborde, et à laisser aux élèves le temps de prendre en main un outil avant le suivant : Git Bash et `conda init bash` au cours 1, VS Code au cours 2 (en classe entière), un environnement conda au cours 3. Chaque séance n'en a qu'une, placée tôt, avec une vérification immédiate ; chaque outil est ensuite réemployé à la séance suivante avant qu'un autre s'ajoute.

Terminal de référence du module : **Git Bash**, configuré au cours 1 (`conda init bash`), rappelé au cours 2, employé ensuite partout, cours 5 compris. C'est le langage du cours 2 et des postes macOS et Linux des élèves, et le cours 4 l'emploie déjà.

---

## Cours 1 — Logiciels, fichiers, terminal et premier programme (CM)

Objectif : savoir où sont ses fichiers et où les ranger, se déplacer et agir sur des fichiers depuis un terminal, écrire un programme Python dans un éditeur de texte et le lancer, ouvrir un notebook.

- **🎓 10′ · Ouverture du module** : diapositives 2 à 8 de 2026, inchangées sur le fond.
- **Partie 1 · Logiciels, fichiers et stockage (30′)**
  - 🎓 10′ · logiciel, système d'exploitation, entrées et sorties, application web, utilité d'un fichier, extension et type de fichier, quiz des extensions (diapositives 10 à 14, 18, 21, 22). Une phrase sur le texte : un fichier texte s'ouvre dans un éditeur de texte, les autres dans le logiciel de leur format ; le détail en octets est au cours 3.
  - 🎓 5′ · **stockage local et distant** *(nouveau)* : où est un fichier (disque du poste, dossier partagé sur un serveur de l'école `formationTemp`, espace personnel réseau, stockage en ligne synchronisé, clé USB) ; pour chacun, qui le voit, ce qui arrive quand deux personnes y écrivent, ce qui reste après la déconnexion, la vitesse (un mot, les chiffres sont au cours 5). Un chemin qui commence par `\\` ou par une autre lettre que `C:` est sur le réseau.
  - ⌨️ 5′ · copier l'archive de la séance depuis `formationTemp` dans `Desktop\info01`, la décompresser, vérifier la barre d'adresse. Reprend la page [`src/avant/donnees.md`](../src/avant/donnees.md) : ce qui était une consigne devient une notion, appliquée tout de suite. En fin de séance, emporter son travail (où : à préciser, voir section 5).
  - ⌨️ 10′ · **TD 1a, première moitié, à la souris** : afficher les extensions, exporter `raven.odt` sous deux autres formats, ouvrir une page HTML depuis le disque, Bloc-notes et Notepad++ sur les mêmes fichiers. La table ASCII part au cours 3.
- **Partie 2 · Terminal et premier programme (50′)** *(le terminal est repris du cours 2 de 2026)*
  - 🎓 10′ · le terminal (la fenêtre) et l'interpréteur de commandes (le langage : cmd, PowerShell, bash) ; une diapositive-tableau des terminaux du poste (où le trouver, son langage, les cours qui l'emploient) qui justifie le choix de Git Bash ; lire l'invite (utilisateur, dossier courant) ; `commande [options] <arguments>`, `--help` ; chemin absolu et relatif, `.` et `..`, fichiers cachés (fusion des diapositives 15 à 17 du cours 1 et 5 à 11 du cours 2) ; le motif `*`, présenté comme un motif de noms de fichiers (le cours 2 de 2026 l'appelait à tort « expressions régulières »).
  - ⌨️ 15′ · **TD 1a, seconde moitié, en ligne de commande** : ouvrir Git Bash dans `cours1/1a_formats/` ; `pwd`, `ls`, `ls -a`, `cd` ; copier `depart/` vers `travail/` (`cp`) ; renommer une extension (`mv raven_odt.odt raven_odt.pdf`) puis ouvrir le fichier (`start`) pour voir l'effet ; créer un nom avec espace et constater qu'il faut des guillemets ; `conda init bash`, une fois, puis `python --version` dans un nouveau terminal.
  - 🎓 5′ · programme et application, compilé et interprété, la place de l'interpréteur (diapositives 39, 40, 42) ; un programme est un fichier texte, n'importe quel éditeur de texte suffit pour l'écrire, et le terminal le fait exécuter par l'interpréteur.
  - ⌨️ 10′ · **TD 2a** : ouvrir `altitudes.py` dans Notepad++, le lancer dans Git Bash (`python altitudes.py`), le modifier, le relancer ; Python en interactif (`python`, puis `exit()`).
  - ⌨️ 10′ · **TD 2b · Trois programmes fautifs**, dans Notepad++ (Affichage → Symboles spéciaux → Afficher tous les caractères) : espaces et tabulations, puis corriger et relancer au terminal.
- **Partie 3 · Un notebook et la syntaxe minimale de Markdown (15′)**
  - 🎓 un notebook : texte, code et résultat dans un seul document ; un bloc de code s'exécute dans un noyau qui retient les variables (diapositives 79, 81).
  - 🎓 une cellule de texte est écrite en Markdown : titre (`#`, `##`), paragraphe (ligne vide), gras et italique, liste à puces et numérotée, lien, code dans le texte. Une diapositive-tableau : ce qu'on tape, ce qui s'affiche. L'origine de Markdown, la conversion et le README sont au cours 2.
  - ⌨️ **TD 3b allégé** : `altitudes.ipynb` ouvert dans JupyterLab (depuis Navigator, ou `jupyter lab` dans Git Bash) ; exécuter les cellules dans le désordre, voir ce que le noyau retient ; ajouter une cellule de texte en tête (titre, une phrase qui dit ce que fait le programme, une liste des données lues, un lien), puis l'exécuter pour l'afficher.
- **Clôture** : « À retenir », resserré sur logiciel, extension, disque local et réseau, terminal, chemin relatif, interpréteur, notebook.

**Budget** : 10 + 30 + 50 + 15 = **105′**, 5′ de plus que ce qui a été joué en 2026. Les minutes ne disent pas tout : le cours 1 de 2026 a débordé sur la configuration de VS Code, poste par poste, et le cours 1 v2 n'a plus qu'une étape de configuration (`conda init bash`), placée dans un TD court et vérifiée aussitôt par `python --version`. Si la séance déborde malgré tout, la partie 3 passe en début de cours 3, qui ouvre des notebooks de toute façon ; le TD 2b ensuite.

**En annexe** : TD 1b (`.odt` archive ZIP), TD 2c (C++) avec la diapositive 41 (étapes de la compilation), débogueur pas à pas (diapositives 61, 62), TD 4c (trajet).

## Cours 2 — Éditeur de code, Markdown et git local (CM)

Objectif : travailler dans un éditeur de code configuré, écrire de la documentation en Markdown, et versionner ce travail avec git en local.

- **⌨️ 20′ · Configuration de VS Code, en classe entière** : l'enseignant projette, chaque élève fait la même étape en même temps, on ne passe à la suivante que lorsque la salle a fini. Lancer VS Code ; installer l'extension Python ; choisir l'interpréteur ; faire de Git Bash le terminal par défaut (`terminal.integrated.defaultProfile.windows`) ; ouvrir le dossier `cours2/` ; vérifier `(base)` et `python --version` dans le terminal intégré. Reprend les diapositives 50 à 56 du cours 1 de 2026, remplace le profil « Anaconda Prompt » par Git Bash, et s'appuie sur [`src/annexes/configuration/vscode.md`](../src/annexes/configuration/vscode.md).
  - Le guide du TD, plus détaillé qu'en 2026 : une capture par étape, la vérification attendue, et la réponse aux blocages connus (PowerShell et `activate.ps1`, interpréteur absent de la liste, webview de l'aperçu). Distribué avant la séance pour les élèves qui veulent prendre de l'avance.
- **Les réglages (5′)**, en classe entière, à la suite de la configuration : 🎓 la palette de commandes (`Ctrl` + `Maj` + `P`) et les réglages (`Ctrl` + `,`), diapositive 54 du cours 1 de 2026 ; deux niveaux, User (le compte, tous les dossiers) et Workspace (`.vscode/settings.json` du dossier ouvert, qui l'emporte), d'après [`src/annexes/configuration/vscode.md`](../src/annexes/configuration/vscode.md), section « Les réglages »). ⌨️ Chaque élève règle au niveau User `editor.renderWhitespace` sur `all` (les espaces et tabulations du TD 2b du cours 1) et `files.autoSave` ; il ouvre le `settings.json` correspondant pour voir le même réglage en texte. Le profil de terminal Git Bash, réglé à l'étape précédente, en est un troisième exemple.
- **🎓 10′ · L'IDE** : les fonctions d'un IDE ; édition (coloration syntaxique, chasse fixe, indentation) ; dossier ouvert = projet (diapositives 43 à 47 du cours 1 de 2026).
- **Markdown (20′)**, suite de la syntaxe minimale vue dans le notebook du cours 1
  - 🎓 l'intention de Markdown (Gruber, 2004 : un texte lisible tel quel, sans aperçu) ; ce qui s'ajoute à la syntaxe du cours 1 : tableau, bloc de code, image ; un fichier `.md` se convertit en HTML, en `.odt` ou en PDF par pandoc ; le README d'un projet, affiché par la forge en page d'accueil du dépôt (diapositives 75 à 78 du cours 1 de 2026).
  - ⌨️ la recette en Markdown avec l'aperçu de VS Code (TD 3a du cours 1 de 2026, sans le diagramme `mermaid`, qui passe en annexe) ; `pandoc recette.md -o recette.html`, ouvrir la page dans le navigateur ; `pandoc recette.md -o recette.odt`, l'ouvrir dans LibreOffice (d'après [`data/cours1/3a_markdown/README.md`](../data/cours1/3a_markdown/README.md)). `recette.md` est le fichier du premier commit ; les `.html` et `.odt` produits servent ensuite au TD git.
- **Git local (≈ 60′)**
  - 🎓 20′ · à quoi sert git (diapositives 15 à 27 de 2026, treize pages, ramenées à trois : versions successives, travail en parallèle, quand l'employer) ; `init`, fichiers suivis et non suivis, zone de préparation, commit (28 à 35) ; `status`, `log --graph`, `diff` (62 à 64), placés avant le TD pour être employés à chaque étape ; `.gitignore` (65) ; annuler une modification non validée (`restore`) ; branche, `HEAD`, `merge` (41 à 45) ; conflit et sa résolution (47 à 49, sans `rebase --continue`) ; un message de commit, une diapositive tirée de 66 à 71.
  - ⌨️ 40′ · un dépôt pour la recette : premier commit, modifier le Markdown, lire le `diff`, committer à nouveau ; committer aussi le `.odt` produit par pandoc, le régénérer après la modification, et lire le `diff` (git indique seulement que les fichiers binaires diffèrent, comme `comparer.py` en 2026) ; ignorer les fichiers produits (`*.html`, `*.odt`) par `.gitignore` ; une branche pour une variante de la recette, fusionnée ; la même ligne modifiée sur deux branches, puis le conflit résolu. Tout depuis le terminal intégré de VS Code. Remplace les TD 3a, 4a et 4c de 2026, qui travaillaient sur `projet_2` et quatre branches.
- **En annexe** : `revert`, `tag`, `rebase`, organisation main / develop / feature (diapositives 36, 37, 46, 72 ; TD 4b et 6a de 2026). Le cours 6 n'en reprend que la branche de fonctionnalité, pour la pull request.

**Budget** : 20 + 5 + 10 + 20 + 60 = **115′**. Le rappel de Git Bash n'est plus une partie à part : la dernière étape de la configuration (`(base)` et `python --version` dans le terminal intégré) le vérifie. Le premier poste à surveiller est la configuration : si elle dépasse 20′ en classe entière, le guide distribué avant la séance doit la faire commencer avant.

## Cours 3 — Environnements, chemins et fichiers en Python, ligne de commande (CM)

Objectif : installer un projet dans son propre environnement, manipuler chemins et fichiers en Python, construire un programme en ligne de commande. Séance surtout pratique.

- **⌨️ 20′ · Un environnement pour la séance** *(remplace la préparation du poste, et la partie 4 du cours 1 de 2026)* : copier l'archive, ouvrir le dossier dans VS Code ; `conda create -n cours3 python=3.12`, `conda activate cours3` ; lancer `recette.ipynb` dans ce noyau et lire l'erreur (`pandoc` introuvable) ; `conda install -c conda-forge pandoc`, relancer ; même démarche pour Pillow, demandé par `images.ipynb` ; constater que ces paquets ne sont pas dans `base` ; choisir cet environnement comme interpréteur et comme noyau. La création depuis un `environment.yml` est faite au projet 4.
  - 🎓 intercalé, trois diapositives : dépendances et versions (95, 96), l'environnement contre les conflits (97), d'où viennent les paquets (99). L'activation et `PATH` (101) fusionnent avec « Où le terminal trouve pandoc ».
- **Chemins (20′)** : `recette.ipynb`, comme en 2026 ; le renvoi au « programme recette du cours 1 » disparaît, la recette est présentée ici.
- **Fichiers (20′)** : ⌨️ `fichiers.ipynb` en TD, comme en 2026 (`open`, `with`, modes, `encoding`, ligne par ligne, CSV, `read_text`).
- **Texte et binaire (15′)** : 🎓 le schéma bit → octet → hexadécimal → caractère (diapositive 19 du cours 1 de 2026) et la table ASCII (31), puis quelques cellules d'`images.ipynb` exécutées avec la salle : § 1 (cellules 1 à 5, PGM `P2` lu comme texte puis ouvert comme image), § 2 (7 à 10, le même en `P5`, octets et en-tête), § 7 (42, 47, 49 : octets de « é » en UTF-8, « é » décodé en cp1252, « œuf »). Le reste du notebook passe en lecture autonome : § 3 et 4 (`hexdump`, signatures) en annexe, § 5 et 6 (poids, compression, temps de lecture) repris au projet 7.
- **Ligne de commande (45′)** : TD 3a comme en 2026, l'étape 6 (`pyproject.toml`, `pip install -e .`) reçoit la diapositive 102 du cours 1 de 2026.

**Budget** : 20 + 20 + 20 + 15 + 45 = **120′**, sans marge. Ce qui se retire d'abord : les étapes facultatives du TD 3a, puis les § 5 et 6 de `fichiers.ipynb` (CSV, `pathlib`) en lecture autonome.

## Projet (séance 4) — Une animation, du notebook au programme

Inchangé sur le fond. La partie A (créer l'environnement `animation`, lancer JupyterLab) devient une application du cours 3 et passe de 35′ à ≈ 20′ ; les 15′ gagnées vont à la partie B, dont l'étape B4 (README) peut alors se faire en séance.

## Cours 5 — Matériel, réseau ; mots de passe, clés, secrets (CM)

Inchangé sur le fond. La diapositive « Client et serveur » reçoit l'exemple du serveur de notebook sur son propre poste (`localhost:8888`, diapositives 104 à 106 du cours 1 de 2026), et « Local et distant » renvoie à la partie stockage du cours 1. Les TD passent de l'invite de commandes d'Anaconda à Git Bash (`cat ~/.ssh/id_ed25519.pub` au lieu de `type %USERPROFILE%\…`).

## Cours 6 — La forge, sur le dépôt du projet 4 (CM)

Objectif : avoir employé une fois GitHub de bout en bout (dépôt distant, `push`, `pull`, `clone`, conflit, pull request). L'outil « trajectoire » de 2026 est retiré : le cours 6 ne demande pas d'écrire de code nouveau.

- **🎓 15′ · La forge** : compte, dépôt distant, `remote`, `clone`, `push`, `pull` ; branche de fonctionnalité et pull request (seule reprise de l'organisation des branches de 2026).
- **⌨️ 20′ · Publier son dépôt** : créer un dépôt vide sur GitHub ; `git remote add origin`, `git push -u origin master` avec la clé SSH du cours 5 ; voir l'historique sur le site.
- **⌨️ 20′ · Deux copies du même dépôt** : `git clone` dans un autre dossier ; un commit dans ce clone, `push` ; `pull` dans le premier dossier.
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
| c1 | Chemins (quiz, absolu et relatif) | c1, partie terminal, fusionnés avec l'arborescence du c2 | gardé |
| c1 | Binaire et texte, octet, hexadécimal, ASCII, UTF-8 | c3, texte et binaire | déplacé |
| c1 | TD 1a, fichiers et extensions | c1, à la souris puis en ligne de commande ; table ASCII au c3 | réduit |
| c1 | TD 1b, un `.odt` est une archive ZIP | — | annexe |
| c1 | Programme, compilé et interprété, place de l'interpréteur | c1 | gardé |
| c1 | Du code source aux instructions machine | — | annexe |
| c1 | Fonctions et édition d'un IDE | c2 | déplacé |
| c1 | Palette de commandes et réglages | c2, avec les niveaux User et Workspace et deux réglages faits par chaque élève | déplacé |
| c1 | TD 2a, configurer VS Code | c2, en classe entière, terminal Git Bash | déplacé |
| c1 | TD 2a, lancer un programme, Python en interactif | c1, dans Notepad++ et Git Bash | gardé |
| c1 | Débogueur pas à pas | — | annexe |
| c1 | TD 2b, trois programmes fautifs | c1, dans Notepad++ | gardé |
| c1 | TD 2c, le même programme en C++ | — | annexe |
| c1 | Markdown : syntaxe minimale | c1, dans les cellules de texte du notebook | réduit |
| c1 | Markdown : intention, syntaxe complète, TD 3a recette | c2, avec la conversion par pandoc et le README ; diagramme `mermaid` en annexe | déplacé |
| c1 | Notebook, TD 3b ouvert de trois façons | c1, dans JupyterLab seulement | réduit |
| c1 | Bibliothèques, dépendances, environnements (partie 4) | c3, quatre diapositives dans le TD d'environnement | déplacé |
| c1 | `pyproject.toml` | c3, TD 3a étape 6 | déplacé |
| c1 | Le terminal de l'éditeur | c2 | déplacé |
| c1 | Client et serveur d'un notebook | c5, réseau | déplacé |
| c1 | TD 4a, installer le projet recette | c3, `conda create` et installation des paquets demandés | déplacé |
| c1 | TD 4b, le client et le noyau ; TD 4c, installer le projet trajet | — | annexe |
| c2 | Terminal, bash, commandes, arborescence, fichiers cachés, `*` | c1, partie terminal, avec TD | déplacé |
| c2 | Git : à quoi il sert, quand l'employer (13 pages) | c2, trois diapositives | réduit |
| c2 | `init`, suivi, zone de préparation, commit | c2 | gardé |
| c2 | `revert`, `tag` | — | annexe |
| c2 | Branches, `HEAD`, `merge` | c2 | gardé |
| c2 | `rebase` | — | annexe |
| c2 | Conflits | c2 | gardé |
| c2 | `status`, `log`, `diff` | c2, avant le TD | gardé |
| c2 | `.gitignore` | c2 | gardé |
| c2 | Bonnes pratiques : messages de commit | c2, une diapositive | réduit |
| c2 | Bonnes pratiques : organisation main / develop / feature | — ; le c6 garde la branche de fonctionnalité pour la pull request | annexe |
| c2 | TD 3a, 4a, 4c (dépôt `projet_2`, quatre branches, conflit) | c2, un seul TD sur le dépôt de la recette | réduit |
| c2 | TD 4b (annuler et `rebase`), TD 6a (publier une version) | — | annexe |
| c3 | Préparation du poste en autonomie | c3, remplacée par le TD d'environnement | retiré |
| c3 | Chemins, `recette.ipynb`, pandoc, `PATH`, `subprocess` | c3 | gardé |
| c3 | `fichiers.ipynb` | c3, en TD | gardé |
| c3 | `images.ipynb` § 1, 2, 7 (PGM `P2` et `P5`, UTF-8) | c3, cellules exécutées avec la salle | réduit |
| c3 | `images.ipynb` § 3, 4 (`hexdump`, signatures) | — | annexe |
| c3 | `images.ipynb` § 5, 6 (poids, compression, temps de lecture) | projet 7, facultatif | déplacé |
| c3 | Du notebook au programme, `main`, `argparse`, TD 3a | c3 | gardé |
| p4 | Présentation, TD montre et tourbillon | p4 | gardé |
| p4 | Partie A, créer l'environnement et exécuter le notebook (35′) | p4, ≈ 20′ | réduit |
| p4 | Partie B, du notebook au programme | p4, avec 15′ de plus ; B4 (README) en séance | gardé |
| c5 | Matériel et réseau, ordres de grandeur, TD 1a | c5 | gardé |
| c5 | Mots de passe, clé SSH, secrets, TD 2a et 3a | c5, dans Git Bash au lieu de l'invite de commandes d'Anaconda | gardé |
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
| — | Conversion d'un `.md` par pandoc (HTML, `.odt`) ; `diff` d'un fichier binaire dans git | c2 | ajouté |
| — | `conda init bash`, Git Bash comme terminal du module | c1, rappel au c2 | ajouté |
| — | Première utilisation d'une pull request | c6 | ajouté |
| — | Ajouter des paquets à un environnement existant et à son `environment.yml` | projet 7 | ajouté |
| — | Option `--effet` : quatre effets au choix sur les images de l'animation | projet 7 | ajouté |
| — | Début de séance identique, fait sans guide *(à valider)* | c2 à p7 | ajouté |
| — | Aide-mémoire d'une page, complété à chaque séance *(à valider)* | c1 à p7 | ajouté |

## 4. Déplacements, diapositive par diapositive

| Diapositives de 2026 | Titre | Vers |
|---|---|---|
| c1 · 15 à 17 | Quiz chemins ; Le chemin d'un fichier | c1, partie 2 (terminal), fusionnées avec c2 · 5 à 11 |
| c1 · 19, 20, 31 | Binaire et texte ; Le fichier texte ; Table ASCII | c3, ouverture de `images.ipynb` |
| c1 · 33 à 37 | TD 1b | annexe |
| c1 · 41, 67 à 73 | Du code source aux instructions ; TD 2c | annexe |
| c1 · 43 à 47 | Fonctions et édition d'un IDE | c2 |
| c1 · 48 à 56 | TD 2a, configuration de VS Code | c2, classe entière |
| c1 · 57 à 60 | Programme du TD, lancer, Python interactif, invite de commandes d'Anaconda | c1, TD 2a sans VS Code, dans Git Bash |
| c1 · 61, 62 | Débogueur | annexe, ou c2 si le temps le permet |
| c1 · 74 à 78, 83 à 87 | Markdown, TD 3a | syntaxe minimale au c1 (partie 3) ; le reste au c2 |
| c1 · 54 | La palette de commandes et les réglages | c2, les réglages |
| c1 · 79 à 82, 88 à 89 | Notebook, TD 3b | c1 allégé (partie 3) |
| c1 · 90 à 101 | Bibliothèques, dépendances, environnements | c3, ouverture pratique (quatre diapositives) |
| c1 · 102 | `pyproject.toml` | c3, TD 3a étape 6 |
| c1 · 103 | Le terminal de l'éditeur | c2 |
| c1 · 104 à 106 | Client et serveur d'un notebook | c5, réseau |
| c1 · 107 à 113 | TD 4a, installer le projet recette | c3, ouverture pratique (même démarche sur l'environnement de la séance) |
| c1 · 114 à 122 | TD 4b, TD 4c | annexes |
| c2 · 2 à 14 | Terminal, bash, commandes, arborescence, fichiers cachés, `*` | c1, partie 2 (terminal) |
| c2 · 15 à 27 | Git : c'est quoi ? ; Fonctionnalités ; Quand l'utiliser ? | c2, ramenées à trois diapositives |
| c2 · 36, 37, 46, 72 | `revert`, `tag`, `rebase`, organisation main / develop / feature | annexe |
| c2 · 62 à 64 | Afficher les informations | c2, avant le TD |
| c2 · 66 à 71 | Bonnes pratiques | c2, une diapositive (messages de commit) |
| c2 · TD 3a, 4a, 4c | Premier dépôt, branches et fusions, conflit | c2, un seul TD sur le dépôt de la recette |
| c2 · TD 4b, 6a | Annuler et `rebase`, publier une version | annexe |
| c3 · `images.ipynb` § 1, 2, 7 | PGM `P2` et `P5`, UTF-8 | c3, cellules exécutées avec la salle |
| c3 · `images.ipynb` § 3, 4 | `hexdump`, signatures | annexe |
| c3 · `images.ipynb` § 5, 6 | Poids, compression, temps de lecture | projet 7, facultatif |
| c6 de 2026 | Outil « trajectoire », numpy | retirés ; numpy au projet 7 |

## 5. À vérifier avant d'écrire les supports

1. Sur un poste de la salle : `conda init bash` dans Git Bash tient-il d'une session à l'autre sans droits d'administrateur ? Toute l'orientation « Git Bash partout » en dépend.
2. Le Bureau du poste est-il conservé d'une séance à l'autre, ou effacé à la déconnexion ? Et quel stockage l'école donne-t-elle aux élèves (espace réseau personnel, OneDrive de l'école, autre) ? La partie 2 du cours 1 en dépend.
3. Notepad++ est-il installé sur tous les postes de la salle ?
4. Les autres cours du programme demandent-ils, en septembre, de lancer un script, d'ouvrir un notebook, ou d'utiliser VS Code ? Si c'est VS Code, le reporter au cours 2 les gêne pendant une semaine.
5. `start` ouvre-t-il un fichier depuis Git Bash sur les postes de la salle, ou faut-il `explorer.exe` ?
6. `unzip` est-il présent dans le Git Bash des postes ? Sinon, la décompression du début de séance se fait à la souris.
7. Un environnement créé par `conda create` apparaît-il comme noyau dans JupyterLab lancé depuis `base`, ou faut-il y installer `ipykernel` ? Le TD d'environnement du cours 3 en dépend.
8. Le temps de la boucle Python de chaque effet sur toute la série d'images du projet 4 : assez long pour montrer l'écart, assez court pour finir en séance (réduire la taille ou le nombre d'images si besoin). Écrire les quatre effets en boucle et en numpy avant de rédiger le guide.
9. pandoc est-il présent dans `base` sur les postes de la salle ? Le TD Markdown du cours 2 en dépend ; au cours 3, l'environnement `cours3` ne voit plus celui de `base` et l'erreur « pandoc introuvable » reste à montrer.
