---
title: C++
subtitle: L'extension de VS Code, un compilateur, et un premier programme compilé
---

Cette page reprend le TD 2c du cours 1, facultatif : le programme
`bonjour.py` du TD 2a, réécrit en C++, compilé puis lancé. Le fichier
`bonjour.cpp` est dans le dossier `cours1/2c_hello_cpp/` de l'archive du
cours 1 ; il s'écrit aussi à la main :

```cpp
// Le plus petit programme C++ qui fasse quelque chose de visible.
#include <iostream>
#include <string>

int main() {
    std::string nom = "géomatique";
    std::cout << "Bonjour, " << nom << " !" << std::endl;
    return 0;
}
```

Il faut deux choses à VS Code pour un programme C++ : l'extension C/C++, qui
lit le langage, et un compilateur, que l'extension ne fournit pas. Sous
Windows, l'installation du compilateur demande une connexion réseau et prend
quelques minutes.

## L'extension C/C++

1. Ouvrir le panneau des extensions, `Ctrl` + `Maj` + `X`.
2. Taper `C/C++` dans la zone de recherche.
3. Choisir « C/C++ », publiée par Microsoft, et cliquer sur Install.
   Plusieurs extensions portent un nom voisin ; la bonne a pour identifiant
   `ms-vscode.cpptools`, écrit dans le volet de droite, ligne
   « Identifier ».

VS Code peut aussi proposer l'extension de lui-même, dans une notification
en bas à droite, à l'ouverture d'un fichier `.cpp`.

**Vérification** : dans `bonjour.cpp`, supprimer le point-virgule à la fin
de la ligne `return 0;`. L'éditeur souligne l'endroit en rouge après
quelques secondes. Remettre le point-virgule, puis enregistrer (`Ctrl` +
`S`).

L'extension apporte la coloration, la vérification de l'écriture et un
bouton d'exécution, mais pas de compilateur : elle analyse le texte C++,
sans pouvoir le traduire en programme exécutable. La documentation de VS
Code l'indique : « The C/C++ extension doesn't include a C++ compiler or
debugger, since VS Code as an editor relies on command-line tools for the
development workflow. »

## Un compilateur

| | Linux, macOS | Windows |
|---|---|---|
| Le compilateur | `g++`, presque toujours déjà installé | aucun, à l'origine |
| Comment l'obtenir | rien à faire | `conda install -c conda-forge "gxx=15.3.0"` |
| Ce qu'on tape ensuite | `g++ …` | `x86_64-w64-mingw32-g++ …` |

### Sous Linux et macOS

Taper `g++ --version`, puis Entrée. La réponse commence par un nom et un
numéro de version. Sous macOS, si le système propose d'installer les outils
de développement en ligne de commande, accepter, puis recommencer.

### Sous Windows

