# Un premier dépôt — TD 2a, cours 2

Questions 1 à 5 du TP. On configure l'affichage du graphe, on crée le dépôt,
et on y enregistre un premier état.

| Dossier | Ce qu'il contient |
|---|---|
| `travail/` | vide : c'est là que vous créez `projet_2` |

Le projet créé ici sert à toute la séance. Les TD 2b, 2c, 2d et 2e le
reprennent, chacun là où le précédent s'est arrêté : ne le supprimez pas entre
deux TD.

## Déroulé

```bash
# 1. l'alias qui affiche le graphe, enregistré dans la configuration globale
git config --global alias.llog 'log --graph --pretty=oneline --abbrev-commit --decorate'

# 2 et 3. le dossier du projet, et le dépôt
cd travail
mkdir projet_2
cd projet_2
git init

# 4 et 5. un fichier, puis un commit
#    créez README.md dans l'éditeur, écrivez-y une ligne
git add README.md
git commit -m "ajout du README"
```

## Vérifier

```bash
git status     # « rien à valider, la copie de travail est propre »
git llog       # un commit, et la branche courante à côté
```

Le fichier est demandé en markdown : il prend donc l'extension `.md`. Le sujet
d'origine écrit `README` sans extension.

## Erreur fréquente

`git init` lancé dans `travail/` au lieu de `projet_2`. Vérifier le dossier
courant avec `pwd` avant `git init`. Pour défaire : supprimer le dossier
`.git` créé au mauvais endroit.
