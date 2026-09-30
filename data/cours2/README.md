# Données — Cours 2 : ligne de commande et git local

Un dossier par TD, dans l'ordre de la séance. Les cinq TD construisent le
même dépôt : chacun reprend le projet là où le précédent l'a laissé. Le TD 2a
le crée dans `2a_premier_depot/travail/projet_2`, et il y reste.

| Dossier | Questions | Ce qu'on y fait |
|---|---|---|
| [`2a_premier_depot/`](2a_premier_depot/) | 1 à 5 | l'alias `git llog`, `git init`, un `README.md`, un premier commit |
| [`2b_branches/`](2b_branches/) | 6 à 17 | `develop`, `documentation`, `main_code`, `operations`, et leurs fusions |
| [`2c_annuler/`](2c_annuler/) | 18 à 20 | annuler avec `revert`, mettre une branche à jour avec `rebase` |
| [`2d_conflits/`](2d_conflits/) | 21 à 25 | fabriquer un conflit, puis le résoudre |
| [`2e_livrer/`](2e_livrer/) | 26 et 27 | fusionner `develop` dans `master`, taguer la version |

Le projet est une petite calculatrice : `src/operations.py` porte quatre
fonctions (`add`, `mult`, `neg`, `inv`), `src/main.py` lit une opération tapée
au clavier et affiche le résultat.

Les feuilles de TD sont déposées dans chaque dossier par
`python outils/compiler_tds.py --cours 2`, sous le nom `td_<dossier>.pdf`.

Le sujet d'origine est celui de Florent Geniet,
[`livraison/cours2_florent/TP_session_2.md`](../../livraison/cours2_florent/TP_session_2.md).
Les écarts avec lui sont signalés dans les README des dossiers concernés.

Il n'y a pas de `make_data.py` : les trois fichiers de départ sont écrits à
la main et versionnés.
