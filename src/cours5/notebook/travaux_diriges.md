---
title: Travaux dirigés de la séance 5
subtitle: Les deux TD de la séance, rangés par partie
---

Chaque TD a son dossier dans l'archive `cours5/` de la séance, avec sa
feuille en PDF, `td_<dossier>.pdf`. Le TD 5a se fait en séance, après la
partie sur le réseau, en 15 minutes. Le TD 5b est facultatif, pour qui va plus
vite ou pour après la séance. La clé SSH et l'accès à GitHub sont vus au
cours 6. Les commandes se tapent dans l'invite de commandes d'Anaconda.

## Le matériel et le réseau

- TD 5a, `5a_mesures/`, 15 minutes : les ordres de grandeur du poste ([page
  du matériel](01_materiel.md), [page du réseau](02_reseau.md)).

Le TD se fait en deux étapes. La première lit les caractéristiques du poste
dans le gestionnaire des tâches, ouvert par `Ctrl` + `Maj` + `Échap`, onglet
Performance. On y relève le nombre de cœurs et la vitesse de base du
processeur, la taille de la mémoire, le type (SSD ou HDD) et la capacité du
disque, et la vitesse du lien réseau. Si le gestionnaire des tâches ne
s'ouvre pas, la commande `systeminfo` donne le processeur et la mémoire.

La seconde étape lance le script fourni, depuis le dossier
`cours5/5a_mesures/` :

```text
python mesures.py
```

Le script chronomètre, dans l'ordre : 10 millions d'additions en Python, la
copie de 100 Mo en mémoire, l'écriture puis la relecture de 100 Mo sur le
disque, un aller-retour vers `github.com`, et le téléchargement de 10 Mo.
Chaque mesure est faite trois fois, et le script garde le meilleur temps,
mesuré avec `time.perf_counter()` avant et après l'opération. Le fichier
temporaire de 100 Mo est supprimé à la fin. Sa sortie sur le poste de
préparation, sous Linux, en septembre 2026 :

```text
processeur   10 millions d'additions      394.1 ms   soit     39 ns par addition
mémoire      copier 100 Mo                 73.9 ms   soit    1.4 Go/s
disque       écrire 100 Mo               1117.1 ms   soit     90 Mo/s
disque       relire 100 Mo                 76.1 ms   soit   1314 Mo/s
réseau       un aller-retour               22.0 ms   vers github.com
réseau       télécharger 10 Mo            194.1 ms   soit    412 Mbit/s
```

Sur les postes de la salle, les valeurs sont différentes, et les rapports
entre elles semblables. La relecture est plus rapide que l'écriture parce
que le système garde en mémoire vive une copie de ce qu'il vient d'écrire. Si
le réseau ne répond pas, le script l'écrit et s'arrête après les mesures
locales.

## Les secrets de vos programmes

- TD 5b, facultatif, `5b_secret_historique/`, 10 minutes : un secret dans
  l'historique ([page de la partie](04_secrets.md)).

Le dossier ne contient pas de fichier fourni : le dépôt se crée dans
`travail/`, que `git init` fabrique. La première étape committe une clé
inventée, puis supprime le fichier dans un second commit :

```text
git init travail
cd travail
echo CLE_API = "d7f3a9c1e5b24086" > config.py
git add config.py
git commit -m "Premier script de carte"
git rm config.py
git commit -m "Supprime la clé du dépôt"
git log -p -- config.py
```

`config.py` n'est plus dans le dossier, et `git log -p` affiche pourtant la
ligne `+CLE_API = "d7f3a9c1e5b24086"` du premier commit. Toute personne qui
clone le dépôt reçoit les deux commits, et la clé avec.

La deuxième étape tient le secret à l'écart, avec un modèle et une règle
d'exclusion écrite avant `git add .` :

```text
echo CLE_API = "à remplir" > config.example.py
echo config.py > .gitignore
echo CLE_API = "d7f3a9c1e5b24086" > config.py
git add .
git status
git commit -m "Modèle de configuration, secret ignoré"
git check-ignore -v config.py
```

`git status` liste `config.example.py` et `.gitignore`, sans `config.py`.
`git check-ignore -v` affiche la règle qui exclut le fichier, et sa ligne :
`.gitignore:1:config.py`.

La première clé reste dans les deux premiers commits. La feuille du TD recrée
le dépôt en dernière étape, sans le commit fautif. Une vraie clé poussée sur
une forge est d'abord révoquée sur le service qui l'a émise.
