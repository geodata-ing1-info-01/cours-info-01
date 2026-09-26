---
title: ImageMagick et ffmpeg, depuis un notebook
subtitle: Appeler un programme qui n'est pas une bibliothèque Python
executer: false
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# ImageMagick et ffmpeg, depuis un notebook

Le projet `trajet` n'importe aucune bibliothèque : il appelle deux programmes,
`magick` et `ffmpeg`, comme on le ferait au terminal. Ce notebook montre les
commandes une à une, avec leur résultat, avant de les retrouver dans le code du
projet.

:::{warning}
Ce notebook ne tourne pas dans le navigateur. `subprocess` demande au système
de lancer un programme, et un navigateur n'en lance aucun : dans JupyterLite, la
cellule échouerait. Ouvrez-le dans VSCode ou dans JupyterLab, avec
l'environnement `trajet_ensg` actif.
:::

## Le chemin des données, à régler avant tout

```{code-cell} ipython3
from pathlib import Path

PROJET = Path("depart/trajet")

CARTE = PROJET / "data" / "carte.png"
SORTIE = Path("essai")
SORTIE.mkdir(exist_ok=True)

assert CARTE.is_file(), f"fond de carte introuvable : {CARTE.resolve()}"
CARTE.stat().st_size, "octets"
```

## Lancer un programme depuis Python

`subprocess.run` reçoit la commande sous forme de **liste** : un élément par
argument. C'est ce qui évite d'avoir à protéger les espaces d'un nom de
fichier, puisque rien n'est découpé.

```{code-cell} ipython3
import subprocess


def lancer(commande, dossier=None):
    """Lance la commande et rend sa sortie, en affichant ce qui a été tapé.

    `dossier` est le dossier de travail du programme lancé, celui depuis
    lequel il interprète les noms de fichiers qu'on lui donne.
    """
    print("$", " ".join(str(morceau) for morceau in commande))
    resultat = subprocess.run(commande, cwd=dossier,
                              capture_output=True, text=True, check=True)
    return resultat.stdout.strip()


lancer(["magick", "--version"]).splitlines()[0]
```

## ImageMagick : lire, redimensionner, dessiner

Une commande ImageMagick se lit de gauche à droite : l'image d'entrée, les
opérations dans l'ordre, l'image de sortie.

```{code-cell} ipython3
lancer(["magick", "identify", CARTE])
```

`-resize` réduit l'image. La largeur suivie de `x` laisse la hauteur se
calculer, ce qui garde les proportions.

```{code-cell} ipython3
from IPython.display import Image

apercu = SORTIE / "apercu.png"
lancer(["magick", CARTE, "-resize", "420x", apercu])
Image(apercu)
```

`-draw` prend une instruction de dessin en **un seul argument**, et `-stroke`,
`-strokewidth`, `-fill` règlent le trait pour tous les `-draw` qui suivent.
Les coordonnées sont des pixels comptés depuis le coin haut-gauche.

```{code-cell} ipython3
trace = SORTIE / "trace.png"
lancer([
    "magick", CARTE,
    "-fill", "none", "-stroke", "#d95f02", "-strokewidth", "9",
    "-draw", "line 398,248 410,360",
    "-draw", "line 410,360 600,372",
    "-resize", "420x", trace,
])
Image(trace)
```

C'est exactement ce que fait `trajet/images.py`, une instruction `-draw` par
segment du trajet.

## ffmpeg : inspecter, puis monter

`ffprobe`, livré avec ffmpeg, dit ce que contient un fichier vidéo sans le
lire en entier. `-of csv=p=0` demande la réponse nue, sans nom de champ.

```{code-cell} ipython3
video = PROJET / "trajet.mp4"
if video.is_file():
    print(lancer(["ffprobe", "-v", "error",
                  "-show_entries", "format=duration,size",
                  "-of", "csv=p=0", video]))
else:
    print(f"{video} n'existe pas encore : lancez `trajet` d'abord.")
```

Le montage lit une **liste de fichiers**, `montage.txt`, plutôt qu'une suite
d'images numérotées : chaque image y porte sa durée, ce qui permet de les faire
durer différemment.

```{code-cell} ipython3
liste = SORTIE / "montage.txt"
liste.write_text(
    "file 'apercu.png'\nduration 2\n"
    "file 'trace.png'\nduration 2\n"
    "file 'trace.png'\n",          # le dernier est répété, sinon ffmpeg le coupe
    encoding="utf-8",
)
print(liste.read_text(encoding="utf-8"))
```

```{code-cell} ipython3
essai = SORTIE / "essai.mp4"
lancer(["ffmpeg", "-y", "-loglevel", "error",
        "-f", "concat", "-safe", "0", "-i", liste.name,
        "-vf", "format=yuv420p", "-r", "25", essai.name],
       dossier=SORTIE)
print(lancer(["ffprobe", "-v", "error", "-show_entries", "format=duration",
              "-of", "csv=p=0", essai]), "secondes")
```

`-f concat` dit de lire une liste et non une vidéo, `-vf` applique un filtre,
ici la conversion des couleurs que tous les lecteurs acceptent, et `-r 25` fixe
le nombre d'images par seconde. La commande tourne dans le dossier de la liste,
grâce à `dossier=SORTIE` : les noms qu'elle contient restent donc nus, et il
n'y a aucun chemin à protéger. C'est ce que fait `trajet/montage.py`.

## Le projet, en une commande

```{code-cell} ipython3
print(lancer(["trajet", "--carte", str(CARTE), "--sortie", str(SORTIE)]))
```

Sans `--carte`, la commande irait chercher `data/carte.png` dans le dossier du
projet installé. On le lui désigne ici parce que le notebook n'est pas lancé
depuis ce dossier : `trajet --help` liste les trois chemins qu'elle accepte.

:::{admonition} À faire
Ouvrez `essai/trajet.srt` et `essai/montage.txt` dans l'éditeur : deux fichiers
texte, écrits par un programme et lus par un autre. Puis changez un texte dans
`depart/trajet/data/etapes.csv` et relancez la cellule ci-dessus.
:::
