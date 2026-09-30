# Publier une version — TD 2e, cours 2

Questions 26 et 27 du TP. On fusionne `develop` dans `master` et on tague la
version obtenue.

Ce TD n'a pas de fichier de départ : on travaille dans le projet créé au
TD 2a, `../2a_premier_depot/travail/projet_2`.

## Déroulé

```bash
git checkout master
git merge develop
git tag -a v1.0 -m "première version de la calculatrice"
```

## Vérifier

```bash
git llog     # master et develop sur le même commit, avec l'étiquette à côté
git tag      # v1.0
python src/main.py
```

C'est la règle de la diapositive « Bonnes pratiques » : `master` ne reçoit
que des versions complètes, et le tag donne à chacune un nom lisible.
