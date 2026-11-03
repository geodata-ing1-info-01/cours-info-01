---
title: Introduction
subtitle: Objectif, contenu et organisation du module
---

## Objectif du module

Plusieurs cours de votre formation de 1re année demandent d'installer des logiciels pour lancer un code. Cela demande de savoir faire les tâches suivantes, et d'être à l'aise avec elles :

  * lancer un script ou un programme en ligne de commande dans un terminal ;
  * manipuler les fichiers (au format texte ou binaire) en entrée et en sortie de ces programmes ;
  * ouvrir un projet de code dans un éditeur de code, ou dans un notebook (JupyterLab) pour un projet Python, et savoir utiliser et configurer ces outils :

     * dépanner leurs problèmes de configuration sur les PC de l'école ;
     * créer un environnement de développement et y installer des paquets.

Il vous sera aussi demandé, en cours ou pour des projets, de programmer vous-mêmes des scripts et de les livrer à un commanditaire ou à un enseignant. Certains projets se font en équipe. Cela requiert de connaître quelques bonnes pratiques :

   * être capable d'écrire un code qui n'est pas spécifique à votre machine (pas de chemins de fichier spécifiques) ;
   * savoir documenter et structurer votre projet, et créer les fichiers utiles pour que votre code s'installe et s'exécute facilement sur une autre machine ;
   * être capable de versionner et de partager votre code pour y travailler à plusieurs.

Les mêmes opérations reviennent dans tous les cours où l'informatique sert d'outil de travail. Ces cours supposent ces opérations acquises, mais aucun ne les enseigne en soi.

Ce module INFO-01 a pour objectif principal de vous les apprendre, pour que vous arriviez dans les cours de programmation et dans les TD qui emploient Python sans perdre de temps sur l'outillage.

## Contenu du module

Le module couvre quatre domaines.

Les outils de la programmation
: D'abord l'édition de texte et une connaissance basique des terminaux (ligne de commande). Écrire du code demande un éditeur de code ;
  le module montre ce qui le distingue d'un traitement de texte, et ce que
  cela change pour les fichiers qu'on écrit.

L'organisation d'un projet
: Structurer un projet pour qu'une autre personne puisse le reprendre : un
  `README` qui le présente, un fichier qui décrit son environnement pour
  l'installer sur une autre machine, la manipulation des fichiers avec les
  bibliothèques Python prévues pour cela, et un outil en ligne de commande
  dont les paramètres se passent en argument, sans modifier le code.

Le versionnement avec git
: Une initiation : enregistrer l'état de son travail, revenir à une
  version antérieure, et travailler à plusieurs sur les mêmes fichiers. Git
  est introduit à la séance 2, puis repris dans les séances suivantes sur
  des exercices courts.

Des notions générales d'informatique
: Les ordres de grandeur (mémoire, temps de calcul, débit réseau) et la
  sécurité (clés, secrets, ce qu'on ne publie pas). Ces notions sont
  réparties au fil des séances, et expliquent pourquoi une façon de faire
  est plus rapide ou plus sûre qu'une autre.

## Hors du module

L'algorithmique n'est pas traitée ici. Écrire un algorithme, choisir une
structure de données et raisonner sur la complexité relèvent du cours de
programmation, qui a lieu en parallèle. Le tableau donne des exemples de
questions, et le cours qui les traite.

```{list-table}
:header-rows: 1

* - Question
  - Traitée ici
  - Traitée ailleurs
* - Quel algorithme résout ce problème ?
  -
  - cours de programmation
* - Où mettre ce fichier, et sous quel nom ?
  - oui
  -
* - Comment écrire cette boucle ?
  -
  - cours de programmation
* - Comment lancer ce script sur une autre machine ?
  - oui
  -
* - Comment retrouver la version qui fonctionnait ?
  - oui
  -
```

Les deux cours se complètent : le cours de programmation porte sur le code
lui-même, ce module sur les fichiers, les outils et l'environnement qui le
font fonctionner.

## Organisation

Le module compte sept séances de deux heures. Chaque séance alterne des
explications courtes et des TD faits sur machine. Les séances 4 et 7 sont
des projets, qui se terminent par un livrable.

```{list-table}
:header-rows: 1

* - Séance
  - Sujet
  - Type
* - 1
  - Logiciel, programmation et formats de fichier
  - cours
* - 2
  - Ligne de commande et git local
  - cours
* - 3
  - Chemins, fichiers et ligne de commande, en Python
  - cours
* - 4
  - Une animation, du notebook au programme
  - projet
* - 5
  - Matériel, réseau, mots de passe, clés SSH et secrets
  - cours
* - 6
  - La forge, sur le dépôt du projet 4
  - cours
* - 7
  - Un effet pour l'animation
  - projet
```

Certains exemples viennent de la géomatique (des coordonnées, une
distance). Aucun ne suppose une notion qui n'a pas encore été vue.

## Compétences visées

À la fin du module, vous savez :

- lancer un programme et agir sur des fichiers dans un terminal ;
- reconnaître ce que contient un fichier, indépendamment de son extension ;
- ouvrir un projet dans un éditeur de code et vous y retrouver ;
- installer un environnement Python, et le décrire pour qu'une autre personne
  l'installe ;
- enregistrer votre travail avec git, revenir à une version antérieure, et
  contribuer à un dépôt partagé ;
- écrire un script Python qui lit des fichiers et en produit d'autres, et
  qui fonctionne sur un autre poste que le vôtre ;
- écrire un script qui reçoit ses paramètres en ligne de commande.
