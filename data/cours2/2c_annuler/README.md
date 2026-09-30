# Annuler et remettre à jour — TD 2c, cours 2

Questions 18 à 20 du TP. On simule une fausse manœuvre, on la défait, puis on
remet une branche à jour.

Ce TD n'a pas de fichier de départ : on travaille dans le projet créé au
TD 2a, `../2a_premier_depot/travail/projet_2`.

## Déroulé

```bash
# 18. la fausse manœuvre : on vide les deux fichiers, et on l'enregistre
git add src/
git commit -m "suppression accidentelle du code"

# 19. repérer le commit fautif, puis l'annuler
git log --oneline
git revert <identifiant du commit>
#    git ouvre vim avec le message du commit : taper :wq puis Entrée

# 20. un commit sur main_code, puis la remettre à jour sur develop
git checkout main_code
#    ajouter en première ligne de src/main.py :
#    # Point d'entrée de la calculatrice : affiche le titre.
git commit -am "commentaire en tête de main.py"
git llog --all
git rebase develop
git llog --all
```

## Ce qu'il faut avoir constaté

Le commit créé par `git revert` a son propre identifiant. Il est ajouté au
bout de l'historique, et le contenu du projet redevient celui d'avant la
suppression. Aucun commit n'est effacé.

Le `rebase` refait le commit du commentaire au bout de `develop`. Son parent
change, et donc son identifiant : `git llog --all`, avant et après, le
montre. Le commit du commentaire est nécessaire : sans lui, `main_code` ne
contiendrait que des commits déjà dans `develop`, et le rebase ne ferait
qu'avancer la branche, sans rien refaire. Une branche que quelqu'un d'autre a
déjà récupérée ne se rebase pas ; le cours 6 y revient.
