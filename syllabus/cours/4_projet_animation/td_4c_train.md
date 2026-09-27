# TD 4c — La fenêtre du train (document de conception)

> 25/09/2026. Troisième TD au choix de la séance 4, à côté de la montre (4a) et du tourbillon (4b), sur les mêmes étapes. Suite au projet 7 : [variante train](../7_projet_effets/variante_train.md).

## Origine

La scène de la mer du clip « Moon (and it went like) » de Kid Francescoli (album *Play Me Again*, 2017), réalisé par le collectif Cauboyz. Le clip n'est pas une animation dessinée : c'est un travelling filmé sur une table ronde qui tourne, la caméra sur l'axe central, avec des décors en carton découpé, en aplats de couleur (Manifesto XXI ; Clique.tv).

Ce qu'on voit sur quatre captures de la scène de jour (5:0x, 5:10, 5:20) :

| Élément | Mouvement |
|---|---|
| ciel, nuages, mer, horizon | fixes : peints sur le fond |
| voiles | 225 pixels en 10 s vers la droite, toutes à la même vitesse (image de 880 pixels de large) : une voile traverse la vitre en une quarantaine de secondes |
| plage jaune, plage orange | plus rapides que les voiles ; pas mesurables sur les captures |
| ombres verticales | passent en quelques images, à des positions sans rapport d'une capture à l'autre |

Sources : [Manifesto XXI](https://www.manifesto-21.com/kid-francescoli-fait-tourner-play-me-again-le-plus-hip-pop-de-ses-albums/), [Clique.tv](https://www.clique.tv/kid-francescoli-moon/), [vidéo officielle](https://www.youtube.com/watch?v=fdixQDPA2h0).

## Ce que le TD fait

Chaque image de la vidéo superpose trois images, par une seule commande `magick` :

```text
magick fond.png ( plan.png -roll -D+0 -crop 640x480+0+0 +repage ) -composite fenetre.png -composite img_0001.png
```

- `fond.png`, 640 × 480 : le ciel, les nuages, la mer ; fixe.
- `plan.png`, bande de 1 920 × 480, transparente hors des voiles et de la plage jaune ; tournée de `D` colonnes vers la gauche, puis coupée à 640 pixels : le paysage défile vers la gauche (vers la droite dans le clip ; changé le 27/09/2026, pour que le décalage soit la colonne où commence l'emprise).
- `fenetre.png`, 640 × 480 : noire, vitre transparente (coins arrondis) ; fixe, par-dessus.

Python calcule `D` pour chaque image : `decalages(nombre, vitesse)` renvoie `[0, 8, 16, …]`. C'est le pendant de `angles` (4b) et de l'heure (4a).

`-roll` revient lui-même au début de la bande (`-2000` donne la même image que `-80` sur 1 920 pixels) : pas de modulo à écrire en Python. Le modulo vient au TD 7 (effet `poteaux`).

Un seul plan mobile au TD 4 ; le second plan (la plage orange) et les ombres des poteaux sont les deux effets du TD 7.

## Étapes

> 27/09/2026 : la partie B du TD 4c ne suit plus le plan commun. B1 le fond sur `master` ; B2 branche `fenetre` (1 commit) ; B3 branche `plan` (plan sur le fond, `--decalage`, `-roll` : 3 commits) ; B4 fusion de `fenetre` (avance rapide) puis de `plan`, conflit dans `image`, résolu à la main ; B5 série ; B6 vidéo ; B7 README ; B8 facultatif ; 13 commits. Annexe du guide : plusieurs plans (voiles 2, plage jaune 8, plage orange 16 pixels par image), base du TD 7. Code dans `generer_corriges.py` (`version_train`, `rejouer_train`). Le tableau ci-dessous décrit l'ancien plan.


Identiques à 4a et 4b ; seuls le programme, les données et les options changent.

| Étape | 4b tourbillon | 4c train |
|---|---|---|
| A | `tourbillon.ipynb` | `train.ipynb` : la composition sans code (schémas : emprise, débordement, cylindre), outils, fond, plan découpé (`-crop`), plan tourné (`-roll`), plan sur le fond (`-composite`), fenêtre, décalages, vidéo ; la commande `magick` construite par morceaux (`arguments_fond`, `arguments_plan`, `arguments_fenetre`), sans fonction `lancer` |
| B0 | copier `vague.jpg` | copier le dossier `decor/` (`cp -r`) |
| B1 | `--angle 90` | `--decalage 200`, et `--decor` (défaut `decor`) |
| B2 | `--maximum 360` | `--images 120` ; `VITESSE = 8` en constante, comme `PAS` |
| B3 | `--video --cadence --nettoyer` | identique ; `nettoyer` ne supprime que `sortie/images/` |
| B4, B5 | README, paquet | identiques ; B5 : `train --decor train/decor --decalage 200` |

Vitesse : 8 pixels par image à 12 images par seconde, pour que le mouvement se voie dans une vidéo de 10 s. La vitesse du clip correspond à `VITESSE = 1` ; le notebook le propose dans « À essayer ».

Pas de texte sur les images (le cadre de la fenêtre occupe le bas) : pas de police.

## Fichiers

| Fichier | Rôle |
|---|---|
| `data/cours4/make_data.py` | `decor_train` dessine les quatre images (polygones de couleur unie, coordonnées écrites à la main) ; `build` remplit `4c_train/produit/depart/` ; `illustrations` fait les vignettes `train_1…5.jpg` |
| `data/cours4/generer_corriges.py` | les morceaux du programme `train.py` (dictionnaire `F`) ; `corriges/4c_train/b1…b3`, `b5/src/` |
| `data/cours4/generer_guides.py` | l'entrée `4c_train` de `TDS` ; trois textes propres au tourbillon rendus paramétrables (`cp_extra`, `ls_extra`, `copie`) |
| `data/cours4/4c_train/` | `README.md`, `depart/environment.yml`, `depart/modeles/` |
| `data/cours4/corriges/4c_train/b4/README.md`, `b5/README.md`, `b5/pyproject.toml` | écrits à la main |
| `src/cours4/notebook/td/4c_train/` | le notebook `depart/notebook/train.md`, le guide `guide.md` (produit), les illustrations du guide |
| `src/cours4/diapo/schemas.typ` | `programme-train` ; `schema_programme.typ` accepte `td=train` |
| `src/cours4/diapo/tds/4c_train.typ` | la feuille résumée `td_4c_train.pdf` |

Testé le 25/09 : les trois corrigés et toutes les commandes de vérification du guide ; le notebook exécuté (120 images, `train.mp4`) ; guide compilé (22 pages) ; guides 4a et 4b inchangés.

## Reste à faire

1. `cours4.typ` : annoncer le troisième choix (tableau « 4a / 4b » de la présentation, `sommaire-td`, `include "tds/4c_train.typ"`).
2. B5 non testé (`pip install -e .`) ; même `pyproject.toml` que 4b, au nom près.
3. En salle : durée de la série (120 appels à `magick` sur une bande de 1 920 pixels), lecture du `.mp4`.
4. Une variante de nuit (la mer, la lune et son reflet, montagnes en bleu) : même programme, un autre dossier `decor/` ; le reflet qui scintille demande un calcul par image, donc plutôt au TD 7.
