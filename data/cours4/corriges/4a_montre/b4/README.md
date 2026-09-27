# Montre

Fabrique l'image de la montre du Lapin blanc à une heure donnée, une série d'images minute par minute, ou une vidéo : Python place les aiguilles, ImageMagick dessine, ffmpeg assemble.

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

## Utilisation

Dans le dossier du projet, l'environnement `animation` activé.

**Une image** :

```
python montre.py --heure 10:05
```

écrit `sortie/montre_1005.png`.

**Une série d'images** :

```
python montre.py --heure 10:00 --minutes 120
```

écrit `sortie/images/img_0001.png` … `img_0120.png`, une image par minute.

**Une vidéo** :

```
python montre.py --heure 10:00 --minutes 120 --video --cadence 12 --nettoyer
```

écrit `sortie/montre.mp4` ; `--nettoyer` supprime ensuite `sortie/images/`.

`python montre.py --help` affiche toutes les options.

## Auteur

(Votre nom.)
