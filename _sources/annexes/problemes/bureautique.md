---
title: Problèmes avec les logiciels de texte et de bureautique
subtitle: Bloc-notes, Notepad++, explorateur de fichiers
---

Le test de ces logiciels est dans [Premiers tests du
poste](../../avant/poste.md).

(dep-bureautique)=
## Problèmes

(dep-b1)=
### B1. Le Bloc-notes ou Notepad++ n'est pas dans le menu Démarrer

Ce qu'on voit
: Rien ne répond au nom tapé dans le menu Démarrer.

Vérifier
: `Win` + `R`, taper `notepad`, Entrée : le Bloc-notes fait partie de
  Windows et s'ouvre toujours. Pour Notepad++ : dans un `cmd`,
  `dir "C:\Program Files\Notepad++"`. « Fichier introuvable » veut dire
  qu'il n'est pas installé sur ce poste.

Remède
: Menu Démarrer, taper le début du nom (`bloc`, `notepad`), Entrée. Pour
  ouvrir un fichier donné dans l'un ou l'autre : clic droit sur le fichier,
  « Ouvrir avec », « Choisir une autre application ». Si Notepad++ manque,
  le Bloc-notes suffit au TD 1a.

(dep-b2)=
### B2. L'explorateur cache les extensions de fichiers

Ce qu'on voit
: Le fichier `raven.txt` s'affiche sous le nom `raven`. Renommer un fichier
  en `raven.donnees` produit en réalité `raven.donnees.txt`.

Cause
: Par défaut, l'explorateur cache l'extension des types de fichiers qu'il
  connaît.

Remède
: Windows 11 : menu Affichage, Afficher, cocher « Extensions de noms de
  fichiers ». Windows 10 : onglet Affichage, cocher « Extensions de noms de
  fichiers ». Au même endroit, « Éléments masqués » montre les dossiers
  `.git`, `.vscode` et `AppData`, utiles à partir de la séance 2.

(dep-b3)=
### B3. Windows demande avec quel programme ouvrir le fichier

Ce qu'on voit
: Au double-clic sur un fichier dont l'extension est inconnue (`.donnees`,
  `.md` sur un poste sans éditeur associé), Windows affiche une liste de
  programmes au lieu d'ouvrir le fichier.

Cause
: Aucun programme n'a déclaré cette extension. C'est le comportement
  normal de Windows. L'extension est une convention de nommage ; elle ne
  dit pas ce que contient le fichier, et c'est le sujet du TD 1a.

Remède
: Choisir le Bloc-notes ou Notepad++ dans la liste, sans cocher « Toujours
  utiliser cette application » : le TD fait ouvrir un même fichier avec
  plusieurs programmes.
