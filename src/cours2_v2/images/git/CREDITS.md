# Logos et capture de la partie git : sources et licences

Téléchargés le 09/11/2026 sur Wikimedia Commons, sans modification, pour la
diapositive « Git : vue d'ensemble » (`diapo/parties/04_git.typ`). Ils
remplacent, dans le cours 2 v2, les logos découpés dans le support d'origine
(`illustrations/cours2/logos/`). Ce sont des marques appartenant à leurs
titulaires, reproduites ici pour désigner les logiciels dans un support
d'enseignement.

| Fichier | Logiciel | Source | Licence | Auteur |
|---|---|---|---|---|
| `git.svg` | Git | [Commons](https://commons.wikimedia.org/wiki/File:Git_icon.svg) | CC BY 3.0 | Jason Long |
| `github.svg` | GitHub | [Commons](https://commons.wikimedia.org/wiki/File:Octicons-mark-github.svg) | MIT, marque déposée | GitHub |
| `gitlab.svg` | GitLab | [Commons](https://commons.wikimedia.org/wiki/File:GitLab_icon.svg) | CC BY-SA 4.0 | 292Jacob |
| `vscode.svg` | Visual Studio Code | [Commons](https://commons.wikimedia.org/wiki/File:Visual_Studio_Code_1.35_icon.svg) | domaine public (selon Commons), marque déposée | Microsoft |
| `gitkraken.svg` | GitKraken | [Commons](https://commons.wikimedia.org/wiki/File:GitKraken_Logo.svg) | domaine public (selon Commons), marque déposée | GitKraken |
| `tortoisegit.svg` | TortoiseGit | [Commons](https://commons.wikimedia.org/wiki/File:TortoiseGit_logo.svg) | GPL | TortoiseGit Team |

Le terminal, le serveur, les personnes et les écrans du schéma sont dessinés
dans `diapo/schemas.typ`.

## Captures de VS Code

Deux captures faites ici le 10/11/2026, qui montrent un logiciel de Microsoft pour en
désigner l'interface dans un support d'enseignement. VS Code 1.145.2 pour Linux, sans
extension, interface en anglais, thème « Default Light Modern », `window.zoomLevel` à 1,
dans un écran Xvfb ; les clics et la frappe passent par l'extension XTest.

`vscode_fusion.png`, pour la diapositive « Résoudre un conflit dans VS Code » :

- Dépôt : celui du TD 2c, rejoué par `notebook/td/2c_depot_altitudes/rejeu/rejeu.sh`
  jusqu'au conflit du `git merge mesure-4`, à l'étape 6.
- Écran : 1200 × 660 pixels.
- Actions : `altitudes.py` ouvert, bouton « Resolve in Merge Editor », barre latérale
  masquée, puis lien « Accept Combination (Incoming First) ».
- Recadrage : de (62, 100) à (1200, 500), sur les trois volets.

`vscode_source_control.png`, pour la diapositive « git dans VS Code : le panneau Source
Control » :

- Dépôt : celui de `diapo/rejeu/rejeu.sh`, arrêté après le commit `3b88896` (fichier
  texte), avec les modifications du commit suivant (trace GPS) faites, sans commit.
- Écran : 1300 × 680 pixels, `diffEditor.renderSideBySide` à `false`.
- Actions : panneau Source Control, barre latérale élargie à 600 pixels, graphe sur
  « All », clic sur `altitudes.py`, puis message « Lit les altitudes d'une trace GPS »
  tapé.
- Recadrage : de (0, 36) à (1300, 490).
