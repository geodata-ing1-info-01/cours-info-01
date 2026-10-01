---
title: Programmes, applications et outils
subtitle: Pourquoi la programmation commence par des fichiers et un éditeur
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

## Programmes et applications

Renommer trois cents photos selon leur date de prise de vue, calculer la
longueur d'un trajet à partir d'un relevé GPS, convertir cinquante tableurs en
un seul fichier : toutes ces tâches sont faisables à la main. Elles sont
longues, et une erreur de recopie y passe inaperçue.

Un programme fait la même chose plus vite, et surtout de la même façon à chaque
exécution. C'est cette régularité qui compte autant que la vitesse : le résultat
est reproductible, et l'erreur, quand il y en a une, est identique partout et
donc repérable.

Le mot *application* désigne un programme muni d'une interface destinée à un
utilisateur : un navigateur, un tableur, un logiciel de cartographie. Tous les
programmes n'en ont pas. Beaucoup de ceux que vous écrirez se lanceront depuis
un terminal, sans fenêtre.

## Écrire de nouveaux programmes

Pour les tâches courantes, un programme existe déjà. On programme quand aucun
outil ne fait exactement ce dont on a besoin, ou quand il faut enchaîner
plusieurs outils sans intervention manuelle entre chaque étape.

Fabriquer un programme demande à son tour des outils. Deux comptent dès
maintenant :

- un **éditeur de code**, où l'on écrit et modifie le texte du programme ;
- un outil de **versionnement**, git, qui enregistre les états successifs du
  travail et permet d'y revenir.

Ces deux outils sont l'objet des séances 1 et 2. Ils ne servent pas à écrire de
meilleurs algorithmes, mais à travailler sans perdre son travail ni son temps.

## Entrées, sorties et code source

Vu de loin, un programme reçoit des données, leur applique un traitement, et
produit un résultat.

```{raw} html
<svg viewBox="0 0 720 138" width="100%" style="max-width:720px;height:auto;display:block;margin:1.2rem auto;font-family:inherit" role="img">
  <defs><marker id="fl" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7"
     markerHeight="7" orient="auto-start-reverse">
     <path d="M0,0 L10,5 L0,10 z" fill="currentColor"/></marker></defs>
  <rect x="10" y="30" width="195" height="78" rx="6" fill="none"
     stroke="currentColor" stroke-width="1.5" opacity=".85"/>
  <text x="107.5" y="66" text-anchor="middle" fill="currentColor"
     font-size="14" font-weight="600" opacity="1">Des données</text>
  <text x="107.5" y="82" text-anchor="middle" fill="currentColor"
     font-size="12.5" font-weight="400" opacity=".75">en entrée</text>
  <line x1="215" y1="69" x2="258" y2="69" stroke="currentColor"
     stroke-width="1.5" marker-end="url(#fl)" opacity=".8"/>
  <rect x="268" y="30" width="195" height="78" rx="6" fill="rgba(31,111,139,.10)"
     stroke="currentColor" stroke-width="1.5" opacity=".85"/>
  <text x="365.5" y="66" text-anchor="middle" fill="currentColor"
     font-size="14" font-weight="600" opacity="1">Un programme</text>
  <text x="365.5" y="82" text-anchor="middle" fill="currentColor"
     font-size="12.5" font-weight="400" opacity=".75">une suite d'instructions</text>
  <line x1="473" y1="69" x2="516" y2="69" stroke="currentColor"
     stroke-width="1.5" marker-end="url(#fl)" opacity=".8"/>
  <rect x="526" y="30" width="184" height="78" rx="6" fill="none"
     stroke="currentColor" stroke-width="1.5" opacity=".85"/>
  <text x="618.0" y="66" text-anchor="middle" fill="currentColor"
     font-size="14" font-weight="600" opacity="1">Des données</text>
  <text x="618.0" y="82" text-anchor="middle" fill="currentColor"
     font-size="12.5" font-weight="400" opacity=".75">en sortie, ou une action</text>

</svg>
```

Les données d'entrée sont le plus souvent des fichiers : un relevé GPS, une
image, un tableau de mesures. Le résultat est un autre fichier, ou un affichage.

```{code-cell} python
largeur = 1920
hauteur = 1080
print("Cette image contient", largeur * hauteur, "pixels")
```

Ce programme n'est lui-même qu'un fichier texte de trois lignes. Vous pourriez
le taper dans le Bloc-notes. Ce qui le transforme en action, c'est un second
programme, nommé `python`, qui le lit et l'exécute.

Trois choses sont donc des fichiers dans cette affaire : les données d'entrée,
le résultat, et le code lui-même. C'est pour cette raison que le module commence
par les fichiers plutôt que par le langage.

## Trois compétences préalables

```{list-table}
:header-rows: 1

* - Compétence
  - Ce que cela recouvre
  - Vu en
* - Fichiers et dossiers
  - ce qu'un fichier contient, ce qu'une extension signifie, comment une
    arborescence s'organise et se parcourt
  - séance 1, puis en Python séance 3
* - Édition de texte pour le code
  - ce qui distingue un éditeur de code d'un traitement de texte, et pourquoi
    l'un convient et l'autre non
  - séance 1
* - Environnement de développement
  - installer Python et les outils associés, et décrire cette installation pour
    qu'elle soit reproduite ailleurs
  - séance 1
```

La séance traite les trois dans cet ordre. Les fichiers sont l'objet de la
partie [Logiciels et formats de fichier](01_logiciels_et_formats.md) ; la
page suivante installe l'environnement de travail du module.

:::{seealso}
Suite : [Environnement Python et notebooks](03_environnement_python.md).
:::
