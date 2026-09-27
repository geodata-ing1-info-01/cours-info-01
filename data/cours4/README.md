# Données — Projet 4 : du notebook au programme, en deux parcours

Le parcours standard fait les TD 4a et 4b, le parcours avancé le TD 4c.

| Dossier | Ce que c'est |
|---|---|
| `4a_noyaux/` | parcours standard : le client et le noyau d'un notebook ; `noyau.ipynb` ouvert dans JupyterLab puis dans VS Code, exécuté dans le noyau de l'environnement `info01-recette` (`depart/environment.yml`) ; reprend les TD 3b et 4b du cours 1 sur le code du cours 3 |
| `4b_cli/` | parcours standard : le TD 3a du cours 3 ; les données sont recopiées de celui-ci par `make_data.py`, la feuille et le guide écrits par `reprendre_td3a.py` |
| `4c_train/` | parcours avancé : la fenêtre du train, d'après le clip « Moon » de Kid Francescoli : un plan décalé par ImageMagick (`-roll`), posé entre un fond fixe et la fenêtre (`-composite`), un décalage par image, une vidéo par ffmpeg ; le décor est dessiné par `make_data.py`. Conception : `syllabus/cours/4_projet_animation/td_4c_train.md` |
| `_propositions/` | les TD 4a montre et 4b tourbillon d'avant le 26/09/2026, gardés comme propositions ; non livrés |
| `corriges/` | le programme de chaque TD d'animation à la fin de chaque étape (`<td>/b1/` … `b5/`), versionné ici pour ne pas partir dans l'archive |
| `generer_corriges.py` | écrit les programmes des corrigés (B1, B2, B3 et B5), avec les mêmes morceaux pour les trois animations |
| `generer_guides.py` | écrit les guides des trois animations, celui du train dans `src/cours4/notebook/td/`, les deux autres dans `src/cours4/notebook/propositions/` |
| `reprendre_td3a.py` | écrit la feuille et le guide du TD 4b à partir du TD 3a du cours 3 |
| `propositions/` | les notebooks d'essai du 20/09/2026, exécutés (non versionnés) |

Le TD 4c a ce déroulé :

- partie A : créer l'environnement `animation` depuis `environment.yml`,
  lancer JupyterLab depuis cet environnement, exécuter le notebook ;
- partie B : construire le programme `train.py`
  fonctionnalité par fonctionnalité, une branche git par fonctionnalité :
  B1 une image, B2 une série d'images, B3 la vidéo (avec un commit sur
  `master` pendant la branche, donc un commit de fusion), B4 le README ; en
  facultatif, B5 : `src/`, `pyproject.toml` et une commande installée.

```bash
conda activate info01
python ../cours3/make_data.py build   # les recettes et le TD 3a, repris par 4a et 4b
python reprendre_td3a.py              # si le TD 3a du cours 3 a changé
python generer_corriges.py            # si le code des programmes a changé
python generer_guides.py              # si le texte des guides a changé
python make_data.py build             # produit/ des trois TD
python ../../outils/construire_notebooks.py
python ../../outils/compiler_guides.py --cours 4
```

Le guide détaillé de chaque TD est écrit dans
`src/cours4/notebook/td/<td>/guide.md` ; `outils/compiler_guides.py` en fait
un PDF A4 et une page HTML déposés dans le dossier du TD.
