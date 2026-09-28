# Installation & construction des supports

Environnement testé le 02/09/2026 sous Linux (conda 24.11, miniforge). Toutes les
commandes de ce document ont été exécutées telles quelles.

---

## 1. L'environnement de fabrication

### Installer conda

**Miniforge** — distribution conda préconfigurée sur `conda-forge`, sans licence
commerciale à surveiller : <https://conda-forge.org/download/>
(Windows, macOS Intel/ARM, Linux).

Vérifier ensuite dans un terminal neuf :

```bash
conda --version
```

> **Windows** : utiliser le *Miniforge Prompt* installé avec Miniforge, ou lancer
> `conda init powershell` une fois puis rouvrir le terminal.

### Créer l'environnement

Le dépôt n'en décrit qu'un, `info01`, celui qui **recompile les diapositives et
le book**. Il porte Python, JupyterLab, numpy, pillow, ffmpeg, ImageMagick et
pandoc — de quoi exécuter les notebooks du book et fabriquer les données — et y
ajoute typst, Sphinx, myst-nb et jupytext.

```bash
conda env create -f environment-supports.yml
conda activate info01
```

Le prompt doit afficher `(info01)`. Durée observée : **~1 min 30** (première
fois, téléchargements inclus).

Les étudiants n'ont pas cet environnement et n'en ont pas besoin. Ce qu'on leur
demande d'installer est **Anaconda**, dont l'environnement `base` suffit aux
premiers TD ; ceux qui demandent autre chose — `recette` au TD 4a,
`trajet_ensg` au TD 5a — font créer le leur, et c'est le sujet de la séance.

### Vérifier

```bash
python  --version    # Python 3.12.x
sphinx-build --version   # 9.x   → book
typst   --version    # 0.15.x    → diapositives
pandoc  --version    # 3.11      → conversions de documents
ffmpeg  -version     # → projet 4
magick  --version    # ImageMagick 7 → projet 4

python -c "import numpy, PIL; print(numpy.__version__, PIL.__version__)"
```

Et le réflexe enseigné en séance 1 — *quel Python tourne réellement ?* :

```bash
python -c "import sys; print(sys.executable)"   # doit contenir « info01 »
```

### Mettre à jour après modification de `environment-supports.yml`

```bash
conda env update -f environment-supports.yml --prune
```

### Repartir de zéro

```bash
conda deactivate
conda env remove -n info01
```

### Ce que contient l'environnement, et pourquoi

| Paquet | Sert à | Vu en |
|--------|--------|-------|
| `python=3.12` | socle | c1 |
| `jupyterlab` | exécuter les notebooks | c1 |
| `jupytext` | conversion `.ipynb` ↔ MyST | c1, ex. 5 |
| `sphinx`, `myst-nb`, `sphinx-book-theme`, `sphinx-design` | construire le book | supports |
| `sphinx-autobuild` | aperçu live pendant la rédaction | supports |
| `typst` | diapositives | supports |
| `pandoc` | conversions de documents | c2, `make_data.py` |
| `numpy`, `pillow` | calcul et images | c6, projet 7 |
| `ffmpeg`, `imagemagick` | pipeline d'animation | c3, projet 4 |

---

## 2. Données du cours 1

Le dépôt versionne le script, pas les textes (voir [`data/cours1/README.md`](data/cours1/README.md)).

```bash
conda activate info01
cd data/cours1
python make_data.py fetch    # télécharge les sources — une seule fois, réseau requis
python make_data.py build    # dérive les fichiers du TD 1a dans 1a_formats/produit/depart/
```

Sans réseau : déposer un `.txt` dans `data/cours1/1a_formats/fourni/` (le nom du
fichier est la clé, ex. `raven.txt`) puis lancer directement `build`.

`build` produit, pour chaque texte : la version `.txt` **sur une ligne**, la
copie `.donnees` à mauvaise extension, l'`.odt` (via pandoc), l'`.html` brut,
l'`.html` + `style.css`, et le corrigé dans `produit/_corrige/`.

---

## 2 ter. Ressources hors dépôt

Deux noms sont réservés dans `data/` : `produit/` désigne ce qu'une commande
refabrique, `fourni/` ce qui vient d'ailleurs et ne se refabrique pas. Les
captures d'écran des supports, dans `illustrations/`, sont du second genre.
Aucun des deux n'est versionné, mais seul le second doit suivre d'un poste à
l'autre.

