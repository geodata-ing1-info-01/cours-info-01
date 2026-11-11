// Clôture du cours 5 v2 — incluse en dernier par `cours5_v2.typ`. Un fichier inclus
// n'hérite pas des imports de son appelant.
//
// Remplace « Au cours 6 : compte GitHub et clé SSH » (05/11/2026) : les mots de passe et
// les clés passent au cours 6.
//
// « À retenir » : trois aide-mémoire, sur le modèle des cours 1, 2 et 3 v2 (10/11/2026), à la
// place d'une diapositive unique. Les lignes reprennent les mots des diapositives de l'exposé :
// partie 2 pour les programmes, partie 3 pour les bibliothèques, parties 4 et 5 pour
// l'environnement, le projet et le noyau. Deux colonnes sur toute la largeur, et non quatre
// comme au cours 3 : certaines commandes sont trop longues pour un quart de diapositive.
#import "../../../commun/prelude.typ": *
#import "../../../commun/schemas_github.typ": page-depot, menu-code, pastille
#import "../../../cours1_v2/diapo/schemas.typ": consignes, comment, terminal

// Un aide-mémoire : des rubriques, chacune avec son titre puis ses lignes (code, effet).
#let aide-memoire(..rubriques) = {
  show table.cell: set text(size: 14pt)
  show raw: set text(size: 12.5pt)
  let cellules = ()
  for (titre, lignes) in rubriques.pos() {
    cellules.push(table.cell(colspan: 2, fill: gris.lighten(45%), text(weight: demi-gras, titre)))
    for (code, effet) in lignes {
      cellules.push(code)
      cellules.push(effet)
    }
  }
  tableau(entete: false, columns: (auto, 1fr), align: left + horizon, inset: (x: 9pt, y: 5pt), ..cellules)
}

#separateur(
  "À retenir",
  annonce: "Récapituler l'appel d'un programme, l'installation d'une bibliothèque et l'environnement d'un projet.",
)

// --------------------------------------------
#d("Aide-mémoire : programmes et PATH")[
  #aide-memoire(
    ([Appel depuis Python : `subprocess`], (
      ([`import subprocess`], [importe le module, livré avec Python]),
      ([`subprocess.run(commande)`], [lance le programme ; la commande est une liste, un élément par mot]),
      ([`check=True`], [lève `CalledProcessError` si le programme échoue]),
      ([`FileNotFoundError`], [levée si le programme est introuvable]),
    )),
    ([Recherche d'un programme : `PATH`], (
      ([`PATH`], [liste les dossiers où chercher une commande, dans l'ordre]),
      ([`which ogr2ogr`], [affiche le chemin du programme trouvé]),
      ([`echo "$PATH"`], [affiche la liste ; `:` sépare les dossiers dans Git Bash]),
      ([`export PATH="…:$PATH"`], [place un dossier en tête, pour ce terminal et les programmes qu'il lance]),
    )),
  )

  #legende[
    Une commande qui contient un `/` est lancée sans passer par `PATH`. Un chemin relatif part du
    dossier du terminal.
  ]

  #notes[
    Pour quelques lignes, faire retrouver la diapositive ou l'étape du TD correspondante.
  ]
]

