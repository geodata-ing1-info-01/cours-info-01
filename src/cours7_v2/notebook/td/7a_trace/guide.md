---
title: "TD 7a — Une pull request sur son dépôt GitHub"
subtitle: Présentation, énoncé et solutions
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

<!-- [[[cog td = donnees("cours7_v2/make_data.py")]]] -->
<!-- [[[end]]] -->

Ce guide a quatre parties. La présentation décrit le programme à compléter, les deux
dépôts du TD et leurs adresses. L'énoncé donne, pour chaque étape, l'objectif, les
consignes et le test de fin d'étape. Le dépannage donne la cause et la solution des
messages d'erreur du premier push. Les solutions donnent le code de l'étape 3,
expliquent ce que font les commandes git, et donnent ce que le TD fait constater.

Le code de ce guide se copie depuis `guide_7a_trace.html`, ouvert dans un navigateur,
ou depuis `guide.ipynb`, ouvert dans JupyterLab. Copié depuis le PDF, il perd ses
indentations.

# Présentation du TD

## Objectif du TD

### Le programme

Le TD part de `stats_trace.py`, le programme de la fin du TD 4a. Il lit une trace GPS
dans un fichier CSV, puis affiche ses altitudes extrêmes, son dénivelé cumulé et, avec
les options `--distance` et `--vitesse`, la distance parcourue et la vitesse moyenne.

Le TD lui ajoute l'option `--profil`, qui écrit le profil de la trace dans
`profil.csv` : à chaque position, la distance parcourue depuis le départ, puis
l'altitude. À la fin du TD, le programme affiche :

<!-- [[[cog td.sortie("3.2", "trace.csv", "--profil")]]] -->
```text
$ python stats_trace.py trace.csv --profil
altitude minimale : 78.8 m
altitude maximale : 129.5 m
max - min : 50.7 m
cumul en hausse : 98.4 m
cumul en baisse : 50.3 m
profil : profil.csv, 60 positions
```
<!-- [[[end]]] -->

et `profil.csv` commence et finit ainsi :

<!-- [[[cog td.texte(td.module.profil("3.2", "trace.csv", "--profil"))]]] -->
```text
distance,altitude
0.0,79.6
18.8,78.8
63.4,79.9
…
1866.5,128.4
1906.7,127.7
```
<!-- [[[end]]] -->

La dernière distance est la distance parcourue, calculée au TD 4a. Dans un tableur, un
graphique en nuage de points sur les deux colonnes donne la courbe de l'altitude selon
la distance.

Le travail sur le code est court. Le TD porte surtout sur GitHub : copier un dépôt,
le cloner, envoyer une branche, puis la fusionner par une pull request.

### Les deux dépôts du TD

Le module publie un **dépôt modèle**, `td7a-trace`, sur son compte GitHub,
`geodata-ing1-info-01`. Un dépôt modèle se copie sur son propre compte par le bouton
« Use this template » de sa page. À l'étape 1, chacun crée ainsi son dépôt
`td7a-trace`, sur son compte : tout le TD se fait dans ce dépôt.

| Dépôt | Adresse |
|---|---|
| modèle du module, à ouvrir dans le navigateur | `https://github.com/geodata-ing1-info-01/td7a-trace` |
| votre dépôt, dans le navigateur | `https://github.com/<compte>/td7a-trace` |
| votre dépôt, pour `git clone` | `https://github.com/<compte>/td7a-trace.git` |

Dans ce guide, `<compte>` désigne le nom de votre compte GitHub, à mettre à la place
de `<compte>` partout où il apparaît. Les exemples emploient le compte `alice-martin`.

Toutes les adresses commencent par `https://`. GitHub donne aussi des adresses en
`git@github.com:…`, sous l'onglet SSH du bouton Code. Elles passent par le port 22,
que le pare-feu de l'école ferme : dans la salle, `git clone` et `git push` échouent
avec ces adresses.

## Les étapes

Le TD dure 85 minutes. Il compte un seul push et une seule pull request. L'étape 6,
facultative, ajoute un second push.

