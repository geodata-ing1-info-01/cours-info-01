# Syllabus v1 — Introduction à l'informatique (bac+2, 14 h)

> Public : 1re année d'école d'ingénieurs (géomatique), profils variés (prépa littéraire ou scientifique).
> Ce fichier décrit le module **tel qu'il est joué en 2026-2027**. Les cours 1 à 5 sont décrits d'après leurs diapositives (`src/cours<n>/diapo/`), relevées le 24/09/2026 ; les cours 6 et 7 sont encore au stade de l'intention. Le détail par séance vit dans `cours/<n>_.../` (`contenu_detaille.md` + `exercices_complementaires.md`). Voir aussi [`README.md`](../README.md).
> La refonte envisagée après les premières séances est dans [`02_syllabus_v2.md`](02_syllabus_v2.md).
> Les séances 3 à 7 de 2026-2027 suivent le [syllabus v1.5](03_syllabus_v1_5.md), qui reprend une partie du v2.

## Tableau des séances

| # | date | type | Séance (2 h) | Contenu |
|---|------|------|--------------|---------|
| 1 | 15/09 8h30-10h30 | CM | Logiciel, programmation, formats de fichier, environnement | logiciel, système, chemins, extensions, texte et binaire ; compilé et interprété, VS Code ; Markdown et notebook ; bibliothèques et environnements conda (**partie non traitée**) |
| 2 | 22/09 8h30-10h30 | CM | Ligne de commande et git local | terminal et bash, arborescence, fichiers cachés, `*` ; git : commit, `revert`, `tag`, branches, `merge`/`rebase`, conflits, `log`/`diff`/`status`, `.gitignore`, organisation main/develop/feature |
| 3 | 29/09 8h30-10h30 | CM | Chemins, fichiers et ligne de commande, en Python | `pathlib`, `subprocess` (pandoc), `PATH` ; `open`, `with`, modes, CSV ; texte et binaire (PGM P2/P5, hexadécimal, signature, poids, compression, ASCII/UTF-8) ; `main`, `argparse`, un commit par étape |
| 4 | 6/10 8h30-10h30 | projet | Une animation, du notebook au programme | environnement conda depuis `environment.yml`, JupyterLab ; script construit par fonctionnalités (une image, une série, la vidéo), une branche par fonctionnalité ; ImageMagick et ffmpeg |
| 5 | 13/10 8h30-10h30 | CM | Matériel, réseau ; mots de passe, clés, secrets | matériel et ordres de grandeur, énergie, coûts ; réseau (client/serveur, débit, latence) ; mots de passe, deuxième facteur, `ssh-keygen`, secrets hors du dépôt |
| 6 | 20/10 8h30-10h30 | CM | Forge & git en équipe ; outil « trajectoire » | remote/push/pull, branch/merge ; distance & vitesse (boucle vs numpy, texte vs binaire) ; intro numpy |
| 7 | 03/11 8h30-10h30 | projet | Capstone : benchmark image + rapport (PR) | gris boucle vs numpy ; PR + conflit (branche pré-amorcée) + revue ; `RAPPORT.md` |


## Objectif du module

Rendre les étudiants à l'aise avec les **outils et concepts génériques** (environnement de développement, ligne de commande, versionnement) qui reviennent dans *tous* les cours mobilisant l'informatique et la programmation. Ce module est complémentaire du cours d'algo parallèle et a pour objectif de réduire la friction d'utilisation de ces outils et concepts dans les autres cours du programme où ils sont utilisés (en tant qu'outils, pas comme objectif d'apprentissage). S'y ajoute une **culture des ordres de grandeur** (mémoire, coût d'un calcul, réseau) qui éclaire *pourquoi* certains outils ou façons d'écrire sont plus rapides que d'autres.

