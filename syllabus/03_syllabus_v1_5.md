# Syllabus v1.5 — Introduction à l'informatique (séances 3 à 7 de 2026-2027)

> Rédigé le 24/09/2026. Les cours 1 et 2 ont été joués selon le [syllabus v1](01_syllabus_v1.md). Ce fichier applique aux séances restantes de 2026-2027 ce que le [syllabus v2](02_syllabus_v2.md) permet de reprendre dès cette année. Le v2 reste la proposition pour 2027-2028.

## Tableau des séances

| # | date | type | Séance (2 h) | Statut |
|---|------|------|--------------|--------|
| 1 | 15/09 | CM | Logiciel, programmation, formats de fichier, environnement | joué (v1) ; partie 4 (environnements) non traitée |
| 2 | 22/09 | CM | Ligne de commande et git local | joué (v1) |
| 3 | 29/09 | CM | Chemins, fichiers et ligne de commande, en Python | **allégé** ; TD d'environnement selon les groupes |
| 4 | 6/10 | projet | Une animation, du notebook au programme | inchangé |
| 5 | 13/10 | CM | Matériel, réseau ; mots de passe, clés, secrets | **deux diapositives ajoutées** : client et serveur sur le même poste |
| 6 | 20/10 | CM | La forge, sur le dépôt du projet 4 | **refait** : l'outil « trajectoire » est retiré |
| 7 | 03/11 | projet | Un effet pour l'animation | **refait** : remplace le benchmark de conversion en gris |

## Ce qui est repris du v2

| Élément du v2 | Repris en 2026 | Où |
|---|---|---|
| Créer un environnement et y installer un paquet demandé | oui, selon les groupes | cours 3, TD 0a |
| `fichiers.ipynb` : § 5 et 6 à lire après la séance | oui | cours 3 |
| `images.ipynb` : § 3 à 6 à lire après la séance ; § 5 et 6 repris au projet 7 | oui | cours 3, projet 7 (facultatif) |
| TD 3a : étapes 5 et 6 hors séance | oui, dans le guide seulement | cours 3 |
| Le serveur de notebook comme exemple de client et serveur | oui | cours 5 |
| La forge sur le dépôt du projet 4, sans l'outil « trajectoire » | oui | cours 6 |
| Un effet au choix, en boucle puis avec numpy, livré par une pull request | oui | projet 7 |
| Partie A du projet 4 ramenée à 20′ | non : les groupes qui n'ont pas fait le TD 0a découvrent les environnements au projet 4 | — |
| Git Bash comme seul terminal (cours 5 compris) | non : les TD du cours 5 restent dans l'Anaconda Prompt | à décider avant le 13/10 |
| Terminal et commandes au cours 1 ; VS Code et Markdown au cours 2 ; `rebase` et `tag` en annexe | sans objet : cours 1 et 2 joués | — |
| Début de séance identique, fait sans guide ; aide-mémoire d'une page | non | à décider |

---

## Cours 3 — Chemins, fichiers et ligne de commande, en Python (29/09)

Objectif inchangé. La séance est allégée pour laisser la place, selon les groupes, à un TD d'environnement : la partie 4 du cours 1 (bibliothèques et environnements) n'a pas été jouée.

- **⌨️ 10′ · Préparation du poste** : copier l'archive, lancer JupyterLab. Inchangé.
- **⌨️ 10′ + 20′ · TD 0a · Préparation du poste de travail** *(révisé le 25/09/2026 : les diapositives de récupération de l'archive et de test des outils, jusque-là dans l'ouverture, y passent ; seule la dernière diapositive, l'environnement, dépend des groupes)* : récupérer l'archive, vérifier que les outils se lancent ; puis, selon les groupes, dans l'Anaconda Prompt, une seule commande crée l'environnement avec ses paquets, `conda create -n info01-cours3 -c conda-forge python=3.12 jupyterlab pandoc pillow` ; `conda activate info01-cours3`, `conda env list` ; vérifier `pandoc --version` et `import PIL` ; `jupyter lab` depuis le dossier `cours3/`. Une seule diapositive, les étapes ; l'annonce définit un environnement (révisé le 25/09/2026 : nom préfixé par le module, plus de diapositive de rappel des commandes, plus d'installation en deux temps).
- **Chemins (20′)** : `recette.ipynb`, inchangé.
- **Texte et binaire (30′)**
  - ⌨️ **TD 2a · 15′ · `fichiers.ipynb`**, § 0 à 4 (`open`, `with`, modes, `encoding`, ligne par ligne). Les § 5 (CSV) et 6 (`read_text`, `write_text`, `read_bytes`) se lisent après la séance ; une diapositive en donne le contenu et montre les deux lignes `read_text` et `read_bytes`, qu'`images.ipynb` emploie.
  - ⌨️ **TD 2b · 15′ · `images.ipynb`**, § 1 (PGM `P2`), § 2 (le même en `P5`, octets et en-tête) et § 7 (ASCII et UTF-8, noms de lieux). Les § 3 à 6 (`hexdump`, signatures, poids, compression, temps de lecture) se lisent après la séance ; une diapositive en donne le contenu.
