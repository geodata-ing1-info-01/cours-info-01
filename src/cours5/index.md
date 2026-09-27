---
title: "Séance 5 — Matériel, réseau, mots de passe, clés SSH et secrets"
---

## Contenu de la séance

Quatre parties. Les deux premières donnent les ordres de grandeur du matériel
et du réseau. Les deux suivantes partent du mot de passe, des façons de le
perdre et des parades, jusqu'à la clé SSH et aux secrets d'un programme, ce
qu'il faut avoir en place avant la forge du cours 6.

```{list-table}
:header-rows: 1

* - Partie
  - Ce qu'on y voit
  - Durée
* - [Le matériel](notebook/01_materiel.md)
  - composants, tailles et temps d'accès, trente ans d'évolution, puissance et consommation, coût des services en ligne
  - 30 min
* - [Le réseau](notebook/02_reseau.md)
  - local et distant, client et serveur, débit et latence, le sans-fil ; TD 1a
  - 30 min
* - [Prouver qui l'on est](notebook/03_prouver_qui_lon_est.md)
  - le mot de passe, les quatre façons de le perdre, les parades, le deuxième facteur, la clé SSH ; TD 2a
  - 40 min
* - [Les secrets de vos programmes](notebook/04_secrets.md)
  - ce qui ne va pas dans un dépôt, et quoi faire si c'est arrivé
  - 15 min
```

Le TD 3a, facultatif, rejoue sur un dépôt neuf ce que la partie 4 montre : un
secret supprimé reste dans l'historique.

Les TD sont réunis, par partie, dans [Travaux dirigés de la séance
5](notebook/travaux_diriges.md).

## Avant la séance

Les fichiers des TD sont dans l'archive `cours5/` remise avec la séance : un
dossier par TD, et dans chacun la feuille du TD en PDF. L'archive se récupère
depuis le dossier partagé, comme décrit dans [Récupérer les fichiers d'une
séance](../avant/donnees.md).

Le TD 2a demande un compte GitHub : le créer avant la séance, avec l'adresse
de l'école, et activer la double authentification quand GitHub la propose.
Le cours 6 commence par `git clone` et suppose la clé en place.

## Vers le cours 6

Le cours 6 utilise le compte, la clé et le deuxième facteur mis en place
pendant cette séance.

```{list-table}
:header-rows: 1

* - Fait pendant la séance
  - Au cours 6
* - un compte sur la forge
  - un dépôt distant pour chaque projet
* - une clé SSH sur ce compte
  - `git clone`, `git push`, `git pull` sans mot de passe
* - un deuxième facteur sur le compte
  - demandé par GitHub à la première connexion
* - le secret dans un fichier ignoré
  - le `.gitignore` du dépôt de chacun
* - le commit en local, le push sur le réseau
  - travailler à plusieurs sur le même dépôt : branches, fusion
```

Le cours 6 commence par `git clone` : la clé doit fonctionner avant la
séance. Un TD 2a non terminé se termine avant, avec la feuille du TD dans
`cours5/2a_cle_ssh/`.

```{toctree}
:maxdepth: 1

notebook/01_materiel
notebook/02_reseau
notebook/03_prouver_qui_lon_est
notebook/04_secrets
notebook/travaux_diriges
```