```bash
python outils/ressources.py verifier                             # que manque-t-il ?
python outils/ressources.py importer /media/…/info01-ressources  # remettre en place
python outils/ressources.py exporter /media/…/info01-ressources  # publier vers la clé
```

`exporter` met à jour `outils/ressources.json`, qui retient la taille et
l'empreinte de chaque fichier. Ce manifeste étant versionné, `verifier`
fonctionne sur un poste fraîchement cloné, avant toute copie : il dit ce qui
manque plutôt que de laisser un TD s'arrêter en séance.

Les copies sont relues après écriture, `importer` n'efface jamais rien et
refuse d'écraser un fichier dont le contenu diffère tant qu'on ne lui passe pas
`--forcer`. `--simuler` montre ce qui serait fait sans rien écrire, et
`--archive` produit en plus un zip daté à côté du dossier.

## 2 bis. Notebooks

Les notebooks sont écrits en **MyST Markdown**, dans `src/cours<n>/notebook/`.
C'est du texte : il se relit, se compare ligne à ligne et se versionne — la
démonstration du cours 1 appliquée à ses propres supports. Les `.ipynb` en sont
dérivés, comme les PDF le sont des `.typ`, et ils sont dans `.gitignore`.

```bash
conda activate info01

python outils/construire_notebooks.py             # cellules vides, à ouvrir en séance
python outils/construire_notebooks.py --executer  # sorties remplies, pour distribuer
```

## 3. Diapositives (typst)

### Polices — à faire une fois, avant la première compilation

Le thème reprend l'identité du thème Beamer *Bruno*, qui impose **Fira Sans**
et dont le « gras » est en réalité un demi-gras (graisse 500). Les gabarits
sont calibrés sur la chasse de cette police.

Sans elle, typst ne s'arrête pas : il prend la suivante de la pile de
substitution et signale `unknown font family`. Le document compile, mais plus
large, et c'est ainsi que du texte est passé par-dessus le bord de ses cadres
dans une version antérieure de ce dépôt.

```bash
conda activate info01

python outils/verifier_polices.py             # état des lieux
python outils/verifier_polices.py --installer # télécharge et installe Fira Sans et Lato
```

L'installation se fait dans le dossier de polices de l'utilisateur, sans droits
d'administration : `~/.local/share/fonts` sous Linux, `~/Library/Fonts` sous
macOS, `%LOCALAPPDATA%\Microsoft\Windows\Fonts` sous Windows. Fira Sans est
publiée par Mozilla sous licence SIL Open Font License 1.1 ; le dépôt ne
l'embarque pas, pour rester sans fichier binaire.

Le script installe aussi Lato, la police de repli de la pile. Elle ne sert pas
quand Fira Sans est présente, mais sans elle typst signale
`unknown font family: lato` à chaque compilation.

> **Terminal intégré de VSCode installé en snap** : il redéfinit
> `XDG_DATA_HOME` pour s'isoler, et fontconfig cherche alors les polices dans
> le bac à sable du snap. Le script installe aux deux endroits, de sorte que le
> rendu soit le même depuis un terminal ordinaire et depuis celui de l'éditeur.

Depuis la version qui suit, les schémas mesurent leurs boîtes avant de les
poser : le texte ne peut plus déborder, même sans aucune police système. La
police reste néanmoins nécessaire pour retrouver la mise en page voulue.

### Paquet typst — récupéré à la première compilation

Les diapositives emploient un seul paquet, `@preview/cetz`, pour les schémas
dessinés à la main dans le code — celui du lieu d'exécution d'une application
web, au cours 1. La version est figée dans le source (`cetz:0.4.2`) : typst la
télécharge depuis le registre à la première compilation, puis la garde en cache
local (`~/.cache/typst/packages` sous Linux).

La première compilation demande donc un accès réseau. Les suivantes n'en ont
plus besoin, et une machine dont le cache est déjà rempli compile hors ligne.

### Compiler

Le script de compilation évite d'avoir à retenir les options : il place la
racine du bac à sable de typst sur celle du dépôt, et n'emploie les captures
d'écran que si elles sont réellement présentes.

