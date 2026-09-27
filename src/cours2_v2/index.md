---
title: "Séance 2, version 2 — Éditeur de code, Markdown et git local"
---

:::{note}
Version 2 de la séance 2, en cours de construction pour l'année 2027-2028,
écrite en septembre 2026 à partir des retours sur la séance 2. La séance
jouée en 2026 est dans la partie « Archive 2026 ». Le TD git de cette
version peut servir à réviser git.
:::

## Contenu de la séance

La séance commence par la configuration de l'éditeur de code, faite par
toute la salle en même temps ; tout le reste se fait dans l'éditeur, avec
son terminal Git Bash.

```{list-table}
:header-rows: 1

* - Partie
  - Ce qu'on y voit
  - TD
* - Configurer l'éditeur de code
  - VS Code, l'extension Python, l'interpréteur, Git Bash comme terminal,
    les réglages User et Workspace
  - 1a, en classe entière
* - L'éditeur de code
  - les fonctions d'un IDE, la coloration, la chasse fixe, l'indentation en
    espaces ou en tabulations ; trois programmes fautifs à corriger
  - 1b
* - Markdown
  - l'intention de Markdown, tableau, bloc de code et image, la conversion
    par pandoc, le README
  - 2a
* - Git local
  - le dépôt, l'index et le commit, `status`, `diff`, `log`, `restore`,
    `.gitignore`, les branches, la fusion et les conflits
  - 3a
```

Les guides détaillés des TD sont réunis dans [Travaux dirigés de la
séance 2, version 2](notebook/travaux_diriges.md).

## Ce qui change par rapport à 2026

La version 2 suit le syllabus v2 du module, `syllabus/02_syllabus_v2.md`
dans le dépôt :

- la ligne de commande passe au cours 1, avec un TD ;
- la configuration de VS Code arrive du cours 1, faite en classe entière,
  avec Git Bash comme terminal ;
- Markdown arrive du cours 1, complété par pandoc et le README ;
- git se joue sur un seul dépôt, celui de la recette écrite en Markdown,
  à la place des cinq TD sur le projet `projet_2` ;
- `revert`, `tag`, `rebase` et l'organisation main, develop, feature
  passent en annexe.

Les diapositives sont dans le dépôt, `src/cours2_v2/diapo/cours2_v2.pdf`.

```{toctree}
:maxdepth: 1

notebook/travaux_diriges
```
