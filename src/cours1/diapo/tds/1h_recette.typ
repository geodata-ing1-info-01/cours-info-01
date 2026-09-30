// TD 1h — « Installer un projet Python, et décrire son installation ».
//
// Inclus par `cours1.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`, qui
// en tire la feuille de TD déposée dans le dossier annoncé. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "1h",
  titre: "Installer un projet Python, et décrire son installation",
  annonce: "Objectif : compléter un projet auquel il manque le fichier qui décrit son environnement, et la section de son README qui dit comment l'installer",
  dossier: "cours1/1h_recette/",
  duree: "20′",
)
#separateur-td(..td)
#d("Le projet, dossier par dossier")[
  #annonce[
    Copier `depart/recette/` dans `travail/`, l'ouvrir dans l'éditeur, et dire
    à quoi sert chaque fichier avant d'en lancer un seul.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Ce que le projet contient], [Ce que c'est],
    [`pyproject.toml`], reponse[le nom du projet, et ce dont son code dépend],
    [`data/`], reponse[ce que le programme lit, et la feuille de style],
    [`src/recette/`], reponse[le code, en trois modules],
    [`recette_a_la_main.py`, `recette_avec_tabulate.py`],
      reponse[deux programmes qui ne diffèrent que par un import],
    [`README.md`], reponse[ce que le projet fait, mais pas comment l'installer],
  )

  #legende[
    Deux choses manquent, et les écrire est l'objet du TD : le fichier qui
    décrit l'environnement, et la section « Installation » du `README`.
  ]

  #notes[
    Faire répondre avant d'afficher. Le tableau est la partie 4 appliquée à
    un dossier réel : ils ont vu ce qu'un projet contient, ils le
    reconnaissent ici.

    Le point à faire venir d'eux, ou à poser si personne ne le voit : ce
    projet ne se laisse pas installer. Rien ne dit quelles commandes taper,
    et aucun fichier ne décrit l'environnement. Un projet qu'on ne sait pas
    installer ne sert qu'à celui qui l'a écrit.

    `data/` et `src/` ne sont pas des noms imposés par Python. `src/` est
    la disposition la plus répandue, et la documentation de la PyPA en
    donne la raison : le code n'est importable qu'une fois le projet
    installé, donc on travaille toujours sur la version installée et jamais
    sur un dossier trouvé par hasard. C'est ce que l'étape 5 fera
    constater.

    Ne pas ouvrir les modules ligne à ligne : ils l'ont été plus haut dans la partie,
    diapositive « Exemple de programme : le code ».

    Libellés de menu non vérifiés sur un poste Windows.
  ]
]
#d("Deux sortes de dépendances")[
  #annonce[
    Le programme importe trois noms que Python ne fournit pas. Deux viennent
    d'un dépôt public, le troisième est le projet lui-même.
  ]

  #face-a-face(
    panneau("Publiées, dans un dépôt")[
      ```python
      import markdown
      from tabulate import tabulate
      ```
      #v(0.3em)
      #text(size: 14pt, fill: estompe)[
        Déclarées dans `dependencies`, et posées par `conda install` depuis
        conda-forge.
      ]
    ],
    panneau("Le projet lui-même")[
      ```python
      from recette.calculs import adapter
      from recette.tableau import GABARIT
      ```
      #v(0.3em)
      #text(size: 14pt, fill: estompe)[
        Le code est sous `src/`, il n'est sur aucun dépôt, et s'installe
        depuis le dossier.
      ]
    ],
  )

  #legende[
    Une bibliothèque qu'on écrit soi-même n'est nulle part tant que personne
    ne l'a publiée. C'est le cas ici, et c'est le cas ordinaire.
  ]

  #notes[
    Les deux colonnes demandent deux commandes différentes, et c'est tout
    le propos des deux diapositives qui suivent.

    Publier son projet sur PyPI ou conda-forge est un travail en soi :
    choisir un nom libre, fabriquer un paquet, tenir un compte, et pour
    conda-forge faire relire une recette. Un projet de cours, un projet
    interne, un projet en cours d'écriture ne passent pas par là. La
    question vient souvent ; y répondre en une phrase.

    D'où `pip install -e .` : le dépôt est remplacé par un chemin, le point
    désignant le dossier courant. « Éditable » veut dire que le dossier
    reste la source, une modification du code prenant effet sans
    réinstaller.

    `pip` et non `conda` pour cette ligne : conda installe ce qui vient
    d'un dépôt de paquets, pas un dossier de travail. C'est la seule
    entorse à la règle « un seul outil par environnement », et elle est
    bornée au projet lui-même.
  ]
]
#d("Un environnement d'essai")[
  #annonce[
    On part d'un environnement qui ne contient que Python, pour voir ce qui
    s'y trouve d'origine et ce qui n'y est pas.
  ]

  #tableau(
    columns: (auto, 1.3fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [`conda create -n recette -c conda-forge python=3.12`], [],
    [2], [`conda activate recette`, puis `conda list`],
      reponse[28 paquets, et aucun des trois noms importés],
    [3], [`cd travail/recette`, puis `python recette_a_la_main.py`],
      reponse[`ModuleNotFoundError: No module named 'markdown'`],
  )

  #legende[
    L'environnement actif se lit à deux endroits : en tête de l'invite du
    terminal, `(recette)`, et en bas à droite dans la barre d'état. Pour en
    changer sans taper de commande, palette puis « Python: Select Interpreter ».
  ]

  #notes[
    Le choix du module, à énoncer une fois : `conda` plutôt que `pip`,
    parce qu'il installe aussi ce qui n'est pas du Python, `ffmpeg`,
    `pandoc`, un compilateur. `-n` nomme l'environnement visé,
    `-c conda-forge` le dépôt d'où viennent les paquets ; sur un poste
    installé avec Miniforge ce dépôt est déjà le défaut, et l'écrire ne
    coûte rien.

    Les deux façons de changer d'environnement ne font pas la même chose,
    et la distinction vaut la minute qu'elle prend. `conda activate` agit
    sur le terminal ouvert, et sur lui seul. « Python: Select Interpreter »
    agit sur l'éditeur : le bouton d'exécution, le débogueur et les
    terminaux ouverts *ensuite* emploient l'interpréteur choisi, mais un
    terminal déjà ouvert garde le sien. D'où la règle : après avoir changé
    d'interpréteur, ouvrir un nouveau terminal.

    C'est l'étape du TD 1c, revue ici sur un environnement qu'ils ont
    fabriqué eux-mêmes. Faire lire l'invite et la barre d'état ensemble :
    quand les deux ne disent pas la même chose, c'est presque toujours
    l'explication du `ModuleNotFoundError` qui suit.

    Étape 2, à faire lire à voix haute : un environnement « Python seul »
    n'est pas vide, il contient 28 paquets, dont une douzaine de
    bibliothèques C, `openssl`, `sqlite`, `zlib`, sans lesquelles
    l'interpréteur ne démarre pas. `pip`, `setuptools` et `wheel` y sont
    aussi, d'où `pip install` qui fonctionne dans un environnement conda
    sans qu'on l'ait installé.

    Étape 3, à ne pas sauter : le `ModuleNotFoundError` annoncé deux fois
    depuis la partie 2 leur arrive dans des conditions où la cause est
    connue. Le fichier est là, sa syntaxe est correcte ; c'est la
    dépendance qui manque.

    Le message nomme `markdown` et non `tabulate` parce que c'est le
    premier import du fichier : une erreur d'import s'arrête à la première
    ligne fautive, elle ne fait pas la liste.

    Nommer l'environnement `recette` dès maintenant, comme le fichier
    l'appellera : c'est ce qui rendra la dernière diapositive intéressante.
  ]
]
#d("Résoudre les deux dépendances")[
  #annonce[
    Les bibliothèques publiées d'abord, le projet ensuite. Deux commandes,
    et le même message d'erreur entre les deux, pour deux causes différentes.
  ]

  #tableau(
    columns: (auto, 1.3fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [4], [`conda install -c conda-forge markdown tabulate`, puis `y`],
      reponse[quatre paquets : les deux demandés, `importlib-metadata`, `zipp`],
    [5], [`python recette_a_la_main.py`],
      reponse[`ModuleNotFoundError: No module named 'recette'`],
    [6], [`python -m pip install -e .`],
      reponse[le projet s'installe, ses dépendances étant déjà là],
    [7], [`python recette_a_la_main.py`, puis ouvrir `recette.html`],
      reponse[la recette mise en page, sans serveur ni réseau],
  )

  #legende[
    Les deux messages sont le même, et les causes ne le sont pas : `markdown`
    manquait à l'environnement, `recette` est le code du projet, que rien
    n'avait encore rendu importable.
  ]

  #notes[
    Étape 4 : quatre paquets pour deux demandés. `importlib-metadata` et
    `zipp` viennent avec, et la même commande dans `base` n'en
    installerait qu'un, les autres y étant déjà. C'est « Dépendances
    directes et transitives » vérifié par eux.

    Étape 5, le point de la diapositive : le message est celui de l'étape 3,
    et il ne dit pas la même chose. `markdown` vient de conda-forge ;
    `recette` est le dossier qu'ils ont sous les yeux, et Python ne le
    trouve pas parce que le code est sous `src/` et que rien ne l'a encore
    déclaré.

    Étape 6 : `pip install -e .` lit `pyproject.toml`. Les deux
    bibliothèques déclarées y sont déjà, pip ne les retélécharge pas, et
    le dépôt est remplacé par le point, qui désigne le dossier courant.

    Étape 7, trois renvois : le `recette.md` du projet ressemble à celui
    qu'ils ont écrit une demi-heure plus tôt ; la page sépare contenu et
    présentation, comme les deux pages du poème de la partie 1 ; elle
    s'ouvre en `file:///`, sans serveur. Faire changer une couleur dans
    `data/style.css` et recharger : la page change, le `.html` n'a pas
    bougé.

    Poste sans réseau : l'installation échoue. Projeter le résultat et
    passer à la diapositive suivante, qui ne demande que d'éditer des
    fichiers.
  ]
]
#d("Écrire ce qui manque")[
  #annonce[
    Quatre commandes tapées ne se retrouvent pas. Écrites dans le projet,
    elles refont le même environnement sur une autre machine.
  ]

  #face-a-face(
    panneau[`environment.yml`, à créer][
      ```yaml
      name: recette
      channels:
        - conda-forge
      dependencies:
        - python=3.12
        - markdown
        - tabulate
      ```
    ],
    // Le bloc contient lui-même une clôture de bloc : il est passé à `raw`
    // par une chaîne, un bloc typst s'arrêtant à la première.
    panneau[`README.md`, section à ajouter][
      #raw(block: true, lang: "markdown", "## Installation

```bash
conda env create -f environment.yml
conda activate recette
python -m pip install -e .
```")
    ],
  )

  #legende[
    Le fichier dit ce dont la machine a besoin, le `README` dit dans quel
    ordre s'en servir. Aucun des deux n'installe quoi que ce soit.
  ]

  #notes[
    La phrase de la partie 4, démontrée ici : une installation se refait
    parce qu'un fichier la décrit, non parce qu'on se souvient de ce qu'on
    a tapé.

    Les deux fichiers ne se remplacent pas et ne disent pas la même chose.
    `environment.yml` liste ce qu'il faut poser ; le `README` donne l'ordre
    des étapes, y compris celle que le fichier ne peut pas porter,
    l'installation du projet lui-même.

    Rien n'est fourni : les sept lignes du YAML s'écrivent, l'indentation
    étant la seule difficulté, et la section du `README` se relit dans
    l'historique du terminal. Les déposer à la racine du projet, à côté de
    `pyproject.toml`.

    `pyproject.toml` déclare déjà `markdown` et `tabulate` : les réécrire
    dans `environment.yml` n'est pas un doublon inutile, les deux fichiers
    ne s'adressant pas au même outil. Le dire si la question vient.
  ]
]
#d("Refaire l'environnement à partir du fichier")[
  #annonce[
    Rien ne prouve qu'une documentation est juste tant que personne ne l'a
    suivie. On efface l'environnement, et on le refait en lisant la sienne.
  ]

  #tableau(
    columns: (auto, 1.3fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [8], [`conda deactivate`, puis `conda env remove -n recette`],
      reponse[l'environnement d'essai disparaît, le projet reste],
    [9], [`conda env create -f environment.yml`],
      reponse[les trois paquets s'installent d'un coup],
    [10], [`conda activate recette`, puis `python -m pip install -e .`],
      reponse[le projet à nouveau importable],
    [11], [`python recette_a_la_main.py`],
      reponse[la même page, sur un environnement refait de zéro],
  )

  #legende[
    Les étapes 9 et 10 sont celles que vous venez d'écrire dans le `README`.
    S'il en manque une ici, c'est qu'elle manque aussi là-bas.
  ]

  #notes[
    Étape 8 : la suppression n'est pas une précaution de ménage. Le fichier
    porte `name: recette`, et `conda env create` refuse d'écraser un
    environnement du même nom. Le conflit est le moyen de vérifier que le
    fichier recrée tout, et non qu'il complète ce qui restait.

    Se déplacer hors de l'environnement avant de le supprimer, sans quoi
    conda refuse aussi. `conda deactivate` rend la main à `base`.

    Étape 9, à faire remarquer : une commande là où il en fallait deux à
    l'aller, et le nom de l'environnement n'est plus tapé, il est lu dans
    le fichier.

    Étape 11 : c'est le seul moment du TD où ils vérifient leur propre
    documentation. Faire circuler entre les postes plutôt que projeter :
    les oublis sont individuels, une étape sautée dans le `README` se voit
    ici et nulle part ailleurs.

    Pour ceux qui vont vite : la commande `recette` existe depuis
    l'étape 10, équivalente à `python -m recette`, et accepte
    `--personnes` et `--unites`. C'est `[project.scripts]`, sujet du
    cours 3. Et le `README` du projet demande de documenter
    `recette_avec_tabulate.py`, resté sans docstring.

    Rendre la main en fin de séance : `conda activate base`.
  ]
]
