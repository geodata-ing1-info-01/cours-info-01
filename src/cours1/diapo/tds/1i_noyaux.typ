// TD 1i — « Le client, le noyau, et où ils sont installés », facultatif.
//
// Inclus par `cours1.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`, qui
// en tire la feuille de TD déposée dans le dossier annoncé. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "1i",
  titre: "Le client, le noyau, et où ils sont installés",
  annonce: "Objectif : installer de quoi ouvrir un notebook de deux façons, le client et le noyau au même endroit ou séparés",
  dossier: "cours1/1i_noyaux/",
  duree: "20′",
  statut: "facultatif",
)
#separateur-td(..td)
#d("Ce que l'environnement contient, et ce qui manque")[
  #annonce[
    Un notebook demande deux choses : un *client*, qui affiche la page, et un
    *noyau*, qui exécute les cellules.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [`conda list -n base jupyterlab ipykernel`],
      reponse[les deux avec Anaconda, aucun des deux avec Miniforge],
    [2], [`conda activate recette`, celui du TD 1h, puis `jupyter lab`],
      reponse[commande introuvable : pas de client dans cet environnement],
    [3], [dans VSCode, ouvrir `altitudes.ipynb` et choisir `recette` comme noyau],
      reponse[l'éditeur propose d'installer `ipykernel` : pas de noyau non plus],
  )

  #legende[
    Le TD 1g marchait sans rien installer parce que les postes de la salle ont
    Anaconda, dont l'environnement `base` porte les deux. Une installation
    Miniforge part d'un `base` minimal.
  ]

  #notes[
    Étape 1, la réponse dépend de l'installation et c'est le propos : la
    distribution Anaconda pose plus de six cents paquets dans `base`,
    JupyterLab et `ipykernel` compris ; Miniconda et Miniforge n'y mettent
    que conda, Python et leurs dépendances. Les postes de la salle ont
    Anaconda, un portable personnel a souvent Miniforge, et le même TD 1g s'y
    comporte autrement.

    La leçon est la démarche, pas la réponse : on vérifie ce qu'un environnement
    contient, on ne le suppose pas. `conda list` accepte des motifs, donc
    pas besoin de `grep`, qui n'existe pas sous Windows.

    Étape 2 : `jupyter lab` n'est pas une commande du système, c'est un
    programme de l'environnement actif. `recette` n'a que Python, `markdown`
    et `tabulate` — ils l'ont fabriqué eux-mêmes au TD 1h, et savent donc
    exactement ce qu'il contient.

    Étape 3, le même manque vu de l'autre côté : le client, ici VSCode, est
    installé une fois pour toutes ; c'est le noyau qui manque dans
    l'environnement visé. Refuser la proposition de l'éditeur pour
    l'instant, la suite installe à la main.
  ]
]
#d("Tout dans le même environnement")[
  #annonce[
    La façon la plus simple : poser le client dans l'environnement du projet.
    Il entraîne le noyau avec lui, et les deux moitiés sont au même endroit.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [4], [`conda install -n recette -c conda-forge jupyterlab`],
      reponse[`ipykernel` s'installe avec, sans qu'on l'ait demandé],
    [5], [`conda activate recette`, puis `jupyter lab`],
      reponse[une adresse `localhost` s'affiche, et le client démarre],
    [6], [ouvrir `altitudes.ipynb`, et lire le noyau en haut à droite],
      reponse[`Python 3 (ipykernel)`, celui de `recette`],
    [7], [fermer l'onglet, puis `Ctrl` + `C` deux fois dans le terminal],
      reponse[le serveur s'arrête, et la page ne répond plus],
  )

  #legende[
    C'est la configuration du TD 1g, refaite à la main : `jupyterlab` déclare
    `ipykernel` dans ses dépendances, donc l'installer une fois suffit.
  ]

  #notes[
    Étape 4, à rapprocher du TD 1h : un paquet demandé, plusieurs dizaines
    installés. `ipykernel` en fait partie sans figurer sur la ligne de
    commande — dépendance transitive, troisième rencontre.

    Le défaut de cette façon, à énoncer sans la condamner : un client par
    projet. Cinq projets, cinq JupyterLab installés, et autant de mises à
    jour. Cela ne gêne personne sur un poste de TP, et devient pesant en
    stage : d'où la diapositive suivante.

    Étape 5 : Navigator faisait ces deux étapes à votre place, en choisissant
    l'environnement affiché en haut de sa page d'accueil. Le terminal
    l'expose, la fiche le cachait.

    Étape 7, à ne pas sauter : le serveur tourne tant que le terminal est
    ouvert. Fermer l'onglet du navigateur ne l'arrête pas, et c'est la cause
    la plus fréquente des « ports déjà pris » de la semaine suivante.
  ]
]
#d("Le client d'un côté, le noyau de l'autre")[
  #annonce[
    L'autre façon : un client installé une fois, et un environnement par projet
    qui se déclare auprès de lui. C'est celle qu'on trouve en stage.
  ]

  #tableau(
    columns: (auto, 1.6fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [8], [`conda create -n altitudes -c conda-forge python=3.12 ipykernel numpy`], [],
    [9], [`conda run -n altitudes python -m ipykernel install --user --name altitudes`],
      reponse[`Installed kernelspec altitudes`],
    [10], [`conda activate recette`, puis `jupyter kernelspec list`],
      reponse[deux noyaux, dont `altitudes`, qui n'est pas dans `recette`],
    [11], [ouvrir `altitudes.ipynb`, choisir le noyau `altitudes`, taper `import numpy`],
      reponse[l'import passe, alors que `recette` n'a pas `numpy`],
  )

  #legende[
    `altitudes` n'a pas `jupyterlab`, et n'en a pas besoin : le `kernel.json`
    écrit à l'étape 9 ne contient qu'un chemin,
    `…/envs/altitudes/bin/python`.
  ]

  #notes[
    Étape 9, à faire lire : le client ne devine pas les environnements. Il lit
    un dossier de déclarations, et `ipykernel install` y écrit un
    `kernel.json` qui n'est qu'un chemin vers un interpréteur. Ouvrir le
    fichier si le temps le permet, c'est trois lignes utiles.

    Étape 11, le point du TD : le client tourne dans `recette`, le code
    s'exécute dans `altitudes`. Les deux moitiés sont dans deux dossiers
    différents, et le notebook ne s'en aperçoit pas.

    VSCode est un client au même titre que JupyterLab, et il lit la même
    liste. C'est la réponse à « pourquoi VSCode me demande de choisir un
    noyau ».

    À retenir pour l'année : une bibliothèque manquante s'installe dans
    l'environnement du *noyau*, jamais dans celui du client. C'est le
    `ModuleNotFoundError` du TD 1h, dans sa version notebook.

    Rendre la main : `conda env remove -n altitudes`, et
    `jupyter kernelspec remove altitudes` pour retirer la déclaration.
  ]
]
#d("Le notebook du projet recette")[
  #annonce[
    `recette.ipynb` reprend le programme du TD 1h, une fonction par cellule et
    rien d'importé. Il lit les données du projet, et c'est à vous de lui dire
    où elles sont.
  ]

  #tableau(
    columns: (auto, 1.2fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [12], [ouvrir `recette.ipynb`, lire la première cellule],
      reponse[un chemin relatif, qui remonte d'un cran vers le TD 1h],
    [13], [commenter chaque ligne de cette cellule, puis l'exécuter],
      reponse[les deux fichiers de données sont listés],
    [14], [Noyau #sym.arrow.r Redémarrer et tout exécuter],
      reponse[la recette s'affiche mise en forme, tableau compris],
    [15], [changer `PERSONNES`, puis tout réexécuter],
      reponse[les quantités changent, la recette non],
  )

  #legende[
    Le noyau à choisir est celui de `recette` : c'est lui qui porte `markdown`
    et `tabulate`. Avec celui d'`altitudes`, les dernières cellules
    échoueraient.
  ]

  #notes[
    L'étape 13 est l'exercice, et elle vaut plus que les trois autres : ils
    commentent du code qu'ils n'ont pas écrit, ce qui oblige à le lire. Faire
    lire deux ou trois commentaires à voix haute, et refuser « on importe
    Path » au profit de ce que la ligne sert à faire ici.

    Le choix du noyau n'est plus une formalité à ce stade : deux noyaux sont
    déclarés, un seul convient. C'est la règle de la diapositive précédente,
    appliquée tout de suite.

    Le chemin relatif est celui de la partie 1 et du TD 1d, une troisième
    fois. Le notebook part de son propre dossier, remonte d'un cran, et
    redescend dans les données du TD 1h : il suppose donc que l'archive n'a
    pas été démontée, et que le projet recette a bien été copié dans
    `travail/`.

    L'`assert` est là pour que l'échec soit lisible. Sans lui, le message
    serait un `FileNotFoundError` sur le premier fichier ouvert, deux
    cellules plus bas, et la cause serait à chercher ailleurs qu'où elle est.

    Étape 14, à faire remarquer : redémarrer le noyau efface tout ce qu'il
    retenait. C'est ce qui départage « mon programme marche » de « ma
    page marche dans l'ordre où elle est écrite ».

    Toutes les fonctions sont dans le notebook, aucune n'est importée : il
    tourne donc aussi dans le navigateur, à condition d'y déposer les deux
    fichiers de données et de remplacer le chemin par `Path(".")`. C'est
    écrit dans le notebook.
  ]
]
