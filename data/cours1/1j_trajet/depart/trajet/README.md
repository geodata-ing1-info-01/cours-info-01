# trajet — une vidéo commentée, à partir d'une carte et d'un fichier d'étapes

Le programme lit un fond de carte et une liste d'étapes données en pixels de
cette carte. Il dessine une image par étape — le chemin déjà parcouru en bleu,
le segment en cours en orange — écrit les sous-titres aux mêmes durées, et
monte le tout en une vidéo.

```
trajet/
├── pyproject.toml      ce qu'est le projet, et ce dont il dépend
├── environment.yml     l'environnement conda dans lequel il tourne
├── README.md           ce fichier
├── data/               ce que le programme lit
│   ├── carte.png           le fond de carte, fourni
│   └── etapes.csv          une ligne par point du trajet
└── src/trajet/         le code, en quatre modules
    ├── __init__.py         ce qui fait de `trajet/` un paquet
    ├── etapes.py           lire le fichier des étapes
    ├── images.py           dessiner une image par étape, avec ImageMagick
    ├── montage.py          les sous-titres, la liste de montage, ffmpeg
    └── __main__.py         le programme en ligne de commande
```

Les images d'étape, `trajet.srt`, `montage.txt` et `trajet.mp4` sont ce que le
programme produit : ils ne sont pas versionnés, et se refabriquent.

## Installation

Le projet a besoin de deux programmes, `ffmpeg` et ImageMagick, qui ne sont pas
des bibliothèques Python et ne s'installent donc pas avec `pip`. C'est
`environment.yml` qui les porte.

```bash
conda env create -f environment.yml
conda activate trajet_ensg
python -m pip install -e .
```

La première commande crée l'environnement `trajet_ensg` et y pose Python,
`ffmpeg` et ImageMagick. La troisième installe le projet lui-même : sans elle,
`import trajet` ne trouve rien, le code étant sous `src/`.

### Vérifier que l'installation est complète

```bash
magick --version      # ImageMagick 7.x
ffmpeg -version       # ffmpeg 7.x
trajet --help         # ce que la commande accepte
```

Si `magick` ou `ffmpeg` répond « commande introuvable », l'environnement n'est
pas actif : `conda activate trajet_ensg`. Le programme le dit aussi, plutôt que
d'échouer au milieu du montage.

## Utilisation

```bash
trajet                          # data/ → trajet.mp4, dans le dossier du projet
trajet --sortie /tmp/essai      # écrit la vidéo et ses fichiers ailleurs
trajet --etapes autre.csv       # un autre trajet, sur la même carte
```

`python -m trajet` fait exactement la même chose : la commande courte existe
parce que `pyproject.toml` la déclare dans `[project.scripts]`.

## Les fichiers intermédiaires, et pourquoi ils restent

Chaque étape produit un fichier que la suivante consomme, et tous restent dans
le dossier de sortie une fois la vidéo montée.

| Fichier | Écrit par | Lu par |
|---|---|---|
| `etape_01.png` … | ImageMagick, un `-draw` par segment | ffmpeg |
| `trajet.srt` | `montage.ecrire_sous_titres` | ffmpeg, qui les incruste |
| `montage.txt` | `montage.ecrire_liste_de_montage` | ffmpeg, en mode `concat` |
| `trajet.mp4` | ffmpeg | vous |

Les deux fichiers du milieu sont du texte : ouvrez-les. Un `.srt` est un
numéro, un intervalle, une ligne de texte ; `montage.txt` est une liste de
fichiers et de durées. Deux programmes s'échangent du texte, et c'est lisible.

## Le fichier des étapes

```
numero,duree,x,y,texte
0,0,398,248,Sortie de la gare de Noisy-Champs
1,4,410,360,1. Sortir côté Cité Descartes et descendre vers le Mail Descartes
```

La première ligne est le point de départ : sa durée vaut zéro, rien n'y est
animé, elle sert d'origine au premier segment. `x` et `y` sont des pixels de
`data/carte.png`, comptés depuis le coin haut-gauche.

Changer un texte et relancer coûte une commande. C'est le propos du TD : la
même vidéo refaite à la souris, c'est tout recommencer.

## Licence des données cartographiques

Le fond de carte provient d'OpenStreetMap, sous licence ODbL. La mention
« © les contributeurs d'OpenStreetMap » est incrustée en bas de l'image et doit
y rester.
