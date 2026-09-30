# Compléter son projet, par des pull requests — TD 7a, projet 7

La suite du programme `recette.py` du projet 4, récupéré depuis GitHub : la
page HTML de chaque recette, écrite par pandoc, puis toutes les recettes et
un sommaire. Chaque fonctionnalité se développe sur une branche et arrive
sur `master` par une pull request.

| Dossier | Ce qu'il contient |
|---|---|
| `depart/recettes/` | le texte des recettes en Markdown (`<nom>.md`), et six recettes de plus (`<nom>.csv`, pour 4 personnes) |
| `depart/style.css` | la feuille de style des pages |
| `travail/` | vide : le dépôt `recette` y est cloné à l'étape D0 |

Le guide détaillé, `guide_7a_recette.pdf` (aussi en `.html` et en notebook
`guide.ipynb`), donne pour chaque étape les commandes, le code et la façon de
vérifier le résultat.

## Les étapes

| | Ce qu'on fait |
|---|---|
| D0 | cloner son dépôt `recette` (ou le dépôt de référence), le relancer |
| D1 | branche `page` : l'option `--page`, la page HTML par pandoc |
| D2 | la pull request de `page`, fusionnée sur GitHub, puis `git pull` |
| D3 | branche `livre` : six recettes de plus, l'option `--toutes` |
| D4 | le sommaire, `sortie/index.html` ; la pull request de `livre` |
| D5 (bonus) | les pages publiées avec GitHub Pages |
