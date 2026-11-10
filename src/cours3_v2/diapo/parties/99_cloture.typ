// Clôture du cours 3 v2 — incluse en dernier par `cours3_v2.typ`, après les TD.
// Un fichier inclus n'hérite pas des imports de son appelant.
//
// « À retenir » : trois aide-mémoire, sur le modèle des cours 1 et 2 v2. Les lignes
// reprennent les mots des diapositives de l'exposé.
#import "../../../commun/prelude.typ": *

#separateur(
  "À retenir",
  annonce: "Récapituler les chemins, les arguments et les fichiers en Python.",
)

// --------------------------------------------
#d("Aide-mémoire : chemins et arguments")[
  #show table.cell: set text(size: 13pt)
  #show raw: set text(size: 11.5pt)
  #tableau(
    columns: (auto, 1fr, auto, 1fr),
    align: left + horizon,
    table.cell(colspan: 2)[Chemins : `pathlib`], table.cell(colspan: 2)[Ligne de commande : `sys`, `argparse`],
    [`from pathlib import Path`], [importe la classe des chemins], [`sys.argv`], [liste les arguments, en chaînes],
    [`Path("trace.csv")`], [crée un objet chemin], [`argparse.ArgumentParser()`], [crée l'analyseur],
    [`chemin / "nom"`], [ajoute un dossier ou un fichier], [`add_argument("fichier")`], [déclare un argument obligatoire],
    [`Path(__file__).parent`], [donne le dossier du script], [`add_argument("-s", default=0)`], [déclare une option et sa valeur par défaut],
    [`Path.cwd()`], [donne le dossier du terminal], [`analyseur.parse_args()`], [lit et vérifie les arguments],
    [`.name`, `.suffix`], [donnent le nom, l'extension], [`options.fichier`], [donne la valeur de `fichier`],
    [`chemin.exists()`], [vérifie que le chemin existe], [`--help`], [affiche l'aide construite par `argparse`],
  )

  #legende[
    Un chemin relatif part du dossier du terminal. Pour un fichier livré avec le
    script, construire le chemin à partir de `Path(__file__).parent`.
  ]

  #notes[
    Pour quelques lignes, faire retrouver la diapositive ou l'étape du TD 3b
    correspondante.

    Notions de la séance, à rappeler à l'oral : le code et les données dans deux
    fichiers, et le chemin des données donné en ligne de commande ; `f.read()` copie le
    fichier du disque vers la mémoire vive ; un caractère occupe un octet en ASCII, deux
    à quatre en UTF-8 pour les autres. Les commandes git du TD 3b sont dans
    l'aide-mémoire du cours 2.
  ]
]

// --------------------------------------------
#d("Aide-mémoire : lire et écrire un fichier")[
  #show table.cell: set text(size: 13pt)
  #show raw: set text(size: 11.5pt)
  #tableau(
    columns: (auto, 1fr, auto, 1fr),
    align: left + horizon,
    table.cell(colspan: 2)[Ouvrir], table.cell(colspan: 2)[Lire et écrire],
    [`with open(chemin, mode) as f:`], [ouvre le fichier, et le ferme à la fin du bloc], [`f.read()`], [lit tout le fichier, en une chaîne],
    [`"r"`], [lit du texte (mode par défaut)], [`f.readline()`], [lit la ligne suivante, fin de ligne comprise],
    [`"w"`], [vide le fichier, puis écrit], [`for ligne in f:`], [lit une ligne à chaque tour],
    [`"a"`], [écrit à la fin du fichier], [`ligne.strip()`], [retire la fin de ligne],
    [`"rb"`], [lit des octets, sans `encoding`], [`ligne.split(",")`], [découpe la ligne aux virgules],
    [`f.close()`], [ferme le fichier, sans `with`], [`f.write(texte)`], [écrit la chaîne, sans ajouter `\n`],
  )

  #legende[
    Chaque lecture part de la position de lecture de l'objet fichier, et la fait
    avancer.
  ]
]

// --------------------------------------------
#d("Aide-mémoire : contenu d'un fichier")[
  #show table.cell: set text(size: 13pt)
  #show raw: set text(size: 11.5pt)
  #tableau(
    columns: (auto, 1fr, auto, 1fr),
    align: left + horizon,
    table.cell(colspan: 2)[Octets et encodage], table.cell(colspan: 2)[Fins de ligne et mémoire],
    [octet], [huit bits, 256 valeurs, noté par deux chiffres hexadécimaux : `52`], [`\n`, LF], [fin de ligne sous Linux et macOS],
    [ASCII], [128 caractères, un octet chacun], [`\r\n`, CRLF], [fin de ligne sous Windows, lue `\n` par Python],
    [UTF-8], [un à quatre octets par caractère : `ê` donne `c3 aa`], [barre d'état de VS Code], [affiche l'encodage et la fin de ligne du fichier],
    [`encoding="utf-8"`], [se donne à chaque `open` en mode texte], [disque], [conserve les fichiers ; accès en 0,1 à 10 ms],
    [fichier binaire], [contient des octets selon un format : `.png`, `.odt`], [mémoire vive], [garde les variables du programme ; accès en 100 ns],
  )

  #notes[
    Le projet 4 revoit ces notions sur un nouveau programme. Le dire en une
    phrase, sans détailler.

    Le dépôt de notes du cours : les notes du jour, un commit.
  ]
]
