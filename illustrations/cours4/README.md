# Vignettes — Cours 4

Cinq images de chaque vidéo des TD 4a (`montre_<n>.jpg`), 4b
(`tourbillon_<n>.jpg`) et 4c (`train_<n>.jpg`), réduites à 320 pixels de
large. Elles illustrent le schéma des étapes du programme, dans les
diapositives et dans le notebook de chaque TD (`src/cours4/diapo/schemas.typ`).

Les images `train_*.png` sont tirées du décor du TD 4c pour les schémas de la
composition d'une image (`src/cours4/diapo/schemas_train.typ`) : le fond, le
plan et la fenêtre sur un damier qui marque les pixels transparents, le plan
posé sur le fond, une image de la vidéo, et la bande enroulée sur un
cylindre.

Elles sont fabriquées en lançant le programme final de chaque TD (corrigé de
l'étape 3), et sont versionnées pour que les diapositives compilent sans
refaire les vidéos :

```bash
cd data/cours4
python make_data.py illustrations
```
