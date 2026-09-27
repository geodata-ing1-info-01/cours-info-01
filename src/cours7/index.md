---
title: "Séance 7 — Un effet pour l'animation"
---

:::{note} Page à rédiger
Le plan ci-dessous est celui du syllabus v1.5 (`syllabus/03_syllabus_v1_5.md`),
qui remplace depuis le 24/09/2026 le benchmark de conversion en gris du plan
initial. Le document de conception est
`syllabus/cours/7_projet_effets/contenu_detaille.md`. Les supports de la
séance sont à écrire.
:::

## Objectif

Ajouter une fonctionnalité au programme du projet 4 par une pull request, et
comparer une boucle Python et numpy sur les images de l'animation.

## Contenu prévu

- **Ajouter les paquets** : `numpy` et `pillow` dans l'environnement
  `animation`, et dans son `environment.yml`.
- **Un effet au choix**, sur une branche : une option `--effet` ajoutée au
  programme, qui applique l'effet à chaque image avant la vidéo. Quatre
  effets, du plus simple au plus long à écrire :

  ```{list-table}
  :header-rows: 1

  * - Effet
    - Calcul par pixel
  * - caméra thermique
    - le niveau de gris, puis une table de 256 couleurs, du bleu au rouge
  * - glitch
    - le canal rouge décalé de quelques pixels à droite, le bleu à gauche
  * - pixel art
    - l'image découpée en blocs, chaque bloc d'une seule couleur, puis peu
      de couleurs
  * - vieux film
    - sépia, bruit aléatoire, assombrissement vers les bords
  ```

  L'effet s'écrit d'abord en boucle sur les pixels, puis avec numpy. Les deux
  versions sont chronométrées sur toute la série d'images.
- **Vérifier** : un test qui compare les deux versions sur une petite image.
- **Pull request et revue** : la branche poussée, la pull request relue par un
  camarade qui a choisi un autre effet, puis fusionnée.
- **`RAPPORT.md`** : une image avant et après l'effet, le tableau des temps,
  une phrase d'interprétation.

:::{warning}
Point à décider : le parcours standard du projet 4 écrit `recette.py`, qui
ne produit pas d'images. L'effet ne s'applique donc qu'au parcours avancé
(`train.py`).
:::
