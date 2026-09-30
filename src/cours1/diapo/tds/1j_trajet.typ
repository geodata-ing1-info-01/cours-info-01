// TD 1j — « Installer un projet en lisant son README », facultatif.
//
// Inclus par `cours1.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`, qui
// en tire la feuille de TD déposée dans le dossier annoncé. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "1j",
  titre: "Installer un projet en lisant son README",
  annonce: "Objectif : installer et lancer un projet qu'on n'a pas écrit, sans autre consigne que sa documentation, et voir ce que la commande enchaîne",
  dossier: "cours1/1j_trajet/",
  duree: "15′",
  statut: "facultatif",
)
#separateur-td(..td)
#d("Installer un projet sur sa seule documentation")[
  #annonce[
    Le projet `trajet` fabrique une vidéo commentée du chemin de la gare à
    l'école. Aucune consigne ici : tout est dans son `README`.
  ]

  #tableau(
    columns: (auto, 1.2fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [copier `depart/trajet/` dans `travail/`, puis lire son `README`],
      reponse[une section « Installation », trois commandes],
    [2], [les taper, dans l'ordre],
      reponse[l'environnement `trajet_ensg`, puis le projet installé],
    [3], [`magick --version` et `ffmpeg -version`],
      reponse[deux programmes, qui ne sont pas des bibliothèques Python],
    [4], [`trajet`, puis ouvrir `trajet.mp4`],
      reponse[cinq étapes, vingt et une secondes, sous-titres incrustés],
  )

  #legende[
    `pyproject.toml` déclare zéro dépendance, et le projet ne tourne pourtant
    pas sans `environment.yml` : ce dont il dépend n'est pas du Python.
  ]

  #notes[
    Le TD est en fin de séance et se fait seul : c'est le seul du cours où
    l'énoncé est « débrouillez-vous avec la documentation ». Circuler plutôt
    que projeter.

    Ce qui est mesuré ici n'est pas la vidéo, c'est le `README`. Trois
    commandes et une vérification suffisent, parce que quelqu'un les a
    écrites et les a essayées, exactement ce qu'ils ont fait au TD 1h sur
    leur propre projet.

    Étape 3, le point de la diapositive : `ffmpeg` et ImageMagick sont des
    programmes, pas des paquets Python. `pip` ne sait pas les poser, `conda`
    si, et c'est la raison d'être des deux fichiers. Le faire lire dans
    `pyproject.toml`, où `dependencies` est une liste vide, commentée.

    Si la salle est sous Windows, l'installation fonctionne : c'est la
    différence avec la version précédente de ce TD, qui reposait sur un
    script bash. Le code appelle les deux programmes par `subprocess`, donc
    depuis Python, donc partout.

    Poste sans réseau : la création de l'environnement échoue. Faire lire le
    `README` et le code, et regarder la vidéo du voisin.
  ]
]
#d("Ce que la commande enchaîne")[
  #annonce[
    Quatre étapes, chacune produisant le fichier que la suivante consomme. Ce
    sont les trois modules de `src/trajet/`, appelés dans cet ordre.
  ]

  #tableau(
    columns: (auto, auto, 1fr, 1fr),
    align: left + horizon,
    [Étape], [Qui la fait], [Entrée], [Sortie],
    [lecture], [`etapes.py`], [`data/etapes.csv`],
      reponse[cinq étapes, en mémoire],
    [tracé], [`images.py`, par `magick`], [`data/carte.png` + les étapes],
      reponse[`etape_01.png` … `etape_05.png`],
    [commentaires], [`montage.py`], [les étapes et leurs durées],
      reponse[`trajet.srt` et `montage.txt`],
    [montage], [`montage.py`, par `ffmpeg`], [les images + le `.srt`],
      reponse[`trajet.mp4`, 21 secondes],
  )

  #legende[
    Les deux fichiers du milieu sont du texte : les ouvrir. `etapes.csv`, le
    `.csv` de la grille des extensions et le `content.xml` du `.odt` — trois
    fois le même constat, le contenu utile est du texte.
  ]

  #notes[
    L'argument n'est pas que la ligne de commande est meilleure. Il est que
    la deuxième exécution ne coûte rien d'un côté et tout de l'autre : refaire
    la vidéo à la souris, c'est tout recommencer ; ici, c'est corriger une
    ligne d'`etapes.csv` et relancer. Le faire faire.

    Faire ouvrir `trajet.srt` dans l'éditeur : du texte, lisible, produit par
    un programme et consommé par un autre. C'est le fichier comme unité
    d'échange entre logiciels, vu de près.

    Aucun des trois modules ne dépasse soixante lignes, et chacun ne fait
    qu'une chose. C'est la même découpe qu'au TD 1h : les regarder côte à
    côte si quelqu'un le demande.

    Le fond de carte n'est pas à retélécharger : le serveur de tuiles
    d'OpenStreetMap est un service bénévole, dont les conditions d'usage
    interdisent qu'une promotion entière le sollicite en même temps. C'est
    `carte.py`, lancé une fois avant la séance, qui l'a fabriqué.

    Les outils sont ceux du projet de la séance 4 : le TD n'est pas un
    détour, c'est une répétition.
  ]
]
#d("En option : les commandes, une à une")[
  #annonce[
    `outils_video.ipynb` reprend les commandes `magick` et `ffmpeg` du projet,
    isolées, avec leur résultat affiché sous chacune.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Ce que le notebook montre], [Ce qu'on y voit],
    [`subprocess.run`], [la commande donnée en liste, un élément par argument, donc aucun espace à protéger],
    [`magick identify`, `-resize`, `-draw`], [l'image produite, affichée dans la cellule qui l'a faite],
    [`ffprobe`, puis `ffmpeg -f concat`], [la liste de montage écrite à la main, et la vidéo qu'elle donne],
  )

  #legende[
    Ce notebook ne tourne pas dans le navigateur : `subprocess` demande au
    système de lancer un programme, ce qu'un navigateur ne fait pas. Il
    s'ouvre dans l'éditeur ou dans JupyterLab, `trajet_ensg` actif.
  ]

  #notes[
    Pour qui a fini, ou pour la maison. Le notebook sert à voir une commande
    et son résultat dans la même page, ce qu'un script ne montre pas.

    La restriction de JupyterLite est la contrepartie exacte de ce qui le
    rend commode au TD 1g : un onglet de navigateur n'a pas de système
    d'exploitation sous la main. Les bibliothèques Python pures s'y
    installent par `%pip install` ; un programme comme ffmpeg, non.

    La dernière cellule lance la commande `trajet` elle-même, avec
    `--carte` : l'occasion de montrer `--help` et les trois chemins que la
    commande accepte.
  ]
]
