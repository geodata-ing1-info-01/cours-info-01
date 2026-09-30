# Syllabus v1.5 — Introduction à l'informatique (séances 3 à 7 de 2026-2027)

> Rédigé le 24/09/2026. Les cours 1 et 2 ont été joués selon le [syllabus v1](01_syllabus_v1.md). Ce fichier applique aux séances restantes de 2026-2027 ce que le [syllabus v2](02_syllabus_v2.md) permet de reprendre dès cette année. Le v2 reste la proposition pour 2027-2028.

## Tableau des séances

| # | date | type | Séance (2 h) | Statut |
|---|------|------|--------------|--------|
| 1 | 15/09 | CM | Logiciel, programmation, formats de fichier, environnement | joué (v1) ; partie 4 (environnements) non traitée |
| 2 | 22/09 | CM | Ligne de commande et git local | joué (v1) |
| 3 | 29/09 | CM | Chemins, fichiers et ligne de commande, en Python | **allégé** ; TD d'environnement selon les groupes ; dernière partie en deux parcours (TD 3a ou 3b) |
| 4 | 6/10 | projet | Projet d'application 1 : un script Python construit pas à pas, en deux parcours | **refait le 30/09** : révision des cours 1 à 3 sur un petit programme ; le parcours avancé en fait un projet installable ; le train passe au projet 7 |
| 5 | 13/10 | CM | Matériel, réseau ; mots de passe, clés, secrets | **deux diapositives ajoutées** : client et serveur sur le même poste |
| 6 | 20/10 | CM | La forge, sur le dépôt du projet 4 | **refait** : l'outil « trajectoire » est retiré |
| 7 | 03/11 | projet | Projet d'application 2 : un projet complété et livré par des pull requests | **refait le 30/09** : TD 7a, la recette en pages (pandoc, toutes les recettes, sommaire) ; TD 7b, le train récupéré d'un dépôt de référence, fenêtre et poteaux (numpy) sur deux branches, un conflit |

## Ce qui est repris du v2

| Élément du v2 | Repris en 2026 | Où |
|---|---|---|
| Créer un environnement et y installer un paquet demandé | oui, selon les groupes | cours 3, TD 0a |
| `fichiers.ipynb` : § 10 et 11 à lire après la séance | oui | cours 3 |
| `images.ipynb` : § 3 à 6 à lire après la séance ; § 5 et 6 repris au projet 7 | plus que prévu : tout le notebook devient facultatif (25/09) | cours 3, projet 7 (facultatif) |
| TD 3b : étapes 5 et 6 hors séance | oui, dans le guide seulement | cours 3 |
| Le serveur de notebook comme exemple de client et serveur | oui | cours 5 |
| La forge sur le dépôt du projet 4, sans l'outil « trajectoire » | oui | cours 6 |
| Des fonctionnalités livrées par pull request, dont une calculée avec numpy (TD 7a recette, TD 7b train) | oui, révisé le 27/09 | projet 7 |
| Partie A du projet 4 ramenée à 20′ | non : les groupes qui n'ont pas fait le TD 0a découvrent les environnements au projet 4 | — |
| Git Bash comme seul terminal (cours 5 compris) | non : les TD du cours 5 restent dans l'invite de commandes d'Anaconda | à décider avant le 13/10 |
| Terminal et commandes au cours 1 ; VS Code et Markdown au cours 2 ; `rebase` et `tag` en annexe | sans objet : cours 1 et 2 joués | — |
| Début de séance identique, fait sans guide ; aide-mémoire d'une page | non | à décider |

---

## Cours 3 — Chemins, fichiers et ligne de commande, en Python (29/09)

Objectif inchangé. La séance est allégée pour laisser la place, selon les groupes, à un TD d'environnement : la partie 4 du cours 1 (bibliothèques et environnements) n'a pas été jouée.

