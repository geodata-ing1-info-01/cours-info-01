# Créer et résoudre un conflit — TD 2d, cours 2

Questions 21 à 25 du TP. Deux branches modifient la même partie de
`src/main.py`, de deux façons. Le second merge s'arrête sur un conflit, que
l'on résout.

| Dossier | Ce qu'il contient |
|---|---|
| `depart/` | les deux versions de la boucle de saisie |

On travaille dans le projet créé au TD 2a,
`../2a_premier_depot/travail/projet_2`.

| Fichier | Question | Branche | Comment il lit l'opération |
|---|---|---|---|
| `main_regex.py` | 21 | `main_code` | une expression régulière trouve le motif dans la ligne tapée |
| `main_operations.py` | 23 | `main_code_bis` | la chaîne est découpée, et les deux morceaux vérifiés avec `isnumeric()` |

Les deux versions modifient les mêmes lignes du fichier : c'est la cause du
conflit de la question 24.

## Déroulé

```bash
# 21. la première version, sur main_code ; on ne la fusionne pas
git checkout main_code
#    copier main_regex.py dans src/main.py
git commit -am "lecture de l'opération avec une regex"

# 22 et 23. la seconde version, sur une branche partie de develop
git checkout develop
git checkout -b main_code_bis
#    copier main_operations.py dans src/main.py
git commit -am "lecture de l'opération par découpage"

# 24. le second merge s'arrête
git checkout develop
git merge main_code_bis     # celui-ci passe
git merge main_code         # celui-ci s'arrête

# 25. choisir, puis reprendre
#    éditer src/main.py, enlever les marqueurs
git add src/main.py
git merge --continue
#    git ouvre vim avec le message de fusion : taper :wq puis Entrée
```

## Les marqueurs

git écrit dans le fichier les deux versions, séparées par trois marqueurs :

```
<<<<<<< HEAD
    (la version déjà dans develop)
=======
    (la version qui arrive)
>>>>>>> main_code
```

Ce sont des lignes de texte ordinaires ; laissées dans le fichier, elles
provoquent une `SyntaxError`. Supprimer les trois, puis lancer
`python src/main.py` avant de poursuivre le merge.

## Corrections par rapport au sujet d'origine

Le sujet livré appelle une fonction `sub()` qui ne figure pas dans la liste
des fonctions à écrire (question 15) : `add(x, sub(y))` devient ici
`add(x, neg(y))`, `neg` étant la fonction qui renvoie l'opposé. Sans cela, la
soustraction lève un `NameError`.

Le motif de l'expression régulière est aussi écrit en chaîne brute,
`r"\d+…"` : sans le `r`, Python signale `\d` comme une séquence d'échappement
inconnue.
