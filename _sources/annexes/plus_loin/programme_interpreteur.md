---
title: Programme, application et interpréteur
subtitle: Ce qui sépare un programme d'une application, et ce que fait l'interpréteur entre un programme et le système
---

Cette page reprend deux diapositives du cours 1, retirées de la séance en
septembre 2026 : « D'un programme à une application » et « La place de
l'interpréteur ».

## D'un programme à une application

Trois mots désignent des choses proches. La programmation est l'activité
d'écrire un programme. Un programme est le texte écrit dans un langage, son
code source. Une application est ce que reçoit la personne qui s'en sert.
Aucun des trois ne désigne une nature différente, et l'usage seul les
distingue.

Le passage du programme à l'application dépend de la façon dont le programme
est distribué :

| Chemin | Étapes | Ce que fait l'utilisateur |
|---|---|---|
| distribution | code source, empaquetage (*packaging*), application | il installe l'application sur son poste |
| déploiement | code source, mise en ligne, application web | il ouvre une adresse dans son navigateur, sans rien installer |

Le même code peut suivre l'un ou l'autre chemin. Le cours 6 revient sur
l'empaquetage et sur la mise en ligne.

## La place de l'interpréteur

Un programme interprété, comme un fichier `.py` ou une page web, ne
s'exécute pas seul : un autre programme, l'interpréteur, lit son texte et
l'exécute. L'interpréteur de Python est `python` ; celui d'une page web est
le navigateur. Le mot « interpréteur » désigne un rôle. Le navigateur
interprète trois langages, HTML, CSS et JavaScript, sans qu'on l'appelle
ainsi.

| Couche | Exemples | Ce qu'elle transmet à la couche du dessous |
|---|---|---|
| le programme interprété | `bonjour.py`, une page web | son texte |
| l'interpréteur | `python`, le navigateur | des appels système, comme `open` et `read` |
| le système d'exploitation | Windows, macOS, Linux | des octets, lus sur le disque ou le réseau |

L'interpréteur fait les appels système à la place du programme. Il ouvre les
fichiers, écrit à l'écran et lit le réseau. Un programme
compilé, comme `bonjour.exe`, fait ces appels lui-même, puisqu'il est déjà
en instructions machine. Les noms `open` et `read` sont ceux de macOS et de
Linux ; Windows appelle les siens `CreateFile` et `ReadFile`.

`python` traduit d'abord le texte entier en *bytecode*, avant d'exécuter
quoi que ce soit. Le bytecode est fait d'instructions d'une machine
virtuelle qui n'existe que dans `python`. Le processeur ne connaît pas ces
instructions, et `python` les exécute lui-même.
`python -m dis bonjour.py` affiche ce bytecode. Les fichiers `.pyc` du
dossier `__pycache__` en sont une copie gardée sur le disque, pour éviter de
refaire la traduction au lancement suivant.

Un interpréteur est lui-même un programme compilé : `python.exe` est écrit
en C, et traduit en instructions machine. Il en découle une conséquence
pratique. Un programme Python ne se lance que sur un poste où Python est
installé, alors qu'un exécutable compilé se lance seul. La page
[C++](cpp.md) le fait constater sur un programme compilé.
