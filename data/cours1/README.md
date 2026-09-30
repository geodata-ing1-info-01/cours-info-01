# Données — Cours 1

Un dossier par TD, nommé comme le TD l'est dans les diapositives : le chiffre
est le bloc, joué au même moment du cours, la lettre l'ordre dans le bloc.
Le fichier typst du TD porte le même nom, `src/cours1/diapo/tds/1a_formats.typ`
pour `1a_formats/`.

| Dossier | TD | |
|---------|----|-|
| [`1a_formats/`](1a_formats/) | Fichiers, formats et extensions : exporter depuis LibreOffice, copier, renommer, ouvrir au Bloc-notes et dans le navigateur ; `depart/` est donné, `travail/` reçoit les copies | |
| [`1b_archive_odt/`](1b_archive_odt/) | un `.odt` est une archive ZIP : l'ouvrir, modifier `content.xml`, recompresser | facultatif |
| [`1c_vscode_python/`](1c_vscode_python/) | configurer l'éditeur de code (depuis Anaconda, ou hors Anaconda), puis exécuter un programme de trois façons | |
| [`1d_erreurs/`](1d_erreurs/) | trois programmes Python fautifs, à corriger dans l'éditeur, dont un chemin en dur | |
| [`1e_hello_cpp/`](1e_hello_cpp/) | le même programme en C++ : extension, compilateur, compilation | facultatif |
| [`1f_markdown/`](1f_markdown/) | une recette en texte brut, à mettre en forme en Markdown ; en annexe, la comparaison de deux versions | |
| [`1h_recette/`](1h_recette/) | un petit projet Python : créer un environnement, installer le projet, écrire son `environment.yml` et sa documentation d'installation | |
| [`1g_notebooks/`](1g_notebooks/) | `altitudes.ipynb`, ouvert dans le navigateur, dans l'éditeur et dans JupyterLab | |
| [`1i_noyaux/`](1i_noyaux/) | séparer le client et le noyau, et le notebook du projet recette | facultatif |
| [`1j_trajet/`](1j_trajet/) | installer et lancer un projet qu'on n'a pas écrit, en lisant son `README` | facultatif |

Chacun a son README. Les TD facultatifs ne sont pas faits en séance ; leurs
diapositives et leurs fichiers sont là pour qui va plus vite, ou pour après.

## Deux noms réservés

À l'intérieur d'un dossier de TD, deux sous-dossiers ont un sens fixé, et
c'est la seule règle à connaître : elle vaut pour toutes les séances.

| Nom | Ce qu'il contient | Versionné | Doit voyager |
|-----|-------------------|-----------|--------------|
| le dossier du TD lui-même | les sources : scripts, `.csv`, `.md`, quelques lignes chacun | oui | par git |
| `produit/` | ce qu'une commande refabrique : `make_data.py`, `carte.py`, `construire_notebooks.py` | non | non, il se refait |
| `fourni/` | ce qui vient d'ailleurs et ne se refabrique pas | non | **oui** |

Perdre un `produit/` ne coûte qu'un temps de calcul ; perdre un `fourni/` coûte
un retéléchargement qui n'est pas toujours possible — les tuiles OpenStreetMap
de [`1j_trajet/`](1j_trajet/) sont dans ce cas, leurs conditions d'usage
interdisant le téléchargement en masse.

Les `fourni/` ne se recopient donc pas à la main d'un poste à l'autre :

```bash
python outils/ressources.py exporter /media/…/info01-ressources   # vers la clé
python outils/ressources.py importer /media/…/info01-ressources   # depuis la clé
python outils/ressources.py verifier                              # rien ne manque ?
```

`verifier` compare le dépôt au manifeste versionné `outils/ressources.json` : sur
un poste neuf, il dit ce qui manque avant qu'un TD ne s'arrête faute d'un
fichier.

Ce qu'un TD fait fabriquer aux étudiants — l'exécutable du hello world, la page
HTML de la recette, les copies renommées du TD 1j — naît à côté de sa source,
parce que c'est la commande que les étudiants tapent ; `.gitignore` le sait.