```bash
conda activate info01

python outils/compiler_diapos.py             # le cours 1, à projeter
python outils/compiler_diapos.py --notes     # version annotée
python outils/compiler_diapos.py --corrige   # corrigé des TD
python outils/compiler_diapos.py --sans-tds  # le fil du cours, un sommaire par bloc de TD
python outils/compiler_diapos.py --tous      # les sept jeux
python outils/compiler_diapos.py --sans-captures   # vérifier le repli dessiné
```

Les commandes équivalentes, à la main :

```bash
conda activate info01

# compilation unique → src/cours1/diapo/cours1.pdf
typst compile --root . src/cours1/diapo/cours1.typ

# version annotée, avec les notes de conduite de l'enseignant
typst compile --root . --input notes=true src/cours1/diapo/cours1.typ cours1-notes.pdf

# avec les captures d'écran, si l'archive a été décompressée
typst compile --root . --input captures=true src/cours1/diapo/cours1.typ

# avec le corrigé des TD, à distribuer après la séance
typst compile --root . --input corrige=true src/cours1/diapo/cours1.typ cours1-corrige.pdf

# recompilation à chaque sauvegarde (confortable pour rédiger)
typst watch --root . src/cours1/diapo/cours1.typ

# export images (une PNG par diapositive)
typst compile --root . --format png --ppi 150 src/cours1/diapo/cours1.typ "apercu-{n}.png"
```

`--root .` place la racine du bac à sable de typst sur celle du dépôt : sans
elle, un `.typ` de `src/cours1/diapo/` ne peut pas lire une image de `data/`.

Tous les jeux d'un coup :

```bash
for f in src/cours*/diapo/cours*.typ; do typst compile --root . "$f"; done
```

### Les compilations, et à qui elles servent

| Options | Pour qui | Ce qui change |
|---------|----------|---------------|
| aucune | projeté en séance | la séance seule, colonnes d'observation vides |
| `--input corrige=true` | distribué après la séance | ces colonnes sont remplies |
| `--input notes=true` | l'enseignant | page deux fois plus large : la diapositive à gauche, ses notes à droite (format « second écran » de Beamer) |
| `--input captures=true` | partout, si les images sont là | les captures d'écran remplacent les schémas dessinés |
| `--input tds=false` | une séance où les TD se font sur feuille | chaque bloc de TD est remplacé par une diapositive qui les liste |

Chaque TD se compile aussi seul, en feuille de TD déposée dans le dossier de
données qu'il annonce, et l'archive remise aux étudiants s'assemble à partir
de là :

```bash
python outils/compiler_tds.py            # les dix TD du cours 1, td_<dossier>.pdf
python outils/compiler_tds.py --corrige  # + la version avec les réponses
python outils/livrer_tds.py              # livraison/cours1/ et livraison/info01-cours1.zip
```

