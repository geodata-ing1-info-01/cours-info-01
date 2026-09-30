// Cours 2, partie 1 — la ligne de commande (diapositives 2 à 7).
// Une diapositive qui se dévoile est écrite une fois par étape.
#import "../../../commun/prelude.typ": *
#import "../beamer.typ": d-beamer as d
#import "../schemas.typ": *
#import "../style.typ": *

// --------------------------------------------- 2/26
#d("Terminal")[
  Terminal : *interface* homme-machine *textuelle*

  #v(0.9em)
  #align(center, invite-commentee())

  #notes[
    Ouvrir un terminal et le montrer à la place de la diapositive. Chacun
    repère sur son écran l'utilisateur, le dossier courant et l'invite. Le
    préfixe `(base)` est l'environnement conda actif, vu au TD 1c.

    Les couleurs sont mises par bash : l'utilisateur en vert, le dossier
    courant en bleu.
  ]
]

// --------------------------------------------- 3/26
#d("Le langage bash")[
  Sur unix (linux et mac), le langage utilisé dans le terminal est *bash*.\
  Les commandes bash s'appellent toujours de la même façon :

  #code("commande [-one_letter_options] [--other_options] <arguments>")

  Pour avoir la liste des options d'une commande :

  #code("commande --help")

  #notes[
    Sous Windows, le terminal par défaut est PowerShell, dont la syntaxe
    diffère. Git Bash, installé avec git, donne le même bash qu'ici. Le
    préciser avant la première commande.
  ]
]

// --------------------------------------------- 4/26
#d("Liste de commandes utiles")[
  #code("#lister les fichiers et sous dossiers d'un dossier
ls [dossier]
#changer de dossier courant
cd <dossier>
#copier un fichier ou un dossier
cp [-r] <source> <destination>
#déplacer un fichier ou un dossier
mv <source> <destination>
#supprimer un fichier ou un dossier
rm [-r] <source>
#savoir dans quel dossier on se trouve
pwd
#créer un fichier
touch <nom_fichier>
#créer un dossier
mkdir <nom_dossier>")

  #notes[
    Faire taper chaque commande. `rm` ne demande pas de confirmation et ne
    passe pas par la corbeille : le dire avant.

    Le support d'origine écrivait `mkdire` ; la coquille est corrigée ici.
  ]
]

// --------------------------------------------- 5/26, en cinq étapes
//
// Même arbre à chaque étape ; le texte et le chemin coloré changent.
#let _diapo-arbre(texte, ..options) = d("Arborescence de fichiers")[
  #grid(
    columns: (0.95fr, 1.7fr), column-gutter: 14pt, align: horizon,
    block(width: 100%)[#texte],
    align(center, arborescence(echelle: 1.48, ..options)),
  )
]

#_diapo-arbre[
  Les fichiers et dossiers sont organisés en *arbre*
]

#_diapo-arbre(racine-annotee: true)[
  *racine de l'arbre* : un dossier contenant tout. Chemin de la racine
  jusqu'à un dossier ou fichier = *chemin absolu*
]

#_diapo-arbre(
  racine-annotee: true,
  legende: ("Chemin absolu", rouge-chemin),
  chemin: (("racine", "etc"), ("etc", "ssh"), ("ssh", "config")),
)[
  Le chemin absolu se note :\
  #code-ligne("/dossier_1/.../dossier_n/destination")

  #v(0.9em)
  exemple :\
  #code-ligne("/etc/ssh/ssh_config.json")
]

#_diapo-arbre(
  racine-annotee: true,
  legende: ("Chemin relatif", vert-chemin),
  couleur-chemin: vert-chemin,
  chemin: (("etc", "ssh"), ("ssh", "config"), ("etc", "cpp")),
  courant: "cpp",
)[
  Chemin d'un dossier quelconque à un autre dossier ou fichier =
  *chemin relatif*

  #v(0.45em)
  *Le dossier de départ est le dossier courant du terminal !*

  #v(0.45em)
  Le chemin relatif se note :\
  #code-ligne("dossier_1/.../dossier_n/destination", taille: 14pt)
]