| Énoncé | Objectif | Commits | Push | Solution |
|-----|----------------------|----|----|----|
| [Étape 1](#étape-1-copie-du-dépôt-modèle) | copier le dépôt modèle sur son compte GitHub | 0 | 0 | |
| [Étape 2](#étape-2-clone-du-dépôt) | cloner son dépôt en HTTPS, puis lancer le programme | 0 | 0 | [2](#solution-de-létape-2) |
| [Étape 3](#étape-3-branche-profil) | ajouter l'option `--profil`, sur une branche | 2 | 0 | [3](#solution-de-létape-3) |
| [Étape 4](#étape-4-premier-push) | créer un token, puis envoyer la branche sur GitHub | 0 | 1 | [4](#solution-de-létape-4) |
| [Étape 5](#étape-5-pull-request-et-fusion) | fusionner la branche par une pull request | 0 | 0 | [5](#solution-de-létape-5) |
| [Étape 6](#étape-6-facultative-readme-et-second-push) (facultative) | décrire l'option dans le README, puis l'envoyer | 1 | 1 | [6](#solution-de-létape-6) |

### Compte GitHub

1. Créer son compte GitHub avant la séance, hors du réseau de l'école (fin du cours 5).
2. Garder près de soi le téléphone qui donne les codes du deuxième facteur.

### Les notions employées

| Notion | Vue au | Employée aux étapes |
|---|---|---|
| un dépôt sur GitHub, `git clone` | cours 6 | 1 et 2 |
| une branche, un commit | cours 2 | 3 |
| une liste de tuples, une fonction, une option `argparse` | TD 4a | 3 |
| l'écriture d'un fichier texte | cours 3 | 3 |
| un token d'accès | cours 6 | 4 |
| une pull request, `git pull` | cours 6 | 5 |

# Énoncé

## Étape 1 · Copie du dépôt modèle

> **Objectif :** créer sur son compte GitHub le dépôt `td7a-trace`, copie du dépôt modèle du module.

![La page du dépôt modèle : le bouton « Use this template »](illustrations/modele.png)

**Consignes**

1. Se connecter à GitHub, puis ouvrir `https://github.com/geodata-ing1-info-01/td7a-trace`.
2. Cliquer sur « Use this template » (repère 1), puis sur « Create a new repository ».
3. Dans le formulaire : Owner, son compte ; Repository name, `td7a-trace` ; laisser
   « Public » coché.
4. Cliquer sur « Create repository ».

**Test**

La page de son dépôt s'ouvre, à l'adresse `github.com/<compte>/td7a-trace`. Elle
affiche les cinq fichiers du dépôt modèle et un seul commit, « Initial commit ».

## Étape 2 · Clone du dépôt

> **Objectif :** copier son dépôt dans `cours7/7a_trace/travail/`, avec son adresse HTTPS, puis lancer le programme dans VS Code.

### Étape 2 · Clone en HTTPS

![La page de son dépôt : le bouton Code et l'adresse HTTPS](illustrations/clone_https.png)

**Consignes**

1. Copier l'archive `info01-cours7.zip` de `formationTemp` dans le dossier `info01` du
   Bureau.
2. Ouvrir Git Bash depuis le menu Démarrer.
3. Aller dans le dossier `~/Desktop/info01`, puis décompresser l'archive :

   ```text
   cd ~/Desktop/info01
   unzip info01-cours7.zip
   ```

4. Aller dans le dossier `travail` du TD :

   ```text
   cd cours7/7a_trace/travail
   ```

5. Sur la page de son dépôt, cliquer sur Code (repère 1), choisir l'onglet HTTPS, puis
   copier l'adresse avec le bouton à droite de l'adresse (repère 2).
6. Taper `git clone `, puis coller l'adresse, avec un clic droit, Paste, ou avec
   Maj + Inser, puis Entrée. Pour le compte `alice-martin` :

   ```text
   git clone https://github.com/alice-martin/td7a-trace.git
   ```

**Test**

Git affiche `Clonage dans 'td7a-trace'...`, puis quelques lignes `remote:`, et le
dossier `travail/td7a-trace/` contient les fichiers du dépôt.

Si `git clone` affiche `Repository not found`, `<compte>` n'a pas été remplacé ou le
nom du dépôt diffère : comparer l'adresse à celle de la barre d'adresse du navigateur.

### Étape 2 · Projet dans VS Code

**Consignes**

1. Ouvrir le dossier du clone dans VS Code : menu File, Open Folder…,
   `Desktop\info01\cours7\7a_trace\travail\td7a-trace`.
2. Ouvrir un terminal (menu Terminal, New Terminal), puis indiquer son identité pour ce
   dépôt :

   ```text
   git config user.name "Prénom Nom"
   git config user.email prenom.nom@ensg.eu
   ```

3. Lancer le programme :

   ```text
   python stats_trace.py trace.csv --distance
   ```

**Test**

<!-- [[[cog td.sortie("depart", "trace.csv", "--distance")]]] -->
```text
$ python stats_trace.py trace.csv --distance
altitude minimale : 78.8 m
altitude maximale : 129.5 m
max - min : 50.7 m
cumul en hausse : 98.4 m
cumul en baisse : 50.3 m
distance parcourue : 1906.7 m
```
<!-- [[[end]]] -->

Solution : [étape 2](#solution-de-létape-2).

## Étape 3 · Branche profil

> **Objectif :** sur une branche `profil`, ajouter l'option `--profil`, qui écrit `profil.csv`, en deux commits : l'option, puis le calcul.

L'étape suit l'ordre du TD 4a : d'abord l'option, avec un message à la place du
calcul, puis le calcul.

### Étape 3 · Option --profil

**Consignes**

1. Créer la branche et y passer : `git checkout -b profil`.
2. Sous la déclaration de l'option `--vitesse`, déclarer l'option `--profil`, avec le
   texte d'aide `écrit le profil altimétrique dans profil.csv`.
3. Dans la boucle de lecture, ajouter `or options.profil` à la condition
   `if options.distance or options.vitesse:` : le profil a besoin des positions.
4. À la fin du fichier, ajouter le bloc `if options.profil:`, qui affiche
   `profil : calcul manquant`.
5. Enregistrer le fichier, puis lancer `python stats_trace.py trace.csv --profil`.

**Test**

La sortie se termine par `profil : calcul manquant`.

**Commit**

```text
git add stats_trace.py
git commit -m "L'option --profil"
```

### Étape 3 · Écriture du profil

**Consignes**

1. Sous la fonction `distance_parcourue`, écrire la fonction `profil(points)`. Elle
   renvoie la liste des tuples `(distance cumulée, altitude)`, un par position, en
   partant du tuple `(0, altitude de la position 0)`.
2. Dans le bloc `if options.profil:`, remplacer le message par l'écriture du fichier
   `profil.csv` : la ligne `distance,altitude`, puis une ligne par tuple, la distance
   avec un chiffre après la virgule.
3. Afficher `profil : profil.csv, `, suivi du nombre de positions.
4. Ajouter une ligne `profil.csv` à la fin de `.gitignore` : le fichier est refait à
   chaque lancement.
5. Enregistrer les fichiers, lancer `python stats_trace.py trace.csv --profil`, puis
   ouvrir `profil.csv` dans VS Code.

**Test**

La sortie se termine par `profil : profil.csv, 60 positions`, et `profil.csv` commence
par `0.0,79.6` et finit par `1906.7,127.7`.

**Commit**

```text
git add stats_trace.py .gitignore
git commit -m "Le profil altimétrique"
```

`git log --oneline` affiche trois commits : les deux de la branche, puis « Initial
commit ».

Solution : [étape 3](#solution-de-létape-3).

## Étape 4 · Premier push

> **Objectif :** créer un token, puis envoyer la branche `profil` sur GitHub, en donnant le token quand Git le demande.

Le premier push vers GitHub demande de s'identifier. GitHub n'accepte pas le mot de
passe du compte pour `git push` : il demande un **token**, une chaîne qu'il génère, à
coller à la place du mot de passe (cours 6, « Accès à GitHub par token »).

Selon le choix de l'enseignant, Git demande le token dans la fenêtre de Git
Credential Manager, le gestionnaire d'identifiants installé avec Git for Windows, ou
par deux questions posées dans la fenêtre Git Bash, Git Credential Manager retiré du
dépôt.

### Étape 4 · Création du token

![Le formulaire du token, puis le token généré](illustrations/token.png)

1. Ouvrir le formulaire : menu du compte (en haut à droite), Settings, Developer
   settings (en bas de la liste de gauche), Personal access tokens, Tokens (classic),
   puis Generate new token (classic). GitHub peut redemander le code du deuxième
   facteur.
2. Note : `td7a` (repère 1). Expiration : 7 days (repère 2). Cocher `repo` (repère 3).
3. Cliquer sur « Generate token » (repère 4), en bas de la page.
4. Copier le token avec le bouton à sa droite (repère 5), puis le coller dans un
   nouveau fichier de Notepad++, sans l'enregistrer. GitHub ne l'affiche qu'une fois.

### Étape 4 · Push par la fenêtre de connexion

Git Credential Manager garde le token dans le Gestionnaire d'identification de
Windows, pour le compte Windows ouvert. Si un autre compte GitHub a déjà poussé depuis
le poste, son identifiant y est resté : Git Credential Manager le donnerait à GitHub
sans rien demander, et le push échouerait (`Permission … denied to …`). Avant le
push, supprimer cet identifiant (consignes 1 à 3).

![Le Gestionnaire d'identification de Windows : l'identifiant de GitHub](illustrations/gestionnaire.png)

1. Ouvrir le Gestionnaire d'identification : menu Démarrer, taper
   « Gestionnaire d'identification », puis Entrée.
2. Cliquer sur « Informations d'identification Windows ».
3. Sous « Informations d'identification génériques », chercher `git:https://github.com`.
   S'il existe, le déplier, puis cliquer sur « Supprimer » (repère 1).
4. Dans le terminal de VS Code, envoyer la branche :

   ```text
   git push -u origin profil
   ```

   La fenêtre « Connect to GitHub » s'ouvre. Si elle n'apparaît pas, la chercher dans
   la barre des tâches : elle peut s'ouvrir derrière VS Code.
5. Dans cette fenêtre, cliquer sur l'onglet Token (repère 1 de l'image ci-dessous).
6. Coller le token dans le champ (repère 2), avec Ctrl + V.
7. Cliquer sur « Sign in » (repère 3).

![La fenêtre de Git Credential Manager, onglet Token](illustrations/connexion_token.png)

Aux pushs suivants, Git ne demande plus rien : Windows a gardé le token.

### Étape 4 · Push par le terminal

La fenêtre Git Bash est nécessaire : dans le terminal de VS Code, VS Code prend à son
compte les questions de Git, et les affiche dans une boîte en haut de sa fenêtre, ou
propose une connexion à GitHub. Avec Git Credential Manager, Git ne pose pas ces
questions : Git Credential Manager ouvre sa propre fenêtre, même depuis le terminal de
VS Code.

1. Si la fenêtre Git Bash de l'étape 2 est fermée, en ouvrir une depuis le menu
   Démarrer. Dans cette fenêtre, aller dans le dossier du clone :

   ```text
   cd ~/Desktop/info01/cours7/7a_trace/travail/td7a-trace
   ```

2. Retirer Git Credential Manager de ce dépôt :

   ```text
   git config credential.helper ""
   ```

   Sans `--global`, la commande ne vaut que pour ce dépôt. Git pose alors ses
   questions dans le terminal, et ne garde pas le token.
3. Envoyer la branche : `git push -u origin profil`. Git affiche
   `Username for 'https://github.com':`.
4. Taper le nom de son compte GitHub, puis Entrée. Le nom du compte figure dans
   l'adresse de son dépôt, `github.com/<compte>/td7a-trace`, et en haut du menu de
   l'icône du compte, en haut à droite de GitHub. GitHub ne le vérifie pas : seul le
   token compte. Git affiche ensuite `Password for 'https://<compte>@github.com':`.
5. Coller le token avec Maj + Inser, ou par un clic droit puis Paste, puis taper
   Entrée. Rien ne s'affiche pendant la saisie, ni le token ni des étoiles. Ctrl + V
   peut ne pas coller dans Git Bash.

```text
$ git push -u origin profil
Username for 'https://github.com': alice-martin
Password for 'https://alice-martin@github.com':
```

Git repose les deux questions à chaque push : garder ouvert le fichier de Notepad++ où
le token est collé, jusqu'à la fin du TD.

### Test

```text
…
remote: Create a pull request for 'profil' on GitHub by visiting:
remote:      https://github.com/alice-martin/td7a-trace/pull/new/profil
To https://github.com/alice-martin/td7a-trace.git
 * [new branch]      profil -> profil
la branche 'profil' est paramétrée pour suivre 'origin/profil'.
```

Les lignes `remote:` viennent de GitHub.

Si un message d'erreur s'affiche, la partie [Dépannage du premier push](#dépannage-du-premier-push) donne sa cause et sa solution.

Solution : [étape 4](#solution-de-létape-4).

## Étape 5 · Pull request et fusion

> **Objectif :** fusionner la branche `profil` dans `master` sur GitHub, par une pull request, puis ramener la fusion sur le poste.

![Le bandeau de la page du dépôt, puis la page de la pull request](illustrations/pull_request.png)

**Consignes**

1. Ouvrir la page de son dépôt. Dans le bandeau qui signale le push de `profil`,
   cliquer sur « Compare & pull request » (repère 1), puis sur « Create pull request ».
2. Sur la page de la pull request, cliquer sur « Merge pull request » (repère 2), puis
   sur « Confirm merge » (repère 3).
3. Dans le terminal de VS Code, revenir sur `master`, puis ramener la fusion :

   ```text
   git checkout master
   git pull
   ```

4. Afficher le graphe du dépôt : `git log --oneline --graph`.

**Test**

`git pull` affiche `Fast-forward`, puis les deux fichiers modifiés, et le graphe montre
le commit de fusion écrit par GitHub :

```text
*   f58602e Merge pull request #1 from alice-martin/profil
|\
| * fa52c72 Le profil altimétrique
| * f3484f4 L'option --profil
|/
* 88b09fe Initial commit
```

Les identifiants des commits diffèrent d'un dépôt à l'autre.

Solution : [étape 5](#solution-de-létape-5).

## Étape 6 (facultative) · README et second push

> **Objectif :** ajouter l'option `--profil` au tableau des options de `README.md`, sur `master`, puis envoyer ce commit sur GitHub.

**Consignes**

1. Dans `README.md`, ajouter au tableau des options la ligne
   ``| `--profil` | écrit le profil altimétrique dans profil.csv |``.
2. Faire le commit :

   ```text
   git add README.md
   git commit -m "L'option --profil dans le README"
   ```

3. Envoyer le commit : `git push`, dans le terminal du premier push. Si Git demande le
   compte et le token, les donner comme à l'étape 4.
4. Sur la page de son dépôt, vérifier que le README affiche la nouvelle ligne.

**Test**

Le README de la page du dépôt affiche la ligne de `--profil`.

Solution : [étape 6](#solution-de-létape-6).

## Fin du TD · Suppression du token

> **Objectif :** retirer le token du poste et de GitHub, pour que l'élève suivant ne puisse pas s'en servir.

1. Dans le Gestionnaire d'identification, Informations d'identification Windows :
   supprimer `git:https://github.com` s'il existe.
2. Sur GitHub, dans Settings, Developer settings, Personal access tokens, Tokens
   (classic) : cliquer sur « Delete » à côté du token `td7a`, puis confirmer.
3. Fermer, sans l'enregistrer, le fichier de Notepad++ où le token a été collé.

# Dépannage du premier push

## Messages d'erreur au push

| Message | Cause | Solution |
|---|---|---|
| `remote: Invalid username or token. Password authentication is not supported for Git operations.`, puis `fatal: Échec d'authentification pour 'https://github.com/…'` | le mot de passe du compte GitHub a été saisi à la place du token, ou le token est mal collé, ou expiré | relancer `git push -u origin profil`, puis coller le token ; sinon, créer un autre token |
| `remote: Support for password authentication was removed on August 13, 2021.` | le mot de passe du compte GitHub a été saisi à la place du token (message plus ancien de GitHub) | relancer `git push -u origin profil`, puis coller le token |
| `remote: Permission to alice-martin/td7a-trace.git denied to bob-durand.`, puis `The requested URL returned error: 403` | Windows a gardé l'identifiant d'un autre compte (push par la fenêtre de connexion) | supprimer `git:https://github.com` du Gestionnaire d'identification, puis relancer le push |
| `remote: Permission to alice-martin/td7a-trace.git denied to alice-martin.`, puis `The requested URL returned error: 403` | le token n'a pas le droit `repo` | créer un autre token, `repo` coché |
| `remote: Permission to geodata-ing1-info-01/td7a-trace.git denied to alice-martin.`, puis `The requested URL returned error: 403` | le clone a été fait avec l'adresse du dépôt modèle du module | `git remote set-url origin https://github.com/<compte>/td7a-trace.git`, puis relancer le push |
| une boîte en haut de VS Code demande `Username`, ou VS Code propose de se connecter à GitHub | le push par le terminal a été lancé dans le terminal de VS Code | fermer la boîte, puis relancer le push dans la fenêtre Git Bash |
| `remote: Repository not found.` | l'adresse du dépôt est fausse | `git remote -v` affiche l'adresse ; la corriger avec `git remote set-url origin https://github.com/<compte>/td7a-trace.git` |
| `ssh: connect to host github.com port 22` | le clone a été fait avec une adresse en `git@github.com:` | `git remote set-url origin https://github.com/<compte>/td7a-trace.git`, puis relancer le push |
| la commande attend, sans fenêtre ni question | la fenêtre de connexion s'est ouverte derrière VS Code | la chercher dans la barre des tâches ; sinon, voir la connexion par le navigateur, ci-dessous |

## Secours · Connexion par le navigateur

Si le push échoue avec le token, Git Credential Manager, l'outil de Git for Windows qui
ouvre la fenêtre « Connect to GitHub », peut aussi connecter Git à GitHub par le
navigateur, sans token.

![La fenêtre de Git Credential Manager : la connexion par le navigateur](illustrations/connexion_navigateur.png)

1. Si le push s'est fait par le terminal, rendre la main à Git Credential Manager,
   dans le dossier du clone : `git config --unset credential.helper`.
2. Supprimer `git:https://github.com` du Gestionnaire d'identification, puis relancer
   `git push -u origin profil`.
3. Dans la fenêtre « Connect to GitHub », onglet Browser/Device (repère 1), cliquer
   sur « Sign in with your browser » (repère 2).
4. Dans le navigateur, se connecter à son compte si GitHub le demande, puis cliquer sur
   « Authorize git-ecosystem ».
5. Revenir au terminal : le push se termine.

Si le navigateur est déjà connecté au compte d'un autre élève, s'en déconnecter d'abord
sur github.com, puis relancer le push.

Si aucune fenêtre ne s'ouvre, lancer `git config --get credential.helper` dans le
dossier du clone : la commande doit afficher `manager`. Sinon, appeler l'enseignant.

# Solutions

## Solution de l'étape 2

Le clone d'un dépôt public ne demande pas de s'identifier. GitHub demande de
s'identifier au premier push, à l'étape 4.

## Solution de l'étape 3

Les blocs de modification ont le format du TD 4a. Les lignes en vert, entre deux lignes
`+++`, sont à ajouter. Les lignes en rouge, entre deux lignes `---`, sont à supprimer.
Le nombre en tête d'une ligne est son numéro dans VS Code, quand les modifications sont
faites de haut en bas.

**Commit « L'option --profil ».**

**Déclaration de l'option.** `--profil` se déclare comme `--distance` et `--vitesse`, avec
`action="store_true"` : l'option ne prend pas de valeur.

**Condition de la boucle de lecture.** La boucle de lecture ne garde les positions que si une
option en a besoin. Le profil en a besoin, comme la distance et la vitesse :

<!-- [[[cog td.modif("3.1")]]] -->
```modif
   40 analyseur.add_argument("--vitesse", action="store_true",
   41                        help="affiche la vitesse moyenne")
+++
analyseur.add_argument("--profil", action="store_true",
                       help="écrit le profil altimétrique dans profil.csv")
+++
   44 options = analyseur.parse_args()
   45
    …
   55         x, y, ele, time = ligne.strip().split(",")
   56         altitudes.append(float(ele))
---
   57         if options.distance or options.vitesse:
---
+++
        if options.distance or options.vitesse or options.profil:
+++
   58             points.append((float(x), float(y), float(ele)))
   59             temps.append(time)
    …
   90     vitesse = distance / temps_total
   91     print(f"vitesse moyenne : {vitesse:.2f} m/s, soit {vitesse * 3.6:.1f} km/h")
+++

if options.profil:
    print("profil : calcul manquant")
+++
```
<!-- [[[end]]] -->

**Commit « Le profil altimétrique ».**

**Écriture de la fonction.** La fonction reprend la boucle de `distance_parcourue`. Elle
ajoute à la liste, après chaque segment, le total parcouru et l'altitude de la
position atteinte. `points[i][2]` désigne la troisième valeur du tuple, l'altitude. Le
premier tuple, `(0, points[0][2])`, est celui du départ.

**Écriture du fichier.** Le mode `"w"` vide le fichier, puis écrit (cours 3). La première
ligne donne le nom des colonnes ; `\n` termine chaque ligne. `for distance_cumulee,
altitude in lignes:` sépare les deux valeurs de chaque tuple.

<!-- [[[cog td.modif("3.2")]]] -->
```modif
   23         total = total + segment
   24     return total
+++


def profil(points):
    """La distance cumulée et l'altitude de chaque position, en mètres."""
    total = 0
    lignes = [(total, points[0][2])]
    for i in range(1, len(points)):
        total = total + distance_entre(points[i - 1], points[i])
        lignes.append((total, points[i][2]))
    return lignes
+++
   35
   36
    …
  102
  103 if options.profil:
---
  104     print("profil : calcul manquant")
---
+++
    lignes = profil(points)
    with open("profil.csv", "w", encoding="utf-8") as fichier_profil:
        fichier_profil.write("distance,altitude\n")
        for distance_cumulee, altitude in lignes:
            fichier_profil.write(f"{distance_cumulee:.1f},{altitude}\n")
    print(f"profil : profil.csv, {len(lignes)} positions")
+++
```
<!-- [[[end]]] -->

**Ligne de `.gitignore`.** Avec la ligne `profil.csv` dans `.gitignore`, `git status`
ne liste plus le fichier, et `git add .` ne l'ajoute pas. Le programme refait le
fichier à chaque lancement.


## Solution de l'étape 4

`git push -u origin profil` envoie la branche `profil` au dépôt `origin`, l'adresse
HTTPS de son dépôt GitHub, enregistrée par `git clone`. `-u` relie la branche locale à
la branche de GitHub : les `git push` et `git pull` suivants, sur cette branche, n'ont
plus besoin de nommer `origin` ni `profil`.

GitHub vérifie le token, puis ses droits : `repo` permet d'écrire dans ses dépôts. Le
nom du compte donné avec le token ne sert pas à la vérification.

Par la fenêtre de connexion, Git Credential Manager garde ensuite le compte et le
token dans le Gestionnaire d'identification de Windows, sous le nom
`git:https://github.com`, d'où l'absence de question au push suivant. Il faut donc
supprimer le token à la fin du TD.

Par le terminal, `git config credential.helper ""` a vidé, pour ce dépôt, la liste des
gestionnaires d'identifiants que Git consulte. Git pose donc ses questions lui-même, à
chaque push, et ne garde rien sur le poste.

## Solution de l'étape 5

La pull request propose de fusionner `profil` dans `master`. « Merge pull request »
fait la fusion sur GitHub, avec un commit de fusion à deux parents, écrit par GitHub,
comme `git merge` au cours 2.

Le `master` du poste ne contient pas encore ce commit. `git pull` le ramène : comme
`master` n'a pas changé sur le poste depuis le clone, git avance simplement la branche
jusqu'au commit de fusion, d'où `Fast-forward`.

## Solution de l'étape 6

Après un premier push par la fenêtre de connexion, Git ne demande rien. Après un
premier push par le terminal, Git repose les deux questions. La
[solution de l'étape 4](#solution-de-létape-4) en donne la raison.
