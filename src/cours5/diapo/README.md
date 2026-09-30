# Diapositives — Cours 5

Premier jet, septembre 2026. Gabarits, conventions et commandes : voir
[`src/cours1/diapo/README.md`](../../cours1/diapo/README.md) et
[`STYLE.md`](../../../STYLE.md). Déroulé diapositive par diapositive :
[`syllabus/cours/5_materiel_reseau_ssh/contenu_detaille.md`](../../../syllabus/cours/5_materiel_reseau_ssh/contenu_detaille.md).

```bash
python outils/compiler_diapos.py --cours 5                  # 53 pages : 43 d'exposé, 10 de TD
python outils/compiler_diapos.py --cours 5 --notes          # notes de conduite à droite
python outils/compiler_diapos.py --cours 5 --corrige        # réponses des TD
python outils/compiler_diapos.py --cours 5 --sans-tds       # 46 pages, un sommaire par bloc de TD
python illustrations/cours5/telecharger.py                  # les deux photos ; sans elles, 51 pages
python outils/compiler_tds.py --cours 5                     # une feuille par TD, dans data/cours5/
python outils/livrer_tds.py --cours 5                       # l'archive remise aux étudiants
python outils/verifier_diapos.py src/cours5/diapo/cours5.pdf
```

```
cours5.typ        assemblage : réglages, ordre des parties et des TD
style.typ         `terminal` : une session de terminal en texte brut
schemas.typ       les schémas dessinés (cetz) : composants, cœurs, pyramide,
                  barres de temps, local/distant, client/serveur, tuyau,
                  clés, échange SSH, commit/push ; la photo à repères et le
                  nuage de points des processeurs
donnees/          tendances.py télécharge les séries de Karl Rupp et écrit
                  tendances.typ, versionné
parties/          00 ouverture, 01 matériel, 02 réseau, 03 prouver qui
                  l'on est, 04 secrets, 99 clôture
tds/              5a_mesures, 5b_secret_historique (facultatif)
```

Les sorties de terminal sont réelles : `ssh-keygen` (OpenSSH 9.6), `git log`
rejoué sur un dépôt de deux commits, `mesures.py` sur le poste de préparation.
Les chemins Windows sont recomposés à partir de ces sorties.

Les deux photos annotées viennent de Wikimedia Commons et sont décrites dans
[`illustrations/cours5/README.md`](../../../illustrations/cours5/README.md) ;
les deux diapositives qui les portent ne sont produites que si elles sont là.

`schemas.typ` ouvre `cetz.draw` : ce qui y est primitive typst du même nom
s'écrit `std.rect`, `std.line`, `std.rotate`, et les parties l'importent
nommément, jamais par `: *`.
