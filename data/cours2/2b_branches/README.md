# Branches et fusions — TD 2b, cours 2

Questions 6 à 17 du TP. On crée les branches du projet, on écrit le code sur
deux branches comme si deux personnes travaillaient en parallèle, puis on
fusionne tout dans `develop`.

| Dossier | Ce qu'il contient |
|---|---|
| `depart/` | `main_base.py`, à copier à la question 11 |

On travaille dans le projet créé au TD 2a,
`../2a_premier_depot/travail/projet_2`.

## Les branches, dans l'ordre

| Branche | Ouverte depuis | Ce qu'on y met |
|---|---|---|
| `develop` | `master` | rien directement |
| `documentation` | `develop` | la description du projet dans `README.md` |
| `main_code` | `develop` | `src/main.py`, l'affichage du titre |
| `operations` | `develop` | `src/operations.py`, les quatre fonctions |

La branche `operations` part de `develop`, qui ne contient pas encore
`src/main.py` : le dossier `src` n'existe pas sur cette branche, et il faut le
créer avant d'y écrire `operations.py` (question 14).

Le sujet d'origine demande d'ajouter le logo de l'école à la fin du
`README.md` ; l'archive ne fournit pas l'image. La question 7 fait écrire la
ligne Markdown de l'image, `![Logo de l'école](logo.png)`, qui montre la
syntaxe ; l'image ne s'affiche pas.

Les quatre fonctions de `operations.py` : `add(a,b)` renvoie la somme,
`mult(a,b)` le produit, `neg(a)` l'opposé, `inv(a)` l'inverse.

## Les deux fusions de la question 17

Le premier `merge` est une **avance rapide** (*fast-forward*) : `develop` n'a
pas de nouveau commit depuis la création de `main_code`, git déplace donc le
nom `develop` sur le dernier commit de `main_code`, sans créer de commit.

Le second crée un **commit de fusion**, parce que `develop` a reçu entre-temps
le premier merge. Git ouvre alors un éditeur dans le terminal, avec un message
de fusion déjà écrit. Si c'est `vim` : tapez `:wq` puis `Entrée` pour accepter
le message et quitter. Ne fermez pas le terminal.

Afficher `git llog` après chaque merge pour voir la différence.
