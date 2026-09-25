# Consignes pour Claude

Avant d'écrire ou de réécrire un support (diapositive, page de cours,
notebook, guide, syllabus), lire [`STYLE.md`](STYLE.md), y compris la table
« Tournures corrigées en relecture ». Une réorganisation compte comme une
écriture : chaque phrase nouvelle ou reformulée suit ces règles, et un texte
déjà relu se déplace sans être reformulé.

Avant de rendre la main, lancer :

```bash
python outils/verifier_style.py      # tournures proscrites, lignes ajoutées depuis le dernier commit
python outils/verifier_diapos.py src/cours<n>/diapo/cours<n>.pdf
```

et corriger chaque signalement de `verifier_style.py`, ou le relire et le
garder s'il ne relève pas de la règle.
