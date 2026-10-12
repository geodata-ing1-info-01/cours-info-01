---
title: Les secrets de vos programmes
subtitle: Ce qui ne va pas dans un dépôt, et quoi faire si un secret y est arrivé
---

Un **jeton d'API**, *token* en anglais, est un mot de passe utilisé par un
programme. Il se perd des mêmes façons qu'un mot de passe, et aussi par le
dépôt git. Cette partie distingue ce qui est un secret de ce qui se partage,
montre qu'un secret committé reste dans l'historique, puis présente la façon
de séparer le code et les secrets, et ce qu'il faut faire quand un secret a
fui. Elle se termine par les mises à jour et les sauvegardes. Le TD 5b,
facultatif, l'accompagne ; il est présenté en fin de page.

## Ce qui est un secret

Un **secret** donne accès à quelque chose. Il ne va ni dans un dépôt, ni dans
un message, ni dans une capture d'écran.

```{list-table}
:header-rows: 1

* - À garder
  - Donne accès à
* - clé privée SSH
  - vos comptes, vos serveurs
* - mot de passe
  - un compte
* - jeton d'API (*token*)
  - un service payant ou limité, de cartographie ou d'IA
* - fichier `.env`, `config.py`
  - l'endroit où sont rangés les trois précédents
```

```{list-table}
:header-rows: 1

* - À partager
  - Pourquoi
* - clé publique SSH
  - elle ne sert à rien sans la clé privée
* - le code
  - le travail rendu
* - README, `environment.yml`
  - ils permettent de relancer le code
* - données publiques
  - orthophotos, BD TOPO
```

Un jeton d'API est une chaîne que le script envoie au service pour
s'identifier. Les documentations l'appellent *token*, ou « clé d'API ». Le
quota ou la facture est compté sur le compte du jeton. Les données
personnelles d'autres personnes, comme des noms ou des adresses, relèvent du
RGPD : elles ne vont jamais dans un dépôt public.

## Un secret dans un dépôt y reste

Le commit qui supprime un fichier ne supprime pas le commit qui l'a ajouté.
`git log -p` affiche les deux. La sortie suivante est réelle, abrégée : le
premier commit ajoute `config.py`, qui contient une clé d'API, et le second
supprime le fichier.

```text
> git log --oneline
b638a2d Supprime la clé du dépôt
9cb1911 Premier script de carte
> git log -p -- config.py
commit b638a2d  Supprime la clé du dépôt
    -CLE_API = "d7f3a9c1e5b24086"
commit 9cb1911  Premier script de carte
    +CLE_API = "d7f3a9c1e5b24086"
```

Des programmes lisent les commits publics en continu et testent les clés
trouvées : un secret poussé est copié avant d'être supprimé. En 2025,
28,65 millions de secrets ont été ajoutés dans des commits publics sur
GitHub, et 64 % des secrets trouvés en 2022 étaient encore valides en 2026
(GitGuardian, *State of Secrets Sprawl 2026*). Le TD 5b, facultatif, rejoue
cette sortie.

## Séparer le code et les secrets

Le code lit le secret dans un fichier que git ignore. Le dépôt contient un
modèle de ce fichier, sans la valeur.

Dans le dépôt, pour tout le monde :

```text
carte.py            import config
                    cle = config.CLE_API
config.example.py   CLE_API = "à remplir"
.gitignore          config.py
README.md
```

Sur votre poste seulement :

```text
config.py           CLE_API = "d7f3a9c1e5b24086"
```

Le fichier `.gitignore`, vu au cours 2, contient la ligne `config.py` : git
ignore ce fichier, et `git status` ne le liste jamais. La personne qui clone
le dépôt copie `config.example.py` en `config.py`, et y met sa propre clé. Un
fichier `.env` lu par le programme suit le même principe.

Avant de committer, on vérifie que `git status` ne liste pas le fichier du
secret. Les forges détectent une partie des jetons poussés ; on ne compte pas
sur cette détection.

## Si un secret a fui

Supprimer le fichier laisse le secret dans l'historique. Le secret est
d'abord rendu inutile, puis remplacé.

```{list-table}
:header-rows: 1

* - Étape
  - Ce qu'on fait
* - 1. Révoquer
  - régénérer la clé sur le service qui l'a émise
* - 2. Remplacer
  - mettre la nouvelle clé dans le fichier ignoré
* - 3. Nettoyer
  - réécrire l'historique, ou recréer le dépôt
* - 4. Prévenir
  - le responsable du projet ou du service
```

On révoque d'abord, parce que l'historique a peut-être déjà été copié.
L'historique se réécrit avec `git filter-repo`, hors programme ; sur un petit
projet, recréer le dépôt est plus simple. Un mot de passe personnel qui a fui
se change sur le site concerné, puis partout où il était réutilisé.

## Mises à jour et sauvegardes

Une **mise à jour** corrige une faille connue et publiée ; une faille publiée
est exploitée dans les jours qui suivent. Une **sauvegarde** permet de
retrouver ses fichiers après la perte, le vol ou le chiffrement d'un poste.

```{list-table}
:header-rows: 1

* -
  - Mises à jour
  - Sauvegardes
* - Quoi
  - système, navigateur, Anaconda, les applications du téléphone
  - ce qui ne se refait pas : documents, données, photos
* - Quand
  - dès qu'elles sont proposées
  - régulièrement, en automatique
* - Règle
  - redémarrer quand c'est demandé
  - 3-2-1 : trois copies, deux supports, une hors du poste
* - Pour le code
  - `conda update`, de temps en temps
  - un dépôt poussé sur la forge est une copie du code ; les données
    ignorées par git sont à sauvegarder à part
```

Pour un étudiant, la forge garde le code et le rapport. Les données lourdes,
ignorées par git, vont sur un disque externe ou sur l'espace de stockage de
l'école.

D'autres mesures de cybermalveillance.gouv.fr ne sont pas traitées dans la
séance : l'antivirus (celui de Windows convient), les applications des magasins
officiels, le Wi-Fi public, la séparation des usages personnels et
professionnels.

## TD de la partie

- TD 5b, facultatif, `cours5/5b_secret_historique/`, 10 minutes : committer
  une fausse clé, la supprimer, constater avec `git log -p` qu'elle est
  toujours dans le dépôt, puis la tenir à l'écart avec un modèle et un
  `.gitignore`.

Les TD des autres parties sont dans [Travaux dirigés de la séance
5](travaux_diriges.md).