Dans un terminal dont l'invite commence par `(base)` (sinon, taper `conda
activate base`) :

```text
conda install -c conda-forge "gxx=15.3.0"
```

conda affiche la liste des paquets qu'il va installer, et demande
`Proceed ([y]/n)?` : taper `y`, puis Entrée.

Deux parties de la commande ne doivent pas être modifiées :

- `-c conda-forge` désigne le canal, c'est-à-dire le dépôt de paquets où
  conda va chercher le compilateur ;
- `"gxx=15.3.0"` fixe la version, avec les guillemets. Sans cette version
  fixée, conda installe la version 16.2.0, dont la compilation échoue sous
  Windows (section [L'erreur `crt2.o`](#lerreur-crt2.o)).

Le compilateur installé ne s'appelle pas `g++`. La commande porte le nom
complet de la cible, `x86_64-w64-mingw32-g++` : l'architecture du processeur
(`x86_64`), le système (`w64-mingw32`, Windows 64 bits), puis le compilateur
(`g++`).

```text
x86_64-w64-mingw32-g++ --version
```

Ne pas installer le paquet `m2w64-toolchain`, proposé par d'anciennes
réponses en ligne : sa propre description le déclare obsolète. Sur un
ordinateur personnel qui a déjà MSYS2 et MinGW-w64, installés selon la
documentation de VS Code, la commande s'appelle `g++`, comme sous Linux.

Python est installé avec Anaconda, alors qu'aucun compilateur C++ ne l'est,
et Windows n'en fournit aucun. L'environnement conda sert ici à installer un
outil qui n'a rien à voir avec Python.

## Compiler, puis lancer

Dans le terminal, dans le dossier de `bonjour.cpp` :

| | Linux, macOS | Windows |
|---|---|---|
| Compiler | `g++ bonjour.cpp -o bonjour` | `x86_64-w64-mingw32-g++ bonjour.cpp -o bonjour.exe` |
| Lancer | `./bonjour` | `.\bonjour.exe` |

La commande de compilation se lit ainsi : le compilateur, le fichier source
à traduire, puis, après `-o` (*output*), le nom du fichier à produire. La
compilation dure quelques secondes, puis l'invite revient. `./` (ou `.\`
sous Windows) désigne le dossier courant : il indique au terminal de
chercher le programme dans ce dossier.

**Vérification** : le terminal affiche `Bonjour, géomatique !`.

Si, sous Windows, le `é` s'affiche sous la forme de deux caractères sans
rapport, le programme n'est pas en cause : le texte du programme est encodé
en UTF-8, et le terminal Windows lit les octets reçus avec une autre table.
Taper `chcp 65001`, qui fait passer le terminal en UTF-8, puis relancer le
programme.

## Un programme compilé, comparé à un programme Python

| | `bonjour.py` | `bonjour.cpp` |
|---|---|---|
| Nombre de commandes | une : `python bonjour.py` | deux : compiler, puis exécuter |
| Fichier produit | aucun | `bonjour`, un exécutable |
| Taille du fichier source | 121 octets | 230 octets |
| Taille du fichier produit | aucun fichier | environ 20 000 octets |

La compilation n'affiche rien quand elle réussit : elle produit un fichier,
qui apparaît dans l'arborescence. Le programme Python ne laisse rien sur le
disque : l'interpréteur lit la source et l'exécute dans la même commande.

La taille de l'exécutable dépend du compilateur et du système : 23 624
octets avec g++ 11 sous Linux, 19 560 avec g++ 13. L'exécutable est de
l'ordre de cent fois plus gros que la source, parce qu'il contient le code
nécessaire pour démarrer et s'exécuter sans le compilateur. Le fichier
Python ne s'exécute pas sans l'interpréteur, qui est installé à part.

Ouvert dans l'éditeur, l'exécutable est illisible : il contient des
instructions pour le processeur, qui ne sont pas du texte. `python`
lui-même est un exécutable de ce type, compilé depuis du C.

Écrit sur une seule ligne, `bonjour.cpp` se compile et affiche la même
phrase : le compilateur C++ ne tient pas compte des retours à la ligne ni de
l'indentation. La fin d'une instruction est marquée par le point-virgule, et
un bloc par des accolades. Les lignes `#include` font exception : ce sont des
directives, lues avant la compilation, une par ligne. La même opération
échoue sur un programme Python qui contient une boucle, où l'indentation et
les fins de ligne délimitent les blocs.

## L'erreur `crt2.o`

Avec la version 16.2.0 du compilateur, installée quand la version n'est pas
fixée, la compilation se termine ainsi :

```text
ld.exe: cannot find crt2.o: No such file or directory
ld.exe: cannot find default-manifest.o: No such file or directory
collect2.exe: error: ld returned 1 exit status
```

Le message est écrit par `ld`, l'éditeur de liens : la traduction de
`bonjour.cpp` a réussi, et c'est l'assemblage du programme exécutable qui
échoue. `crt2.o` est le fichier de démarrage ajouté à tout programme
Windows, et exécuté avant `main`. Il est installé, dans
`%CONDA_PREFIX%\Library\x86_64-w64-mingw32\sysroot\usr\lib`, mais gcc 16.2.0
ne le cherche plus dans ce dossier.

La réparation la plus simple est d'installer la version 15.3.0, par la
commande de la section précédente, puis de recompiler. Sans réseau, deux
autres réparations conservent la version 16.2.0 ; elles sont écrites pour le
terminal `cmd`. La première ajoute une option à chaque compilation, qui
indique au compilateur où chercher :

```text
x86_64-w64-mingw32-g++ bonjour.cpp -o bonjour.exe -B "%CONDA_PREFIX%\Library\x86_64-w64-mingw32\sysroot\usr\lib"
```

La seconde répare l'installation une fois pour toutes, par une jonction, qui
crée à l'endroit où le compilateur cherche un accès au dossier réel, et ne
demande pas de droits d'administrateur :

```text
mklink /J "%CONDA_PREFIX%\Library\x86_64-w64-mingw32\sysroot\lib" "%CONDA_PREFIX%\Library\x86_64-w64-mingw32\sysroot\usr\lib"
```

Chacune de ces deux commandes s'écrit sur une seule ligne. Le défaut vient
du paquet conda-forge ; il est suivi dans l'issue 229 du dépôt
conda-forge/ctng-compilers-feedstock, ouverte le 4 septembre 2026 :
<https://github.com/conda-forge/ctng-compilers-feedstock/issues/229>. Les
versions 13.4.0, 14.4.0 et 15.3.0 n'ont pas ce défaut.
