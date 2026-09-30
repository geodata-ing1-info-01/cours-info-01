# Étude — TD 5, facultatif : « une vidéo, deux chemins » (cours 1)

Note de préparation. Elle répond à une question : peut-on faire produire aux
étudiants une courte vidéo animée du trajet gare → école, une fois en cliquant
et une fois en ligne de commande, dans le temps d'une séance ? Réponse courte :
oui pour le chemin en ligne de commande, qui est écrit et testé ; le chemin
« clic » demande de choisir entre deux options décrites plus bas.

Supports : diapositives « Mode graphique et mode texte », « Ce que “facile à
utiliser” veut dire » et le TD 5, « Une vidéo, deux chemins ».
Scripts et données : [`data/cours1/1j_trajet/`](../../../data/cours1/1j_trajet/).

## Ce que le TD doit montrer

Le fichier est l'unité d'échange entre les logiciels. Dans les deux chemins, les
mêmes objets circulent : un fond de carte, une liste d'étapes, des textes, une
vidéo. Ce qui change est qui les transporte, et ce qu'il en reste.

L'argument n'est pas que la ligne de commande est meilleure. Il est que la
deuxième exécution ne coûte rien d'un côté et tout de l'autre. C'est
exactement la ligne « Trace laissée » du tableau de la diapositive UX.

## Chemin en ligne de commande

Vérifié de bout en bout sur un poste Linux avec l'environnement `base`
(ffmpeg 9.0.1, ImageMagick 7.1.2). Quatre étapes, chacune produisant le fichier
que la suivante consomme :

| Étape | Outil | Entrée | Sortie |
|-------|-------|--------|--------|
| fond de carte | `carte.py` (tuiles OSM + `magick montage`) | une emprise géographique | `carte.png`, 932×666 |
| tracé | `magick -draw line` | `carte.png` + `etapes.csv` | `etape_01.png` … `etape_05.png` |
| commentaires | `printf` | `etapes.csv` | `trajet.srt` |
| montage | `ffmpeg -f concat` + filtre `subtitles` | les images + le `.srt` | `trajet.mp4`, 25 s |

Les cinq étapes se lisent dans `etapes.csv` : durée, point d'arrivée en pixels,
texte affiché. Le chemin déjà parcouru reste tracé en bleu, l'étape en cours
est en orange.

### Rien à installer

`ffmpeg` et `imagemagick` sont déjà dans `environment.yml`, donc dans l'env
`base` que les étudiants créent plus tôt dans la même séance. Aucune
installation supplémentaire n'est nécessaire, ce qui est la raison principale
de retenir ces deux outils plutôt que d'autres.

> **Contrainte d'ordre.** Le TD suppose donc l'environnement
> installé. Dans le déroulé actuel, l'installation conda arrive **après** le
> bloc interfaces. Deux sorties possibles : faire le TD en
> démonstration au vidéoprojecteur au moment des interfaces et la rejouer en
> autonomie après l'installation, ou déplacer le bloc interfaces après
> l'installation. À trancher au moment de figer le minutage.

Si un poste n'a pas l'environnement : `winget install Gyan.FFmpeg` et
`winget install ImageMagick.ImageMagick` sous Windows, `brew install ffmpeg
imagemagick` sous macOS. Les binaires statiques de ffmpeg fonctionnent aussi
sans droits administrateur, mais le TD ne doit pas dépendre de ce
plan de secours en séance.

### Données à préparer

1. **Le fond de carte.** `python carte.py` assemble les tuiles et incruste la
   mention « © les contributeurs d'OpenStreetMap » exigée par la licence ODbL.
   À lancer **une seule fois** et à distribuer : les conditions d'usage du
   serveur de tuiles interdisent qu'une promotion entière le sollicite en même
   temps.
2. **Les coordonnées des étapes**, en pixels de cette image. Elles sont dans
   `etapes.csv` pour la Cité Descartes ; elles sont à refaire si l'emprise
   change.
3. **Les textes**, cinq phrases courtes. Les laisser à écrire aux étudiants
   rend le TD moins mécanique.

### Variante avec illustration

Ajouter à droite de la carte une photo de fin de tronçon se fait en une
commande de plus, avant le montage :

```bash
magick etape_03.png photo_03.jpg +append etape_03_illustree.png
```

Cela suppose de photographier le trajet en amont. Utile si le TD
devient un exercice complémentaire, superflu pour la démonstration en séance.

## Chemin « clic »

Aucun outil unique ne couvre la chaîne complète en mode graphique. Deux
options, selon ce que l'on veut montrer.

### Option A — un seul outil en ligne, pour la comparaison rapide

[MapRecap](https://maprecap.com/) trace un itinéraire sur un fond de carte et
exporte un MP4. Gratuit, sans compte, sans filigrane, et le rendu se fait dans
le navigateur. C'est le contre-exemple le plus économe en temps : cinq minutes
suffisent.

Ce que l'on y perd, et qui est justement le propos : aucun fichier
intermédiaire n'apparaît, le trajet n'est pas réutilisable ailleurs, et rien
ne se rejoue. L'outil fait une chose, bien, et rien d'autre.

### Option B — une chaîne d'applications, pour montrer les échanges de fichiers

Plus lente (trente minutes environ) mais fidèle à ce que la diapositive
annonce, puisqu'un fichier passe visiblement d'une application à la suivante :

| Étape | Application | Fichier produit |
|-------|-------------|-----------------|
| tracer le trajet | [uMap](https://umap.openstreetmap.fr/) (sans compte) | `trajet.geojson` |
| capturer le fond | export image d'[openstreetmap.org](https://www.openstreetmap.org/) | `carte.png` |
| annoter les tronçons | GIMP ou Photopea | `etape_*.png` |
| monter et sous-titrer | Clipchamp (fourni avec Windows 11), CapCut, Kdenlive ou Shotcut | `trajet.mp4` |

uMap exporte en GeoJSON, GPX, KML et CSV, mais **pas** en image : la capture du
fond passe par le panneau de partage d'openstreetmap.org, qui exporte en PNG,
JPEG, SVG et PDF.

`carte.py` sait relire le GeoJSON exporté d'uMap et le convertir en
`etapes.csv` :

```bash
python carte.py trajet.geojson
```

C'est le meilleur moment du TD : le trajet dessiné à la souris
devient l'entrée du script. Les deux chemins ne sont pas deux mondes, ils
partagent leurs fichiers.

## Recommandation

Faire l'**option A** en séance : elle tient en cinq minutes, et le contraste
avec `trajet` porte tout de suite. Garder l'**option B** en exercice
complémentaire pour les étudiants rapides, avec le passage GeoJSON → `etapes.csv`
comme point d'arrivée.

Répartir la salle en deux moitiés fonctionne aussi, à condition que chacune
montre son résultat : c'est la mise en commun qui fait la leçon, pas le
TD lui-même.

## Ce que ce TD n'est pas

Le projet de la séance 4 construit un studio d'automatisation avec ImageMagick et ffmpeg pilotés
depuis Python. Ici, on ne programme pas : on lance un script fourni. La
frontière doit rester nette, sinon le cours 1 déborde sur la programmation
qu'il annonce ne pas traiter.

## Sources

- Conditions d'usage des tuiles OpenStreetMap :
  <https://operations.osmfoundation.org/policies/tiles/>
- Export de données uMap :
  <https://wiki.openstreetmap.org/wiki/FR:UMap/Guide/Exporter_les_donn%C3%A9es_de_ma_uMap>
- Clipchamp, préinstallé avec Windows 11 :
  <https://support.microsoft.com/fr-fr/clipchamp>
