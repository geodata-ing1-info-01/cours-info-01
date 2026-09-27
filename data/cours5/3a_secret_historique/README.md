# Un secret dans l'historique — TD 3a, cours 5, facultatif

Committer une fausse clé, la supprimer, constater qu'elle est toujours dans le
dépôt, puis l'en tenir à l'écart. Aucun fichier fourni : le dépôt se crée dans
`travail/`, que `git init` fabrique.

## Committer, supprimer, relire

Depuis `cours5/3a_secret_historique/`, dans l'invite de commandes d'Anaconda :

```bash
git init travail
cd travail
echo CLE_API = "d7f3a9c1e5b24086" > config.py
git add config.py
git commit -m "Premier script de carte"
git rm config.py
git commit -m "Supprime la clé du dépôt"
git log -p -- config.py
```

`config.py` n'est plus dans le dossier ; `git log -p` affiche pourtant la
ligne `+CLE_API = "d7f3a9c1e5b24086"` du premier commit. Toute personne qui
clone le dépôt reçoit les deux commits, et la clé avec.

## Tenir le secret à l'écart

```bash
echo CLE_API = "à remplir" > config.example.py
echo config.py > .gitignore
echo CLE_API = "d7f3a9c1e5b24086" > config.py
git add .
git status
git commit -m "Modèle de configuration, secret ignoré"
git check-ignore -v config.py
```

`git status` liste `config.example.py` et `.gitignore` ; `config.py` n'y est pas ;
`git check-ignore -v` nomme la règle qui l'exclut, `.gitignore:1:config.py`.

## Sortir la clé de l'historique

Sur ce dépôt, la première clé reste dans les deux premiers commits. Sur un
petit projet, le plus simple est de recréer le dépôt sans le commit fautif :

```bash
cd ..
rmdir /s /q travail\.git
cd travail
git init
git add .
git commit -m "Script de carte, secret hors dépôt"
```

Réécrire l'historique en gardant le reste se fait avec `git filter-repo` ;
ce n'est pas au programme. Dans tous les cas, une vraie clé qui a été poussée
sur une forge est d'abord révoquée sur le service qui l'a émise : l'historique
a déjà pu être copié.