- **Ligne de commande (45′)** : TD 3a, étapes 0 à 4. Les étapes 5 (`src/` et `data/`) et 6 (`pyproject.toml`, `pip install -e .`) ne sont plus projetées ; elles restent dans le guide, marquées « après la séance ».
- **Clôture** : « À retenir » reçoit une ligne sur l'environnement conda.

**Budget** : 10 + 20 + 30 + 45 = **105′** sans le TD 0a. Avec le TD 0a : **120′**, le lancement de JupyterLab passant de la préparation au TD 0a (+15′ net, comme l'annonce le tableau de l'ouverture). Si la séance déborde, l'étape 4 du TD 3a (README) se fait après.

**Supports modifiés** (le 24/09) :

| Fichier | Modification |
|---|---|
| [`src/cours3/diapo/tds/0a_preparation.typ`](../src/cours3/diapo/tds/0a_preparation.typ) | trois diapositives : archive, outils, environnement (selon les groupes) |
| [`src/cours3/diapo/cours3.typ`](../src/cours3/diapo/cours3.typ) | inclut le TD 0a après l'ouverture |
| [`src/cours3/diapo/parties/00_ouverture.typ`](../src/cours3/diapo/parties/00_ouverture.typ) | tableau « Contenu de la séance » : ligne du TD 0a, durées ; note de conduite pour les groupes qui font le TD 0a |
| [`src/cours3/diapo/parties/02a_fichiers.typ`](../src/cours3/diapo/parties/02a_fichiers.typ) | « Lire un fichier CSV » et « Les raccourcis de pathlib » remplacées par « À lire après la séance : § 5 et 6 » |
| [`src/cours3/diapo/parties/02b_images.typ`](../src/cours3/diapo/parties/02b_images.typ) | cinq diapositives (§ 3 à 6) remplacées par « À lire après la séance : § 3 à 6 » |
| [`src/cours3/diapo/tds/2a_fichiers.typ`](../src/cours3/diapo/tds/2a_fichiers.typ), [`2b_images.typ`](../src/cours3/diapo/tds/2b_images.typ) | durées 20′ et 25′ ramenées à 15′ |
| [`src/cours3/diapo/tds/3a_cli.typ`](../src/cours3/diapo/tds/3a_cli.typ) | diapositives des étapes 5 et 6 retirées ; le tableau des étapes et la légende renvoient au guide |
| [`src/cours3/notebook/td/3a_cli/guide.md`](../src/cours3/notebook/td/3a_cli/guide.md) | étapes 5 et 6 marquées « après la séance » |
| [`fichiers.md`](../src/cours3/notebook/td/2a_fichiers/depart/notebook/fichiers.md), [`images.md`](../src/cours3/notebook/td/2b_images/images.md) | une phrase en tête des sections à lire après la séance |
| [`src/cours3/diapo/parties/99_cloture.typ`](../src/cours3/diapo/parties/99_cloture.typ) | ligne « Un environnement conda » |

Les diapositives retirées restent dans l'historique git.

## Projet 4 — Une animation, du notebook au programme (6/10)

Inchangé. Les groupes qui ont fait le TD 0a au cours 3 connaissent `conda create` et `conda activate` : la partie A (`conda env create -f environment.yml`) va plus vite pour eux, le temps gagné va à la partie B.

Le dépôt git du projet 4 sert au cours 6 et au projet 7 : le dire en fin de séance, et demander de le garder (voir « À vérifier », point 3).