// --------------------------------------------
#d("Aide-mémoire : bibliothèques")[
  #aide-memoire(
    ([Installation], (
      ([`pip install folium`], [télécharge le paquet depuis PyPI, et l'installe avec ses dépendances]),
      ([`pip show folium`], [affiche la version, le dossier et les dépendances]),
      ([PyPI, conda-forge], [les dépôts de `pip` et de `conda`]),
      ([résolution], [le choix d'une version de chaque paquet, compatible avec toutes les exigences]),
    )),
    ([Recherche par `import`], (
      ([`import folium`], [charge la bibliothèque ; `ModuleNotFoundError` si elle manque]),
      ([bibliothèque standard], [livrée avec Python : `pathlib`, `subprocess`, `argparse`]),
      ([`sys.path`], [liste les dossiers où `import` cherche, dans l'ordre]),
      ([`site-packages`], [contient les bibliothèques installées]),
    )),
  )

  #legende[
    `pip` n'installe ni `ogr2ogr` ni la bibliothèque compilée de GDAL, absents de PyPI. `conda` les
    installe depuis conda-forge.
  ]
]

// --------------------------------------------
#d("Aide-mémoire : environnement et projet")[
  #aide-memoire(
    ([Environnement : `conda`], (
      ([environnement], [le dossier d'un projet, avec son Python et ses paquets]),
      ([`conda activate carte`], [place son dossier en tête de `PATH`, pour ce terminal]),
      ([`conda env create -f environment.yml`], [recrée l'environnement que décrit le fichier]),
      ([`which python`, `sys.executable`], [donnent l'interpréteur lancé]),
    )),
    ([Fichiers de projet et noyau], (
      ([`environment.yml`], [Python, bibliothèques et programmes, lu par `conda`]),
      ([`pyproject.toml`], [nom, version et dépendances PyPI du projet, lu par `pip`]),
      ([`pip install .`], [installe le projet du dossier courant et ses dépendances]),
      ([`python -m ipykernel install --user --name carte`], [déclare le noyau de `carte`, l'interpréteur qui exécute les cellules d'un notebook]),
    )),
  )

  #legende[
    Les autres commandes de `conda` sont sur « Commandes conda : résumé », partie 4.
  ]

  #notes[
    Le cours 6 reprend la distribution du code par une forge, et l'accès à ce code.
  ]
]

// --------------------------------------------
// Ajouté le 10/11/2026 : le compte GitHub se crée avant la séance 6, hors du réseau de
// l'école. En 2026, GitHub a refusé une partie des inscriptions faites ensemble dans la
// salle : derrière le proxy, tous les postes ont la même adresse IP. Les deux diapositives
// suivantes montrent ce que les séances 6 et 7 emploient d'un dépôt.
#separateur(
  "Avant la séance 6 : un compte GitHub",
  annonce: "Créer son compte chez soi, et repérer sur la page d'un dépôt l'adresse à donner à git.",
)

// --------------------------------------------
#d("Création d'un compte GitHub")[
  #objectif[
    créer un compte GitHub avant la séance 6, depuis un autre réseau que celui de l'école, et y
    activer le deuxième facteur.
  ]

  #consignes(
    taille: 15pt,
    [Se connecter à un autre réseau que celui de l'école : la box de chez soi, ou le partage de connexion de son téléphone. #comment[Derrière le proxy de l'école, tous les postes ont la même adresse IP, et GitHub refuse les inscriptions trop nombreuses depuis une même adresse.]],
    [Aller sur `github.com/signup`, puis saisir son adresse e-mail, un mot de passe et un nom de compte. #comment[Le nom de compte figure dans l'adresse de tous ses dépôts : choisir un nom sobre, par exemple `prenom-nom`.]],
    [Saisir le code reçu par e-mail.],
    [Activer le deuxième facteur avec une application à codes, puis garder les codes de secours. #comment[Menu du compte, Settings, Password and authentication.]],
    [Vérifier que la page `github.com/<compte>` affiche son profil.],
  )

  #notes[
    Novembre 2026, salle de TD : GitHub a refusé une partie des inscriptions faites ensemble.
    Les postes sortent par le proxy de l'école, sous une seule adresse IP, et les systèmes
    anti-abus des sites bloquent les inscriptions nombreuses venues d'une même adresse. Ne
    pas faire créer les comptes en séance.

    GitHub impose un deuxième facteur aux comptes qui publient du code (depuis 2023) :
    diapositive « Authentification à deux facteurs », cours 6. Sans les codes de secours, la
    perte du téléphone fait perdre le compte.

    Le compte est personnel : l'adresse de l'école peut être remplacée plus tard.
  ]
]

// --------------------------------------------
#d("Page d'un dépôt GitHub")[
  #annonce[
    Un dépôt GitHub appartient à un compte. Sa page montre les fichiers de la dernière
    version, et donne l'adresse du dépôt pour `git clone`.
  ]

  #grid(
    columns: (1.3fr, 1fr), column-gutter: 18pt, align: horizon,
    text(size: 13pt, page-depot("geodata-ing1-info-01", "cours-info-01",
      fichiers: ("data/", "outils/", "src/", "README.md", "STYLE.md"),
      reperes: (nom: 1, pr: 2, code: 3))),
    [
      #set text(size: 15pt)
      #pastille(1) le compte, puis le nom du dépôt, repris dans l'adresse de la page

      #pastille(2) les pull requests : les modifications proposées, à fusionner (séance 7)

      #pastille(3) le bouton Code, qui donne l'adresse du dépôt
    ],
  )

  #notes[
    Le dépôt des supports du module, public : la page existe, la montrer en direct si le
    réseau le permet.

    Un dépôt public se lit et se clone sans compte. Le compte sert à pousser des commits et
    à ouvrir une pull request.
  ]
]

// --------------------------------------------
#d("Adresse HTTPS d'un dépôt")[
  #annonce[
    Le bouton Code, onglet HTTPS, donne l'adresse du dépôt, en
    `https://github.com/<compte>/<dépôt>.git`. `git clone` copie le dépôt à cette adresse.
  ]

  #text(size: 14pt, menu-code("https://github.com/geodata-ing1-info-01/cours-info-01.git", repere: 1))
  #v(0.9em)
  #terminal(
    taille: 15pt,
    "$ git clone https://github.com/geodata-ing1-info-01/cours-info-01.git",
    "Clonage dans 'cours-info-01'...",
  )

  #legende[
    #pastille(1) copier l'adresse, puis la coller après `git clone`. L'onglet SSH donne une
    adresse en `git@github.com:…`, qui passe par le port 22, fermé par le pare-feu de l'école :
    en salle, prendre l'adresse HTTPS.
  ]

  #notes[
    HTTPS passe par le port 443, comme les pages web, donc par le proxy de l'école.

    Un dépôt public se clone en HTTPS sans s'identifier. Le premier `git push` demande le
    compte et un token (cours 6), à la place du mot de passe.
  ]
]
