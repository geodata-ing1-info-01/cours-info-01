# La scène complète — TD 7b, projet 7

La suite du TD 4c : plusieurs plans, chacun à sa vitesse, décrits dans
`decor/plans.csv` ; l'effet `poteaux`, des ombres qui passent devant la
fenêtre, écrit avec une boucle sur les pixels puis avec numpy ; une vidéo qui
boucle sans saut. Chaque fonctionnalité se développe sur une branche du
dépôt GitHub du cours 6, et arrive sur `master` par une pull request.

Le guide `guide_7b_train.pdf` (aussi en `.html` et en notebook
`guide.ipynb`) détaille les étapes.

| Fichier | Ce qu'il contient |
|---|---|
| `depart/notebook/tableaux.ipynb` | le notebook des outils numpy : une image est un tableau, tranches, dépassement des `uint8`, masques, mesure du temps |
| `depart/exemple.png` | une image de la série du TD 4c, lue par le notebook |
| `depart/decor/` | `plage.png` et `fenetre.png`, lues par le notebook |
| `depart/modeles/plans.csv` | les plans et leurs vitesses : voiles 4, plage jaune 8, plage orange 16 pixels par image |
| `depart/modeles/test_effet.py` | le test : les deux versions de `poteaux` donnent-elles la même image ? |
| `depart/modeles/mesurer.py` | le chronométrage des deux versions, sur une image et sur la série |
| `depart/modeles/RAPPORT.md` | le gabarit du rapport |
| `travail/` | vide : la copie du notebook, et le clone du dépôt `train` |

Conception : `syllabus/cours/7_projet_effets/variante_train.md`.