- **Format des séances** : chaque séance alterne explications et **TD sur machine** illustrant immédiatement la notion vue (jamais un magistral pur).
- **Ancrage géomatique léger et sans prérequis** : les exemples peuvent se raccrocher à des notions géomatique (CSV de points = des coordonnées, distance = Pythagore) mais **n'exigent jamais une notion pas encore acquise**.
- **Découpage indicatif** : chaque séance ≈ 120 min ; parties notées 🎓 *exposé* / ⌨️ *TD* avec une durée indicative. Dans une séance, les TD sont numérotés `1a`, `1b`, `2a`… (chiffre = bloc joué au même moment, lettre = ordre dans le bloc) ; ceux qui sont trop longs pour la séance sont marqués *facultatifs*.
- **Archives** : une archive par séance (`info01-cours<n>.zip`), un dossier par TD, et dans chaque dossier `depart/` (fichiers fournis, jamais modifiés) et `travail/` (copies de l'étudiant).

---

## Cours 1 — Logiciel, programmation, formats de fichier, environnement (CM)

Objectif : comprendre ce qu'est un logiciel et un fichier, écrire et lancer un programme dans un éditeur de code, écrire de la documentation en Markdown, et installer un projet Python dans un environnement.

> **Inversion avec le cours 3.** L'environnement conda est remonté ici pour que les autres cours du programme disposent d'un Python fonctionnel dès le départ, et le bloc binaire / hexadécimal / PGM est descendu au cours 3. Analyse : [`inversion_c1_c3.md`](inversion_c1_c3.md).

> **Retour de séance (15/09).** Les parties 1 à 3 ont été jouées ; la partie 4 (bibliothèques et environnements, diapositives 90 à 122) n'a pas été traitée. La séance préparée compte 123 diapositives et dix TD, dont quatre facultatifs.

- **🎓 10′ · Ouverture du module** : objectif du cours, les trois compétences (éditer, versionner, structurer), les sept séances, les fichiers du cours (`depart/` et `travail/`).
- **Partie 1 · Logiciels et formats de fichier (25′)**
  - 🎓 logiciel (définition du _Journal officiel_, termes courants : application, app, webapp, OS, driver) ; le système d'exploitation entre le programme et le matériel ; entrées et sorties (fichier ou flux) ; où s'exécute une application web ; utilité d'un fichier ; chemins (quiz de vocabulaire, absolu et relatif, `\` et `/`) ; extension et type de fichier ; fichiers binaires et fichiers texte (octet, hexadécimal, ASCII, UTF-8) ; quiz « reconnaître un format à son extension ».
  - ⌨️ **TD 1a · 20′ · Fichiers, formats et extensions** : afficher les extensions sous Windows ; copier et renommer à la souris ou au clavier ; exporter `raven.odt` sous deux autres formats ; renommer une extension et voir ce qui s'ouvre ; ouvrir une page HTML depuis le disque (`file://`) ; un espace dans un nom de fichier (`%20`) ; la table ASCII ; Bloc-notes et Notepad++ sur les mêmes fichiers.
  - ⌨️ **TD 1b · 12′ · facultatif · Un `.odt` est une archive ZIP** : ouvrir l'archive, modifier `content.xml`, recompresser, rouvrir dans LibreOffice.
- **Partie 2 · Programmation et éditeur de code (35′)**
  - 🎓 programme et application ; compilé et interprété ; du code source aux instructions machine ; la place de l'interpréteur ; les fonctions d'un IDE ; l'édition de texte dans un IDE (syntaxe et coloration, chasse fixe, indentation en espaces ou tabulation).
  - ⌨️ **TD 1c · 25′ · Configurer VS Code et lancer un programme** : lancer VS Code depuis Anaconda Navigator ; installer l'extension Python ; palette de commandes et réglages ; choisir l'interpréteur ; hors Anaconda, remplacer le terminal PowerShell par un profil « Anaconda Prompt » ; lancer `altitudes.py` ; Python en interactif ; en option, la même chose dans l'invite de commandes d'Anaconda seul ; débogueur pas à pas.
  - ⌨️ **TD 1d · 10′ · Trois programmes fautifs** : afficher les caractères invisibles, corriger trois erreurs de nature différente.
  - ⌨️ **TD 1e · 10′ · facultatif · Le même programme en C++** : extension C/C++, compilateur par conda-forge (`gxx`, erreur `crt2.o` de la dernière version), compiler puis lancer.
- **Partie 3 · Markdown et notebook (30′)**
  - 🎓 les fichiers texte d'un projet ; le format de la documentation ; l'intention de Markdown (Gruber, 2004) et sa syntaxe ; programmation littérale ; le bloc de texte en Markdown ; un notebook dans JupyterLab, lancé depuis Navigator.
  - ⌨️ **TD 1f · 20′ · Une recette en Markdown** : aperçu dans VS Code, titre, tableau, liste numérotée, diagramme `mermaid`.
  - ⌨️ **TD 1g · 12′ · Le notebook, ouvert de trois façons** : le programme du TD 1c découpé en cellules, ouvert dans le navigateur (jupyter.org/try-jupyter), dans VS Code et dans JupyterLab ; ce que le noyau retient d'une cellule à l'autre.
- **Partie 4 · Bibliothèques et environnements Python (30′) — non traitée le 15/09**
  - 🎓 bibliothèques et `import` ; exemple : le programme « recette » en neuf lignes ; dépendances et numéros de version ; l'environnement contre les conflits de dépendances ; outils (pip, conda, conda-forge, mamba, pixi, uv) ; dépôts (PyPI, conda-forge) ; créer un environnement et le décrire (`environment.yml`) ; ce que change l'activation (`PATH`) ; `pyproject.toml` ; le terminal de l'éditeur ; client et serveur d'un notebook, les trois emplacements du serveur, les clients.
  - ⌨️ **TD 1h · 20′ · Installer un projet Python et décrire son installation** : projet `recette`, environnement d'essai, deux dépendances (publiée et locale), écrire `environment.yml` et la section d'installation du README, refaire l'environnement depuis le fichier.
  - ⌨️ **TD 1i · 20′ · facultatif · Le client, le noyau, et où ils sont** : tout dans le même environnement, ou client et noyau séparés.
  - ⌨️ **TD 1j · 15′ · facultatif · Installer un projet en lisant son README** : projet `trajet` (vidéo commentée du trajet gare-école, magick et ffmpeg).
- **Clôture** : « À retenir » (logiciel, application, interface, extension, format, dépendance, environnement, notebook).

*Détail & exercices : [`cours/1_formats_et_environnement/`](cours/1_formats_et_environnement/). Supports : [`src/cours1/`](../src/cours1/), données : [`data/cours1/`](../data/cours1/).*

## Cours 2 — Ligne de commande & git local (CM)

Objectif : se repérer dans un terminal, et versionner un projet en local avec git, branches comprises.

> Support de Florent Geniet (Beamer du 17/09/2026), porté en typst page pour page ; il déroge à la structure *assertion-evidence* (listes qui se dévoilent). 74 pages, dont 17 de TD.

> **Retour de séance (22/09).** Séance jugée un peu trop ambitieuse (à préciser : ce qui a été joué).

- **🎓 · Ligne de commande** (13 pages, sans TD) : le terminal et son invite (utilisateur, dossier courant) ; bash, `commande [-o] [--option] <arguments>`, `--help` ; commandes utiles (`ls`, `cd`, `cp`, `mv`, `rm`, `pwd`, `touch`, `mkdir`) ; arborescence, racine, chemin absolu et relatif, `..` ; fichiers cachés (`.git`, `.ssh`) ; le motif `*` (présenté comme « expressions régulières »).
- **🎓 · Git local** : à quoi sert git (états du projet, travail à plusieurs), quand l'utiliser ; `init`, commit, fichiers suivis et non suivis, zone de préparation ; annuler un commit (`revert`) ; `tag`.
- ⌨️ **TD 2a · 15′ · Un premier dépôt** : alias du graphe, `git init` de `projet_2`, `README.md`, premier commit.
- **🎓 · Branches** : branche, `HEAD`, fusion par `merge` et par `rebase`, conflits et leur résolution.
- ⌨️ **TD 2b · 30′ · Branches et fusions** : branches `develop`, `documentation`, `main_code`, `operations`, fusionnées dans `develop`.
- ⌨️ **TD 2c · 15′ · Annuler et remettre à jour** : `revert`, puis `rebase` de `main_code` sur `develop`.
- ⌨️ **TD 2d · 25′ · Créer et résoudre un conflit** : `main.py` modifié sur deux branches.
- **🎓 · Informations et bonnes pratiques** : `log --graph`, `diff`, `status` ; `.gitignore` ; messages de commit, ne pas committer de code non fonctionnel, organisation main / develop / feature.
- ⌨️ **TD 2e · 10′ · Publier une version** : fusionner `develop` dans `master`, taguer.
- **Bilan horaire** : 95′ de TD annoncés, plus l'exposé ; la séance ne tient pas en 2 h.

*Supports : [`src/cours2/`](../src/cours2/), données : [`data/cours2/`](../data/cours2/).*

## Cours 3 — Chemins, fichiers et ligne de commande, en Python (CM)

Objectif : manipuler des chemins et lire des fichiers en Python, construire un programme en ligne de commande, et revoir côté code les notions des cours 1 et 2 (chemins, encodage, texte et binaire, lancer un programme au terminal).

> Trois notebooks, dont les deux premiers se font pendant l'exposé, puis un TD de construction. 57 diapositives.

- **⌨️ 10′ · Préparation du poste** : copier l'archive depuis `formationTemp`, lancer JupyterLab (Navigator, ou `jupyter lab` dans l'invite de commandes d'Anaconda) ou VS Code ; Spyder en repli.
- **Chemins (20′)**, ⌨️ **TD 3b · `recette.ipynb`** suivi pendant l'exposé : le programme « recette » avec ses chemins en dur (lire le CSV, adapter les quantités, insérer le tableau) ; `pathlib.Path` et `/` ; la racine lue automatiquement ; lister un dossier pour traiter plusieurs recettes ; les parties d'un chemin ; `pandoc` dans le terminal, puis depuis le notebook ; où le terminal trouve `pandoc` (`PATH`, `shutil.which`) ; `subprocess.run([...])`.
- **Texte et binaire (45′)**
  - ⌨️ **TD 3c · 20′ · `fichiers.ipynb`** : `open`, `read`, `close` ; `with` ; les modes ; lire ligne par ligne ; lire un CSV ; `read_text`, `write_text`, `read_bytes`.
  - ⌨️ **TD 3d · 25′ · `images.ipynb`** : le format PGM ; P2 (texte) et P5 (binaire) ; lire octet par octet (`hexdump` en six lignes, `Format-Hex`, extension Hex Editor) ; la signature des formats ; le poids d'une image (P5, P2, BMP) ; la compression ; le temps de lecture ; ASCII et UTF-8 ; des noms de lieux hors ASCII.
- **Ligne de commande (45′)**
  - 🎓 du notebook au programme : le même code dans un fichier ; ce que l'interpréteur exécute ; une fonction `main` et `if __name__ == "__main__"` ; `argparse`.
  - ⌨️ **TD 3f · 45′ · Une ligne de commande pour la recette** : dépôt git dans `travail/`, terminal Git Bash avec `conda init bash` ; étape 1 le code dans `recette.py`, étape 2 une fonction `main`, étape 3 les arguments sur une branche, étape 4 un README ; facultatif, étape 5 `src/` et `data/`, étape 6 `pyproject.toml` et `pip install -e .` ; un commit par étape.
- **Clôture** : « À retenir » (chemin relatif, `Path(__file__)`, `encoding="utf-8"`, `subprocess.run`, `__main__`, binaire, signature, caractère, `argparse`).

*Supports : [`src/cours3/`](../src/cours3/), données : [`data/cours3/`](../data/cours3/).*

## Projet (séance 4) — Une animation, du notebook au programme

Objectif : écrire un projet Python qui fabrique une courte vidéo animée ; le rendu est un dossier versionné avec git, contenant un script appelable en ligne de commande.

*Découpage ≈ 120 min : 🎓 10′ présentation + ⌨️ 35′ partie A + ⌨️ 70′ partie B + 5′ mise en commun.*

- **Deux TD au choix, mêmes étapes** : ⌨️ **4a · La montre du Lapin blanc** (cadran dessiné, aiguilles calculées par `sin` et `cos`, une image par minute) ; ⌨️ **4b · La Vague en tourbillon** (_La Grande Vague_ tordue par `magick -swirl`, un angle par image, aller et retour).
- **🎓 10′ · Présentation** : les deux TD, les outils en ligne de commande (`magick`, `ffmpeg`), le programme étape par étape.
- **⌨️ 35′ · A · Exécuter le notebook** : dans VS Code avec un terminal Git Bash, rendre conda disponible, `conda env create -f environment.yml` (`magick` et `ffmpeg` ne sont pas dans `base`), `conda activate animation`, lancer JupyterLab depuis ce terminal, exécuter le notebook.
- **⌨️ 70′ · B · Du notebook au programme** : B0 le projet et le dépôt ; B1 une image, sur la branche `une-image` (fonction `main` et `argparse` dès le départ) ; B2 une série d'images, sur la branche `serie` ; B3 la vidéo, avec un commit fait sur `master` entre-temps, donc un commit de fusion ; B4 le README ; B5 facultatif, commande installée.
- **Livrable** : le dossier du projet avec son historique git (code, `environment.yml`, README), la vidéo, et le `git log` montré en fin de séance.
- **Guides** : un guide A4 par TD (`src/cours4/notebook/td/<td>/guide.md`), avec le code à coller et la vérification de chaque commande.

## Cours 5 — Matériel, réseau ; mots de passe, clés, secrets (CM)

Deux moitiés ; la seconde prépare directement la forge (cours 6). Déroulé diapositive par diapositive : [`cours/5_materiel_reseau_ssh/contenu_detaille.md`](cours/5_materiel_reseau_ssh/contenu_detaille.md). 55 diapositives.

**A. Matériel et réseau, ordres de grandeur (~1 h) — culture générale.**

- **🎓 30′ · Le matériel** : composants (schéma, photo d'un boîtier ouvert, photo d'une carte mère), processeur, température du processeur (question à la salle), mémoire vive et disque, le chemin d'une donnée, tailles, temps d'accès sur échelle log et « si la mémoire vive valait une seconde », processeur et carte graphique, trente ans de processeurs, puissance de calcul et consommation, électricité et coût des services en ligne.
- **🎓 15′ · Le réseau** : local et distant, client et serveur, adresse, nom et port (rappel de SNT), débit et latence, la distance, le lien le plus lent, le sans-fil, commit et push.
- **⌨️ 15′ · TD 5a** : les caractéristiques du poste dans le gestionnaire des tâches, puis `mesures.py` dans l'invite de commandes d'Anaconda : additions, copie en mémoire, écriture et relecture sur le disque, aller-retour et téléchargement.

**B. Prouver qui l'on est, et les secrets des programmes (~1 h).**

- **🎓 20′ · Prouver qui l'on est** : identifiant et mot de passe (le serveur garde une empreinte) ; les quatre façons de perdre un mot de passe (deviné, volé sur le serveur, volé chez vous, intercepté) ; combien de temps pour le deviner ; hameçonnage ; une parade par menace ; le deuxième facteur ; la clé à la place du mot de passe, la connexion SSH, les deux fichiers.
- **⌨️ 20′ · TD 5b** : dans l'invite de commandes d'Anaconda, `ssh-keygen`, la clé publique sur le compte GitHub, `ssh -T git@github.com`.
- **🎓 15′ · Les secrets de vos programmes** : ce qui est un secret, un secret dans un dépôt y reste (`git log -p`), séparer le code et les secrets (`.gitignore`, fichier modèle), si un secret a fui, mises à jour et sauvegardes.
- **⌨️ TD 5c, facultatif** : un secret dans l'historique, rejoué sur un dépôt neuf.
- **Clôture** : « Vers le cours 6 » (compte, clé SSH, deuxième facteur, secret ignoré ; le cours 6 commence par `git clone`).

## Cours 6 — Forge & git en équipe ; outil « trajectoire » (CM)

Objectif : maîtriser la forge (remote, push/pull) et branches/merge **en construisant** un petit outil qui calcule des stats sur une trajectoire (CSV/GPX) — les jalons de code *sont* les étapes git.

- **🎓 15′ · Forge** : compte, dépôt distant, `remote`, `clone`, `push`/`pull`.
- **🎓 15′ · Outil trajectoire** : distance totale et **vitesse moyenne** sur une suite de points ; deux comparaisons — boucle vs **numpy** (« Python interprété vs boucle **C** compilée ») et lecture **texte ligne par ligne** vs **binaire d'un bloc**.
- **⌨️ 10′ · numpy** introduit ici comme *ajout de dépendance* à l'env (`conda install numpy`, rappel c3).

**⌨️ ~55′ · Jalons de code = étapes git** (TD guidé) sur outils calcul stat gpx:

| Jalon | Code | Étape git |
|------|------|-----------|
| J1 | `load_txt` (lecture ligne par ligne) | `feat/load` → merge |
| J2 | `distance_totale` (boucle, Pythagore) | `feat/distance` → merge |
| J3 | `vitesse_moyenne` | `feat/speed` → merge — **conflit pré-amorcé** résolu ensemble |
| J4 | `distance_np` + `load_npy` (numpy / binaire) | `feat/numpy` → merge |
| J5 | mini-`benchmark()` | `feat/bench` → merge → `push` |

**But / seed** : chaque étudiant a poussé son outil sur la forge et fait ≥1 merge (dont un conflit résolu) ; sème le **TD7** (benchmark en plus gros).

## Projet (séance 7) — Recap tout : benchmark image + rapport (PR)

Objectif : appliquer numpy + le workflow **Pull Request** sur un benchmark **image** 2D, et produire un **rapport markdown**. Dépôt **individuel** (GitHub Classroom) → aucun merge séquentiel entre élèves.

*Découpage ≈ 120 min : 🎓 ~15′ cadrage + ⌨️ ~95′ implémentation & PR + ~10′ mise en commun.*

- **Noyau (plancher, tous)** : niveaux de gris = **moyenne des 3 canaux** — version **boucle** sur les pixels vs version **numpy** vectorisée ; chronométrer → speedup ×100-1000 (« Python pur vs call C » à l'échelle 2D).
- **Plafond** : flou = moyenne d'un voisinage (moving average 2D) ; accès **ligne vs colonne** (cache, c5) ; lecture PNG vs `.npy`.
- **Étapes git (features à implémenter)** :
  1. `git clone` de son dépôt (squelette : loader, chrono `timed()`, image de référence, `RAPPORT.md` gabarit) ;
  2. `git switch -c feat/grayscale` → coder `gris_boucle` puis `gris_numpy` (commits jalons) → `push` ;
  3. **ouvrir la PR** (titre + « ce que je mesure ») ;
  4. **conflit via branche pré-amorcée** : merger la branche `conflit-rapport` fournie (elle touche l'en-tête de `RAPPORT.md`) → résoudre les marqueurs `<<<<<<<` ;
  5. **revue round-robin** : commenter la PR d'un pair assigné (N relit N+1) — parallèle, sans dépendance ;
  6. **merger sa propre PR** ; l'autograder vérifie `gris_numpy` vs référence.
- **Livrable** : PR mergée + conflit résolu + `RAPPORT.md` (image avant/après, tableau de temps, 1 phrase d'interprétation par comparaison) + une revue laissée.
- **Robustesse** : squelette fourni ; plancher = 1 ligne (`img.mean(axis=2)`) réussissable par tous ; médiane de N essais, « on lit des *ratios*, pas des chiffres exacts » ; `Pillow` + `numpy` via conda-forge ; **une seule** PR (jalons = commits) pour tenir en 2 h.

---

## Détail par séance

Le déroulé fin et les exercices complémentaires de chaque séance vivent dans un sous-dossier dédié — `contenu_detaille.md` + `exercices_complementaires.md` :

| Séance | Dossier |
|--------|---------|
| 1 | [`cours/1_formats_et_environnement/`](cours/1_formats_et_environnement/) ✅ rempli (gabarit) — supports [`src/cours1/`](../src/cours1/), données [`data/cours1/`](../data/cours1/) |
| 2 | `cours/2_cli_git_local/` |
| 3 | `cours/3_python_env_cli/` |
| 4 | `cours/4_projet_animation/` |
| 5 | `cours/5_materiel_reseau_ssh/` |
| 6 | `cours/6_forge_trajectoire/` |
| 7 | `cours/7_projet_benchmark_image/` |

---

## Annexe — Artefact optionnel « fiche perso » (à trancher, non retenu comme projet)

Rôle pédagogique *spécifique* : la leçon **secrets / `.gitignore`** (données perso réelles → historique public **permanent**), difficile à enseigner ailleurs, + Markdown/pandoc. Tâches : `fiche.md` ; données dans `perso.yaml` **ignoré** (prouver via `git check-ignore`) ; photo recadrée (ImageMagick) ; PDF (pandoc). Hook motivant *seulement si publiée* (page `username.github.io`, séance forge). **Verdict** : livrable léger pour des primo-entrants en semaine 3 → à garder en artefact court/optionnel ou pour la seule leçon secrets, pas comme TD principal. *(La leçon secrets est désormais portée par le cours 5B — la fiche perso n'est donc plus nécessaire pour ça.)*
