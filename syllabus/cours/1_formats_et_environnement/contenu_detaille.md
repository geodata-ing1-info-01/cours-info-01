# Contenu détaillé — Cours 1 : Logiciel, programmation & formats de fichier

Vue d'ensemble : [../../01_syllabus_v1.md](../../01_syllabus_v1.md) (section « Cours 1 »).
Inversion C1↔C3 : [../../inversion_c1_c3.md](../../inversion_c1_c3.md).

**Supports** : [`src/cours1/notebook/`](../../../src/cours1/notebook/) (MyST, 4 pages) et [`src/cours1/diapo/`](../../../src/cours1/diapo/) (typst, 119 diapositives en assertion-evidence avec les captures d'écran ; `--input notes=true` pour la version annotée, `--input corrige=true` pour le corrigé des TD, `--input tds=false` pour le fil du cours avec un sommaire à la place de chaque bloc de TD, `--input captures=true` si les captures d'écran sont en place).
**TD** : dix, numérotés `1a`…`5b` (chiffre = bloc, lettre = ordre dans le bloc), quatre facultatifs (`1b`, `2c`, `5a`, `5b`). Un fichier par TD dans [`src/cours1/diapo/tds/`](../../../src/cours1/diapo/tds/), un dossier de même nom dans [`data/cours1/`](../../../data/cours1/), et l'archive remise aux étudiants assemblée par `outils/livrer_tds.py`.
Conventions d'écriture : [`STYLE.md`](../../../STYLE.md).
Illustrations manquantes, relevées diapositive par diapositive : [`illustrations_a_chercher.md`](illustrations_a_chercher.md).
**Données** : [`data/cours1/`](../../../data/cours1/) — générées par `make_data.py`.

Objectif : comprendre ce qu'est un logiciel, pourquoi programmer revient à écrire du texte, et savoir manipuler fichiers et environnement de travail en confiance.

---

## Fil conducteur

La séance est construite comme une chaîne de questions, chacune amenant la suivante :

> *Qu'est-ce qu'un logiciel ?* → entrée/traitement/sortie, et c'est un fichier.
> *Que manipule-t-il ?* → des **fichiers**, que l'extension nomme sans les décrire.
> *D'où vient le logiciel lui-même ?* → de **texte** écrit par un humain, dans un **éditeur** qui en connaît les règles.
> *Qu'y a-t-il vraiment dans un fichier ?* → des **octets**, que le format organise et que l'extension ne décrit pas.
> *De quoi un programme a-t-il besoin pour tourner ?* → de **bibliothèques**, donc d'un **environnement** qu'on installe au clavier.
> *Et l'outil qui réunit tout cela ?* → le **notebook**.

Aucune notion n'est introduite sans que la précédente l'ait rendue nécessaire.

Les diapositives suivent ce découpage en cinq parties, séparées par des
diapositives de séparation : *logiciels et formats de fichier*, *programmation
et éditeur de code*, *formats de fichier*, *environnement de programmation*,
*notebooks*. La diapositive « Contenu de la séance » les annonce, avant la
première séparation.

L'ordre a changé deux fois. En septembre 2026, la partie programmation et
éditeur est passée **avant** la ligne de commande, pour que les étudiants aient
écrit et lancé un programme avant qu'on leur explique comment on pilote un
logiciel au clavier. Puis la partie *formats de fichier* est remontée **avant**
la partie environnement : elle prolonge directement l'éditeur de code, puisque
lire les octets d'un fichier s'y fait avec un script Python lancé depuis
l'éditeur, et elle n'a besoin de rien d'autre.

La partie environnement, elle, a été recentrée sur ce qu'elle est vraiment,
l'installation et l'isolement des dépendances. Elle ne s'ouvre plus sur une
comparaison entre interfaces, mais sur le problème qui rend l'outil nécessaire :
un programme emprunte du code à d'autres, ces emprunts se contredisent d'un
projet à l'autre, et l'outil qui les démêle n'a pas de fenêtre. La ligne de
commande y est réduite à ce qu'il faut pour lire les trois commandes `conda` du
semestre ; elle est traitée pour elle-même au cours 2, et les diapositives qui
la détaillaient sont conservées en annexe du deck.

---

## Déroulé détaillé

---

## Partie 1 — Logiciels et formats de fichier

> **Le rythme est annoncé avant d'entrer dans la partie.** Une diapositive suit celle des notions déjà vues au lycée : la partie 1 les reprend, elle avance donc plus vite que les suivantes, et c'est la seule où le rythme est délibérément élevé. Le temps gagné va aux TD.
>
> Elle porte un **point d'attention** encadré (`bloc-titre`) : si quelque chose n'est pas clair ici, la question se pose tout de suite. Formulation qui fonctionne mieux qu'une invitation générale — dire qu'ici, ne pas comprendre est probable et normal *parce qu'on va vite exprès*, si bien que la question n'est pas un aveu mais ce que le rythme suppose. Le passage à surveiller est le vocabulaire (logiciel, application, format, extension, chemin) : des mots qu'ils croient connaître, et où les malentendus s'installent sans bruit.

### 🎓 12′ — Qu'est-ce qu'un logiciel (haut niveau)

- Schéma unique et réutilisé tout le semestre : **entrée → traitement → sortie**. Distinguer deux sortes de sorties : celle **qui reste** (un fichier) et celle **qui passe** (un périphérique : écran, son). Le module s'intéresse surtout à la première, parce que c'est elle qui se relit, se compare et se versionne.
- Un logiciel installé = **des fichiers**, rien de plus. Double-cliquer = demander au système de lire un fichier et de l'exécuter.
- Ce fichier est **binaire** (illisible pour un humain) — mais il n'a pas été écrit comme ça, il a été *produit*.
- *Ne pas entrer* dans l'architecture machine (registres, mémoire) : c'est le cours 5.

### 🎓 6′ — Logiciel, application, app

- **Le vocabulaire d'abord**, parce qu'il est flottant : *logiciel* est le terme général ; un *logiciel d'application* sert une tâche de l'utilisateur ; *application*, *appli* et *app* en sont des synonymes ou des abréviations, pas d'autres objets.
- Définitions de référence : « logiciel », vocabulaire de l'informatique publié au *Journal officiel* du 22 septembre 2000 ; « logiciel d'application », Grand dictionnaire terminologique de l'OQLF.
- **Deux questions posées à la salle**, réponses à l'oral :
  1. *Quel système d'exploitation tourne sur votre téléphone ?* — attendu Android ou iOS (ordre de grandeur mondial : ~70 % / ~30 %, StatCounter 2026). Personne ne dit « Linux » alors qu'Android en est un : c'est le point à relever.
  2. *Qu'est-ce qu'une application web, une « webapp » ? Citez-en une que vous utilisez.* — laisser venir « un site où on fait des choses », « ça marche sans installer », sans corriger. Les exemples viennent seuls : messagerie, documents partagés, retouche d'image, cartes.
- Le schéma des couches (programmes → système → matériel) se lit dans la foulée : le système d'exploitation est justement le *logiciel de base* de la définition.

> Ne pas citer Android ni iOS avant la question 1, ni les logiciels que les étudiants ne connaissent pas encore en début d'année (QGIS arrive plus tard dans le cursus). Les exemples des diapositives précédentes ont été choisis dans ce sens.

### 🎓 5′ — L'application web, et où elle s'exécute

Réponse à la question 2, en deux diapositives. L'enjeu n'est pas le vocabulaire : il est de faire remarquer que des tâches qui demandaient un logiciel installé se font aujourd'hui dans un navigateur, et que le lieu du calcul, donc celui des fichiers, a changé sans qu'on le dise.

- **Définition** : « application fonctionnant dynamiquement avec le concours d'un navigateur web » (Grand dictionnaire terminologique de l'OQLF). Pas d'installation : le code est téléchargé à chaque visite et exécuté par le navigateur, dans un environnement isolé.
- **Le navigateur fait le travail d'un système d'exploitation** : il charge du code, l'exécute dans une machine virtuelle, lui donne du stockage et un accès réseau, et l'empêche de toucher au reste de la machine. La documentation de Mozilla emploie littéralement le mot « machine virtuelle » pour le moteur qui exécute JavaScript et WebAssembly, ce dernier tournant à une vitesse *proche du natif*. Ne pas entrer dans les technologies.
- **Deux endroits pour le calcul**, et c'est la conséquence qui compte :

| | Dans le navigateur | Sur un serveur |
|---|---|---|
| Votre fichier | ne quitte pas la machine | part sur le réseau |
| Sans connexion | peut continuer | s'arrête |
| Qui calcule | votre processeur | celui du service |
| Exemples | retouche d'image en ligne | traduction, IA générative |
| **Le cas courant : les deux** | l'affichage, la mise en page, les interactions | les données, la recherche, les traitements lourds |

> La dernière ligne est la plus importante, et elle vient après les cas purs parce qu'elle ne se comprend qu'ensuite : presque aucune application web n'est entièrement d'un côté. Une messagerie affiche et met en page chez vous, mais cherche dans vos messages sur son serveur. La question utile n'est donc pas « où est-ce que ça tourne ? » mais « qu'est-ce qui part, et quand ? ».

- **Rattachement** : l'outil en ligne proposé pour le TD vidéo (5b, facultatif) annonce que le rendu se fait sur l'appareil, ce qui explique qu'il n'exige ni compte ni connexion permanente. La phrase « ce qu'on dépose quelque part y reste » est semée ici et reprise au cours 5 avec les secrets.

### 🎓 1′ — Ce qu'un fichier permet *(liaison)*

Diapositive de liaison entre les entrées-sorties et les extensions, à passer en une minute : elle justifie la suite plutôt qu'elle n'apporte une notion. Sans elle, la partie enchaîne sur les extensions et les chemins sans avoir dit pourquoi ces détails méritent qu'on s'y arrête.

Le fil vient de la diapositive précédente : parmi les deux natures de sortie, c'est le fichier qui reste. Quatre lignes disent ce que ce « rester » permet — conserver un résultat, le passer d'un logiciel à l'autre, changer de machine, le remettre à quelqu'un — et elles sont toutes vraies dès cette semaine, la dernière au cours 2.

> La deuxième ligne est celle qui porte le plus loin : un format de fichier est ce sur quoi deux logiciels se mettent d'accord sans se connaître. Ne pas développer, la partie 3 y revient.

### 🎓 6′ — Fichier, extension, type de fichier

- **Anatomie d'un nom de fichier** : le nom, puis l'extension après le dernier point. L'extension décide quel logiciel le système lance au double-clic ; elle ne modifie aucun octet.
- **Fichiers et dossiers cachés** : nom commençant par `.` (`.gitignore`, dossier `.git/`) ; comment les afficher. *Prérequis du cours 2* — ne pas sauter.
- Faire activer **l'affichage des extensions** dans l'explorateur (masquées par défaut sous Windows/macOS) : à faire une fois, utile tout le semestre, et **indispensable au TD 1a**.

### 🎓 4′ — Reconnaître un format à son extension

Grille de seize extensions (`.mp3` `.flac` `.mp4` `.mkv` `.jpg` `.png` `.svg` `.tif` `.pdf` `.odt` `.xlsx` `.csv` `.zip` `.7z` `.py` `.exe`), interrogation rapide de la salle, puis la même grille avec les réponses.

