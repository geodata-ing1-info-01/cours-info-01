# Tourbillon

Tord une image en tourbillon : une image tordue d'un angle donné, une série d'images de 0 à un angle maximal puis retour, ou une vidéo : Python calcule les angles, ImageMagick tord l'image, ffmpeg assemble.

## Installation

Le programme demande Python, ImageMagick et ffmpeg, décrits dans
`environment.yml`.

1. Installer Anaconda ou Miniforge.
2. Récupérer ce dossier par `git clone`, ou en décompressant l'archive du projet.
3. Dans un terminal (Git Bash ou l'invite de commandes d'Anaconda), dans le dossier du
   projet :

```
conda env create -f environment.yml
conda activate animation
```

## Installation de la commande

Dans le dossier du projet, l'environnement `animation` activé :

```
pip install -e .
```

## Utilisation

Dans n'importe quel dossier, l'environnement `animation` activé.

**Une image** :

```
tourbillon vague.jpg --angle 90
```

écrit `sortie/tourbillon_090.png`.

**Une série d'images** :

```
tourbillon vague.jpg --maximum 360
```

écrit `sortie/images/img_0001.png` … `img_0049.png`, de 15 en 15 degrés.

**Une vidéo** :

```
tourbillon vague.jpg --maximum 360 --video --cadence 12 --nettoyer
```

écrit `sortie/tourbillon.mp4` ; `--nettoyer` supprime ensuite `sortie/images/`.

`tourbillon --help` affiche toutes les options.

## Auteur

(Votre nom.)
