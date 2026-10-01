# Cours d'introduction à l'informatique (bac+2, 14 h)

École d'ingénieurs (géomatique), 1re année, profils variés (prépa littéraire ou scientifique).
Module d'**infrastructure de travail** (outils + concepts génériques) complémentaire du cours d'algo/programmation parallèle.

Le book est en ligne : **<https://geodata-ing1-info-01.github.io/cours-info-01/>**,
pour les étudiants. Le même site est servi par GitLab Pages, pour les intervenants
qui travaillent sur gitlab.ign.fr : <https://ecue-info-01-de820c.gitlab-pages.ign.fr/>.

## Structure du dépôt

| Dossier | Rôle |
|---------|------|
| [`syllabus/`](syllabus/) | **Documents de référence** : [`01_syllabus_v1.md`](syllabus/01_syllabus_v1.md) (vue d'ensemble des 7 séances) et `cours/<n>_.../` (déroulé fin + exercices). |
| [`src/`](src/) | **Supports de séance** : `cours<n>/notebook/` (pages MyST exécutables), `cours<n>/diapo/` (sources typst : `parties/` pour l'exposé, `tds/` pour les TD), [`avant/`](src/avant/) (vérifications des postes avant les séances), [`annexes/`](src/annexes/) (`configuration/` : postes de la salle, Anaconda, JupyterLab, VS Code ; `poste_personnel.md` ; `notions/` ; `faq.md` et `problemes/`, une page par outil ; `plus_loin/`, hors module) et [`conf.py`](src/conf.py) (config du book). |
| [`data/`](data/) | **Fichiers des TD**, un dossier par séance puis par TD, numéroté dans l'ordre de la séance (`1a_formats/`, `1e_hello_cpp/`…). Deux noms réservés à l'intérieur : `produit/` est refabricable par une commande, `fourni/` vient d'ailleurs et ne l'est pas. Ni l'un ni l'autre n'est versionné ; `fourni/` voyage avec [`outils/ressources.py`](outils/ressources.py). Les étudiants reçoivent une **archive par séance**, assemblée par [`outils/livrer_tds.py`](outils/livrer_tds.py), qui ne montre ni l'un ni l'autre. |
| [`illustrations/`](illustrations/) | **Captures d'écran des supports**, hors dépôt. Elles servent aux diapositives, pas aux travaux dirigés. |
| [`src/commun/typst-101.md`](src/commun/typst-101.md) | **Lire le typst du dépôt** : les deux premières diapositives commentées ligne à ligne. |
| [`STYLE.md`](STYLE.md) | **Conventions d'écriture** des supports (diapositives, pages de cours, notes). À lire avant d'en rédiger. |
| [`environment-supports.yml`](environment-supports.yml) | Environnement de **fabrication** `info01` : typst et la chaîne du book, pour qui recompile les supports. |

*(Cours 1 rempli de bout en bout — syllabus, notebook, diapos, données ; cours 2–7 en gabarits.)*

## Démarrage

Pour **suivre** le cours et jouer les TD :

```bash
conda env create -f environment-supports.yml && conda activate info01
cd data/cours1 && python make_data.py fetch && python make_data.py build && cd ../..
python outils/livrer_tds.py     # l'archive des TD telle que les étudiants la reçoivent
```

Les étudiants, eux, n'installent qu'Anaconda : chaque TD qui a besoin d'autre
chose crée son propre environnement, et c'est ce que le TD 1h fait apprendre.

Les étudiants, eux, ne reçoivent que `livraison/info01-cours<n>.zip` : un
dossier par TD, la feuille du TD en PDF dans chacun. Les diapositives nomment
les chemins tels que cette archive les montre.

Pour **recompiler** les supports, il faut en plus la chaîne documentaire :

```bash
conda env create -f environment-supports.yml && conda activate info01
python outils/compiler_diapos.py                               # diapositives → PDF
sphinx-build -E -b html src _build/html                        # book → _build/html/index.html
python outils/publier_book.py livraison/*.zip                  # book + archives → https://geodata-ing1-info-01.github.io/cours-info-01/
```

La dernière ligne reconstruit le book, dépose les fichiers donnés dans
`telechargements/` (avec une page qui les liste, liée depuis l'accueil du book)
et publie `_build/html/` sur la branche `gh-pages`, que GitHub Pages sert ; la
branche est refaite à chaque publication et n'a pas de lien avec `main`.
Elle part aussi vers le remote GitLab, où son `.gitlab-ci.yml` lance le job
`pages` qui sert le site, sans le reconstruire.
`ghp-import` s'installe par `pip install ghp-import`.

Détail, vérifications et pannes connues : **[`INSTALLATION.md`](INSTALLATION.md)**.

## Décisions de conception (le « pourquoi »)

- **Ancrage géomatique léger, sans prérequis** : les exemples peuvent parler au métier (points, coordonnées, distance = Pythagore) mais n'exigent **jamais** une notion pas encore vue (pas d'API *live*, pas de Dijkstra).
- **Environnement = conda/conda-forge** : sert à *installer les outils* (ffmpeg, imagemagick, pandoc, typst, numpy, Pillow) de façon reproductible et cross-platform — pas à packager. Commandes fournies + testées.
- **Installé dès la séance 1** (v2) : les autres cours du programme mobilisent Python avant la semaine 3. En échange, le bloc *binaire / hexadécimal / PGM* descend au cours 3, où il précède directement `numpy` et le TD image. Analyse : [`syllabus/inversion_c1_c3.md`](syllabus/inversion_c1_c3.md).
- **Pas de navigation shell** (`ls`/`cd`/`rm`) : trop dépendante de l'OS (Windows) ; la manipulation de fichiers se fait en Python (`pathlib`).
- **TD numérotés, certains facultatifs** : un TD porte le numéro de sa séance et une lettre, dans l'ordre où la séance les fait — `2a`, `2b`, `2c` au cours 2 ; le nom est unique dans le module. Son statut, écrit à côté du numéro et jamais dans le nom du dossier, dit s'il est *facultatif* ou réservé à un parcours (*parcours standard*, *parcours avancé*). Les anciens numéros sont dans [`src/anciens_noms_td.md`](src/anciens_noms_td.md). Ce qui est trop long pour la séance est marqué *facultatif* (au cours 1 : l'archive .odt, le C++, les octets, la vidéo) et reste dans l'archive pour qui va plus vite. Le support se compile aussi sans les TD, une diapositive de sommaire à leur place (`--sans-tds`).
- **Les données de cours sont générées, pas versionnées** : `data/cours<n>/make_data.py` récupère des sources du domaine public et en dérive les fichiers de l'exercice. Dépôt léger, données reproductibles, et le script devient lui-même un exemple de `pathlib`/`subprocess` (cours 3).
- **Supports en formats texte** : notebooks en **MyST** (`.md`) plutôt qu'en `.ipynb` — `git diff` lisible ; diapositives en **typst**, avec une seule dépendance, [`cetz`](https://typst.app/universe/package/cetz), pour les schémas dessinés. Le module enseigne ce qu'il pratique.
- **Book construit avec Sphinx + `myst-nb`** : produit du HTML à chemins **relatifs**, sans ressource externe — `_build/html/index.html` s'ouvre par double-clic, hors ligne, sans serveur. C'est la contrainte de distribution aux étudiants ; `mystmd` / Jupyter Book 2 génère une application web qui exige un serveur. Détail : [`INSTALLATION.md`](INSTALLATION.md).
- **Git enseigné par répétition à faible enjeu** (dépôt de notes) puis appliqué (projet 4 animation, c6 trajectoire, projet 7 benchmark).
- **Projet collaboratif = parallèle, sans merge séquentiel** : dépôt **individuel** (GitHub Classroom), PR + **conflit pré-amorcé** (branche fournie) + **revue round-robin**. Réussite ≠ « mergé dans un main partagé ».
- **Fiche perso / CV écartée** comme projet (livrable trop léger en semaine 3) ; la leçon secrets/`.gitignore` est portée par le cours 5B.
- **Deux projets** : séance 4 = studio d'animation (subprocess + ImageMagick + ffmpeg) ; séance 7 = capstone benchmark image (boucle vs numpy, « Python pur vs call C »), rapport markdown.

## Conventions

L'écriture des supports suit [`STYLE.md`](STYLE.md) : diapositives en
assertion-evidence (titre = groupe nominal qui nomme le sujet, corps = preuve
visuelle, pas de liste à puces), pages de cours en prose autonome, notes
enseignant télégraphiques. À lire avant de rédiger une séance.

- Chaque séance ≈ **120 min** ; parties notées **🎓 exposé** ou **⌨ TD** + durée indicative.
- Cours = exposé + TD sur machine ; projet = les séances 4 et 7, un livrable complet.
- Un support de séance = une page MyST (`src/cours<n>/notebook/`) **et** un jeu de diapos (`src/cours<n>/diapo/`) ; le déroulé pour l'enseignant reste dans `syllabus/cours/<n>_.../`.

## Reste à faire

- Détailler `syllabus/cours/2..7` (contenu + exercices) sur le gabarit du cours 1.
- Rédiger les supports `src/cours2..7` (notebooks + diapos), modèle : `src/cours1/`.
- Alimenter `data/cours2..7` (un `make_data.py` par séance quand c'est pertinent).
- Ajouter une source `scarborough.txt` dans `data/cours1/1a_formats/fourni/` si on veut la ballade en plus (pas d'export texte stable sur Wikisource — la page ne contient que la partition).
- Dépôts-squelettes réels : projet 4 (studio animation), projet 7 (benchmark image + branche `conflit-rapport`), outil trajectoire (c6).
- Recaler le calendrier (dates) si besoin.