Les trois qui font débat : `.svg` (une image, mais du texte XML), `.csv` (du texte, pas un fichier Excel) et `.7z` (une archive comme `.zip`, mais d'un autre outil). **Trois des seize sont du texte** : ce sont ceux qu'on peut ouvrir dans un éditeur, comparer ligne à ligne et versionner — la conclusion qui prépare le cours 2.

> `.geojson` a été retiré de la grille : les étudiants ne l'ont pas encore rencontré en début d'année.

### 🎓 6′ — Chemins de fichiers et adresses de pages

- **Le chemin d'un fichier**, décomposé sur un exemple Windows : `C:\` le disque, `Users\alice\Documents\` les dossiers du plus large au plus précis, `raven` le nom, `.odt` l'extension. Windows sépare par une barre inversée, macOS et Linux par une barre normale ; un chemin **relatif** part du dossier courant.
- **L'adresse d'une page** est le même objet, précédé de la machine où aller chercher : `https://` comment on parle, `www.ensg.eu` à quelle machine, `/cours/base/` le chemin sur cette machine, `raven.html` le fichier.
- **Le pont** : `file:///C:/Users/alice/Documents/raven.html`, même structure sans machine distante. C'est ce qui explique le `file:///` que les étudiants verront en ouvrant une page par double-clic, tout de suite après.
- *Semé pour le cours 3* : « le fichier existe pourtant » signifie presque toujours qu'on ne l'a pas cherché depuis le bon dossier.

### ⌨️ 20′ — TD 1a : fichiers, formats et extensions, puis TD 1b : l'archive `.odt` *(facultatif)*

Fichiers de départ dans `cours1/1a_formats/depart/`, produits dans le dépôt par `python make_data.py fetch && python make_data.py build`. Le TD ouvre sur **deux dossiers** : `depart/`, ce qui est donné et ne se modifie pas, et `travail/`, livré vide, où vont toutes les copies. La première diapositive écrit les deux chemins en entier, `C:\Users\alice\Documents\cours1\1a_formats\depart\raven.odt` et sa copie renommée dans `travail\`, pour que le vocabulaire des chemins serve tout de suite ; les suivantes abrègent à partir de `cours1/`. Une diapositive montre ensuite deux fois la copie avec renommage, dans l'explorateur (`Ctrl`+`C`, `Ctrl`+`V`, `F2`) et dans un terminal `cmd` (`copy depart\raven.odt travail\raven_odt.pdf`) : le terminal est pour ceux qui le connaissent déjà, aucune étape ne l'exige.

Depuis septembre 2026, la partie « un `.odt` est une archive ZIP » — les étapes 3 et 4 ci-dessous — est un TD à part, **1b, facultatif**, dans `cours1/1b_archive_odt/` (même `raven.odt`, mêmes `depart/` et `travail/`), pour ceux qui vont vite. Le TD 1a garde l'export LibreOffice (étape 1), le renommage (2), la page HTML (5), la table ASCII et le Bloc-notes, plus la diapositive sur l'adresse `file:///`, venue de l'exposé.

**1. Un même document, trois formats.** Ouvrir le `.odt` dans Writer, puis :

| Fichier produit | Comment | Le texte est-il encore du texte ? |
|-----------------|---------|-----------------------------------|
| `raven.pdf` | Fichier → Exporter au format PDF | oui : il se sélectionne et se cherche |
| `raven.png` | Fichier → **Exporter…**, type PNG | non : des pixels, et la première page seulement |
| `raven.odt` | le fichier de départ | oui, et il reste modifiable |

L'export en image se trouve sous *Fichier > Exporter*, pas sous *Enregistrer sous* : les filtres `writer_png_Export` et `writer_jpg_Export` existent bien depuis Writer. Nommer la différence entre une page **décrite** (PDF, texte vectoriel) et une page **photographiée** (PNG, JPEG). Rouvrir le `.png` dans LibreOffice : il s'ouvre dans **Draw**.

**2. Renommer, et voir qui se laisse tromper.** Avec `F2`, sur des copies, en gardant `odt` dans le nom :

| Nom donné | Ce que le système propose | Ce qui se passe |
|-----------|---------------------------|-----------------|
| `raven_odt.pdf` | un lecteur PDF | refus : le fichier n'est pas un PDF |
| `raven_odt.jpg` | une visionneuse | refus : *Not a JPEG file: starts with 0x50 0x4b* |
| `riri.fifi.loulou.odt` | LibreOffice Writer | s'ouvre : seule la fin du nom compte |
| `raven.loulou` | rien : « Comment voulez-vous ouvrir ce fichier ? » | choisir LibreOffice : s'ouvre, le contenu n'a pas changé |

La quatrième ligne est la plus instructive et n'est pas intuitive : avec une extension **inventée**, le système n'a plus de convention à appliquer. **Vérifié sous Windows 11** : il n'ouvre rien et ne regarde pas le contenu, il propose une liste de logiciels ; cocher « Toujours » associe l'extension au logiciel choisi, et le double-clic suivant ouvre directement. Sous Linux (GNOME), le système lit les premiers octets et propose LibreOffice de lui-même. La conclusion sur la diapositive : le système ne regarde que le nom. Laisser la salle inventer l'extension. Le message de la visionneuse nomme lui-même les octets lus, `0x50 0x4b`, soit « PK ».

> **Prérequis, vérifié en 2026** : Windows 11 masque toujours les extensions des types connus **par défaut**. Le réglage est dans *Explorateur > Affichage > Afficher > Extensions de noms de fichiers* ; sous macOS, *Finder > Réglages > Avancé > « Afficher tous les suffixes de fichiers »*. Sans cela, `F2` ne montre pas ce qu'on renomme et tout le TD tombe à plat. C'est la première étape de la séance, et il est rappelé sur la diapositive elle-même.

**3. Un `.odt` est une archive** *(TD 1b)*. Copier dans `travail/` sous le nom `raven.zip`, ouvrir avec le gestionnaire d'archives : six fichiers, dont `mimetype`, `content.xml` (le texte) et `styles.xml` (la mise en forme). Ouvrir `content.xml` dans l'éditeur : le poème est en clair. C'est aussi la réponse à « pourquoi un `.odt` se versionne mal ».

**4. Modifier le document sans traitement de texte** *(TD 1b)*. Éditer les fichiers extraits, recompresser, renommer en `.odt` :

- le texte : dans `content.xml`, remplacer `>The Raven<` par `>Le Corbeau<` ;
- **un style, sans code hexadécimal** : dans `content.xml`, remplacer `Text_20_body` par `Heading_20_1` sur un paragraphe, qui devient un titre. Une diapositive montre la ligne avant et après, la partie changée en couleur. Le `_20_` intrigue toujours : ce n'est pas un nom en trois morceaux, c'est « Text body » dont l'espace est encodé, un nom XML n'en acceptant pas. ODF écrit chaque caractère interdit sous la forme de son code hexadécimal entre tirets bas, et l'espace vaut 20 — le même principe que le `%20` des adresses web. Le nom lisible est dans l'attribut `style:display-name`, et l'explication est donnée aux étudiants dans le notebook, avec un lien vers la spécification ;
- la taille : dans `styles.xml`, sur `Heading_20_1`, passer `fo:font-size` de `115%` à `220%`.

> **Sur la couleur, question attendue** : ODF n'accepte **pas** de nom de couleur. Vérifié — `fo:color="red"` est ignoré et le titre reste noir ; il faut `fo:color="#c0392b"`. C'est donc l'occasion d'expliquer le code hexadécimal, deux chiffres par composante rouge, verte et bleue. CSS, lui, accepte les deux écritures, ce qui se vérifie au TD 3a.

`content.xml` fait 4 ko sur 21 lignes, dont une de 1 300 caractères : le Bloc-notes l'ouvre, en activant le retour à la ligne, mais l'éditeur de code du module est nettement plus confortable, puisqu'il colore et replie les balises.

> ⚠️ **Le piège, désormais écrit sur la diapositive** : compresser les six fichiers depuis l'intérieur du dossier, **pas le dossier qui les contient**. Sinon les chemins dans l'archive deviennent `raven/content.xml` et LibreOffice refuse d'ouvrir, avec « source file could not be loaded ». Vérifié : c'est bien un échec, pas une dégradation silencieuse.

**5. Ouvrir une page depuis son disque.** Double-clic sur `depart/raven_brut.html` : le navigateur l'affiche sans réseau, et l'adresse est un chemin du disque. La diapositive suivante reprend l'anatomie d'une URL (`https://` / la machine / le chemin / le fichier) et pose la question des trois barres de `file:///` : la place de la machine est vide, c'est la vôtre, et la troisième barre est la racine. Puis `raven_style.html`, même texte mis en forme, qui appelle `style.css` : changer une couleur dans le CSS et recharger avec `F5`. Le `.html` est identique dans les deux cas ; seule la ligne `<link rel="stylesheet" href="style.css">` les distingue. Si `style.css` n'est pas dans le même dossier, la page s'affiche sans mise en forme — bonne occasion de reparler des chemins relatifs.

L'argument à retenir dépasse le TD : un format **ouvert et documenté** se manipule avec des outils quelconques, et le contenu se sépare de sa présentation aussi bien dans un `.odt` que dans une page web.

---

## Partie 2 — Programmation et éditeur de code

### 🎓 10′ — Du code source à l'exécution *(ouverture de la partie)*

La partie s'ouvre sur le **vocabulaire**, diapositive « D'un programme à une application » : programme, logiciel et application nomment la même chose, et c'est l'usage qui les spécialise. La diapositive montre désormais les deux chaînes qui mènent du code à une application, l'empaquetage et le déploiement : la frontière tient à l'empaquetage et à l'usage, non à la technique, et c'est la question qui revient chaque année. Le schéma entrée → traitement → sortie du début de séance se reprend ici **à l'oral**, pour poser ce qui suit : la boîte du milieu est un fichier, d'où vient-elle ?

**Code source et fichier exécutable** répond en montrant les deux côte à côte, trois lignes de Python d'un côté, les premiers octets de l'exécutable `python3` de l'autre.

**Interprété et compilé, en schéma plutôt qu'en tableau** : la chaîne compilée a une étape de plus (`raven.c` → compilateur → `raven.exe` → résultat) mais ne la fait **qu'une fois** ; la chaîne interprétée en a une de moins (`raven.py` → interpréteur → résultat) mais la refait **à chaque lancement**. Lancer un programme Python ne crée rien sur le disque, et c'est aussi pourquoi il est plus lent.

**La place de l'interpréteur** reprend enfin le schéma en couches de la partie 1, avec un étage de plus : un programme interprété s'adresse à l'interpréteur, qui s'adresse au système ; un programme compilé n'a pas cet étage. Le point à faire est que `python` est lui-même un exécutable compilé, celui dont les octets viennent d'être montrés. Un navigateur tient le même rôle pour HTML, CSS et JavaScript, et personne ne l'appelle interpréteur : le mot désigne un rôle. Conséquence pratique, qui justifie la partie 4 — il faut que Python soit installé pour lancer un programme Python.

Viennent ensuite, dans la même partie, la feuille de route des trois compétences, l'environnement conda et les notebooks : c'est l'outillage annoncé par le titre.

### 🎓 10′ — Qu'est-ce que programmer

- Un langage = un vocabulaire, une grammaire, un sens. Écrire un programme = écrire un texte respectant cette convention.
- Démonstration : 3 lignes de Python affichées, exécutées en direct dans le notebook. Insister — *c'est du texte qu'on pourrait taper dans le Bloc-notes*.
- La comparaison compilé / interprété est déjà faite juste avant : y renvoyer plutôt que la refaire.
- **Graine explicite** : « exécution plus lente » → cours 6 (boucle vs numpy) et TD7 (×100–1000).

### 🎓 8′ — IDE (VSCode)

Une capture d'écran de VSCode ouvert sur un petit projet sert de support : les trois zones y sont visibles d'un coup, et le fichier produit par la commande apparaît dans l'arborescence pendant qu'on parle.

- **Dossier = projet** (on n'ouvre pas un fichier isolé) — habitude structurante pour git au cours 2.
- Explorateur, palette de commandes (`Ctrl+Maj+P`), terminal intégré, aperçu Markdown (`Ctrl+Maj+V`), extensions (Python, Jupyter, MyST).
- Numéros de ligne, tabulation vs espaces, encodage affiché dans la barre d'état.

**Le sigle, une fois.** IDE, pour *integrated development environment*, se traduit par **environnement de développement intégré** ; « EDI » existe et ne s'emploie pas. La diapositive « Les fonctions d'un IDE » énumère ce que l'intégration recouvre — écrire le code, le lancer et le tester, naviguer dans le projet, déboguer — et l'argument est que seule la première ligne est le fait d'un éditeur de texte ordinaire. Les deuxième et troisième servent dès aujourd'hui, le débogage vient au cours 2. Ne pas s'attarder sur le fait que Microsoft présente VSCode comme un éditeur plutôt que comme un IDE : la frontière est commerciale autant que technique.

### 🎓 4′ — Lancer un programme depuis l'éditeur

La partie a dit qu'un IDE sert à lancer et à tester, sans jamais montrer par où. Trois menus suffisent, et ils sont projetés avant le TD 2a plutôt que découverts pendant.

| | Le bouton d'exécution | Le terminal intégré |
|---|---|---|
| Où le trouver | en haut à droite de l'éditeur | Terminal → Nouveau terminal |
| Sur un `.py` | « Run Python File » | `python bonjour.py` |
| Sur un `.cpp` | « Run C/C++ File », qui demande le compilateur la première fois | `g++ …`, puis l'exécutable produit |
| Ce qu'il choisit à votre place | l'interpréteur, réglé par `Ctrl`+`Maj`+`P` → « Python: Select Interpreter » | rien : la commande dit tout |

Le module fait écrire la commande à la main, et il faut **dire pourquoi** plutôt que de l'imposer : elle est identique sur les trois systèmes, elle se relit, et c'est elle qu'on enchaînera au cours 2 puis qu'on mettra dans un script au cours 3. Le bouton, lui, change d'un langage à l'autre et masque ce qu'il fait — mais il écrit sa commande dans le terminal avant de l'exécuter, ce qui est l'argument à montrer.

> La dernière ligne est celle qui coûte cher si on la saute. Le bouton exécute avec **l'interpréteur sélectionné**, qui n'est pas forcément celui du module : c'est l'origine du `ModuleNotFoundError` « sur un paquet qu'on vient d'installer » annoncé en partie 4. La sélection vaut aussi pour le terminal, que l'extension Python active ensuite toute seule.

> Sur le bouton C++ : il existe, s'appelle « Run C/C++ File », demande de choisir un compilateur au premier lancement puis écrit un `tasks.json` dans le projet. Ne pas l'employer en séance — cela ajoute un fichier de configuration à expliquer — mais savoir répondre à celui qui l'aura trouvé.

### 🎓 3′ — De quoi compiler du C++

Python vient avec l'environnement ; un compilateur C++, non. **Windows n'en fournit aucun**, et il s'installe dans le même environnement conda.

| | Linux, macOS | Windows |
|---|---|---|
| Le compilateur | `g++`, presque toujours déjà là | aucun d'origine |
| Comment l'obtenir | rien à faire | `conda install -c conda-forge "gxx=15.3.0"` |
| Ce qu'on tape ensuite | `g++ …` | `x86_64-w64-mingw32-g++ …` |

> **Le nom de l'exécutable est le piège**, et il faut le projeter : conda-forge installe `x86_64-w64-mingw32-g++.exe`, pas `g++`. C'est le nom complet de la cible, et il ne s'invente pas. Vérifié sur un poste de l'école en septembre 2026.

> **La version fixée est le second piège**, et il n'est pas de notre fait. `gxx` 16.2.0, celui que conda prend par défaut, échoue à l'édition de liens sous Windows — `cannot find crt2.o` —, parce que les fichiers de démarrage sont installés dans `sysroot\usr\lib` et que cette version de gcc n'y cherche plus. Défaut du paquet conda-forge, ouvert le 4 septembre 2026 ([issue 229](https://github.com/conda-forge/ctng-compilers-feedstock/issues/229)) et non corrigé au 13 septembre ; les versions 13.4.0, 14.4.0 et 15.3.0 en sont indemnes. Une diapositive du TD 2c montre le message, à passer si la compilation sort du premier coup. Réparations et chemin sans conda : [`data/cours1/2c_hello_cpp/README.md`](../../../data/cours1/2c_hello_cpp/README.md).

> Ne pas employer `m2w64-toolchain`, encore proposé par de vieilles réponses en ligne : le paquet affiche lui-même à l'activation qu'il est obsolète et renvoie vers `gcc`, `gxx` et `gfortran`.

L'installation demande du réseau et quelques minutes : la lancer avant la séance si possible, sinon au début du TD 2c en enchaînant sur autre chose pendant qu'elle tourne. C'est la seule étape de la séance qui dépende du réseau de la salle. La justification de l'environnement est repoussée à la partie 4, et il faut le dire plutôt que de laisser la question en suspens.

### 🎓 3′ — Ouvrir un terminal où conda existe

`conda` n'est pas disponible dans n'importe quel terminal, et c'est la première cause de « la commande n'existe pas ».

| Où | L'action | Ce qui la prouve |
|---|---|---|
| Windows, hors éditeur | menu Démarrer, chercher « Anaconda Prompt » | l'invite commence par `(base)` |
| Linux, macOS | un terminal ordinaire suffit | l'invite commence par `(base)` |
| Dans l'éditeur | `Ctrl`+`Maj`+`P`, « Python: Select Interpreter », choisir `base` | le terminal ouvert ensuite commence par `(base)` |

Les postes de la salle ont Anaconda installé : c'est lui qui fournit l'invite de commandes d'Anaconda (« Anaconda Prompt » du menu Démarrer). Le terminal Windows ordinaire, `cmd` ou PowerShell, ne connaît pas `conda` tant qu'il n'a pas été initialisé.

> **La troisième ligne est celle qui sert toute l'année** : choisir l'interpréteur dans l'éditeur suffit, l'extension Python plaçant ensuite tous les terminaux intégrés dans cet environnement — on n'a plus à taper `conda activate`. Faire lire l'invite à voix haute une fois : `(base)` et `(base)` ne sont pas la même chose, et les confondre fait installer les paquets là où ils ne serviront pas.

### ⌨️ 25′ — TD 2a : configurer l'éditeur de code, et lancer un programme ; puis TD 2c, le même en C++ *(facultatif)*

Le TD a été renommé et étoffé en septembre 2026, après des essais sur les postes de l'école (machines virtuelles Windows avec Anaconda) : la configuration de l'éditeur n'y est pas immédiate, et c'est elle, plus que le hello world, qui est le sujet. Le dossier s'appelle `2a_vscode_python/`. Le fil, dans l'ordre des diapositives :

1. **Lancer VS Code depuis Anaconda Navigator**, après avoir choisi `base` dans la liste des environnements. Doc Anaconda : « When you launch VS Code from Navigator, it will automatically use the Python interpreter in the currently selected environment ». Que le terminal intégré hérite bien de l'environnement est **à vérifier sur un poste avant la séance** : la doc ne le dit pas.
2. **L'extension Python**, `ms-python.python`, que Navigator n'installe pas.
3. **La palette de commandes** (`Ctrl`+`Maj`+`P`) **et les réglages** (`Ctrl`+`,`, et `settings.json` à deux niveaux, User et Workspace) : une diapositive à part, parce que toutes les consignes du module passent par là.
4. **Choisir l'interpréteur.**
5. **VS Code hors Anaconda** (lancé depuis le bureau) : PowerShell refuse `activate.ps1` — « running scripts is disabled on this system » — et les élèves n'ont pas les droits pour changer la stratégie d'exécution. La solution retenue, sans droits : un profil de terminal `cmd.exe /K …\Scripts\activate.bat …`, la cible exacte du raccourci « Anaconda Prompt », posé en profil par défaut dans `settings.json` (User). Les autres pistes de l'issue vscode-python #2559 et leurs limites sont dans les notes de la diapositive : `Set-ExecutionPolicy -Scope CurrentUser` et le profil PowerShell `-ExecutionPolicy ByPass` cèdent devant une stratégie de groupe ; l'activation par variables d'environnement de l'extension (#11039) n'exécute aucun script mais la version des postes a montré l'erreur.
6. **Lancer le programme**, puis les trois façons d'exécuter `altitudes.py`, dont le pas à pas détaillé sur deux diapositives (poser l'arrêt et lancer, avec le choix « Python Debugger › Python File » au premier `F5` ; puis avancer avec `F10` en prédisant `total`, la barre de boutons et ses touches).
7. **En option, sans VS Code** : refaire lancement et session interactive depuis l'invite de commandes d'Anaconda (`conda activate base`, `cd` en glissant le dossier dans la fenêtre), pour voir ce que l'éditeur faisait à leur place.

**Les étapes sont écrites une par une et projetées telles quelles** — l'objectif seul ne suffit pas à cette séance, une étape sous-entendue est une étape où la moitié de la salle s'arrête sans le dire.

1. **Fichier → Ouvrir le dossier**, puis choisir `cours1/2a_vscode_python/` — le dossier, pas un fichier.
2. **`Ctrl`+`Maj`+`P`**, taper « Python: Select Interpreter », choisir `base`. Rien ne se passe visiblement, et c'est normal : le réglage sert au terminal qu'on ouvre juste après. Sans lui, `python` peut être un autre que celui du module.
3. **Terminal → Nouveau terminal** : il s'ouvre en bas, déjà dans `2a_vscode_python/`, ce qu'il faut faire remarquer après les erreurs de chemin du début de séance.
4. Taper `python bonjour.py`, puis Entrée.

Puis, au TD 2c, facultatif, dans `cours1/2c_hello_cpp/` :

5. Taper `g++ bonjour.cpp -o bonjour`, puis Entrée. **Rien ne s'affiche**, et c'est l'étape où la question vient : faire regarder l'arborescence plutôt que le terminal, `bonjour` vient d'y apparaître.
6. Taper `./bonjour`, puis Entrée.

Le bouton d'exécution fait la même chose que l'étape 4, et il existe aussi pour le C++ : c'est la diapositive précédente. Le montrer après, jamais avant — la commande écrite à la main est celle qui reste.

| | `bonjour.py` (TD 2a) | `bonjour.cpp` (TD 2c) |
|---|---|---|
| Ce qu'on tape | `python bonjour.py` | `g++ bonjour.cpp -o bonjour`, puis `./bonjour` |
| Étapes | une | deux : compiler, puis exécuter |
| Sur le disque | rien | `bonjour`, un exécutable |
| Taille de la source | 121 octets | 230 octets |
| Taille produite | aucun fichier | environ 20 000 octets, près de cent fois la source |

La taille de l'exécutable dépend du compilateur et du système — 19 560 octets avec g++ 13.3, 23 624 relevés ailleurs — mais l'ordre de grandeur ne bouge pas, et c'est lui qu'on fait dire.

C'est la diapositive « Deux chemins du texte à l'exécution » faite à la main : y renvoyer explicitement. Faire ensuite ouvrir `bonjour` dans l'éditeur pour constater qu'il est illisible — la diapositive « Code source et fichier exécutable », vérifiée par eux.

Sous Windows, `g++` n'est pas fourni : l'environnement conda du module, à défaut MinGW-w64 par MSYS2, les Build Tools de Visual Studio ou le sous-système Windows pour Linux. Prévoir un poste de démonstration si personne ne l'a. Détails dans [`data/cours1/2c_hello_cpp/README.md`](../../../data/cours1/2c_hello_cpp/README.md).

#### À essayer sur un poste de la salle, dans cet ordre

Rien de tout cela n'est vérifiable depuis Linux : les quatre essais tiennent en quelques minutes sur une machine de l'école, et le premier qui aboutit clôt la question. Après chaque essai, la preuve est la même — `.\bonjour.exe` affiche `Bonjour, géomatique !`.

| | L'essai | Ce qu'il faut noter |
|---|---|---|
| 1 | `conda install -c conda-forge "gxx=15.3.0"` dans `info01`, puis compiler | la version installée (`x86_64-w64-mingw32-g++ --version`) et la durée du téléchargement |
| 2 | garder 16.2.0 et ajouter `-B "%CONDA_PREFIX%\Library\x86_64-w64-mingw32\sysroot\usr\lib"` | si le seul `-B` suffit, ou si d'autres fichiers manquent ensuite |
| 3 | garder 16.2.0 et créer la jonction `mklink /J …\sysroot\lib …\sysroot\usr\lib` | si `mklink /J` passe sans droits d'administrateur sur ces postes |
| 4 | dans un environnement neuf, `conda create -n cpp -c conda-forge "gxx=15.3.0"` | si l'échec vient de l'environnement `info01` plutôt que du paquet |

L'essai 1 est celui que les supports décrivent ; les essais 2 et 3 servent le jour où le réseau de la salle ne permet pas de réinstaller. Le poste de l'école a Anaconda et non Miniforge : vérifier au passage que `conda install -c conda-forge` n'y mélange pas les canaux au point de casser `base`, et faire l'essai dans un environnement dédié plutôt que dans `base` si le doute subsiste.

---

### ⌨️ 8′ — TD 2a, suite : le même programme, trois façons de l'exécuter

`cours1/2a_vscode_python/altitudes.py`, six lignes qui calculent une moyenne d'altitudes. Choisi pour trois raisons : il tient à l'écran, il a une boucle donc un état qui change, et son résultat se vérifie de tête — le `hello world` n'avait aucune de ces propriétés. Les altitudes sont celles de la diapositive « Coloration syntaxique » : le même extrait, devenu un programme qui tourne.

1. **En entier** : `python altitudes.py` → `moyenne : 129.0 m`. Une seule ligne de sortie ; ce qui s'est passé entre-temps n'est pas visible.
2. **Ligne à ligne**, dans la session interactive : `total` s'affiche sans `print`, ce qui donne accès à l'intérieur du calcul. Faire refaire la boucle en affichant `total` à chaque tour — 128,4 puis 259,4 puis 387,0.
3. **Pas à pas dans l'éditeur** : point d'arrêt en marge de la ligne 4, lancer (`F5`, puis « Python Debugger » › « Python File » la première fois), avancer (`F10`), lire le panneau « Variables » ; `F5` pour finir, et enlever le point d'arrêt.

> Le réflexe à installer contre celui qu'ils ont déjà : on n'ajoute pas des `print` partout pour savoir ce qui se passe, on pose un point d'arrêt. Ligne 4 est choisie exprès — c'est le corps de la boucle, l'arrêt se répète trois fois et `total` change sous leurs yeux. Faire prédire la valeur avant chaque `F10`. Ne pas aller jusqu'à `F11`, qui entre dans les fonctions appelées et perd tout le monde.

> Raccourcis par défaut de VSCode, relevés dans la documentation et non sur les postes : vérifier que personne n'a un jeu modifié. **« Python en interactif » vient d'ici** et non plus de la partie 4, où son exemple s'appuyait sur un script parti en annexe.

### 🎓 2′ — Il n'existe pas qu'un interpréteur Python *(remarque)*

Diapositive de remarque, une minute. « Python » nomme le langage ; plusieurs programmes savent l'exécuter, et celui que tout le monde emploie est écrit en C.

| Interpréteur | Écrit en | Ce qui le distingue |
|---|---|---|
| CPython | C | la référence, celle qu'on installe sans le savoir |
| PyPy | Python | plus rapide sur les longs calculs, compatible en partie |
| Jython | Java | permet d'employer les bibliothèques Java |
| MicroPython | C | tient dans un microcontrôleur |

> Le seul qu'ils rencontreront est CPython, et il faut le dire ainsi pour qu'ils ne cherchent pas à choisir. Que l'interpréteur de référence soit écrit en C boucle avec « Code source et fichier exécutable » : les octets montrés étaient ceux de ce programme, compilé comme le `bonjour.exe` du TD 2c. Ne pas ouvrir la question de la vitesse, qui revient au cours 6.

---

## Partie 3 — Environnement de programmation

La partie ne s'ouvre plus sur les interfaces mais sur le problème qui rend l'outil nécessaire. L'ordre est : ce qu'un programme emprunte, pourquoi il faut isoler ces emprunts, l'outil qui le fait, comment lire ses commandes, où les taper, puis l'installation elle-même.

### 🎓 6′ — Bibliothèques et dépendances

Trois diapositives, dans cet ordre. Elles répondent à la question que les étudiants ne posent pas : pourquoi s'embêter avec un environnement.

- **Ce qu'un programme emprunte** : les lignes `import` désignent du code écrit par d'autres. Nommer le mot *bibliothèque*, écarter « librairie », faux ami de *library*. L'image qui passe bien : une recette qui commence par « prenez une pâte brisée » — vous ne la fabriquez pas, mais il faut qu'elle soit dans le placard, et que ce soit la bonne.
- **Une bibliothèque en entraîne d'autres** : `environment.yml` nomme 15 paquets, l'environnement en contient 352. Personne ne tient cette liste à la main, d'où l'outil. Conséquence à énoncer : une installation est reproductible parce qu'un fichier la décrit, pas parce qu'on se souvient de ce qu'on a tapé.
- **Pourquoi isoler un environnement** : la même machine porte numpy 1.21.5 hors environnement et 2.5.2 dans `base`. C'est la réponse au `ModuleNotFoundError` sur un paquet « qu'on vient d'installer », symptôme le plus fréquent du semestre.

### 🎓 4′ — Ce qu'une bibliothèque contient vraiment

Certaines bibliothèques ne sont que du Python ; d'autres enveloppent du code écrit dans un autre langage, déjà compilé.

| | Tout en Python | Une enveloppe autour d'un autre langage |
|---|---|---|
| Exemples | `requests`, `markdown` | `numpy`, `pillow` |
| Ce qui est distribué | du texte, lisible | du texte, plus un binaire compilé |
| Selon la machine | le même fichier partout | un fichier par système et par version de Python |
| Pourquoi | rien à compiler | la vitesse, ou une bibliothèque qui existait déjà |

> **C'est la troisième ligne qui compte.** Une enveloppe doit exister précompilée pour chaque système et chaque version de Python ; quand elle n'existe pas, l'installation tente de compiler sur place et échoue faute de compilateur — le « Microsoft Visual C++ 14.0 is required » que tout le monde a déjà vu. C'est exactement ce que conda résout, et pourquoi le module l'emploie plutôt que `pip` seul : il distribue les binaires précompilés, et sait installer ce qui n'est pas du Python, comme le compilateur C++ de la partie 2 ou `ffmpeg`. Les quatre exemples sont choisis pour être compris **sans notion préalable** : `markdown` convertit en HTML ce qu'ils viennent d'écrire au TD 3a, et c'est du Python de bout en bout ; `pillow` ouvre les `.jpg` et `.png` de la grille des extensions, mais ne les décode pas lui-même — il appelle `libjpeg` et `libpng`, deux bibliothèques C plus vieilles que les étudiants.

### 🎓 6′ — L'outil, et le minimum de ligne de commande pour s'en servir

**C'est la charnière de la séance**, et elle explique pourquoi la ligne de commande arrive ici plutôt qu'au début : on ne l'apprend pas pour elle-même, on la rencontre parce que l'outil dont on a besoin n'existe que sous cette forme. Le dire simplement — beaucoup de programmes n'ont pas de fenêtre, parce que personne n'en a écrit une — sans en faire une question d'austérité.

Trois commandes pour tout le semestre :

| Ce que vous voulez | Ce que vous tapez |
|---|---|
| créer l'environnement du module | `conda env create -f environment.yml` |
| l'activer dans le terminal courant | `conda activate base` |
| savoir ce qui est installé dedans | `conda list` |

Suivent **deux diapositives seulement**, le minimum pour lire ces lignes :

1. **Ligne de commande et interface graphique** — la comparaison sur cinq points, dont « ce qui en reste », qui prépare git au cours 2 et les scripts au cours 3. Aucune des deux ne remplace l'autre : on clique pour chercher, on tape pour répéter.
2. **Anatomie d'une commande** — le programme, l'option, l'argument, sur `soffice --convert-to pdf raven.odt`, avec son équivalent à la souris. Le lien est direct avec la première partie, où ils ont exporté `raven.odt` en PDF en cliquant : `soffice` n'est pas un autre outil, c'est le même appelé par son nom.

> **Ce qui a été retiré d'ici**, et qui reste en annexe du deck : la démonstration chiffrée `*.odt` (vingt fichiers en 2,1 s contre 1,4 s pour un seul), le tableau de décision « quand l'une, quand l'autre », les critères d'expérience utilisateur, le terminal sur les trois systèmes et la façon de l'ouvrir, et le TD de conversion LibreOffice / navigateur. **Le cours 2 traite la ligne de commande pour elle-même** : ces diapositives y sont reprises. Le dire à la salle en une phrase, pour que le survol ne passe pas pour de l'escamotage.

### 🎓 4′ — Le terminal de l'éditeur de code

Ils s'en sont déjà servis sans qu'on le nomme, au TD 2a, « hello world » : c'est le moment d'y revenir. Le terminal intégré n'est pas un autre terminal, c'est le même programme affiché dans la fenêtre de l'éditeur — le dire, parce que la question vient.

| L'action | Ce qu'elle règle |
|---|---|
| Terminal → Nouveau terminal | un terminal dans le dossier ouvert |
| le sélecteur, à droite du panneau | l'interpréteur de commandes : PowerShell, bash, zsh |
| `Ctrl`+`Maj`+`P`, `Python: Select Interpreter` | l'environnement activé dans chaque nouveau terminal |
| la barre d'état, en bas | l'environnement en cours |

La troisième ligne est celle qui évite le `ModuleNotFoundError`, et la quatrième permet de le vérifier sans rien taper. Le dossier du projet est le **dossier courant** : c'est de lui que partent les chemins relatifs.

> Les libellés dépendent de la version de VSCode et de la langue de l'interface, qui est l'anglais par défaut : à vérifier sur le poste de démonstration avant la séance. Le terminal ouvert hors de l'éditeur, et la façon de l'ouvrir sur chaque système, sont en annexe du deck ; c'est le cours 2 qui s'en occupe.

### 🎓 3′ — L'environnement de développement

Un environnement réunit une version de Python et les outils choisis, dans un dossier isolé, décrit par un fichier et recréable ailleurs. Le problème d'abord — « ça marche sur ma machine » — puis le dossier qui y répond.

**Rien n'est créé ici** : seul Anaconda est installé avant la séance, et son environnement `base` suffit aux premiers TD. Ce qui est projeté est la commande, pour qu'ils sachent la relire ; le TD qui suit la fait taper sur un environnement de projet, en quelques secondes parce qu'il ne pose que Python.

```bash
conda create -n recette -c conda-forge python=3.12 markdown tabulate
conda activate recette
```

- **Anaconda** : <https://www.anaconda.com/download>. Le dépôt ne distribue plus d'`environment.yml` commun : chaque TD qui a besoin d'un environnement fait écrire le sien.
- Vérification : invite `(recette)`, puis `import sys; print(sys.executable)`, dont le chemin doit contenir le nom de l'environnement actif.
- **Message à marteler** : `ModuleNotFoundError` alors qu'« on vient d'installer » = presque toujours le **mauvais environnement actif**. Le TD 3b le fait constater.
- L'environnement sert à **installer des outils**, pas à packager un projet (décision de conception du module).

> ⚠️ **Point de bascule de la séance.** Si l'environnement manque sur quelques postes, le TD 3b ne se fait pas, et le cours 3 démarre mal. Prévoir : consigne d'installation **avant** la rentrée, une clé USB avec l'installeur Miniforge (Windows/macOS), et un binôme d'entraide. Voir les leviers d'allègement dans [`inversion_c1_c3.md`](../../inversion_c1_c3.md).

### 🎓 3′ — Les outils d'installation, et d'où viennent les paquets

Trois diapositives courtes, insérées après « L'outil qui installe un environnement ». Elles répondent à ce que les étudiants trouveront de toute façon en cherchant sur le web, et sèment la question de la confiance.

1. **Les outils qui installent des paquets** — une frise dessinée : `pip` (2008), `conda` (2012), `conda-forge` (2015), `mamba` (2019), `pixi` (2023), `uv` (2024). Ce qu'il faut dire, et rien de plus : `pip` installe des bibliothèques Python et rien d'autre, il ne sait pas installer `ffmpeg` ni un compilateur C++ ; `conda` fait les deux, d'où le choix du module. `pyenv` est nommé dans la légende pour ce qu'il est — un sélecteur de version de Python, qui n'installe aucun paquet — parce que son nom le fait confondre avec les autres. `uv` et `pixi` sont récents, écrits en Rust, excellents, et hors programme : le module s'en tient à un seul outil. Ne pas laisser croire à une succession où le dernier remplace les précédents ; `pip` a dix-huit ans, il est installé dans l'environnement du module, et `uv` l'appelle encore par-dessous.
2. **D'où viennent les paquets** — PyPI, 886 022 projets, publication immédiate et sans relecture ; conda-forge, 29 411 paquets, chacun avec une recette relue par des humains. Ni bon ni mauvais dépôt : un paquet conda-forge est le plus souvent construit à partir des mêmes sources que le paquet PyPI, quelques jours plus tard. Ce qui change est la porte d'entrée.
3. **Ce qu'une installation exécute** — `requests` contre `reqeusts`, en grand, côte à côte. Installer un paquet exécute du code écrit par quelqu'un d'autre, avec les droits de celui qui a tapé la commande. Le typosquattage n'a rien de théorique : des campagnes de plusieurs centaines de faux paquets ont été relevées sur PyPI, calqués sur les noms les plus téléchargés.

> **Le réflexe, et c'est la seule chose à retenir** : le nom d'un paquet se copie depuis la documentation du projet, il ne se tape pas de mémoire. Ne pas transformer cela en peur de tout installer — la conclusion est une action, pas une abstention. Chiffres relevés le 8 septembre 2026 (index de PyPI, API de GitHub) ; 454 600 nouveaux paquets malveillants recensés en 2025, tous dépôts confondus, *State of the Software Supply Chain*, Sonatype, 2026.

> **Sur le canal `defaults` d'Anaconda**, si la question vient : le module emploie Miniforge, qui n'installe que depuis conda-forge, parce que les conditions d'utilisation du dépôt d'Anaconda demandent une licence payante aux organisations au-delà d'une certaine taille. La raison est dans [`INSTALLATION.md`](../../../INSTALLATION.md) et n'a pas à être développée en séance.

### ⌨️ 12′ — TD 3b : installer une bibliothèque et s'en servir

Fichiers : [`data/cours1/environnement/`](../../../data/cours1/environnement/) — un petit projet Python écrit comme les dépôts qu'ils ouvriront cette année : `pyproject.toml`, `environment.yml`, `README.md`, le paquet `page_html/` et `style.css`. Le README y donne le déroulé complet. Trois diapositives d'étapes, après l'ouverture brune.

C'est le seul TD de la partie, et il en est la conclusion : la partie a dit ce qu'un programme emprunte et quel outil l'installe, sans que personne n'ait encore installé quoi que ce soit. `page_html` convertit en page HTML le `recette.md` écrit à la partie 3, avec la bibliothèque `markdown`, qui n'est nulle part.

**On repart d'un environnement neuf**, et non de `base` : c'est ce qui permet de voir ce qu'un environnement contient d'origine, ce qui manque, et ce qu'une installation ajoute.

| # | L'action | Ce qu'ils constatent |
|---|---|---|
| 1 | Ouvrir le dossier `data/cours1/environnement/` | l'arborescence d'un projet, pas un script isolé |
| 2 | Lire la ligne `dependencies` de `pyproject.toml` | le projet annonce avoir besoin de `markdown` |
| 3 | `conda env create -f environment.yml`, puis `conda activate recette` | l'invite passe de `(base)` à `(recette)` |
| 4 | `conda list` | **28 paquets**, dont `pip`, `setuptools`, et une douzaine de bibliothèques C — aucun `markdown` |
| 5 | `python -m page_html` | `ModuleNotFoundError: No module named 'markdown'` |
| 6 | `conda install -c conda-forge markdown` | **trois** paquets : `markdown`, `importlib-metadata`, `zipp` |
| 7 | `python -m page_html`, à nouveau | `recette.md -> recette.html, 1282 octets` |
| 8 | Ouvrir la page par l'adresse `file:///` affichée | la recette mise en page, sans serveur |
| 9 | Changer une couleur dans `style.css`, `F5` | la page change, le `.html` n'a pas bougé |
| 10 | Ajouter `- markdown` sous `dependencies` dans `environment.yml` | le fichier décrit enfin ce qu'on a installé |
| 11 | `conda env update -f environment.yml` | rien ne s'installe : c'était déjà fait |

**L'étape 4 est la surprise du TD.** Un environnement « Python seul » n'est pas vide : 28 paquets, dont une douzaine de bibliothèques C — `openssl`, `libsqlite`, `libzlib` — sans lesquelles l'interpréteur ne démarre pas. `pip`, `setuptools` et `wheel` y sont aussi, ce qui explique que `pip install` fonctionne dans un environnement conda sans qu'on l'ait installé. Et rien de ce que fait un programme utile : ni `numpy`, ni `jupyterlab`, ni `markdown`.

**L'étape 5 ne se saute pas.** C'est la seule fois de la séance où ils voient `ModuleNotFoundError` dans des conditions où la cause est connue d'avance : le message annoncé deux fois depuis la partie 2 devient une chose qui leur est arrivée. Dire en une phrase ce que `-m` fait — exécuter un paquet plutôt qu'un fichier — et ne pas s'y attarder.

**Le chiffre de l'étape 6 vaut la comparaison** : trois paquets ici, un seul dans `base`, où `importlib-metadata` et `zipp` avaient déjà été tirés par autre chose. C'est « Une bibliothèque en entraîne d'autres » vérifié par eux, et la démonstration que ce qui est déjà là ne se réinstalle pas.

Trois choses de la séance se referment à l'étape 8, et elles se nomment une par une : le `recette.md` est celui qu'ils ont écrit une demi-heure plus tôt ; la page sépare le contenu de la présentation, comme les deux pages du poème de la partie 1 ; elle s'ouvre par une adresse `file:///`, sans serveur.

**Les étapes 10 et 11 sont la conclusion de la partie**, et elles démontrent enfin ce que la deuxième diapositive annonçait : une installation n'est pas reproductible parce qu'on se souvient de ce qu'on a tapé, elle l'est parce qu'un fichier la décrit. Le faire devant eux — une ligne ajoutée, quatre caractères d'indentation.

**La question à poser avant de répondre** : pourquoi le diagramme n'est-il pas dessiné ? Le bloc `mermaid` arrive dans la page sous la forme de ses six lignes de texte. Mermaid est un service de l'aperçu de l'éditeur, pas du HTML. C'est la distinction tenue toute la séance entre ce qu'un fichier contient et ce qu'un logiciel en affiche, déjà rencontrée avec la coloration syntaxique et avec la chasse fixe.

**Pour ceux qui vont vite**, et seulement pour eux : `pip install -e .` installe le projet lui-même, après quoi la commande `page-html` existe. C'est la section `[project.scripts]` de `pyproject.toml`, et c'est le sujet du cours 3. Rendre la main ensuite par `conda deactivate` puis `conda activate base`.

> **Mesuré sur la machine de préparation**, sous Linux, avec le solveur `libmamba` de conda 24.7 : création de l'environnement en 10 s (index en cache), 28 paquets ; `conda install markdown` en 7 s et 3 paquets dans l'environnement neuf, contre 1 paquet de 85 ko et 1 min 52 s à froid dans `base`. Trente postes en même temps iront moins vite. Commenter la sortie de `conda install` pendant qu'elle tourne plutôt que d'attendre en silence. Les libellés de menu de l'éditeur n'ont pas été vérifiés sur un poste Windows. Poste sans réseau : les étapes 3 et 6 échouent ; projeter le résultat, et faire quand même les étapes 10 et 11, qui ne demandent que d'éditer un fichier.

> **Pourquoi `markdown` et pas `jinja2`.** L'idée d'un `.odt` produit depuis un modèle, par substitution dans `content.xml`, a été écartée pour une raison mesurée : `jinja2` **est déjà installé** dans `base`, tiré comme dépendance de Sphinx et de JupyterLab, et `conda install jinja2` n'installerait rien. `markdown` est absent des deux environnements, et il est l'exemple « tout en Python » de la diapositive « Ce qu'une bibliothèque contient vraiment » : l'installation la vérifie. Il n'est **pas** ajouté à l'`environment.yml` du module, l'objet du TD 3b étant d'ajouter une bibliothèque à un environnement qui existe déjà.
### 🎓 4′ — Python en interactif

Taper `python` sans nom de fichier ouvre une session interactive : chaque ligne est lue, exécutée, et son résultat affiché aussitôt, sans `print`. La trace projetée est une session réelle, dans `data/cours1/formats/`, qui réimporte le script des octets de tête.

Deux façons d'exécuter du Python, et elles ne servent pas à la même chose : un script se lance en entier et se relance à l'identique, une session interactive s'essaie ligne à ligne et ne laisse rien.

- Faire remarquer les **trois chevrons** : c'est l'invite de Python, pas celle du terminal. Les confondre est l'erreur de début de semestre, et elle produit un `SyntaxError` quand on tape une commande du système dans Python.
- On y entre par `python`, on en sort par `exit()` ou `Ctrl`+`D`. Le dire tout de suite : on ne devine pas comment sortir.
- Le module réimporte ici son propre script comme une bibliothèque : c'est « Ce qu'un programme emprunte » vu de l'autre côté, le code de quelqu'un d'autre étant aussi du code écrit par eux dix minutes plus tôt.

**Amorce de la partie suivante** : un notebook est cette session interactive, avec le texte conservé autour.

---

## Partie 4 — Notebooks

### 🎓 10′ — Notebooks

- **Deux moitiés** : l'interface (navigateur ou VSCode) affiche, le **noyau** (un processus Python) calcule et *retient les variables*.
- Deux conséquences, à faire vivre plutôt qu'à énoncer :
  - « Redémarrer le noyau » efface les variables — le texte des cellules reste, son effet disparaît ;
  - l'ordre d'exécution (`[1]`, `[2]`…) n'est pas l'ordre d'affichage.
- **Démonstration en direct** (2′) : `x = 10` / `print(x*2)` → modifier la première cellule sans l'exécuter → la seconde ment. Puis *Restart & Run All*.
- **`.ipynb` vs MyST** : JSON généré (résultats et images inclus, `git diff` illisible) vs Markdown écrit (résultats recalculés, `diff` lisible). Montrer que **le support projeté est lui-même un fichier MyST**.
- **Trois façons d'ouvrir un notebook**, et la troisième referme « Le lieu du calcul » de la partie 1 :

| Comment | Ce que vous lancez | Où tourne le noyau |
|---|---|---|
| Dans l'éditeur de code | le `.ipynb` ouvert dans VSCode | sur votre machine |
| JupyterLab en local | `jupyter lab` dans un terminal | sur votre machine |
| Dans le navigateur | **JupyterLite**, une adresse à ouvrir | dans l'onglet, chez vous |

> JupyterLite n'a **pas de serveur** : son noyau Python est compilé en WebAssembly et tourne dans l'onglet, si bien que rien de ce qu'on écrit ne part sur le réseau. C'est un service en ligne où le calcul se fait chez soi — exactement le cas qu'on annonçait en partie 1 sans pouvoir le montrer. Ni compte ni installation, ce qui le distingue de Colab et de Binder. Ne pas le proposer comme environnement de travail : tous les paquets n'y sont pas, et ce qu'on y dépose vit dans le navigateur.

- **Bouclage explicite** : « même contenu, deux formats » — la leçon d'il y a une heure, appliquée à leur propre travail. Et amorce du cours 2 : *pourquoi le texte se versionne bien*.
- **Quand un notebook, quand un script** *(diapositive de clôture)*. La partie disait ce qu'est un notebook sans jamais dire quand en ouvrir un ; c'est ce que cette diapositive corrige.

| | Notebook | Script `.py` |
|---|---|---|
| Ce qu'on y cherche | explorer, expliquer, montrer | refaire, automatiser |
| Exécution | cellule par cellule, l'état reste | du début à la fin |
| Le résultat | dans le document, avec le texte qui l'explique | à l'écran ou dans un fichier |
| Se relance seul | non | oui |
| Se partage comme outil | mal : il faut le noyau, et le bon ordre | bien : une commande |

> La formule à laisser : **on explore dans un notebook, on livre un script.** Le cas d'usage se reconnaît — on ouvre un notebook parce qu'on ne sait pas encore ce qu'on cherche ; le jour où cela marche et doit tourner sans surveillance, cela devient un script, et c'est le cours 3. Ne pas opposer les deux : le notebook n'est pas un brouillon honteux, le script n'est pas la version sérieuse. La progression notebook → script → CLI est l'arc du module, et c'est ici qu'elle s'énonce.

Cette diapositive **remplace** « Ce que le notebook réunit », récapitulation que le minutage désignait déjà comme la première à sauter : la partie garde donc sa longueur, et « À retenir » assure seule la clôture de la séance.

### ⌨️ 15′ — TD 4a : le notebook, ouvert de trois façons

Support : deux notebooks écrits pour le TD, `src/cours1/notebook/td/4a_notebooks/`, en MyST et convertis par `python outils/construire_notebooks.py`. `altitudes.ipynb` reprend le programme du TD 2a et fait constater ce que le noyau retient entre deux cellules ; `recette.ipynb` reprend celui du TD 3b, une fonction par cellule et rien d'importé, avec en tête un chemin relatif à commenter et à changer.

Ouvrir un `.ipynb` dans VSCode demande l'extension `ms-toolsai.jupyter`, la troisième et dernière du module : l'éditeur la propose à la première ouverture.

| | L'action | Ce qu'on observe |
|---|---|---|
| Dans le navigateur | ouvrir [jupyter.org/try-jupyter](https://jupyter.org/try-jupyter/lab/), y déposer le fichier | aucun compte, aucune installation, et le calcul se fait chez vous |
| Dans l'éditeur | ouvrir le `.ipynb`, installer l'extension proposée, choisir le noyau `base` | les cellules s'exécutent par `Maj`+`Entrée` |
| Dans JupyterLab | `jupyter lab` au terminal, puis le fichier dans l'arborescence | une adresse `localhost`, donc un serveur qui est le vôtre |

L'ordre est celui de l'engagement croissant : rien à installer, puis l'éditeur qu'ils ont déjà, puis un serveur qu'ils lancent eux-mêmes. Si le réseau de la salle est mauvais, sauter la première et la montrer au tableau ; le premier chargement de JupyterLite prend une dizaine de secondes.

> **Les deux cellules à faire attendre.** Dans `altitudes.ipynb`, la dernière : relancer la boucle sans relancer les données ajoute une seconde fois les trois altitudes, et c'est ce que le noyau retient qui se voit. Dans `recette.ipynb`, la première : elle est à commenter ligne à ligne avant d'être exécutée, ce qui oblige à lire du code qu'on n'a pas écrit.

> **Dans le navigateur, ce qui marche et ce qui ne marche pas.** JupyterLite exécute Python par Pyodide et n'est pas limité à la bibliothèque standard : `%pip install` y pose une bibliothèque pure Python. Ce qui échoue est tout ce qui demande un processus au système, `subprocess` en tête — d'où le notebook du TD 4c, qui appelle ffmpeg et ne tourne qu'en local.

> Le noyau à choisir dans l'éditeur est la même question que l'interpréteur de la partie 2, et la même réponse — `base`. Le dire ainsi plutôt que comme une nouveauté. Et le fichier source étant en MyST, donc du texte comparable ligne à ligne, c'est « Deux formats de notebook » vérifié sur le support qu'ils ont sous les yeux.

---

## Partie 5 — Markdown et les autres fichiers texte

La partie ne traite plus que des formats de texte d'un projet, en dehors du code : ce qu'on édite dans un projet, Markdown en tête, une page HTML et sa feuille de style, et un diagramme écrit en texte.

Ce qui relève de l'édition du code est passé à la partie 2, dont il prolonge l'exposé sur l'éditeur : programmer c'est éditer du texte, les règles d'écriture d'un langage, la coloration, la vérification, les espaces et les tabulations. Le TD des programmes fautifs les suit, à la partie 2 également, puisqu'elle en dépend.

### 🎓 4′ — Programmation et édition de texte *(ouverture de la partie)*

Tout ce qui sera produit cette année passe par l'édition d'un fichier texte : le programme, ses réglages, sa documentation, jusqu'à ce que git doit ignorer. Ce n'est donc pas un détail d'outillage, c'est l'opération de base — et c'est ce que la partie outille.

La preuve visuelle est un face-à-face de ce que coûte l'édition sans outil adapté : une faute qui se découvre à l'exécution plutôt que soulignée à la frappe, un fichier cherché dans l'explorateur plutôt que dans l'arborescence, un programme relancé dans une autre fenêtre, une indentation fausse qui ne se voit pas. La colonne de droite annonce le plan de la partie.

> La colonne de gauche n'est pas une caricature : c'est ce que fait quelqu'un qui écrit son code dans le Bloc-notes, et plusieurs l'auront fait au lycée. Ne pas s'en moquer, montrer ce que cela coûte.

### 🎓 5′ — Texte brut et document mis en forme

**Texte brut et document mis en forme.** Un programme s'écrit dans un éditeur de texte brut, jamais dans Word ni LibreOffice : pas de gras, pas de taille de police, pas de style, non parce que ce serait laid mais parce qu'un `.py` n'a aucun endroit où les enregistrer. La preuve est le `content.xml` ouvert en début de séance, la même ligne de code noyée dans les balises de style. Le piège concret à annoncer maintenant : un traitement de texte remplace tout seul les guillemets droits par des guillemets typographiques, et le programme recopié depuis un document Word refuse alors de s'exécuter sur un message qui ne parle pas de guillemets.

### 🎓 4′ — Les règles d'écriture d'un langage

À placer **avant** la coloration et la vérification, qu'elle justifie l'une et l'autre. Un langage de programmation a une grammaire appliquée à la lettre, et surtout **beaucoup moins d'exceptions que l'orthographe** — c'est ce qui rend la vérification automatique possible.

| | L'orthographe du français | La grammaire d'un langage |
|---|---|---|
| Les règles | nombreuses, et souvent affaire d'usage | peu nombreuses, et écrites noir sur blanc |
| Les exceptions | à apprendre une par une | presque aucune |
| Qui tranche | l'usage, parfois personne | l'interpréteur, sans appel |
| Une faute | le lecteur comprend quand même | le programme s'arrête |

La comparaison sert à désamorcer une inquiétude, et il faut la formuler dans ce sens : un langage s'apprend plus vite qu'une langue, parce qu'il a peu de règles et presque pas d'exceptions. Ce qui est difficile n'est pas la syntaxe mais de savoir quoi écrire, et cela relève du cours de programmation. La contrepartie est la dernière ligne : la machine n'interprète pas les intentions.

> On ne peut pas écrire un logiciel qui corrige un texte français de façon sûre ; on peut en écrire un qui vérifie un programme. C'est exactement ce que fait l'extension installée au TD 2b.

### 🎓 4′ — Coloration et vérification

- **Coloration syntaxique** : chaque langage a ses règles d'écriture, l'éditeur les connaît et donne une couleur à chaque catégorie de mot. La preuve est le même extrait Python affiché deux fois, sans couleur puis avec. Faire nommer par la salle ce que la couleur distingue — mots du langage, nombres, texte entre guillemets, noms choisis par celui qui écrit — avant de le dire. L'intérêt n'est pas le confort : un mot-clé mal orthographié perd sa couleur, et cela se voit sans rien exécuter.
- **Vérification de l'écriture** : l'éditeur relit le fichier pendant qu'on l'écrit, le compilateur ne répond qu'au lancement. La comparaison qui fait comprendre est le correcteur orthographique, qui souligne le mot sans attendre l'impression. La preuve est `cpp/aire.cpp`, où le point-virgule manque à la ligne 6 et où **g++ signale la ligne 7** : un compilateur désigne l'endroit où il ne peut plus continuer, pas l'endroit de la faute. Lire le message, puis remonter d'une ligne, est le réflexe à donner.

> On dit ici « l'éditeur » et non « l'extension » : d'où vient ce service est le sujet de la diapositive qui ferme le bloc, et il vaut mieux faire constater le soulignement avant d'en expliquer l'origine.

### 🎓 5′ — Ce que l'éditeur ajoute au texte

Deux fois la même ligne, en chasse fixe puis en chasse proportionnelle : à gauche les `=` s'alignent, à droite non. Couleurs, numéros de ligne et police sont des affichages ; seule l'indentation est dans le fichier.

La diapositive est placée **juste avant** les espaces et tabulations, parce que c'est le même sujet pris par l'autre bout : si l'éditeur impose une police à chasse fixe, c'est pour que les colonnes s'alignent et que les espaces se comptent — exactement ce dont Python a besoin, et ce que la diapositive suivante fait constater.

Point de culture : le mot vient de l'imprimerie, où la chasse est la largeur d'un caractère. Le rapprocher de LibreOffice, manipulé en début de séance, où l'on choisit une police pour la mise en page alors qu'ici on la subit pour une raison technique.

### ⌨️ 5′ — Espaces, tabulations et fins de ligne

Erreur qui coûtera des heures au semestre si elle n'est pas nommée maintenant. Un fichier dont une ligne est indentée par quatre espaces et la suivante par une tabulation produit `TabError: inconsistent use of tabs and spaces in indentation`, et rien ne se voit à l'œil.

- Faire **activer l'affichage des espaces** sur les postes : Affichage → Rendu des espaces → Tout. Un point par espace, une flèche par tabulation.
- Faire lire la **barre d'état** : `Spaces: 4` dit ce qu'insère la touche de tabulation, `LF` ou `CRLF` dit comment les lignes se terminent.
- Sur les fins de ligne : Windows en met deux caractères, Linux et macOS un seul. Un même fichier n'a donc pas la même taille selon la machine qui l'a écrit, et un diff peut signaler toutes les lignes comme modifiées alors qu'aucune ne l'est. Le point est repris au cours 2 avec git ; aujourd'hui, savoir où l'éditeur l'affiche suffit.

### 🎓 5′ — Extension de fichier et extension de VSCode *(clôture du bloc)*

Un seul mot pour deux choses sans rapport, et la confusion est réelle : « installe l'extension Python » et « le fichier a l'extension `.py` » ne parlent pas de la même chose. Le dire explicitement, une fois.

| | L'extension du fichier | L'extension de l'éditeur |
|---|---|---|
| Ce que c'est | la fin du nom, après le dernier point : `.py`, `.cpp`, `.md` | un greffon installé dans VSCode : `ms-python.python` |
| Dans le fichier | rien : les trois sont du texte, sans marque ni en-tête | rien non plus : elle n'agit que sur l'affichage |
| Ce qu'elle apporte | une indication de langage, à qui lit le nom | la coloration fine, et la vérification des règles d'écriture |

**La colonne de gauche est le point neuf.** Un `.py` et un `.cpp` sont des fichiers texte, et rien dans leurs octets ne les distingue : pas de marque binaire, pas d'en-tête, pas de signature. L'extension est purement informative — elle dit ce qu'on peut espérer trouver dedans, elle ne le garantit pas. `python bonjour.txt` exécute parfaitement un programme Python : la démonstration tient en cinq secondes et se retient. C'est aussi ce que le TD 5a, « Les premiers octets d'un fichier », fera constater plus loin dans la partie, les formats texte n'ayant aucune signature contrairement au ZIP et au PDF.

**La vérification est partielle**, et c'est la limite à poser : elle porte sur les règles d'écriture, pas sur le sens. Un programme peut être irréprochable pour l'extension et faire exactement le contraire de ce qu'on voulait. Cela prolonge « Les règles d'écriture d'un langage ».

Les trois du module, avec leur identifiant, qui est ce qu'il faut chercher dans le panneau puisque les noms affichés se ressemblent tous :

| Langage | Extension | Ce qu'elle ajoute |
|---|---|---|
| Python | `ms-python.python` | vérification, complétion, lancement du fichier |
| C++ | `ms-vscode.cpptools` | vérification, complétion, compilation et débogage |
| Notebooks | `ms-toolsai.jupyter` | exécution des cellules dans l'éditeur |

> Identifiants relevés sur le poste de préparation, où les trois extensions sont installées. L'extension Python installe elle-même Pylance, qui fait la vérification : ne le dire que si quelqu'un remarque qu'une deuxième extension est apparue.

### ⌨️ 10′ — TD 2b : extensions de langage et programmes fautifs

Ouvrir `cours1/2b_erreurs/` dans l'éditeur. Trois fichiers Python courts, chacun fautif d'un genre différent. Détails et messages complets dans [`data/cours1/2b_erreurs/README.md`](../../../data/cours1/2b_erreurs/README.md).

**1. Installer l'extension.** Ouvrir `surface.py` **avant** toute installation : le texte est déjà coloré, ce qui surprend et doit surprendre — la coloration ne vient pas de l'extension. Installer ensuite `ms-python.python` par `Ctrl`+`Maj`+`X`, rouvrir le fichier : une ligne se souligne, sans que rien ait été exécuté. C'est cela que l'extension apporte.

> L'éditeur n'a pas pu être piloté sur le poste de préparation. Le soulignement et la proposition automatique de l'extension C/C++ à l'ouverture d'un `.cpp` viennent de la documentation de VSCode et restent **à vérifier sur les postes de la salle**. Prévoir aussi le poste sans réseau : les extensions ne s'installent pas, et la suite se fait quand même.

**2. Corriger les trois programmes.** Lancer, lire le message, corriger, relancer. L'ordre est celui de la difficulté de lecture, et il faut le suivre.

| Fichier | Message | La faute |
|---|---|---|
| `surface.py` | `TabError: inconsistent use of tabs and spaces`, ligne 6 | ligne 6 indentée par une tabulation, ligne 5 par des espaces |
| `moyenne.py` | `SyntaxError: expected ':'`, ligne 6 | deux-points manquants après le `for` |
| `chemin.py` | `FileNotFoundError: [Errno 2] No such file or directory: 'C:/Users/alice/…'` | un chemin absolu, celui du poste où le programme a été écrit ; la correction est `../1a_formats/depart/raven_une_ligne.txt` |

Messages réels, obtenus avec Python 3.12.14. La colonne « la faute » est masquée à la projection et remplie par `--input corrige=true`. Une fois corrigés, les trois affichent `294.0`, `130.05` et `1341 caractères`.

La première ne se voit pas à l'œil : c'est là qu'on fait activer **l'affichage des espaces**, Affichage → Rendu des espaces → Tout, réglage à garder toute l'année. La troisième est d'une autre nature, et c'est le point : le programme est correct, l'éditeur ne souligne rien, et il tourne chez Alice ; il échoue ici parce que le chemin absolu n'existe que sur son poste. Le chemin relatif part du dossier où le terminal se trouve et vaut partout — la diapositive « Le chemin d'un fichier » vérifiée par eux, et l'erreur la plus fréquente des rendus des autres cours. Le C++ fautif (`aire.cpp`, point-virgule manquant, signalé à la ligne suivante) est sorti du TD avec le passage du C++ en facultatif.

La vérification demandée n'est pas que le programme affiche le bon résultat, mais qu'il n'affiche plus de message : c'est la définition de « ça marche » à ce stade. Une fois corrigés, les trois affichent `294.0`, `130.05` et `294`.

Sous Windows sans compilateur, le fichier C++ se lit et se corrige mais ne se compile pas ; le soulignement de l'éditeur reste alors la seule vérification.

### 🎓 — Reprise du cours : Markdown et les autres fichiers texte

Le TD précédent est au milieu de la partie, pas à sa fin. Une **diapositive de reprise** (`separateur-reprise`, fond bleu, mention « Reprise du cours ») marque le retour à l'exposé : sans elle, rien ne dit où le travail sur machine s'arrête, puisque les diapositives de TD ont le même fond blanc que le cours. Le bleu ouvre un bloc de cours, le brun un bloc sur machine.

### 🎓 10′ — Les fichiers texte d'un projet, et Markdown

Quatre diapositives qui existent parce que la séance **demande du Markdown sans l'avoir montré** : les notes du jour, le `README`, et le premier commit du cours 2 sont tous en `.md`.

- **La famille.** Le code n'est pas le seul texte d'un projet : `.py` porte les instructions, `.json` et `.yaml` les réglages, `.csv` les données, `.md` la documentation. Tous s'ouvrent dans le même éditeur, se comparent ligne à ligne et se versionnent. C'est le `.md` qui occupe la suite de la partie : celui qu'ils écriront le plus tôt et le plus souvent.
- **L'intention de Markdown.** John Gruber, 15 mars 2004, avec Aaron Swartz pour unique bêta-testeur ; les titres en `#` viennent d'`atx`, le format de Swartz. Le but déclaré : un texte « publiable tel quel, sans avoir l'air balisé », inspiré du courriel en texte brut. La preuve est un face-à-face `.md` / HTML au même rendu, dont seul le premier se lit sans conversion. CommonMark (2014) n'est à mentionner que si quelqu'un signale un rendu qui diffère d'un outil à l'autre.
- **Trois façons d'écrire un document**, et quand employer chacune :

| | `.txt` | `.md` | `.odt` / `.docx` |
|---|---|---|---|
| Titres, listes, emphase | aucun | dans le texte | dans des balises |
| Lisible sans logiciel | oui | oui | non |
| Se compare ligne à ligne | oui | oui | non |
| Mise en page fine | non | non | oui |
| Quand l'employer | note jetable, sortie de programme | `README`, notes, doc d'un projet | rapport à rendre, charte imposée |

> Le piège à désamorcer sur-le-champ : « mon rapport doit être en PDF » n'est pas un argument contre Markdown, puisque `pandoc notes.md -o notes.pdf` le produit — c'est d'ailleurs le premier outil du cours 2. Ce qu'on perd est le contrôle fin de la mise en page, ce qu'on gagne est de pouvoir relire, comparer et versionner.

- **Ce que l'éditeur en fait**, relevé dans les extensions livrées avec VSCode plutôt que supposé :

| Format | Fourni d'origine | Où voir le rendu |
|---|---|---|
| `.md` | coloration, plan du document, complétion et vérification des liens | dans l'éditeur, `Ctrl`+`Maj`+`V` |
| `.html`, `.css` | coloration, complétion des balises et des propriétés | dans le navigateur, par `file:///` |

> `markdown-language-features`, `html-language-features` et `css-language-features` sont livrés avec l'éditeur. Le propos est ce qu'on en conclut : pour tout ce qu'on écrira en dehors du code, il n'y a rien à installer — contraste avec Python et C++, qui exigent une extension. Montrer l'aperçu Markdown en direct sur le fichier de notes du jour.

> JSON et YAML sortent de la séance : le sujet n'y est pas assez employé pour valoir une diapositive projetée. La comparaison, et le fait que `yaml-language-features` n'existe pas contrairement à `json-language-features`, sont conservés en annexe.

La grille des seize extensions de la partie 1 a été révisée en conséquence : `.md`, `.json` et `.yaml` y entrent, `.flac`, `.mkv` et `.7z` en sortent (des doublons de `.mp3`, `.mp4` et `.zip`), et la dernière ligne regroupe les quatre fichiers qu'ils éditeront eux-mêmes. Six des seize formats sont maintenant du texte, contre trois.

### 🎓 4′ — La syntaxe de Markdown

Une dizaine de marques suffisent, et chacune se lit telle quelle : le dièse annonce un titre, le tiret une puce, les astérisques une emphase. La preuve est un face-à-face source / rendu — ce qu'il faut faire remarquer est que **la colonne de gauche se lit déjà**, l'intention de Gruber rendue concrète.

Les deux pièges à signaler, une minute chacun : une ligne vide sépare les paragraphes, sans quoi deux lignes consécutives n'en font qu'un ; et le dièse veut un espace après lui.

### 🎓 4′ — Un diagramme écrit en texte

Six lignes dans un bloc `mermaid`, et l'aperçu dessine les boîtes et les flèches. **Rien à installer** : depuis la version 1.121, VSCode rend les diagrammes Mermaid dans l'aperçu Markdown d'origine — vérifié sur le poste de préparation, où `mermaid-markdown-features` est livré avec l'éditeur.

> L'intérêt n'est pas de dessiner joli, c'est que le schéma soit du texte : il se compare ligne à ligne, il se versionne, et on le corrige sans rouvrir un logiciel de dessin. Faire remarquer que le dessin n'est pas dans le fichier — les boîtes sont calculées à l'affichage, comme la coloration l'était pour le code. Le cours 2 s'en sert pour représenter l'historique d'un dépôt git.

### ⌨️ 20′ — TD 3a : formatage HTML et Markdown

Données : `cours1/1a_formats/`, produites dans le dépôt par `python make_data.py fetch && python make_data.py build`.
Textes du domaine public : **The Raven** (Poe, 1845) et **Auld Lang Syne** (Burns, 1788).

| Étape | Fichier | Action | Constat attendu |
|-------|---------|-------|------------------|
| 1 | `*_brut.html` | ouvrir dans le **navigateur** (double-clic) | adresse en `file://` — **aucun serveur** ; le navigateur ignore les sauts de ligne : la structure se **déclare** (`<p>`, `<br>`) |
| 2 | `*_style.html` + `style.css` | ouvrir, puis éditer le CSS et recharger (`F5`) | **contenu ≠ présentation** : deux fichiers, on change l'apparence sans toucher au texte |

C'est l'aspect graphique du fil « texte » : le même contenu, deux présentations, et la seconde se règle dans un fichier texte qu'on édite dans le même éditeur. Faire éditer `style.css` en direct — `background`, `font-family`, `max-width` — et recharger : le retour est immédiat, et c'est ce qui fait comprendre la séparation.

**Second temps — mettre en forme une recette.** Support dans `cours1/3a_markdown/` : `recette_a_formater.txt` (le texte de départ, sans aucune structure), `ingredients.csv`, et `recette.md` (le résultat attendu, à n'ouvrir qu'après avoir essayé). L'exercice n'est pas de recopier des marques, c'est de **décider ce qui est un titre, ce qui est une étape et ce qui est une donnée** : la mise en forme est une lecture du contenu.

| | Ce qu'il faut faire |
|---|---|
| 1 | ouvrir `cours1/3a_markdown/`, puis `recette_a_formater.txt` |
| 2 | l'enregistrer sous `recette.md`, aperçu côte à côte par `Ctrl`+`K` puis `V` |
| 3 | un titre en `#`, deux sous-titres en `##` |
| 4 | les étapes de préparation en liste numérotée |
| 5 | les ingrédients en tableau, depuis `ingredients.csv` |
| 6 | l'ordre des opérations en bloc `mermaid` |

> Étape 5 : le tableau se tape à la main la première fois — l'intérêt est de voir qu'un tableau Markdown n'est que des barres verticales, et que leur alignement n'est même pas obligatoire. Une extension du catalogue le fait ensuite en une commande, chercher « CSV to Markdown Table » ; plusieurs existent et se valent, aucune n'est indispensable. Pour ceux qui vont vite : une photo par `![](…)`, ce qui fait retravailler les chemins relatifs, et la remarque finale en citation par `>`.

> **Ce qui est sorti de la séance.** Le TD comptait cinq étapes : remettre en forme un `.txt` d'une seule ligne, renommer un `.donnees`, ouvrir un `.odt` comme une archive ZIP. Les trois premières travaillaient l'édition d'un poème plus que le format, et n'employaient pas Markdown : elles sont conservées en annexe, avec leurs diapositives, en attendant d'être reprises ou supprimées. Le même sort échoit à « Binaire, hexadécimal et encodage du texte » et au mini-projet « Les premiers octets d'un fichier ».
## Annexes et bonus

### ⌨️ 15′ — TD 4c, facultatif : installer un projet en lisant son README

Trois diapositives désormais, au lieu d'une, pour que le bonus explique au lieu d'annoncer :

1. **Le trajet de la gare à l'école** — la comparaison clic / commande, et ce qui change à la deuxième exécution.
2. **Le fichier qui décrit le trajet** — `etapes.csv`, six lignes, une par étape : durée, point d'arrivée en pixels, sous-titre. Corriger une étape, c'est corriger une ligne. Le rapprocher du `.csv` de la grille des extensions et du `content.xml` de l'archive `.odt` : trois fois le même constat, le contenu utile est du texte.
3. **Ce que la commande enchaîne** — `etapes.csv` → une image par étape (ImageMagick) → `trajet.srt` → `trajet.mp4` (ffmpeg). Chaque étape produit un fichier que la suivante consomme ; ce sont les trois modules de `src/trajet/`, appelés dans cet ordre, et ce sont les outils du projet de la séance 4.

Le fond de carte est **distribué avec les supports** et n'est pas à retélécharger : le serveur de tuiles d'OpenStreetMap est un service bénévole dont les conditions d'usage interdisent le téléchargement en masse.

Produire la même vidéo — le trajet de la gare à l'école en cinq étapes commentées — en assemblant des applications graphiques, puis en une commande. Scripts, données à préparer et alternatives « clic-bouton » : [`td_video_trajet.md`](td_video_trajet.md) et [`data/cours1/5a_trajet/`](../../../data/cours1/5a_trajet/).

L'exercice n'est plus de taper un script fourni mais **d'installer un projet qu'on n'a pas écrit, sur sa seule documentation** : `conda env create -f environment.yml`, `conda activate trajet_ensg`, `python -m pip install -e .`, puis `trajet`. `pyproject.toml` y déclare zéro dépendance et le projet ne tourne pourtant pas sans `environment.yml` : `ffmpeg` et ImageMagick sont des programmes, pas des paquets Python. Le code les appelle par `subprocess`, donc le TD fonctionne aussi sous Windows.

### ⌨️ 10′ — Débouché : le dépôt de notes

- Markdown pour README et notes ; aperçu VSCode.
- Ouverture du **dépôt de notes du cours** — fil rouge git à faible enjeu, rejoué à chaque séance (git lui-même arrive au cours 2).

### 🎓 — Interface graphique et ligne de commande *(annexe, repris au cours 2)*

Ce bloc était la partie 3 de la séance jusqu'en septembre 2026. Il en reste deux diapositives dans la partie environnement, celles qui suffisent à lire une commande ; le reste est conservé ici, et c'est le **cours 2** qui le traite pour lui-même. Les mesures et les vérifications faites à l'époque sont gardées telles quelles.

#### Interface graphique et ligne de commande, en détail

Trois diapositives, dans cet ordre, et c'est la deuxième qui porte l'argument :

1. **Ligne de commande et interface graphique** — la comparaison sur cinq points, dont « ce qui en reste », qui prépare git au cours 2 et les scripts au cours 3.
2. **Désigner un fichier, ou les décrire tous** — la démonstration chiffrée. La même commande convertit un fichier en 1,4 s et vingt en 2,1 s, parce que le programme ne démarre qu'une fois ; seul le dernier mot change, `raven.odt` devenant `*.odt`. À la souris, les quatre clics du menu deviennent quatre-vingts. Mesuré sur les fichiers du cours.
3. **Quand l'une, quand l'autre** — le tableau de décision. À résumer en une phrase : on clique pour chercher, on tape pour répéter.

La différence de fond, à énoncer sur la deuxième : à la souris on *montre* des objets déjà à l'écran, au clavier on *décrit* un ensemble, y compris des fichiers qu'on ne voit pas. C'est la distinction classique en ergonomie entre reconnaissance et rappel, chiffrée deux diapositives plus loin avec les critères de Nielsen.

- **La différence, en tableau** : au clic on désigne ce que l'on voit, au clavier on nomme ce que l'on veut ; les menus proposent ce qu'ils contiennent, la commande accepte tout ce que le programme sait faire ; pour dix fichiers, dix fois les mêmes clics contre une ligne ; et surtout, **ce qui en reste** — rien d'un côté, la commande de l'autre. Aucune des deux n'est meilleure : elles ne rendent pas le même service.
- **Expérience utilisateur** : les perceptions et réactions qui résultent de l'usage d'un produit (norme ISO 9241-210). Critères d'après Jakob Nielsen, plus un cinquième ajouté ici, la trace laissée.
- **Le terminal** : une fenêtre où l'on tape des commandes et où le programme répond par du texte. Une commande se lit toujours pareil — le programme, ce qu'on lui demande, ce sur quoi il travaille.

| Système | Comment l'ouvrir |
|---------|------------------|
| Windows 11 | clic droit sur Démarrer ou `Win`+`X`, puis Terminal ; depuis un dossier, clic droit puis « Ouvrir dans le terminal » |
| macOS | Applications, Utilitaires, Terminal |
| Linux | `Ctrl`+`Alt`+`T` |

Sous Windows 11, **Terminal est l'application par défaut** et ouvre PowerShell ; l'Invite de commandes reste disponible dans le même onglet déroulant. Ne pas développer la différence, elle est au cours 2. Insister en revanche sur le fait que le terminal s'ouvre **dans un dossier** : c'est le dossier courant des chemins relatifs, et la source de la moitié des erreurs de début de semestre.

#### TD : la même opération, à la souris et au clavier

**1. Convertir des deux façons.** *Fichier > Exporter au format PDF* d'un côté, la commande de l'autre. Le fichier produit est identique ; la commande, elle, se recopie et se relance sur trois cents documents.

> ⚠️ **La commande n'a pas la même forme selon le système.** LibreOffice n'est ajouté au `PATH` par aucun installeur.
>
> | Système | Ce qu'il faut taper |
> |---------|---------------------|
> | Linux | `soffice --headless --convert-to pdf raven.odt` |
> | macOS | `/Applications/LibreOffice.app/Contents/MacOS/soffice --headless …` |
> | Windows | `& "C:\Program Files\LibreOffice\program\soffice.com" --headless …` |
>
> Trois pièges : le `PATH` ; le choix de **`soffice.com`** et non `soffice.exe`, que demande la [documentation officielle](https://help.libreoffice.org/latest/en-US/text/shared/guide/start_parameters.html) puisque seule la version console attend la fin de la conversion ; et l'opérateur d'appel `&` de PowerShell, sans lequel un chemin entre guillemets est pris pour du texte.
>
> **Seule la ligne Linux a été exécutée.** Celles de Windows et macOS viennent de la documentation et restent à vérifier sur ces systèmes avant la séance. *Repli* : `pandoc raven.odt -o raven.pdf`, qui est dans le `PATH` sur les trois systèmes une fois `conda activate base` fait.

**2. Le navigateur aussi se pilote au clavier.** Même idée que LibreOffice, sur un logiciel que tout le monde connaît par ses fenêtres. **Les trois lignes ci-dessous ont été exécutées et vérifiées.**

| Ce que l'on veut | La commande |
|------------------|-------------|
| la page en PDF | `chromium --headless --no-pdf-header-footer --print-to-pdf=page.pdf file://…` |
| la page en image | `chromium --headless --screenshot=page.png --window-size=900,1200 file://…` |
| la page en image, Firefox | `firefox --headless --screenshot page.png --window-size 900,1200 file://…` |

Deux détails avant de lancer en séance : sans `--no-pdf-header-footer`, Chromium ajoute la date et l'adresse sur chaque page ; et Firefox refuse de démarrer si une fenêtre est déjà ouverte, il faut alors `--profile` avec un profil à part. **Firefox ne sait pas produire de PDF** de cette façon, Chromium si.

**3. Le minimum sur le binaire.** Un octet vaut de 0 à 255 et s'écrit avec deux chiffres hexadécimaux ; « texte » signifie « octets plus une table de correspondance ». `P` vaut 80 soit `50`, `K` vaut 75 soit `4B`, `é` vaut `C3 A9` en UTF-8. Rien de plus : le binaire est ouvert pour de bon au cours 3.

**4. Ce qu'un logiciel lit vraiment.** `head -c 8 … | xxd` puis `file` : `PK` pour une archive ZIP donc un `.odt`, `%PDF` pour un PDF. Ces octets de tête s'appellent des *nombres magiques*.

> **Équivalent Windows**, puisque `head` et `xxd` n'existent pas : `Format-Hex raven.odt | Select-Object -First 1` remplace les deux à la fois, en affichant l'hexadécimal et le texte côte à côte. Le paramètre `-Count`, plus direct, n'existe qu'à partir de PowerShell 6.2 et **pas** dans le PowerShell 5.1 livré avec Windows, d'où le passage par `Select-Object`. Windows ne fournit aucun équivalent de `file`. **Ces lignes viennent de la documentation Microsoft et n'ont pas pu être exécutées** faute de Windows : à vérifier avant la séance.

#### Les octets de tête au terminal, PowerShell et Unix

Faire ouvrir un terminal à toute la salle avant de commencer : c'est le premier usage réel de ce qui vient d'être présenté, et cela sert ensuite toute l'année.

La diapositive principale est en **PowerShell**, puisque c'est ce que la majorité de la promotion a sous la main. Les octets à relever sont laissés vides à la projection et remplis dans la compilation `--input corrige=true` : `50 4B 03 04` (`PK`, une archive ZIP, donc un `.odt`) et `25 50 44 46` (`%PDF`). La diapositive suivante, `head`/`xxd`/`file` sous Linux et macOS, est **facultative** ; elle vaut surtout pour `file`, dont Windows n'a pas d'équivalent.

Les lignes PowerShell viennent de la documentation Microsoft et n'ont pas pu être exécutées sur le poste de préparation : à vérifier avant la séance. Les valeurs d'octets, elles, sont mesurées.

Deux étages de décision. Le **système** choisit le logiciel d'après le **nom** ; le **logiciel** ouvre le fichier et lit ses **premiers octets** : `PK` pour une archive ZIP donc un `.odt`, `%PDF` pour un PDF, lisibles en clair. Ces octets de tête s'appellent des *nombres magiques* ; `file` ne fait que les comparer à un catalogue.

Ne pas développer le binaire ici : il est ouvert en hexadécimal au cours 3. Annoncer en revanche que le même phénomène revient dans la partie programmation, où les premiers octets de `python3` se lisent « ELF ».

## Minutage

**Le deck est volontairement plus large que la séance.** Le parti pris est de produire les diapositives d'abord et de filtrer ensuite : le déroulé détaillé ci-dessus totalise environ **216 minutes** hors annexes, pour une séance de 120, et cet écart est assumé tant que le contenu n'est pas stabilisé. *(Le chiffre de 160 minutes annoncé précédemment sous-estimait la somme des blocs ; il est corrigé ici.)*

Le budget visé, celui de la diapositive « Contenu de la séance », est :

| Partie | Contenu | Durée |
|--------|---------|-------|
| Logiciels et formats de fichier | logiciel, vocabulaire, système d'exploitation, application web, extension, chemins, TD fichiers | 25′ |
| Programmation et éditeur de code | d'un programme à une application, compilé et interprété, code source et instructions machine, place de l'interpréteur, fonctions d'un IDE, édition de texte, règles d'un langage, coloration et vérification, espaces et tabulations, extensions de fichier et de VSCode, hello world, programmes fautifs | 40′ |
| Environnement de programmation | bibliothèques et dépendances, conda, les outils et les dépôts, terminal de l'éditeur, installation d'une bibliothèque | 25′ |
| Notebooks | interface et noyau, trois façons de l'ouvrir, deux formats | 10′ |
| Markdown et les autres fichiers texte | fichiers texte d'un projet, structure d'une page HTML, contenu et présentation, Markdown, trois façons d'écrire un document, un diagramme en texte, mise en forme d'une recette | 15′ |

La partie 1 perd cinq minutes par rapport au budget précédent, et la partie 2 en gagne dix : le levier employé est celui qui était déjà prévu, l'étape ODT-ZIP du TD 1a passant en exercice complémentaire.

> ⚠️ **La partie 4 dépasse son budget, et c'est le point à arbitrer avant de figer la séance.** Elle compte désormais treize diapositives — dix d'exposé et trois d'étapes — pour 25′ : le déroulé détaillé ci-dessus totalise 6 + 4 + 6 + 3 + 3 + 12 = 34′. Les trois candidats à la sortie, par ordre :
>
> 1. **« L'environnement de développement »** (−3′), qui redit ce que « L'outil qui installe un environnement » a déjà montré : les deux projettent une commande `conda` de création. Sa seule nouveauté, la vérification par `sys.executable`, se dit en une phrase sur la diapositive précédente.
> 2. **« D'où viennent les paquets »** (−2′) passe en annexe, « Ce qu'une installation exécute » restant en séance : c'est l'avertissement qui compte, pas le décompte des deux dépôts.
> 3. **La frise des outils** (−2′) passe en annexe, en gardant une phrase à l'oral sur `pip`. Elle répond à une question qui vient, elle ne construit rien de la suite.
>
> Les trois ensemble ramènent la partie à 27′, ce qui tient. Ne pas raccourcir le TD : ses étapes 4, 5 et 10 sont ce que la partie entière prépare.

Les autres leviers connus, à activer au moment de figer la séance :

1. « Une vidéo, deux chemins » en **démonstration** (3′) plutôt qu'en TD (10′), et rejoué en autonomie après l'installation de l'environnement.
2. Le bloc IDE réduit à ce qui sert au cours 2 : −4′.
3. Le bloc Markdown réduit à deux diapositives — l'intention et la comparaison des trois formats — en renvoyant l'édition dans l'éditeur au cours 2, où `pandoc` est de toute façon repris : −4′.
4. Le mini-projet « premiers octets » ramené à une démonstration au tableau : −5′. Il vaut mieux le garder en TD, c'est le seul moment où ils lancent un script qu'ils n'ont pas écrit.

**Contrainte d'ordre** : le TD vidéo a besoin de `ffmpeg` et d'`imagemagick`, donc de l'environnement conda. Celui-ci est créé avant la séance, mais le TD reste facultatif, en fin de séance : elle demande dix minutes que la séance n'a pas. D'où la démonstration au moment des formats, le TD complet venant en exercice complémentaire.

## TD et diapositives de séparation

Le deck distingue trois régimes par la couleur de fond de ses diapositives d'ouverture, et par rien d'autre : blanc pour l'exposé, bleu pour les diapositives de section (`separateur`), brun pour les TD (`separateur-td`, et `sommaire-td` quand le support est compilé sans eux). C'est la distinction 🎓 / ⌨️ de ce document, rendue visible de loin.

Dix TD dans la séance, un par ouverture brune, répartis sur les quatre parties du deck. Le chiffre est le bloc — les TD d'un même bloc se jouent à la suite, au même moment du cours — et la lettre l'ordre dans le bloc. Quatre sont facultatifs : ils ne sont pas faits en séance, mais leurs diapositives et leurs fichiers sont dans le deck et dans l'archive, pour qui va plus vite ou pour après.

| TD | Ouverture | Partie | Contenu | |
|----|-----------|--------|---------|-|
| 1a | *Fichiers, formats et extensions* | 1 | `depart/` et `travail/`, exporter en PDF et PNG, copier et renommer, ce que le système lance, la page HTML et son adresse, l'espace dans un nom, la table ASCII, le Bloc-notes | |
| 1b | *Un .odt est une archive ZIP* | 1 | ouvrir le `.odt` comme une archive, modifier `content.xml` et `styles.xml`, recompresser | facultatif |
| 2a | *Configurer l'éditeur de code, et lancer un programme* | 2 | VS Code depuis Anaconda ou hors Anaconda (le terminal `cmd`), l'extension, la palette et les réglages, l'interpréteur, puis un programme exécuté en entier, ligne à ligne, pas à pas | |
| 2b | *Trois programmes fautifs* | 2 | afficher les caractères invisibles, corriger trois fichiers Python dont un chemin en dur | |
| 2c | *Le même programme en C++* | 2 | l'extension, le compilateur, puis compiler et voir ce qui reste sur le disque | facultatif |
| 3a | *Mettre en forme une recette en Markdown* | 3 | un texte brut repris en Markdown, l'aperçu ouvert à côté | |
| 3b | *Le notebook, ouvert de trois façons* | 3 | `altitudes.ipynb` dans le navigateur, depuis Navigator, et dans l'éditeur — aucune ne demande de créer un environnement | |
| 4a | *Installer un projet Python, et décrire son installation* | 4 | un environnement neuf, les deux sortes de dépendances, puis l'`environment.yml` et la section « Installation » à écrire | |
| 4b | *Le client, le noyau, et où ils sont installés* | 4 | vérifier ce que `base` contient, constater ce qui manque dans `recette`, puis installer des deux façons — tout au même endroit, ou le client et le noyau séparés — et le notebook `recette.ipynb` | facultatif |
| 4c | *Installer un projet en lisant son README* | 4 | installer et lancer le projet `trajet` sur sa seule documentation, puis voir ce que la commande enchaîne | facultatif |

Chaque TD est un fichier de `src/cours1/diapo/tds/`, nommé comme le dossier de l'archive qu'il fait ouvrir (`2c_hello_cpp.typ` ↔ `cours1/2c_hello_cpp/`), et commence par un dictionnaire `td` — numéro, titre, annonce, dossier, durée, facultatif — qui alimente l'ouverture brune, le sommaire de la version `--sans-tds`, et la feuille de TD déposée dans le dossier. Les diapositives citent les chemins tels que l'archive les montre, sans `data/` ni `produit/`.

Le C++ (2c) et l'archive `.odt` du TD d'ouverture (1b) sont passés facultatifs en septembre 2026 : installer l'extension, puis un compilateur sous Windows, puis compiler, prenait plus que les dix minutes prévues ; et l'archive `.odt` demande un gestionnaire d'archives et une recompression qui piège tout le monde une fois, pour une leçon que la page HTML et sa feuille de style donnent aussi. Le TD des programmes fautifs (2b) est passé avant le C++ et ne contient plus que du Python — deux fautes d'écriture, et un chemin absolu qui n'existe que sur un autre poste. Le mini-projet des premiers octets a été supprimé en septembre 2026 : il demandait d'avoir lancé Python, arrivait en fin de séance, et sa leçon — l'extension ne décrit pas le contenu — est déjà celle du TD 1a. Le TD des notebooks a été coupé en deux au même moment : l'ouverture d'un notebook rejoint la partie Markdown, devenue « Markdown et notebook » (3b), et la séparation du client et du noyau passe en facultatif avec le notebook de la recette (4b). Ce dernier part désormais d'une vérification : `base` porte JupyterLab et `ipykernel` avec la distribution Anaconda, pas avec Miniconda ni Miniforge, et le TD 3b ne marche sans rien installer que grâce à la première. Les étapes « Python en interactif » et « Exécuter pas à pas » de la fin du TD 2a sont les candidates suivantes si le temps manque encore : à vérifier en séance avant de trancher.

La création de l'environnement lui-même n'en fait pas partie : elle est faite avant la séance, sur consigne d'installation, et seule sa commande est projetée.

Deux blocs sont **en annexe** en fin de deck, et n'ont pas vocation à être joués en séance 1 : *Comparaison interface graphique et ligne de commande* (convertir un document des deux façons, piloter le navigateur sans fenêtre) et *Échanger deux extensions* (qui demande la ligne de commande). Les résultats observés y sont conservés.

## Points d'attention

- **Ne pas glisser vers la programmation.** La séance parle de *fichiers et d'outils*. Le seul code montré sert d'illustration (3 lignes) — l'algorithmique est le cours parallèle.
- **Profils hétérogènes** (prépa littéraire / scientifique) : le TD 1a, « quatre formes », ne demande aucun prérequis et occupe utilement les plus rapides via les étapes ODT-ZIP et CSS.
- **Le binaire n'est plus ici** : si la question vient (« et le `.png` alors ? »), répondre en une phrase (« compressé, on l'ouvrira en hexadécimal au cours 3 ») et ne pas dévier.
- **Mention utile** : ce qu'on met dans un dépôt public y reste — d'où le choix de textes du domaine public et de données *générées* plutôt que versionnées. Amorce discrète de la leçon secrets (cours 5B).
