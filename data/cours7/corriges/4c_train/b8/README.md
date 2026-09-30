# Train

Fait défiler un paysage derrière la fenêtre d'un train : une image, le paysage décalé d'un nombre de pixels donné ; une série d'images, le paysage un peu plus décalé à chaque image ; ou une vidéo. Python calcule les décalages, ImageMagick superpose le fond, le paysage et la fenêtre, ffmpeg assemble.

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

Dans n'importe quel dossier, l'environnement `animation` activé ; le décor est lu dans `decor/`, sous le dossier du terminal.

**Une image** :

```
train --decalage 200
```

écrit `sortie/train_0200.png`.

**Une série d'images** :

```
train --images 120
```

écrit `sortie/images/img_0001.png` … `img_0120.png`, le paysage décalé de 8 pixels de plus à chaque image.

**Une vidéo** :

```
train --images 120 --video --cadence 12 --nettoyer
```

écrit `sortie/train.mp4` ; `--nettoyer` supprime ensuite `sortie/images/`.

`--decor` donne un autre dossier de décor, par exemple
`train --decor train/decor --decalage 200` depuis le dossier qui contient le projet.
`train --help` affiche toutes les options.

## Auteur

(Votre nom.)
