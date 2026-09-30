# Le même programme en C++ — TD 1e, cours 1, facultatif

Le `bonjour.py` du TD 1c, réécrit en C++. Même phrase affichée ; ce qui change
est le nombre d'étapes pour y arriver, et ce qui reste sur le disque.

| | `bonjour.py` (TD 1c) | `bonjour.cpp` |
|---|---|---|
| Ce qu'on tape | `python bonjour.py` | `g++ bonjour.cpp -o bonjour`, puis `./bonjour` |
| Nombre d'étapes | une | deux : compiler, puis exécuter |
| Ce qui apparaît sur le disque | rien | `bonjour`, un exécutable |
| Taille du fichier source | 121 octets | 230 octets |
| Taille du fichier produit | aucun fichier | environ 20 000 octets |

Tailles relevées avec `g++` 13 sous Linux ; celle de l'exécutable varie d'un
compilateur et d'un système à l'autre, mais l'ordre de grandeur, près de cent
fois le fichier de départ, ne varie pas. L'exécutable embarque de quoi tourner
sans le compilateur.

Le TD est facultatif : il demande un compilateur, que Windows ne fournit pas,
et l'installation de l'extension C/C++ de l'éditeur. Il se fait après les
autres, ou chez soi.

## Déroulé

Dans l'éditeur, **Fichier → Ouvrir le dossier** sur `cours1/1e_hello_cpp/`,
puis **Terminal → Nouveau terminal** :

```bash
g++ bonjour.cpp -o bonjour   # compiler : rien ne s'affiche, un fichier apparaît
./bonjour                    # exécuter
```

**Rien ne s'affiche à la compilation, et c'est normal** : cette commande ne
montre pas un résultat, elle produit un fichier. `bonjour` apparaît dans
l'arborescence de gauche.

Le bouton d'exécution existe aussi pour le C++, « Run C/C++ File » ; il demande
de choisir un compilateur au premier lancement, puis écrit un `tasks.json`
dans le projet. La commande écrite à la main reste préférable.

## Sous Windows

Un compilateur C++ n'est pas fourni avec Windows : il s'installe dans
l'environnement conda du module.

```bat
conda install -c conda-forge "gxx=15.3.0"
```

**La version est fixée, et ce n'est pas un détail.** Sans la contrainte, conda
installe `gxx` 16.2.0, dont le paquet conda-forge est cassé sous Windows depuis
la fin d'août 2026 : la compilation aboutit, l'assemblage du programme échoue
(voir « Si la compilation s'arrête sur `crt2.o` » plus bas).

**La commande ne s'appelle pas `g++`.** Le paquet installe
`x86_64-w64-mingw32-g++.exe` — le nom complet de la cible, architecture,
système et format — et c'est lui qu'il faut taper :

```bat
x86_64-w64-mingw32-g++ bonjour.cpp -o bonjour.exe
.\bonjour.exe
```

L'installation demande du réseau et quelques minutes : la lancer avant la
séance, ou au début du TD en enchaînant sur autre chose pendant qu'elle
tourne.

> Ne pas employer `m2w64-toolchain`, encore proposé par de vieilles réponses en
> ligne : le paquet affiche lui-même à l'activation qu'il est obsolète et
> renvoie vers `gcc`, `gxx` et `gfortran`.

### Si la compilation s'arrête sur `crt2.o`

Avec `gxx` 16.2.0, la commande de compilation se termine ainsi :

```text
ld.exe: cannot find crt2.o: No such file or directory
ld.exe: cannot find default-manifest.o: No such file or directory
collect2.exe: error: ld returned 1 exit status
```

C'est `ld`, l'éditeur de liens, qui parle : la traduction du fichier a réussi,
c'est l'assemblage du programme qui échoue. `crt2.o` est le fichier de
démarrage que reçoit tout programme Windows avant d'entrer dans `main`. Il est
bien installé, dans
`%CONDA_PREFIX%\Library\x86_64-w64-mingw32\sysroot\usr\lib`, mais gcc 16.2.0
ne cherche plus dans `usr/lib` : c'est un défaut du paquet conda-forge, ni de
la machine ni du programme. Les versions 13.4.0, 14.4.0 et 15.3.0 en sont
indemnes.

Trois réparations, de la plus simple à la plus intrusive :

```bat
:: 1. redescendre d'une version — la solution retenue par le module
conda install -c conda-forge "gxx=15.3.0"

:: 2. garder 16.2.0 et indiquer le dossier manquant à chaque compilation
x86_64-w64-mingw32-g++ bonjour.cpp -o bonjour.exe ^
  -B "%CONDA_PREFIX%\Library\x86_64-w64-mingw32\sysroot\usr\lib"

:: 3. garder 16.2.0 et réparer l'arborescence une fois pour toutes
mklink /J "%CONDA_PREFIX%\Library\x86_64-w64-mingw32\sysroot\lib" ^
          "%CONDA_PREFIX%\Library\x86_64-w64-mingw32\sysroot\usr\lib"
```

La jonction `mklink /J` ne demande pas de droits d'administrateur, à la
différence du lien symbolique `mklink /D`.

Suivi du défaut : conda-forge/ctng-compilers-feedstock,
[issue 229](https://github.com/conda-forge/ctng-compilers-feedstock/issues/229),
ouverte le 4 septembre 2026. Reprendre `conda install -c conda-forge gxx`, sans
contrainte de version, une fois le correctif publié.

### Sans conda : les outils de Microsoft

Un poste qui a déjà Visual Studio, ou sur lequel on peut installer, dispose
d'un second chemin. Le téléchargement s'appelle **Build Tools for Visual
Studio** : il ne contient que la chaîne de compilation, sans l'environnement de
développement, et une seule charge de travail suffit, « Développement Desktop
en C++ ».

La compilation se fait alors depuis l'« Invite de commandes développeur »
installée avec les outils, la seule où les variables d'environnement du
compilateur sont posées :

```bat
cl /EHsc /Fe:bonjour.exe bonjour.cpp
.\bonjour.exe
```

Deux réserves. L'installation demande les droits d'administrateur et plusieurs
gigaoctets, ce que les postes de la salle n'accordent pas. Et le paquet
`compilers` de conda-forge n'est pas une solution de rechange sous Windows :
il s'y réduit à `vs2022_win-64`, qui ne fait qu'activer un Visual Studio déjà
installé.

Documentation : [Use the Microsoft C++ Build Tools from the command
line](https://learn.microsoft.com/en-us/cpp/build/building-on-the-command-line?view=msvc-170).

## Ce qui est laissé de côté

L'exécutable `bonjour` (ou `bonjour.exe`) n'est pas versionné : c'est un
artefact, comme les PDF et les vidéos du reste du dépôt. Le supprimer avant la
séance suivante pour que le TD reparte de zéro.
