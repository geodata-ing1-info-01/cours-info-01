// TD 4c du cours 4 — « La fenêtre du train ».
//
// Compilable seul par `outils/compiler_tds.py`, qui en tire la feuille
// `td_4c_train.pdf`. Les étapes en résumé : le détail, avec le code à coller,
// est dans le guide `guide_4c_train.pdf`. Les étapes A sont celles des TD 4a
// et 4b, gardés comme propositions ; la partie B suit la composition d'une
// image (fond, fenêtre, plan), sur deux branches.
// Inclus par `cours4.typ` : le TD du parcours avancé.
#import "../../../commun/prelude.typ": *
#import "../../../cours4/diapo/schemas.typ": tableau-etapes

#let td = (
  numero: "4c",
  titre: "La fenêtre du train",
  annonce: "Objectif : construire par étapes un programme qui produit une vidéo, dans un environnement dédié et un dépôt git, avec deux fonctionnalités développées sur deux branches",
  dossier: "cours4/4c_train/",
  duree: "105′",
)
#separateur-td(..td)

// Les étapes A sont celles des TD 4a et 4b ; la partie B suit les étapes de
// la composition, sur deux branches réunies par une fusion avec conflit.
#d("A1 à A3 · L'environnement animation")[
  #annonce[
    Dans VS Code, avec un terminal Git Bash : rendre `conda` disponible,
    créer l'environnement `animation`, l'activer, vérifier les deux outils.
  ]
  #tableau-etapes(
    [A1], [décompresser `info01-cours4.zip` sur le Bureau ; ouvrir `cours4/4c_train/` dans VS Code ; terminal Git Bash], [`pwd` se termine par `cours4/4c_train`],
    [A2], [une fois par poste : `source /c/ProgramData/anaconda3/etc/profile.d/conda.sh`, `conda init bash`, nouveau terminal ; puis dans `depart/` : `conda env create -f environment.yml`], [invite `(base)` ; `conda env list` affiche `animation`],
    [A3], [`conda activate animation` ; `magick -version`, `ffmpeg -version`], [l'invite commence par `(animation)` ; les deux versions s'affichent],
  )
  #legende[Guide, étapes A1 à A3. La création télécharge les paquets : plusieurs minutes.]
]

#d("A4 · Le notebook")[
  #annonce[
    La section 1 du notebook décrit la composition d'une image ; les
    sections 3 à 7 la fabriquent étape par étape.
  ]
  #tableau-etapes(
    [1], [copier `depart/notebook/train.ipynb` dans `travail/` ; `cd travail`, `jupyter lab`], [JupyterLab s'ouvre sur `travail/`],
    [2], [exécuter le notebook, section par section], [section 2 : trois chemins dans `envs\animation` ; section 9 : la vidéo],
  )
  #legende[Guide, étape A4. Ne pas lancer JupyterLab depuis Navigator : `magick` n'y est pas trouvé.]
]

#d("B0 et B1 · Le projet, puis le fond sur master")[
  #annonce[
    Dans un second terminal Git Bash, `conda activate animation`. Le fond est
    la base commune des deux branches qui suivent.
  ]
  #tableau-etapes(
    [B0], [`travail/train/` avec `environment.yml` et `decor/` ; `git init` ; `.gitignore`, `README.md` ; un commit], [`git log --oneline` : une ligne],
    [B1], [`train.py` : `arguments_fond`, `image`, `taille`, puis `main` ; un commit sur `master`], [`python train.py` écrit `sortie/train.png` et affiche `640x480`],
  )
]

#d("B2 et B3 · La fenêtre et le plan, sur deux branches")[
  #annonce[
    Les branches `fenetre` et `plan` partent du même commit, celui du fond.
  ]
  #tableau-etapes(
    [B2], [`git checkout -b fenetre` ; `arguments_fenetre` et sa ligne dans `image` ; un commit], [la fenêtre posée sur le fond],
    [B3], [`git checkout master` ; `git checkout -b plan` ; le plan posé sur le fond ; un commit], [les voiles et la plage sur le fond],
    [], [l'option `--decalage`, découpage à la colonne du décalage ; un commit], [à 1~500, la plage s'arrête à 420 pixels],
    [], [`-roll` : la bande tourne avant le découpage ; un commit], [à 1~500, la plage traverse l'image],
  )
]

#d("B4 · Réunir les deux branches : un conflit")[
  #annonce[
    Les deux branches ont modifié `image` au même endroit : la fusion de
    `plan` s'arrête sur un conflit.
  ]
  #tableau-etapes(
    [1], [`git checkout master` ; `git merge fenetre`], [`Fast-forward`],
    [2], [`git merge plan`], [`CONFLICT (content): Merge conflict in train.py`],
    [3], [garder les deux fonctions, `decalage`, et les deux lignes : le plan, puis la fenêtre], [aucun marqueur ; l'image complète],
    [4], [`git add train.py` ; `git commit --no-edit`], [un commit de fusion ; sept commits],
  )
  #legende[Guide, étape B4 : le texte du conflit et la version qui réunit les deux.]
]

#d("B5 à B8 · La série, la vidéo, le README")[
  #annonce[
    La série et la vidéo se développent chacune sur sa branche, fusionnée en
    avance rapide.
  ]
  #tableau-etapes(
    [B5], [branche `serie` : `decalages` et `serie`, puis `--images` ; fusion], [`sortie/images/` ; neuf commits],
    [B6], [branche `video` : `assembler`, `--video`, `--cadence`, puis `--nettoyer` ; fusion], [`sortie/train.mp4` ; onze commits],
    [B7], [README complété à partir de `depart/modeles/README.md` ; un commit], [douze commits],
    [B8], [facultatif : `src/`, `pyproject.toml`, `pip install -e .`], [la commande `train` ; treize commits],
  )
  #legende[Annexe du guide : plusieurs plans, chacun avec sa vitesse.]
]
