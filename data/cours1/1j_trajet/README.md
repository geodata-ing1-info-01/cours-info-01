# Installer un projet en lisant son README — TD 1j, cours 1, facultatif

Le projet `trajet` fabrique une vidéo commentée du chemin de la gare à l'école.
L'exercice n'est pas de l'écrire, c'est de **l'installer et de le lancer sans
autre consigne que sa documentation**.

| Dossier | Ce qu'il contient |
|---|---|
| `depart/trajet/` | le projet, avec son `README` et son `environment.yml` |
| `travail/` | vide : votre copie du projet, et la vidéo que vous en tirez |
| `outils_video.ipynb` | facultatif : les commandes `magick` et `ffmpeg` une à une |

Copiez `depart/trajet/` dans `travail/`, ouvrez son `README`, et suivez sa
section « Installation ».

## Ce que le TD fait constater

`pyproject.toml` déclare zéro dépendance, et le projet ne tourne pourtant pas
sans son `environment.yml`. Ce dont il dépend — `ffmpeg` et ImageMagick — n'est
pas du Python : ce sont des programmes, que `pip` ne sait pas poser et que
`conda` installe. Les deux fichiers ne disent donc pas la même chose, et c'est
la démonstration de la partie 3, faite sur un projet qu'on n'a pas écrit.

Le code les appelle par `subprocess`, donc depuis Python : le TD fonctionne sur
les trois systèmes, Windows compris.

## Le fond de carte

`carte.png` est fabriqué **une fois par l'enseignant**, avant la séance, et
livré avec le projet :

```bash
conda activate base
python carte.py                 # → produit/depart/trajet/data/carte.png
```

Le serveur de tuiles d'OpenStreetMap est un service bénévole dont les
conditions d'usage interdisent le téléchargement en masse : une promotion
entière ne doit pas le solliciter en même temps. Les tuiles déjà récupérées
sont en cache dans `fourni/`, qui ne part pas dans l'archive.

`carte.py` accepte aussi un tracé exporté depuis uMap, ce qui permet de partir
d'un trajet dessiné à la souris :

```bash
python carte.py trajet.geojson  # écrit etapes.csv, dont les textes restent à saisir
```

## Ce que l'enseignant prépare avant la séance

1. Lancer `python carte.py` une fois, avec le réseau.
2. Vérifier les coordonnées en pixels d'`etapes.csv` sur la carte produite ;
   elles dépendent de la zone choisie, `BBOX` dans `carte.py`.
3. Rédiger les cinq textes d'étape, ou les laisser à écrire aux étudiants.

## Zone couverte

`BBOX` vaut par défaut la Cité Descartes, de la gare de Noisy-Champs à l'avenue
Blaise Pascal. Changer cette constante suffit à déplacer le TD ailleurs ; les
coordonnées d'`etapes.csv` sont alors à refaire.

## Licence des données cartographiques

Le fond de carte provient d'OpenStreetMap, sous licence ODbL. La mention
« © les contributeurs d'OpenStreetMap » est incrustée par `carte.py` en bas de
l'image et doit y rester.
