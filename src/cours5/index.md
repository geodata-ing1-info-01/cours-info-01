---
title: "Séance 5 — Matériel, réseau, mots de passe, clés SSH et secrets"
---

## Contenu de la séance

Quatre parties. Les deux premières donnent les ordres de grandeur du matériel
et du réseau. Les deux suivantes partent du mot de passe, des façons de le
perdre et des parades, jusqu'à la clé SSH et aux secrets d'un programme. Le
compte GitHub et la clé SSH déclarée sur ce compte sont mis en place au
cours 6.

```{list-table}
:header-rows: 1

* - Partie
  - Ce qu'on y voit
  - Durée
* - [Le matériel](notebook/01_materiel.md)
  - composants, tailles et temps d'accès, trente ans d'évolution, puissance et consommation, coût des services en ligne
  - 30 min
* - [Le réseau](notebook/02_reseau.md)
  - local et distant, client et serveur, débit et latence, le sans-fil ; TD 5a
  - 30 min
* - [Prouver qui l'on est](notebook/03_prouver_qui_lon_est.md)
  - le mot de passe, les quatre façons de le perdre, les parades, le deuxième facteur, la clé SSH
  - 20 min
* - [Les secrets de vos programmes](notebook/04_secrets.md)
  - ce qui ne va pas dans un dépôt, et quoi faire si c'est arrivé
  - 15 min
```

Le TD 5b, facultatif, rejoue sur un dépôt neuf ce que la partie 4 montre : un
secret supprimé reste dans l'historique.

Les TD sont réunis, par partie, dans [Travaux dirigés de la séance
5](notebook/travaux_diriges.md).

## Avant la séance

Les fichiers des TD sont dans l'archive `cours5/` remise avec la séance : un
dossier par TD, et dans chacun la feuille du TD en PDF. L'archive se récupère
depuis le dossier partagé, comme décrit dans [Récupérer les fichiers d'une
séance](../avant/donnees.md).

## Vers le cours 6

Au cours 6, chacun crée son compte GitHub, avec un deuxième facteur, et y
déclare une clé SSH, avant de publier son dépôt.

```{list-table}
:header-rows: 1

* - Vu pendant la séance
  - Au cours 6
* - la clé à la place du mot de passe
  - une clé SSH créée sur le poste et déclarée sur le compte GitHub ;
    `git clone`, `git push`, `git pull` sans mot de passe
* - le deuxième facteur
  - activé à la création du compte GitHub
* - le secret dans un fichier ignoré
  - le `.gitignore` du dépôt de chacun
* - le commit en local, le push sur le réseau
  - travailler à plusieurs sur le même dépôt : branches, fusion
```

```{toctree}
:maxdepth: 1

notebook/01_materiel
notebook/02_reseau
notebook/03_prouver_qui_lon_est
notebook/04_secrets
notebook/travaux_diriges
```