Les captures d'écran des diapositives ne sont pas ici : elles servent aux
supports et non aux TD, et vivent dans [`illustrations/`](../../illustrations/)
à la racine du dépôt.

## Ce que les étudiants reçoivent

Pas ce dépôt : une archive par séance, `info01-cours1.zip`, assemblée par

```bash
python outils/livrer_tds.py            # → livraison/cours1/ et livraison/info01-cours1.zip
python outils/livrer_tds.py --lister   # ce qui partirait, sans rien écrire
```

Elle contient `cours1/`, avec un dossier par TD, et dans chacun : les fichiers
versionnés, le contenu de `produit/` **mis à plat** (sans `_corrige/`), et la
feuille du TD, `td_<dossier>.pdf`, compilée par `outils/compiler_tds.py`. Ni
`fourni/`, ni `make_data.py`, ni ce README ne partent : l'archive porte le
sien, qui liste les TD.

La distinction `produit/` / `fourni/` compte pour qui entretient le cours et
n'est rien pour qui le suit ; l'archive ne la montre donc pas, et **les
diapositives nomment les chemins tels que l'archive les montre** :
`cours1/1a_formats/raven.odt`, sans `data/` ni `produit/`. C'est depuis
`livraison/cours1/` qu'on rejoue un TD pour le vérifier, jamais depuis `data/`
— ce qu'un TD fabrique y resterait, et `make_data.py build` repart de zéro.

Les scripts qui lisent les fichiers d'un autre TD (`1d_erreurs/depart/chemin.py`, les
notebooks) cherchent d'abord `produit/`, puis le dossier lui-même : ils
tournent dans les deux arborescences.

## Pourquoi le texte n'est pas versionné

- Un dépôt git garde **tout, définitivement** : on n'y met pas de gros corpus recopiés
  (cf. leçon « secrets & `.gitignore` », cours 5B).
- Les fichiers du TD 1a sont **dérivés** (une-ligne, `.odt`, `.html`) : ce sont des
  artefacts générés, comme les frames du projet de la séance 4. On versionne la
  recette, pas le produit.
- Bonus pédagogique : `make_data.py` est lui-même un exemple de `pathlib` + `subprocess`
  (cours 3).

## Sources utilisées (domaine public)

| Clé | Texte | Origine |
|-----|-------|---------|
| `raven` | *The Raven*, Edgar Allan Poe (1845) | Project Gutenberg |
| `auld_lang_syne` | *Auld Lang Syne*, Robert Burns (1788) | Project Gutenberg |
| `scarborough` | *Scarborough Fair* (ballade traditionnelle anglaise) | Wikisource, à déposer à la main |

## Fabriquer les fichiers du TD 1a

```bash
# 1. récupérer les sources (une seule fois, nécessite le réseau)
python make_data.py fetch

#    …ou, hors ligne : déposer soi-même un .txt dans 1a_formats/fourni/
#    (ex. 1a_formats/fourni/raven.txt)

# 2. générer les fichiers de l'exercice dans 1a_formats/produit/depart/,
#    et la copie de raven.odt du TD 1b dans 1b_archive_odt/produit/depart/
python make_data.py build
```

`build` vide `produit/` avant d'écrire : ce qu'un TD joué depuis le dépôt y
aurait laissé ne part pas dans l'archive. Il crée aussi `produit/travail/`,
vide : dans l'archive, l'étudiant trouve `depart/` (ce qui lui est donné) et
`travail/` (où vont ses copies), et ne confond pas les deux.

| Fichier | Rôle dans l'exercice |
|---------|----------------------|
| `<nom>_une_ligne.txt` | tout le texte sur **une seule ligne** → à re-formater |
| `<nom>_une_ligne.donnees` | le **même** contenu, mauvaise extension → à renommer |
| `<nom>.odt` | à ouvrir avec **LibreOffice Writer** |
| `<nom>_brut.html` | à ouvrir dans le **navigateur** (rendu sans mise en forme) |
| `<nom>_style.html` + `style.css` | même contenu **avec CSS** → comparer les deux |
| `_corrige/<nom>.txt` | version correctement formatée (pour l'enseignant, pas livrée) |
