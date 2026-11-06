// Partie 2 du cours 3 v2, suite : le récapitulatif sur les fichiers.
//
// Incluse par `cours3_v2.typ`, après `02b_encodage.typ`.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *

// --------------------------------------------
// Récapitulatif (05/11/2026), à partir du tableau « Méthodes de lecture d'un
// fichier ». Exemple exécuté sur `trace.csv`, Python 3.12.
#d("Fichiers en Python : récapitulatif")[
  #{
    // Un titre de rubrique ; `block` fixe les écarts, qu'une `stack` refermerait.
    let rubrique(titre) = block(above: 10pt, below: 5pt, {
      show raw: set text(size: 12.5pt)
      text(size: 13.5pt, weight: demi-gras, fill: estompe)[#titre]
    })
    let lignes(..paires) = code-commente(taille-code: 11pt, taille-texte: 12pt, ..paires)
    grid(
      columns: (0.9fr, 1.1fr), column-gutter: 16pt, align: top,
      [
        #rubrique[Ouvrir]
        #{
          show raw: set text(size: 11pt)
          block(below: 6pt, raw(lang: "python", "with open(chemin, mode, encoding=\"utf-8\") as f:"))
        }
        #lignes(
          ("\"r\"", "lire du texte (mode par défaut)"),
          ("\"w\"", "vider le fichier, puis écrire"),
          ("\"a\"", "écrire à la fin du fichier"),
          ("\"rb\", \"wb\"", "lire, écrire des octets, sans `encoding`"),
        )
        #rubrique[Lire]
        #lignes(
          ("f.read()", "une chaîne : tout le fichier"),
          ("f.readline()", "une chaîne : la ligne suivante"),
          ("f.readlines()", "une liste de chaînes, une par ligne"),
          ("for ligne in f:", "une chaîne à chaque itération"),
        )
        #rubrique[Écrire]
        #lignes(
          ("f.write(texte)", "écrit la chaîne, sans fin de ligne"),
        )
        #rubrique[Traiter une ligne]
        #lignes(
          ("ligne.strip()", "enlève la fin de ligne"),
          ("ligne.split(\",\")", "découpe la ligne aux virgules"),
        )
      ],
      [
        #rubrique[Exemple, sur `trace.csv`]
        #script("# Lire une ligne à la fois\naltitudes = []\nwith open(\"trace.csv\", encoding=\"utf-8\") as f:\n    f.readline()\n    for ligne in f:\n        x, y, ele, time = ligne.strip().split(\",\")\n        altitudes.append(float(ele))\n\n# Vider le fichier, puis écrire\nwith open(\"resume.txt\", \"w\", encoding=\"utf-8\") as sortie:\n    sortie.write(f\"minimum : {min(altitudes)}\\n\")\n\n# Écrire à la fin du fichier\nwith open(\"resume.txt\", \"a\", encoding=\"utf-8\") as sortie:\n    sortie.write(f\"maximum : {max(altitudes)}\\n\")", taille: 10.5pt)
        #rubrique[`resume.txt`, après l'exécution]
        #script("minimum : 78.8\nmaximum : 129.5", taille: 10.5pt, lang: none)
      ],
    )
  }

  #notes[
    `read` et `readlines` copient tout le fichier en mémoire vive. `readline` et la
    boucle `for` copient une ligne à la fois.

    Sur un fichier de plusieurs gigaoctets (un nuage de points LiDAR en
    texte), `read()` échoue faute de mémoire ; la boucle `for` le traite, et
    `break` arrête la lecture.
  ]
]