Les options se combinent. Ce que le TD fait constater n'est pas projeté
pendant qu'il se fait : la tentative, même infructueuse, améliore la rétention
de la réponse donnée ensuite, et un support à trous est plus efficace qu'un
support complet. Les références sont dans [`STYLE.md`](STYLE.md#td-et-corrigé).

### Vérifier une fois compilé

typst ne signale pas une diapositive trop pleine : le gabarit répartit l'espace
libre par des ressorts, et quand le corps est trop haut ils se referment
silencieusement, collant la phrase d'annonce sous le titre. Le symptôme se
mesure sur le PDF :

```bash
python outils/verifier_diapos.py src/cours1/diapo/cours1.pdf
```

La version annotée est plus contrainte, puisqu'elle réserve le bas de la page
aux notes de conduite. Elle se relit avec un seuil plus bas :

```bash
typst compile --root . --input notes=true src/cours1/diapo/cours1.typ notes.pdf
python outils/verifier_diapos.py --seuil 10 notes.pdf
```

Le script sort en code 1 dès qu'une diapositive est signalée.

### Captures d'écran

Les images d'illustration ne sont pas versionnées : voir
[`illustrations/cours1/README.md`](illustrations/cours1/README.md)
pour l'arborescence attendue, les noms de fichiers et le format. Sans elles,
chaque diapositive concernée emploie un équivalent dessiné en typst, et le
document compile normalement.

### Dépendances

**Aucun paquet typst importé.** La seule dépendance externe est la police du
texte, traitée ci-dessus ; celle du code (*DejaVu Sans Mono*) est embarquée
dans typst. Les PDF générés sont dans `.gitignore` : ce sont des artefacts.

### Structure d'un jeu de diapositives

Le contenu est découpé par partie sous `src/cours1/diapo/parties/` ;
`cours1.typ` ne porte que les réglages globaux et l'ordre des inclusions. Les
gabarits sont partagés par les sept séances dans `src/commun/`, et un seul
import les apporte tous :

```typst
#import "../../commun/prelude.typ": *
```

`src/commun/theme.typ` porte la mise en page et les gabarits. Les principaux :

| Helper | Rôle |
|--------|------|
| `diapos(titre-court:, auteur-court:)` | réglages globaux, pied de page |
| `d(titre)[…]` | une diapositive ordinaire |
| `separateur(…)` / `separateur-td(..td)` / `sommaire-td(…)` | diapositives de section, ouverture et sommaire des TD |
| `annonce[…]`, `legende[…]`, `notes[…]` | phrase sous le titre, source, notes de conduite |
| `tableau(…)`, `face-a-face(…)`, `panneau(…)` | preuves visuelles |
| `fenetre(titre)[…]` | fenêtre d'application dessinée |
| `illustration(chemin, repli)` | capture d'écran si elle est là, dessin sinon |

La liste complète est dans [`src/cours1/diapo/README.md`](src/cours1/diapo/README.md).
`src/cours1/diapo/cours1.typ` sert de modèle ; les gabarits des cours 2–7
importent le même thème.

---

## 4. Book (notebooks)

Le book couvre les 7 séances. Sa configuration, [`src/conf.py`](src/conf.py), est
lue par **Sphinx** ; les pages sont du Markdown MyST exécutable (`myst-nb`).

Toutes les commandes se lancent depuis la **racine du dépôt**.

### Construire

```bash
conda activate info01
sphinx-build -E -b html src _build/html
```

Sortie dans `_build/html/`. Durée observée : **~6 s** en repartant de zéro,
exécution des notebooks comprise. `nb_execution_mode = "cache"` ne réexécute
ensuite que les pages modifiées.

Les schémas des pages de cours sont des SVG versionnés, tirés des dessins des
diapositives (`src/cours<n>/notebook/figures/<nom>.typ`). Après avoir modifié
l'un d'eux, ou le dessin de diapositive qu'il reprend, les recompiler avant de
construire : `python outils/compiler_figures.py`.

`-E` fait relire toutes les sources. Sans lui, Sphinx ne réécrit que les pages
dont la source a changé : après une modification d'un sommaire (`toctree`),
les autres pages gardent l'ancien menu de gauche. Le cache d'exécution des
notebooks n'est pas concerné, et la construction reste de quelques secondes.

### Consulter le résultat

**Double-cliquer sur `_build/html/index.html`.** C'est tout.

Le HTML produit utilise des **chemins relatifs** et n'appelle **aucune ressource
externe** : le site s'ouvre en `file://`, sans serveur et sans connexion. C'est
la contrainte qui a décidé du choix de Sphinx (voir §6).

Pour distribuer aux étudiants : zipper `_build/html/` (≈ 7,6 Mo) ou le déposer
sur l'ENT — dans les deux cas ça marche hors ligne.

> Seule réserve : la **recherche plein texte** peut rester inerte en `file://`
> (le navigateur bloque les requêtes locales). La navigation, les pages et les
> résultats de cellules, eux, fonctionnent.

### Aperçu live — pour rédiger

```bash
sphinx-autobuild src _build/html      # → http://localhost:8000
```

Reconstruit et rafraîchit le navigateur à chaque sauvegarde.

### Nettoyer

```bash
rm -rf _build
```

`_build/` est dans `.gitignore`.

### Prérequis d'exécution

Des cellules des pages du cours 1 lisent des fichiers de TD versionnés :
`04_bibliotheques_environnements.md` le projet
`data/cours1/4a_recette/depart/recette/`, et `05_comparer_versions.md`
`data/cours1/3a_markdown/depart/recette.md`. Une page qui lirait un fichier fabriqué, dans
`data/cours<n>/<td>/produit/`, demanderait de **générer les données avant de
construire** (section 2), sinon la build échoue
(`nb_execution_raise_on_error = True` : une cellule cassée doit se voir).

La page localise la racine du dépôt en remontant l'arborescence : elle fonctionne
aussi bien depuis JupyterLab, VSCode que `sphinx-build`.

### Écrire une page

Une page exécutable = du Markdown MyST avec ce frontmatter :

```yaml
---
title: Titre de la page
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---
```

Sans le bloc `jupytext`, `myst-nb` traite le fichier comme du Markdown ordinaire
et **n'exécute pas** les cellules.

Puis les cellules de code :

````markdown
```{code-cell} python
print("exécuté à la construction")
```
````

Les pages du cours 1 servent de modèle (encadrés `:::{note}` / `:::{important}`,
tableaux `{list-table}`, schémas SVG).

## 4 bis. Publier une séance

Ce que les étudiants reçoivent n'est pas dans git : les PDF et `livraison/`
sont ignorés par `.gitignore`, pour ne pas alourdir l'historique à chaque
recompilation. Une **release** est faite pour ça : c'est une étiquette posée
sur un commit (un *tag*), à laquelle la forge attache des fichiers à
télécharger. Le tag dit d'où viennent les fichiers ; les fichiers sont ce
qu'on distribue.

Deux fichiers par séance :

| Fichier | Ce que c'est |
|---|---|
| `src/cours1/diapo/cours1-sans-tds.pdf` | le fil du cours, un sommaire par bloc de TD |
| `livraison/info01-cours1.zip` | les dossiers des TD, feuille de TD comprise |

### 1. Tout refabriquer, puis vérifier

Dans l'ordre, chaque commande reprenant le résultat de la précédente :

```bash
conda activate info01
python outils/compiler_diapos.py --sans-tds        # le PDF à publier
python outils/verifier_diapos.py src/cours1/diapo/cours1-sans-tds.pdf
python outils/livrer_tds.py                         # données, feuilles de TD, notebooks, puis le zip
```

`livrer_tds.py` ne prend que les fichiers connus de git : un fichier nouveau
doit être ajouté (`git add`) avant.

### 2. Committer, et poser le tag

```bash
git add -A
git commit
git tag -a cours1-2026-09-14 -m "Séance 1 — version projetée le 15 septembre 2026"
```

Le nom du tag est libre ; ici, la séance et la date. `-a` en fait un tag
annoté, qui garde qui l'a posé et quand ; `-m` est son message, comme pour un
commit.

### 3. Pousser, tag compris

```bash
git push gitlab main
git push gitlab cours1-2026-09-14      # un tag ne part pas avec la branche : il se pousse à part
```

Même chose vers GitHub, en remplaçant `gitlab` par `github`. Le remote
`github` s'ajoute une fois, avec l'adresse du dépôt public :

```bash
git remote add github https://github.com/<compte>/ecue-info-01.git
```

### 4. Créer la release et y joindre les deux fichiers

Cette étape se fait dans le navigateur, et c'est la même idée sur les deux
forges : choisir le tag, écrire un titre, joindre les fichiers.

**GitLab** (gitlab.ign.fr) : le formulaire de release, **Deploy → Releases →
New release**, ne sait pas recevoir un fichier. Sa zone « Links » attend une
adresse, et le champ de description n'a pas de bouton pour ouvrir un fichier
local. Deux façons de faire, la première est celle du module.

*Avec `glab`, l'outil en ligne de commande de GitLab.* À installer une fois
dans l'environnement, puis à connecter une fois au serveur de l'école : la
commande demande un jeton d'accès personnel, à créer dans **Avatar →
Preferences → Access tokens** avec la portée `api`.

```bash
conda install -c conda-forge glab
glab auth login --hostname gitlab.ign.fr       # une fois ; coller le jeton
```

Ensuite, une commande par séance, depuis la racine du dépôt. Le tag doit déjà
être poussé (étape 3) ; `glab` crée la release s'il le faut, téléverse les
fichiers dans le projet et les inscrit comme pièces jointes de la release :

```bash
glab release upload cours1-2026-09-14 src/cours1/diapo/cours1-sans-tds.pdf livraison/info01-cours1.zip
```

*Sans rien installer, dans le navigateur.* Il faut d'abord obtenir une adresse
pour chaque fichier, et GitLab n'en donne une que là où il accepte un fichier
glissé : la description d'une issue. Ouvrir **Plan → Issues → New issue**, la
nommer « Fichiers séance 1 », glisser les deux fichiers dans la description ;
GitLab écrit pour chacun une ligne `[nom](/uploads/…/nom)`. Créer l'issue, puis
copier ces deux adresses, en les faisant précéder de
`https://gitlab.ign.fr/geodata-paris/ecue-info-01`. Enfin **Deploy → Releases
→ New release**, choisir le tag, et dans la zone **Links** coller chaque
adresse avec son nom. L'issue peut être fermée, pas supprimée : c'est elle qui
héberge les fichiers.

**GitHub** : dans le dépôt, colonne de droite **Releases**, bouton **Draft a
new release**. **Choose a tag** et prendre le tag poussé ; titre ; puis glisser
les deux fichiers dans la zone **Attach binaries** en bas. **Publish release**.

Ce qu'on donne aux étudiants est alors l'adresse de la page de la release,
où les deux fichiers se téléchargent sans compte.

---

## 5. Problèmes rencontrés (et leur solution)

**La page est vide, ou le navigateur affiche la liste des fichiers.** Symptôme
d'un site MyST/`mystmd` ouvert en `file://` — plus d'actualité depuis le passage
à Sphinx : `_build/html/index.html` s'ouvre directement. Si ça se reproduit,
vérifier qu'on regarde bien `_build/html/` et non un ancien dossier.

**Les cellules n'ont pas de résultat dans le HTML.** Le frontmatter `jupytext`
manque sur la page (voir « Écrire une page » ci-dessus). Sans lui, `myst-nb` lit
le fichier comme du Markdown simple.

**`Executing notebook failed: CellExecutionError`.** La build s'arrête
volontairement sur une cellule en erreur. La cause la plus fréquente : les
données du cours 1 n'ont pas été générées (section 2). Le traceback complet est
écrit dans `_build/html/reports/`.

**`ERROR: Failed to complete gtk3's post-link script`** pendant
`conda env create`. Sans conséquence : ce script concerne l'interface graphique
d'ImageMagick, dont on n'utilise que la ligne de commande. Vérifier simplement
que `magick --version` répond.

**`ModuleNotFoundError` alors que le paquet est installé.** Presque toujours le
mauvais environnement actif. Contrôler `python -c "import sys; print(sys.executable)"` :
le chemin doit contenir le nom de l'environnement actif. C'est le message à
marteler en séance 1.

**`unknown font family: fira sans` et une diapositive signalée trop pleine,
alors que `verifier_polices.py` dit Fira Sans installée.** typst ne lit pas le
dossier où la police est ; vu depuis le terminal intégré de VSCode en snap. Lui
donner le dossier une fois pour la session, puis recompiler :

```bash
export TYPST_FONT_PATHS=~/.local/share/fonts
typst fonts | grep Fira            # doit répondre « Fira Sans »
```

**`mamba` renvoie une `ImportError`.** Installation `mamba`/`conda` désynchronisée
sur ce poste. `conda` seul suffit pour tout ce document (le solveur `libmamba`
est déjà celui de conda ≥ 23).

---

## 6. Pourquoi Sphinx et pas `mystmd` / Jupyter Book 2

Les deux lisent le même Markdown MyST. Ils ne produisent pas la même chose :

| | `mystmd` (Jupyter Book 2) | **Sphinx + `myst-nb`** |
|---|---|---|
| Sortie HTML | application web, chemins **absolus** | pages statiques, chemins **relatifs** |
| Ouvrable en `file://` | non | oui, par double-clic |
| Serveur nécessaire | oui | non |
| Dépendances | + Node.js | Python seul |
| Ressources externes | quelques-unes | aucune |

Le module distribue ses supports à des étudiants de 1re année, sur des postes
variés, parfois hors ligne. **Devoir lancer un serveur local pour lire un cours
est une friction inacceptable** — c'est ce seul critère qui a tranché.

`mystmd` reste le meilleur outil si la destination est un site hébergé ; ce
n'est pas le cas ici.

Deux conséquences de ce choix, assumées :

- **Node.js n'est plus dans l'environnement** (~150 Mo et une source de panne en
  moins : `conda-forge` sert par moments une version *alpha* de Node que
  `mystmd` refuse).
- **Les schémas ne sont plus en `mermaid`** — Sphinx n'a pas de moteur mermaid
  hors ligne. Les trois diagrammes du cours 1 sont écrits en **SVG inline** dans
  les pages, en `currentColor` : ils suivent le thème clair/sombre et ne
  dépendent de rien.
