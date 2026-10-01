---
title: Premiers tests du poste
subtitle: La session réseau, le Bloc-notes, Notepad++, l'explorateur de fichiers, LibreOffice
---

À faire avant la séance 1 : ouvrir la session réseau, puis vérifier que
les logiciels de texte et de bureautique se lancent. Dix minutes.

:::{warning}
**Ouvrir la session réseau avant tout le reste.**

Sur les postes de la salle, l'accès à Internet demande une authentification.
Certains outils du module, comme Anaconda Navigator ou VS Code, ont besoin
du réseau : pour installer une extension, ou au lancement, pour chercher des
mises à jour. Sans réseau, leur lancement peut être long, et leur
configuration peut échouer une fois lancés.
:::

## Ouvrir la session réseau

1. Sur le bureau, double-cliquer sur le raccourci [à compléter : nom exact
   du raccourci]. Firefox s'ouvre sur une page de connexion.
2. Entrer ses identifiants.
3. La session dure [à compléter : durée]. Après ce délai, les
   téléchargements échouent de nouveau : refaire les étapes 1 et 2.

Pour vérifier, ouvrir <https://code.visualstudio.com> dans Firefox. La page
doit s'afficher. Sinon : {ref}`R1 <dep-r1>`.

## Tester les logiciels de texte et de bureautique

Le TD 1a emploie le Bloc-notes, Notepad++, l'explorateur de fichiers et
LibreOffice. Les vérifier prend deux minutes.

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Menu Démarrer, taper `bloc-notes` (ou `notepad`), Entrée | une fenêtre vide du Bloc-notes | {ref}`B1 <dep-b1>` |
| Menu Démarrer, taper `notepad++`, Entrée | Notepad++ s'ouvre | {ref}`B1 <dep-b1>` |
| Explorateur de fichiers, ouvrir le dossier du TD | les noms de fichiers montrent leur extension (`raven.txt`, et non `raven`) | {ref}`B2 <dep-b2>` |
| Double-clic sur un fichier `.txt` | il s'ouvre dans un éditeur de texte | {ref}`B3 <dep-b3>` |
| Menu Démarrer, taper `libreoffice`, Entrée | LibreOffice s'ouvre | le signaler à l'enseignant |

L'extension est la fin du nom d'un fichier, après le point : `.txt`,
`.odt`, `.py`. Elle est cachée par défaut dans l'explorateur, et le TD 1a
demande de la voir.
