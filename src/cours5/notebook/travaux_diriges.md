---
title: Travaux dirigés de la séance 5
subtitle: Les trois TD de la séance, rangés par partie
---

Chaque TD a son dossier dans l'archive `cours5/` de la séance, avec sa
feuille en PDF, `td_<dossier>.pdf`. Deux TD se font en séance, 35 minutes en
tout : le TD 5a après la partie sur le réseau, le TD 5b après la partie sur
les mots de passe et les clés. Le TD 5c est facultatif, pour qui va plus vite
ou pour après la séance. Les commandes se tapent dans l'invite de commandes d'Anaconda.

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

## Prouver qui l'on est

- TD 5b, `5b_cle_ssh/`, 20 minutes : une clé SSH sur votre compte GitHub
  ([page de la partie](03_prouver_qui_lon_est.md)).

Le TD demande un compte GitHub, créé avant la séance, avec l'adresse de
l'école. Il se fait en trois étapes.

La première crée la paire de clés. On répond par Entrée à chacune des trois
questions : l'emplacement proposé, `C:\Users\<vous>\.ssh\id_ed25519`, puis
une phrase de passe vide, deux fois. Si `ssh-keygen` demande
`Overwrite (y/n)?`, une paire existe déjà : on répond `n` et on la garde.

```text
ssh-keygen -t ed25519 -C "prenom.nom@etu.ecole.fr"
```

La deuxième affiche la clé publique, pour la copier :

```text
type %USERPROFILE%\.ssh\id_ed25519.pub
```

On copie la ligne entière, de `ssh-ed25519` jusqu'à l'adresse. Sur
github.com, le chemin est : photo de profil, Settings, SSH and GPG keys, New
SSH key. On y remplit Title, par exemple « poste école », et Key, avec la
ligne copiée, puis on valide par Add SSH key. GitHub peut demander le mot de
passe ou le deuxième facteur à cette étape.

:::{warning}
Seul le fichier qui se termine par `.pub` se copie. Coller le contenu de
`id_ed25519`, sans extension, fait passer la clé privée par le
presse-papier ; GitHub la rejette. La ligne collée commence par
`ssh-ed25519`.
:::

La troisième étape vérifie la connexion :

```text
ssh -T git@github.com
```

```{list-table}
:header-rows: 1

* - Ce qui s'affiche
  - Ce que cela veut dire
* - `Are you sure you want to continue connecting`
  - première connexion : `ssh` affiche l'empreinte du serveur ; on répond
    `yes` une fois
* - `Hi <compte>! You've successfully authenticated`
  - la clé est reconnue
* - `Permission denied (publickey)`
  - la clé publique n'est pas sur le compte, ou la ligne collée n'est pas la
    bonne
* - rien, puis `Connection timed out`
  - le port 22 est fermé en sortie
* - `'ssh-keygen' n'est pas reconnu`
  - le client OpenSSH de Windows n'est pas dans le `PATH` ; il se trouve dans
    `C:\Windows\System32\OpenSSH\`, et Git Bash fournit aussi `ssh-keygen`
```

L'empreinte du serveur affichée à la première connexion est comparée à celle
que GitHub publie, page « GitHub's SSH key fingerprints » :
`SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU` pour la clé ED25519.
Elle est ensuite enregistrée dans `.ssh/known_hosts`.

Si le port 22 est fermé, GitHub accepte aussi SSH sur le port 443, le port du
web. Le fichier `config` du dossier du TD règle `ssh` pour ce port ; il se
copie dans `.ssh`, et la commande de vérification reste la même, comme tout
ce qui suit au cours 6 :

```text
copy config %USERPROFILE%\.ssh\config
ssh -T git@github.com
```

Un TD 5b non terminé se termine avant le cours 6, avec la feuille du TD : le
cours 6 commence par `git clone`, qui demande la clé.

## Les secrets de vos programmes

- TD 5c, facultatif, `5c_secret_historique/`, 10 minutes : un secret dans
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
