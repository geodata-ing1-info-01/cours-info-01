---
title: Récupérer les fichiers d'une séance
subtitle: Le dossier partagé formationTemp, la copie dans Desktop\info01, la décompression
---

Les fichiers des TD d'une séance (textes, images, notebooks, feuilles de TD
en PDF) sont dans une archive `.zip`, un fichier par séance :

- `info01-cours1.zip` pour le cours 1 ;
- `info01-cours3.zip` pour le cours 3.

Avant la séance, l'archive est déposée dans le dossier partagé
`formationTemp`, sur un serveur de l'école. Il faut la copier sur le poste,
puis la décompresser, avant d'ouvrir le premier fichier :

1. copier l'archive : sur le Bureau, ouvrir le raccourci `formationTemp`,
   et copier l'archive de la séance dans le dossier `info01` du Bureau,
   `C:\Users\eleve\Desktop\info01`, à créer la première fois ;
2. décompresser l'archive : clic droit sur l'archive copiée, « Extraire
   tout… », puis effacer la fin du dossier proposé pour garder
   `C:\Users\eleve\Desktop\info01`. Le dossier de la séance, `cours1`
   pour le cours 1, apparaît à côté de l'archive.

Chaque étape est détaillée plus bas, dans les {ref}`instructions
détaillées <instructions-detaillees>`.

:::{warning}
**Ne pas travailler dans le dossier partagé.**

`formationTemp` est le même dossier pour tous les élèves. Un fichier
enregistré là est visible par tous, et il peut être écrasé par un autre
élève, ou effacé avant la séance suivante. À la séance 1, du travail a été
perdu de cette façon.

Avant d'ouvrir un fichier, regarder la barre d'adresse de l'explorateur :
elle doit commencer par `C:\Users\eleve\Desktop\info01`. Si elle commence
par `\\` ou par une autre lettre que `C:`, on est dans le dossier partagé.
:::

(instructions-detaillees)=
## Instructions détaillées

### Ouvrir le dossier partagé

1. Sur le Bureau, double-cliquer sur le raccourci `formationTemp`.
2. Windows demande un nom d'utilisateur et un mot de passe : entrer ses
   identifiants d'élève [à compléter : les mêmes que pour la session
   réseau ?].
3. Le dossier s'ouvre dans l'explorateur de fichiers. Il contient l'archive
   de la séance, `info01-cours1.zip` pour le cours 1.

### Copier l'archive dans un dossier du Bureau

L'archive se copie dans un dossier `info01`, sur le Bureau du poste. Le
Bureau se retrouve sans chercher et son chemin est court ; le dossier
`info01` réunit les séances du module, `cours1`, `cours2`…, et se copie en
une fois en fin de séance. Le chemin complet est
`C:\Users\eleve\Desktop\info01`.

1. La première fois : sur le Bureau, clic droit sur un endroit vide,
   Nouveau, Dossier, et le nommer `info01`.
2. Dans `formationTemp`, clic droit sur `info01-cours1.zip`, Copier (ou
   `Ctrl` + `C`).
3. Ouvrir le dossier `info01` du Bureau, clic droit sur un endroit vide,
   Coller (ou `Ctrl` + `V`). La copie prend quelques secondes.
4. Fermer la fenêtre de `formationTemp`. Tout ce qui suit se fait dans
   `info01`.

:::{note}
L'explorateur affiche le Bureau sous le nom « Bureau ». Son nom réel,
celui qu'on lit dans un chemin ou dans un terminal, est `Desktop`.
:::

### Décompresser l'archive

Un fichier `.zip` est un seul fichier, qui contient des dossiers et des
fichiers compressés. L'explorateur de Windows l'affiche comme un dossier :
un double-clic l'ouvre, et montre son contenu. Ce n'est pas un dossier :

- un fichier ouvert par double-clic depuis l'archive est d'abord extrait
  dans un dossier temporaire ; ce qu'on y enregistre reste dans ce dossier
  temporaire, et il est perdu à la fermeture ;
- VS Code, JupyterLab et Spyder n'ouvrent pas un dossier qui est dans un
  `.zip`. Dans leur fenêtre « Ouvrir un dossier », l'archive est un
  fichier, et on ne peut pas entrer dedans.

Il faut donc extraire l'archive, une fois, avant de commencer :

1. Dans `info01`, clic droit sur `info01-cours1.zip`, « Extraire tout… ».
2. Une fenêtre demande le dossier de destination. Elle propose
   `C:\Users\eleve\Desktop\info01\info01-cours1`. Effacer la fin,
   `\info01-cours1`, pour laisser `C:\Users\eleve\Desktop\info01`.
   L'archive contient déjà un dossier `cours1` ; sans cette correction, on
   obtient `info01\info01-cours1\cours1`, un dossier de trop, et les
   chemins des diapositives ne correspondent plus.
3. Laisser cochée « Afficher les fichiers extraits une fois l'opération
   terminée », puis cliquer sur « Extraire ».
4. Le dossier `cours1` s'ouvre. Il contient un dossier par TD, numéroté
   dans l'ordre de la séance (`1a_formats`, `1b_archive_odt`…), avec dans
   chacun la feuille du TD en PDF, et un fichier `README.md` qui liste les
   TD.

Dans `info01`, il y a maintenant l'archive `info01-cours1.zip`, avec une
icône de fermeture éclair, et le dossier `cours1`, avec une icône de
dossier. Tout le travail se fait dans le dossier `cours1`. L'archive peut
être supprimée, ou gardée pour refaire un TD depuis ses fichiers de départ.
Pour voir l'extension `.zip` dans le nom, l'explorateur doit afficher les
extensions ({ref}`B2 <dep-b2>`).

Si le dossier partagé contient un dossier au lieu d'une archive, le copier
dans `info01` de la même façon ; il n'y a rien à décompresser.

## Vérifier

| Ce qu'on fait | Ce qu'on doit voir |
|---|---|
| Ouvrir `info01` puis `cours1` sur le Bureau, et lire la barre d'adresse de l'explorateur | `C:\Users\eleve\Desktop\info01\cours1`, ou « Ce PC > Bureau > info01 > cours1 » |
| Dans `cours1`, ouvrir un dossier de TD | un fichier `td_….pdf`, et les fichiers du TD |
| Dans VS Code, Fichier, « Ouvrir le dossier… », choisir `Bureau\info01\cours1` | les dossiers des TD dans le panneau de gauche |

## À la fin de la séance

Le travail de la séance se copie dans le dossier personnel avant de quitter
le poste, comme le décrit [Sauvegarder son travail](../apres/sauvegarder.md).