## Cours 5 — Matériel, réseau ; mots de passe, clés, secrets (13/10)

Inchangé, sauf deux diapositives ajoutées après « Client et serveur », dans [`src/cours5/diapo/parties/02_reseau.typ`](../src/cours5/diapo/parties/02_reseau.typ). Elles reprennent les schémas de la partie 4 du cours 1, non jouée ([`src/cours1/diapo/schemas_notebooks.typ`](../src/cours1/diapo/schemas_notebooks.typ)).

- **Client et serveur sur le même poste** : le schéma client (JupyterLab dans le navigateur, VS Code) et serveur (`jupyter-server`, `ipykernel`) sur la même machine, reliés par `localhost`. Démonstration de deux minutes, en note : `jupyter lab` dans un terminal, une ligne par requête dans le terminal, le terminal fermé puis une cellule exécutée.
- **Trois emplacements pour le serveur** : sur un ordinateur distant (Colab), sur le poste (`jupyter lab`), dans le navigateur (JupyterLite).

La note de « Client et serveur » qui renvoyait au cours 1 est retirée.

## Cours 6 — La forge, sur le dépôt du projet 4 (20/10)

Repris du v2. L'outil « trajectoire » est retiré ; le cours 6 ne demande pas d'écrire de code nouveau. Les branches, le `rebase` et les conflits ont été vus au cours 2 de 2026 ; la séance ne les reprend pas en exposé.

- **🎓 15′ · La forge** : compte, dépôt distant, `remote`, `clone`, `push`, `pull` ; branche de fonctionnalité et pull request.
- **⌨️ 20′ · Publier son dépôt** : créer un dépôt vide sur GitHub ; `git remote add origin`, `git push -u origin master` avec la clé SSH du cours 5 ; voir l'historique sur le site.
- **⌨️ 20′ · Deux copies du même dépôt** : `git clone` dans un autre dossier ; un commit dans ce clone, `push` ; `pull` dans le premier dossier.
- **⌨️ 20′ · Un conflit** : modifier une ligne du README sur le site, la même ligne en local ; `pull`, résoudre le conflit, `push`.
- **⌨️ 20′ · Une pull request** : une branche qui améliore le README, poussée ; ouvrir la pull request sur le site, la fusionner ; `pull` dans le dossier local.
- **Élèves sans projet 4 terminé** : un dépôt de référence par TD (montre, tourbillon), construit depuis `data/cours4/corriges/`, à copier et publier à la place du leur.

**Budget** : **95′**, avec 25′ de marge pour les problèmes de clé SSH et d'authentification. Supports à écrire (`src/cours6/`).

## Projet 7 — Un effet pour l'animation (03/11)

Repris du v2. Chaque élève ajoute au programme du projet 4 une option `--effet`, qui applique un effet à chaque image avant la vidéo : caméra thermique, glitch, pixel art ou vieux film. Il écrit l'effet en boucle sur les pixels, puis avec numpy, vérifie que les deux versions donnent le même résultat, les chronomètre, et livre le tout par une pull request relue par un camarade.

Document de conception : [`cours/7_projet_effets/contenu_detaille.md`](cours/7_projet_effets/contenu_detaille.md), avec une implémentation de référence des quatre effets et les temps mesurés ([`effets_reference.py`](cours/7_projet_effets/effets_reference.py)).

## À vérifier avant les séances

1. **Avant le 29/09** : durée de `conda create -n info01-cours3 -c conda-forge python=3.12 jupyterlab pandoc pillow` sur un poste de la salle ; si elle dépasse cinq minutes, lancer la création dès le début de la séance (note de conduite du TD 0a).
2. **Avant le 29/09** : dans un environnement activé autre que `base`, `pandoc --version` échoue-t-il bien sur les postes (pandoc de `base` hors du `PATH`) ?
3. **Avant le 6/10** : les dossiers `travail/` et les environnements conda sont-ils conservés d'une séance à l'autre sur les postes ? Sinon, le dépôt du projet 4 doit être emporté (clé USB, espace réseau) pour le cours 6.
4. **Avant le 20/10** : le pare-feu de l'école laisse-t-il passer SSH vers GitHub (port 22) ? Sinon, `ssh.github.com` sur le port 443.
5. **Avant le 03/11** : les temps des quatre effets sur un poste de la salle, sur toute la série d'images de chaque TD du projet 4.
