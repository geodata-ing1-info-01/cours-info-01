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
: Le menu Démarrer ne propose rien pour le nom tapé.

Vérifier
: `Win` + `R`, taper `notepad`, Entrée : le Bloc-notes fait partie de
  Windows et s'ouvre toujours. Pour Notepad++ : dans un `cmd`,
  `dir "C:\Program Files\Notepad++"`. « Fichier introuvable » veut dire
  qu'il n'est pas installé sur ce poste.

Solution
: Menu Démarrer, taper le début du nom (`bloc`, `notepad`), Entrée. Pour
  ouvrir un fichier donné dans l'un ou l'autre : clic droit sur le fichier,
  « Ouvrir avec », « Choisir une autre application ». Si Notepad++ manque,
  le TD 1a peut se faire avec le Bloc-notes.

(dep-b2)=
### B2. L'explorateur cache les extensions de fichiers

Ce qu'on voit
: Le fichier `raven_une_ligne.txt` s'affiche sous le nom `raven_une_ligne`. Renommer un fichier
  en `raven.donnees` produit en réalité `raven.donnees.txt`.

Cause
: Par défaut, l'explorateur cache l'extension des types de fichiers connus de
  Windows.

Solution
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
: Aucun programme n'a déclaré cette extension, et Windows affiche alors cette
  liste. Le TD 1a étudie le lien entre extension et contenu.

Solution
: Choisir le Bloc-notes ou Notepad++ dans la liste, sans cocher « Toujours
  utiliser cette application » : le TD fait ouvrir un même fichier avec
  plusieurs programmes.