- **⌨️ 10′ · Préparation du poste** : copier l'archive, lancer JupyterLab. Inchangé.
- **⌨️ 10′ + 20′ · TD 0a · Préparation du poste de travail** *(révisé le 25/09/2026 : les diapositives de récupération de l'archive et de test des outils, jusque-là dans l'ouverture, y passent ; seule la dernière diapositive, l'environnement, dépend des groupes)* : récupérer l'archive, vérifier que les outils se lancent ; puis, selon les groupes, dans l'invite de commandes d'Anaconda, une seule commande crée l'environnement avec ses paquets, `conda create -n info01-cours3 -c conda-forge python=3.12 jupyterlab jupyterlab-myst pandoc pillow` ; `conda activate info01-cours3`, `conda env list` ; vérifier `pandoc --version` et `import PIL` ; `jupyter lab` depuis le dossier `cours3/`. Une seule diapositive, les étapes ; l'annonce définit un environnement (révisé le 25/09/2026 : nom préfixé par le module, plus de diapositive de rappel des commandes, plus d'installation en deux temps).
*Révisé le 25/09/2026, puis mis à jour ici le 28/09/2026 d'après les supports (`src/cours3/`) : les parties 1 et 2 sont de l'exposé suivi du notebook en autonomie, sans diapositive de TD ; la dernière partie se fait en deux parcours.*

- **Chemins et programmes externes (20′)** : `recette.ipynb` (TD 1a), en autonomie après quelques diapositives : `pathlib`, pandoc lancé par `subprocess`. La partie présente aussi le passage en script, `main`, `if __name__ == "__main__":` et `argparse`, qui servent au TD 3a.
- **Fichiers et encodage (30′)** : `fichiers.ipynb` (TD 2a), § 1 à 9 en séance (`open`, le texte comme suite de caractères, les octets, ASCII et UTF-8, la fin de ligne, le mode binaire, `with`, ligne par ligne, les modes) ; § 10 (CSV) et 11 (`read_text`, `write_text`) après la séance ; § 12 (un `.npy` lu à la main) facultatif. Diapositives en trois fichiers : `02a_lecture`, `02b_encodage` (dont bit, octet, hexadécimal, repris du cours 1 de 2026), `02c_fichiers`.
  - `images.ipynb` (TD 2b) devient **facultatif**, pour le parcours avancé s'il reste du temps.
- **Dernière partie, au choix (45′)**
  - ⌨️ **parcours avancé, TD 3b** : `recette.py` lancé depuis le terminal, `main`, `argparse`, un README, un commit par étape ; étapes 0 à 4 en séance, 5 et 6 dans le guide, « après la séance ».
  - ⌨️ **parcours standard, TD 3a** : un dépôt git de recettes, créé à partir des recettes du TD 1a, auquel on ajoute la recette des gaufres, écrite en Markdown, et sa page produite par un notebook qui reprend le programme du TD 1a. Il reprend le TD Markdown du cours 1, que beaucoup n'avaient pas fini.
  - Conseil donné à l'ouverture : le parcours avancé si `fichiers.ipynb` est fait jusqu'au § 9 à la fin de la partie 2.
- **Clôture** : « À retenir » reçoit une ligne sur l'environnement conda.

**Budget** : 10 + 20 + 30 + 45 = **105′** sans le TD 0a. Avec le TD 0a : **120′**, le lancement de JupyterLab passant de la préparation au TD 0a (+15′ net, comme l'annonce le tableau de l'ouverture). Si la séance déborde, l'étape 4 du TD 3a (README) se fait après.

**Supports modifiés** (le 24/09) :

| Fichier | Modification |
|---|---|
| [`src/cours3/diapo/tds/0a_preparation.typ`](../src/cours3/diapo/tds/0a_preparation.typ) | trois diapositives : archive, outils, environnement (selon les groupes) |
| [`src/cours3/diapo/cours3.typ`](../src/cours3/diapo/cours3.typ) | inclut le TD 0a après l'ouverture |
| [`src/cours3/diapo/parties/00_ouverture.typ`](../src/cours3/diapo/parties/00_ouverture.typ) | tableau « Contenu de la séance » : ligne du TD 0a, durées ; note de conduite pour les groupes qui font le TD 0a |
| `src/cours3/diapo/parties/02a_fichiers.typ`, `02b_images.typ` | fichiers remplacés le 25/09 par [`02a_lecture.typ`](../src/cours3/diapo/parties/02a_lecture.typ), [`02b_encodage.typ`](../src/cours3/diapo/parties/02b_encodage.typ) et [`02c_fichiers.typ`](../src/cours3/diapo/parties/02c_fichiers.typ) ; `images.ipynb` n'a plus de diapositive |
| [`src/cours3/diapo/tds/2a_fichiers.typ`](../src/cours3/diapo/tds/2a_fichiers.typ), [`2b_images.typ`](../src/cours3/diapo/tds/2b_images.typ) | durées 20′ et 25′ ramenées à 15′ |
| [`src/cours3/diapo/tds/3b_cli.typ`](../src/cours3/diapo/tds/3b_cli.typ) | diapositives des étapes 5 et 6 retirées ; le tableau des étapes et la légende renvoient au guide |
| [`src/cours3/notebook/td/3b_cli/guide.md`](../src/cours3/notebook/td/3b_cli/guide.md) | étapes 5 et 6 marquées « après la séance » |
| [`fichiers.md`](../src/cours3/notebook/td/2a_fichiers/depart/notebook/fichiers.md), [`images.md`](../src/cours3/notebook/td/2b_images/images.md) | une phrase en tête des sections à lire après la séance |
| [`src/cours3/diapo/parties/99_cloture.typ`](../src/cours3/diapo/parties/99_cloture.typ) | ligne « Un environnement conda » |

Les diapositives retirées restent dans l'historique git.

## Projet 4 — Projet d'application 1, en deux parcours (6/10)

*Refait le 30/09/2026 après la séance 3 : le TD de la fenêtre du train, jugé trop ambitieux, passe au projet 7 ; la séance revoit à un rythme lent les opérations des cours 1 à 3. S'éloigner du syllabus v2 est voulu. Conception : [`cours/4_projet_recette/contenu_detaille.md`](cours/4_projet_recette/contenu_detaille.md).*

- **🎓 5′ · Tous** : présentation de la séance.
- **⌨️ TD 4a · Tous, 30′ + 75′** : partie A, le dossier du projet créé dans le terminal (`mkdir`, `cp`), ouvert dans VS Code avec Git Bash pour terminal, versionné (`git init`, `.gitignore`) ; partie B, le programme `recette.py`, un commit par étape : corriger deux erreurs (`SyntaxError`, `TabError`), `adapter`, `convertir` (SI et US, un dictionnaire), lire un CSV, écrire un CSV, `argparse` ; en bonus, un README et `git tag v1.0`. Sans Markdown ni pandoc.
- **Parcours avancé** : TD 4a plus vite (50′), 🎓 10′ d'exposé (module et `import`, environnement conda, `environment.yml` et pip, `pyproject.toml`), puis ⌨️ **TD 4b, 55′** : `main`, deux modules, `conda env create -f environment.yml`, `src/` et `pip install -e .`, la commande `recette` ; en bonus, `--page` par pandoc.

Les TD 4a noyaux et 4b ligne de commande (reprise du TD 3b du cours 3) sont retirés, et restent dans l'historique git. Le dépôt du projet 4 sert au cours 6 et au projet 7 : le dire en fin de séance, et demander de le garder (voir « À vérifier », point 3).

## Cours 5 — Matériel, réseau ; mots de passe, clés, secrets (13/10)

Inchangé, sauf deux diapositives ajoutées après « Client et serveur », dans [`src/cours5/diapo/parties/02_reseau.typ`](../src/cours5/diapo/parties/02_reseau.typ). Elles reprennent les schémas de la partie 4 du cours 1, non jouée ([`src/cours1/diapo/schemas_notebooks.typ`](../src/cours1/diapo/schemas_notebooks.typ)).

- **Client et serveur sur le même poste** : le schéma client (JupyterLab dans le navigateur, VS Code) et serveur (`jupyter-server`, `ipykernel`) sur la même machine, reliés par `localhost`. Démonstration de deux minutes, en note : `jupyter lab` dans un terminal, une ligne par requête dans le terminal, le terminal fermé puis une cellule exécutée.
- **Trois emplacements pour le serveur** : sur un ordinateur distant (Colab), sur le poste (`jupyter lab`), dans le navigateur (JupyterLite). *Passée au parcours standard du projet 4 (TD 4a) ; le parcours avancé ne la voit pas.*

La note de « Client et serveur » qui renvoyait au cours 1 est retirée.

## Cours 6 — La forge, sur le dépôt du projet 4 (20/10)

Repris du v2. L'outil « trajectoire » est retiré ; le cours 6 ne demande pas d'écrire de code nouveau. Les branches, le `rebase` et les conflits ont été vus au cours 2 de 2026 ; la séance ne les reprend pas en exposé.

- **🎓 15′ · La forge** : compte, dépôt distant, `remote`, `clone`, `push`, `pull` ; branche de fonctionnalité et pull request.
- **⌨️ 20′ · Publier son dépôt** : créer un dépôt vide sur GitHub ; `git remote add origin`, `git push -u origin master` avec la clé SSH du cours 5 ; voir l'historique sur le site.
- **⌨️ 20′ · Deux copies du même dépôt** : `git clone` dans un autre dossier ; un commit dans ce clone, `push` ; `pull` dans le premier dossier.
- **⌨️ 20′ · Un conflit** : modifier une ligne du README sur le site, la même ligne en local ; `pull`, résoudre le conflit, `push`.
- **⌨️ 20′ · Une pull request** : une branche qui améliore le README, poussée ; ouvrir la pull request sur le site, la fusionner ; `pull` dans le dossier local.
- **Élèves sans projet 4 terminé** : un dépôt de référence par parcours (`recette.py`, `train.py`), à copier et publier à la place du leur. *Écrit pour les TD montre et tourbillon ; à refaire pour les deux parcours actuels.*

**Budget** : **95′**, avec 25′ de marge pour les problèmes de clé SSH et d'authentification. Supports à écrire (`src/cours6/`).

## Projet 7 — Projet d'application 2, par des pull requests (03/11)

*Refait le 30/09/2026 avec le projet 4 ([`cours/7_projet_effets/refonte_30-09.md`](cours/7_projet_effets/refonte_30-09.md)). Chaque TD part d'un dépôt git récupéré sur GitHub, le complète sur des branches, et livre chaque branche par une pull request fusionnée sur le site. Pas de numpy au parcours standard.*

- **🎓 10′ · Tous** : présentation ; une fonctionnalité, une pull request.
- **⌨️ TD 7a, standard, 85′** : le dépôt `recette` du projet 4 (ou le dépôt de référence) ; `--page`, la page HTML d'une recette par pandoc (reprise du TD 3b du cours 3) ; pull request ; `--toutes` ; le sommaire ; seconde pull request ; en bonus, GitHub Pages.
- **Parcours avancé** : 🎓 10′, une image comme tableau numpy, un masque de colonnes ; ⌨️ **TD 7b, 100′** : le dépôt de référence `train` (deux plans, sans fenêtre), cloné, lancé, lu ; deux branches du même commit, `fenetre` et `poteaux` (calque numpy) ; la seconde pull request s'arrête sur un conflit, résolu sur le poste ; en bonus, un troisième plan par `decor/plans.csv`.

Les TD 7a (livre de recettes, photo, `--frigo`) et 7b (scène complète, boucle et numpy chronométrés) du 27/09 sont dans l'historique git. Dépôts de référence : `recette` (TD 4a, étape B7, étiquette `v1.0` ; sert aussi au cours 6) et `train`, écrits par `data/cours7/generer_projet7.py --depots`.

## À vérifier avant les séances

1. **Avant le 29/09** : durée de `conda create -n info01-cours3 -c conda-forge python=3.12 jupyterlab jupyterlab-myst pandoc pillow` sur un poste de la salle ; si elle dépasse cinq minutes, lancer la création dès le début de la séance (note de conduite du TD 0a).
2. **Avant le 29/09** : dans un environnement activé autre que `base`, `pandoc --version` échoue-t-il bien sur les postes (pandoc de `base` hors du `PATH`) ?
3. **Avant le 6/10** : les dossiers `travail/` et les environnements conda sont-ils conservés d'une séance à l'autre sur les postes ? Sinon, le dépôt du projet 4 doit être emporté (clé USB, espace réseau) pour le cours 6.
4. **Avant le 20/10** : le pare-feu de l'école laisse-t-il passer SSH vers GitHub (port 22) ? Sinon, `ssh.github.com` sur le port 443.
5. **Avant le 03/11** : les temps des quatre effets sur un poste de la salle, sur toute la série d'images de chaque TD du projet 4.
