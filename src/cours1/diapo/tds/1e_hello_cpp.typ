// TD 1e — « Le même programme en C++ ».
//
// Inclus par `cours1.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`, qui
// en tire la feuille de TD déposée dans le dossier annoncé. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "1e",
  titre: "Le même programme en C++",
  annonce: "Objectif : configurer l'éditeur pour un second langage, compilé, et comparer son programme à celui écrit en Python",
  dossier: "cours1/1e_hello_cpp/",
  duree: "10′",
  statut: "facultatif",
)
#separateur-td(..td)
#d("Installer l'extension C/C++")[
  #annonce[
    Un autre langage demande une autre extension. Celle-ci apporte la
    coloration, la vérification et un bouton d'exécution pour C et C++.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [L'action], [Ce qu'elle donne],
    [`Ctrl` + `Maj` + `X`, chercher « C/C++ »],
      [l'extension publiée par Microsoft, à installer],
    [Ouvrir `cours1/1e_hello_cpp/`, puis `bonjour.cpp`],
      [le code se colore, et les fautes d'écriture se soulignent],
  )

  #avertissement[
    L'extension n'apporte pas de compilateur. Elle sait lire le C++, pas le
    traduire : c'est l'objet de la diapositive suivante.
  ]

  #notes[
    C'est l'exemple qui généralise : un éditeur générique se configure langage
    par langage, et la démarche est la même que pour Python.

    L'avertissement est écrit dans la documentation de VSCode : « The C/C++
    extension doesn't include a C++ compiler or debugger, since VS Code as an
    editor relies on command-line tools for the development workflow. »
    C'est la confusion la plus coûteuse de la séance.
  ]
]
#d("Installer un compilateur")[
  #annonce[
    Python vient avec l'environnement du module. Un compilateur C++, non :
    Windows n'en fournit aucun.
  ]

  #tableau(
    columns: (auto, 1fr, 1.35fr),
    align: left + horizon,
    [], [Linux, macOS], [Windows],
    [Le compilateur],
      [`g++`, presque toujours déjà là],
      [aucun d'origine],
    [Comment l'obtenir],
      [rien à faire],
      [`conda install -c conda-forge "gxx=15.3.0"`],
    [Ce qu'on tape ensuite],
      [`g++ …`],
      [`x86_64-w64-mingw32-g++ …`],
  )

  #legende[
    L'environnement conda ne sert pas qu'à Python : il installe aussi des
    outils. La version est fixée parce que la dernière, 16.2.0, ne termine
    pas une compilation sous Windows : c'est la diapositive suivante.
  ]

  #notes[
    À faire avant la séance si possible : quelques minutes, et le réseau de la
    salle n'est pas garanti. À défaut, lancer l'installation au début du
    TD et enchaîner sur autre chose pendant ce temps.

    Le chemin officiel n'est pas celui-là. La documentation de VSCode fait
    installer MinGW-w64 par MSYS2, puis ajouter `C:\msys64\ucrt64\bin` au
    `PATH` de Windows. Il fonctionne, mais il modifie la machine et demande une
    installation de plus ; le module préfère l'environnement conda, déjà
    présent et supprimable d'une seule commande. Le dire si la question vient, et
    surtout si un étudiant arrive avec MSYS2 déjà installé : dans ce cas la
    commande est `g++`, comme sous Linux.

    Le nom de l'exécutable est le piège, à projeter : sous Windows,
    conda-forge installe `x86_64-w64-mingw32-g++.exe`, pas `g++`. C'est le nom
    complet de la cible, et il ne s'invente pas. Vérifié sur un poste de
    l'école en septembre 2026.

    La version fixée est le second piège, et il n'est pas de notre fait :
    `gxx` 16.2.0, la version que `conda install -c conda-forge gxx` prend par
    défaut, échoue à l'édition de liens sous Windows. Les versions 13.4.0,
    14.4.0 et 15.3.0 fonctionnent. Retirer la contrainte de version quand
    conda-forge aura corrigé le paquet.

    Ne pas employer `m2w64-toolchain`, encore présent dans de vieilles réponses
    en ligne : le paquet s'annonce lui-même obsolète.
  ]
]
#d("L'erreur crt2.o sous Windows")[
  #annonce[
    Avec la dernière version du paquet, la traduction du fichier réussit et
    l'assemblage du programme échoue : les fichiers de démarrage sont
    installés là où le compilateur ne les cherche pas.
  ]

  #fenetre("Terminal — cours1/1e_hello_cpp", code: true)[
    (info01) …\\1e_hello_cpp> x86_64-w64-mingw32-g++ bonjour.cpp -o bonjour.exe \
    ld.exe: cannot find crt2.o: No such file or directory \
    ld.exe: cannot find default-manifest.o: No such file or directory \
    collect2.exe: error: ld returned 1 exit status
  ]

  #legende[
    Relevé sur un poste de l'école en septembre 2026, avec `gxx` 16.2.0. La
    version 15.3.0 installée par la commande de la diapositive précédente ne
    montre pas l'erreur.
  ]

  #notes[
    Diapositive de secours : la passer si l'installation s'est faite avant la
    séance et que la compilation sort. Elle sert le jour où un poste a la
    version 16.2.0 malgré la contrainte, et elle vaut aussi comme lecture de
    message d'erreur, ce que la séance fait déjà au TD 1d.

    Ce que le message dit, dans l'ordre : c'est `ld`, l'éditeur de liens, qui
    parle, donc la compilation proprement dite a réussi ; `crt2.o` est le
    fichier de démarrage que tout programme Windows reçoit avant `main`. Il
    est bien installé, dans
    `%CONDA_PREFIX%\Library\x86_64-w64-mingw32\sysroot\usr\lib`, mais gcc
    16.2.0 ne regarde plus dans `usr/lib`. Défaut du paquet conda-forge, pas
    de la machine ni du code : conda-forge/ctng-compilers-feedstock, issue
    229, ouverte le 4 septembre 2026.

    Deux réparations si la version 16.2.0 est déjà en place et que le réseau
    ne permet pas de la changer : ajouter à la commande
    `-B "%CONDA_PREFIX%\Library\x86_64-w64-mingw32\sysroot\usr\lib"`, ou
    créer une jonction `sysroot\lib` vers `sysroot\usr\lib` par `mklink /J`,
    qui ne demande pas de droits d'administrateur. Le détail est dans le
    `README.md` du TD.
  ]
]
#d("Compiler, puis lancer")[
  #annonce[
    Deux commandes au lieu d'une : la première produit un fichier, la seconde
    exécute ce fichier.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire],
    [1], [Terminal #sym.arrow.r Nouveau terminal, dans `cours1/1e_hello_cpp/`],
    [2], [taper `g++ bonjour.cpp -o bonjour`, puis Entrée],
    [3], [taper `./bonjour`, puis Entrée],
    [4], [en option : mettre tout `bonjour.cpp` sur une seule ligne, recompiler],
  )

  #legende[
    L'étape 2 n'affiche rien, et c'est normal : elle produit un fichier. Sous
    Windows, la commande est `x86_64-w64-mingw32-g++`, le fichier produit
    s'appelle `bonjour.exe` et se lance par `.\bonjour.exe`.
  ]

  #notes[
    Étape 2 : rien ne s'affiche, la question vient. Faire regarder
    l'arborescence à gauche, où `bonjour` vient d'apparaître. C'est la
    différence avec Python, qui n'a rien laissé.

    Le bouton d'exécution existe aussi pour le C++, « Run C/C++ File » : il
    demande le compilateur au premier lancement et écrit un `tasks.json`. Ne
    pas l'employer en séance, mais savoir répondre.

    Étape 4, facultative : tout `bonjour.cpp` tient sur une ligne —
    `#include <iostream>` doit rester seul, c'est une directive — et le
    programme compile et affiche la même chose. Le compilateur ne voit pas les
    retours à la ligne, seulement les points-virgules et les accolades. Faire
    ensuite tenter la même chose sur un programme Python à boucle : cela
    échoue. C'est « Espaces, tabulations et fins de ligne » démontré.
  ]
]
#d("Ce que chaque lancement a produit")[
  #annonce[
    Les deux programmes affichent la même phrase. Ce qui les distingue est le
    nombre d'étapes, et ce qui reste sur le disque.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [`bonjour.py`, TD 1c], [`bonjour.cpp`],
    [Nombre d'étapes], reponse[une], reponse[deux : compiler, puis exécuter],
    [Ce qui apparaît dans l'arborescence],
      reponse[rien],
      reponse[`bonjour`, un exécutable],
    [Taille du fichier source], [121 octets], [230 octets],
    [Taille du fichier produit],
      reponse[aucun fichier],
      reponse[environ 20 000 octets],
  )

  #legende[
    La taille de l'exécutable dépend du compilateur et du système ; le
    rapport à la source, près de cent fois, n'en dépend pas.
  ]

  #notes[
    C'est « Deux chemins du texte à l'exécution » fait à la main : y
    renvoyer.

    Le rapport de taille est le chiffre à faire dire. L'exécutable
    embarque de quoi tourner sans le compilateur, d'où le facteur cent ;
    le fichier Python ne peut rien sans l'interpréteur, déjà installé et
    qu'on ne compte donc pas.

    Faire ouvrir `bonjour` dans l'éditeur : illisible, c'est « Code
    source et fichier exécutable » vérifié par eux. Ajouter que `python`
    est un exécutable de la même espèce.

    Le terminal est repris à la partie « Environnement de programmation »,
    où le dossier courant est nommé.
  ]
]
// Le résultat du TD, quand la capture est disponible.
#if captures-disponibles {
d("Les deux exécutions dans l'éditeur")[
  #annonce[
    Le terminal de l'éditeur garde la trace des trois commandes, et
    l'arborescence montre le fichier que la compilation vient de produire.
  ]

  #align(center)[
    #illustration(
      "/illustrations/cours1/vscode_hello.png",
      none,
      hauteur: hauteur-capture-pleine,
    )
  ]

  #legende[
    `bonjour` n'existait pas avant la deuxième commande. Le programme
    Python, lui, n'a rien laissé.
  ]

  #notes[
    Trois commandes, deux langages, une seule fenêtre : l'argument de
    l'éditeur de code, montré plutôt qu'énoncé.

    La sortie est identique, le chemin pour l'obtenir non.
  ]
]
}
