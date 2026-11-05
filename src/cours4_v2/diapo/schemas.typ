// Schémas propres au cours 4 : les étapes du programme final de chaque TD,
// de la ligne de commande à la vidéo, avec des images de la vidéo produite.
//
// Servent deux fois : dans les diapositives (`cours4.typ`) et, compilés en
// PNG par `schema_programme.typ`, en tête du notebook de chaque TD.
#import "../../commun/prelude.typ": *

// La couleur de l'outil qui fait l'étape : Python dans la couleur du texte,
// les deux programmes en ligne de commande dans la couleur des TD.
#let couleur-outil(outil) = if outil == "Python" { accent } else { brun }

#let case-etape(numero, titre, outil, detail, hauteur: auto) = block(
  width: 100%, height: hauteur, inset: (x: 7pt, y: 6pt), fill: white,
  stroke: 1pt + couleur-outil(outil).lighten(45%),
)[
  #text(size: 11pt, weight: demi-gras, fill: couleur-outil(outil))[#numero · #outil]
  #v(0.2em)
  #text(size: 13.5pt, weight: demi-gras)[#titre]
  #v(0.2em)
  #text(size: 11pt, fill: estompe)[#detail]
]

// Les étapes, de gauche à droite, puis une bande d'images de la vidéo.
#let programme(etapes, vignettes, legendes, video, hauteur-vignette: auto) = {
  // Toutes les cases prennent la hauteur de la plus haute, mesurée à la
  // largeur qu'elles occuperont, comme dans `chaine`.
  layout(dispo => context {
    let n = etapes.len()
    let ecart = 14pt
    let largeur = (dispo.width - ecart * (n - 1)) / n
    let hauteur = calc.max(..etapes.map(e => measure(case-etape(..e), width: largeur).height))
    let colonnes = ()
    let cases = ()
    for (i, e) in etapes.enumerate() {
      if i > 0 {
        colonnes.push(ecart)
        cases.push(align(center + horizon, text(size: 18pt, fill: accent)[→]))
      }
      colonnes.push(largeur)
      cases.push(case-etape(..e, hauteur: hauteur))
    }
    grid(columns: colonnes, rows: hauteur, ..cases)
  })
  v(6pt)
  text(size: 11pt, fill: estompe)[Images écrites à l'étape 4 dans `sortie/images/`, puis la vidéo écrite à l'étape 5 :]
  v(2pt)
  grid(
    columns: (1fr,) * vignettes.len() + (auto,),
    column-gutter: 6pt,
    align: center + horizon,
    ..vignettes.zip(legendes).map(((chemin, legende)) => stack(
      spacing: 3pt,
      if hauteur-vignette == auto { image(chemin, width: 100%) } else { image(chemin, height: hauteur-vignette) },
      text(size: 10.5pt, fill: estompe)[#legende],
    )),
    text(size: 12pt, fill: brun, weight: demi-gras)[→ #video],
  )
}

#let programme-montre(hauteur-vignette: auto) = programme(
  (
    ("1", "Lire les options", "Python", [`argparse` : l'heure de départ, le nombre de minutes, la cadence]),
    ("2", "Préparer le cadran", "Python", [le boîtier, les chiffres, 60 graduations placées par `sin` et `cos`]),
    ("3", "Placer les aiguilles", "Python", [pour chaque minute, l'angle des deux aiguilles]),
    ("4", "Dessiner chaque image", "ImageMagick", [`magick` et `-draw` : une image par minute]),
    ("5", "Assembler la vidéo", "ffmpeg", [120 images, 12 par seconde : 10 secondes]),
  ),
  range(1, 6).map(i => "/illustrations/cours4/montre_" + str(i) + ".jpg"),
  ("10 h 00", "10 h 30", "11 h 00", "11 h 30", "11 h 59"),
  [`montre.mp4`],
  hauteur-vignette: hauteur-vignette,
)

#let programme-tourbillon(hauteur-vignette: auto) = programme(
  (
    ("1", "Lire les options", "Python", [`argparse` : l'image, l'angle maximal, la cadence]),
    ("2", "Réduire l'image", "ImageMagick", [`magick` et `-resize` : 640 pixels de large]),
    ("3", "Calculer les angles", "Python", [0, 15, 30 … 360, puis retour à 0 : 49 angles]),
    ("4", "Tordre chaque image", "ImageMagick", [`magick` et `-swirl` : une image par angle]),
    ("5", "Assembler la vidéo", "ffmpeg", [49 images, 12 par seconde : 4 secondes]),
  ),
  range(1, 6).map(i => "/illustrations/cours4/tourbillon_" + str(i) + ".jpg"),
  ("0°", "90°", "180°", "270°", "360°"),
  [`tourbillon.mp4`],
  hauteur-vignette: hauteur-vignette,
)

#let programme-train(hauteur-vignette: auto) = programme(
  (
    ("1", "Lire les options", "Python", [`argparse` : le nombre d'images, la cadence, le dossier du décor]),
    ("2", "Calculer les décalages", "Python", [0, 8, 16 … pixels : un décalage par image]),
    ("3", "Décaler le plan", "ImageMagick", [`-roll` : la bande de 1 920 pixels revient au début]),
    ("4", "Composer chaque image", "ImageMagick", [`-composite` : le fond, le plan décalé, la fenêtre]),
    ("5", "Assembler la vidéo", "ffmpeg", [120 images, 12 par seconde : 10 secondes]),
  ),
  range(1, 6).map(i => "/illustrations/cours4/train_" + str(i) + ".jpg"),
  ("0 px", "240 px", "480 px", "720 px", "952 px"),
  [`train.mp4`],
  hauteur-vignette: hauteur-vignette,
)

// ---------------------------------------------------------------------------
// Les étapes des TD 4a et 4b, en résumé : une diapositive par groupe
// d'étapes, « ce qu'il faut faire » et « ce que vous devez obtenir ». Le
// guide A4 du TD (`src/cours4/notebook/td/<td>/guide.md`) détaille chaque
// étape avec le code à coller ; ces diapositives sont pour qui n'en a pas
// besoin. Les deux TD appellent la même fonction : leurs étapes restent
// identiques, seuls le nom du programme, les données et les options changent.
//
//   nom        : "montre" ou "tourbillon"
//   td         : "4a_montre" ou "4b_tourbillon"
//   copie      : ce qu'il faut copier dans le dossier du projet, en plus
//                d'`environment.yml` (contenu, ou none)
//   b1         : (commande d'essai, fichier écrit) de la fonctionnalité « une image »
//   b2         : (commande d'essai, option, fonctions ajoutées) de « une série »
//   b3         : la commande d'essai de « la vidéo »
#let tableau-etapes(..lignes) = tableau(
  columns: (auto, 1.25fr, 1fr),
  align: left + horizon,
  [], [Ce qu'il faut faire], [Ce que vous devez obtenir],
  ..lignes,
)

#let etapes-animation(nom, td, copie, b1, b2, b3) = {
  let py = nom + ".py"

  d("A1 à A3 · L'environnement animation")[
    #annonce[
      Dans VS Code, avec un terminal Git Bash : rendre `conda` disponible,
      créer l'environnement `animation`, l'activer, vérifier les deux outils.
    ]
    #tableau-etapes(
      [A1], [décompresser `info01-cours4.zip` sur le Bureau ; ouvrir #raw("cours4/" + td + "/") dans VS Code ; terminal Git Bash], [`pwd` se termine par #raw("cours4/" + td)],
      [A2], [une fois par poste : `source /c/ProgramData/anaconda3/etc/profile.d/conda.sh`, `conda init bash`, nouveau terminal ; puis dans `depart/` : `conda env create -f environment.yml`], [invite `(base)` ; `conda env list` affiche `animation`],
      [A3], [`conda activate animation` ; `magick -version`, `ffmpeg -version`], [l'invite commence par `(animation)` ; les deux versions s'affichent],
    )
    #legende[Guide, étapes A1 à A3. La création télécharge les paquets : plusieurs minutes.]
  ]

  d("A4 · Le notebook")[
    #annonce[
      JupyterLab est lancé depuis le terminal Git Bash, l'environnement
      `animation` actif : c'est ainsi que le notebook trouve `magick` et
      `ffmpeg`.
    ]
    #tableau-etapes(
      [1], [copier #raw("depart/notebook/" + nom + ".ipynb") dans `travail/` ; `cd travail`, `jupyter lab`], [JupyterLab s'ouvre sur `travail/`],
      [2], [exécuter le notebook, section par section], [section 1 : trois chemins dans `envs\animation` ; section 6 : la vidéo],
    )
    #legende[Guide, étape A4. Ne pas lancer JupyterLab depuis Navigator : `magick` n'y est pas trouvé.]
  ]

  d("B0 · Le projet et le dépôt git")[
    #annonce[
      Dans un second terminal Git Bash (le premier fait tourner JupyterLab) :
      `conda activate animation`, puis le dossier du projet.
    ]
    #tableau-etapes(
      [1], [`mkdir` #raw("travail/" + nom) ; y copier `depart/environment.yml`#if copie != none [ et #copie] ; `cd` dans le dossier], [l'invite se termine par #raw("travail/" + nom)],
      [2], [`git init` ; `echo "sortie/" > .gitignore` ; un `README.md` d'une ligne], [`git status` : les fichiers non suivis, sans `depart/`],
      [3], [`git add .` ; `git commit -m "Le projet : environnement, .gitignore et README"`], [`git log --oneline` : une ligne],
    )
    #legende[La suite construit le programme fonctionnalité par fonctionnalité, une branche git par fonctionnalité.]
  ]

  d("B1 · Une image, sur la branche une-image")[
    #annonce[
      Le programme dessine une image. Il a dès le départ une fonction `main`
      et lit ses options avec `argparse`.
    ]
    #tableau-etapes(
      [1], [`git checkout -b une-image`], [`git branch` : `* une-image`],
      [2], [#raw(py) : les imports, les outils, les fonctions de dessin du notebook ; un commit], [#raw("python " + py) n'affiche rien, sans erreur],
      [3], [la fonction `main` et les options ; `git commit -am "…"`], [#raw(b1.at(0)) écrit #raw(b1.at(1))],
      [4], [`git checkout master` ; `git merge une-image`], [`Fast-forward` ; trois commits],
    )
  ]

  d("B2 · Une série d'images, sur la branche serie")[
    #annonce[
      Le programme écrit une image par valeur du paramètre dans
      `sortie/images/`. Sans la nouvelle option, il écrit toujours une image
      seule.
    ]
    #tableau-etapes(
      [1], [`git checkout -b serie`], [`git branch` : `* serie`],
      [2], [#b2.at(2), sous les fonctions de dessin ; un commit], [#raw("python " + py + " --help") fonctionne comme avant],
      [3], [l'option #raw(b2.at(1)) dans `main` ; un commit], [#raw(b2.at(0)) remplit `sortie/images/`],
      [4], [`git checkout master` ; `git merge serie`], [`Fast-forward` ; cinq commits],
    )
  ]

  d("B3 · La vidéo, et un commit de fusion")[
    #annonce[
      ffmpeg assemble la série en vidéo. Pendant ce travail, un commit est
      fait sur `master` : la fusion crée un commit de fusion.
    ]
    #tableau-etapes(
      [1], [`git checkout -b video` ; la fonction `assembler`, les options `--video` et `--cadence` ; un commit], [#raw(b3) écrit #raw("sortie/" + nom + ".mp4")],
      [2], [`git checkout master` ; compléter le README ; un commit ; `git checkout video`], [le README de `master` décrit une image et la série],
      [3], [`import shutil` ; la fonction `nettoyer` et l'option `--nettoyer` ; un commit], [`sortie/images/` est supprimé après la vidéo],
      [4], [`git checkout master` ; `git merge --no-edit video`], [`Merge made by the 'ort' strategy.` ; neuf commits],
    )
    #legende[`git log --oneline --graph --all` dessine les deux branches et le commit de fusion.]
  ]

  d("B4 et B5 · README, commande installée")[
    #annonce[
      Le README décrit les trois fonctionnalités. L'étape B5, facultative,
      fait du script une commande #raw(nom).
    ]
    #tableau-etapes(
      [B4], [copier `depart/modeles/README.md` sur le README et le compléter ; `git commit -am "README complet"`], [`git log --oneline` : dix lignes],
      [B5], [#raw("git mv " + py + " src/" + py) ; copier `depart/modeles/pyproject.toml` ; `pip install -e .`], [#raw("Successfully installed " + nom + "-0.1")],
      [], [#raw(nom + " --help") depuis un autre dossier ; `git add .` ; commit], [l'aide s'affiche ; onze lignes dans `git log`],
    )
    #legende[Le rendu : le dossier #raw("travail/" + nom + "/") et son historique git.]
  ]
}