#_diapo-arbre(
  racine-annotee: true,
  legende: ("Chemin relatif", vert-chemin),
  couleur-chemin: vert-chemin,
  chemin: (("etc", "ssh"), ("ssh", "config"), ("etc", "cpp")),
  courant: "cpp",
)[
  Le dossier parent d'un autre dossier se note ”..”\
  exemple :\
  #code-ligne("../ssh/ssh_config.json")

  #notes[
    Faire taper `cd ..`, puis `pwd` pour afficher le dossier courant.
  ]
]

// --------------------------------------------- 6/26, en deux étapes
#d("fichiers cachés")[
  #grid(
    columns: (0.95fr, 1.7fr), column-gutter: 14pt, align: horizon,
    [
      Certains fichiers/dossiers peuvent être *cachés*. Pour cacher un
      fichier/dossier, il faut que son nom commence par un ”.”.

      #v(0.9em)
      Exemple : `.git`, `.cache`, `.ssh`
    ],
    align(center, arborescence(echelle: 1.48, caches: true)),
  )
]

#d("fichiers cachés")[
  #grid(
    columns: (1fr, 1.3fr), column-gutter: 18pt, align: horizon,
    [
      Pour afficher les éléments cachés d'un dossier :
      #list([En ligne de commande #code("ls -a [dossier]")])
    ],
    [
      #list([dans l'explorateur de fichiers :])
      #v(0.4em)
      #fenetre("Fichiers")[
        #set text(size: 14pt)
        #grid(
          columns: (1fr,), row-gutter: 0.45em,
          text(fill: estompe)[Nouvelle fenêtre #h(1fr) `Ctrl+N`],
          text(fill: estompe)[Nouvel onglet #h(1fr) `Ctrl+T`],
          block(width: 100%, inset: (x: 3pt, y: 2pt), stroke: 1pt + alerte)[
            $checkmark$ Afficher les fichiers cachés #h(1fr) `Ctrl+H`
          ],
          text(fill: estompe)[Préférences],
          text(fill: estompe)[Raccourcis clavier #h(1fr) `Ctrl+?`],
        )
      ]
    ],
  )

  #notes[
    `Ctrl+H` est le raccourci de l'explorateur de fichiers de GNOME (Ubuntu).
    Dans l'explorateur de Windows : menu Affichage › Afficher › Éléments
    masqués. Le faire activer maintenant : le dossier `.git` de la partie
    suivante est caché.
  ]
]

// --------------------------------------------- 7/26, en trois étapes
//
// Les règles s'accumulent ; les exemples sont ceux de la règle du moment.
#let _regles = (
  [”\*” : n'importe quelle chaîne de caractères],
  [”?” : n'importe quel caractère (un seul caractère)],
  [”[]” : permet de donner une liste de caractères.],
)

#let _diapo-regex(etape, exemples, notes: none) = d("Expressions régulières")[
  On peut désigner des groupes de fichiers/dossiers en utilisant des
  *expressions régulières (ou regex)*.

  #liste-progressive(etape, _regles)
  #list([exemples : #list(..exemples)])

  #notes
]

#_diapo-regex(1, (
  [#motif("/etc/*") : *tous les dossiers et fichiers* contenus dans etc],
  [#motif("/users/FGeniet/*.jpg") : toutes les images jpg du dossier FGeniet
   (ne comprend pas les images dans les sous-dossiers)],
  [#motif("*/*.pdf") : tous les pdf qui sont dans un sous-dossier du dossier
   courant],
))

#_diapo-regex(2, (
  [#motif("*_?.png") : tous les png avec un nom ayant un ”\_” en avant
   dernier caractère],
  [#motif("/users/*/????.*") : tous les fichiers dans les dossiers
   utilisateurs ayant un nom de 4 caractères],
))

#_diapo-regex(3, (
  [#motif("mo[tn]o.jpg") : désigne `moto.jpg` et `mono.jpg`],
  [#motif("reunion_[0-9][0-9].txt") : les fichiers texte dont le nom est de la
   forme `reunion_` suivi d'un nombre à 2 chiffres],
), notes: notes[
  Ces motifs sont ceux du shell (*globbing*). Les expressions régulières de
  `grep` et du module `re` de Python ont une autre syntaxe : `*` y signifie
  « zéro ou plusieurs fois le caractère précédent ». Le TD 2d emploie
  `re.search`.
])
